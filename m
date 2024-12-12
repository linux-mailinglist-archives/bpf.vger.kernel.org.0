Return-Path: <bpf+bounces-46724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630069EF8EC
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 18:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADF01895787
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8258A222D70;
	Thu, 12 Dec 2024 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cbc5MT4h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BF20A5EE
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025190; cv=none; b=hPxohveME1IMcVHRWw4PZhINJcx6+EVTKWtzNULZpFvv1Njg1xbxmfcA0a+CydV30oDyt4kdVyXtgcNHOvz1C9lR5H2MbZiym5bPGUjrIOcC2DkPn5WgbD3qwWn8PYDTK6fRbyDqg5kZVTXWrB5I6vRFHR9YDqi73QWBP1oZPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025190; c=relaxed/simple;
	bh=bTZOSoVCidXecuQaGVbMCgjNjb7EJKlSGgp/+hoRuQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJK38nZYooXBRL8SvyYyDZD7IEuorsigZtU4WW+VAPmqzOfIo+rq5ZffxRNbrkVc+29LzZxq62NkSPg8+ONbaN3ZZ3kct/3mE+6kbJD2WvjFfYZF0WTu3KverSWbeQvyqROSD+qncPoydBkbd97pV6K2njAP+j8Mmcks+vX7Xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cbc5MT4h; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728ec840a8aso1009813b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 09:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734025188; x=1734629988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7rM4gY/t0TAm13sd7EhwsBGEjPyE7D9W2z1XBteifM=;
        b=Cbc5MT4haF/h6P3fZuob8YHWZjMvLhNEjyCmZbgg8jPQF4mHG1rTVkPzi87BDL0d2f
         QfvKrI6ohVDRJGyObicqye1aiF051VMxKRcJjjH+xIrsYk2LbxSbBNdF0Mubhxl466qa
         rByBlGrL3ADQhfdMKnP1Wn9uEt5FvSJBMPfpeWg29KNE6VrEqjc8S8r2BkB6tiZ7vjVa
         6ecZ0O+nXGY3NNNgMp3wypgV1dZu2tRbWRccUbtHs5EF4hI0E3ElVaGlNjZk+C4tBosO
         TsySQb6BLxnTYG5ew4agfb9xw0OQN0ovh37DREanyHwkjAQnSxxHPG6wo14rxYtdPLlM
         uSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025188; x=1734629988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7rM4gY/t0TAm13sd7EhwsBGEjPyE7D9W2z1XBteifM=;
        b=w2uh5l815ZKxj7P18zxBSE1zHTTw25r8SNUVWrDtprP540PksG0iGTSVUEvmPQYyo4
         OYOmULKba8jk7rBYQU0Tb7E/O3/HvYlkpPhKT4LClw/tUWfBAmliKKlo/biCXuBz8Fxg
         K5a7OKDyer6BlgtbJ3PG36cW/tTGfazg31e8g/83wed+8zdneEgfPB0bBgsHeA/+Q3Pf
         +FcBn/Fg3cZEWwB0aUZYEBemmLL2vguKTj1XLak33wIPT0afzRvyooYCCvZYowWdkmKm
         NNOF25Rm39+A6s9vcFWV3nu7sgei+dmqSjTbXojhpwfc+t6yWSPWY3TLw0M9DrjqDWcx
         BVng==
X-Forwarded-Encrypted: i=1; AJvYcCXjokZjcXiP1tpguOX0FXSicnKx+MzgL9rkk/lpD+UtnYEp003jgwFFxi6nv1vydwTajxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37nt/vmd7ecTBaCDrASKVzv7dnpBtjWS4LS8dIR81UsNk7uax
	i0tG64lrzi8kvSxZnt81zWBsLqwHXTPeMMmvyBJjbr3J4SIjCSHSKXDF9nCvQnBlgRwpD70j4Bx
	MLvBZZgJ3iBvpro/zbm3lNNOWJiU=
X-Gm-Gg: ASbGncusPesWAxPT3R7WDi4Uxw5QTt0UX5RhDB+/yCDkTfJTUl31qdZ3YPrxKs3lDE6
	rLhKNgKXZGESY0ag7L2UzhESaeBkpKzalu39qYBzL8WLGk8fR/FNJIw==
X-Google-Smtp-Source: AGHT+IFedJi/r6g/WOVcwY0eEDkh7I0fWMNx+kJXm5nEeZpEjYE7ZQq869WhveRcxnuZuig+YziN3KlVdL1758o6xGw=
X-Received: by 2002:a17:90b:278f:b0:2ee:cd83:8fe6 with SMTP id
 98e67ed59e1d1-2f13932900amr7428403a91.35.1734025187826; Thu, 12 Dec 2024
 09:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
 <Z1BJc/iK3ecPKTUx@eis> <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>
 <Z1FnPIuBiJFMRrLP@eis> <Z1gCmV3Z62HXjAtK@eis> <CAADnVQJyCiAdMODV3eVxk-m6C3xAR0mKCJYgYqUzcXypKcWwcQ@mail.gmail.com>
 <CAEf4Bza6i3nda+7XPcfmVEckwGfmvsvPmakf_VQhFHEWoVTh4A@mail.gmail.com> <Z1saqkRqbAc+bMWp@eis>
In-Reply-To: <Z1saqkRqbAc+bMWp@eis>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 09:39:35 -0800
Message-ID: <CAEf4BzZenQDea0yuGiOta8J=OGx_PVSZaOc31oSFMeLw8No-aw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:15=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On 24/12/10 10:18AM, Andrii Nakryiko wrote:
> > On Tue, Dec 10, 2024 at 7:57=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Dec 10, 2024 at 12:56=E2=80=AFAM Anton Protopopov <aspsk@isov=
alent.com> wrote:
> > > >
> > > > >
> > > > > This makes total sense to treat all BPF objects in fd_array the s=
ame
> > > > > way. With BTFs the problem is that, currently, a btf fd can end u=
p
> > > > > either in used_btfs or kfunc_btf_tab. I will take a look at how e=
asy
> > > > > it is to merge those two.
> > > >
> > > > So, currently during program load BTFs are parsed from file
> > > > descriptors and are stored in two places: env->used_btfs and
> > > > env->prog->aux->kfunc_btf_tab:
> > > >
> > > >   1) env->used_btfs populated only when a DW load with the
> > > >      (src_reg =3D=3D BPF_PSEUDO_BTF_ID) flag set is performed
> > > >
> > > >   2) kfunc_btf_tab is populated by __find_kfunc_desc_btf(),
> > > >      and the source is attr->fd_array[offset]. The kfunc_btf_tab is
> > > >      sorted by offset to allow faster search
> > > >
> > > > So, to merge them something like this might be done:
> > > >
> > > >   1) If fd_array_cnt !=3D 0, then on load create a [sorted by offse=
t]
> > > >      table "used_btfs", formatted similar to kfunc_btf_tab in (2)
> > > >      above.
> > > >
> > > >   2) On program load change (1) to add a btf to this new sorted
> > > >      used_btfs. As there is no corresponding offset, just use
> > > >      offset=3D-1 (not literally like this, as bsearch() wants uniqu=
e
> > > >      keys, so by offset=3D-1 an array of btfs, aka, old used_maps,
> > > >      should be stored)
> > > >
> > > > Looks like this, conceptually, doesn't change things too much: kfun=
cs
> > > > btfs will still be searchable in log(n) time, the "normal" btfs wil=
l
> > > > still be searched in used_btfs in linear time.
> > > >
> > > > (The other way is to just allow kfunc btfs to be loaded from fd_arr=
ay
> > > > if fd_array_cnt !=3D 0, as it is done now, but as you've mentioned
> > > > before, you had other use cases in mind, so this won't work.)
> > >
> > > This is getting a bit too complex.
> > > I think Andrii is asking to keep BTFs if they are in fd_array.
> > > No need to combine kfunc_btf_tab and used_btfs.
> > > I think adding BTFs from fd_array to prog->aux->used_btfs
> > > should do it.
> >
> > Exactly, no need to do major changes, let's just add those BTFs into
> > used_btfs, that's all.
>
> Added. However, I have a question here: how to add proper selftests? The =
btfs
> listed in env->used_btfs are later copied to prog->aux->used_btfs, and ar=
e
> never actually exposed to user-space in any way. So, one test I can think=
 of is
>
>   * passing a btf fd in fd_array on prog load
>   * closing this btf fd and checking that id exists before closing the pr=
ogram
>     (requires to wait until rcu sync to be sure that the btf wasn't destr=
oyed,
>     but still is refcounted)
>
> Is this enough?

Yeah, I think so, something minimal and simple should do, thanks.

>
> (I assume exposing used_btfs to user-space is also out of scope of this p=
atch
> set, right?)

right

