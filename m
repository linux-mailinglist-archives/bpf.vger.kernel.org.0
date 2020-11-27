Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E32C6D12
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgK0WA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 17:00:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:60803 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732094AbgK0Vk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 16:40:26 -0500
IronPort-SDR: qqCw/agI4W0KTTqEteIrCBknJPkAZPozapEGHwSv+XUctrM5sOlu37kZPQl9x1Ok+vPaYfhFB7
 Gb6pyYclKaeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="172591076"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="172591076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 13:39:58 -0800
IronPort-SDR: D/hoQkrEHUI8mDmMKK2kHVpFbugmp6zx2DNeU7LCh0+ngoz+FyA9HSnodVO1gqR2Nkl2rpN7ZQ
 MNvTd3yEtKMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="313777069"
Received: from lkp-server01.sh.intel.com (HELO b5888d13d5a5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Nov 2020 13:39:55 -0800
Received: from kbuild by b5888d13d5a5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kilT9-0000Aw-1w; Fri, 27 Nov 2020 21:39:55 +0000
Date:   Sat, 28 Nov 2020 05:39:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Subject: [RFC PATCH] bpf: bpf_atomic_alu_string[] can be static
Message-ID: <20201127213953.GA65585@ca1034cdd227>
References: <20201127175738.1085417-11-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127175738.1085417-11-jackmanb@google.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 disasm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index f33acffdeed05..737e95b049574 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -80,7 +80,7 @@ const char *const bpf_alu_string[16] = {
 	[BPF_END >> 4]  = "endian",
 };
 
-const char *const bpf_atomic_alu_string[16] = {
+static const char *const bpf_atomic_alu_string[16] = {
 	[BPF_ADD >> 4]  = "add",
 	[BPF_SUB >> 4]  = "sub",
 };
