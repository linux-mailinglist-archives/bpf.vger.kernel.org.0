Return-Path: <bpf+bounces-3869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D723745AB0
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 12:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144971C2032D
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A251DDCC;
	Mon,  3 Jul 2023 10:58:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F083DDC2
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 10:58:39 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1484C9;
	Mon,  3 Jul 2023 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688381917; x=1719917917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aDd9Dd7JEfe7wMOXCs64FITvs+m6jxeMPO7Bg5RtL0s=;
  b=ik0PfakRSTeHCimtnIGzMAlYS5YXdPLfqHeVSgMev13wKwMVVoO3O1tK
   8+qYeYyEKvJza6ElXUxjx3viQNiyfIUb8/AAQfmqZsoUogAIq0aF6GPT5
   4//c9qae6svL0hoKp9JOMyGuh8IjgNFYoJFpYBz3O+Y/1duc+gkIwJGCW
   EoqXTgE9F5DDu7Wb4rJN23f/24WQ+iWt5F+nwipL4lhQnNKqSBPOyxOdj
   ognVbzJPxUlLIG3idGil2Z7EZXa6TICL6ZOiERlrQTSMj1Aw42DH9gcps
   2LVLvpdHOsP6GgLsuQhCDOtHziippfOKaBX/iVByAD1hwv5/sV2X54zqd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="360329699"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="360329699"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="748108247"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="748108247"
Received: from agrabezh-mobl1.ccr.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.48.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:58:23 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: shuah@kernel.org,
	tglx@linutronix.de,
	x86@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com
Cc: ast@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] x86/BPF: Add new BPF helper call bpf_rdtsc
Date: Mon,  3 Jul 2023 13:57:43 +0300
Message-Id: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

This patch series adds a new x86 arch specific BPF helper, bpf_rdtsc()
which can be used for reading the hardware time stamp counter (TSC.)
Currently the same counter is directly accessible from userspace
(using RDTSC instruction), and kernel space using various rdtsc_*()
APIs, however eBPF lacks the support.

The main usage for the TSC counter is for various profiling and timing
purposes, getting accurate cycle counter values. The counter can be
currently read from BPF programs by using the existing perf subsystem
services (bpf_perf_event_read()), however its usage is cumbersome at
best. Additionally, the perf subsystem provides relative value only
for the counter, but absolute values are desired by some use cases
like Wult [1]. The absolute value of TSC can be read with BPF programs
currently via some kprobe / bpf_core_read() magic (see [2], [3], [4] for
example), but this relies on accessing kernel internals and is not
stable API, and is pretty cumbersome. Thus, this patch proposes a new
arch x86 specific BPF helper to avoid the above issues.

-Tero

[1] https://github.com/intel/wult
[2] https://github.com/intel/wult/blob/c92237c95b898498faf41e6644983102d1fe5156/helpers/wult-tdt-helper/tdt-bpf.c#L102
[3] https://github.com/intel/wult/blob/c92237c95b898498faf41e6644983102d1fe5156/helpers/wult-tdt-helper/tdt-bpf.c#L133
[4] https://github.com/intel/wult/blob/c92237c95b898498faf41e6644983102d1fe5156/helpers/wult-tdt-helper/tdt-bpf.c#L488



