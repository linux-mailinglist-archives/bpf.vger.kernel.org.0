Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B238FFEE
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 12:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfHPKWA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 16 Aug 2019 06:22:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbfHPKWA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 06:22:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GAHTaF124332
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 06:21:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udtjw0727-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2019 06:21:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 16 Aug 2019 11:21:56 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Aug 2019 11:21:54 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7GALrAL51838980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 10:21:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A91EA4060;
        Fri, 16 Aug 2019 10:21:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40072A405B;
        Fri, 16 Aug 2019 10:21:53 +0000 (GMT)
Received: from dyn-9-152-96-190.boeblingen.de.ibm.com (unknown [9.152.96.190])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 10:21:53 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH bpf] selftests/bpf: fix endianness issues in test_sysctl
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20190815203324.GA49729@rdna-mbp>
Date:   Fri, 16 Aug 2019 12:21:52 +0200
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20190815122525.41073-1-iii@linux.ibm.com>
 <20190815203324.GA49729@rdna-mbp>
To:     Andrey Ignatov <rdna@fb.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19081610-4275-0000-0000-00000359B96E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081610-4276-0000-0000-0000386BD169
Message-Id: <D58F7E8E-81D3-42E7-95FB-14DFD82232D8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=776 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160107
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 15.08.2019 um 22:35 schrieb Andrey Ignatov <rdna@fb.com>:
> 
>> @@ -1344,20 +1379,26 @@ static size_t probe_prog_length(const struct bpf_insn *fp)
>> static int fixup_sysctl_value(const char *buf, size_t buf_len,
>> 			      struct bpf_insn *prog, size_t insn_num)
>> {
>> -	uint32_t value_num = 0;
>> +	uint64_t value_num = 0;
>> 	uint8_t c, i;
>> 
>> 	if (buf_len > sizeof(value_num)) {
>> 		log_err("Value is too big (%zd) to use in fixup", buf_len);
>> 		return -1;
>> 	}
>> +	if (prog[insn_num].code != (BPF_LD | BPF_DW | BPF_IMM)) {
>> +		log_err("Can fixup only BPF_LD_IMM64 insns");
>> +		return -1;
>> +	}
>> 
>> 	for (i = 0; i < buf_len; ++i) {
>> 		c = buf[i];
>> 		value_num |= (c << i * 8);
>> 	}
>> +	value_num = __bpf_le64_to_cpu(value_num);
>> 
>> -	prog[insn_num].imm = value_num;
>> +	prog[insn_num].imm = (__u32)value_num;
>> +	prog[insn_num + 1].imm = (__u32)(value_num >> 32);
>> 
>> 	return 0;
>> }
>> @@ -1499,6 +1540,7 @@ static int run_test_case(int cgfd, struct sysctl_test *test)
>> 			goto err;
>> 	}
>> 
>> +	errno = 0;
> 
> Yeah, access_sysctl() can return -1 w/o affecting errno, did it cause a
> problem, or you set it just in case?

It's actually for another use case: if access_sysctl() unexpectedly
returns 0, log_err() will misleadingly print a "random" errno. With this
change, it would print "Unexpected success: errno: None", which makes
sense to me.
