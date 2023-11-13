Return-Path: <bpf+bounces-14969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBA7E9642
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 05:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3671F2107C
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 04:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032DFC8E0;
	Mon, 13 Nov 2023 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RTtKWbic"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A501A584
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 04:36:48 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE6FA
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 20:36:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ifj4+lRnLsI9vK1p6Q0sn0iWlLWigfQ9tVDBc3hyoyKER3DeQvoHWQgsMcKPD6sEdq2Qq8/DpBlb3Od3GSwbImpJ51obJCeGNoqY7qOH2oEjicFSRQE8Z0BKIQ1QGxtpkEf68w0iz91iVHvziuQyno+wBHk7v0FXz24+tXe4bE5JSJOcZKKHmKcc1KYHrcC7Rk3wFpDZOxjZ7ERnmd6+rQvojb2cQSBMc7kWIlgflBcmWaD/oMIarCUho88rJ4dNe52dh49SjY/KXCQbxwR6vUNa0OyPoP23sgFivIGKpNDpKhRBxU4uNqI7UOR/fSHQ7D8nAiCEpJsx8D4kD3evOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ+dk3eF5GBiV9vjiaMEVV66ctuJ2+1GHll9ijnvues=;
 b=TtMwVi67O+ph4JLwt4+iyQex8ylQG/ivuGNuKmWkEchEcQs3WV1lPXSK1G7KOFo9qP6qqH//w/nIGd4au5id08C3AJiX2oHZmbjcCMsF2cXMt7EIamJhhOhm71tem+6IIYDUCoAvOemigWSRZuVz9Joqpl23YjS5+A9546BwNb9mWjwt6DFPiuFqAjKlz6NbDKlEz4471sOWPIFISyKwsprHTEkZbjoc9renwhKx9f8bGKOl6kIFFrVOOlQ5hMcHgLeaLojSkb4q5PtfOITR0QVv1lVeJHjxx6fBywaTNpcP3yV/27a0XBwGuIQE9tRVJA/nB5CtUrMZfQB18gyfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ+dk3eF5GBiV9vjiaMEVV66ctuJ2+1GHll9ijnvues=;
 b=RTtKWbic/RjDpPSIaZRMaRmFivUTd9KynkPYVDbKKqVBbWGi8S2Za6iid9KuKCu8BX3vhXeljZhzsySJh0EUzrvUhgk536Dm9h0YZjLSKchBzLvZqTK4sqa9EORVCMjhakTnYTcotnEMBxgr0JWrq/NV5Y81B8weLYnpxTEKY7dgyCWA2/bzbPlmF2iN9RVKeeKGtY5gPNarG27XsayWaBqqf/smxfWuOoekMyha0kAw1GX89ojOzS+3OCdBFmTKQRRc+xo8uKZ6aYC50OkrSN/Lxrejh6Os9eaxjIP9JxeixVM7Ax2RpwBLyLJbwqksHqoilC8zC6SZois0ueZ3VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 04:36:42 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%6]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 04:36:42 +0000
Date: Mon, 13 Nov 2023 12:35:58 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: generalize reg_set_min_max() to
 handle non-const register comparisons
Message-ID: <gacy5y4lrh4gvynzdrwqjf5554atx5bsas3edici2luxrwr2pb@i7pvhn53d6ts>
References: <20231112010609.848406-1-andrii@kernel.org>
 <20231112010609.848406-2-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112010609.848406-2-andrii@kernel.org>
X-ClientProxiedBy: TYCP301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::13) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8d206b-5d63-4ce3-0e2f-08dbe4022230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9xjqesHLPSl3Vsi63NIEA50zH6a/mrBetxZFkcRnYmLUU1dC0DaxNYES/Rw01Xc1qw4re1x+3Mizcu7zcurlTocBPFCSbRNnxw5XPra5NyVCr5cTkSxezdZ3fOudKApzkAQAWqfUET8vcpFb3P7lYBnx5oSvQZUjo0YQhA1kzZlPXKr8dPnuuI+GW6WzyGIVfVy2fsstidB78XJheLthsArNCBL48dk1cBxqVvQHBIw+wGxl/+y0IuzPByDmd5H/hmD/DpJEv2moPWZatd/EiKlRKzslyxyYEx2MAf0NMyUbA1vcwbD88sLeeZtnbdoDj0ICP+ZW+o9QelvJDlEW2d3hYkBYqM5JMkRg67Xsj1DMxMQ3SquyAS8xWrKIDlq5ANpohH3z3cBN7gg1Q770Q7umggAC+5/9awsLoxbFo0NeZqfPfD45mmI/y0Yme8QKpU4DkNj2y8XUGF6B5hSJv3eFYf/utFZoy69j2MldXjpfcAK5wChu0Ds/2qolxkY5a/kx68MldNzrSVc4zbSzYzt8YppNn1pLaL3GkOYpBB+HNQ6RrmuhuOYry41BwZiP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(6666004)(6506007)(478600001)(86362001)(33716001)(9686003)(6916009)(6512007)(316002)(66556008)(66476007)(66946007)(6486002)(38100700002)(5660300002)(8936002)(8676002)(4326008)(41300700001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+oZNNMesWGTgLigyhvCp6gaFV6voBKrKTo7YE95tFS7x8p7nz/4shNF6d5++?=
 =?us-ascii?Q?Qh+aN7lVELXiHDhq23xiIk2Q3N3yp0sH0P13E9ErWygyVdtAON74TJcutbtb?=
 =?us-ascii?Q?KlSntX8lZLjR0OtlPJTbUsqz0QkqIW256Wzn97J4NaRFbL/qlZcfpmZ+Sq8V?=
 =?us-ascii?Q?jZvxh5/4y6WmBnKMlqt0ioLt9OSDhQFaZIPcMirdvkw/aFOaXOt98mDKYrMV?=
 =?us-ascii?Q?OQvptVnxd6ITImiMAs4U/Bqo6nPNkuzkz/4FT+/+8L5ZzC/lA8tWBPLZisGH?=
 =?us-ascii?Q?D0QHG2JEk4XAVpELs/pQUjZagThns8vRTCJjhxZ5Z6HMs715RX2GeaQjGZSS?=
 =?us-ascii?Q?0sTtOtFPu+l4249D3mcl7SsP4oyE7EFu6N/XAWPQGPOy/Jufrg2vuJHXjbqC?=
 =?us-ascii?Q?oBBfc1Gj4tqQa7YGKoWIelPeFT2CLIcL9mphwjn8xJm8EefwnWp09PfqNTef?=
 =?us-ascii?Q?76EloZ6WWiQfperl6mrWWHEUMedW89hS+qMIFbZf9Lf5FqmkmV4QsQit6dC/?=
 =?us-ascii?Q?AbNsYKZVKSCupCtWyvzusX5p6nikPKlhC8i1eGF/ct+I9TiCaohgzLsZtkRm?=
 =?us-ascii?Q?kjMjTUHfoPE+n76+tLFZzp6QNET4tPOdjfgJFWGxLFQYPmaM+qm0d9r+eMti?=
 =?us-ascii?Q?IrGyJhZdSXj656FZ8FZDAt8DwaEoQ9E6PTNfCM2iSLuqBD4KoUDIjPohD4YN?=
 =?us-ascii?Q?zUigF/YMAW1GbhKOpyy543+keC035lyqQAs8ORW8WI8p2CXo+sf4gBp0y66H?=
 =?us-ascii?Q?YnTlZpLQ+fpnZVUH+55NX2Cp8CcA8ORpEaRP1ycZgK5NTn1fjayNY+qb48DW?=
 =?us-ascii?Q?BqYqPQEPM21piQsISSP2LkQKhtsW8+19JnAUOIh82CG+SvcboqXhZR5FQEDm?=
 =?us-ascii?Q?+iKkY3je0nBnDEdAg73IgI3998+2WjjjRmSMxyLStDPLDKOq2R293ig6gyLL?=
 =?us-ascii?Q?5+Sr10uI5gs2T5r9zRVgkzUcIIKnGA1rpePhXaEUtfuYKMOwoxegR1+/slrj?=
 =?us-ascii?Q?BsmwjAuPWsaT4Gg7vBxtsHW0VtuJjNGpNQ2JWl4Ma1Ak6J1WmGglQGJpf4AY?=
 =?us-ascii?Q?JbnNDEk9in9A7niMbgqT9nnJ/gIe1SKuy5OIRcl0c7JQuxTDlt/MtWAvvN+t?=
 =?us-ascii?Q?5aGF6f9iU1y0Ww94ZDNUSYut5TqTnxc7lYL6MDsfbCdaKMN8SYchOkvC0MI2?=
 =?us-ascii?Q?9IqMGLwkagUjCdpOHbSVPmDOMEHOKBzMy3S+J1lDlJ999fg9CafqQeys8ghR?=
 =?us-ascii?Q?6HFjx3dXypQ7KKskbQFCpUE1t0jepA7D4OUbVMcd17D0skL9QkjE5RpzIrt7?=
 =?us-ascii?Q?Fy4XoOnR6cKgeK0YVTrdGBuxzwkoukQIxOWGSbOiH2ycL640APV8A+xZwf1a?=
 =?us-ascii?Q?x3+VOO5yacrgp2YD4IZcJOSBWSK054tyJdfLvqSPo1xho9Zvgqni1z0NBRFK?=
 =?us-ascii?Q?4yB7HpUOSKM5X7wJt0NZSbv/RujoU72riVBfIU+XHcCzOrmJ17ME7BC+q4Q6?=
 =?us-ascii?Q?6hLHKS4j+BKcOds3/PTFtJ3w3d0xgGzUbk5KGxJz0vMna7p4rXUnuVo6tPck?=
 =?us-ascii?Q?e1o3ptKoU3bQFzLoY7af9PyFTrJo4nVQkTGD8s237PzLAKlwSNGatOl0ISNU?=
 =?us-ascii?Q?HCjWazF0Hx2ga3wfB5mxF6U7xOdacl08d2dAfUnQjqXV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8d206b-5d63-4ce3-0e2f-08dbe4022230
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 04:36:42.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xy+lU+WUxmLxB+O+PJBfir8u+ItL+kxC0A2DLky9+zbZYn5u1qa6jxz370YJtyO/2LSHkgeX1KOItnxCVkF+iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

On Sat, Nov 11, 2023 at 05:05:57PM -0800, Andrii Nakryiko wrote:
> Generalize bounds adjustment logic of reg_set_min_max() to handle not
> just register vs constant case, but in general any register vs any
> register cases. For most of the operations it's trivial extension based
> on range vs range comparison logic, we just need to properly pick
> min/max of a range to compare against min/max of the other range.
> 
> For BPF_JSET we keep the original capabilities, just make sure JSET is
> integrated in the common framework. This is manifested in the
> internal-only BPF_JSET + BPF_X "opcode" to allow for simpler and more
> uniform rev_opcode() handling. See the code for details. This allows to
> reuse the same code exactly both for TRUE and FALSE branches without
> explicitly handling both conditions with custom code.
> 
> Note also that now we don't need a special handling of BPF_JEQ/BPF_JNE
> case none of the registers are constants. This is now just a normal
       ^
       missing a word here? ("when" perhaps)

> generic case handled by reg_set_min_max().
> 
> To make tnum handling cleaner, tnum_with_subreg() helper is added, as
> that's a common operator when dealing with 32-bit subregister bounds.
> This keeps the overall logic much less noisy when it comes to tnums.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

