Return-Path: <bpf+bounces-16490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73358801A2F
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 04:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B831C209E2
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 03:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35504613E;
	Sat,  2 Dec 2023 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY3pqeA9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CCC10D0;
	Fri,  1 Dec 2023 19:04:20 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso2885358b3a.0;
        Fri, 01 Dec 2023 19:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701486260; x=1702091060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REw1mAw66ScsuvDmlw17GMi/wuxgxUo9tJzn9xaikuM=;
        b=FY3pqeA9ckJ2ZSKqjg48Um9AFS1quCL78rSMpQArFzsN2J4UF9SPo6/VQRUKkP4CYA
         QdYFJYIiwCrZ6Gd91pT+kDDMk81ibGL+Rn9Paaa3KrcfzH85LzqReqM/Kngugn1f8/id
         eF9u/Ukkr+dQcnxMzJ6SF494c6W95CAveG2XOqX42Ok0p3iVkWMGFoOLDL+CTFj97PBZ
         x/apJ0XvaAw7/WTnly35mp2yLgFSYiRiahpHt+F/ISrtXnht93NU5PJ9sN3foYpjfwE4
         z9AsEyYN+6ZRWsdKFQ9laWDUc4sZl4+JGPuToUmdVdS+SyZu5FquCYzq1c5HzZQCfAyw
         w5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701486260; x=1702091060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REw1mAw66ScsuvDmlw17GMi/wuxgxUo9tJzn9xaikuM=;
        b=DAt/Z4UArBbvHjJNpcLsDOtiDhEZByyT3UaCQb2TSzFFDQk99ufUo/eLuMVKwvMICq
         63uhGqm1pAUipGImu6EKSE8cy/Kh3a0lWLdPnlw1K3j7v1YV6s8T/ukvD8ze8AafSGWO
         jjNk2LccKCHHWg0hVBzuzwuDY0N3mZ6NMrKIxCKUYy8Dgz/wCjawM19aGL9loXLG6t6z
         RF9dyioJ/8kaP7shEo60WOlr2Bsr96RlRI+1fPlhHg8sJr8DzNBkCcVHtlK9iFo9tA4Y
         YBXDNOJkwN+EqYtXDqKqvOWPJ2kjwm9AA7chEYAGpmvFtWkNM/48dCedvoa5CyUR+83+
         Duuw==
X-Gm-Message-State: AOJu0YyTUGplAsvfI2qHGvryEjDxhPijo3B0q8WAjx3DTyXHSASMLSZ1
	/VlPYSOoOqM4y8VhYTg6SGrkX+IG7pk=
X-Google-Smtp-Source: AGHT+IE3KFV19ADFs1mUPExAmlKdN0d9YGpc5JdEEyaRf6nN7+dLQCkmGfnxUJovZiUeI3jwAvt5QQ==
X-Received: by 2002:a05:6a00:438d:b0:6ce:2732:590 with SMTP id bt13-20020a056a00438d00b006ce27320590mr699706pfb.65.1701486259941;
        Fri, 01 Dec 2023 19:04:19 -0800 (PST)
Received: from localhost.lan ([2601:648:8900:1ba9:692:26ff:fed8:afdd])
        by smtp.gmail.com with ESMTPSA id j18-20020a056a00235200b006c345e192cfsm3644645pfj.119.2023.12.01.19.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 19:04:19 -0800 (PST)
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
Subject: [PATCH] 9p: prevent read overrun in protocol dump tracepoint
Date: Fri,  1 Dec 2023 19:04:10 -0800
Message-ID: <20231202030410.61047-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An out of bounds read can occur within the tracepoint 9p_protocol_dump().
In the fast assign, there is a memcpy that uses a constant size of 32
(macro definition as P9_PROTO_DUMP_SZ). When the copy is invoked, the
source buffer is not guaranteed match this size. It was found that in some
cases the source buffer size is less than 32, resulting in a read that
overruns.

The size of the source buffer seems to be known at the time of the
tracepoint being invoked. The allocations happen within p9_fcall_init(),
where the capacity field is set to the allocated size of the payload
buffer. This patch tries to fix the overrun by using the minimum of that
field (size of source buffer) and the size of destination buffer when
performing the copy.

A repro can be performed by different ways. The simplest might just be
mounting a shared filesystem (between host and guest vm) using the plan
9 protocol while the tracepoint is enabled.

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
 include/trace/events/9p.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/9p.h b/include/trace/events/9p.h
index 4dfa6d7f83ba..8690a7086252 100644
--- a/include/trace/events/9p.h
+++ b/include/trace/events/9p.h
@@ -185,7 +185,8 @@ TRACE_EVENT(9p_protocol_dump,
 		    __entry->clnt   =  clnt;
 		    __entry->type   =  pdu->id;
 		    __entry->tag    =  pdu->tag;
-		    memcpy(__entry->line, pdu->sdata, P9_PROTO_DUMP_SZ);
+		    memcpy(__entry->line, pdu->sdata,
+				min(pdu->capacity, P9_PROTO_DUMP_SZ));
 		    ),
 	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
 		      (unsigned long)__entry->clnt, show_9p_op(__entry->type),
-- 
2.43.0


