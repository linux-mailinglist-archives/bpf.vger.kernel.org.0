Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE5D494343
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 23:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357609AbiASWv1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 17:51:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31028 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbiASWv0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 17:51:26 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIs85d030881
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:51:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ejyZFdyQ3OKGeyUtYkIB3U3AnhSKEXqTOV6qYnJdmWU=;
 b=HrS5Auy6GfEyDeTKoUrFu3+scqBfGjvDNHhRzegjks0zNSYHI6VXD6adRQYJK6x8iiV8
 0y6bXfDlK4tU4aNzI+pfRJET4OQQeZGQGO2QVmADXtOeh35rPRzItZihUUyRl/plw56U
 d6Mm3mk+H4KgL3W2SHdFulp8S/MAWu/1J6I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dpafj6gww-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:51:25 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 14:51:18 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 1EEA1945BA44; Wed, 19 Jan 2022 14:51:12 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <alexei.starovoitov@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <kennyyu@fb.com>, <phoenix1987@gmail.com>,
        <yhs@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
Date:   Wed, 19 Jan 2022 14:51:10 -0800
Message-ID: <20220119225110.2026595-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAADnVQKDfacNQD8WCp-mmQeyWd6Y09_b41L1=E3b3A6+GCyH+w@mail.gmail.com>
References: <CAADnVQKDfacNQD8WCp-mmQeyWd6Y09_b41L1=E3b3A6+GCyH+w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fL7G0YGVuzl7UkMABSUqddCKzefSMBpk
X-Proofpoint-GUID: fL7G0YGVuzl7UkMABSUqddCKzefSMBpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=906 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > +BPF_CALL_5(bpf_access_process_vm, void *, dst, u32, size,
> > +          const void __user *, user_ptr, struct task_struct *, tsk,
> > +          u32, flags)
> > +{
> > +       /* flags is not used yet */
> > +       return access_process_vm(tsk, (unsigned long)user_ptr, dst, s=
ize, 0);
> > +}
>
> Though the 'flags' argument is unused the helper has to check
> that it's zero and return -EINVAL otherwise.
> If we don't do this we won't be able to change the behavior later
> due to backward compatibility.

Thanks for the feedback! Will fix.

Kenny
