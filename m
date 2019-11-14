Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4945DFCDB9
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2019 19:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNSfU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 14 Nov 2019 13:35:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbfKNSfU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Nov 2019 13:35:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEIRVD9129742
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 13:35:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w99hbydb1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 13:35:18 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 14 Nov 2019 18:35:16 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Nov 2019 18:35:13 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAEIZCnE65667154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 18:35:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09827A4064;
        Thu, 14 Nov 2019 18:35:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 885E8A4054;
        Thu, 14 Nov 2019 18:35:11 +0000 (GMT)
Received: from [9.145.171.64] (unknown [9.145.171.64])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Nov 2019 18:35:11 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH bpf-next] bpf: make bpf_jit_binary_alloc support alignment
 > 4
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAADnVQL0sk7XXGYAMWKoZOYSN7qi6vN5ZW3VJbd7e9Q_wJaBAA@mail.gmail.com>
Date:   Thu, 14 Nov 2019 19:35:09 +0100
Cc:     Song Liu <liu.song.a23@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20191113170005.48813-1-iii@linux.ibm.com>
 <CAPhsuW6ktX4zDt4fE=C0G4gCZoY_GRdkJFk0sdpsxYVtohnBxA@mail.gmail.com>
 <CAADnVQL0sk7XXGYAMWKoZOYSN7qi6vN5ZW3VJbd7e9Q_wJaBAA@mail.gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
X-TM-AS-GCONF: 00
x-cbid: 19111418-0020-0000-0000-000003863B2B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111418-0021-0000-0000-000021DC53D7
Message-Id: <DFD3A00C-34D2-40B1-86FC-3E37B2718C6D@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140156
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> Am 14.11.2019 um 19:14 schrieb Alexei Starovoitov <alexei.starovoitov@gmail.com>:
> 
> On Thu, Nov 14, 2019 at 9:40 AM Song Liu <liu.song.a23@gmail.com> wrote:
>> 
>> On Wed, Nov 13, 2019 at 9:20 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>> 
>>> Currently passing alignment greater than 4 to bpf_jit_binary_alloc does
>>> not work: in such cases it aligns only to 4 bytes.
>>> 
>>> However, this is required on s390, where in order to load a constant
>>> from memory in a large (>512k) BPF program, one must use lgrl
>>> instruction, whose memory operand must be aligned on an 8-byte boundary.
>>> 
>>> This patch makes it possible to request an arbitrary power-of-2
>>> alignment from bpf_jit_binary_alloc by allocating extra padding bytes
>>> and aligning the resulting pointer rather than the start offset.
>>> 
>>> An alternative would be to simply increase the alignment of
>>> bpf_binary_header.image to 8, but this would increase the risk of
>>> wasting a page on arches that don't need it, and would also be
>>> insufficient in case someone needs e.g. 16-byte alignment in the
>>> future.
> 
> why not 8 or 16? I don't follow why that would waste a page.

It might waste a page because bpf_jit_binary_alloc rounds up allocation
size to PAGE_SIZE, and unnecessary padding might be the last straw that
would cause another page to be allocated. But that would apply only to
a tiny amount of programs, whose JITed size is slightly smaller than a
multiple of PAGE_SIZE.

Sorry, I didn't fully get the 8 vs 16 question. At the moment, for
s390-specific purpose 8 would be enough. I used 16 just to demonstrate
that this solution wouldn't be future-proof. AFAIK some Intel
instructions might want 16 (VMOVDQA?). But maybe it's better to think
about it when someone actually needs to use them.

>>> 
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> 
>> Maybe we can just make it 8 byte aligned for all architectures?
>> 
>> #define BPF_IMAGE_ALIGNMENT 8

Seems like I'm overthinking this. If just bumping the alignment to 8 is
OK, then I'll send a simpler patch.

Best regards,
Ilya
