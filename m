Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE33E6224D8
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 08:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKIHqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 02:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIHqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 02:46:09 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9401B186FE
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 23:46:08 -0800 (PST)
Date:   Wed, 09 Nov 2022 07:45:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1667979966;
        x=1668239166; bh=jRkrx8NQ5c18XQ7suYq3J2d2oW6FX4/YYIWJGXT+zdI=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=xcvmhr/Dg5YR66UdwVOK7vxeGw2GQslqlRidxs12rTAqScBr1LhstG6TRruingRj3
         NkslBCrbz1luFIM6P3ldefZHJ45lC5suqLVXRQSGkkMB2UltrHfvhpDSaRrjPSQVG9
         o+cK2W4Vjk7aWygqsDF3meTpOnWXBYXa4BLuG3KA+R3rYrkz/wvlB7swkoszP80GLB
         i+3JAW8sGCpqSA426wW5o8Xrn8LxnB93ZApyqbDx+HSYFDJOSwfV1RE2Q3FmacoFlL
         a1IV3K2ew1TlSYC4/5/uLEMJLJ28/Ub/5bfJ0sm0EU4zJ3HEdYw/XKg/rLsy0p8BcS
         Q7Gbqfx3T4oLA==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v2 5/5] bpftool: remove function free_btf_vmlinux()
Message-ID: <20221109074427.141751-6-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function contains a single btf__free() call which can be
inlined. Credits to Yonghong Song.

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
---
 tools/bpf/bpftool/map.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index b6bddf6c789e..557bc5bdd50a 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -813,11 +813,6 @@ static void free_map_kv_btf(struct btf *btf)
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
@@ -954,7 +949,7 @@ static int do_dump(int argc, char **argv)
 =09=09close(fds[i]);
 exit_free:
 =09free(fds);
-=09free_btf_vmlinux();
+=09btf__free(btf_vmlinux);
 =09return err;
 }

--
2.34.1


