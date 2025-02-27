Return-Path: <bpf+bounces-52775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636C7A485DC
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C5117225C
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763DB1BCA05;
	Thu, 27 Feb 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c8TWLADf"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013070.outbound.protection.outlook.com [52.103.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F51B3943;
	Thu, 27 Feb 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674990; cv=fail; b=Md+WIMpd1rpQal1WE2HpG6niXyGKVnySCpQ1ndp0isWvN6BaN0gdTNShfruRoImb0mD6OQGDfqf8Y2rpQyaA/RAm34m/S7bQf5MEGNqlceOyuPopLL1XQ7ONLzsoXcmzNLRm2Knz+Dxipjfpb5EXuhW63IsB1JwWMsiYpCUa/nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674990; c=relaxed/simple;
	bh=rsKEvdbwQM8di2B6K4ujOyh5S0RzMAFwLMdXxdRbkTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FlvlBYC3I8es6nuXDSCMUngyGaXwLD0JgwHgV8t6jBkjYeCqnPuhFY7qMHRr9+EZAdp6/upqBSkxhGkjDAOjlz68oN24/kPwCk7D+BPZ5/lGV4nLJCIATE38blZPnQvjAUL9qQ7segYTsj6dexA8q9X7nueLJKS+JkNmhBL8dtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c8TWLADf; arc=fail smtp.client-ip=52.103.32.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qrnu18tNgXMr5wJDX4uCDVuyHD4vlmOW5jsoKVr+HhBSGtdrzqL1z7RWTPQqZaiCo5//pmZ3DkKoTSbDDH+mC6mPMi/03mWeM3cbLUoWSbRIlLfTG3qEXqQFCEqxv351+KFoW/fxqUaozYogPwTdCSvpiEGpIR6/5v/joB4z4Ds4RHunW/rz9RoKIXY1gczpPTgVzzVykY8NmHj3PCqq9nmvL22lyxklKraZ0SpOpf4FkB6P6LoLQDpetuk/yre/RjXpIokYcZZl5nQ6bemOBkusDUg3n1odLUNewjdOEAolNtUP5GxJ4xM4uMlt26+p3mSyXOih9ImPRbjfIL3zZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRC6iL4XeiWYd306dwIxAIgW+4x6hQxJRRhEkQpfQZE=;
 b=BTP2GKl4RxTTRHwiPDFaoO4LAnh6cFrrzH88ikIbdeuyU7XvW1v7TnOltuc9BSZIbTms4QOxzs+W9BkiroaoASp/jNFbXTwF+fdo1tY0/faPTc6+mdIjq5CtuagN71Qgq1U9j71uMKCuWFlZkrB8lAdIY4289xvcCGMtXIeswhwlBSMgu1inx0HIgbb1NuLhPBQ6D9dFOWLhUyvjPBBBPEJDUGHdtyhJcJ10r40yHx79qSLndAilH84zoBSlu+8tD1TXT5yW9bcXbt46Snb//z4Qliv8D7l1vd+4VAT+gYHoJ7iChrm5GigvZIbUyvLluWx665Gg2tCDkzPCG/aGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRC6iL4XeiWYd306dwIxAIgW+4x6hQxJRRhEkQpfQZE=;
 b=c8TWLADfYyY4a45g9cFoyNPEUBFaY4i6oYldWJglksAL4JKV/mcjfKcne7/Ltf8qA8qzj6xGjUMv5hnnpZWGQb/6InSWzbvT/gG9WMOBAn8EgzsTKK7B3coZFWjVuI4ffZXsIPQ1jZb0ZdbxsKaR8lfkZ/EjxYkbbXjlN8BBDwuwWJTYb+RIdZrWGA367LBeg5pKVqNmY/I3Dj4Spn/ys2oRGHhVSHtNBmmtZWrUH3FjKgvRXSN7CnoNx/wEwa97Z0Hut7WL54ite4jmIKiEjZ74i2BemLm2O64OkEaADo2odTG4LSIIn9Wr5+Ig/dupC2DSFGUv8BaJfl7f2M+2vg==
Received: from AM0PR03MB5076.eurprd03.prod.outlook.com (2603:10a6:208:101::17)
 by DU0PR03MB9029.eurprd03.prod.outlook.com (2603:10a6:10:47c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 16:49:45 +0000
Received: from AM0PR03MB5076.eurprd03.prod.outlook.com
 ([fe80::81c9:b053:75a2:2590]) by AM0PR03MB5076.eurprd03.prod.outlook.com
 ([fe80::81c9:b053:75a2:2590%7]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 16:49:45 +0000
Message-ID:
 <AM0PR03MB5076E7272ECC6208135874C299CD2@AM0PR03MB5076.eurprd03.prod.outlook.com>
Date: Thu, 27 Feb 2025 16:49:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.15 v3 4/5] sched_ext: Removed mask-based
 runtime restrictions on calling kfuncs in different contexts
To: Andrea Righi <arighi@nvidia.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, tj@kernel.org,
 void@manifault.com, changwoo@igalia.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080BDE038C8E8E89996F30E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8CRtWS117dVEnFa@gpd3>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <Z8CRtWS117dVEnFa@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::23) To AM0PR03MB5076.eurprd03.prod.outlook.com
 (2603:10a6:208:101::17)
X-Microsoft-Original-Message-ID:
 <ef3bb129-f914-4552-8a69-ff39f25cd1ce@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR03MB5076:EE_|DU0PR03MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: b2944753-1013-4ce2-445d-08dd574ebc77
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayFXX0mVJp9wZC4LLIW1QoQ+C8o90OWTFo2C7GHfx2vos57y8FIEzHXRb7rGsrkK4leKe7flnbYDaLtcPaPq/7JDZn5+UK4RT5zvFMkXcj5tWl5snKhhhKmeOnVHxhz8cIbTjIo0ru5NeuyYuXO86tVQpYYaeizKvbD3eVomYXhIVPQcO1uKZXtrpgh1FEFR1gHhsGpo9W9mGqmtgDqHAUgZSzluskHm9hBfyFD4Ed00Uz/2f555sxvGTQ4HlPmADREuxlsp+cfL5eAk+yM6zBdPw52mJ4NrN4ysYhYVitjYezQzKKmP+QFZoB2YdO5KU0pAn6rN2P/7LpalUl8pSwMDLwv0PH1oWKfj5aVDnoQEqna9OawmsvEsT/7F6kjXC7IXG36OQZKaksMPiS8ZZjhwwyMprWi/kv9xvzapkAbKp63ZHXv1rg7QNqgAhKdqpRPXSWCEGkG5KubD0Llzo964l6+J8r24kyzUWEgu8xFwi4yH8M+8q1J6dJeHk5ZIzfynZe0l5YPy1EcC8Xt6ZJ7yDJ5j4skNlRkR4IJwFOC/WAZmXXGueLzEBT/MdYVlxNpuNEBsy0S27bUhFPBKFchLScLBwbm2/ErDu+9cs+DhOUew1QTtaRxtndH8PPef3fKIfCBnhyoCZvvjSOzK39d6oKn4H//CFJ4xgTXSk2bTNaIgSXkYObGl1SZjDovQ3kWTIIwpw8TCqOH3VUIfdLciX4ii0snGg5Q=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|12121999004|5072599009|8060799006|19110799003|15080799006|461199028|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3pKOTVGamxZZmZ0ZWUwOEliWDJobktNU3ZwbC84TDhGdkRmOWRtMkwzSHNh?=
 =?utf-8?B?dU9GL1R4TEZkT081aFFJcUtmU28xYm5vbENIOTdOaHN3c1FCRzBIRENzS0NC?=
 =?utf-8?B?RjN5MThaZjB0UTQ1UEJlcTF2YTJvRTk3TVE5amg1OGVSLy81OFZxMFA5M1NX?=
 =?utf-8?B?OHViUDJnaUxZODB2ZWpjRUJGcHI4YWN0QTJNaEpwYjN3UnpiMk5QQmo5OHRr?=
 =?utf-8?B?ZkZTRjl6L2JCemk0OEtWcXRQSmNIdFNtUTN0WHlLKzlaQ2w0b2tYTFRnMFk3?=
 =?utf-8?B?cG9VbmdFRGNYdEZxY1BOK0FFWnUwaUNNTEdVYXVmOWF0RWNieUswRnQrT3E1?=
 =?utf-8?B?d2tBMWpKYkR0Mjh2UVJBckM0V3dTd3pJV2tXaFZtL2lkbHphcHBhazIvUjZR?=
 =?utf-8?B?K29KMHlwS01yenRhcS9TMVNEVVk5aHdEZW1IOVRNQzI5YXN4b0xYckp6TmRM?=
 =?utf-8?B?eGs4VjdGZ0RSd2doalZRdDdMZEVEMGJhSVFRbDF1M3ZjQXhieDN1Q1hLZ0VH?=
 =?utf-8?B?c1Z0RDlvSGlOQTZ0dENUOVRBb3BRVnAwVjVrdHJveGEwR0dzcnlkNllQV1NP?=
 =?utf-8?B?aXUxMnJ2UXNvVzB6cWJFNkltZFE3ZFRtYXdhYW8rMXJRbTNVT2pzY2d0L21K?=
 =?utf-8?B?TGpCNm9nSFVlWlgzV0YzQUd1ZG44WkpqSEhwNzBSY1ZIQmhSemFFVHUyN1lR?=
 =?utf-8?B?ejIrdHh3ZHhieE1JOHgwdzdtWCtXUXd3M0VvM1RKbGpyeTkrV29neDYwMGhm?=
 =?utf-8?B?c2FtemRZWDRhd3NtTW9LdU5JSzkrUmFUVkNNS08rOEQ5TDdLQlFrVEorclAv?=
 =?utf-8?B?TzZmS1ptT2V1MlBmbHlNQ0pTNE5EUXVuM1RBd3B6MURYdWxoMkx2bmFMQzBi?=
 =?utf-8?B?Y1FqK3lERmgvM0wxUTRQdnFJZE9YbUlKYVhIUDBZelByUGxEcDRReW9CTCs0?=
 =?utf-8?B?WlkwRGRxV2JjY2lySmF0R0RjeUYxTitnUW5uS0FXVCtiV1lqZHd5UGVzVlVP?=
 =?utf-8?B?SWJXWTRSR1RJNGtoTlJkYmUxeTNSMWhabjVOUnRnZmp1YlVRRjBKYm1GZzh4?=
 =?utf-8?B?MHRhd2hzT0x4N0RnUnhwamJ3Vm9MencxWHplUTVXMnhpVWRxNWhWaHVmU1Bq?=
 =?utf-8?B?SUMwQ09RRTErUUhqWmRkZ1hOSmpLbkRMOGJtOFVZTnhNSC9VcVpVajZRejFk?=
 =?utf-8?B?REtRaDAvRVUxV01wcE9EWVl4YVkrd0EvcVFvNHpMdGNnY3RxTW9YY2RMSmo2?=
 =?utf-8?B?bmtOVG5LSUtsbWdCb1JOZDNVdGRRRWNZWWV1RkVmOXN5a3F1cS9UZExGamVP?=
 =?utf-8?B?SURueU40MVBQWW13UGxVaXYzM1B1aWMvOEI4Y2dTcklZYlFmMmo1S0JGN0RD?=
 =?utf-8?B?TDJOSzZKOXdoU3lRNVE5MHVpSmRzUU1vejkzdDJIcUJTKzArU1czY0hPNEUy?=
 =?utf-8?B?TVN2dWhWZ2xkUVpleVRiVU5kU0FHdzdLVGh5NXd6eStyTXRqTWd6UmtDbDF2?=
 =?utf-8?B?bW41aEFqUyttRDhLZVRxdVVRRlZoZGs2eW0vb2NLdWtsUjZTZnB5UU1rKy9W?=
 =?utf-8?B?UkJadz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHhYeDNrU3B3N2FpYjhZbXJpRGtZaHRjM0FYdmptU0lYenZyZ0g1RGJUK29a?=
 =?utf-8?B?SnByL01vYWlBQWxJa2FYcWFCV3dKNnNGT1dFZFZDNTFvTExxNktaT0czdUdu?=
 =?utf-8?B?NlgvRkQ5cjRxMit0anN1TDJrVVdta2drMVJEWTh0UUpBcDdWa1ljTEgzditF?=
 =?utf-8?B?NWV1TG9mS285QUNWcnNLYmJlbnk1bWdoeGxUMEpEVFZ2RnpKZ0Z0M05NVzE4?=
 =?utf-8?B?b0xsOHlGSkRTTzhmN0NtbFBvdzBlWk9scFoxekVJREJxS0I2S0h2MnpFN2RX?=
 =?utf-8?B?ai80ejkvUzk1S0lrV2dCSjhXTnFuTnU2QzVURkVHZDFsMk1lc3NieGE2VDUz?=
 =?utf-8?B?SS84L1dTMnlzSEd6YWs5Sm5KK01vaEFJTm12UE9Ca0l6emI4Wis0ZUJ1c2xU?=
 =?utf-8?B?bDZ6bjc2SWw3SnRxd3VrbCtvZkJka3ZtNm5hN2tMMjRTbStRREJ2aEhHUTdm?=
 =?utf-8?B?Q1pMaGk3bGhiU0J3MTllRlJnV0R0OEdJeXhJRktGM29oYU1YWU5ZNzQyOXVL?=
 =?utf-8?B?TmplS2E3OFJBK25JNHRWbzhldWZ3MEZSS2Y2TUhNT1B2WGNEK0dKVEoxb0Vp?=
 =?utf-8?B?azRYZ0V5N3ZmOCtNT2Q5QlEzTWJjK0lSMzdFWllYaG9MMTlyTjhEYWdMOHZS?=
 =?utf-8?B?N1dTZ1I4Z3VRaVU2WHlRbjJGWjc1VjF2YXpaQWVDQXdPdXZKQ25ENDArNDhO?=
 =?utf-8?B?WGVEdHUxZDYrYnp2MGRpdjRnNW0vNExGSGV3TXpHNGtMU3NTYWdOZEFmKzVJ?=
 =?utf-8?B?ZnloWFRjVzNXMkxSaDg5b1JFUzZqbW1kVStCZEdzUGUwN0szY0UwRGc5b01q?=
 =?utf-8?B?bXBLSVNpMTd2eTFjWTNQQnpLcXYyQkI4c1pZNVA0S005dUo0VUxhVnovT0NH?=
 =?utf-8?B?NStMRExFY3V1Ym5Ycm1VY2w1QVhtaVM5UCtWQ0cxQzZHVTJqSWx1cy9HajlF?=
 =?utf-8?B?Z2E4TTZqN3ZIZXBKSmFweXRKbHQ1SFRHZGs0S0tGOGFwRlF4RG5PcjUxbGE4?=
 =?utf-8?B?bjQrN0hLZ2RBcm55R3ZuU0lDU2hsZ0ZuT0FoMzFlVDJMZ1lDemxOYXpub2JB?=
 =?utf-8?B?VGxqZ0RxNVpaZnZERVlxYm0vQURoM3gxbGpsb3QybEZSUm5vMkhpREE3bWFY?=
 =?utf-8?B?cTlGSmFianhlTDFsOTIrMGk0NFEvSE8rM2h1ekErY0t0M1ZKd1ZwaTdEUERz?=
 =?utf-8?B?aUtPNDFiaGpXK29MQmY3Wkl0WXc4bGVqT0h0REx5WDBndk55R0RiNFhodmtE?=
 =?utf-8?B?OFZidEMzUGhUVU95bGpDZVIxSDFKS1ZGdHlJbDN2Vi9jYnp2dWt4WFBISmta?=
 =?utf-8?B?cjRLVnNyZGdJMFlDV0xPTGRtZnJmWldta1hPanZLY3dja2VXTjRxWkNZM3Mr?=
 =?utf-8?B?T3d4ZDlNYi9vRk1kMWZ2c0NYdmE3Z0w1dy9rd3dJN0NyNkNmV2x4YVBCcTl2?=
 =?utf-8?B?a3hvbms3N0VmOUVOS2NZb0ZQcDM5SHR2YmRmd1AxbG0zZEgwQmcxVTIrbkhp?=
 =?utf-8?B?ejlWdnVyTFREeFF1cWNKWERJZkxvQThMa3RmOGRLbmxURGVNM3ViL1BZWUxX?=
 =?utf-8?B?UllGWlc0UHVndmo4akthaE1oNlR4NkFONmFVUUdxbldYbkhlQkdBb0xzR2Zw?=
 =?utf-8?B?YURRQ091Zi9LdEY1V2tLZ2V5WCtUd2pJd0xSN2tZRUVUQ1ZuUGpXekw5UXYx?=
 =?utf-8?Q?NBSd3dpWK9OnbGvEX73l?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2944753-1013-4ce2-445d-08dd574ebc77
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB5076.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:49:45.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9029

On 2025/2/27 16:24, Andrea Righi wrote:
> On Wed, Feb 26, 2025 at 07:28:19PM +0000, Juntong Deng wrote:
>> Currently, kfunc filters already support filtering based on struct_ops
>> context information.
>>
>> The BPF verifier can check context-sensitive kfuncs before the SCX
>> program is run, avoiding runtime overhead.
>>
>> Therefore we no longer need mask-based runtime restrictions.
>>
>> This patch removes the mask-based runtime restrictions.
> 
> You may have missed scx_prio_less(), that is still using SCX_KF_REST:
> 
> kernel/sched/ext.c: In function ‘scx_prio_less’:
> kernel/sched/ext.c:1171:27: error: ‘struct sched_ext_ops’ has no member named ‘SCX_KF_REST’
>   1171 |         __typeof__(scx_ops.op(task0, task1, ##args)) __ret;                     \
>        |                           ^
> 
> I think you just need to add:
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 4a4713c3af67b..51c13b8c27743 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3302,7 +3302,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
>   	 * verifier.
>   	 */
>   	if (SCX_HAS_OP(core_sched_before) && !scx_rq_bypassing(task_rq(a)))
> -		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, core_sched_before,
> +		return SCX_CALL_OP_2TASKS_RET(core_sched_before,
>   					      (struct task_struct *)a,
>   					      (struct task_struct *)b);
>   	else
> 
> -Andrea
> 

Thanks for pointing this out.

I made the mistake of not enabling CONFIG_SCHED_CORE, which led to not
noticing this issue.

If you find any other issues, please let me know.

I will fix these issues in the next version.

>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   include/linux/sched/ext.h |  24 ----
>>   kernel/sched/ext.c        | 227 ++++++++------------------------------
>>   kernel/sched/ext_idle.c   |   5 +-
>>   3 files changed, 50 insertions(+), 206 deletions(-)
>>
>> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
>> index f7545430a548..9980d6b55c84 100644
>> --- a/include/linux/sched/ext.h
>> +++ b/include/linux/sched/ext.h
>> @@ -96,29 +96,6 @@ enum scx_ent_dsq_flags {
>>   	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
>>   };
>>   
>> -/*
>> - * Mask bits for scx_entity.kf_mask. Not all kfuncs can be called from
>> - * everywhere and the following bits track which kfunc sets are currently
>> - * allowed for %current. This simple per-task tracking works because SCX ops
>> - * nest in a limited way. BPF will likely implement a way to allow and disallow
>> - * kfuncs depending on the calling context which will replace this manual
>> - * mechanism. See scx_kf_allow().
>> - */
>> -enum scx_kf_mask {
>> -	SCX_KF_UNLOCKED		= 0,	  /* sleepable and not rq locked */
>> -	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
>> -	SCX_KF_CPU_RELEASE	= 1 << 0, /* ops.cpu_release() */
>> -	/* ops.dequeue (in REST) may be nested inside DISPATCH */
>> -	SCX_KF_DISPATCH		= 1 << 1, /* ops.dispatch() */
>> -	SCX_KF_ENQUEUE		= 1 << 2, /* ops.enqueue() and ops.select_cpu() */
>> -	SCX_KF_SELECT_CPU	= 1 << 3, /* ops.select_cpu() */
>> -	SCX_KF_REST		= 1 << 4, /* other rq-locked operations */
>> -
>> -	__SCX_KF_RQ_LOCKED	= SCX_KF_CPU_RELEASE | SCX_KF_DISPATCH |
>> -				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
>> -	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
>> -};
>> -
>>   enum scx_dsq_lnode_flags {
>>   	SCX_DSQ_LNODE_ITER_CURSOR = 1 << 0,
>>   
>> @@ -147,7 +124,6 @@ struct sched_ext_entity {
>>   	s32			sticky_cpu;
>>   	s32			holding_cpu;
>>   	s32			selected_cpu;
>> -	u32			kf_mask;	/* see scx_kf_mask above */
>>   	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
>>   	atomic_long_t		ops_state;
>>   
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index c337f6206ae5..7dc5f11be66b 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -1115,19 +1115,6 @@ static long jiffies_delta_msecs(unsigned long at, unsigned long now)
>>   		return -(long)jiffies_to_msecs(now - at);
>>   }
>>   
>> -/* if the highest set bit is N, return a mask with bits [N+1, 31] set */
>> -static u32 higher_bits(u32 flags)
>> -{
>> -	return ~((1 << fls(flags)) - 1);
>> -}
>> -
>> -/* return the mask with only the highest bit set */
>> -static u32 highest_bit(u32 flags)
>> -{
>> -	int bit = fls(flags);
>> -	return ((u64)1 << bit) >> 1;
>> -}
>> -
>>   static bool u32_before(u32 a, u32 b)
>>   {
>>   	return (s32)(a - b) < 0;
>> @@ -1143,51 +1130,12 @@ static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
>>   	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
>>   }
>>   
>> -/*
>> - * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
>> - * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
>> - * the allowed kfuncs and those kfuncs should use scx_kf_allowed() to check
>> - * whether it's running from an allowed context.
>> - *
>> - * @mask is constant, always inline to cull the mask calculations.
>> - */
>> -static __always_inline void scx_kf_allow(u32 mask)
>> -{
>> -	/* nesting is allowed only in increasing scx_kf_mask order */
>> -	WARN_ONCE((mask | higher_bits(mask)) & current->scx.kf_mask,
>> -		  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x\n",
>> -		  current->scx.kf_mask, mask);
>> -	current->scx.kf_mask |= mask;
>> -	barrier();
>> -}
>> -
>> -static void scx_kf_disallow(u32 mask)
>> -{
>> -	barrier();
>> -	current->scx.kf_mask &= ~mask;
>> -}
>> -
>> -#define SCX_CALL_OP(mask, op, args...)						\
>> -do {										\
>> -	if (mask) {								\
>> -		scx_kf_allow(mask);						\
>> -		scx_ops.op(args);						\
>> -		scx_kf_disallow(mask);						\
>> -	} else {								\
>> -		scx_ops.op(args);						\
>> -	}									\
>> -} while (0)
>> +#define SCX_CALL_OP(op, args...)	scx_ops.op(args)
>>   
>> -#define SCX_CALL_OP_RET(mask, op, args...)					\
>> +#define SCX_CALL_OP_RET(op, args...)						\
>>   ({										\
>>   	__typeof__(scx_ops.op(args)) __ret;					\
>> -	if (mask) {								\
>> -		scx_kf_allow(mask);						\
>> -		__ret = scx_ops.op(args);					\
>> -		scx_kf_disallow(mask);						\
>> -	} else {								\
>> -		__ret = scx_ops.op(args);					\
>> -	}									\
>> +	__ret = scx_ops.op(args);						\
>>   	__ret;									\
>>   })
>>   
>> @@ -1202,74 +1150,36 @@ do {										\
>>    * scx_kf_allowed_on_arg_tasks() to test whether the invocation is allowed on
>>    * the specific task.
>>    */
>> -#define SCX_CALL_OP_TASK(mask, op, task, args...)				\
>> +#define SCX_CALL_OP_TASK(op, task, args...)					\
>>   do {										\
>> -	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
>>   	current->scx.kf_tasks[0] = task;					\
>> -	SCX_CALL_OP(mask, op, task, ##args);					\
>> +	SCX_CALL_OP(op, task, ##args);						\
>>   	current->scx.kf_tasks[0] = NULL;					\
>>   } while (0)
>>   
>> -#define SCX_CALL_OP_TASK_RET(mask, op, task, args...)				\
>> +#define SCX_CALL_OP_TASK_RET(op, task, args...)					\
>>   ({										\
>>   	__typeof__(scx_ops.op(task, ##args)) __ret;				\
>> -	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
>>   	current->scx.kf_tasks[0] = task;					\
>> -	__ret = SCX_CALL_OP_RET(mask, op, task, ##args);			\
>> +	__ret = SCX_CALL_OP_RET(op, task, ##args);				\
>>   	current->scx.kf_tasks[0] = NULL;					\
>>   	__ret;									\
>>   })
>>   
>> -#define SCX_CALL_OP_2TASKS_RET(mask, op, task0, task1, args...)			\
>> +#define SCX_CALL_OP_2TASKS_RET(op, task0, task1, args...)			\
>>   ({										\
>>   	__typeof__(scx_ops.op(task0, task1, ##args)) __ret;			\
>> -	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
>>   	current->scx.kf_tasks[0] = task0;					\
>>   	current->scx.kf_tasks[1] = task1;					\
>> -	__ret = SCX_CALL_OP_RET(mask, op, task0, task1, ##args);		\
>> +	__ret = SCX_CALL_OP_RET(op, task0, task1, ##args);			\
>>   	current->scx.kf_tasks[0] = NULL;					\
>>   	current->scx.kf_tasks[1] = NULL;					\
>>   	__ret;									\
>>   })
>>   
>> -/* @mask is constant, always inline to cull unnecessary branches */
>> -static __always_inline bool scx_kf_allowed(u32 mask)
>> -{
>> -	if (unlikely(!(current->scx.kf_mask & mask))) {
>> -		scx_ops_error("kfunc with mask 0x%x called from an operation only allowing 0x%x",
>> -			      mask, current->scx.kf_mask);
>> -		return false;
>> -	}
>> -
>> -	/*
>> -	 * Enforce nesting boundaries. e.g. A kfunc which can be called from
>> -	 * DISPATCH must not be called if we're running DEQUEUE which is nested
>> -	 * inside ops.dispatch(). We don't need to check boundaries for any
>> -	 * blocking kfuncs as the verifier ensures they're only called from
>> -	 * sleepable progs.
>> -	 */
>> -	if (unlikely(highest_bit(mask) == SCX_KF_CPU_RELEASE &&
>> -		     (current->scx.kf_mask & higher_bits(SCX_KF_CPU_RELEASE)))) {
>> -		scx_ops_error("cpu_release kfunc called from a nested operation");
>> -		return false;
>> -	}
>> -
>> -	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
>> -		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
>> -		scx_ops_error("dispatch kfunc called from a nested operation");
>> -		return false;
>> -	}
>> -
>> -	return true;
>> -}
>> -
>>   /* see SCX_CALL_OP_TASK() */
>> -static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
>> -							struct task_struct *p)
>> +static __always_inline bool scx_kf_allowed_on_arg_tasks(struct task_struct *p)
>>   {
>> -	if (!scx_kf_allowed(mask))
>> -		return false;
>> -
>>   	if (unlikely((p != current->scx.kf_tasks[0] &&
>>   		      p != current->scx.kf_tasks[1]))) {
>>   		scx_ops_error("called on a task not being operated on");
>> @@ -1279,11 +1189,6 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
>>   	return true;
>>   }
>>   
>> -static bool scx_kf_allowed_if_unlocked(void)
>> -{
>> -	return !current->scx.kf_mask;
>> -}
>> -
>>   /**
>>    * nldsq_next_task - Iterate to the next task in a non-local DSQ
>>    * @dsq: user dsq being iterated
>> @@ -2219,7 +2124,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>>   	WARN_ON_ONCE(*ddsp_taskp);
>>   	*ddsp_taskp = p;
>>   
>> -	SCX_CALL_OP_TASK(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
>> +	SCX_CALL_OP_TASK(enqueue, p, enq_flags);
>>   
>>   	*ddsp_taskp = NULL;
>>   	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
>> @@ -2316,7 +2221,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
>>   	add_nr_running(rq, 1);
>>   
>>   	if (SCX_HAS_OP(runnable) && !task_on_rq_migrating(p))
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
>> +		SCX_CALL_OP_TASK(runnable, p, enq_flags);
>>   
>>   	if (enq_flags & SCX_ENQ_WAKEUP)
>>   		touch_core_sched(rq, p);
>> @@ -2351,7 +2256,7 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
>>   		BUG();
>>   	case SCX_OPSS_QUEUED:
>>   		if (SCX_HAS_OP(dequeue))
>> -			SCX_CALL_OP_TASK(SCX_KF_REST, dequeue, p, deq_flags);
>> +			SCX_CALL_OP_TASK(dequeue, p, deq_flags);
>>   
>>   		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>>   					    SCX_OPSS_NONE))
>> @@ -2400,11 +2305,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>>   	 */
>>   	if (SCX_HAS_OP(stopping) && task_current(rq, p)) {
>>   		update_curr_scx(rq);
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, false);
>> +		SCX_CALL_OP_TASK(stopping, p, false);
>>   	}
>>   
>>   	if (SCX_HAS_OP(quiescent) && !task_on_rq_migrating(p))
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, quiescent, p, deq_flags);
>> +		SCX_CALL_OP_TASK(quiescent, p, deq_flags);
>>   
>>   	if (deq_flags & SCX_DEQ_SLEEP)
>>   		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
>> @@ -2424,7 +2329,7 @@ static void yield_task_scx(struct rq *rq)
>>   	struct task_struct *p = rq->curr;
>>   
>>   	if (SCX_HAS_OP(yield))
>> -		SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, p, NULL);
>> +		SCX_CALL_OP_2TASKS_RET(yield, p, NULL);
>>   	else
>>   		p->scx.slice = 0;
>>   }
>> @@ -2434,7 +2339,7 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
>>   	struct task_struct *from = rq->curr;
>>   
>>   	if (SCX_HAS_OP(yield))
>> -		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, from, to);
>> +		return SCX_CALL_OP_2TASKS_RET(yield, from, to);
>>   	else
>>   		return false;
>>   }
>> @@ -2992,7 +2897,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>>   		 * emitted in switch_class().
>>   		 */
>>   		if (SCX_HAS_OP(cpu_acquire))
>> -			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, cpu_of(rq), NULL);
>> +			SCX_CALL_OP(cpu_acquire, cpu_of(rq), NULL);
>>   		rq->scx.cpu_released = false;
>>   	}
>>   
>> @@ -3037,8 +2942,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>>   	do {
>>   		dspc->nr_tasks = 0;
>>   
>> -		SCX_CALL_OP(SCX_KF_DISPATCH, dispatch, cpu_of(rq),
>> -			    prev_on_scx ? prev : NULL);
>> +		SCX_CALL_OP(dispatch, cpu_of(rq), prev_on_scx ? prev : NULL);
>>   
>>   		flush_dispatch_buf(rq);
>>   
>> @@ -3159,7 +3063,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
>>   
>>   	/* see dequeue_task_scx() on why we skip when !QUEUED */
>>   	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
>> +		SCX_CALL_OP_TASK(running, p);
>>   
>>   	clr_task_runnable(p, true);
>>   
>> @@ -3240,8 +3144,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
>>   				.task = next,
>>   			};
>>   
>> -			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
>> -				    cpu_release, cpu_of(rq), &args);
>> +			SCX_CALL_OP(cpu_release, cpu_of(rq), &args);
>>   		}
>>   		rq->scx.cpu_released = true;
>>   	}
>> @@ -3254,7 +3157,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>>   
>>   	/* see dequeue_task_scx() on why we skip when !QUEUED */
>>   	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
>> +		SCX_CALL_OP_TASK(stopping, p, true);
>>   
>>   	if (p->scx.flags & SCX_TASK_QUEUED) {
>>   		set_task_runnable(rq, p);
>> @@ -3428,8 +3331,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
>>   		WARN_ON_ONCE(*ddsp_taskp);
>>   		*ddsp_taskp = p;
>>   
>> -		cpu = SCX_CALL_OP_TASK_RET(SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
>> -					   select_cpu, p, prev_cpu, wake_flags);
>> +		cpu = SCX_CALL_OP_TASK_RET(select_cpu, p, prev_cpu, wake_flags);
>>   		p->scx.selected_cpu = cpu;
>>   		*ddsp_taskp = NULL;
>>   		if (ops_cpu_valid(cpu, "from ops.select_cpu()"))
>> @@ -3473,8 +3375,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
>>   	 * designation pointless. Cast it away when calling the operation.
>>   	 */
>>   	if (SCX_HAS_OP(set_cpumask))
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
>> -				 (struct cpumask *)p->cpus_ptr);
>> +		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
>>   }
>>   
>>   static void handle_hotplug(struct rq *rq, bool online)
>> @@ -3487,9 +3388,9 @@ static void handle_hotplug(struct rq *rq, bool online)
>>   		scx_idle_update_selcpu_topology(&scx_ops);
>>   
>>   	if (online && SCX_HAS_OP(cpu_online))
>> -		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
>> +		SCX_CALL_OP(cpu_online, cpu);
>>   	else if (!online && SCX_HAS_OP(cpu_offline))
>> -		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_offline, cpu);
>> +		SCX_CALL_OP(cpu_offline, cpu);
>>   	else
>>   		scx_ops_exit(SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
>>   			     "cpu %d going %s, exiting scheduler", cpu,
>> @@ -3593,7 +3494,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
>>   		curr->scx.slice = 0;
>>   		touch_core_sched(rq, curr);
>>   	} else if (SCX_HAS_OP(tick)) {
>> -		SCX_CALL_OP(SCX_KF_REST, tick, curr);
>> +		SCX_CALL_OP(tick, curr);
>>   	}
>>   
>>   	if (!curr->scx.slice)
>> @@ -3670,7 +3571,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
>>   			.fork = fork,
>>   		};
>>   
>> -		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init_task, p, &args);
>> +		ret = SCX_CALL_OP_RET(init_task, p, &args);
>>   		if (unlikely(ret)) {
>>   			ret = ops_sanitize_err("init_task", ret);
>>   			return ret;
>> @@ -3727,11 +3628,11 @@ static void scx_ops_enable_task(struct task_struct *p)
>>   	p->scx.weight = sched_weight_to_cgroup(weight);
>>   
>>   	if (SCX_HAS_OP(enable))
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p);
>> +		SCX_CALL_OP_TASK(enable, p);
>>   	scx_set_task_state(p, SCX_TASK_ENABLED);
>>   
>>   	if (SCX_HAS_OP(set_weight))
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
>> +		SCX_CALL_OP_TASK(set_weight, p, p->scx.weight);
>>   }
>>   
>>   static void scx_ops_disable_task(struct task_struct *p)
>> @@ -3740,7 +3641,7 @@ static void scx_ops_disable_task(struct task_struct *p)
>>   	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
>>   
>>   	if (SCX_HAS_OP(disable))
>> -		SCX_CALL_OP(SCX_KF_REST, disable, p);
>> +		SCX_CALL_OP(disable, p);
>>   	scx_set_task_state(p, SCX_TASK_READY);
>>   }
>>   
>> @@ -3769,7 +3670,7 @@ static void scx_ops_exit_task(struct task_struct *p)
>>   	}
>>   
>>   	if (SCX_HAS_OP(exit_task))
>> -		SCX_CALL_OP(SCX_KF_REST, exit_task, p, &args);
>> +		SCX_CALL_OP(exit_task, p, &args);
>>   	scx_set_task_state(p, SCX_TASK_NONE);
>>   }
>>   
>> @@ -3878,7 +3779,7 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
>>   
>>   	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
>>   	if (SCX_HAS_OP(set_weight))
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
>> +		SCX_CALL_OP_TASK(set_weight, p, p->scx.weight);
>>   }
>>   
>>   static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
>> @@ -3894,8 +3795,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
>>   	 * different scheduler class. Keep the BPF scheduler up-to-date.
>>   	 */
>>   	if (SCX_HAS_OP(set_cpumask))
>> -		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
>> -				 (struct cpumask *)p->cpus_ptr);
>> +		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
>>   }
>>   
>>   static void switched_from_scx(struct rq *rq, struct task_struct *p)
>> @@ -3987,8 +3887,7 @@ int scx_tg_online(struct task_group *tg)
>>   			struct scx_cgroup_init_args args =
>>   				{ .weight = tg->scx_weight };
>>   
>> -			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
>> -					      tg->css.cgroup, &args);
>> +			ret = SCX_CALL_OP_RET(cgroup_init, tg->css.cgroup, &args);
>>   			if (ret)
>>   				ret = ops_sanitize_err("cgroup_init", ret);
>>   		}
>> @@ -4009,7 +3908,7 @@ void scx_tg_offline(struct task_group *tg)
>>   	percpu_down_read(&scx_cgroup_rwsem);
>>   
>>   	if (SCX_HAS_OP(cgroup_exit) && (tg->scx_flags & SCX_TG_INITED))
>> -		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, tg->css.cgroup);
>> +		SCX_CALL_OP(cgroup_exit, tg->css.cgroup);
>>   	tg->scx_flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
>>   
>>   	percpu_up_read(&scx_cgroup_rwsem);
>> @@ -4042,8 +3941,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
>>   			continue;
>>   
>>   		if (SCX_HAS_OP(cgroup_prep_move)) {
>> -			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_prep_move,
>> -					      p, from, css->cgroup);
>> +			ret = SCX_CALL_OP_RET(cgroup_prep_move, p, from, css->cgroup);
>>   			if (ret)
>>   				goto err;
>>   		}
>> @@ -4056,8 +3954,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
>>   err:
>>   	cgroup_taskset_for_each(p, css, tset) {
>>   		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
>> -			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
>> -				    p->scx.cgrp_moving_from, css->cgroup);
>> +			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
>>   		p->scx.cgrp_moving_from = NULL;
>>   	}
>>   
>> @@ -4075,8 +3972,7 @@ void scx_cgroup_move_task(struct task_struct *p)
>>   	 * cgrp_moving_from set.
>>   	 */
>>   	if (SCX_HAS_OP(cgroup_move) && !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
>> -		SCX_CALL_OP_TASK(SCX_KF_UNLOCKED, cgroup_move, p,
>> -			p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
>> +		SCX_CALL_OP_TASK(cgroup_move, p, p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
>>   	p->scx.cgrp_moving_from = NULL;
>>   }
>>   
>> @@ -4095,8 +3991,7 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
>>   
>>   	cgroup_taskset_for_each(p, css, tset) {
>>   		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
>> -			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
>> -				    p->scx.cgrp_moving_from, css->cgroup);
>> +			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
>>   		p->scx.cgrp_moving_from = NULL;
>>   	}
>>   out_unlock:
>> @@ -4109,8 +4004,7 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
>>   
>>   	if (scx_cgroup_enabled && tg->scx_weight != weight) {
>>   		if (SCX_HAS_OP(cgroup_set_weight))
>> -			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight,
>> -				    tg_cgrp(tg), weight);
>> +			SCX_CALL_OP(cgroup_set_weight, tg_cgrp(tg), weight);
>>   		tg->scx_weight = weight;
>>   	}
>>   
>> @@ -4300,7 +4194,7 @@ static void scx_cgroup_exit(void)
>>   			continue;
>>   		rcu_read_unlock();
>>   
>> -		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, css->cgroup);
>> +		SCX_CALL_OP(cgroup_exit, css->cgroup);
>>   
>>   		rcu_read_lock();
>>   		css_put(css);
>> @@ -4343,8 +4237,7 @@ static int scx_cgroup_init(void)
>>   			continue;
>>   		rcu_read_unlock();
>>   
>> -		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
>> -				      css->cgroup, &args);
>> +		ret = SCX_CALL_OP_RET(cgroup_init, css->cgroup, &args);
>>   		if (ret) {
>>   			css_put(css);
>>   			scx_ops_error("ops.cgroup_init() failed (%d)", ret);
>> @@ -4840,7 +4733,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
>>   	}
>>   
>>   	if (scx_ops.exit)
>> -		SCX_CALL_OP(SCX_KF_UNLOCKED, exit, ei);
>> +		SCX_CALL_OP(exit, ei);
>>   
>>   	cancel_delayed_work_sync(&scx_watchdog_work);
>>   
>> @@ -5047,7 +4940,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
>>   
>>   	if (SCX_HAS_OP(dump_task)) {
>>   		ops_dump_init(s, "    ");
>> -		SCX_CALL_OP(SCX_KF_REST, dump_task, dctx, p);
>> +		SCX_CALL_OP(dump_task, dctx, p);
>>   		ops_dump_exit();
>>   	}
>>   
>> @@ -5094,7 +4987,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>>   
>>   	if (SCX_HAS_OP(dump)) {
>>   		ops_dump_init(&s, "");
>> -		SCX_CALL_OP(SCX_KF_UNLOCKED, dump, &dctx);
>> +		SCX_CALL_OP(dump, &dctx);
>>   		ops_dump_exit();
>>   	}
>>   
>> @@ -5151,7 +5044,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>>   		used = seq_buf_used(&ns);
>>   		if (SCX_HAS_OP(dump_cpu)) {
>>   			ops_dump_init(&ns, "  ");
>> -			SCX_CALL_OP(SCX_KF_REST, dump_cpu, &dctx, cpu, idle);
>> +			SCX_CALL_OP(dump_cpu, &dctx, cpu, idle);
>>   			ops_dump_exit();
>>   		}
>>   
>> @@ -5405,7 +5298,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>>   	cpus_read_lock();
>>   
>>   	if (scx_ops.init) {
>> -		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
>> +		ret = SCX_CALL_OP_RET(init);
>>   		if (ret) {
>>   			ret = ops_sanitize_err("init", ret);
>>   			cpus_read_unlock();
>> @@ -6146,9 +6039,6 @@ void __init init_sched_ext_class(void)
>>    */
>>   static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
>>   {
>> -	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
>> -		return false;
>> -
>>   	lockdep_assert_irqs_disabled();
>>   
>>   	if (unlikely(!p)) {
>> @@ -6310,9 +6200,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>>   	bool in_balance;
>>   	unsigned long flags;
>>   
>> -	if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
>> -		return false;
>> -
>>   	/*
>>   	 * Can be called from either ops.dispatch() locking this_rq() or any
>>   	 * context where no rq lock is held. If latter, lock @p's task_rq which
>> @@ -6395,9 +6282,6 @@ __bpf_kfunc_start_defs();
>>    */
>>   __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
>>   {
>> -	if (!scx_kf_allowed(SCX_KF_DISPATCH))
>> -		return 0;
>> -
>>   	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
>>   }
>>   
>> @@ -6411,9 +6295,6 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
>>   {
>>   	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
>>   
>> -	if (!scx_kf_allowed(SCX_KF_DISPATCH))
>> -		return;
>> -
>>   	if (dspc->cursor > 0)
>>   		dspc->cursor--;
>>   	else
>> @@ -6439,9 +6320,6 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
>>   	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
>>   	struct scx_dispatch_q *dsq;
>>   
>> -	if (!scx_kf_allowed(SCX_KF_DISPATCH))
>> -		return false;
>> -
>>   	flush_dispatch_buf(dspc->rq);
>>   
>>   	dsq = find_user_dsq(dsq_id);
>> @@ -6632,9 +6510,6 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
>>   	struct rq *rq;
>>   	struct task_struct *p, *n;
>>   
>> -	if (!scx_kf_allowed(SCX_KF_CPU_RELEASE))
>> -		return 0;
>> -
>>   	rq = cpu_rq(smp_processor_id());
>>   	lockdep_assert_rq_held(rq);
>>   
>> @@ -7239,7 +7114,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
>>   	struct task_group *tg = p->sched_task_group;
>>   	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
>>   
>> -	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
>> +	if (!scx_kf_allowed_on_arg_tasks(p))
>>   		goto out;
>>   
>>   	cgrp = tg_cgrp(tg);
>> @@ -7479,10 +7354,6 @@ static int __init scx_init(void)
>>   	 *
>>   	 * Some kfuncs are context-sensitive and can only be called from
>>   	 * specific SCX ops. They are grouped into BTF sets accordingly.
>> -	 * Unfortunately, BPF currently doesn't have a way of enforcing such
>> -	 * restrictions. Eventually, the verifier should be able to enforce
>> -	 * them. For now, register them the same and make each kfunc explicitly
>> -	 * check using scx_kf_allowed().
>>   	 */
>>   	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>>   					     &scx_kfunc_set_ops_context_sensitive)) ||
>> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
>> index efb6077810d8..e241935021eb 100644
>> --- a/kernel/sched/ext_idle.c
>> +++ b/kernel/sched/ext_idle.c
>> @@ -658,7 +658,7 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
>>   	 * managed by put_prev_task_idle()/set_next_task_idle().
>>   	 */
>>   	if (SCX_HAS_OP(update_idle) && do_notify && !scx_rq_bypassing(rq))
>> -		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
>> +		SCX_CALL_OP(update_idle, cpu_of(rq), idle);
>>   
>>   	/*
>>   	 * Update the idle masks:
>> @@ -803,9 +803,6 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>>   	if (!check_builtin_idle_enabled())
>>   		goto prev_cpu;
>>   
>> -	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
>> -		goto prev_cpu;
>> -
>>   #ifdef CONFIG_SMP
>>   	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
>>   #endif
>> -- 
>> 2.39.5
>>


