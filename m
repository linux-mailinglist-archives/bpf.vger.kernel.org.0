Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0416A1160
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 21:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBWUnn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 15:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBWUnm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 15:43:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B91E3B841
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 12:43:41 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NKLAJR026199;
        Thu, 23 Feb 2023 20:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+r2mUKgtsQPAJg7qerPU29C9lNEQAjg41ENS0+Da4f8=;
 b=SNx6U1wg6+476IPZA9GHWXGxFCkLbhU/rBPPxcqLSioasvrCUCuuY3zAGGu9MLsCejIX
 D1T0Mn6j5iyzY7nArT/qTWxg5nG2bELGxxfko0JRhXyNr7spQaNLuMA2PL068v4wdMGf
 SlgIG+VJgXI8yq7/b5Qb3ekCB/Bh4eq5lqUvwx7ud68U069O216Bpi++QiEHNzNhvE3Q
 fqOR2+Zql9wd9iJ5OyOUhv+TKU+JCTNiP2FKx5UF0Ioo57qVrW2yGg5fIoSlsE1PokIg
 33aieLtPVsGOuZmMPBdlDFGKNb1v0ytD1zJw8skT1zai8FKL4b1DeDzrKY/FJwaGN6C9 vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxf3m0dfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 20:43:03 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31NKNxb7002079;
        Thu, 23 Feb 2023 20:43:03 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxf3m0dex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 20:43:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31NIqZbI023761;
        Thu, 23 Feb 2023 20:43:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ntpa65cp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 20:43:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31NKgvwg52036034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 20:42:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2EB22004D;
        Thu, 23 Feb 2023 20:42:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00E3D20040;
        Thu, 23 Feb 2023 20:42:57 +0000 (GMT)
Received: from [9.179.17.238] (unknown [9.179.17.238])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Feb 2023 20:42:56 +0000 (GMT)
Message-ID: <8e53174c5d5bae318a38997a7e276d7cdbccfa00.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 00/12] bpf: Support 64-bit pointers to kfuncs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Date:   Thu, 23 Feb 2023 21:42:56 +0100
In-Reply-To: <CAADnVQ+c_+sCXgb63_Kqp8Qb_0cMDcHXrDsbtoP60LiWerWpkQ@mail.gmail.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
         <CAADnVQ+c_+sCXgb63_Kqp8Qb_0cMDcHXrDsbtoP60LiWerWpkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9cetMJ51DY-XMjH7CfmHvtBTHm2JK89E
X-Proofpoint-ORIG-GUID: pkPoS4nv4i0rYuOOgMFvauRofm1nHaB1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-02-23 at 09:17 -0800, Alexei Starovoitov wrote:
> On Wed, Feb 22, 2023 at 2:37 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > v2:
> > https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.com/
> > v2 -> v3: Drop BPF_HELPER_CALL (Alexei).
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Drop the merged =
check_subprogs() cleanup.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Adjust arm, spar=
c and i386 JITs.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Fix a few portab=
ility issues in test_verifier.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Fix a few sparc6=
4 issues.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Trim s390x denyl=
ist.
>=20
> I don't think it's a good idea to change a bunch of JITs
> that you cannot test just to address the s390 issue.
> Please figure out an approach that none of the JITs need changes.

What level of testing for these JITs would you find acceptable?
