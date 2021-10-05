Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067774231A0
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhJEUYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 16:24:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230033AbhJEUYY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Oct 2021 16:24:24 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195K5vfd007002;
        Tue, 5 Oct 2021 16:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=kYvgRD44K/u6uVDaUItEcnZxx00SRWWc3R0pcMCVCIU=;
 b=VZpLDOGeXDM4K028WS38AESHwtiXkbZdTnIyr+4H0iAqPH3sleUeZLnyuwmU9NCotova
 57WthHpHGJNtH/lWenkKTEv2g7B5upkEpXhRWidU+11vwFjFEYiCwdA+JgtIEgKyXaDi
 Sto2NGSp8jPW7LMKWYyx+XQ3k2E8t2pFoBXX9rTfuZpNJ3Rg0KPdYjeuHBG/cUIObtgF
 vWhlaqeWXyoRbI3JuUXzoPmXuKEQevW6mwBYY3GZyu6TeYGBmVUfT4YApbzhq15NBLVy
 oj7QbgANA/qFSYfim9KN//r7WJU9YF8p+vlDZ4+3ROUjFRF0/nSwc21bZDFDLPnkr1a6 /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgs36y1mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 16:22:10 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 195JxuqZ011456;
        Tue, 5 Oct 2021 16:22:09 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgs36y1mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 16:22:09 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 195KImqu012495;
        Tue, 5 Oct 2021 20:22:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3bef29ksh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 20:22:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 195KM4gV46072088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 20:22:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F73CA4065;
        Tue,  5 Oct 2021 20:22:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D831AA4062;
        Tue,  5 Oct 2021 20:22:03 +0000 (GMT)
Received: from localhost (unknown [9.43.5.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Oct 2021 20:22:03 +0000 (GMT)
Date:   Wed, 06 Oct 2021 01:52:02 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/9] powerpc/bpf: Remove unused SEEN_STACK
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
        <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
        <bdadfd21-7e39-5984-43b9-818f1660ccaf@csgroup.eu>
        <1633369544.ekqufta9bg.naveen@linux.ibm.com>
        <a9904ed3-c9fc-d86f-a720-de0a7e7a8938@csgroup.eu>
In-Reply-To: <a9904ed3-c9fc-d86f-a720-de0a7e7a8938@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1633465104.63u4we4w28.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BCZQQdM5PTLlgls5OsQd7iGMS89Viy96
X-Proofpoint-ORIG-GUID: _LmBPzT-wyPEOCQ15WVdij5gbPNcDVld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_04,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050117
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 04/10/2021 =C3=A0 20:11, Naveen N. Rao a =C3=A9crit=C2=A0:
>> Christophe Leroy wrote:
>>>
>>>
>>> Le 01/10/2021 =C3=A0 23:14, Naveen N. Rao a =C3=A9crit=C2=A0:
>>>> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>>
>>>> SEEN_STACK is unused on PowerPC. Remove it. Also, have
>>>> SEEN_TAILCALL use 0x40000000.
>>>
>>> Why change SEEN_TAILCALL ? Would it be a problem to leave it as is ?
>>>
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>=20
>> I prefer the bit usage to be contiguous. Changing SEEN_TAILCALL isn't a=20
>> problem either.
>>=20
>=20
> Well you are adding SEEN_BIG_PROG in following patch so it would still=20
> be contiguous at the end.
>=20
> I don't really mind but I thought it would be less churn to just leave=20
> SEEN_TAILCALL as is and re-use 0x40000000 for SEEN_BIG_PROG.

Ah ok. This patch was from a different series and it made more sense to=20
change the bit number there. I have reused the patch here as-is since=20
the change is fairly trivial.


- Naveen

