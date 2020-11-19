Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606082B8ABD
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 06:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgKSFEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 00:04:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbgKSFEM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Nov 2020 00:04:12 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ52LVK010967;
        Wed, 18 Nov 2020 21:03:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7w5gbCT/V12RmbPn4+jTgnsKVRr+NywDVvqHwHFqaWs=;
 b=JzO3Zffupy2uLpRvnJU59QWf9MgJRzSTXcG3S5jnAyHxpYp69OYVFq4vCrMVoRaBNoz4
 bT03U45Zp8TkxfCvLic+u0p6k6aP7CH5jtfHLH5Xwtm3XLpMSXYdtx5gOTx0+OFB3Y12
 HR0JLYCBt/7GiWfxO1mNp4LPuhGGZcXBCrs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34w2mk69d0-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Nov 2020 21:03:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 21:03:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbRK7hDf6KsaOW8RiS0fhkaXkwAZP1H2vpeW1IC2mo3sjCrG5Vj44Lt3h6/2Nio5F5T3cgRXLJfYdCzeFUq6ibfki0BrW4cSLRErE+c2lZHuO9awql2C53w1l5wtWOj7itH7DHANuTOp0F+UJpXNL+hHAX16FBltsT6d+1ObwoAHb5Jdl+TjSihymoBLBPhubLBWieaeti+k1XihiOaJiwExdYxxXq5yHTltNNK5slSfLtLspy+urIv22Km81CF+X0do8JD2VhUF4CpxWi4DdJczFLh+J3LViPQ6xJVGSTsTjVxhHKAmdWJZBpJYcIp08y1nGLJosrZdI9dQ5q/Mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w5gbCT/V12RmbPn4+jTgnsKVRr+NywDVvqHwHFqaWs=;
 b=B9G24HXkEHcLEV62kkcMd5Dm8wrfKLk42AKVFRpHeiv8agA+0UJFk7iaQCsQVC42443qF+5oslupe1wUIuMMen8aKa/MS7lPcWjloqwA55cssyqeSuNBH4t5535f55O36zF+Qy7+RP10NB3IjguiVfxRVVGa1BzaSTwgFZeO2LLsXtOTJx5vTxInh8bcWTiSVX7LRMxM9RYwc1zEcRn91zrETsC9K3Yp4rgmwzkGKCcxMZS3ze4hlA/pWinueEVdyug3ZUjOlx+S5h5qUVvXeVXRsaKhM50hVyi5jP7CHVl0Kijn/v7zbAT1LPMmJ0ZKX925Qkg/wpk2F793w8HYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w5gbCT/V12RmbPn4+jTgnsKVRr+NywDVvqHwHFqaWs=;
 b=Wb85ojdQ3EA4bvO3eHGWK1Uxr0IYLSg73giJHqwgHvOu+LoKOTxNC3Pntm/+WYdSmn88aHYrMpnk/xIBHp487VGqZUC85Ut+NDplnDeQ+08ZX4+YGK4Z6PCuPFIwR9YqUNV27RwnTR3ewefr0M+oOT3xQKhDoqJ5dO7q6+SyZi4=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4201.namprd15.prod.outlook.com (2603:10b6:a03:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 05:03:52 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3564.031; Thu, 19 Nov 2020
 05:03:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpftool: add {i,d}tlb_misses support for bpftool
 profile
Thread-Topic: [PATCH bpf-next] bpftool: add {i,d}tlb_misses support for
 bpftool profile
Thread-Index: AQHWvivC23wajc/7X0eO1MzeUCrPOKnO5mSA
Date:   Thu, 19 Nov 2020 05:03:51 +0000
Message-ID: <3D194218-382A-48F0-AAAC-9D3C2355D61B@fb.com>
References: <20201119042332.3343146-1-yhs@fb.com>
In-Reply-To: <20201119042332.3343146-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
x-originating-ip: [2620:10d:c090:400::5:69f9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49ea988c-7f38-402a-ea2c-08d88c48821c
x-ms-traffictypediagnostic: SJ0PR15MB4201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB420127FDD9E0E17AB8EC00A9B3E00@SJ0PR15MB4201.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WFZXFQbu3s3lrndD3t7v0Z1z2kcPmOSYwfUVhacXYL0Yu9///0bLEd+WKpygVzVYWapaQs2CqN1v6bF7qrSeVcEPZJjM2szzOX3VaTLdktwxha2fUkmVOdC/qvQes+h0MjaK17gTGuynDfP1+7zOTodigYFAfqhYccPvrmiPGlqxrBIHVYYcQi2lPdU1P66QCnx6hn5jcj1tav+V0+RMykPw01YQUUSz3H4bevn6tgo9iJ921+drpHBU/nPr7IE1smw+JsD9FEr8mudimW4oHZruURt7qEsyCpvQmD4ffrkI+JInL3s6qEQ6s0eNq+DjYYrbZEBe9UFTHDKp/eneLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(136003)(396003)(66556008)(66446008)(64756008)(316002)(66946007)(8936002)(478600001)(76116006)(5660300002)(186003)(6636002)(4326008)(71200400001)(8676002)(66476007)(91956017)(36756003)(54906003)(53546011)(6486002)(6506007)(86362001)(33656002)(6512007)(2616005)(6862004)(37006003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NNnMssjzHZVphW2TB/YK1/JYJUa5jaRJG0n1+eiAz6SsrMpf+dyKGUDM/bsL4Icj0g/isxAQFKjYAwJJQGKrcb+9ysglCLFudKOKzv+WY6T/67XX6Tr1rCHhto1EF7TnTahTJUE240fV64Gl5OCnSD6GC446xv1T9dnYURXRnbVjyV18i3Mu0eDmKTTBbdoQWJjb+AwwrZugVyBa08IO6I7tH9YdW4LwKPoC+KPvS0g705ugFT3lw7MVNh9/2Bpv/FTAGhifGkUveoVpb0LPjkvrWMm7TPncuqXlTwcnbLOlCGTa+ScxDHHJgybhgVMdOxubzKhfqrW+sEORmayZfYX989VqQ3Z/CuwwKzH9EngIsluMQCD8Bw+0BKyIjXMHtdIspMX8NDPy2Ot2wp+nAkLefN1h+Frh5emyzDF3RZt0THjhvgNW0A1MtaT+Dka4KqYl+Fw3NSI+pbUttzRqTF+oVpNulls8HEcuCSYgXydLL7bp9Bkjia+YnTXse+NgljyDO/s3haHKq2aihYqUATEKTHdm+LM20KRLiTcueK0gP3+Vii7NTnrVPzyYztoRAUD4U5di38RoRLmZ1vmzs8DzyR6gobQqRKTMcRPwj79aOVOw00oRFWOjSx+CZQgDMhALn15i0YDvqLpviphx3T2/wBRYNnqi+owKA7zZEmrqFH3yi9BnHi826Zlnp0xabaeW5WxNTLXLT5KB9L4mBvC4Cznr/dEGeBK0N09y8jhRoqhvjOH5piHtb74oSZo7TI/C/oeH2Um1gOr6bVSAHS26AHDAHE/Ycnui0UmCuZawIU60SpwtbxCc75q0leSmEF2pgRA+AX4YP1UwBKSoEds7jaNu7MJCig5Up0wjKeKSkaFvX7twexnC44v0xoSQLK3o9/bieQQm6YvLHsdX71FTSdT4xTq1E1G90bYxEAM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8510A27FDFE094A8E22367740EB2C95@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ea988c-7f38-402a-ea2c-08d88c48821c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 05:03:52.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Luld061TirlWXMYYSwbnIZAbp1hOVBJuwXvQkPBpb0h65eF89gmUWWPQO7LKX+E6idyckmtvclaklww4VhRLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4201
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_01:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Nov 18, 2020, at 8:23 PM, Yonghong Song <yhs@fb.com> wrote:

[...]

>=20
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
> tools/bpf/bpftool/prog.c | 32 ++++++++++++++++++++++++++++++--
> 1 file changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index acdb2c245f0a..e33f27b950a5 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1717,11 +1717,39 @@ struct profile_metric {
> 		.ratio_desc =3D "LLC misses per million insns",
> 		.ratio_mul =3D 1e6,
> 	},
> +	{
> +		.name =3D "itlb_misses",
> +		.attr =3D {
> +			.type =3D PERF_TYPE_HW_CACHE,
> +			.config =3D
> +				PERF_COUNT_HW_CACHE_ITLB |
> +				(PERF_COUNT_HW_CACHE_OP_READ << 8) |
> +				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
> +			.exclude_user =3D 1
> +		},
> +		.ratio_metric =3D 2,
> +		.ratio_desc =3D "itlb misses per million insns",
> +		.ratio_mul =3D 1e6,
> +	},
> +	{
> +		.name =3D "dtlb_misses",
> +		.attr =3D {
> +			.type =3D PERF_TYPE_HW_CACHE,
> +			.config =3D
> +				PERF_COUNT_HW_CACHE_DTLB |
> +				(PERF_COUNT_HW_CACHE_OP_READ << 8) |
> +				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
> +			.exclude_user =3D 1
> +		},
> +		.ratio_metric =3D 2,
> +		.ratio_desc =3D "dtlb misses per million insns",
> +		.ratio_mul =3D 1e6,
> +	},
> };
>=20
> static __u64 profile_total_count;
>=20
> -#define MAX_NUM_PROFILE_METRICS 4
> +#define MAX_NUM_PROFILE_METRICS 6

This change is not necessary. This is the max number of enabled metrics.=20
We don't stop the perf counters, each enabled metric adds some error to=20
the final reading. Therefore, we don't want to enable too many metrics
in the same run. If we don't have a use case for more metrics in one run,=20
let's keep the cap of 4 metrics.=20

If we do want to increase this, we should also increase MAX_NUM_MATRICS=20
in profiler.bpf.c.

Other than this,=20

Acked-by: Song Liu <songliubraving@fb.com>

Thanks!
