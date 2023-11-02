Return-Path: <bpf+bounces-13960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEA77DF631
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A5F281BFA
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E9A1C29F;
	Thu,  2 Nov 2023 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="m6t5KnBU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562741C297
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 15:20:25 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4810CE
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 08:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRni/NTSCM1qYe/XF0VY3KYtpAQxnHa/MW+toA1CCDAmBDTEzRKjF5qc9+ALHbdmuoXye0pUPzMtyfog0hjO2BCv4fFsmULHudd7orq1IYnfE2mT5kwZodZzO5+5iCWL6DFARcuWR5whKUWPd6V7XEXm7SCEDiJSL8Nk7+jNK2Rqs+MFLx/cxB+MWGPLCK81RKvCq98pdwjUc7Cdk8QNJL1cFp8D4dZHJUjLHg3fumlI2mwT5qbJytiCHuXotVn9gZlxtiCg7BbVLwzwliyR9r25PflVgzAW2OcYQmiYk+mw3ZC8EkR07QiDA/CqVTV+laFJLW4sLSnOARmZIxz5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvzhdNaA3FoErJ/TzcXFCRsKgQSgQfeHzce/hdZ0wgU=;
 b=hiSHEZhSjjC4c3jNGwqbLJ4Vb69D+RoWHAN+ohVl3i9Bv+BLEdSijo3RFqYdEKFBBy4B65ffSJjKC9H5EaSFyAuDpzM5dXoYwFXlD8C0MQj7+DSkawvOG92OfKYAm44jyRJyHJqBLJVJIFLXwiH7OZN8+ZZZLHlAf29GY1VG+Dxpp064/W4T1rEeyM9STkdWrZrAspqgqCg3c2Q1rXlyCB5CjkcaJlz0qPlQJD9lQPEIhkv1utClcZf3GCwfG8mK2dDoJCjg3qcvQGG+CGuqd1zQESj12TgnnsC1dLkn5G1LMC+1gT3xQouG+ehgOA5LGNsojQKET4pUavVLutfE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvzhdNaA3FoErJ/TzcXFCRsKgQSgQfeHzce/hdZ0wgU=;
 b=m6t5KnBUPvp8Mde79lEFCVxNnQMR2AK1sWYbd7tG0DCLshjXSVmAyrA9PcYe9qlOKPlT6+s+mr/EYJanSbfUbNSU1rqrobki0xw7TTlqpaHdgx7tIG9heq5rZj0ay++Whh0bserBnXgW0Z0O5XvDRBHQbFnicfXdH8HAAzAVZ2UsvTA0BSaSC3sUlQCkOAUV07gcIaI4r1nIdqCaYOnLfMY9Jq8I+mbjVU+kNUqWxXrrK+N8NzLMNneOqNS9uxoJKz15UF736Og+BplCdnI6zLJiGFDhz0pV6IzLCoy8LrVdsYxXxViqdeUpmAcCF3fYtD0ZZ1SZaZ2tustF/l37BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB8280.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Thu, 2 Nov
 2023 15:19:53 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:19:53 +0000
Date: Thu, 2 Nov 2023 23:19:44 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v6 bpf-next 12/17] bpf: generalize is_branch_taken() to
 work with two registers
Message-ID: <ZUO-EB3MgBvrVkbq@u94a>
References: <20231102033759.2541186-1-andrii@kernel.org>
 <20231102033759.2541186-13-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102033759.2541186-13-andrii@kernel.org>
X-ClientProxiedBy: TYAPR01CA0205.jpnprd01.prod.outlook.com
 (2603:1096:404:29::25) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1457b324-f345-4c2a-4403-08dbdbb729f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5tSZTh3E2a0KawCwqfy7AoNtkGHHY+oDI1aVBMttxCd6bALtw99WYwsaGCRNE0wj10i5fULhlHFcvwVWjAJWypYWJqXiqpP3SbiSxaKmHLaZ3LaXlnWlNc7qt700bjceoapn5uN7/DzCtcaIEz84ElwFQ5Sx4wxe2FkFyjCycjig9ei7x/JrgNeJR6lTGReOO6Yo84tZKWIUgU3qV/UPNuBlVGWQ4hmlckuCpadvQ8vSrWUqTSsrmc2h9+FWFpaCVZVhKRq/7qzCKPf0w80xnWBO5892T//x8OSA6xpYBCdSTbm6Y3riK7fgWf5dfC+nIMMHe2Bet2fKs9CiVG/hJx/q0n7Rp0xulqKNFym88dqdi5EszUHul7uBn4TmF/sjAKRLiUM5UcUzxpRfO4MFSsiI+WiqO6rzrrVLNS5en79/RqtkoHVmTUwQLRRRkIfE52q5wurZ205NrokfDRSOkK/+sIGvKFA34IQIDboEp/wC/HdNa8mPDK0OEfwDXXhXvHEOw30GeQSaEcPXvq0RhFvPTMHjZgpH+ssFl4LkIkr3Mg3VHYsXwnLooYefXhim
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(38100700002)(5660300002)(86362001)(6486002)(4326008)(8936002)(8676002)(41300700001)(4744005)(2906002)(6506007)(9686003)(6666004)(6512007)(66946007)(66476007)(316002)(6916009)(66556008)(478600001)(26005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEx0WFJSbGJaMG5wcGJuTEZvQnlhSU45K3BNVmVsRzliY0NRSlRKeXNCT1RH?=
 =?utf-8?B?RVZXTUhvZTErSUNIUDFsWi9IWVFhWEVoZjAzcDYxcjhOU0V1cDlyZGc4ZlZM?=
 =?utf-8?B?TlVhM1NjUjFqV2MwT3l4N0FBUUJ6UG5PeFQ5SEFtRWx6ZjJhNkFJb2FiTnhN?=
 =?utf-8?B?bjlLVE9Pa3gvandiY3RmOHlZTFNKSlhQNDd0YlJJT1c4Z2xlZXM4RTh3aU9o?=
 =?utf-8?B?UHFkbXBKai9WQ0U4NG41SVZLOG80MEQrcFQ0dG81WGxQQURUSjl4dEpEVU9j?=
 =?utf-8?B?U1NMTlVkYlpLMGhBS2NNWkVFVk10N0VTbVorbERZVWRhYUtvelRVNTNjVDZI?=
 =?utf-8?B?QTFoSWJkODhpN0ROODBkbFRNbzljUkxBbkVSZFNMOW5OWnJ6dlc1a2twcDJk?=
 =?utf-8?B?YmVxSVViUmk1dUh2M0dPWFg5d1l2ZlRZQ1JnNVJ5T3BXMWxJRzU1MkVUbGIy?=
 =?utf-8?B?cDdPbHZRUEhQM3FXNG1JWDlMcUJsdUFWblM1SkJOVTN3aG9taVRvZXdtdGhk?=
 =?utf-8?B?NVB4K0JleGNtSElFcktWNDlJczhmWkRPRjhpNEVlVk1MYS8rQ2ZXNVVYQWFF?=
 =?utf-8?B?SFZqcU41LzlSaGJBdzg5NTBES2VVeFhQcXVXS1RTdkRVNldHYUxEOHkrUVl5?=
 =?utf-8?B?TTJYV1FQTEVvL2QxT3NtMmk4SHZCZDdMZmpWZGQzOThrTGZKSFJseHZtSkd0?=
 =?utf-8?B?d05BRXN3MlpJTEMvMHd5Y1NuYnlOU084QnVuUWN4emRHSVV2K1VTeDhtV01i?=
 =?utf-8?B?bmdON1lZaVBoZ2VDQkxraWcwRlQ5Zys4eTZjc0tPV0RoZklvc241emJ2M2t6?=
 =?utf-8?B?bjFndThnVGlONXdhZXo4eFdHN3gwQm04cWk1YkRNeVVPYkJwdzF2RTB6aVVZ?=
 =?utf-8?B?bGkxdzdtM2FPRWFYekwwa0oyZERVcEVWdTBBdVp1N29CYTg1STg0V3ZGVUdU?=
 =?utf-8?B?NjluZVZuK0Y2YzQ3cjVraWdvWE9tc2xmNzZnbEllOUx0OG8wbDlwL2w2QnRh?=
 =?utf-8?B?Zmw3UUZjeU5FTnIwNFp3cG1FRDBINW1QVkg4VHJmY1J6UkovMHl6Vi9hRFhB?=
 =?utf-8?B?MkxKUVJsMnVuNlBLVzJVbXlRZUFja1Arc1YvTE5jS1lreEZwLzMvYitubE9m?=
 =?utf-8?B?V3drTDRKblJRVFpjSFp2WEpsb0FTNFF5Ri85KzdmMERVZ21MWDVGeE9xTTY2?=
 =?utf-8?B?V1NOMjZPZDhYd2VodVFiZUpjcnFnLzI1cmd2a2tVTHJ2M3p2YVpubzRCaUVQ?=
 =?utf-8?B?RTFPanVrcEptb0I3b3YveEJPMU1xYVdkZ0wvWkI4aUpUOVlyWERFL29nM3pu?=
 =?utf-8?B?c05KYWZBQkxpVXpvbGQxWHhPOFJQWnVSSngwNGxXRFJ2NStLUHd3QWREQWNQ?=
 =?utf-8?B?WGE4MWVmdXFGVSt5R3lSc1JSR2cxclVkWEY4ZkozL1Jmb1psdFNNSmxiZ2xp?=
 =?utf-8?B?bmZCVEJjZU9uL2VNSXhGRG56MWU5UVIrdGdsT09UYVhJY3Bvb1EyVmpxSCt1?=
 =?utf-8?B?ZnJubjNFL1VkM3oyNGc0bGl0dTgvTlhtaElLazVPVmszWU44RXBYYkZDZ1Ny?=
 =?utf-8?B?aSt4dlRxV1ozSEtiQkxsOFQ0WDdDV3dBVUhGblAwVHNGWUVXNkRNZTdDV3dL?=
 =?utf-8?B?VjA1QXRvbEJCZDZiRjNhYzhXYy9TNUVpQ3d1ejJvZURPY2lFU1hwOG15MjVU?=
 =?utf-8?B?V0pKRjhKcVNnVFhrTjJtTXQzQzR6NTVGRjl0UDlhWVRCNzJlQmg1U2swYW93?=
 =?utf-8?B?S2hXa3p4RkIvZHYxQ1NlVFBFY0ltQnZ0TGhzWnNkbHhOR1ZsTm00d25TNjNa?=
 =?utf-8?B?ek9jc1ZuYlZYTUpybncrRStQN2wyYlpnNFh4L1VlVkozdGFwZFZYZDdQWStZ?=
 =?utf-8?B?blE1REMzTkJoZlRreE9wMjdEWDFseGhEbHFEMUo5c1hzNnBITVhoSHBIS1Uv?=
 =?utf-8?B?c1hXNlpPYktSamt6YXduRTI0SjVzeXJwNEVkNHluUDc0SEQ4czZxQkl6VUJY?=
 =?utf-8?B?TXdUazJyT0tRNzNtb1Q0MkdCWnU3TUhHeExzQThtNDBScExWVzAvcXNsaS9L?=
 =?utf-8?B?RHVyc1c3OXQ4VjN6Tlc0RnVtVGRqZE5vRUxJc2k5NUFzUTVuaHVGMi9abWw4?=
 =?utf-8?Q?vrIYYIQCDX1Qh3Fx2M3FEWOLB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1457b324-f345-4c2a-4403-08dbdbb729f0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:19:53.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgslCra+ZHai2QSgRjqswhgYzlsjecMzTrmGQ4/FR3Ax23zDgO3S0xHUUDeP5JvZ6U1z/rrLYiPncBFcdXjhbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8280

On Wed, Nov 01, 2023 at 08:37:54PM -0700, Andrii Nakryiko wrote:
> While still assuming that second register is a constant, generalize
> is_branch_taken-related code to accept two registers instead of register
> plus explicit constant value. This also, as a side effect, allows to
> simplify check_cond_jmp_op() by unifying BPF_K case with BPF_X case, for
> which we use a fake register to represent BPF_K's imm constant as
> a register.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

