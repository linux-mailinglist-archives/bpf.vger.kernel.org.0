Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD604B4DCD
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349896AbiBNLRD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:17:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350632AbiBNLQ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:16:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C326C90D
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:47:39 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E9EAmc006904;
        Mon, 14 Feb 2022 10:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ib57o6XEDx2zL4tfXsEqyFcGD5EI0qTqjW2ch/AjXtc=;
 b=NbUO0ttLLQa+Y8fG3i4KaTn/tGeltTrnu5eRSukZjWgU09hR2JWd3caDvB4ZG/oWbkpF
 YEfXO4C9t902ylaz4sqOuHCc4aonMjPtLCmLaXXJ+DEYMXsCAe/ysbWKV5atpjZUI4Ss
 AKbgRbUfL/p+bbrjkYokgydyfsOEtqKFNeA8fAoP4NXOtXrk4HAMHzXOf+g2gD9v93SC
 +3ViOPH8nJpDT2sUZzdS49rMzbxzAyfGDG0+LHJImVjLI9QMRHq8azYElAgt6Ddb8Osx
 JmzTSwZxnvDoxcMDXPlsze+yVPkhh6Dut665SzuWxkwYSkvqj+yq6CNEqMADgc8Ahmg7 kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7ath437p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:47:08 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EAcgw8032248;
        Mon, 14 Feb 2022 10:47:07 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7ath436f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:47:07 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAXVN5012196;
        Mon, 14 Feb 2022 10:47:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64h9m1ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:47:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAl2Xf42336576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:47:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67912A4060;
        Mon, 14 Feb 2022 10:47:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF9BDA405B;
        Mon, 14 Feb 2022 10:47:01 +0000 (GMT)
Received: from localhost (unknown [9.43.124.167])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:47:01 +0000 (GMT)
Date:   Mon, 14 Feb 2022 16:17:00 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/3] powerpc64/bpf: Add support for BPF Trampolines
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
References: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <918b842d-f674-bbdb-c772-b43a00f1b155@csgroup.eu>
In-Reply-To: <918b842d-f674-bbdb-c772-b43a00f1b155@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1644835471.mm5694ds8t.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SVBsdeW2rPuPsaiU_U_Pv4tGdWrT5rZU
X-Proofpoint-GUID: L62ehD2I5ZMrJx9P1LNnET6rBYPxqt2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 07/02/2022 =C3=A0 08:07, Naveen N. Rao a =C3=A9crit=C2=A0:
>> This is an early RFC series that adds support for BPF Trampolines on
>> powerpc64. Some of the selftests are passing for me, but this needs more
>> testing and I've likely missed a few things as well. A review of the
>> patches and feedback about the overall approach will be great.
>>=20
>> This series depends on some of the other BPF JIT fixes and enhancements
>> posted previously, as well as on ftrace direct enablement on powerpc
>> which has also been posted in the past.
>=20
> Is there any reason to limit this to powerpc64 ?

I have limited this to elf v2, and we won't be able to get this working=20
on elf v1, since we don't have DYNAMIC_FTRACE_WITH_REGS supported there.=20
We should be able to get this working on ppc32 though.


- Naveen

