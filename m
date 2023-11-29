Return-Path: <bpf+bounces-16139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07887FD58D
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 12:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A752834A4
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D301A73B;
	Wed, 29 Nov 2023 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="u+RzeP+/"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E581BF3
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 03:24:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbSJlJsLLNjrJFOGxEzi1laG353/Z2eb9ihi4SDnv7VAxp6cT1YpW7zKFS6gSDui3+jJvw6DR7+MDosxzP6aTxViU8sIUvBMlzorw+Fe5swDRvBhCD3v4ltDD6zvwQh4JVi50iUUMengt18cWx3UOnSmMMw52N4VB9S/fA+TOgacUbbG7S+xoGbcuDpA+abyq9CrBfm/JvwnWV7SWtNDwuFFYfPAQ/GiyJAWVh0qk3j1D/IC35+1fXapdji+sTxwSjIpDeIoH4V3UE1faG75uGJKmiYfSaqUJZrf1a3nfkZtq66zgouKoXOBEWntDutK1UJVDtyaaWCgy75cYODAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T5NptHdVpyuqq8syEP0rpY3Cg09tFI3lvW2N0BMt7o=;
 b=nOvKMyt9ecGqX6RMkU4py3PwKIxcpLXOy/S5DEZlw5RAY8KsfFG1UzOcehk6MZUkq+cpHijeVwCOirGOL6F4vRwOtdGlMfshrKOD4DJVaN0Vf5e1rNyzBDoBO8Hsq96IuGvk/3MKEi+4V7o1feqcFqGRcYpTFiOIwgebTxV0Da3p6tr/JiHl59m5PlyzIHyHmuEvFNwtKa96tgilcYzGZhfLUc0ACd5ZoKifgaIBxAGfAfSiiZHQzBocUBoChyQtPEVdLY7b7ik0RAxofVyAA3YZNqTLcb2dsz46Q89pT8odhADpN8UCLP2KlQUsx975fHiLIm/hXmlZKMESF0jV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T5NptHdVpyuqq8syEP0rpY3Cg09tFI3lvW2N0BMt7o=;
 b=u+RzeP+/8LxZ650N4opMmRKS/FawnooyRDOS12yZ6A44SAveiALOIVHd1Tywmr/0o9HEHECd6k2+D8ag6+6w24CEEYEpIJ95gzRRtBFt/g6G+WWpWbMZk6TuyWaZvfcFc/MDoNyhq7xs2k9UOEeXuG7XrGYjmhGvR+x2DVNinWl71m1y2kx8KgbA2bXFyy+z/RuI9C0/Ew7PbFSpkErJ2Wb5cIXrVh7VzKfcqihFQ2Zxj3DUENgCkPkLXD/DOlzNRrSkjj0Zbst/cbCd0VHn/4YdwvVPIPIWqm6IhLKcpnX8MIqefIdeCYmn/+q9S6+V29YKTUYNUB48zCJFGu/QhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by VE1PR04MB7487.eurprd04.prod.outlook.com (2603:10a6:800:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 11:24:11 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:24:10 +0000
Date: Wed, 29 Nov 2023 19:23:58 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/10] bpf: enforce precise retval range on
 program exit
Message-ID: <f4zdgu5gyjo5ldq5pvrdzyrhvyx7ec2xus6ngcfdok5ibma3op@jzf4cofcyab6>
References: <20231129003620.1049610-1-andrii@kernel.org>
 <20231129003620.1049610-6-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129003620.1049610-6-andrii@kernel.org>
X-ClientProxiedBy: PS1PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:803:3d::21) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|VE1PR04MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca45583-acc2-4833-190f-08dbf0cdb590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DiMdD19WrxEjLUWQGzzNG9C4jeA/KgUtRwS06p7jpXEUSLQggIN1rbsrM51wLVbeoQbDLGchvf8hKBPUoFXuxESx+aTqlY5aVxoLt/1e6DtKskEVOtjOa+236zm1KBoRZzOwJ70k2Azhaw9xiXlmYu8kSvitLL/OYyOKCafzEawt4/x8SP5w4t0sOS+xqSCnFGKL9puYJdQ1QE2r+Que9L4kJ6WyWh8hCos9b1KQ9AGSYEzgVOCIF7rpntO7qqBa14Y/AUQrAbO5F4G2yo/6oYk/KGgnkw3yKbOnGo9AIFqBekv7Y9wcWdzyasAomDkBzbMBegwqs2MtxzK7wexlY9jw83n1/xe5beDyiyoqpvomSlYkwLBnf80CxJ2frWnDOwtTIwA6csKi2B9v9wY/vT0/oZ05BDOsDH/A0LUJA+nxfojfMpMcwffuDt9UH/rEMTy+0CboXAgxuz/Zybr/dqf6J5iQY/y+i3uRug8ZUY5+wq59D95m9rp1ktpfaq+VbfdUQlkST3gawvQMULNvzFrlUf4z/vzhcMAarqEm4FkVpeLHNjxExQtB/eNnU5/c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(86362001)(38100700002)(478600001)(6486002)(66946007)(6506007)(83380400001)(4326008)(8676002)(8936002)(41300700001)(2906002)(33716001)(6916009)(66556008)(316002)(9686003)(6512007)(66476007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hoIc0KddZ9rHcUXem0n7atZiZqlgClCYYTX9jXc1X0puY5T80C2/Oyg7hN4S?=
 =?us-ascii?Q?DaCkPwYqOe4SzD9TRdIweZbO5PjEklaMIVgItehIjWmU6Jdrw1gFKA/FVOcS?=
 =?us-ascii?Q?mYarj6g6bqm4APdki0opstExGoUnv7gmLzM9/SiQhatY6o7PZNgDNJJf6Fq1?=
 =?us-ascii?Q?uMnSBnT2q6rGdClS56Xr/dWjbz8OtYInLDqxKe4zdkzcydmYZEAebOK8+v1I?=
 =?us-ascii?Q?+xCC4kzUEN2z90hPICQe2Ny2d8x9nzrmKby6xjce/knUwSd8gXckrXzwl2DH?=
 =?us-ascii?Q?TsvsWa2aovoXQ6CjhbrpIK03clUgOLc4z8XekOClI3INKka3nvt/183oDzFn?=
 =?us-ascii?Q?2zEvY6Kedi4yLV4Fmmrhg81319/HGI0Crapse1vmAk9BCCfNjuUi1AJdraJE?=
 =?us-ascii?Q?qmErVuJCj8pugAEotR7LexpZ5BOLfw4JPl2GoQRFA3UmSnzcnu/DuZDCMASY?=
 =?us-ascii?Q?0Eo/odT39oAWpGEQZiTOubKOM2PZ8vsnIyu2g2px3khYE5yjqK26Khy811Pe?=
 =?us-ascii?Q?zKYBoAhUakJNaaie9IA2d4wQ1lspusu6BIj3KtHd+U99av90LbQRdWBifOCN?=
 =?us-ascii?Q?Drj6Xf7n6zqysSzRHqCzP42szpHH8+OLVtL6QiaAjKgY4UJ3Vm2CeVQAljiL?=
 =?us-ascii?Q?SPJIcse39AiV2smzndzGjwKZjiSu1Eei2DAWsZfODP7dB0y6hc/RXOMclhJv?=
 =?us-ascii?Q?U7HFX82FqyeubiY+yj53ITRvq3jq5nqAqs8cJusYxQNbWhFdZ0kvE7HdxrUl?=
 =?us-ascii?Q?mPKeFq2Co6Xzy1QIm+jxL9KIoX4fn1mbnHf34iPBhkLyb9F/iB/EDK+1LwcA?=
 =?us-ascii?Q?Jwnf+U4oHAM83kc++MZp+PWcPhMd1ltePWGoU+dSNwR6iE8SixXpg4Hh+Jk+?=
 =?us-ascii?Q?RSDb2CrAmxEXtsx6gPgf3PHegOlLuLjsPKZu7k0HYCNpWtYIrKDTlEvLL1K9?=
 =?us-ascii?Q?8vV0KUX3+Tp5qJd4e2lhzR7sLAJnTEQAN9DqUeuKJ1l+8hkTSXcTZi9SeDms?=
 =?us-ascii?Q?DPf7tiKDQ3GUQwxH25gxmJc1l1y1k3M0HCzscIYP+9wFnS2zY46sl/1nBdR5?=
 =?us-ascii?Q?TYD7TrFWp0Md0jeT8xR9ezYRrBpv4h/msz7JT0O+dxw5mdtaSo095POgB7Vl?=
 =?us-ascii?Q?5ueIbDrN/0hdLKfCYodg34OGQ916U4x6DFNEgR0xqyz/5XgiarB8sCM0GbXk?=
 =?us-ascii?Q?34lOFHKtn8vlfI0kE3Rkko4xgibmlfeiTZUq5jplEqqNPcnIbMQuQ5irabOU?=
 =?us-ascii?Q?IwPFlXWUwuUekCf/dUDszJbVAJ3eQWj347ML8/KIMkZHox5kU7DuO6PXxpVn?=
 =?us-ascii?Q?Hqv08qhPxAOo7O+Z34hUs4Ejutg7nbRSOV0Enq+lWYM6+aCWvc8P3xAqHTR/?=
 =?us-ascii?Q?CAr/7yuhFrtz/gGFMoqi7mSd5Q0tfkuIM06r2TqcS8de3ybvXdmPzOne89z/?=
 =?us-ascii?Q?RxGHj60OVVTubCLWrt7aQDyz1J/QGCZGAg0GnIJL+REBMYru5kpgWOxDJ8PR?=
 =?us-ascii?Q?l8v18TB3vzHB0jjpRetxGrBQJ3v4nKEsIEjVOSfykpS9DcQUHAEdr1W1e/T0?=
 =?us-ascii?Q?fhMS6n4hDBigQ75EWiZmgW5n89j1XxbjUlqDy4+X66YDkuCJtsNEYK0lib3w?=
 =?us-ascii?Q?lZNAiBfpgYoCVM4KOpHMiCF0GaMn9KZFFZVN33GE4yCrzRrJU132mULrT6KG?=
 =?us-ascii?Q?Z+ErRg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca45583-acc2-4833-190f-08dbf0cdb590
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:24:10.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x4bwdr5KKS1bn1yKibPM1XSUBl5ULC/GaWyCncLKlfrBbqH0P+1DjGpsGeMiAyIuDuwK7MvJSbFaoTE/pVodw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7487

On Tue, Nov 28, 2023 at 04:36:15PM -0800, Andrii Nakryiko wrote:
> Similarly to subprog/callback logic, enforce return value of BPF program
> using more precise umin/umax range.
> 
> We need to adjust a bunch of tests due to a changed format of an error
> message.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

...

Q: should the missing register name and values be added?

I know relatively little about selftest, but scrolling through it looks
as though the expect verifier message is incomplete. (Admittedly lots of
them are like this even before this patch, and this patch improves the
situation already)

e.g.

> --- a/tools/testing/selftests/bpf/progs/test_global_func15.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
> @@ -13,7 +13,7 @@ __noinline int foo(unsigned int *v)
>  }
>  
>  SEC("cgroup_skb/ingress")
> -__failure __msg("At program exit the register R0 has value")
> +__failure __msg("At program exit the register R0 has ")
>  int global_func15(struct __sk_buff *skb)
>  {
>  	unsigned int v = 1;

looks like it is missing umin/umax=1

...

> diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
> index d6c4a7f3f790..4655f01b24aa 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
> @@ -7,7 +7,7 @@
>  
>  SEC("cgroup/sock")
>  __description("bpf_exit with invalid return code. test1")
> -__failure __msg("R0 has value (0x0; 0xffffffff)")
> +__failure __msg("umax=4294967295 should have been in [0, 1]")
>  __naked void with_invalid_return_code_test1(void)
>  {
>  	asm volatile ("					\

looks like it is missing mention of R0, etc.

