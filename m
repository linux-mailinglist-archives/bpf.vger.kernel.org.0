Return-Path: <bpf+bounces-13130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E81C7D4FAC
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 14:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C382EB20F02
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634826E3D;
	Tue, 24 Oct 2023 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KM0vmO5g"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C6748C
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 12:22:19 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD02F9
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 05:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP72nHgUwkjeVDN9uhXSpKzQjXZnT4DrPmcZiTBkw3+kvMPNd2ZEHb0ATDONfCfDmNj0l4PTCcTISltcYzeVLgeDSDrRm7m8s/5GofKyDtOg59obTZ8dTHC53pc38mEQm2AN7QLlfhPwsOroego5lnk4vnlBCxj7i+bPgu0gatsPWVuFEPCBtA6IqDVrDzqolZvHFdxVEdzvTdIc8zn8BGffPhsA765Ui9julHEmYssleSeVJwncYjm9PQvLnHqwHgDgl+O7acx/7J/tcAJu83x60fLM/aArsO2lu1bqs9e9pXpzdSm5GCD0oW3xrB9vAhMUoYEFrMRfSZVnzaCdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNSFySb6CheYGk8wZnvEEn8ZEndNnBAX4jvx7kbmgxY=;
 b=KT0oiwPFp7lV1t/iiXAhej1pXz8q6T7fBNCRyqpLJAlh8ToXgTtB64srCpoFZ/QOFzzul7usKSCUNieVgqLJZcdyDMuPI9HKRpkeQjGLatacpQ09HJv7MEXRoVNSswcm8xIHxZn4KiPdh9ogJrjhMfmCWqn4B8S+MGCoaRIpLxP331nn2nchEDfP3P20BEPNSlvc1QC7e60bchIQ92Imuy/fnvcxI/aqPF8e85s4Nil3HvSOQcUQ3+aUQrAIzL2r85VvCzoGlYcaBb1EQFaYO6p3OiwdIOpRmEDrp64NYtq322wJYMtilC5IJLi4TFJCw6ZO/773M+QvHgX9JvNnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNSFySb6CheYGk8wZnvEEn8ZEndNnBAX4jvx7kbmgxY=;
 b=KM0vmO5gre5pF4oT/700qCNIv1BbaUj1YHiEL3xbiyJfKvyqII/lT4mdLVW2SwJk9UxYbDh6qNoIKrRg7Zzz2n4dilJlW4boxpxZYOpiPXKyZ2V9lk0DTTDdHMSrH1ZodZy8QwntjWOBRPNMnDMRucS/Qf9q48uEfAuhazlrnbEvRAiQmZxBTgsMSwE/nbgmr6pRJVYELUdIhZP7LOTjL/tNhQeCuo2q/MsQbAPPgN44uH6lsOZjqvWNRNAF91dTs+zwZ/T7tC+3S8hfBgHz7x0tOVUCwC6rE91pbEceIVsaG9h7Qp18sVvxZcxEtNxulxtdd/8HcoF05ZnvkaETUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DBBPR04MB7516.eurprd04.prod.outlook.com (2603:10a6:10:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 12:22:15 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 12:22:15 +0000
Date: Tue, 24 Oct 2023 20:22:10 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: enhance subregister bounds
 deduction logic
Message-ID: <ZTe28jP0qFNtf89A@u94a>
References: <20231022205743.72352-1-andrii@kernel.org>
 <20231022205743.72352-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231022205743.72352-4-andrii@kernel.org>
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DBBPR04MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6f0198-a8c4-4c8e-fd23-08dbd48bdbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mer9XEC7h4J842tyIunkGrPuxQ44h43o0/64hYq/ESo51oMVzkjJHFp47mEt0fkG+KSADLHaqUymij5uBerwmfQxB0nxqjWVBIshAapRyJLSs2yTW9tM0uYzpE83RL6KBvlfcdmp1hMoGvZfdotvdkVmVRGN98vCSCyLK3QJFt18ruTJIfZTEQh0IpDxHNKejy2J4Av+rfZJ44wGWJ7pky11Sf+VMG42nv+F5yD4Nb/WkTZerjgTvNtixWtDueapedgFkpcMj7tAREcY0c3P5g32zfAnUbwpQgLFpY9pzdQ9qt9OHM7ocAxNBmVXe1PaId4v2GHZWdHuIIAU37ykGRXDhdSSgrcdGYRzB39JHIhLwKe3n715jI+Wext5YN+TJZbEw5aAGSHwx0i25tcU8mPhI3ERoCxmyfPYCzGrL3jpOimmHsnYaCIOUITynHsh4Xlt5Owz1/eQ+K9TLM6qpMKPjYt3M2d9fcpRVctonOtEDNU/HmqVIkpV+rn2Mdi2eEliCtN9YhUDmVfqJzdEjEihE5o8o/0KbshX1/DzkXJbGry+MsZKS6Rfwc/tWkzU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(33716001)(38100700002)(2906002)(41300700001)(4744005)(86362001)(5660300002)(8936002)(4326008)(8676002)(478600001)(316002)(6506007)(6916009)(66476007)(66556008)(66946007)(6666004)(6486002)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWdNWjdKVWV2UGY3S3NWblVvWjNOZW9OUjJxcUlNY1hRNDZtb09ZemYxdjJa?=
 =?utf-8?B?eGVvWVFRVVp0Q3owb3o0UkN0L2JyVFdtL2JzMHJIbmFBWWxmeUtUN1R4U25C?=
 =?utf-8?B?UVF6Yk81L1ZvOTZJYTFqeWVRbE84WTh0WDVRWEZ3MldDNnQ2WFRzNjRKdENn?=
 =?utf-8?B?Q2QyK0NVQ05hS3NCanVHZ3c0SmRTZWx6M1VUYkFZNXZIWGVaaHdJcXNjVU5t?=
 =?utf-8?B?dDR5TytIRXF0Wm1Ramk5ZzUvV0pIemtvYlZBZWo4QkVFcEUvMWJ2aFBmL0oy?=
 =?utf-8?B?T2JpeXhtTzBLMGc4WVlzdklzRUpHMk5ydy9rODNxVklHeTlxemd3bmFxeU1x?=
 =?utf-8?B?ay9uek1jNnUwOHZnUmYyakFXdVdyd1JmbERiWjY3MjgwVU5wbTNyc2xvYWF0?=
 =?utf-8?B?c3ZUbDhxUjk3eHpkTmhLYkJ1ZUhSSi9vOW9PQUNIekR5eDZRMFYvR3h3cE5P?=
 =?utf-8?B?YytaRXNNblUrem0vQ1E3b1prNnBjYlU0WXFyVnR5aDlKbzlHVEdLTlNZYnN5?=
 =?utf-8?B?eEgwbHRjQTJvNDJodFo0eGFIVlVUNzhzRXdvaGRuZUE0MU4vVFBlYVRxakFk?=
 =?utf-8?B?ZTEwSHFlNk04bk54N1h4U085aTh1OGJNK3FnRU11RTYzbFh5WkJYKzZzaTN5?=
 =?utf-8?B?Z1YwWlF5TklVUXh3am5Ucjl5b0pGMndMSC9nOFZRV1NSSkYvdXk0Q0s0NUQy?=
 =?utf-8?B?aFowVnBZNnJRUDlpSVpWZnMxUkpobDJkM09TR3FiU3NTWUVVVW5zL0k1UmJU?=
 =?utf-8?B?akRpRXVRRDdWVzhubUMxc1pucUp5RmtXQWVZUXFXZXVCek0yVThKQ3RaMUpZ?=
 =?utf-8?B?aU1LekNGa1RZaUZxYXUzZDFzK0ltQXgvaC9oSzRxM3RvTkJ5dFFyeXVOTFdL?=
 =?utf-8?B?MSt0ZWFCbDMyZE55ZVJmcEs4c29Yd3dYRTNzQXNnd1Btd2JIeGJDditWMVcw?=
 =?utf-8?B?emlwQ1Joa2dCV0dDYkZ0WHlvMTVGVHh4dmwxMm03MkZWUHdXa2VhamFUdjJZ?=
 =?utf-8?B?Q2Z1MDgvdXUzb2FzOFVtb244MnFaUW10ZW1zeHNGMnBNVW56N1prMFArcjJZ?=
 =?utf-8?B?MXhYQ3BpT0xQY1hUdEVnWWtoM3Y5MWxRTFpJSFRoYmVBKzA3a3NvTnlxVnlF?=
 =?utf-8?B?cW02T3M0KzhLb1JYeXZtWWpncmpJVVM4RE9vNmhFalZsY29mYVdVa0E2Zlgw?=
 =?utf-8?B?RjBVamdYM0VuVCtGQVRORVlMem1hbWcrLytjRTFRYndpQUZHNytvelVLSTNK?=
 =?utf-8?B?V21uUThpK1QxZGNjWFlIZTNjd1dyc3hIeWI0dWRKQ0I4Y2VXZVZQczQ4cCtF?=
 =?utf-8?B?NnB1c2F4VzJtakpreUlvS2FqbDJ6cU43NlFzTWR4Y3RtcDEycHYxSy8zMUNP?=
 =?utf-8?B?SUk5emxxd3JtSXIwOVpJQ0xON3NuTWQzaXBKMTlzRURRUUZvTlJEdHBDR2NQ?=
 =?utf-8?B?WDFQQkNWY2tLSUlJMFRFQlNycXFrQitUMEo3cU5WdzJsRm1ia3k4WlJVSEpn?=
 =?utf-8?B?Y3BzKzdjZlRsdE5kMXpYNmJnRFZ5ZnNNUk9qRm5hUzd4c2p2YkVPRlB0OWhv?=
 =?utf-8?B?OUVJQStKei82WnFnd05jZEtkNHg2bzBCb1I2VUxNRmNzOGROaVlSOGl5QnUx?=
 =?utf-8?B?Q29sMURHTHZrSWF5ZEVLTEQ0dkp5RWhNcHRhVEs3TVoyaHA3Tmp0TzZRVGlI?=
 =?utf-8?B?WmRHVEhBeXdSSTZwUlhxTkJtSjZ1NTF3aW9HbTl6ZUdPTmpvTTR5eExPdjBQ?=
 =?utf-8?B?bXlOY1BrNk52VlltSHdTTUFzZkc3c25LOVRHbHdjSGo4eUg2UTJ1dC9sT040?=
 =?utf-8?B?L3NaWk14T3psb0FZdElVTTJuS1FTNEdaalA3Rk1qVEdCUWJoZ0FRYWpWQUV5?=
 =?utf-8?B?VllBbHUwa0hyaWgvekc0TkJNMEtGb0lxbnpWc1NXZXR2bEo3bUFZVG8zM3Q1?=
 =?utf-8?B?dWh1Z1pGQ2FqQVRWNEZrUUE4N1RhdjVEN3VkWGg4UHQ0L2ZaYmF3SlJxSDdT?=
 =?utf-8?B?b1diK2RXUWJ1Rk9CWXEvQUVUYmhjVTh4cUFQSUJxSm5hYWhuNWU4NG83cWxQ?=
 =?utf-8?B?RHJReWlrUTJYMXdhd1pSeHZyODcrd1VQSEdyYnV6Qk9VRHJJalRFZ04wWVRm?=
 =?utf-8?Q?SiAwEsy5kG99mOA1vN6W5y3lR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6f0198-a8c4-4c8e-fd23-08dbd48bdbd1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:22:15.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGld9Jca+21zDLKjQahjsZFDoXJ+1rLTfNSHM+/kegczSvI7aoMN7AfthKiEt2NXUeCBI9/HUw56K42bZSiQjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7516

On Sun, Oct 22, 2023 at 01:57:39PM -0700, Andrii Nakryiko wrote:
> Add handling of a bunch of possible cases which allows deducing extra
> information about subregister bounds, both u32 and s32, from full register
> u64/s64 bounds.
> 
> Also add smin32/smax32 bounds derivation from corresponding umin32/umax32
> bounds, similar to what we did with smin/smax from umin/umax derivation in
> previous patch.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Forgot to add

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

And that the acked-by for this and previous patches applies to future
version of the patchset as well.

Q: I going through the patches rather slowly, one by one, and sending
acked-by as I go, is that considered too verbose? Is it be better to spend
the time to go through the entire patchset first and just send an acked-by
to the cover letter?

