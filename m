Return-Path: <bpf+bounces-8342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063FF785043
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 07:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A5F281282
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 05:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96F20F1;
	Wed, 23 Aug 2023 05:57:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD51FA5
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 05:57:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7909A1;
	Tue, 22 Aug 2023 22:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692770267; x=1724306267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tXspCGGhfWZ9eYIgTV/JCqA8WbgbtQL3v61LQqkLziQ=;
  b=P625QIS6Ek8CTPlBkoOzJzYJ59GGDahD7h0+TITphbX9w0W3n2gMJ7yv
   efmHm0Aq8/GZCvq4/yvKMBtd9QtJ4f1MRkXutT8bQksxOQ67suPAkFCq6
   4IhuJBAf8PUY9d9Dxq9aA9aFPV7spEZkrYzJIZkX488z2VKN5HxUSoDS1
   QIGWrFCiBHVVfm8uNR5tRm4sKZjk0cJL35p9dSp4WEmuqPZaH9Zd1zWJV
   YYCjUsgLNoTuNn/lyFUUANwk3U8qR+snujs+IN5SAKcGtkcXtzKclBf+B
   VR6KsE4l4txPofPqVNrm2pbXHuwnjv77yH9wX7U6bQ1IZvLK7+QFsI7DX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="438009715"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438009715"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 22:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="983140550"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="983140550"
Received: from ebold-mobl1.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.251.213.156])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 22:57:42 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	x86@kernel.org,
	bp@alien8.de
Cc: artem.bityutskiy@linux.intel.com,
	acme@kernel.org,
	bpf@vger.kernel.org,
	namhyung@kernel.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	hpa@zytor.com,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org
Subject: [PATCH 0/2] perf/x86: Package residency counter improvements
Date: Wed, 23 Aug 2023 08:56:51 +0300
Message-Id: <20230823055653.2964237-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

Following two patches address a couple of different issues with Intel
C-state package residency counters, which are used to track power saving
state usage on Intel chips. The patches don't have any dependencies to
each other and can be applied separately.

1) The residency counters are always read from the first CPU of the
   package via an SMP call, even if they are available from any CPU.
   This causes extra latency. Patch #1 fixes this issue by flagging
   the perf event properly and allowing to execute it on any CPU of
   the package.
2) The residency counters are completely impossible to read from a BPF
   program running on any other than the first CPU of the package, as the
   SMP call is not available in this context. Patch #2 addresses this
   issue by allowing the read of the perf event from the local CPU,
   similar to what is done in perf_read_event(). This patch also allows
   reading any other package scope perf events (RAPL/UNCORE) from
   arbitrary CPUs on a package via BPF.

-Tero



