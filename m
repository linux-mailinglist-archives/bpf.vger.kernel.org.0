Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCC336A74
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 04:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCKDNA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 22:13:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:56308 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhCKDMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 22:12:55 -0500
IronPort-SDR: bKJfck3OeBzNcyWnAYvw/HqFlhL8yQcINSgv1yqkA7x2GFMrM3hhQAKnUZSTj0zSEDAIwKPR81
 gVz4vHRyIGaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="273644018"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="273644018"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 19:12:54 -0800
IronPort-SDR: iFlauzI9h5teA1JCweoBaBhgDRVBZRI4vibUqvYC1q79X40D25E0esFofi1G61HDI7c3XiV547
 Tfshtg2Qr2tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="403927764"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2021 19:12:52 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKBkq-0000XB-4w; Thu, 11 Mar 2021 03:12:52 +0000
Date:   Thu, 11 Mar 2021 11:12:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        jackmanb@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [RFC PATCH] bpf: check_bpf_snprintf_call() can be static
Message-ID: <20210311031207.GA81254@8de2f37f21f5>
References: <20210310220211.1454516-3-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310220211.1454516-3-revest@chromium.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 verifier.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3ab549df817b6..06c868989852d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5732,8 +5732,8 @@ static int check_reference_leak(struct bpf_verifier_env *env)
 	return state->acquired_refs ? -EINVAL : 0;
 }
 
-int check_bpf_snprintf_call(struct bpf_verifier_env *env,
-			    struct bpf_reg_state *regs)
+static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *regs)
 {
 	struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
 	struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
