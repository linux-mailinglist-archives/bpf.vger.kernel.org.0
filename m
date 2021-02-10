Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71428315E0A
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 05:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBJEIc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 23:08:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229864AbhBJEIb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 23:08:31 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11A47dkv004956;
        Tue, 9 Feb 2021 20:07:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5/FqwA+Ej0MSo9KOyoaKFO8sdb2V+C9sw7fDtY54nT4=;
 b=KEApUb1X/JP79YXhIeBcdXut9kh+h48iZmE1Z897T35/WxIKBeyuBo2R+m1BmGNBij6A
 /oIRZ/Bo/0KLraMzh/yoNMompJRUVuceVPAZan74iwQgYXkBFQp6DBoOC09ijLoTwChC
 js0KDI3IS9MfOl4ew/JmqcF+R9lSKYcwjdc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1cfge5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 20:07:45 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 20:07:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd9uxGT8jRVXErswi8eGsxw+8bFHETEherdjQiYVzU8lZ4KXauaWyS2Ckihg5DZNpDt5PbaGRo1kMbmR34Gy4ms2X+gW2GnbleEgj7HqUt3bq1sq+OUwlYNRe5jkaz3WPY2ZiBsdXGEqylU1qmrP9i8Nr0Bb8Q2t0Iudc0LKAwbzOv7rGAgQrohfmsVANA08jVgTemZy9wkfkGmKeYp8iM9XkKdDBfxkvF3JalVfqv5X4iJrmceohsNp3QRpafVtEfL9uYXCLgw7TsrTechbdZikSTSq3dPgU4gl7eyQh+gb/d32tQ7SKU+Z1tCdIzpQ+4Ghz2VKbUzhQWm/7KurNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/FqwA+Ej0MSo9KOyoaKFO8sdb2V+C9sw7fDtY54nT4=;
 b=m0F5YBMMAuijTlPugodpJIhXAiiG5x3Hp6wGUnF6OKHZVyq/yKb0u7b4osq1KBG80OqPeIof5uZivO2AcRKbfDJsElgX516ItwsR6O8CZPS4cGQ78Ph35YEqmBZ2GxiwQveB4R+SGkSiEcbogZ1oLGdmJfZz1j+7oh5IStpoAmYzGq2Vn74kHEypeNyjFtzHICLGNj3KnHTahMod9ZccwfXz7InYpeDOPkb5OrA+gARqI7faf4n6hF7AFyHs4iVJib2bVzZvyJMevt6c93mFoFBACj/fNvq7HKHvCTvdGEG6jHPap/5ZiDxhdM6qU/OPuVnyDuVSc+3qntGao15S9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/FqwA+Ej0MSo9KOyoaKFO8sdb2V+C9sw7fDtY54nT4=;
 b=dNcq8Hv7+e5QBkc6Xh9Rn9l3BmU1y4PyTHvmdTgdBHKElAR9nUrzMR92afhzR4C0uuGaXuLpAf9DmUrb22te0uTg08v4Es7lqf+EZ+fdJCU9R5K71hrB6evxwk5SP4jGsp/RzB4uYoC4doDVSt8rpVqhCojc2qx1Tw4tpietWPk=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3255.namprd15.prod.outlook.com (2603:10b6:a03:107::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 04:07:42 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0%7]) with mapi id 15.20.3763.019; Wed, 10 Feb 2021
 04:07:42 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Joe Perches <joe@perches.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, "Andy Whitcroft" <apw@canonical.com>
Subject: Re: [PATCH v4] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
Thread-Topic: [PATCH v4] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
Thread-Index: AQHW/ylj1Y/C3YR/QkyVJIzS8tmtH6pQpXMAgAAgx4A=
Date:   Wed, 10 Feb 2021 04:07:42 +0000
Message-ID: <F5609C13-E5D7-47C2-94C2-F4C2443352C4@fb.com>
References: <20210209211954.490077-1-songliubraving@fb.com>
 <2b4805f6ca2b44f4195b6fdba4f82d5e90ab1989.camel@perches.com>
In-Reply-To: <2b4805f6ca2b44f4195b6fdba4f82d5e90ab1989.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:3a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85fec6b6-5903-4cf1-61a0-08d8cd7969e7
x-ms-traffictypediagnostic: BYAPR15MB3255:
x-microsoft-antispam-prvs: <BYAPR15MB325591E4D0EF20B5EB7E895DB38D9@BYAPR15MB3255.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6q2qrMvC15e2/xwQK/JoGM2LsZWu5RPQnAK4Gn/9DDg+haDceDQNwBztyxXcQZm07eGRADIMChnbAO52ssmkXxgvfUiWrg5l2Ox4QMCMPXE2H1vUccGmt/dECU9h9ziHDp5/0Ft90wxNaSv+bAiHHBN6FuRGUNsFPNPc4IYuezx7nFb0JpftpyF4K+V3m4iqgG23AVh+xOyCDd770RlMEr5gM/K+NJVqcL3n+7/q5Zop+kQDT3aRjg3WQX2iRKbR2VAxlB/h/X14a1rrDZ+yA7BnHUjxLip6dqY7x2aq0UZbpbSC5DNl/CKGVshIw6SnaR9vO6Ldqu4U+PvPIQEIwgKEtRBb3tnVt2ZBG6lk5kTnx3gqa2ysnWMDQPORdA7FPFxRpYROBFvimuVK1lqwgBkR++3gSg+YdqfrP7jqxEQtsgR11aa3KDRf6qCHyvHe1XSzXQknpZJj1Vehes1WwzRdpyAhixQUjSmd3S27ombKX6ByGDLhuQ7qFlAKLXuA4KMDjYwW9skHe8JoDcPd8h7W2flJOpoixpkdSThkJjYdLKCe06IBo8822poxtDbCLv9DzygKnF36ZZ6D8hVg1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(346002)(366004)(396003)(66556008)(76116006)(66446008)(66946007)(66476007)(6486002)(64756008)(91956017)(54906003)(316002)(5660300002)(33656002)(6512007)(8676002)(2906002)(4326008)(86362001)(71200400001)(6916009)(478600001)(2616005)(8936002)(36756003)(6506007)(53546011)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OztoJ4z18JEoIA0BQQIKxQw5FaQ3nBG4L75+YGJVBSO56OGGaAwY5kazEm+c?=
 =?us-ascii?Q?D9yof43afL541VAl4YE2kVNgO5g5oSc4IhunhalJY1iQNPJ8LWOP3AiDJ1BJ?=
 =?us-ascii?Q?BuTlCz8TetRDnSM9vQGJHZy51Hm5TM6G6+7WErrs7WwS6to3Vt85fxYU9bRf?=
 =?us-ascii?Q?qkEnFdoeQNVbnICMqSc49Uz4HqbyyCEd3KPVZR/cdq7h2Ny81KtWIcDv5Wq6?=
 =?us-ascii?Q?cLyV1aMV1/ZtuCA8oLCS3JRntIjmNUqFEpCkpQfVusTQd6hMP2H7dC4Mu8J1?=
 =?us-ascii?Q?/IvyQF7dH5Wf8dZfNOH0hxm+bSfagPUY5sndCq1F5iHX+TYB80Yw6Z9H8lTB?=
 =?us-ascii?Q?d5dGlaHTiOwV1N5PbUW8ZGBXgijFYynCgglpVFUOydZfT4LZvSiumwNk1uNR?=
 =?us-ascii?Q?Lofio2WMkhUzOV5DXbyxpdisxGNQ1+LtKz+lzDV78JmEf3/Ta26+szmnwul7?=
 =?us-ascii?Q?QfrxE1Yy3GvCMb/m50WYFxtznqkdQawGNqfO7PrxyxB/lPCrOYF7bRUl/NpV?=
 =?us-ascii?Q?8GHVoCWgSZdLGKpgD1X/VL7cCMo1uDQG/2w8blv8wghb+SLPb6XfvTLW3aVH?=
 =?us-ascii?Q?t9C6LnHJkACNipw0YNowQBRnE68LeEGUWV/cptyNqrjpVasEV6H3dzk2ilhr?=
 =?us-ascii?Q?QEa2qLw74wFLk+FhPNAeHlI+NKIk/rc3YMv6S1o0tGn2IUkVUrY8OUebQau3?=
 =?us-ascii?Q?N+aiprABVYbztNxc+xeQ9VSjb6dZI5knjmwFD8+BQQpg1n0bZMDhmoQIF/IF?=
 =?us-ascii?Q?mzkntQkOqMy8z/P54yoNOlHt6VQ+duM2Pr5yIDUV3I9r5avXb0in4I8E1Ie6?=
 =?us-ascii?Q?rASvoT+BriHImwxkyGpNAbR1lRkyVtX/Lqtml1UL8VDAhqinEdn4hK3FNzMH?=
 =?us-ascii?Q?/UsBNqagcLo/d/fPjLv5icARHvuW+eesd9R/CjCgPS1+WU9Jh6PZXBO82mU5?=
 =?us-ascii?Q?l2ptwN+AFDgq4wY2Qp8H6v7Uph4vv6wnpd78T/DP4A6q+vShlIu4y3EB+4ND?=
 =?us-ascii?Q?6Ioph9C22HQtnb0t3ZuInxCl/WGndDo87H16niIZKhiVG6qkTpOokUOBZyOt?=
 =?us-ascii?Q?h4r5aufxKYNyZ3gOx5pUd9R8FPhxmBUqSqjFq+0q697p5Ha13X7scFL4XxkR?=
 =?us-ascii?Q?1aPoQA1CY7tqa0S3zYZOLTfXz1PSK02614GyMabfcOJU+DKWDK/8PcDsZSST?=
 =?us-ascii?Q?pFXR1yI+1GIEG6yNoGkmButPV28OLxLSlkIIlcCeDqFtHcUEceZ0H3Mzflyf?=
 =?us-ascii?Q?jjwAHdUC6fzh0hbrxxxHhqOMJuFPQqzyQXnge8cft2O6Zk6bQ0rWzr/Xw1+N?=
 =?us-ascii?Q?hN6TDDtkiG5b2WSw95B/PjIf9QwhGnUzTeYb0nWEb11OiIwwZ6QE40Wulf53?=
 =?us-ascii?Q?fqok2SE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <420B9578234366419CFE1B2A6E1121EA@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fec6b6-5903-4cf1-61a0-08d8cd7969e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 04:07:42.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rD68zrV9rF3Lav9QmQY8Kl4uStiptykWNd/4tJJ651uvmpv/XZKQ6PHF3Y4vtKYoQkmJKPS9nPuqGrk7a4sV8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3255
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=912 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 9, 2021, at 6:10 PM, Joe Perches <joe@perches.com> wrote:
>=20
> On Tue, 2021-02-09 at 13:19 -0800, Song Liu wrote:
>> BPF programs explicitly initialise global variables to 0 to make sure
>> clang (v10 or older) do not put the variables in the common section.
>=20
> Acked-by: Joe Perches <joe@perches.com>
>=20
> So the patch is OK now, but I have a question about the concept:
>=20
> Do you mean that these initialized to 0 global variables
> should go into bss or another section?

We want these variables to go to bss.=20

> Perhaps it'd be useful to somehow mark variables into specific
> sections rather than bss when initialized to 0 and data when not
> initialized to 0.

Currently, libbpf expects zero initialized global data in bss. This=20
convention works well so far. Is there any reason that we specify=20
section for global data?=20

Thanks,
Song

>=20
> $ clang --version
> clang version 10.0.0 (git://github.com/llvm/llvm-project.git 305b961f64b7=
5e73110e309341535f6d5a48ed72)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
>=20
> $ cat t_common.c
> int a =3D 0;
> int b =3D 1;
>=20
> int foo_a(void)
> {
> 	return a;
> }
>=20
> int foo_b(void)
> {
> 	return b;
> }
>=20
> $ clang -c -O3 t_common.c
>=20
> $ objdump -x t_common.o=20
>=20
> t_common.o:     file format elf64-x86-64
> t_common.o
> architecture: i386:x86-64, flags 0x00000011:
> HAS_RELOC, HAS_SYMS
> start address 0x0000000000000000
>=20
> Sections:
> Idx Name          Size      VMA               LMA               File off =
 Algn
>  0 .text         00000017  0000000000000000  0000000000000000  00000040  =
2**4
>                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>  1 .bss          00000004  0000000000000000  0000000000000000  00000058  =
2**2
>                  ALLOC
>  2 .data         00000004  0000000000000000  0000000000000000  00000058  =
2**2
>                  CONTENTS, ALLOC, LOAD, DATA
>  3 .comment      00000068  0000000000000000  0000000000000000  0000005c  =
2**0
>                  CONTENTS, READONLY
>  4 .note.GNU-stack 00000000  0000000000000000  0000000000000000  000000c4=
  2**0
>                  CONTENTS, READONLY
>  5 .eh_frame     00000040  0000000000000000  0000000000000000  000000c8  =
2**3
>                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>  6 .llvm_addrsig 00000000  0000000000000000  0000000000000000  00000210  =
2**0
>                  CONTENTS, READONLY, EXCLUDE
> SYMBOL TABLE:
> 0000000000000000 l    df *ABS*	0000000000000000 t_common.c
> 0000000000000000 l    d  .text	0000000000000000 .text
> 0000000000000000 g     O .bss	0000000000000004 a
> 0000000000000000 g     O .data	0000000000000004 b
> 0000000000000000 g     F .text	0000000000000007 foo_a
> 0000000000000010 g     F .text	0000000000000007 foo_b
>=20
>=20
> RELOCATION RECORDS FOR [.text]:
> OFFSET           TYPE              VALUE=20
> 0000000000000002 R_X86_64_PC32     a-0x0000000000000004
> 0000000000000012 R_X86_64_PC32     b-0x0000000000000004
>=20
>=20
> RELOCATION RECORDS FOR [.eh_frame]:
> OFFSET           TYPE              VALUE=20
> 0000000000000020 R_X86_64_PC32     .text
> 0000000000000034 R_X86_64_PC32     .text+0x0000000000000010
>=20
>=20
> Perhaps instead something like:
>=20
> $ cat t_common_bpf.c
> __attribute__((__section__("bpf"))) int a =3D 0;
> __attribute__((__section__("bpf"))) int b =3D 1;
>=20
> int foo_a(void)
> {
> 	return a;
> }
>=20
> int foo_b(void)
> {
> 	return b;
> }
>=20
> $ clang -c -O3 t_common_bpf.c
>=20
> $ objdump -x t_common_bpf.o=20
>=20
> t_common_bpf.o:     file format elf64-x86-64
> t_common_bpf.o
> architecture: i386:x86-64, flags 0x00000011:
> HAS_RELOC, HAS_SYMS
> start address 0x0000000000000000
>=20
> Sections:
> Idx Name          Size      VMA               LMA               File off =
 Algn
>  0 .text         00000017  0000000000000000  0000000000000000  00000040  =
2**4
>                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>  1 bpf           00000008  0000000000000000  0000000000000000  00000058  =
2**2
>                  CONTENTS, ALLOC, LOAD, DATA
>  2 .comment      00000068  0000000000000000  0000000000000000  00000060  =
2**0
>                  CONTENTS, READONLY
>  3 .note.GNU-stack 00000000  0000000000000000  0000000000000000  000000c8=
  2**0
>                  CONTENTS, READONLY
>  4 .eh_frame     00000040  0000000000000000  0000000000000000  000000c8  =
2**3
>                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>  5 .llvm_addrsig 00000000  0000000000000000  0000000000000000  00000210  =
2**0
>                  CONTENTS, READONLY, EXCLUDE
> SYMBOL TABLE:
> 0000000000000000 l    df *ABS*	0000000000000000 t_common_bpf.c
> 0000000000000000 l    d  .text	0000000000000000 .text
> 0000000000000000 g     O bpf	0000000000000004 a
> 0000000000000004 g     O bpf	0000000000000004 b
> 0000000000000000 g     F .text	0000000000000007 foo_a
> 0000000000000010 g     F .text	0000000000000007 foo_b
>=20
>=20
> RELOCATION RECORDS FOR [.text]:
> OFFSET           TYPE              VALUE=20
> 0000000000000002 R_X86_64_PC32     a-0x0000000000000004
> 0000000000000012 R_X86_64_PC32     b-0x0000000000000004
>=20
>=20
> RELOCATION RECORDS FOR [.eh_frame]:
> OFFSET           TYPE              VALUE=20
> 0000000000000020 R_X86_64_PC32     .text
> 0000000000000034 R_X86_64_PC32     .text+0x0000000000000010
>=20
>=20
>=20
>=20

