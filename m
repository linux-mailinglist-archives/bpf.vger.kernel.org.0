Return-Path: <bpf+bounces-78383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B1CD0C438
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57C183029566
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816F31E11F;
	Fri,  9 Jan 2026 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy22f/K5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6CB31B82B
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992921; cv=none; b=XwmheYNaIgxqsaWEs54oEsJR4OAQERl+E4DNRLpwDk2LfMpz6pm4jBaj+4+DeC3gHRcSp867y2aX462B5NEsiKDwto9gT2atOttSPTaphd8tYGmcCMqwxk5uYGaGhx+nPT7AKcCxagmUNnSViIP2xEWHBoYlC+H5ZJ0EyzyKp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992921; c=relaxed/simple;
	bh=+8HAGz7cDN2qPH0M0sF2Eo9lnEGkdR5mhMdJD8C0UsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fa5OV/K367kdZ9xVnz4C9o4damKkc6lfnST5JLI81rYIBKSf+FhNqUNnlvTqf/OHif5iqPQuiSF/sNGwWKKxDBvouLN2I/wswWZpD+lsL8//5w82n/N1reOLeJFpjupWqzksKghjfW3Ny/LxAr+l/Rz8+KB0wyHFE45GysSZLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy22f/K5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso42722875e9.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 13:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767992918; x=1768597718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U8aOxR/HKyZTLxSUlYEkniw9whQerh+rPlob4zOrVA=;
        b=gy22f/K53MNoyNBiGBadhJAGKNf6+xxaI1mos+meqCz59ecHAgRR9zkS/0HNYySU8X
         l2Frz3FZBJp1W1W3IL35vmbfJOamplU25zzJYH/DJ3E010CXpfQG3mlFJx/nZ0j+Q1U/
         z0br1TEq18cC4YNl7i5zH7MpCZYhMUK3o43CRQTsDPbQoFeBk/HM3ebtU1oMTAwBPK60
         rPd7TFrp2Zy1X8IV6k50qobn9zb0itDsoVixKpbhtPBxW+KPI+KSGWSlCKnYieLBvMuK
         ILFZeeZlJaNT8RfMoB3F6N4HGJVxFIUXAZXQYD+GBsrt4uvEPPb8UkZe8RIeE+7FbS5c
         EWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767992918; x=1768597718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6U8aOxR/HKyZTLxSUlYEkniw9whQerh+rPlob4zOrVA=;
        b=Gmv8GazMBbURHNuaqKfIdbziRR5NIWNlg1HYDxhfWY9CiqoLYqqu27/0wyqijLvkHO
         SMfqcQqbL2RsyNg8mezmBHum0e26BFLBEPo27aPBYkjR+1cyVTGCjwVveYK1CPT5BVqQ
         ImEBd0ilqALdX/GkaqtkcYcoxiRtuhG0njZSsDsheER4S8Uy+cJ4Jlv32daz6+bWcSmr
         DfLM74Hq0wppnmWGTKAOi2yrO1+fi/a7/xzheOWGCv90A/Umb+wntMFy0XP7blFLukj1
         XH8gq1CPd6/SYWZuY49YSNRNRy+omCLl+gvEBQAKtiAMYbQOGLcfgYcHSnLRzzmmE9gO
         Ue5g==
X-Forwarded-Encrypted: i=1; AJvYcCXpS5RWY3H2mHp/sLY0P159pIMDBH2o4dEQMVRaTc6eKSjfN6MBvWsJ/SxAG772SaEepSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FZiWshaNfNPb+177cjUD6AbrbqUV30dkIwaVEkjAokIZLE+a
	ge13mzag+oGxs7wV8+KtqnYMEhVpTbtfeIc8nrnp8BUDnkTS1tNE8UYZOtShNZCBOQCG6fmL+zz
	7Uofl2vCYz97POzLLkHeedQrOvGZD21o=
X-Gm-Gg: AY/fxX4jv2YgNybMuLvgWQUqK/l0QdYWCFNEWLXbpJ/d66LQQHIFT8RNVkh0aAasJgR
	WW540vajv4PSSXKtd/h6FRcUf4kkX8zsUJkrFSOQAnxEu+wLnJP9AsoAtPGLZmQkPdTOlEyqiN0
	jVH5UkuOCjDlZhszilXlFU/if0mGEt4pKhH1q4V9Kt1vRy5yIYpWCrdBrHaH8wbtGpM17I94+Nj
	PiqZlcfwww6w4xXJ/eCcApcMRfecaQURW0Qcvq8hbXcpHv5u4Pjt+WbTi9YIdXe1bBDt45w/Q9w
	UWES9VxoPAlcpMN5rZZzPeFLZvw8
X-Google-Smtp-Source: AGHT+IHJgBK+qqcdmP1gFtAzrhoJMFO1Ypc9h1A1bFa1gZrFq29sdplWKiASGiCp3D82//y/JkSl59SME+qXCzMnSnU=
X-Received: by 2002:a05:600c:3555:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-47d84b3b692mr145494055e9.31.1767992917689; Fri, 09 Jan 2026
 13:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106172018.57757-8-leon.hwang@linux.dev> <db428e27fdf0110ea05cdadf8980c7758d7f4dcd61289293394db7e34ce99601@mail.kernel.org>
 <28ace50f-9ae6-46da-a05d-eab31f33f9cb@linux.dev> <CAADnVQJLifBhcpe5ci7FBB2uzTR5OXPji5RPq2NLSoVXpTfScg@mail.gmail.com>
 <a936f459-a7a1-431d-8ef8-cae5cf4d2196@linux.dev>
In-Reply-To: <a936f459-a7a1-431d-8ef8-cae5cf4d2196@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 13:08:26 -0800
X-Gm-Features: AZwV_QhpXiR99q5kXERxymPT5YLdcOtd4HKm8pMF-OAf_S1dUBZ6bxQ-do66_2M
Message-ID: <CAADnVQK04pc1ONvqe4JRg+PfSmUK3j1M=vE3A_+GOfYK+8ND9g@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v4 7/9] bpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	sforshee@kernel.org, yuichtsu@amazon.com, aalbersh@redhat.com, 
	Willem de Bruijn <willemb@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Rong Tao <rongtao@cestc.cn>, 
	LKML <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 10:32=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 7/1/26 14:20, Alexei Starovoitov wrote:
> > On Tue, Jan 6, 2026 at 9:57=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >>
> >>
> >> On 7/1/26 01:44, bot+bpf-ci@kernel.org wrote:
> >>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>>> index 14fc5738f2b9..e64cc7504731 100644
> >>>> --- a/kernel/bpf/syscall.c
> >>>> +++ b/kernel/bpf/syscall.c
> >>>
> >>> [ ... ]
> >>>
> >>>> @@ -6279,7 +6345,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr=
_t uattr, unsigned int size,
> >>>>
> >>>>      switch (cmd) {
> >>>>      case BPF_MAP_CREATE:
> >>>> -            err =3D map_create(&attr, uattr);
> >>>> +            common_attrs.log_true_size =3D 0;
> >>>> +            err =3D map_create(&attr, uattr, &common_attrs);
> >>>> +            ret =3D copy_common_attr_log_true_size(uattr_common, si=
ze_common,
> >>>> +                                                 &common_attrs.log_=
true_size);
> >>>> +            err =3D ret ? ret : err;
> >>>
> >>> When map_create() succeeds, it returns a file descriptor that is alre=
ady
> >>> installed in the caller's fd table via bpf_map_new_fd(). If
> >>> copy_common_attr_log_true_size() then fails (e.g., user provided a
> >>> read-only buffer for uattr_common), the syscall returns -EFAULT but t=
he
> >>> fd remains installed.
> >>>
> >>> Could this leak the file descriptor? The user gets an error and has n=
o
> >>> way to know what fd number was allocated, so they cannot close it.
> >>>
> >>
> >> Good catch =E2=80=94 you=E2=80=99re right.
> >>
> >> If 'map_create()' succeeds and 'copy_common_attr_log_true_size()' late=
r
> >> fails (e.g. returning -EFAULT), the newly created file descriptor woul=
d
> >> remain installed and could be leaked.
> >>
> >> I=E2=80=99ll fix this in the next revision by explicitly closing the f=
d when
> >> ret is non-zero.
> >
> > No. The refactoring was wrong. Don't make the kernel do extra work.
> > Patch 3 introduced a bug and closing fd is not a solution.
> > Such a pattern can be exploited for DoS.
>
> You=E2=80=99re right =E2=80=94 closing the fd after the fact is not the c=
orrect
> solution, and introducing extra work in the kernel is undesirable. Doing
> so could also open the door to DoS-style abuse.
>
> The correct approach is to copy log_true_size into common_attrs
> before allocating and installing the new fd, so that a failure in
> copying cannot leave behind a partially created object.

Why move it at all?
I don't think you should be moving
copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
                                  &log_true_size, sizeof(log_true_size))

from where it is in verifier.c

