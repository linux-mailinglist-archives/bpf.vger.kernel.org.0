Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE86313A8
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 12:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKTL0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 06:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKTL0N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 06:26:13 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6BB4874F
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 03:26:12 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1668943571;
        x=1669202771; bh=+E7ZLX2VIUnegEhBmHeUAvMX+7T3+ziwh1hfqEqGbsI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=qnAlY5kT+AE54qeEWU/s76Ck5MtTmj2j9yfOyhbA44nAaInVv/7BssKkMDaMKiIrL
         3X6do+c1BDmsD/mkIQV8hG57Z1gKVGB/OhKfF+0DPOSSTVG0nAmqaIPG0w4H7/34Lh
         ArQgn4/h7wFFGjIZERgydV9HrxTTs0VN+Q3GhjYPVAsHe5dtj8y0jnwyhBhx56hxcT
         7xtH9U93aKvl2IT8JxG+6qvxxnzLByxxov+tjOTzGng7c2m+Zm2w+ycEn7Vinc+ETf
         y8w6Ktrk5bLUMsoLkvCnW7KnAxbMRYJERYwAuwqPKijGp2EXw56v9p409wa8zCfyHz
         x77q01HS4tRZQ==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v4 2/5] bpftool: replace return value PTR_ERR(NULL) with 0
Message-ID: <20221120112515.38165-3-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221120112515.38165-1-sahid.ferdjaoui@industrialdiscipline.com>
References: <20221120112515.38165-1-sahid.ferdjaoui@industrialdiscipline.com>
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

There is no reasons to keep PTR_ERR() when kern_btf=3DNULL, let's just
return 0.
This also cleans this part of code from using libbpf_get_error().

Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipli=
ne.com>
Acked-by: Yonghong Song <yhs@fb.com>
Suggested-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/struct_ops.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.=
c
index e08a6ff2866c..d3cfdfef9b58 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -63,10 +63,8 @@ static __s32 get_map_info_type_id(void)
 =09=09return map_info_type_id;

 =09kern_btf =3D get_btf_vmlinux();
-=09if (libbpf_get_error(kern_btf)) {
-=09=09map_info_type_id =3D PTR_ERR(kern_btf);
-=09=09return map_info_type_id;
-=09}
+=09if (!kern_btf)
+=09=09return 0;

 =09map_info_type_id =3D btf__find_by_name_kind(kern_btf, "bpf_map_info",
 =09=09=09=09=09=09  BTF_KIND_STRUCT);
--
2.34.1


