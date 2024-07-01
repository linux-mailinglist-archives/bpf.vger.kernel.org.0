Return-Path: <bpf+bounces-33478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99AA91DB66
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 11:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057D1B225DD
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407E184D3F;
	Mon,  1 Jul 2024 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGj9v0cV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDEE1F937;
	Mon,  1 Jul 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826085; cv=none; b=g9io/zYSEiO7EzcBxLNxyfdIwdkrcXbDxKMeCz4XJyMrHupMSRC4mpUgqIlBZu5G9SuPYI7lvT9Tn89H7ZjVI6EjUH+wMmxNFmC5AKCAXs55bdKh01q8WMTzaaWxt39XXvVNFi8jYENEa0mv0UbUmhHLaFy3h1tZKYvP5AW+/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826085; c=relaxed/simple;
	bh=1oxViJYoAONW3AaOYoL6NX0ee9tlxdo2GT5xQ3qfkSM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=N9an0eR6+aR+oaLmQNTZp5IyzAgvjTLIVQU5acxCe7+DLAf7MnHgErKmyvr4hsvx4pvFBfPiyet+xNtyOIdVft1o6pd8DvvRXp4L0Es31SBrk5I8ZZxuFFmzK4rqUs1fhXppdAZUfhKQJXqAVJrcZhIzPrdrcT6JkxBd1pGPKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGj9v0cV; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso1475616a91.1;
        Mon, 01 Jul 2024 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719826084; x=1720430884; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpPhp371r6vsTyMutHc20NsXXbmLoxmB6xNDF30tnFg=;
        b=BGj9v0cVY80WUI4ddwsCvpIaQeKaN7hf8vfXmcWNrQ64KZlWLBodjIwbjF/gsWAwKG
         GGAl2O4Sj9Q1ecykFK5bndYiQJ1eUmgwxEgync+A3NcnDaMgurtwlMkPdfX0fCVVUlhh
         Iwiw4mLVy66Gb/x5CTvdVlurFoaKFR+drW3Z/0kcxp386eOED8JjTLg7zVPeaawXs0bj
         uJKFblN/xbD2iChsO094aRvMFQMMp87aJHwLQJjtu274RMVHFMffJVDv0PPddE0dDvRp
         yewFizVRBmMq0UE/DAxzT7XmPdBMBzBnyt98bX8adAtiOVIRFVrWL1lYKg+kPYXHM/yE
         DUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719826084; x=1720430884;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gpPhp371r6vsTyMutHc20NsXXbmLoxmB6xNDF30tnFg=;
        b=IX2qT1qBN8moL9XNFR1CMTi7iJ2tMJA0mCHnbsMJAtbB6szhimC5XoPEcabBPbkkfS
         BkvzF7EPA5ieJFyyuLho2mJXviiLeBEQeqskFkPm7kK1rJ3LzC3MHJ3r7TmJoQw6/NEX
         Z4mNOmJl7WrJiG/vx09bstPTuTFAxG0jBT2Vo7pI/ExRJv+Ti4X276lzJ7SSJPkLkgSn
         RTnAy5x7SLyvua9hsltG31PZw1HVvHq5QAGr0JVGilET+Yftl+Eu1gILX6zqZw+Onhpf
         /+ChUzrOQ5IDNQeRUUcGDkQtJ+4JiuUIZXerJHs59yrltPcrVpx+cx5skSIQdtKe5s6f
         Xh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjpwd51uCjTws/egpxYil+DvGDMBniLlO/NJqgaxUpl1Ax72T/oEKG1R7zsF80wbpbxVfbhxOJnzHQKCLNjdsEbHP9EUT1cxt6qu2JklUtUqpg4nAZuqYveKHpxOnULdHWhr2+pwAo
X-Gm-Message-State: AOJu0YzbwtNraC4VQylZfiW/HU0Tpl02FkWmalPgqll/B5YLD2YJ66KJ
	6F+a5a6txlIhI3XBnop6fdXSfXXk+7hxKm1lm28aR6ge3k9eouP4
X-Google-Smtp-Source: AGHT+IH6I2DlaBIeXUUYgjLeoMC1HJ0wmxY95eFhcgqTFT+WgfyJzrPH8kD5cMBD8wCRv1qjUcn2Gw==
X-Received: by 2002:a17:90a:ac10:b0:2c4:dc4d:83dc with SMTP id 98e67ed59e1d1-2c93d6c6080mr2348497a91.5.1719826083601;
        Mon, 01 Jul 2024 02:28:03 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a83sm6246602a91.11.2024.07.01.02.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 02:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 19:27:55 +1000
Message-Id: <D2E3GNRTRCOF.16TWBZIA5EZS2@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Masahiro Yamada"
 <masahiroy@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>
Subject: Re: [RFC PATCH v3 04/11] powerpc/ftrace: Remove pointer to struct
 module from dyn_arch_ftrace
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1718908016.git.naveen@kernel.org>
 <f13b5e0cb4f9961f23c8880a2f98073e41f695d8.1718908016.git.naveen@kernel.org>
In-Reply-To: <f13b5e0cb4f9961f23c8880a2f98073e41f695d8.1718908016.git.naveen@kernel.org>

On Fri Jun 21, 2024 at 4:54 AM AEST, Naveen N Rao wrote:
> Pointer to struct module is only relevant for ftrace records belonging
> to kernel modules. Having this field in dyn_arch_ftrace wastes memory
> for all ftrace records belonging to the kernel. Remove the same in
> favour of looking up the module from the ftrace record address, similar
> to other architectures.

arm is the only one left that requires dyn_arch_ftrace after this.

>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  arch/powerpc/include/asm/ftrace.h        |  1 -
>  arch/powerpc/kernel/trace/ftrace.c       | 54 +++++++++++-------
>  arch/powerpc/kernel/trace/ftrace_64_pg.c | 73 +++++++++++-------------
>  3 files changed, 65 insertions(+), 63 deletions(-)
>

[snip]

> @@ -106,28 +106,48 @@ static unsigned long find_ftrace_tramp(unsigned lon=
g ip)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_MODULES
> +static unsigned long ftrace_lookup_module_stub(unsigned long ip, unsigne=
d long addr)
> +{
> +	struct module *mod =3D NULL;
> +
> +	/*
> +	 * NOTE: __module_text_address() must be called with preemption
> +	 * disabled, but we can rely on ftrace_lock to ensure that 'mod'
> +	 * retains its validity throughout the remainder of this code.
> +	 */
> +	preempt_disable();
> +	mod =3D __module_text_address(ip);
> +	preempt_enable();

If 'mod' was guaranteed to exist before your patch, then it
should do afterward too. But is it always ftrace_lock that
protects it, or do dyn_ftrace entries pin a module in some
cases?

> @@ -555,7 +551,10 @@ __ftrace_modify_call(struct dyn_ftrace *rec, unsigne=
d long old_addr,
>  	ppc_inst_t op;
>  	unsigned long ip =3D rec->ip;
>  	unsigned long entry, ptr, tramp;
> -	struct module *mod =3D rec->arch.mod;
> +	struct module *mod =3D ftrace_lookup_module(rec);
> +
> +	if (!mod)
> +		return -EINVAL;
> =20
>  	/* If we never set up ftrace trampolines, then bail */
>  	if (!mod->arch.tramp || !mod->arch.tramp_regs) {
> @@ -668,14 +667,6 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsig=
ned long old_addr,
>  		return -EINVAL;
>  	}
> =20
> -	/*
> -	 * Out of range jumps are called from modules.
> -	 */
> -	if (!rec->arch.mod) {
> -		pr_err("No module loaded\n");
> -		return -EINVAL;
> -	}
> -

A couple of these conversions are not _exactly_ the same (lost
the pr_err here), maybe that's deliberate because the messages
don't look too useful.

Looks okay though

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

