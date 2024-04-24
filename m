Return-Path: <bpf+bounces-27721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B648B13BE
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D82D1F245D9
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9D213AA3C;
	Wed, 24 Apr 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdsInAd+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104B1772F;
	Wed, 24 Apr 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987918; cv=none; b=be6m6/GUgIdFN30PdbYFnOBR/vLNQORRJ4ugMqqDEoT+dDWELoNEiF/k/ic0SXn6OvPM21PdPu6Ik/XjOfdzla8TMUSRlxVYkD+niphWU+CuWeuXMC/ng8YuV2X1Z9O0CmB5mf0qf31+f2JwESjQU8Oc+Wb1cRU2F+7Zcv2/ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987918; c=relaxed/simple;
	bh=TKFl9kKtOhCFylFVkKSuVb1elJMY8fhFNfm1O7Tf+UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GG+7wXQLg+0HyztgdivbFYPJCKVbvB6oq6OSr+PIp6f3jZoeRh5qKfCx85FIAhi5ZKU3+zJbZiB6KdXZWWEnMWbbgYBe/qXnGls5U6M+byM81gakHkZL5ZlPBtKestEKWPKoZxJBWXJpqCabQDI9f3ByPyfd9epUG0DJVGzZty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdsInAd+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3476dcd9c46so123598f8f.0;
        Wed, 24 Apr 2024 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713987915; x=1714592715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9nkQizUZINco6fYbTTRqD+38cF4hjGoEgSLA8Uwio4=;
        b=NdsInAd+1lgAc1CEXK13b3gGSongOu3Hmkv+Gh9OQ2z49NLVhwEj1qF6xdRCT+j2cy
         kJrAOoDChJ50Ud4snVhoLT3mEkDofeceYna1uWGa6J9IPI2VXjATOKB1MCHXLz7VNEQN
         em1RUGBk5AqopC3UUk4/hiYk/8XC5bmJcdMULxkuDCT/jG51f7zDWZtRGZfZFxnXjoSP
         np8ZZzkSxqo/JrzR4SGCwEOb62dNoOtoTQmC7kkmk01lR6vY9RJDq9epCBwg1rRuyxxZ
         QeQIdhF6GLfwVWpjid6GYrdaFmogaTsQZgsIi5tlk0QdWPb6N0yTq6mL2LQgFBgHx0IY
         SIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987915; x=1714592715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9nkQizUZINco6fYbTTRqD+38cF4hjGoEgSLA8Uwio4=;
        b=w349flVcyMvJ8/BtvfOEVUgPTnvImJj24QV9hA6tXUo/hwSLzuh5sxFnz0crsTzrwg
         W1xL7yAzsVA4N4JM/bN6daA2lAeP+F4SIkDWRNcpgEi0dnS3lo2YF14HT4dTbArzxMrX
         WIO38Mi+S9VpHJQUZjc5NKt8IijVLqFy34s7YPLp9EWg+clpUXFHvTeCswlZ3sTM0ElS
         DYYykwrhQoCpoirj2K7yPK753S0qTfyhLW1+/XFrKnP+vy6PCuFB3WI3o3Ny2XvXiDfz
         zIrDtOoOnCDTouYVMiUyFu7ujr5KUXIIvk2tNrC5g66YyAJHbXc7zgVcHDrcdj4DFilD
         Mw6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSbXs8qeRK04jYLk1IAH1zbqbuP5QLZ4VUQ03l8ikwufZ4xVDFZBkMwo5qiDzgc4o5HNFuhQljuFYpWBKEsCuHJBC9Bb3s5oDm3Kelg72s4KBhSUMQ/8DPNHuOZFE4Lxl0
X-Gm-Message-State: AOJu0YxS97jgINDgYWCW2CikA/VCxhjb5A/uE9qfafHkS3vgsLkebE93
	qaRUiK1ID66C0RqgBGPf0jeNX19foRFApHVwLfQU14c7+k+662cVG1vh1Og5ZPrIAUyXsBAs+DS
	bo4fBKu2xHR8FmJtZr3LfAgyxvhM=
X-Google-Smtp-Source: AGHT+IEydZlC7xEGIR9+2aVdtR2jbIZr5WQjrNYyiu9uOOb/zbNDpgnO0U6ONgJZv0zM65Y0b2+2msUibgJ5Pqh3xNw=
X-Received: by 2002:a5d:6509:0:b0:343:8373:1591 with SMTP id
 x9-20020a5d6509000000b0034383731591mr2111251wru.64.1713987915024; Wed, 24 Apr
 2024 12:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
 <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net> <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>
 <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
In-Reply-To: <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 12:45:03 -0700
Message-ID: <CAADnVQJaG8kDaJr5LV29ces+gVpgARLAWiUvE9Ee5huuiW5X=Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: verifier: allow arrays of progs to be used in
 sleepable context
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 7:17=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On Apr 22 2024, Benjamin Tissoires wrote:
> > On Apr 22 2024, Daniel Borkmann wrote:
> > > On 4/22/24 9:16 AM, Benjamin Tissoires wrote:
> > > > Arrays of progs are underlying using regular arrays, but they can o=
nly
> > > > be updated from a syscall.
> > > > Therefore, they should be safe to use while in a sleepable context.
> > > >
> > > > This is required to be able to call bpf_tail_call() from a sleepabl=
e
> > > > tracing bpf program.
> > > >
> > > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > > ---
> > > > Hi,
> > > >
> > > > a small patch to allow to have:
> > > >
> > > > ```
> > > > SEC("fmod_ret.s/__hid_bpf_tail_call_sleepable")
> > > > int BPF_PROG(hid_tail_call_sleepable, struct hid_bpf_ctx *hctx)
> > > > {
> > > >   bpf_tail_call(ctx, &hid_jmp_table, hctx->index);
> > > >
> > > >   return 0;
> > > > }
> > > > ```
> > > >
> > > > This should allow me to add bpf hooks to functions that communicate=
 with
> > > > the hardware.
> > >
> > > Could you also add selftests to it? In particular, I'm thinking that =
this is not
> > > sufficient given also bpf_prog_map_compatible() needs to be extended =
to check on
> > > prog->sleepable. For example we would need to disallow calling sleepa=
ble programs
> > > in that map from non-sleepable context.
> >
> > Just to be sure, if I have to change bpf_prog_map_compatible(), that
> > means that a prog array map can only have sleepable or non-sleepable
> > programs, but not both at the same time?
> >
> > FWIW, indeed, I just tested and the BPF verifier/core is happy with thi=
s
> > patch only if the bpf_tail_call is issued from a non-sleepable context
> > (and crashes as expected).
> >
> > But that seems to be a different issue TBH: I can store a sleepable BPF
> > program in a prog array and run it from a non sleepable context. I don'=
t
> > need the patch at all as bpf_tail_call() is normally declared. I assume
> > your suggestion to change bpf_prog_map_compatible() will fix that part.
> >
> > I'll digg some more tomorrow.
> >
>
> Quick update:
> forcing the prog array to only contain sleepable programs or not seems
> to do the trick, but I'm down a rabbit hole as when I return from my
> trampoline, I get an invalid page fault, trying to execute NX-protected
> page.
>
> I'll report if it's because of HID-BPF or if there are more work to be
> doing for bpf_tail_call (which I suspect).

bpf_tail_call is an old mechanism.
Instead of making it work for sleepable (which is ok to do)
have you considered using "freplace" logic to "add bpf hooks to functions" =
?
You can have a global noinline function and replace it at run-time
with another bpf program.
Like:
__attribute__ ((noinline))
int get_constant(long val)
{
        return val - 122;
}

in progs/test_pkt_access.c

is replaced with progs/freplace_get_constant.c

With freplace you can pass normal arguments, do the call and get
return value, while with bpf_tail_call it's ctx only and no return.

