Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32D548F2DC
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 00:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiANXOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 18:14:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbiANXOz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Jan 2022 18:14:55 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20EMbtOI006541
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 15:14:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6e86mrg2QR0GbtS0nIUYgPqcoXSnFtv+nZIPuAJKrBw=;
 b=GLkF5CJ3zL+0RWQbgc8iqHglycGENc6HZ/5ZqTtsVx06QZbFAFkh8/iPS3hhpfxFCGrX
 jT2ZZI6P0Kp6xVR3taHZ+CY31ayFzm9U1IPrDUYoQpVkSTpJW9WRD1TT8fLqq9H0fygd
 93u5ZT6oyyo00IhSx8QyQwVMF52DvsI073w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dk7u3bwaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 15:14:54 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 15:14:54 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id AF5A29072CFA; Fri, 14 Jan 2022 15:14:46 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <alexei.starovoitov@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <kennyyu@fb.com>, <yhs@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Add test for sleepable bpf iterator programs
Date:   Fri, 14 Jan 2022 15:14:26 -0800
Message-ID: <20220114231426.426052-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAADnVQ+nS1++7NwcAPuwO26CcuvNnPVMQgtwi4FDNcmHQEBm8g@mail.gmail.com>
References: <CAADnVQ+nS1++7NwcAPuwO26CcuvNnPVMQgtwi4FDNcmHQEBm8g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JteMGD-_c1NjvbMnA84fgxV4Zor2JLVo
X-Proofpoint-ORIG-GUID: JteMGD-_c1NjvbMnA84fgxV4Zor2JLVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_07,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=950 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

> > +// New helper added
> > +static long (*bpf_access_process_vm)(
> > +       struct task_struct *tsk,
> > +       unsigned long addr,
> > +       void *buf,
> > +       int len,
> > +       unsigned int gup_flags) =3D (void *)186;
>
> This shouldn't be needed.
> Since patch 1 updates tools/include/uapi/linux/bpf.h
> it will be in bpf_helper_defs.h automatically.

I will fix. This is my first time writing selftests, so I am not too fami=
liar
with how these are built and run. For my understanding, are these tests
meant to be built and run after booting the new kernel?

> > +
> > +// Copied from include/linux/mm.h
> > +#define FOLL_REMOTE 0x2000 /* we are working on non-current tsk/mm *=
/
>
> Please use C style comments only.

I will fix.

> > +       numread =3D bpf_access_process_vm(task,
> > +                                       (unsigned long)ptr,
> > +                                       (void *)&user_data,
> > +                                       sizeof(uint32_t),
> > +                                       FOLL_REMOTE);
>=20
> We probably would need to hide flags like FOLL_REMOTE
> inside the helper otherwise prog might confuse the kernel.
> In this case I'm not even sure that FOLL_REMOTE is needed.
> I suspect gup_flags=3D0 in all cases will work fine.
> We're not doing write here and not pining anything.
> fast_gup is not necessary either.

Thanks for the suggestion! I'll remove the flag argument from the helper
to simplify the API for bpf programs. This means that the helper will hav=
e
the following signature:

  bpf_access_process_vm(struct task_struct *tsk,
                        unsigned long addr,
                        void *buf,
                        int len);

Thanks for the feedback!

Kenny
