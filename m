Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7263D869
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiK3Ono (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 09:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3Onm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 09:43:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4DBE12
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 06:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669819366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCyIoMGSiGDdstVNqCLmro74t1BNkUezYoweJpKNg/Q=;
        b=YZkLv6ln/nxREmhdhElreBFGYjRNwsVLagrJV4C5vV6XrCdfFzOTRp0gI/rAnnRbkM7/1+
        /MyBNuWQlDDjd7i8X2eYn7f8waOzp01eu7kSBbrL23BrWAMMGVSZ3PIrjGyGoyR8lZtZTW
        IWiuLT9y3AuFwsyNGJNhslXwvi1H7p0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-d-tfSih1PdWY3Tu4eq2xjg-1; Wed, 30 Nov 2022 09:42:44 -0500
X-MC-Unique: d-tfSih1PdWY3Tu4eq2xjg-1
Received: by mail-ed1-f71.google.com with SMTP id z3-20020a056402274300b0046b14f99390so5501760edd.9
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 06:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCyIoMGSiGDdstVNqCLmro74t1BNkUezYoweJpKNg/Q=;
        b=u2BFF7tt2doE3RTbUzRd1t02gjXYaKn9vqEeq4QJtXVxtwy53ocH+LrgnKSWA73nUb
         65H6cd9FuPv7bO1JUgxbhz+wXfnhas19qmUdLJhTkTSbUMTdxEiQ6Mldvc26Gla4qE7O
         BqauzCKewD63qNau4N9GZqCS7biAoqqaX9nJiUu8k9Wc9jFoYZAQEnLfmgKxd/Oq+5N6
         p/5wiRj7a+IXWqa2gGUH4Lht9LbxoNiBzDffBYgcX7Lv65EOChIrA3jgMzN5+/b8qXPu
         R14CRkhAT9L4mHtiPzVqlvnJlvFqMTJawE9Hb26qy/mHU+cx0LcdNBys0ioo96yvojiZ
         fe8g==
X-Gm-Message-State: ANoB5pmV2G1a4Lw7X3EajfTns1Lstv177bXwcazF2Iz/L1YCJopS2oM1
        C1aXrj5Dy3pIRL9h6L3zqzSiGpYSwWITI0+QLurVeHlFKUkATnfbQYgDlSq3bIcUVWsVZpUmB1Q
        mmbqqjs/03xDj
X-Received: by 2002:a05:6402:189:b0:469:85d:2663 with SMTP id r9-20020a056402018900b00469085d2663mr53175115edv.56.1669819363123;
        Wed, 30 Nov 2022 06:42:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4nznHyB26L9ozlWiRnu8euu+cP/TnaBByZcaYk6rRCEggUn6PevCLSEkOytUzStyKrRrbLcw==
X-Received: by 2002:a05:6402:189:b0:469:85d:2663 with SMTP id r9-20020a056402018900b00469085d2663mr53175087edv.56.1669819362784;
        Wed, 30 Nov 2022 06:42:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q25-20020a17090676d900b007803083a36asm707204ejn.115.2022.11.30.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:42:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 90A8C80ADF5; Wed, 30 Nov 2022 15:42:41 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jiri Benc <jbenc@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Add local definition of enum nf_nat_manip_type to bpf_nf test
Date:   Wed, 30 Nov 2022 15:42:40 +0100
Message-Id: <20221130144240.603803-2-toke@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130144240.603803-1-toke@redhat.com>
References: <20221130144240.603803-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_nf selftest calls the bpf_ct_set_nat_info() kfunc, which takes a
parameter of type enum nf_nat_manip_type. However, if the nf_nat code is
compiled as a module, that enum is not defined in vmlinux BTF, and
compilation of the selftest fails.

A previous patch suggested just hard-coding the enum values:

https://lore.kernel.org/r/tencent_4C0B445E0305A18FACA04B4A959B57835107@qq.com

However, this doesn't work as the compiler then complains about an
incomplete type definition in the function prototype. Instead, just add a
local definition of the enum to the selftest code.

Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 227e85e85dda..6350d11ec6f6 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -43,6 +43,11 @@ struct bpf_ct_opts___local {
 	u8 reserved[3];
 } __attribute__((preserve_access_index));
 
+enum nf_nat_manip_type {
+	NF_NAT_MANIP_SRC,
+	NF_NAT_MANIP_DST
+};
+
 struct nf_conn *bpf_xdp_ct_alloc(struct xdp_md *, struct bpf_sock_tuple *, u32,
 				 struct bpf_ct_opts___local *, u32) __ksym;
 struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *, struct bpf_sock_tuple *, u32,
-- 
2.38.1

