Return-Path: <bpf+bounces-14563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A83D7E6573
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83F11C20988
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE35D294;
	Thu,  9 Nov 2023 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hcB4imeo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E572DF52
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 08:39:51 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072182D72
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 00:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnpthedrLZDs/SiBQoUkYuFXBIPzdX+nRbZbk2NKWTi/r02dmt7XTdaFTjgRH00S5wD9HG2ukXKtc3A8KbxuThkrX8rTTsNUgZMNBJqwdpKiGNgpDpxHB4u1eM55lyWBMENVZLUpB89mcq0PEHTLDof4hxtK+u9LwSeVNMffPOhlYeGuxf4O35h9echw8rTWU5AcPRsGbktRQwPISaVpjpVkAZcfUzqe5osS+4mh6WOpoKH7S7VSvsU1Q3GorG2V/ABBlY2j+8XjH0p3VkgzMNL9ppzoG+TwAPzVJYhS80OKxDXMl/DHUdydzw4AwEB3Kn7DlL5dRaIFzC+aBORZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tYAckFUCfCyroQYAJJJNEPFQ/DgIJk8oXnIAOQU1DI=;
 b=lugWrs/gPdl7ZxmC8ml+rLB4daLuh9irAROQ2LWy9Wna+KiuNNik9ro57zny2E7VMVJc6VhSxJRTSCU586UVs0Ac4r/zNpSkKC5hRbL9nnuaISx4wIQD0VM/pIJwc3+TCp8T5gNIdRU+aPWELruZFsifoniwJONDgqTNPCDyv+7fOCWiX5FbD7l4Wguz8ptUD2VBsKaBtMkKMPkHjHvL3h5HSASPoxyvPCB2VHZ8Ty0reHLD8uPEoH8Dv12D94It3oyyq1Wf7d2dM5np62FAjBYyEROCCRVIn5jE43PkUX9qAVp2poDJALnJnQ6Ava0iduar9fiBeQXzv8a+MZdVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tYAckFUCfCyroQYAJJJNEPFQ/DgIJk8oXnIAOQU1DI=;
 b=hcB4imeofjqxRA+NMuis5BLW2QIzH41Ou65obqEpBXt7fxe2Gic2CEzTe6JKEy1rlJ5z31yxdKRJFeiJTibY5yuA1W3osfM4UROC4djykHYKtyEt1IQuVohCOGM8/4AnIhwvIHzTjsxVBHtBKKnr4mEn5ozoUOI4GxewxvOS175/lScgjxMNn14tkEI6hDUtGSVolS9rEUr2WN6WAvpfmErq5+sEyXrHnPRn4bLgP0EjPYAMevDRlaq5Eg9bly/0HzlYGKHyckXHNr0Go8a5uOtPGoEYZFkP8wt6Ctk8uYX3+W7lEvjHWuFwx7qaTDwg9dY20prf85rzN/ABctY2ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 08:39:45 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 08:39:45 +0000
Date: Thu, 9 Nov 2023 16:39:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/13] bpf: enhance BPF_JEQ/BPF_JNE
 is_branch_taken logic
Message-ID: <plgh6npqfqez5malbq2j7ayc76v2p2kbbdasrpioef5jszl7we@x2emwqpkg7ki>
References: <20231103000822.2509815-1-andrii@kernel.org>
 <20231103000822.2509815-4-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103000822.2509815-4-andrii@kernel.org>
X-ClientProxiedBy: PU1PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::26) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b097db-088e-4fd4-0316-08dbe0ff6c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rMHmPFZ3+bdERofKiVacE7I7QIfifgy5txRUtXkrsiupd9WeeTGXlUzEnb9wSKj3jEXsbT7CY7Hvnxyvn3TaPIDWk53POzBNUyo+8UR6DtUaPavT5xp20v9gRwoZZYYLA5HqW4UJlL7OjgIH8VYs36p0ynDgYG+j/04BIQFYTj8k1/7uVjgJwJiKCmgrCyuil35WGgsjuhf5Jvy4n1dUkQrQ4MpaYfihuKqnE9F0tsTATDQTjm6TybiULXZYFowVgf0m4zhCM8DSQUaxZ9j9mLGURQVUkFEkh3VtWTYr2ztoV9ERCmxusUGAf9tjepWTlO3ejGFQOU5jLWHVXo8VYoKp2zjhQDxNFua1sKUcHRFi1erDLOw6wmP+7LSpUYSR1gme2Z8MdpxXM6K0rtilOZhnBNfTg4YxC+NJTxV1SJGyED3urJJjEX6Kz7p2zQU1knOjjBIdtMQ3DqKB1QUqpv87UJICCCiG2wFABYAwjrckjghWuAC/7U9XLs73oZbcsyBmVL6szXKsqsyYV8foUA1qUuMTA12ZekELG/6sS/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(6916009)(316002)(66556008)(66946007)(66476007)(2906002)(5660300002)(8936002)(8676002)(4326008)(41300700001)(9686003)(6666004)(6512007)(6506007)(478600001)(966005)(6486002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bld8Ym16LVF/k1ZKRm7ujFRbru2ynjriC4GWCBSLBsPSU+MZ74NLup0rd3xZ?=
 =?us-ascii?Q?zbYY1zw1FoFpqcTp20Zroby1N1lw1QL4vJ2oic1v/SxNv7IBsYorxoCFH4fu?=
 =?us-ascii?Q?opcWYZ0SjAHTZugM0ExH2HoRVPeabA4yPu+dCuK1TY/yIrEkqn4RVYsn5uf/?=
 =?us-ascii?Q?NKs3CxIU64HeWk9DeYxSyC8ob5pLBL19numOuW66VM2v4dHW8NwvePhsv5z+?=
 =?us-ascii?Q?PjmF8wZiTuKaCs8FERk/qYpdskPUBewlTUGCnG2vE3MV9in/erSOqBGStAwi?=
 =?us-ascii?Q?rxeWpKgZgFQMt1Hq4765qN1dLWd0RJJLE1bfd7ee+QWdZ6V7jHqrhnqZSRGN?=
 =?us-ascii?Q?ZxfEnE+cY0J6AfgHDkgEi6myxHM5/tvLskAoN/+fC9EGK6JV3+tLMqJMDRjO?=
 =?us-ascii?Q?RZeRduXmZK7a1zfYM9EczopO5JnqwQNalSjkQFJ9qgnx1yZALovT1xOBCCX2?=
 =?us-ascii?Q?8e00JzC5SFITIooM08Xmgi8RNLgBPV0TErR6Agl4fsrx0kq8SnioLV1tAZmA?=
 =?us-ascii?Q?v5Xoha8phhsl249ONNR9rxm5aQ2NpRWHDFYJi4hbNqoFfRGMoXQxaNnOdC4X?=
 =?us-ascii?Q?Q464cG5Mgsm/UJK9WEnGCX8HTIWzOQXLaKSG/MtZA7h5fEdFVRLXTHgMjIiq?=
 =?us-ascii?Q?Q82/IQWs36RBKtvruXps3DQDeVLCirTEwzg231VFFjEDZ5Tn397BHKtwAeoC?=
 =?us-ascii?Q?OFiBII8xuxWtU7LJae8Vt+bNh+gRJTfg7oeFP2hwwYYbadfV5l9Rna85JolG?=
 =?us-ascii?Q?1qqcshvPS2u8Z3pq4f+QSqwKskyFnfh2uMPQeim56pBcZsM984lha40tzFX+?=
 =?us-ascii?Q?rrLKYq6FC4nMakchyABk+SF7hoLSUtA/GBpqGvSySV/Ww953DOSwnhHFyqFP?=
 =?us-ascii?Q?F05nJwM3V/7hpC05lDujmyZ2gjHjHAyTvPOnuvhdqLOvHEWbTqlcj0/fx7Y9?=
 =?us-ascii?Q?eWBEGU9JLgFzR+ethcT9ZHtsrC3obeS93CABB0QAWa5UxZR6DbioFjsXC99p?=
 =?us-ascii?Q?qmJI+BhOOsbDm7kOUPkqyzQMYQAbiGOjLLJvqBoRK4zSNRkG3yXa+LMCyB6M?=
 =?us-ascii?Q?tyk+0vLhX7lUlSywcxVvwH1PgjAcHt4KInviDuKWu2esmcoijykXns3aQS2m?=
 =?us-ascii?Q?+IBA9tmbfR2gHJ41qxoRvOoYqQDX/6l1vtwuhpHe11+/Nq2fwa/XvX01vM6B?=
 =?us-ascii?Q?sjTaNx4ASW+ZLPRUQIJUyu/IzTaky7VG/dBmu/RF4QbyIStegqENXP1J6sQ3?=
 =?us-ascii?Q?Pqt3/qjdpMs8m6DRWLCc0trcccmHILik3lsqCrHpjMJBtsWSpSyBbKuZLsvE?=
 =?us-ascii?Q?9LyGIVc8JHOSYRBmNVlUAkM5b/PtxAVxbpVaMygoVwxAsuXRnfHdKa72g7Zp?=
 =?us-ascii?Q?tJFT1o5YAJACN0BFn/fb6XwiVkswIkCmMt1N5BoH8uh5qsBWUPPBBxCBvfqp?=
 =?us-ascii?Q?W/a8sKlEl2VRvwDRsj6A7/bbbqo2VPbd2lU8EOIv7dytdEq2kTkMOVWSUa9v?=
 =?us-ascii?Q?rXaesdAkOJqYrrdyggT9HQf5G280a285IHD7fccqY9JCi+obZqPiH+2STjVf?=
 =?us-ascii?Q?+U/Eqm5zwfPA+QRcsdWTBfRieuFszPDueg/lnlKNPa2s6iBOz0qFMYOUAdOK?=
 =?us-ascii?Q?JA+0diL5hGN70RICarYEKCWs0VF3m1WqxolzmPUS7+Ck?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b097db-088e-4fd4-0316-08dbe0ff6c6e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:39:45.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Phhsp16zcuUnMS2A9XdZmVMwb2GJ4Z88cAwa/Lv2x8ToS2Ong9IVWaS2cHfiH336q6F93rAB91V0B7aF8Rz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908

On Thu, Nov 02, 2023 at 05:08:12PM -0700, Andrii Nakryiko wrote:
> Use 32-bit subranges to prune some 64-bit BPF_JEQ/BPF_JNE conditions
> that otherwise would be "inconclusive" (i.e., is_branch_taken() would
> return -1). This can happen, for example, when registers are initialized
> as 64-bit u64/s64, then compared for inequality as 32-bit subregisters,
> and then followed by 64-bit equality/inequality check. That 32-bit
> inequality can establish some pattern for lower 32 bits of a register
> (e.g., s< 0 condition determines whether the bit #31 is zero or not),
> while overall 64-bit value could be anything (according to a value range
> representation).
> 
> This is not a fancy quirky special case, but actually a handling that's
> necessary to prevent correctness issue with BPF verifier's range
> tracking: set_range_min_max() assumes that register ranges are
> non-overlapping, and if that condition is not guaranteed by
> is_branch_taken() we can end up with invalid ranges, where min > max.
> 
>   [0] https://lore.kernel.org/bpf/CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com/
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

