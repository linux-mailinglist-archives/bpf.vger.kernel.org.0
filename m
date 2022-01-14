Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048E248F2DD
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 00:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiANXPw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 18:15:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1206 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbiANXPw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Jan 2022 18:15:52 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20EMbtGe006557
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 15:15:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=XVsiZO4VaHhbvUp+B2eunBsZNDFCBAIJiseqrNzbJ/I=;
 b=qR3suSPPMWdYacqoEVHuf84grPeukXb8Qdy5wdLmjZhPEsQcJEPvYmWsF5PJuNhkYlde
 ASTBGTaRZZSocsUBas06zFHjdIS+uvkCULgVRN//tFms7oVpynIahramJwWbl68avKwl
 zvyrq19wRU0E48fjwD2+AuoV6h15jBsBZd8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dk7u3bwep-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 15:15:52 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 15:15:51 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id B1D639072F50; Fri, 14 Jan 2022 15:15:43 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <alexei.starovoitov@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <kennyyu@fb.com>, <yhs@fb.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Add support for sleepable programs in bpf_iter_run_prog
Date:   Fri, 14 Jan 2022 15:15:34 -0800
Message-ID: <20220114231534.480314-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAADnVQKmdrXi=6AZbg6+-YG2d08PxuJ0D+z0FqT175jXra1f_w@mail.gmail.com>
References: <CAADnVQKmdrXi=6AZbg6+-YG2d08PxuJ0D+z0FqT175jXra1f_w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _p4PLjLqsQP4rDx27p2lPMZ8H8dCFMSo
X-Proofpoint-ORIG-GUID: _p4PLjLqsQP4rDx27p2lPMZ8H8dCFMSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_07,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=667 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

> Pretty cool that a single 'if' is all that is needed to enable
> sleepable iterators.
>=20
> Maybe combine under one 'if' ?
> if (prog->aux->sleepable) {
>   lock_trace
>   migr_dis
>   might_fault
>   bpf_prog_run
>   migr_en
>   unlock_trace
> } else {
>   lock
>   migr_dis
>   bpf_prog_run
>   migr_end
>   unlock
> }
>
> Would it be easier to read?

Yes, I agree, that is more readable. I'll make the change. I'll also
follow Yonghong Song's suggestion (offline) of merging this patch into
the first patch to keep bisectability together.

Thanks for the feedback!

Kenny
