Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED31B477FF7
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 23:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhLPWVz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 17:21:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhLPWVz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 17:21:55 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGHJWgi013154
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 14:21:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=H7ixoRWxvGmGbBlf67SqKO38E2i95W6A6B7ZCgwUlHY=;
 b=L04ljmLj65sGMSx+45YccoV39RdU26KGng3l7g77CHysrJgoVU6pnwRxH+Cz6oXTvg2u
 /njvRVzq8USSvdKYBkP42Qz7PqUsYTLVtwy02DbZs4NBBQe6KhH7iPx7frn2OtUgWN4L
 QJ8XPhePKJPiDHg747nWz34RWiUIj/uoPBE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cyyrr6fcd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 14:21:54 -0800
Received: from twshared10426.24.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 14:21:51 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id DB871790646; Thu, 16 Dec 2021 14:21:41 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christylee@fb.com>, <christyc.y.lee@gmail.com>,
        <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/2] perf: stop using deprecated bpf APIs
Date:   Thu, 16 Dec 2021 14:21:06 -0800
Message-ID: <20211216222108.110518-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: J7OSsf26zNHiBs2DsP3BQYgRlwxcG2JB
X-Proofpoint-ORIG-GUID: J7OSsf26zNHiBs2DsP3BQYgRlwxcG2JB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_09,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=751 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Except for multi-instance bpf program APIs, remove perf use cases
of deprecated bpf APIs.

Christy Lee (2):
  perf: stop using deprecated bpf_prog_load() API
  perf: stop using deprecated bpf__object_next() API

 tools/perf/tests/bpf.c       | 14 ++-----
 tools/perf/util/bpf-loader.c | 73 +++++++++++++++++++++++++++---------
 tools/perf/util/bpf-loader.h |  1 +
 3 files changed, 60 insertions(+), 28 deletions(-)

--
2.30.2
