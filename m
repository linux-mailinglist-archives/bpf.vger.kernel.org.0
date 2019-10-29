Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5ADE8AA2
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 15:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbfJ2OUI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 29 Oct 2019 10:20:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389167AbfJ2OUI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Oct 2019 10:20:08 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TE8MHh001444
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 10:20:07 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxf6uye0n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 10:20:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 29 Oct 2019 14:19:43 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Oct 2019 14:19:40 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9TEJdMC38666482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 14:19:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A823AE057;
        Tue, 29 Oct 2019 14:19:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F16CEAE055;
        Tue, 29 Oct 2019 14:19:38 +0000 (GMT)
Received: from dyn-9-152-96-221.boeblingen.de.ibm.com (unknown [9.152.96.221])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 14:19:38 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAEf4BzajQL463pCogVAnX1H5Tg-+kj9p_-mAJs=n1r6OfZ2mXg@mail.gmail.com>
Date:   Tue, 29 Oct 2019 15:19:38 +0100
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Andrey Ignatov <rdna@fb.com>
Content-Transfer-Encoding: 8BIT
References: <20191028122902.9763-1-iii@linux.ibm.com>
 <CAEf4BzajQL463pCogVAnX1H5Tg-+kj9p_-mAJs=n1r6OfZ2mXg@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
X-TM-AS-GCONF: 00
x-cbid: 19102914-0012-0000-0000-0000035ECDF1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102914-0013-0000-0000-0000219A0FE2
Message-Id: <9B04A778-42CE-4451-A276-5A41D6290055@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=968 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290138
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 29.10.2019 um 05:36 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.com>:
> 
> On Mon, Oct 28, 2019 at 1:09 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>> 
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -1311,12 +1311,12 @@ static bool sysctl_is_valid_access(int off, int size, enum bpf_access_type type,
>>                return false;
>> 
>>        switch (off) {
>> -       case offsetof(struct bpf_sysctl, write):
>> +       case bpf_ctx_range(struct bpf_sysctl, write):
> 
> this will actually allow reads pas t write field (e.g., offset = 2, size = 4).

Wouldn't

	if (off < 0 || off + size > sizeof(struct bpf_sysctl) || off % size)
		return false;

prevent all OOB read-write attempts? Especially the off % size part - I
think it has the effect of preventing OOB accesses for fields. In
particular, it would filter offset = 2, size = 4 case.

I have also checked the other usages of bpf_ctx_range, for example,
bpf_skb_is_valid_access, and they don't seem to be doing anything
special.

> 
>>                if (type != BPF_READ)
>>                        return false;
>>                bpf_ctx_record_field_size(info, size_default);
>>                return bpf_ctx_narrow_access_ok(off, size, size_default);
>> -       case offsetof(struct bpf_sysctl, file_pos):
>> +       case bpf_ctx_range(struct bpf_sysctl, file_pos)
> 
> this will allow read past context struct altogether. When we allow
> ranges, we will have to adjust allowed read size.

Same here.
