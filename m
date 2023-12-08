Return-Path: <bpf+bounces-17093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92C6809A00
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E667282230
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7301FDB;
	Fri,  8 Dec 2023 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQkJDaz3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FAC10CA
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 19:01:52 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso73141066b.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 19:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702004511; x=1702609311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyMc0DNWF9syMc4oSeatHD/owFFzBDM1cIo2EvtQ9so=;
        b=dQkJDaz3BRbpa+5XzX1P0FolGcbV/qUjH9fngJinW9javFA4pg2O4LHa+GsNmgZjZl
         yNhkW7ops4GdHwYFXEHT777CqtCGMyf9wbMrwHLGQL6RhzVpj9NrEbaVTGiwyXJpLslL
         d3SUFZEzdXVIm63xAvXkOE2goE4yeYE2VDLLPdkRakkQzbl0+qMG/O9h5IwimG32fIYr
         zSlYL5+CGRou60zVHf2jskwN09lPSaCd/+pbucEfNV+RjUM7GEtxryuaWNh2WLscEmQu
         MLGZ19AUJ0ewQQWenW0HH0ROqhzj7wF6gxWRRXV0iibMCpmweoffHWPSLXiRUuPmIGbp
         i60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702004511; x=1702609311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyMc0DNWF9syMc4oSeatHD/owFFzBDM1cIo2EvtQ9so=;
        b=kLx5neoaMn7xUp3uoYcT85aUo+wwvyDRMsrbMC0z0Z2rlJNvhJVe7M/mHOq49E2CFS
         madg4986jF5cSb3z4Ww1FTJaeqsc7sFjNrXCbo6Y0cxA1khsk6eov3krESPEkHrtXvQv
         2UeH07hetjHjIFFSqUX1jMEsniIG+OxBWi4rmLpUNbpTX1X1s1UWzu72kie9aw6j0M+h
         VeGyBXUzRRLnbyT6daSF4iOAg1ydl4E9SNzCWOxhPVKCzZJUAIpueQ/mHsnlgk+Zr6sZ
         fWzWTdB/bnoRI+4lsrbctx6jRdUsdHq/S6y7DR6piha5Pj17fx/RSJCGSoSB1v/lRThE
         ht4g==
X-Gm-Message-State: AOJu0Yyoe+mTWwdkYBVgl/9YGxtCRbjy4FyUJKXtUTl/FH1EhxfLDHaP
	CKXR1mVF4YL4ur4JmXyuVHIwtnvrmGpPWHEdt463Xyk0BAM=
X-Google-Smtp-Source: AGHT+IHrTQngWNMnfRN1yWHjZX0NiF90NaTUdYJlFLRCMOezCrhvYg0QKKyAbRCaRMcuxyCrwAnIfIQMk3rnGE6zxqA=
X-Received: by 2002:a17:906:2245:b0:a18:3001:c4ac with SMTP id
 5-20020a170906224500b00a183001c4acmr260991ejr.18.1702004511271; Thu, 07 Dec
 2023 19:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208023150.254207-1-andreimatei1@gmail.com>
 <CABWLsev1q+ves60giYt7rFU--yfhCjgchyoduttgZa8mjynEeQ@mail.gmail.com> <CAADnVQJ7TAwfOpPpk_GeN9OuN1j49+YwLKK=pXWbfAWykJnN8w@mail.gmail.com>
In-Reply-To: <CAADnVQJ7TAwfOpPpk_GeN9OuN1j49+YwLKK=pXWbfAWykJnN8w@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Thu, 7 Dec 2023 22:01:40 -0500
Message-ID: <CABWLsetNNfy0yefKwXUkb02BkP26r5rFijr2h8WYQ0B=oFFORw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 0/3] bpf: fix accesses to uninit stack slots
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Hao Sun <sunhao.th@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eddy Z <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 9:50=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 7, 2023 at 6:45=E2=80=AFPM Andrei Matei <andreimatei1@gmail.c=
om> wrote:
> >
> > [...]
> >
> > Some decorum questions from a newbie:
> >
> > I'm not sure if this should go to bpf or bpf-next (or perhaps if only t=
he 2nd
> > patch here should go to bpf and the rest to bpf-next). If anyone has op=
inions,
>
> bpf-next please. The changes are too tricky to expose the world immediate=
ly.

Ack. Resending.

