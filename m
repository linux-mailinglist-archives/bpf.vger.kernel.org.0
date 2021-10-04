Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF163421606
	for <lists+bpf@lfdr.de>; Mon,  4 Oct 2021 20:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhJDSFn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 14:05:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234389AbhJDSFm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 Oct 2021 14:05:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194Gahk5018720;
        Mon, 4 Oct 2021 14:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=pqPly1J9VIlETbxdzJUeNypZMdb+biWSHQrrWqFxHwI=;
 b=S/9Dkl4NgxzNUNR/0FImNaPlH4cCX7SWBfNLNTdW85yfLTF6wKc+V+n1TqijB++REnmr
 ABiZKczJ4un3LcdqYSvKCRdKhtTvg0FhXSUI4tDaITaCaspRJbb8TKl8MG6Cgro6OXSq
 4TJbVzCplUQbKtqYYQKBCfhKDO7BgnHRuAJhESPyIiaSkrPkcU9u6Amg6p9YgGlXbUxu
 KzebJat+ODdTKmPlQG8TXHCSvHJs+WAtDRmHdIQBvtVmlQu6ULPFpDuS+eJYJj7tCkPM
 WB824iE0Mhxuk7VsCsU7gp2ITWIu/1VuaX9jmMMmJ5A7CEyLkdK1Jqehne+9wqlU8QqL Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg4bn360u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 14:03:34 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 194HlieF011962;
        Mon, 4 Oct 2021 14:03:33 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg4bn35xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 14:03:33 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194I2W37025856;
        Mon, 4 Oct 2021 18:03:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3beepjaf76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 18:03:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194HwDHV60686814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 17:58:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0F1C42047;
        Mon,  4 Oct 2021 18:03:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4304204D;
        Mon,  4 Oct 2021 18:03:28 +0000 (GMT)
Received: from localhost (unknown [9.43.21.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 18:03:27 +0000 (GMT)
Date:   Mon, 04 Oct 2021 23:33:27 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/9] powerpc/lib: Add helper to check if offset is within
 conditional branch range
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
        <f8d581e6a5d9555180c38e009f90d236f310f85e.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
        <6745a836-1991-24d0-f02a-437f06052c63@csgroup.eu>
In-Reply-To: <6745a836-1991-24d0-f02a-437f06052c63@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1633370580.7belb0symt.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fzau_ik4DYqWES6hChuzk32alQ4eNHDW
X-Proofpoint-GUID: tALOoYsQovM2JoKZ12PEpFHHJ8Mc-VDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040125
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Christophe,
Thanks for the reviews.


Christophe Leroy wrote:
>=20
>=20
> Le 01/10/2021 =C3=A0 23:14, Naveen N. Rao a =C3=A9crit=C2=A0:
>> Add a helper to check if a given offset is within the branch range for a
>> powerpc conditional branch instruction, and update some sites to use the
>> new helper.
>>=20
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/code-patching.h | 1 +
>>   arch/powerpc/lib/code-patching.c         | 7 ++++++-
>>   arch/powerpc/net/bpf_jit.h               | 7 +------
>>   3 files changed, 8 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/inc=
lude/asm/code-patching.h
>> index a95f63788c6b14..4ba834599c4d4c 100644
>> --- a/arch/powerpc/include/asm/code-patching.h
>> +++ b/arch/powerpc/include/asm/code-patching.h
>> @@ -23,6 +23,7 @@
>>   #define BRANCH_ABSOLUTE	0x2
>>  =20
>>   bool is_offset_in_branch_range(long offset);
>> +bool is_offset_in_cond_branch_range(long offset);
>>   int create_branch(struct ppc_inst *instr, const u32 *addr,
>>   		  unsigned long target, int flags);
>>   int create_cond_branch(struct ppc_inst *instr, const u32 *addr,
>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-pa=
tching.c
>> index f9a3019e37b43c..e2342b9a1ab9c9 100644
>> --- a/arch/powerpc/lib/code-patching.c
>> +++ b/arch/powerpc/lib/code-patching.c
>> @@ -228,6 +228,11 @@ bool is_offset_in_branch_range(long offset)
>>   	return (offset >=3D -0x2000000 && offset <=3D 0x1fffffc && !(offset &=
 0x3));
>>   }
>>  =20
>> +bool is_offset_in_cond_branch_range(long offset)
>> +{
>> +	return offset >=3D -0x8000 && offset <=3D 0x7FFF && !(offset & 0x3);
>> +}
>=20
> Would be better without capital letters in numbers, in extenso 0x7fff=20
> instead of 0x7FFF

Ack.

- Naveen

