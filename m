Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 431731A061F
	for <lists+bpf@lfdr.de>; Tue,  7 Apr 2020 07:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDGFLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Apr 2020 01:11:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29176 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbgDGFLU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Apr 2020 01:11:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03759lWY005546
        for <bpf@vger.kernel.org>; Mon, 6 Apr 2020 22:11:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=n7vPynvpSnGKhEIuCNbLf35BRffuamFs+C3ckHw7KTE=;
 b=RveyCTMmyPXE/oG+Wy9oR3vkPMX2m254/gOFU5afBg1pqz4gduc4gKJ6LFvMCQexTfg7
 RXmYj4g6whL/NTjtBB7GEwSgyj9C+ZQRt/yfJNfKKXyompzb4HIg/hbGsd8fGR6YZYw1
 ETSQryoXPFKKLbMZTFkaGWK28z3YM5fXbtg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3089k2jwgu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2020 22:11:18 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 6 Apr 2020 22:11:18 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id B9D4F3700D26; Mon,  6 Apr 2020 22:11:13 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>, <toke@redhat.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 1/2] libbpf: Fix bpf_get_link_xdp_id flags handling
Date:   Mon, 6 Apr 2020 22:09:45 -0700
Message-ID: <0e9e30490b44b447bb2bebc69c7135e7fe7e4e40.1586236080.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1586236080.git.rdna@fb.com>
References: <cover.1586236080.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=682
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=13
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070042
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently if one of XDP_FLAGS_{DRV,HW,SKB}_MODE flags is passed to
bpf_get_link_xdp_id() and there is a single XDP program attached to
ifindex, that program's id will be returned by bpf_get_link_xdp_id() in
prog_id argument no matter what mode the program is attached in, i.e.
flags argument is not taken into account.

For example, if there is a single program attached with
XDP_FLAGS_SKB_MODE but user calls bpf_get_link_xdp_id() with flags =3D
XDP_FLAGS_DRV_MODE, that skb program will be returned.

Fix it by returning info->prog_id only if user didn't specify flags. If
flags is specified then return corresponding mode-specific-field from
struct xdp_link_info.

The initial error was introduced in commit 50db9f073188 ("libbpf: Add a
support for getting xdp prog id on ifindex") and then refactored in
473f4e133a12 so 473f4e133a12 is used in the Fixes tag.

Fixes: 473f4e133a12 ("libbpf: Add bpf_get_link_xdp_info() function to get=
 more XDP information")
Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/lib/bpf/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 18b5319025e1..f5732d35930d 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -321,7 +321,7 @@ int bpf_get_link_xdp_info(int ifindex, struct xdp_lin=
k_info *info,
=20
 static __u32 get_xdp_id(struct xdp_link_info *info, __u32 flags)
 {
-	if (info->attach_mode !=3D XDP_ATTACHED_MULTI)
+	if (info->attach_mode !=3D XDP_ATTACHED_MULTI && !flags)
 		return info->prog_id;
 	if (flags & XDP_FLAGS_DRV_MODE)
 		return info->drv_prog_id;
--=20
2.24.1

