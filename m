Return-Path: <bpf+bounces-16137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6799B7FD4C1
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 11:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FE81C210F6
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F2C1BDCA;
	Wed, 29 Nov 2023 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J8C4EtW+"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2044.outbound.protection.outlook.com [40.107.103.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433D695
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 02:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZkK8Mn3wwH9GEH7tOrIlcYnm8zsYEtdkA0YYkSBasDB2M3VejsGIQElZTVOSUm7FUcYz0d6MDxipGu4cf9QFBGmwZ8LL8DF0n7PzIYmPSOKHetnkXCMUqKBpsE1h+Q1GOfrAldVa/L+KX6DqpsQ8vxcHLNWmAtJiuHi94f0u3WAbOsdpcY7BWFvT1IgD+ukSrqIpiwI6s38eeuSTAQYnd+zpX+4TKzdJ3SIaFcupmQ1v1Yn3W07pbKwghqC3x7qXgMSp7pYSJzHN9A6Asw1b5OXFyGxcldUH5y0c6r2X+VXF+Dqh2+miEaG6rRxb5AhCfp2ZVcFBNoaKNKjotrnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWEpPM442meNT9guE7V8W5XyRsP5I2VmRQxjRzzSdRk=;
 b=S0TKftiEUxQzT+XrFJ20D8x22x5rtXB2QW4wXw4b92DkcuI+sKHNC3i0mJh6+Q+4n4NKat3G0Yra0a91rJFd/nXE4UYVeA4OPwUiYeOuUyPqMIDBJ/Q50cg19aWMV5e/01fLq7xabgBNp0W8ZqkVwtuBmqqLdncVmPed4+8YjT2QkZHt4saqIkFrNIAxLcaIQDkrLW+R7M090mJJWeSNvMDwkUGz1nXBk+6JldCQzb+Ce9MiarTCKGe/uCJL2Gd7yw9Y81vzZ6KZOGaFkuHQeOioCq92gZImrLQT1GLJoUGptGMvV6SM5y9lKVDsyd92p7NNla+QBsZlajsOshEfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWEpPM442meNT9guE7V8W5XyRsP5I2VmRQxjRzzSdRk=;
 b=J8C4EtW+7yKzxbYPLol/GGLCrtf9S5y4BHJJ8maF5tt0PgxMkNnhDPuY/2y73Pe06DMzIalW9aiFp5jET08JduEt+Xwna+SaLlNe9LnJrCGpe50EviqrnD7wpT2mAJGs7Z514Z4arsxb6fBVKtXkHrIxZr5FApcmln9u+2d+1McMjnuoMHZsv2VwhfjjIii1QZbRtdbTymZnAi92rjlPqhXFkN4sXSmZLJ3CkqIPG76ZoSnRlA7HWIspDpKfVrL31A/z3wmiGUxVBBN1PwYuPUZEWzsdmIGoULPirzXr5Tl/JZXLsqDCaDCRQUVvpZLQKGwl1vVt6bTroJaTrBdbjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by AM0PR04MB6850.eurprd04.prod.outlook.com (2603:10a6:208:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 10:56:09 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 10:56:09 +0000
Date: Wed, 29 Nov 2023 18:55:54 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/10] bpf: enforce exact retval range on
 subprog/callback exit
Message-ID: <carufygwn5mf27v5y336tout32yokzoqhfaot2skxgn7s54rxb@qp3qicqilpcz>
References: <20231129003620.1049610-1-andrii@kernel.org>
 <20231129003620.1049610-4-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129003620.1049610-4-andrii@kernel.org>
X-ClientProxiedBy: TYCPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:405:1::17) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|AM0PR04MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: b57405a6-693f-4ea1-05e1-08dbf0c9cb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PEV8cI/n14q0zrwIVuOKtsJyYebz9lSQ2w34Pdl/pcOmvD4pDgqNZ1r3LG2bzSkvWrh4ZqpE8rKk01MWvjb04TW1NL3GchZ97cf+gaW3J3q1p3w6ovR3xtPopz6A03wjOUS5L33wsiCPfKtYu2XHCij+0MPBhxpfYuDtaa48PrYUNPbMeTsRIINthzhhfsixZZvufSjTvb+FL9CLjx2MbQ2EI0Vqk0aRlk3ZCUSEqbhFomNqvh86QX2VcGFcXkuRX40GpV4u46cpA24AMDoaeqOnQBo7ftrFR5iAv2NqL+yCyrhF480+ZZR3lWhjOyq/OmFQ5TCVxPvbTbCRuSixrEreZGp6GVWD5IZBTYOeVEBkRC2zTHVfH6djgjBguB1xIHUwcajLN5+SAQCj8h3Bq1eZVsGW0EET2gY3jHX8k4ZSS0ecHzJgZJvt15PUvTk0aaeuLCDE8ryrmkJQ2WNXCEaLep2Wgir61G8xQfpbrbaGwbTnLDWzjHQzBcqjCrAujJHfj6KLeomedQaXsB7H1mydH/8/sr7TVUjCegK3I4CwXbCMaNdIrc6WfOLvMhiN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66946007)(316002)(66556008)(66476007)(6916009)(83380400001)(6666004)(6506007)(478600001)(6486002)(38100700002)(33716001)(6512007)(86362001)(9686003)(5660300002)(2906002)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPFwXBkeF8zZFkvjr/FU2k0LY46oxAXsAkE+UU53m12rgXCqjouCvxZ5BJU2?=
 =?us-ascii?Q?fQJUAhBxB71NtP4cDT/DIoJLqTEUvO/H16rOG1sWSoAymCnXyB0448NNFDVz?=
 =?us-ascii?Q?elot0NHKk3Jm99Qts1az46swBsLSGE65LqbAfDKKlvUiIjMtylmcqVCAR5cd?=
 =?us-ascii?Q?ygPMxktrIuSXG9C4OikxwboA/qO/so/jbRJCFHPySrGbn4yB+1LnFkyW2xh+?=
 =?us-ascii?Q?IkrNmJ2KNaUS5As16DS6aFKTchcXwpZUgMUTei5f/s5qB4N6ffAg1nWn/6FO?=
 =?us-ascii?Q?XR7hOLgwoJk0UBcydd706gDYiM0onY4O+4JDttDcoQ8V0yjZPGV+fsejhGMk?=
 =?us-ascii?Q?IpTfKgqe6kkllPfVZ9/62q/82/jgYS+NUhCEWbL0iquOng2Ngl3tHveFJOoZ?=
 =?us-ascii?Q?PByjXQJvpHkeyFeyIu5T1Hrb2PkpgaB5gotWSIN+weD6S3D5dbBhWeA27n0n?=
 =?us-ascii?Q?PHI3PNkaoTU1fHosEw0nawwBsfCsgHL/uiRyMEBiqijG69ziwNIho0vhVg71?=
 =?us-ascii?Q?ol+8qW5hlaYzMOAjik3eKczP/7CCfNgApCYXFJlBriN+pfF3t/OPAq+eKMmQ?=
 =?us-ascii?Q?QH4hSiuSZLXBD//IkWYl7V+wYy2oNVMm1URYbDJnq7uuqDjeMGMhlvkGKOqZ?=
 =?us-ascii?Q?AdgweiExluXsoNQA3V1YZ/ShXYNryu0i/pwoWc481LtGldAsZivA98qsFxzb?=
 =?us-ascii?Q?LjFcQRqJ9SSfhdapDDs5xv96b4H2tnv3m8amtsqvMKJW3etuXrl3F8hossW3?=
 =?us-ascii?Q?+jAkCZaSBuAbxep5Ch0sdLgkUdF8uZQu+jq58DEN7U51K2qbFDys9a/ZUZGG?=
 =?us-ascii?Q?Dk8ctK2SjKTMW3uKacuqz/inJZ/mU6Kq8vThdL5xu/iAY9cD9JA91OY8xy5U?=
 =?us-ascii?Q?iaD9Fhi/djGNrcGkO0maCEObdudldE/qdKtKth05d91xVh+FmPd6mFljai2h?=
 =?us-ascii?Q?oWZSx70UUJaFFvZakW+0UdErqfeoxIRbZXabqOcZZ6wPYLAddJFQZuvZbs9N?=
 =?us-ascii?Q?t+aXBLTBpAiFTED1ixCPZE9XStmBRyh0cqn8WtFil+RR/NxvFEMaA1NejCHV?=
 =?us-ascii?Q?LD4lttfHW2FtyKoFKF87zebziDljSSxTt4bCGoHscTONeo0npCee0UWmUVPM?=
 =?us-ascii?Q?JKEJJow02auihzvePs6k2GzTpwCSYVGUMAjnjiPHH3VDlekf2wnXXj5L6xJ4?=
 =?us-ascii?Q?eDBWVNXTVuXlZw8L243sOBFPrAzi4KXzrk0keIxGhHsWegVWaEwX/atO8eEE?=
 =?us-ascii?Q?77rmTiTbB8Rd5uhHotv1RcImvNeEae0QmCHkllxK3gybv2Sr8lCxt6hjmEyO?=
 =?us-ascii?Q?5x6D89e/6F17POA+kxwg+eFSbnlqgPxhbgG1My8haecei0NrIptwNWJ4e6zk?=
 =?us-ascii?Q?89mb5xq4esADvQiCBj2sljvIsxTIRXRU6swK1Vt6ZZX4YUWtqqgZm8QYNgTR?=
 =?us-ascii?Q?EnpOocr5BL2U58BLGsQGCrSYzW/o7V1tbKiIHGkCLSD2Y/rUu5PSHFOmJ2WR?=
 =?us-ascii?Q?RHodMkE+A6jtEfgC9BxgXeep7YbVGR1EFUXIWu6bEtYlZAWCN+mN2Dfnh2r3?=
 =?us-ascii?Q?i8a6INUT4HuqB77avYwxSy3a+WTK1pnGdZyIF51ZiRoCl85q9OnpBygqaOy+?=
 =?us-ascii?Q?gTIAWnUifGYaNoeCqpSe08I5c4yGnw2koH3gnTUp4JS434F/wBbT+jenVitI?=
 =?us-ascii?Q?7dNjkA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57405a6-693f-4ea1-05e1-08dbf0c9cb46
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 10:56:09.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDlf46DuKAMC7EgFFiLY4WOZNrj34dioSwnP/sCHfTqA05J+kOrOnILFP7JjDBSkf5Vh1/5UzMbfkJV2fXKvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6850

On Tue, Nov 28, 2023 at 04:36:13PM -0800, Andrii Nakryiko wrote:
> Instead of relying on potentially imprecise tnum representation of
> expected return value range for callbacks and subprogs, validate that
> umin/umax range satisfy exact expected range of return values.
> 
> E.g., if callback would need to return [0, 2] range, tnum can't
> represent this precisely and instead will allow [0, 3] range. By
> checking umin/umax range, we can make sure that subprog/callback indeed
> returns only valid [0, 2] range.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h |  7 ++++++-
>  kernel/bpf/verifier.c        | 40 ++++++++++++++++++++++++++----------
>  2 files changed, 35 insertions(+), 12 deletions(-)

...

> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9560,6 +9565,19 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
>  	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
>  }
>  
> +static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
> +{
> +	return range.minval <= reg->umin_value && reg->umax_value <= range.maxval;
> +}
> +
> +static struct tnum retval_range_as_tnum(struct bpf_retval_range range)
> +{
> +	if (range.minval == range.maxval)
> +		return tnum_const(range.minval);
> +	else
> +		return tnum_range(range.minval, range.maxval);
> +}

Nit: find it slightly strange to have retval_range_as_tnum() added here
(patch 3), only to be removed again in the patch 5. As far as I can see
patch 4 doesn't require this, and it is only used once.

Perhaps just replace its use below with tnum_range() instead? (Not
pretty, but will be removed anyway).

> @@ -9597,7 +9612,10 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  		if (err)
>  			return err;
>  
> -		if (!tnum_in(range, r0->var_off)) {
> +		/* enforce R0 return value range */
> +		if (!retval_range_within(callee->callback_ret_range, r0)) {
> +			struct tnum range = retval_range_as_tnum(callee->callback_ret_range);

