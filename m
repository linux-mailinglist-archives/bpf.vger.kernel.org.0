Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2FF5A8778
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 21:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfIDNxl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 4 Sep 2019 09:53:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730457AbfIDNxl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Sep 2019 09:53:41 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x84DlIw2099010
        for <bpf@vger.kernel.org>; Wed, 4 Sep 2019 09:53:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utdes31n4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2019 09:53:39 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 4 Sep 2019 14:53:38 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Sep 2019 14:53:35 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x84DrYX752494372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 13:53:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62555A4051;
        Wed,  4 Sep 2019 13:53:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 207A2A4040;
        Wed,  4 Sep 2019 13:53:34 +0000 (GMT)
Received: from dyn-9-152-98-23.boeblingen.de.ibm.com (unknown [9.152.98.23])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 13:53:34 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH bpf v2] bpf: fix accessing bpf_sysctl.file_pos on s390
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <55d0fca4-099a-9fb8-8dcd-9cca31e18063@iogearbox.net>
Date:   Wed, 4 Sep 2019 15:53:33 +0200
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Andrey Ignatov <rdna@fb.com>, Yonghong Song <yhs@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20190816105300.49035-1-iii@linux.ibm.com>
 <55d0fca4-099a-9fb8-8dcd-9cca31e18063@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19090413-0020-0000-0000-00000367A4EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090413-0021-0000-0000-000021BD147A
Message-Id: <786A5138-BDE6-4C9F-A302-4E8B7D2DD46F@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040138
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 04.09.2019 um 00:13 schrieb Daniel Borkmann <daniel@iogearbox.net>:
> 
> On 8/16/19 12:53 PM, Ilya Leoshkevich wrote:
>> "ctx:file_pos sysctl:read write ok" fails on s390 with "Read value  !=
>> nux". This is because verifier rewrites a complete 32-bit
>> bpf_sysctl.file_pos update to a partial update of the first 32 bits of
>> 64-bit *bpf_sysctl_kern.ppos, which is not correct on big-endian
>> systems.
>> Fix by using an offset on big-endian systems.
>> Ditto for bpf_sysctl.file_pos reads. Currently the test does not detect
>> a problem there, since it expects to see 0, which it gets with high
>> probability in error cases, so change it to seek to offset 3 and expect
>> 3 in bpf_sysctl.file_pos.
>> Fixes: e1550bfe0de4 ("bpf: Add file_pos field to bpf_sysctl ctx")
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>> v1->v2: Merge bpf_ctx_narrow_load_shift and
>> bpf_ctx_narrow_access_offset.
>>  include/linux/filter.h                    |  8 ++++----
>>  kernel/bpf/cgroup.c                       | 10 ++++++++--
>>  kernel/bpf/verifier.c                     |  4 ++--
>>  tools/testing/selftests/bpf/test_sysctl.c |  9 ++++++++-
>>  4 files changed, 22 insertions(+), 9 deletions(-)
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 92c6e31fb008..2ce57645f3cd 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -749,14 +749,14 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
>>  }
>>    static inline u8
>> -bpf_ctx_narrow_load_shift(u32 off, u32 size, u32 size_default)
>> +bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
>>  {
>> -	u8 load_off = off & (size_default - 1);
>> +	u8 access_off = off & (size_default - 1);
>>    #ifdef __LITTLE_ENDIAN
>> -	return load_off * 8;
>> +	return access_off;
>>  #else
>> -	return (size_default - (load_off + size)) * 8;
>> +	return size_default - (access_off + size);
>>  #endif
>>  }
>>  diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 0a00eaca6fae..00c4647ce92a 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -1325,6 +1325,7 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
>>  				     struct bpf_prog *prog, u32 *target_size)
>>  {
>>  	struct bpf_insn *insn = insn_buf;
>> +	u32 read_size;
>>    	switch (si->off) {
>>  	case offsetof(struct bpf_sysctl, write):
>> @@ -1356,7 +1357,9 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
>>  				treg, si->dst_reg,
>>  				offsetof(struct bpf_sysctl_kern, ppos));
>>  			*insn++ = BPF_STX_MEM(
>> -				BPF_SIZEOF(u32), treg, si->src_reg, 0);
>> +				BPF_SIZEOF(u32), treg, si->src_reg,
>> +				bpf_ctx_narrow_access_offset(
>> +					0, sizeof(u32), sizeof(loff_t)));
>>  			*insn++ = BPF_LDX_MEM(
>>  				BPF_DW, treg, si->dst_reg,
>>  				offsetof(struct bpf_sysctl_kern, tmp_reg));
>> @@ -1365,8 +1368,11 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
>>  				BPF_FIELD_SIZEOF(struct bpf_sysctl_kern, ppos),
>>  				si->dst_reg, si->src_reg,
>>  				offsetof(struct bpf_sysctl_kern, ppos));
>> +			read_size = bpf_size_to_bytes(BPF_SIZE(si->code));
>>  			*insn++ = BPF_LDX_MEM(
>> -				BPF_SIZE(si->code), si->dst_reg, si->dst_reg, 0);
>> +				BPF_SIZE(si->code), si->dst_reg, si->dst_reg,
>> +				bpf_ctx_narrow_access_offset(
>> +					0, read_size, sizeof(loff_t)));
> 
> I see what you're doing, but generally I'm a bit puzzled on why we need these
> partial store/loads and cannot access the full loff_t value internally with the
> rewrite. Why was BPF_SIZEOF(u32) chosen in the first place? Looks like git history
> doesn't have any useful insight here ... Andrey mind to put some clarifications
> on this? Thx

Do you mean rewriting e.g. the following:

    BPF_LDX_MEM(access_size, si->dst_reg, si->src_reg,
                offsetof(struct bpf_sysctl, file_pos)));

as the following?

    BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sysctl_kern, ppos),
                si->dst_reg, si->src_reg,
                offsetof(struct bpf_sysctl_kern, ppos));
    BPF_LDX_MEM(BPF_DW, si->dst_reg, si->dst_reg, 0);  # full loff_t

while also doing

    *target_size = sizeof(loff_t);

in order to let is_narrower_load logic in convert_ctx_accesses () do the
masking? That would work, but wouldn't the generated code be less
efficient due to explicit masking?
