Return-Path: <bpf+bounces-71939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFBAC02034
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 17:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E18A3B1554
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEEC33033F;
	Thu, 23 Oct 2025 15:02:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738641E0DFE;
	Thu, 23 Oct 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231733; cv=none; b=jzWXpOfksyJwNJ/s13U/s5FB9x/TxCEbTblmgOF2pBeAheVGLpcBciM0iwA3ZPjhtHcFUmsJSWg2ol6yiLBVz4IQip0NfTyfm/7bcE2/MsETscUEBwdGe6ju6aZXcg22GC0i12CD7bUFGclb5aSBV+qrsUFHm0h/Kdk2xOF63RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231733; c=relaxed/simple;
	bh=S/cYIb8x+NynLojHbP+5KIv1BmaYFiPzleWxqjhDKH4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OZyLmzLNrPjqbxoRzPF8kDSe57M65J9jjHrf7wobJ/duOX2TtTeJD/dxgQRzT6PahkBMXhaQ4+59MJZEIDSrd3edVtGoceMydF05SigEDTNXe4hMPYl+nPF1aRqB75ppePHwfRe5xg1lOcNn9Czjchvbfsl+Q5UQVX+5QCy0RoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 414CA1516;
	Thu, 23 Oct 2025 08:01:57 -0700 (PDT)
Received: from [10.57.37.86] (unknown [10.57.37.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3B863F63F;
	Thu, 23 Oct 2025 08:02:01 -0700 (PDT)
Message-ID: <83c8989c-bd9b-4eed-8372-e280c80a93f5@arm.com>
Date: Thu, 23 Oct 2025 16:01:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 13/14] selftests/sched_ext: Add test for sched_ext
 dl_server
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-14-arighi@nvidia.com>
 <67335454-6657-42d2-bf98-d1df1b58baa6@arm.com> <aPY_YHK-oWZp0KK1@gpd4>
 <664c2c34-1514-421f-b3e4-3aec1139f8e3@arm.com>
Content-Language: en-US
In-Reply-To: <664c2c34-1514-421f-b3e4-3aec1139f8e3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 15:21, Christian Loehle wrote:
> On 10/20/25 14:55, Andrea Righi wrote:
>> Hi Christian,
>>
>> On Mon, Oct 20, 2025 at 02:26:17PM +0100, Christian Loehle wrote:
>>> On 10/17/25 10:26, Andrea Righi wrote:
>>>> Add a selftest to validate the correct behavior of the deadline server
>>>> for the ext_sched_class.
>>>>
>>>> [ Joel: Replaced occurences of CFS in the test with EXT. ]
>>>>
>>>> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>> Signed-off-by: Andrea Righi <arighi@nvidia.com>
>>>> ---
>>>>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>>>>  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
>>>>  tools/testing/selftests/sched_ext/rt_stall.c  | 214 ++++++++++++++++++
>>>>  3 files changed, 238 insertions(+)
>>>>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
>>>>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
>>>
>>>
>>> Does this pass consistently for you?
>>> For a loop of 1000 runs I'm getting total runtime numbers for the EXT task of:
>>>
>>>    0.000 -    0.261 |  (7)
>>>    0.261 -    0.522 | ###### (86)
>>>    0.522 -    4.437 |  (0)
>>>    4.437 -    4.698 |  (1)
>>>    4.698 -    4.959 | ################### (257)
>>>    4.959 -    5.220 | ################################################## (649)
>>>
>>> I'll try to see what's going wrong here...
>>
>> Is that 1000 runs of total_bw? Yeah, the small ones don't look right at
>> all, unless they're caused by some errors in the measurement (or something
>> wrong in the test itself). Still better than without the dl_server, but
>> it'd be nice to understand what's going on. :)
>>
>> I'll try to reproduce that on my side as well.
>>
> 
> Yes it's pretty much
> for i in $(seq 0 999); do ./runner -t rt_stall ; sleep 10; done
> 
> I also tried to increase the runtime of the test, but results look the same so I
> assume the DL server isn't running in the fail cases.
> 

FWIW the below fixes the issue and also explains why runtime of the test was irrelevant.
I wonder if we should let the test do FAIR->EXT->FAIR->EXT or something like that,
the change would be minimal and coverage improved significantly IMO.

-----8<-----

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c5f3c39972b6..ed48c681c4c2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2568,6 +2568,8 @@ static void dl_server_on(struct rq *rq, bool switch_all)
 
        err = dl_server_init_params(&rq->ext_server);
        WARN_ON_ONCE(err);
+       if (rq->scx.nr_running)
+               dl_server_start(&rq->ext_server);
 
        rq_unlock_irqrestore(rq, &rf);
 }


