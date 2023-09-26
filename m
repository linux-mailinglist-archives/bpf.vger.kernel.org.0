Return-Path: <bpf+bounces-10876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951267AF017
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id ADA561C20865
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34D830D1B;
	Tue, 26 Sep 2023 15:56:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC830CE6
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 15:56:45 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A571BFB
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 08:56:44 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QFhupZ022198
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 08:56:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=1VJBN+5mpHmZrrrQAcQEcXvZUuI6ADm/ARmmXrlknBU=;
 b=KbG1Mb4rVzcmjftcoaWC+FMYn4zdfeh/SBrhXgqmBFhyGs+LyDiEnaEKROAY7gwjVKNJ
 KXsq3peuElNY9hbkSZUCHwgUusp7/Gq/MPbP+hCt5n6dyomZ6f5R+5JTwk8ktLV8aUYK
 xShtyaTX9o86G0QXjjXwGr2UXfaaHeTAGi0DpVFWq48xln33yNWTPBRuHRqKSjx5KgSH
 GSQiLZDTEG8l8WpmavhsYAEvGmufdTI90Mj62ZrAWUnVSH7Cat004+b5JeJBI3u8QzIS
 sjd7Y6L9jFVl5kzUzN8KUYDHHq8OWOGueI7V1HTRBzE5GNHMlrTlejXaz5Ts/t4LDYbO 3A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tc10eh37r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 08:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+Ojwe7l5jV4PBPx116yffD0T6MtNOt+lYd+YgXR8SNYg7Jqdv+9nmicRqHkmsaSd+A/8ru4lemW7ueeaGTQ2SnP1z1v34GCu54KVTcer4gsHdg2HJcRWYVRnwj9BiYHcC57aG0qm0+NyNFrxIv/+mmhTcvDm+gZO9GZUbGYcwbDnv8I1WdRtILVqhO+3PaxcYXlY85Q5vSDXKADTcbhNfzuwVb/vKrOwEFX9jNe3nl+IqNYVy64qhjOZCwM2LaSx8HJ/cjKTtGhuWw+GmlgclEb49j2Sho55joYf9Vnk+hWyRGjuewIUc4zeDT+U6jVmuEIGAa0kCkVe+vOsSaSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VJBN+5mpHmZrrrQAcQEcXvZUuI6ADm/ARmmXrlknBU=;
 b=AmLg5ajqB+NcBdxCWWY3ikokgOAhp4bCX5IA2OGl1uq9c36Z4xh0O0lta5bFo6TNbaiIb6vYaEih73xJXQqBZrjQAlASdahIQBWnx0BrBohdrgLbtjm+7gvebUAh1xcQ5vQvNCvEorCSKSUE3UGiRPo/ps5VUrAuTLzsm24V/jKdyGthRNN6lBhh/X7ItwngpUKaR0XQ42oWH2VuZVoZae0IuObupcYP4ZGA02+Znmp2bl4WmzaUI2tx3VzMGysu3+zVSr1YOqmkn+MBXqXyLtpXdlXLwZLfHu3is7gPB0v0t+vQD9xVfwDgLxV2k+BWBOgwodGXDEG57Pg3TxqeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN6PR15MB6124.namprd15.prod.outlook.com (2603:10b6:208:472::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 15:56:41 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 15:56:41 +0000
From: Song Liu <songliubraving@meta.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        Kernel
 Team <kernel-team@meta.com>
Subject: Re: [PATCH v2 bpf-next 0/8] Allocate bpf trampoline on bpf_prog_pack
Thread-Topic: [PATCH v2 bpf-next 0/8] Allocate bpf trampoline on bpf_prog_pack
Thread-Index: AQHZ7/q7UhOYxD/Kh02AEYfvOHOSLbAtCXeAgAA6mgA=
Date: Tue, 26 Sep 2023 15:56:41 +0000
Message-ID: <39045A65-0A8B-464A-968B-A12F18853D66@fb.com>
References: <20230925215324.2962716-1-song@kernel.org>
 <898b73dfc592c4a49de4777e4776b0b8b7c6bb66.camel@linux.ibm.com>
In-Reply-To: <898b73dfc592c4a49de4777e4776b0b8b7c6bb66.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MN6PR15MB6124:EE_
x-ms-office365-filtering-correlation-id: f1e8dbce-71f3-46b9-71e3-08dbbea92ca2
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 VoadybjLSeZwCcQ2dNOZlb/A9FWH/nQI4uhzAHHfxCaDS0sl7C2Qu7gD4JyU4HW++6VBIgyBOQiaIxkbfg5e8I+M7mmdMIDVCn/jxQxS9plxR3X2DZnXgk2wnsDHUycRjjuiYEkyKgedPrwnc5VizSAfdAJDGDC0AZ12EMDpq2GnwrfR6QkomavpP0N/Gc6Xy4+aerp2VmXZrzrkT2Rn76D4+Y1Ihs3pEqT5zNNZ9GZVrbVF33HPIUlBf844auQRa4fLaarndxy3qMRvQd3tJVb7E58EtsX0o4ovGIpVEGpP6goHlmeiiabnBigDfD0fisYfgm0dn2V8pU8u41en0XXKR6fxc5U1RqYvmefXDONLw00T9+8X7p251SY8r3uMsK2uLPquYnjGsDZwPh6hNSEf3odG/cR4BINKj41hYu8bBdlYujqSZl6VSKCl8m7IKFnKxMIwb/wV8/DJ+vFRQ/tI/Dl2i3tbyvmFI0FVGAAz9sjlAXvywBT7ztt0XGF+dHXNZFq+w0VjQY0TcdJpWZNQjznZ7ihi/KP0kpYs5bOjU0Cp3X/Bq0zOIUkYY8WCeRj9MrYvLIUgvF5yTKLtWzlxBUi3RfNKoMRq4pOLyDAaUz3Q2qa+47FhfCUiFgzp
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(66446008)(41300700001)(6916009)(5660300002)(316002)(8676002)(8936002)(4326008)(66476007)(76116006)(66556008)(64756008)(54906003)(66946007)(91956017)(2906002)(6512007)(83380400001)(33656002)(71200400001)(53546011)(86362001)(6506007)(9686003)(122000001)(6486002)(36756003)(38070700005)(107886003)(38100700002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cZrB/986GFfgypf6Da9zMJAnGlgQhqanU2GedRpdf1UwKE5VA/ECGMym8jyk?=
 =?us-ascii?Q?sgaI9RCuBXyecLd0TpyAEXu0eftQ3eLGN26jXKYrg2RiKbq/yXqU38sFmdju?=
 =?us-ascii?Q?2vlYij9VxZtACUisesACppAGix14RopNH0Y/ubprnjjQpgQmqnxNHTypYiE0?=
 =?us-ascii?Q?kyt/MxrkS4q8Wxb67ODTrMgQhwmoKMAI6kyAhe6jwxR8biuKXB7dZCCsG7/f?=
 =?us-ascii?Q?Dw5sFA93uag8b9m3lhBqDSedgVk1jKXP3bppRcSNYVbgqLTK4/lgX6lDXERL?=
 =?us-ascii?Q?AqKHwb6gTrSqem12rL0+TOwQmpXN+s7/GPCqg3hWOI5GNC26kD3uOi/BdmnO?=
 =?us-ascii?Q?71DjSI7gAxyiQl8yixC5tS5CfpHA4fmWTTVvwIDAPG3VRviGJLAm3MYIWjuG?=
 =?us-ascii?Q?llEdrBxSODguocvHCbqBryU/w2sKDg71h+fo95xB7jgMgGMxnc/x4ubublr8?=
 =?us-ascii?Q?2sBZyIIS20lSc/kfCetl3tKaPnRahA2+sjjNzLTt5T2JKo8uIBREfjDYLtxr?=
 =?us-ascii?Q?pEizmSbTfTIzn/68GmrCjKBskTQU8JpG5XhkNmYlhe1VeMMGmxjufVCYn6An?=
 =?us-ascii?Q?dxMUM/nTnKxP8sLVUah4UH4DXadITY8HQ7c1/W149gIUFKxcMMrSWVDNhjKC?=
 =?us-ascii?Q?axzNbsJibXdEJAR6948SQfr73wgR7ULBYBe4HTveI55gxH85EIU3hIlR3DYS?=
 =?us-ascii?Q?2I+hZTxPY5k5TznR6W7LBLDVTbmqZS+IH7ItSS2o+7DoCkJSgYa60r22bn5j?=
 =?us-ascii?Q?GJGmDSLzgegMvAmr/Boss/gcQyQ49BpgPKJWdEhFfvFDl12kOuKupT2mR4Uw?=
 =?us-ascii?Q?jnqN4xZcboOZn0N8tLeXTer0+ufNeuUJQBPeKJ6LInw44tI4d+J2hkKIsi3i?=
 =?us-ascii?Q?5zjip5ZyDsVykDeRYTMriW7FBG+nIfguBH+ggWw4UNcNajIfOuwYM0HO2f/A?=
 =?us-ascii?Q?y7+hADJ48bpp+nKMgIQKctCSWo8VcmnDqEkpG3+xCBoT3d/Ay2ZaA2rxEP3q?=
 =?us-ascii?Q?tLaRZd3Be5dSu2RtCOpdLc8JLewHGuzoM9hu8hpEu0pJklnnB4UMvrJYbP34?=
 =?us-ascii?Q?ph+R2ObBgoJ3sihXzXD5GEJJn6Q0L3tGaT9znXwIymagRJTZPoZOVd+pK5jF?=
 =?us-ascii?Q?dluY9QojHWG/dq3/ggoq+d4CKqgEv+sq/KCAcK7kl82b5x2mXhAjua6RSBiU?=
 =?us-ascii?Q?yQ6O/mPIsqpUa6k30M53uh9q0F1UmL9GNfOdwyxoNps/ocelLV0Meeapmjmz?=
 =?us-ascii?Q?gTnhL2bwGVhCvRUahn9zEfjXKHkrmZ/rprtH/Uv3AMEGoC7XtCrg6gFmwWQY?=
 =?us-ascii?Q?i+QfGmE6H4kdIbr+0++Hi+QrPo6XZfSyYDOr76La/GiEDZE4sI0tScK4O9mz?=
 =?us-ascii?Q?VaV4JaJEPv79/r1vuSxgUzBRcZDrWEwQFYkBBkTIKmvv0AJcwhBJGNxnVOyH?=
 =?us-ascii?Q?6/yNRifHmmVZjcGU9qrUUEOoRxhAXJnu27lSqjDCcY13lhcrUJNn6e9XWzWy?=
 =?us-ascii?Q?oizUQ2oKez1STAus81NEBds/FGgMO+CTiOWH1BwOeu+hSGe4/6w1fhUU9qKc?=
 =?us-ascii?Q?+qybMPhcVbg42GW0QhRphTI8awfGpXS1LZO5rK8npic18pHWjSPiPbbGoyhH?=
 =?us-ascii?Q?D79Ny/cw63iIdSKZb/KioFM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8283A637B50804FB6A2DE9FD1C3B894@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e8dbce-71f3-46b9-71e3-08dbbea92ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 15:56:41.0386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwraUHPVHBK1tRPEcf4fyTnutA+YYWbJ0z2v1oHrJa3i05PnUE5e1CCFFEqPRMTnR3E6tz7n0GspSma/c4uABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6124
X-Proofpoint-ORIG-GUID: IHrb7pjW9HtVb4tZHH-N99fHIu-Zfg5u
X-Proofpoint-GUID: IHrb7pjW9HtVb4tZHH-N99fHIu-Zfg5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Sep 26, 2023, at 5:26 AM, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> 
> On Mon, 2023-09-25 at 14:53 -0700, Song Liu wrote:
>> This set enables allocating bpf trampoline from bpf_prog_pack on x86.
>> The
>> majority of this work, however, is the refactoring of trampoline
>> code.
>> This is needed because we need to handle 4 archs and 2 users
>> (trampoline
>> and struct_ops).
>> 
>> 1/8 is a dependency that is already applied to bpf tree.
>> 2/8 through 7/8 refactors trampoline code. A few helpers are added.
>> 8/8 finally let bpf trampoline on x86 use bpf_prog_pack.
>> 
>> Changes in v2:
>> 1. Add missing changes in net/bpf/bpf_dummy_struct_ops.c.
>> 2. Reduce one dry run in arch_prepare_bpf_trampoline. (Xu Kuohai)
>> 3. Other small fixes.
>> 
>> Song Liu (8):
>>   s390/bpf: Let arch_prepare_bpf_trampoline return program size
>>   bpf: Let bpf_prog_pack_free handle any pointer
>>   bpf: Adjust argument names of arch_prepare_bpf_trampoline()
>>   bpf: Add helpers for trampoline image management
>>   bpf, x86: Adjust arch_prepare_bpf_trampoline return value
>>   bpf: Add arch_bpf_trampoline_size()
>>   bpf: Use arch_bpf_trampoline_size
>>   x86, bpf: Use bpf_prog_pack for bpf trampoline
>> 
>>  arch/arm64/net/bpf_jit_comp.c   |  55 +++++++++-----
>>  arch/riscv/net/bpf_jit_comp64.c |  24 ++++---
>>  arch/s390/net/bpf_jit_comp.c    |  43 ++++++-----
>>  arch/x86/net/bpf_jit_comp.c     | 124 +++++++++++++++++++++++++-----
>> --
>>  include/linux/bpf.h             |  12 +++-
>>  include/linux/filter.h          |   2 +-
>>  kernel/bpf/bpf_struct_ops.c     |  19 +++--
>>  kernel/bpf/core.c               |  21 +++---
>>  kernel/bpf/dispatcher.c         |   5 +-
>>  kernel/bpf/trampoline.c         |  93 ++++++++++++++++++------
>>  net/bpf/bpf_dummy_struct_ops.c  |   7 +-
>>  11 files changed, 277 insertions(+), 128 deletions(-)
>> 
>> --
>> 2.34.1
> 
> Regarding the s390x part, arch_prepare_bpf_trampoline() needs to call
> __arch_prepare_bpf_trampoline() twice: the first time in order to
> compute various offsets, the second time to actually emit the code. So
> I would suggest to either keep the loop or use the following fixup:

Thanks for the test and the fix! 

I will fold the fix in and send v3. 
Song

> 
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -2645,7 +2645,15 @@ int arch_prepare_bpf_trampoline(struct
> bpf_tramp_image *im, void *image,
>        struct bpf_tramp_jit tjit;
>        int ret;
> 
> +       /* Compute offsets. */
>        memset(&tjit, 0, sizeof(tjit));
> +       ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
> +                                           tlinks, func_addr);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Generate the code. */
> +       tjit.common.prg = 0;
>        tjit.common.prg_buf = image;
>        ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
>                                            tlinks, func_addr);
> 
> With that:
> 
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
> 
> for the series.


