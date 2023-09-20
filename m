Return-Path: <bpf+bounces-10457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA6D7A8910
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19B2281C0D
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3533C6A5;
	Wed, 20 Sep 2023 15:56:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459B1428E
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 15:56:41 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1FAD3
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:56:39 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KERBfc012334
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:56:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=uxuTxz9iA1Il5+mbSea8ZcEXPlaphNAVT2cJ/nqeHYI=;
 b=eSFlZ265NsHl6R6+W4/4qL9UZkee8Q4FqiU7GyYnRH8s1adlXSww4mZPj13drA733hoM
 K2wu6LZ0VmsaErFrfIzcwxHxF53raKemkvcHbDEri575mItbs62ECVBfPr3D2oQ7ohQY
 0yC5wSOgDr0CJTTrpFmB2Lviw32i/v9iq5R1RSEsUDqiZNB+n23QjnGin7GeB42KwMYx
 oZEsVNJ8/g2mk/lLvwWBZ1WV0on+lH8r8g8FcWmjh4cievQjVAdQHDmY8yuV0P2NG/tq
 Amd1XohhIUJzTuNi1RVQoeMAMMfEG3DUZZThzcl4u9KsCmJU04V/IgHpuitgxtq32+RP ow== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t82gx2pes-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 08:56:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdr1Mg3VOvtb80Pf93WioRqPzYbC2Ol+ZZG53O/0gAuIhqSd4CNDenNtfXBP+IbpGMHFzRbBjhshNF28y5ntQ2y/wvWBe5g68KfUtFZxnpoHE/XQ3NWVGkeq9C+Wj/JDHQbwt8SCFIvW+Di++RwpIgH13TjEu1429LNrWLBgbnxnUgX/4troQJ+Q4aj4x/uCZ2iNdtl9bCchzi2wMgurvDs5MGuErDqs8wao0c3XnTO5pOmgm3Vz28Iim37hJVs9Ebf65GRO2TGe7pbQ3Z5Oit6yS/TXfVmHL4kZq0sFBuJoTewnN9TeAFNryZByfqHrvScALfp3SHxVtQUfxeGmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxuTxz9iA1Il5+mbSea8ZcEXPlaphNAVT2cJ/nqeHYI=;
 b=R9ABCVwcZLRIhm2tb7W6Ory5Izc4+TCGT9sFDzhNqexWI8En4O2auJ7uZ0d7yGxqm6hgs+dOdDerfct7+TjImLQWvPJd0Ed8OVOgA/fnlB19VmGDgkpY7MyCwnRwnO6jdaRPBlRq3zv9kXzHIfi81ig29WitPksx3oOrmk3Ctlf4mXiRtYg076p1i9sqXVt80350A3EGjKUhTolrj9l9Zu1IXNCC6oBWK0tuTkEZ5aBVala1HCPBjZMFKFQRBN71ir7p1Ub8ZXheaYHSq2z2W1/WYZ1Ib2FYTsnxcN6mD87tLwycdLAvqaXVkxOtnWxJGfuljOMIndOEsppWLOj/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5299.namprd15.prod.outlook.com (2603:10b6:806:237::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 15:56:35 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::57f2:86c6:1115:ad7d]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::57f2:86c6:1115:ad7d%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 15:56:35 +0000
From: Song Liu <songliubraving@meta.com>
To: Xu Kuohai <xukuohai@huawei.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 6/8] bpf: Add arch_bpf_trampoline_size()
Thread-Topic: [PATCH bpf-next 6/8] bpf: Add arch_bpf_trampoline_size()
Thread-Index: AQHZ64PZyi+wZEZ8l0y0stZ0Ni9JDLAjVCWAgACK1gA=
Date: Wed, 20 Sep 2023 15:56:35 +0000
Message-ID: <A993D9A2-C4FE-4124-B989-CE5AA4881724@fb.com>
References: <20230920053158.3175043-1-song@kernel.org>
 <20230920053158.3175043-7-song@kernel.org>
 <61918273-1bec-d45c-09de-8fd76dec9620@huawei.com>
In-Reply-To: <61918273-1bec-d45c-09de-8fd76dec9620@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB5299:EE_
x-ms-office365-filtering-correlation-id: 2f09272b-d704-40e3-a8a0-08dbb9f22ae5
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o8cHVV9C/Xcl1rGBVkHWS7PBng4PKj/2S24UzpwTgMl0bo0n55Zg56ovqJbEJcYGdbYRfhQlkT7VSNauzsBNtzW+JY1Mr+Pbsbo333BWWomExrT7jAgGvRTZlfyevC0rS0srWq1UWP7L0Oi7RSu+wvaPOk4Du8XBVFRGBSh+IYFpzSJMLq/YpoT3AhGy4X1xK+7sL5LfdZCYpTQa6vbm57qca/qYRXmi2SJsmZbgdxYlvyGvH+5JfWFZz6anhGRPmUJaHq+wIq05T7NmvBZwHvdZrgjBAJf9NShNr0IGpW2uwT10Wm6SETFpgdOPeIFht2lFIu7TKTgyvHHhyw3zBvNkVNc3D1pBfP/BHZX5uN8QcrZ+3kzGoT1ghsg7ubBCGnbeEYE3OvfL2smoGyCh+QdNEsDTKekCQFMso5UQDOfD+Zl7VrdD30MuIdOrVpi1k4QLp8bomHv+6X8T2QF++9Bfqej2T3RI3pwm9c4jXUH+zd+O1ZMoFvFtQapjWBCG5nxEYK1GqAM19n/B/jw2WypV8hs9Bbvk7/vAk2K51MR90k4uQtC7aV7UWj8zxrfiSoHBvDr4qaPnBJyT57DJps//01aQKr2Zoz2PJictjv6SYiVP3DN1c03suWFKJ9q5
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(1800799009)(451199024)(186009)(64756008)(54906003)(6916009)(316002)(91956017)(66556008)(66946007)(66446008)(76116006)(66476007)(107886003)(36756003)(71200400001)(6506007)(6486002)(9686003)(33656002)(38070700005)(86362001)(38100700002)(53546011)(122000001)(6512007)(478600001)(2906002)(5660300002)(8676002)(4326008)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lZhUHoYiCVJGM30ZHeG8ub+tAd+3/uAiOcbhWg2J0mRWir1McvDrsOnipjcJ?=
 =?us-ascii?Q?cozvvsNaAxoItqgr2o2q9U/XWYkEJMYjrVL+uPkgerEMFsuIUmHmkxnlAj0r?=
 =?us-ascii?Q?h4XXThE5djGGjJ83su0StkjrjGteBPrWplZVOyFb1lIj95MvAUSabtLuCc34?=
 =?us-ascii?Q?fhaduTtnJw3mxiG7MwNp9WZVHpdi1BWqVkN1J01Mnluux8wtDu5xOKA91Mll?=
 =?us-ascii?Q?DYG4sQYruQxTU74akErISd4ocFoMyl9DVOcis4bOnlz8ftI/OI1w0dLj1xKX?=
 =?us-ascii?Q?1pf85YnrqV3dq+HeZiVTv+S7+923tzeHWXoUv2RfucJxh+zXJhC0ZeRASYtl?=
 =?us-ascii?Q?TmoLo+X3XpFiKmvr+lRbB6ttXATt2Ej9qtxJrj/0mY+CqhIk5LHaZCsWGLCm?=
 =?us-ascii?Q?oxlK56A0fi8goc5WDT0Bcr+3twuLUtF0NpW6mNeLWomZduSh4iZlCGyy1xYm?=
 =?us-ascii?Q?+uAEdWzJKajRwJg2dfLBzeWknycfngsSQc/K6jDGzNZm0nNbuaMvcwpNM9cT?=
 =?us-ascii?Q?f5xI16B0IOlAipBOQzbO3eLQT3RThwL9S4Ad9wCnDTRy+KN78nG5ZX6cKrNm?=
 =?us-ascii?Q?TunriQXIILvdxGXSopNbDg5GeMQLYIm+gNoZvxLXWiunLn3/LZ/EC1VA6o1o?=
 =?us-ascii?Q?MO1xO2hcSmwyFXygewlNB2AMwUE6h8xpqBGiDTmtCqNIRHf8g1G0/p2/ELvp?=
 =?us-ascii?Q?TOIwfcCFuvt92+ywoTcuoRrAgy/mX05r3y3ZFI7o7Ky0ba2lA/sDnFjrla/m?=
 =?us-ascii?Q?bNJkDwzjjn6KxlFdZ2wDlltYyXKJuIVoHCHnSUwSwcjS+kH3SjXT44H3QkEh?=
 =?us-ascii?Q?z6Q1QHEvEzijkGoDgCNb709nMvSYZ/P2JgGIajBrMtEv5HW//m+kZt8waY0g?=
 =?us-ascii?Q?UZtftBiWYX/F40ZEyYjVvJ0QMcQwEOU8vKXihyGsg5TpOEoHu/BIAJTWzjpW?=
 =?us-ascii?Q?KdEWpfTPA/SVvTC6GmjRJoxN/fYwiIKCIoSRjd5MnSZWedojTDK0NxHqm/um?=
 =?us-ascii?Q?NwrfrCQQE42t3Vjb0lCJ1LgJvbIkn5rEdpJ+fLEvca/2OoWCywTa3/jDrSE1?=
 =?us-ascii?Q?lNpqykwRFEi4CJGrmquZWR05F8l1FjfugZfecCWBA8VvG1/ILnkg4BdISv/0?=
 =?us-ascii?Q?b9grTE0YXGtyH2IFE0NMv5CaWXz4pKrEJVe0AzLwnVMYoZOkXcX+N5Yt16ky?=
 =?us-ascii?Q?WU2vIrALjr+GrJKFG7kk2ShCndORzDbUAu0/nSm2SuYnCWdvFzjoU4kmjvWv?=
 =?us-ascii?Q?0zAOmeN/PhH654w5L0whnsGSsQqZT2qayNGpr5UuVfv+y83WEKN6PCpElqla?=
 =?us-ascii?Q?nkrCvGXyQ3KnhzaZBNAa/1pBVnJqvfNTY9Ly9EnYgu5VS70/wWxYKOnLGGtx?=
 =?us-ascii?Q?LwYftrLnoKSMIFX8i8f7iEvPPv/ggQR8p7QiWkZBLJny3EtS40OmIYlN7x0A?=
 =?us-ascii?Q?Bz037nfwHPnisjmspCgyb/l354iJGKxoIPbTL77nrhUhiCN9auoldMXZkt1H?=
 =?us-ascii?Q?NA418HzDQI3cMbWNwuz0prYogkduwZXgsr2kb3xxHSzmE/8E/LfBxrJuUe+4?=
 =?us-ascii?Q?lYM0nRsSs1+j3scDO6/qe6Z88O4F7PKVuxH25vc5OxS5canHadrgXZy4EqHl?=
 =?us-ascii?Q?YL1d6QLoNPzypHYcJXnVFTA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1B8585BBEB8B2479D9BD42EBABBFAA3@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f09272b-d704-40e3-a8a0-08dbb9f22ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 15:56:35.5530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOx6NJvQLTRI1sFS/d4kw1Lmfz5MbHpRtzmghMViNKAx7UG9Dwpo6N3CKGYXhDMN6zPItNj0SVyckWRmqvv8MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5299
X-Proofpoint-ORIG-GUID: _jXqVa7wvoKCvPsHDn2xLogbGQzlMFxr
X-Proofpoint-GUID: _jXqVa7wvoKCvPsHDn2xLogbGQzlMFxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Kuohai,

> On Sep 20, 2023, at 12:39 AM, Xu Kuohai <xukuohai@huawei.com> wrote:
> 
> Hi Song,
> 
> On 9/20/2023 1:31 PM, Song Liu wrote:
>> This helper will be used to calculate the size of the trampoline before
>> allocating the memory.
>> Signed-off-by: Song Liu <song@kernel.org>
>> ---
[...]
>> +
>> + nregs = btf_func_model_nregs(m);
>> + /* the first 8 registers are used for arguments */
>> + if (nregs > 8)
>> + return -ENOTSUPP;
>> +
>> + ret = arch_bpf_trampoline_size(m, flags, tlinks, func_addr);
>> + if (ret < 0)
>> + return ret;
> 
> Since arch_bpf_trampoline_size was already called before the trampoline
> image was allocated, it seems this call to arch_bpf_trampoline_size is
> unnecessary. If this call can be omitted, we can avoid one less dry run.

Indeed. This set doesn't call arch_bpf_trampoline_size() from struct_ops. 
But we can add that and then remove the _size() call here. 

Thanks,
Song

> 
>> +
>> + if (ret > ((long)image_end - (long)image))
>> + return -EFBIG;
>>     jit_fill_hole(image, (unsigned int)(image_end - image));
>>   ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
> 
> 
> [...]
> 


