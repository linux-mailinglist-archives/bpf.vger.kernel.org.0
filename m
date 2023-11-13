Return-Path: <bpf+bounces-14970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D37E9656
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 05:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F45F1C209FC
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 04:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C9468F;
	Mon, 13 Nov 2023 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VxV/bNU2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF78BE6
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 04:46:55 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73769171B
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 20:46:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6qlbDVwv9SdWGnDY7KvEyntydTTONQWZ+mYS+odUeaGtotAo6yVBAtnRw0A1FlGMFLyenS7InhekX1Qj3A1HCuc7Lfb0ZtePKu5LAdLpK35rLURuekx8GJGAt2PM48XdXMd6r8hVxvsIPbV1GxNcBRaeEOGHo0I3HD/to6OulDtZjuaMSwr1dcFBaxahhWaTSHrgP+pIpdVj917mM/3yH98MvKVeXXOF7iGzYpTDFlnCdgBACgCIqKzTB7e/9ME+7N245/YkHu+34IOL0Xv3G2BEISBJ8Xt3zg++bKzdMrYTyCBmMFez+Y1acJJ3yD+dLnBeyGUvzodsdoqfJrfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKesMW3dBol7vWgCQ2rY35yRtebF1eAlKv8qBRNcjoM=;
 b=TRRENtO41cz+KwtXOt5NPtmPViKfKJwWnH+OYD1aiciiI6rT4Bx4Ic/UaOqigwTH87FB7lVARrPVW/RXLOV2kDjzFqF5ylswY2vHv4OFRZOfuJc9TLLpfDprFHipzZKkf1XLLAStYrKkwg2sYMWGFVQqtVyLAx5ze+FZzB/XpYjTQywT7fDxh2FA3jc3vIHZomWjEvnJUmOhf6s7NkfwybfTrsnwmRvVsvhOVNEwbSLHkbz6FYdfyIpL99jtaEu/ueYA6qOvqYUYCkJdZ4KvSO/jMoMvgUc6iacr2kTg1j/3cGZFO6g5MRHd81rXG0WSv+w+8ImChn2W/fVLzreGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKesMW3dBol7vWgCQ2rY35yRtebF1eAlKv8qBRNcjoM=;
 b=VxV/bNU2duV7uAXks24KaCAn/PKnzzrpqpD0IYJcyJDFCLKxd/D9855ifmQmXV6K6KSoLOSl+AYSnYIj1WRFLywgKYrioQKp3jwNc0xIOPpE9jJD3RtPr6+0+6cV5DAh6I/RWrek0KpuYRHoTvzkO0WH8pGY45FZdBPD9fRT5zzLr+Lbn10teyRvNIodGnZ65PqOQSk/om5+vURA2SoVk7dOMCTq2APWqZZKRV45pgtDKzcBPOVZK7fIc5CfpgoudQDm0Ism17RaYngROf4sbTldj6jTMa8dSPe4Is2OcTsKRX0ELaz8JUZy8hZZDTDDdhum9trQd+3Vd8uaVph6mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by VI1PR04MB9737.eurprd04.prod.outlook.com (2603:10a6:800:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 04:46:50 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%6]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 04:46:49 +0000
Date: Mon, 13 Nov 2023 12:46:40 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: generalize
 is_scalar_branch_taken() logic
Message-ID: <hhekdoccbnkk7xxiec753ku43wwewyzf2r6u5ppuew7wvso6hv@cy6zd7skbax5>
References: <20231112010609.848406-1-andrii@kernel.org>
 <20231112010609.848406-3-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112010609.848406-3-andrii@kernel.org>
X-ClientProxiedBy: TYCP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::19) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|VI1PR04MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f95cee-695c-491c-c63b-08dbe4038c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hS2HvDaADI61l5+Ers8uezy2gN8weDPNB7RF90iyDELrB8iC6lW1rehLDR8oYeDAYOTXp2TC1Ww77WU9NRTwsdTR9h/YUTz8Pjq83NflaPxQWeZ9mgpXZnEHj/+UNKVL76TzIgmf4vpfRQYgfJtOGytaCRPy1ecXcyeNEu/w03kJTPrqXwRwd6tq+kgdzW48O7qgrYVaxozC2ZTwvr3xA/W5JM6zKoZS3yaGByYH6qLL/jnKrPfo4Ucx+WPhGiiGBEMZ3iIBrrW6a2wPH5ZFz8SzJeNLkT8xicfHTsmZbtPlFcb1Jod9DnskZd6NAjE2ELokQoyV5jxpWzwYE5M5E13+VG8KIh5MjHfBDbgOGemK0ic3uD5aVGAbgd8P/64y6lfegRO2Lpz7d9t7+tlQKVtJ2lYzDqc7Dxv0qFTHxQLJr7+EWL8cNVSv8x1ArHpNS5xa8v0gt5tJLTlXdWOJRjBgpzHxwvPWpCQ+WOJCbftidUDsv1hbsU1BEyfHPzPHbNy92Ja/gmrHaGR9MjBt6bRYk6gV2DcbQ6866t9IDjQoMNtMeOl8e7IYTqN4IlsS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(39850400004)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(5660300002)(86362001)(6486002)(478600001)(33716001)(2906002)(6666004)(4744005)(8676002)(8936002)(4326008)(316002)(66476007)(66556008)(66946007)(6916009)(41300700001)(9686003)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0KKLS6UNkZY+Dr14AW7Yd8PRkmKl3ywmO3FVolVo9K0xtg8/ReDzYpQidCxk?=
 =?us-ascii?Q?PnI72j21m+6UoYF4YTEiyi9rboUbQVcp7PB/ocqU1v3XMyhtuTlFfhnOPE4i?=
 =?us-ascii?Q?HB7tNsY8O36ANVDR1x8qdtP/dOB7CcAG+14vipQW28JBy+VAAMwKvCjYGwFp?=
 =?us-ascii?Q?mMVXngX98o/TW7goIkT/+ba+3bJmYK1U+HuoqOGg3+i494HHgbI/Yi0G4kNF?=
 =?us-ascii?Q?FYIpUHBcU8Hj3kAP6VjsDB/NHIUVyPaxNr+mhvx4T/g6FH1E5zX3Pe02jo03?=
 =?us-ascii?Q?oOwLeal/yA6QRUvRgmJQmQ99HbRAn4ZW74labTv5q8i2ozhsSSveYLZ3Q8lk?=
 =?us-ascii?Q?I06mja6bUe1G8C+cwLxP4RNgoTcldg2MLfE2oU8qX7vrld3JxFzapRQrqs8w?=
 =?us-ascii?Q?CVoSXlVzGduHwMKY5UfQP1CjJcenwYBoEum8aazReclEgZPlrAPerTjTmoC0?=
 =?us-ascii?Q?jnOB0/bHmTFVOuvJrdTHjmsvZtlduiOXLubPfQJJkh9KvE6wnvxl8ol1Z/tl?=
 =?us-ascii?Q?550CUFVosoX80VfDC4hj/ygS9goylcGIhpDnrJbY74cunrtnDn34gQP+5u29?=
 =?us-ascii?Q?GV9xhkoMelyX31x1EbE9XdLvmFk+yrsmMK+RImgGGPlwC3RGB581ZaUaLZZ3?=
 =?us-ascii?Q?cJdM191ht8xxiiy/FedUMTKiuvDeh7oqTi+IS4evT9OCsaSZ3cCu61B03o+s?=
 =?us-ascii?Q?lzKOZ0lb7AnSWtSib77ryhL7mC8WMzAa2FLS6/zbIVUUdMUmUEwv9YgsnAiN?=
 =?us-ascii?Q?p/6RGennYqD3Gj3hiUfaTbwgKczSfg95j5cVrfVJ7C+7pEIIg2cUbn5JEovG?=
 =?us-ascii?Q?VsOH/QaYblMrCubSO5+zyCMDChm9fTqLB0zpDut2pqoeeLW//mbHXytKgx8Z?=
 =?us-ascii?Q?zePmvtASUm4d4f9mkp0rYhl3cZ0bQN/7WUYNiG7fJavpIcdCDvaxwjoWrvRS?=
 =?us-ascii?Q?V8tO5tQ7JAy/pZxK9jXvhrPaHJEsDGG3rQVKspfy4hqmu6Qv/qU1L+7sGtAr?=
 =?us-ascii?Q?+bB0FfT058uLKxjvhCpjv2Z9SlmiWExgh5WwHweyJ/dFp14z/pe9DVXA1FjR?=
 =?us-ascii?Q?RHGV0Px8s+La5m5CfN+PY8iD5qIg2a/Kwjn8iBAxWGuC8FN+bD05P0Cz/zoG?=
 =?us-ascii?Q?Z7uM07NhGZlBD9p0SYe/d9eFDBcALuywu5jN40R8qt/qxcGKguBic1/dlnvR?=
 =?us-ascii?Q?AXFh2WAtre8xT2Hbexm7p0ljksX+Gh9HGflMK65aPHBxVuBS0mqNWzbHkjg5?=
 =?us-ascii?Q?ufyOGKJNeAVQ8ssMhmZzkwzvfXTQkV9LUD393dFlOfB5YFTdMReWtkH9dBy6?=
 =?us-ascii?Q?OxGC/mQtcnYWe3xp8IP0KdVJ+6zn+vN2jJlkfDjtgyYqoo2erP93wT7nyRwu?=
 =?us-ascii?Q?GNDwTijFSGN8+IKhK7x3FqQ6FGkYmWR5Vd+eMvGlkIh+oaw4uAPC59S8q2Fk?=
 =?us-ascii?Q?uqNMxNwvUH0G6VZAN/fcu9XbsSyOaBGQ0DFh72mCS/9pGL35IuTr1pA7KZq2?=
 =?us-ascii?Q?QHlLJucPlUrZ7JljRftpG4v0spoXbNVRH0IYvWQWyCILakqA8nidi8Ap2+DC?=
 =?us-ascii?Q?TQIB/oAdSuzgxstc4WQ0wB1A0wXAmO8QegrByvY6VINbJsLjlOy5rP0Otr9S?=
 =?us-ascii?Q?7eIDEnoePVjPHTEXPgQOsQEtA6X0ciEinxRB4ENf+JIA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f95cee-695c-491c-c63b-08dbe4038c99
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 04:46:49.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kI3qFP5A/JSqWqkXZfLb4BfUNed+X5dK8Fib6t9dl4NpAUwWbElCpXWkb1F2nuLPATeUNmoPzsl0oSPJl6dPng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9737

On Sat, Nov 11, 2023 at 05:05:58PM -0800, Andrii Nakryiko wrote:
> Generalize is_branch_taken logic for SCALAR_VALUE register to handle
> cases when both registers are not constants. Previously supported
> <range> vs <scalar> cases are a natural subset of more generic <range>
> vs <range> set of cases.
> 
> Generalized logic relies on straightforward segment intersection checks.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

