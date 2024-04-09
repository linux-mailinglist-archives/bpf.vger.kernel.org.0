Return-Path: <bpf+bounces-26250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A428D89D1EE
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65EB1C22723
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 05:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B25657AE;
	Tue,  9 Apr 2024 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7NzfviO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED91138E;
	Tue,  9 Apr 2024 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712640744; cv=none; b=a8Hssl6lg1M12ipkMp1DqsLhd0kSRUdAs/MzNMIZNRV9hh40KwS1J26j5EIE+yie0qW+IDWqXgYMFgIfuFCI50Ov+tq8gF2j+yl5rGVMrILvqsAx04F0PJZi8LvmGsGO7s81t8vL5qUJYLQmlizRWTmRAZl63L9y7Cchobbngfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712640744; c=relaxed/simple;
	bh=9lZWekprgzyxrfgFM5K0oPFDxTJVjijkbbZ6B4fmnHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KARXVi8ICtWXvSRIztCctyv0+GGb+K2sG0qo57YuTpbVFQ/+iNCnLmlP4b6eUOPvrZyzokSoZRXYZdyA7MYYjp+mIk2x425TuMg7SAbHMkoUx+jaUXCSr3GVpNxJPtsAeBeLr/XZ6uyK6s303MK6Ky8piQWFUEAC777TLmGhClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7NzfviO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516ab4b3251so5772000e87.0;
        Mon, 08 Apr 2024 22:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712640741; x=1713245541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CGb/5Mee8Fak1uuYWFLZbIIgpz0svekZAVX6sH4tG4=;
        b=X7NzfviOUJ8lFJ8Lhhsw/SFRQStdg7aroFNGBbB1zyr0ze6zvhZ5REijfdxll4AUX2
         mEG+ef0tTkcYRX/JxBVmEQc39T4wNnzg4EpeaU7u/d8gcYI+x89U7vrkgbaizNpxxJ2y
         1Ng5hMaGKn+7kxdni0P5XYMOnXiGTw1dVSgP+9U8R8O1BLAhRWmxKigBcCBTudXWeTb1
         3h18iq2hsmLD01Tka4I2XAa13bOz3L6S2zmiRv2eV8a9uZywQdKEstkgLfoFK/N4wJrc
         +1Vddw3n8tSWXCOgrG1rBrT+W+qlLyP6ixRz7WlUE6xB9IBTviI+EEj3XazWK9o1NxPc
         tXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712640741; x=1713245541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CGb/5Mee8Fak1uuYWFLZbIIgpz0svekZAVX6sH4tG4=;
        b=Fz6lD/8eauLpZm11hOZB0PBQCY5unM9RJ7BQrTdUCBEcGFbtwTxtjySTpJ4ulvRvXM
         O+eJLEgFPfGBcZgPEv9OLZayFeJ+KuKKhre1hD/lGjhs8E55e4t/ug32itDQO0WMGHWh
         FhKYhXYakB8s7MXUl5dJrO5CoYcAr+wgmn+nWrAtsCoRKol2n3brH92fVRpC3mJhj7Z0
         2ZLNc9vsdgbdX091Ya3gkSddw5kaDx2owJieW2xleBg1BBjOO8XkzCiKk2R63ROg8Y5L
         Dw2JGapbpw+cusrW8JenSAVKYu12abAcm5hxI4X93CzQn+3MPQI/i9I3J6jmfHV8ON5O
         upgw==
X-Forwarded-Encrypted: i=1; AJvYcCXodEyWJSY7ugxtJncYZQ140fpIURauHhFSSzL+rs2132lAGY/ZB86sg1agVgar6HWlkMjo5T2KDLMKo2hFAoOQPS7rLda/ZxlB5g4a9xxcL0IG2Mkl7RRBfxydx9+EVFsS
X-Gm-Message-State: AOJu0Yxbe9oTTpEFGCN0CfteyVG6OuNXoFmTgvWvkLPW2rT+ZYYflVd4
	FHF2Ju/oNvt3Edq4tudBuj12gY67MTLSE8E78DtsaLjFp8pvGXU=
X-Google-Smtp-Source: AGHT+IESwnp6fyQVdc0UfqoknG/o5y9Albgpx0kzEFOO2bgYX0crR9IV1mKmZPx7JT2wOY1nCgvH8Q==
X-Received: by 2002:a05:6512:539:b0:515:8c97:ff47 with SMTP id o25-20020a056512053900b005158c97ff47mr7660491lfc.23.1712640740773;
        Mon, 08 Apr 2024 22:32:20 -0700 (PDT)
Received: from p183 ([46.53.248.67])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b0033e7603987dsm10594309wrq.12.2024.04.08.22.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 22:32:20 -0700 (PDT)
Date: Tue, 9 Apr 2024 08:32:17 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
	james.clark@arm.com, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Chenyuan Mi <cymi20@fudan.edu.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Colin Ian King <colin.i.king@gmail.com>,
	Changbin Du <changbin.du@huawei.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Georg =?utf-8?Q?M=C3=BCller?= <georgmueller@gmx.net>,
	Liam Howlett <liam.howlett@oracle.com>, bpf@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/8] perf tools: Fix test "perf probe of function from
 different CU"
Message-ID: <d0dc91b6-98ee-4ddd-b0a9-ba74e1b6c85f@p183>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>

On Mon, Apr 08, 2024 at 11:52:22AM +0530, Chaitanya S Prakash wrote:
> - Add str_has_suffix() and str_has_prefix() to tools/lib/string.c
> - Delete ends_with() and replace its usage with str_has_suffix()

> - Delete strstarts() from tools/include/linux/string.h and replace its
>   usage with str_has_prefix()

It should be the other way: starts_with is normal in userspace.
C++, Python, Java, C# all have it. JavaScript too!

