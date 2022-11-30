Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0763D86B
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 15:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiK3Onu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 09:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiK3Ont (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 09:43:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C9B18B15
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669819369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=crVCumDlTSh3ITTn1/1f42ksAkShS/hhF76AM8JHUUU=;
        b=QtizwF3FnSbXQPTChEr9jLlRJdGEKTY+3x06jmz0C2Fk4YyN6AB0xCVxu7BGMCrEDJqd8G
        JANNU9lZVqGwE26myBgFtVpbCCTTXXW+m2mvOjU2e0w+Y94ibZtQTJPwBP0ShRyG8N5eEm
        8GZGIyI3iqVgJzgwytU/2oMIJC9zXxg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-298-RAyKDI2SMGaP3kQJi4TnaA-1; Wed, 30 Nov 2022 09:42:48 -0500
X-MC-Unique: RAyKDI2SMGaP3kQJi4TnaA-1
Received: by mail-ej1-f72.google.com with SMTP id ne29-20020a1709077b9d00b007c0905baae1so2795784ejc.8
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 06:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crVCumDlTSh3ITTn1/1f42ksAkShS/hhF76AM8JHUUU=;
        b=qguymJMr8RpHHqtZ+8zoKkJHAKD/hoNIoQymCAg8n6pl2op3/GJICk/pyYC/PaPpqA
         gwVJyi36jx+P10tn3vmkxwgF8BZhMQ3AHFFxAcquP+h3iSRxjedY7qmA3B7T/BOwii4I
         BelEG9/BEphp0D6/yDWuaCMU4tU1+yJ028LPvlKfB/x55leaPg1H1sVAk34jYxO9moVe
         LUF1W+ZBh1DLjuYghE3cJHOzR1Drq8mEtzn2e+67NtO1CYr7ZVGsVkW7G3cBxqaY1WAW
         TiNPuRkumwlSEl1jZDgVLpXu2uoqbT4Tm96IzXta4ezg9a7RvTgie/Kgz+vu3BoxuSIo
         qyAA==
X-Gm-Message-State: ANoB5pmL6OvMWr5vgyVNgtuBUvdc14irbLcy83ex+A16Y8BiXULUkUsc
        SzY96qKlkR6QqFUFAkwEouVkO7O66ZA5VaxvDSbhCPuOSQ2XdL3tvUTzf7/+g/ZJtlGW0Ag/MyO
        RB23DZ+nRRj+f
X-Received: by 2002:a05:6402:68c:b0:461:b506:6b8a with SMTP id f12-20020a056402068c00b00461b5066b8amr55986244edy.208.1669819365117;
        Wed, 30 Nov 2022 06:42:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7wdBNsOHHoOR7LIpapj/cFK+5DQiHiWjSP+unOpa4buIm9tnAkYDfRzgP9Ht5etXIxzIhVDw==
X-Received: by 2002:a05:6402:68c:b0:461:b506:6b8a with SMTP id f12-20020a056402068c00b00461b5066b8amr55986089edy.208.1669819362601;
        Wed, 30 Nov 2022 06:42:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b00741a251d9e8sm710764ejf.171.2022.11.30.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:42:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5847D80ADF3; Wed, 30 Nov 2022 15:42:41 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jiri Benc <jbenc@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: Add dummy type reference to nf_conn___init to fix type deduplication
Date:   Wed, 30 Nov 2022 15:42:39 +0100
Message-Id: <20221130144240.603803-1-toke@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_ct_set_nat_info() kfunc is defined in the nf_nat.ko module, and
takes as a parameter the nf_conn___init struct, which is allocated through
the bpf_xdp_ct_alloc() helper defined in the nf_conntrack.ko module.
However, because kernel modules can't deduplicate BTF types between each
other, and the nf_conn___init struct is not referenced anywhere in vmlinux
BTF, this leads to two distinct BTF IDs for the same type (one in each
module). This confuses the verifier, as described here:

https://lore.kernel.org/all/87leoh372s.fsf@toke.dk/

As a workaround, add a dummy pointer to the type in net/filter.c, so the
type definition gets included in vmlinux BTF. This way, both modules can
refer to the same type ID (as they both build on top of vmlinux BTF), and
the verifier is no longer confused.

Fixes: 820dc0523e05 ("net: netfilter: move bpf_ct_set_nat_info kfunc in nf_nat_bpf.c")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/filter.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index bb0136e7a8e4..1bdf9efe8593 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -80,6 +80,7 @@
 #include <net/tls.h>
 #include <net/xdp.h>
 #include <net/mptcp.h>
+#include <net/netfilter/nf_conntrack_bpf.h>
 
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
@@ -11531,3 +11532,17 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 
 	return func;
 }
+
+#if IS_MODULE(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)
+/* The nf_conn___init type is used in the NF_CONNTRACK kfuncs. The kfuncs are
+ * defined in two different modules, and we want to be able to use them
+ * interchangably with the same BTF type ID. Because modules can't de-duplicate
+ * BTF IDs between each other, we need the type to be referenced in the vmlinux
+ * BTF or the verifier will get confused about the different types. So we add
+ * this dummy pointer to serve as a type reference which will be included in
+ * vmlinux BTF, allowing both modules to refer to the same type ID.
+ *
+ * We use a pointer as that is smaller than an instance of the struct.
+ */
+const struct nf_conn___init *ctinit;
+#endif
-- 
2.38.1

