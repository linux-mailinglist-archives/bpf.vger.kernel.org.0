Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE58638388
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 06:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiKYFj2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 00:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKYFj1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 00:39:27 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51A321E01;
        Thu, 24 Nov 2022 21:39:26 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AP4Z4j9025893;
        Fri, 25 Nov 2022 05:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=w13mrymH4KYWhX8C+By/LPifLb1Xs84nwMRyXQGfR8A=;
 b=lwZBvza23Gn/mg/txSJCisZHQpv6+Uopd0lWQLew06bgYAJTWzj1FXYmP6Z7hF+tuDDH
 BEJ8WWVvDdbmu64w2L9mzBgA+giYRKSBXXNiDyIvOOQWYwy5T8S4OmkHw6POdsp7YDyy
 SSfdlc7lOTvBCdRa1DUuxjVZiOXd3VaFNkdEg7FXVJSS3FU0JKoTZ29hxL42dyEmjJby
 VMouEe5slRmrrGwvgpwMhzZTx8QF95EIlzLkalKgOKQrMbxL9HYgOwimCocowVFsM2/x
 pliN9G6y8uNWvkp9g4uVqb/IRCgkpFEQJd8l4MZWdR+deHo7JP5FMkaJf0yfNxx0Dnbx tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m2ptdh5wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 05:38:58 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AP5BEEW021794;
        Fri, 25 Nov 2022 05:38:58 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m2ptdh5vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 05:38:58 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AP5Zkph025155;
        Fri, 25 Nov 2022 05:38:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3kxpdj141q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 05:38:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AP5crHO5243642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Nov 2022 05:38:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8098FAE051;
        Fri, 25 Nov 2022 05:38:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED1F7AE045;
        Fri, 25 Nov 2022 05:38:52 +0000 (GMT)
Received: from localhost (unknown [9.43.63.150])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Nov 2022 05:38:52 +0000 (GMT)
Date:   Fri, 25 Nov 2022 11:08:51 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] powerpc/bpf: Only update ldimm64 during extra pass when
 it is an address
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>,
        =?iso-8859-1?q?Yonghong=0A?= Song <yhs@fb.com>
References: <3f6d302a2068d9e357efda2d92c8da99a0f2d0b2.1669278892.git.christophe.leroy@csgroup.eu>
        <1669284441.66eunvaboi.naveen@linux.ibm.com>
        <9f17237f-94da-f58f-4f4b-0068851b4123@csgroup.eu>
        <1669297066.kxu8xl391n.naveen@linux.ibm.com>
        <ba982820-0a22-1180-7b3c-b32acae6e9f7@csgroup.eu>
In-Reply-To: <ba982820-0a22-1180-7b3c-b32acae6e9f7@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1669354227.c0iu04jq2o.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MPwV45oJxt6nvxGUXCJBoDMQoQBIf8Mj
X-Proofpoint-ORIG-GUID: cFq-2K3Ph9aPUQxSd6n8YrznpOMIP-Gn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_02,2022-11-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211250044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 24/11/2022 =C3=A0 14:49, Naveen N. Rao a =C3=A9crit=C2=A0:
>> Christophe Leroy wrote:
>>>
>>>
>>> Le 24/11/2022 =C3=A0 11:13, Naveen N. Rao a =C3=A9crit=C2=A0:
>>>> Christophe Leroy wrote:
>>>
>>> In what direction could that change in the future ?
>>>
>>> For me if they change that it becomes an API change.
>>=20
>> More of an extension, which is exactly what we had when BPF_PSEUDO_FUNC=20
>> was introduced. Took us nearly a year before we noticed.
>>=20
>> Because we do not do a full JIT during the extra pass today like other=20
>> architectures, we are the exception - there is always the risk of bpf=20
>> core changes breaking our JIT. So, I still think it is better if we do a=
=20
>> full JIT during extra pass.
>>=20
>=20
> I like the idea of a full JIT during extra passes and will start looking=20
> at it.
>=20
> Will it also allow us to revert your commit fab07611fb2e=20
> ("powerpc32/bpf: Fix codegen for bpf-to-bpf calls") ?

Not entirely. We still need those extra nops during the initial JIT so=20
that we can estimate the maximum prog size. During extra pass, we can=20
only emit the necessary instructions and skip extra nops. We may need to=20
do two passes during extra_pass to adjust the branch targets though.

Thanks,
Naveen

