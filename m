Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B410F3EF2E3
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 21:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhHQTuB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 15:50:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52722 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231281AbhHQTuB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 15:50:01 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HJjruY004194
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=2JfdCWAxdgH2IUSvF1eC/qytJqvf9nPPvYeyX1zsCwI=;
 b=iOdGIyBEpzI5GcQwxLwCqE6XZ5xDEIqXOwwVlAJfr/7RpHfg7zKKUnLBz1ZA6ZjMZ/FU
 fyJmSjyPVMbXP2hej4WzEgq7xTvZDxdtd4x3rW0l+tLCzA2mqSkdfvWKVZ6C73ua8V7D
 rpBgoVH57rDac2FAJqK51SgmmtIRlzJDAAU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aftr4rssa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:49:27 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 12:49:26 -0700
Received: by devbig577.ftw3.facebook.com (Postfix, from userid 201728)
        id 9C37F6E748C5; Tue, 17 Aug 2021 12:49:21 -0700 (PDT)
From:   Prankur gupta <prankgup@fb.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>, <prankgup@fb.com>,
        <prankur.07@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add support for {set|get} socket options from setsockopt BPF
Date:   Tue, 17 Aug 2021 12:49:21 -0700
Message-ID: <20210817194921.2317212-1-prankgup@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAEf4BzacXvT5tsVe-xYSOYrxrf8B_02jG=Hv67SXhC-8rWcxrw@mail.gmail.com>
References: <CAEf4BzacXvT5tsVe-xYSOYrxrf8B_02jG=Hv67SXhC-8rWcxrw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: _hnYbIFqfJ-jHm2BMCXh0MTPPANnodma
X-Proofpoint-GUID: _hnYbIFqfJ-jHm2BMCXh0MTPPANnodma
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>>
>> Add logic to call bpf_setsockopt and bpf_getsockopt from
>> setsockopt BPF programs.
>> Example use case, when the user sets the IPV6_TCLASS socket option
>> we would also like to change the tcp-cc for that socket.
>> We don't have any use case for calling bpf_setsockopt from
>> supposedly read-only sys_getsockopti, so it is made available to
>> BPF_CGROUP_SETSOCKOPT only.
>>
>> Signed-off-by: Prankur gupta <prankgup@fb.com>
>> ---
>>  kernel/bpf/cgroup.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index a1dedba4c174..9c92eff9af95 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -1873,6 +1873,14 @@ cg_sockopt_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>>                 return &bpf_sk_storage_get_proto;
>>         case BPF_FUNC_sk_storage_delete:
>>                 return &bpf_sk_storage_delete_proto;
>> +       case BPF_FUNC_setsockopt:
>> +               if (prog->expected_attach_type =3D=3D BPF_CGROUP_SETSO=
CKOPT)
>> +                       return &bpf_sk_setsockopt_proto;
>> +               return NULL;
>> +       case BPF_FUNC_getsockopt:
>> +               if (prog->expected_attach_type =3D=3D BPF_CGROUP_SETSO=
CKOPT)
>> +                       return &bpf_sk_getsockopt_proto;
>
>Is there any problem enabling bpf_getsockopt() for
>BPF_CGROUP_GETSOCKOPT program type?
>

No, there's no problem but there's no usecase (which i can think of)
where a user wants to set or get some socket option for a getsockopt call

>> +               return NULL;
>>  #endif
>>  #ifdef CONFIG_INET
>>         case BPF_FUNC_tcp_sock:
>> --
>> 2.30.2
>>
