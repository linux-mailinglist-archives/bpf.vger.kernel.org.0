Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27769A97F
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 11:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBQK5t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 05:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQK5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 05:57:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1E5383B
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 02:57:46 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H9sZEL030530;
        Fri, 17 Feb 2023 10:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=E3bsyQyr2NL8yyqFCPUgoi24/tVYfRcLdt+MQ3qzDmc=;
 b=F29M+6EyWKJ7BeA0KmwAWMeIWxVK9qqNDdEEg9ELX7fvFv56KfKhrRc3MZ83T0fzMOxt
 oWQutg4V0wKNfSsD2FVEMINEDhCX5S+DfFBZNsPS7d4pQ4COKnOHrx2GnNfflvXzWr70
 YLliaL2BYvX0mdgbMuxreqDbF+2jzdW0Vm4jZFQakobe5pvmejoPshMiotq9Kd9ESm4Y
 yl6JmppmgzIWXHQUdEw3J/3hpQ1T1rpqD9qciwyJAthG/Sqk+v7VW31HLPhrUUKiwWfY
 lc4XBt2ypwX2KhXncrXhlcpMv/pvwT+TuXqltTi+cItXgv7t7Mj5zwf38lH0GqG73pLk iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt1f7s456-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:57:29 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HAvTXW017369;
        Fri, 17 Feb 2023 10:57:29 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt1f7s44j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:57:28 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31GKwi6l009276;
        Fri, 17 Feb 2023 10:57:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3np2n6dtqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:57:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HAvNxb24314394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 10:57:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF7702004B;
        Fri, 17 Feb 2023 10:57:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6647D20040;
        Fri, 17 Feb 2023 10:57:22 +0000 (GMT)
Received: from [9.171.8.126] (unknown [9.171.8.126])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 10:57:22 +0000 (GMT)
Message-ID: <5a71852169384c3c60a763c6964d6798664dfa72.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next v2 1/4] bpf: Introduce BPF_HELPER_CALL
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 17 Feb 2023 11:57:22 +0100
In-Reply-To: <Y+5wCbT30EGsswMg@google.com>
References: <20230215235931.380197-1-iii@linux.ibm.com>
         <20230215235931.380197-2-iii@linux.ibm.com>
         <CAADnVQK-_MOk=ejM5USFZL9codbzosUqfAs4ppqQuC0y4uBLqw@mail.gmail.com>
         <Y+5nCRZ3ns3u+Tun@google.com>
         <CAADnVQJH6PRgGRMMZufDu6AZkQFF_40boz4oLHdYMWFNAj+zOA@mail.gmail.com>
         <Y+5wCbT30EGsswMg@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oShUW5bpMQxADU1OYc9WkJkQD7ujJKBJ
X-Proofpoint-GUID: otpS3Az8rZuCevUDeoqNMQom6EbcVLX-
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_05,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=965
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-02-16 at 10:03 -0800, Stanislav Fomichev wrote:
> On 02/16, Alexei Starovoitov wrote:
> > On Thu, Feb 16, 2023 at 9:25 AM Stanislav Fomichev <sdf@google.com>
> > wrote:
> > >=20
> > > On 02/16, Alexei Starovoitov wrote:
> > > > On Wed, Feb 15, 2023 at 3:59 PM Ilya Leoshkevich
> > > > <iii@linux.ibm.com>
> > > > wrote:
> > > > >=20
> > > > > Make the code more readable by introducing a symbolic
> > > > > constant
> > > > > instead of using 0.
> > > > >=20
> > > > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > ---
> > > > > =C2=A0include/uapi/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++++
> > > > > =C2=A0kernel/bpf/disasm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > > =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 12 +++++++-----
> > > > > =C2=A0tools/include/linux/filter.h=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > > =C2=A0tools/include/uapi/linux/bpf.h |=C2=A0 4 ++++
> > > > > =C2=A05 files changed, 17 insertions(+), 7 deletions(-)
> > > > >=20
> > > > > diff --git a/include/uapi/linux/bpf.h
> > > > > b/include/uapi/linux/bpf.h
> > > > > index 1503f61336b6..37f7588d5b2f 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -1211,6 +1211,10 @@ enum bpf_link_type {
> > > > > =C2=A0 */
> > > > > =C2=A0#define BPF_PSEUDO_FUNC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
> > > > >=20
> > > > > +/* when bpf_call->src_reg =3D=3D BPF_HELPER_CALL, bpf_call->imm
> > > > > =3D=3D=C2=A0=20
> > index
> > > > of a bpf
> > > > > + * helper function (see ___BPF_FUNC_MAPPER below for a full
> > > > > list)
> > > > > + */
> > > > > +#define BPF_HELPER_CALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> > >=20
> > > > I don't like this "cleanup".
> > > > The code reads fine as-is.
> > >=20
> > > Even in the context of patch 4? There would be the following
> > > switch
> > > without BPF_HELPER_CALL:
> > >=20
> > > switch (insn->src_reg) {
> > > case 0:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > >=20
> > > case BPF_PSEUDO_CALL:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > >=20
> > > case BPF_PSEUDO_KFUNC_CALL:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > }
> > >=20
> > > That 'case 0' feels like it deserves a name. But up to you, I'm
> > > fine
> > > either way.
>=20
> > It's philosophical.
> > Some people insist on if (ptr =3D=3D NULL). I insist on if (!ptr).
> > That's why canonical bpf progs are written as:
> > val =3D bpf_map_lookup();
> > if (!val) ...
> > zero is zero. It doesn't need #define.
>=20
> Are you sure we still want to apply the same logic here for src_reg?
> I
> agree that doing src_reg vs !src_reg made sense when we had a
> "helper"
> vs "non-helper" (bpf2bpf) situation. However now this src_reg feels
> more
> like an enum. And since we have an enum value for 1 and 2, it feels
> natural to have another one for 0?
>=20
> That second patch from the series ([0]) might be a good example on
> why
> we actually need it. I'm assuming at some point we've had:
> #define BPF_PSEUDO_CALL 1
>=20
> So we ended up writing `src_reg !=3D BPF_PSEUDO_CALL` instead of
> actually
> doing `src_reg =3D=3D BPF_HELPER_CALL` (aka `src_reg =3D=3D 0`).
> Afterwards, we've added BPF_PSEUDO_KFUNC_CALL=3D2 which broke our
> previous
> src_reg vs !src_reg assumptions...
>=20
> [0]:=C2=A0=20
> https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.com/T/#=
mf87a26ef48a909b62ce950639acfdf5b296b487b

FWIW the helper checks before this series had inconsistent style:

- !insn->src_reg
- insn->src_reg =3D=3D 0
- insn->src_reg !=3D BPF_REG_0
- insn[i].src_reg !=3D BPF_PSEUDO_CALL

Now at least it's the same style everywhere, and also it's easy to
grep=C2=A0for "where do we check for helper calls".
