Return-Path: <bpf+bounces-60515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D503AD7B5A
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF353B43AA
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866512D4B54;
	Thu, 12 Jun 2025 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pf5wsos"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBA20B80E
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757543; cv=none; b=ERoaRAVheJXPO5xjSQ9ebA+NmsDjz7ep0gdfGSPWGqBUFnzvRNznffb5+Knp4tiSOUdyqV8QwBIX6g6uwPE8i/jL/LErRdtCYobuNZ6XNeut9PYBhqxcA22ik11jQPYHVGRcj1eznQQ0C8aZORXxDqxUn0FM9uRl1BupqAjN/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757543; c=relaxed/simple;
	bh=wAHT/AcGoo7CgSVNGycSSTiAzwBxGuFr8k/W7cFpxZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEJDVadtwNergCXsq4XMw7QovWnaIZjbQgj9t85x0I5shedC9rEjii+n60L0pw1uHpCGHBGFxFsN0daoEvzpaF/KpPDtjZY483vd/voolQo8QUMGJua3mlwWPJC4xUJjJTsgoqE0rel28/yd2MqQRhJlZUVeruBNIHcpw3zCkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pf5wsos; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87f0efa51c0so5415241.1
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749757540; x=1750362340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAHT/AcGoo7CgSVNGycSSTiAzwBxGuFr8k/W7cFpxZg=;
        b=0pf5wsosyBPl2BBljKQ8kpYHzFCpD1oRZTYKZm5VYl223v6wcYYolhN4VWv9lM5feT
         nbspVy39p0SZB7/yk+M2QLNK+1YaXXprrxo2bobOY/GVd9utaPv9D4RaEt6k72VwpzJi
         3atJzkf8XnD0pG9A+g/sHT84ZKMIS9qWxDIQ4AAo8kctBmuzmBQqK18GrwsV6EUUSk1J
         hjedVcvHmZtVEI8a9O6cV/aH2rcQYQ82CFL8w0ExEDYUHjgWL1I36ARy50Rs2PDJoKVs
         xiAsOi5IcRDmZTM5vgrNIBCbks+s6bEGJC+26kA6VZihxRR7GI9flQR7jMcsFnw11+4c
         sI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757540; x=1750362340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAHT/AcGoo7CgSVNGycSSTiAzwBxGuFr8k/W7cFpxZg=;
        b=ljpZzdNgEbBuZl3I1bn+Pt+Zo8uXT7QOKJsTHDIDcpJID6f8PYY/6BcoKIoIwsNPa2
         jIQyd6V/ao2bUoUmgFydfrNswu6PR1k2eq4br72vBsds104pF76LWmj5jMukinDghm/3
         HsC8g/bYWsZdWYk65nkslX0HgI5sVXxDLZwbdhZNUZl+ca48HNiBUtMWyUnBqms1QVHF
         h4+vyaDcW928UG+iZakC9fVcBt9dMhTF7nhih3Z8NqNlWrAUOZq0/F1aSdp++QrgFLn0
         DJxAhpZkWpKeOpITDF2YFZ/3dUXFpmY/CJkXxNMpyA7+2x4lu1/tedD/F3WgIl/89C7R
         JqhA==
X-Forwarded-Encrypted: i=1; AJvYcCUbirb15vfeaWG9mR5lrqjOmgPwFBbFZGNgYZZwIw9nsQyUt3Z23a64XYPkwNq5Ku81IlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJkhQm/Ue1ajgd+GMnjH/WqgZC74oDmT8s3bbJqH9nDVeI1gm
	sgbbel+V+pUR7WVvr7oTc4C0kbh52fRkqcOWR/rPzjDJsDgPv0lilQJ3IJN7mpwd4v2dje7OtLM
	ZmygNtO5hJUS5wUr7LYHLqkxuo6yna/haGwg+yREU
X-Gm-Gg: ASbGncueEFZX5Eyu/iy7L6mqZA3nQf9xMkUdADCBF9FfUWSap4DG+a2MDBbDDdGTM95
	fBNvmVzU63n8sQaG2qGqwSqZA/LZuQupfqr2rNxdygbzE5huijCE/TQdGrVMhCv85szSZvwwTSk
	hcUtzpn/agFIG3YEFNQV17eYjSN2NG+XoRBT3rZZRuCTrQMOBxWBX8UR7C7EzXHbvs3XNKvHMZ3
	g==
X-Google-Smtp-Source: AGHT+IEHRxuSJmDekfPevaGg0P88Kg+HTSpjX9dFsg+2vHWBTNzZj+7ncBqz8KjOFQMFJc5ImCgn4Jea+W2cpnvby9I=
X-Received: by 2002:a05:6102:2d03:b0:4e2:bacd:9f02 with SMTP id
 ada2fe7eead31-4e7e39d7d05mr164846137.16.1749757539524; Thu, 12 Jun 2025
 12:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com>
 <aEnLBgCTuuZjeakP@google.com> <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
 <CAP-5=fW1FhaDcG54OS=_65gxmehjDTR+1XqCPWMX-aw9reJHdA@mail.gmail.com>
In-Reply-To: <CAP-5=fW1FhaDcG54OS=_65gxmehjDTR+1XqCPWMX-aw9reJHdA@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Thu, 12 Jun 2025 12:45:28 -0700
X-Gm-Features: AX0GCFuJaWBm0sxoTLHcXuh_yk_mpToTV13cQIpxmu5iRZXykkCsMy-NMMDTMLg
Message-ID: <CAP_z_Ch+d1FA5Yp65aegn7-vcLhZY8rspSXbDsxCA7yTLufNew@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf: generate events for BPF metadata
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
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

On Wed, Jun 11, 2025 at 10:19=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> Fwiw, binutils is GPLv3 and license incompatible with perf which is
> largely GPLv2. This patch series deletes the code in perf using it and
> migrates the BPF disassembly to using capstone or libLLVM:
> https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/
> The series isn't merged into upstream Linux but is in:
> https://github.com/googleprodkernel/linux-perf

Good to know. I'd be a bit concerned about the validity of testing my
changes with a 19-patch unmerged changeset, so I don't think I'm going
to try that for now.

Perhaps I'll just send along v4 of my changes, which has the fixes and
testing mentioned upthread.

Blake

