Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E318120247
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 11:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfLPKYS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 05:24:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39356 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727070AbfLPKYR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Dec 2019 05:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576491856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RFU4tPXHiyF5aYxO9pyn8VgUnU9YEjy9VpkSc1zyn5o=;
        b=dvIDbNL6szl1fh2toIzkg+vDuHNLUAQ4YSiZbHHq+B88X0FN5BZwgaLNZdmTgJVYJA5txk
        +pk1XU6joIyxMMg66qt666Tlg1WHPbeT9pbkP/+/7CLq2NA5rstDh4cNIK5dL2UNb8fF1b
        Mfl46tmhB+phk9xOJR2gDt3SYPGRyMk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-ZpRitP2PPUG73S3xoy4D3g-1; Mon, 16 Dec 2019 05:24:14 -0500
X-MC-Unique: ZpRitP2PPUG73S3xoy4D3g-1
Received: by mail-lf1-f69.google.com with SMTP id h7so475114lfp.20
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 02:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFU4tPXHiyF5aYxO9pyn8VgUnU9YEjy9VpkSc1zyn5o=;
        b=FKbuRZ0L6P/A+xJ8WIlg36i9wV/lPbLSwkyZHmu9yvJiZ4yGc6BIVUZZCK/jZ1tpBG
         MCpPqtkotCjJX1ytPpD6J6OuT9RSuXJyxts1UqEXTwrynjjSZoxMA0X+xt+0KGRCTlws
         eZKM+00arsP+mnClu0a7I7yO3HGJ4fPEGOK8ieNTaO8ZlLYMRYsPgGY5d1caltGTyvHq
         XgbxIYnfRYWPkDgG1g9UkoChbv6Nql/7CzoO+9xMgIP4QnM0PbEp638+7Hzz7S3VtQvF
         Wd6NTme8+kUh32u0IuKoX8UnG7ekPlEJBpgXPeDgnW/Js5VUYd4mYeVVhDRP9koDQNXC
         5f0w==
X-Gm-Message-State: APjAAAVIL3oFM2WH47hQb4TGmqlx43xWynpoSJtmrT3MeVSEhuv7ZOlY
        I+11dUTV5iOJsiuHFsaG+kiX//iNzpcSAfqgXtoImkCDjOkITX/2XZWx8GJAj29heP3qjLEYKNF
        iBqi1/jye5eTb
X-Received: by 2002:a05:6512:48c:: with SMTP id v12mr16580121lfq.56.1576491853510;
        Mon, 16 Dec 2019 02:24:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyA18z62Rzo+ToA3TXc0ALhkIIhVIByPHlctWEzIt7N3SZiz4XBZPpv3n9nTXEbn8ENAZEVw==
X-Received: by 2002:a05:6512:48c:: with SMTP id v12mr16580110lfq.56.1576491853282;
        Mon, 16 Dec 2019 02:24:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u20sm10203028lju.34.2019.12.16.02.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:24:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D1C101819EB; Mon, 16 Dec 2019 11:24:11 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next] samples/bpf: Add missing -lz to TPROGS_LDLIBS
Date:   Mon, 16 Dec 2019 11:24:05 +0100
Message-Id: <20191216102405.353834-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since libbpf now links against zlib, this needs to be included in the
linker invocation for the userspace programs in samples/bpf that link
statically against libbpf.

Fixes: 166750bc1dd2 ("libbpf: Support libbpf-provided extern variables")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 1fc42ad8ff49..b00651608765 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -196,7 +196,7 @@ endif
 
 TPROGCFLAGS_bpf_load.o += -Wno-unused-variable
 
-TPROGS_LDLIBS			+= $(LIBBPF) -lelf
+TPROGS_LDLIBS			+= $(LIBBPF) -lelf -lz
 TPROGLDLIBS_tracex4		+= -lrt
 TPROGLDLIBS_trace_output	+= -lrt
 TPROGLDLIBS_map_perf_test	+= -lrt
-- 
2.24.0

