Return-Path: <bpf+bounces-9745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A805279D152
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 14:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D631C20C23
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 12:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F616431;
	Tue, 12 Sep 2023 12:45:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AE8F41
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 12:45:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3E9F;
	Tue, 12 Sep 2023 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694522719; x=1726058719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D9xeT2qID5bS6853+91laC5cChL3kKSaLf8+yh4putk=;
  b=Ea06EPCkd57mAflbx5YQwAFWWK6O69mZ9v/14U59+ksaGNWO52gTLTpI
   LdNrLOQpMhl5Ha+r5OnRrE892r58bJYyv13iiDRvflL5fKlZiqLv7cZNS
   LXPMexlwtE/IW7sG63Q/kDUDzx9Ch/BabzBMDfSrG8zl/2QAQipMGg5Ff
   1Jayc8U0JOq49p2fN9RWA8uQ89QxkZ82FGPvNmCft5UfDt/0xkOBeiMDZ
   UE+9oGIAjxaz8gOCrkhmxabR8wljHmsEdymhpUOJsIL2g6Xlf2TJZ03VT
   HZveX9n01NM74BQfljDybxZBFzLlKTxbPWX5Qc3V4DfiwHaMs1c+QyLKa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358638814"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358638814"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867352738"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="867352738"
Received: from srosalim-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.217.51])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:14 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: x86@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: irogers@google.com,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	hpa@zytor.com,
	mingo@redhat.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acme@kernel.org,
	peterz@infradead.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	namhyung@kernel.org,
	jolsa@kernel.org
Subject: [RESEND PATCH 0/2] perf/x86: Package residency counter improvements
Date: Tue, 12 Sep 2023 15:44:30 +0300
Message-Id: <20230912124432.3616761-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

No changes on this, just resending as 6.6-rc1 is out, and the first post
got no feedback.

Original cover letter with more details here [1].

-Tero

[1] https://lore.kernel.org/bpf/20230823055653.2964237-1-tero.kristo@linux.intel.com/T/#mdaea2388b76abc33ebccac3d0a6ccc0ac0def20b



