Return-Path: <bpf+bounces-22235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD191859A8E
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 02:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E3281332
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 01:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C731FDB;
	Mon, 19 Feb 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO/3K5mZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FD394;
	Mon, 19 Feb 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708306830; cv=none; b=PJ7UXZ12hRrrZZTAa5M20J39bqhsNvblBLUVHRdDxQBBSbez9YdsxTFSBZ4are/kjwMdqaB1CEqrRBgqLgWZRf3VCJcLSImuj84AwQCe4HCn97eSVusHCjUeGsb/nKdkao8WF68M9V+kOIoNdbQtBgPQ3fHhobPE/hilzVnIBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708306830; c=relaxed/simple;
	bh=kihmzIEp4jMtsotvVbuh70VmbID04B4QlATbCQEaaIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3QvyEw9wOddoYTaHzw8kFWoLM5KNRbt0/e+gFgyxOy9uOCx6nSnoyKyZwiPLy6PetrQ9YxJOeV3B/ojInjp1ReaDrAlajQ0U8Kn1M0htZMRF16ByX3Y8GAOoHQ5274+OhRTiWAmQ1mMXNThB0r6EItg949rAXALWTTiwCBX7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO/3K5mZ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21e7c3e3cf3so1931950fac.0;
        Sun, 18 Feb 2024 17:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708306827; x=1708911627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaiLI6HuMk3k6QJ4h2pdePYkeTI4xDaauIoDn8/w0BM=;
        b=hO/3K5mZS4tJ0bxQ3K8ypxV1ThLxjgd0aY8iXmhN/4R1zCjbxj8DcMmGaxMrbDLY/I
         SciAipQaL8Y6wIU+n0lVnEp0cdudcbCLp3GsaHAC/RdhSYoesupYId9gqeQt5YWukFJU
         2yZS2/qAPsuFoIcyxLKXn1Ol9WTsE2Nu5Ynnk+rBNGaJ73lUkMQFxTH2s+ePF/xDV+ne
         Q8bhea46Nd7kiYyqVq8lzXf3Ygkpdc3nC36e8VU4LeKauSoLVQKVIWRX8de6m6MbxwNq
         nMMnoXBf/WKJWAuJIgK5OtRWzXbDh9ae4u30MicuAJTqoGw6JEEDysHwPORQV3FoPECC
         ZF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708306827; x=1708911627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaiLI6HuMk3k6QJ4h2pdePYkeTI4xDaauIoDn8/w0BM=;
        b=Cq7F/L+rt03pCF8JDOTOZDIdjE3PjUxiV0LgHYBx1GOhxq94sCQfnqdsJ67bN0EQnH
         IJW0R0euo62BV7gzUu9+8o8m6/V6AyqQ3VQ0SlOZY8oITDIuJAzdeTmZn0hwxK02ntZu
         /vZ9jtBWnkJI/kGptKS22bDhIClQ78XyWx36+cwv3YACSyWcqsnwdEpR54BKzKGjLSiU
         ehJG8HIWburIP7zQxIZp75H2nlPy4Htohw42FxH6dr05QghcmM3BHnBk7cDb0sdyD7A8
         OPNyTtFkQJ5xOEU/EkUg5UfFoNJ0dr7rWiYQo8YejE3UN2E0NfTrYEHtBcBwwsSobjKO
         f22w==
X-Forwarded-Encrypted: i=1; AJvYcCXmbNuSdIZDPSwjqiyfhv+TK4weYXM/4QXqeda8gW2jbHEUakeSVOqcxLwEBCki/gd0CKWCuWfFSq2UUOy0WzxCV+prpBtrOStHaDhbSLNkBBPTgAbS9RG/3/Luadrf3nKsMwS2m4xsg2JmJmfV4aEOiRtn7/P9KohWm8wqUOQc3tdACYXUsUML/p7S+IGVNHTTtDbYwiq2G8bW
X-Gm-Message-State: AOJu0YxpaLzx3htX1H7lIP7FAxjWUuK1B6XgJOIHIRchPftgNUh/KpMZ
	UQq1b4qdAZ0XV1tfaK3UwmMoiW7WFnQiY/QZdTvF29RnDm4nlITMHT/79RYNtPPC+xIJnOu1MrA
	OpIbj3m5KDhoEQEnYPC1xX8hQsG0=
X-Google-Smtp-Source: AGHT+IFkFmT+v1hh+iQ/E3URA6z1M8En8SQFup37KMF7zerqKZzW/uA0xjHmbflknywYN84qSBeaoW+UYlQGo85TBn0=
X-Received: by 2002:a05:6870:831d:b0:21e:b6fc:750d with SMTP id
 p29-20020a056870831d00b0021eb6fc750dmr2690494oae.32.1708306827680; Sun, 18
 Feb 2024 17:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
In-Reply-To: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 19 Feb 2024 09:40:16 +0800
Message-ID: <CAEyhmHT8H3AXyOKMc3eQSdM2+1UDETJDPyEQ0-AEb6E8pt9LTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christophe,

On Sun, Feb 18, 2024 at 6:55=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> set_memory_ro() can fail, leaving memory unprotected.
>
> Check its return and take it into account as an error.
>

I don't see a cover letter for this series, could you describe how
set_memory_ro() could fail.
(Most callsites of set_memory_ro() didn't check the return values)

And maybe craft a selftest to check the expected return values.

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/linux/filter.h | 5 +++--
>  kernel/bpf/core.c      | 4 +++-
>  kernel/bpf/verifier.c  | 4 +++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fee070b9826e..fc0994dc5c72 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -881,14 +881,15 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32=
 size_default)
>
>  #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]=
))
>
> -static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
> +static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
>  {
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>         if (!fp->jited) {
>                 set_vm_flush_reset_perms(fp);
> -               set_memory_ro((unsigned long)fp, fp->pages);
> +               return set_memory_ro((unsigned long)fp, fp->pages);
>         }
>  #endif
> +       return 0;
>  }
>
>  static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 71c459a51d9e..c49619ef55d0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2392,7 +2392,9 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf=
_prog *fp, int *err)
>         }
>
>  finalize:
> -       bpf_prog_lock_ro(fp);
> +       *err =3D bpf_prog_lock_ro(fp);
> +       if (*err)
> +               return fp;
>
>         /* The tail call compatibility check can only be done at
>          * this late stage as we need to determine, if we deal
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c5d68a9d8acc..1f831a6b4bbc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19020,7 +19020,9 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>          * bpf_prog_load will add the kallsyms for the main program.
>          */
>         for (i =3D 1; i < env->subprog_cnt; i++) {
> -               bpf_prog_lock_ro(func[i]);
> +               err =3D bpf_prog_lock_ro(func[i]);
> +               if (err)
> +                       goto out_free;
>                 bpf_prog_kallsyms_add(func[i]);
>         }
>
> --
> 2.43.0
>
>

