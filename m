Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED56A41CA
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 13:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjB0MhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 07:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0MhL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 07:37:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D81E2AB
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:37:08 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RBF3xR027177;
        Mon, 27 Feb 2023 12:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=70/r+iclVw5ZyNk2sGQRyHS9wOqPfT6VnuO7wMjR7PQ=;
 b=kIgB6y3eHKaESqdY7cEMWin5TBibHk8z29e4X644tUj1XyIn2/i7wZy/MzeSAeYiLPm1
 1T/fML6gSlYofknrNns0gWiwdkbTQ68YJlGCcMot5/+IzSsrUabzuJ8eyMYaXFMMMaZp
 8OHF/5bw9tEmgGqQT69q6xuNqDX1SmFqS1z8p5L1zCw0xq0EWuVWoLIJeiSDfZUGjpvE
 GwPi6iZVQ7VexXkEwIbYY9cLCOQvUB6GxFaJGrWD8tVBACmpC5yyK4R56IJFrQb3Wfn8
 Ji363VWDiljTmji9VNSRm88aDvRcBjkUKPD8X/LDROdeKnJ8FQ1X3wS3G+jv5l+Eswgm LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p0u1r2rkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 12:36:54 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31RCHQ3b028845;
        Mon, 27 Feb 2023 12:36:53 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p0u1r2rjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 12:36:53 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31QLgsh9017631;
        Mon, 27 Feb 2023 12:36:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3nybbysemy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 12:36:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31RCaloI197176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 12:36:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 456DC20049;
        Mon, 27 Feb 2023 12:36:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6A3620043;
        Mon, 27 Feb 2023 12:36:46 +0000 (GMT)
Received: from [9.171.32.164] (unknown [9.171.32.164])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Feb 2023 12:36:46 +0000 (GMT)
Message-ID: <4badc596ef42b52b907d2bcaf79d7b248e27496b.camel@linux.ibm.com>
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
Date:   Mon, 27 Feb 2023 13:36:46 +0100
In-Reply-To: <CAADnVQJ9-wBrAw5+Y17Bxv4+CrLHmtkjuU143eD3fwhpQ1wvKA@mail.gmail.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
         <CAADnVQ+c_+sCXgb63_Kqp8Qb_0cMDcHXrDsbtoP60LiWerWpkQ@mail.gmail.com>
         <8e53174c5d5bae318a38997a7e276d7cdbccfa00.camel@linux.ibm.com>
         <CAADnVQJ9-wBrAw5+Y17Bxv4+CrLHmtkjuU143eD3fwhpQ1wvKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BE9z7abc8NkgXQu2_Qolg21kbS-Hg2aR
X-Proofpoint-ORIG-GUID: eACe7r-Sf25xO7mxjq-JaD6BlLPgtFEc
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_08,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=936 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-02-24 at 16:02 -0800, Alexei Starovoitov wrote:
> On Thu, Feb 23, 2023 at 12:43 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > On Thu, 2023-02-23 at 09:17 -0800, Alexei Starovoitov wrote:
> > > On Wed, Feb 22, 2023 at 2:37 PM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >=20
> > > > v2:
> > > > https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.c=
om/
> > > > v2 -> v3: Drop BPF_HELPER_CALL (Alexei).
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Drop the mer=
ged check_subprogs() cleanup.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Adjust arm, =
sparc and i386 JITs.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Fix a few po=
rtability issues in test_verifier.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Fix a few sp=
arc64 issues.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Trim s390x d=
enylist.
> > >=20
> > > I don't think it's a good idea to change a bunch of JITs
> > > that you cannot test just to address the s390 issue.
> > > Please figure out an approach that none of the JITs need changes.
> >=20
> > What level of testing for these JITs would you find acceptable?
>=20
> Just find a way to avoid changing them.

Ok. But please take a look at patches 1-6. They fix existing issues,
which were found by running test_verifier on arm and sparc64.
