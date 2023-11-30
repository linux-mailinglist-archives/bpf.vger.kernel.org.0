Return-Path: <bpf+bounces-16231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2D7FE8D4
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B096B20F52
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 05:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624051B288;
	Thu, 30 Nov 2023 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gvo4NXHf"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E28D5C
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 21:52:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIiIF3j/h14aLw1QFSowXoZ7iJ1fnfsOYZrFs4cCvNrRl83inIkF8y2zoON4jGzF8fJs7iz32dBLjSD1JnPiqe4j/pivAcNipwKhGFwJkIKtfJDshtdox3Jpx1twsNqKi889OEEMRmton8vvqQmhmKKsyi6K3/Pj/V3UecoOK71Jq0c6dBgac//KEyJhXWXm2f1irfeFDqXHSo9O/RIOLJrYULgfOFsx8L3YmXaQjzE1/8GGo/TNeM2irzXojczxHlypAe7mmX27bwhuGrVC49iahPZpiHUjPlo/Y69ssaXv20s7o4+412NHilNkIvzCCeFtMQIZOZVWy7qVdQ854g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3l3dx/3o0vev+7CaWyQWvMUgo0Vf8ZdPwiZi6FBrWA=;
 b=HfWV+JD02QXXLhHvkklviS9N7qi3t4yAeiiyW3kGUMHtXfvDA2IoMctj6pK5wdJsdIvZSJDYcjiMKjIN9a17VQDvuH3ep3WagpNf44vf9lNumo/2/RP/BZUGCo7WI2gPlJhxsXPun07HvPpuloI513NZod4O7L1+2McncaLQlcV0WXEfzO+2idPzfbrXl+cajPrFs4O2aQtqJ5vYQhK/o+4W8mir83EIsJjpWVPs3y1BtVjxwMTRnIZM+vjGIJVrWyhxSf6Q/1QYQO96jfLO3D9+Ekm8pa9oJwuaX6xCnB1XKzA3O4JER7KDgkLymuu4AEJ4fjYIhGGV5Vya07pruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3l3dx/3o0vev+7CaWyQWvMUgo0Vf8ZdPwiZi6FBrWA=;
 b=gvo4NXHfGn5+94E1q0YabNNAmGOrUpdTQm0DosBcS626VYJ5YFlRNJi9k5+26KYUM2ESrVBVI9tBB37kHaQUUHo1DPkMZXrqF4ZY/2lskxad0L+5oStqNZyqn9LLUbB0kfBSXfXvNu3sZ9QkDzWWG9jRFOhig9ERbF9sM8zfjmgbfvYx020nKQsHdA2VgF61xOycGJErbnk4dWl/ZE072ziK/2T5gASmWuuD1ZdLzqZiVlJkVRyYl4zU0LJzH5nVth+XnnfSXrj+hZMNpSHK9EXitlYuGlYxrMcEotyITEtN6GnWtj09YphWeBdqs/Uti67JwFsnxKv7JBIF03reIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by DB8PR04MB6985.eurprd04.prod.outlook.com (2603:10a6:10:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:52:14 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 05:52:14 +0000
Date: Thu, 30 Nov 2023 13:52:04 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v3 bpf-next 04/10] selftests/bpf: add selftest validating
 callback result is enforced
Message-ID: <wh2hhxvtwkg3hfjllrt5olrmflitmb7oxpuhk2xmflob7q52c4@lv5nbsmh2tnv>
References: <20231130000406.480870-1-andrii@kernel.org>
 <20231130000406.480870-5-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130000406.480870-5-andrii@kernel.org>
X-ClientProxiedBy: TYCP286CA0230.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::10) To PAXPR04MB8669.eurprd04.prod.outlook.com
 (2603:10a6:102:21c::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|DB8PR04MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c846d0-ff93-4ab3-44b3-08dbf16880e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p5biqhoPOoM3Ca+q8EGCfeT+EqLpMICR4OqPSN4kSlhUECN2Cykr3uqNzReef5trnPJtsARetHO5vOYPb9ZvPWjASBUC2Bel26AjyRVp/r0z8mODqygWo0C8GMrYcy409yL4djg8jNBT6F16QrefGoJInV1DEu7Tqa8p1sI1xdogYGUE8wxNpZ3V974SQ/9I/M1vAeGd7+eWnbaYCWPdhTKBWzKXlk3alTd11F9G2dGM+pmCCOD3uwXUv0+MyBS4r04tHUckHbiIit5yvRSs1Jo7O+41zNWvk6TN9ZnwOL/U7xeRlw1igfcFAWw9lK/q1ls0ekKdbVEvIBUvasRlUmgP6vZ6S3MgG5lFoQD41qfD0RTDw95gPP0HYKUGY+eTNdikns1+YxDHCKTHjg8M2AojqfZwlYSmJJeU6chZPbx74Ouimm2g/QT5PHcrzgbQFpRj4rm45Fbrx2BNBBECy6lNeqPGLVFWCpxaEuK2oDb3wCqOknplAHHZ2sKAvFE3mQtMRrB1GLjmfbNTNay3YTzQpJp2Ui5jr057/Af8+G8Wy5GTsAmQyDqfQwideYF0q9I7IXBFKd6xtbttkAzKvf2y9FGfNbr/10Y/K5m5CL3DKl3cXEm6kw5YE16Ww6rO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(202311291699003)(33716001)(41300700001)(2906002)(4744005)(5660300002)(316002)(8936002)(8676002)(66946007)(6916009)(66476007)(4326008)(66556008)(86362001)(9686003)(6486002)(83380400001)(6512007)(38100700002)(6666004)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HIMYI3SGXOhZf3G5zSWUpOExktPmFDFQhcRGuyHrC92lM+FV1Hlm6ueg5/M2?=
 =?us-ascii?Q?ArLfq+LV+3AtZOXXXM+QAjCbRrSEtJGGIdP1wOWNNw6D4lZC90Bqvngl4Yts?=
 =?us-ascii?Q?sHZOx50IABn9QuANHsPSrMRa40Kay9fwyyZgyyEVjr6sFLCod8frT6MpgMtf?=
 =?us-ascii?Q?uEukglzqoHP8TgoUZ/6slxdr3vlH25HuNr0fLfACHD0nvv4Nd2xG7Ijqwi7V?=
 =?us-ascii?Q?YkkKNkfvxbv+4ZlTaY0ezPq3Ca37ALtYMRzz2NRncblK4sbXRIPofRVxitlY?=
 =?us-ascii?Q?exA3At6G4miX7N6v9kh7Xjr2K5CxyX+cAmFSWoZmfD0fvMOdFssUct/EWYYE?=
 =?us-ascii?Q?X1ml8WBZS3srNYlOvrvSOi0WJOw/pfmSExiiCvcisp70w4M3PFCIoqmgi6w5?=
 =?us-ascii?Q?k2zXr0mvUebMQcPImZ0/iiF9p6fDN42N6kj0AkJ7x69cVAYYhzEyqnLvEj0t?=
 =?us-ascii?Q?ZIYafoV2GOgfdadqGpjNpjCmDRcPIh6iX44XaAX/eARcSIdrAIGEY20kStlC?=
 =?us-ascii?Q?rL6HjCCQZSyZaBuJwdehCYpea5YFPN2NyUDAeoB3tJo9AXuyoHfXn/PNHvFc?=
 =?us-ascii?Q?HhR8gSPCkc5QdwwLXsWLYU1ZsNJSov/uzHyZNJPg61cIt8b4ggIvnqPVjnuO?=
 =?us-ascii?Q?G98xhH6f/CxdC9iXYOd5iJVFrMjBL1+XIxp4FgT53N7QJWhLTbE6vfDae4Yi?=
 =?us-ascii?Q?5rkyiEqoVpc+0oj+GDu4yEpi+3REx0bDDvmJcWgnf3H9tBAoP7q9/qXDC/Vg?=
 =?us-ascii?Q?zAhMqtOv6Juo5zREjpndQOrSA03SG3aVQelZskbgNKuxs2DQCcjFF2V/pOz+?=
 =?us-ascii?Q?r3jvg5scYcMx3z1W+w0TOr9Cnjv4u/aI8SiylmVkLGH8w4CYwWL2kLpO3l3Z?=
 =?us-ascii?Q?+H/O3SnhRwfJerYAG2JOHDDQgEtrsvDZNuLgIyu+tEAYkSVP9QZ74sdWuhKf?=
 =?us-ascii?Q?QYd++/jtwJp9bK3nsUyiHoQ0CrFvSN1eKetUOs8WnNYCyGLQxSY6KPtym+Nc?=
 =?us-ascii?Q?3zZqtUtKZX/1ann1RNy84Y9dItqbBdqzywChp1q0SxiqNRCtFSTddC7Q/DTR?=
 =?us-ascii?Q?cVJ4ozKGG9Kj7A48kQ3PGgLf6XvF++n7yCmCEggpVEvn0OLfmn/U5SgF4+Tv?=
 =?us-ascii?Q?tCZYpVFqz/HaeW4xcq2sLR4sqM96CW07+D1aqMm7Clv0Eq5LsudJB9+z+YXv?=
 =?us-ascii?Q?cslwxryInIotF5S3vKhorKrQ9pGgwyQ8ilSwaRZlPfyHK/9oVzQWnoARu1si?=
 =?us-ascii?Q?lxVz+HPeJQu7YzcPpODXW5kQXFEwCwU0QEsyTWIgV4NqZxLokrT7DNtIRoJf?=
 =?us-ascii?Q?K85GhBIGfmCG8tFvR9asMaUsdgAV3UOzDr8/LEcJRIwa237Q14Cit7te+lm6?=
 =?us-ascii?Q?DnoQgPhVb82rLCnTWiAKic1GCgp3q1zjPR8WsU6WVfAdGWgRXEdyNMP/bkGg?=
 =?us-ascii?Q?B8S+GYEUyTdjcVeOJvNB5jwjlusVblnWYzKncW/drGrREFqDfJMgNuQ7VdEB?=
 =?us-ascii?Q?/uzLPohVjhx6obQx+3hOIG3IZzaWPLCB/sQIQSbi7tiOhFdhd4oJag+mxY5m?=
 =?us-ascii?Q?aLYuNPoaP8R3pQzzng6je5AWlFOhnuIJ5hdQ6t14Oa7KNE/VsVLDGYuAj7NO?=
 =?us-ascii?Q?bVBX2Yl+R1W9O7nigFwyQFB4vL/bM0/yf55kcC7YLw8t61fif4erE6M3c13O?=
 =?us-ascii?Q?Mqf3zQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c846d0-ff93-4ab3-44b3-08dbf16880e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8669.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:52:14.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vF8smVoDaKy3/82hYzmEJPUYpSPCcC04bl9P7IHKTaGDIJJIUpqDQbuRo3ArLJ/5+9U8DZ1/HY/FQ0FDipgTfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6985

On Wed, Nov 29, 2023 at 04:04:00PM -0800, Andrii Nakryiko wrote:
> BPF verifier expects callback subprogs to return values from specified
> range (typically [0, 1]). This requires that r0 at exit is both precise
> (because we rely on specific value range) and is marked as read
> (otherwise state comparison will ignore such register as unimportant).
> 
> Add a simple test that validates that all these conditions are enforced.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

