Return-Path: <bpf+bounces-11440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A22D7B9D7E
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B3473281BAB
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2420B31;
	Thu,  5 Oct 2023 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZWJkEIqR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070E1A27F
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 13:47:02 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102D3287CD
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 06:47:01 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950CYUf010140
	for <bpf@vger.kernel.org>; Wed, 4 Oct 2023 23:31:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=P31E4xLUJ9Zj+dTnFnE8RoDM0I1DbKtJ59M7+S0pBns=;
 b=ZWJkEIqRNLUF/S30os7ua0ci1C0gWzWvuENplr7Zt4YI9QPtdPYtN4vbuuGYTMUeFGMZ
 C6NT5TDwGZwAjNPyigwBwUuuFpZ215urSQx48j8uYsp1Chk7Macy+JWOmOB8i/yUuUxi
 pz+JiD5WL1ILmHlai2LfP7B/gL639s3UHTC/g7imD4+MZXwOYgpdUWNwekJllZ5ki+76
 8abOzcvl7Lp5WA+jYSaffw54pzKFwS2Daw7CkrH5r68IoTYdfUI4YdHuPLkBJ+wWve6X
 eOztV9agmEpPIuUQ3WDQlTNohkzfit6I8NmM5qeeVQ3nmn+WV+otvtc0Ay7W+H8tsMwZ hg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tguy02ckf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 23:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnlZptotaJU0Dh8VEGtyM0ybBLazk9xLFc8KdxH272sYY32gJDJFlNppaMf0vRx3wWnPbk4MkL3+ihSlM7/ORvNsPEzshts6HBdFH6+NAzt6IG/h/PxVh4/1TOsADX5sv6QYrocoxLQaAzzoaGjJwoxRsWlorSyP1xUruuRR+AO2g/o/LwC8a+CQq1phKIWDf9SjAi0L9u3RbZ4tOdQGmEkLiwDkIWex0y2smTLAPWVkbIQ6H5waof577MjDpfZMTlenf/VOtCYWdGVVGlACSzbvlQkyJjxGTdqi2heZy4YtZezjD3sPVfk4NNu0JZb7PEgBuR5gBYb4U1LoKUP6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P31E4xLUJ9Zj+dTnFnE8RoDM0I1DbKtJ59M7+S0pBns=;
 b=KfCPAN9mPwWeGyWtLRoYoJw7KJZSjSooqPwXKyzp7AtKP6mmgCKvHv7eDjU5ZCF/cN7avEKvt5o2sA4u6DlFmAMNMD5Dffn+tUIZP2uuZxUzme5PyJvaXMJOZyOrAwzshU3UHxwcjCWqXcdJa3MV29bnyc49fh0Ko0J6I25e2VLy6+Ruu8XEsYvx2oXvZuH5ElVhTj2wuPnAQTQNFoOyBGLNk8k93SOhJRwKQWB/m+jqN0zGuGevOLhZ8V3/E7nIT0UvGN4eEWly7bgJ3ZFiLpP3JizQ4Fj9jINGPKLL7EWqDy8zLwaM+ALNKayP0R9UhUxopHG05kqQQ0MjH0RaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4462.namprd15.prod.outlook.com (2603:10b6:510:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Thu, 5 Oct
 2023 06:31:56 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 06:31:56 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <song@kernel.org>
CC: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin
 KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>, Tejun
 Heo <tj@kernel.org>
Subject: Re: [PATCH v3 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Topic: [PATCH v3 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
Thread-Index: AQHZ9ztk8ARAnrG440SIiGxv+3DmJbA6vMAA
Date: Thu, 5 Oct 2023 06:31:56 +0000
Message-ID: <9639F5D0-4376-4FB8-B148-0DCB063663AE@fb.com>
References: <20231005032350.1877318-1-song@kernel.org>
In-Reply-To: <20231005032350.1877318-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4462:EE_
x-ms-office365-filtering-correlation-id: b4936cdb-5bf7-4280-b6be-08dbc56cc5a4
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1xAmSPOfVEmRwLz6MGxNC5Ad2XKU0XcSsVfg7Js8P5ZfzVyTbwTzrpNs0R6wCCfF55rsgad/gYAL/w8+MexrZhbshqxooKdS6gAeqqraqW/hq+zpaESvnAXhSFrgs4blUSnSuv1QRmKr9+/IE7RGk7WDDw7iwQDDJWJV2zszHWZP6nEwRp4AdTJhGnagcuQCpgxnpclXRzOxqg7kFZR2OPPkVSEVzyDuHUSDKsLZhzcnqRg22gbmroBSG3cRU2N8UZfZkv1OzPp4yrEJH48zcf/KDGaUSnzU8flD3pHJUAx/1mkSDh8JncnZx+t74dMQgeoEkIyB9kRRH9PB3NogIjLIaYT4RCrNQuYFHPUbAX8rsjRrM44SNd6aCm60J540krR5+HHzvX/jU3tyc2aoaA8yQ9Vb9bEd9lgalV5W8Zg2FH0bonXbkeINGFqigWln0qjQIskgxzdDZt32nWGNFAC1awYSTfhTjtaddUeqHpdSA/FH+LzdNGzSSYHmqYOSfe7zLQ+MtgEVAikSk3uKxE9ZdsbrMp+k/gDkx4cFxn033hCSEw3q/1TDcgKj9hsTiM6qbb70f+rUBFtaSfpbtmYTQ6e8JMhjTV4E+erbHzCk0ZXwnGXTBlsKjrXP2HTv
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(38100700002)(38070700005)(6512007)(6506007)(6486002)(53546011)(66946007)(76116006)(9686003)(66476007)(91956017)(478600001)(66556008)(4326008)(4744005)(86362001)(36756003)(2906002)(122000001)(41300700001)(54906003)(316002)(83380400001)(71200400001)(33656002)(5660300002)(66446008)(64756008)(8676002)(8936002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?F3vLI3XIAOgOSa0yHM9BC/w+mNNx+c8eLaWgJvv9f2rm/RUvy58jmcsLhutk?=
 =?us-ascii?Q?Z/Irtaax6/SfBdwZ4BMgA2/nWq/7hWArzgDu+/giJkQlyBosbtgJNzhubJpK?=
 =?us-ascii?Q?BVC/TrQOS12j2300ih1FSrxZ1leVFynWVh/O90RrnEBUxXJE8K1pYXbjAEoH?=
 =?us-ascii?Q?7HVyrgk0C7LR8VAufYN0zeOzZRPe4yDZSe6G4tuoFOGOjSgQEuGE4RAzoBds?=
 =?us-ascii?Q?+6cfUeGekLITQlNvpW5Fxded2iTFl6cVb2XkRNvYOKvUkGsKkAjUap74ZlZ8?=
 =?us-ascii?Q?I3Rbz1PJSiW6iJo/Hh/5l+OfJpEmdktpOkQBEQ2Oaid1Jq7z2C6MhF7Iewgk?=
 =?us-ascii?Q?jbt4RBLcMhkt4h+StFHbFGWaA8tZfwr2VQBtwEU+wjswRgmazgEptXV2/WNz?=
 =?us-ascii?Q?AqiHZ4P4y4EaAeiNsOrihskeR2f9T6rvbrvObV46ZWNh3S9ELoWICHBSAFnd?=
 =?us-ascii?Q?Fre/SOpUWP5s1Ma//pjQ7iqVfnzh7G5Rk4xllcxpQCZbYFv3pe4oNE7w7581?=
 =?us-ascii?Q?nxyhFBSeyeRJlrcEuZXFQGcMGNAo3mc0Ga3jB5YXmfpjpShCuLiNmxify6Q+?=
 =?us-ascii?Q?BK+ca9QuRAVtjeF2mTOQ5wBAdHaSr00UIblNH58dIL1I227UUqSpQMugRX5P?=
 =?us-ascii?Q?BCf6QI7fW46QTl1sOczrQLikWbfbNYpVLdMODZK1F4V5ULMEoePVYWoqeguY?=
 =?us-ascii?Q?cZd/7iZC7DQx6lhp2tesOHOWFfE0U9PrbyRPnuA7D+g6TFd8PGPbtxjfjZAF?=
 =?us-ascii?Q?cFkZqvqnvRdr64XYoN+rhelcLrVqg71cYPOkkjWuCaqK2btahx6G3WXMaeQy?=
 =?us-ascii?Q?GCXFehjaccLsDOfCcPCNl6TPypKPBRkqswyHbCVZowcqwhebpUd7gpIyc4K4?=
 =?us-ascii?Q?X1fsTeMkiM44I9sBa8q2/NHjYlKFqvYQDbPC4w8H9WrQzdcafmPnsxtLA+5s?=
 =?us-ascii?Q?C15+ZRlbIT1D9u8ZSuVojVzo4H2BFuFs29YWQSsVb1741HpW0LvLysmhH5vO?=
 =?us-ascii?Q?FOa1jjxeAGgAkfE9Xp4MjkgEuwo8yLApNq7PFvFPLbEPJnHQTv7jTUKGzo8k?=
 =?us-ascii?Q?q7UHHiCde8QoOz9h6rgaWuG2rXGK5NtE66m4LflUStc8FFIPQSagLOzhKhwc?=
 =?us-ascii?Q?SjT1GtVuGJTxjQZP1kz0tM0pyts6Ul23A2qclw5jzrAHJph+SNLdlPAiyZpb?=
 =?us-ascii?Q?febaHqN840/qlWcV/sjUaJQ+Y0LYN0cHb9u44WVcE6KANOkJ+dFoqCh2W8F+?=
 =?us-ascii?Q?slbe6Jl5hDWOT7frBiiFFZqYmip+6imISgOvuDdKB+/Bm7vPa+maQM31auKK?=
 =?us-ascii?Q?lhKXRMX98Bj2l5OTbXdDGJkdy5TIPeY5eZ8pUa1+DoRzwCbdxJ789+Pbv1kQ?=
 =?us-ascii?Q?kbPfRE3FjTu9dIRmOEhTaM+lWog77+0VLhn+I1vg4LOcTxBY3KUnp8OYuuB/?=
 =?us-ascii?Q?9NZvetuyeDqmgtInIz825kDe0k938FuCG0Z4M0aN6OKYjDULqTvGAEGohBvn?=
 =?us-ascii?Q?uL2p+sGHm4jdA17jyFB4LCW5tY3lkjSBLFZZBaK0E0z6fLvLNrz+BJ+LVB9k?=
 =?us-ascii?Q?a+dAV+HcIGAWxVxyrQBp43ctSzBsvSLAcKHvwBsvMH9XkJygjzftUm6TjtLf?=
 =?us-ascii?Q?AUVfeeQCu8StEM+/PnV1Wy8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5480F53FBFE9514CBE83F1C782D0D93A@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4936cdb-5bf7-4280-b6be-08dbc56cc5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 06:31:56.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSWDTVIP1v8pmgxJoBbtAknmsnnkc90wZHiF/T6p97AiXXPh1yAeumeg5KfytSa2BqMv4aMEM05lRP/td9Q3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4462
X-Proofpoint-GUID: aNdkGZjnEATELP8g08NBWIg33Ue-abHl
X-Proofpoint-ORIG-GUID: aNdkGZjnEATELP8g08NBWIg33Ue-abHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_03,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Oct 4, 2023, at 8:23 PM, Song Liu <song@kernel.org> wrote:
> 
> htab_lock_bucket uses the following logic to avoid recursion:
> 
> 1. preempt_disable();
> 2. check percpu counter htab->map_locked[hash] for recursion;
>   2.1. if map_lock[hash] is already taken, return -BUSY;
> 3. raw_spin_lock_irqsave();
> 
> However, if an IRQ hits between 2 and 3, BPF programs attached to the IRQ
> logic will not able to access the same hash of the hashtab and get -EBUSY.
> This -EBUSY is not really necessary. Fix it by disabling IRQ before
> checking map_locked:
> 
> 1. preempt_disable();
> 2. local_irq_save();
> 3. check percpu counter htab->map_locked[hash] for recursion;
>   3.1. if map_lock[hash] is already taken, return -BUSY;
> 4. raw_spin_lock().
> 
> Similarly, use raw_spin_unlock() and local_irq_restore() in
> htab_unlock_bucket().
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>

Somehow this didn't make to lore and thus not to patchwork. Let
me resend, sorry for the noise. 

Song


