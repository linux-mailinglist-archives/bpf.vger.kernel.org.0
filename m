Return-Path: <bpf+bounces-22975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E004286BCD5
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F69A2890E9
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA771FBF3;
	Thu, 29 Feb 2024 00:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTnrbDX0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C06A23
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166642; cv=none; b=p8F5xw/vVL7hQURVM3p0YA1qhf31/8cVMMVUVf1Wgmdsh5zdSSB3bdEb0UhWZrzJprm4+9L8yOIUrSgR4IVH6o+ckwwKAoO1kYywb0HlX5EOCeKp86LgZGXLU0I9wZX2kyecQKmBvHmgM40Ln6Yh+3mZi94dE7ex2+6ZanP5gEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166642; c=relaxed/simple;
	bh=OsnG47ui76vYHCpgOHUCFUwEFvwtEWyt/+IhHKvnIlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAjChcKxKDoowbNuzMy31LyVLVFG66KoupqgehEobAoBNDuCJ8OLR8lAowgSmioCFYhYp4xxP4ir5jIndcunRtxm/2DvCIybnP2J/A3bQSk0jHYzF2onZnoN9DLatj7lZV5l8m+EsO8knJB6KVhulEvmFXCiYCQ0fEIk6iszp2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTnrbDX0; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so282287a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709166640; x=1709771440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVNgIoCAQKxuXn6up+l1TnJcCJKT04wvhYtTeM78vBI=;
        b=BTnrbDX0oyykDxO2N9rzXGhUFUu8cV+xfZ5XVizW/DP40b5iWbtLFMYhWrg8NEiBZZ
         vVLE64l9iwVdkqKF7evMebJ9URz4FFJ34I+n5Uri4yd+eCsj/nahNIb/aqHapqQCJAsF
         lChXPK9GOJucLntEXPIzyIPq3XGKegsgVHfa3qxgi2SaogKXTgBUX86+PLfSo3Ux6fBj
         padFHQuePCrQuDBxerikpx1UMuxu/1BeJzn/Zve2zGLcJkMZ/wkipuJZ5nIeIlyP7oWl
         deTPB5sju7rfr6Fn0R9TvOAeNQvv96gC7J4W/ht+zXFp/n+bUnTwDKJIIueHDuKSpZRS
         M5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709166640; x=1709771440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVNgIoCAQKxuXn6up+l1TnJcCJKT04wvhYtTeM78vBI=;
        b=Acn7wXn1fzaDAZkyl8wT0dhcRafPNY8YoKT3nvvwMYRZQBLWt04qHU8FgE8wZBKAx3
         x4c1x0ZJIZ05X9WT4G8dMIu1PPnTWCefj9Alayxftvq/WI2c4/QHZbI08m1It2UXIKQ7
         7plhGyFNrTg6wsGIFpEs9L7La5JWOPon24z/r1UrsICLYBM/ZMuUbJIXFBUX3OH+tsru
         L/McrNJkp5/Di1J9JjYWSlvZNN2YRxXLeLBHFoVgBX7mli4lrQ/P+eDfXkOLQcB9AnOj
         7tJpmOzBWh/T8BR/YsCYiFZtW+p/Vi7lkY+xfHZB54bKSTEnMhpemBjkWZkFuP0vsFgR
         eZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCULkSx+AQ/NFDXn7Sm8MadkWsGIt4rpcjR0/lgq5cT+0FEk1XEw/OT3XUQwpm/8ik5wkuaTlyagMRoacMtQDLGSz1HP
X-Gm-Message-State: AOJu0YyOACgo6yoVrrXDyvWgxtymKCfyiSnn7oP+dO/dQtcMk388wUC3
	TokeaIXkxAc6ukQwZAXMmFOtgevAR9I3EoqEZywbPc6GI+R/Z2rLd4uLj+Smaj1OhtvodTS1m9l
	RKY6hhCE8QUKlr4Erff+r+AzdkwA=
X-Google-Smtp-Source: AGHT+IF0r1xyWrxRT/LwvhdiggWlFMYMrkWsnrJDnmANn5ybFJBqJRHtetyfzuVUgTNnFCOgkTKkUpQ5SaLKsPziYSw=
X-Received: by 2002:a17:90b:378e:b0:299:1831:25c9 with SMTP id
 mz14-20020a17090b378e00b00299183125c9mr725110pjb.37.1709166640035; Wed, 28
 Feb 2024 16:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-8-eddyz87@gmail.com>
 <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev> <CAEf4BzbQryFpZFd0ruu0w9BC6VV-5BMHCzEJJNJz_OXk5j0DEw@mail.gmail.com>
 <ca62c2b8-adbb-4cbd-ab93-10a90dbdf2cf@linux.dev>
In-Reply-To: <ca62c2b8-adbb-4cbd-ab93-10a90dbdf2cf@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 16:30:27 -0800
Message-ID: <CAEf4BzYNVRaq7b+K_KqLMm+E3oybhaVFp1HzbTbR+sBYSoHM-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, daniel@iogearbox.net, 
	kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com, 
	bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:25=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/28/24 3:55 PM, Andrii Nakryiko wrote:
> > On Tue, Feb 27, 2024 at 6:11=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 2/27/24 12:45 PM, Eduard Zingerman wrote:
> >>> Make bpf_map__set_autocreate() for struct_ops maps toggle autoload
> >>> state for referenced programs.
> >>>
> >>> E.g. for the BPF code below:
> >>>
> >>>       SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
> >>>       SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }
> >>>
> >>>       SEC(".struct_ops.link")
> >>>       struct test_ops___v1 A =3D {
> >>>           .foo =3D (void *)foo
> >>>       };
> >>>
> >>>       SEC(".struct_ops.link")
> >>>       struct test_ops___v2 B =3D {
> >>>           .foo =3D (void *)foo,
> >>>           .bar =3D (void *)bar,
> >>>       };
> >>>
> >>> And the following libbpf API calls:
> >>>
> >>>       bpf_map__set_autocreate(skel->maps.A, true);
> >>>       bpf_map__set_autocreate(skel->maps.B, false);
> >>>
> >>> The autoload would be enabled for program 'foo' and disabled for
> >>> program 'bar'.
> >>>
> >>> Do not apply such toggling if program autoload state is set by a call
> >>> to bpf_program__set_autoload().
> >>>
> >>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> >>> ---
> >>>    tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++++++++++++++++-
> >>>    1 file changed, 34 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >>> index b39d3f2898a1..1ea3046724f8 100644
> >>> --- a/tools/lib/bpf/libbpf.c
> >>> +++ b/tools/lib/bpf/libbpf.c
> >>> @@ -446,13 +446,18 @@ struct bpf_program {
> >>>        struct bpf_object *obj;
> >>>
> >>>        int fd;
> >>> -     bool autoload;
> >>> +     bool autoload:1;
> >>> +     bool autoload_user_set:1;
> >>>        bool autoattach;
> >>>        bool sym_global;
> >>>        bool mark_btf_static;
> >>>        enum bpf_prog_type type;
> >>>        enum bpf_attach_type expected_attach_type;
> >>>        int exception_cb_idx;
> >>> +     /* total number of struct_ops maps with autocreate =3D=3D true
> >>> +      * that reference this program
> >>> +      */
> >>> +     __u32 struct_ops_refs;
> >>
> >> Instead of adding struct_ops_refs and autoload_user_set,
> >>
> >> for BPF_PROG_TYPE_STRUCT_OPS, how about deciding to load it or not by =
checking
> >> prog->attach_btf_id (non zero) alone. The prog->attach_btf_id is now d=
ecided at
> >> load time and is only set if it is used by at least one autocreate map=
, if I
> >> read patch 2 & 3 correctly.
> >>
> >> Meaning ignore prog->autoload*. Load the struct_ops prog as long as it=
 is used
> >> by one struct_ops map with autocreate =3D=3D true.
> >>
> >> If the struct_ops prog is not used in any struct_ops map, the bpf prog=
 cannot be
> >> loaded even the autoload is set. If bpf prog is used in a struct_ops m=
ap and its
> >> autoload is set to false, the struct_ops map will be in broken state. =
Thus,
> >
> > We can easily detect this condition and report meaningful error.
> >
> >> prog->autoload does not fit very well with struct_ops prog and may as =
well
> >> depend on whether the struct_ops prog is used by a struct_ops map alon=
e?
> >
> > I think it's probably fine from a usability standpoint to disable
> > loading the BPF program if its struct_ops map was explicitly set to
> > not auto-create. It's a bit of deviation from other program types, but
> > in practice this logic will make it easier for users.
> >
> > One question I have, though, is whether we should report as an error a
> > stand-alone struct_ops BPF program that is not used from any
> > struct_ops map? Or should we load it nevertheless? Or should we
> > silently not load it?
>
> I think the libbpf could report an error if the prog is not used in any
> struct_ops map at the source code level, not sure if it is useful.
>
> However, it probably should not report error if that struct_ops map (wher=
e the
> prog is resided) does not have autocreate set to true.
>
> If a BPF program is not used in any struct_ops map, it cannot be loaded a=
nyway
> because the prog->attach_btf_id is not set. If libbpf tries to load the p=
rog,
> the kernel will reject it also. I think it may be a question on whether i=
t is
> the user intention of not loading the prog if the prog is not used in any
> struct_ops map. I tend to think it is the user intention of not loading i=
t in
> this case.
>
> SEC("struct_ops/test1")
> int BPF_PROG(test1) { ... }
>
> SEC("struct_ops/test2")
> int BPF_PROG(test2) { ... }
>
> SEC("?.struct_ops.link") struct some_ops___v1 a =3D { .test1 =3D test1 }
> SEC("?.struct_ops.link") struct some_ops___v2 b =3D { .test1 =3D test1,
>                                                    .test2 =3D test2, }
>
> In the above, the userspace may try to load with a newer some_ops___v2 fi=
rst,
> failed and then try a lower version some_ops___v1 and then succeeded. The=
 test2
> prog will not be used and not expected to be loaded.
>

Yes, it's all sane in the above example. But imagine a stand-alone
struct_ops program with no SEC(".struct_ops") at all:


SEC("struct_ops/test1")
int BPF_PROG(test1) { ... }

/* nothing else */

Currently this will fail, right?

And with your proposal it will succeed without actually even
attempting to load the BPF program. Or am I misunderstanding?


> >
> > I feel like silently not loading is the worst behavior here. So either
> > loading it anyway or reporting an error would be my preference,
> > probably.
>

