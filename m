Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50DA403F2F
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 20:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbhIHSpp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 14:45:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22532 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240231AbhIHSpo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 14:45:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188HxM4w028104;
        Wed, 8 Sep 2021 18:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uzyJNPGE/1N2lbnNUHv1xfa+C5Jfo8jadClNrizie0Y=;
 b=pmrRt8w4bZ7Z5iqtKN/MxFARSBs0vgipT4x95KZOrSAQWQMdnzTJop2G7KxntQENkkUy
 EvaHZr0jjHt3lp5t3RRE+HwKZ/5Y7Aw/kMU7aLDZNDjyZjDOwvaB2cYeUudtTisnSXQI
 YIk5yZ9qIn1CKd81EzHlWjKlYsSLe46k11pG0TzaKgj35bRDf3knWT/2w2ltg+WgrSyF
 YpHM9xxB/q4z6mKVADm2PNDZsO5dJ3mJjhqQPzuzadxbRsA6Ria6RNt/GAa8hZ5CJ+4+
 zruOVo4He3RIzw/qJoZBnQ1vI4kXORpc/7MyGoJFPt8o9a2tStduMaYxoxP1aVH0ErNM +w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=uzyJNPGE/1N2lbnNUHv1xfa+C5Jfo8jadClNrizie0Y=;
 b=zTQi74RbHVO2hARgumxz7KuARtyvJA/zODttSMw2l/It7FrPtWv9LHwixhvhDmCGXrG8
 G8WU3/ZRV8XS7dgbFUvTzsIGTHq9qu+DvvnuDYD5pRtR+VZ8WqC3AD8eTD3GDEFptNSx
 rfIYkSLVbZUR9Ti0d8rEjFHl49/ksoD/iPqm1jWuILykoLxx583nY4enYceCtlVIUZ1x
 QtriX9lnyJlzFEWhlZw13oNGX0Bkl/vzt2ifBvGI/U65UDvJ3kP7aVyG5LvOiMw7KgkA
 kYbt/950LTCWCLGF72C35nNRSpzG+gF8yryTnAJnw6tJZfDZu+0Szf5yY5KJvOri/jd/ aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q3rsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 18:43:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188IaLpf121470;
        Wed, 8 Sep 2021 18:43:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by aserp3020.oracle.com with ESMTP id 3axcpmn9ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 18:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6LFHt0uS6nyIQY2yFkhLBUx12DufDPD0K3ufDIClszKmb3JS07x4yJmtjyuUZunwFcL0F+I3TfSh8jfTD/EOmSKPeKZHsohMATRCaS0cjfDLkEvNH/iQ4wmkQry/ODF0dCfXc85kFkyWxAAWjL1ufxSA6Je756hXsYe04bnoIuttprHjhD2Zpu8bJirxiRHDYcEJBaaBDrzRoiVFuNw1LNrFjkojbZGMjnnF2z0ZQqRAwoOyViDi3zAJqRmRJ2YK0PhkHG5rV6obrCjNkWX08mw52m5IgsNC8V5HTpd2D8yY/panZutznu8gfEMAm5ShpxpZ84qox13o5MZ3cZUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uzyJNPGE/1N2lbnNUHv1xfa+C5Jfo8jadClNrizie0Y=;
 b=EFtf4pvjTFPFHnjbJGkroIZA68Xtl/LI82Z+ZQNDKLgbcpXjJJmMcgZZb4wIbA2oI4crUP+0KyAS6tHKV9px9IoRKRSeO87A09KMVr7bJiqSU6FSq9kn+ff/eLifq3oUNmbAyDEq5+sl0yVCd5WqyZOcnKKeHvnL2v5x77996sWcfxsa3bc2CfuLiCILhGJGHMH+7FZt87GlBwaDaEGlx9SJmu4htxIohf19VsScdNiBLoiZ4NepUJMrondCNfTuwIQoS+oRNPEIpS/35pjoR+mnCn3+HVc+qiG+LlvM9YknspwYMcUM+4Lez2EC1SX/JAYai4WJOrMX5rN8vVCkxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzyJNPGE/1N2lbnNUHv1xfa+C5Jfo8jadClNrizie0Y=;
 b=Mh17SOJAhGrRhssZYijku0bSZmRLIe37zISrcWPyoNK0zR0C0l/ewFCkdSr2oNIflFo50lyBnGA1mhA8l4e+NfOYDn9C1H81dC3Q0/Nc69zxNR4BIxRZ8BSJDR4RQgv28IRCsVBXdD/dC94KZBh7P8sUpvGMHZwg4gZUOEH4COI=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DS7PR10MB5181.namprd10.prod.outlook.com (2603:10b6:5:3a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 18:43:49 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 18:43:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Luigi Rizzo <lrizzo@google.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michel Lespinasse <walken@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Thread-Topic: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Thread-Index: AQHXpGw9DgXD+GNr6U6ppzcLTIluVquaDuuAgAAaBwCAAAYWgIAAB/aAgAAICwCAABANgIAAEJuAgAADVQCAAAjagIAAAsoAgAALYQA=
Date:   Wed, 8 Sep 2021 18:43:49 +0000
Message-ID: <20210908184342.r3bwp7v24a6tnslg@revolver>
References: <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
 <20210908135326.GZ1200268@ziepe.ca>
 <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
 <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9b4e21e-3ea2-4537-ad10-08d972f8993d
x-ms-traffictypediagnostic: DS7PR10MB5181:
x-microsoft-antispam-prvs: <DS7PR10MB5181F7FEDCCD3BF09E19C94BFDD49@DS7PR10MB5181.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzmhcGr2RPq/oassgfI5J1XQ8wG7tcx3HuyxQHxVIZsr9k4CeEs/jCxf5aZMn3ktur70GRYgjX2PA18gYELDOrn89O/2pWfx87lwH5qKF/roL062DR25a1FfkB69F2/D0fxfZfv6ndvypPssOzSNXARlhHQdOjKm48uAQPRsId9b4MMZaLU8eJX2yZ6yrL4ThcezXMuHTyu7QALLT9M9dGp9qDrWYLELWl56/J7UrL8R/i270lCjU/4EWJ/tOC6PiaqAPndVtRSvSalai5z6CxbxMQGgyATyFKQZtC9fw7W2Od2IVfjnxCjmND0QmY9BrO1Q3Fy2fJ7uCj7VJi2pS+92jy61pccNcS4VAl5pojrQJOT1k945YR5iNMFDyXCL/CQtkB2ZjcCLC7OMBpKtecct96jGjkzYQ8Oq5O9gH4JePmN1IX7jMO+bVQzzche7NwFp/0XXuQliRJZpBnyek877evJ9POpA+3PREbT7IHTAKrDKUgk4dqQkoa3qk0+wthW8mRx7Fuay5XUMFD32j9eRXs5DoI13CYZDXUJ7VH1aHRo9Z814bRaXGIfb5EFLZD83dAsDnkvOT4lKW3m/grJtA0uwzjgv+CNiqu2TbRHDxv1HUMlZe0gQK9SZL0EXqCwwsG7ylSwdXNoLjOf/56PIYPDtXT7+KsBwxfdKisy3K0adk4spyHsc5RiwDBdxH2T2seNaxpw9IX761EcSbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6916009)(44832011)(33716001)(316002)(6506007)(54906003)(122000001)(2906002)(1076003)(38100700002)(4326008)(71200400001)(508600001)(186003)(6486002)(8676002)(9686003)(6512007)(8936002)(66556008)(66446008)(64756008)(66476007)(7416002)(66946007)(86362001)(5660300002)(83380400001)(38070700005)(26005)(76116006)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qMjVZFRXKIFcGMO5vNvb8/SNIWLpKgWnoyWcgtQZtN0iZVV+Hhj19kKGXUH4?=
 =?us-ascii?Q?2aPnrME1vKaq1glO47y3Rzow32yu8Ofx25ul4nSymidOLVoF3PjAvlHN/POm?=
 =?us-ascii?Q?q8sYBiQ0Jdohfi6HkxnYw4FQtwX05inJOMO4S/P6V42zeS90cdXYMVrBMGgJ?=
 =?us-ascii?Q?jMYH3ZQSw3ns6EYvfCs06osa1cqym5bHBhQKHZDDKVYjpr2FNuBIMqLb2Xd2?=
 =?us-ascii?Q?AtgqghE0kjN23rEguYuS1fTLOowgetlVc1Ssku8xoT8rO2j6mhlp6frTzBp7?=
 =?us-ascii?Q?YV40VHma4sHMpniotndrCGkb7IRlsXA7DIAk+IpITtOIakVOWyaj4i9GuxRm?=
 =?us-ascii?Q?u7X06j0KL4QigaTIfGkbGlWogp1ylNLvn27IL5knoVyscO4LP3uawWlIP7OI?=
 =?us-ascii?Q?CmfuyRLygh+KZKFZeQDCxMp94wWN+Zhuw4IKirzykUabsHr6XoJ61kIgcKO/?=
 =?us-ascii?Q?i7N4+c9f6ik2DLTZQQxJFHVaWSrQ4gBPOYC+I+G1EWjMpN1cM7ARi7HJcquD?=
 =?us-ascii?Q?4uLdtsthpo86mGiTedj08AsZhDSSqnhSwtFRCAsNliftsqXlm+r2mEi7q3az?=
 =?us-ascii?Q?3oSdBYk2BeB/OFDhLznME5R2Ae1LRt9VIj7Ef+iTgyeLGAMFxKxfdCQGPCCD?=
 =?us-ascii?Q?0XQyvVgg6d5fIx24YEqS/+jipz3GtzVtNAC7iAoeMxdl2HNtWvEnmc9f7jM8?=
 =?us-ascii?Q?8KniB/1kP15zCQuzjDFWmRnFC/8GhERO9xOM3LjOntLG1TlxUPKp86BYzngY?=
 =?us-ascii?Q?wuocZVRKLMCsMHDufhCVZgaBoi8sV2+23iM0e2vQ76vJYaVy1ryY3VBLH/E3?=
 =?us-ascii?Q?3qN8Dw2ehG5OySRwxAKeYLxFiTCJyZjAUl4Ywg0hjkRAg4yV8EWmXvOT31+e?=
 =?us-ascii?Q?eS0bLny83YmJ+Yr8nGFxZOy2L1AtJAtTNSKqlUiu8RwDJZ0v1Rntb9F2N3NS?=
 =?us-ascii?Q?8WEdrnekZPaqbTJDT6RMQrZmvab2JM9Qfu6jSBrZ5pF2vpV1WTm84wOoeQ+F?=
 =?us-ascii?Q?NBubVQbOnYJBqbJSlDxA5+vcQ8IKwPo8zwzuvgMaqb/F+CZvmjyw1ylUguRh?=
 =?us-ascii?Q?ZrflR9POOzocIEFcHoJLzGKGjYDBHvedEGtuRVbQwlVZCvf+438mfBRnvm6y?=
 =?us-ascii?Q?d24inw8Saacw3QSc9xUH4dY26tSh+W1ef1BO2tnzP41WGDBjXYf91igtQ2aG?=
 =?us-ascii?Q?iN0t/kheDhThskntAaT9MBsfFUrcMoloqUWzODP7v9tvTSLFmLCUw9Rxh/iT?=
 =?us-ascii?Q?ILbmFZr4n/99BdyOdP3gNlRRlMQUIsMdVRjuk6GjoUlzKp6naXrhC4aG9Ixb?=
 =?us-ascii?Q?Nd+UpTlgNEOfc7NDrwyDXHIg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B962D22A97BE474E80B4A121739AC012@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b4e21e-3ea2-4537-ad10-08d972f8993d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 18:43:49.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLV0fWRsiWvJIMLucp116YADiOU1vRCtOct4EgNXVa9RGYgOmP7sAL+lgCzIJESEqnEuFh+W1k9n+HgAW+L30Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5181
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080116
X-Proofpoint-GUID: nENr00IZC1b_sxPfXdLmoQuQooaJhv1T
X-Proofpoint-ORIG-GUID: nENr00IZC1b_sxPfXdLmoQuQooaJhv1T
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* Alexei Starovoitov <alexei.starovoitov@gmail.com> [210908 14:03]:
> On Wed, Sep 08, 2021 at 10:52:59AM -0700, Andrew Morton wrote:
> > On Wed, 8 Sep 2021 10:21:18 -0700 Alexei Starovoitov <alexei.starovoito=
v@gmail.com> wrote:
> >=20
> > > > Again I am ignorant on the details so if you can clarify the follow=
ing
> > > > it may help me and others to better understand the problem:
> > > >=20
> > > > 1. Peter's patch appears to just take the same "fallback" path
> > > >    that would be taken if the trylock failed.
> > > >    Is this really a breakage or just loss of performance ?
> > > >    I would expect the latter, since it is called "fallback".
> > >=20
> > > As Yonghong explained it's a user space breakage.
> > > User space tooling expects build_id to be available 99.999% of the ti=
me
> > > and that's what users observed in practice.
> > > They've built a bunch of tools on top of this feature.
> > > The data from these tools goes into various datacenter tables
> > > and humans analyze it later.
> > > So Peter's proposal is not acceptable. We don't want to get yelled at=
.
> > >=20
> >=20
> > I'm not understanding.  Peter said "this patch merely removes a
> > performance tweak" and you and Yonghong said "it breaks userspace".=20
> > These assertions are contradictory!
>=20
> Peter said:
> "The only sane approach is making the vma tree lockless, but so far the
>  bpf people have resisted doing the right thing because they've been
>  allowed to get away with these atrocities.
> "
> which is partially true.
> bpf folks didn't resist it. There is work ongoing to make it lockless.
> It just takes an long time. I don't see how bpf folks can speed it up
> any further.

What work are you doing on a lockless vma tree?  I've been working on
the maple tree and would like to hear what you've come up with.

>=20
> > Please describe the expected userspace-visible change from Peter's
> > patch in full detail?
>=20
> User space expects build_id to be available. Peter patch simply removes
> that feature.
>=20
> > And yes, it is far preferable that we resolve this by changing BPF to
> > be a better interface citizen, please.  Let's put those thinking caps o=
n?
>=20
> Just silence a lockdep as Yonghong proposed or some other way,
> since it's only a lockdep issue. There is no actual breakage.
> The feature was working and still works as intended.=
