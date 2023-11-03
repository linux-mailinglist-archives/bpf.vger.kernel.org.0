Return-Path: <bpf+bounces-14059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B66D7DFE74
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 04:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5312A1C20FA2
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 03:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CFE15C1;
	Fri,  3 Nov 2023 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M0CvAAlB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A27E
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 03:44:03 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B2DCE
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 20:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKn2vbU9FU+QyhSVAXVNsKgarC+flN4605s9P+cE9cPKpdHSEK9OEFSNw83kA4FAxH8MLTNkc5rWMDKpOiKORnIsQDaw/NRh48aHYtHdqtQV8i3SE7kcO8FtJufxKItBXWfyxjOGlHV0r3Go6a7POAoNbpFVyI1Ugbv/eK7ch0QbxAEJV+GcHKjcOlg7HU4giCa/x80DV8d09T4ScqoGKvD438vHlXxX6dd1kDDWcqjn6nvkNLpHvjZT9j14wmSnDGhDojoaUMPrjcgJIepejfhpQCzdYE5IIm/FnU6yywLc2L3NoH7QMQgPVOfjzWJXl5joQYXT6KzaI3JjwOk6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ/0+S6oVONcPk0GOni4vyikWtjabQPNF6tvukGzGyw=;
 b=Zwpjd9/PDg2ZItC1eRVQI4/Rhaf5hilcewMZTUuFRvFI1bUxfdq9vRUOKzFn7aX+O2Ass65onFVyvRddfG4oMyI72SrLDOiPKi7nAszsi081uUMaPoaNNJvds8mnMmjesIuYgucONIlOBfUo3z/rPcX5QvnU+XZTrFGHa9qvlklOCsEbz1vHHsxhvcYZSUP5dZ1Ch4WMK3Ul2KTmV/veX/dTQ9K2/2Tqk5+OIi7QStswGezxbG6O56WlJJw3RGEBO6xk2m4S6yViWSOCw+NqhokEHezPspEBnK3t5EpOLarMyZLR8Zjt/PRCNZgNEM8nLhuPPlixkJFwCkfd/RNLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ/0+S6oVONcPk0GOni4vyikWtjabQPNF6tvukGzGyw=;
 b=M0CvAAlBXUaemvc6i3gqoPxxlwNeLgx6oD43S2ZcyaHYXD3XMaEJfsdhgOVrxEd1jeBGe0GwhBrLYG/v/Ync5hkpIlyg4IdSzdWiouGU2UXKp1XFdyycAfFmXkOjwPRLgmSo8EfWKAPdlfoejOrZp2URDycg65jFgS0tDUCFRThIdHE2MkZoSFUtja7l5Bh6qElNVX0DXYUUIrnWNS1+tB40DjCrVMAYHI/7ZcsvuES7pkaRyLQ4RZ3yUWfls+Ht3hhb8zoqPRYV+e1GP+AYF/a4+0pI1LC5LfeVPx84MdmRZ0xaN5A97ZlzhneLqVaNpqKeZA3Ni0xEav5AcBqtpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DBBPR04MB7996.eurprd04.prod.outlook.com (2603:10a6:10:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 03:43:56 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 03:43:56 +0000
Date: Fri, 3 Nov 2023 11:43:46 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v6 bpf-next 07/17] bpf: improve deduction of 64-bit
 bounds from 32-bit bounds
Message-ID: <ZURripAb6Y885q7e@u94a>
References: <20231102033759.2541186-1-andrii@kernel.org>
 <20231102033759.2541186-8-andrii@kernel.org>
 <ZUO0rzR3O0Ib5hwR@u94a>
 <CAEf4BzZZnPMO1z66vFWtxt=jQH4AFFSDkONwNLS6OSM9EZ_eZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZZnPMO1z66vFWtxt=jQH4AFFSDkONwNLS6OSM9EZ_eZg@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0008.jpnprd01.prod.outlook.com (2603:1096:405::20)
 To AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DBBPR04MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: b3821642-b356-45a3-4108-08dbdc1f1b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4VlDfdUrzl1TpZQCCtF/2mwPIMxpirCvyp7OcHIDtlL115oJcaICrEbTX6A4Qs/hr/JeB4Mraxg/mKPcIfF72D/RHkTvvHSMUbdpkkoN7+n5ead8Xj7WuBpISfj3/WsiAMPea+WdWDjiQHhIjLcYg/nnTnJ2nxve9JPevKZ+7QHCe/EhywEtAG9Lig4tj2hTtPvFc0FmspQByEI45nE+sUfxkGdzc8nVJALHkuLJdMNILgJ4F1qaY3/HnCWwfCagaAIm52nW9Rn+Fzz/m0KMBE0NpWKSw1epmQ+gOKzGMuUEusggT7LnII5NPc7qpeVT0eUxa7FzS+rtHsA2yAzvBbJrkIWpxdQ07D2sKWTRSnHynBRztv+ErKlt7AyeFxR7q14YUyoBak/J2PVAVHLLevf6+KeL8X9KygQLC8XbLVV4/W2/w5YAO2jOR5/reU7MMao9xUfjTFkiTHteFQ46E8sRPnOX0do2uB17FiCjIcyHOQWq5IDvTf6UX6FOswUXMx49ud+CR5G6rjUHwt6Ilp7xj3D7a4nxkr9ANh0kuxj6YhRwBDzilQwjTnZodY52
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(9686003)(86362001)(38100700002)(2906002)(5660300002)(53546011)(478600001)(6666004)(26005)(6506007)(4326008)(8936002)(54906003)(8676002)(66556008)(66476007)(6916009)(66946007)(316002)(33716001)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWNlUW5acjMxODhjTmJTeHF6VXkxYWdaZXY0L2JRSHBSdlFHTnFQejRYTisz?=
 =?utf-8?B?M2FXQXh6dWJ1VjJQWmlmREpwcDArUExXWDhMK2pKWEY5NGNyMUdQTDZob0NP?=
 =?utf-8?B?UnpDTGtjOWxTZExpOVZLQVZjUFl2cVNEWkNOYkdxOVlCK0thVk9LWGkrQStZ?=
 =?utf-8?B?UXZBc3ZKM08zcWt6SE1BaEhTTWY5RDJxYU5pTFZvamg4TVVWaTRsTHZ6SXBE?=
 =?utf-8?B?SHlySzloWGlpbHhzc3BucnBnMVZhb3FLNlpoVzFCaVpURU9jYjBYb1lHaDls?=
 =?utf-8?B?cUo2c3hqR1FZVjZrREQ4UXdqa2VpNmtpRkk5QWw3K2p3NWZJMzczN3lhTHJi?=
 =?utf-8?B?am9hSkExMmJFN1RGb0xjVVZ4RlRCdWk3ajgvT2htcWFGbS9KbHR4MDdIdFNM?=
 =?utf-8?B?OVJWOWVGZmkxdjNtVXNvK1pMMGMrMUpZTm92WGtVY0Z6dFUvTEFuTkNxTEhS?=
 =?utf-8?B?bmMwOWZTV0RZRncrdXZNVEFiTytHR0ozZEpZNzBja0pyWHRiV2V0bTE0ZitM?=
 =?utf-8?B?QzNzVEpIOTF0MkJHQWh3S1VkYWtNWTBVdWVBY3ZqM0h1NEFlb0l0VWtUSzB3?=
 =?utf-8?B?V2l2YWF5SVB4VGVEVk1tYjNWQk01dmlQbER6QWdHejdkMTVmeFV3YU9UcDlS?=
 =?utf-8?B?RTNzdjZmY3NLeGFNN3B2VEJuVkt0Nis4WTM3NEZoNWRiMFVqdWswbDNrdUZH?=
 =?utf-8?B?NDdjVFNJc3VrSnpMRFB0dndsZGJWMjhYWXhnWFJvUk8xa2p0TVlqTlVNaFNK?=
 =?utf-8?B?WmpmTGxmWkQ5Q0ZPbkM5ZUFnOXJsbVFLNkhKeDRHV3RqUzhibkk2NEo2OEhV?=
 =?utf-8?B?L2Y3MVVQYllqTE54M1ZPTU9QZHVGd1k5THVQM0hjS21JRmZYTVR2VU9BNktT?=
 =?utf-8?B?WUtMWWxXNzVJYkRIR1VwbmkzR1A4NDNTc2RkTHFMbmVnMXFXeENBRnI3OXRu?=
 =?utf-8?B?VDhXdEFDK0hMU25GMXNQeDVpZ1dGRFZwVVZYUXJEYXU0dlhXMTVJUzJFMjRk?=
 =?utf-8?B?aTljTllVdm5OU01rYi9hWXBuSFhyaTdKUXZ2cWt3M2xiNGtVVTVKejYzb2Zt?=
 =?utf-8?B?L05HNXRpL3I2VGMvL0tFQzg5Y1ZOQXBYK1V6Vk9rSkY4TVRVM1dpclFwZ0tX?=
 =?utf-8?B?RElsQVAzcFpFVVVHdUI0YWdrY3lJQTlLc1BnZVBTeksrS2M0K1JMc0dLVVcr?=
 =?utf-8?B?czA2US92MDRnS0xvMnExVHc1aXdCbnN5STQ1d0FUU1EzcTZKOTZvUWNpOVk4?=
 =?utf-8?B?dDhCMXYvR2RlYlN1dENnZTdTSE9oWWJDOU1tdGdOV1FLRmFta2lyaDhUUHls?=
 =?utf-8?B?anpQTEpCL203K05aVDBaaHdxaTkvTU1FMGFDdVNSbmpadGU4MTlCYWpNVENZ?=
 =?utf-8?B?aTNwaXcyQlR5V3MzY2txd0t4S0JqUFA4Y2p5cXNkTDFWc3RRQlgrL2NodUc2?=
 =?utf-8?B?R1N1UFRHTEdoM3pRWjBtQnZCZ1pEelprQ0JvSDl6RjdGNWNlWjE5eExqUndI?=
 =?utf-8?B?a1RBZnVDd2JUb2pBbUxWNnQyUkZ0TDh0aGlvUEtvYkVvcEcxTmlVc2VXc0NB?=
 =?utf-8?B?VWdHcSsweUluVk10VkVYTE1kYnUxRk5uSHVPV2dlUXVQYnM5ZER3T2xrL2p4?=
 =?utf-8?B?VGVWZ3EvRjBueldjNEdReEhBR0loSjFtU29rZWZXZUQ1MTFQUVJ5VkRBOTRj?=
 =?utf-8?B?NERNSmVrU0dWOTlBQ3FzR1dxWVV0M0FkZ1lTQzRyYzBId3ljZmpzTjE4S0JT?=
 =?utf-8?B?MnZPVEQ3SjZTTGdtM3NpUWJHc0dIMXYxTEpOYys4UXVML1F2dWdITzNqRFdZ?=
 =?utf-8?B?Nkd0K2MraS92N1MzWjJ1Q0lHS1VNSWlOQkloYzI0eGdhN0FjL0VSODNVYXV6?=
 =?utf-8?B?RWlQTDhWcVBkRlZqUEVsZFovYWlzWnFVQ2NzS1hxNERtQ0VSWTBUdVg4Nzhv?=
 =?utf-8?B?WCtIUHB2RzgyWTRDSnQwZDhkT0ZzTndXcFVpLzFNNHhRaEhyV3FrTkNNckRQ?=
 =?utf-8?B?eXVmY2VJZE5MUVd3MzNLUUljUEtLeDNoSDBCMk52eE9pWkJzeHFmcTdKQnNx?=
 =?utf-8?B?MlFKS0pncWoyL2ZmTnVBUldLUG1BYXRRU1JBcEluNGJrSVpKZWQzazhOSzg3?=
 =?utf-8?B?SVVnTHdvK0JPbzdSZklaS1VXWnI0RFZnb01KdE9LaVlNK3cwWDFOSWpnUmpH?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3821642-b356-45a3-4108-08dbdc1f1b4d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 03:43:56.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsFUMtDGD/yz2TOV75DiVmspHOLYE7Tm5VdBKKiNMsJHF6uS1LosrMm3SIR++Idasxz6RCj1MalXAYZ0ANN+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7996

On Thu, Nov 02, 2023 at 09:17:33AM -0700, Andrii Nakryiko wrote:
> On Thu, Nov 2, 2023 at 7:40 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > On Wed, Nov 01, 2023 at 08:37:49PM -0700, Andrii Nakryiko wrote:
> > > Add a few interesting cases in which we can tighten 64-bit bounds based
> > > on newly learnt information about 32-bit bounds. E.g., when full u64/s64
> > > registers are used in BPF program, and then eventually compared as
> > > u32/s32. The latter comparison doesn't change the value of full
> > > register, but it does impose new restrictions on possible lower 32 bits
> > > of such full registers. And we can use that to derive additional full
> > > register bounds information.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> >
> > One question below
> >
> > > ---
> > >  kernel/bpf/verifier.c | 44 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 08888784cbc8..d0d0a1a1b662 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -2536,10 +2536,54 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
> > >       }
> > >  }
> > >
> > > +static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
> > > +{
> > > +     /* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
> > > +      * values on both sides of 64-bit range in hope to have tigher range.
> > > +      * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
> > > +      * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fffffff].
> > > +      * With this, we can substitute 1 as low 32-bits of _low_ 64-bit bound
> > > +      * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits of
> > > +      * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at a
> > > +      * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
> > > +      * We just need to make sure that derived bounds we are intersecting
> > > +      * with are well-formed ranges in respecitve s64 or u64 domain, just
> > > +      * like we do with similar kinds of 32-to-64 or 64-to-32 adjustments.
> > > +      */
> > > +     __u64 new_umin, new_umax;
> > > +     __s64 new_smin, new_smax;
> > > +
> > > +     /* u32 -> u64 tightening, it's always well-formed */
> > > +     new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
> > > +     new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
> > > +     reg->umin_value = max_t(u64, reg->umin_value, new_umin);
> > > +     reg->umax_value = min_t(u64, reg->umax_value, new_umax);
> > > +     /* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
> > > +     new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
> > > +     new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
> > > +     reg->smin_value = max_t(s64, reg->smin_value, new_smin);
> > > +     reg->smax_value = min_t(s64, reg->smax_value, new_smax);
> > > +
> > > +     /* if s32 can be treated as valid u32 range, we can use it as well */
> > > +     if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
> > > +             /* s32 -> u64 tightening */
> > > +             new_umin = (reg->umin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
> > > +             new_umax = (reg->umax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
> > > +             reg->umin_value = max_t(u64, reg->umin_value, new_umin);
> > > +             reg->umax_value = min_t(u64, reg->umax_value, new_umax);
> > > +             /* s32 -> s64 tightening */
> > > +             new_smin = (reg->smin_value & ~0xffffffffULL) | (u32)reg->s32_min_value;
> > > +             new_smax = (reg->smax_value & ~0xffffffffULL) | (u32)reg->s32_max_value;
> > > +             reg->smin_value = max_t(s64, reg->smin_value, new_smin);
> > > +             reg->smax_value = min_t(s64, reg->smax_value, new_smax);
> > > +     }
> > > +}
> > > +
> >
> > Guess this might be something you've considered already, but I think it
> > won't hurt to ask:
> >
> > All verifier.c patches up to till this point all use a lot of
> >
> >         reg->min_value = max_t(typeof(reg->min_value), reg->min_value, new_min);
> >         reg->max_value = min_t(typeof(reg->max_value), reg->max_value, new_max);
> >
> > where min_value/max_value is one of umin, smin, u32, or s32. Could we
> > refactor those out with some form of
> >
> >         reg_bounds_intersect(reg, new_min, new_max)
> >
> > The point of this is not really about reducing the line of code, but to
> > reduce the cognitive load of juggling all the min_t and max_t. With
> > something reg_bounds_intersect() we only need to check that
> > new_min/new_max pair is valid and trust the macro/function itself to
> > handle the rest correctly.
> 
> Yes, I thought about that. And it should be doable with macro and a
> bunch of refactoring. I decided to leave it to future follow ups, as
> there is already plenty of refactoring happing.

Yeah sounds fair to leave it out of this patchset. Thanks for going
through the reasoning.

