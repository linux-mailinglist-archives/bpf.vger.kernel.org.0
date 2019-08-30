Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1D5A34E0
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 12:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH3KWt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 30 Aug 2019 06:22:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727170AbfH3KWs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Aug 2019 06:22:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UAMeE8146531
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 06:22:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upy74emfv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 06:22:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 30 Aug 2019 11:22:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 11:22:41 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UAMe2957409710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 10:22:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C3C0AE053;
        Fri, 30 Aug 2019 10:22:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CD68AE045;
        Fri, 30 Aug 2019 10:22:40 +0000 (GMT)
Received: from dyn-9-152-96-21.boeblingen.de.ibm.com (unknown [9.152.96.21])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 10:22:39 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix endianness issues in
 test_sysctl
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAPhsuW58L4fBQ2mN5V5027w6tAmkad3R3-gcr3NZOJZAiNedtg@mail.gmail.com>
Date:   Fri, 30 Aug 2019 12:22:39 +0200
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20190828132214.68828-1-iii@linux.ibm.com>
 <20190828132214.68828-3-iii@linux.ibm.com>
 <CAPhsuW58L4fBQ2mN5V5027w6tAmkad3R3-gcr3NZOJZAiNedtg@mail.gmail.com>
To:     Song Liu <liu.song.a23@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19083010-0012-0000-0000-0000034499F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083010-0013-0000-0000-0000217EDD84
Message-Id: <35D8D473-DCE1-410F-B08C-C5E0461D8CE1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300112
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 29.08.2019 um 23:53 schrieb Song Liu <liu.song.a23@gmail.com>:
> 
> On Wed, Aug 28, 2019 at 6:22 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>> 
>> A lot of test_sysctl sub-tests fail due to handling strings as a bunch
>> of immediate values in a little-endian-specific manner.
>> 
>> Fix by wrapping all immediates in bpf_ntohl and the new bpf_be64_to_cpu.
>> 
>> Also, sometimes tests fail because sysctl() unexpectedly succeeds with
>> an inappropriate "Unexpected failure" message and a random errno. Zero
>> out errno before calling sysctl() and replace the message with
>> "Unexpected success".

...

>> @@ -13,6 +13,7 @@
>> #include <bpf/bpf.h>
>> #include <bpf/libbpf.h>
>> 
>> +#include "bpf_endian.h"
>> #include "bpf_rlimit.h"
>> #include "bpf_util.h"
>> #include "cgroup_helpers.h"
>> @@ -100,7 +101,7 @@ static struct sysctl_test tests[] = {
>>                .descr = "ctx:write sysctl:write read ok",
>>                .insns = {
>>                        /* If (write) */
>> -                       BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
>> +                       BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
> 
> I didn't find explanation for this change in the commit log. Is this a typo, or
> a real fix?

This is a real fix, but I forgot to explain it.  We read the first byte of an
int assuming it's the least-significant one, which is not the case on BE arches.
Two fixes are possible: use a different offset on BE arches or just read the
whole int.  Since we are not testing narrow accesses here (there is e.g.
"ctx:file_pos sysctl:read read ok narrow" for that), I went with the simplest
solution.

...

>> @@ -1344,20 +1379,24 @@ static size_t probe_prog_length(const struct bpf_insn *fp)
>> static int fixup_sysctl_value(const char *buf, size_t buf_len,
>>                              struct bpf_insn *prog, size_t insn_num)
>> {
>> -       uint32_t value_num = 0;
>> +       union {
>> +               uint8_t raw[sizeof(uint64_t)];
>> +               uint64_t num;
>> +       } value = {};
> 
> This change doesn't match the description in the changelog.

This one I also forgot to explain - writing an immediate into things like
BPF_LD_IMM64(BPF_REG_0, FIXUP_SYSCTL_VALUE) should be endianness-aware.  We can
also do bpf_be64_to_cpu or similar here, but a better trick (suggested by
Yonghong) is to simply memcpy the raw user-provided value, since testcase
endianness and bpf program endianness match.


Let me send a v4 with an improved commit message.
