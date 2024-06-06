Return-Path: <bpf+bounces-31543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53108FF77B
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 00:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7B11F249C7
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 22:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF4C770E0;
	Thu,  6 Jun 2024 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QwQyFSBc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8913C676
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711416; cv=none; b=iqcnw6/RBsGfdkAWlautRum9ztRF2OKWihS+sTpXgittbwpwWnxNW/LYL/xplLCPGVGP8H6EwoyGIO0R2bakptzJdu9eong5yRo4UcOnyo09zSY4u8nXiECrrLUzClG2I6bXEdx8SGCwGezyVMiCgYkYWopvsRb9LawgBy+TsYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711416; c=relaxed/simple;
	bh=6zHTFtyjyc8ZROYDuvlHxVG4z9aX7uUzqgUziBlScV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a6DOLdJzMr/mvWl9gwkshGgavY+T62QnWHzVxNq17vLdqVWMDkfZGqwTqI8/m0Xzgl4sZT5tbHrMgQnsDK6eijOHBdgeb/xW7aT+eHng3ZUlnIdmS7T5fGC+JsLyqMFA9KSdpoteT9x43XqKLYSGzG0gjw5iItgy87k8ECKZTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QwQyFSBc; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-24c9f91242dso785984fac.2
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717711412; x=1718316212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wDM63n5dL+21LExRtL5y1UFCD0UbVulDhww3WIg9SE=;
        b=QwQyFSBcfp2g41G+FHQ/VK/EUbVkTdwDeFcm6uR4oD4gA81cUfE3nek7M0ZYnhfx5N
         Hm1OonWuH6h1DC4pkY5Lhc0VdcErJcO+6d9PXL7TJ+l/7kLw7Nk/1t5NY0cq6x8HyhW/
         /0rT0csvsuQbpFXqEBcweWBtcxiERuflI+KjO7oYxn+84Ew/InYh2U+GdgmEvUvFC/2M
         v+9UQsbl9are8ONe8vjiwNrL/dBdDpzX271u+LllVeQV35IqhGBoODfzqrSXy/XHtwiF
         IYnzDUCOvl0dgfQzc9I9nL8IjezAVLfv23SbcmhEB6oJUeZ6TfGpvcxCwGJQJMSIbCmh
         k9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717711412; x=1718316212;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wDM63n5dL+21LExRtL5y1UFCD0UbVulDhww3WIg9SE=;
        b=uBfxLsoFyLcrbVVLbirzDbgWOSgvifm1vf/iOx79RJ1vUGlQsQuNQxgdjAflXEj/Ot
         UhNKJ38zktQxtwAWheDCprdYnyymaUK2UGdHkHfEI5eMOrwFaKtcRzt47cCMGhL7OiON
         eHJjpMDe6KhkIRmoiFK0LiELhXNC4qAy0qWuCGIz4Pap/9BOEEJiePeAqsXTigUicYc9
         IpcoM47bq+IdiqeSRWJXZks7+xovO2x9oZp/Ej90OtRB8WLBHG/kzOjBOSkAWmfn7hpR
         6JPV4eCP18kJWN2vHxZdcUiw1vpNIibksFKPrY+F51oeNE8C3vNqvT/O2p33PWSzut+O
         tk7Q==
X-Gm-Message-State: AOJu0YyGke/uNn4QXBgJcud+mKTUDxqOEnLN9OU+FoDMeBqi5wZntlkO
	N7V11YZtiXHV2MUbCWOtIc/DVSmAFjXtq9DKG8WtR1a/T9Wu8MKcYjM8IIQBYfu0nlb1SzfNJSR
	6
X-Google-Smtp-Source: AGHT+IG/0LJK/LYZt1TScgAkfwqyKdYiu7tpO1/B6Nqtbi/uT1FR0Axg2DTSlln1Q0y9koT0Q5Fz9g==
X-Received: by 2002:a05:6870:8a10:b0:24f:f609:357f with SMTP id 586e51a60fabf-2546462d296mr832678fac.38.1717711412461;
        Thu, 06 Jun 2024 15:03:32 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79538974213sm53450685a.22.2024.06.06.15.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:03:31 -0700 (PDT)
Date: Thu, 6 Jun 2024 15:03:29 -0700
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: kernel-team@cloudflare.com
Subject: Ideal way to read FUNC_PROTO in raw tp?
Message-ID: <ZmIyMfRSp9DpU7dF@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

 I am building a tracing program around workqueue. But I encountered
following problem when I try to record a function pointer value from
trace_workqueue_execute_end on net-next kernel:

...
libbpf: prog 'workqueue_end': BPF program load failed: Permission
denied
libbpf: prog 'workqueue_end': -- BEGIN PROG LOAD LOG --
reg type unsupported for arg#0 function workqueue_end#5
0: R1=ctx(off=0,imm=0) R10=fp0
; int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
0: (79) r3 = *(u64 *)(r1 +8)
func 'workqueue_execute_end' arg1 type FUNC_PROTO is not a struct
invalid bpf_context access off=8 size=8
processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'workqueue_end': failed to load: -13
libbpf: failed to load object 'configs/test.bpf.o'
Error: failed to load object file
Warning: bpftool is now running in libbpf strict mode and has more
stringent requirements about BPF programs.
If it used to work for this object file but now doesn't, see --legacy
option for more details.
...

A simple reproducer for me is like:
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

SEC("tp_btf/workqueue_execute_end")
int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
{
        u64 addr = (u64) f;
        bpf_printk("f is %lu\n", addr);

        return 0;
}

char LICENSE[] SEC("license") = "GPL";

I would like to use the function address to decode the kernel symbol
and track execution of these functions. Replacing raw tp to regular tp
solves the problem, but I am wondering if there is any go-to approach
to read the pointer value in a raw tp? Doesn't seem to find one in
selftests/samples. If not, does it make sense if we allow it in
the verifier for tracing programs like the attached patch?

Yan

---
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 821063660d9f..5f000ab4c8d0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6308,6 +6308,11 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
                        __btf_name_by_offset(btf, t->name_off),
                        btf_type_str(t));
                return false;
+       } else if (prog->type == BPF_PROG_TYPE_TRACING || prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT) {
+               /* allow reading function pointer value from a tracing program */
+               const struct btf_type *pointed = btf_type_by_id(btf, t->type);
+               if (btf_type_is_func_proto(pointed))
+                       return true;
        }

        /* check for PTR_TO_RDONLY_BUF_OR_NULL or PTR_TO_RDWR_BUF_OR_NULL */

