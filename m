Return-Path: <bpf+bounces-51606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4BBA3671E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF6B1891F6F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D791C861E;
	Fri, 14 Feb 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="COy3PrKs"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazolkn19012049.outbound.protection.outlook.com [52.103.33.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333D18BBBB;
	Fri, 14 Feb 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566429; cv=fail; b=H7PsXSG77RdacU+LNNYFY1fiPR42vEEWVTWjSbHuS9JCmjINYkkeqfYfxoqzY1bjezvNTAGFdu9kqNF6tHJWVaz+QTNmDFywh6CD6TL5UABPOMicJXRVMlNHqzo/x7drtglzhHHOUe5cCA+jwey1rO5cG8PSKY5Lk28yreK/3xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566429; c=relaxed/simple;
	bh=AGRi9xE58I5N0LrhozTlsSNnOvMlVg5+87tjt+C139U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HcAmNgZQ6ZjCdIkOSnxZ1l4Gn+NSdQs3FBGo6+1LNEEFE1JMnH58JwzgI4wzNjmvUlHdsxGilDS6x23YrZvhq8/m2euVRIEwiVVPLAmUhlD6+kbV6OtzwNyyVW3iRtv3Si5raqEIZkvYDxuBye1eB7/Ir3mBBevyZAd/FEnsVnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=COy3PrKs; arc=fail smtp.client-ip=52.103.33.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUK7+ueQp2d05rcrNnLcig8y0SBNbV/CZtEthPNI2m7jeT64ncs2ZVj1Fg4yyCHR22xiERbYi9mfNrZV+k3v/KjW9y2CKwLyVHhenTaU2ZaUX7iuZDhT4GtzRfrgxARznl01Ttde9iSRZdrKgMwpdnKqgHZdOxsyuPLTIk9JBwVUfF9rd4fmx+NzEv29FErq2EskSWdk5Os8BxxW7/WgIQwuGsE9NQNnXht/p1CyuurD6bqVOhB1YrmEMfVxDEN0MmrEcdyeKzob5eahCVEhKy5dyrctuNM8cv0S16jwzC37eFabHGH1m477zwIxuwiwNBPe//4n64ALVpV1Nafbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a9h0f8euAZwiXn+qvEj9wiaS2Lx0bF8HhllgpVFVDw=;
 b=RA+ILKTfFqXERh9FT8O5GhLQq9wh+utHEOb/3oINA/xTQ711Rg6/9+IosXufmR7qeZ8adU/jGSu1CpacxKEps2h501Ld7lMhcq7HNrovj4VnMt4JOastr5GKqfHId7I3xUqhf4AvuJhv6Ge7O2HaGKsY8LhyFwtRFcDmfTYBvtdbixJ0bSfOkOatW3UciKeaoeJDemmveyTmnWQ/SuD7bEakAWTEOkIq3HWO843xZ2SqD4JawT7Vg/VO2wT4WmyV+hM5UJa5odVFzXl/WmGDwQ1CDdDPBm4n5QycGHFwZreOK0P8p+gr3cu6cjYzW9T3oSWRfHXY+iJQBA5wDyDB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a9h0f8euAZwiXn+qvEj9wiaS2Lx0bF8HhllgpVFVDw=;
 b=COy3PrKseKtnydo6PXBwvdjGm81/UmV1sa1TxyAN52y7hjkuIWXxnGmybHvLb2BdOi3SXbDFEBFgwYIl8yjlcZn6r0A1M3QuiyLgVsSOOleIiGj02HAmkEZKXM/ZR75NtJlinkQWGJsl2XO+mOyxEIX2DzNy7mNj7GHFf4k7AxCvdpqV3BU/wc8e0sVf8tQ6fRPNq7BBBjmuq9dM+AgsZdyf9AEHmaad4GvhlbomgKnQCxoL8bJDkY8Ie2e/z4ihac0G7Uy3fVOtOjI0HmdOy/qTeokmpRfOa/eVdIe1NDqiWdVS+scuO0yIZ39bBqUNOBEyLRJcuAePCOCkowS3eQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB9984.eurprd03.prod.outlook.com (2603:10a6:20b:630::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:53:44 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:53:44 +0000
Message-ID:
 <AM6PR03MB5080F92AACF93F40872F53AB99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 14 Feb 2025 20:53:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bpf: Rethinking BPF safety, BPF open-coded iterators, and
 possible improvements (runtime protection)
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
 Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5080392CC36DB66E8EA202DE99F42@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLb--LzFmXZPLPa5V+cD1A9YzTnZSgno9ftcA4-GGTi8w@mail.gmail.com>
 <AM6PR03MB508011599420DB53480E8BF799F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+7RvuGsbnpeyMrZPKypKeUSULx42Gvmc9J_gnnkPffdA@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQ+7RvuGsbnpeyMrZPKypKeUSULx42Gvmc9J_gnnkPffdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::20) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <f08652b8-0e0f-4301-84f8-06e37b307127@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB9984:EE_
X-MS-Office365-Filtering-Correlation-Id: 6306652c-e6c0-46f0-7d5d-08dd4d39ab54
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZkOVoj0UqpnLtxcZHTVbEDrUrjpEzFgGUScka6neGodRpwvcufpqD/8HGhCgfcdInzEqyqptH2/FuQHowe00xd8yo15z4GIfZWRiHjfwW/MxwOjwDgzolT+c9hz8ZQqsRRoDs2FvlDQffUPK3fJc6NKWHiZ5iEU77CqqqOq1k4koUTVhOJ+BCQuUDIc2DzAf2B0aXRGH3F0B0UHqgM83zkXMBT3aqjCHGgkVsph9AOrcaQyqv15+GO4D6e81jTs44OcY4LYHeEVH3Y6D7DxUHgtVCm1n1VRp8FSa6EVL7wq/nmyFxfV1VzvpG95bogyxJuggPyu96arVpm5bzjyAMSsXgQR39PWIYtsmqPMIBjsXNCFguWiIMWzRRS9A86GhXBdCXiZ4pKd0bnbt9cDMEbYIPfJDLY+mTTd0qUaTFsBfUzkLL2PnNWv9097nTUPownMxLq9qfdJ5yKnQ0nkfhnl1dAD/hq2fGpp5TOCtiEL0al7r2CrC966CR85IsnGKsxemH+CunYX4lRVmqGp0kvURKOGhzq1NEUNQM4TfmZFHVqsmeW6b0Y44ThPg9cbPOWy2zZBfK802D+who1ouaONJWexVHfR49nmoSBBMtRDUCBN/PoyZ5mNkEw7T1g4KQf9sc3dOO7L1Cmf5X6Zsmar68QGETgAqcakr98hqAon1nMBq5WRIiqkqLwpqPqdx677jiz389RB2pXJcIm3dPQEteKPa3x08eNS1gDmFOyR1e0M7KvmR/iWt67Qg5zDMHV6vk5BRrDTm4pHfkp4r0j6tyksoZoWgvKu4EKnQI6oygvri/V7WG7e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|8060799006|19110799003|15080799006|461199028|3412199025|4302099013|440099028|10035399004|41001999003|12091999003|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1RRRnd0bERjSGQ4UVgvWTljWko2RUdFRk1PeG15Q1RNYXVjYU5mNENJL2tF?=
 =?utf-8?B?VkswQVRGYkRQMUNFbnVKSDV1QlNSbWdzUEppZ2JGR2JuN3RLeTM1RUNFZnE4?=
 =?utf-8?B?cGZ1d1lINVp5VDc2UkVCbnIvUEtmNFVVazEvNEdlOGpNUGRJcHdmL09xTGZx?=
 =?utf-8?B?TWU2LzRST0Y0ZkJLdEt5KzM1MXYzOXhvZWJUbERrY3RDdXF1ajBZbUNFVmlB?=
 =?utf-8?B?b0hFcUJtdHRiQzZaMG81N3FmRXJxRmJENXhoNUFPZXBPSDdvU05TWDJ0ZEcr?=
 =?utf-8?B?TG0rYldQWUltQkRWQmh1eCtCMDlLYjhxL0Vyd1RRdFd3UlNNbGU3T2lNak1n?=
 =?utf-8?B?cHA1c215YnVjbkt6clk0RjJRSWxxVXhKUnFKYmIyZWpZOXh5RDZlZ2VnNzhl?=
 =?utf-8?B?aStWU3ZLQktxM2FYUjBQWE55SmtRdCtTbjlCdVRxUmlMZVRVaklISEwvNXVh?=
 =?utf-8?B?RWVRTzd6QkxGTUQ3YjFqSXJXUy81eUJNdE93OGJ2QXhRbytKN0JjZXRwRFNW?=
 =?utf-8?B?Z3hrNDhMMW9zbGVqRUNmYkZSYkw2SEpPMTVMZEw5L3orSjlsS0pmYW5aSEJE?=
 =?utf-8?B?elcycUsxNm5OMkFiQjZwUEsvMldmcklNbytrSTJVY1d4TTAwVjQxa2d1blN2?=
 =?utf-8?B?Q2prVTdYb0JOZGpqNWM1eXBDSTRmeTdIT2IwbGpJeUpmNE9LdUpjaEgzMFlU?=
 =?utf-8?B?NlpMa2dJa2VGQ0VyWm1EUWVQaGRsZ2RlbVJ5ZGU0Q3FKc0taUDU5RGFkWEhz?=
 =?utf-8?B?NXI2cjZ3STZkMldYaWl3T05aNFlYVVB4MEJFam5OVE90dkpwL3dwRTlqUUU2?=
 =?utf-8?B?ak9WOU90aE81RGxxZlZ0Rk9LcHI1c3p0bEtLSHhrUHpTZ3NQMkpudThhRGZK?=
 =?utf-8?B?MzltRy9xUVRoUXFlSlI2Y21PYkVWWk5McmpjWndtYWN4VTBRZzBic3pOak5h?=
 =?utf-8?B?L3crV1poU1pkblZxbTBPQUVNZFlENFhsVndKaEhXWHVZK1VMN01IVzREZTBL?=
 =?utf-8?B?dXlRQUZ3T3RpSTBpWDgxRWk0bG1Pa1B1VUdIdmo0MWV0RzdpRkw0QkQxS0hj?=
 =?utf-8?B?UnNzbkdNWm5ONkVZaW9FUVdpSmlnWEpReUhUdlV1VnpUZTYwT2kwQkxKYzIw?=
 =?utf-8?B?ajF6R21OVDF1dzNsSVg2WWQ5TTVHYVEvOWFNUUZHZFdJdEhMNTRIcHpCVzZn?=
 =?utf-8?B?aW1TK0E1KzllWGVSdUh2eWx2ZGhvYjRoQVdpL0x6WkdtWkVad1paMTlmU3h4?=
 =?utf-8?B?M0lMN2xvdHdxWWRQRDNRSmFLSWxmSmlQQ3BBQnI5ZCs5MGZLQ25FWFRuUUZK?=
 =?utf-8?B?SU5McTdVcTdaQW5ENFVqTXVTSldDYmYwNzNrcnRoQ2RpN2FhMzlHUlhQTjJB?=
 =?utf-8?B?VFY2VFRKNmNiMW5tdmd6ejhWOFF2SXFhY0djV1o1cFhxTVBBbGRrYlRxR3hw?=
 =?utf-8?B?UDZDRjFhZ2QveTkyVU9wTjhxdDlmYmM4TUNTOTZRSjc5dGJ5NmdtUlJiRDBk?=
 =?utf-8?B?SXI3eThFbjQrcVhsRzZ6bnU4SlhLVWRoZEcrMXVqWnZWVDFYY1RFNjdmeWtX?=
 =?utf-8?B?dnM1OTNvVE85NHNIN2t1eU0ybVAvNlV6ZVNSQWQ5bGdKOHZuWmhlL2hwSlJG?=
 =?utf-8?B?RXB0KzQ5WHdzVE1hZ0toVzhwM015NUZUOWN0VE05b3JOZzNxRUpEdnZIZFdY?=
 =?utf-8?B?WGhUeGdkN0grZUhzYUJ6YitGNlVXU0d5M3NWSzhIbzZza2lRZTNVeG5RPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHhONEx0eXV5V3hJV29yM2FsVFlaS2REY0pHNnNvcW9ZeWFDV3Zma3J6cFZF?=
 =?utf-8?B?UTVnb1M3VFV3b2pYQmtteC9yK21RWGtYSXJ1RFFyMUVnRGVGYzlqTXZ6UWcy?=
 =?utf-8?B?UFpvcVUzampSdGkxdHJqdkUzcTNsVWRQWHl6eXJzV3dTdjZCeWJ2b2hHVnFM?=
 =?utf-8?B?aEUvL1FOdXl0cEpYYkhWNzkrNTMxN1U0VURTb0MyYno5Y2YrTXc0WFdVeWRF?=
 =?utf-8?B?cGdmTGxZZ3B1ZDNHWFFQMmI1eVVSM0V4OTBLSkl0SjZrS3JheXRXc0M4aVFw?=
 =?utf-8?B?aDBQZU1ObWF1N1d4M3MzT0Fmc0pRaVdueVVJRHpxRG1semJmOVVGOHB5REhY?=
 =?utf-8?B?ZGlRdUg0YjhQS3lQM3BuNEN5THJYWFA3ZUhiNDNEZXNkemxVcjN4MW9sK1lY?=
 =?utf-8?B?TThjekx5VHdnVStqWG95b0dwUTQvd3BkNzQ4QTNaK0hkMVBPN3FPRWlYdXUw?=
 =?utf-8?B?UlVNeGlZVDVYQ0xycmtwb3dvRTl3UmxRYUhjMW5TOVQvUStxU3ZONEwvSSt4?=
 =?utf-8?B?ZzN1MnJONUI5YXNUU1RyMjZUWE0rejlKS2g3M0JIaDNxWFpua1dGMjRjWFMr?=
 =?utf-8?B?Rnh2ejZsQmtkK3FxK0ExVlg0NG5MU1VCLytmUmd3YzdSbUxmMkpWUXQ5cGZY?=
 =?utf-8?B?UlZOV0NmNFNPbnVpdFZyOVYzS295VzFrdFJibmNWRGpxZzN3bC9SZ3A2RmZ5?=
 =?utf-8?B?SmxTdjJzUlh3WHZ3STI1N0hXaytiMUJ2UXRhM0hhM016cWpHQ214V0QzdFU2?=
 =?utf-8?B?d1F6MjN5aC9XaUVRdjlCVDZvV2NYSG5WVWVlTzBQQ3M3cWFNL2ZZOGF0b1o2?=
 =?utf-8?B?QUxBNzFFZ1BWblVyTERpQTlqSTljT2w0Q3RnVkdQMllDaTJmb2N1K3hibUNZ?=
 =?utf-8?B?QWdPY3llRHVIT1V1ajlYRDRvV2VTLzNLc1d6b1h3dElHbDdyOTAvSW5zVkY3?=
 =?utf-8?B?OXRUVVZlQzA0N0xmSE5lVDBYamZYaEZUeDQwVVZvNWlQZC9tc1RKTHFDTDVR?=
 =?utf-8?B?ZmV2anlQaERkNlpXRlRGZEpyWnNZYjN2ZUFuVmdmYWs0LzRZQVpweEx5VjFy?=
 =?utf-8?B?dHQyVkYzWGkzRkx2YmxIUUZxT2ZTTXZ5YjU3UllTQktoVEJFbWJsT0JqN0lO?=
 =?utf-8?B?OXpwbit3S2lpVkR2YmJTNy9pZlduWXZvRlZpQXVIblY1MTZWUVJGeXRHZVVF?=
 =?utf-8?B?cG9sSkxwdUFEYjU0ZDhnWFRaeTlWL0lhbFVSUDBTaHdIUVdacTJzcGNadm1P?=
 =?utf-8?B?RFBpUHg3OVhLRVBSSlFXOWZqa3o4S0x6VWF2bFNNNzJuVHZWaE00VFBjTXBs?=
 =?utf-8?B?cHMycDIyVVVFYlZadTB1dGVBbngyOHY4WkxCK1FDbC8zbTZaQ1d0NkFYNENW?=
 =?utf-8?B?eVFCZFQ3aVl6K09zUXBwSERPbTVma2w0a3E5azdaK09qZXBCYjAyWGVpQm4x?=
 =?utf-8?B?OTRBdGRMQVBiOVlPVy9oUExiTDJrL2tUaHBZSWJOU29aa1hqQTVSSEJDc0RU?=
 =?utf-8?B?WnFNUUp3Mm5wbnVEMS9rbHlIZjJBendhNElwY1FIRFV4QjAvTktRUEU4dkZJ?=
 =?utf-8?B?WDlrMkZ2K3Q3enNkYUdQNmJmOFREQlNQMnhPY0pMSFM0NVJYa0N5WGkvRXlS?=
 =?utf-8?B?TVN0WXNUQ2libFVBOTJ2NUxJTWp4Tkh5RmU0QkFCQ2xuWGtQTHJMTHQ0Vi94?=
 =?utf-8?Q?5Q5TfweTtn9SNxRM7a67?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6306652c-e6c0-46f0-7d5d-08dd4d39ab54
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:53:44.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9984

On 2025/2/8 02:40, Alexei Starovoitov wrote:
> On Tue, Feb 4, 2025 at 4:40 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> On 2025/2/4 23:59, Alexei Starovoitov wrote:
>>> On Tue, Feb 4, 2025 at 11:35 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>>>
>>>> This discussion comes from the patch series open-coded BPF file
>>>> iterator, which was Nack-ed and thus ended [0].
>>>>
>>>> Thanks for the feedback from Christian, Linus, and Al, all very helpful.
>>>>
>>>> The problems encountered in this patch series may also be encountered in
>>>> other BPF open-coded iterators to be added in the future, or in other
>>>> BPF usage scenarios.
>>>>
>>>> So maybe this is a good opportunity for us to discuss all of this and
>>>> rethink BPF safety, BPF open coded iterators, and possible improvements.
>>>>
>>>> [0]:
>>>> https://lore.kernel.org/bpf/AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#t
>>>>
>>>> What do we expect from BPF safety?
>>>> ----------------------------------
>>>>
>>>> Christian points out the important fact that BPF programs can hold
>>>> references for a long time and cause weird issues.
>>>>
>>>> This is an inherent flaw in BPF. Since the addition of bpf_loop and
>>>> BPF open-code iterators, the myth that BPF is "absolutely" safe has
>>>> been broken.
>>>>
>>>> The BPF verifier is a static verifier and has no way of knowing how
>>>> long a BPF program will actually run.
>>>>
>>>> For example, the following BPF program can freeze your computer, but
>>>> can pass the BPF verifier smoothly.
>>>>
>>>> SEC("raw_tp/sched_switch")
>>>> int BPF_PROG(on_switch)
>>>> {
>>>>           struct bpf_iter_num it;
>>>>           int *v;
>>>>           bpf_iter_num_new(&it, 0, 100000);
>>>>           while ((v = bpf_iter_num_next(&it))) {
>>>>                   struct bpf_iter_num it2;
>>>>                   bpf_iter_num_new(&it2, 0, 100000);
>>>>                   while ((v = bpf_iter_num_next(&it2))) {
>>>>                           bpf_printk("BPF Bomb\n");
>>>>                   }
>>>>                   bpf_iter_num_destroy(&it2);
>>>>           }
>>>>           bpf_iter_num_destroy(&it);
>>>>           return 0;
>>>> }
>>>>
>>>> This BPF program runs a huge loop at each schedule.
>>>>
>>>> bpf_iter_num_new is a common iterator that we can use in almost any
>>>> context, including LSM, sched-ext, tracing, etc.
>>>>
>>>> We can run large, long loops on any critical code path and freeze the
>>>> system, since the BPF verifier has no way of knowing how long the
>>>> iteration will run.
>>>
>>> This is completely orthogonal to the issue that Christian explained.
>>
>> Thanks for your reply!
>>
>> Completely orthogonal? Sorry, I may have some misunderstandings.
> 
> ...
> 
>> program runs a huge loop at each schedule
> 
> You've discovered bpf iterators and said, rephrasing,
> "loops can take a long time" and concluded with:
> "This is an inherent flaw in BPF".
> 
> This kind of rhetoric is not helpful.
> People that wanted to abuse bpf powers could have done it 10 years
> ago without iterators, loops, etc.
> One could create a hash map and populate it with collisions
> and long per bucket link lists. Though we have random seed with enough
> persistence hashtab becomes slow.
> Then just do bpf_map_lookup_elem() from the prog.
> This was a known issue that is gradually being fixed.
> 

Sorry for my inappropriate expression.

Actually I just wanted to give an example to show that the problem has
existed for a long time and exists in other iterators as well...

Sorry for using "inherent flaw in BPF", I should try to help fix it.

>> Could you please share a link to the patch? I am curious how we can
>> fix this.
> 
> There is no "fix" for the iterator. There is no single patch either.
> The issues were discussed over many _years_ in LPC and LSFMM.
> Exception logic was a step to fixing it.
> Now we will do "exceptions part 2" or will rip out exceptions completely
> and go with "fast execute" approach.
> When either approach works we can add a watchdog (and other mechanisms)
> to cancel program execution.
> Unlike user space there is no easy way to sigkill bpf prog.
> We have to free up all resources cleanly.
> 

I sent a proof-of-concept patch series [0] that implements low-overhead,
non-intrusive runtime acquire/release tracking.

By replacing the address of the CALL instruction during JIT, BPF runtime
hooks can be implemented.

I hope this patch series will help with the watchdog and resource
auto-release issues.

[0]: 
https://lore.kernel.org/bpf/AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#u

>> Yes, I am willing to help, so I included a "Possible improvements"
>> section.
> 
> With rants like "inherent flaw in BPF" it's hard to take
> your offer of help seriously.
> 
>> I am also working on another patch about filters that we discussed
>> earlier, although it still needs some time.
> 
> Pls focus on landing that first.


