Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D704DC4EF
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 12:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiCQLkt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiCQLkl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 07:40:41 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12CE1E3E38
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 04:39:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z26so6800050lji.8
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6cIvA5fpC+1DumvjmukuahH9VsbyXJK8ay6q2GqRmP4=;
        b=cn48Ouj69DPYuZLYMon7O7fwvUqM2b0ec32EnA0eZRwgGJqyyptVZyg229V6aXcTYa
         OjFgI1IndQwf2rvt0xYKGD+lsotTmeYcnS8B4qdsGLbQidBs6uZnIerk+wsR/5spIYNa
         QM99hwuArD1DBrjkPX3eY9A+JsnS865I/qjzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6cIvA5fpC+1DumvjmukuahH9VsbyXJK8ay6q2GqRmP4=;
        b=59eNPhQg80zGoww2SWEm3/UbDbpFC/UwTjzmoiJzJLjtZs4YootVzBAxysCXgDO/sz
         hArIOnF3F9gJJrFlQzgpLaT0cHKMDyWe5VqBK94uJbxKyf3kxia/qGsu2NMPjze9dK/y
         CtW6sY8XuhTM57Kl4kLyp190DYfwikxWOZqY21VeTIxs/o29sT2mNlmb9qITB0gGPP+7
         o8V8BPV360zLZsBVYt7XFGwe3xBBEKn8aMxuibFnqHhc8eSPvpPEmplhu7lDQII6Ps7K
         l7Cxwm9Q0EWLOO6Zu/h/bJdwpaHd5haBNt/F3rsqrgSdQ7V1XEQaXYJuawyYEG2U5ntR
         bKtA==
X-Gm-Message-State: AOAM531ao8C6LS2hQLtkdF7j5OAg7KBbmos3ljoDIQzeOJq94SL9btS6
        W1czD3z4PQVhw7P8yPjyI7uE1QRH6upDsA==
X-Google-Smtp-Source: ABdhPJzn9RvbWs4yOtGQDUQGDqIej9Wn7dFkMFASqdSoewsqDfGJlBj4R7m2Dzu4EcAfHFOCMFh/Wg==
X-Received: by 2002:a2e:b706:0:b0:247:ff35:cfd7 with SMTP id j6-20020a2eb706000000b00247ff35cfd7mr2493655ljo.510.1647517163048;
        Thu, 17 Mar 2022 04:39:23 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id f14-20020a056512092e00b004423570c03asm425012lft.287.2022.03.17.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:39:22 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Check dst_port only on the client socket
Date:   Thu, 17 Mar 2022 12:39:18 +0100
Message-Id: <20220317113920.1068535-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317113920.1068535-1-jakub@cloudflare.com>
References: <20220317113920.1068535-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup_skb/egress programs which sock_fields test installs process packets
flying in both directions, from the client to the server, and in reverse
direction.

Recently added dst_port check relies on the fact that destination
port (remote peer port) of the socket which sends the packet is known ahead
of time. This holds true only for the client socket, which connects to the
known server port.

Filter out any traffic that is not egressing from the client socket in the
BPF program that tests reading the dst_port.

Fixes: 8f50f16ff39d ("selftests/bpf: Extend verifier and bpf_sock tests for dst_port loads")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/progs/test_sock_fields.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index 3e2e3ee51cc9..43b31aa1fcf7 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -281,6 +281,10 @@ int read_sk_dst_port(struct __sk_buff *skb)
 	if (!sk)
 		RET_LOG();
 
+	/* Ignore everything but the SYN from the client socket */
+	if (sk->state != BPF_TCP_SYN_SENT)
+		return CG_OK;
+
 	if (!sk_dst_port__load_word(sk))
 		RET_LOG();
 	if (!sk_dst_port__load_half(sk))
-- 
2.35.1

