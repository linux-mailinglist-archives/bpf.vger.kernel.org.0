Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF904733E4
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 19:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhLMSVm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 13:21:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20008 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232192AbhLMSVm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 13:21:42 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BDHAD9I031562
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 10:21:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ea70dzxpP2LHEv3LlERISPb2o453oohTl7FnA1qFbOc=;
 b=ZqGavV3dr3w9rGWo4fP5JTUa0O89YopSTgSLdAOv90xEn2MIHe8xMWjlBoXSYqlqQIpp
 UWygpeaq9vnf/2SHKnzcLsTeAGXjFPp9xWuvobLj4mhIVgSA64s4yp2BYGUuiiBKgr4W
 FXPR25TzuhNqXeexVqyJ1uzGLUkH8r+yHeg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cx9rp0v8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 10:21:41 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 10:21:40 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 788C35379F5; Mon, 13 Dec 2021 10:21:38 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <christylee@fb.com>, <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] Improve verifier log readability
Date:   Mon, 13 Dec 2021 10:21:14 -0800
Message-ID: <20211213182117.682461-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 38sjXR-KHU7mwJkoPsBic0RGjG-2S9d1
X-Proofpoint-GUID: 38sjXR-KHU7mwJkoPsBic0RGjG-2S9d1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_08,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=649 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simplify verifier logs and improve readability.

Christy Lee (3):
  Only print scratched registers and stack slots to verifier logs
  Right align verifier states in verifier logs
  Only output backtracking information in log level 2

 include/linux/bpf_verifier.h |   9 +++
 kernel/bpf/verifier.c        | 116 ++++++++++++++++++++++++++++++-----
 2 files changed, 111 insertions(+), 14 deletions(-)

--=20
2.30.2

