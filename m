Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA23CF3BE
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 06:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242405AbhGTEP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 00:15:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:51770 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239422AbhGTEPS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Jul 2021 00:15:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="210897307"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="210897307"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:55:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="431923356"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:55:56 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 3/6] x86/tdx: Add SetupEventNotifyInterrupt TDX hypercall support
Date:   Mon, 19 Jul 2021 21:55:49 -0700
Message-Id: <20210720045552.2124688-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720045552.2124688-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720045552.2124688-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SetupEventNotifyInterrupt TDX hypercall is used by guest TD to specify
which interrupt vector to use as an event-notify vector to the VMM.
Such registered vector is also used by Host VMM to notify about
completion of GetQuote requests to the Guest TD.

Add tdx_hcall_set_notify_intr() helper function to implement the
SetupEventNotifyInterrupt hypercall.

This will be used by the TD quote driver.

Details about the SetupEventNotifyInterrupt TDVMCALL can be found in
TDX Guest-Host Communication Interface (GHCI) Specification, sec 3.5
"TDG.VP.VMCALL<SetupEventNotifyInterrupt>".

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Change since v2:
 * Included TDVMCALL_SUCCESS case check in tdx_hcall_set_notify_intr().

 arch/x86/kernel/tdx.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index aa49c6809a0c..27e56ab0d4a2 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -29,6 +29,7 @@
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_GET_QUOTE		0x10002
+#define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
 
 /* TDX Module call error codes */
 #define TDX_PAGE_ALREADY_ACCEPTED       0x8000000000000001
@@ -208,6 +209,32 @@ int tdx_hcall_get_quote(u64 data)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
+/*
+ * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
+ *
+ * @vector        : Vector address to be used for notification.
+ *
+ * return 0 on success or failure error number.
+ */
+int tdx_hcall_set_notify_intr(u8 vector)
+{
+	u64 ret;
+
+	/* Minimum vector value allowed is 32 */
+	if (vector < 32)
+		return -EINVAL;
+
+	ret = _trace_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0,
+				   NULL);
+
+	if (ret == TDVMCALL_SUCCESS)
+		return 0;
+	else if (ret == TDCALL_INVALID_OPERAND)
+		return -EINVAL;
+
+	return -EIO;
+}
+
 static void tdg_get_info(void)
 {
 	u64 ret;
-- 
2.25.1

