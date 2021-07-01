Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF253B96A5
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 21:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhGATjY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 15:39:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhGATjX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Jul 2021 15:39:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161JXlNW155054;
        Thu, 1 Jul 2021 15:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=jEVJ4q1ZvfZGmK6n0Mm367AN8ZZJQTFhBD8TmMyFW54=;
 b=agYOEfJp3o8IAEl3xdu2/XUEP9KiwzHWO1HM7Gycc1Rc8+OJ/3d9iCXCCgOyes8jZ7nI
 UpSmzLuBgzBWDTj0Qz96wKrPkLn2ca6jSHYo0nskm8uh0yMGp2vten8pMFfW39FyEDDG
 saYI0tsZALTc8pNKRYrotnRmGtnVgpPLR2K01Ru+KziHIg+Fd87J1PPwD7rdIakZXhKs
 dbub+10jeijb7WMLr0T14z2sHWL7DM1oBW2K3MYKcV4EXWkJbCALLRyVuWNXKsZRn/5W
 tx2xFmHdBLxG2UpGx2jX8gMGgdw9ZT1hCIk/w3d/VK2E96I70qsnx2ySa+/GCzrjlenu 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hepr9xda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 15:36:35 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161JaY6I168946;
        Thu, 1 Jul 2021 15:36:34 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hepr9xc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 15:36:34 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161J2YmX025016;
        Thu, 1 Jul 2021 19:36:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 39duv8aj8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 19:36:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161JaTqS19988856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 19:36:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD1B74208C;
        Thu,  1 Jul 2021 19:36:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E9E34208E;
        Thu,  1 Jul 2021 19:36:29 +0000 (GMT)
Received: from localhost (unknown [9.85.115.110])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jul 2021 19:36:28 +0000 (GMT)
Date:   Fri, 02 Jul 2021 01:06:27 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/bpf: Reject atomic ops in ppc32 JIT
To:     bpf@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Jackman <jackmanb@google.com>,
        Jiri Olsa <jolsa@redhat.com>
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
        <426699046d89fe50f66ecf74bd31c01eda976ba5.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
        <f05821f6-816f-c9bf-faa9-015e11f25a46@csgroup.eu>
In-Reply-To: <f05821f6-816f-c9bf-faa9-015e11f25a46@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1625167931.l9jfkufqlx.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z2J8m6gLUp2f2qpYmf6YJErztQWhVXxR
X-Proofpoint-GUID: 5ZgWX0_ngW6RQ_WQf0d_DWZq317cZtBe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_12:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010114
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 01/07/2021 =C3=A0 17:08, Naveen N. Rao a =C3=A9crit=C2=A0:
>> Commit 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other
>> atomics in .imm") converted BPF_XADD to BPF_ATOMIC and updated all JIT
>> implementations to reject JIT'ing instructions with an immediate value
>> different from BPF_ADD. However, ppc32 BPF JIT was implemented around
>> the same time and didn't include the same change. Update the ppc32 JIT
>> accordingly.
>>=20
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>=20
> Shouldn't it also include a Fixes tag and stable Cc as PPC32 eBPF was add=
ed in 5.13 ?

Yes, I wasn't sure which patch to actually blame. But you're right, this=20
should have the below fixes tag since this affects the ppc32 eBPF JIT.

>=20
> Fixes: 51c66ad849a7 ("powerpc/bpf: Implement extended BPF on PPC32")
> Cc: stable@vger.kernel.org

Cc: stable@vger.kernel.org # v5.13


Thanks,
- Naveen

