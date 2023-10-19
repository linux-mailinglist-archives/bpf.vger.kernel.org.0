Return-Path: <bpf+bounces-12678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572187CF143
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 09:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880A81C20E60
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9FAD29D;
	Thu, 19 Oct 2023 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MhM4oytP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A88F64
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 07:30:49 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0EA112
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8fEkpM4RlLa4vVjrr/5N6cB/pWolv5UgeRVcEP9SodDAJKjfmr4RZu/GvkorzINhauv7CT9XCfi+EeQLk/j3f8h6CJPwWWP5JDHxXoWb+FK3whpdMcbxQM4G0rYX08NpBB8Ct6gxqlwtP82UE0z7Tlx7yzxK4osB70Egya3/gma31kpCFaQvpeI8J6/GW3RMH2ZbMtLNPBx7c8wSFu10xCfAPS0yRr7garwj1day/1AD3MboU7wkX5BRmT1AaDWWhtJ7OREQpO21RRRNaTsNLlrFR2s9MIlPT8+04EL9DGhM8eDwmPfAgW7H9ARlU2UufAQdjvzTvofxJOFyYl9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2yEWm44hOBQjSMTmXEgAYYCPOyzx0gwuq6KtIY+YEQ=;
 b=WJtfgeJw6dfS0PE6DzoHI5ZpsbuAbYbryaz6ryO/WQ/jzrG4MOTfD1vXucFO6hzOMJu0ygwDmkf5JxumOfDUwC9cjiUV5nSPJA9tRVYvx4dJ8SvbOb/pAJnH5HEuvPw3S1t8Ks/+iGQUIhjg5mo4I5vF8CcxfAPHJARmbzAWVueoTD+zltMSS7pLCusx4nO39Wztbx2n8bd+5e6fswguIWCMSgyxThx1b8BJEeoaX0ZsNU+7vlQlot3oz0sy/QrUS2PX/De8nAKVEDTXHa3t7x21tef2swuPoYMpFVQ4g8YXsFOIopgCKYFlQ5n5DgUNC5f+YYYLLfD232FC2R4f8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2yEWm44hOBQjSMTmXEgAYYCPOyzx0gwuq6KtIY+YEQ=;
 b=MhM4oytPWB/PVWJvKmuF+Wm+wHBj/yppXud0dfs9jmnbUtLVhGA/Z1SeSfjbGXV4KZEKVqizv5TaYf5Oa8alKlkYSgIx9hQZXEHUveB2iK+hIu8CPEhki+THOC6Ebef0lrlzGMBhWqqQ9OoQdDSBW9yWxfFFv1/fc78ct668FMIBBjLr14H4fRORHSwSS33RsmNY45ZyUH3zy+/9G4So/bPTR1kMogHhk6kSir2wsz9r4tDR43UF0tLAy9SKOXU/TvsVh64G66+1WZFdl851OwA7AcR61qfiejzBMTagScn6bI37jbbFmxoy5vvlonU4xXz9a15gO7Xv9od0x4ufeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU2PR04MB9195.eurprd04.prod.outlook.com (2603:10a6:10:2fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 07:30:42 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 07:30:41 +0000
Date: Thu, 19 Oct 2023 15:30:33 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Langston Barrett <langston.barrett@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@cs.rutgers.edu>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Message-ID: <ZTDbGWHu4CnJYWAs@u94a>
References: <20231019042405.2971130-1-andrii@kernel.org>
 <20231019042405.2971130-8-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019042405.2971130-8-andrii@kernel.org>
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU2PR04MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fff6400-5459-4ee8-ae9d-08dbd0754c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/hKgStZJWCuijlnbRp/kE/jnYtbsY1t8/gDPhnMxx291SKGlxYH0AhRp3xc+3zzPVRX8FTnDtji5TzT6/TJBCcFkb3Tqtv7RUdZafQHS/yJxFWzEmv5NuzzaQiDhrHng4WEItYaCKqJvP5WcfhvEz+ABIk01YTwyxlCHiWsXpgtdFzz+Br5B+7MNMl8DuBSKT1H6W6kf6gZeIlOxCEhRw9uj1Rc0XKvLU3fQQaG/VSEGRBH1DmvyeeMQZUZdTfS1SWzj3qngeZLWDEugsUnbYdf7EY1dye+4IW+CpfluJuP3PgZoofmQ2iwPJTvpl7LpP4VM9uoy+/rsyKm742GB/1U7LNhoB548wkwclWpW1tfR3SdgQsUyWUz1Ec3VldeZjtpqMAKjzMaeqNyqAR2T8r6L/EQZvc1XNgBDfSjbgrNbT2fWvHWdyaEhpy6wpaxTdL3Bw/CBE/myyYL4XejPEpH09/XXBTlDDuRk0KXWLNorK81q/SwI0tDufRSq8/QfvVcNAUm8Z4u1kFcms31HHycTYYSs92Bylu66igs7aBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(5660300002)(6506007)(33716001)(2906002)(6666004)(8676002)(8936002)(4326008)(41300700001)(6512007)(54906003)(66946007)(66556008)(6916009)(66476007)(6486002)(316002)(966005)(478600001)(9686003)(83380400001)(26005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlpXby9ZUmNEcmlwaWxLSWE2YlhmbUV4UVBCNjVteTE5V2daeFZxaG5MUUZP?=
 =?utf-8?B?NGhWNjBwOGZPN09FTVZyY1pkRXQvSlBkVHdRTUFSV0FtRHZNZk1melB1U0hQ?=
 =?utf-8?B?UzRZb0FuckdnNEJMNGdxdEU3UjdDR3VrUnplbVVhY3pBdWcxR0tSemJGM1RN?=
 =?utf-8?B?aS9rek95Q2E2VWRTbmlaajBTUnA0cXlQaDRDa1JtRmlMc0ZnNENXdE9UajFm?=
 =?utf-8?B?YzdiOHFKbjJiOEVueml0elJub0tyZ2JVY1loaFVuME9VUE9pTG8vTkZBYTh4?=
 =?utf-8?B?Z09VTUg4SEFjZDZVVGs0VmtUYlNvc1AwT0pCZ2NqVXlXZGxyZjlCdzVWdG1U?=
 =?utf-8?B?SkxyamtYcGw4SmVSNFJVcUdpNVZZRmxjWlVlYW1YMFFQdkliaTFtcTUvZzFl?=
 =?utf-8?B?UnNGeW9KZlc2bDZEZlJ5SCsySWE3Qmh0Q0FPdENPU21HSUZyR09nY1ZpdW5n?=
 =?utf-8?B?ejhPcjJBM1ozMXpJOXNVYm1CYVUyaEZBeFJSVllXa3FCYWw2SVNmMmd0TnBa?=
 =?utf-8?B?VGZPWlNSUkJ3bXlmUUw5VktIZGNBOXdqcnh6WFoxRzk5SUdlS2FCYU50V2xm?=
 =?utf-8?B?RmhkYU9VN1hFazBENnllWktwV2EzQUZaZzVUNG85YTFpajhoM2lBN1lJc0tP?=
 =?utf-8?B?UXpnTW5jd0s2S0VOUUpqMkg1U2crL1pjMm9SS3pXSFhQVVJIaDNOVE04TGhu?=
 =?utf-8?B?bDdxSGozaDFBTTJiYlI4YVpYZEJRUFdaaWQyc3gycE5uZkUzSTNpUnpRaHJT?=
 =?utf-8?B?Q01jRHBENmd6YjRzMUlIM2FVNmpKcnR4eDZld1Y4ZzZMYkxhUWprSmNMTUNP?=
 =?utf-8?B?cGF3cC93eTRCTTllMkpDcUV5Qmo1YVFlNzh3cm9kbWJ6QzVnRDRoaGltZG5H?=
 =?utf-8?B?Unl4VHNYN25CaUV3djBpakJmK2dNcnU5ZUo5aUZpV1NzYTIySFRhUTZ3cW4x?=
 =?utf-8?B?RGxHQmZyam5td1BJNEd0S0JiU2V4RHdPMlR6MStHUjVzM1hqaEl1bW9wR0No?=
 =?utf-8?B?NXRIMGlxdXNwejZ3TXd6NEl5MTV2enVpc01iUEhyRk12bG1GdWlOODJ5UWFB?=
 =?utf-8?B?dGZadDNHMlVzOXZRUVhaeW0vSm0vckQ1T201NFNSUEwvTWt1ZU9PZkJmSktI?=
 =?utf-8?B?azBkbjU0SGthNUppcnQ0eDFMMyt5bTVjWUtxd1NucUEvN21sNnFsM3hOQ2RP?=
 =?utf-8?B?aFl2VFhURWE0K01ZaXh2aFlQNGVmVWJRWlp1UkJuc2taTG9CY1lLc3BocHVV?=
 =?utf-8?B?OFNRWnBieTVsMzVGYmMrK1ZwNzBDVGZXdWtvYjArQ1ZnMFpUWUtaT3dFOXRS?=
 =?utf-8?B?dFJsQUJHcTJrb2MwR2dmdHkyUjA4dFZVTkdDZDF4bTdNbE9NTEVKY1Vyc3Bs?=
 =?utf-8?B?eFF1U3pLaTBMZ3lIc2tqek5mWWJUNVV5aTd1QWtPNmo5NmVUMzZYMmNoOEJl?=
 =?utf-8?B?c2JKdkdzNzhMOVlOR3M0RGd1dG95VzdTR1ZRYWE3UG0yNnNBSk1BaUNYWERR?=
 =?utf-8?B?cXNja0wzckFkQlZoOFBMakFnMTVHMTFZckJkcXdpeXlzZDRPa2pKR1JqTUd4?=
 =?utf-8?B?QllQaUNEamtMM3d5M1U1WGM4bmNrSE1peHYrR2pSdTJFdXVOR1plQzJkQU5Q?=
 =?utf-8?B?NzlESnFXaXk4UDFCUEUwSHhqSzU3bml5dnlFT29ONXUvNitpOUdKQldPM2dI?=
 =?utf-8?B?ZHovWFZnd3BlVWhJQVdWMll4Ylg2VTAyOEh3bVFCb1hxQ1BlU05ScVZkNy9Z?=
 =?utf-8?B?WnM1MGtlcm1UcXFma1RrN2MxYm45MlpwTUxJTHBZZnRZcU9XYVZLWFUxZTVk?=
 =?utf-8?B?a2FSdnQyU3VPUHk4SVYzUVphVmczOW0yR21tWVI4ZDFkSUFEUjBCN1hSdGlF?=
 =?utf-8?B?VUI1NmpqZnViQ3lwUFFzbitMcW9oU25mR1NCVkhkUjY0RmM0V3BTYnNLcllH?=
 =?utf-8?B?cWZwaml0V3MzR0pTanUzSVhzV2NFNzhMRlVvdlU3dE5sY0grQjk4aktIeUNs?=
 =?utf-8?B?ZDlObVVPaDRZZmJJMDNFQVFlc3RhMlp4Wlg3Ui9BQ2JFZDVybjBHZGsyQ0Rm?=
 =?utf-8?B?bEllZ1JsZk1iZW1WWUkzalNDeGJRQnMyUEJsTXVNYWZPeURHT1E5OG5lVlo5?=
 =?utf-8?Q?VzA6P9wnSH0NoFDMDF1jz6EiF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fff6400-5459-4ee8-ae9d-08dbd0754c2f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 07:30:41.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHGZiu53jxbrVvGADeYj63BNNtuH6M6FLauid70LaaxLrmL2LuQu6/NY7J6J0jiSq4cJPhCF95Zw9Jvsl9pAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9195

On Wed, Oct 18, 2023 at 09:24:05PM -0700, Andrii Nakryiko wrote:
> Add tests that validate correctness and completeness of BPF verifier's
> register range bounds.

Nitpick: in abstract-interpretation-speak, completeness seems to mean
something different. I believe what we're trying to check here is
soundness[1], again, in abstraction-interpretation-speak), so using
completeness here may be misleading to some. (I'll leave explanation to
other that understand this concept better than I do, rather than making an
ill attempt that would probably just make things worst)

> The main bulk is a lot of auto-generated tests based on a small set of
> seed values for lower and upper 32 bits of full 64-bit values.
> Currently we validate only range vs const comparisons, but the idea is
> to start validating range over range comparisons in subsequent patch set.

CC Langston Barrett who had previously send kunit-based tnum checks[2] a
while back. If this patch is merged, perhaps we can consider adding
validation for tnum as well in the future using similar framework.

More comments below

> When setting up initial register ranges we treat registers as one of
> u64/s64/u32/s32 numeric types, and then independently perform conditional
> comparisons based on a potentially different u64/s64/u32/s32 types. This
> tests lots of tricky cases of deriving bounds information across
> different numeric domains.
> 
> Given there are lots of auto-generated cases, we guard them behind
> SLOW_TESTS=1 envvar requirement, and skip them altogether otherwise.
> With current full set of upper/lower seed value, all supported
> comparison operators and all the combinations of u64/s64/u32/s32 number
> domains, we get about 7.7 million tests, which run in about 35 minutes
> on my local qemu instance. So it's something that can be run manually
> for exhaustive check in a reasonable time, and perhaps as a nightly CI
> test, but certainly is too slow to run as part of a default test_progs run.

FWIW an alternative approach that speeds things up is to use model checkers
like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() against *all*
possible inputs takes less than 1.3 seconds[3] (based on code from [1]
paper, but I somehow lost the link to their GitHub repository).

One of the potential issue with [3] is that Z3Py is written in Python. So
there's the large over head of translating the C-implementation into Python
using Z3Py APIs each time we changed relevant code. This overhead could
potentially be removed with CBMC, which understand C, and we had a
precedence of using CBMC[4] within the kernel source code, though it was
later removed[5] due because SRCU changes are still happening too fast for
the format tests to keep up, so it looks like CBMC is not a silver-bullet.

I really meant to look into the CMBC approach for verification of ranges and
tnum, but fails to allocate time for it, so far.

Shung-Hsi

> ...

1: https://people.cs.rutgers.edu/~sn349/papers/cgo-2022.pdf
2: https://lore.kernel.org/bpf/20220430215727.113472-1-langston.barrett@gmail.com/
3: https://gist.github.com/shunghsiyu/a63e08e6231553d1abdece4aef29f70e
4: https://lore.kernel.org/all/1485295229-14081-3-git-send-email-paulmck@linux.vnet.ibm.com/

