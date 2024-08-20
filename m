Return-Path: <bpf+bounces-37588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD9957E12
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 08:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD4F1F23FB8
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 06:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE316C437;
	Tue, 20 Aug 2024 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhqh66yi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537616B723;
	Tue, 20 Aug 2024 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135350; cv=none; b=a9uTfhUmCeXKEArSdhfwp5QU2lvT/c5zlXKjVfzTW17SFWQ6Q5DEHWrPedcyW/rU+jIGVqJggXwi7AbO0vuz28W5Rs4Osmg5E4hRd6s/UE0ZUApO+YXsHxw1MwlxbLW/iX7EGrDD25pGvsIt/GCK3JRzQV59IQBo+ehSlue/5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135350; c=relaxed/simple;
	bh=eLyrIc97QmcbwfFEFhrA5x+ma1e+MhYGAl+qld8e6RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED4GTBO1LPBv5mNWD7G56/67VN4MHJHMV3za/VtETofMPrTEZRoLmlliXEeJwwiqk9wPDz7OM+IjDUhmEfFxTOHO9AVDwORXxa52sBJNU3WbiQtetEi/dEPBNhBgyMcFJ6zqnJclEFeUB0QeTUlwu1TzANNneMP3T8v71AF9qvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhqh66yi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ab97465c8so1648555e9.1;
        Mon, 19 Aug 2024 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724135347; x=1724740147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLyrIc97QmcbwfFEFhrA5x+ma1e+MhYGAl+qld8e6RE=;
        b=bhqh66yidpmjKATVOhpzOeUkANKaxxXndtR52vHApwWOIwmRS1a0UkL2PyjR1yxd1x
         MHoLAzcmbuxaDDCLmPyH3jBtfCMq162/hdr7YryWLWt36nxaW2C7IODVY9blDi+v722O
         W77vu8Fs22RTcdas1V3Qxgvy5M5CDVqzOOMjMDnowQ52d9AQwYGrNzyqat7Nqe1nu1xr
         jEj2sbpq4JY3c3tOdbr45FXitVoj4VfsXo1LTn1GcdP4FjvxkIr/RKyj1w3OWVZ+e/FB
         jfNHHKsNbyyAThDYX8UcGKSDwgtd5Ydphi6xL4COjxu6xaGEOEyOQGIdVhe6uwZMxMzS
         3MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724135347; x=1724740147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLyrIc97QmcbwfFEFhrA5x+ma1e+MhYGAl+qld8e6RE=;
        b=ESbdbV1uYqK8NjDGpAvltd243hzT9A8oXQJ2NVM+ZukUxGWiLuR982JiGrMFDWYt1K
         mJhC3BDqDMhShvL5zgBHC1Ecb2kM3e67PTkFzLWMRHf/zZEQvODH2QyufZ4A5fCDY1vt
         A/SLtXbko+mgop6g7wnlqPSIJYqLtrTQ9H/QE8v8J5s9eY2/GV6ZaNDEX8Z9zo3CKBwl
         spGEvSi4rVZV+mEn/8mmh5w580zq5v4qpZ5X9uDJUEYwI08yP7D2sLNCAiANJMnTYVbU
         0dprFOP37eTbd2Ehk0vpIQTqLAo483kJtpAjhN/CsHFyWJA1quCiunnSNi2Z9rZSIdpx
         h+sg==
X-Forwarded-Encrypted: i=1; AJvYcCVw2GsSdkgHFN5ed2V6ezMXZewJkwEKX5Gw6ydHNm0urLgr/mT+FtXINgkAGBJayS0GjSE=@vger.kernel.org, AJvYcCWz00v2DRq6tU0KHXl8H/LGCGTlwBmzp4fKY1M3CnMkwDNJyhGacEQoehai22RJZtN3mope/oQsYiC9osQc@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVnKm0wlB2yyPdgIllQ22pVhIqTqmdfausnkgpffYXd87nI9V
	GtgaaUOhiBcaAsnrVbuJ1RgDRuoCdldfAtpc4ZYpD/WzGPsxYFPn/2LHvBC4VeEOXXcW+i98weN
	2d/JfHvVBHz6bu9NZFFqVUvoLa30=
X-Google-Smtp-Source: AGHT+IFzgts25KwBHlGyIeYuxcnWmEL8U7uxJ5xWYMKH1HnAzKxHPn1BMQ6WtiEuBkf+pmlcE1b7J2EIiT/TqOghLds=
X-Received: by 2002:adf:b1c3:0:b0:371:941f:48f2 with SMTP id
 ffacd0b85a97d-37194651afbmr7368132f8f.32.1724135346873; Mon, 19 Aug 2024
 23:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58489794C158C438B04FD0E599802@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4Bzb3XbGx+N5yrYELNAkaABP9fyifAQhTP1VHSvVycG36TQ@mail.gmail.com>
 <AM6PR03MB584807BFB29105F1D7FDC89E99812@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQKvt2uUsvFbYnEmApj9ZzeL0on1zM4zKBJEFmzuoTtzhg@mail.gmail.com> <CAEf4BzYWLFUtTx2obdBunaJ2qUdX+Nvv5w=VAwBTutxvYvR0PA@mail.gmail.com>
In-Reply-To: <CAEf4BzYWLFUtTx2obdBunaJ2qUdX+Nvv5w=VAwBTutxvYvR0PA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Aug 2024 08:28:54 +0200
Message-ID: <CAADnVQ+=nGLgj=HOiquvzKJv3WZ320HPduNms8OujZtv65fV4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Make the pointer returned by iter next
 method valid
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > >
> > > [0]:
> > > https://lore.kernel.org/bpf/CAP01T75na=3Dfz7EhrP4Aw0WZ33R7jTbZ4BcmY56=
S1xTWczxHXWw@mail.gmail.com/
> > >
> > > Maybe we can have more discussion?
> > >
> > > (This email has been CC Kumar)
> >
> > +1
> > pointer from iterator should always be trusted except
> > the case of KF_RCU_PROTECTED iterators.
> > Those iters clear iter itself outside of RCU CS,
> > so a pointer returned from iter_next should probably be
> > PTR_TO_BTF_ID | MEM_RCU | PTR_MAYBE_NULL.
> >
> > For all other iters it should be safe to return
> > PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL
> >
>
> Ok, but we at some point might need to return a non-RCU/non-trusted
> pointer, so I guess we'll have to add yet another flag to opt-out of
> "trustedness"?

If such case ever happens then yes, we'd need a new flag,
but I don't see it's happening

