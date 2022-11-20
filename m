Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841686313AB
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 12:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiKTL04 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 06:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKTL0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 06:26:53 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1AA4874F
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 03:26:53 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:26:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668943611;
        x=1669202811; bh=mFgslVBJMmDamIjmC3BL4mU01El8v2LgV8H5z8IK/Mk=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=fOl+ij2ND/WHnzw+Ed58TgdaNrfIrx6XhVviAJrHQFgJTXKJeuo2bKOlzbqj2UbbT
         dn1hKrY2I4w8GzHU4aQNOuDdYfDEqFVUXJNbenB0UrosKbEAj5+7E+Z/EEIYPsfPPn
         ae1nEcvjGsFOsKoxLwb+BkSy6M6qNh31UhpIHJPA1RUXpEtuboQiHXxAjgDBJbvYxy
         h/ATEUnMTBo3KUmerdDovb/5LU0Qezt542wlV5e2lL5ndVnUbgY/zqtnfDJNAijnLs
         LJL9Ge7DHsyGy7pLmWdtujm94m7J2Cm9EH9a8S5/EtO/QWIW5qJbsZ7csOcF5VKCS8
         Gf0thnEvOQiUw==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v4 5/5] bpftool: remove function free_btf_vmlinux()
Message-ID: <20221120112515.38165-6-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function contains a single btf__free() call which can be
inlined. Credits to Yonghong Song.

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
Acked-by: Yonghong Song <yhs@fb.com>
Suggested-by: Yonghong Song <yhs@fb.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/map.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index eb362bd3d2c9..88911d3aa2d9 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -811,11 +811,6 @@ static void free_map_kv_btf(struct btf *btf)
 =09=09btf__free(btf);
 }

-static void free_btf_vmlinux(void)
-{
-=09btf__free(btf_vmlinux);
-}
-
 static int
 map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 =09 bool show_header)
@@ -952,7 +947,7 @@ static int do_dump(int argc, char **argv)
 =09=09close(fds[i]);
 exit_free:
 =09free(fds);
-=09free_btf_vmlinux();
+=09btf__free(btf_vmlinux);
 =09return err;
 }

--
2.34.1


