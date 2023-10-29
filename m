Return-Path: <bpf+bounces-13583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A317DAD6E
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 18:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F047F2814E4
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78448DDD4;
	Sun, 29 Oct 2023 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ROZ0UQTS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19C9447;
	Sun, 29 Oct 2023 17:09:07 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0168FAF;
	Sun, 29 Oct 2023 10:09:05 -0700 (PDT)
Received: from pwmachine.localnet (unknown [86.120.35.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 714F820B74C0;
	Sun, 29 Oct 2023 10:09:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 714F820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1698599345;
	bh=+vyv4CkSwgagEPwk+wRETLVwUgG6vZleJi4Iy+OYXPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROZ0UQTSTRS9eTBJ1WbjsfOZ4yGRifzRL8OBLr7vHcEgUQjVJctYNvWtQuIjklO4v
	 swKPpL5iCUdIRKLQZXDb+0j+uNh/24gdBGdz5TvQf7MUnw0n7jPRufBxn9YAD6tJq7
	 UD21InUTZh4jXUEs0xoOOIqUwrZ8nKdc+2P3OyJ4=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Sun, 29 Oct 2023 19:09:00 +0200
Message-ID: <2711863.mvXUDI8C0e@pwmachine>
In-Reply-To: <20231027233126.2073148-1-andrii@kernel.org>
References: <20231027233126.2073148-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi!


Le samedi 28 octobre 2023, 02:31:26 EET Andrii Nakryiko a =E9crit :
> Recent changes to count number of matching symbols when creating
> a kprobe event failed to take into account kernel modules. As such, it
> breaks kprobes on kernel module symbols, by assuming there is no match.

Ah... Sorry about this...
Thank you for the fix, I will handle the patch for older kernels in case th=
ere=20
are troubles applying it.
=20
> Fix this my calling module_kallsyms_on_each_symbol() in addition to
> kallsyms_on_each_match_symbol() to perform a proper counting.
>=20
> Cc: Francis Laniel <flaniel@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func
> matches several symbols") Signed-off-by: Andrii Nakryiko
> <andrii@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index effcaede4759..1efb27f35963 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long
> unused) return 0;
>  }
>=20
> +struct sym_count_ctx {
> +	unsigned int count;
> +	const char *name;
> +};
> +
> +static int count_mod_symbols(void *data, const char *name, unsigned long
> unused) +{
> +	struct sym_count_ctx *ctx =3D data;
> +
> +	if (strcmp(name, ctx->name) =3D=3D 0)
> +		ctx->count++;
> +
> +	return 0;
> +}
> +
>  static unsigned int number_of_same_symbols(char *func_name)
>  {
> -	unsigned int count;
> +	struct sym_count_ctx ctx =3D { .count =3D 0, .name =3D func_name };
> +
> +	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
>=20
> -	count =3D 0;
> -	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> +	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
>=20
> -	return count;
> +	return ctx.count;
>  }
>=20
>  static int __trace_kprobe_create(int argc, const char *argv[])


Best regards.



