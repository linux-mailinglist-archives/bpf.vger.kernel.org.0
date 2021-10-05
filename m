Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997C3423319
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 23:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhJEV5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 17:57:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233216AbhJEV5G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Oct 2021 17:57:06 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195IvCUA024318
        for <bpf@vger.kernel.org>; Tue, 5 Oct 2021 14:55:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=xu801LCCGbMZrJoDc2D+raM38ITw50H2RJwFDsuPQvw=;
 b=nXD0hyr0/CXNwntypZeeD6gNxtRs/GJpwaI7YY4smg+fo4RW2Nup61jKvHmX2U/1wIrf
 vG+26lvQLgVcZBKStf42LAgS19mUrz4KjGytYsQoe3leB5cSJw/Hqb8WyLN04H10VuK3
 mP4tswOLPgMVjsI10ts+ocO/4QtAkv6Dm0I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bgrhykk9w-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 14:55:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 5 Oct 2021 14:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeqfragRB68zbO4WLx+8O4SNxAX6ZpYX2PEmlzQB90knFj2Bu3Lne/mWAZ88daRyyLMwVjtLG9TYFCsUkoWielnIhx9kQDsziZh2m6Si3sLXWUHb9Ckb4L3tZIpSb/WV0xYAMrE1VYIcQUDa9F/G2VAwFSXZHr+P5YhtuPOKZ7Ea1byzaldKfExrmUUz+ksBejqPDrS/ByGSFaSxRCwKWA+NFahVwG6rmjKFrjqpTI1F4GTEUeQmIzBak90OcgWuSOIABM5xoO+ek6Zo383/X9FB63UxU6yVYqpvX8FRnqC7hNdppm2E3JgdZTHAwbkfANN4E/AZEt8NUGvfPQIUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu801LCCGbMZrJoDc2D+raM38ITw50H2RJwFDsuPQvw=;
 b=daHffqZkQ+F4xh2q8QRTbuQz1u7AWPJHZViRbalGBt3OsaxdRpsOWcGIKR6X3cT2RK0UnB+t21KBwbh/aEupuma3n9mT3MDBXPfo4dHB/E8QVOTL/z/zNu6Ld2e2HAgvP+nyuMoWjsdvbow55azd0z/PCJSf9Eieg9FiYkp5qQv0+vS2EGFP2jK4tR7JtgRfCUzc/AjsdnZ6+d3ImqpJtG76yencwj/R8rQlI+1dhxqRYPMF3NLOhG8kD4caK8oLvIX9S13jXPm9ByXVN/q9W+4k3z3sjFBbXXk0uMe/aqC2WtY2Oj2+lqi4dxhaT0bXOhZ6DjNJmCDACVy3634QlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5077.namprd15.prod.outlook.com (2603:10b6:806:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 21:55:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 21:55:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] libbpf: add API that copies all BTF types
 from one BTF object to another
Thread-Topic: [PATCH bpf-next 1/3] libbpf: add API that copies all BTF types
 from one BTF object to another
Thread-Index: AQHXubTYy0//ay6mmE+2ylmtduRk8qvE8+WA
Date:   Tue, 5 Oct 2021 21:55:05 +0000
Message-ID: <9E7457CE-5CA2-474F-AAB9-AF3B9484907A@fb.com>
References: <20211005064703.60785-1-andrii@kernel.org>
 <20211005064703.60785-2-andrii@kernel.org>
In-Reply-To: <20211005064703.60785-2-andrii@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6362633e-e0e4-4a35-51e2-08d9884aca9a
x-ms-traffictypediagnostic: SA1PR15MB5077:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB50771C256BF1B82F42852DA3B3AF9@SA1PR15MB5077.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJpk+hZe1u7EGqLd7rLk3g8TBNqnKJi4nnQ0YEr3zI4uszBbn/bW+801WByipunIgpCbjJV5er4ApjSXhaBiTGL4pUUSMyRYZERwOe/2yVx5jNrP0NF633mz5b2UJ/PpwxiOkpsTjSjnJqLfciwc9Iw6N9nCE8r7TKr2lMYwSt4S1xxUxWaZbN+VxSYSKOpehcx0p1MqLl3aWZrps0dlVqOabVZDFxczw+XTW6IxVDXhILpLnazpqkj6lv/WOUNbR/dZz8O6/H1FbzkV4je80bXaxyRAFxVXhXvN7lS+HQ5u1R49IxW5prZwvkKmC2hOHgpv5wHUWc6oAE275TcJvDdgfrpxSwr8VK2vXgQKzLTxBLDeSNHdNiPFhXwSRQG8Q6fp5+s0esfS+1q0cpucB/S6jR/l9CvYT62S7pJTMUYM2GURMCZ4HVxs15lle8AU9wTYhXgLSdl0SVrHqDyUPJ5aPvdSPEHycxuDlTx6j3s8z3F9JvTyoBVoNTd2de7l/VY2osiC3YhYff1fhf+U3E7PCw3iMg8yw/prRql3mYFm3i5UxoKc8zigUB5LD5kbpyZI3iGE/3/nD9pfuw1db4dxFUJYrOcjwU0WXACUr0j2beee2PLQ8iLaww9ue1qTG7/ZjHfPsF5z36xjUyS/uJ8OyKocTp4u2s3nkBHISTZyl2bUJHsNaZKAIUFZNqSsba9vAEZsi8QjV9/zpYiMUFf0TnyIYNP85MyZNcngKTmkb6LzQ2TyWdPrbgLKDI8Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(33656002)(64756008)(66476007)(2616005)(71200400001)(86362001)(66556008)(6486002)(508600001)(91956017)(122000001)(66946007)(4326008)(8936002)(66446008)(76116006)(54906003)(5660300002)(38070700005)(6512007)(2906002)(53546011)(6506007)(316002)(186003)(36756003)(8676002)(83380400001)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B6GqZ+BDQqOf9R4gVLqaxaqCTmZQVplkj8DF27wbc0g0bsq/6BPcGhnzsLva?=
 =?us-ascii?Q?+/13lP+xeRDj6jK26LOSyUm5iTLeBeTZJEBDyT005Ry9kt+/YWRY1XFIud4w?=
 =?us-ascii?Q?+TXspYQbuG8xvh6aMv4i3nVkVhqDmKrHRwrDr4lAaYER55S1a76TKAs9929v?=
 =?us-ascii?Q?w5bgxkjaBLCtdqAj6acizSgXtU1PO6AeM5nlTtcWnEwC+DtJ3tTPCDd2aQoV?=
 =?us-ascii?Q?KTe7yE2BXplCTfxlMJ3WKhlbEb+jF561TvW+EtnoB0L25jnh+8ZmP6zNBGsx?=
 =?us-ascii?Q?3wByopEgGTfwRqnGp7O+pVmqlVxR3pbVSXVd2ReNuYbAPRaZm7Qlj+f077BB?=
 =?us-ascii?Q?MHsB0I1t42feji5gz4ZSjIA6K4umK/1CpFW4IQ3bW+tQwlYHkheihQ0UpHZ0?=
 =?us-ascii?Q?3qvejstzhIvNM2aRlImNDWNE0VLo6BTQ20QMfJtxTvyCilAA+IRiGh7tnMJh?=
 =?us-ascii?Q?5Snu2SI71kXnJDR949d9v0owFZvp0vy9pSwkn2ppps2EAmkkAlqsysDbXhb+?=
 =?us-ascii?Q?7awOQVtLYXgiR6kw0hKLMdFP3ZALYWO7IhtVGG3e7p5PUjQVVaRfRiSEYCL6?=
 =?us-ascii?Q?Bil5ufF4YnS5IiTqtr4Y/rNDFX9mU3vbQOMN/4NkuuQq1Bb3NhimQ/+TAKKd?=
 =?us-ascii?Q?gfwsruzeQCs88OvdtLdWNY9ykiWSTe7YGFzIPQ3g18+ZUvo8NxjDGx5eLYsW?=
 =?us-ascii?Q?T3Kc3XcZBKUJmW0NKnyBMQ/CdqbCRtiyYLvi/kitVv4WiCKC/4jcRuZ7aiWJ?=
 =?us-ascii?Q?/FR42Ayfc+mVvAL+UV5Z4eBugQAWYML0qbEJH0Ue8SQnY7AID0sCDH3jDxcF?=
 =?us-ascii?Q?8lXQhGwh+M75QTvOlIXmilyRK/WgtRYHDt+lfD6tTtR3KLD3yZp9CQqFQ3RX?=
 =?us-ascii?Q?3iKuS5W9JNURyGOt/4+aXsx/KjeJepfci+N+A2mBkIRtB3Lsvas7ypSmRsTw?=
 =?us-ascii?Q?p93URmsjHwuBOFxA+FE0O5lGQ4c4RnNJ8n1ZSPcUNrCZkw35sYLwVbekbMsm?=
 =?us-ascii?Q?kiJOGAfUdIjadQj66iknZ+tECj/CaxbhPU5DIncK3eNGhICJdJkD+jiAf/k9?=
 =?us-ascii?Q?BTGDc5XbTgUQGOaf4Md1hoffG6I/WWZnGLtD7KpU4nzHx1edVCNddWrW8hWY?=
 =?us-ascii?Q?GBoXKxP4o8hd6lnIJj3A89S606rT7S2DVcH4ufeupr8PXx3fLlh+Al0ja7tg?=
 =?us-ascii?Q?S4Or3HzUP9AhO8Y8UTWJw2LS1Gr9JA7U9BZoxjp8ADapvwVfcOlhClx3t1E/?=
 =?us-ascii?Q?qG8ZUoka5cI9oIB032ih47r3OCk+1eiD2jWJgdkspfQOnNAMpOODVoDak5Rm?=
 =?us-ascii?Q?5Q0jzKZBOQmhkytY77ELJ9sTSlqEeCtfSrKeDnSJs2nKmbADL7ItLaYb1J7N?=
 =?us-ascii?Q?qAqHAd4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <016928C74DDFFC459B40BF6218B609B6@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6362633e-e0e4-4a35-51e2-08d9884aca9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 21:55:05.6031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzexCXb9Z5bFLZ3lBh3cJHQPbpCnMXYnR8T4WjHLuwa4yR53q7kTzJdAUsLG3Vu73OhPm/rIrxknnwU8787cig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5077
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: aKS8Cj7lirfzSRf28Joy8bjs-465wYrc
X-Proofpoint-ORIG-GUID: aKS8Cj7lirfzSRf28Joy8bjs-465wYrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_04,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Oct 4, 2021, at 11:47 PM, andrii.nakryiko@gmail.com wrote:
> 
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> Add a bulk copying api, btf__add_btf(), that speeds up and simplifies
> appending entire contents of one BTF object to another one, taking care
> of copying BTF type data, adjusting resulting BTF type IDs according to
> their new locations in the destination BTF object, as well as copying
> and deduplicating all the referenced strings and updating all the string
> offsets in new BTF types as appropriate.
> 
> This API is intended to be used from tools that are generating and
> otherwise manipulating BTFs generically, such as pahole. In pahole's
> case, this API is useful for speeding up parallelized BTF encoding, as
> it allows pahole to offload all the intricacies of BTF type copying to
> libbpf and handle the parallelization aspects of the process.
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>  

with on typo below. 

> ---
> tools/lib/bpf/btf.c      | 114 ++++++++++++++++++++++++++++++++++++++-
> tools/lib/bpf/btf.h      |  22 ++++++++
> tools/lib/bpf/libbpf.map |   1 +
> 3 files changed, 135 insertions(+), 2 deletions(-)
[...]

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 2cfe31327920..823e7067d34e 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -173,6 +173,28 @@ LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
> LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
> LIBBPF_API int btf__add_type(struct btf *btf, const struct btf *src_btf,
> 			     const struct btf_type *src_type);
> +/**
> + * @brief **btf__add_btf()** appends all the BTF types from *src_btf* into *btf*
> + * @param btf BTF object which all the BTF types and strings are added to
> + * @param src_btf BTF object which all BTF types and referenced strings are copied from
> + * @return BTF type ID of the first appended BTF type, or negative error code
> + *
> + * **btf__add_btf()** can be used to simply and efficiently append the entire
> + * contents of one BTF object to another one. All the BTF type data is copied
> + * over, all referenced type IDs are adjusted by adding a necessary ID offset.
> + * Only strings referenced from BTF types are copied over and deduplicated, so
> + * if there were some unused strings in *src_btf*, those won't be copied over,
> + * which is consistent with the general string deduplication semantics of BTF
> + * writing APIs.
> + *
> + * If any error is encountered during this process, the contents of *btf* is
> + * left intact, which means that **btf__add_btf()** follows the transactional
> + * semantics and the operation as a whole is all-or-nothing.
> + *
> + * *src_btf* has to be non-split BTF, as of now copying types from split BTF
> + * is not supported and will result in -OPNOTSUP error code returned.
                                         ^^^ typo: -ENOTSUP
> 
> + */
> +LIBBPF_API int btf__add_btf(struct btf *btf, const struct btf *src_btf);
> 
> LIBBPF_API int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding);
> LIBBPF_API int btf__add_float(struct btf *btf, const char *name, size_t byte_sz);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 9e649cf9e771..f6b0db1e8c8b 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -389,5 +389,6 @@ LIBBPF_0.5.0 {
> 
> LIBBPF_0.6.0 {
> 	global:
> +		btf__add_btf;
> 		btf__add_tag;
> } LIBBPF_0.5.0;
> -- 
> 2.30.2
> 

