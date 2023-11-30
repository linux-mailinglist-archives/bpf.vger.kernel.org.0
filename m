Return-Path: <bpf+bounces-16235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33707FE936
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 07:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886E42822D6
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D5154B8;
	Thu, 30 Nov 2023 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="k7/seFRU"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C602910CE
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 22:34:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1JSfrB8T/aC3vpJ6PfteyYeqBvOPYASqifT2mlxgraBIz2GzE6kIAghe68iLVmFjvi9SSkR6BmOGdiz11xSmoafR90uFejQ+rIxejQQc5VZpGxeO/Qgi9FTs605xxoB+5C+2PfAnjiiqm5+7wFESysthD2dTXKGo3EttWKaP+Gwt2QgsjCVcbVStm3sJ1KAiR/8HcR41M8mt14IyC0EI6daGVkRAbRqhKJBiNt/+2WHnxZpexXCUytjP0PrgY4CPZ8OlkFDa1UyR5QRLN1mbkrhRTiDuHELHGfH/hE7men52QHRihebZr7LkNJgzRdJzPMCYzEvNqPS/GtTkYm2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2eW5CQRYtlHkEhphgYff59QBo5gKhBAbt/GZKvfYRk=;
 b=lcEg4lJk1ZRODpSDdEtlZ+b/b68dG5bpiItEmYHcbqIEARqMl2Wn+3ponDT4J/omINWlxwDJTmCJkJq60BvIkmz7jKqOIRyIzgyplq1WNudQaKPceXWwNYN3/rTn3/SKRT5A5BY3aALyX9Y55tLpmpPWMPVmaGFFlpXpzREXLjsdeG17A+t3nS09t6bpjX8OmZHnKFvNrS262eCYyOBnF+6NtepXmqfuWsmogyoU74zNXPGfTJjL/3HROGPCsKjdupMOYx0Py/U0QQ2EkIxpYwlkFBsM9s7CsMH47x2jRlt17Q/llKFYGtu+wlqUUuR1UbYApKX6yiiDm2D1iOGX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2eW5CQRYtlHkEhphgYff59QBo5gKhBAbt/GZKvfYRk=;
 b=k7/seFRUVDZeNxU1i1QszAuQWq3bKWgga+Y5TmoJM4FXBTSP1TKzdOGyaTjAACFX2Yx4kQt/6SZK1GFDwl6sxZ3qJaBPEhqEWNPFsnk00Pw9DhfTtXhYLfuEKz2zucbJtd7jETnUKEDsTtivZeTfT6GebVBrKyKnU5EBh5UVADomY2jf2ZuRzybdUyrdAocTUMtqJ/4s1E89HttqDf1/vHjJreQYYn4S/ekMyqu/fFDuHkbxY3AlFI/qVlQPiX6aMjnZz25nTiqzamgQm5A/3+ra7mjn5bn3zAFs/vWtX25D9s/bou2hZHfR6xgKjIuEbvtxnnce1vjXNrQrY8bG5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Thu, 30 Nov
 2023 06:34:46 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 06:34:46 +0000
Date: Thu, 30 Nov 2023 14:34:37 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 bpf-next 10/10] bpf: simplify tnum output if a fully
 known constant
Message-ID: <55qt5jr6srtznchng3sxdjdvril4gfd7bf7ysscmzfpdxidlrj@uy3qpd5fk5fu>
References: <20231130000406.480870-1-andrii@kernel.org>
 <20231130000406.480870-11-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130000406.480870-11-andrii@kernel.org>
X-ClientProxiedBy: TYXPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:403:a::20) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f2755d-23db-4ebf-7288-08dbf16e7231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0PMzNwchNP6Q4wnA58blLLWIikAbsHhdCRIJabHidFBD9seCOMvtcNapMizR5tK36LKo382VyXae93ZxzJuTPNL6QJhc1ln5axT6zvnw26W1TAtKwnJz8qbvYxa0ST08dr8HXikNvNgsOteOG273zY2f7IJw2V7f+4bsGevbNs0qO3CLjr2FwLBb4Z02OpZRWEgsuVTYphaX2ENzQxiBXIPxev5USc4kxKDJ/Ws9k46JN0y41UkuNGaGgGeKa5A5EUDvFcuT4iIIltoedP0qzMaNFM/r8UVFi88KC0nJk4l+4Dlf3uz6FdJfkFo7/XoVqfPIM0xLo1kxE5idcWIlUrioPFNrdze4XGgPbjrAUeE4EsibmWz40XRO9n9owauSJlWFTjlPkptOU61EUJfZdz9zObkUTL4IeCUEnhaxUxwa9ZlW51Wi4sYXnyOaRMmyvYis0XtFWUVxxNXjKWIHZnfKKTH2qXCS09/PfGwePRM5Gp+FO0AfDyiwj+GTMwNKVcaqgRx3Ggenf/Q+Oi2L427fz9FlwHfygiPY7esjooytYolIjRBC3j6COPa7DUjbvjMtUh4utzcb8wY6hNp8nPJdwL8h1iHirzTlBgeN6smnol6iP2BXzUapXBD8YO+S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(4744005)(66556008)(66476007)(66946007)(8936002)(6916009)(8676002)(316002)(5660300002)(4326008)(33716001)(41300700001)(86362001)(202311291699003)(38100700002)(6666004)(9686003)(6512007)(6506007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GvFslyIIrimu+4FBrYli5ZvUpIK14b/GwwnAMRTCXb7gxvInRUYlS558JOhe?=
 =?us-ascii?Q?q29vUa5iXOqYrVRURHxTTY1vyulbXc0wgbHP2o5vENnGuUD/V12AH4hlODwa?=
 =?us-ascii?Q?qKVvO1B827i/Xsxu1GsA538zKx36owcjNje21dNtrKlYi0PgI4hjr8J8ipW8?=
 =?us-ascii?Q?eVkKJQeXHFM30VhrgGcWpZldbI8xR65KjSUNzRW/JhdB6RkknudklR0hpJzb?=
 =?us-ascii?Q?C4bOmaUW6eGXEIws6QsA2KgkFre2Vqc9NOdDsrHRUhJeBf5MCtov8AvJqE2y?=
 =?us-ascii?Q?fuXEHlvqzv9MbfbvYGplB+LMm0dd+rksWRbid9LiL580ZAy3IyLo6EKMEQYu?=
 =?us-ascii?Q?MCJMx7qm08KMLKPvOHjoE7jU/5H4o67wnKEo574VsdvOhDp6m7jOq1dEiTTc?=
 =?us-ascii?Q?z104hBIppeh5F5DVPFrfvepOR2RdYTRTUn+8+OiAMysh+JCqKUN6MAlHjRG6?=
 =?us-ascii?Q?yt5n4MykJwP56HXGd5iKYDojQwNCrnf8eBzomt5M41HB6oVAipH3pMUERtA1?=
 =?us-ascii?Q?bcAFMgEu/Gm7pI81ti7gzSTMtp8lQRdapqRQu4dxjziUqbYWLPwsBRlB1Vht?=
 =?us-ascii?Q?qIhgSjD3GDQDKBIdn4F+YD3nJ7o8hVho5Z0FEmMxchXXxJTL8bTIQOtfXXqI?=
 =?us-ascii?Q?4+HpLQ5IGWJoD0sUmek3pil7ytjRvDA2Zk7hZo1db38ISN5f7KFcvgm46SHT?=
 =?us-ascii?Q?7n77NPKrVHgmPLeeSlSjH0q9E+LwbDcg4OjrCBNBnWkkT4yHTW4JjgNHkVBL?=
 =?us-ascii?Q?hCg5e9IIUaK6sLVzSpsX/HQpvGmV4DHnnvIJ+NkujPRXsD5xxZAriIID38pP?=
 =?us-ascii?Q?RYEj03RIm5CW2Y9p3klu4VJNEOVQWX1FnCGgA3yacpCoJTe3N/AqHDvMS873?=
 =?us-ascii?Q?1RB5xnt3tpejDrY3/jyH90a0grPoPEwXn8/fguj/04kbN2u3CpFq60D1yaiW?=
 =?us-ascii?Q?V0xNZNLZ2Jm8/ro2iNsu/iz5sZFR33NefDKy0p4ZkaikdSgUcZCPKp7jFjxD?=
 =?us-ascii?Q?JNgLgAKKjpQvQRUJuOHv2CaZXLWyruqVnaCSpuyoa/MzdzbXx0BKAWLzQeU/?=
 =?us-ascii?Q?AY/mCk5ATXGZ9u4li8k7tk7iIKj0uorJAvvH/nsZ69d5Qc+z+FQbBfgbd09R?=
 =?us-ascii?Q?TNfwlWzCXbcq4yiUMQL7O/Q0SaU1ES5ZtHzvKs/L/hBLObnkpa+FFV1Z5Jog?=
 =?us-ascii?Q?IkYHrlEzGoPaxC006kcs1/RzxvIzy/794nq758MVisRy1DPTw554T4m0ljCv?=
 =?us-ascii?Q?iSpsnPML1mlCx5q/8NOrk5OB2liKYA/DhgDpbkbF06Nf19VoyKPlKq+3M7Lq?=
 =?us-ascii?Q?ITcmQ/uqFJWGYQCKzMTj6tOW4irtRHW+jSw/Asc8uM1rSHzE97/vzMW1Cqpb?=
 =?us-ascii?Q?yk/iviI+wXclZunzZQt1dLscz+LDJR/BXnyKb6gMlEWYELk3Upkhm4pJcZWm?=
 =?us-ascii?Q?/m/zH70ZT+JTdwagOMPS933pgA+WFwcMQ9tbE/vPb+LXXQS1Q3Z1Gjd9ARIa?=
 =?us-ascii?Q?8Lk7CeXkhv+ztp5UNsXiGuJcka9LjKzMBpHbtjMkz8sjRF9ghFtC0r8LBz7c?=
 =?us-ascii?Q?wCDhrzglFEs0j6ro4fDWHAl61OiuABCgwCMZ3uffuRHfOHZUuS98PhzEO5f4?=
 =?us-ascii?Q?KqxJ+3sc4f9ZNDWZThtuihWgYuPVJ7k8s8IJtc+zMOpUMferG29hl7EyCCx+?=
 =?us-ascii?Q?D9jhEQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f2755d-23db-4ebf-7288-08dbf16e7231
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 06:34:46.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn4Z1wg7ptngcBw440C25i6sLuUJiaP7mHwXPk9xSHcOnTfpIpo9rukH4c5Qwoph1z4BangfkklfCiZ1mcjXYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414

On Wed, Nov 29, 2023 at 04:04:06PM -0800, Andrii Nakryiko wrote:
> Emit tnum representation as just a constant if all bits are known.
> Use decimal-vs-hex logic to determine exact format of emitted
> constant value, just like it's done for register range values.
> For that move tnum_strn() to kernel/bpf/log.c to reuse decimal-vs-hex
> determination logic and constants.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

This is much easier to read, thanks1

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

