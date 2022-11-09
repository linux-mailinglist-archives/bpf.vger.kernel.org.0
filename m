Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13796224D4
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 08:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKIHpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 02:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKIHpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 02:45:33 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E6186FE
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 23:45:32 -0800 (PST)
Date:   Wed, 09 Nov 2022 07:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=industrialdiscipline.com; s=protonmail3; t=1667979930;
        x=1668239130; bh=B5LNyWpBlDcvcC3c0aEl4fbMNmMCKlWzD1UphlPyrJ0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=lH8bNYM6eV17luzcjrWJty3fq0E72sJOxHpL0NIcxwGttlH1ACken6j8wHKdaFBhr
         Albpm/Fhmhbu1LMtDO9/qSnaF2AOmh/5D3kZUqah+LXdqJqyZCjVkzOJGCR+HwoFRm
         IE+fi8S2WA8QfMQf+RpOS7z+OSp9tuMBxQiMVWxpDu8T+sG52A6RC4PkTN5D8k64Mg
         GcdDmLaonERT4lzB3A8BL73G1/QN3eOTv9iQDJ0wrhIcxzFloQ+DXpqONx+BRJBbV+
         woobr5DzNs7PeDUkAoFke9Gdoe57vZHa/DTmFMwLCsqky8436ag94BSyaz7VVppnXK
         eMjBClYDY50WQ==
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
From:   Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Subject: [PATCH bpf-next v2 2/5] bpftool: replace return value PTR_ERR(NULL) with 0
Message-ID: <20221109074427.141751-3-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221109074427.141751-1-sahid.ferdjaoui@industrialdiscipline.com>
References: <20221109074427.141751-1-sahid.ferdjaoui@industrialdiscipline.com>
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


