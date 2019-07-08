Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED662108
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfGHPBi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Jul 2019 11:01:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730281AbfGHPBi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Jul 2019 11:01:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68F09pj004960
        for <bpf@vger.kernel.org>; Mon, 8 Jul 2019 11:01:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tm6nrv515-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 11:01:32 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 8 Jul 2019 16:01:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 16:01:26 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x68F1Q5j39190670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 15:01:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF0F611C04C;
        Mon,  8 Jul 2019 15:01:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3DD611C052;
        Mon,  8 Jul 2019 15:01:25 +0000 (GMT)
Received: from dyn-9-152-99-31.boeblingen.de.ibm.com (unknown [9.152.99.31])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jul 2019 15:01:25 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: do not ignore clang failures
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <cc418117-32a7-b7aa-3570-29b1b3421303@iogearbox.net>
Date:   Mon, 8 Jul 2019 17:01:25 +0200
Cc:     bpf <bpf@vger.kernel.org>, Song Liu <liu.song.a23@gmail.com>,
        andrii.nakryiko@gmail.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Content-Transfer-Encoding: 8BIT
References: <CAEf4Bzb3BKoEcYiM3qQ6uqn+bZZ7kO2ogvZPba7679TWFT4fmw@mail.gmail.com>
 <20190701184025.25731-1-iii@linux.ibm.com>
 <cc418117-32a7-b7aa-3570-29b1b3421303@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19070815-0008-0000-0000-000002FAF873
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070815-0009-0000-0000-00002268556A
Message-Id: <59B1630A-537D-43A1-B75C-87BE80709F93@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080187
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 05.07.2019 um 16:22 schrieb Daniel Borkmann <daniel@iogearbox.net>:
> 
> On 07/01/2019 08:40 PM, Ilya Leoshkevich wrote:
>> Am 01.07.2019 um 17:31 schrieb Andrii Nakryiko <andrii.nakryiko@gmail.com>:
>>> Do we still need clang | llc pipeline with new clang? Could the same
>>> be achieved with single clang invocation? That would solve the problem
>>> of not detecting pipeline failures.
>> 
>> I’ve experimented with this a little, and found that new clang:
>> 
>> - Does not understand -march, but -target is sufficient.
>> - Understands -mcpu.
>> - Understands -Xclang -target-feature -Xclang +foo as a replacement for
>>  -mattr=foo.
>> 
>> However, there are two issues with that:
>> 
>> - Don’t older clangs need to be supported? For example, right now alu32
>>  progs are built conditionally.
> 
> We usually require latest clang to be able to test most recent features like
> BTF such that it helps to catch potential bugs in either of the projects
> before release.
> 
>> - It does not seem to be possible to build test_xdp.o without -target
>>  bpf.
> 
> For everything non-tracing, it does not make sense to invoke clang w/o
> the -target bpf flag, see also Documentation/bpf/bpf_devel_QA.rst +573
> for more explanation, so this needs to be present for building test_xdp.o.

I'm referring to the test introduced in [1]. test_xdp.o might not be an
ideal target, but even if it's replaced with a more suitable one, the
llc invocation would still be required. So I could redo the patch as
follows:

- Replace test_xdp.o with get_cgroup_id_kern.o, use an intermediate .bc
  file.
- Use clang without llc for all other eBPF programs.
- Split out Kbuild include and order-only prerequisites.

What do you think?

[1] https://lore.kernel.org/netdev/1541593725-27703-1-git-send-email-quentin.monnet@netronome.com/

Best regards,
Ilya
