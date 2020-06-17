Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEB41FD160
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFQPzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 11:55:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54004 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgFQPzs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 11:55:48 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05HFsdwS020392
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 08:55:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=YZTTT+4yJKOsSckGQG3nmfu0U81s4MSQc5dwyolzIlg=;
 b=RgsnHRuuttlR5kL8SrXQ1gQ9sjBUbA7drU17MvGHslqFnNGmqL2kkgjsDJ0FIVh6DeeQ
 rdQPsqHxpj915PKcuDHLlZuODKM3AlRzsGiFJBFpE5QFerprXomC7c3hH91xpA1DkVGN
 UjAxXUuioAK7yB//jbcq06EJpn0RJ02XeGk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 31q65k5371-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 08:55:46 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 08:55:45 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 89B622EC341F; Wed, 17 Jun 2020 08:55:43 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] libbpf: bump version to 0.0.10
Date:   Wed, 17 Jun 2020 08:55:39 -0700
Message-ID: <20200617155539.1223558-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_06:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 cotscore=-2147483648 mlxlogscore=663 lowpriorityscore=0 malwarescore=0
 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 suspectscore=8 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170126
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Let's start new cycle with another libbpf version bump.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.map | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f732c77b7ed0..3b37b8867cec 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -270,3 +270,6 @@ LIBBPF_0.0.9 {
 		ring_buffer__new;
 		ring_buffer__poll;
 } LIBBPF_0.0.8;
+
+LIBBPF_0.0.10 {
+} LIBBPF_0.0.9;
--=20
2.24.1

