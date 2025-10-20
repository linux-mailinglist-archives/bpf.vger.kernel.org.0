Return-Path: <bpf+bounces-71393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512DBF1876
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01CB3E4855
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF92FB0BC;
	Mon, 20 Oct 2025 13:26:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394B12C21E4;
	Mon, 20 Oct 2025 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966784; cv=none; b=STglET3r/45/qg6cXSRhLlLPmjWRR6cDJlCUFWGwv7D5hggB7gy4JWqt/6521Z9VIacWwP9wZrIdlHK2hYGEoqCm1IzXp1XLguq6SNvbpZQRX4RZah3vvYUxzxadS/14CN1VbbUkktP35yeSo7gvZt3/Psj5r6diR5fCk69SqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966784; c=relaxed/simple;
	bh=9pkFy8AP2oanktC2W2BpgOATkWktZC12uTFM201uEPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUNHlIJRnmLUjkMxEc74ayi1ETQw40jbKR5n8trcebRM/BIt6y5btTzcrRtqjNl+zIbsj8XlwyXeWlgjX3GQOpLI3SruA5q2+buOOwdQoxNCof5YcyjVWYaQPBtqx9s8bdb5L7AKoENKk+SAaQWf9RpVm8xfbRv8R3QGpJgHx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA6321063;
	Mon, 20 Oct 2025 06:26:14 -0700 (PDT)
Received: from [10.1.31.45] (e127648.arm.com [10.1.31.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F74C3F66E;
	Mon, 20 Oct 2025 06:26:19 -0700 (PDT)
Message-ID: <67335454-6657-42d2-bf98-d1df1b58baa6@arm.com>
Date: Mon, 20 Oct 2025 14:26:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] selftests/sched_ext: Add test for sched_ext
 dl_server
To: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-14-arighi@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251017093214.70029-14-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 10:26, Andrea Righi wrote:
> Add a selftest to validate the correct behavior of the deadline server
> for the ext_sched_class.
> 
> [ Joel: Replaced occurences of CFS in the test with EXT. ]
> 
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
>  tools/testing/selftests/sched_ext/rt_stall.c  | 214 ++++++++++++++++++
>  3 files changed, 238 insertions(+)
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c


Does this pass consistently for you?
For a loop of 1000 runs I'm getting total runtime numbers for the EXT task of:

   0.000 -    0.261 |  (7)
   0.261 -    0.522 | ###### (86)
   0.522 -    4.437 |  (0)
   4.437 -    4.698 |  (1)
   4.698 -    4.959 | ################### (257)
   4.959 -    5.220 | ################################################## (649)

I'll try to see what's going wrong here...

