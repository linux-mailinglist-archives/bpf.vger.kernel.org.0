Return-Path: <bpf+bounces-16631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC31803F32
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 21:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3405B1C20A86
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8434188;
	Mon,  4 Dec 2023 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug47MDDG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF88AF;
	Mon,  4 Dec 2023 12:23:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d06d4d685aso12331255ad.3;
        Mon, 04 Dec 2023 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701721413; x=1702326213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVjS70OS71a4UFnI0/y09WP8jWT0Ha288mxabbPI+EM=;
        b=Ug47MDDG4aOpM3O9wq9p8ElFbBfnk/DefxmzXDN/SamO6Nzx0cgpsiTzBqjo7QJRva
         yrSBNSQ3n9Mdbz4edPKHvYZEeLwZER+xqRzt/5QR5e+tGDD92QmDDiw91O1bLbjeqEwu
         FJZwaU4l3PXPyZ5aX4rj/OSNu5+xZVr38tr3X8KtjukNgF1K+afrTtw2RyByFB6nLtKu
         Z0H2QyJK8YR8fPidbcYM68emww+fE7MgqzCEKxJEnp0/hXrTIkQkrlFFdc2ap546aYfS
         rAOsFYxrnEzQUbM57F86F7znLA0vj2oc8I8VSAo3XFIbZzYV/YrkROrGJxPHjt5//E2q
         dQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701721413; x=1702326213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVjS70OS71a4UFnI0/y09WP8jWT0Ha288mxabbPI+EM=;
        b=Zd3nDKcn28HHMimYg0ZzF3FuOvKkjjH6kDdRqEmS8MafvcWRobsbCIginyCWa6xRFE
         xY67Z/9EotM9XUhg+PvEasVh0hYFOOsjx2IoppnorknugXcLKwcHyCfG9pqf5dcDi7M0
         tquSx2kDXsujGgkk3jCFQ3AbpjUS6KRAnnbJwRe/8TbGsXV3DklRWQuoKLorw0nnuQK1
         lLU2U0wrhZnd+my5xACYO04ee0sQaUFaJTTu5SbwFanAAzH5TzNILhaG3LEH2GFo2TXz
         HJcDFwAAXR62/ak4W0wysUiBpnMDvOaQSo3EK6o93SgpThDbAfh/9jxBhngL3In0Ga1I
         c0vA==
X-Gm-Message-State: AOJu0YyB32hCa5V7CPLvnJNdeTlQbMY+JO9bfkhsfH+mlgpLX4yX8oYE
	8wIvHCtswERTIsuEaUQBcdk=
X-Google-Smtp-Source: AGHT+IEZnHypQNo+wnImWpW1CT4pRSkna+76zEAA20WYV5o93R7E6DkHV3NFild2kYTqVRC4Ks15zw==
X-Received: by 2002:a17:902:7616:b0:1d0:ad56:d879 with SMTP id k22-20020a170902761600b001d0ad56d879mr1335824pll.14.1701721413254;
        Mon, 04 Dec 2023 12:23:33 -0800 (PST)
Received: from localhost.lan ([2601:648:8900:1ba9:692:26ff:fed8:afdd])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902820e00b001cc52ca2dfbsm11740pln.120.2023.12.04.12.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:23:32 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: v9fs@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] 9p: prevent read overrun in protocol dump tracepoint
Date: Mon,  4 Dec 2023 12:23:20 -0800
Message-ID: <20231204202321.22730-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An out of bounds read can occur within the tracepoint 9p_protocol_dump. In
the fast assign, there is a memcpy that uses a constant size of 32 (macro
named P9_PROTO_DUMP_SZ). When the copy is invoked, the source buffer is not
guaranteed match this size.  It was found that in some cases the source
buffer size is less than 32, resulting in a read that overruns.

The size of the source buffer seems to be known at the time of the
tracepoint being invoked. The allocations happen within p9_fcall_init(),
where the capacity field is set to the allocated size of the payload
buffer. This patch tries to fix the overrun by changing the fixed array to
a dynamically sized array and using the minimum of the capacity value or
P9_PROTO_DUMP_SZ as its length. The trace log statement is adjusted to
account for this. Note that the trace log no longer splits the payload on
the first 16 bytes. The full payload is now logged to a single line.

To repro the orignal problem, operations to a plan 9 managed resource can
be used. The simplest approach might just be mounting a shared filesystem
(between host and guest vm) using the plan 9 protocol while the tracepoint
is enabled.

mount -t 9p -o trans=virtio <mount_tag> <mount_path>

The bpftrace program below can be used to show the out of bounds read.
Note that a recent version of bpftrace is needed for the raw tracepoint
support. The script was tested using v0.19.0.

/* from include/net/9p/9p.h */
struct p9_fcall {
    u32 size;
    u8 id;
    u16 tag;
    size_t offset;
    size_t capacity;
    struct kmem_cache *cache;
    u8 *sdata;
    bool zc;
};

tracepoint:9p:9p_protocol_dump
{
    /* out of bounds read can happen when this tracepoint is enabled */
}

rawtracepoint:9p_protocol_dump
{
    $pdu = (struct p9_fcall *)arg1;
    $dump_sz = (uint64)32;

    if ($dump_sz > $pdu->capacity) {
        printf("reading %zu bytes from src buffer of %zu bytes\n",
            $dump_sz, $pdu->capacity);
    }
}

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/trace/events/9p.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/9p.h b/include/trace/events/9p.h
index 4dfa6d7f83ba..cd104a1343e2 100644
--- a/include/trace/events/9p.h
+++ b/include/trace/events/9p.h
@@ -178,18 +178,21 @@ TRACE_EVENT(9p_protocol_dump,
 		    __field(	void *,		clnt				)
 		    __field(	__u8,		type				)
 		    __field(	__u16,		tag				)
-		    __array(	unsigned char,	line,	P9_PROTO_DUMP_SZ	)
+		    __dynamic_array(unsigned char, line,
+				min_t(size_t, pdu->capacity, P9_PROTO_DUMP_SZ))
 		    ),
 
 	    TP_fast_assign(
 		    __entry->clnt   =  clnt;
 		    __entry->type   =  pdu->id;
 		    __entry->tag    =  pdu->tag;
-		    memcpy(__entry->line, pdu->sdata, P9_PROTO_DUMP_SZ);
+		    memcpy(__get_dynamic_array(line), pdu->sdata,
+				__get_dynamic_array_len(line));
 		    ),
-	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
+	    TP_printk("clnt %lu %s(tag = %d)\n%*ph\n",
 		      (unsigned long)__entry->clnt, show_9p_op(__entry->type),
-		      __entry->tag, 0, __entry->line, 16, __entry->line + 16)
+		      __entry->tag, __get_dynamic_array_len(line),
+		      __get_dynamic_array(line))
  );
 
 
-- 
2.43.0


