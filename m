Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBDD628920
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiKNTRO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbiKNTRB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:17:01 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC927CF1
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:58 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id b62so11113039pgc.0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvMB46Vqr7eLH23u46H2EgXkWOTOPfK9QqKgaAYTLEg=;
        b=VN63TrDtzjbKb6NMp2HlbVGHkd5LmqMZ2B+nuEN98/MEfHAfLQiAoLsY6UpPKarJlv
         QysVphllI2X5m2+W0tnCKaVPxt6NsoY16CDPBODEYLGAvQyp5cFMvWMIAY2ADUSv2nlh
         4HZlObpDXLfrKphSRmj05RI+CDy8sr+6kbrqEyd8cz+hLVSFh5vv9nwVCndXYPkbai98
         FedckmKnA8cSAcOXOQWuk67JIOHTl68wyIrXKr+3JiAVbMOJh/Rk9KrcgDDwerZhrtHa
         NvrfnOJpbOWcozxuKTEogZCidwghbLBkGeqLqqd3APR+d3hvQajB4uXhrCEOO/x6jE6b
         mzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvMB46Vqr7eLH23u46H2EgXkWOTOPfK9QqKgaAYTLEg=;
        b=eZTpgl+eTFnxQCx6/ujMFGjAgPXpTe8swtBKy87zYep+qgE9WTjY0tOfYV6126MzXT
         3bSQiVc6DlmcbLtCjRwDl/GJ0vHKSczmoeSuI83ebk5YFlxy5XSwOrOiD2FVFz7Wf9wY
         uAngAeCFi8Ad3iQtwYQw2HdMQ9DrjHM4rOijwaw01cu0AvqG7HIuQYvMZ1Q28BPkC5br
         1vJYaTEObGVsVZNWXPnJ5AfriovsLxuMJedW/+TeHVktBts9svwSI2lJM9IhXyDVVE+D
         1wAp01rFEv/yhNxH83HcU0oGPcNSSmummnHq6JbT7994hblbY5as/fJ3EFjwXgPdmGaE
         GxPw==
X-Gm-Message-State: ANoB5pk7NaSXpjPQRQcrS9dtmIQk+V1BpAX0KBUwfx2sHq5Lc5LV4LI8
        K1ocSCTA+635gm1rOfTIgzilSfGhcTUL3Q==
X-Google-Smtp-Source: AA0mqf4AGaa8tfoFPIHbuaOXvCkm7khrMAcyFWVmhQOSBRSbniXpyF2Lg5/mPc38aH46NeD/+Khiyw==
X-Received: by 2002:a65:5908:0:b0:46f:1e8f:1633 with SMTP id f8-20020a655908000000b0046f1e8f1633mr12806431pgu.556.1668453417917;
        Mon, 14 Nov 2022 11:16:57 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id o1-20020aa79781000000b0056ba02feda1sm7268623pfp.94.2022.11.14.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:57 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 22/26] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Tue, 15 Nov 2022 00:45:43 +0530
Message-Id: <20221114191547.1694267-23-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=memxor@gmail.com; h=from:subject; bh=VcTPpE/Iv5Qqfs22C7MYEC67+XombxopywbBgVHOTXY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPJat2m++oaewJcZt2UDMupXoNxYDkyNqAT1xwv xR2sFL+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyQAKCRBM4MiGSL8RyrDfD/ 49lcztYLkqhJTXf3MAJmFopoj1vvxf3HjBxJSxsbzJ5pVVPb4mZFQ9PSLCakVjvvCf05lw20Uj673n gp1TqsZi4QFZBWS8wZj3UUy9tj/ikvSeM9Qa+x0HzNStqyslmol3hMqAUpNY4IbfN4kv4Q5cvnyuV9 guWPFmK325T/i8PZMfYwLiUboGPj7Pfni0xsYnHkdhxiaxy/naLOp292BAMcyZ8CZBI9apEw07IgeU Z/n08cQeCJLQtdQ0rX7ZHvl/zg/cuPoZKxvxEKZo87Ts7Rv6e4ztg4YNFRmzaKNrubHw7sjN5hu/2W 99TZZFiUW2G31LPSbfZR8xzDAN3xuiWlcDwOd+MLvLSYChdlwRG5WfjU0KVmRXhmHa8otiF6JrzZDH Ekf2n661gyq+eBM+uNr6zcDuOX0mnkUOTXFlI3jeJk7L048z51RaEThSvwP89FHdf/E1HY11qjMYyr Hix3W/9uWkxpeGpJDvAIudH0yIs4wQor5G01yoC5rLaPLHjirfkd68FPBTXxG/NlJy/lN5NWy8ZmAJ q2Sacnm3PHoM68WaTjyLMJe6Dg4mwSDZATOxrAY/DFa7Nd8nNiM9wmq1ktM3YPNhtOkvT/wYwiXE/o XsQtFBZO6Qw6HEkxIBzqfCRPNOG173eCmtze8Tma+oKc611pJBkzUh+FOR9A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add user facing __contains macro which provides a convenient wrapper
over the verbose kernel specific BTF declaration tag required to
annotate BPF list head structs in user types.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d6b143275e82..424f7bbbfe9b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -6,6 +6,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+
 /* Description
  *	Allocates an object of the type represented by 'local_type_id' in
  *	program BTF. User may use the bpf_core_type_id_local macro to pass the
-- 
2.38.1

