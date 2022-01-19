Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7788F4943A7
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 00:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357662AbiASXJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 18:09:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26806 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357885AbiASXJ1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 18:09:27 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIrvBa028940
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 15:09:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=RmitwdMG68ml3CKsZ9y7jKrGxHfJr5Nnu/Fzbm1K6xY=;
 b=OBp49cl6iHu7d75CYreQMNLAhVW1FgF0zkUgz7zfnq4GYvh+M1oDCuM9JqA0T63xcBSQ
 nlSNad/kwz7yjx1ZSUu9cACFjFFlX9PMtqlDjTsyoOZIrdSWES0pXgoEM9xHtOZXHMDu
 DK9/+czdJPBN0/Fvftk6ILdXuI6mpsc9YHM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpad3xmb6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 15:09:27 -0800
Received: from twshared1259.42.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 15:09:26 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id D93621F0A165; Wed, 19 Jan 2022 15:06:40 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>, <jolsa@redhat.com>
CC:     <christylee@fb.com>, <christyc.y.lee@gmail.com>,
        <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kernel-team@fb.com>, <wangnan0@huawei.com>,
        <bobo.shaobowang@huawei.com>, <yuehaibing@huawei.com>
Subject: [PATCH bpf-next v4 0/2] perf: stop using deprecated bpf APIs
Date:   Wed, 19 Jan 2022 15:06:34 -0800
Message-ID: <20220119230636.1752684-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 97YF55cv537PzYd7_qBuTT64C_m4ar1r
X-Proofpoint-ORIG-GUID: 97YF55cv537PzYd7_qBuTT64C_m4ar1r
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=892
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf's bpf_load_program() and bpf__object_next() APIs are deprecated.
remove perf's usage of these deprecated functions. After this patch
set, the only remaining libbpf deprecated APIs in perf would be
bpf_program__set_prep() and bpf_program__nth_fd().

Changelog:
----------
v3 -> v4:
* Fixed commit title
* Added weak definition for deprecated function

v2 -> v3:
https://lore.kernel.org/all/20220106200032.3067127-1-christylee@fb.com/

Patch 2/2:
Fixed commit message to use upstream perf

v1 -> v2:
https://lore.kernel.org/all/20211216222108.110518-1-christylee@fb.com/

Patch 1/2:
Added missing commit message

Patch 2/2:
Added more details to commit message and added steps to reproduce
original test case.

Christy Lee (2):
  perf: stop using deprecated bpf_load_program() API
  perf: stop using deprecated bpf_object__next() API

 tools/perf/tests/bpf.c       | 14 ++-----
 tools/perf/util/bpf-event.c  | 16 ++++++++
 tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
 tools/perf/util/bpf-loader.h |  1 +
 4 files changed, 75 insertions(+), 28 deletions(-)

--
2.30.2
