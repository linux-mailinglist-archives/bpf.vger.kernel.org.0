Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3727766D19B
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 23:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjAPWPu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 17:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjAPWPm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 17:15:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75730125A9
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 14:15:40 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GKSJcF013296;
        Mon, 16 Jan 2023 22:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ueqplLB8X2tpZ7xlrRvyhlv9MG7ofbrRH0yHffqpTwU=;
 b=Qr3oosWRIAU/6HalTZ0Rad00zU+hilCe1yqn94R8EHv5lQPYaSA0tv1wibvu8hqmIYEB
 vV/kOPYQ6Jtl83jOah1ITH51Y7CHsIHVzRNxMZ3CZpPf1GGcGeX2sWPDMCCrik6C9kG8
 1VBsCadvplp2NxpCCnKtGmIxKdYZ4sQpXA+Jb0Jre2Ezu1ceVDm/jGL84d5n+Qva5kTg
 Li5pmS3EOY2afnzPMYjadLf4fgheYvkm44Xw86yA97E2hFauqnzKDOKsg5tLFWL3KR53
 G2W909r7E02BxMDYvLKkEsNydqCJTsND8B6PBK6f03dgkfHLf57ZElkuLHzNc5FuDN41 HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5dn6st4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:13:21 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30GLYPLw008522;
        Mon, 16 Jan 2023 22:13:20 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5dn6st3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:13:20 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30GG7vYs023703;
        Mon, 16 Jan 2023 22:13:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16jya7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:13:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30GMDGUV23658850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 22:13:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC23A2007B;
        Mon, 16 Jan 2023 22:13:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BEEC2007A;
        Mon, 16 Jan 2023 22:13:15 +0000 (GMT)
Received: from [9.171.3.141] (unknown [9.171.3.141])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jan 2023 22:13:15 +0000 (GMT)
Message-ID: <ccecce089c56ae8b49cf5b45f7898ccbe9bf6220.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 15/25] libbpf: define s390x syscall regs spec
 in bpf_tracing.h
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Pu Lehui <pulehui@huawei.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Florent Revest <revest@chromium.org>
Date:   Mon, 16 Jan 2023 23:13:14 +0100
In-Reply-To: <20230113083404.4015489-16-andrii@kernel.org>
References: <20230113083404.4015489-1-andrii@kernel.org>
         <20230113083404.4015489-16-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DL9qB7JR-rbsyy11o9Hmza-HGReWm2oo
X-Proofpoint-ORIG-GUID: AEokykWnhFhQJaLvmKdLTkPuEJHK33jt
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_16,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301160161
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-01-13 at 00:33 -0800, Andrii Nakryiko wrote:
> Define explicit table of registers used for syscall argument passing.
> Note that we need custom overrides for PT_REGS_PARM1_[CORE_]SYSCALL
> macros due to the need to use BPF CO-RE and custom local pt_regs
> definitions to fetch orig_gpr2, storing 1st argument.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> =C2=A0tools/lib/bpf/bpf_tracing.h | 17 +++++++++++++++--
> =C2=A01 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/lib/bpf/bpf_tracing.h
> b/tools/lib/bpf/bpf_tracing.h
> index 34ac0a2d7885..888beea6565b 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -157,6 +157,10 @@
> =C2=A0
> =C2=A0#elif defined(bpf_target_s390)
> =C2=A0
> +/*
> + *
> https://en.wikipedia.org/wiki/Calling_convention#IBM_System/360_and_succe=
ssors
> + */
> +

Here is the more official ABI spec:

https://github.com/IBM/s390x-abi/releases/download/v1.6/lzsabi_s390x.pdf

> =C2=A0struct pt_regs___s390 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long orig_gpr2;
> =C2=A0};
> @@ -168,13 +172,22 @@ struct pt_regs___s390 {
> =C2=A0#define __PT_PARM3_REG gprs[4]
> =C2=A0#define __PT_PARM4_REG gprs[5]
> =C2=A0#define __PT_PARM5_REG gprs[6]
> +
> +#define __PT_PARM1_SYSCALL_REG orig_gpr2
> +#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
> +#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
> +#define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
> +#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
> +#define __PT_PARM6_SYSCALL_REG gprs[7]
> +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BPF_CORE_READ((const struct pt=
_regs___s390 *)(x),
> __PT_PARM1_SYSCALL_REG)
> +
> =C2=A0#define __PT_RET_REG gprs[14]
> =C2=A0#define __PT_FP_REG gprs[11]=C2=A0=C2=A0=C2=A0/* Works only with
> CONFIG_FRAME_POINTER */
> =C2=A0#define __PT_RC_REG gprs[2]
> =C2=A0#define __PT_SP_REG gprs[15]
> =C2=A0#define __PT_IP_REG psw.addr
> -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
> -#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ((const struct
> pt_regs___s390 *)(x), orig_gpr2)
> =C2=A0
> =C2=A0#elif defined(bpf_target_arm)
> =C2=A0

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
