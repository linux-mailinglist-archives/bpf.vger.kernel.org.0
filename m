Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7872148F4C4
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 05:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiAOEax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 23:30:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14686 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229952AbiAOEax (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Jan 2022 23:30:53 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20F1bert032580
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 20:30:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=v8K5tXsQCuF/GzOTc0UogewuOgJA5yUQ67i5GMBrxJc=;
 b=YXaVFZkA7T1QJOQgbx7DQPdwDN4R3Ml5Mm27nOLBZ/5nL+OpQdGyNUaseR+x2WjiiUli
 i7NLDmw07LlNJYFxRWPSLqIg6Sg96jVRMo2gThOIaQ0No1wZa8FCCgUzSeqvNVqQiQHv
 60ucm9qNAzr3Om+ZqrcZm+y/ZSftkA80rlo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dkaecm40b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 20:30:52 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 20:30:51 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 0F21090A211A; Fri, 14 Jan 2022 20:30:37 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
        <ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <kennyyu@fb.com>, <yhs@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Add test for sleepable bpf iterator programs
Date:   Fri, 14 Jan 2022 20:30:26 -0800
Message-ID: <20220115043026.1401889-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAEf4BzY9s1ngF_ja_rrpY=1cNX=byVSjptNT-LaEKTsUJEfP6Q@mail.gmail.com>
References: <CAEf4BzY9s1ngF_ja_rrpY=1cNX=byVSjptNT-LaEKTsUJEfP6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FavqonTrmjLNACWEO0du8a_HFiAFNwjb
X-Proofpoint-ORIG-GUID: FavqonTrmjLNACWEO0du8a_HFiAFNwjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-15_01,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

> Look at vmtest.sh under tools/testing/selftests/bpf, it handles
> building kernel, selftests and spinning up qemu instance for running
> selftests inside it.

Thanks, this helps!

> keeping generic u64 flags makes sense for the future, so I'd keep it.

That makes sense, I'll keep the flags in that case.

> But I also wanted to point out that this helper is logically in the
> same family as bpf_probe_read_kernel/user and bpf_copy_from_user, etc,
> where we have consistent pattern that first two arguments specify
> destination buffer (so buf + len) and the remaining ones specify
> source (in probe_read it's just an address, here it's tsk_addr). So I
> wonder if it would be less surprising and more consistent to reorder
> and have:
>=20
> buf, len, tsk, addr, flags
>
> ?

Yeah, that looks better for consistency. Should I still keep the name
as `bpf_access_process_vm`, or call it something else to be more consiste=
nt
with the naming of the other bpf helpers? The benefit of the
`bpf_access_process_vm` name is that it makes it obvious it is wrapping
an existing function `access_process_vm`.=20

Thanks for the feedback!

Kenny
