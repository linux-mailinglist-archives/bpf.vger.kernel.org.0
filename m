Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED071202BE
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 11:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLPKif (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 05:38:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52909 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727099AbfLPKif (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Dec 2019 05:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576492713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gf1efliaRWnpvAVh5vnGXcL2YmyXEHBK2in0V8Lblq4=;
        b=R6ttrI9P91VSTxTR2W423+eTR6qdQipV+cYrBO0WFcdyQhHOT64NkKfuQxQvMR4JHlD6rF
        lOmBaZNj6UXU3KqVtaDpty3cv8+jPaMYzZDJhcGUzyjC2mx7I1pO3l2ZlT72fZCwjUqn34
        tZtQF4kUrXvr5WfuaoGepwl1J8BjKmI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-5JNHVGC0OY-NgFfs4UqiVg-1; Mon, 16 Dec 2019 05:38:32 -0500
X-MC-Unique: 5JNHVGC0OY-NgFfs4UqiVg-1
Received: by mail-lj1-f198.google.com with SMTP id g28so1990655lja.6
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 02:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gf1efliaRWnpvAVh5vnGXcL2YmyXEHBK2in0V8Lblq4=;
        b=gCDjS4PjGbSaVRrq4n2sjpCd0Fxkk9QfO/bTFhH7LhzBryeNqYO/biI6vlXdwE+9Z/
         OtuKD4/cHj3KtcpksJnPGTxnZBaGZOgaJBrE+fK8ihEvHfIM1m6mvnyaO4iRa719o/ND
         sNlpwtntYlmj/rYasm8BFqW6BW8iXIneCTc5N+zxSGysN8lJN3oXYSEX3bbeRsYyo6T2
         v/rBMBI8A4FyZhJSTmnDQaYUPeJ/1MzVIFHj3T9rJm4EC9sYJZDPDn3k0RthTbYdF+gI
         VI/JR3Hhjd4f/AmDlH8o1y/qPUVeo6sDGn5Ivh7FF8la0yav2zEaqhGLwXkAzdU2APYW
         JFdw==
X-Gm-Message-State: APjAAAVV/DOm3TlBMbebVUFJHLgNQ2ZYQWuDaXos4t2BT61y3YsCQoZB
        jdYycwvyukALlicJKgpu7rqp53Er/yKBM3IIj9RqGzhsF5M5XmI0tx3gqsEqyJW6Umf1hZAiBjr
        Qx8r/Yn0la7d8
X-Received: by 2002:a19:86d7:: with SMTP id i206mr15713305lfd.119.1576492710572;
        Mon, 16 Dec 2019 02:38:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAC7blaaEIQuV426pWfsiM9hQDs8+KIaFApneIvLvnQjwG0S82ZHs7D2IVOlgI6seAYwiZEA==
X-Received: by 2002:a19:86d7:: with SMTP id i206mr15713293lfd.119.1576492710403;
        Mon, 16 Dec 2019 02:38:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y29sm10246562ljd.88.2019.12.16.02.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:38:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A55371819EB; Mon, 16 Dec 2019 11:38:28 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next] samples/bpf: Set -fno-stack-protector when building BPF programs
Date:   Mon, 16 Dec 2019 11:38:19 +0100
Message-Id: <20191216103819.359535-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It seems Clang can in some cases turn on stack protection by default, which
doesn't work with BPF. This was reported once before[0], but it seems the
flag to explicitly turn off the stack protector wasn't added to the
Makefile, so do that now.

The symptom of this is compile errors like the following:

error: <unknown>:0:0: in function bpf_prog1 i32 (%struct.__sk_buff*): A call to built-in function '__stack_chk_fail' is not supported.

[0] https://www.spinics.net/lists/netdev/msg556400.html

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index b00651608765..f51804ef12c3 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -234,6 +234,7 @@ BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
 			  readelf -S ./llvm_btf_verify.o | grep BTF; \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
+BPF_EXTRA_CFLAGS += -fno-stack-protector
 ifneq ($(BTF_LLVM_PROBE),)
 	BPF_EXTRA_CFLAGS += -g
 else
-- 
2.24.0

