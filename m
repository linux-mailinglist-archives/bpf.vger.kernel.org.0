Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D174986D5
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 18:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbiAXRbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 12:31:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60326 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244442AbiAXRbu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 12:31:50 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OHVhvn019301
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 09:31:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AQNNK9l8/JAKp2jzg+ctyYoaHfk/NvhYvMPFixSRRTk=;
 b=NWcaf0cZtGQlkjDG+IklSuNsUzzcNE3AfAJ4JJ9U0xp5CMCH1gns1TQgj0ywdzl+CCMX
 X/7/oXtQNu5kdMCUTzagRwXttJbAIcVc6uXxxataHdQOWpv3bdvf4w0TGM416i6q/yNS
 ds4IM7hBxjuFcimvDwxHNspNGzaVlbQ7ips= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dswd8hhr9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 09:31:48 -0800
Received: from twshared13833.42.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 09:30:40 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id BD52E9808C20; Mon, 24 Jan 2022 09:30:34 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <yhs@fb.com>
CC:     <alexei.starovoitov@gmail.com>, <andrii.nakryiko@gmail.com>,
        <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <kennyyu@fb.com>, <phoenix1987@gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/3] bpf: Add bpf_copy_from_user_task() helper
Date:   Mon, 24 Jan 2022 09:30:27 -0800
Message-ID: <20220124173027.1868912-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <170be4e4-6709-cfae-f728-81fc4452f111@fb.com>
References: <170be4e4-6709-cfae-f728-81fc4452f111@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BxK4-AgDLU7y9NjLxZupSGjQ7d6SigeU
X-Proofpoint-ORIG-GUID: BxK4-AgDLU7y9NjLxZupSGjQ7d6SigeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> "On error dst buffer is zeroed out."? This is an explicit guarantee.

Will add to the docs.

> is there a point in calling access_process_vm() with size =3D=3D 0? It
> would validate that get_task_mm() succeeds, but that's pretty much it?
> So maybe instead just exit early if size is zero? It will be also less
> convoluted logic:
>=20
> if (size =3D=3D 0)
>     return 0;
> if (access_process_vm(...)) {
>     memset(0);
>     return -EFAULT;
> }
> return 0;

Will do an explicit check for `size =3D=3D 0`.
Note that we still need to check if the return value of
`access_process_vm` =3D=3D `size` to see if we have a partial read.

> > Without the above change, using bpf_copy_from_user_task() will trigge=
r
> > rcu warning and may produce incorrect result. One option is to put
> > the above in a preparation patch before introducing
> > bpf_copy_from_user_task() so we won't have bisecting issues.
>
> Sure, patch #1 for sleepable bpf_iter, patch #2 for the helper? I
> mean, it's not a big deal, but both seem to deserve their own focused
> patches.

I'll split this into 2 patches and place the bpf_iter patch first.

> I appreciate that existing helpers already do this and it's good to
> follow suit for consistency, but what is the rationale behind zeroing
> memory on failure?

I believe the intent behind this is for security/privacy reasons.
On error, we don't want to unintentionally leak partially read data.

Thanks everyone for the suggestions!

Kenny
