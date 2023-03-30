Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685AD6D0948
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjC3PTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjC3PTl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 11:19:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90CD322
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o2so18386185plg.4
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680189497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GMH/sMqxTO7VPUYqW8LTgQ4I7YNXjBTU9UJG9Mf4+M=;
        b=GARD2atwfFct/hksBYYWgGmT6DOVOD/f3StFCdez2EMXHq5rsdENK1kSVptguNNgp6
         fNXOk4BYlKLhy/Wp6Vk4GkNP37glJuoEhEXgZb0eCaH0xaNJ58nLi5qEBEv/IZE5jzb+
         IATCtuJDSM6KfR+wvC9t6cE7cTPTlgz2MNM+ZnCtpF+xNuMUqnyPFNAqkf1qQ897KqSO
         W9YWwxk4o2bCusKS+1+6+hkkJ/JvXIaT8KArfwjjVjOb6XnFa9kpsRnoOBtTXFJWexdb
         hDvRLZLLtWP4qRVQ8pudRU1uZpZ50UWKJ79sRoHiGmL4je5AsDXrYevTmiHB0rJP0AZ4
         DFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GMH/sMqxTO7VPUYqW8LTgQ4I7YNXjBTU9UJG9Mf4+M=;
        b=AyA2flq5pKykaUIXaVorD01+RIEqjtBbkdjVKTTT8IALm7YgD60WtVP1zn7F+IQX2U
         MaJ10J4cBeq9VrwiJkP06g5vrZAbwoo1Il3WFPwjjJ/f9Vj0yL+kQ1h7Sp+HS3a96f0r
         jsPpkqiv7PWCsbTdwypzqoRSpyiKLDCEagQHa2kIX+GLPYxYYmvFGn99O6WwKI/yqEmH
         d3P5SuCTQhCbjOeEhIhdDhcoI74lYKJYdjHfEhw93RQXF7/n6Yiog58CSvLe32pawocm
         mYJK2FVzF45sWpjIVOMk0aDOXJ+aF+kpP6tPw4STMOacTysmMjtO/pivyMZMvJ4AOl4h
         tu6w==
X-Gm-Message-State: AAQBX9dkdMAEKtChyG+R1kNOB7H0cQiN6RNiYUBKa8A3n0aOFw2D9ymj
        usGHoycFGnNaMGj45wgpdgBUperlGDsmAqaPyyo=
X-Google-Smtp-Source: AKy350aG0ukGp5IfYrR1xAiIo1RMXxkNK6L1e5DsZCsfPTaROnuaJuzvLahOwPZoSKU/8SzcIs/6cg==
X-Received: by 2002:a17:902:fb08:b0:1a2:1fb9:3b2 with SMTP id le8-20020a170902fb0800b001a21fb903b2mr20154375plb.11.1680189497062;
        Thu, 30 Mar 2023 08:18:17 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id f17-20020a63de11000000b004fc1d91e695sm23401177pgg.79.2023.03.30.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:18:16 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com, Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v5 bpf-next 2/7] udp: seq_file: Remove bpf_seq_afinfo from udp_iter_state
Date:   Thu, 30 Mar 2023 15:17:53 +0000
Message-Id: <20230330151758.531170-3-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330151758.531170-1-aditi.ghag@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a preparatory commit to remove the field. The field was
previously shared between proc fs and BPF UDP socket iterators. As the
follow-up commits will decouple the implementation for the iterators,
remove the field. As for BPF socket iterator, filtering of sockets is
exepected to be done in BPF programs.

Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 include/net/udp.h |  1 -
 net/ipv4/udp.c    | 15 +++------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index de4b528522bb..5cad44318d71 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -437,7 +437,6 @@ struct udp_seq_afinfo {
 struct udp_iter_state {
 	struct seq_net_private  p;
 	int			bucket;
-	struct udp_seq_afinfo	*bpf_seq_afinfo;
 };
 
 void *udp_seq_start(struct seq_file *seq, loff_t *pos);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c605d171eb2d..c574c8c17ec9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2997,10 +2997,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
 	struct udp_table *udptable;
 	struct sock *sk;
 
-	if (state->bpf_seq_afinfo)
-		afinfo = state->bpf_seq_afinfo;
-	else
-		afinfo = pde_data(file_inode(seq->file));
+	afinfo = pde_data(file_inode(seq->file));
 
 	udptable = udp_get_table_afinfo(afinfo, net);
 
@@ -3033,10 +3030,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
 	struct udp_seq_afinfo *afinfo;
 	struct udp_table *udptable;
 
-	if (state->bpf_seq_afinfo)
-		afinfo = state->bpf_seq_afinfo;
-	else
-		afinfo = pde_data(file_inode(seq->file));
+	afinfo = pde_data(file_inode(seq->file));
 
 	do {
 		sk = sk_next(sk);
@@ -3094,10 +3088,7 @@ void udp_seq_stop(struct seq_file *seq, void *v)
 	struct udp_seq_afinfo *afinfo;
 	struct udp_table *udptable;
 
-	if (state->bpf_seq_afinfo)
-		afinfo = state->bpf_seq_afinfo;
-	else
-		afinfo = pde_data(file_inode(seq->file));
+	afinfo = pde_data(file_inode(seq->file));
 
 	udptable = udp_get_table_afinfo(afinfo, seq_file_net(seq));
 
-- 
2.34.1

