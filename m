Return-Path: <bpf+bounces-19971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234FC835440
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 03:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3B31C20DCE
	for <lists+bpf@lfdr.de>; Sun, 21 Jan 2024 02:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C3360BA;
	Sun, 21 Jan 2024 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkfBPkTj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50A2AE8F
	for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705805608; cv=none; b=Bh0wKQIVMGoA+QG8eocScGyf5SBph0CSezVlxkZmW1/M6w2p9JDMw2LR0Cl+FB10Qcfw5SCXzE055bJuHN2J4B6OOKKNLTSiBqPw4wA2Fzn6SfRbRXx51KKgbjE9+uyXg9/2fVhnnKxH0DK6U4R5s/BG/UOREZ+CCTOWr5HJMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705805608; c=relaxed/simple;
	bh=A3jGjl3gvqqavcG/Qq8yQyo6Htazykr/gabeOpAiTc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJq0RSzGZrTOfuGiWgbvmOIm5TxiXzLwiddBix6XzvDIiLnqb55kP2vQv42c9zxBVci49w33SwEQ5lTypznPt4cnd8uA6PwTR1mrHWZSA80zCdmVbwxWY8FrY7M0qs55QjZQPeVTLz4zNjaPxf+Pi8svsjirJ5KriIRr3EaN+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkfBPkTj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-680a13af19bso13362946d6.0
        for <bpf@vger.kernel.org>; Sat, 20 Jan 2024 18:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705805606; x=1706410406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvyh1Ui1s1uUA8CalC0joqOFQUQDYzK0JllX2IRX3sI=;
        b=BkfBPkTj1CgGX+6YwHfEP7b4KLzdrJdwZq+iqKAwLjKb+prZaOvaudN1tLw9Kg6O/A
         Hg+XRVcIfyzPLFKDYR2m9ZxEDf1zW/bF7Vzk4G3fs2BpSPEF3XLSLZW3vCRa/nj3HpYb
         nNGVYzf9RnFLFEcRzDk4U4b0XJFH8mRHOsUPwZvwUEyNy9bFR0Si19aLl+0BqJ5m10WN
         J5p/LjMaPChPLHolUqp2gSvFOGMfkcswbOUvqDWRBGAVfc/crK34tYWDGttsDvNdhRSP
         FoZ/Muk0AP8k62XX4Nv0chP0iUE/4j0Cc4C/RFX5EIZ8GnZq35tWHdlUzofE7CDnwenc
         lqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705805606; x=1706410406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvyh1Ui1s1uUA8CalC0joqOFQUQDYzK0JllX2IRX3sI=;
        b=dwcJMo5IlV+Fn2Cln5xF2/JAXUAHVkD71DVcyh+VUviNGp28S1KGoVLTskHbXe3/gP
         BnsuCtRC3fQKuWQK/XSFNidv28YHd464F7Bsw/htGfyvwVxSDpBUwWHm0uhEiCrIyKxD
         WHzJnt0oDqBFaPoWmb4CNRzBTGvDr/tY0WDsv2SWa+B+3U66Xuo4wTA/jrhfk3jmUB0Y
         uSzxzZfy2fXT4f7RIrfJEvcA6DBM/i3p+OW1k/q262B8ZKdH6d3c4VQjChPFKlqPd72H
         MJwLLIt+0CiNdEoBvOb1HzIHbsh+jWnD94GF40N05LlxkkKQadcQa5bxLHo4wMoooBVF
         knKA==
X-Gm-Message-State: AOJu0YxNFtizELGRQwqI7Yty3YHjNBwnKRqsndis7myyWPqEI1WR93BH
	hBWAzf5BKRCi4n2LtWxs84vvUTU0QUYzhHeWV0zVF3DZV1asaisBCZz5KR78CryqzuT8kW1QOb6
	udnpOrNIA5oC+swarZgReVgxFtBk=
X-Google-Smtp-Source: AGHT+IFL0CeJfioodOlhN34zLbX5cMWYULK9huN4rKJ003Xe/8OSiLSm/CfiE3rOjd/7ygeaFlzR9fGyDcQb9GiGro8=
X-Received: by 2002:a05:6214:f2e:b0:681:88ea:3699 with SMTP id
 iw14-20020a0562140f2e00b0068188ea3699mr3152300qvb.90.1705805606084; Sat, 20
 Jan 2024 18:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110505.400573-1-jolsa@kernel.org> <20240119110505.400573-2-jolsa@kernel.org>
 <CAPhsuW7gFMtyWPGpWFORX6pNXLUqYSj2Srv1pVtgKoNS7g3=rQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7gFMtyWPGpWFORX6pNXLUqYSj2Srv1pVtgKoNS7g3=rQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 21 Jan 2024 10:52:48 +0800
Message-ID: <CALOAHbAn52VudYSyb=6bHPboq04i7z1Bwqy++k8fCuktKBgcKQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/8] bpf: Add cookie to perf_event
 bpf_link_info records
To: Song Liu <song@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 7:25=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Fri, Jan 19, 2024 at 3:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > At the moment we don't store cookie for perf_event probes,
> > while we do that for the rest of the probes.
> >
> > Adding cookie fields to struct bpf_link_info perf event
> > probe records:
> >
> >   perf_event.uprobe
> >   perf_event.kprobe
> >   perf_event.tracepoint
> >   perf_event.perf_event
> >
> > And the code to store that in bpf_link_info struct.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>
> Acked-by: Song Liu <song@kernel.org>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

--=20
Regards
Yafang

