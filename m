Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1EA26B42E
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgIOXTJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 19:19:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63346 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727395AbgIOXTE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Sep 2020 19:19:04 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FNDsnX028967
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 16:19:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=AiwXlAd1M1quWSIQvRE5e9A1TNScau+EB/qXG7xS6Cw=;
 b=Eq87sAS6mUz1KRUSycagLsd62MOsfNPB9VJLC7egJiuY5qbN9mXLCOtfHQIxzRdXpuYW
 zxol1ynoMFGmoBfoz+ARSu31dO7QjoBcuY5qrunHiPpPEogvOqPNCjBUCDkwoDJfYnT8
 sOGzRA2VctypVLK3ktkpXqsQ+XA/JLNnqIU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33k5nbge27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 16:19:01 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Sep 2020 16:19:00 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 83E9C294612F; Tue, 15 Sep 2020 16:18:57 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>, <netdev@vger.kernel.org>
Subject: [PATCH RFC v2 bpf-next 0/2] bpf: Enable bpf_skc_to_* sock casting helper to networking prog type
Date:   Tue, 15 Sep 2020 16:18:57 -0700
Message-ID: <20200915231857.1306320-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_14:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxlogscore=382 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150183
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set allows networking prog type to directly read fields from
the in-kernel socket type, e.g. "struct tcp_sock".

Patch 2 has the details on the use case.

It is currently under RFC since it needs proper tests and it builds on
top of Lorenz's patches:=20
   https://lore.kernel.org/bpf/20200910125631.225188-1-lmb@cloudflare.com=
/

v2:
- Add ARG_PTR_TO_SOCK_COMMON_OR_NULL (Lorenz)

Martin KaFai Lau (2):
  bpf: Move the PTR_TO_BTF_ID check to check_reg_type()
  bpf: Enable bpf_skc_to_* sock casting helper to networking prog type

 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 97 +++++++++++++++++++++++++++++--------------
 net/core/filter.c     | 73 ++++++++++++++++++++++----------
 3 files changed, 117 insertions(+), 54 deletions(-)

--=20
2.24.1

