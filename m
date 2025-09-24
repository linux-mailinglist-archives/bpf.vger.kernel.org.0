Return-Path: <bpf+bounces-69643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FCB9CC18
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 01:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771EA382F0E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E692C21E8;
	Wed, 24 Sep 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abO9AIqF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C136283FE9
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758286; cv=none; b=m0jNlT8QO3WfR56IbXaz2YvIwNVz8UrjotaJ9sYg1e+N1K57c5TbvBqTsU6xgVydPCnpDiJOyLxdhLn7tPO1rfCBeTrkbVPuyw+OH3L2ovyTjozR8BM0KqwK/Fb1TTO6OtX/4kiRFAJU6APMe5gaEOwN6AtFnlBBwhMgETJrH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758286; c=relaxed/simple;
	bh=z0WIuLDPgkN4KYjb0Po2mx4mE+ivZGzw+XlJjBQHbm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUsZN4U1kx+dEJdnwlbmtj08ITWowJJa3VSn8EHfjBAL9IlMBNGnb5b+tilN5DEdYHDR2CsXFrClQM3bOAh3f4GZhgyx2IX3vjdaNSlonPHsEzlgpGHHHgdg/AaID3hdkNVqyqAm7OC4tUdaeDwGtHg47OpRvGdlQU89XL1Xbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abO9AIqF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-323266cdf64so396102a91.0
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758758283; x=1759363083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhouQfqTyzGm+wWvVbF6V1ffiRFm6W4WSPB23TB9w6Q=;
        b=abO9AIqF8bhD69IKkxnsK9JttgVRlVrONgJ3weOZj07S0eL27MUznCdYIioTLl+omm
         TYIgdJVPdY88DfZglx/WnCbQZJoiKfrEOPsu3Fch2vClqKA6KeSgKO92BBkUYYtOvPCt
         +es0sMDjg2+s1c+KRcfCJ0DIdhg7ak7kdB98NRokb2ii+ovaGCq6Sstqf7MlYqmZJPau
         TIHRDzws0dTjoS9xBTdiE9Lia/fleWgdwDYePX3utgHDnTIQwAJ9odDrd5hD+H0K77ds
         MBfJ1ZvWfXUUUSUepDp6h2i2gj3+dAL3ePdV8yNhF+cR2NpIbq5rw2VCjfYCPnR11Isr
         ag7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758283; x=1759363083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhouQfqTyzGm+wWvVbF6V1ffiRFm6W4WSPB23TB9w6Q=;
        b=WMyqHom2T0Heyaq1LULvy9oe20vPwbmHKn630wKEUFYyagV7dJrruqTnxMtEyYygOP
         RV9985/Lx5owNeOLrNJKusmTQ8h3F9iJFqVewKEOjbt4g2zdD8yomTkNSALNBad7bD4A
         f0GNbWYNL/h15WjVVRUqjtBTfu3xMitWGmUK/9YgicsizldTxTREW9//8fbUTtMhAzJs
         T1LwyjsgZBKiVEapNoeLGl8sukbBRLTm3zplhCMdXp7I4IEDnZ65wsuILS//K/LN7fXx
         tqQMbxAFrpLeazSikxlqFaHbAcy3GlcwF/cnDak8mqXmQ+XUcYjzV4Z/8bOo2kYTgYu7
         er5g==
X-Gm-Message-State: AOJu0Yw6pET8M0J5w1pOmV/BKXzDBdniHHnopYjVr3VPs+sepuSChSxf
	3+kC8MiEybOLD2gdVj4IaRirDiQutsIextVJXqFVMNa57HMj+mDcIHZupASMRLBfZHgeLr6UzyF
	tVSL2Q+cBV6GtYirNKR6upR9GAZKKM5I=
X-Gm-Gg: ASbGncssmv3Il+Xb0+fcWmWLNA/5gLGDC66biUpLdjjw0hvBGY929I/MfKCpx95PZJZ
	VtFP73vhofUNKAFSQx9fJRcBIoOawynhbtvgQa7jo2DBBxX25NP3kFZ2f+GBkKm7sIrYQxagGMR
	EzP6B9XzjezAd7goQcycICx7wXswdgN0cb0cCAIV+61jj+x1Yuh21enWRpoAkzKG6owi+GNleY8
	rVTBZXWyRd7ebcxtSAk3fw=
X-Google-Smtp-Source: AGHT+IHrW9SCNzgk4q0d7GlkrqeGrCO5CjlEIGeRA4Gqj6C1jwigtqm0teXtQ2jQkh5k9ma+UBLt0gPMPmQz2U+fBy0=
X-Received: by 2002:a17:90b:3b45:b0:32b:4c71:f423 with SMTP id
 98e67ed59e1d1-3342a3208d1mr1239999a91.32.1758758283393; Wed, 24 Sep 2025
 16:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-3-leon.hwang@linux.dev>
 <CAEf4BzZp8vb3EYwvSCbewdZi0eKZjW5sJkDnm6YfPqaRbjf2NA@mail.gmail.com> <d535ef7e-a7fb-41be-8550-bb0c0af045f9@linux.dev>
In-Reply-To: <d535ef7e-a7fb-41be-8550-bb0c0af045f9@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Sep 2025 16:57:49 -0700
X-Gm-Features: AS18NWBHWLO8JVgR8fJY55my3k6xUhAEWFfGs5TWBdE6bTVA8FehAJxd6KJA-hM
Message-ID: <CAEf4BzbKHL+_m-tJ5qddUEJixSN+MSueDNNtf2L843cRFKTknQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/6] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, menglong8.dong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 8:36=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/9/17 08:06, Andrii Nakryiko wrote:
> > On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> To support the extended 'bpf()' syscall introduced in the previous com=
mit,
> >> this patch adds the following APIs:
> >>
> >> 1. *Internal:*
> >>
> >>    * 'sys_bpf_extended()'
> >>    * 'sys_bpf_fd_extended()'
> >>      These wrap the raw 'syscall()' interface to support passing exten=
ded
> >>      attributes.
> >>
> >> 2. *Exported:*
> >>
> >>    * 'probe_sys_bpf_extended()'
> >>      This function checks whether the running kernel supports the exte=
nded
> >>      'bpf()' syscall with common attributes.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  tools/lib/bpf/bpf.c             | 45 ++++++++++++++++++++++++++++++++=
+
> >>  tools/lib/bpf/bpf.h             |  1 +
> >>  tools/lib/bpf/features.c        |  8 ++++++
> >>  tools/lib/bpf/libbpf.map        |  2 ++
> >>  tools/lib/bpf/libbpf_internal.h |  2 ++
> >>  5 files changed, 58 insertions(+)
> >>
> >
> > (ran out of time, will continue reviewing the rest of patches
> > tomorrow, so please don't yet send new revision)
> >
> >> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >> index ab40dbf9f020f..27845e287dd5c 100644
> >> --- a/tools/lib/bpf/bpf.c
> >> +++ b/tools/lib/bpf/bpf.c
> >> @@ -69,6 +69,51 @@ static inline __u64 ptr_to_u64(const void *ptr)
> >>         return (__u64) (unsigned long) ptr;
> >>  }
> >>
> >> +static inline int sys_bpf_extended(enum bpf_cmd cmd, union bpf_attr *=
attr,
> >> +                                  unsigned int size,
> >> +                                  struct bpf_common_attr *common_attr=
s,
> >> +                                  unsigned int size_common)
> >> +{
> >> +       cmd =3D common_attrs ? cmd | BPF_COMMON_ATTRS : cmd & ~BPF_COM=
MON_ATTRS;
> >> +       return syscall(__NR_bpf, cmd, attr, size, common_attrs, size_c=
ommon);
> >> +}
> >> +
> >> +static inline int sys_bpf_fd_extended(enum bpf_cmd cmd, union bpf_att=
r *attr,
> >
> > please shorten to sys_bpf_ext() and sys_bpf_ext_fd() (also note ext bef=
ore fd)
> >
>
> The short ones look good to me.
>
> >
> >> +                                     unsigned int size,
> >> +                                     struct bpf_common_attr *common_a=
ttrs,
> >> +                                     unsigned int size_common)
> >> +{
> >> +       int fd;
> >> +
> >> +       fd =3D sys_bpf_extended(cmd, attr, size, common_attrs, size_co=
mmon);
> >> +       return ensure_good_fd(fd);
> >> +}
> >> +
> >> +int probe_sys_bpf_extended(int token_fd)
> >> +{
> >> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_toke=
n_fd);
> >> +       struct bpf_common_attr common_attrs;
> >> +       struct bpf_insn insns[] =3D {
> >> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> >> +               BPF_EXIT_INSN(),
> >> +       };
> >> +       union bpf_attr attr;
> >> +
> >> +       memset(&attr, 0, attr_sz);
> >> +       attr.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER;
> >> +       attr.license =3D ptr_to_u64("GPL");
> >> +       attr.insns =3D ptr_to_u64(insns);
> >> +       attr.insn_cnt =3D (__u32)ARRAY_SIZE(insns);
> >> +       attr.prog_token_fd =3D token_fd;
> >> +       if (token_fd)
> >> +               attr.prog_flags |=3D BPF_F_TOKEN_FD;
> >> +       libbpf_strlcpy(attr.prog_name, "libbpf_sysbpftest", sizeof(att=
r.prog_name));
> >> +       memset(&common_attrs, 0, sizeof(common_attrs));
> >> +
> >> +       return sys_bpf_fd_extended(BPF_PROG_LOAD, &attr, attr_sz, &com=
mon_attrs,
> >> +                                  sizeof(common_attrs));
> >
> > I think we can set up this feature detector such that we get -EINVAL
> > due to BPF_COMMON_ATTRS not supported on old kernels, while -EFAULT on
> > newer kernels due to NULL passed in common_attrs. This would be cheap
> > and simple. Try it.
> >
>
> Let me give that a try.
>
> >> +}
> >> +
> >>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
> >>                           unsigned int size)
> >>  {
> >> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> >> index 7252150e7ad35..38819071ecbe7 100644
> >> --- a/tools/lib/bpf/bpf.h
> >> +++ b/tools/lib/bpf/bpf.h
> >> @@ -35,6 +35,7 @@
> >>  extern "C" {
> >>  #endif
> >>
> >> +LIBBPF_API int probe_sys_bpf_extended(int token_fd);
> >
> > why adding this as a public UAPI?
> >
>
> If we don=E2=80=99t mark it with LIBBPF_API, the build fails when compili=
ng libbpf.
>
> My intention here wasn=E2=80=99t to introduce a new public UAPI, but simp=
ly to
> provide a way for 'features.c' to probe whether the kernel supports the
> extended BPF syscall, without directly exposing 'sys_bpf_fd_extended()'.
>
> Do you have a suggestion on how we can perform this probe without
> introducing a new LIBBPF_API symbol?

see libbpf_internal.h, it's not the first non-UAPI global function we
have in libbpf.

Just don't add this function to libbpf.map and it should be fine

>
> Thanks,
> Leon

