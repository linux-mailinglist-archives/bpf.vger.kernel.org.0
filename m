Return-Path: <bpf+bounces-69267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAB1B93365
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 22:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979101903F33
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 20:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1331A56C;
	Mon, 22 Sep 2025 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISFI2PrX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7FB2F28FA
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572669; cv=none; b=TJ4TR7DRKU2V/Zjqet6QHsjHoFqBfbL+oWg5g2zhTPKwhpxi54gOYkT8tHAoURl60VqAkqlXoHtTkcVejuFLr+cfm+x9TAwbHbOUQInmdaMAuOf/EQCV3ZrjiprIAlXBLx5JFknbetafzKgunwfSE1+gZnE1123cYwoXiwCXIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572669; c=relaxed/simple;
	bh=H87w2oCtE9zuPw62HUu9GfYhRNsSkglIlHZai8e/jqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ld8Qrdz+C0fAoMVp7Oye0Sdv++bnJj8885lEqeWRGUljDer16HawgO0ncv+BsuguJxyfCDVMJbfQ0PYlkfOstrNo6UMC8C6CxrcUBUxIhXuuMkF6fg0CuI8f1KWBf89qPccabbIPNTHi3xNbfZt+v7klxhg8Jr41LIrHy/pcDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISFI2PrX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso32456725e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758572666; x=1759177466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bDLoqIL0L4GyiEGOgjMbKPRDrLNrCGOIHn9aW7KylI=;
        b=ISFI2PrXrhlPUdevx7SkPRj0PSJ13ul6pkp6qE2tQx2Ra50iAFo04RpBv80NJi/hNu
         ChA/rp6Fg3Og069GvYLSI35gydmnOTxSzoKvSO2jFYOLNeYbXU2NdQ9Jd0oEc3mtm2Xp
         57dlxg5o3PwrRpYvZjzdkAtGcHxkMhygpVy7H48iSzkTwTTnPorg4nP87KF97Onxy105
         Wco5ODJ7EzF3vqrxRo4YBi1cN94Q1thw6LeuobfvDroKBfP/YOKgVonZrQyRPuB+ghQR
         VOMLM4t1/t4QRUyaPQk4R+mgPO3RNIbb/HIYe1Hx5nd9Wv1fuUdJ7XRIjH3tD+qypiwz
         Gjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758572666; x=1759177466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bDLoqIL0L4GyiEGOgjMbKPRDrLNrCGOIHn9aW7KylI=;
        b=wp20VrOKzHHM6ODug96jSRhFftJfdL4kAMS/rz3SM8cJIcoST/FwGptzZsrsC/pzO0
         7tzt2h9+mj26heqcDD0yCQv0CsLG9iEcT5f4SCkw6j/OaBHhYU6y/Xq1ClkfoUJz2VfH
         bvLYal7JP5BWaR+0H/F/mZcPK3tXIfRECsWUABLdQcDBEphbxLstRg7PweNjUJ4bJby6
         436vxHC7/4EQaZoNTGo5gPtqDYaHoeD2FysEnlJkOccUJexoAPcq0dM+rtb6ajRIeDwj
         wEhTwRarU0LWHSTi9Aw/nzGC0AFBzTe4s9TKr9SafSlxMbJy25s2JYmLTKnNHDRbdCVt
         78og==
X-Gm-Message-State: AOJu0Yw7Ch5DdgySasnBazPlGx9T3CfSED1fuNYCvNZU6IaXezGuORN1
	sxQyoPQ4gHUahkarVGq7Hroj7RkV1Db3kKSXtAerLbpx+hKR1KZ8fpmM1Nx/1kfi/SSqdIGfcjr
	9n9sYKE9DBqcXb6XmOHr6brkx8TocBzKK+w==
X-Gm-Gg: ASbGncs6fAstW7O76Qb5GW8qRC1tlHlBfyEj7J5kX3HFguj+ldnBjFT6yjiHd9y88yT
	oR6RhbSpwtDRwqn3O3v/8Z2HMVZkaJkJWI/3CAKLLN79kg/QvUKWpo/l53J5VILNvwBfXTUVyll
	ir9U2qs8n4ZBwNPyIxh3j/YjJJtZnAL+V55NmxvB1H2UYmThyBoy0C7E7y342Hopm1ZtGmR8QTv
	CsjYN4IL9lWFj8eDzpyMg2jxV61fBHduhtf6AJC2PKY3uM=
X-Google-Smtp-Source: AGHT+IGGHxRFsYeQnCVUTqP+r/iaX+KCTmp9/4dEg670jhwS9QTh/iB7Yx1FxWScVNN70hhuJm/3nEEgj1/MkuwZfig=
X-Received: by 2002:a05:6000:4212:b0:3ee:15d5:614f with SMTP id
 ffacd0b85a97d-405cb7bbc70mr16368f8f.46.1758572666015; Mon, 22 Sep 2025
 13:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
 <20250913193922.1910480-4-a.s.protopopov@gmail.com> <CAADnVQJsuxh5HrNKW_-_yuO5FqLQ8S4A4YN9bZfRHhO5pt5Dtg@mail.gmail.com>
 <aNEnLZzOyEuNOtXu@mail.gmail.com> <CAADnVQKK80Vvph7W7PSwG_GAPwXZO_wNYOKt6h9LHjHhPcjHPA@mail.gmail.com>
 <aNGJT6IosAI7HP+B@mail.gmail.com> <CAADnVQJ=qN+x9vTwU=yskvwoe7vAqe=c7U6nLaKmP1u+jn0s3w@mail.gmail.com>
 <aNGiIgC7+t+YIM8j@mail.gmail.com>
In-Reply-To: <aNGiIgC7+t+YIM8j@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Sep 2025 13:24:14 -0700
X-Gm-Features: AS18NWDdfOpApxIn3qNVk1EHF1GnjeEdBIzAAuC3YkaJu7dvSUeZfKSAhRPJRiA
Message-ID: <CAADnVQK2s6nPCAPy+HDfG0MgPYSkFH0mPobO4HNP+ymueN9Seg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:17=E2=80=AFPM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/09/22 10:57AM, Alexei Starovoitov wrote:
> > On Mon, Sep 22, 2025 at 10:31=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > On 25/09/22 09:16AM, Alexei Starovoitov wrote:
> > > > On Mon, Sep 22, 2025 at 3:32=E2=80=AFAM Anton Protopopov
> > > > <a.s.protopopov@gmail.com> wrote:
> > > > > > > +int bpf_insn_array_init(struct bpf_map *map, const struct bp=
f_prog *prog)
> > > > > > > +{
> > > > > > > +       struct bpf_insn_array *insn_array =3D cast_insn_array=
(map);
> > > > > > > +       int i;
> > > > > > > +
> > > > > > > +       if (!valid_offsets(insn_array, prog))
> > > > > > > +               return -EINVAL;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * There can be only one program using the map
> > > > > > > +        */
> > > > > > > +       mutex_lock(&insn_array->state_mutex);
> > > > > > > +       if (insn_array->state !=3D INSN_ARRAY_STATE_FREE) {
> > > > > > > +               mutex_unlock(&insn_array->state_mutex);
> > > > > > > +               return -EBUSY;
> > > > > > > +       }
> > > > > > > +       insn_array->state =3D INSN_ARRAY_STATE_INIT;
> > > > > > > +       mutex_unlock(&insn_array->state_mutex);
> > > > > >
> > > > > > only verifier calls this helpers, no?
> > > > > > Why all the mutexes here and below ?
> > > > > > All the mutexes is a big red flag to me.
> > > > > > Will stop any further comments here.
> > > > >
> > > > > Mutex came here from the future patch for static keys.
> > > > > I will see how to rewrite this with just an atomic state.
> > > >
> > > > I don't follow. Who will be calling them other than the verifier?
> > > > Some kfunc? I couldn't find that in the patch set.
> > > > If so, add synchronization logic in the patch set that
> > > > actually needs it. This one doesn't not. So don't add
> > > > any mutex or atomics here.
> > >
> > > The usage of this map is as follows:
> > >
> > >   1. A user creates it and fills in the values using the map_update_e=
lement (syscall)
> > >   2. Then the program is loaded
> > >
> > > The map <-> program is 1:1 relation, so I want to prevent users from
> > >
> > >   1. Updating the map after the program started loading
> > >   2. Allowing two programs to use the same map (while, say, loading s=
imultaneously)
> >
> > Then the user space should freeze the map after updating and
> > before loading.
> > As far as 1-1 relation, we just landed exclusive map support
> > that ties a map to one specific program.
> > This mechanism can be used or 1-1 can be established by the kernel
> > internally.
>
> I've actually first did it via frozen, and then removed it after Andrii's
> comments. Will get it back and remove all other mutexes

What was Andrii's concern with freeze ?
It seems like a good fit to me. User space updates and freezes,
because it shouldn't be updating it anymore. Normal jmp tables
in ELF are readonly too.

> > > At the same time I want map to be reusable for the same program for t=
he case
> > > when the program failed to load and is reloaded with the log buffer.
> > > So there should be some synchronisation mechanism.
> > >
> > > (In future patchset, the bpf(STATIC_KEY_UPDATE) syscall needs to exec=
ute. It
> > > needs to be sure that the map was successfully loaded with the progra=
m. But
> > > you're right that this doesn't make sense to leak part of this patch =
into this
> > > patchset.)
> >
> > Even when that bit will be available it won't be modifying the map.
> > At best it will flip flag or bit whether the branch is nop or jmp.
> > I still don't see a need for mutexes.
>
> ok

