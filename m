Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25B942332A
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 00:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhJEWGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 18:06:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229974AbhJEWGx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Oct 2021 18:06:53 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Lq1ur010833
        for <bpf@vger.kernel.org>; Tue, 5 Oct 2021 15:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=+ETgKzcGBVg15AL96727Tazmquxe3D/hEYLMG8v2qyI=;
 b=gKKtw9fTj1gsA8nG5d0Crnb1Mx5QNXFSa+ly7AHrGI0bqDbRbLPgIeQ8PhLfV6T5Nq8e
 z8YBB1mIWGfOpiM7MJ0MgYJhuXdXleMJICc6CqBLNs2kvx60YzkRA9poSNmWfeThE2Iu
 l6B3sCq/kwOqMRiRYw3USsjvSgjReXO84AI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bgy06833w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 15:05:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 5 Oct 2021 15:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYHvbwAVqL9LzU4KBz1AxkCdu0FugekDa+leojUDbeJKAIlIZhZCnBOXUrFxn+ka5rcbdO/Hw9H5OEjK/E7cxBjyECGA46dJumNKXzZpJjsycWYh1Yt0UKJagWy/474ESR6d68Ubn5rwYejKeL9NshlK5cf3TZcuYVMzCLI+T0OfL75Re1uPJ7ydVSdv6xF1gv4jyrvxrkS8te02WlUhfMvYhZ84TEVJMniOA8rL4uaMgOgVzgriFo4DMsRrcvnOdQfwaL7pQYi1csxjkM/1QYV0qzTV9boDcelqSXcHXtsBF+7I7O0Ts/8mID/okLnp0Q39mQwbzBT1vf5w6r4uLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ETgKzcGBVg15AL96727Tazmquxe3D/hEYLMG8v2qyI=;
 b=LA2YnfwOVDKtzhQJQd9F6ksq3t3PMEm2SOCe16OMfeTio69RJU1pEu79ZrOtaMatVwH2jDyS0a44+OHvtbOGCBE6pvHGhuxI7Pd5dzN7TriH+54ETYRVSHguOru+6R0IKwRHmlVRAamXkygk5w8bRy9az+0fMZadH6EveCZl0j3spIwIaJSzbyHZzkCelEADgmaJ0x1yU6EaKTqKLtSWvhpducp4xRKlbXNmQS+m9yys0SdyJN94QpqGJxqwOXTHsipkvVWAOwrJVnXhHihS4guqm0A+gBDaDRzjQXilseWj3cFj2gKW0uSnVU3bq610Xp8fk8LXOzO7834I/8DHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5078.namprd15.prod.outlook.com (2603:10b6:806:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 22:05:00 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 22:05:00 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: test new btf__add_btf() API
Thread-Topic: [PATCH bpf-next 3/3] selftests/bpf: test new btf__add_btf() API
Thread-Index: AQHXubUGi4v1ZugHKU23ogC34dkyqKvE9qmA
Date:   Tue, 5 Oct 2021 22:04:59 +0000
Message-ID: <12FA0143-6E11-46D1-ACF3-8206D4925E3E@fb.com>
References: <20211005064703.60785-1-andrii@kernel.org>
 <20211005064703.60785-4-andrii@kernel.org>
In-Reply-To: <20211005064703.60785-4-andrii@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d96cbb44-1dfc-4c43-50f5-08d9884c2ccb
x-ms-traffictypediagnostic: SA1PR15MB5078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5078E650223409B1FED64A86B3AF9@SA1PR15MB5078.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m7ucu0C0hPjqNFDC3C8GSYGRpYlRmGReDpj7+/ZnNIVJ1SSGuKdVXdskbaO03b0YBYzaU5Ra7IRjK5MHNw9PoJohYlkEtnuwadz9smRZMNKGZ/9lOcpLnZ/I2TqyTgUPcE2F6zs2ZVXb/+B+iRdZOpjog6xzVgrrkUrpqp//YMHJU5YWEBgwwOepWyPSmPpy33KdqXcgpuThl1h1sxosxCPDItpNiQhs2HwYCBc7jlqthpOpOPReoquE7dbWemTqOWM9K5uvxTL5BdpeZ1pk7Va/HEhRMO3ZsWQcrPdcw+D/Z5EeueTnEFvyskRLnaINJ+y9GBJDxEdM3h1cNbyIlVExx2sVrd+23kqBprLlJiJNOA5XFLzB7HFqfYqvTxgmIYwtXr7omPHl4vLHvFsPTEaX/rZyMgRmSCMEFASvjlvKdVgsLrjFEtRTB6y0oJIVwB0V18BwvnOgX3ssHRpXokjRcS+6M4C6Itpi2j1wB7ZEEEU8qzwD3AdLheW5D8Uvh/bRjibqYq0xqfO3BhbSkrgdAhZHPKPBKKPB91D7E1eing/o6BiRuknmHHYfYnb4OAmXyxVJlTilRxm5VHI2Yt63rpszKeraRf01DKRYmgdCE7TyG5ye7juhZdpdUkEcz15nXkleIO/hgPOpPGo5pDhL4uy2nxQKDL8hjtAYR81olMpySYpnlDaGqKziTS6u9IuMlOC64KwCteaQkP5mKo+UTGD5TiOIvIT9OWWl1YU5DCRq1j2HFP6U5LxtlI31ldpC/lUug7Pjz3KGVJ1PrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6916009)(53546011)(33656002)(2616005)(71200400001)(2906002)(83380400001)(8936002)(6512007)(86362001)(54906003)(508600001)(91956017)(8676002)(66556008)(38100700002)(122000001)(316002)(66946007)(66446008)(36756003)(76116006)(4326008)(66476007)(5660300002)(6486002)(38070700005)(64756008)(186003)(101420200003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JW5D9F7h3Ai4W1BXfETVfEYsP2LmNAZWWXvg4K7QmZDIP1JEjGWHz03JGm2T?=
 =?us-ascii?Q?WXPhLYzMVKISN8xlAbHNRq/Y1NVK1d87TvoZnKiS3NYDdOmj9t7qO7RPIHRS?=
 =?us-ascii?Q?TTP9ARFdWwkoi4eEnyeys4uv57AsqgqwtmU2i658a8BFLA6p6wWVznHBYBrl?=
 =?us-ascii?Q?QTNnrMx4u6IATKMCPhCVy4JNYY6Hx3uLv2cI8zeciv00LHOvh4oSfdG7XyzS?=
 =?us-ascii?Q?lwoPIYwKCaMi3UaGuxrOHYcBhZ2Ae3xB31oj4eYV1fievG3nHUc6znS5uJ6n?=
 =?us-ascii?Q?iKHE/EMwhbkddCt20NOotb9yOI/Ef9i2TvHyxV4qTf95IjBdeyrgCC9saJ/C?=
 =?us-ascii?Q?oSLQACB3Llg4z6+N3ZpWmUQ+XOo9MdZgI6yaz159k4yh+5081z0vGLrkOssP?=
 =?us-ascii?Q?HnBQPIAs2hCNgKn+dcpzqbVu3NYHxD8AgE3AtDV0pCQxBmzE5gn97rPhTscp?=
 =?us-ascii?Q?WARBcv7A3Egh/gwg1PY4Zel4F7eyEqFBauFpqueyyVsifEBfRjBO/6U44SyG?=
 =?us-ascii?Q?CZ1E/1s3zWzEHzV8EcUElMP8K/tYTDNedFsQel15qyTZC2LVsrxzMZZF6IJE?=
 =?us-ascii?Q?jzMPtCGptbz3rRIMNN8Ex79oZqX1HZhwOVXghC4YTa2U562uKQa10XNcC67g?=
 =?us-ascii?Q?JPx5JBpGn0ttvgfCWaFm8IdElZPDzcajSK7xNTQsMS1D24wsvlNjqAoA7wEq?=
 =?us-ascii?Q?t5lkQyHEbW8YqA6KK7F89n53dBkAxU/kBqncj9OnQnnULSmOcGi7PeLG+yKy?=
 =?us-ascii?Q?nnx7047KkpCh1fc+eUzHnwAmCVAwtsffwL7rGWKcLrC5MsU4MFPrYH2FHgzt?=
 =?us-ascii?Q?wRnaLt7hUNuEmfA+GlWNvV4CecsBjxsh7GQr1ljRmDNMLqkSHJ3SAzr0COKu?=
 =?us-ascii?Q?imwIRC1gtgXLP9eIgXgJ9Nyv13HALjPqQa9xhiEAas6c26yUSBmZ8vcea/Gi?=
 =?us-ascii?Q?zC2RN0K3lXxeNlSoNDmRZeWLaPz2I1NpPAAlSQLbsUotzpM0bfkpjsAneeMI?=
 =?us-ascii?Q?s5IXuIxNJMiyFA9FOEqzvStp0H1KjCFDfYfdLQqgWFoomucxw1ci8Zg/VVel?=
 =?us-ascii?Q?2nCZBplZGh8f+nS37x+YvMi7pPDvSuA1YYdUkNPYjDJrNzXpTm1kMsJQLLr4?=
 =?us-ascii?Q?VwBs7H7+RRbI+L5sAiG1+OAqOm6Nubq8+Int9CU51/c6mZJ/cO+y89rImY14?=
 =?us-ascii?Q?Tunp6qd2OhmsI0G4Sbrt6HLvYUN0sw/e6Je8BHTwFXKqhAMAq6BodA8VOTZG?=
 =?us-ascii?Q?kFwgQDN7oH0ODZ7Rceny2NaBz/+FI1yA2rgAZhmJOkjckL5Ge89MHjs2uHAu?=
 =?us-ascii?Q?9SKb6+UTDuGVPLmA6LlxPeof+GZfDwUGNDAQz3YYaZyM/mHteCpxVDSCTKgK?=
 =?us-ascii?Q?fkOFnww=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44BD86B087102141B440E104923C6BF7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96cbb44-1dfc-4c43-50f5-08d9884c2ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 22:04:59.8257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zBlvxJNLLSdp3nSaqBqUOEISDyOXh+g06ptYJ5Ph0FkI454u5+7320xLGAMa1sRRkiqIuoU6xYk919ksdwyQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5078
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: PAUWYg4BfmgUq-_tP2GLMJC5xqdB5UoY
X-Proofpoint-GUID: PAUWYg4BfmgUq-_tP2GLMJC5xqdB5UoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_04,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=997
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
> Add a test that validates that btf__add_btf() API is correctly copying
> all the types from the source BTF into destination BTF object and
> adjusts type IDs and string offsets properly.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> .../selftests/bpf/prog_tests/btf_write.c      | 86 +++++++++++++++++++
> 1 file changed, 86 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> index aa4505618252..75fd280f75b2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> @@ -342,8 +342,94 @@ static void test_btf_add()
> 	btf__free(btf);
> }
> 
> +static void test_btf_add_btf()
> +{
> +	struct btf *btf1 = NULL, *btf2 = NULL;
> +	int id;
> +
> +	btf1 = btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf1, "btf1"))
> +		return;
> +
> +	btf2 = btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf2, "btf2"))
> +		return;
We need goto cleanup here, no?

Thanks,
Song
