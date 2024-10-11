Return-Path: <bpf+bounces-41680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5290A999A46
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8239CB23B08
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA871E9088;
	Fri, 11 Oct 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3vjoR08"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79260748F;
	Fri, 11 Oct 2024 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613203; cv=none; b=KL5eSBzOhbvLC9jjJN+f+xUGE8FK1e97JkCzaxFxdor+vM2ca61uaBdsNTq4SPVC3O2eM7AEt431EfyDDFI9RHUG0TU1GT9wtaGX2QOJZjjiMnd42vBlrFc71KsqKU9t/5iKadg1+zk2fbBgxcy2eA6t3dfyxec5QeSRUbF1gqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613203; c=relaxed/simple;
	bh=BuWWt9J3d5LmtGizNy0RWMaMy0OvpvtNZEvoJlggdsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7xGSV4ChQ/eFDRjNXbbTdwC1C+1jcIpV3rWya3U5IVfaBAyruRuLoccFr1gChnBEP9ucg7Gl0hK1Y4V+q0Vy9trftpvvHBHXB63z3M0PqU6VUiv+2mc4tmaHI0XnxrsdNF08jZ7HcUgNYGo76V793SYUtuqkplYrS3EYKI8Yxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3vjoR08; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so752824a91.0;
        Thu, 10 Oct 2024 19:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613202; x=1729218002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLhOIYaSD3mZ10qNGhaTSWJ8llOcmLQ9hp+Mf//qB4E=;
        b=V3vjoR08E9TR5w5YQYHiMVziOIVdEVn0gcT8NdXVMMRI1NHTWCzWa6WotE3Lbh+ibk
         JhwOyZLgREFtfn2dj7320wCWKdtsrMwE/I0/IJgSuFhw1K9fDNs3JeytoqNDdvqo6pIp
         2M/IvgaUZp5oJYCfYuENG2Z4BPGsgxGpe10szNzkhKe4SjQMtkEYxtiLn6MnpvoyO7QN
         OUMl9w7MQCZUaMvTYGiEkTXvKD9REe8/0/guaxoQ+fSdTtqcG8cnJMiUvdFDvh+mkWw3
         K49PPcg1AxmxDaZXkaiTDsKX6PHKdDZnfshKnNj5MXffjW/P6mEe7TJ+bDqa7ScwbWqM
         YA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613202; x=1729218002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLhOIYaSD3mZ10qNGhaTSWJ8llOcmLQ9hp+Mf//qB4E=;
        b=ZDSkTpI2F/G+xcBcPxxx9sVTDeiNqzjohGfVRzSfTBp7D5aJsbtkL50CpNjzcAPB5e
         FfsgKLoJtQaah7ZSfQY/XZIyMpCAGumIwQYQTxCRLEuqOPuT6khu7faHO3k7yY10eQvn
         5OdibTfC0dxDMF2oy7U/v/jxwzMDjDOYDkd8lGRQvGnh14gsxz233saLoZZUcFZ3h+d+
         8oZ6NLwowbk6WJbs7LuQyLCa5AXfsVt4JgRfshSyF7cW9/0eFs+TbFs2QH8x+3Uw/vm4
         SHK3I2u15G0ZG9VPerRyefkDM9ePxBLGhx+wrVE86e4CONcEyE8XPi4qoGIu9MgxhFOl
         qgqw==
X-Forwarded-Encrypted: i=1; AJvYcCVQAFkA7ca0RnD/3pG13TMeru4Dmi6vx2AklvuSm94OCvQh6G9Gs9Rs0Faq1UjoEPD5tw5+a+QY5inpZ6WZ@vger.kernel.org, AJvYcCWP0dn4QW2H/uhPwN+uaW95tkgF+fDgP6y7Ho3mmedhP4hvH9esm0CEPhZe78hU8fCTSmI=@vger.kernel.org, AJvYcCX54V98Jjwf+4d6Gwh++aVPg0okAO+vnywQTp1RNxY6IjARgsD3M93VonG3xGhLyMMB+Y8LEOn8HUUEHz9wXM/mEv4j@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFRyWWSsijoXzymdy8ph4lzgT0Ki1BC2ugsNXTq6pQACQglFp
	fi9o0KWyyc02gYOtlD1cz/thFgDnIyBO58jPS1d1/jnpbeZiI75Cr9ebdEMDg4Y9l17pqL8sLvg
	CHy6czDThDv8bessWEXENYeAh/5M=
X-Google-Smtp-Source: AGHT+IG1I4iFVqrY5V/vK7jeWCCxVnW1eUMByhbkTIBDME0FM3UNcH2kH7ZEZ8SIqjT5wvAWRPg9sAnwXXcaz7e478U=
X-Received: by 2002:a17:90b:3844:b0:2da:88b3:cff8 with SMTP id
 98e67ed59e1d1-2e2f0aa5610mr1953711a91.6.1728613201788; Thu, 10 Oct 2024
 19:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-4-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:19:49 -0700
Message-ID: <CAEf4BzZV4AS2w5iXhTh+hEA1W+6uxHv7sJ9hAUvpUiBFbuOC+Q@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 03/16] bpf: Allow return values 0 and 1 for
 kprobe session
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:10=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The kprobe session program can return only 0 or 1,
> instruct verifier to check for that.
>
> Fixes: 535a3692ba72 ("bpf: Add support for kprobe session attach")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/verifier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7d9b38ffd220..787008872a14 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15910,6 +15910,15 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
>                         return -ENOTSUPP;
>                 }
>                 break;
> +       case BPF_PROG_TYPE_KPROBE:
> +               switch (env->prog->expected_attach_type) {
> +               case BPF_TRACE_KPROBE_SESSION:
> +                       range =3D retval_range(0, 1);
> +                       break;
> +               default:
> +                       return 0;
> +               }
> +               break;
>         case BPF_PROG_TYPE_SK_LOOKUP:
>                 range =3D retval_range(SK_DROP, SK_PASS);
>                 break;
> --
> 2.46.2
>

