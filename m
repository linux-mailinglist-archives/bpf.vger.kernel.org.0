Return-Path: <bpf+bounces-76365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6841CAFE19
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 13:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 823FD30B86C5
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D5A2D321B;
	Tue,  9 Dec 2025 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRyJQyJ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780B3218B2
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282446; cv=none; b=cWP076oO3i4Cu7aaMJneoxD4ZgvPHox0T3IyPD4WaaAcb3SqQyvWNdPlF+9WakWVZ5bcBkjoY/gp+UQWgNKCPo2PwPF/7N3uwEgO6ZHGhl60NsQSM6ulXN2pKPZzgvshWWewhL7I4CONG6gnHfOFf9GAyoYnF27aan2ltDub4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282446; c=relaxed/simple;
	bh=BWyN4D8XB3EHVKIANdR3jOmuIyDp9zYjYnorcbrtitk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bliIil8StJlS72N0vTlEg0Kw9rqAYUAhFcJC8BO8ZCdH+1I40RkjxT8lzY178/5NqHw34Np9D1+UtAqDvyvquoDqq8cHguVptDhVavuoib0Nzyw/Rpp5cgoModCseGyCEJQSzHAdvH/ouHgIF9Cz/WT0TIEGcgwgUwxTGhqt/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRyJQyJ1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so3681975b3a.2
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 04:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765282444; x=1765887244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7QTKaMq3p7fYjtMRSt1RZ9qB0q4/IC5ZQr51AGxCMI=;
        b=hRyJQyJ17mmkinprebALjEOLEmY/AJLILYAbB2HCw/bi5PhiUKP14HfFmaEBMLX+j3
         6tZOMJm+0jF7+z9MNR/6st8slLCOhLsqqm7RFfodLF1CxGY23uQx76YnuBHt8DpI2aZR
         h/8ISaNFhvNNBY1DnDi5rjZASeptiTzxiFV535QOF1BWznZWObqVGgLfdkOs7NtnEi7j
         COMJvWSLy4/pCapEN8Ikgeo1OCZoOFWjU/QaAfx4uIFYNxOn/hw8Gj45yBfIVvl/aKM0
         f7mlFrfXBu0awXVwwRsqQT2PDWA5/9x/zuL8K2x/TuN115pNDK1P+YxHTqyqW/55HwDF
         UGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765282444; x=1765887244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7QTKaMq3p7fYjtMRSt1RZ9qB0q4/IC5ZQr51AGxCMI=;
        b=EI3VGMW6RCZiBBbsp1cKE8ii/9oF6JQxFpo2TeWIruVFn6OOkjV12YpgQggfGpHUSl
         LYOXdfL1PxshJVCRpGbK5bL8vaejaoX8x+sOs2ExgsAALr3U4ZSBWzym4jRq/LTlLGVF
         +AbgD67DzTA1ESR2NbNVksCglQ4UDbPemGSaVXRoqt5fJOz4mXj3eVgqdDzc6SpGa3I3
         xt91gaijr/mHhN8J3m0Kq77/dNGL0Jkw10UygDzY4aDXNS1yxh1UFCKy/KfJvu5CHHnh
         kc2wj1Ju/QdBmKBr2mMuKHVCeORK/AdtXroWeAdWeEv1Gw/6VNzY0epti6dZ7+jyYD2M
         i8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV6ILrVundBfm4dhL+aZa9mQQdN/NeNfVfnMzZivN0cRa6dwklHA8xSEh9s6olBqj40S8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7dFEJh5UfUxCK2u9a4ep7l9iXswXEChwy7coLBRxj65veNVn
	9t9JbyUwQNE2IKXK76uhaBlS03ni8HDRYXPNQ8BayMvLilyfMff+Ae7y
X-Gm-Gg: ASbGnctZSEzpChbG9zIyvcVeQOX6xTj5UcqPCy+08U4ZaddnVZI7Y6RGgWYtzXCYm8X
	JoFvoC/L8O3BjHV6zpaj6YkfVYqwW1/a9ths6RAOLIS8eYTj/KM2yx6/MvoUC0yMRrV1Xcq82yY
	Caxq9Qb7V3Y8CRsRgoxmyCxV6BM15RKZBIi06dquXR+t2s59Qrp1gCGxjdsKl4vnbp9Lu2zApxJ
	7JNElnx6KdBAd5szyOQcBjg0PKSY2x4D0O3IuLLS8xVVQKDuB80ZgrkOOuw08LGqLg2hNTTuOMj
	4dXuSVp9UT0j1tyz+9s6wckTrUFetbMZ/S6p7TpPncinFEDqw2MOqLy/t56dwg6aHZyHECXV8gt
	SKv0o5WLMNRVbMod5LQ2O7TjL61gm7aZoE22uAfwFXg9zfXlvebdSyk9K+HFlTk63X4dre0xUSF
	+ktp1UQ/ryreHb49Q/NvfR0q6ex8A=
X-Google-Smtp-Source: AGHT+IGX+H47LvTOZvJY2p32Lu/R40fOKg5MRKHIVtyz/ONyDGGZ7YAR8vn/V+zevzmjFEIZ6YxBfg==
X-Received: by 2002:a05:6a20:4310:b0:35e:6c3:c8de with SMTP id adf61e73a8af0-36617e8d07bmr11175660637.34.1765282443851;
        Tue, 09 Dec 2025 04:14:03 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0724e9888esm4776a12.14.2025.12.09.04.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 04:14:02 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v3 2/2] tracing: Update funcgraph-retval documentation
Date: Tue,  9 Dec 2025 20:13:49 +0800
Message-Id: <20251209121349.525641-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251209121349.525641-1-dolinux.peng@gmail.com>
References: <20251209121349.525641-1-dolinux.peng@gmail.com>
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
 Documentation/trace/ftrace.rst | 78 ++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index d1f313a5f4ad..03c8c433c803 100644
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
+    1)   0.732 us    |              cgroup_taskset_next(); /* ret=0xffff93fc8fb20000 */
+    1)   1.232 us    |            } /* cgroup_taskset_first ret=0xffff93fc8fb20000 */
+    1)   0.380 us    |            sched_rt_can_attach(); /* ret=0x0 */
+    1)   2.335 us    |          } /* cpu_cgroup_can_attach ret=0xffffffea */
+    1)   4.369 us    |        } /* cgroup_migrate_execute ret=0xffffffea */
     1)   7.143 us    |      } /* cgroup_migrate = 0xffffffea */
 
-At present, there are some limitations when using the funcgraph-retval
-option, and these limitations will be eliminated in the future:
+Note that there are some limitations when using the funcgraph-retval
+option:
+
+- If CONFIG_DEBUG_INFO_BTF is disabled (n), a return value is printed even for
+  functions with a void return type. When CONFIG_DEBUG_INFO_BTF is enabled (y),
+  the return value is printed only for non-void functions.
 
-- Even if the function return type is void, a return value will still
-  be printed, and you can just ignore it.
+- If a return value occupies multiple registers, only the value in the first
+  register is recorded and printed. For example, on the x86 architecture, a
+  64-bit return value is stored across eax (lower 32 bits) and edx (upper 32 bits),
+  but only the contents of eax are captured. If CONFIG_DEBUG_INFO_BTF is enabled,
+  the suffix "(trunc)" is appended to the printed value to indicate that the
+  output may be truncated because high-order register contents are omitted.
 
-- Even if return values are stored in multiple registers, only the
-  value contained in the first register will be recorded and printed.
-  To illustrate, in the x86 architecture, eax and edx are used to store
-  a 64-bit return value, with the lower 32 bits saved in eax and the
-  upper 32 bits saved in edx. However, only the value stored in eax
-  will be recorded and printed.
+- Under certain procedure-call standards (e.g., arm64's AAPCS64), when the return
+  type is smaller than a general-purpose register (GPR), the caller is responsible
+  for narrowing the value; the upper bits of the register may contain undefined data.
+  For instance, when a u8 is returned in 64-bit GPR, bits [63:8] can hold arbitrary
+  values, especially when larger types are truncated (explicitly or implicitly). It
+  is therefore advisable to inspect the code in such cases. If CONFIG_DEBUG_INFO_BTF
+  is enabled (y), the return value is automatically trimmed to the width of the return
+  type.
 
-- In certain procedure call standards, such as arm64's AAPCS64, when a
-  type is smaller than a GPR, it is the responsibility of the consumer
-  to perform the narrowing, and the upper bits may contain UNKNOWN values.
-  Therefore, it is advisable to check the code for such cases. For instance,
-  when using a u8 in a 64-bit GPR, bits [63:8] may contain arbitrary values,
-  especially when larger types are truncated, whether explicitly or implicitly.
-  Here are some specific cases to illustrate this point:
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


