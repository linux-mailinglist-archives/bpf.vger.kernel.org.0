Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D5220F1
	for <lists+bpf@lfdr.de>; Sat, 18 May 2019 02:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfERArB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 May 2019 20:47:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33103 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfERAq5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 May 2019 20:46:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so10325758wme.0
        for <bpf@vger.kernel.org>; Fri, 17 May 2019 17:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVHOEkVV9mlfbXiBNiOTGc9iVLu9GHw8uX4Flvc6nzM=;
        b=K7hDMd6YFWWxfPuD8F7ysJmrLSbsHc8RvotRYcsCNvt2MHG9Zjic5c+UYWgsk6QpXM
         0S0Q3AKythkZoZmRmkkrjVAnHVfkCEGjs/DwGb7+FkCyFwWOFEbV2rqv3hRgdi1iVnQs
         Wgq3Rx7vT22JpNZi5yhIsJJl/PvG8JuNBkLT1Bn38FMXHxxVa728Y2CDvzmi+dpL+RHO
         MU4Gpt9TEzcBDoVyesrYcFbWjqCG6C73UzS+yNk5UwuyYkivXXg8QO0QZ5w2HB2cirHb
         OS1BGj9ebQXS2XrE4otKQ1UEg0MvmBxpDcmFtYfcK2xpwDPfOi3lw9gpDALK/mMfRb6l
         uYwg==
X-Gm-Message-State: APjAAAUo9dZNu3Tm6n1+n+qBkcRXDRvViBPID8/SN07axzXl2zvtzqkw
        hYUm4e9RP68uAItwRY6dKei6eA==
X-Google-Smtp-Source: APXvYqz9dVgMCVBct1AsG2RXTM2TI8XXuNWqSFcJ7VB0m1uiNeGfnNjK+La84/2whwbjh7SsBSR/0Q==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr4206756wmc.130.1558140415076;
        Fri, 17 May 2019 17:46:55 -0700 (PDT)
Received: from raver.teknoraver.net (net-47-53-225-211.cust.vodafonedsl.it. [47.53.225.211])
        by smtp.gmail.com with ESMTPSA id b12sm12189924wmg.27.2019.05.17.17.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 17:46:54 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 2/5] libbpf: add missing typedef
Date:   Sat, 18 May 2019 02:46:36 +0200
Message-Id: <20190518004639.20648-2-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190518004639.20648-1-mcroce@redhat.com>
References: <20190518004639.20648-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync tools/include/linux/types.h with the UAPI one to fix this build error:

make -C samples/bpf/../../tools/lib/bpf/ RM='rm -rf' LDFLAGS= srctree=samples/bpf/../../ O=
  HOSTCC  samples/bpf/sock_example
In file included from samples/bpf/sock_example.c:27:
/usr/include/linux/ip.h:102:2: error: unknown type name ‘__sum16’
  102 |  __sum16 check;
      |  ^~~~~~~
make[2]: *** [scripts/Makefile.host:92: samples/bpf/sock_example] Error 1
make[1]: *** [Makefile:1763: samples/bpf/] Error 2

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 tools/include/linux/types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 154eb4e3ca7c..5266dbfee945 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -58,6 +58,9 @@ typedef __u32 __bitwise __be32;
 typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
 
+typedef __u16 __bitwise __sum16;
+typedef __u32 __bitwise __wsum;
+
 typedef struct {
 	int counter;
 } atomic_t;
-- 
2.21.0

