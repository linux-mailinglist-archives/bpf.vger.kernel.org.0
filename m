Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617C95F58BF
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 19:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJERBL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJERBF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 13:01:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C17373330
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 10:01:00 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295GVcdp030415
        for <bpf@vger.kernel.org>; Wed, 5 Oct 2022 10:01:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=WOcu3hIYkNKYVjFuwEByLq9XNG6sXDad1mte+nonBhE=;
 b=GjYcPABc4MGaqfGzs4H//VMoKBX0o1iZXiimP7S/8ty1fxmufmEP5BZg55D9rgqGtwgk
 UZv8cM1fFUHy9nbbKK5NUjEtmJqKGp69aPl5SiTmop0JnWzt6LXOvHZz12sneOdNxXzN
 DHSD81CnhWerGclPtp7g8GiL1h2tKB084yQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k0xhpw2wf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 10:00:59 -0700
Received: from twshared22593.02.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 10:00:51 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id E8182112544A9; Wed,  5 Oct 2022 10:00:47 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <kpsingh@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
        <andrii@kernel.org>, <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v2] bpf,x64: Remove unnecessary check on existence of SSE2
Date:   Wed, 5 Oct 2022 10:00:39 -0700
Message-ID: <20221005170039.3936894-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CACYkzJ5X-ShtGKHshSt74=5faZW5jWUBWyq7bzfs6x1f4jb65Q@mail.gmail.com>
References: <CACYkzJ5X-ShtGKHshSt74=5faZW5jWUBWyq7bzfs6x1f4jb65Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fkt5sDrpoaL-JwMwd6HaRxQOMpdUgge4
X-Proofpoint-ORIG-GUID: fkt5sDrpoaL-JwMwd6HaRxQOMpdUgge4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_04,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SSE2 and hence lfence are architectural in x86-64 and no need to check
whether they're supported in CPU. SSE2's CPUID flag is still set to
maintain backward compatibility with older code or code shared with x86,
but bpf_jit_comp.c is compiled under x86-64 exclusively so the check is
redundant.

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d09c54f3d2e0..b2124521305e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1289,8 +1289,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
=20
 			/* speculation barrier */
 		case BPF_ST | BPF_NOSPEC:
-			if (boot_cpu_has(X86_FEATURE_XMM2))
-				EMIT_LFENCE();
+			EMIT_LFENCE();
 			break;
=20
 			/* ST: *(u8*)(dst_reg + off) =3D imm */
--=20
2.30.2

