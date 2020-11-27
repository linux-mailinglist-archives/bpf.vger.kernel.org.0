Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342EB2C6A89
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgK0RU6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:20:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:35363 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbgK0RU6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:20:58 -0500
IronPort-SDR: d2zsoY2Nnh+wD/+juHcFS72oyJTFdf4TVRmenwPSKm+SIbIEI+JgrGms8VlNMcgJEKp1u+5CqZ
 cAz3hvw/twlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="169856102"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="169856102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 09:20:52 -0800
IronPort-SDR: 2bFNAkVEDfkECjyZDBwqWUQzS0aV+BrLEa82Li0ZlcJtKV4fs5bO6GbTGA4IiZ0zrq4xRlDn2L
 FpCJl1qYYdMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="537702710"
Received: from lkp-server01.sh.intel.com (HELO b5888d13d5a5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Nov 2020 09:20:50 -0800
Received: from kbuild by b5888d13d5a5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kihQP-00007x-M3; Fri, 27 Nov 2020 17:20:49 +0000
Date:   Sat, 28 Nov 2020 01:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] bpf: bpf_kallsyms_lookup_proto can be static
Message-ID: <20201127172038.GA27671@df16bc54365e>
References: <20201126165748.1748417-1-revest@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126165748.1748417-1-revest@google.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 bpf_trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9d86e20c2b13cd..a3dc24695ea9f6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1288,7 +1288,7 @@ BPF_CALL_5(bpf_kallsyms_lookup, u64, address, char *, symbol, u32, symbol_size,
 	return ret;
 }
 
-const struct bpf_func_proto bpf_kallsyms_lookup_proto = {
+static const struct bpf_func_proto bpf_kallsyms_lookup_proto = {
 	.func		= bpf_kallsyms_lookup,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
