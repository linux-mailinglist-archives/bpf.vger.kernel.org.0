Return-Path: <bpf+bounces-52893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1877A4A252
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F237E173DAF
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C9F1C3C0D;
	Fri, 28 Feb 2025 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TeuXQ2y3"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2030.outbound.protection.outlook.com [40.92.90.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B031C5D75;
	Fri, 28 Feb 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769224; cv=fail; b=bk8XT/o88PZjhNdUpcRBkmXdsEA6jApRIDflASa1cVP7rF3dspKmc1mQERql+Jqwa2+uMJ28kIoZsCBC0myY52NqUsboPX95kCZqkCuB9lmNA5Jq/w4HtIESD+Qpv9QX975MUV3vSekLxhUeri4TRAxZSk4nJ9KvcQuyuhBQOQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769224; c=relaxed/simple;
	bh=xNBEmOgJfLSqoolxeuF6utWEKk04V3XCz61Bf2tLcGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EVeePBKVE47DicWTA7KzaY2/AMW9wGlhEi3v/w+IrllrH4A6saMBxQ7tsQWXu6DcH3kSE6/owryb7UHnSZQTzQWtuSYgKhc13riCv57QYq71W76xk42aLr0Sxl7P3u1VCB3y2v3OnvT1ev7p2QV11NcClSHNecZBZ4cQmkPRS0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TeuXQ2y3; arc=fail smtp.client-ip=40.92.90.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2Ooo0RAZrvuDGxvT9dE0AmVShErHmzIMBscCb0M+Xv339SvTO//aTGt4T7/YUEQ67bobLwuNmvgH1EhNyaBVd0xP7TtlcZ8Wk/0xfYg/bbCjwRVVKNhGADf5NLau82hE6h4EandWAiHtsLoBwG1j2AyjoRya5Iv8q1U7UNhpFOdLWbAk8EA8g9U82Y5W2UMAPZUauR4x0Qrgy2FEQqotz0cXcSO+ZUhEeUWeMj/Y4XWaHsBezKkdFIJs9cDwDDkt9Wdq3QA4bQvcwJRAe7eQp+25AS5Jp7WsSZtCfD+O7vPNUAzwNO8OkmHLzviNMozc1AzPdbATDN86g/tcP8PUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4asI1TavBy1WlKryfbxvgfbIDZ7BuWIVm+7XchR4Go=;
 b=ww6L2GABgd3TwgF5G6OL0CmnvbCc2EKfKm65PSIjJXEM5L5glBkWOY0YX3N4MVWzEdBrlwPJNjYk5PPBpCIpx6xW+qKf5eUj59cFJrtd7370ZbcXGrce7d6abEefGrwmnfQMZltzJQ850b3EsZ/hPR+05ZHBEIhF+V6XyFcYhu8G2WZTcn0QOyUwUF86HajI9+VM8s01EDjjZFQM1bh9PgmB1OpJ9cowZZ9aOQ7TzknYbfZPxbXFlTmlwq0APXGWWfrJM4GU+L11MMPvjbV1ZjbTK+nAm66guDFBOtZPmEzL26tV6hXFm+rAY9OCPKmk7D1BZ5HWEl9qKkkSPIzf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4asI1TavBy1WlKryfbxvgfbIDZ7BuWIVm+7XchR4Go=;
 b=TeuXQ2y3tjPjLDvVzxgfpGQjtkfupL8oQ56nyGQu4E1cR/P2MA2BIh2M44Qq6paXvQoQEoA79+fJLsXQ4+eO7MBitqOuFjY2XRsqEuaVaKI2J6Mo3z3gqByuougKCNnZrANQDioHInSjdEfvDg+4ifmt2DDUT00oXgWTfbm41M1vXo38tpk5m0VViok+Li3j6XyNPJtSuEmgERVeP+ZY2k6dQJBsxOll7h5Nh2XaumfgqdYehDEZGMNMDKsoI8tyjJL50hv9S1bl1Jn7SIaTPDC/GlLJ8nkggoJPvc8z3cxrH2LD3OcFB576dd44s4NP8fMUWzvwtMAnP5ieLmyb2w==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB7811.eurprd03.prod.outlook.com (2603:10a6:10:2c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 28 Feb
 2025 19:00:15 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 19:00:15 +0000
Message-ID:
 <AM6PR03MB5080FC54F845102C913B596599CC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 28 Feb 2025 18:59:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 4/6] bpf: Add bpf runtime hooks for tracking
 runtime acquire/release
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLR0=L7xwh1SpDfcxRUhVE18k_L8g3Kx+Ykidt7f+=UhQ@mail.gmail.com>
 <AM6PR03MB50802FB7A70353605235806E99C32@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+TzLc=Z_Rp-UC6s9gg5hB1byd_w7oT807z44NuKC_TxA@mail.gmail.com>
 <AM6PR03MB508026B637117BD9E13C2F9299CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+cokog6j5RjO7qNwBWswXTbu-x2j4EoQEt405-2i5jXw@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQ+cokog6j5RjO7qNwBWswXTbu-x2j4EoQEt405-2i5jXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <7c63e9db-003b-4939-bbae-bfcd90f0a316@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: cf28b4bf-dece-4fd5-8570-08dd582a2259
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZkOVoj0UqpnLtxcZHTVbEDrWvEi/zPYMyK5FIUvu1zGLO2h87XxBtvHvdylygqg1r9jeGZ8Rugr+EKyYo70+Psr2p3n/xLP5oneThpWbF491ubWBKO1eCYOcPbeczSlIDa8YbA7iKFSZnDVf1DsuPspdm4DXTVOPpSUwv8QS8v3+5sKwI/rftg8how7Yt3gOe4Fp9F72UfQhP0zrHF/14nXbcvDkZjuTStOEn0nhblQ8g0tmf2PFWoLMBLxh7w3K67x9LaBmZ07ECGkgB9Bw3wedgXxSgfRIphn/yGLCjwaWRCJzE7LSytm8lbaNcA7qgv40OX55rrSDP5O8Nd66ZMnC1/y+/6kX3+Sxxo+WCHKBm7jO93auPsmq9b7S3unuIUucK5SptHNeK/A4zyeISuTpSKITm3VuNBN9JA44GI78KYMUmXQK5JCIVW14XM5JyOY6sjEnbwbeUZX0AzpEi3m6r+h/+ZCSSu7pGUleBR2t6HCwEbwP+4PkrEcb20Pt4XF3B3OfYK8p+nuE8VNonvA7QVKw6WfopS95BYAGiaTA681OFg5yYFSvzV+dxgdr+TI5f5hII0R91PDjCFfZAev8aKVDSaUmZ6Sj7QnNpvHaJoPQIYt2Gc/o/9ZmCLKmATniARczeSx8GULnhPfPdjpCdW36yH/Rl/Vznyx3ySNsMwDYKEctbz8GCN+ra901XujLaIsZo6I8oozk61sD8uxZs+sBHFmYnEzDD7f4l7SOPuzNjq0gILZln2HvkInUT8mqlo4eHrjMG05mKBks+JNwulXG3CCiezrP2snBbZ+No46TqDXzoqF
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|15080799006|8060799006|461199028|5072599009|13041999003|3412199025|440099028|10035399004|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEQxOEtydk9jUTE3ZGhKNXFZai9qTC9haXJvaG9hRGgxeGg5UWs2QnlSWm5N?=
 =?utf-8?B?VVhUNS9lQ2NkcDNjL2ltZGZmVmVrSnNWUzJoa29uSE1pNEMyd1FBWExZeGcz?=
 =?utf-8?B?K1Y0b2dDLzlXV0NveENzZzlvQVV3MXNTTG1GdDhKMVdaenpuYzlMc0J5Ly9R?=
 =?utf-8?B?dGo0UE1jdWthQk9xUEsycUI4Y0dSeGNVUmNzTVhtUCt4QVVZdVk5R2J4SnRT?=
 =?utf-8?B?YVVnSTh0MGpmbEFUN1dYVXFHUS82M0FTSHgxbzNaZi9DUWFqWVE3NVpOUGtE?=
 =?utf-8?B?VHppMDUwQVFwM2ROODh0aHpEOU9IUE8wMWpDbHJmb3dMcGRYSzJiZXdlcXkr?=
 =?utf-8?B?Rm1tWHArQUpaVkxkNnZORHcxUjY5a1AwZExHcWRVcEtuZ3JjUTJJTGZZamkz?=
 =?utf-8?B?VDY0cVRKdHdneHdnbnBOc01teHBhSFdmSmRFcmJLT2k5S3VDNGdadUV3UmRE?=
 =?utf-8?B?cHhuVW9TbUltaDdiVHhmb2RzbHVEUW92aUhpeHNaNnQyNEdiTUVGNTZ3ZlB6?=
 =?utf-8?B?ZmdhTDNyYUtWakc5ZFVsWkFtS2FuWkFMZDRXeW5IdU8razdJSFo0UDdsWkF4?=
 =?utf-8?B?bWpNLzAyRWlOczZ5MVQxeWJ0eXN5NEtTUXdXZE8vU3l3d0NxeEptTXI0YXZQ?=
 =?utf-8?B?K0pzd3pSdWwxK0ovMGVVelpTWk9lSnU0NlF5UGl4emVCdFg2M2JWQTk4TUVh?=
 =?utf-8?B?dW1yWHFONjUxSkFTUUpCZnhHR2V1enFNSGJjM0dPUGFlRXlRcHVCWHVLUXRa?=
 =?utf-8?B?R1A0eXZ4OEJkYnE4N0M2RUV4L1cvYllSVXBTWUR0clVOOUQ5d2daWUJaK3Fk?=
 =?utf-8?B?TEVLL3I5Zm9nL0llTmJsdnRrSTRvK1dWUVNQL2o3L3kvYUJhSlh3RTJYZThz?=
 =?utf-8?B?N0FJWDV0eW05NXZYQktsdGpacmJYZ1JkY01nMmdTNmp1ZDEzTDJHTW9YTTU4?=
 =?utf-8?B?a1hDdklvenNCcW9FR3dPYmJFZWhSVUZsdytVWWZYblRYUzhaK0pnUy9yeXMr?=
 =?utf-8?B?N2l0VWdrMEtiUE16dm5CTGNaOXJmZUxINXhFclFkUTZxT1B0c1Qrd3pjVkdw?=
 =?utf-8?B?US9CajBnd1BmMGxpVTlTd1FXMHRkd3hRVWQzcisyc3AybzY4RzQ5ZURiTzln?=
 =?utf-8?B?U2pyQ01DM1BCUGlmNEQrVDZ2Ni95SG81NG42eFIySjYxZVd2dzJJL1RoQSs0?=
 =?utf-8?B?bCtURDI5QmhDQlhMdkVFS1RvdVVyZnNWbGJCTndZVXFpN1IrZURSaFZPTkhD?=
 =?utf-8?B?U2JtUkswVnpHQjdxRVY4SllyWkNWcFZpcjI1WkdGMjNVcFNEUy8zaW81ZitY?=
 =?utf-8?B?QTFLYzZ2eGFuWkNvMkx0dUE1elFGWk9xZGE2ajN2VWVpc0FEZWpDK21Zb01Z?=
 =?utf-8?B?ZHpvMzRObXNNa1pucWxERWFoejFqcnNrTnBsSEZaRDUzazhvdTNkWjBqN09E?=
 =?utf-8?B?Q2RkNzkzTUE0SGJ2YWlJcU5ZVzY4VXpEaFpyY011NkhIejZ6dStxTDRlRGdE?=
 =?utf-8?B?TlhKK0hFY3o5MHpWY3RGYUREQ0cwRWlJcUN1U3VlNkZJRE50NW5pbHA2YkVQ?=
 =?utf-8?Q?aAyUtKk8NytYkZ4r4mB2TyM3TH032ceAwlssbHQTGkkd/E?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWgwZkdpV1ZiSTdpZWR5K3hZdUdWci9ya3Q5clEwZ2c4QXI5VnorUTQ1RFZ4?=
 =?utf-8?B?SDNqZTkxejcraTFQcFl2WWxOTTl3NWpLNFVLTHltT29paUdDLzQ1SVRVcjM0?=
 =?utf-8?B?eFgwNTNCempnR1VHc2hkdkg0ck5oTkhienc1L2h2TlZMMUJCd1RCc0c2dUd5?=
 =?utf-8?B?cWMrdlc2T2dGQ2dNakF6RHd3U29UVDhDc3lSeEhOTmI3UXB5MzNhNHpvd2N2?=
 =?utf-8?B?anEvTER5TVo2M0toNHppSDBtaWJ4YklMaWRkZW84WUJvK05vSEdWY2VhVFN1?=
 =?utf-8?B?bzFTZ0NRWUM0ZVlFQlEzOENvNHphZjE3YytnaUNYNjZ3TENNdFpMa1FyTGR0?=
 =?utf-8?B?NEJlYW9NQkY1NW56SHRjMkduZFk0b0lvcFFMVWdieXJCaWpWdXFHTWQyUUk2?=
 =?utf-8?B?V2oySktJT1lZRnVNd0orWVZESkYwcTNRTE45aHhGNnI1RXJGY0RoYVZMRy9I?=
 =?utf-8?B?eXA5KzRvVVB6eTFFN1RDbytFdmFncXYvOUR5ekRSMDNWajBSc3BCR3lzdXl4?=
 =?utf-8?B?OFR5cm5WRllTTWNtbnpYUWdVU00vOXJhN2o5YzltKzN5c1IyWjBDcU9zU2xK?=
 =?utf-8?B?Yy96dWRuaktDdnlsNy95Qk1LTFBqdFpyWkpSaENiR1lpNkt0YUs1MVBHbnNz?=
 =?utf-8?B?VVVxWWZ5L2VXU2RKcXR0bmhZWWhveERqektpNk12SWZQQnhsMVpWZy9JSFNw?=
 =?utf-8?B?ejJxWmJrNVE5dUE3d2VlR2szVTYwazE1ZHBmOVBsOVFCWkxncFlvT21Sb0hV?=
 =?utf-8?B?RFNBTUJDV2xzSklyMnBEOWJYSW4wbWhNbGtxcjJWa0tkbjFLcGMxdHZTYnpW?=
 =?utf-8?B?RXA5Uk9vUWwxZkpza0M5Q3cxRCs3b3IrZGY2Qkd1OXR3YXlTTGN2ZGxiNDFY?=
 =?utf-8?B?R0hPbnFjc3M0eUZCekpOMkFCcHJwdHgzZEZMWjB0NG1VUWhUYmtGSVRHanlI?=
 =?utf-8?B?QVJkOEtRME0zQll5bmJOaVk0dDYzQmY2UHp4ZUtiTVhLNnBJVDRsVEZndUcz?=
 =?utf-8?B?eVdaY3M3bVA4anNYY2d5NWs4T0ZrUE1ZZUFLOWhKaG91RllEZytxMUJhWE9L?=
 =?utf-8?B?dmduOHdpTVpETG95SjF2VVcxY2FSMUNUOHA2b3ppQWpBeWZ6ZkdBeHVic3V2?=
 =?utf-8?B?WmhnNGJPVWFxbm4wcVpJcXE4Y1grM1VQSzZjemhMeVdYSUc3eGhxU3pnODYw?=
 =?utf-8?B?ZHRFVElSSE5QM2ZpTk1lcTMrcWkxRE4rYWYzYktBbHlrbGVWeS90QXFnMUtD?=
 =?utf-8?B?SnAxTVY0ay9iZWxRT2Rha0F3d1BSbFZZM0c2R0k1V2V5dFd5ejBxZ3ZXbEtI?=
 =?utf-8?B?ZWV0aFZhWXJDa3hFUWJ1MXBrQkhXeDROOWNiQis4dlNxSXFxTnZPU1dINndw?=
 =?utf-8?B?WjhISm13ODRBRDNjUnE2aVJEaUY5d2ppOERZT09neEJ6ck1YN3IyR1VaQVpq?=
 =?utf-8?B?ZXZxVmh2VVowaUF4V0RDcFRRSVZjYVd4U1NQM1E2Y3Vzcjc1dEdIaXdDSTA0?=
 =?utf-8?B?MW1WbHltQmhHRmF4YnN1MmZLVU5SK0tvSXFzVW01L0NPTFZkbzBFMDNXUEdw?=
 =?utf-8?B?QitMRWRBVHNzcnVPWDJDbnRFV24vRUVydXA2bVNjUFJOVkZVK0ovRnVHKzdY?=
 =?utf-8?B?V280MHBwUXVUTkw1NlVMSmduM3Y0eWVNOGttOTlhbVBkTGNzZ3QyN0pjd1pL?=
 =?utf-8?Q?Unwgt0h34YUpKMEad39q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf28b4bf-dece-4fd5-8570-08dd582a2259
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:00:15.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7811

On 2025/2/28 03:34, Alexei Starovoitov wrote:
> On Thu, Feb 27, 2025 at 1:55 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> I have an idea, though not sure if it is helpful.
>>
>> (This idea is for the previous problem of holding references too long)
>>
>> My idea is to add a new KF_FLAG, like KF_ACQUIRE_EPHEMERAL, as a
>> special reference that can only be held for a short time.
>>
>> When a bpf program holds such a reference, the bpf program will not be
>> allowed to enter any new logic with uncertain runtime, such as bpf_loop
>> and the bpf open coded iterator.
>>
>> (If the bpf program is already in a loop, then no problem, as long as
>> the bpf program doesn't enter a new nested loop, since the bpf verifier
>> guarantees that references must be released in the loop body)
>>
>> In addition, such references can only be acquired and released between a
>> limited number of instructions, e.g., 300 instructions.
> 
> Not much can be done with few instructions.
> Number of insns is a coarse indicator of time. If there are calls
> they can take a non-trivial amount of time.

Yes, you are right, limiting the number of instructions is not
a good idea.

> People didn't like CRIB as a concept. Holding a _regular_ file refcnt for
> the duration of the program is not a problem.
> Holding special files might be, since they're not supposed to be held.
> Like, is it safe to get_file() userfaultfd ? It needs in-depth
> analysis and your patch didn't provide any confidence that
> such analysis was done.
> 

I understand, I will try to analyze it in depth.

> Speaking of more in-depth analysis of the problem.
> In the cover letter you mentioned bpf_throw and exceptions as
> one of the way to terminate the program, but there was another
> proposal:
> https://lpc.events/event/17/contributions/1610/
> 
> aka accelerated execution or fast-execute.
> After the talk at LPC there were more discussions and follow ups.
> 
> Roughly the idea is the following,
> during verification determine all kfuncs, helpers that
> can be "speed up" and replace them with faster alternatives.
> Like bpf_map_lookup_elem() can return NULL in the fast-execution version.
> All KF_ACQUIRE | KF_RET_NULL can return NULL to.
> bpf_loop() can end sooner.
> bpf_*_iter_next() can return NULL,
> etc
> 
> Then at verification time create such a fast-execute
> version of the program with 1-1 mapping of IPs / instructions.
> When a prog needs to be cancelled replace return IP
> to IP in fast-execute version.
> Since all regs are the same, continuing in the fast-execute
> version will release all currently held resources
> and no need to have either run-time (like this patch set)
> or exception style (resource descriptor collection of resources)
> bookkeeping to release.
> The program itself is going to release whatever it acquired.
> bpf_throw does manual stack unwind right now.
> No need for that either. Fast-execute will return back
> all the way to the kernel hook via normal execution path.
> 
> Instead of patching return IP in the stack,
> we can text_poke_bp() the code of the original bpf prog to
> jump to the fast-execute version at corresponding IP/insn.
> 
> The key insight is that cancellation doesn't mean
> that the prog stops completely. It continues, but with
> an intent to finish as quickly as possible.
> In practice it might be faster to do that
> than walk your acquired hash table and call destructors.
> 
> Another important bit is that control flow is unchanged.
> Introducing new edge in a graph is tricky and error prone.
> 
> All details need to be figured out, but so far it looks
> to be the cleanest and least intrusive solution to program
> cancellation.
> Would you be interested in helping us design/implement it?

This is an amazing idea.

I am very interested in this.

But I think we may not need a fast-execute version of the bpf program
with 1-1 mapping.

Since we are going to modify the code of the bpf program through
text_poke_bp, we can directly modify all relevant CALL instructions in
the bpf program, just like the BPF runtime hook does.

For example, when we need to cancel the execution of a bpf program,
we can "live patch" the bpf program and replace the target address
in all CALL instructions that call KF_ACQUIRE and bpf_*_iter_next()
with the address of a stub function that always returns NULL.

During the JIT process, we can record the locations of all CALL
instructions that may potentially be "live patched".

This seems not difficult to do. The location (ip) of the CALL
instruction can be obtained by image + addrs[i - 1].

BPF_CALL ip = ffffffffc00195f1, kfunc name = bpf_task_from_pid
bpf_task_from_pid return address = ffffffffc00195f6

I did a simple experiment to verify the feasibility of this method.
In the above results, the return address of bpf_task_from_pid is
the location after the CALL instruction (ip), which means that the
ip recorded during the JIT process is correct.

After I complete a full proof of concept, I will send out the patch
series and let's see what happens.

But it may take some time as I am busy with my university
stuff recently.

