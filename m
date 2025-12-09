Return-Path: <bpf+bounces-76363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E87CAFE13
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 13:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F76B304DEC5
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806233218B2;
	Tue,  9 Dec 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0SDXiqS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30232D321B
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282440; cv=none; b=lfoYeHy8YoIHKv54en3kIbc5HZAZtFitGPwFTUsQZKopvYLAYkABbSaL7L1eu706ijIs5zpyvDwkuReWvBLgFOB522mwZbd2vsDmOxrKSpLl2XjgA7yGCPLliDJRfvkoG2nX/A/QD6bI7ZnCfPtsiUO8vCK2yK3h/n7TF7yLXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282440; c=relaxed/simple;
	bh=hqZJhBlk8E0uWqAszsGWdn6uwEpnAkl70yRVFX1r8vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HISXXOqUV7nDeIjvdw9uBndMYr0G9sM0WXAw2AYA99P0EhCUUT58qD0/ECoBDsbShQWE4WuFQO/q5/94z7bhKhlJvwqyxCiYPFt8Pc6mjcyY5Cc1iQyWJMiY7QiFbw80i88PV7qaz/6FybPHd5E0AXoxXWpg3ys6edv2jGMmQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0SDXiqS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so6081524b3a.2
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 04:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765282438; x=1765887238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9P06umUEfXCiGuidNyWvy9LA75ynGEE6DkaxamGroo=;
        b=T0SDXiqSwMJ6sxz/ksgjMVlehLw1p+VauuDE6+Dw7vPGhEsGN2Wmwn6/dhb22VSX6S
         KuM+2b8QTsspPdoTJYXvVymfo5f1LMI97AjnGQ3dWuB+KsH7Ri5xiNjZBktM+TUuHJqq
         LuHwNl/rw26tAYWazveTjLWufLNpf5bn5yNFMnbNXjbRj8uhtvgty2icYruuenItKTCO
         pjRFqP1vMnbQmBjxAvFAotVqmYqH8BdBwRiD2fJEjXoooOiyAPNVEDzgQikk2g3CGCji
         IYOoq4arBnrs3TOfYgnl6nlCkqh2qVt4OIetPZu5MBu5W56O+kixI5qv8lWOZZgk2zZi
         yldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765282438; x=1765887238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9P06umUEfXCiGuidNyWvy9LA75ynGEE6DkaxamGroo=;
        b=c/imzDrtVIfthsVLBqFdQNR696TKjNf9a/Abfxe2nhaLjrZXk7R9O0sM4djN7UdzVs
         B33ysnb6tH2mRD8WsMwDRUDwPa45Dxy8YVSOjrk1Te5y137tD3GazO+qZJySkYaEMFVV
         d4iGlnh0TooZBvTuTixBGeNfJBVjvHH+Ai7I0bhNJmxrSiWirOGTA3BdcMMLinzs8zll
         2MaJVmFNouFUar81RPr2DGdAMJy4CwmmLTk0pafJhWIWwE0s4y15ZqV8unBOo/DyWTTe
         slCgGpVRov5tOUSt32lbEW8fZlox7R4tWSW9lmA4bH/5lRhacmJJ5FHez16mPGUStLjQ
         CUSg==
X-Forwarded-Encrypted: i=1; AJvYcCXpIUxOFX4zo8LrnO9bHJP2+AgFfiPnEF8boiN9+3E9JCUaD5qJHL+YILmJ/gyYJClxwJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hIRFoI7HTks1UaPjrs1FhKBoqfVFK4LlHqtvnE/kjyM2bA74
	dWcoWwhkT6auGx3etK8kW/PQkOBwCW4MxXxLI3AAT+Fhfh9b1L8J84EG2v10VFfMO8c=
X-Gm-Gg: ASbGncs33iePw6gq9Os43LfP463rKKAedY612DieYUJ1+XY4SrI5RwSoerWRWjMC/fk
	c7Y6wmxT8UOnvc6qnW30XNNFFiNbkuNKlf92wufsCdVHbMgPcLcEYupVMlMa/kuHsR0epxHolza
	X+/BsP1fIMUxLbTwNeXeHD/BH4yKBRLQkv7d7qW7tgiMcHGaQhiCMUxIL3damIOGt78mD9Hk461
	sJ0nIOc9saRMMqUKfzzGONsCF5KbQRat0Qr4n3s0r34ZaugORfJR0K6Yc9zkmd7n0iDiR2jn+Ua
	PjWGQYrcmjqlTLK0GUmVD4By9/RVfkQTrSTx6feflnpUhGBNCXz04tN06oV2u37rtpFNZurzXOb
	9tfCkgz8I7ITjsfITl0fAHskIDjkTeDswAXhG8zm0Izl5WCkVjWVi9vYaZa0TqKdtaPiz46FLc/
	JxP8LGsEZvmAJEsBHlrfi9aBo3Y8mEe+Q6hTZhiw==
X-Google-Smtp-Source: AGHT+IHNd0JoDbjVHcFvgyK84UO3DpBZXx0uJFjuxTNHxDk4OSzSd5kiG95BNaY3jJ6b67Xqz7lfmQ==
X-Received: by 2002:a05:6a00:18a2:b0:7e8:450c:61ce with SMTP id d2e1a72fcca58-7e8c63bbfe6mr10676948b3a.62.1765282437877;
        Tue, 09 Dec 2025 04:13:57 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0724e9888esm4776a12.14.2025.12.09.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 04:13:56 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 0/2] Use BTF to trim return values
Date: Tue,  9 Dec 2025 20:13:47 +0800
Message-Id: <20251209121349.525641-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

This patch series addresses two limitations of the funcgraph-retval feature:

1. Void-returning functions still print a return value, creating misleading
   noise in the trace output.

2. For functions returning narrower types (e.g., char, short), the displayed
   value can be incorrect because high bits of the register may contain
   undefined data.

By leveraging BTF to obtain precise return type information, we now:

1. Void function filtering: Functions with void return type no longer
   display any return value in the trace output, eliminating unnecessary
   clutter.

2. Type-aware value formatting: The return value is now properly truncated to
   match the actual width of the return type before being displayed.
   Additionally, the value is formatted according to its type for better human
   readability.

Here is an output comparison:

Before:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 1)               |   touch_atime() {
 1)               |     atime_needs_update() {
 1)   0.069 us    |       make_vfsuid(); /* ret=0x0 */
 1)   0.067 us    |       make_vfsgid(); /* ret=0x0 */
 1)               |       current_time() {
 1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=0x187f886aec3ed6f5 */
 1)   0.352 us    |       } /* current_time ret=0x69380753 */
 1)   0.792 us    |     } /* atime_needs_update ret=0x0 */
 1)   0.937 us    |   } /* touch_atime ret=0x0 */

After:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 2)               |   touch_atime() {
 2)               |     atime_needs_update() {
 2)   0.070 us    |       make_vfsuid(); /* ret=0x0 */
 2)   0.070 us    |       make_vfsgid(); /* ret=0x0 */
 2)               |       current_time() {
 2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
 2)   0.312 us    |       } /* current_time ret=0x69380649(trunc) */
 2)   0.753 us    |     } /* atime_needs_update ret=false */
 2)   0.899 us    |   } /* touch_atime */

Note: enabling funcgraph-retval now adds overhead due to repeated btf_find_by_name_kind()
calls during trace output. A separate series [1] optimizes this function with
binary search (O(log n) vs current O(n)), which will greatly reduce the impact.

Here is a performance comparison:

1. Original funcgraph-retval:
# time cat trace | wc -l
101024

real    0m0.682s
user    0m0.000s
sys     0m0.695s

2. Enhanced funcgraph-retval:
# time cat trace | wc -l
99326

real    0m12.886s
user    0m0.010s
sys     0m12.680s

3. Enhanced funcgraph-retval + optimizined btf_find_by_name_kind:
# time cat trace | wc -l
102922

real    0m0.794s
user    0m0.000s
sys     0m0.810s

Changelog:
v3:
- Print the return value based on its type for human readability, thanks Masami
- Update documentation and cover letter

v2:
- Link: https://lore.kernel.org/all/20251208131917.2444620-1-dolinux.peng@gmail.com/
- Update the funcgraph-retval documentation
- Revise the cover letter

v1:
- Link: https://lore.kernel.org/all/20251207142742.229924-1-dolinux.peng@gmail.com/

[1] https://lore.kernel.org/all/20251208062353.1702672-1-dolinux.peng@gmail.com/

pengdonglin (2):
  fgraph: Enhance funcgraph-retval with BTF-based type-aware output
  tracing: Update funcgraph-retval documentation

 Documentation/trace/ftrace.rst       |  78 ++++++++++-------
 kernel/trace/trace_functions_graph.c | 124 ++++++++++++++++++++++++---
 2 files changed, 156 insertions(+), 46 deletions(-)

-- 
2.34.1


