Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5F4943D4
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 00:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344271AbiASXXV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 18:23:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22376 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343864AbiASXXU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 18:23:20 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIs691000584;
        Wed, 19 Jan 2022 15:23:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=XaBzQbarHYbl2mYqszvqLoxuLvidxEk40+Q8uD+Y3gg=;
 b=BDn3E2q7cf7KlS0Jsl16DZfWE1bpUytq7Wu9IxQ3GrcAaR3p89azFoIO7MDQudP1XBHC
 LpdpxoZ9bQzU1k+RKbvPOBNPJLnHiarxYpyACy0eibbrJcpU45TPJ+vEpC/CO7jKSERq
 hfNZYeCs4LstR88ECFWw5zShmyyhZl0c4TQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp89yf788-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Jan 2022 15:23:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 15:23:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggrOqueKYrHjRYZQjaIyVkcBPW8GwyzposgUw7Yl4UD0ck9v4ajWl1/P835oS0twIKqZKF55gWjnpUUdoVmsl0jO/GqcO4NGrcK+GLHCW3zcqbmGvF1HHklu9IZ8hToCoCNRZ4COk4DiOv06PyasJ+qKtFoIZvCYmwSS8aAcgk5SFpeyhI2ywDDSWlNJdBYZZ9nIxxD7gNbHExAvqz9R6OGZpt7a0FR5O9eO//4bfNgh9XKtMLS9F2n94fOuW5spAKGQt90yNCGyYVrq9Mt5/9+JEQUQiCGCnZtXqVVpF3I+iHhQkGyZiXrVmFmtus+YcSDDRog1Eqrz8UfZo4XUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Weyb4u9cnovfrTfwul/0VAIMde8EQIE2fiODIzo8bEw=;
 b=ZLdGPKLYjtIE1o6Pva9wbg+2bJfb9Zs75jp2EgiuVzjnDR2vgD+wXyq3eLR4Bxel5rczglt/n0JlFe5+QxjWIJXNuen43RlMFl+R5UD3pkua3jV/DZp7NgneVG12U9xe3S2DdEjvoPAyU6Wn1IWHnVs5DAsanjmtbtEmllfAwnMdMQwi/1FDS7IKYbEG3c/VM0mhjy0A6IoVKL3MDenQXiXFFo8yflYluhqOXavwTUyvDuqpklSs6/XXwtWPDHinm41JoPDivkPJfhWJbwL/6ajtFQ5ADSLsv0R2deImHDWzun6j3n1Y2h04+qrxLzdxYym5H0X0GqNvh5u8odTxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4187.namprd15.prod.outlook.com (2603:10b6:a03:2e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 23:23:10 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1d7e:c02b:ebe1:bf5e]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1d7e:c02b:ebe1:bf5e%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 23:23:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Christy Lee-Eusman (PL&R)" <christylee@fb.com>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "christyc.y.lee@gmail.com" <christyc.y.lee@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>,
        "wangnan0@huawei.com" <wangnan0@huawei.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
Subject: Re: [PATCH bpf-next v4 2/2] perf: stop using deprecated
 bpf_object__next() API
Thread-Topic: [PATCH bpf-next v4 2/2] perf: stop using deprecated
 bpf_object__next() API
Thread-Index: AQHYDYnOYaiJ2yjqYEmtuYtsxAGl2axq+/cA
Date:   Wed, 19 Jan 2022 23:23:10 +0000
Message-ID: <13ABED53-94DD-4B36-8BB4-776D326E6171@fb.com>
References: <20220119230636.1752684-1-christylee@fb.com>
 <20220119230636.1752684-3-christylee@fb.com>
In-Reply-To: <20220119230636.1752684-3-christylee@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5d21c14-6e54-4ea6-056b-08d9dba2a885
x-ms-traffictypediagnostic: SJ0PR15MB4187:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4187568895D75FEA20172E48B3599@SJ0PR15MB4187.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crKg1bt2b/kasPu5y2y84HD3eqUH656vLokX8fkp2PwqRHUKTjHOftukh0J6eDqM7pqkrSmgv3nM+4hjbPAqBeUka5Lp7Qsr0j3ZTU67qccWeWdEa4VV2ncPxO/l+gNJXtYSbBUMw4J3kNq8YGa+jk6zhh3ArOM9iUIvmvnOvDvgZaE6Op7JOKP6wg2UOoD1l5BwzQWLtQy/MDUy6UHgnzqRJEHIrSealLo27MBeTJvNBZMdsxymlJVSCUs3B7dc3WO4dwwtsC7F3MSnA4qcAd9TFdfOo+6YbEVQgqUl1bTRnan6rIafFLDLrW4DClUmlEO+9FD5u/nhtNSjTiVTdcajXecNMwcvAQOr1DdjTBBEcbYd8JeD/6Qk7ZZeRrjgvdbikXctZ7ZUCwdcYye5L8MrKlWe/0kldX5GF6kjHIqFvLAGkDbTPQGje+Iy7Ey+m3hAEdd/aGf/bK4zs6pPgWXgMskY2rvah0iFQvO1WeNKOsa3OnsLqMEbYekLZrQKR1pcEG1H9ZLlBoTLfJEzgVRWfj2oNkgyfm/RskkgX8TRhs0CkuEvQFw1+3ZoNIRLGJ/81WFEPtglUhiEWyXsFYnLRfQ1XCWDN4r6cgINT4eZX68CIv0iVb9t57GMel1nd8rdHLpHid2L0NgNZlBt4Qzb/lV0g0eiyc1kcWe/Hk6H2rIYpBKN/kfQrsSjrqk/j68PimidHx9FgsZZ2P+h20r2lzBoLp2Qd6PcKPvDJvfE1hJRXGQe6WOhJyz+cqTXrPs8v8pb/Dj5xDMtuh7lVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6862004)(2906002)(6506007)(91956017)(76116006)(86362001)(4326008)(508600001)(83380400001)(186003)(33656002)(8676002)(2616005)(122000001)(66446008)(36756003)(6636002)(66476007)(66556008)(37006003)(64756008)(316002)(66946007)(6512007)(54906003)(38070700005)(53546011)(71200400001)(8936002)(4744005)(6486002)(5660300002)(38100700002)(101420200003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?guePISg3DaY3HvpmvUnjJqEMks0lmk18Iqp+NZYvVkTrJUZpfY0Yi16SPY9M?=
 =?us-ascii?Q?f4s+Ad4KnKSuJ00dEe7V/OiHzX9/0SB8DqjjSvkjDRnH2eXuSZepNHxi/jtG?=
 =?us-ascii?Q?QDmynt3SURIN8AHMvh17QsSAlDogXtXrTv+GV3HxLB7TB4Kvb2ZTiC6nyE2e?=
 =?us-ascii?Q?0sPTdS6WSA/5uLk7A/jo/4mxy1ICng0Gw3+Z7u4VKI02CRH4yvQrHYlU7xTs?=
 =?us-ascii?Q?4GFH/QohOhlKbxkSPOPS50pRzRu9AcGQD/Wi1NYudNJeGdb1yAfMu1HJAMlE?=
 =?us-ascii?Q?UNYcml27u2JXC9vapytRE6P18sgu8/Yith93ns21IhpeSM2T9sH+rKDHDd9c?=
 =?us-ascii?Q?xelSiCv/AxijN6PkorZaZNDMK1AmVa5Rk9vfMLD8hgjAhyMeAB67eRw7NcVK?=
 =?us-ascii?Q?ub5lOuPwhRo5cA9QFULC5glCpXjDBScCzeh/EoAb1jDXhTqdTg8iqsTrqTsa?=
 =?us-ascii?Q?zeDUXj1pHYuRL3AfSsRq0Tiis2C7CSb2YNZuXIlDlv3c4Dx0xsgynrV55VuY?=
 =?us-ascii?Q?MlLiWI0DhdXJoypxtwqXBmaF7jY11Ll8YrTz1x5wWVqw4jb6cVjljw5OmYug?=
 =?us-ascii?Q?ymiUIswKnsjWzcQdw3RV5mE7IchnRJ6yB2YNXyOjDFJ9IMx/SQZyZTv3nZUq?=
 =?us-ascii?Q?mAWSZidF6HKiJnS4u411kYIn66vYMnbon9In2dTe9kCEPBenGkO7HZrYVbmJ?=
 =?us-ascii?Q?Zi632/lcpkpH0tYzLBUx3g6M0WtITzfk2mTTgFhDqjbLYFa8oYizSvwl5/ta?=
 =?us-ascii?Q?kW8jsdOSdr3Uyhw+57wr4wEzPJqrbZJ7vCcV9k8Lz5mAk5pQswDYXd0WH7Oy?=
 =?us-ascii?Q?6MbOBA/BI6edYDHLr/URGmG3ioGxHrwmhJkAhBD12FbFL7RsMUIlgOwT821A?=
 =?us-ascii?Q?XlSkTVksNqnEhlXDNvpyrvEXa1cFojgXsyQh4b+V5zQzDa4UpLCIPH88LOFk?=
 =?us-ascii?Q?bd5vAm7H7L8DWuGX4qg8BNa2+rhGHyW0ixiFkk/tGKA4qFhx9v7wUzsmuJ/q?=
 =?us-ascii?Q?N5ieqhxNOyOlGg13hd06aJ6xUj6LoepDy0u6D0YI8SpeKIimGGuQrkr9q4Al?=
 =?us-ascii?Q?PIxn5/+nYOv7Qi/GXKcYoa3UFqhfXIlhH2p0Pr+1gU5zkddWGaDEQKMCfemj?=
 =?us-ascii?Q?myq4mepEvIZBlTFsDOj0AIIkTCj4foXDY2z0hAQifS2rKm9xS+fQGROHuJK6?=
 =?us-ascii?Q?9TwWzkG7YtxyQUjyZ9fpDGDAE3fHaY/q19IOSPkK3CitdW/Hnvn3tqo2jzSQ?=
 =?us-ascii?Q?6zKNj5tLI8m7CmzY4ykbPygxyaMmtWX8f7OB0y1WZoefUdsfO3dmE0pS5DZs?=
 =?us-ascii?Q?8T3q/G0eUetdaHOJYFJWXH1aM3tVb4T9MuhBIox3GRpr9iRUltANqG40/7Mu?=
 =?us-ascii?Q?EIQc5jP/hnSKANwBBCTYOI8ZZXLGXsOUqKBHlXXXao0WuNOw0kbJgBbNvf4s?=
 =?us-ascii?Q?Rn3+3tp8dFh0cceQZqeUaiATH/YT/bB9uAIdVEMw4swu/soKlvt58pU6Wjcd?=
 =?us-ascii?Q?aivVxNf6VQ52omW/z3xwSr8vCiht8q3Q8IYEY0XQJIGdvr8I8eHuklCXq5Bq?=
 =?us-ascii?Q?VwhaanV1x/B0g/K201dpX0B6DxSc2QwXVNQrVgSvsUm3oGHUUe2rAuEyMEec?=
 =?us-ascii?Q?/3ZX42Nr72lUz0Z1RWVFDO7uCM0C1SIyO/wINV88a7N9HXnUNHlrt0dfAq0o?=
 =?us-ascii?Q?opWf4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCD3088DDDA75A4B82452057458D66E7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d21c14-6e54-4ea6-056b-08d9dba2a885
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 23:23:10.7017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aZcR2nMWtEV5LVeTpiFVQ/sT9citeKmsVIm01iDcX4w3yCUoP45WXyY1n7lP7gFSRgoVf4MvSowMHNJWLwS2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4187
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 0yOSZ339n3-lUm8ThLuQC6JYpQVqESDc
X-Proofpoint-GUID: 0yOSZ339n3-lUm8ThLuQC6JYpQVqESDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201190123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jan 19, 2022, at 3:06 PM, Christy Lee <christylee@fb.com> wrote:
> 

[...]

> $ sudo -i
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.018 MB perf.data ]
> perf_bpf_probe:probe_point
> perf_bpf_probe:probe_point: type: 2, size: 128, config: 0x8e9, \
> { sample_period, sample_freq }: 1, \
> sample_type: IP|TID|TIME|CPU|PERIOD|RAW, read_format: ID, disabled: 1, \
> inherit: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, \
> sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, \
> bpf_event: 1
> 
> ---------------------------------------------------
> 
> Signed-off-by: Christy Lee <christylee@fb.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

[...]
