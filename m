Return-Path: <bpf+bounces-53781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17449A5B6C3
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 03:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D0516FF88
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 02:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DCC1E5B65;
	Tue, 11 Mar 2025 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCpAQrjL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63C1DE2DF;
	Tue, 11 Mar 2025 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660443; cv=none; b=N1Plu0l5E/JOJshDI28NiIODTdhM+5l1qaZBdUGGnhCvo/xtjPtbi/C6bbgxA5IcOwJGsNgaJvYcSN5/S1x8jWi0RQE+9HDPLWza6ewq0bA+r3z2BtROyuLxfYGXtn+ZksOlr57V4oY20xPC4+sRKq3blAswjJXXusSGE3RE19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660443; c=relaxed/simple;
	bh=TmIPsk6bPeZCS0s/G7g2/2kYKZgP1sUU3hG2xmySBQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZjOIDsAATvfL7mTbH2+gZq4XTY4PC84sdlCXRp7NBwqpfB6T6yY16BJQegwOxNN2ojmaUutGUoqsr5JsBBHuF6IlmzGI4llEcpByMd3YOgo5xQobFcspwJqxm1SZZG69i1J4X4UoINY7uwPxwapZA5Xw+9OWF6f4RpS5qSMbgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCpAQrjL; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fee50bfea5so17842097b3.1;
        Mon, 10 Mar 2025 19:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741660440; x=1742265240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4oJ/tKrAlrBp4dD3JSa7Bs/QnnIDGEa5sGZOSTRMHuU=;
        b=TCpAQrjLb9nANlPV5yKM+K1ryTiXkrqfh23L4AR2SQSFgjMyCAVfmOQ6lLDzPX4/dz
         0teBrKZp0fva/cfW60XFKvJhYgsHOzoqFjZ8YX7yLXuF0vLvjB1kcIIcWdTZtjwSr553
         GF51JO5WeUi+mWw+fBWkwbq1AAnSo3FSQKTrpIxFfpSbUFupQJ7MVrsnuA3KSIMnenTo
         3O16ZVPrxErkwcx14LWe4XQKRgOS/3gmu4wiuHlID8KlbmSMKqWoNIteOpL906hhWW0b
         1gmVISbrb2w50mCb0qH5+yGd/B5fI843i8VNLOwMZaoi23Gn6z4nPmgbtY2/xRqnrofu
         okyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741660440; x=1742265240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oJ/tKrAlrBp4dD3JSa7Bs/QnnIDGEa5sGZOSTRMHuU=;
        b=CVjHVkpDAwiErgTfLUKZTGQOmcHTW5TWNUa2kNcYmja71wkv52uKOCJE5Hza6sGV+X
         8jGhugZ6/UtjxKQkdNQum07x0EnmqSRIbl3Fo/94LfMd0uJ0/rzFRKuvZOmSxoTQqXjx
         AbUM6tRn1QBmY90uYZt1aqB0pnMvMqI5y9VT/EYmT5mpa/CZiR7hPzJbxrO8Tsg8+V9B
         WTtIaUDDMWT+qi1WnEQH9y6BVxINWNBd2qBOtkQSppuwK5visHpU8rNSuxDJSbJ9RN7y
         H+PT8aXs/X3nIrTlm9U/x2IpAru7gc3K3kAp8MHUU0fweDxSrAqMQjNgtNxtbKT/5izB
         ecQA==
X-Forwarded-Encrypted: i=1; AJvYcCWxtz1NnfJDYWdu3uqG28m5c3EdlX5VNsUG5Qeve/LaQjIGskb7S/60zeMps8tG7NOob5EZvdNR8r4lXe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDqgW5NL9pwrMbRZ//9mtmMwSrIKK0Eo9cKNa6WrRIE/uMjCc
	Xhz1ySZKcxZhX68FW+Y1usEJYPMELeplYwlsNgdfSO4+2FkgLMU/YreKrGs7pfBiYxtgAXZhZMy
	hmkDb5yeA1jZEyLhNYpjUs6b2bko=
X-Gm-Gg: ASbGncuB2WLE2K8zkGONOK95sONf99N5wup93CWdIEzWnF6TupPg3r3HAej0F3xRbdE
	XBS1kQ/gGC5k++0vDdU97Nrtu7zRTJXzeiwM+mTftd2CJguoOXsMUR71LFTDqdw05rDZ/fp8/A6
	dvfApEPml97GKM3CenIz65a7diHCGE
X-Google-Smtp-Source: AGHT+IFtcH/UMic39r9LtCzFkULnHharfTzPxrNTQjL/CGrVsyy0wHQ/rhkuSuqBupOYfnJIzHzmOi8YgSTo+QS9Hhg=
X-Received: by 2002:a05:690c:6d05:b0:6ea:5da9:34cc with SMTP id
 00721157ae682-6febf2a7111mr213945607b3.7.1741660440415; Mon, 10 Mar 2025
 19:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310052555.53483-1-swnam0729@gmail.com> <40064e3d-e8c6-42ee-80e9-a87f4140ecc0@kernel.org>
In-Reply-To: <40064e3d-e8c6-42ee-80e9-a87f4140ecc0@kernel.org>
From: =?UTF-8?B?64Ko7IS47JuQ?= <swnam0729@gmail.com>
Date: Tue, 11 Mar 2025 11:33:49 +0900
X-Gm-Features: AQ5f1JoGjCwLLi5OcDLLj0x5XpTkFSQIjIjO7lwYSl2qNEyV2mu0EBYx12jBzsw
Message-ID: <CAKUNZ7F-UofMmbD6VtwSiu2ho1-fQ1yFxnfC57-oN5L9ksi+sg@mail.gmail.com>
Subject: Re: [PATCH] bpf: bpftool: Setting error code in do_loader()
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ngomhla ka-Mso, Mas 10, 2025 ngo-22:28 Quentin Monnet <qmo@kernel.org> wabhala:
>
> 2025-03-10 14:25 UTC+0900 ~ nswon <swnam0729@gmail.com>
> > missing error code in do_loader()
> > bpf_object__open_file() failed, but return 0
> > This means the command's exit status code was successful, so make sure to return the correct error code.
> >
> > Link: https://lore.kernel.org/bpf/d3b5b4b4-19bb-4619-b4dd-86c958c4a367@stanley.mountain/t/#u
> > Closes: https://github.com/libbpf/bpftool/issues/156
> > Signed-off-by: nswon <swnam0729@gmail.com>
>
>
> Thanks for this!
>
> Others may correct me if I'm wrong, but I think you should sign off with
> your full name here (although it doesn't strictly have to be a full
> name, the patch submission docs mention in should be a "known identity"
> so I'm not sure whether a GitHub handle, for example, is acceptable).
>
>
> > ---
> >  tools/bpf/bpftool/prog.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index e71be67f1d86..641802e308f4 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -1928,6 +1928,7 @@ static int do_loader(int argc, char **argv)
> >
> >       obj = bpf_object__open_file(file, &open_opts);
> >       if (!obj) {
> > +             err = libbpf_get_error(obj);
>
>
> This is the correct way to retrieve the error code, but given that
> bpftool does nothing with this error code, could we instead simply
> return -1 to remain consistent with the other locations where we call
> bpf_object__open_file() in the tool, please?
>
> Thanks,
> Quentin


Thanks for the review!
I'll submit a v2 patch soon with the signature renamed :)

