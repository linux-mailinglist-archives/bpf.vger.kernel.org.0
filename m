Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEDF621696
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKHOaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiKHOaB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:30:01 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E659CC8A2F
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 06:28:20 -0800 (PST)
Date:   Tue, 08 Nov 2022 14:28:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1667917696;
        x=1668176896; bh=B5LNyWpBlDcvcC3c0aEl4fbMNmMCKlWzD1UphlPyrJ0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=b9ESaw2liTFcQkKrzhmCBbOOxPsrmnVhiQZNw2ZDmVCOufIJuL3+YFjEiRRctt5m5
         evCu4N6fUfzB0thhlNdP5ZeYsPRwNFqgFkAGp9VDuwBymsiAzdjjOmzh7TkeEK0zHp
         fG+JHeos9gtiQo/TbzKoIfX6T15DE4G2z56DdZVB3jdICb/HGfuYlt+msIgDEdUWn5
         0QQfzuH1IBZVqNFMAVh9TSFJlDpztMa7WbPohfuwfFdOP++/Vwp5UWB7aRO64UtpEN
         0voL1q2dKGwQ5dEAaweu6/Yqyo1mpJqlHzP/ku1JkDZ6bKEmcUmGrUC5aOl0V7++VQ
         SuYk2HnJ/078Q==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH 2/4] bpftool: replace return value PTR_ERR(NULL) with 0
Message-ID: <20221108142515.126199-3-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221108142515.126199-1-sahid.ferdjaoui@industrialdiscipline.com>
References: <20221108142515.126199-1-sahid.ferdjaoui@industrialdiscipline.com>
Feedback-ID: 39921202:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is no reasons to keep PTR_ERR() when kern_btf=3DNULL, let's just
return 0.

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
---
 tools/bpf/bpftool/struct_ops.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.=
c
index e08a6ff2866c..68281f9b7a0e 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -63,10 +63,8 @@ static __s32 get_map_info_type_id(void)
 =09=09return map_info_type_id;

 =09kern_btf =3D get_btf_vmlinux();
-=09if (libbpf_get_error(kern_btf)) {
-=09=09map_info_type_id =3D PTR_ERR(kern_btf);
-=09=09return map_info_type_id;
-=09}
+=09if (libbpf_get_error(kern_btf))
+=09=09return 0;

 =09map_info_type_id =3D btf__find_by_name_kind(kern_btf, "bpf_map_info",
 =09=09=09=09=09=09  BTF_KIND_STRUCT);
--
2.34.1


