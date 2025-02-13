Return-Path: <bpf+bounces-51455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D0A34BB5
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B37A20D6
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164623A9B6;
	Thu, 13 Feb 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eiy/DafI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA92222D6;
	Thu, 13 Feb 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467293; cv=none; b=KH3WH3NKuPJkdN5tlhVSirkp+hH1t4PrvlWxY6JcpkO6FcOayz0BZNVeeqIzWpedqs2e+d2FvvjYTR56+Q3vMDbUceLahzXj4z+/kHR2kh8Dg3ndzK/8Fk8fMb/JfuqVeI2nxhl3VllmUNvdSyVhhD69/x6fo/8o1/4AmneDFsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467293; c=relaxed/simple;
	bh=AyZ82WZibsDuj4Hs1+u/AlrM5pQ71BbhpLn92Dz/uQQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QJ3V47wkRaZ2fMg2Itm/2FHvzmcgCpIoEUUNPMFm3R8fubjUIcre4KE4ZB0122Y4O8kTJxyA+e3w9NZ+m8GXVp5L2dL9G9WtrPDUXF9/TRTavNf6t8MQ0W4jJel1sQY8b2GDY/hhlhTsO726xPWNb2I40QOCxaz1Pb6fk6KIWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eiy/DafI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3151C4CEE4;
	Thu, 13 Feb 2025 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739467293;
	bh=AyZ82WZibsDuj4Hs1+u/AlrM5pQ71BbhpLn92Dz/uQQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Eiy/DafIVSYxZhuJFXY/zcKGYKcm8Rxywgy2vQH4T9aPAKggW0U82YhSZClEmRw4g
	 4LW14Lbn2LlTYTKMAcmRXs8EUF6TXzbpxf8lOAzKh0oUYSUIy96RnlaEwVtoOQPw9Q
	 OH5Z8d9tKx9ATCjpe2kHW4FCf+DQVO1oTvsL51PHU5TtPdPPG1gztibxF921qzUgi7
	 iJnKokWYjHIewbeZLZhNbaabOrcrZFOgrjrDqyeXLXHMxtxOTyL9nhC1a1e3ziP0DB
	 u8WxmXwYFhAOZraOv2z16mWu1P/lbs9yu/r5m2YI3qqkXszVrARd2Kdnt7iBw85Pvr
	 7MtVQ8dEWvzmg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250106215443.198633-1-irogers@google.com>
References: <20250106215443.198633-1-irogers@google.com>
Subject: Re: [PATCH v1] tools build: Fix a number of Wconversion warnings
Message-Id: <173946729282.1291083.15633927093597611976.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 09:21:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 06 Jan 2025 13:54:42 -0800, Ian Rogers wrote:
> There's some expressed interest in having the compiler flag
> -Wconversion detect at build time certain kinds of potential problems:
> https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/
> 
> As feature detection passes -Wconversion from CFLAGS when set, the
> feature detection compile tests need to not fail because of
> -Wconversion as the failure will be interpretted as a missing
> feature. Switch various types to avoid the -Wconversion issue, the
> exact meaning of the code is unimportant as it is typically looking
> for header file definitions.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



