Return-Path: <bpf+bounces-38904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C081096C5C6
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC6D1F28286
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4B91E133B;
	Wed,  4 Sep 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjZ1gb9e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAB4778C
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472417; cv=none; b=bx6BYZoNcgns/P+niej9TFb+GVb9LO62hQ/X+YwNwruyD/O0+qRHN0D2l4UfYVz7qOaIS5lr0kRtxRTkZIyFyoB0MLStOKHB+ee/JZZzQmuyci8Z1+GybI3Ky0fp4DmpYiKXBfB/zJPUYFKuQYsVHjjA8/+qXSStLj4Q3fqzMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472417; c=relaxed/simple;
	bh=LJKKQJXwoLwYCfOmz4YScSDD0nh9jbpAZsyAg1j3Fww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1pgL7Fl5db3oNFS1kU5nQ8jqShxwBUPXic16P3c6YybS3UHW7UBTN+d/HdTn6ij4gz9mZyYd14pYRQB4ON37P2beqDqKsNNWG2i5k1PqQi5wuhgYJ+cNFKezxo5PxptWIkIgQ4f7IN3fT6qP6IK9/rRWpFQ1RTM9PJMmBfBBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjZ1gb9e; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso3623020a91.3
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725472415; x=1726077215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydjc/sIhp1poblFcVfF/+5xFSn6DwsytXzLXERIDBMY=;
        b=bjZ1gb9eJ5Ud4FmKUSXTbm27dBF+iNJXs8osP4mx6mqQdIA75iwtYPXiQc9+PQ3Axh
         Xs9dQGOJrLh6a5A81KgEV8muAhIpmyfjjpVTXhAa6qmsPTU0zLclHZ73EGa94XSbNcp7
         TcU1YqFiz5huVcVkE78xbVzhjJOx1r/LpMyAr2k/D6iFH7fX9w/JbbKMdLlWG0BPdMks
         jgHSh1KfAWOalhTz/ZC5j6i0Q7HOh4yDq+c+IGWS6MvAoGPR3vj2cJE9i6Lfq3i6sgEG
         +hWPlhtGVf96jDNYAjkyuVw+Ns8uo45Mu6O5bEGuYzJltq0RO7qcUb3GCi9k7fkH7ESL
         Zj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472415; x=1726077215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydjc/sIhp1poblFcVfF/+5xFSn6DwsytXzLXERIDBMY=;
        b=UvrhHGs3QJXkIN8T3tGuJGh3OecLwSsr64YhL2NAPr2u6kKqoHSoveFbxaPFFpMDFS
         oYmiWB9PjeVmJy+Ew0JOPk7lwPrbUVwikn3Wv6SYMUWEnEsZbew8KnkT8tggZQ4BjwUG
         NT5i9KK1qZM65XtCGOMvx+xwP53c0/xCUYLWx03kgf8gNCXu8A9QAFyDlJ4SIxsXpI3N
         bXdyxc3SdYtHZz02h1/1dXFU4Br9bOqSxYFj8YW019lW3jQhzMnba/N8Jc7rXlRKg6/6
         QejESjGlzs/h0/lHmkVa+fc8mKEVE5o3Hchmmqv1Yvt9DafzdwtGJ6tD8Z2lCHBZRxMI
         WSyg==
X-Gm-Message-State: AOJu0Yzl2HjWAfNMvyWKTsnSJF2qAuxTSY3K5g+L6p2SYsVWWgtnObhp
	jmw7EgehvcvoWI/BQlKDPjK3padPY7BhzhFxzKkW2m2n7qxVhOuuOHI5NpZ251AjwDDY6HpHDuc
	G63w0t7+c7HTzunwcoy4eXTVdLXY=
X-Google-Smtp-Source: AGHT+IEJ98fSG+Oa0SC0byCT8F/NymIaJZz8+e5T3flehBYmNfGvP4iF7NfA+10m5qzV460yF3koAuXTlCiu5Yav7io=
X-Received: by 2002:a17:90a:e004:b0:2d8:82a2:b093 with SMTP id
 98e67ed59e1d1-2d89348db8cmr13601367a91.13.1725472414739; Wed, 04 Sep 2024
 10:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823222033.31006-1-daniel@iogearbox.net> <CAEf4BzaLhBBPZWwPgTA8bRwxy-Zar07chWm4J9S55EusnH5Yzg@mail.gmail.com>
 <7181ad2d-b940-8046-3a8e-25a07960eeb5@iogearbox.net>
In-Reply-To: <7181ad2d-b940-8046-3a8e-25a07960eeb5@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 10:53:22 -0700
Message-ID: <CAEf4BzbAFqw6M4OFa4JL9iU03Bvk+=N_gi0xKA-6a8-_-0zZ2A@mail.gmail.com>
Subject: Re: [PATCH bpf 1/4] bpf: Fix helper writes to read-only maps
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:02=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 8/28/24 12:37 AM, Andrii Nakryiko wrote:
> > On Fri, Aug 23, 2024 at 3:21=E2=80=AFPM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> Lonial found an issue that despite user- and BPF-side frozen BPF map
> >> (like in case of .rodata), it was still possible to write into it from
> >> a BPF program side through specific helpers having ARG_PTR_TO_{LONG,IN=
T}
> >> as arguments.
> >>
> >> In check_func_arg() when the argument is as mentioned, the meta->raw_m=
ode
> >> is never set. Later, check_helper_mem_access(), under the case of
> >> PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
> >> subsequent call to check_map_access_type() and given the BPF map is
> >> read-only it succeeds.
> >>
> >> The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM=
_UNINIT
> >> when results are written into them as opposed to read out of them. The
> >> latter indicates that it's okay to pass a pointer to uninitialized mem=
ory
> >> as the memory is written to anyway.
> >>
> >> Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
> >> Reported-by: Lonial Con <kongln9170@gmail.com>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> ---
> >>   kernel/bpf/helpers.c     | 4 ++--
> >>   kernel/bpf/syscall.c     | 2 +-
> >>   kernel/bpf/verifier.c    | 3 ++-
> >>   kernel/trace/bpf_trace.c | 4 ++--
> >>   net/core/filter.c        | 4 ++--
> >>   5 files changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index b5f0adae8293..356a58aeb79b 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -538,7 +538,7 @@ const struct bpf_func_proto bpf_strtol_proto =3D {
> >>          .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> >>          .arg2_type      =3D ARG_CONST_SIZE,
> >>          .arg3_type      =3D ARG_ANYTHING,
> >> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> >> +       .arg4_type      =3D ARG_PTR_TO_LONG | MEM_UNINIT,
> >>   };
> >>
> >>   BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, fla=
gs,
> >> @@ -566,7 +566,7 @@ const struct bpf_func_proto bpf_strtoul_proto =3D =
{
> >>          .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> >>          .arg2_type      =3D ARG_CONST_SIZE,
> >>          .arg3_type      =3D ARG_ANYTHING,
> >> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> >> +       .arg4_type      =3D ARG_PTR_TO_LONG | MEM_UNINIT,
> >>   };
> >>
> >>   BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, =
s2)
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index bf6c5f685ea2..6d5942a6f41f 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -5952,7 +5952,7 @@ static const struct bpf_func_proto bpf_kallsyms_=
lookup_name_proto =3D {
> >>          .arg1_type      =3D ARG_PTR_TO_MEM,
> >>          .arg2_type      =3D ARG_CONST_SIZE_OR_ZERO,
> >>          .arg3_type      =3D ARG_ANYTHING,
> >> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> >> +       .arg4_type      =3D ARG_PTR_TO_LONG | MEM_UNINIT,
> >>   };
> >>
> >>   static const struct bpf_func_proto *
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index d8520095ca03..70b0474e03a6 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -8877,8 +8877,9 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg,
> >>          case ARG_PTR_TO_INT:
> >>          case ARG_PTR_TO_LONG:
> >>          {
> >> -               int size =3D int_ptr_type_to_size(arg_type);
> >> +               int size =3D int_ptr_type_to_size(base_type(arg_type))=
;
> >>
> >> +               meta->raw_mode =3D arg_type & MEM_UNINIT;
> >
> > given all existing ARG_PTR_TO_{INT,LONG} use cases just write into
> > that memory, why not just set meta->raw_mode unconditionally and not
> > touch helper definitions?
> >
> > also, isn't it suspicious that int_ptr_types have PTR_TO_MAP_KEY in
> > it? key should always be immutable, so can't be written into, no?
>
> That does not look right agree.. presumably copied over from mem_types fo=
r reading not
> writing memory (just that none of the helpers using the arg type to actua=
lly read mem).
>
> Also, I'm currently looking into whether it's possible to just remove the=
 ARG_PTR_TO_{INT,LONG}
> and make that a case of ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT where we j=
ust specify the
> arg's size in the func proto. Two special arg cases less to look after in=
 verifier then.
>

When I looked at this last time, my conclusion was that
PTR_TO_{INT,LONG} just have extra alignment checks, which might be
important on some architectures. Not sure how to go about that. We
could probably implement this as another MEM_ALIGNED modifier or
something, not sure.

> Thanks,
> Daniel

