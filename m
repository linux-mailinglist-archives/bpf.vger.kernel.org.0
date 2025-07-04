Return-Path: <bpf+bounces-62426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4ACAF9A5B
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FE14A0500
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82320F079;
	Fri,  4 Jul 2025 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRFt6+wb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14C1386B4
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652811; cv=none; b=u010JPfyga+w3t7Bwu1EhS8vY5PKx3NJaZKq5S5gL8zD68nD58M9VTulZf/7OnC2uod3z9Hgz3IRUMoxamWlAvt+3yTfS944uuQS5GZYyHJW8UcUgKACOALjkmfaUtWvvzmIdrQUWx4m73SsB1yrGUlYpXxo0YN/Fl4B7DmlUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652811; c=relaxed/simple;
	bh=90YiNR/cSVmfTiqAhvewGUU/GdUPE2CfMefPY/xzpTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmfkoWgGH7Ua3PowdVHRrzn33eylVA9wfrEggLIWzzIpZkx+PfSGicTGltgjZSKvXzD1dDWIenuCbmTIQ6kVQ2h5FyuB9ycUJQoOHhc3ktJzW0N6DQHC7PYZa2HiOp453hi++Fm3PjepySzQALjcAzSEWJwyU+v29pugXQMCUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRFt6+wb; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ae0c4945c76so167912466b.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751652808; x=1752257608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z4XGZ6C9DRovEDHkeKGC9bxfVITJrC2PxXK6/Y9uyvc=;
        b=WRFt6+wb1psBXXQYWHvDC989bsK+12pKdY+0yxHg6of9c86ZT/lY7DG3F6cQkPo/zG
         EMEaLQTzlpfjmq3sccir+EBQESyUQ7Lw9lMUUqP2L1HLeGdGGid0nI3EHu01xjSu+vYM
         tbR4M0mKR981tkpri3vlSFFBPCyrSc1xBaogI0C5TkfN72D6Hn6YunMvpGiSSmtTs8YP
         1YqScvDUqlWBFJ21CalubgioipoyPOdby0PGyPXcxwwEN+RBqLnBHfnvBj8jWuNM3Jyf
         ZSMVgquPcwmriG+7F9nURYBf4noOWO1dN8BRYP4Pjp2yPi0ndEABJmq//FXZFJt+8J7O
         qKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751652808; x=1752257608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4XGZ6C9DRovEDHkeKGC9bxfVITJrC2PxXK6/Y9uyvc=;
        b=MwlU5SFguaeAljcZzNlLj+4Kq/fqreC7mrtSHGyiLuiYsv9ZXOrmX4fl/GJ0OWUfeS
         yu7wgpU7e0MdWI9mJoG2d8gl3qgAitCJhsyyguM2xi25P7AK0XWmFm2R76rEf/RH3K+U
         QO0Eny82LRv0FN/U0dL4Naz4f0kgqUsXeCPH99W201elGH7IuPUJXC5loatmBGlqjr58
         l9DOIp6Hvazdk4FSFy/HG+wSBHyRbwpiUlhhY87xwOeuMFP9Q3gLyBGVA0fR5y8HCuga
         lkCiFBRaXkI2Lio0zYscDdqlZGcftbcxe08+82xey9jG6pVTpcqzHvVwsvNFgWX4WsEw
         rO1Q==
X-Gm-Message-State: AOJu0YzO7idnR7GSpNX7fFAgfQD9cuB7/MadY5tF47q3UkHj+/k06saA
	/Rk+kL1HOH5t9P9h2DnEu+1I74xuX7Eszi0TE0OsOYA3O7vUUyTLwS4ZBfv3Xu2kseXNXaGE8qv
	jy/bvvtUCXxjS7Gafali7GfspuIaU+wc=
X-Gm-Gg: ASbGncsOXio9SGaStA8f5fftWFwpExWG8SJPB0RWeRXEpsO/TrrQseO7X3RgpZcz1HS
	VvCULT/jmIyCae+7Gu1Z7G9wUXhDpwkgXYUnEF9jtHSc6R9JQkwUfm+MWZQHaokwcYKszyilXcD
	k8fthb/K7gytHQYpBt0zBwBWChbf3axwQJHDA4aOhDXio1xk6UAv4AqNxcukXz+pqcyw/MR5dDb
	8M=
X-Google-Smtp-Source: AGHT+IGG81J+PQKpttK5K48myQvrYPwZqQzxmdGOEsERaPbYl6hESl+A2R6IY1bELed0oLWPUZoVxpE+ymjgtjvshm8=
X-Received: by 2002:a17:906:27c4:b0:ae0:c539:b866 with SMTP id
 a640c23a62f3a-ae3fe5cb165mr252406166b.41.1751652807838; Fri, 04 Jul 2025
 11:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-9-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-9-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 20:12:51 +0200
X-Gm-Features: Ac12FXzEl0vkpyGZ3GevF2M-YGv0sMg48xcY0C6bDiLkwQUwUKOGK0IlAoQ3LnQ
Message-ID: <CAP01T74bqqPCV8xYQCoVHGTWa=3m4H-xGNiQsiGbSjQyGEJ+Wg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 8/8] selftests/bpf: tests for __arg_untrusted
 void * global func params
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 00:44, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Check usage of __arg_untrusted parameters of primitive type:
> - passing of {trusted, untrusted, map value, scalar value, values with
>   variable offset} to untrusted `void *` or `char *` is ok;
> - varifier represents such parameters as rdonly_untrusted_mem(sz=0).
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

LGTM, but can we also exercise BTF_KIND_ENUM{,64}? Since you
explicitly handle both of them. I guess char * covers BTF_KIND_INT, so
we don't need more cases (but up to you).

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  .../bpf/progs/verifier_global_ptr_args.c      | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> index 772e8dd3e001..f91d9c2906aa 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> @@ -245,4 +245,45 @@ int untrusted_to_trusted(void *ctx)
>         return subprog_untrusted2(bpf_get_current_task_btf());
>  }
>
> +__weak int subprog_void_untrusted(void *p __arg_untrusted)
> +{
> +       return *(int *)p;
> +}
> +
> +__weak int subprog_char_untrusted(char *p __arg_untrusted)
> +{
> +       return *(int *)p;
> +}
> +
> +SEC("tp_btf/sys_enter")
> +__success
> +__log_level(2)
> +__msg("r1 = {{.*}}; {{.*}}R1_w=trusted_ptr_task_struct()")
> +__msg("Func#1 ('subprog_void_untrusted') is global and assumed valid.")
> +__msg("Validating subprog_void_untrusted() func#1...")
> +__msg(": R1=rdonly_untrusted_mem(sz=0)")
> +int trusted_to_untrusted_mem(void *ctx)
> +{
> +       return subprog_void_untrusted(bpf_get_current_task_btf());
> +}
> +
> +SEC("tp_btf/sys_enter")
> +__success
> +int anything_to_untrusted_mem(void *ctx)
> +{
> +       /* untrusted to untrusted mem */
> +       subprog_void_untrusted(bpf_core_cast(0, struct task_struct));
> +       /* map value to untrusted mem */
> +       subprog_void_untrusted(mem);
> +       /* scalar to untrusted mem */
> +       subprog_void_untrusted(0);
> +       /* variable offset to untrusted mem (map) */
> +       subprog_void_untrusted((void *)mem + off);
> +       /* variable offset to untrusted mem (trusted) */
> +       subprog_void_untrusted(bpf_get_current_task_btf() + off);
> +       /* variable offset to untrusted char (map) */
> +       subprog_char_untrusted(mem + off);
> +       return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> --
> 2.47.1
>
>

