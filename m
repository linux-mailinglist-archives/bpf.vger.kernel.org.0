Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22092D635D
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 18:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391070AbgLJRTj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 12:19:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390049AbgLJRT3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 12:19:29 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BAHIKFN027861;
        Thu, 10 Dec 2020 09:18:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DCoDdbPnnFq4+X/g56yIdEKiKiPG8NgpBgxisjGdL+U=;
 b=bGpTA8VGsIUnOeUJoeSirghRgrwT4tiJKoCxkVPoThkg8GlY940HUMjA6PW4lsqrDaa4
 OBFydAnn/6CHlS4EYN7ILXIerySDi6updZcwtPDOeyHDz49ZuaohnQtMPV17DM9LW1bU
 3fB29X6TOrWprY4qHlSn2tVaxqNKnfHbmjw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35aj8vwwuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Dec 2020 09:18:34 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 09:18:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT56DllL6CIgiqArhBT0rb6uW/8YOPEts+Y+vm6reLUuFfUtJaWnFGHTtrcaRHQP1C7leGrp/9fVWeBJcAndUlE82CsQyVxyICx1BLEzuwcib5Sa5EVUOJR2TU3tF7yUkoQeVOrRSVtYquGcgptmWxtAMa5AqBNCinY0btH+ZusveDii4g/R++7qlpaIicbg0XBG/gUwc0Fi705tYNizQvoooQjvx7WwHO/C4FPZo4JplMqDNIdawRNA9kpA0JHU5SBel1camS0SQOwvFkAh6h9pfdwHn3x+dRCxq4FKdtq3SVPxWfZ/cx9zWJzvKlin7NvgB3hseyua4FMfM9GWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCoDdbPnnFq4+X/g56yIdEKiKiPG8NgpBgxisjGdL+U=;
 b=h0q6Oi9qcT/xrahQLQzdNAn4vSbDQc6csitNKVNKKqlgT7qxQG4VPL044Xp3Aqi3sw4MDb5/BxMGQaxI//uHJAGq7N7KjsSbHF2Y8PCnEuUYsQl5DAHNGEws1MRdCr9BfjzXqcriitlZ4Ym0Gcm07pF3V5xZdUknQ+QT8IFJ6BqHCJXV/11tZHyKQWzqTiEjf1+H4MqLkAFQcOTdz7+N995eLUn6SR0O2D/fqI0n0igAEGYYjMWEfIT6YbFZBDrI4cbHnUvtUgvIGHNTPjdoM0LdANZmdt/9hQzpqd3swfWihwIyqEFNYbfinze8juzZAlW9jwGIrFmPNBX7k17wsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCoDdbPnnFq4+X/g56yIdEKiKiPG8NgpBgxisjGdL+U=;
 b=BA/yuEF+uzL9cVo1mRaSVbVDfytEb7gxZ66ohxaTlzcew2WTus3ElRKmUSwjoc51+d0zCz7MEtiMGdRlCwcD4TNG8SDUqFaoGf0qRJAaYcwySu/21GCshplXWE80k/shaa5V4ampxLPVqTPVAii1dQAZ6DmXe9J8B8lRBf1arG8=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Thu, 10 Dec
 2020 17:18:32 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 17:18:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: permits pointers on stack for helper
 calls
Thread-Topic: [PATCH bpf-next v2 1/2] bpf: permits pointers on stack for
 helper calls
Thread-Index: AQHWzpSF8nDXEtnHDEaDmpItepDlBqnwk84A
Date:   Thu, 10 Dec 2020 17:18:32 +0000
Message-ID: <B7EA6237-513F-45DC-8E38-D0765AF7E275@fb.com>
References: <20201210013348.943623-1-yhs@fb.com>
 <20201210013349.943719-1-yhs@fb.com>
In-Reply-To: <20201210013349.943719-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
x-originating-ip: [2620:10d:c090:400::5:d023]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6edf6d0a-1fb2-4823-c4f2-08d89d2f9ec4
x-ms-traffictypediagnostic: BYAPR15MB4088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB4088DBD7FF23DD786E6AA4B2B3CB0@BYAPR15MB4088.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOPUf9ZQ7Ivou4XoFHKteqE5NpRsq7/0sZ54BHFQ0nd8KzHjrVBxnsP+PWYvcSKWa7N5PVfpvntEniwlE9YU4lGmaqe5uUcC/fAo5vcRlzQs7ZaBZeREJ4ieG3x/mZn1MfzBQ6huHrK3zHJlmaE/IeP2VdI/KBxDzC0PijEbU6W+e2mxb3X2cjdTnhphqGBUmZsqneB59mdidyZELrRsKRqqyM8nvjtZ/rza1SmiXoqtDv2DwydNK9pGBd+A3UybcHUjbxCEMLEMikFIDcffzYJsdSq3+leGF5eaitqJ7YwCJNlBY6fKjPh5Dq+5pdgHPMp97Qj4FzzaUbS6a/uPb5bJN0FKoGDfdrGSVvNfrLRgttQev96givfuNB2HWVjp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(8936002)(8676002)(76116006)(508600001)(6486002)(6512007)(2906002)(6862004)(53546011)(4326008)(6506007)(6636002)(54906003)(86362001)(83380400001)(71200400001)(37006003)(186003)(2616005)(66946007)(33656002)(5660300002)(36756003)(64756008)(66476007)(66446008)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lnDKAqrWondZMDA4tKO6koiDfJYHaAz6JgWcdhOcdaBeX20hHRoCFWu+4CVU?=
 =?us-ascii?Q?jy/OLgim+i7pTw1Ao8mWSAjGmURYLZvUF9cgYbbrkTr0LVhgrlnTpD98Dq2H?=
 =?us-ascii?Q?HgZ6EDSTjNCNoNiM+P9kIQefUO/3kzFl+0uRX0zzW8pyxEQfLIIaIKppw0rO?=
 =?us-ascii?Q?5+ShZl1JciFUP4XY5dSjZPaUQ1Uo6YXWQd+Ik2WYjLwY6ueH8EjfMh/asGWi?=
 =?us-ascii?Q?epZgxRPViw+WcR3O5CCLDiKPtohOTeyi3Ub+rcaUhfX7MdUJiII5QP7N45IZ?=
 =?us-ascii?Q?bocL9NuNaRqoSGFv4Asj9p+ObOGutWq/2hZLH610pZ6H6G1MNrXk6BFXprN2?=
 =?us-ascii?Q?4EiIniZxJ/loxPd2DnSSG2isYywJMei3x/X9hblRKsfFGDCkV6IGJlUxnqm7?=
 =?us-ascii?Q?IrDe2iFrzuFMCg2YccrzNcbV0GgoRfeCKsSXGzVhuPVbyg8bJDOaXvpcLbHi?=
 =?us-ascii?Q?jVdCIHZvV21CNFrC6hEVy9WV1hi7u+V9yoptJhOslsrTbFxk16gfinyMV+Kb?=
 =?us-ascii?Q?GEyFQTfyavp7yQ5cyxjY1R0ObfqbJF3ZukazMNpe1deEDYyJ4BH9BeStL8Tu?=
 =?us-ascii?Q?Rhzj2zV76mEPiOz6Nq5ixsVqgyuKEfAfBGMypBWK6Rt7V6HV3fZhQorpEruF?=
 =?us-ascii?Q?1OILYRFh9AH0scrxMhTeF/ABEvcyZoVhrnHmX8SQ1gKG/Oct8SlyqNwVkQbv?=
 =?us-ascii?Q?qTZqXuYqzOylZHoAd10alv5Vx0SgqHyoM5z3TcN5b5CwdOjejPhV9ARfJKon?=
 =?us-ascii?Q?loZGN7tN+SGzQA7UAs9eONVuAlWe2mFAVTKA0C2i6ZrjbrYJTKY6x2ZQOKzP?=
 =?us-ascii?Q?K6NwqfHRnX/3sNbfYrGMONDwkN1MEbDEGK49QUAQTUOKKKAPPQYGHwc7/ff3?=
 =?us-ascii?Q?ZCgxDFAR3UFfbDUD3KuSZuZda9a23oi+zX+y/cF/S+wgcx4k7hs2aSsh2JlP?=
 =?us-ascii?Q?cY9U0Kf3ODxZxVC9QmFB3IirlhwMvWsGIUYoaOF24bo8qZ5t7rrLs9oCNRjX?=
 =?us-ascii?Q?rd1vF06oFuQQ7McT7bh1k3UbGsEQosgGF9MKMOigg197bR4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16B79AAAC2A3AC4897AF57D4BDFAE4A2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edf6d0a-1fb2-4823-c4f2-08d89d2f9ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 17:18:32.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1MIpmj3YBjQB/VuNeUGgmfY14L5qOZjfC9wfhkLSfYxW90GXMCLbqPByw3C1G+ic9v6aezBN6Dc3rZeDyWyDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4088
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_07:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Dec 9, 2020, at 5:33 PM, Yonghong Song <yhs@fb.com> wrote:
>=20
> Currently, when checking stack memory accessed by helper calls,
> for spills, only PTR_TO_BTF_ID and SCALAR_VALUE are
> allowed.
>=20
> Song discovered an issue where the below bpf program
>  int dump_task(struct bpf_iter__task *ctx)
>  {
>    struct seq_file *seq =3D ctx->meta->seq;
>    static char[] info =3D "abc";
>    BPF_SEQ_PRINTF(seq, "%s\n", info);
>    return 0;
>  }
> may cause a verifier failure.
>=20
> The verifier output looks like:
>  ; struct seq_file *seq =3D ctx->meta->seq;
>  1: (79) r1 =3D *(u64 *)(r1 +0)
>  ; BPF_SEQ_PRINTF(seq, "%s\n", info);
>  2: (18) r2 =3D 0xffff9054400f6000
>  4: (7b) *(u64 *)(r10 -8) =3D r2
>  5: (bf) r4 =3D r10
>  ;
>  6: (07) r4 +=3D -8
>  ; BPF_SEQ_PRINTF(seq, "%s\n", info);
>  7: (18) r2 =3D 0xffff9054400fe000
>  9: (b4) w3 =3D 4
>  10: (b4) w5 =3D 8
>  11: (85) call bpf_seq_printf#126
>   R1_w=3Dptr_seq_file(id=3D0,off=3D0,imm=3D0) R2_w=3Dmap_value(id=3D0,off=
=3D0,ks=3D4,vs=3D4,imm=3D0)
>  R3_w=3Dinv4 R4_w=3Dfp-8 R5_w=3Dinv8 R10=3Dfp0 fp-8_w=3Dmap_value
>  last_idx 11 first_idx 0
>  regs=3D8 stack=3D0 before 10: (b4) w5 =3D 8
>  regs=3D8 stack=3D0 before 9: (b4) w3 =3D 4
>  invalid indirect read from stack off -8+0 size 8
>=20
> Basically, the verifier complains the map_value pointer at "fp-8" locatio=
n.
> To fix the issue, if env->allow_ptr_leaks is true, let us also permit
> pointers on the stack to be accessible by the helper.
>=20
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Reported-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for the fix!

> ---
> kernel/bpf/verifier.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 93def76cf32b..9159c9822ede 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3769,7 +3769,8 @@ static int check_stack_boundary(struct bpf_verifier=
_env *env, int regno,
> 			goto mark;
>=20
> 		if (state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
> -		    state->stack[spi].spilled_ptr.type =3D=3D SCALAR_VALUE) {
> +		    (state->stack[spi].spilled_ptr.type =3D=3D SCALAR_VALUE ||
> +		     env->allow_ptr_leaks)) {
> 			__mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
> 			for (j =3D 0; j < BPF_REG_SIZE; j++)
> 				state->stack[spi].slot_type[j] =3D STACK_MISC;
> --=20
> 2.24.1
>=20

