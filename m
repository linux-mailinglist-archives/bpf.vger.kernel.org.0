Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34384493EA4
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356238AbiASQ4n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 11:56:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9958 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352790AbiASQ4l (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 11:56:41 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JG2oMU024102
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 08:56:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4WRI7L68uxXbCgF9lrCU93IcQAFn9Mxei5UBd28e1gw=;
 b=X2HVodzKBzdddl6JUAvdSt3ZUGXxFRqZJA/FEWP+2PB8NrOluX1St3gvOnIAIMRRfRA6
 ULyxh662V6mdV+njLk7XaPOEED9kjikdjxDyxVE3rvol+BcCmSBkXW+VYl/yby8huyr7
 YItlK1SNCLZQ4vsIuYxcUbj+5Ykhn95HwEU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp89ycrfn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 08:56:40 -0800
Received: from twshared21922.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 08:56:39 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id A1889941E702; Wed, 19 Jan 2022 08:56:27 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <phoenix1987@gmail.com>
CC:     <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
        <ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <kennyyu@fb.com>, <yhs@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Add test for sleepable bpf iterator programs
Date:   Wed, 19 Jan 2022 08:56:10 -0800
Message-ID: <20220119165610.3966158-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAGnuNNv0TVQ3ZSYjJgJh1Dxasc9pX-QTwVApYyW7Q0xEy0Bgng@mail.gmail.com>
References: <CAGnuNNv0TVQ3ZSYjJgJh1Dxasc9pX-QTwVApYyW7Q0xEy0Bgng@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RFkhN25VxUKpfuJj5rGbvjs8L7qfKTX_
X-Proofpoint-GUID: RFkhN25VxUKpfuJj5rGbvjs8L7qfKTX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_10,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201190096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > But I also wanted to point out that this helper is logically in the
> > same family as bpf_probe_read_kernel/user and bpf_copy_from_user, etc=
,
> > where we have consistent pattern that first two arguments specify
> > destination buffer (so buf + len) and the remaining ones specify
> > source (in probe_read it's just an address, here it's tsk_addr). So I
> > wonder if it would be less surprising and more consistent to reorder
> > and have:
> >
> > buf, len, tsk, addr, flags
> >
> > ?
> >
>
> I would personally find it more intuitive to have process information
> passed as either the first argument (like process_vm_readv does), or
> as "last", just before the flags (as extra information required w.r.t.
> to local versions, e.g. bpf_copy_from_user).

I think that makes sense. I'll combine both Andrii's and Gabriele's sugge=
stions
and keep the signature as close to the existing helpers
(e.g., bpf_probe_read_user) and add the additional arguments at the end.
I'll proceed with this signature:

  bpf_access_process_vm(void *dst,
  			u32 size,
			const void *unsafe_ptr,
			struct task_struct *tsk,
			unsigned int flags);

Thanks for all the suggestions!

Kenny
