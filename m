Return-Path: <bpf+bounces-76570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2045ACBC58B
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 04:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6507D3009847
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 03:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE0299A84;
	Mon, 15 Dec 2025 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfDue/L0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645529D297
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770172; cv=none; b=uQyMPd7OgN8PrHb7LEO1v/GPkJU+V6XitXzMHOAgIVGXXcc9B+gV+9r5EBa9pLZ56JVpMmr/tF88ddoQ44fK6iMQ87ORCi0V++QCg5qwjKJyiJMi9JHu8mKEircgIK9x3eLbtI7/Ug+olBB1ugSUny9NgcVverK3AaQy4ztfx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770172; c=relaxed/simple;
	bh=l38H3vsBTdrEgWUMkEZiNVCzoEObSKrQ0jGhEvBuLdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOd6batZwfeRpB1M1KKiDxRMyMFgQT+WYj91rlrJq2+LufNiMQaqJIziboGq1vv9G9OpFOp31ICaWhvyVHeXz55oG/SGL793R8KeAg8FoyhaSdsFqERExtQ/UOCwjAZCI5WFS0fZ8zSGU9tgBEsnQgrgUpL3YviyMGwEf3LuySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfDue/L0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso565128a91.0
        for <bpf@vger.kernel.org>; Sun, 14 Dec 2025 19:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765770170; x=1766374970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zodsawp9MT0zFDRA0UB83iWzeQZFAUerG70qGUpiRMU=;
        b=NfDue/L0yFWtqnxi/keewnVPnabgZxad1Rr36A7q0GHidOAQs3Y3wQoigRsdIVaf03
         oV/Y/auCasDw/j/OjRoyknhbMJ/ucyS8nBYHUr6Oi2zvTQHdmBwOWXf7Bry9kJMzjs6i
         j+wAFcUK3vZBxnDBFA9FYWE3wPpbp1LLAlr+UNOFydGZ903AKSIB8sUu9gpF47nBAG5d
         bu7LDpm6Rw2E/zjYYNk5IcvmlZXowDlXGDj2fFVj7ZZN8cM2Hfnbh9Thz6+AJEU4nrWh
         FW7MRlQcmRDnRGTBiDvgxdujcWTr4f2ZTs/juuuaaxisHGa3R8kZqdS2XBl87JpNv/7O
         +vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765770170; x=1766374970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zodsawp9MT0zFDRA0UB83iWzeQZFAUerG70qGUpiRMU=;
        b=X6d/Fm3sjrt3MQU9CLK6i6074Xg9HFQ7hvpjgjPJ61luuah5SOiyniSl/h7ECqoR2U
         E54Xx05adACxUjxF+UGIcTf9mhdBhtZ0CRRBVijC0VtSHR6ah5OapbDsTUuUummonal0
         IW6pbAT9ko4QHERSU/VDF980ZqTnPuBCk3wwfDioMlbQrRm+qeLXJHgKzyBV4wn5WtAs
         oTuOvtxVi7NLsKQVsXYVY/VYA9u1l/DTCwvkWPxjM38gYLGHgwuaBloy0rbeDknxUUaG
         mohGOQLn52JkE0uBBG5FX7ndrfQzl17FgYBdmMImpbHaSSEf/FvRpa/khoOyvyN4xB6a
         fNtw==
X-Forwarded-Encrypted: i=1; AJvYcCW4dvZbbU8IzJhGs/bBTPNc4DWrPX/iObnh+veXUgXYYQ7fa7xahrmXIE1A4JgGNB9aNk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClTOcmmo88Jwaxuf+JpnfHyNRefUj4HxybMPf4fE/nJYRxoV+
	vHRiNf6frX+CZRpkafERuG6PqRctZWp24xEElsAy8ux7ioiPph7j7HPy
X-Gm-Gg: AY/fxX4/rVS+oIHKLe1DE7Jd6FedzmtgguFEJ8lGT8xkuq1aSV4qiN5rsNCM0wiklxU
	qHS1Spenlhy3Yf1xdAi6PqN8CLwdf09Z51PC+JstGvY4sGXJSa3SoMJOOExouaMz3CzTLFfcijk
	tq/ltIze1vzW/wsp0YWn/NJIn+rUN8WEHcrKRiZ8yWzsnunr0TKuToRZ09yhLHTjWHflNbyEdkN
	69O3UaSP8dSfCsH2Z2b0e98qGaNpsfslqGZ+24jYG5A1k20l9Tax93UGX0wCumAFhxvVFVIEU7C
	0D3/lat/JXhZffKWzTlrT+A6yBNOVEFhI9PHdyhsCbF+kvdTMUJynteJc5hwzyqStYa0XTWetsS
	NNUiNbPM2jmCWlccGdF03n4nLkBl7fmcod7PE0nuqsXkxyG+qT/ILxSyjspHy2uiYOe5C3a5B01
	JhPUrxgWyg1mYL4V6WnIFrKkRqG6o=
X-Google-Smtp-Source: AGHT+IFV0mk8C23ZddCTFMGBb6EW5vJkKKe/Id/7ooCo0G5hzTqwU+bujzLDeHuF/5cfsXslbYpfpg==
X-Received: by 2002:a17:90b:3c4f:b0:340:c179:3666 with SMTP id 98e67ed59e1d1-34abd6c02cfmr7561102a91.8.1765770169907;
        Sun, 14 Dec 2025 19:42:49 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe23a207sm3420562a91.1.2025.12.14.19.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:42:48 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v4 3/3] tracing: Update funcgraph-retval documentation
Date: Mon, 15 Dec 2025 11:41:53 +0800
Message-Id: <20251215034153.2367756-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215034153.2367756-1-dolinux.peng@gmail.com>
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The existing documentation for funcgraph-retval is outdated and partially
incorrect, as it describes limitations that have now been resolved.

Recent changes (e.g., using BTF to obtain function return types) have
addressed key issues:
1. Return values are now printed only for non-void functions.
2. Values are trimmed to the correct width of the return type, avoiding
   garbage data from high bits.

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 Documentation/trace/ftrace.rst | 88 +++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index d1f313a5f4ad..b231e80e6a4f 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1454,6 +1454,10 @@ Options for function_graph tracer:
 	printed in hexadecimal format. By default, this option
 	is off.
 
+  funcgraph-retaddr
+	When set, the return address will always be printed.
+	By default, this option is off.
+
   sleep-time
 	When running function graph tracer, to include
 	the time a task schedules out in its function.
@@ -2800,7 +2804,7 @@ It is default disabled.
     0)   2.861 us    |      } /* putname() */
 
 The return value of each traced function can be displayed after
-an equal sign "=". When encountering system call failures, it
+an equal sign "ret =". When encountering system call failures, it
 can be very helpful to quickly locate the function that first
 returns an error code.
 
@@ -2810,16 +2814,16 @@ returns an error code.
   Example with funcgraph-retval::
 
     1)               |    cgroup_migrate() {
-    1)   0.651 us    |      cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
+    1)   0.651 us    |      cgroup_migrate_add_task(); /* ret=0xffff93fcfd346c00 */
     1)               |      cgroup_migrate_execute() {
     1)               |        cpu_cgroup_can_attach() {
     1)               |          cgroup_taskset_first() {
-    1)   0.732 us    |            cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
-    1)   1.232 us    |          } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
-    1)   0.380 us    |          sched_rt_can_attach(); /* = 0x0 */
-    1)   2.335 us    |        } /* cpu_cgroup_can_attach = -22 */
-    1)   4.369 us    |      } /* cgroup_migrate_execute = -22 */
-    1)   7.143 us    |    } /* cgroup_migrate = -22 */
+    1)   0.732 us    |            cgroup_taskset_next(); /* ret=0xffff93fc8fb20000 */
+    1)   1.232 us    |          } /* cgroup_taskset_first ret=0xffff93fc8fb20000 */
+    1)   0.380 us    |          sched_rt_can_attach(); /* ret=0x0 */
+    1)   2.335 us    |        } /* cpu_cgroup_can_attach ret=-22 */
+    1)   4.369 us    |      } /* cgroup_migrate_execute ret=-22 */
+    1)   7.143 us    |    } /* cgroup_migrate ret=-22 */
 
 The above example shows that the function cpu_cgroup_can_attach
 returned the error code -22 firstly, then we can read the code
@@ -2836,37 +2840,41 @@ printed in hexadecimal format.
   Example with funcgraph-retval-hex::
 
     1)               |      cgroup_migrate() {
-    1)   0.651 us    |        cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
+    1)   0.651 us    |        cgroup_migrate_add_task(); /* ret=0xffff93fcfd346c00 */
     1)               |        cgroup_migrate_execute() {
     1)               |          cpu_cgroup_can_attach() {
     1)               |            cgroup_taskset_first() {
-    1)   0.732 us    |              cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
-    1)   1.232 us    |            } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
-    1)   0.380 us    |            sched_rt_can_attach(); /* = 0x0 */
-    1)   2.335 us    |          } /* cpu_cgroup_can_attach = 0xffffffea */
-    1)   4.369 us    |        } /* cgroup_migrate_execute = 0xffffffea */
-    1)   7.143 us    |      } /* cgroup_migrate = 0xffffffea */
-
-At present, there are some limitations when using the funcgraph-retval
-option, and these limitations will be eliminated in the future:
-
-- Even if the function return type is void, a return value will still
-  be printed, and you can just ignore it.
-
-- Even if return values are stored in multiple registers, only the
-  value contained in the first register will be recorded and printed.
-  To illustrate, in the x86 architecture, eax and edx are used to store
-  a 64-bit return value, with the lower 32 bits saved in eax and the
-  upper 32 bits saved in edx. However, only the value stored in eax
-  will be recorded and printed.
-
-- In certain procedure call standards, such as arm64's AAPCS64, when a
-  type is smaller than a GPR, it is the responsibility of the consumer
-  to perform the narrowing, and the upper bits may contain UNKNOWN values.
-  Therefore, it is advisable to check the code for such cases. For instance,
-  when using a u8 in a 64-bit GPR, bits [63:8] may contain arbitrary values,
-  especially when larger types are truncated, whether explicitly or implicitly.
-  Here are some specific cases to illustrate this point:
+    1)   0.732 us    |              cgroup_taskset_next(); /* ret=0xffff93fc8fb20000 */
+    1)   1.232 us    |            } /* cgroup_taskset_first ret=0xffff93fc8fb20000 */
+    1)   0.380 us    |            sched_rt_can_attach(); /* ret=0x0 */
+    1)   2.335 us    |          } /* cpu_cgroup_can_attach ret=0xffffffea */
+    1)   4.369 us    |        } /* cgroup_migrate_execute ret=0xffffffea */
+    1)   7.143 us    |      } /* cgroup_migrate ret=0xffffffea */
+
+Note that there are some limitations when using the funcgraph-retval
+option:
+
+- If CONFIG_DEBUG_INFO_BTF is disabled (n), a return value is printed even for
+  functions with a void return type. When CONFIG_DEBUG_INFO_BTF is enabled (y),
+  the return value is printed only for non-void functions.
+
+- If a return value occupies multiple registers, only the value in the first
+  register is recorded and printed. For example, on the x86 architecture, a
+  64-bit return value is stored across eax (lower 32 bits) and edx (upper 32 bits),
+  but only the contents of eax are captured. If CONFIG_DEBUG_INFO_BTF is enabled,
+  the suffix "(trunc)" is appended to the printed value to indicate that the
+  output may be truncated because high-order register contents are omitted.
+
+- Under certain procedure-call standards (e.g., arm64's AAPCS64), when the return
+  type is smaller than a general-purpose register (GPR), the caller is responsible
+  for narrowing the value; the upper bits of the register may contain undefined data.
+  For instance, when a u8 is returned in 64-bit GPR, bits [63:8] can hold arbitrary
+  values, especially when larger types are truncated (explicitly or implicitly). It
+  is therefore advisable to inspect the code in such cases. If CONFIG_DEBUG_INFO_BTF
+  is enabled (y), the return value is automatically trimmed to the width of the return
+  type.
+
+  The following examples illustrate the behavior:
 
   **Case One**:
 
@@ -2885,7 +2893,9 @@ option, and these limitations will be eliminated in the future:
 		RET
 
   If you pass 0x123456789abcdef to this function and want to narrow it,
-  it may be recorded as 0x123456789abcdef instead of 0xef.
+  it may be recorded as 0x123456789abcdef instead of 0xef. When
+  CONFIG_DEBUG_INFO_BTF is enabled, the value will be correctly truncated
+  to 0xef based on the size constraints of the u8 type.
 
   **Case Two**:
 
@@ -2910,7 +2920,9 @@ option, and these limitations will be eliminated in the future:
 		RET
 
   When passing 0x2_0000_0000 to it, the return value may be recorded as
-  0x2_0000_0000 instead of 0.
+  0x2_0000_0000 instead of 0. When CONFIG_DEBUG_INFO_BTF is enabled, the
+  value will be correctly truncated to 0 based on the size constraints of
+  the int type.
 
 You can put some comments on specific functions by using
 trace_printk() For example, if you want to put a comment inside
-- 
2.34.1


