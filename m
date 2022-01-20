Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB48849529E
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 17:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377069AbiATQur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 11:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346704AbiATQuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 11:50:46 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EDEC061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 08:50:46 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so5706661pju.2
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cJe1dqPAL7rP+GUm7NwjMuLsz1alMs+mZXCZ7oHtGU=;
        b=okgkw8TAupxq9Tudeh/RUpzBnRn0aOFedu88REkxLHcgC2LW+2kytL0la8UZiUeSYq
         PwIpvjU6K5NFkpHo+xVt7jMvdtpD+1/t8jEcxWLjwjLKtPWZEV6FJX0G/SnPfduCgx5v
         ZftiUDyzjg8pkpK7WLdHxvJpxsnN598xt0rT/fwRRUtYxXqhM9zXnOfnq9a0JlQYGrdE
         nuuWiyeKHGF81FpV4Ppi2BhSJ8PS0ntTj95bulTQ7iUQRbWEs+6p225fzqHQ9uZPI0Ha
         E6HgsyvP+nsR+3bAw+8p5VGLcF6hQqg+ZIELtD23AsnMyBjw/LHE/4q0B9JUGe0K/ihy
         xGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cJe1dqPAL7rP+GUm7NwjMuLsz1alMs+mZXCZ7oHtGU=;
        b=ELtKqvCk7r2oYco1ZqajPUt4ZXsTxCZZBRgnMTw3T8FfrS6xAe9vsni1VzZ1Gn1ZHk
         lwhBd3Vm0Wg0hotkX8tnfOeWVMQWeWVJZWWBvLCiGGTuyG+nkdcMQ4hsZpHKCWBjxJO/
         0uqLDEm7n5UpzjG0dCf/hppQR4l7xHPCybPZzU9dQNcKKbESyRc/OTH3bruLzBxsRRSo
         avyMsmbDWlHy0oaCC2SBj7GMDXZge92NuwLo2dv2eqsUL2CWG6Bjt+AsFAvb4Y/B8wBv
         3/Kkh0jyIoLbtHblctOnxia8VcFbZaqGY2nAWY4ArqqKWXd9rQdzi+XkIGdlm0Ydoj3e
         aTVA==
X-Gm-Message-State: AOAM530gmAMMZTSJXHoFJAUUpzstkUkrcoYh4Hh2NKKdrvDruKrIXPbJ
        z9HpCS4P5Oj6GvrZR7aNGu2+0zv30vfgYQ==
X-Google-Smtp-Source: ABdhPJy4cCPcEskOP73YcxUhqQb34n/HxcctnTam0ubtvo6yB29g5HPr/nmcK9yr0blyabIYpA1J7w==
X-Received: by 2002:a17:903:41cf:b0:14a:f1af:15cc with SMTP id u15-20020a17090341cf00b0014af1af15ccmr8792609ple.122.1642697445839;
        Thu, 20 Jan 2022 08:50:45 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:502e:73f4:8af1:9522])
        by smtp.gmail.com with ESMTPSA id q9sm3898872pfj.113.2022.01.20.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 08:50:45 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Do not fail build if CONFIG_NF_CONNTRACK=m/n
Date:   Thu, 20 Jan 2022 22:19:32 +0530
Message-Id: <20220120164932.2798544-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some users have complained that selftests fail to build when
CONFIG_NF_CONNTRACK=m. It would be useful to allow building as long as
it is set to module or built-in, even though in case of building as
module, user would need to load it before running the selftest. Note
that this also allows building selftest when CONFIG_NF_CONNTRACK is
disabled.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_bpf_nf.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 6f131c993c0b..d048d355a69f 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -17,18 +17,27 @@ int test_enonet_netns_id = 0;
 int test_enoent_lookup = 0;
 int test_eafnosupport = 0;

+struct nf_conn;
+
+struct bpf_ct_opts___local {
+	s32 netns_id;
+	s32 error;
+	u8 l4proto;
+	u8 reserved[3];
+};
+
 struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *, struct bpf_sock_tuple *, u32,
-				  struct bpf_ct_opts *, u32) __ksym;
+				  struct bpf_ct_opts___local *, u32) __ksym;
 struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *, struct bpf_sock_tuple *, u32,
-				  struct bpf_ct_opts *, u32) __ksym;
+				  struct bpf_ct_opts___local *, u32) __ksym;
 void bpf_ct_release(struct nf_conn *) __ksym;

 static __always_inline void
 nf_ct_test(struct nf_conn *(*func)(void *, struct bpf_sock_tuple *, u32,
-				   struct bpf_ct_opts *, u32),
+				   struct bpf_ct_opts___local *, u32),
 	   void *ctx)
 {
-	struct bpf_ct_opts opts_def = { .l4proto = IPPROTO_TCP, .netns_id = -1 };
+	struct bpf_ct_opts___local opts_def = { .l4proto = IPPROTO_TCP, .netns_id = -1 };
 	struct bpf_sock_tuple bpf_tuple;
 	struct nf_conn *ct;

--
2.34.1

