Return-Path: <bpf+bounces-60221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850C2AD420A
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 20:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CDC3A45AB
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBDD248862;
	Tue, 10 Jun 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM7RDwzz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D012472B4;
	Tue, 10 Jun 2025 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580740; cv=none; b=GNWvUq/hwFoZJ+pW9xO9ZwTLBswgEeCdiIWQVpaLZYtFGB08uzgc2iErEIs96ogVoKDUC5ueYpNdz4NXeiF8W3NnK645jY4ra8zPl32f9dcqOTBnUW0pJtQdkTGR2ADsgdujqvv6owc69HTxneMcGR7lkzn/eyiO00LEwtgYgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580740; c=relaxed/simple;
	bh=edUDw8NZg4v1sx3/A+CQMjeRWuYE+qaNxc8t/7NOp9s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FesASb5edbxeBus4WPHMTWQYvW6liHQwO4UKn2Mxf3KfBPlsr04Qeqge2uarEj9Ft/L4RH/l8acF6zYxELJ7fK6IP7PqT6IiIUSPi6UjE0WeWYZdGRvUjYi7FAOYcfEWiEJLMgVm1SsB4en0J0S7Q/GKvJ8Gh0MRZX03kLXF81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM7RDwzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5FCC4CEF2;
	Tue, 10 Jun 2025 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749580740;
	bh=edUDw8NZg4v1sx3/A+CQMjeRWuYE+qaNxc8t/7NOp9s=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ZM7RDwzz3vIt1hezXwKUmp9aY5SSOrHf0cd6tpKKcVaN2yUFPNs0LpmJwc8wZWM8D
	 kTZfxPJgO18l2JhzGo1zxcOgmoeRW3v4dOiqPUuLGnAgu5wHfkIAKpS0hAc83AyuOq
	 owvG+AdxdR5AD7RaDNIJFlzOHr2FJweNrXUdFRMTXoIgdYvUSaQZQeqZ19axb93796
	 7r267IGuhAjl4GqQazMAOsFTLIZ/myQZEg2IIDya9Q2cEI6CVrFQPkcyPAQRRbI8IN
	 TL6S8TcJiac/5rgq2QpF1k1k3rvwol7Ayx3HvsdRGqz1wyWGRckA1gA56yhV99JLon
	 skv5Y3pJ0YCJQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, 
 Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
 Leo Yan <leo.yan@arm.com>, Hao Ge <gehao@kylinos.cn>, 
 Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
 Levi Yun <yeoreum.yun@arm.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Gautam Menghani <gautam@linux.ibm.com>, 
 Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
References: <20250604174545.2853620-1-irogers@google.com>
Subject: Re: [PATCH v4 00/10] Move uid filtering to BPF filters
Message-Id: <174958073941.4039944.6156587445391341437.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 11:38:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 04 Jun 2025 10:45:34 -0700, Ian Rogers wrote:
> Rather than scanning /proc and skipping PIDs based on their UIDs, use
> BPF filters for uid filtering. The /proc scanning in thread_map is
> racy as the PID may exit before the perf_event_open causing perf to
> abort. BPF UID filters are more robust as they avoid the race. The
> /proc scanning also misses processes starting after the perf
> command. Add a helper for commands that support UID filtering and wire
> up. Remove the non-BPF UID filtering support given it doesn't work.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



