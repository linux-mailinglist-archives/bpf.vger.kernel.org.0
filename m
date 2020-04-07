Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC551A0621
	for <lists+bpf@lfdr.de>; Tue,  7 Apr 2020 07:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgDGFLd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Apr 2020 01:11:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16546 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgDGFLd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Apr 2020 01:11:33 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0375BS5k026492
        for <bpf@vger.kernel.org>; Mon, 6 Apr 2020 22:11:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=3YibdS0UKx5l9l22WTyH//kMHLuX69iCuzoNpcxmDww=;
 b=bAL7XlSkKAgVZUdf+FdvfKlxHwVobqYmOE1cbR36b+60vdPGCjczkWTfKzDK8VWledhF
 mXnXPuEJTGSKT9j88WJYVxJenfWTTF5KtYUb3ya4VeD3JcgpQ0B2fPgoMaX93mPRQ5yV
 hq43SB+SHMHQhx8n7kuHZBGBY9StLQjlNaI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 307a266ydt-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2020 22:11:32 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 6 Apr 2020 22:11:14 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id A9C4A3700D26; Mon,  6 Apr 2020 22:11:08 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>, <toke@redhat.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 0/2] libbpf: Fix bpf_get_link_xdp_id flags handling
Date:   Mon, 6 Apr 2020 22:09:44 -0700
Message-ID: <cover.1586236080.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=309
 malwarescore=0 suspectscore=13 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070042
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set fixes bpf_get_link_xdp_id() behavior for non-zero flags an=
d
adds selftest that verifies the fix and can be used to reproduce the
problem.


Andrey Ignatov (2):
  libbpf: Fix bpf_get_link_xdp_id flags handling
  selftests/bpf: Add test for bpf_get_link_xdp_id

 tools/lib/bpf/netlink.c                       |  2 +-
 .../selftests/bpf/prog_tests/xdp_info.c       | 68 +++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_info.c

--=20
2.24.1

