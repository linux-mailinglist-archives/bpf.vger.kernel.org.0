Return-Path: <bpf+bounces-50134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B8CA23356
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 18:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F53018885F6
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23151EF0B9;
	Thu, 30 Jan 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9zbpNfW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185E15381A;
	Thu, 30 Jan 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259179; cv=none; b=WnwOzjuVaPCCCCDhQ7EON/sKph+CsCWq3hwmZfGr3u98Oxsh7IHDIp3CNGEC0ytd447sivjgsoyBoQdMGC8BUwkrDWwBQuqBS50/BsMYUfQWc+jM2a3f94CdALvs8kQuQjy0OFgEKjgRGpo1RxUYy4PR9KJ0JrzqYPZZBXyjcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259179; c=relaxed/simple;
	bh=7fFoQU8lEaXeKNCuvbEaXEk+WtJz3kft7cQEkJ5rq9g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvH89h0XvCBf5jfoA1PF3lRWPjjVb918tbNxpUZ0b2KyJEGvkgMhFe93GgC7kiiB/BsDN3/VEfOwXR4F/04fKfj4BV6e6Otj2w92ATtwYh7IUcwhJMPNVMDKEnqvalJwTJdPiFR6qu6OEYN3gyRIH07O6JxqkNZS52u/eAnwK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9zbpNfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69246C4CED2;
	Thu, 30 Jan 2025 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738259179;
	bh=7fFoQU8lEaXeKNCuvbEaXEk+WtJz3kft7cQEkJ5rq9g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u9zbpNfWDFe+Pc6hiLwBtG3AnsuNggVsEWLTjmqYrEGRKqnl5XKO6GeePkbFufxmb
	 68aA4V8Yp9wX7GynW5Mnumv6mAFN5qMsPlex/INkHcZ7jSrPt2DDLB8gjK83M/mMUd
	 5ika04i+wQI2JWKxhYYtElwOTLYrf6oEWjHMGoIh6+kHFhbuFKVdPqmWWw2aysewhN
	 n5tFmcp/koRch/89TfmaBTTFYuEvypYzHDdpBAz8E52cgZzrA2tSeL9zwIIFbZJh7g
	 Mya4JxoRQatF1CZ7O+1vf9x+DgmR3aHGJOuQgHcdwQyrywFxbi/cNRNu1Fyx5IU/m3
	 RdppPDJhHfAQQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v5 0/4] Prefer sysfs/JSON events also when no PMU is provided
Date: Thu, 30 Jan 2025 09:46:11 -0800
Message-ID: <173825913284.2069353.1023049431738913294.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250109222109.567031-1-irogers@google.com>
References: <20250109222109.567031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 09 Jan 2025 14:21:05 -0800, Ian Rogers wrote:
> At the RISC-V summit the topic of avoiding event data being in the
> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> events being the priority when no PMU is provided so that legacy
> events maybe supported via json. Originally Mark Rutland also
> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> M? processors, but James Clark more recently tested this and believes
> the driver issues there may not have existed or have been resolved. In
> any case, it is inconsistent that with a PMU event names avoid legacy
> encodings, but when wildcarding PMUs (ie without a PMU with the event
> name) the legacy encodings have priority.
> 
> [...]
Applied patch 1 and 2 to perf-tools-next, thanks!

Best regards,
Namhyung


