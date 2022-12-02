Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81B64107A
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 23:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiLBWR3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 17:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLBWR2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 17:17:28 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328D8B5D84
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 14:17:28 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2K4QG6003678
        for <bpf@vger.kernel.org>; Fri, 2 Dec 2022 14:17:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=tkcwT+C1QJRCBRNZjxv8bkSy4fjZd/2B22bsUXK/XN4=;
 b=Cqw34lx1D1HQV4uU6zRPhfMngTh3xwLmC6tG8ilLLJ4Lw+hsUH2hvOV6lNr53VisNLQw
 XoXRmmfjj30ynAUtgbjjebl2T+eI7GmeCoalptmlt3z5VBaXgtAO84flvFh5sPg5K5qh
 rwn247PU/+d2cld7ftXsz7D9U7Nj9M8bN8r7q6XM9QNS+Ygm4GBJzO1Lr7zOcGG8TeVw
 JSdye0+Rs0ux9szEvDlg2lnfUGhhy5LaOm7okbH2zMYtDCR0NDZqbhSpHiv85JjLheHR
 P1MRLTgKSqO+HHb7qVsywt9p2CZT6tTeFWnnK1E+p2Mg865DQTZTjkISKB5om3Ynu4zg oA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m7gqn502h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 02 Dec 2022 14:17:27 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub104.TheFacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 14:17:25 -0800
Received: from twshared4568.42.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 14:17:25 -0800
Received: by devvm11876.prn0.facebook.com (Postfix, from userid 343873)
        id 4CEB34052A38; Fri,  2 Dec 2022 14:17:20 -0800 (PST)
From:   Sreevani Sreejith <ssreevani@meta.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
        <psreep@gmail.com>
CC:     <void@manifault.com>, <yhs@meta.com>, <mykolal@meta.com>,
        Sreevani <ssreevani@meta.com>
Subject: [PATCH v2 bpf-next 0/1] BPF Iterator Document
Date:   Fri, 2 Dec 2022 14:17:09 -0800
Message-ID: <20221202221710.320810-1-ssreevani@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5AkdKIYJd3iKw7KThzdcpFOc2ytObIs7
X-Proofpoint-GUID: 5AkdKIYJd3iKw7KThzdcpFOc2ytObIs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_12,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Sreevani <ssreevani@meta.com>

Removed SVG image file.

Sreevani Sreejith (1):
  bpf, docs: BPF Iterator Document

 Documentation/bpf/bpf_iterators.rst | 485 ++++++++++++++++++++++++++++
 Documentation/bpf/index.rst         |   1 +
 2 files changed, 486 insertions(+)
 create mode 100644 Documentation/bpf/bpf_iterators.rst

--=20
2.30.2

