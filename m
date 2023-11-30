Return-Path: <bpf+bounces-16234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BA7FE92F
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 07:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F5528244F
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB1F154B8;
	Thu, 30 Nov 2023 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HgEV9+1d"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C2B10C9
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 22:33:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsRZPok/Q1eOH6Lc9miigXGs2BUJjGuNiVF/lEzPJ82LdvccWQooOww/TBmuDuzDXFnSUXoF9ap9+Zn9/Zs/nEBSUiVNDQoAFjPNybU1dhkRVdLv2gCLaWBtfgAJ7PcuhDLv9268xPUdQ7BEr/KQDLlwS3DXXVudUsXKjNZk4Zki6ulpCJFSkJ1/0qupTjelcGpmwCF04UonXTE/hXRC5fSDKJj0eE64wiPgrd+8ZYWnov/AxRsiCvOprNdxK6aAQJiF/BXVWLx2Qwoy9pZ8sq9247bKvRhvz8qSLs6r7b+4Z1TUHKZmqEonGnmGDkwBNGDln3HnayaC9qhq3GPYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31luoRCvsWWR/VORZ4ownUbt2dh50qzX+s7yr6fJWSc=;
 b=eqXN4Vzx8ER9di7k8D9ne//JCcyGWl+M83dDK/LnJM7+/t/htU3f8uSbFkN32N2S7iLs0AZ1Tvy/6HAtkZjdsAhnrYlgVrqebxizJ9ofUhabLavCVY8SNJX5qawntSVOQGRKp/28W505uPaQPKDk1DEFWHKikCsADG0FQ66m8FgNhqbeEG/591pthNolSB5zbbqXZfXi9H2PhFyJyPxoNcASARCgHUueDOxfl01PqTaSQqqNGPkwU45tXlctxngZqrN7SW4QRxYpovxKxZx4l6Q72w9ZHWbZ3gPMxJrL3+yf/iXGzOvDeCs20myTeeqH1MTG2rGbGPJjOfOxl/NaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31luoRCvsWWR/VORZ4ownUbt2dh50qzX+s7yr6fJWSc=;
 b=HgEV9+1dr6IWY5Yi1OTYNBlI5YeRRW0sOiTAJ7xV+WEuA51w2IVXpTY6Q1khdlqbwV3voLdi90978AiiuzO4dKIv/OcHxXsctzOH2uy2XuczLBn11wmyIwodN2FskIBRPH9ab7zvm77iIMMXbb03P0rQNDWAHh4NgnBvfBgYLEJuZBjZLWmiPjEdZW9PJVEZsfCdbGAgB9F/wtyke7XhKVdTtdEsA6ChSY1LaCnNc6PfVZh6poekxXIY8GW2E/veAo0vq50Qi6AprrkyDJ0hhMB1U/MBuYjIyj/RwHFYsEyTIfa5ctHLX8RFAwo22seW7HyNF02dR992XH1CUEMemw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Thu, 30 Nov
 2023 06:33:22 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 06:33:21 +0000
Date: Thu, 30 Nov 2023 14:33:08 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/10] bpf: enforce precision of R0 on
 program/async callback return
Message-ID: <dybeiygqc6qllxhuaagvylw4bgiyyqxzz6cu3vbvcloiz4mgux@qfzwtupey7p7>
References: <20231130000406.480870-1-andrii@kernel.org>
 <20231130000406.480870-8-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130000406.480870-8-andrii@kernel.org>
X-ClientProxiedBy: TYCP286CA0240.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::16) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: af29d5bd-5043-468c-32f8-08dbf16e3f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KQ+vZqwNaYEYquyRVpbupZsAdqJep5LEIAgxL9OaqD2L0U+yraP1SmL0unRPXYvFtwadXt74duRdYQO+Sa3knUGOMuNXawCUXGL0LAq6QvBTMIaAlLyeRmdbDu5xaHfbO42MgF6VgBHAiaT2l2ZqqA52m1bEMnHvUvxeTTWhr+5w+y0R6Or0hm/DVnmw5Z1Hpl07OUW/HiHtAm5Bq6x8v5CaWwcYtGMClFVPVZdnhU7QcRIN8sPWshrYSgd7YCv0GC5vkusMz0HpUlebruywVPeDQd6Yo+2iTGbsMfHMsx1b3mzV32eYdhIAG2NIHcTzQhXsE5WIxoe4FfUnekLTArYgd/BsKCt8RUnCIP48Sncxd7GZrFhP2Z2o57M5exslCvKP3jPi65amm4KACRm/bdKi8vb3nQaSuecY2L80ZSgl00evm8MTKDP2AGhkRuwXV+STvRgSW2gm+N6iveeSZnQxL+h8M6fBCMJblVezzXqczlvC1qcU0wyypwUsO2/onMMCfN7yQlhSWUGFCJ4KKiHaDmTg5z0mgIMeO5O5f9VFLGkkHw1dVUSxDmWBtKlqXpWhOsK9IOs2oiIx0ggEZjhXviyNBqXWWPXwJUFmkBjGa8c0/Q1xzXM0x7tZObTC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(66556008)(66476007)(66946007)(8936002)(6916009)(8676002)(316002)(5660300002)(4326008)(33716001)(41300700001)(86362001)(202311291699003)(38100700002)(6666004)(966005)(9686003)(6512007)(6506007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RAtrH3suCTFcNUA5mF8Echfu3+vHrxJ+hxiEg54Xo3Rsz/spH4ay86ugJV8q?=
 =?us-ascii?Q?AFliUyR2a52AG4wXkDrGk4GaPrnQwAh4qcptKOsnAldvbHzM++y9IQ7aN/P2?=
 =?us-ascii?Q?/NcxwYFIwpCFV0nM+nTwUVPIUND4c7lgWLPfcTb2tthR5I5PEEgmJ6prTnLv?=
 =?us-ascii?Q?6JWnDWhVto0/j0VrFCWVlQPGAaFxfyvPoeNQbBeSyBgRVEYDfLTDtkFkaFId?=
 =?us-ascii?Q?zR7EkJRYWqD4q3v/ZRxoqto4Ol3F66SvXGa/yt/0I6Yegi2Wx2fR7Kqxjjy9?=
 =?us-ascii?Q?B7kR4VyFdEjxGBgKRE9yRp7nFEwtPqA6NayVaPmO6BABV17GCi+vkWUF3sqa?=
 =?us-ascii?Q?rE4yFBsXrueD4/wv9x9IqJCvJq63AFq7dKNec82Eqwcf2KLmCqB1RHDpTBIi?=
 =?us-ascii?Q?+6OpSC27TKZt3+Hz4jAKTmq2C1YkEiG0+tH67923pIYMpn2hR+y86AKbpTy7?=
 =?us-ascii?Q?stswDxnqqwnki13KMbgRTXYc2yAHhRfW7NtvEf73u95Ug48eW4SioeX7VNAM?=
 =?us-ascii?Q?FwTUiLj2cszCwIMxakCsZO91zwU6raXMbYMDQvN0w+A8ggr9pCCw0ixg4Ifs?=
 =?us-ascii?Q?JERt35qa5iJZQKo6QjYW2izKVYS/apeD098yYJElFNJMhrRcvlJcJTIrsuiz?=
 =?us-ascii?Q?qR1XDT8K1NFU3tpw/EMyj4ynVESR9WlH4pHs6e0MYRov0bZCeABNE1Qt7n6b?=
 =?us-ascii?Q?2aqkqWUApUqy5wEak2QOp4jc8v+cnLYWOD5i261HQ+wUPxlglWs46vBJCrCp?=
 =?us-ascii?Q?+0XoQM+ctvlBntnbWMSFeBxzL1wc+MdkGsD7wdrhY3cL6XDpe2Vi6OGboBcu?=
 =?us-ascii?Q?D2RqcCzEx/bUdpHyF9pkknCt3aj9SEX4Pi07MOHDIYatFgNqtilJYm/XpWgj?=
 =?us-ascii?Q?KMlhXq6SRdzA+cO2/Qcpm0xp1KrnRCS4lyLXycvMtaxL8HFhMG4j8krirINa?=
 =?us-ascii?Q?5gHhdU0W40m2xCIBmCK3gyvntyMp26ZzpeBSSE+whIcQBk72sDTTDXtDam3W?=
 =?us-ascii?Q?3UTSRgeXlICAT/yUfJDRJN11oHKV2ka1AO669aovCnDagIWFaZGQYq3EDKMi?=
 =?us-ascii?Q?iCDOxy17V5Z/3WkzqYI5rLnFAOrlYkNZ5grvPyd4E6FlYkRc+v4Vpm4EBKua?=
 =?us-ascii?Q?9WfXbZN8p5YKRSDkIqx0Dn+5gnGuD3Di12594QWlIFthhYAXpmD3Q4uh3sNC?=
 =?us-ascii?Q?UT8742Ou9CaQ8v9KoKkeWR3RvW4VsNhogOI/J2sp9vnaXfLbWPrI3GVYzL5a?=
 =?us-ascii?Q?8yYIqNnMUyqNLe3t7SWvDuwPH/mvph+swg4ulpkwF0+6SzjZBlMASzjUFSO5?=
 =?us-ascii?Q?bk3gR4gqSUGYLpEKTw8ccaLVrhYIk/lRu+DMWEQx/7XugJs58a4lpbm4CeaO?=
 =?us-ascii?Q?zdM2HuqJG1Z/CDAHq+RWxBI2JlYPCH40zArTXCAyEx051aflaxSDb/Aq+0Z5?=
 =?us-ascii?Q?Ay/fHlgxVlENwgOatSzHttx8PyXv6PQQlVIT4HFE6icZSA/hGMXmCMiOgqG8?=
 =?us-ascii?Q?m//1PzW8Y8wjR4uLSmDCOycxjzmamPaUN7HYeQX4xdzq+EjGbL7BWnZmx+Vx?=
 =?us-ascii?Q?mI67DPJ1dn/dnWW241mk/6/a77wu2YHkBD6VN/tgfAWPsShmTygEoMfEVgUP?=
 =?us-ascii?Q?teciAh4F37gLP5e6ZVBYl/UK+s4j3/swOukO77c5eiVmXYoLAE01zjFlAC/k?=
 =?us-ascii?Q?7F8ZXA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af29d5bd-5043-468c-32f8-08dbf16e3f8e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 06:33:21.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMKSJzxadElU9a/bAOnmVm+rD7BHizgj7bdTBuqcLl+eBLSJlLMMpA3RdlqWqyEA6/pFrEu6Ku2v0KjoXTTjyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414

On Wed, Nov 29, 2023 at 04:04:03PM -0800, Andrii Nakryiko wrote:
> Given we enforce a valid range for program and async callback return
> value, we must mark R0 as precise to avoid incorrect state pruning.

Looking at previous discussion[1], this commit fixes the potential
"out-of-range r0 got state pruned" issue. To my best knowledge that
means this commit would be needed all the way back in

Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")

Is this wildly off?

1: https://lore.kernel.org/r/20231031050324.1107444-4-andrii@kernel.org

> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c54944af1bcc..2cd150d6d141 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15138,6 +15138,10 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>  		return -EINVAL;
>  	}
>  
> +	err = mark_chain_precision(env, regno);
> +	if (err)
> +		return err;
> +
>  	if (!retval_range_within(range, reg)) {
>  		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
>  		if (!is_subprog &&

