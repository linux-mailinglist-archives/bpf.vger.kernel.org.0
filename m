Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D45E494278
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 22:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiASVZd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 16:25:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11996 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbiASVZc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 16:25:32 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIrojJ029330;
        Wed, 19 Jan 2022 13:25:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=mStf2XUsx7BlzOi1gfzAiyNxo+KWjBOZA+82XKMAzAU=;
 b=OR5h0RutRZbajBCk87Ioh/NzFs9n8UtRSYiwt/8TnwN3tGIEZB9vEmuVlojpYAUAdOXD
 za6iG4GnshElVQpLqed+JySc1IGh0rToQN4pVm8EyAGnKWH2wvMFxl5KplJQt6/thvlJ
 +gNrbMClzR5ksKTjHN4xoNBCAQJqP2V4dcE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dnw1guecf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Jan 2022 13:25:31 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 13:25:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnOrtdeaOplqKwb17uw4atv7V80YYDLb07U6nNxcqQpILZXohJXf4pY7trWFllsUVepSRLUM0OCCY/cR3XWJuJQsVJ8Cs/tuA78ON6OMQdWi4TPBiotP5A9trP07yKHvqGGtyuiJbaN87MwzYkqGZ6TzWmzaes8pOSNCyaaHAUmPJYw54aUhfqvJX9fUHph+KGPWMFelMAhWQ8SzScaJTPOhNRY/R/YpXrkids3VNItuKDZWccL5v0gJqi8U2nuNipfxF8cTfz/Tp6YY2CRmzlL2ZvTpebw53pYtQ0Wzduu0K7f+Sd1tYnvfwaUNBRf8h0Xs+tfec816ue8axAyJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mStf2XUsx7BlzOi1gfzAiyNxo+KWjBOZA+82XKMAzAU=;
 b=cr43gpPZSNjA4pTU2eonUpNdNEk8BQN4xHGI44fN0fmEFysK/UeIh3z0fGhohug3WqmB57oZz5osI9N2tyRnsZ3R9PIk5w93YqB+vLW7qoWvXdoV8oQhknh+6EnpCG7SiUuFoGsZGqWFK24ts4yBu9+LBaZ7neuACTCsRrE6rMzzSwPyzFZBOWduVtvr5v2fVrfr/eVvEaeod5fXhVcWoqap0FwNjrMsf7CjPRUGiu9MXu0UrT9+VgrBgf7Ltc8dXL/wOUUGqZBgRJKyv2X1vZ8k7RZhIyAx6xHbcidzklB52igDhEyUOjjxikiXGPddlxQP+H35KeEvB3sGbdXXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4902.namprd15.prod.outlook.com (2603:10b6:806:1d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 21:25:28 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1d7e:c02b:ebe1:bf5e]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1d7e:c02b:ebe1:bf5e%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 21:25:28 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Christy Lee-Eusman (PL&R)" <christylee@fb.com>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "christyc.y.lee@gmail.com" <christyc.y.lee@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>,
        "wangnan0@huawei.com" <wangnan0@huawei.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
Subject: Re: [PATCH bpf-next v3 1/2] perf: stop using deprecated
 bpf_prog_load() API
Thread-Topic: [PATCH bpf-next v3 1/2] perf: stop using deprecated
 bpf_prog_load() API
Thread-Index: AQHYDV72LXEnvfTaSEqw1WDF6YXfTqxq22oA
Date:   Wed, 19 Jan 2022 21:25:28 +0000
Message-ID: <66C221AA-D79F-4880-90BF-53140C6E33C6@fb.com>
References: <20220119180023.835496-1-christylee@fb.com>
 <20220119180023.835496-2-christylee@fb.com>
In-Reply-To: <20220119180023.835496-2-christylee@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f49a46b4-d182-4ffa-51cf-08d9db92372b
x-ms-traffictypediagnostic: SA1PR15MB4902:EE_
x-microsoft-antispam-prvs: <SA1PR15MB4902A90E668010EF7DA1FD2CB3599@SA1PR15MB4902.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTWkj08JV2yH1k/pShkfztBTJHjgiABU5zo1xxOMqmLr5RUc68GeCBfwLJ3JgfS0mMtPJl4pxdVe9e17TNmfYO2jvg9rWmeK8+KvUmC/jQGtoGzH/7G7I2HkbLUph0p00VbCncTlyiJ8PLR+XVbQ8PkeCRrbfiDV4MinjD4K3QOa1ZeembOx0KHaJ3b6CRPB8tItP0xsEjjeaDtxW85NpJtw/Rxuud0na41l3UVg1k5TVxC8IUmgIzySy2XS5MMgkkdWYlReuB5vQDWQv2kgiLVZgVaAzxxRB7vXoOCEDtdeLIYQQjPuPGNysHbkNIX8ouAw207Y7XlGHmEobKyuAN3ZlrNXpTOCrXzyzdeRAqTJWxznl3UiCAbftLapucTv23CMO4rCRe614AMG0A7pEGaBcnnUwnUWLMYdqFPoLlvDk7vdVPSIw4SJxt/tanl2B6zTllmH+JMJHtuKu8tWhNr2EMKItwywAFExa1+MxM0g/681x1z6OAI/Rm9y9vnTXQ2AzaA2TXJaYu6j8FmPTpIB6XnogQ2MmbLOlWOUakQgEsyPjfQ6NHPqmJWFdcEIbHOyzPlxaAtLM78o7f8XvAvzaR6t0dMW++xiPF1vu64JUcQ2OXNAYCrSp/2KlLpIAWuh1Dr6e043PPc4LSHFpcEWUZc64z+oGQ30Hug0M4tzPUFcAF47yf9q3/AgjjLvS3kERAS77hsGHMXxts/p8bVZGndC3+fNWdhUwfwhWYzhv8RW9bMIDhSHzop9DrEL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6636002)(186003)(8936002)(53546011)(122000001)(6486002)(33656002)(71200400001)(38100700002)(86362001)(508600001)(5660300002)(6862004)(36756003)(38070700005)(8676002)(91956017)(6512007)(83380400001)(76116006)(66946007)(54906003)(4326008)(66556008)(37006003)(66446008)(64756008)(2906002)(316002)(66476007)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/DrVAPs/EWLIjj0WMBXLUp8Z+rqrwZ4mAgeLuwEhZxD1HFd2HJcMMAu3IdNg?=
 =?us-ascii?Q?iU8kXhDKbXqxUFa7BZGDmUOQSM2XsmRo4nb3MfTcFcV7sQXbgE9QsgmUF9GU?=
 =?us-ascii?Q?DdLZlgm8HpJZJIuc9RDCMykZxB+mUEh6E9WAhS6/1rOeXJ6Nmf5sIxen4z+O?=
 =?us-ascii?Q?9E1lWq/OigobHsdB/l0fXsYcfAmxRnOWTRO0Flh8GZE/AmUtDtocegML5euW?=
 =?us-ascii?Q?v3/P7BKr2JL0CIBLQN0xHKmtu+b1ZQymHXD5Pq2edIzzkf1a/wrOpGQ1R+ZK?=
 =?us-ascii?Q?FdypOjjTrMzH86G1wzancmKpHVS4uebmMdEneRyk4U9eaTB1hWM51z/IjgJ0?=
 =?us-ascii?Q?gPQLWX5tjTEsGPv00hUcAVccTFd11Jbev61qIHA6Vmzb37TWoe5j9/wQWLKp?=
 =?us-ascii?Q?/cDZ4IPuEHN4m+bMbY+TS+mQds7oUn6EdoD0ICjOgDPRc4esEA2rq0UEut0q?=
 =?us-ascii?Q?Odf+mTJqXVuKaAlxXH6gfO0JYywNQ74Sb8oRP10idDSLLNMkL4XTZBBPqIQ9?=
 =?us-ascii?Q?WQMrExtF0JXgkdD9HMU6UQUUK6WL3QTN9ZQNg2VC5fhaZ2VZih72rUzXhCAO?=
 =?us-ascii?Q?D1/3dvqQ8+rmEfOogFeWuPQQWYG0Oaivgd9lUeRIdAy+zBvtTvSMmlCSzMhI?=
 =?us-ascii?Q?a8ezTW1J5J8NXGWLMPsyfGRNlYUVnE3GcjjchFwlC8+4GrPVncx7L9He6p7o?=
 =?us-ascii?Q?k8OCWkdVHxyCCcQtIZI8ysi/TiKiSbKR9sHQgawn3UVN8doGp03nZ4ar7IZ8?=
 =?us-ascii?Q?pYwd+UdVM3aAg+umakBJPkRwdoIbtADlTh939S0jau373MWFurpcblRwqHDM?=
 =?us-ascii?Q?qxWf7J9r8ZE7y+1/eqZVOE1U/XBzJUUUC1n/izNxBOUaTRQwZkhRCCdTqqUx?=
 =?us-ascii?Q?QOeXZfJ2ysfVrDYyEqNQnJ+sdY2Oac0/OB+4vxA5oM4jMc4c6HRzawdDxohH?=
 =?us-ascii?Q?XVtYOkIBXppRO6gPDh68czZYEuWrtAM/XBO6ugSeejn4gjtPvVVhfwsGz0mp?=
 =?us-ascii?Q?HDKbnbXzMGBnt2oki+zD8j2xd3wVREaIZpw1tKX7UcB5ZzRxJ7jtTKGBHuaK?=
 =?us-ascii?Q?D3kT145OMIVQEhabRh3a8A7t2mFSCTl5wTXN1I6WNuSe1QHbcd4IMT3FsFDC?=
 =?us-ascii?Q?Pojjg3HkNhiNFBBYRtr5jh1xp7zLS3TN+h/JRcNCT+sJS+kj6lH5UamgrTjX?=
 =?us-ascii?Q?UC0yTaAe1q/zguVGde0SPWoVx5APwLK+zddOhpCe/qAEMUqv0hGId79Wm2RY?=
 =?us-ascii?Q?ADT7EUidbbYSX38Xr7n9zVc7fleZ+gvD+QVf8bRvDqCFeslKhiGanIXDTDGG?=
 =?us-ascii?Q?plzpphnV8rnJJ36rCAin6lPOn/JQx20bZZoJuTsMWOOSuojzQPNrrFJesx9m?=
 =?us-ascii?Q?a2vFX8JhZ5l6swPkwKMM5JSEMTsiMw39h1wGwjjgt2E3T2DeiNyVw2gMW21x?=
 =?us-ascii?Q?holtLfgJ5kVM9J2+irZkv9EDAUxmFqwTktH+Vp8YfekLn2gcnSLEfxh5WQqS?=
 =?us-ascii?Q?aV+yjq7Of8lOyvPxEcf3Dff1+FGZgztNHoZizSH58RXcBNG3b4ZhBDNCeqEA?=
 =?us-ascii?Q?cW0bPm56RCaGptAaKYJMnxm1E38iNKs5G/R5FSaTklmaoX9Hu1EVAOg4fKF9?=
 =?us-ascii?Q?XRUzb4hggqkfJ6vA3/e+tBLzFQnppjvOe3ja6rcc1Nq4Pg8ciXcv6f2/vApr?=
 =?us-ascii?Q?qZJa9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5C1C35FCE5F884A84618B8451DE29AF@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49a46b4-d182-4ffa-51cf-08d9db92372b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 21:25:28.6304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnYHYDhUuTgX1278bl5DHVxWJdmoovncyA6ZmOsAOVVTuOkyl9AjCuc8AcccifI+m8ROZ5GslbNSJmuQEi1Zuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4902
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: AYDYaJKf2xeeclnmDbixxaG6TjKx7aKj
X-Proofpoint-ORIG-GUID: AYDYaJKf2xeeclnmDbixxaG6TjKx7aKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_11,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jan 19, 2022, at 10:00 AM, Christy Lee <christylee@fb.com> wrote:
> 
> bpf_prog_load() API is deprecated, remove perf's usage of the deprecated
> function.

I think this should be "bpf_load_program() API is deprecated"? Same for 
the subject. 

Thanks,
Song


> 
> Signed-off-by: Christy Lee <christylee@fb.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> tools/perf/tests/bpf.c | 14 ++++----------
> 1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 573490530194..57b9591f7cbb 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -281,8 +281,8 @@ static int __test__bpf(int idx)
> 
> static int check_env(void)
> {
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> 	int err;
> -	unsigned int kver_int;
> 	char license[] = "GPL";
> 
> 	struct bpf_insn insns[] = {
> @@ -290,19 +290,13 @@ static int check_env(void)
> 		BPF_EXIT_INSN(),
> 	};
> 
> -	err = fetch_kernel_version(&kver_int, NULL, 0);
> +	err = fetch_kernel_version(&opts.kern_version, NULL, 0);
> 	if (err) {
> 		pr_debug("Unable to get kernel version\n");
> 		return err;
> 	}
> -
> -/* temporarily disable libbpf deprecation warnings */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> -	err = bpf_load_program(BPF_PROG_TYPE_KPROBE, insns,
> -			       ARRAY_SIZE(insns),
> -			       license, kver_int, NULL, 0);
> -#pragma GCC diagnostic pop
> +	err = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, license, insns,
> +			    ARRAY_SIZE(insns), &opts);
> 	if (err < 0) {
> 		pr_err("Missing basic BPF support, skip this test: %s\n",
> 		       strerror(errno));
> -- 
> 2.30.2
> 

