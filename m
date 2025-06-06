Return-Path: <bpf+bounces-59955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D642FAD09B8
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFAE16FEAC
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A296239090;
	Fri,  6 Jun 2025 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rySf56j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4C20DD49
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246769; cv=none; b=G+Lu37t7Vx1XnwKfXb9Q16ssuEOLdxdE72YwlNzFjrAlq0lZUr5IQSQu8SoSRi2zj+G4UCTNWa6jwI+bdg+3R/QGcuZ5+8LgAZGA9uDz9rgwjchcTQXIOOVi7pLmskWdGFprvG3H1L+EhL8n2DwW7juHzy9dTCxMB45qKrOOLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246769; c=relaxed/simple;
	bh=l//H4CXt+bskKG2N3+2XmPtVrEWbNc6XBDNRfmVrGOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/vz9YdgfbE57Hir3QOk1PaJ0SbRl0kBRyerZ+EyvK/L7OoRTHk5W2YQ/AzqoFBboFoFRoM2tF+o/OFi+Zh8tmh2u7nfDfXN8GUhLjr27qtD5EWn3ZV+2q7mThJCsXiRN5SF7nBZXCsP3QkBLblQ/jdemrn85VOyatXxKcQbH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rySf56j; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so772247241.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749246767; x=1749851567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l//H4CXt+bskKG2N3+2XmPtVrEWbNc6XBDNRfmVrGOo=;
        b=3rySf56jiQYRW/eEoDXBQY2gqmC1w5r9Lf4GHNijW2GdZUACg3cLyo2Li8WohKthwg
         dozXc1WONccDh4+KkHImqfosPINKyRUCzP+qOIw4gKhc4w0cnm7qjIwkRZ6efPl3H977
         pqNbxfE6uuh2lkStqZoG9A98A70DPdOmfSkBpPVuA2vJYPka6+R9pRS0XgaeZzIsaDUG
         ME5SNDB/YN2LS5/bkaBeOhl+MuVcfyrqrJNF5Nl8cZflDx4fWMwJ3CEUMxrfef2uz0Ce
         sMAB1RFmi4PUftR9RyEamzXAUkC/fpQoQUJZQ/dCIpy5k57IJvDRFDMbEL2MaqkczvZZ
         BMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246767; x=1749851567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l//H4CXt+bskKG2N3+2XmPtVrEWbNc6XBDNRfmVrGOo=;
        b=JP8rtSlrhomni6laT2qUTOndjELvXQ7sliSaIspTZO5ETSusIXp9YCbJp9rfNWf96D
         TNZmw1iKQYRI1YDHxXiG5HpPmkxglfGDHeOXOpnLgAaLbWVHVkwI5nOomx2kzU8jishy
         p4xXvRd+/oHQS5Ys6MqgRwE8dwwvl//MZE0RIHqwvVuWfDlsVFE16rbzAIICPjzF9o3y
         GHkdtd1e89wf9vcsStH0cQrVkYMRyeu5+XAR11C8ejxzDWjp/9xd8ARztnHOZs1NZTg7
         xUoPJ9D1CB1cTq7rc+50jq8pBa7UmxqLHIKJhuA3qydDEEUs1wlUSCCfHyncyIHcVTxL
         UNPw==
X-Forwarded-Encrypted: i=1; AJvYcCW5uEweUOWLFcpjDtMuTUV75lrYEQOvovGaKq+HPWoB+2AQDbHybD0DhDINC5eaKUK0DjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhT1yQCENxzQi+JyMayu4GDGp/9WQ4a+kCv+EoJ+iJGXyp4NgD
	OaXkRrqjFQZZtCgXbsL85gE7P1W/YPcvbEAaeKNXqJlKyp0Xim6zth0D8ItdrGYT2BorsWzEAAY
	XlXIgh1LyiPYhB690eVERRnxfid1A80Dx//83du2r
X-Gm-Gg: ASbGncv5RMAMv6T4/YM4N9HWRqIX9+HHzkAfgDkyTs6uO9V8K7rb2T1nGY7qLyEKaBW
	8AKriE+DrcrzAxg1CLzqanT4ipw6fSJ1XQgPUCWbhSqZOftxla6xAywf2r2N+u24I5pSHyDk31H
	dWJbTsW0qzL9+ZjE+uadJm0NopR05I+kZ5IhuaXTz7/EA=
X-Google-Smtp-Source: AGHT+IH/uUnR2u3HG85mG/PwMPK9b4y20VMsqQ6oo3Gz0Rox33uSS86jPNEYvvAu+MxbM01PnkSiGPg9CCug2O0pLuo=
X-Received: by 2002:a05:6102:458a:b0:4e5:93f5:e834 with SMTP id
 ada2fe7eead31-4e772ade074mr5976100137.24.1749246766424; Fri, 06 Jun 2025
 14:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-2-blakejones@google.com> <aEM71LulKhuEinN6@google.com>
In-Reply-To: <aEM71LulKhuEinN6@google.com>
From: Blake Jones <blakejones@google.com>
Date: Fri, 6 Jun 2025 14:52:35 -0700
X-Gm-Features: AX0GCFusIWvcqKPEJqwjiD87wt-amDm46BQj8HstpaaK8zau_M5bUw3G9ghSJsE
Message-ID: <CAP_z_CgXv1+XA2pLzx999SAXUedcAqZJTZESLmVFd0mCR3go2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf: detect support for libbpf's emit_strings option
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

On Fri, Jun 6, 2025 at 12:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> Please check out tmp.perf-tools-next branch which made some changes in
> the area.

Done - v3 is synced with that branch. I'll send that out now.

Blake

