Return-Path: <bpf+bounces-28351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654848B8CA5
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C829283D17
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCE813442D;
	Wed,  1 May 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhSKlZ6M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5B133998;
	Wed,  1 May 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576441; cv=none; b=SWK2HKiE4Hqw6xKFYHMuSekUq42f6YB/dTdzqU249kno68TxUk73bjCdpHVxIGlFHaWgYcPE02I4qV4vfR4sYypgZyhIEmALx8y2KcTTONRVb7iz4M+LKPhGc/cDwJpOgE0+tTvHLkjkpgwKthdLDnkobAnHj9Wwj7d5u240oBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576441; c=relaxed/simple;
	bh=kUgdwRe/dvuT4mKQwJOJlVfT4LfqbdBN0nt3UpjpKHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Muqr8AB6N3CggELymXOH5hyYTv+fszygd1v3tfX7ObCPYRuHFV4vvDH3jM9s9QvpbNmRC0Do+qCCnY722q0B3kQhAJ6iMU674m9ORoDWCf1tbZ+or+ehS03ukGlOq+yR+4ZWfbM2EosQXsa+Mr5Mx4u/Lu4GYqQ3RYUvt30z/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhSKlZ6M; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-53fa455cd94so5286465a12.2;
        Wed, 01 May 2024 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576439; x=1715181239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR22YA52Nel5m0t8m3tWAaTfqlEF+PwOrjXP0qnqYfo=;
        b=YhSKlZ6MD1FVs6U12sg7N3qU2Xer3cP6B82mEmbct4TLQzIW4tK5P8rvA9gFhjH1Ht
         n6HmX2V8FVd0oiZvhMdN+C8MPDbYlByIU97YMnGcQG6pMnL9Ei6ReBr5KF0d5pTb3g9/
         1sjzVu5WHbnIwBGdTM0dbX4fVE6b18rOVzIFQ6QjEEIjIOkDnjE2ZM/Cz2YCzg24Q9eY
         Wue+GJW0KhmO4SukE3pNQd01OFqRTcnHZjVCgIR302cNVjWHXJwWjzyFHwyDrtVSHmml
         LTkp7LCMgdO6ui/hoCXMTPpkCfojnfp2GyzJuGVJKoDvFQrMugFiFHTxWpJpwS2G+JKn
         23gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576439; x=1715181239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TR22YA52Nel5m0t8m3tWAaTfqlEF+PwOrjXP0qnqYfo=;
        b=CHalsoHnAzhixMRInnq+afsukXRVf5KzNVDK6GGIoluHgO3JfH5jusAh1RGYtiy4gq
         rpJCg6x5xy50W1as9lCV46buGyTjpjq9vWxASf0jUotOTnSJM7QTePwxjjk722u/eTZV
         NI3me61wkNDHuyORDx98s6rWusk0OWgXzCY4gCAMX3uFqovCg2dmd46xAHeVolTYcmCt
         S/7oEUI68g7N08TN6HnEjS2YFRxnY7AZ7CXiZ/aSg8mfxcg7rMljOkMPafZ7nv7KQSKi
         biOAUhIxOzZENXHrTkAV7qJvUAMLl6PZ5YI4REa5KrAyecobpYAyRoIOVeO7CvFKR/pv
         MLQw==
X-Forwarded-Encrypted: i=1; AJvYcCVu+oubgPkRkLyVSfivqam4El7jdSlvnp1c+/XOOSHJnvMJzNBa/D9Qd+0p0tM+7M7RNiW6EnhlXjvKBvaiBk0LOJWI
X-Gm-Message-State: AOJu0Yy4BHhVCVwuHn7RV/suSQ5ENBjeN8tPyp0z2HQpTC/LBKX5cdJl
	laW7IPAIpLn+6Zx/xxGvU4GvQJIhh1uzYMWq41dIJSQyvnjg//fX
X-Google-Smtp-Source: AGHT+IHZovs4r3pLuRTVYtTd1RkoXlvwqI07haaXMJTuD+Q62zESDUuqIzVuRmmmcmbugfO3Bb8ZtA==
X-Received: by 2002:a17:90a:9a88:b0:2b2:a1f1:22cc with SMTP id e8-20020a17090a9a8800b002b2a1f122ccmr2415908pjp.41.1714576438908;
        Wed, 01 May 2024 08:13:58 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001e49bce9d40sm24242481plf.128.2024.05.01.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 21/39] tools/sched_ext: Add scx_show_state.py
Date: Wed,  1 May 2024 05:09:56 -1000
Message-ID: <20240501151312.635565-22-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are states which are interesting but don't quite fit the interface
exposed under /sys/kernel/sched_ext. Add tools/scx_show_state.py to show
them.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 tools/sched_ext/scx_show_state.py | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 tools/sched_ext/scx_show_state.py

diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show_state.py
new file mode 100644
index 000000000000..d457d2a74e1e
--- /dev/null
+++ b/tools/sched_ext/scx_show_state.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2024 Tejun Heo <tj@kernel.org>
+# Copyright (C) 2024 Meta Platforms, Inc. and affiliates.
+
+desc = """
+This is a drgn script to show the current sched_ext state.
+For more info on drgn, visit https://github.com/osandov/drgn.
+"""
+
+import drgn
+import sys
+
+def err(s):
+    print(s, file=sys.stderr, flush=True)
+    sys.exit(1)
+
+def read_int(name):
+    return int(prog[name].value_())
+
+def read_atomic(name):
+    return prog[name].counter.value_()
+
+def read_static_key(name):
+    return prog[name].key.enabled.counter.value_()
+
+def ops_state_str(state):
+    return prog['scx_ops_enable_state_str'][state].string_().decode()
+
+ops = prog['scx_ops']
+enable_state = read_atomic("scx_ops_enable_state_var")
+
+print(f'ops           : {ops.name.string_().decode()}')
+print(f'enabled       : {read_static_key("__scx_ops_enabled")}')
+print(f'switching_all : {read_int("scx_switching_all")}')
+print(f'switched_all  : {read_static_key("__scx_switched_all")}')
+print(f'enable_state  : {ops_state_str(enable_state)} ({enable_state})')
+print(f'bypass_depth  : {read_atomic("scx_ops_bypass_depth")}')
+print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
-- 
2.44.0


