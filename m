Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC494C5E94
	for <lists+bpf@lfdr.de>; Sun, 27 Feb 2022 21:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiB0U2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Feb 2022 15:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiB0U2i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Feb 2022 15:28:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E94504A
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 12:28:01 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g39so18019877lfv.10
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 12:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zqijjm9f7tE414H1e1di3FMcR+kw5fFe69s6gA4efr4=;
        b=lLEGl2DGEVO3ZvIOrGppxJamauD7zIofXhj5lXh0IKzk1PmgyF4oli6/76w7c/cqwu
         muE7bALaBVTAnRnAZ86H/dpKSKMwTEMfGYXCqw8NGlNWmHcmwlRMycF1ih6/FmHtp7Aq
         D0EW02dE4nfN6H8KT3JLKPELEFDuuMwewld1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zqijjm9f7tE414H1e1di3FMcR+kw5fFe69s6gA4efr4=;
        b=J3B3NcJGBfHQ5BwilkxEhXMH+pXVFfmpTPb8G3UXTt62RcGj6V4Aibiztgh6cai9/P
         EeGKWQqVTIEPZ7LMh813P7iBtGjdq47+cagl2MflIjVk5rBaCC3HMqb04JhXI33QLZl5
         lHIOVnAxvWcvz9hsmHd5iAyuSnUB1xacBHtPe8up3UUrBMRjXT2ubUb5DCd7mhEqEGzm
         krKLWQ/nYFDjaTF2BVVsB5qG4NY3vOzXLGMvrQX6uLQP4FizfiHaFg3UtnAPW4FLZmQu
         wfhXwqvgatSh8EmhZQqYdZnWZqe50rHNH/Gu0iW0bBxwojDF5fTPRIC/n7mVhssImkBx
         NbCQ==
X-Gm-Message-State: AOAM530+9k4tf2RNLBhMp6scxmzOuUUlnTlShVOzfoOqqKUwc3M+FYpn
        qUPB9SP4Wtw78yus9qHyefintaq/WGe6Vg==
X-Google-Smtp-Source: ABdhPJx+i2OT02nbPabwT9eRqdyR8GwEcURjomc8O/fKemItuayS/d16eCegvN+G5UlrmVOxZl37wQ==
X-Received: by 2002:a05:6512:260b:b0:444:18:fce5 with SMTP id bt11-20020a056512260b00b004440018fce5mr10599095lfb.119.1645993679281;
        Sun, 27 Feb 2022 12:27:59 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0f9c.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id q5-20020a19a405000000b00443128c6c2bsm728034lfc.289.2022.02.27.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 12:27:58 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Martin KaFai Lau <kafai@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: Fix error reporting from sock_fields programs
Date:   Sun, 27 Feb 2022 21:27:55 +0100
Message-Id: <20220227202757.519015-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227202757.519015-1-jakub@cloudflare.com>
References: <20220227202757.519015-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper macro that records an error in BPF programs that exercise sock
fields access has been inadvertently broken by adaptation work that happened
in commit b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel
and global variables").

BPF_NOEXIST flag cannot be used to update BPF_MAP_TYPE_ARRAY. The operation
always fails with -EEXIST, which in turn means the error never gets
recorded, and the checks for errors always pass.

Revert the change in update flags.

Fixes: b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel and global variables")
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/progs/test_sock_fields.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index 246f1f001813..3e2e3ee51cc9 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -114,7 +114,7 @@ static void tpcpy(struct bpf_tcp_sock *dst,
 
 #define RET_LOG() ({						\
 	linum = __LINE__;					\
-	bpf_map_update_elem(&linum_map, &linum_idx, &linum, BPF_NOEXIST);	\
+	bpf_map_update_elem(&linum_map, &linum_idx, &linum, BPF_ANY);	\
 	return CG_OK;						\
 })
 
-- 
2.35.1

