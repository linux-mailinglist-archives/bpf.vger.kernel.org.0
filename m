Return-Path: <bpf+bounces-14864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578357E89AB
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 08:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BB8B20BD1
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B6979F6;
	Sat, 11 Nov 2023 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S44fEx1J"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2679D9
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 07:55:01 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD0B3C0C
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 23:54:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgYjnV895lG1Ox8TAjPTaFA8dCRYNJz5RSJos9dE6pnWg7pZVNX73RxL8r8VCozYh//abT7lCf6XWqLL7kIFmEAtfcaXR9g855BBLs4+ClBbdtuzxziInEQeFnzoELCeIFECnac3p7UkT75QAAiMbBQPLpeMa6n68YbdnDQWl17XDVIhWlrHyTqocG2CB+/sFXjHs5sJeui1H28E3tkkHks7jCe730jlGwNCdsshvUWlBitZV1imiDyaWTFSiEknGfu01A71MtOBvWnhfj0LHW9P5RB691nQnFVZgk+vYbQq3Pi45kFLMaMWUuMTcJ/hjRSBPPdd34LlDlchjp7pkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxKtX9/z6OGRKJAz8WjdRt78WR/L3SOGYdVpY3RjyKM=;
 b=oTn1Mdn0fvkZ/E1StfVeWBr8k8M1N9myyAbWhr00niuo1dCUc6O5LLgsfrvr8ujragZwzlrdXBzkgweKbRE8PbwyWDGjxNkGCjK3L+K/u9aTOOc7rd9ddKR+6UTpFGbr+YZJrdEk3AZe2PXl69eVSr+iAgLEyfqltEFRbJAmi0ytjamprV4zmQrbgMXzZCoxeK8my6i4H2NTtOcO4zIvgKnmKNZ9tcZCUpOdnWawIRVOM8qHzZslKEfIgzNZy4P1ksIKj7QXzy8DRpDhDdnm+T5h8KuajvLWX8QMHspLhytA2FfFVA0btuOaw5jHmjUp7nYx/YlEHD5incsHxSNOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxKtX9/z6OGRKJAz8WjdRt78WR/L3SOGYdVpY3RjyKM=;
 b=S44fEx1JKPJJXNuva6+siVLwRLXPBAFqjECv0FlU0X5YhkVImg4HKpZ4djXQIzAsSe4n2ZYqQLDKBEnIOm2qDpiTS/lad3aWACCCBhCQxxUCHfHJ0W77qM3BEyB3f3mjtwb2AtAfolU3fWJoKCrUbIJk6uRnxNpAHRe9qBeQPh5Fww3kmgyhnqqBkC7QXoBbH/QwH0a2vqSu+uhDsmr7VB/t1AjMQTJKpbUOTEDdc9CoF2V/HHaPss/OFnzYz7hImLkaUYlBHlKB+XkxFSUcfvUV87ZXj2/4+XD83Zzh60sBYregOgDoJXmokygf1kgJEHQaiX+iONXwgxjs4cQycA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by DU2PR04MB8517.eurprd04.prod.outlook.com (2603:10a6:10:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.12; Sat, 11 Nov
 2023 07:54:56 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%6]) with mapi id 15.20.7002.010; Sat, 11 Nov 2023
 07:54:56 +0000
Date: Sat, 11 Nov 2023 15:54:46 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Paul Chaignon <paul@isovalent.com>
Subject: Re: [RFC bpf-next v0 0/7] Unifying signed and unsigned min/max
 tracking
Message-ID: <5c3c3lnjih6hvljm6kozus7wzk5qwqkm64emirct4v4nkdozfg@faq6srd4qqu7>
References: <20231108054611.19531-1-shung-hsi.yu@suse.com>
 <CAADnVQLRjj7nQg02BAzToDOZvtk6P9f5UN010Nyb2negcPzoWQ@mail.gmail.com>
 <ZU74vP8US-QnwHrK@u94a>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZU74vP8US-QnwHrK@u94a>
X-ClientProxiedBy: TY2PR06CA0045.apcprd06.prod.outlook.com
 (2603:1096:404:2e::33) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|DU2PR04MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 618d64a3-9b25-4b40-c1e3-08dbe28b7f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rN0c67CJCUuNh+YzFbdHR+e32mQ7mxFn38sKQUkKWLcdugMjadmsY5E4CjCghX4ZvLB4HN1O373MUpBacSgicQOrbwKOnklD4gNFqhj7xH6+p8yYmc5kD0O3ECRSQw0LNg3oa9wIWoFS7Clwhu993C4dtOFiK+cDqB+tjGcjeglcjQHcA45somkB3gFELQ9CrZVDZZcNUWZEoaMAo5nyYGGu/AEGC58z2ifGc6WrbRHW88MEXVdBrRC8NTn23yvSD1TocuslvZzT2dAHJgy82l7rt6drpvdHfG0kPfYdB2wfaliFXid9P6E02OoKy/P0xdYIErumW7ERuGe1GicDJiif1MqcnW5aIeML1Va6jtsHuLlnap3FEpJ1t/vSzl0fph6KeCznhnpfzfqwRnlidQctLzPWwUSauo+S5CuOs6R44BDWLTmdN2lgTauGX30CW1wXxaeBOMobZvf3+N/p2K/D7UMqcasoRUHEzFua3MDYt4LxOx7r3jpWwLs5VoRmS6YVSownWTlnJWL45v2AB5/PFBQFD6frJnuzaqwLJRi2WZLBtUNLkuWupLV3RTFn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(39850400004)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(54906003)(66946007)(66476007)(66556008)(6916009)(316002)(478600001)(6486002)(6666004)(86362001)(5660300002)(41300700001)(2906002)(33716001)(4326008)(8676002)(8936002)(38100700002)(6512007)(9686003)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2lKcnA4bEp3cXE5STVrT2d0YTA2QTBpMm81RXRkcHk4MUdKVkpGTm15aXVF?=
 =?utf-8?B?MjZrMUpheERDVTZUVGpTc0NzYm5KdVBUd3Y4Mm5QK2U4QUhjWHpKQS9PV1p6?=
 =?utf-8?B?ekZrN0hIeDd4c2RxdmVJNU9CYzhoVUlUSDRIdEFBVzkvdWM0QXpzOHdveDJJ?=
 =?utf-8?B?aDBVSURvRHNOdFdsNElXZVZWUUNxUG95NEFhQ1dvQTRuc25nYjd0TkMzRUU5?=
 =?utf-8?B?UkVDSHRuVTVkdkhwUzVWTDlEcXE5YUVOVE9haWZCa1A4elI5YXdpZ2U1R2FQ?=
 =?utf-8?B?Nk1lc2JzbG1MdXdqSEFvMG1USDlnZ2RVMWtmNmI3b2RzR3Z6WWFQL3dveVdR?=
 =?utf-8?B?eXRBd2oxM1Y1NGdJYmdtS1FOWlc3SFNUTDVNUWZYT2lQWlFkMGlCN2hjZzg3?=
 =?utf-8?B?bUIzOW5BV3h6NHRnM2dqczhvKys5T1dXaUVpYjFpd0V6bWhHS21PZFRCcHBG?=
 =?utf-8?B?SVRNUHZHSXRURmk2TDJWWVh4YmZTMXU0bVlRZ3FsZVl1NDhJSS8yWU9mSlYz?=
 =?utf-8?B?RjNTMWg1dVc4MzdiL1V3RFFMaWhSaEo2cUNFclFwYzR4VitCemxiNW1OUGVr?=
 =?utf-8?B?UlNMN3EydnBzWEs3ZFBid3Ardkt3R1VBZDN4UUVBTm5mVnZsZkcybDMzT2cz?=
 =?utf-8?B?eUJ6QTR2azkrWjg0SlVUYlNnaHdrcG1PYjVCVVJrUHkyd1U2ZWxzQm9CdTIv?=
 =?utf-8?B?ZVEwVUVYSUFIcGZTQjJta1RuZ0JnUC92eEZyTEZRNjJGWEdOQ2JtaG1IUXpk?=
 =?utf-8?B?QVlqMHJrVzk2N1MzTC9MYVZlYXcreGtRSCtScW9peEVvSjFEaklzTTBBaUFZ?=
 =?utf-8?B?MjlZNGl4ck5nemoxM09sWmUxdm8xMDZla1FicEFiUjBmRUE3WWVEK0ZHMUs4?=
 =?utf-8?B?VEQ5UGk0T3RQZlFjU08yUE90WXl1aFZPaDROY1JlWW05TjVOb1ZIWDNvdyt5?=
 =?utf-8?B?VDlwRTZkV3BkTkQ3LzBDWXVkRHFma0NtTkpxMVd5ZVRJY3dsNVBuNFd4VEpy?=
 =?utf-8?B?VUxKdWZabGtVZzBIWlphZnEvNHE1d1RWaVFjNkF3UDJNZU0xSTJ6WUdmbjM0?=
 =?utf-8?B?ZXJEaUhSbzM2Ti9Vc05KNkFGRHhDVXhBUmNYVUNncVR3Y1NTOVNSV21ialRV?=
 =?utf-8?B?WThIaXpPaTR2eDdtMW5aWW5UWEI2RktOSm0rMlAwS0pueWxpZGJKU214bnow?=
 =?utf-8?B?MWhBNTgxc3Z2NCtEN3R1Z3JPR0pwdzVGT0t2ZEIxb0I1OVY4ZkJsMWJQb29z?=
 =?utf-8?B?eUNybStBRmtMcVUvTTFjbkZod0U1T1ArOTRDcmRoTUd1ZUp5b2FCM2s0azVT?=
 =?utf-8?B?NTFKaFdYOGhhR0NOa3ZQYnFFWmw1dlgxVHhCUXliZGdKWEdrQlcwMkdUaWRr?=
 =?utf-8?B?YTFFSzVKd3U5MTZFNHFISWJDUEdCR0JyNDNDKzZQV0R3dmVLWjJQdjRhK01E?=
 =?utf-8?B?ZU1QR0xHK2RsdXJKTFg1Tk1FVWtHaTNsU0ZDWk9wcVNWbjJPZWZrVllWRVlR?=
 =?utf-8?B?T0dyeHBRR3htR0YxR1N3anFsa3E5U1JpbFZqc0ZzQkVOeVRBUVFCQWFweXox?=
 =?utf-8?B?b2t0L0xpNzhQMUVpc01Rd0kyQlFhUk16K2JoZENLRmZvdFRuU2sySVVXalhl?=
 =?utf-8?B?WktZUTZ3UkJJQmF4RlNJUm04NGxjckU0aGdOT1lMSkVvaXYyRHNHYUpKcHIw?=
 =?utf-8?B?eTh1NjNoT2x3ZDFpRzVkUTFsaHdPS0x3ZG11SnIzWDkvWGRSbUxQVFIvbFpq?=
 =?utf-8?B?QnVyeWhjZXlOdzEvSUpIenRiZ1lSTVF6YkErd1JkVkROd2FGdkVMTlRjYTdw?=
 =?utf-8?B?UzAxTk5wSUtYeDRGZ0ZkTEZjYTlVQklPVTVLNGRSZUs0OXQzandCUno0RDUr?=
 =?utf-8?B?eHdGV3greG9jU1N4a0U0VjdoeTMwTDh3RmFsTDlqeVZnU1F1V3c0dUdZNng4?=
 =?utf-8?B?b2FMdzNoVTNSOXlGdXgyY1J1SUdpUUMrS0toRzMrWGpxYWMzYlJhRERTSkJI?=
 =?utf-8?B?aG5iVU5ZV0E5VkNTRlBPdHpTcjJtL2dUOHpLNFV3T0oyMGdzS2hEVUJ1ZkFr?=
 =?utf-8?B?RXhxNjNFdDdvdGFoYmQwOGgzWlNSaHdUUWY2cGU1QlFvV1V5WHV2a3p0bU9Q?=
 =?utf-8?B?MllFcjNjQStXWTYrQWdqeW9kK3hKc3VoMCtpUlVBbWxwWkhlM1hya0FxNVpG?=
 =?utf-8?B?cFd3MjdDMG1FbWtOVWphWk9tTENoaXlZZVJXbnNpTjNGWXNaN1R5U3ZTT3ZV?=
 =?utf-8?B?TmZ5emxkYWdUUVZKN0FNbXlVRWhnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618d64a3-9b25-4b40-c1e3-08dbe28b7f02
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 07:54:56.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvUpMDgChgvPqEdgg+ii7f2SA8nZXPBQrAMIV6Q6E2o+h+BgSU9tu3WNZbPZn9bdgqR54FhkstiSEy5ccY+a3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8517

On Sat, Nov 11, 2023 at 11:45:22AM +0800, Shung-Hsi Yu wrote:
> On Thu, Nov 09, 2023 at 11:38:09AM -0800, Alexei Starovoitov wrote:
> > On Tue, Nov 7, 2023 at 9:46 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > This patchset is a proof of concept for previously discussed concept[1]
> > > of unifying smin/smax with umin/uax for both the 32-bit and 64-bit
> > > range[2] within bpf_reg_state. This will allow the verifier to track
> > > both signed and unsiged ranges using just two u32 (for 32-bit range) or
> > > u64 (for 64-bit range), instead four as we currently do.
> > >
> > > The size reduction we gain from this probably isn't very significant.
> > > The main benefit is in lowering of code _complexity_. The verifier
> > > currently employs 5 value tracking mechanisms, two for 64-bit range, two
> > > for 32-bit range, and one tnum that tracks individual bits. Exchanging
> > > knowledge between all the bound tracking mechanisms requires a
> > > (theoretical) 20-way synchronization[3]; with signed and unsigned
> > > unification the verifier will only need 3 value tracking mechanism,
> > > cutting this down to a 6-way synchronization.
> > >
> > > The unification is possible from a theoretical standpoint[4] and there
> > > exists implementation[5]. The challenge lies in implementing it inside
> > > the verifier and making sure it fits well with all the logic we have in
> > > place.
> > >
> > > To lower the difficulty, the unified min/max tracking is implemented in
> > > isolation, and have it correctness checked using model checking. The
> > > model checking code can be found in this patchset as well, but is not
> > > meant to be merged since a better method already exists[6].
> > >
> > > So far I've managed to implement add/sub/mul operations for unified
> > > min/max tracking, the next steps are:
> > > - implement operation that can be used gain knowledge from conditional
> > >   jump, e.g wrange32_intersect, wrange32_diff
> > > - implement wrange32_from_min_max and wrange32_to_min_max so we can
> > >   check whether this PoC works using current selftests
> > > - implement operations for wrange64, the 64-bit counterpart of wrange32
> > > - come up with how to exchange knowledge between wrange64 and wrange32
> > >   (this is likely the most difficult part)
> > > - think about how to integrate this work in a manageable manner
> > 
> > Thanks for taking a stab at it.
> > The biggest question is how to integrate it without breaking anything.
> > I suspect you might need to implement all alu and branch logic
> > just to be able to run the tests.
> 
> Once the wrange32_{to,from}_min_max() helpers in patch 7 is implemented, I
> should be able to swap out individual alu operation while keeping
> bpf_reg_state untouched. E.g. for addition in 32-bit
> 
>   static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
>                                    struct bpf_reg_state *src_reg)
>   {
>       struct wrange32 a = wrange32_from_min_max(dst_reg->smin, dst_reg->smax,
>                                                 dst_reg->umin, dst_reg->umax);
>       struct wrange32 b = wrange32_from_min_max(src_reg->smin, src_reg->smax,
>                                                 src_reg->umin, src_reg->umax);
>       
>       wrange32_to_min_max(wrange32_add(a, b), &dst_reg->smin, &dst_reg->smax,
>                           &dst_reg->umin, &dst_reg->umax);
>   }
> 
> and get current tests to run on top of the new algorithm. This won't cover
> every aspect, but should be enough as a first taste on how well (or unwell)
> the integration will be.
> 
> These helpers also can help to create finer intermediate steps for smoother
> integration; something that's added in the beginning to aid the transition,
> but removed after the transition is done.
> 
> > It's difficult to see a path for partial/incremental addition.
> > The concern is that at the end this approach might hit an issue
> > which will make it infeasible.
> 
> Agree. While the helpers above can aid with integration, I do not see a safe
> path for partial addition. At least not before everything until
> reg_bound_sync() proofs to work should it be considered.
> Still a long way to go.

Meant to say "everything until, and including, reg_bound_sync() are
proofed to work", since it is likely the hardest part.

[...]

