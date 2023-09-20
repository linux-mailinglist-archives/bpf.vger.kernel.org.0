Return-Path: <bpf+bounces-10472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4BC7A8977
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6847C281CD5
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC2B37164;
	Wed, 20 Sep 2023 16:31:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597679EE
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:31:30 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C92C6
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:31:29 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KFgWYQ023658
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:31:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=JtOccfNsEDCRYYdQwud3/DKMsu89wvfezulgRY1Bh8s=;
 b=fvpqfkGOSSEPmYv+vzXxziIiWM78DQBMded1DQku4GVF1LOleLsP/jK1+wPGPmS9wk7N
 L6/hlVWlQwikAZfcwkmNaZV9gQWrBlRoNA53kzYRekgKT+WgInROg14AL9rhDm/cFblI
 zXr4HtG2K14Go7Id7BIhlA1nQW/O2BH1nxmAqor4PmNUunyC9XXtogB3QU5gnAZkq6jS
 B1dlQ27OPU9bhD6U+Au0ZBmD6SPzb35qFfKhStxeuo1w2tiBHmZ36uGD/hIUvaRNJQl+
 3zHBPNHhxtoXR0uVa+KyY9wYv3MSAKZpvuYxrTGeobX9WCk7TQS+vXgUXzBY8AHrE7EW kQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t7xhn38ms-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFXSaKCtH0EL+iiiEOFIBsQfzxvppazGa20d41LsbS2FgIZTMQAaAnfR8JVROke3YKJjxj8UiAGFXqltRwWYmz5KsLhIBXDJpeuT2hvSzsgyNgM1G07+3gtZ39U8AcAxV+UAXj0jK2dcPzeKAkR1OMY9YuW6dc3494hLtNuZxiixgdKruzm4YkIVk/jdR9Kdshu9mWNmxBasnW2gs8ngbs14NooWuXGKKIlCthj15dFhZa5+jes/lGgO+dAig3XuJms+DPv+oRK2ivLKfoaLytwPkGRTb5tfy+DZXW3aZ3FgpTMmZuMZ2e7+nnLR2whCvCShDwFTlhGnSS1hKcBj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtOccfNsEDCRYYdQwud3/DKMsu89wvfezulgRY1Bh8s=;
 b=A/uDV2TzenITc2GS8rhzs7iLZXbm3Zph4FUXPwwLFFVcGlU+JGLOnWJliaSpS4Zgq1NXxHQJTFT/798yCNRk6peHZHJF+KaY1JdDww4wpOUDf47fH7UJ9pfQRSOq9JYuT9GBSEnWEbgx2tKkjdX4Kde8qSeBzOEORe9sJAd3TO4spdEDiSFrqui0WTfR8eu/0PXgTAKNKGCqidhRTYtgkl3OOeOTZ3rt1n6BPzT7ggiRpL/ef4H8RSvMdGOHQfONC/OVKNAqL/vFWuNKFnb0DkPmL01xRgDMr/S/Jx689gkWX4NweecBMEV67XUiKQaV/pMGHsg5b1AL8nMTCo9+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA0PR15MB3840.namprd15.prod.outlook.com (2603:10b6:806:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 16:31:25 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::57f2:86c6:1115:ad7d]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::57f2:86c6:1115:ad7d%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 16:31:25 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <song@kernel.org>
CC: bpf <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        Kernel
 Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 4/8] bpf: Add helpers for trampoline image
 management
Thread-Topic: [PATCH bpf-next 4/8] bpf: Add helpers for trampoline image
 management
Thread-Index: AQHZ64PSo3WdTy+peUqcK0SH/MWnDbAj6LYA
Date: Wed, 20 Sep 2023 16:31:25 +0000
Message-ID: <ABD8E59A-7F0C-4CA9-A698-A83A3C15601E@fb.com>
References: <20230920053158.3175043-1-song@kernel.org>
 <20230920053158.3175043-5-song@kernel.org>
In-Reply-To: <20230920053158.3175043-5-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA0PR15MB3840:EE_
x-ms-office365-filtering-correlation-id: 512b7a36-0a6a-4ab1-27fa-08dbb9f70862
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 x4tm5Ntb8O+yBLXF/itm/7AOrLiewpOpw1bFzXtUCRw29RbcYqtp23uHCXyKehbmYZ0v6Jmn08dx7AZjc5/FtWv0+58JlTyf1wttvkJ2uG7iDCUG1Tc4vJiW7n6bAswmKGTnMJNVdHuXgT9pWI3JnI1JqFG+TSVkeezx1AkneqhWiASXTqXuxQID+m1dmzaMHQew5hL61T91DIXUi+Q16owNzt+baB2AnTpKgSMBoW+8TtkECbYJqPT/KD8Fay1Gw1FDsSvluZtjI0RvhJ9CKRkWZSeabuC7eBPRXNklnIl8NsAyAaOGIREK4J1KtJ7Duv51adOhQVOMPTjgi/miHXYApx9YDRBnWNTv0hCNjh1LjEHQaLf63+9beBmVfvbAKli2M0SHgLefd9jkkaZ0r7UnRfMSDLoVDuSfoRYwwv9Zixf5s/noruxN9FCClBC+JqslkZXChCJqaCJX9adoSzcegu6ptI+z8QZfC9g5lxtpCpF1+ZelEv8IPYdltFrtDgX0deh6lbOLQzQeM+WzYQOALmw1a+z857mVJTmjJdg045e8Nqf06lyHD5nlaqLe5OJlnnUo2WDDvNtV37e5i4wwXvCXm3hMk3GqAZd2+8m6wNHPQPsY3oFdNbPTw+tC
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(1800799009)(451199024)(186009)(9686003)(6512007)(71200400001)(53546011)(6486002)(6506007)(122000001)(86362001)(38100700002)(38070700005)(36756003)(33656002)(4744005)(107886003)(4326008)(2906002)(478600001)(5660300002)(8676002)(8936002)(76116006)(41300700001)(91956017)(316002)(66476007)(54906003)(66446008)(66556008)(64756008)(6916009)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?K6EIoX4C++Gxgt/1RwWDNOjspwPx3S/sYP7tvWjKMTMEuhDLoxoLfdtDDBPQ?=
 =?us-ascii?Q?IfpwVxI4/qgCJH1rs9P4Ugnf2V+vKTnikTgVj8G57NeeZ7i6x7cemEo1RS7p?=
 =?us-ascii?Q?glPkAqbPCRt8CViVrhwcIC+QyaOyj8bsHD9IUAU8tWLS9hh14oy5cASeI0kE?=
 =?us-ascii?Q?WLhca35MgWGcFRapabB4R6zGiFIm+GGVjSzCeFET0KL/8ULTMcbh6BOcdKLV?=
 =?us-ascii?Q?sKGy2JD2jIvEWBl9wbe/2XqZFgBIn1NfU/oXLNEw0uuBBP43sSxzlGuJGoT/?=
 =?us-ascii?Q?YMvtgQNtawW0jNjoSUZ3oHnhF041ptKLXXcStJ2TZXw2rLThYK9haMYreo78?=
 =?us-ascii?Q?R96TCndzdfMP7lKo6PH0h5LEqHak3AxJt544GjZ2ol1ZXElE9m/IZd1N+3Py?=
 =?us-ascii?Q?RZD03GJp1T5LPaG7aW/7mtbRRzlc7dw7MiWWEwTj+NMVSexATN6EMoJ8ISaW?=
 =?us-ascii?Q?XlZPuhcRKYW29BQILCj70JuUxC7YP5uyInrZwZROBJG0nk83x3TS5J6Bo+jB?=
 =?us-ascii?Q?2EC1HoxMt00AXvHT5He9WoYRgCnJLOuwedjW1Nd79F78CpnzNG+Kn/suelC+?=
 =?us-ascii?Q?Dvv0E60AQUI32LblISGhw8Ui0Ix86px6DDsss70mQtkQ7KfkI1N/YbAlpM0i?=
 =?us-ascii?Q?06tWcwqO7Li41KyLdwuODUS0rAvo1n5RkLYQvSujnvtSB7VWOLBRaTJJUxf5?=
 =?us-ascii?Q?54qzCmR1vw26NZ5kwvkLeVWuwAJ13nAt7jygIIWXs45bP9MOssvDPx/rLPsQ?=
 =?us-ascii?Q?hVkN9lV6HxzZy5s30GXcQsu/EeAMFmsK4bz2/ncsm9+cvAv0kcgx0JeNyaJQ?=
 =?us-ascii?Q?Qyzb4LKTmS4yZisvLI2L3J97Q1ShYPtjGRItjfx7YQ0qM2cUVDMHFcQEZuli?=
 =?us-ascii?Q?M4QChfhXrG+FmXS/drNM6SvfJCQUGGKrXMJDhywNRy2rO7SmLsANlcP9YnCX?=
 =?us-ascii?Q?HY8iOQ/Nz1gkGnpd0StAaU3FY40fsmvUAEr4dt/OMgzkOa/GXKKCjOjdLZk8?=
 =?us-ascii?Q?4UE7pTXKfjCowBDtdPlvfnmqiHI1sSMToBZgHvsCrWxmCSBFCu2XV1oTS2zK?=
 =?us-ascii?Q?3fOMw3i0dkaRtsBLTMvbafFv8k10hnSRcw6ay43e3sZ2DKlfDMFcjcZfQ6RF?=
 =?us-ascii?Q?avGPR7Fx5FSep/NCGazOSRy1JgnQ0M64j+cUO+KiVro2H/1y/gHLLd1adrE6?=
 =?us-ascii?Q?Y1MkcZcETaOq4DZ9vDnyZgIQyf/fzbgqKsmQu8bio6SwcLgNmLIXXVfNGwph?=
 =?us-ascii?Q?zJ679kHO8CH6dg9e0GkZZayb6D/GkHJs/cq756aUxdZXeZ6+ncNNLMUbTMIF?=
 =?us-ascii?Q?evdVHhEwOSKyyv+nogYSdf0MGXPsyKyVQd625AWr/u0MqWNtZxmPPI14L/2h?=
 =?us-ascii?Q?9WADXW+FXtt53DscMAZ4Mi1FfsqCraUIvgH1Y0D7/DQiuVTtgmu4TPuB+V93?=
 =?us-ascii?Q?0Wr1IbiLF3GTn/Ehrg9ttljx52/I5a+r6JzfejjAdeIGhONbqmKHV4H3iDNF?=
 =?us-ascii?Q?r8CnfEBSSt5WVFmxLBlTmL0uMaZmGX4OYrr4YAab8fw/c27hWJkkcwh3Fg2t?=
 =?us-ascii?Q?sgx2mDIR5fYzpc/PfmiO0bAKybqC7UwV5YDlDhFJHlsd7qrUUg5GSUYCzYb6?=
 =?us-ascii?Q?fgn+yRRSI/BxAktcm7RZas4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <548F98163BE1014095315B866F9085F8@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512b7a36-0a6a-4ab1-27fa-08dbb9f70862
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 16:31:25.1361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewUqj0Qyquar+lXTFKByFcKdv/PLQVW4c0fxkyCJqiH4xqTRRpbhnsuzp1MVkhp9A5+4mSJH62XTE/9cMITuYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3840
X-Proofpoint-ORIG-GUID: q2NIF6v9xLL3Sg7J62xRwQsC3l0iyWZr
X-Proofpoint-GUID: q2NIF6v9xLL3Sg7J62xRwQsC3l0iyWZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_06,2023-09-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Sep 19, 2023, at 10:31 PM, Song Liu <song@kernel.org> wrote:
> 
> As BPF trampoline of different archs moves from bpf_jit_[alloc|free]_exec()
> to bpf_prog_pack_[alloc|free](), we need to use different _alloc, _free for
> different archs during the transition. Add the following helpers for this
> transition:
> 
> void *arch_alloc_bpf_trampoline(int size);
> void arch_free_bpf_trampoline(void *image, int size);
> void arch_protect_bpf_trampoline(void *image, int size);
> void arch_unprotect_bpf_trampoline(void *image, int size);
> 
> The fallback version of these helpers require size <= PAGE_SIZE, but they
> are only called with size == PAGE_SIZE. They will be called with size <
> PAGE_SIZE when arch_bpf_trampoline_size() helper is introduced later.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
> include/linux/bpf.h         |  5 +++++
> kernel/bpf/bpf_struct_ops.c | 12 +++++-----

I just found that we need similar changes in net/bpf/bpf_dummy_struct_ops.c. 

Added it to the next version. 

Song



