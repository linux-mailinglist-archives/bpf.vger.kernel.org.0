Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562F890015
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 12:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfHPKes convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 16 Aug 2019 06:34:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726761AbfHPKes (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 06:34:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GAVn4G177684
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 06:34:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2udtr287rh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 06:34:47 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 16 Aug 2019 11:34:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Aug 2019 11:34:43 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GAYgSM50397262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 10:34:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 890ADA4066;
        Fri, 16 Aug 2019 10:34:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C1DDA4054;
        Fri, 16 Aug 2019 10:34:42 +0000 (GMT)
Received: from dyn-9-152-96-190.boeblingen.de.ibm.com (unknown [9.152.96.190])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 10:34:42 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH bpf] bpf: fix accessing bpf_sysctl.file_pos on s390
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <515ad8ab-9ded-5573-b2c5-37ee9c23dd6e@fb.com>
Date:   Fri, 16 Aug 2019 12:34:41 +0200
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20190815112044.38420-1-iii@linux.ibm.com>
 <515ad8ab-9ded-5573-b2c5-37ee9c23dd6e@fb.com>
To:     Yonghong Song <yhs@fb.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19081610-0012-0000-0000-0000033F5A36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081610-0013-0000-0000-0000217973B1
Message-Id: <AA7D06F3-907C-434D-8387-9481FF99BC4C@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160110
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 16.08.2019 um 01:01 schrieb Yonghong Song <yhs@fb.com>:
> 
> 
> 
> On 8/15/19 4:20 AM, Ilya Leoshkevich wrote:
>> "ctx:file_pos sysctl:read write ok" fails on s390 with "Read value  !=
>> nux". This is because verifier rewrites a complete 32-bit
>> bpf_sysctl.file_pos update to a partial update of the first 32 bits of
>> 64-bit *bpf_sysctl_kern.ppos, which is not correct on big-endian
>> systems.
>> 
>> Fix by using an offset on big-endian systems.
>> 
>> Ditto for bpf_sysctl.file_pos reads. Currently the test does not detect
>> a problem there, since it expects to see 0, which it gets with high
>> probability in error cases, so change it to seek to offset 3 and expect
>> 3 in bpf_sysctl.file_pos.
>> 
>> Fixes: e1550bfe0de4 ("bpf: Add file_pos field to bpf_sysctl ctx")
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>  include/linux/filter.h                    | 10 ++++++++++
>>  kernel/bpf/cgroup.c                       |  9 +++++++--
>>  tools/testing/selftests/bpf/test_sysctl.c |  9 ++++++++-
>>  3 files changed, 25 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 92c6e31fb008..94e81c56d81c 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -760,6 +760,16 @@ bpf_ctx_narrow_load_shift(u32 off, u32 size, u32 size_default)
>>  #endif
>>  }
>> 
>> +static inline s16
>> +bpf_ctx_narrow_access_offset(size_t variable_size, size_t access_size)
>> +{
>> +#ifdef __LITTLE_ENDIAN
>> +	return 0;
>> +#else
>> +	return variable_size - access_size;
>> +#endif
>> +}
> 
> The change looks correct to me.
> But now in include/linux/filter.h we have to macros:
> 
> static inline u8
> bpf_ctx_narrow_load_shift(u32 off, u32 size, u32 size_default)
> {
>         u8 load_off = off & (size_default - 1);
> 
> #ifdef __LITTLE_ENDIAN
>         return load_off * 8;
> #else
>         return (size_default - (load_off + size)) * 8;
> #endif
> }
> 
> static inline s16
> bpf_ctx_narrow_access_offset(size_t variable_size, size_t access_size)
> {
> #ifdef __LITTLE_ENDIAN
>         return 0;
> #else
>         return variable_size - access_size;
> #endif
> }
> 
> It would be good if we can have ifdef __LITTLE_ENDIAN only in one place.
> How about something like below:
> 
> static inline u8
> bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
> {
>         u8 access_off = off & (size_default - 1);
> 
> #ifdef __LITTLE_ENDIAN
>         return access_off;
> #else
>         return size_default - (access_off + size);
> #endif
> }
> 
> static inline u8
> bpf_ctx_narrow_load_shift(u32 off, u32 size, u32 size_default)
> {
>         return bpf_ctx_narrow_access_offset(off, size, size_default) * 8;
> }

This does indeed look better, thanks! In this case, we don't even need
bpf_ctx_narrow_load_shift() anymore, since doing

u8 shift = bpf_ctx_narrow_access_offset(
       off, size, size_default) * 8;

directly is quite readable. I will test and send a v2.
