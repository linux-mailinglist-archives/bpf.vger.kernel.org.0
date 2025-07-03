Return-Path: <bpf+bounces-62295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69678AF79BD
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCAD3B245A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6BD2EE28F;
	Thu,  3 Jul 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="cof71W4h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A2E2E339E
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554932; cv=none; b=sNmayWKoVhmaAtgslArUvMU7JaTFjm6EqCUl8VmsnOQphV/ohKknfSQMZnQkwPUI2TadUFjNatYUv3m7BnZXVAf1iGPf5417M9ytSFOVwmNahHX1ua95RXHu3NejGaqop7NHtgxLY+rrUcCTQOOd2cyyCOeL/sZ86eeM3GKsf7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554932; c=relaxed/simple;
	bh=OiZipMfQsAwpr/DtT/zuk1Z9wquq2kpSOhnkj8Zs/Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uljwLNSt3yQzsJoiJzJovjl6O+X7EMrDiXhkyIT4d+fBQcxbgzU/8M0lxLJA3vqNmiG6NoFkfb7yhCHuxXTfYOWyS39qZ1j5qhiuh5HwFIT01K6IrTUfskbgEGpFC3AvDpzSfv0jjpuOuIVMpx4ApIBVdZdSY27T+3vXkhMHWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=cof71W4h; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ea35edc691so10885fac.2
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751554928; x=1752159728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ1n5OoPU2y2aTRLFFFFzUnbaLykEhjzLCr3s4U0Y/Q=;
        b=cof71W4h/GAhAP29bnYtsSSTg87Rc8JSEIirezzLb+wQyc5wzOJidkM0Sa+O9/qCVs
         a5b2Bo95zBxmID9srbbpFU3HuCdlLzCWRY2ORpVRgJcmZbU38hTdq+2d2i2+YevVXKkB
         6DRCcNBIfA44WCkRU0Ffqt8cDYO2sTigqoAKYK61JIuSb3P3TX6uHi2gekGSthMeJ0vl
         LwRP5VEQzo0AeX5siWrwJAasBrYjhReDXpvAYbusCwuR7GG28Qe6jafqoQlAVIUa4f+I
         Rn+a0K8F9hFUhkOLUTtCRjc+Oc+jhoA9s7NZcwIMr4/pFc3TYEVRQaZdsUb3ABK4mjFZ
         icgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751554928; x=1752159728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ1n5OoPU2y2aTRLFFFFzUnbaLykEhjzLCr3s4U0Y/Q=;
        b=LR9hrKHzLnl39SWxtLx3tbO9fUH8WVje19C89D+7u3UE3hY3Mx/nW4LMsis7ZC+zHS
         ZgS+D4+NVoD0iBX09W1Qz2sO2XvHEKOgJ99dkfe2E/BZ0vNi98M0HoO2O6chxu0trY4z
         W7ujrbFDYwtRV5s968ztpiEb/KHYLbiolZ8GfLuTo3CPLr90DSW5eaw6T0gAo1TSQF7g
         KUXWREtWodL515gq1Eu/GWHdkI5UAcO+5pgaRHkTuZXmQX19/zYY+NwtfWfJMJDaYAje
         dbEHQzz/JJ+mVi+XT+PUdtpris+AHtWHsXaaeRVtCFeILrkOYInDQekfJh8uSJDEOUhn
         vswA==
X-Gm-Message-State: AOJu0Yz0dh9MVslNMNheAymXUJX5vV9jcqVyT0IfiSZOf2qdghY+nrnJ
	Ai7+zxAHctBZR75clIoZYczmZ0dTMQd/EOlUiFIe9mvuntPApFmye1v29bktHeblMo7Yn40VbJZ
	1IvmNZbBWxsGwS7XJXZcjQiXWxR74PF2rPjV7yeJktQ==
X-Gm-Gg: ASbGncsM9knfuYQVBX25VYhfTiS15ZAY27GZvbnkaJ8dOxC3WViBJ82gPeQCDHf1AUX
	iSDUe/rxlJ3hxD9fsyI33ATDobtt1XRn2N1z0fJjhF2NYZUvuHnN+60zvs4ds0ZWNc8A8AF9e+e
	NuUBjXwb2yyI8M2G+pz5GEh/tD+8ukqZtVqqtX6kG7Koj5bXz1rKo2XxY=
X-Google-Smtp-Source: AGHT+IHC11fH5WTxlFG0ORs+9yicE3NFkJFu8WKortnfjzt63zA3kpKSWe+qHuVpvVDXXP+6k56e939XHVyUq+FFPK8=
X-Received: by 2002:a05:6870:5489:b0:2e9:b6:2edd with SMTP id
 586e51a60fabf-2f76ca1afa1mr2745566fac.32.1751554928363; Thu, 03 Jul 2025
 08:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-4-memxor@gmail.com>
In-Reply-To: <20250702031737.407548-4-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 3 Jul 2025 11:01:57 -0400
X-Gm-Features: Ac12FXwmZxQDGB4ilVhac7sfDzGctFn442bP0IuW6K05Tf6EXW-ling14bqYKkM
Message-ID: <CABFh=a6iKrkcoZL3KUdrK3YMjuFUNM4NMp7k7y51J6h+dM+KRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/12] bpf: Add function to extract program
 source info
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Prepare a function for use in future patches that can extract the file
> info, line info, and the source line number for a given BPF program
> provided it's program counter.
>
> Only the basename of the file path is provided, given it can be
> excessively long in some cases.
>
> This will be used in later patches to print source info to the BPF
> stream.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h |  3 +++
>  kernel/bpf/core.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>

Nits aside:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 85b1cbe494f5..09f06b1ea62e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3660,4 +3660,7 @@ static inline bool bpf_is_subprog(const struct bpf_=
prog *prog)
>         return prog->aux->func_idx !=3D 0;
>  }
>
> +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, cons=
t char **filep,
> +                          const char **linep, int *nump);
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index f0def24573ae..5c6e9fbb5508 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3213,3 +3213,50 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
>
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +
> +int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, cons=
t char **filep,
> +                          const char **linep, int *nump)
> +{
> +       int idx =3D -1, insn_start, insn_end, len;
> +       struct bpf_line_info *linfo;
> +       void **jited_linfo;
> +       struct btf *btf;
> +
> +       btf =3D prog->aux->btf;
> +       linfo =3D prog->aux->linfo;
> +       jited_linfo =3D prog->aux->jited_linfo;
> +
> +       if (!btf || !linfo || !prog->aux->jited_linfo)
> +               return -EINVAL;

Either use jited_linfo in the condition, or remove the shorthands
above sin ce btf and
jited_linfo immediately get overwritten anyway.

> +       len =3D prog->aux->func ? prog->aux->func[prog->aux->func_idx]->l=
en : prog->len;
> +
> +       linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
> +       jited_linfo =3D &prog->aux->jited_linfo[prog->aux->linfo_idx];
> +
> +       insn_start =3D linfo[0].insn_off;
> +       insn_end =3D insn_start + len;
> +
> +       for (int i =3D 0; i < prog->aux->nr_linfo &&
> +            linfo[i].insn_off >=3D insn_start && linfo[i].insn_off < ins=
n_end; i++) {
> +               if (jited_linfo[i] >=3D (void *)ip)
> +                       break;
> +               idx =3D i;
> +       }
> +
> +       if (idx =3D=3D -1)

This doesn't catch the case where we exhaust the loop without ever
triggering the
jited_linfo[i] >=3D (void *)ip branch. Is it worth using (jited_linfo[i]
< (void *)ip as the
error condition instead, or do we not need to account for it?

> +               return -ENOENT;
> +
> +       /* Get base component of the file path. */
> +       *filep =3D btf_name_by_offset(btf, linfo[idx].file_name_off);
> +       *filep =3D kbasename(*filep);
> +       /* Obtain the source line, and strip whitespace in prefix. */
> +       *linep =3D btf_name_by_offset(btf, linfo[idx].line_off);
> +       while (isspace(**linep))
> +               *linep +=3D 1;
> +       *nump =3D BPF_LINE_INFO_LINE_NUM(linfo[idx].line_col);
> +       return 0;
> +}
> +
> +#endif
> --
> 2.47.1
>

