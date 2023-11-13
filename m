Return-Path: <bpf+bounces-14972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B5A7E9662
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 05:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A7B280F0E
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 04:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866AC158;
	Mon, 13 Nov 2023 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NfA0hlf2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F833E2
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 04:55:46 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A2C1732
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 20:55:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPkre0eSJhtR2YARPSTM1m4HfKaKIk6OS6NIco+/46VXyFx6DaP5PZKkKiNQK7/ws6R96wrjrDrb/2KRgeVkVL9Oc21fJKQ5vC4dYdYy3d/EjHk9R9744D7vF6fzSrxsWLCl6lcO4AUT6VNWLrUUvkSMMOsgVrVHXpY+sms3OFHI/C96ugD5yyl7Rv8R5a3xwy5as64umPxG1YRaufAq/hT+KxlG8kaO+m6cZoiYBXixrDsaE0m0PyYX0ZQp9vlJa8mm18W3xbDpmrDrWIyKIrG56yGLuK4jyQ+ZL3efYyS3Kg1q9b1JbpQhWj7fx36uumX03a1qQczdD67HHfPWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2zLVBcBe8A/quL+K5/5yri9uhin7iwvWIz5+RerVyc=;
 b=Cwgnq6b9ZFHakrH3WAVWv3a+4KEXJdBqu3QNRbUwc8/m3fo3t3j5aDpWNAEtvf0l4PL+Xy4zLc1210UnRb8XkPfhD3x489i31QZJK/ksARftGH4xehkfc3qCryu20NjYehsTW3iYxBCuMrei6qNldCFqCqzbt4+F1NCfK2vuIgaufbvkQSlK8nk6OjP/rmOKMxaqQJuwhKzlOmHTgroP7LPX7YvdGNBm4sh6MBoAArPOpRZuxetpLEcE9mWGDb9HkCDC2y/9ThonWL/aWQxW6YRcCxHsFvMcf8N87B2R2XkbSRS5+HrcH6WfFfFrD7PyZoQajLrzq3vWJHT88lD6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2zLVBcBe8A/quL+K5/5yri9uhin7iwvWIz5+RerVyc=;
 b=NfA0hlf2qAXwE/z4hcfrpRfbSQSMTYFpbh6F9eAKwky+gbPpJB1iqva/zoqDrdLVVGnvL0P4pIoi2jYqoXBO+CmA5y0iodVoZ57yaRhyeh3vZeWodeFQpw4ql6nBNuQH1EJy9TBCVhx3S90PTUnPD1GqBeyCPQV68gfdaiiXdEgSr/TRki+NQnA3b3Ii5kczadsY6IMeT2LGwNHaZgzNZSugov5NcEk8c3Z3wLL7PG8/WScAC2E4r3NIVVU7StmLUEiWyv55Kf0XGEVY+PP1sIPbe1uEXlOi4oX8OFuDQdu3X/qvN+wp4gfmnhr8u+bkKpr2H/8Tfg5ttFmmrwRqyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by PAXPR04MB8373.eurprd04.prod.outlook.com (2603:10a6:102:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 04:55:42 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%6]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 04:55:42 +0000
Date: Mon, 13 Nov 2023 12:55:28 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/13] selftests/bpf: BPF register range
 bounds tester
Message-ID: <2fnoho4uxxca7ix4aamburg3tdwljmx3subxxhw3iej32fjnbp@amcdo5vood6l>
References: <20231112010609.848406-1-andrii@kernel.org>
 <20231112010609.848406-8-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112010609.848406-8-andrii@kernel.org>
X-ClientProxiedBy: TYCPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::14) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|PAXPR04MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 585fa459-7163-4bad-2f4d-08dbe404c9d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bYpJhiMJ97TyHpH3oQ2MTpUWK+vWfNueopnEIB9fHw5oLjt+cwfwy8mcmOvsG9boxG9F6Eb5lRhJfgd7I/Kup8wSi2V+Zi2Wmp7yhVgOOjNVBM66IYvziAqNOSAngWr2bQbJun9Zo0AMFyHoZjQSSs5EHH8/8MqCOMRvCqoBB01Sa18PWJRoH5wtCJL3oyzm8ZN1VbR5erQS29RLPHRydhguPwdn193cZbbGm6uqlaV3oDRDP7JBn07UHcjU6FM+o9Q9+33qphTNlr1nyHm54zn0oPPSN3MTreFkhR+XclKYnpKQKD3Mydwvx/c6aQR41OEnWhfpKoyu8ywaHmEeZepDIIsAXzvjRDXf4xamS9dXiKDUMe82m/yB9RjDvcQufxmW/zYLfcPPqCGQyxFXuOqT1JQrZy9oEND427wvp27bvUiNIUqO3w2di50iUmQeiOMqpg9ZU/Jh6FqTB9PB+9y+zuPMUTzlydc3bZpsIMAa7kExyYEBDcTgmZkFmE3WSWnaRrloRyF9q1kWbFrSvZp1ruaDO381qof/I5u9vlz6reDr6/5kfJHG7+59GDIW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(5660300002)(86362001)(41300700001)(33716001)(66556008)(66946007)(66476007)(6916009)(9686003)(6512007)(316002)(83380400001)(38100700002)(478600001)(6486002)(6506007)(6666004)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T/36+hNJDS7RQDXH94N1lG2G0LZR9cRSzYmy9/qtKCSX/NDHagnBNlKJsij3?=
 =?us-ascii?Q?gdhQkdlwgkJlAcESExdrYrViqvJ1IMMUu44OxE2SQ0pfSswxtSw5gc2LZ3Vz?=
 =?us-ascii?Q?+nNP+0GC+NolaiLg8F9KQXyrJ53RC3JQ6YoADvUuw6ElnK6BCgpR5Nd8luVx?=
 =?us-ascii?Q?TxuWhG4A2xEP5yyxAUIN7yDvov0/nw7Kw04cNatHm4g2vXNe1vSevkECcvWk?=
 =?us-ascii?Q?sR4iV51UIjqtLuF3SIBnxLyqfHfEx/AjgZl3ELBKpkgbCoyFN7xqVQt1sqBK?=
 =?us-ascii?Q?FX3UtMFG9arfmpgtHB8YdwgxtkVSHjIbHm+HfwqOUMQF9aixYoTzPG+CC/KD?=
 =?us-ascii?Q?t5zkaPf3i5EtfF3kELJN88RUD29DpmiDOD9wwPTO9fwWWkvw2GQ6Jco8ToqE?=
 =?us-ascii?Q?4pRnKglXP58bH3G5SlVNJ6e5v6A4m1GVWg/HgOXS3uOahymGbxGz4E5+Dnvi?=
 =?us-ascii?Q?q0QmfTKbd18Rdw8WTTn8PdO9AuiVPmGkuts15OCxJPQPrYcodqyYXtIdTAuy?=
 =?us-ascii?Q?VWvNKGRW5p/bHnMzmkIcVuIr/WdC1jdHmzLiZYic+gEvycWwEjTyxNIFnL7u?=
 =?us-ascii?Q?byg3HuhQmAgj3d+Ht/xr34Q/oSjlFD1hx8Do71JGbVZx5gFFwg3fSOg7NDWP?=
 =?us-ascii?Q?zx24hSDAWqufy6fE1IIKgFtHP7FKis7S1KwwNPNsnKtcDIUI2GRMSUd7mPGA?=
 =?us-ascii?Q?zaZ9cEp1yhUGGMQ8K459MwaiM+Xi0OmxGfy50SGHOgSNd5b8pFrKmgtTN5FW?=
 =?us-ascii?Q?TfsuK80DnZqiuqwaILOEWm9BrNuP4uwwerlZvWTA/6Lzii1rs8+R/5rQpS+w?=
 =?us-ascii?Q?szOxRM8ugvsrFCOR5p6Ys4DIA4r8kBKh0q0rQAO9wHHBd4yiwFekxzx4ywd/?=
 =?us-ascii?Q?4Odyb0pfu5XMqUc9+cgZk6H1SVPB82WGgkvKLOFinEKvsku3n1nqQSZ5IAt6?=
 =?us-ascii?Q?nNJ9DU9OGM4GVI5v8mqKqx8ymSY9cjU7iAGDZR5wextGSfML8xbQZvg0X6BN?=
 =?us-ascii?Q?dJD6AaHthn/04nfd5q/4aprbNl/qmjTT+aoXh9+iV4ObJuE3y1CY8pvhJsbd?=
 =?us-ascii?Q?IwtcsWEqhEkMWjBDx8x5fDV8mIXHNYbudmj+pkre1XgpKPJTlhBgGnYQwmVG?=
 =?us-ascii?Q?z6PggYvDDiQImjqRk9XxOot1p6HSjLf420JBn4GOG4xcUIqZ7EsrJy7KSzWR?=
 =?us-ascii?Q?18bUw02Mn0T8n6Zu6gWgwDRDxvItnMM4CQoxA9XgZ4dC0II7Hynj8t+9gvwA?=
 =?us-ascii?Q?n+FeAt/uvGafJnyvsyCJOeePALjmkvzI7ID7xTmTKo86jsbzooEiLMKc2Jbo?=
 =?us-ascii?Q?kSUHNXJua7hWxJcKUh7M/Vl6NqoKzcgcl2bBP+TjUTlxtuUKSF0WwicjT38w?=
 =?us-ascii?Q?QZYzTBRb/gEAIqHsVbwkLJIEDBZPCiaCXsAYFhLYpChKsoGY9OrZeE9fjTGb?=
 =?us-ascii?Q?91bohPcYqCdPrhpdyaQdq4sBi8tYxBchkI3HFPiGtuUm5n5Fx89UEthfs3vT?=
 =?us-ascii?Q?43LqkPPnnL2k/1yfHIw/gi0pFDy4PEPYoGzpE6sL5xMaAlzG+dMt/XceGs41?=
 =?us-ascii?Q?Tw4xOgsRBpyXkj1ikYwgwLCQCSMIhuBPOugmNWj8iC3Ki9uSSEbFulx7hE3q?=
 =?us-ascii?Q?yAeiWeVZJ+nbh9zVhW1tspXd5OmrtAAnp9rexTiC2e5p?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585fa459-7163-4bad-2f4d-08dbe404c9d0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 04:55:42.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Woxyfy6ph93kv/IVey3wqDF/fuMy5cYQLjcG/UV/nGLR0XR4JevylDAGVaZU2J+LmPeyAdvNM9fv9pgI02+ALA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8373

On Sat, Nov 11, 2023 at 05:06:03PM -0800, Andrii Nakryiko wrote:
> Add test to validate BPF verifier's register range bounds tracking logic.
> 
> The main bulk is a lot of auto-generated tests based on a small set of
> seed values for lower and upper 32 bits of full 64-bit values.
> Currently we validate only range vs const comparisons, but the idea is
> to start validating range over range comparisons in subsequent patch set.
> 
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
> on my local qemu instance without parallelization. But we also split
> those tests by init/cond numeric types, which allows to rely on
> test_progs's parallelization of tests with `-j` option, getting run time
> down to about 5 minutes on 8 cores. It's still something that shouldn't
> be run during normal test_progs run.  But we can run it a reasonable
> time, and so perhaps a nightly CI test run (once we have it) would be
> a good option for this.
> 
> We also add a small set of tricky conditions that came up during
> development and triggered various bugs or corner cases in either
> selftest's reimplementation of range bounds logic or in verifier's logic
> itself. These are fast enough to be run as part of normal test_progs
> test run and are great for a quick sanity checking.
> 
> Let's take a look at test output to understand what's going on:
> 
>   $ sudo ./test_progs -t reg_bounds_crafted
>   #191/1   reg_bounds_crafted/(u64)[0; 0xffffffff] (u64)< 0:OK
>   ...
>   #191/115 reg_bounds_crafted/(u64)[0; 0x17fffffff] (s32)< 0:OK
>   ...
>   #191/137 reg_bounds_crafted/(u64)[0xffffffff; 0x100000000] (u64)== 0:OK
> 
> Each test case is uniquely and fully described by this generated string.
> E.g.: "(u64)[0; 0x17fffffff] (s32)< 0". This means that we
> initialize a register (R6) in such a way that verifier knows that it can
> have a value in [(u64)0; (u64)0x17fffffff] range. Another
> register (R7) is also set up as u64, but this time a constant (zero in
> this case). They then are compared using 32-bit signed < operation.
> Resulting TRUE/FALSE branches are evaluated (including cases where it's
> known that one of the branches will never be taken, in which case we
> validate that verifier also determines this as a dead code). Test
> validates that verifier's final register state matches expected state
> based on selftest's own reg_state logic, implemented from scratch for
> cross-checking purposes.
> 
> These test names can be conveniently used for further debugging, and if -vv
> verboseness is requested we can get a corresponding verifier log (with
> mark_precise logs filtered out as irrelevant and distracting). Example below is
> slightly redacted for brevity, omitting irrelevant register output in
> some places, marked with [...].
> 
>   $ sudo ./test_progs -a 'reg_bounds_crafted/(u32)[0; U32_MAX] (s32)< -1' -vv
>   ...
>   VERIFIER LOG:
>   ========================
>   func#0 @0
>   0: R1=ctx(off=0,imm=0) R10=fp0
>   0: (05) goto pc+2
>   3: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
>   4: (bc) w6 = w0                       ; R0_w=scalar() R6_w=scalar(smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
>   5: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
>   6: (bc) w7 = w0                       ; R0_w=scalar() R7_w=scalar(smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
>   7: (b4) w1 = 0                        ; R1_w=0
>   8: (b4) w2 = -1                       ; R2=4294967295
>   9: (ae) if w6 < w1 goto pc-9
>   9: R1=0 R6=scalar(smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
>   10: (2e) if w6 > w2 goto pc-10
>   10: R2=4294967295 R6=scalar(smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
>   11: (b4) w1 = -1                      ; R1_w=4294967295
>   12: (b4) w2 = -1                      ; R2_w=4294967295
>   13: (ae) if w7 < w1 goto pc-13        ; R1_w=4294967295 R7=4294967295
>   14: (2e) if w7 > w2 goto pc-14
>   14: R2_w=4294967295 R7=4294967295
>   15: (bc) w0 = w6                      ; [...] R6=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
>   16: (bc) w0 = w7                      ; [...] R7=4294967295
>   17: (ce) if w6 s< w7 goto pc+3        ; R6=scalar(id=1,smin=0,smax=umax=4294967295,smin32=-1,var_off=(0x0; 0xffffffff)) R7=4294967295
>   18: (bc) w0 = w6                      ; [...] R6=scalar(id=1,smin=0,smax=umax=4294967295,smin32=-1,var_off=(0x0; 0xffffffff))
>   19: (bc) w0 = w7                      ; [...] R7=4294967295
>   20: (95) exit
> 
>   from 17 to 21: [...]
>   21: (bc) w0 = w6                      ; [...] R6=scalar(id=1,smin=umin=umin32=2147483648,smax=umax=umax32=4294967294,smax32=-2,var_off=(0x80000000; 0x7fffffff))
>   22: (bc) w0 = w7                      ; [...] R7=4294967295
>   23: (95) exit
> 
>   from 13 to 1: [...]
>   1: [...]
>   1: (b7) r0 = 0                        ; R0_w=0
>   2: (95) exit
>   processed 24 insns (limit 1000000) max_states_per_insn 0 total_states 2 peak_states 2 mark_read 1
>   =====================
> 
> Verifier log above is for `(u32)[0; U32_MAX] (s32)< -1` use cases, where u32
> range is used for initialization, followed by signed < operator. Note
> how we use w6/w7 in this case for register initialization (it would be
> R6/R7 for 64-bit types) and then `if w6 s< w7` for comparison at
> instruction #17. It will be `if R6 < R7` for 64-bit unsigned comparison.
> Above example gives a good impression of the overall structure of a BPF
> programs generated for reg_bounds tests.
> 
> In the future, this "framework" can be extended to test not just
> conditional jumps, but also arithmetic operations. Adding randomized
> testing is another possibility.
> 
> Some implementation notes. We basically have our own generics-like
> operations on numbers, where all the numbers are stored in u64, but how
> they are interpreted is passed as runtime argument enum num_t. Further,
> `struct range` represents a bounds range, and those are collected
> together into a minimal `struct reg_state`, which collects range bounds
> across all four numberical domains: u64, s64, u32, s64.
> 
> Based on these primitives and `enum op` representing possible
> conditional operation (<, <=, >, >=, ==, !=), there is a set of generic
> helpers to perform "range arithmetics", which is used to maintain struct
> reg_state. We simulate what verifier will do for reg bounds of R6 and R7
> registers using these range and reg_state primitives. Simulated
> information is used to determine branch taken conclusion and expected
> exact register state across all four number domains.
> 
> Implementation of "range arithmetics" is more generic than what verifier
> is currently performing: it allows range over range comparisons and
> adjustments. This is the intended end goal of this patch set overall and verifier
> logic is enhanced in subsequent patches in this series to handle range
> vs range operations, at which point selftests are extended to validate
> these conditions as well. For now it's range vs const cases only.
> 
> Note that tests are split into multiple groups by their numeric types
> for initialization of ranges and for comparison operation. This allows
> to use test_progs's -j parallelization to speed up tests, as we now have
> 16 groups of parallel running tests. Overall reduction of running time
> that allows is pretty good, we go down from more than 30 minutes to
> slightly less than 5 minutes running time.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

