Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDAC42163F
	for <lists+bpf@lfdr.de>; Mon,  4 Oct 2021 20:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhJDSVA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 14:21:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238035AbhJDSU6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 Oct 2021 14:20:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194HWL84010824;
        Mon, 4 Oct 2021 14:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=H0av/dAH0oIixaWBHzCjJlVo0IHCn5UKO2kfhI+reDA=;
 b=ICv6SgLbznxCTdPUpU6Xbu6tFr+tf+nX+lTNBc5Ue3Gh2SXW87suDm2c/UM1xt3s78bn
 Da8Lw3T3HQnw0ofwfe221YwK9KDvir0cDnTAeppptd8xtU7VDcZrE0K8daKS8Wt3GFRn
 JI+yE2rzmBG99oVBxzMkH3gS4gdY7PUt+2vJ9b3fBt1DvvLpOe8fpRrR5T2DaZOCPBMs
 yzsRTRPBiw9ObKeeoIkzsF72m3btd/QvhqjK43Vn9fWmgYTdlv4U6BK0bMgpxLQ+TrMh
 ehdYkG/MHxO1PvZUGRmAQ5ZBuEBsHHHXqBcedJI9zr5nmJlEsPHIrm0erNPE5GMVklYY LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg63r10nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 14:18:48 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 194HvlIu020019;
        Mon, 4 Oct 2021 14:18:47 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg63r10na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 14:18:47 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194ICSrl009192;
        Mon, 4 Oct 2021 18:18:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3beepjaj6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 18:18:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194IIgwr61538690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 18:18:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B498542041;
        Mon,  4 Oct 2021 18:18:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF33F4204D;
        Mon,  4 Oct 2021 18:18:41 +0000 (GMT)
Received: from localhost (unknown [9.43.21.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 18:18:41 +0000 (GMT)
Date:   Mon, 04 Oct 2021 23:48:40 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/9] powerpc/bpf: Fix BPF_SUB when imm == 0x80000000
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
        <1912a409447071f46ac6cc957ce8edea0e5232b7.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
        <43626c62-9a3a-bbba-8cbc-11efb0468b4b@csgroup.eu>
In-Reply-To: <43626c62-9a3a-bbba-8cbc-11efb0468b4b@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1633371242.5ghdfjua6t.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ddjUAP8cEf5gwHV57O36pQaLu7kKOWQW
X-Proofpoint-GUID: t3eOiiekSSWiT5c2M5EJMttushbjdh8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040125
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 01/10/2021 =C3=A0 23:14, Naveen N. Rao a =C3=A9crit=C2=A0:
>> We aren't handling subtraction involving an immediate value of
>> 0x80000000 properly. Fix the same.
>>=20
>> Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for ext=
ended BPF")
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/net/bpf_jit_comp64.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_ji=
t_comp64.c
>> index ffb7a2877a8469..4641a50e82d50d 100644
>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>> @@ -333,15 +333,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *i=
mage, struct codegen_context *
>>   		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -=3D (u32) imm */
>>   		case BPF_ALU64 | BPF_ADD | BPF_K: /* dst +=3D imm */
>>   		case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -=3D imm */
>> -			if (BPF_OP(code) =3D=3D BPF_SUB)
>> -				imm =3D -imm;
>> -			if (imm) {
>> -				if (imm >=3D -32768 && imm < 32768)
>> -					EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
>> -				else {
>> -					PPC_LI32(b2p[TMP_REG_1], imm);
>> +			if (imm > -32768 && imm < 32768) {
>> +				EMIT(PPC_RAW_ADDI(dst_reg, dst_reg,
>> +					BPF_OP(code) =3D=3D BPF_SUB ? IMM_L(-imm) : IMM_L(imm)));
>> +			} else {
>> +				PPC_LI32(b2p[TMP_REG_1], imm);
>> +				if (BPF_OP(code) =3D=3D BPF_SUB)
>> +					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]));
>> +				else
>>   					EMIT(PPC_RAW_ADD(dst_reg, dst_reg, b2p[TMP_REG_1]));
>> -				}
>>   			}
>>   			goto bpf_alu32_trunc;
>=20
> There is now so few code common to both BPF_ADD and BPF_SUB that you=20
> should make them different cases.
>=20
> While at it, why not also use ADDIS if imm is 32 bits ? That would be an=20
> ADDIS/ADDI instead of LIS/ORI/ADD

Sure. I wanted to limit the change for this fix. We can do a separate=20
patch to optimize code generation for BPF_ADD.


- Naveen

