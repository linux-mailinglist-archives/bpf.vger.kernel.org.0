Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824852A19BC
	for <lists+bpf@lfdr.de>; Sat, 31 Oct 2020 19:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgJaSpW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Oct 2020 14:45:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:34504 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSpW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Oct 2020 14:45:22 -0400
IronPort-SDR: hr4uColLGL921lzOaC1jvuUXlTRHuAcMDPoKsAgdgeh89U2xFvxbCqKkQ84HhCw3726JKNP3o6
 k34mbino7YxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9791"; a="155728669"
X-IronPort-AV: E=Sophos;i="5.77,438,1596524400"; 
   d="scan'208";a="155728669"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2020 11:45:21 -0700
IronPort-SDR: +8KHV+OHWnoziTFRitP+nlKXQL9qyMHIa86N7DYyec4mHah/F29GpowQ51DHJMzBHEZ566CXiO
 4rVOgGfBNkNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,438,1596524400"; 
   d="scan'208";a="305061689"
Received: from lkp-server02.sh.intel.com (HELO ee7b80346e9c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 31 Oct 2020 11:45:19 -0700
Received: from kbuild by ee7b80346e9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYvsN-0000AK-3D; Sat, 31 Oct 2020 18:45:19 +0000
Date:   Sun, 1 Nov 2020 02:45:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH] bpf: bpf_get_current_task_btf_proto can be static
Message-ID: <20201031184503.GA18952@1ec460b3ae4c>
References: <20201027170317.2011119-3-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027170317.2011119-3-kpsingh@chromium.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 bpf_trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7b48aa1c695ab8..e4515b0f62a8d3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1029,7 +1029,7 @@ BPF_CALL_0(bpf_get_current_task_btf)
 
 BTF_ID_LIST_SINGLE(bpf_get_current_btf_ids, struct, task_struct)
 
-const struct bpf_func_proto bpf_get_current_task_btf_proto = {
+static const struct bpf_func_proto bpf_get_current_task_btf_proto = {
 	.func		= bpf_get_current_task_btf,
 	.gpl_only	= true,
 	.ret_type	= RET_PTR_TO_BTF_ID,
