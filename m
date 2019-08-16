Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 897FC900D6
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfHPLho convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 16 Aug 2019 07:37:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727081AbfHPLhn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 07:37:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GBbOU8116416
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 07:37:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uduk6rds5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 07:37:42 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 16 Aug 2019 12:37:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Aug 2019 12:37:37 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GBbaUH46071836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 11:37:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D938AA4060;
        Fri, 16 Aug 2019 11:37:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C2F0A4054;
        Fri, 16 Aug 2019 11:37:36 +0000 (GMT)
Received: from dyn-9-152-96-190.boeblingen.de.ibm.com (unknown [9.152.96.190])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 11:37:36 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH bpf] selftests/bpf: fix endianness issues in test_sysctl
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <076513cd-fbde-cf66-ce3b-a6143878f786@fb.com>
Date:   Fri, 16 Aug 2019 13:37:36 +0200
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20190815122525.41073-1-iii@linux.ibm.com>
 <076513cd-fbde-cf66-ce3b-a6143878f786@fb.com>
To:     Yonghong Song <yhs@fb.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19081611-0028-0000-0000-000003905E42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081611-0029-0000-0000-0000245277CD
Message-Id: <91EFE17B-3835-4679-8464-A76C885BCD46@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160123
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 16.08.2019 um 02:05 schrieb Yonghong Song <yhs@fb.com>:
> 
>> +# define __bpf_constant_be64_to_cpu(x)	___constant_swab64(x)
> 
> bpf_endian.h is used for both bpf program and native applications.
> Could you make sure it works for bpf programs? It should be, but want to 
> double check.

Yes:

#include <linux/compiler_attributes.h>
#include "bpf_endian.h"
u64 answer() { return __bpf_constant_be64_to_cpu(42); }

compiles to

        r0 = 3026418949592973312 ll
        exit

on x86.

> The __constant_swab64 looks like a little bit expensive
> for bpf programs compared to __builtin_bswap64. But
> __builtin_bswap64 may not be available for all architectures, esp.
> 32bit system. So macro __bpf__ is required to use it.

Isn't ___constant_swab64 supposed to be 100% compile-time?

Also, I think __builtin_bswap64 should be available everywhere for
userspace. At least the following test does not indicate any problems:

for cc in "x86_64-linux-gnu-gcc -m32" \
          "x86_64-linux-gnu-gcc -m64" \
          "aarch64-linux-gnu-gcc" \
          "arm-linux-gnueabihf-gcc" \
          "mips64el-linux-gnuabi64-gcc" \
          "powerpc64le-linux-gnu-gcc -m32" \
          "s390x-linux-gnu-gcc -m31" \
          "s390x-linux-gnu-gcc -m64" \
          "sparc64-linux-gnu-gcc -m32" \
          "sparc64-linux-gnu-gcc -m64" \
          "clang -target bpf -m32" \
          "clang -target bpf -m64"; do
	echo "*** $cc ***"
	echo "long long f(long long x) { return __builtin_bswap64(x); }" | \
	$cc -x c -S - -O3 -o -;
done

Only sparc64 doesn't support it directly, but then it just calls
libgcc's __bswapdi2. This might not be ok only for kernel native code
(though even there we have e.g. arch/arm/lib/bswapsdi2.S), but I don't
think this header is used in such context anyway.

>> 
>>  			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
>> @@ -1344,20 +1379,26 @@ static size_t probe_prog_length(const struct bpf_insn *fp)
>>  static int fixup_sysctl_value(const char *buf, size_t buf_len,
>>  			      struct bpf_insn *prog, size_t insn_num)
>>  {
>> -	uint32_t value_num = 0;
>> +	uint64_t value_num = 0;
>>  	uint8_t c, i;
>> 
>>  	if (buf_len > sizeof(value_num)) {
>>  		log_err("Value is too big (%zd) to use in fixup", buf_len);
>>  		return -1;
>>  	}
>> +	if (prog[insn_num].code != (BPF_LD | BPF_DW | BPF_IMM)) {
>> +		log_err("Can fixup only BPF_LD_IMM64 insns");
>> +		return -1;
>> +	}
>> 
>>  	for (i = 0; i < buf_len; ++i) {
>>  		c = buf[i];
>>  		value_num |= (c << i * 8);
>>  	}
>> +	value_num = __bpf_le64_to_cpu(value_num);
> 
> Can we avoid to use __bpf_le64_to_cpu?
> Look like we already having the value in buf, can we just cast it
> to get value_num. Note that bpf program and host always have
> the same endianness. This way, no endianness conversion
> is needed.

I think this might be dangerous in case buf is smaller than 8 bytes.
