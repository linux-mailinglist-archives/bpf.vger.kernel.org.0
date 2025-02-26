Return-Path: <bpf+bounces-52694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88972A46B40
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 20:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631B216C720
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792124BBF6;
	Wed, 26 Feb 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="okKvdFlu"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012038.outbound.protection.outlook.com [52.103.32.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE0245006;
	Wed, 26 Feb 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598802; cv=fail; b=dqUwlVzStr0+gM/ShteOyPIsD3qObgZvqhgcvidOfA6UOl+rGWozbSyUZf1ZPdeFF8syovDndlrIN/gR8AQqy2zYy6+/2DPOcuNkfcoHxQ87VO40t/eom/VPR7vQJDj/TGO5Ein3GuXz5YEeaYIekkrb0FeXpR8bsabnnDiP3hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598802; c=relaxed/simple;
	bh=0ARYSOTJ0sGEfviJ3xWdJ5id1lZtxeVhHHXGOGfEznU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tM7ExIMY5cHsf7NGnnaeEJefwuCU+eZPIyFhFJMmzT3j9fA7dTeat7ztwTbK8Hes6JrBFYAEwyMmEj2Hny1x0W6jU55biF5CZWeytZiIAyyQNxIqTb8LWyzYbmIW/B/uZ3xTFfL/Acsfh1oKhXPVNHNC12BS/YRAKCJjk4m3TZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=okKvdFlu; arc=fail smtp.client-ip=52.103.32.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpYp4tJukIZSQVx7KDW90oWU/0br68x3o4PM7ojG4jSlW9/CEEDWZbgrxUEFXVO22LSJ/cBMyjibuEfERulb+ooghrVkEtil6cnYQcFUkrSYe8LZNmfKLJH5Gh8kYWAHl1aCd2D8Cr0oM0OZ8UT+hO/dpDS2iehIkRIqwDMFx3zLmpTV5kPMeJJe+yROJ7Wd9mYgB23WkaA0f6SxDpCa419IRuZ6G2u8trSRkzgxgq5pPu30BvfXCGnQjIrK46s+GMMdMCfuU0zQBCoNqB+h9/Ju/OR+wvZh+WcIPcY3QsXofDRYlaegy4hp8vu7vc5c6K4alWcXqXuIithniOq/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wQ8eB2EuON/ee+IiFWWfih+jkeEAp4QhmfxOg60TFQ=;
 b=VbMoUOb33KCH3FeNA8Ax+JlO6Aoiks87IUIZoN21tPa5IZXmW7CdDBGPxiag+MLk7RWkhu9NG95HpDuGEF+F0ErE8tKF3RZEsBAwbCggGT0vGpyjNttpJmnT73Lm/FxP+ppumQkxoSB1WsucysFU/Ox2T+b7B2jPj8vHkJEwh4/gZt7hkUgrzzW91NX8Oy3kcBmzTimc3zhVJHinde0uLZa7mPS4dEua6SRdRFeCAp5PVT1NHTbb7G++kbqv+OL3cLrcXNCzBuDIHSsW8Mtf/6sX9hI0gjvHd36unV8VicpiebmOfLmLMN7VHE88otFL31dUc6T1seNmkvELT9qp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wQ8eB2EuON/ee+IiFWWfih+jkeEAp4QhmfxOg60TFQ=;
 b=okKvdFluMs7/R8Lj+Hf9WyfnhjOZ5JAoOhF6Pm/aHq9luRvZFG1bUe8k8FsjV4RhRqqwI66Agp3WGzqrgvxFFESMCOA6FdG5xpoc5MlQuOgT9/IFAAKsGk8LNFozn0oR1D2thvG9LKZtjUQ7RJcUTXu7Xng9Y6AeghCMbLMNxwhZA8W4yKyWhMdGJpc5UYNejKCPQxEwlZJ5rFPID4QEXZf/yFEQIwyzpN3ophArI418XMqgmGcFf4/JO9QEH8xZ71o8qCN+ANIWgVPwtyZZKENVcNSb+dkhoBco6zGXn05dZU8QjHlg1YIk00KN26Lildyso1Fqz+NnVO/jtuklTw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB8188.eurprd03.prod.outlook.com (2603:10a6:10:303::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 19:39:57 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:39:57 +0000
Message-ID:
 <AM6PR03MB508061A662E059CE3F76010399C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Wed, 26 Feb 2025 19:39:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v2 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context for unified filtering of context-sensitive SCX
 kfuncs
To: Andrea Righi <arighi@nvidia.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080D59AD7DD5B59E1FB14E599FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQKnJCdW5OCs338W4ts_mn6JVw7fD5U6w5o6dtc4DSJQrA@mail.gmail.com>
 <Z78pVPKTEIh-utFE@gpd3>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <Z78pVPKTEIh-utFE@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <b0a6bc4a-e502-4331-9b15-4c701da3d712@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ef51dc-7676-4ab1-97e1-08dd569d59b2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|5072599009|8060799006|6090799003|19110799003|41001999003|1602099012|10035399004|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0crb1FKRWU0MGJtaUZScWhKYUEvOHRXMTlSL3dmKzl0RGh1RW9kQmYrUE1x?=
 =?utf-8?B?ZmFsNzRUWm1Xb1d5RXNOU3M3T0tOMGFFNWtPRGRhMUNuZnJvb1Y0YmNQTXFN?=
 =?utf-8?B?MVBQdm9GM1dKckFtTnFZUzJHOXdxaEpNMDdTaEJUTDVJcEc0cjdUN2ZRdVdu?=
 =?utf-8?B?clBQMUVkWU42YWdZTW9BeTN2M1lQdFlVUXRjRGVrR3NTTGpWRWptaSs2SXgv?=
 =?utf-8?B?RlBtekhPeHlSYzRDZ2FCN0FjOU0vTlAzU09Ya2RETlNlWFFEQkhUNjZTQ0Iz?=
 =?utf-8?B?MXByT3FteFEwM1pXRzNzTVM3dWxjNWpqVDRkMU5YazNUWlNoaWUxeWJKaFNG?=
 =?utf-8?B?c2E2UjQvNTE1bWl3dXBNRTJObFNYNXlLZ1ZHY2ZPRFBJMmtBbXZHZlpuaFFw?=
 =?utf-8?B?VWxGSXppbS9sR3BzSDZqTHlmUjNSOHc0NFU1Q2FTcHYxcFk5Q0IraVE3bERS?=
 =?utf-8?B?NEU2VGdabFNBZC9ENkVyeUhBWE1LeTVxVXpOak8wektFVmRoY1N5VFVWbElx?=
 =?utf-8?B?MW1Cb2QzT0VSSmhsa09QWGkzdXZzMkVkc2xoZjlFZWlXVXpJbDM2L0ZESU9w?=
 =?utf-8?B?NElSUzJWeDFZbjhqQ2ZFN1NYN29TOVN1U0pLZ1VSZzJiNnJxYjRzRUJCWXdV?=
 =?utf-8?B?RzZMSW5hZTVleFdFbmZSbkdZeFlzcEpRS2pTZ3VlaTdwVnB0eUgxZHlkalpk?=
 =?utf-8?B?NU9id2xoMFIxd00xWlNWRWU3K3JacURwWUlnQmhFVUNJcnY0VGRpU3NweDJr?=
 =?utf-8?B?OUpMRDFrNTJSV29aLzdTL3hIRTR5MkR3ZzlSRjV3c1lWR1JZTDljaEVwZStO?=
 =?utf-8?B?WXhWS09QcGNxUEVScmdNZnlNWlhnMGNTQWRDQWk2SHdzSXhQT0dpZHpFOHNY?=
 =?utf-8?B?dnE0Y2syNXk1ZmxFZkxjcWxHbW4vWS9Hd2FyYUVOamJjU005ektPeXE4ZFJS?=
 =?utf-8?B?S1JmV2NHUUxGdGtpUkZTRjBPZzR2VjNZY2dqREZwbVN3QTlVUnB2M3VaK013?=
 =?utf-8?B?SHV5c295SU9DVHZkQ0pvLzdXSkJaL2ZzYlFZY2xsb3g3RXZyd0V5Y1dKMHlO?=
 =?utf-8?B?aERjY201UUcvRUJZQ0pSeU5mOXJoWFB1UjJWa1ZiTHZqVU94RSs5Tm0zaUpv?=
 =?utf-8?B?ZEZGM3NpQWZBRkVTeUx5dXphV3k5bWZRcXByRHJKYUllbHI1cDZJMU5acHpr?=
 =?utf-8?B?aXVDKzc1RFBwdnB0cmdGM3FhMUtQdGh6bm1aZ096QUV0bzBmbTFVdXA0ODdT?=
 =?utf-8?B?MmR4dTRXYU9xSlpJQWIzeU5HSEFjQ1Fuc0lCTEpYQXpmQUQxaTF5eDd1SnJN?=
 =?utf-8?B?OXd2K2JXZFFJNm9IdWNWbncxR000cllPUldXdUpzc0h1Nis5ZUpaK1RKSFNL?=
 =?utf-8?B?cEFYNnlUV0U0eW1WN1haSWtrS0U5ZUFUdFBzU3luVkMzaXJZaldVbVNydDVl?=
 =?utf-8?B?SC81clRoNGxRR2FWbmRhVm5IaEhMM1hWTTgrVVFER3lyNnJLalh1SmdwV0hF?=
 =?utf-8?B?dDF2SWR3eGJaYlZkQXFTcEkwWHpEbndQaEs3Z1ZJck1LTjE5ZUdVM1Rjd1ly?=
 =?utf-8?B?bEF5c0ViejM5YWlSNHNoNVhvZFJ0Y3NWWGpiZys3bW4yTjBzaTQwRWV5K2pC?=
 =?utf-8?Q?L6wiw+JCELHcxFGhjksGAAxOwQv6IS8dnHJxoonBi7nA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGh3QUJtNjJuWUdocU4vUjZLYnhaM25rdjYvb2JZVk9QV0lqSVVMV2RYTDl4?=
 =?utf-8?B?K1V1d2V4SkRzTEhNWFpnZ2FSK2lwQVFKR0VwL21FODFnUnhnMGErckRTb2hP?=
 =?utf-8?B?UEJ5ZlZPRHg5TDJZYkk1SkxEWmZZOTZJQ2Q4S3JmWkRwWi9tZlBPNWhsekI0?=
 =?utf-8?B?d0JTekxMcUI5Vk1GalNUL1V6NytaU2dmUVFuZi9FRGxIWGxJYVE3WTMyb01z?=
 =?utf-8?B?VCtRUmU0MThWak5nTHptVkVrYTRwdGFrYlBVc0MwUmY4enVOM1l0Nlk5VHRX?=
 =?utf-8?B?SzBGN21sZHNYYTVXeW82bEZ6ZXBIVFgvbjkwMGVSVjhvb3JKYjZOekQ0aHg4?=
 =?utf-8?B?NjdlZWplcnY0QlRwMmY4VGJXbG1ydElBb1dNaUIreEtUQkpsYlBHc0NWSU9k?=
 =?utf-8?B?UjhvVERVQmZ6SWxNNkJ1ZjZJWDVBaDFVWkNXVTRzdXkreUxDMkRyVUFHa1pK?=
 =?utf-8?B?aWN5UFJJaUordWJmb3ZyMCtKV3lRdzdmSUFCQmNJUmlPamhFUDZpN2piT1o2?=
 =?utf-8?B?cmYwZEpnMVpyaUJHTkl1MTI4VTN4ZTJwRzFiREpDLzF4NVNjSWd5NnVsaURq?=
 =?utf-8?B?RkVIT0l0dGxEbm93LzMwMU1hS3o5Z21GcUlId21PSTI0ZTU0VGUwbkJSaTVz?=
 =?utf-8?B?aUwwTkw4WVhlVVBYTGVXdlI4Wm5RZnlhc2NTdVVWMmcvMytHNXBFS0s1Vk1Z?=
 =?utf-8?B?azlCMmMrZDlBM0lXNHFNYnFHeXNuUkw4Y0IxdGtydjcrMGhUMUxOT0xpYUhr?=
 =?utf-8?B?NTA1SmFiSEM1aGZ5NkpQcGhDY2tZekM2cUYvZWNmOFFEcGUvdVJZY3Rzc1hS?=
 =?utf-8?B?eVBsSTZueUpvd2FGY1BRR1hTMW91bjg3dnJkT242ckJ3eWpLRmFCK1cxMFhi?=
 =?utf-8?B?SzNRQnZIU3MwV0lCcUlnMEE2dmFnT1UrbVc4VGlBL21QVXJNWFNlUFNWSUZp?=
 =?utf-8?B?Tzk4UHg2TG82UXMwckQwaEJNeFlpd0FONno5NUZKRm96MmtreUpoWlRTRDI2?=
 =?utf-8?B?NHVobWFoQ2d3M0tITWhVUjZ4eW5HbmhXYnB4U0NBNDYrK3N5THZsOGNmcFZH?=
 =?utf-8?B?U2RHUGhiS2M5ZkVjcTAzclNBNFVzZjl1NDExblJlYlNMcDU5bXVZZXlqaDd5?=
 =?utf-8?B?dzR5djRlNklzKzVqQy9zUWtoRjcyTXJTdHpzc0M4RlV0RnhPdllCVk1DeUY5?=
 =?utf-8?B?WWVFUC9TdjV6M0FkbHBySkF5d1NsQ3paeGFxeExtSmR0WUFMbnRDdU5udGYv?=
 =?utf-8?B?eUU5bFlKQW9TZEZVRVA3ZDd3Vm1CcFh6UDdiV2FUMk9ZMkFMZ2d5TUh6OThD?=
 =?utf-8?B?R0ZpMTEvNzI4SGQraWF0M0ZEaktMYVUwN1ZsbWRLSTI3QlZWY2NIMkNTdTAx?=
 =?utf-8?B?VC95WGJlNXpCb2svNk9SeFAwL0hESzJFMDhCVlhCenpRQ1hCYkp2MFZIK284?=
 =?utf-8?B?NGg2QnYrNGxsdS9xY3lSeWZORlVka25oR2FvM29mUEV2b1JweEp3S2NuOXVn?=
 =?utf-8?B?eWdhaVhJemVPKzh0NTNRTFpPL1QxTm5ydFFJQ00xcFVRZzd0dzFhT3oya0Vy?=
 =?utf-8?B?MGU1V0NNNEpXQUd1MWFqb0tEb2JMV0M5ekt0bmVNeTcvVFoxa0JPRDA3QUpu?=
 =?utf-8?B?Z2FTbnZmb1lVc2FKQk5QOXpFUXk3WFJWWkZBc3hrM1VxMnZDYXF2WkhLMkt3?=
 =?utf-8?Q?3/bVdOMZfJY0IsngcrkJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ef51dc-7676-4ab1-97e1-08dd569d59b2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:39:57.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8188

On 2025/2/26 14:46, Andrea Righi wrote:
> On Tue, Feb 25, 2025 at 09:24:27PM -0800, Alexei Starovoitov wrote:
>> On Fri, Feb 14, 2025 at 12:13 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>> +static int scx_kfunc_ids_ops_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
>>> +{
>>> +       u32 moff, flags;
>>> +
>>> +       if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context, kfunc_id))
>>> +               return 0;
>>> +
>>> +       if (prog->type == BPF_PROG_TYPE_SYSCALL &&
>>> +           btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
>>> +               return 0;
>>> +
>>> +       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
>>> +           prog->aux->st_ops != &bpf_sched_ext_ops)
>>> +               return 0;
>>> +
>>> +       /* prog->type == BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_ops == &bpf_sched_ext_ops*/
>>> +
>>> +       moff = prog->aux->attach_st_ops_member_off;
>>> +       flags = scx_ops_context_flags[SCX_MOFF_IDX(moff)];
>>> +
>>> +       if ((flags & SCX_OPS_KF_UNLOCKED) &&
>>> +           btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
>>> +               return 0;
>>> +
>>> +       if ((flags & SCX_OPS_KF_CPU_RELEASE) &&
>>> +           btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id))
>>> +               return 0;
>>> +
>>> +       if ((flags & SCX_OPS_KF_DISPATCH) &&
>>> +           btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id))
>>> +               return 0;
>>> +
>>> +       if ((flags & SCX_OPS_KF_ENQUEUE) &&
>>> +           btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id))
>>> +               return 0;
>>> +
>>> +       if ((flags & SCX_OPS_KF_SELECT_CPU) &&
>>> +           btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id))
>>> +               return 0;
>>> +
>>> +       return -EACCES;
>>> +}
>>
>> This looks great.
>> Very good cleanup and run-time speed up.
>> Please resend without RFC tag, so sched-ext folks can review.
>>
>>  From bpf pov, pls add my Ack to patch 1 when you respin.
>> The set can probably target sched-ext tree too.
> 
> Thanks for this work Juntong! I'll do a more detailed review later (with
> this one or the next patch set without the RFC).
> 
> Just a heads up, if you decide to target the sched-ext tree, you may want
> to consider sched_ext/for-6.15, since we moved some code around (no big
> changes, but some functions are now in ext_idle.c):
> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/log/?h=for-6.15
> 
> Thanks!
> -Andrea

Thanks for telling me this information.

I have sent the version 3 patch series [0], targeting
sched_ext/for-6.15.

[0]: 
https://lore.kernel.org/bpf/AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#u


