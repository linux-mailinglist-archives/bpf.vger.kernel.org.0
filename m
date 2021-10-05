Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC242331D
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 00:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhJEWCk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 18:02:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3060 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233282AbhJEWCj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Oct 2021 18:02:39 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Lpt2G010758
        for <bpf@vger.kernel.org>; Tue, 5 Oct 2021 15:00:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=0N1pEPQbLaNtvPMYbt4ZK/SHhIyj8RieaMNMArfkeJM=;
 b=d+gaiRh/K8Vy3cLBNO3VaC9xLWpcVLq52sxJctYnsU4oE/t3+cJN8fzfQwfJIbv1rnYr
 dWNeMxkeaHqR3Ov61bmqIeUCUnGKbAObkC390PDNgLcYkaCLgyurdAquq4ulqVtVKIfJ
 0QRs3u2R50f70TAgTdzgHPSe9VBpxO1jgPM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bgy06822k-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 15:00:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 5 Oct 2021 15:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3YgrYPVvheu2uj53mcsyFJhAYLWO7t0QqXwdJn1RrScO65NuGrC3g9slqW8umHAHF5BuNkURO3+RTlRNcXAB0jGbC2ScNEGInYQgr7UnHqmSEpO0nHdDapuZXLZ2IN43a+dXDrNboni73VovvU+z/PrESXIcmyh5EfHKYKtcP0CEt8QQqfRV4puLj+6IRnAGMVxLzPDyKcRXPSczvsPeYJdEuSpxcpscUdB2ejagCod01oKUFZ1fKsmhpgo7e1kiV4hqznyjXQVahnqVHtZsd/I2hfWFs9I+Mu4RStrdG8oczqXAA6nyQV94pP9JIQfnZ6ktaXZ59YONB3OgfNsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N1pEPQbLaNtvPMYbt4ZK/SHhIyj8RieaMNMArfkeJM=;
 b=SEDDwkKnUJKj3xqyuZSgOQO7B5EfAeHtHVEF5twBfR1scoJZF1Jk4R+dDGqYkNACispZKgyFIxtzE0sYbkYgTy9xCt34XH5ugHvBFI7Jk7jp/TUkpt68oZ4zPb2aRgTtMYgzdVEhTmbwHApnPM3x794Zi90XM0slyTSOVdJFJx9gDshcSCyWCFc4a1BcEn9L2wBiCJFyHb3v4Y3h4kyZyBjBt65Y8kY6rqCdRjj2oqh1j/SX63m3YLAgMEugqdohkcZp+VvnQjB45ZuTxlPli0Jv2dmtj85lkmsmAjOINVk1Qz2zB3hgHH9fk5xs6FRR1I3+Tvxfjfeuxb8F+CME+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5095.namprd15.prod.outlook.com (2603:10b6:806:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 22:00:22 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 22:00:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: refactor btf_write selftest
 to reuse BTF generation logic
Thread-Topic: [PATCH bpf-next 2/3] selftests/bpf: refactor btf_write selftest
 to reuse BTF generation logic
Thread-Index: AQHXubTaQpJctEVYxECOX9EwIIhHe6vE9V6A
Date:   Tue, 5 Oct 2021 22:00:22 +0000
Message-ID: <7617E159-AD1E-4FCF-BFD8-39D8803196DC@fb.com>
References: <20211005064703.60785-1-andrii@kernel.org>
 <20211005064703.60785-3-andrii@kernel.org>
In-Reply-To: <20211005064703.60785-3-andrii@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a223e3d-130c-44c9-6089-08d9884b8747
x-ms-traffictypediagnostic: SA1PR15MB5095:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB509587EE57A4A3B48F81D243B3AF9@SA1PR15MB5095.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G3RPZITJpK6nWPrcJaKzOMzqTia0sGQPEXfY66JIAr9vQBguAP+wNqPnxLiodX4m/h5rMnbxtjbrv/pjtFQvSlhcRVkVt9CW1ScqQhNHk5butdOyTQEbnpQDprsZcUYC9B0VWrs6ZVBPKvVZTOU58vTLA1x5FinzcoXbHj01d2stSJkkcN41WbR//9PuYgxjXFQq+argKcZMhnHMc+SHGcsUTpa14KijyoJu+CnYLKejHMoIOjyZUZA2voV9NN4C1c5JkRODbMTIqJXucOhN15sZYglMcWbFxIisxpLOGuiGAN3PADFcU1jTbAfmlGWRGE1VfNdk6Ox9TYjD6JGk9L4T8thHNwEtWgOPr77HS0GkdS+192IxLS1ictTpLq3wpddF0LgTfZhBeLW3ZAvcX7x4tgbB7IUb94TyinrEqoxWqq39+lfBtRl2oqWZ5ykCfaqb4XQzzH5dFXzcMwARtGHpQzVP9wxjC3azmlOts2WhGGWj5gZCuAI8o0XLWvK35lECgNA47BLcrC0axfWMb6c+QRZqa/XiOFuuu49cHYGVWesdPEUMD15FwgNYRNNDk/ozdt6bEDtQM6DJ2Y78rxPfCmXJC34nbHmWqn2X+FCCrBcwy3+KzH/aB+EITybIDDOmIq29lkC9rkfctIAYZZjckcWJBGelmXg+jo7KONeRkrTMvc/fBMYCOEmN2c5dnMgYGqNgvwPSm5S4JDEuA1LLXXUVejrh2wsqv1EpuJY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(38070700005)(6506007)(2616005)(6916009)(508600001)(33656002)(38100700002)(53546011)(8936002)(36756003)(86362001)(8676002)(186003)(2906002)(122000001)(316002)(76116006)(5660300002)(6486002)(6512007)(66946007)(64756008)(66556008)(66476007)(66446008)(4326008)(83380400001)(71200400001)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?btZqFTUrWgxWazdpYZLlp/hT3ADbRE9oRyFFmYbwmblcsGhX/x57eRzu+Z0m?=
 =?us-ascii?Q?4mYwmrdj07eLkMINboUkwAqz/N7x2z/cAx+Z8dD4MI8HDSGfuUmwESlo2Clt?=
 =?us-ascii?Q?qt0JkhABMxQOVG2ErPFp3Q48F4PtCfyyhCOje/tKUJfsttvp/tG5JSsRLSm3?=
 =?us-ascii?Q?C1+U/ZmforaWrSzNemyn9rYW4gab7LXZDqzH2W2Zkgl+8Kvpyg6OQJFmntD+?=
 =?us-ascii?Q?ZKd8hWtIlGRKh26N91FhMGUntoG+odiNQBdTzFeYssZSRHCusbsW2koGAyaF?=
 =?us-ascii?Q?wAVy4hKMoqT5H9E2esrO+Tc2+YLXyOnQEESq94pBbeGw8khaahx/+dfZp3Sj?=
 =?us-ascii?Q?vuO175c9nICKwJ3JQZ/QyrNCeVb035eOBoKJ1dqGXeuYDjDqCAr/AJK5eveA?=
 =?us-ascii?Q?xxmqP6ly31uyyWXaZqWZETTEbQKGL02OLQ4kgs1q85EyYLqZ2d+R5YX1BAox?=
 =?us-ascii?Q?H2g9rCWYtuu0fbXXJriLq9RL0IY9iWhqS5UU+w0ueHYCslOU3dIM1+v2YA80?=
 =?us-ascii?Q?ymZPyFl0ghLuT+QA3ynrdSgJ5/Q9dMZLnCXag7iMmZTXWOfQQWStR3+IMlt4?=
 =?us-ascii?Q?0LHpkMRVfxDRVg5wHmQp3c+2Xxxqp4I2CEcQXqr5EvkHnXWL0ly6laWKnhYt?=
 =?us-ascii?Q?nuArVIEhm+VwztyfahhyoldQbgp+0eK6B93vhVfZ/2DJKXlEznETw1lk1wGF?=
 =?us-ascii?Q?B4LgFgR0J4aboSosVidNjo37Vs3t0ed8ZBljkQy/RxoBlQzhIEOVDMt1IIDj?=
 =?us-ascii?Q?+LfBpPPHctn94zM1mQODjHStyd3m8OAzvmske6GzJAMBS4odNJIqR3sT9/v+?=
 =?us-ascii?Q?LHcMMLTsRTrdtslO8NiF2wiXBSnmfu19i8lxQOPVuYR18lfIbnfpetU9CFZl?=
 =?us-ascii?Q?CkADZ801vg+8w6lWKKk8gTI+ePWXa8FURpD9Dx/hQoqYjEomvKyPMcSlzWl9?=
 =?us-ascii?Q?Ja5q8YZr9iw/XzDsT7RPOASBPlMOY4ZJbGQe7XtwmhqQVVv6MqPsLRjSLqTq?=
 =?us-ascii?Q?/AO7btMzr5OgDBMIGEZN3qTAER9cbP1SUwWSjfejTXWkjquEUBlR7j3m6YcT?=
 =?us-ascii?Q?HBlgcRSW42MwFz1MvNySUgrrpBaXkJWc6U0P/JD26AqQsCNVfFzbKR6xQU2i?=
 =?us-ascii?Q?/ZianBT4BOb9pMngqvXwC3qLJ/rSH/MPSv3MLFs//algEsH5OlOJx8OvMmjm?=
 =?us-ascii?Q?scOn+jEV3gTHS0nIDo2pNJ3nVwH9zwuNl+rPtjWJ6fAwsNqk9H8MT8CeTUGU?=
 =?us-ascii?Q?K6LIFZNyNKpa/1Y3sLgl8Gh5Ag+TRyrUBenjF/wUFcIWhMimq9LvBAxUPzzi?=
 =?us-ascii?Q?1+ufkDAbPPJ058szSIzAHj2Y3j6QBuobizc2gx9KvT1GNcrF0DfS/vAIoeRP?=
 =?us-ascii?Q?ZyNF1vw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7083FF6DB768743AB742F0DB563A885@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a223e3d-130c-44c9-6089-08d9884b8747
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 22:00:22.1121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6YkSyoAavkZIeiTvlwPCbvFXZEi8f1BeM+sT26sv9GfY1LjnOt5e+1ASPy8JsrHXy6XrtWAyqypEhdE8jPUmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5095
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: q1pMLdnZTmXnEwRLK_09IUXz0tV_lABL
X-Proofpoint-GUID: q1pMLdnZTmXnEwRLK_09IUXz0tV_lABL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_04,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=958
 mlxscore=0 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Oct 4, 2021, at 11:47 PM, andrii.nakryiko@gmail.com wrote:
> 
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> Next patch will need to reuse BTF generation logic, which tests every
> supported BTF kind, for testing btf__add_btf() APIs. So restructure
> existing selftests and make it as a single subtest that uses bulk
> VALIDATE_RAW_BTF() macro for raw BTF dump checking.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

