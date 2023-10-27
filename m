Return-Path: <bpf+bounces-13408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0F7D90E0
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 10:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A0C281F57
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECA134B7;
	Fri, 27 Oct 2023 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="3jEMJ7rj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C0125CB
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 08:16:39 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3CC196
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 01:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzLCmClGvrakYCrTPXwA/I44goKj7BmMRY3mRpz7MFMhkgRmm9ACXkPpYTgkYpYMU410zAoqmof6d+eiTJ2pJTvCkpRVZf76zEtvheFVWa2iEZl7dwz7zBswjmqL2WQwVePYZs9aCBItyiHnJFVZY4ruzE4nC1stcSaAhhVHUAhhbZv8aNOR43n8kpFfrpPik8sW9few9j5BbsaBXbe6Ms1Tqi2eAt/bahY682DQGDftcLu6svC8R6XTHRKx0M14EjXhow2R5S+jVQGW1m9jDESCC8tMKrEufXW7n+bNhRnlQcVdGlTMwvHCGHRY6mS0khvDwd0bNNKp//vf2aln7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjyMB+Q8pp2L0xzyJoZVmkjqMpg3IbBMJC1PSA9LibA=;
 b=OGAP3RzCnedApxTxxB8RHU/9Rb/cUbbKuNImCjxY966jjudnnEhOhx3l1tQ4qE7KQ066VZnLuA9NGzKSsz3uOUMRX8q1wFxJIewhqS6hmYgLCebFCpU9iWemRV4G2OzXBqAJNPWQ/pAdI6ek9kxelqvhLr03NKSt33rHwGWF8njEOuuGQ1IOB9v0BOW8DXupUpbvMgTPRGL7xEwo4yUJTks0FfZxol/EkUlzHHnXskU/+W7xR5wj2tZdkI/KNT0OiwcnhR90aqMxEyBt3wwf+77mB7qQQRW1ShGLPHGIhMtBwqVWvgXMIE+5AV5zPN9/Y4tk6sXQCqEsphEAnDqrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjyMB+Q8pp2L0xzyJoZVmkjqMpg3IbBMJC1PSA9LibA=;
 b=3jEMJ7rjsp2BvXiTbaxdbc7mkm9+lRmcnM7oLlGmyhLjtHRzcRSlGuK39x7mfqeSj/slFi/odPNxSXvJBg1TdVxJ0ToJn04w6wm2bUmbNiJek1u2Xv/PfaGZBvIzDg8a8u4UWdHih7hpccJ6Ab6GrcRmSD/+2NbGPLyQz7FLVHn1XjR2CBcY73zDSUixy+RrKi7GWTGnKOYEZrf+x+8cDzWys7tJPSMz6pSPgGqJPYzt7pi1XcavicOgzP3tV907dD/b+2p0B9+Hl7oo+ceVH5yA0FC8zCT8vMBmmsIcL7L1Tb+ZAsSmcyg1vFDbPfbNfs7LQ11/2zrCpwILkcNIzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB8624.eurprd04.prod.outlook.com (2603:10a6:102:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 08:16:34 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Fri, 27 Oct 2023
 08:16:34 +0000
Date: Fri, 27 Oct 2023 16:16:28 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: enhance subregister bounds
 deduction logic
Message-ID: <ZTtx3DxStmx3i9Eo@u94a>
References: <20231022205743.72352-1-andrii@kernel.org>
 <20231022205743.72352-4-andrii@kernel.org>
 <ZTe28jP0qFNtf89A@u94a>
 <CAADnVQ+_PrGAsQfQag0ktFHZ2pOVA2-63n-pA5=uRSu5GmWM0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+_PrGAsQfQag0ktFHZ2pOVA2-63n-pA5=uRSu5GmWM0g@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB8624:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c7380b-0a4d-423c-3314-08dbd6c5087e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qSghICa84Fuv6uhJmk+rJIfNZgoQKb+Z0kkd0YHfiDs0JWe/eElLga2Sga2YsZHAW8TG6cHYY6gRIdTcDJ8wxdMMqrPYNyY/6CP5Gc7GPajANAF2fHInrbs40Zf8BbkF2i3brGajmyez8gWwLrjwkCSdsbI4sP4Vd8Lp+HF6YU/C/ryJIllAKCG6jWjqNZfQs5w8aB/KgnGxlVo5kKgFnSiGMGuOmUy1t5kVdWik9GPrtAI1mXkF51rzlo2hoDMnYYETEpYBi8rfZ73qG9DYp+W88Vuw7gjiNHrC/y0A0eJXTDR0UmSxVw5fp4AHP21v2e8qTkNvs0M2Rn19B/H9FF3fpYqPR+A1y69LakpQH0rmqOHqC9SoWNUYCUfBe6i6rZqqG0I2BbEpLZQwiGGSLjwaiYvte3+qSBAoCTuZJYkcu9idNi68Pgd31YDsBl33SLwCTT11DW3XSvTlCG4MxCzx1YN5d4WxAVZdSteh4dLyRNuTQWKU1pJCfzS0almti0xXzH4iLrHkZu4z7dLWmDl0gtkZAdINA1fh17NtewC2V3Jv7QpEUWjRPR/obc5Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(478600001)(6506007)(9686003)(66476007)(6512007)(66946007)(53546011)(6666004)(6486002)(33716001)(86362001)(54906003)(26005)(66556008)(8936002)(8676002)(41300700001)(4326008)(5660300002)(316002)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2RXQk5rSmNWM1AzN3VEa1FWNEUzRXNsM3JqY3RxcUxpNUkwY05kUXV4cTlC?=
 =?utf-8?B?cHR0ckZ1TlMxb2xrSzVJZFAxYmx6QmkySWdZMGplMUtNN0d6NEFjWi84V0hO?=
 =?utf-8?B?NE1QUkN3a0tSSkUwbGtZRXh5eVZFdmFYZ3BuLzhoS3ZzeklOOThnaVhuck9i?=
 =?utf-8?B?ekpGb0hGdklrbU55d29GWEgvWXB4VVBCNjNHRldwQ1BjRVJhMEpVOGtXUllG?=
 =?utf-8?B?VzRUU2xDR2tCSE5uOTFSOFBxeTd3SURtUWx3aEdPMHBjZmR2NW9KMThWOVlF?=
 =?utf-8?B?U3R5Z2JUcE1GbU5xeVVSY2xnR3lkNHI5RGN5Q09Qc04xNG9KTHBWbnJ4RTFV?=
 =?utf-8?B?Q2F1VllSM0I2T0gxMnMzTmNMTUt0RzB2eHhvWnJaNFZGc2hHVHFJbFBqWjhN?=
 =?utf-8?B?S0o1VWpEaHdnRHZPaVY4ZWJFa0JJcEwyUHIxTXV0Q2xJbnQrTWJBc09rK25w?=
 =?utf-8?B?eUJ4VXIvN1l4VGg4NUFCOXNiTmc5dU82VHhrTW5qVlhOUkpNSmMveUFMdFFB?=
 =?utf-8?B?elI4WjVTSE00MThJbEh5ZzM3Q1RqZ3JWZjBUcHFhWGt1K3pnSjBkb3lxcllh?=
 =?utf-8?B?L24ralBvcmxxSThEUVlYZGwwQU5NS05sOVhrUXlXT0Qzdy9zOGRjdmlIdEFW?=
 =?utf-8?B?ZkFOYXViOURNd3NPSHA2LzF2ZjNyTGlLbHNvUnBBZmlsQ21TeC9sQnZUSzRJ?=
 =?utf-8?B?OVZLWFZZcUpEMFdwTDc2K1dEeE03WlZ0SmxPL2tFNnUwOWx6N3VNajlwdEhO?=
 =?utf-8?B?SU9zSmxHcWtqSHY2QnZxQ0xmT1J2b2kreHhIRmF0eG9sZko2WFZnOHpRdDNJ?=
 =?utf-8?B?SEt6VldWQzFxRmpOK0ZGQkhGcnpaamVxMS9iNUx4QmRpRnZ1VXRxY0JoQU15?=
 =?utf-8?B?VnFJVEJQZHQ3Y2l1bFgrOWpPbnJsT0QwTnVVMENaQ0NDRHdnSVBlOTZXQUdo?=
 =?utf-8?B?TEZZenIrcmtoYWx6VklCaUI1WE5FNVZVQVdnejM2VTVrT0VLOUV6NFNWUHhs?=
 =?utf-8?B?Sm9PV3ErbEtmeGlpSnh5cG9PcEVBNnhJUGNSS0FoMzFUeDB6MWRLczNRVU1z?=
 =?utf-8?B?ZUFZL09sdjVnTFZ6NHBPbjFrRXdJRUJXRzRmRnMxWGJFb09GREZlKytURGl4?=
 =?utf-8?B?WGk4MENUa1UxRHEvWUV4Rk0zUDVNY2JZVXlGeFA1djZvT1lid2VVdTZPc3Yw?=
 =?utf-8?B?ci85SituV1ArdTJNUHJXOXZ1THNOZGRWL21IblpxUGd3UmRDanpkbTF4YTBE?=
 =?utf-8?B?bEhwbXBkQlZ4ZHY2WFdWMXN1ZWJtZloySFBWZnUvMmNXa1VpVmNodXJicVZQ?=
 =?utf-8?B?bFN2ejdoWURlYmpLYmdjbW5LMW42MnZHSzlFVXc0UnZvQS9kQVZQblhFbmZj?=
 =?utf-8?B?MkdIaU5JZ0tCU0lENFFLV2FzenlWcWw5bDhUZ3VmOXVTbGJyODd5ZloyT0lN?=
 =?utf-8?B?VFhmQWdON3ZpampmSnRzV3E3cUUyWXBLVEVRS3hVVy8rK0x0NE5jL29vVWVC?=
 =?utf-8?B?UXhZc25UdDR6YVozUTFPUkZOaGVCY0lhTzdySG8yMHVva0FqMTlNVDBWRW8x?=
 =?utf-8?B?ZkR0bTAzU0xMNldQUDJ2NnZSR2JjdURzUXpzZG5KSG9RN0RqemFtd2N6TXFt?=
 =?utf-8?B?RmVjY3ltdXFZTHlycFFZZk9yMG44WVdHNWp6c09QeWEyS0V2Qm13Rzdoa1dS?=
 =?utf-8?B?U2hWbnQrZThYNjlhbS9HWCtIbDJFVWdvSVBTcEoyaDlyRzYzMUV2a2dtQ0hx?=
 =?utf-8?B?M3RiNHFGbkFVak1WMnN1OEJaZGJJb3cxbWVvSTdxdWZxYVBIOFdRVkJVemU5?=
 =?utf-8?B?L09uM1dsdXo3UGNsb0FoYStYYzFrRVV4bXBJU3R2SzFpQ3ZnVkQ2Vm1kczhG?=
 =?utf-8?B?ckE1ek00bnR1Y3hkaWtkZFVRQThJNnRmYlNFNzFpUEg0S1MwaXZRazdodXls?=
 =?utf-8?B?NzBJTm9TNGV4eS9jcWVmY1hKaW1reUJpQjNTbVJvSlQ2TVdzYTdFaDY1NjVO?=
 =?utf-8?B?N3llMTBKcjdxdUw1WDdPUUtUeURtUUxrYnllQWxQSkp2bzBOVkp4d1ArYVdy?=
 =?utf-8?B?Z1cxcXQzTndvbWE4czdCVzdUNERWUUdxUHB1T2s2dlpvZWtGVk1yRm5FTEJz?=
 =?utf-8?Q?ZN1zR2bp10Xo9zmKh9PpMoHHq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c7380b-0a4d-423c-3314-08dbd6c5087e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 08:16:34.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2u0+wesheO1J+s4zWpZ7Oq/jF7AjGwnR2wPhbWU9JCmlWkLZeeZ4f9j7SJp593C1R+hDrCvCd350jXMQlbj6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8624

On Tue, Oct 24, 2023 at 08:31:41AM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 24, 2023 at 5:22 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > On Sun, Oct 22, 2023 at 01:57:39PM -0700, Andrii Nakryiko wrote:
> > > Add handling of a bunch of possible cases which allows deducing extra
> > > information about subregister bounds, both u32 and s32, from full register
> > > u64/s64 bounds.
> > >
> > > Also add smin32/smax32 bounds derivation from corresponding umin32/umax32
> > > bounds, similar to what we did with smin/smax from umin/umax derivation in
> > > previous patch.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Forgot to add
> >
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> >
> > And that the acked-by for this and previous patches applies to future
> > version of the patchset as well.
> >
> > Q: I going through the patches rather slowly, one by one, and sending
> > acked-by as I go, is that considered too verbose? Is it be better to spend
> > the time to go through the entire patchset first and just send an acked-by
> > to the cover letter?
> 
> Take your time. Careful review of every individual patch is certainly preferred.
> This is a tricky change. I'm still stuck on patch 2 :)

Noted and thanks :)

