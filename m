Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DF36982AD
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 18:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBORt7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 12:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBORtp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 12:49:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B1F166FC
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 09:49:44 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FHXO34032265;
        Wed, 15 Feb 2023 17:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=X5Y2dzoRPklMILaK0xaOwK/Jo+JjLHRBV3Fr62toPIw=;
 b=pWG89RwoU3wL9jCbSEwWSw52KteEomZvoCGgGxN7fYBu2xBRwjTsJ7GaOoDR2HhZ5xD0
 N4mZ1TUz7YSAXcu5XpaGh6/IkgdUyu+9UZrZYWl7A2A7+NY8c5W6L5UjD7FfgS2CBIYP
 XIoNmpgithnpA+Dhbs2R/trnchggXXfCCNaX6j1ozbBfKpokR7qV5Zj42O5pInTz/bdq
 /5v3GVW9YtmbIOqdxIOrSZDXTGjstLowuk0VYbaUMYkS6aiz3vMrz8Gz5izU8EpywXlM
 Pg2y5DCbH7PAo8baik56+TevMC9E/ctQF2eevcU9V7ctZr5WOC8l6NTQsbiqa1jegTe1 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns3a3hkd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 17:49:29 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FHejkl003175;
        Wed, 15 Feb 2023 17:49:29 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns3a3hkc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 17:49:29 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FC7bI5010915;
        Wed, 15 Feb 2023 17:49:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6wpjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 17:49:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FHnNhm23986582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 17:49:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03DA32004B;
        Wed, 15 Feb 2023 17:49:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EA6620040;
        Wed, 15 Feb 2023 17:49:22 +0000 (GMT)
Received: from [9.179.4.133] (unknown [9.179.4.133])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 17:49:22 +0000 (GMT)
Message-ID: <33d548b6b265af07b7578c529e09751b58fe92ed.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 1/1] bpf: Support 64-bit pointers to kfuncs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 15 Feb 2023 18:49:22 +0100
In-Reply-To: <Y+0Zve9/LTWaZ96a@google.com>
References: <20230214212809.242632-1-iii@linux.ibm.com>
         <20230214212809.242632-2-iii@linux.ibm.com> <Y+wgDzf9zjfwgFwA@google.com>
         <7a2d61865e0fb1ef8db5bee8f7b95b3e983e59d4.camel@linux.ibm.com>
         <Y+0Zve9/LTWaZ96a@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WVwvnslZE35MUiuI2bgg_1hQuL9AwPK6
X-Proofpoint-GUID: n9wbu6W3UiC5tDkR8Er2IcpMyOxDHg4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_07,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150157
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-02-15 at 09:43 -0800, Stanislav Fomichev wrote:
> On 02/15, Ilya Leoshkevich wrote:
> > On Tue, 2023-02-14 at 15:58 -0800, Stanislav Fomichev wrote:
> > > On 02/14, Ilya Leoshkevich wrote:
> > > > test_ksyms_module fails to emit a kfunc call targeting a module
> > > > on
> > > > s390x, because the verifier stores the difference between kfunc
> > > > address and __bpf_call_base in bpf_insn.imm, which is s32, and
> > > > modules
> > > > are roughly (1 << 42) bytes away from the kernel on s390x.
> > >=20
> > > > Fix by keeping BTF id in bpf_insn.imm for
> > > > BPF_PSEUDO_KFUNC_CALLs,
> > > > and storing the absolute address in bpf_kfunc_desc, which JITs
> > > > retrieve
> > > > as usual by calling bpf_jit_get_func_addr().
> > >=20
> > > > This also fixes the problem with XDP metadata functions
> > > > outlined in
> > > > the description of commit 63d7b53ab59f ("s390/bpf: Implement
> > > > bpf_jit_supports_kfunc_call()") by replacing address lookups
> > > > with
> > > > BTF
> > > > id lookups. This eliminates the inconsistency between
> > > > "abstract"
> > > > XDP
> > > > metadata functions' BTF ids and their concrete addresses.
> > >=20
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > > =C2=A0 include/linux/bpf.h=C2=A0=C2=A0 |=C2=A0 2 ++
> > > > =C2=A0 kernel/bpf/core.c=C2=A0=C2=A0=C2=A0=C2=A0 | 23 ++++++++++---
> > > > =C2=A0 kernel/bpf/verifier.c | 79 +++++++++++++--------------------=
-
> > > > ----
> > > > -----
> > > > =C2=A0 3 files changed, 45 insertions(+), 59 deletions(-)
> >=20

[...]

> > > > +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32
> > > > func_id,
> > > > u16=C2=A0
> > > > offset,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 **func_addr=
)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct bpf_kfunc_d=
esc *desc;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0desc =3D find_kfunc_desc=
(prog, func_id, offset);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (WARN_ON_ONCE(!desc))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*func_addr =3D (u8 *)des=
c->addr;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > +}
> > >=20
> > > This function isn't doing much and has a single caller. Should we
> > > just
> > > export find_kfunc_desc?
>=20
> > We would have to export struct bpf_kfunc_desc as well; I thought
> > it's
> > better to add an extra function so that we could keep hiding the
> > struct.
>=20
> Ah, good point. In this case seems ok to have this extra wrapper.
> On that note: what's the purpose of WARN_ON_ONCE here?

We can hit this only due to an internal verifier/JIT error, so it would
be good to get some indication of this happening. In verifier.c we have
verbose() function for that, but this function is called during JITing.

[...]
