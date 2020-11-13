Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A21D2B151C
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 05:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgKMEWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 23:22:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:5416 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgKMEWj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 23:22:39 -0500
IronPort-SDR: pb5pEqIGr2h6s3OtOZ+62l9V1F4FQzalcXlWm1Uy+9UYkxqJ2+HpCTVRybddwtnilf98pRNHQE
 uD5xICdbV0WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="232042116"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="232042116"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 20:22:38 -0800
IronPort-SDR: dN4ut54hOHCrXhNKN1pQTokMMFPRpFUmgfGwic+LOUZE+zAeDbZsSFFeYLcDUmmnGEYOkRyshc
 Pci5PGLvzAPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="309051276"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Nov 2020 20:22:35 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdQbb-00004T-2b; Fri, 13 Nov 2020 04:22:35 +0000
Date:   Fri, 13 Nov 2020 12:22:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, yhs@fb.com, andrii@kernel.org, kpsingh@chromium.org,
        jackmanb@chromium.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@google.com>
Subject: [RFC PATCH] bpf: bpf_sock_from_file_proto can be static
Message-ID: <20201113042205.GA744@0ade40929f09>
References: <20201112200944.2726451-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112200944.2726451-1-revest@chromium.org>
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
index 4749575b81b2d1..c34c81095d61c1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1264,7 +1264,7 @@ BTF_ID_LIST(bpf_sock_from_file_btf_ids)
 BTF_ID(struct, socket)
 BTF_ID(struct, file)
 
-const struct bpf_func_proto bpf_sock_from_file_proto = {
+static const struct bpf_func_proto bpf_sock_from_file_proto = {
 	.func		= bpf_sock_from_file,
 	.gpl_only	= true,
 	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
