Return-Path: <bpf+bounces-47987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC5A02F3B
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F283A140C
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBE1DF277;
	Mon,  6 Jan 2025 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHO1H+32"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF21DEFEE
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185564; cv=none; b=iI/YsXopV2So+PC9fBUD7getLJxopOkxRthFdqsN0Dnqpq9CQ+jJ9iHTx2D2yneAxdgpGVVVd5pfzzouOd8nzGRkTv68P6AjBrNZF7bOnDwe3uPFdehtWD2zv4+D5uERASBLDQuVD3C4OdjSuoyAl1uPMrNTNmAySCXJ3jQkXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185564; c=relaxed/simple;
	bh=eZ/CNQCgUKnDkd9Ob5XO7WmEGOEfgg2R5W0f3NcVz5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxImc493dSyI0KIn5H8RexPrqTzHmL3mdUxcgZEJhRA/jYihuXCGcCFpFPWLRa3vQ2sLrsZwE4uMcg2N2KqOwljm6Znlcc3tTO5g3qmZuK0XwfuoslcRJthQYPhxkoMHDhGQUuKkUta5hmViIccKSJ1iB4XWaZQt7gZa8T4CEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHO1H+32; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso14089816f8f.2
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 09:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736185561; x=1736790361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZmBonqZciyZyaAsRVx4gjP2o+SLAwfnpWGYbEP5vgg=;
        b=kHO1H+32tj7e5eYNRJA59tFfgRSHotFL208E1iefNdwO2rddWOhh29jy/hLbFZIbMe
         6g9scxvCoGWFSobjp2HHjaATmoCqLGOKM34qPAftY8QKRDcpo8+JeV5gYbmUPX6CWl5z
         MfZyU/Oqwlf8QmUx/MrYN0C0qBwe6eaR4jJjq8FODtmytgqQgUu72RagOmgPfkAAyd6a
         JRTj90Ij0QFMx4OWf3VP57YgG6fQHbghmGukIy7zqA0c/4bzYe2I16QbV0tWtlHG1khk
         QM78zi8LzZ+HJZNKyorlNrgWTuIQmD8NAEznG1ekEFfQ22KA9kei/rnZYrdWZNZpve1Q
         XmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185561; x=1736790361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZmBonqZciyZyaAsRVx4gjP2o+SLAwfnpWGYbEP5vgg=;
        b=KRuj3bvXRPYPnI+zxNZt5aUYSqa4YZvg1JB/RT1hgvT/NXm4iHbs3IEmlqQRRTZ3l8
         g2FMXsEIexvzvl8S4FDrxtT3GTU7RFSRGSMSIezZkgANutNdTzvJt87Lafae47YofRST
         SdECWbEa9wTaT9pkFhlwCpz1uRIUWDN+1KNNlvwb9IZ6EBaOroL5dbwc3eDKVTKRXW2r
         Fda0tg2trdcntk8NFHD+DVeWMvCGtuFM3PvQ2bmLr5nkwc045GjkZqTBdPJG5At5Jv79
         9nzWg0WoaNGZ+shPWEWAGYpzkwSyzQiBrwhpyTlSdLnTBVSC2zKF6nJgtcR3DfgYXbEq
         rZSg==
X-Gm-Message-State: AOJu0YxLnziZP0AiE8BEtNgbXBHc9rJoVrL2Sua5TMtdwg5FUY6GwBmg
	kEj5U/GN3oPrQqfTbzeG0LrPfyYXx9sCEAE0yqvd9srACR21E+VTYWdO8gGzxTEPYUc4DcyV7oI
	yptFU8qtNHQ9juOpQ4HWqWDnEXHs=
X-Gm-Gg: ASbGncuYhI0pSjnea/Ljw0QPvwRRc9QlqForB/eEXXrrQ5RL7Ori8itNTUSqHlofkQy
	14cxC8g76QeP91ZaTGXgmbu7jHdMqXRtT3MXtDHNs2E/9HcRaTzG8Ng==
X-Google-Smtp-Source: AGHT+IF/TvMPIrhZpMBTXrM/wT7dJaDwZeEK7vEwPNt3YbCLE83Re2Ep3CDnYn/79+nHbXdOQ4mcH/K7eCajh+8/F8Y=
X-Received: by 2002:a05:6000:1ac6:b0:385:ef8e:a652 with SMTP id
 ffacd0b85a97d-38a223ffc9dmr47113527f8f.56.1736185560447; Mon, 06 Jan 2025
 09:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
 <20241108025616.17625-2-alexei.starovoitov@gmail.com> <5fe34ecf-07df-49c2-b94e-36ee6cb21f8a@google.com>
In-Reply-To: <5fe34ecf-07df-49c2-b94e-36ee6cb21f8a@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Jan 2025 09:45:49 -0800
Message-ID: <CAADnVQJhvpK_wtASpfUNbem9iktc21x+z9ZjXfvcyjzX1F=86g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce range_tree data structure and
 use it in bpf arena
To: Barret Rhoden <brho@google.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, djwong@kernel.org, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 8:12=E2=80=AFAM Barret Rhoden <brho@google.com> wrot=
e:
>
> On 11/7/24 9:56 PM, Alexei Starovoitov wrote:
> > +/* Clear the range in this range tree */
> > +int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
> > +{
> > +     u32 last =3D start + len - 1;
> > +     struct range_node *new_rn;
> > +     struct range_node *rn;
> > +
> > +     while ((rn =3D range_it_iter_first(rt, start, last))) {
> > +             if (rn->rn_start < start && rn->rn_last > last) {
> > +                     u32 old_last =3D rn->rn_last;
> > +
> > +                     /* Overlaps with the entire clearing range */
> > +                     range_it_remove(rn, rt);
> > +                     rn->rn_last =3D start - 1;
> > +                     range_it_insert(rn, rt);
> > +
> > +                     /* Add a range */
> > +                     new_rn =3D bpf_mem_alloc(&bpf_global_ma, sizeof(s=
truct range_node));
> > +                     if (!new_rn)
> > +                             return -ENOMEM;
> > +                     new_rn->rn_start =3D last + 1;
> > +                     new_rn->rn_last =3D old_last;
> > +                     range_it_insert(new_rn, rt);
> > +             } else if (rn->rn_start < start) {
> > +                     /* Overlaps with the left side of the clearing ra=
nge */
> > +                     range_it_remove(rn, rt);
> > +                     rn->rn_last =3D start - 1;
> > +                     range_it_insert(rn, rt);
> > +             } else if (rn->rn_last > last) {
> > +                     /* Overlaps with the right side of the clearing r=
ange */
> > +                     range_it_remove(rn, rt);
> > +                     rn->rn_start =3D last + 1;
> > +                     range_it_insert(rn, rt);
> > +                     break;
>                          ^^^
> did you mean to have the break here, but not in the "contains entire
> range" case?  for the arena use case, i think you never have overlapping
> intervals, so once you hit the last one, you can break.  (in both
> cases).  though TBH, i'd just never break in case you ever have
> intervals that overlap (i.e. two intervals containing 'last') - either
> for arenas or for someone who copies this code for another use of
> interval trees.

I copy pasted that 'break' from the original Darrick's
commit 6772fcc8890a ("xfs: convert xbitmap to interval tree")

This asymmetrical loop termination bothered me as well,
but as far as I understood the code it's correct,
so I kept it as-is.
In bpf arena we won't have overlaps and the way the range tree
is used with preceding is_range_tree_set() or range_tree_find()
even the 'while' part is not necessary,
but somebody might copy paste the code, as you said.
This particular 'break' is more of the optimization, I think, since
next call to range_it_iter_first() is supposed to return NULL anyway.

