Return-Path: <bpf+bounces-16228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCFE7FE8C5
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6072282348
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 05:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A817752;
	Thu, 30 Nov 2023 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="wdZtbdX9"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D61493
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 21:41:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdW2AYYuj/5rTKAuaAoj8OqHQduaKGF5LGRluokxZNFppeZ+0MKCm2GqMU2lBi98W7mpWJ9x7XWf0IyfUDsqhkiboc7NtOXRGC8v//Dn6xFpihxAtBCZPT8nXgMzuTQngc1OSPrzzX/CSrki79XcoWOXpEzqfUsGxx3evksSy8QQ/SsnvbcjJPheP8etCvGjraL0rhh7cufluGiqGiGPrjI1lcir5kNGYa9Ds0Aw87PpryQGLWWGH84IBo9UUui+8HDfkXPzPV1jEsu9yoUEzyShzmrNVH+RO/otWRD2f20bXp4L/ok5KdoCb9+FSa2r758+Udh0Q6SPqMtNfMcVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u18Y0V5PIJMKY1ZzlWn/I/a4kHsX/0TGfeLRm8NhxPA=;
 b=froC82uyzYPgR5dkwdcWS2Mk2JrrU986HlNxhC1tCBIZ/U45SkgVBNyCvd7bEBP9DbqN71+bM6d54b5bHHg9D/Kv1qZy/N+ihKA45T6zmSSeDt1o6zLz81BtLEHZ04JZ1FJ/1htxKFvtw0dt5ix+UQc2G2/BEhG41gqbzWARhr8oa4+wDQ7H7OMXmHVCyR0JW+lczBqKBVOVNFYM1y8WwtKiPDcShzIVfEBjV5B8FwkRWMvAcq014DoSr3omXYud+/HLvc+0PzqTaftPWWiYF4MQFQBKo2GGgOgl58Tn9BZU0tyTra/2Rmpgfr2K9eHIlW/wUofmGiYRkKrRaxizDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u18Y0V5PIJMKY1ZzlWn/I/a4kHsX/0TGfeLRm8NhxPA=;
 b=wdZtbdX9YiHIjfzildvevcT3FLT4trPptjqt3fa/9j4lOUbviVfDPkWS/zBPxJKT/0/MOFPcfaQiiH0FXftXsIKqAXubwvwwBg/pZYO3XeJGzkBr9qVMcuOAbg9mzUoiNZ7jQC6MjprlgtugY6gKyE6skRmvW3hipy434VJyDSwUzWRERNQSTc7I/eo8xiVBBCYA6bxl0UYmenjLCGIpiYjjbFy/u1dcqxpRNxMfyK7opXGdZyIkxnUtCaBiIrYUEkWNBgpR+0nG3PEZWPSHmxZXRUd5Km2nvAo4t9FezRzHqCOGz+ri8UWagVRh/yRUCZm4hVOH5ccoRW/Ikh6YJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by AS8PR04MB7605.eurprd04.prod.outlook.com (2603:10a6:20b:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:41:45 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 05:41:44 +0000
Date: Thu, 30 Nov 2023 13:41:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/10] bpf: provide correct register name for
 exception callback retval check
Message-ID: <vyi2llao3yk5tqtau6eyk26u73wobhq3vc7rgokjerz5uhj4fc@eownqkg7fd5r>
References: <20231130000406.480870-1-andrii@kernel.org>
 <20231130000406.480870-2-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130000406.480870-2-andrii@kernel.org>
X-ClientProxiedBy: PU1PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:803:29::16) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|AS8PR04MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 528dc714-6ffc-4921-5b80-08dbf1670977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iF/3Iem16BBX7yjel1emJ+dMYjkJZfzLLkLp9oKKStuEzf53qUHmcN7SOy/HSkd9wPAz+B4HORsNzzxXUODWUl8DC27ubBsV2SEmGCNVgwOKZwMJfVrD6qT+LRi9Foy/azlHclifJxYAZlSbjH2p3AImTfig2G5XCG6dXun7CjUkALC0hE2Asu9AK/RCFqSe0BxJ0imIaW9s6TozebMvF8nJ2HQtnRz2V614Tplnqy6X/mrb+qLlZLX4Vndy9hApCwJMHykxIvwLJdMC6Z4eG2HwIznA8NfbAypLTLvbAL3wT3NFPYwI7YWlLbTTPSDjNEbmyPXztyzHe2tm4c+jE7f2w/O/SQZ6FNLADXyNozAE1IW8Op267/JK1n6clnWZykuL6jbQzyvClUc59rD2+dHCfWyXLpu7jakIEkosQ1BZKHqa9WUdBljCpk7VngWSrWpzFRU7kBwjW+8nOgnDBxby6lDAQVxfguufGIM7/LjF0CbKS6i4rdWp4JBp8VDqlvQc8jA1FaerutQgXWDH1U5nSMWOF4SFUNM9eXYSXLqD2HLGjuTizDBMWkdEhAQAs2tvyMFaNLUIDGk/rhA2utopgcTeHGsWs2GrQST+k1kVzffG+xeqE1cHyWifLR9w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(202311291699003)(33716001)(41300700001)(2906002)(5660300002)(316002)(8936002)(8676002)(66946007)(6916009)(66476007)(4326008)(66556008)(86362001)(9686003)(6486002)(558084003)(6512007)(38100700002)(6666004)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?128bzgrd5M9AOK9EYr5Z1hN3x9/snz/Y0zR65b7QBhf12+/lWginpOepJ7m1?=
 =?us-ascii?Q?fr4np8IPqg1wpWO6D//w9gjInwu8k3arGiNyh9iGeB64ga4ZRtxdUWg6dV5q?=
 =?us-ascii?Q?0mS/+upScUFEBudR05D7xe4LGELmHOPfjkEgX4WYKDL1rc41hJwH4goOG2x8?=
 =?us-ascii?Q?Wf1mV0tREVK7JQpkf70wUeQ8wPfQ8NR8C9jSEn/NtLjaTsf7+nPa8d5sQ5r/?=
 =?us-ascii?Q?y0BIZGLva/l5eQd4xkJ8cVHs1Qal54YGhnr1XRItiznxISwEnAoThLthi7uw?=
 =?us-ascii?Q?YjVWaJCYBKLlU7tFJjygmFoPWcLsA2u7CvCnMzKI0iRg8ziRyejhGbmRvY3P?=
 =?us-ascii?Q?cZkljW8n6XqvVd/8DBAWy7A12GACPcaG1YVO8ftnN2TjSIg8u5+dN3gELMIJ?=
 =?us-ascii?Q?zvH2lSx0x0VrlcFIeR2suW+N38qAak2AM2ceeSdIqT9kJQe5T/w/nbZhcT7Z?=
 =?us-ascii?Q?ahWyh3G+p/1beoHS0JG7k1NHR25pbxdFEt6Tix3BPNtMxUKiCREy/xhAtk7c?=
 =?us-ascii?Q?msUCG3dzwgmmuAD4BOCuiFr2xrAeqs3Jj46zf+v7dXGkSAJq+sVqULUWFX3h?=
 =?us-ascii?Q?ZjwoM835Bnfr9ey+IcC754rFXBt37XMXhm7vwZxPgDXvDYMPi6B2YBi3sg8R?=
 =?us-ascii?Q?v1IeE3t10ItHUg4gPy9oLr0/uQx4a2Y2Gltu0u/z+fIXCoyeN9fsmEHNfjfe?=
 =?us-ascii?Q?YqEtUKJXqGDzZzOP0NF9gnyLEnPQ8WeQEg+pnEoHG7xU24hGYzX+FBR4sLSr?=
 =?us-ascii?Q?SWCJr3ZMRLwZL8oIE5s9oiQxlngeNF17Aidjk/l4wzv2rU1wl846JcJgTt9g?=
 =?us-ascii?Q?P7+pml7uxHGbWrA5QpAcJRT2LMvDOrchhglTzFCDRyS1Ott2wEj2YTPsm/Ar?=
 =?us-ascii?Q?HNfKifQFroPu9CKGNppEoYoKmJOD0QXRCgOnSefuoZblrqx780rkegKLrPXK?=
 =?us-ascii?Q?l5oUL5oW/P9I5OwS1GgVowYRaNHfAuyP5DR2x3Low3K7Me1Q/V/uklsYykti?=
 =?us-ascii?Q?Fa9oWeCPk1vXZAzcx3yyfil+0xM7j0jpAMAGny7MypmtWRCz27gJDwm4Lz/Y?=
 =?us-ascii?Q?tV8jPvzZFOcFsft8juEJDr8CnJO/xAmXqOrR1PTPCCLXnIkavks1t174dXmr?=
 =?us-ascii?Q?LPIBcsDJlCEbHWQKZzPXqbodKRIVAqdHx0iBiPOhTMr/qQatDeGeNDk2LAxk?=
 =?us-ascii?Q?YgIbAwAk/3PoQKnKcBCADQqblx1t6zQ/90FACM57JZyDLC9ZA0b8x2gbfu8r?=
 =?us-ascii?Q?OYFpPQ7XROvKpK5BG9OK0pAwjUkuBPNR9A9bNc1PlkwMpP+Gy7D5Y2csqXQG?=
 =?us-ascii?Q?tHcZPt+T9KdakIBo7KOHfqC47pan2YQudrIBkmd+5hluFGIuJsHeySh9eKI8?=
 =?us-ascii?Q?NcijGMFNyoB2ZMyvYq5ZruGcp4KqfA54B3FGZv1jV15HVPrE7LSYrGvHRJc6?=
 =?us-ascii?Q?ucgI/OHZ6Vg0CHDxpUo1LrzFGZOLBz9KpMHn5CndXFLausizNpO8jcsIWep3?=
 =?us-ascii?Q?TvVQDjoFcsFleXV+gHUGzCizlazSda8QKRrhKpzArRiH1DP3MoiN375tVtlL?=
 =?us-ascii?Q?2ZhqOXzDVrT2dGRVVvHZx/B3jKYtB4jl1/k1BcLrLTR/OyTOWgt0wpAmH98z?=
 =?us-ascii?Q?O5T5RmTQCzAZL0K6/d+s0E6WhVFzvXoA7dePvqZX5BXsWGbMAstzoPaFHMBf?=
 =?us-ascii?Q?8d8GYA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528dc714-6ffc-4921-5b80-08dbf1670977
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:41:44.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BinSAEDv7fuD6rkr7UAT4Y5jWtuHEQQ212jMk3fEebaBxN8zm/5Jpu2ScHxuRQQTsvrA/jfEVZgdvm2XxJL3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7605

On Wed, Nov 29, 2023 at 04:03:57PM -0800, Andrii Nakryiko wrote:
> bpf_throw() is checking R1, so let's report R1 in the log.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

