Return-Path: <bpf+bounces-69246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6AB92297
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C2C3A5055
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EA43101BB;
	Mon, 22 Sep 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0af/bYl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A52E2850
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557792; cv=none; b=nymTKWunNhHGaEyl/qAFNsd6XY24txs0J6XOQdT1ssUsGcpehZUZqN1O3ysuayW2kj6LkcbHs02AD0TTKU4hpFoSzrmQHBIGMiKP3gI1NEib0rJIL+9iUGu/ZWhBPQyWYscaW02p8Ez3/sBOOGUgJHoDZARJ/lzILbwk4GHpg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557792; c=relaxed/simple;
	bh=k6e9yacPcaxNeR/G/vDl+4Sc9IVXtSREsF2s4eg/GBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl9VctTdoGJM4xdZFJQZjIeweUX1K9ESZKJ6lF8qXadvOIoxJUCbgyOeqLmK4XDt4QquwJmTjDK03aat0nkpuzb1XWXYtHxceKfSV59sk2mZPPgQx+jI1Rt2jTn6YMElaTi5qXh9kI797GZtK3EQSenSYpCnnHniKwXIQPhK4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0af/bYl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso2596333f8f.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758557789; x=1759162589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbZ9yx48UvonI3ViWHBtvsY4obV/dViz8JZGysXqUo0=;
        b=E0af/bYlmWQrByBf2h9zSkzMlOZx7VA13Hup0nP66dk40tpznbfrPA7ke5CQMn7ggE
         TzZGfuVJwDw5CBtMz9ea9uZjyNdWcXJhtS2/pI+Hw80vvcTcH+SxBX0CiYvBhum2UCvv
         DkVm5kH74JE05LWCDHAI9j4pJ/mNTxDTwgYthRf2Qsf/AGsPm9GkRM2kZq2/Zl13vsl8
         sPVLGOzsMPg2OpqkKtUzJDNpUsaDS0t7QR/J9xwiYlVmzOgMgpDiADzlrLfAUA12yxIu
         0Iru9mlN5E6APZr663YNq7NqUfpx+RJ1HEfbxKi7stSswM1gzW85KmIvDaROerRV5lmj
         YAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557789; x=1759162589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbZ9yx48UvonI3ViWHBtvsY4obV/dViz8JZGysXqUo0=;
        b=ozhhQPGWtwrWpAGCFyE/zDpB2e7yjnxx9aPSJLpipgmvFMIDRfYDL+A0XFDMtkc+Hm
         i99EmEHYlAYuHu6LB7H6f3qAyh1a15Wl+aSbgpTrpkYd54f2NDeGfp3+rNYhCK3K/Tpq
         syAq5ndiMkvu0OTKELTj4h3MYuXPW3yJQA9MAjBOygoJ9Rs18p8mwtb85C9vpUxDhDGc
         fPVEkXuxR7T4mTo0yFRBpV0kwXFhOBD4RIam8vkJDNCIOkG9Furz+a8zx0DorbPlKThf
         oIFRT2u11ez/vWH9VEtTyy3WrjaB2KbOojnLEBTK8VBEGGTMG6Gf8B8RdjECvpIBnzCC
         Sj+Q==
X-Gm-Message-State: AOJu0YwLcExBx1InaZFKbPB/HbXvD/QuvN5L3XkW3lVK81Rjrr7WMmT/
	rs6ySwmWzGduBh5z31iWRa+SHDxqVDVSHidR6EelNPcs667K4Zv5EAdg8njQF5ONlvgTFFaLoo8
	FJwW5pBvP1VHPxPw7OXVbTAVAnDCNH08=
X-Gm-Gg: ASbGnctZ/sR6vedzBH1apV9LEgt64vJ0z8c6XXYJ6sjnHHHmzC60jrcISfMgD28evZB
	kqUFbpDELCdWUy5FctARV8At4k3Vz2fvFajzc42veho5iz5h57SMwf/yOFJiNKH0L9+HqRvRSR+
	RrBlzqyOqxXzWZrpnzhe1RrMKWqinD4WmF5g3XtdWqffjvKV3a5j8P0L4DwhCNNFZoEpsfcu/YT
	V6UyKWEz2PZYDad77mRjLk=
X-Google-Smtp-Source: AGHT+IEGENQU4mW1g3Kc4syDm8FFK5ur6pWHP2TjkeQiI5esKuI7Rk/KWjw+L8PVKQDqynUfLo29fAVwn1qz3YbKfJU=
X-Received: by 2002:a5d:408d:0:b0:3f2:dc6e:6a89 with SMTP id
 ffacd0b85a97d-3f2dc6e726fmr5794102f8f.57.1758557789326; Mon, 22 Sep 2025
 09:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
 <20250913193922.1910480-4-a.s.protopopov@gmail.com> <CAADnVQJsuxh5HrNKW_-_yuO5FqLQ8S4A4YN9bZfRHhO5pt5Dtg@mail.gmail.com>
 <aNEnLZzOyEuNOtXu@mail.gmail.com>
In-Reply-To: <aNEnLZzOyEuNOtXu@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Sep 2025 09:16:17 -0700
X-Gm-Features: AS18NWACIdXsFs8BdUQOaTpohYarT6i1P0pMN4zZEp3X9uptD691MH-dkJDdBpc
Message-ID: <CAADnVQKK80Vvph7W7PSwG_GAPwXZO_wNYOKt6h9LHjHhPcjHPA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 3:32=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> > > +int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *=
prog)
> > > +{
> > > +       struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> > > +       int i;
> > > +
> > > +       if (!valid_offsets(insn_array, prog))
> > > +               return -EINVAL;
> > > +
> > > +       /*
> > > +        * There can be only one program using the map
> > > +        */
> > > +       mutex_lock(&insn_array->state_mutex);
> > > +       if (insn_array->state !=3D INSN_ARRAY_STATE_FREE) {
> > > +               mutex_unlock(&insn_array->state_mutex);
> > > +               return -EBUSY;
> > > +       }
> > > +       insn_array->state =3D INSN_ARRAY_STATE_INIT;
> > > +       mutex_unlock(&insn_array->state_mutex);
> >
> > only verifier calls this helpers, no?
> > Why all the mutexes here and below ?
> > All the mutexes is a big red flag to me.
> > Will stop any further comments here.
>
> Mutex came here from the future patch for static keys.
> I will see how to rewrite this with just an atomic state.

I don't follow. Who will be calling them other than the verifier?
Some kfunc? I couldn't find that in the patch set.
If so, add synchronization logic in the patch set that
actually needs it. This one doesn't not. So don't add
any mutex or atomics here.

