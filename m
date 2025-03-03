Return-Path: <bpf+bounces-53067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F19A4C3AE
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7213AD514
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88152213E94;
	Mon,  3 Mar 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pvYUiRSO"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2068.outbound.protection.outlook.com [40.92.90.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8839213E8B;
	Mon,  3 Mar 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012918; cv=fail; b=dHfBRYHoKi94B8VWvnNO9gORgS06xArIT/lm09StQSfXS2aC8QAFe/j2DfvfkhqfrBkdkpbtweV5ReTclD2sCrwUDzB5G6KufHJazSQYS0utOM7pEZW+RqGlN7JFEyLx5it05gt4x3HqH9cJIlNbnm2vX1To4WkXWJNJyRy6HuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012918; c=relaxed/simple;
	bh=OYMwTkFozPfGROqIaERARxrQy+lG6cIOp+6WfHbHzyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/v4D2StwJUmA/3XYkzeEhrmp8mgpQTRLpVOOpUkS+Dgo/GQoqhRxMG3pMcIcq2fsY/VgCOeuU134FQkl8n8ZjZSsJZ6j5WrPapjSoBp+6B7BV8TpeyL/waH7X3MkAkPI4Hr+PzQxa9S/QlAt4ZuAj5Qkj+/vkohOIWmYzh2Fws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pvYUiRSO; arc=fail smtp.client-ip=40.92.90.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3avNfkKqkho1zfCsczV4DyEcqgzK1RbOPXKHyLMuTpjly8v7G4gOlOJOTagJxCe3OmCEfO90q2a/x3Dnr83KTT2nCEOb53GqmHASOjjcwKH9OsRA+ncDuiwPZ2nvKGqR75RspU4n+ILjU0hQQcvkyMLZ1IDd8BZh3ijUC0EDMHWTfvWdJGnz5YiIU7uj1kh6nvDlk0zqb39YL3oxoqPZi4VFhK2SigG+7MLcwu1sJlpKuu9FtpMhoWqLhyTg+HGm/dfD7e/PMyc6JpSpCqZ5QKCoDTn92hGjI7/l6jma6Sr8IBKK/eUACx+4QLtOy/Z5i2lNLv4L/jdcmw+76K+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLm9tsm7IRZvqaKg672fcDv9KlzWTxoq5iFGBVmZS34=;
 b=AfYEqw4Vuu4Ys9roev9guL2rCqZCVtVjvtzWFpptUoW/a0oieEfLZcJolOOK1p/0Uk8ELRErrFcg5XknLd7Ae3Y3w7V2Mo18WLeyFcBn6BNv/41/X/Wql3vNRjIlQWwl2syB8PO2u4EShggw6Tra8IQo/GUnj1XJgdI69MCz46SjUqtNmSqyolWoTWxSKFaDkz4pvM5m4BK+UFRTTXrmemKmZipEZjWqgPKFAuVMK31laRg6nx8sz2W7Y6Xxc9G5cAL8rHpE8zUub4sgtMEOxXlWpfpPP0jISuVT1nOwHqdHlXFH/GfPZ6pw+IHLQlEws26hJL4qdOiTPjSwWhJvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLm9tsm7IRZvqaKg672fcDv9KlzWTxoq5iFGBVmZS34=;
 b=pvYUiRSOTsAQkq52NQjZr+VN9fNgnvaESJ1CD2VdeDIhyIfU2kQe+jGKz7zIwDa39vnhW0bNNKHDNnO8e4hjz9i6nq4NaFgKjfsb0YCQ4QBWnsTqRaNXMciZ9ICes5ii9CTfBnswJRzBQauOlLQFRkQbqODrQ6yzCpJT376KPonAOrAJqpRicNH6z/coUjjlevaofErOYi0Ph8a0Rz42RyEJ3fs4z2YphkOC99DDKMi6XgTV8wO1amsUMp+lTE2qWuynDdCO31peMHT/bi/9BZ6KqfIF+FlL1vMyVN94MLY+gTlhDMH2TaJkInEvCx661BQ1YfeIOnhQr2RqKs9XqA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by VI1PR03MB10077.eurprd03.prod.outlook.com (2603:10a6:800:1cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 14:41:52 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 14:41:52 +0000
Message-ID:
 <AM6PR03MB5080EAEABDA8AA271DB14D5E99C92@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Mon, 3 Mar 2025 14:41:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 4/6] bpf: Add bpf runtime hooks for tracking
 runtime acquire/release
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 snorcht@gmail.com, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLR0=L7xwh1SpDfcxRUhVE18k_L8g3Kx+Ykidt7f+=UhQ@mail.gmail.com>
 <AM6PR03MB50802FB7A70353605235806E99C32@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+TzLc=Z_Rp-UC6s9gg5hB1byd_w7oT807z44NuKC_TxA@mail.gmail.com>
 <AM6PR03MB508026B637117BD9E13C2F9299CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+cokog6j5RjO7qNwBWswXTbu-x2j4EoQEt405-2i5jXw@mail.gmail.com>
 <AM6PR03MB5080FC54F845102C913B596599CC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAP01T76m7OP_u8C1hJMrpVqJGf77W00DE9qB-8Yq6Cd-BMQ=7g@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAP01T76m7OP_u8C1hJMrpVqJGf77W00DE9qB-8Yq6Cd-BMQ=7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::7) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <3680cd4d-e276-4f1b-a7f7-7a820e5aebf2@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|VI1PR03MB10077:EE_
X-MS-Office365-Filtering-Correlation-Id: d22ffca8-8251-43e6-b101-08dd5a618963
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|8060799006|19110799003|5072599009|6090799003|10035399004|440099028|3412199025|13041999003|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2hWRUt4KzRzb282RHgvRHVtTklocHh4QU9yWERKVzlKREsxTDBQRkRycDNk?=
 =?utf-8?B?NUpPVHVNc0M5YXRlZ2ZLaUxBNDBDWFFhUUY0Q1hnQ0d0cGZ0MXFUVng4eUtB?=
 =?utf-8?B?eUp2R0x2OTE0QlYyQ1ZZUldMQTNxYXFVM2EvMjdXMUdaYVlPUmVKeFZaQ0Rl?=
 =?utf-8?B?MVg4UGxaM0ZnYkkzdStxV2R2QzhqcHFpVVBzUkt0bGZaRyt5WUs3M3Y4MkFT?=
 =?utf-8?B?UGdQVjFUc1NSem1CcWxPUCtXTXlHNzlQeDJzMnJPeU5uZm5rS3NQdEF4d3I4?=
 =?utf-8?B?QlJtalh4RGRzaUtKS0tZcjdkZXBKVC9jTTc0RWI4K2Y1N2R6OTVBRVdWeGdI?=
 =?utf-8?B?SFRteEJwYUQ5WFp1N2NpR0dnc1ZoeDlxeldoTlJyaDRodlBnd3hneEwvMzJk?=
 =?utf-8?B?aUdVcGdZVGdsUjEzZ0dGYlVaODg4dnNHUjBxOS9BNTB4b0RjZDZuMk9DRG1D?=
 =?utf-8?B?RmphRGplemRIL1NZVTlPZ1JwK2FUYURPOTVFVXZ0TmZMay9aQWNLejhxbVJX?=
 =?utf-8?B?VTlKUllJUEJraHRuVFFZSTYrcm9ocFA5TExTT0w3Z2o0VUR5YUw4cjdSVE5P?=
 =?utf-8?B?TVhaSHhqL3dIL2VweWh6YXpIbklOTEE3QTdRU284blhKSW9lVVVwZFBtVVgx?=
 =?utf-8?B?Nmh4ZTFZVnZ0NWpnODZvN0kyVXdoWDV1cWpuM2NaR1JpbHIwQVVpMkFoeFZz?=
 =?utf-8?B?aWI5c0phUFk4VnMzUzNRd3RWMjNtRitWQisvdDQ2aHRHb0ZUa2ZJcXFmZ3lu?=
 =?utf-8?B?USt0aEtoN01ad0NnaGR2OE5MQkVhWGljckpYU0cwckVFK0RYZnBnK1JvSVh3?=
 =?utf-8?B?ZWFESkJxSWhuUEdQbkJvajU1VTVodC9QbUVsVVB0SXBxVG1KRExqa1o2R0pR?=
 =?utf-8?B?VnZJV3NuWStxUTBRTnNWOUZFUHI3dm5xcS9JTFBjUForZzA2a2Y3Zi96TXdu?=
 =?utf-8?B?bmZhd2l0eVZSNDVwNS9GT2F6ZU93L0ROSGdkZ084VHNVcGd5a2pFS1lUOEtR?=
 =?utf-8?B?Y3graXhabng0Y2wrWHZVRk5EUGRhQjYwRk03akllQ3o1VGQ2cCs0UENOenhy?=
 =?utf-8?B?QVB1NkZaeU9hSEVzUjB5L1RUS2pVaUM0Z1NaemE2aGd5V29ZcERzR2U1TTZv?=
 =?utf-8?B?dnhZcEc5czlpK25nYWtzcFRDUlcrVklZQWI1ZnZjYWZYaDBybFR1QWdzalVw?=
 =?utf-8?B?VzcxaEJCbGU0ZUd0NGZmcFM5dmtUVHcyVDMrSURhZ2oxa0k1YkVCRUJzYVlm?=
 =?utf-8?B?UUtZQzNtTmlxd3pkN3Q4cEhST1B5SWJYbzJ2ZVpqRWdxc3VqeWZQWEQwWGZZ?=
 =?utf-8?B?SUx4UytkOWRYb3N3aDlqaVVtbzc2cmJiZ0UxSG5NS29GdUVjNTk5NTV3eks0?=
 =?utf-8?B?d0ZRSXhsdFNnUU5sUjVRdGFhUFdFU0txMzdzL2g1aXBPLzloRm1UWlFVZDJy?=
 =?utf-8?B?LzAySXE0M2pWVGpyN3VCT2Q1a25Qb3Q5a010UUdKQVpLMmoycmxJZXBLc05L?=
 =?utf-8?B?MFlRRG1ZOStVcnpGMWIxcUFoT1ZDUGlvWWNCMHhFQ21PalJJSzB0Yzl6eEtn?=
 =?utf-8?Q?W/tW24rElnxAhp5f9hf+WzYfRE3ME1kyAl/VF8axiJSu2x?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVBmYVA1Nm9lcjgvUnB0dUtqNFlZZjljZVQ4bnE0Ym90ZWZXeDVaS0loRFhS?=
 =?utf-8?B?V0NUQU1Oa1hGSHlITWdBSk9BRE13c3lwK1V5UEwxZ09xUU84ajFYclR6Rnh4?=
 =?utf-8?B?VUdGOU4yTk1GZEdLNmtlcm0zYUVvQTg5R1c2SlBOZU9ZcHdHUVFFdUFqdWtq?=
 =?utf-8?B?dFl2aFMwdndGUkdsdTlvMDd1U0xNU1BvMWErTzd2WVdWYXRMUWpXbHRBZ2NZ?=
 =?utf-8?B?Wit2WTU0eE9DbGRTMDUvVlFEMUJ1MjJyQXNsUmNJKzJBR1hNVitIY2YwNzFk?=
 =?utf-8?B?cHI1TjNRQkpnSkh3S25HV2lQVktuUktXdnNXSjhQWHpOOGlFZGg3cDIrMC9o?=
 =?utf-8?B?YStjS1NyVUFqQWJFZUxtUlUzNWpIY0lLNld6QzBUQXNCYVpjYWxLM2dnS3Zn?=
 =?utf-8?B?bDVZaENKSkNPUmVFZXgvUmtnMko0TWZiZkMrTkQybGdXNm0yM3haVGRCcDA0?=
 =?utf-8?B?akhNR2duNWwwUkJxbm81VmdRYVVqMGtJUnJTa28vTGNaeEdjM09wblU4OWNr?=
 =?utf-8?B?QXZZT3lOdlF1ZHh0SXdFejBQQ1RSTlBaYnpIeUpjVlZYU0Zpc0FqSmxYZ3Mv?=
 =?utf-8?B?YmYvMVVXV00rVDE4Z3l2WWJadEMxNUUrcE1RQngwSUJ2ZEpsOVhIU2lIWXUw?=
 =?utf-8?B?RmM2Vm9jbXEzSU94T2lTc1loejhpdkYzaEtLbFB1ckE4ak9sVGhYbGFmbnBr?=
 =?utf-8?B?Z09DU1JoZUNiWXkxOUNvUy90WWhMQlBWQzdnbHRPN2JrYk8yNUQxZFNaOGhL?=
 =?utf-8?B?VFByV1ZScHRZMksrdkRveVdwOE0yekZKcVZUcjBsMUNMY0ZHKy9jZENaNjd3?=
 =?utf-8?B?V2tBRlZpdEtzZkZZV2JFa05tNkpRRVZHak1selRlVHVxSmpzTzFPYXZQa2ZX?=
 =?utf-8?B?MU5ucDd5NFg2SFZQZDY3elBnUHByZ2IwaW8zOTM5ZU84WXFLdFdJY05jS3ZF?=
 =?utf-8?B?VldjUjBpSXIyUlFzOU5LTlFVaE1iUHdESmwzSDh2RkdZTktQNlRTUmJNSmJF?=
 =?utf-8?B?dXQ2SzVacnFSVmlPMmNKZVBxM1FoT3RHK0t5ZEZ2UnFKMFF5NFVWYlFuUTlZ?=
 =?utf-8?B?UHVHblFsRDZiYlcwMThqVndEemlaMlRGY256MTZKbXp5Q2lQSkdiWC9BbWZG?=
 =?utf-8?B?M1dvSWFpRDhvNXVGM0RsMUxPcHlvRVZadVhzQkU3V0E3aWhkbTJJUkFzQk9o?=
 =?utf-8?B?WFZEeW43VDM4STBHUFlBNTBsWDJpQTFacVN4ZjVCOXhLTVJPZVRvNmNPZTFq?=
 =?utf-8?B?Z0NNaWhRZTdhMkd5MDA3MEZFd0N5ano3eGczQjhiVHhpYXYxYU1qbHp1aDZJ?=
 =?utf-8?B?SFl0ZEdYQkpUcUtyWWw3V2VzcUJGTjRjcVphNTMzOVVCNjhlWjlkeTVXbmdl?=
 =?utf-8?B?VExmc2tlY290b2FyaC9pNVpiS2NlWkN0Tm5wVnh0ZGJYVk1DT3NyMXZLMXNY?=
 =?utf-8?B?bWNBcm9JMUFhSjZ0ZWZSTys2WGRDU2pZeThDZ01kcVVMZkZBQzZBNDdwSDVV?=
 =?utf-8?B?RXdKQTV5SENaMGFLdkZEQjZkMXczYlQvbWJ4N1BTZUZ1QkFzbitIUWlYRSt6?=
 =?utf-8?B?NmJ0NWk5TXVsZm4vcFVDVjdTUlJhMFlNQmNnaVI3M0V4aEk1Yi9Wamhwa01Q?=
 =?utf-8?B?bTcvQVVPVXI5SEZ5bC9uQmtCMWlDNVBGTGE5K2dyTHZaVFdtcmxoM3JDeUs4?=
 =?utf-8?Q?crP3gOuh8NnirUnKCAzX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22ffca8-8251-43e6-b101-08dd5a618963
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 14:41:52.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB10077

On 2025/3/1 01:23, Kumar Kartikeya Dwivedi wrote:
> On Fri, 28 Feb 2025 at 20:00, Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> On 2025/2/28 03:34, Alexei Starovoitov wrote:
>>> On Thu, Feb 27, 2025 at 1:55 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>>>
>>>> I have an idea, though not sure if it is helpful.
>>>>
>>>> (This idea is for the previous problem of holding references too long)
>>>>
>>>> My idea is to add a new KF_FLAG, like KF_ACQUIRE_EPHEMERAL, as a
>>>> special reference that can only be held for a short time.
>>>>
>>>> When a bpf program holds such a reference, the bpf program will not be
>>>> allowed to enter any new logic with uncertain runtime, such as bpf_loop
>>>> and the bpf open coded iterator.
>>>>
>>>> (If the bpf program is already in a loop, then no problem, as long as
>>>> the bpf program doesn't enter a new nested loop, since the bpf verifier
>>>> guarantees that references must be released in the loop body)
>>>>
>>>> In addition, such references can only be acquired and released between a
>>>> limited number of instructions, e.g., 300 instructions.
>>>
>>> Not much can be done with few instructions.
>>> Number of insns is a coarse indicator of time. If there are calls
>>> they can take a non-trivial amount of time.
>>
>> Yes, you are right, limiting the number of instructions is not
>> a good idea.
>>
>>> People didn't like CRIB as a concept. Holding a _regular_ file refcnt for
>>> the duration of the program is not a problem.
>>> Holding special files might be, since they're not supposed to be held.
>>> Like, is it safe to get_file() userfaultfd ? It needs in-depth
>>> analysis and your patch didn't provide any confidence that
>>> such analysis was done.
>>>
>>
>> I understand, I will try to analyze it in depth.
>>
>>> Speaking of more in-depth analysis of the problem.
>>> In the cover letter you mentioned bpf_throw and exceptions as
>>> one of the way to terminate the program, but there was another
>>> proposal:
>>> https://lpc.events/event/17/contributions/1610/
>>>
>>> aka accelerated execution or fast-execute.
>>> After the talk at LPC there were more discussions and follow ups.
>>>
>>> Roughly the idea is the following,
>>> during verification determine all kfuncs, helpers that
>>> can be "speed up" and replace them with faster alternatives.
>>> Like bpf_map_lookup_elem() can return NULL in the fast-execution version.
>>> All KF_ACQUIRE | KF_RET_NULL can return NULL to.
>>> bpf_loop() can end sooner.
>>> bpf_*_iter_next() can return NULL,
>>> etc
>>>
>>> Then at verification time create such a fast-execute
>>> version of the program with 1-1 mapping of IPs / instructions.
>>> When a prog needs to be cancelled replace return IP
>>> to IP in fast-execute version.
>>> Since all regs are the same, continuing in the fast-execute
>>> version will release all currently held resources
>>> and no need to have either run-time (like this patch set)
>>> or exception style (resource descriptor collection of resources)
>>> bookkeeping to release.
>>> The program itself is going to release whatever it acquired.
>>> bpf_throw does manual stack unwind right now.
>>> No need for that either. Fast-execute will return back
>>> all the way to the kernel hook via normal execution path.
>>>
>>> Instead of patching return IP in the stack,
>>> we can text_poke_bp() the code of the original bpf prog to
>>> jump to the fast-execute version at corresponding IP/insn.
>>>
>>> The key insight is that cancellation doesn't mean
>>> that the prog stops completely. It continues, but with
>>> an intent to finish as quickly as possible.
>>> In practice it might be faster to do that
>>> than walk your acquired hash table and call destructors.
>>>
>>> Another important bit is that control flow is unchanged.
>>> Introducing new edge in a graph is tricky and error prone.
>>>
>>> All details need to be figured out, but so far it looks
>>> to be the cleanest and least intrusive solution to program
>>> cancellation.
>>> Would you be interested in helping us design/implement it?
>>
>> This is an amazing idea.
>>
>> I am very interested in this.
>>
>> But I think we may not need a fast-execute version of the bpf program
>> with 1-1 mapping.
>>
>> Since we are going to modify the code of the bpf program through
>> text_poke_bp, we can directly modify all relevant CALL instructions in
>> the bpf program, just like the BPF runtime hook does.
> 
> Cloning the text allows you to not make the modifications globally
> visible, in case we want to support cancellations local to a CPU.
> So there is a material difference
> 
> You can argue for and against local/global cancellations, therefore it
> seems we should not bind early to one specific choice and keep options
> open.
> It is tied to how one views BPF program execution.
> Whether a single execution of the program constitutes an isolated
> invocation, or whether all invocations in parallel should be affected
> due to a cancellation event.
> The answer may lie in how the cancellation was triggered.
> 
> Here's an anecdote:
> At least when I was (or am) using this, and when I have assertions in
> the program (to prove some verification property, some runtime
> condition, or simply for my program logic), it was better if the
> cancellation was local (and triggered synchronously on a throw). In
> comparison, when I did cancellations on page faults into arena/heap
> loads, the program is clearly broken, so it seemed better to rip it
> out (but in my case I still chose to do that as a separate step, to
> not mess with parallel invocations of the program that may still be
> functioning correctly).
> 
> Unlike user space which has a clear boundary against the kernel, BPF
> programs have side effects and can influence the kernel's control
> flow, so "crashing" them has a semantic implication for the kernel.
> 

Thanks for your reply.

Yes, I agree, we should keep the options open.

I simply thought before that if a bpf program meets the conditions for
cancellation, then we can assume that it is a potentially "malicious"
bpf program and may be cancelled again in the future. So we should just
rip it out of the kernel as a whole, like an immune system.

But I ignored the assertion case before and this should be considered.

If we do not modify the bpf program code (which is globally visible), it
seems that the feasible solution comes back to modifying the return
address in the runtime stack of the bpf program, since only the stack is
not shared. I am not sure, but accurately modifying the stack of a
running bpf program seems not easy to implement?

>>
>> For example, when we need to cancel the execution of a bpf program,
>> we can "live patch" the bpf program and replace the target address
>> in all CALL instructions that call KF_ACQUIRE and bpf_*_iter_next()
>> with the address of a stub function that always returns NULL.
>>
>> During the JIT process, we can record the locations of all CALL
>> instructions that may potentially be "live patched".
>>
>> This seems not difficult to do. The location (ip) of the CALL
>> instruction can be obtained by image + addrs[i - 1].
>>
>> BPF_CALL ip = ffffffffc00195f1, kfunc name = bpf_task_from_pid
>> bpf_task_from_pid return address = ffffffffc00195f6
>>
>> I did a simple experiment to verify the feasibility of this method.
>> In the above results, the return address of bpf_task_from_pid is
>> the location after the CALL instruction (ip), which means that the
>> ip recorded during the JIT process is correct.
>>
>> After I complete a full proof of concept, I will send out the patch
>> series and let's see what happens.
> 
> We should also think about whether removing the exceptions support makes sense.
> Since it's not complete upstream (in terms of releasing held resources), it
> hasn't found much use (except whatever I tried to use it for).
> There would be some exotic use cases (like using it to prove to the
> verifier some precondition on some kernel resource), but that wouldn't
> be a justification to keep it around.
> 
> One of the original use cases was asserting that a map return value is not NULL.
> The most pressing case is already solved by making the verifier
> smarter for array maps.
> 
> As such there may not be much value, so it might be better to just
> drop that code altogether and simplify the verifier if this approach
> seems viable and lands.
> Since it's all exposed through kfuncs, there's no UAPI constraint.
> 

In my opinion, even if we have a watchdog, BPF exceptions still serves a
different purpose.

The purpose of the watchdog is to force the cancellation of the
execution of an out-of-control bpf program, whereas the purpose of the
BPF exception is for the bpf program to proactively choose to cancel
the execution itself.

For example when a bpf program realizes that something is not right,
that a fatal error has been detected, and that there may be a
significant risk in continuing execution, then it can choose to
proactively and immediately cancel its own execution.

 From this perspective, BPF exceptions are more of a panic() mechanism
for bpf programs than exceptions in other programming languages.

So I think the key to whether BPF exceptions are valuable is whether we
think that exceptions may occur during the execution of a bpf program?
And do we think that it is the responsibility of the bpf program
developer to handle these exceptions (e.g., ensuring runtime correctness
via assertions)?

This seems to be a controversial topic because we seem to keep assuming
that bpf programs are safe.

> 
>>
>> But it may take some time as I am busy with my university
>> stuff recently.


