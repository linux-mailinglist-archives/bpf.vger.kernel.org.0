Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B14952EF
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 18:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347607AbiATRMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 12:12:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346412AbiATRMQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 12:12:16 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K3OKuf029646
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 09:12:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SgDD2FK7n6+3Hlilm6Sfyb0lLQl+3zuugsaXKloD41k=;
 b=qVOPfgv23XGDd8s/INTsW67LeeS2JMKD5Y5sR/xbLhoRl9K9DVsj1BEkQGHBwPfEnDQJ
 9c1d4rr9Way6a+iOb0T6gggPdSMtls7K3GmZ/JTw5C27prJWmWnSh/atox4L53BKx7FV
 iMRdyFkyaFvZ4Limgn/e1OmdsCzWKVwPW3Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpysx3yk5-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 09:12:15 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 09:12:14 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 1462894F1170; Thu, 20 Jan 2022 09:12:06 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <yhs@fb.com>
CC:     <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
        <ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <kennyyu@fb.com>, <phoenix1987@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
Date:   Thu, 20 Jan 2022 09:11:54 -0800
Message-ID: <20220120171154.3688951-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cae83c38-3c83-af42-a0ef-551611d0af5f@fb.com>
References: <cae83c38-3c83-af42-a0ef-551611d0af5f@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9IAyrL3FWzDz6dHZd_BIk7jd0o81rULY
X-Proofpoint-GUID: 9IAyrL3FWzDz6dHZd_BIk7jd0o81rULY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=989 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200089
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > + * long bpf_access_process_vm(void *dst, u32 size, const void *unsaf=
e_ptr, struct task_struct *tsk, u32 flags)
>=20
> Maybe we can change 'flags' type to u64? This will leave more room for=20
> future potential extensions. In all recent helpers with added 'flags',=20
> most of them are u64.

I'll change it to u64. Thanks for the suggestion!

Kenny
