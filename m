Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08CCFF3315
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfKGPaO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 7 Nov 2019 10:30:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727925AbfKGPaO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 10:30:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7FT4LB007642
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 10:30:12 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w4mdq50gx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 10:30:11 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 7 Nov 2019 15:30:05 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 15:30:02 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7FU1p128312010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 15:30:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4856111C04A;
        Thu,  7 Nov 2019 15:30:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C26011C054;
        Thu,  7 Nov 2019 15:30:01 +0000 (GMT)
Received: from dyn-9-152-99-204.boeblingen.de.ibm.com (unknown [9.152.99.204])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 15:30:00 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [RFC PATCH bpf-next] bpf: allow JIT debugging if
 CONFIG_BPF_JIT_ALWAYS_ON is set
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <2d4334ad-545d-13b6-224a-14420e1da4c0@iogearbox.net>
Date:   Thu, 7 Nov 2019 16:30:00 +0100
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20191106161204.87261-1-iii@linux.ibm.com>
 <CAADnVQ+jOo61VoOp+CDAW7k+GnacgEB8Kge-4JsDBaF25sVhWA@mail.gmail.com>
 <10A60D54-07EB-4B5D-AD3B-59C6D8D7CF9D@linux.ibm.com>
 <5dc2f9cbb002d_23152aba75b6a5bcfd@john-XPS-13-9370.notmuch>
 <2d4334ad-545d-13b6-224a-14420e1da4c0@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
X-Mailer: Apple Mail (2.3594.4.19)
X-TM-AS-GCONF: 00
x-cbid: 19110715-0008-0000-0000-0000032C73EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110715-0009-0000-0000-00004A4B79BE
Message-Id: <335309FE-C7AF-4B89-AC2A-D9138B1E4589@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070147
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 07.11.2019 um 00:07 schrieb Daniel Borkmann <daniel@iogearbox.net>:
> 
> On 11/6/19 5:50 PM, John Fastabend wrote:
>> Ilya Leoshkevich wrote:
>>>> Am 06.11.2019 um 17:15 schrieb Alexei Starovoitov <alexei.starovoitov@gmail.com>:
>>>> On Wed, Nov 6, 2019 at 8:12 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>>>> 
>>>>> Currently it's not possible to set bpf_jit_enable = 2 when
>>>>> CONFIG_BPF_JIT_ALWAYS_ON is set, which makes debugging certain problems
>>>>> harder.
>>>> 
>>>> This is obsolete way of debugging.
>>>> Please use bpftool dump jited instead.
>>> 
>>> Is there a way to integrate bpftool nicely with e.g. test_verifier?
>>> With bpf_jit_enable = 2, I can see JITed code for each test right away,
>>> without pausing it (via gdb or rebuilding with added sleep()) and
>>> running bpftool.
>> On the library side we can set the log_level causing the verifier logic
>> steps to be printed. I guess adding it to bpftool might be nice. At least
>> I would find it useful. I'll probably get to it sometime if its not
>> already there somewhere and/or someone doesn't beat me to it.
> 
> +1
> 
> Was wondering whether it may be worth it moving parts of the logic from bpftool
> into libbpf wrt jit dump as a higher level api, so it could be used directly for
> checking out the jit disasm + opcodes for specific tests given we have the fd
> there as well, but that might be too specific perhaps and would bring one more
> lib dependency to libbpf for a rather narrow use case. Adding sleep before prog
> fd close and/or shelling out to bpftool etc all is a crude temporary hack as
> well (currently using something long these lines locally). Would it make sense
> to dump some meta data and generated opcodes per test case to a file as opt-in
> e.g. ./test_verifier 711 --dump produces 711.opcodes out of bpf_obj_get_info_by_fd()
> which then bpftool could dump this artifact through its own disasm?
> 
> Thanks,
> Daniel

Yes, this sounds fine - if the test fails or behaves strangely, I won't
have to re-run it using a special setup, but rather just disasm the
dumped JITted image (maybe even without bpftool, just with objdump).

Another question though: what about seccomp? It looks as if those
programs are not shown by bpftool, since they are not created using bpf
syscall.

Best regards,
Ilya
