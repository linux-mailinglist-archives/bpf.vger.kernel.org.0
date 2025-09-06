Return-Path: <bpf+bounces-67662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49680B47075
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 16:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E93E17E7E8
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A721EFF93;
	Sat,  6 Sep 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdP/uN+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E4366;
	Sat,  6 Sep 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169362; cv=none; b=EUZ478icgDLcedt0vYQrA6molMXjXec+fahI3LnvRkNXq3kSStUX41BRW3Qq0AlB7aBUD+ikdGNElwImryreLFdI6A68GYw91SaDGJ0/zTZQ96g7feB0YsLDLDbTAuRTALwUf9B3Qk0KF0FgkFV3X8oGaWYVFyLm57Svcg+FWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169362; c=relaxed/simple;
	bh=abhzJbQ6qYX7uXiJ2gfTUsrxYVWh8CcV04vHvTkfWmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1e2ot4n6c6hf2lPEsQvu23yslh6hR0SoUr0us3L0mKSXUq/aN3o2R/fhYkO/wIDLj8NohCA2GD9aQ8p2vOS488BQTEc8CH6MMB5p6VsJnqo1m3BSiCJ7JZccRwXIi7DxFHcCR+vrMCB802hiMe4frq1uoTw4Nm2YRE3Om+3smQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdP/uN+w; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6071dbcf3fcso142102d50.0;
        Sat, 06 Sep 2025 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757169360; x=1757774160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Egkm1U5iXlvfaFNf/qCSah5l26lLoj1n/U9N9etCIiM=;
        b=DdP/uN+wnoO4J2yXxh6TSlWhjLt8i9Km6ubQOlu01bBRPdvhkZ1domX5YYkoDkm5Ph
         CPumCtj9i+P9tSiztT2qW/fwzm7x7oLXnerAz6Ntli+RVN7aBaYRUZTrcGi/8ryBPyEZ
         NxzLU3rqBE42QAAcxYO0mV1NpvCKbJ4C0c6dsAJ+XTRZicnV5eT+dZ3T9oq2ETPOJCOx
         kblWv0Fh70vutv7fVcbIz7er4kPO+FaphsLG5nnWfzr36guEBzqUD9tKeSifBJ9bqtoS
         WLM+TLdXSyh4eBB7ytj5GVxqigNF4qjEExJiXdZRDCXgKaIrXMSA4U6J22hQ+0btmNid
         Hsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757169360; x=1757774160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Egkm1U5iXlvfaFNf/qCSah5l26lLoj1n/U9N9etCIiM=;
        b=HkXJVpN0TI7V74QD+STiPcvALCsZg/7IN9JDXLmzCbIJ8VV3eNK7NX419rPo4hOf1v
         J5kbX0w2hBMgBVUaDMnPMGoK+I4FZ66TUsZTrjVy/AYunyA8kFcxhkhcauOw2OhJeDT9
         7ON0n2Drgxx1aAbS3c71iO4pNhXn1gwMLofZu/HhFy1JzvMKHiykj3UBp9j3EE9BrQO9
         nH81l/R3V5TKgfW7sU/fp2asptel54WLcrgNp/9tkD6FKLN3W5RmTI7p1uUbbSQPj2nY
         6eMVw9J772CcZmkXgaKBY2FXEhCaCBWwR86VIztF5LIYREzRP1y7Oq0U6yLT/2mqOgo1
         xZoA==
X-Forwarded-Encrypted: i=1; AJvYcCU66ahED884Tjn+LEQpLYSI5muHQDho2nfJvJM+uloQtQOiI3vvj7SFV6veHd1j+z4Z3O0+388bPSh8CL4F1yiC2Q==@vger.kernel.org, AJvYcCV/jC09W76MUG6n6LP69ptbfrKM+vGU6TkuRNM7D/J/bJB4Uo7Xzy3KydG9pSi6jIm9PGM=@vger.kernel.org, AJvYcCWK3YlFMtjWpfOeYAjJ2FCtjGFChzM1U/+ExvYOjZp1ZsRfbmm6cRvba5iU/4w1iiHI2tI2tP7RQ7u+cnCz@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsz4YJzpQZq1Fv+CqMCTh7kEt9fTD7swb4g5T0DTw9Y5c0BFt
	O5fm1SNm8YEx4t90lFm26rUXzliumNGZYmVLwO5kHOWF9OOHzBtOi9fe
X-Gm-Gg: ASbGncuOZBrR6atxaDlleYoz74Jxy2pFwq1JxtfNH2q4FBIKTh1c9PXJQnNSZrCfaZW
	bsO9HRUiJP0l/0LDvUTmfQflQPQT4bAZU/t9HxNyYpVU9aq6HEwUC0qvFZ0iQ1X4cwJBHEEJj9H
	RBH8RDAsxShc9kwT2CGOI5MHfJKJ38fhYDTlAiNyhF69uiWOgVBQaCXFj5TyzaCiRSBoRqIMEn3
	MYPOMWNq08qCtK9rzXeolhxGNY1mAsCfm9bYUKAu5Ngph7LoqaPROONdTd81TAW+giBb08kfj49
	jUnQ04kKKaBuVQwvKj7Uka5Y32I9ziuYxEtSr2RoDUgYu3zmSON0Msk+sDhKrSTAL6Qy1pQL1T3
	oJIxtgz7feU+OnrtIGVJLlG3wVRQyuqUDAxNJr1qB5G7Pfne5p+ehemdsEr13dp1IjnbZ
X-Google-Smtp-Source: AGHT+IHT9Ph+Ih0Jgzv4pMXX0J0tMWWNJ2bI17+DrUP71bpXw7bkuvyvkzaxJpK5Nc+pCc1iRakrrQ==
X-Received: by 2002:a53:d003:0:b0:5fd:2ec5:f34e with SMTP id 956f58d0204a3-6102277ad4cmr1326212d50.5.1757169360054;
        Sat, 06 Sep 2025 07:36:00 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8501f5fsm37998547b3.48.2025.09.06.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 07:35:59 -0700 (PDT)
Date: Sat, 6 Sep 2025 10:35:58 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yuyang Huang <yuyanghuang@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Petr Machata <petrm@nvidia.com>,
	Maurice Lambert <mauricelambert434@gmail.com>,
	Jonas Gottlieb <jonas.gottlieb@stackit.cloud>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1 2/4] tools bitmap: Add missing
 asm-generic/bitsperlong.h include
Message-ID: <aLxGztswgpjxlt2l@yury>
References: <20250905224708.2469021-1-irogers@google.com>
 <20250905224708.2469021-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905224708.2469021-3-irogers@google.com>

On Fri, Sep 05, 2025 at 03:47:06PM -0700, Ian Rogers wrote:
> small_const_nbits is defined in asm-generic/bitsperlong.h which
> bitmap.h uses but doesn't include causing build failures in some build
> systems. Add the missing #include.
> 
> Note the bitmap.h in tools has diverged from that of the kernel, so no
> changes are made there.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> ---
>  tools/include/linux/bitmap.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index d4d300040d01..0d992245c600 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -3,6 +3,7 @@
>  #define _TOOLS_LINUX_BITMAP_H
>  
>  #include <string.h>
> +#include <asm-generic/bitsperlong.h>
>  #include <linux/align.h>
>  #include <linux/bitops.h>
>  #include <linux/find.h>
> -- 
> 2.51.0.355.g5224444f11-goog

