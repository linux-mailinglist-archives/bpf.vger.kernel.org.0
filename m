Return-Path: <bpf+bounces-59954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0143BAD09B6
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3AC1718C4
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98782239090;
	Fri,  6 Jun 2025 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ye/ySsnl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9AC2356BD
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246729; cv=none; b=XSO1adsA0a8z6Nn2gdn+fiX8uN9gAYExMsLCcgHtXOr2cHN/3aHzP1sjgmAf03Z6seXMxr4DZb8tFHgRm1fqP1gDhNzYUUDolE0Y+bl2GyC0ZuYTdMZKywqeOKA3vWNJb69rPbkG9qbRovgthD0S5wFUctmC98GfzPPXiTTcO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246729; c=relaxed/simple;
	bh=wNRLXwP2AOV1TrHHUqrNrX9EWxb3G26pRZWwMmUbQTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chVD92E2JQf8hfdr7gFiSKeqNYKhg+U5vgKEu1Lf7Kh/EcIpSPJl4D+GKlK2zGBFWYnrjnuVqJ5OdJuhQagKVLuPehyY8NJM0RkaRH0ffxTyJTakZXL3DHdkHgrshDTk2EqMI8aCpW2jzM5k6FKXXAbNcWsB/4RYi2YA1OUWg5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ye/ySsnl; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-530e4ba1032so411290e0c.3
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749246726; x=1749851526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyOaDhp2PexLIt5LY+LfBmOnozOIIhJOKbnZ0qemSwI=;
        b=Ye/ySsnl/Lp/EhoNzozti9Gb0z0+0TUWjTfrl9uwm+W1PYZv3oGquJ2TehMWBpMhuw
         tY/JHmWD7XuiUQ43ww/FPniq1ijyZUEQBM2ugWr5qQnzhNfcDx8OKo0kbc9NJMNfTRE4
         lnv82DpYgfh1jBus4ysdV1KyruIdz/J1/zd67DmWkyZExHGN5AYRlAyXlzffMfm4wSxl
         qYHR+h0iOZvu+bolqm1oAP/ZOL52Pk9XIYm57i8jiSxglFfmAvzz1eJGZS+l1e5mtOjH
         EULDLgPmjmkFg6Rwksnvsi+y45mV0R3s1oEC9Ec5eCoUN7oEDcOfFbc79WtggJ7lPRSH
         IiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246726; x=1749851526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyOaDhp2PexLIt5LY+LfBmOnozOIIhJOKbnZ0qemSwI=;
        b=A6Ef7E2WbmmNVulCyLmHYMsfqv7ikN1xLYYYn5srwMQBynawVtGuiEqUGcCC1xqf+i
         rjK2x/CEiUQn9Zbip+m3BHzD3AQoutCVOYyM7DjILkbBPHlTr5ulaI6BKxmVAVYBag/S
         Ay/lFbl0OPIMGAqRTcmcF7LyhgeEAOJlopMF3G6Q2VcMLUyByjVDIoROQXpOovFX+Qcu
         pm8ZL+xs4V+F1bDV0X2LVXgkFmctUMfURlC7j1tFpGEr1ipYmyiKu7B1UzmiY2Q2D+h/
         BupLgf8+Rm2gQnlalM+NP8XT6Bm1NrWP4oLoxXO95omjtq2ad5NEDyU9dTgMALIrMJMH
         r71Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXtuXKXX66LM8cxd7Id1fFVnWvzL6SoziQjzoqnpMJNM4Yt/VGI8R1YK84EzdJuL8f80I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRGaZGcccCISPJUbsJ+fbnekuwD0lsYV9b/zpAlAkV+fKBJL2
	ormf+3RouF9G93IuuOzUj5uzbAAhPvtRf7Bv1D/7UPcEg2F6L8oD5VGKIR0f4pEKuu8omQw57WR
	r14Cg57xilVC1i6qhB36cKGoP2OF9NWiCKq3wa1QP
X-Gm-Gg: ASbGncvbqIgUKuRfjaDlrAV2chcPHUoZGfXf51ey4MeqgsClv3XerQ8mjTVLgc0FUK5
	ZFIfMmjfendRsP9B4miecG6XcZuEVWV7Pklf1aVVSX4ZyK+Ol8pIx17cNAJOm+GB+QkIa2TQkL6
	C9nqs8SBP/OCAbC8qy872du/V3Y9EIgLBhRt59Ol+QPGI=
X-Google-Smtp-Source: AGHT+IHVHFaA1ry8YDiIbyMGIfrve8HMzCRf6dRbsB1VOlu9MTykpwHA6tI71aPDkraqSY7CjR0ozhtFiZHyJm38vDY=
X-Received: by 2002:a05:6122:1d41:b0:526:720:704 with SMTP id
 71dfb90a1353d-530e487a257mr5820895e0c.7.1749246726354; Fri, 06 Jun 2025
 14:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-4-blakejones@google.com> <aEM7SeSC7yup7TJ7@google.com>
In-Reply-To: <aEM7SeSC7yup7TJ7@google.com>
From: Blake Jones <blakejones@google.com>
Date: Fri, 6 Jun 2025 14:51:55 -0700
X-Gm-Features: AX0GCFvT1RS7Fs_le6fa-v64xZAYCDvDqqmAEUDabdNRCY24PDqfLenkWkzvCCA
Message-ID: <CAP_z_CiJrs5qsM557TgNrcFu2yyML6uMKfU0mDJ8Z=AKs_Kpaw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf: collect BPF metadata from new programs, and
 display the new event
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Fri, Jun 6, 2025 at 12:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> Can you please split the final synthesis and the processing/display
> parts?  I prefer commits doing one at a time.

Sorry about that - when I was doing development these two parts seemed
inextricably tied up, but when I went back over them just now they were
easy to separate. v3 will have these split out.

Blake

