Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C4369A96A
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 11:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBQKxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 05:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBQKxy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 05:53:54 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F162413
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 02:53:53 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H9IkAK014471;
        Fri, 17 Feb 2023 10:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kPyDisM0L6AnjIFbQRcUKLO2Yz05uksWCVUBDWDRzD8=;
 b=RFb4MBokRrFwL9DrdSyS5CqiZycz9IZqifoF/2AvAZdQ01InfVqPiQxEfRuXpS4OZQpZ
 G6iF7PgE4hMQoVH/nm3CUk/XXy/V+OFXHjJ2HoLTJByeOK+GQ/zzywaVxHcuq3k390CK
 oXgnzpw4n11G2NkvV/rvSTL7ID2RvsHMKwK6C/8f/dGntwbWV6W9XmJEa2aXz8Y1yG45
 wAGh7BFjBvy0Jay/lPrApdrJBEfOUbYlYXrFaXp7CR9+w7xYx5gG1HYkwufMyLwunEbA
 p2XoaG10/rjXNoPuEasRYQq7CMIWWjBIBIjCmEoqshmeqx4qy1uvxQQ2WlpM5q8ui/Td 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt15wscvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:53:39 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HAesOI020800;
        Fri, 17 Feb 2023 10:53:38 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nt15wscv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:53:38 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HAgdKA018089;
        Fri, 17 Feb 2023 10:53:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3np2n6dtkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:53:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HArXZ152429238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 10:53:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BA9720043;
        Fri, 17 Feb 2023 10:53:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6977820040;
        Fri, 17 Feb 2023 10:53:32 +0000 (GMT)
Received: from [9.171.8.126] (unknown [9.171.8.126])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 10:53:32 +0000 (GMT)
Message-ID: <29d5754432943c89a03e504fc62725f1bbcbbc97.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next v2 4/4] bpf: Support 64-bit pointers to
 kfuncs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stanislav Fomichev <sdf@google.com>
Date:   Fri, 17 Feb 2023 11:53:32 +0100
In-Reply-To: <Y+9LcD0U0ftB91/t@krava>
References: <20230215235931.380197-1-iii@linux.ibm.com>
         <20230215235931.380197-5-iii@linux.ibm.com> <Y+9LcD0U0ftB91/t@krava>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: stYKvq5Wb9XTBzgkjURU7gxodW8cWOf1
X-Proofpoint-GUID: 9432Co11tUgETlu24yysMF9BdvYG7_Bv
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_06,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-02-17 at 10:40 +0100, Jiri Olsa wrote:
> On Thu, Feb 16, 2023 at 12:59:31AM +0100, Ilya Leoshkevich wrote:
>=20
> SNIP
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 71158a6786a1..47d390923610 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2115,8 +2115,8 @@ static int add_subprog(struct
> > bpf_verifier_env *env, int off)
> > =C2=A0struct bpf_kfunc_desc {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct btf_func_model f=
unc_model;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 func_id;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s32 imm;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 offset;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long addr;
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct bpf_kfunc_btf {
> > @@ -2166,6 +2166,19 @@ find_kfunc_desc(const struct bpf_prog *prog,
> > u32 func_id, u16 offset)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(tab-=
>descs[0]),
> > kfunc_desc_cmp_by_id_off);
> > =C2=A0}
> > =C2=A0
> > +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
> > u16 offset,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 **func_addr)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct bpf_kfunc_desc =
*desc;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0desc =3D find_kfunc_desc(pro=
g, func_id, offset);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!desc)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EFAULT;
>=20
> should we warn here? this should alwayss succeed, right?

Hi Jiri!

This was discussed here:

https://lore.kernel.org/bpf/20230214212809.242632-1-iii@linux.ibm.com/T/#m3=
a4748997d31f6840c50b0bf2ccafe9d24f9218f

The conclusion was that the existing code does not warn in situations
like this, so we should not warn here either.

Best regards,
Ilya

>=20
> jirka
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*func_addr =3D (u8 *)desc->a=
ddr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
> > +
>=20
> SNIP

