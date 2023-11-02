Return-Path: <bpf+bounces-14041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7777DFD21
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E09281E61
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 23:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BCD22336;
	Thu,  2 Nov 2023 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtXCzVzK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D491224C6
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 22:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6BFC43391
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698965995;
	bh=YOpBUZmh6EeX6Ei6kNqvNHhXZDsc0AD/diM6AVtWuUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OtXCzVzKB7g0Pr8B6oEvYlKNWs5J+0WQM41QT2h1qxhS4oLCh+cdRjksKawnHuoMG
	 VU50WqQ6FxOwiNPQ8RSKEUTek+YuS4kocMf8sU0j1eoI1wtXSTwjMgv2UvkLFpMK10
	 XGySBj/4h/15uGA3VXqrGVYJfMAjil3fBPc03P9ADn6eDFVLk1ALTwNg4T9e39AiRn
	 Q0jC+JTApwbw4XYCtg2rkrBsjgxmsoyJ1loN89mv9yVFUeTXS5BADWZvcbnt9W7WAo
	 R7OojeFNZEIcWbSAhDNIR/Qo6w0klpUiUKCG46KA7Y0ug+BK2jFVtx5Ql6ej1dPvHq
	 J+B6yQzcDpQOQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-507a62d4788so1862211e87.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 15:59:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YwVFgmSuwuRqGogvaUMWgsbrZi+EjWN+cpjt/Y2XJRYJ4QEgv2T
	MZPH9P/9eBfrbtuT/M0XFebV6YbNstitlAfKYjk=
X-Google-Smtp-Source: AGHT+IGXMgwBX+Qk2fYV3M5PekOERyTQuDKin5BaT2M/WdITtXAFnmigEoJjjbqcnhnlmhT61y7Ez3gjopZtzK5g2FE=
X-Received: by 2002:a05:6512:3a8b:b0:509:4c8a:5256 with SMTP id
 q11-20020a0565123a8b00b005094c8a5256mr2412530lfu.31.1698965992929; Thu, 02
 Nov 2023 15:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102201619.3135203-1-song@kernel.org> <20231102201619.3135203-2-song@kernel.org>
In-Reply-To: <20231102201619.3135203-2-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 2 Nov 2023 15:59:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW68DMvSSu9JVfJLWiRjrSWbhOmza2ivd6Dmh22oogM7eA@mail.gmail.com>
Message-ID: <CAPhsuW68DMvSSu9JVfJLWiRjrSWbhOmza2ivd6Dmh22oogM7eA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 1/9] bpf: Add __bpf_dynptr_data* for in kernel use
To: bpf@vger.kernel.org, fsverity@lists.linux.dev, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, kernel-team@meta.com, ebiggers@kernel.org, 
	tytso@mit.edu, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 1:16=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
[...]
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index df697c74d519..92dc20d9b9ae 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1378,6 +1378,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct b=
pf_dynptr_kern *data_ptr,
>                                struct bpf_dynptr_kern *sig_ptr,
>                                struct bpf_key *trusted_keyring)
>  {
> +       void *data, *sig;
>         int ret;
>
>         if (trusted_keyring->has_ref) {
> @@ -1394,10 +1395,14 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct=
 bpf_dynptr_kern *data_ptr,
>                         return ret;
>         }
>
> -       return verify_pkcs7_signature(data_ptr->data,
> -                                     __bpf_dynptr_size(data_ptr),
> -                                     sig_ptr->data,
> -                                     __bpf_dynptr_size(sig_ptr),
> +       data =3D __bpf_dynptr_data(data_ptr, __bpf_dynptr_size(data_ptr))=
;
> +       sig =3D __bpf_dynptr_data(sig_ptr, __bpf_dynptr_size(sig_ptr));
> +
> +       if (!data || !sig)
> +               return -EINVAL;

Sigh, I missed this failure:

https://github.com/kernel-patches/bpf/actions/runs/6737884115/job/183164801=
88

#110/1 kfunc_dynptr_param/dynptr_data_null
...
verify_success:FAIL:err unexpected err: actual -22 !=3D expected -74

It is easy to fix, but I am not sure which is the right fix.

Basically, null dynptr bpf_verify_pkcs7_signature used to return
-EBADMSG. And it
is returning -EINVAL after this change. Do we need to keep the error code a=
s
-EBADMSG?

Thanks,
Song

> +
> +       return verify_pkcs7_signature(data, __bpf_dynptr_size(data_ptr),
> +                                     sig, __bpf_dynptr_size(sig_ptr),
>                                       trusted_keyring->key,
>                                       VERIFYING_UNSPECIFIED_SIGNATURE, NU=
LL,
>                                       NULL);
> --
> 2.34.1
>
>

