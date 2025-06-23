Return-Path: <bpf+bounces-61297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D49AE490A
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF4517632B
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968A128E579;
	Mon, 23 Jun 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YYdoaprW"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD81F94A;
	Mon, 23 Jun 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693487; cv=fail; b=Vo6KuxmefzG4FgJ9c/B7tzJinYu4xLz4S/Fm0Junfx5tf4m4XumEOnZk4vMRXPvw9bP0JR9+ld3+qe/96i/mbOe+nOHg8e1buAaGue3FP+Q9nbRJ4/WKG5fpKLXcTvr1jL1WlaizBsJhjp/WA9ezF8pKEhOtQyDdENSR2kpgTOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693487; c=relaxed/simple;
	bh=eN3rjzEbYGOws5lf4iJHU9GdQl0K0Un7WlBHC7qBhZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DC24p9lKtwEuWd4EBpyY2Ajz3i4w4YFpbl6RZJm1Pebv1mCmeGhdAz8xVlndpXbwW9SSssiu5XfBY5odR33stQQ4BwcyC6rgUdB6r6tY54/3/CTL63c8MAWW7w9umfinguPHAjeZIzBTb4O46OF/K5Puof4f9ANPdqRuvEW87eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YYdoaprW; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiHOrWEKJLr4sYTajzqN6RPwanM2lABvXkiTJaUefDSSb8ttk1qPy9Kubhwo/PyQiKq+o9OjCtZ7Mq4kGy+SZPbXsqrZctwQLbxdmLE/yDL5t3a3xEGCVz+AezllV+JBde7fbPCv609gV/9sXAyqmFsy+xXGLrEev9+E7mZluKh/vY2hyzkG6+3q73Nh3d4Op3pVPBEDSpO722Px0naD3JRJIrn0cqr4BHLvAjc5CS2OR4Jp8fWu5m5dfLpu+Dj2QElkjNvP3hDWZ9jkP+9lJVXeFlemL1VzlysaRELZL9GgF16I6lhfu0LxxVx2UbKYeE//ZcUByDSOxIbZJ362xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtGGu/bHwbi07+bHWdUhLUhJYsXAj2s6r2Rw6SFVzl0=;
 b=Sm8ERav2j8EyXchqR3Az755D0XygnLA19J6VqbUq7weX0EnhJBLhg2+pTOqA1DIv+aP/WS4ao4tYANj+5wuk+cj+bJ9A1pZsXknwoNcAl7sUUotI/pbbPJXTf3btp4nHOISUtitx6UyDuW1d4H223JQz3akemuRCpMY5IYoqAjh7kCxRN/x5nw/aZSVw3vELSaqV/56I9tKZiQ87zgCbAM7En7vweH0+BSMAMHDqn0Vy3qiiQmv5/bLZ4WKxgsZapi7zviccf1bR/5km1yEYaBSFAUQmfspizXlMBGS3vVxfISE5gRuYomj0QCFil/KCa0+r0mBVbcCpp49nPxyq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtGGu/bHwbi07+bHWdUhLUhJYsXAj2s6r2Rw6SFVzl0=;
 b=YYdoaprWYFv1B/bDqSosvjxKkQJJNcPOlyjkhZT5S+ZtUDwsA+W5dQfeM/9ETSRLrmPY+0SAFX+yT/MY05sZertB0ifdyRQo0vaDWx9N5UgtKhifkyGNFN52NUDxEOdfHiVj+RM/WJVLRFVc0rEKobBRhS+nMZZWrXUH3jYOEpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 15:44:41 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.8857.022; Mon, 23 Jun 2025
 15:44:41 +0000
Message-ID: <8f54ae13-7943-4e45-9881-a01108a1b58f@amd.com>
Date: Mon, 23 Jun 2025 08:44:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ethernet: ionic: Fix DMA mapping tests
To: Simon Horman <horms@kernel.org>
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250619094538.283723-2-fourier.thomas@gmail.com>
 <bb84f844-ac16-4a35-9abf-614bbf576551@amd.com>
 <20250620105114.GH194429@horms.kernel.org>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250620105114.GH194429@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39)
 To PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb1f461-a09f-49e2-44bb-08ddb26cde5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmQ3S080MUxxamZIY0VuWDJLM3E3U1dZQ2hCMzNUY0VhcVdjYjBheUpGSm8y?=
 =?utf-8?B?QmVRRGEySUhiRGY2ajdHcDlTMHF5LzZlLzFCeUdPa25ZMU9FWUJSUENmMlh5?=
 =?utf-8?B?alVyUW9PWmI0V2xUOFdOeVFyUCs5c1BoU0dHTGUxNldPV2pBZ0tSWnJlM1FI?=
 =?utf-8?B?OHZ2QnE0SXBVaDZQR0dXUXBMQ01ETVp2VkZYTDVHb3pFbkhFWVlGdmpJaE9C?=
 =?utf-8?B?dHZPeUUxUkNmbjczOFFLVWxVNE9LTnJ4K0t2UmpGTWhCT2dYMW16Y2R5cnlV?=
 =?utf-8?B?QzJNMHMzWnIrVE9GWmlWQWoyTDU0YVhJYU9oK1p3QjhabUNSVW9qUmJTS3RH?=
 =?utf-8?B?NktOemVydUdzN2hjb1E0TGtvdzNOQ3NtLzZ6Zmh0dkxIdVd6SXd3Vm1KWGFH?=
 =?utf-8?B?UjdYVlc5b2w4SS9aMXlPVWFoWitldzZGd0lBVHFvZnZ5SlcvQjlNT1JEdjcw?=
 =?utf-8?B?aEI5ZFJsS0RHQndBc3dpVkRjeEpvdGFFYllNNTFqYk1Sc0RBaExLUzcyTjho?=
 =?utf-8?B?SlV1NUV5MTZwR2pvQmVJWlQ2ZUxhS0lkc3p5Q1pTWTdTRld3N2RaMEF4VmI3?=
 =?utf-8?B?UzZXZ013QlpUckZyaHlJWlEwWVNnOGIzNHJST3NKY2NLc2tOQzRic05kT3Ba?=
 =?utf-8?B?TnpyTmJWSENsdngyT2k1czhFdGdWRTR5TVpDUitYWTI3L21LVU9hVnFBQjR5?=
 =?utf-8?B?L1Ryelk4Vmt2bTBITWhjNTJSOC9SOUxxRDlzbVpQamJia2Vwc2dkWmVmRFFZ?=
 =?utf-8?B?L2hoU1k1UGkrM0l1bHoxT3Q5SUZ5YTdOaFl0MG5JRVVDWmhxcnlLR3d3YkVh?=
 =?utf-8?B?N01BbTRNZ1JGWGlxbTIrcEk1cHM4RlNqWTZzQTYzSS9nVnJXazdwM2ZCSERL?=
 =?utf-8?B?Tk1oK0w5QjYzNEt6TWZYbHBZZk5oenVKUUV6emNVYkJYY2lVWnJWalp2TllJ?=
 =?utf-8?B?VXdta0h6WjI4K3QzSGcyT0dLKzlteVBuTFNkYm5QWDZZbGtEbkdiRHBUcUQ2?=
 =?utf-8?B?SDg3WTNiRTJ6TFZPYWc1b2t4RnF3Nk5wQWQvMGUyM0FXT3U1SHJHc1p5aFh1?=
 =?utf-8?B?KzRGNlhUUDkzYW4wRlZ5NUpQZzI4dXJsZlJQQnFNVnJFVHVSNzJHRFNrei80?=
 =?utf-8?B?UGZMKzZTV3lxSjFicm92VjAvNWZtNnpDR2RYK01pQjE1TUYveVVsd1lNOVpp?=
 =?utf-8?B?Q3R4WXJmcEpnZXhQa2FXQ1Y3blVOOWpsNk1IWS9DbEJ2dWZvTVVROHQxQkZt?=
 =?utf-8?B?Y3RlQTAvd01PeU5DTkg4UEpJTWthblJHaHJHU1JXeHZkTXF2SzYxWXgyL3Ay?=
 =?utf-8?B?UC9DcTh5MlpPcGh0bzhxSXpyemhPMTh1RHd4U09KRFlUWi81dG5ZeXJ2Wm1v?=
 =?utf-8?B?VFZ3SVUzRHEwZUx5Uk8vYU4rc0d6Vm5xMEdSWHI5a3V6K1NZczdoY2dRYzFS?=
 =?utf-8?B?Wm1oZEtGZ0UxcVhJdGlGQU10d1U2S1lHaDJweXFmM3l3Z0VFSjJsRHNDem8w?=
 =?utf-8?B?L3BFcmIxSWwrMFJtK1NNRXFJanAyK3ZmRjlRMFNpRjFCVG9ZUzMvTFd0L1U0?=
 =?utf-8?B?emxEOTN6Smx6azJHVmNESGhPMXIxSlFWcFpQNjZvNjY5LzJrbThJMXFnVmxR?=
 =?utf-8?B?M0JqVlB2Tzc5ZzlKS3llazJYOEZrOFhlb1lCcGQ4WkVaR0xqWVZ4MExqYXFS?=
 =?utf-8?B?OTJPRWN2cWVLbDBLQ0pLS0IxTG0ySDlKWFpJeExSN0IzWTEyeFNSSVZnNzQ1?=
 =?utf-8?B?NlJYOEZIaTI5MSswdmpwd1FYRk83c2dzWDh2WFF5T093RlNmd0R4cEg1Z1ln?=
 =?utf-8?B?ZDJYVHhsSDBGYmJZRVpEUTQzekt4eitGVG1sUFhNY21qaXJlQ1BBbFJhbWMz?=
 =?utf-8?B?b3YrSmVaRlRJOVdyNHlMWGFBQno1ZC9qbTN5djBLQnpHd1l4T3lKVFBuVm5C?=
 =?utf-8?Q?rcwjByEv70E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWZkZmY4WU5RN0tSN3hxdG9QWmY1dkJ2b25LcFFxYzA2eFlpWFpDVi9HYU1G?=
 =?utf-8?B?RlZ3NUZlcndzalRsUDQ4TXg3bEx1aVd2d0VoNE9xeUhZK3JQbTRIUDFFRXAy?=
 =?utf-8?B?UUtsOG4ycE5uMHdUUSsxS3IrUUVoVklxQndnRkxSWGt2VEdEdnhSY1JuU084?=
 =?utf-8?B?UHVMeVlIbXVpTGpjc1BrcjBFNWtrMmYrTWJsdXFhL2dGdVhkb3JiYUNpYVlm?=
 =?utf-8?B?NUt5VXhvc2gvNDFCZkFKVXJhMGxudHU5aDkxU2I1ZXN0b2tFa1NjUU1OYk9n?=
 =?utf-8?B?VjF2VzUrdWlCWEllTEZuV2NxVENHTGM5L1lMN2NBVnEwSnU2RVBZRWtkS3hs?=
 =?utf-8?B?eDhMVnF4dHZMZmxnOGg0aEVmeTMrQW5YeUgzeGQxUDhKUFdJYVFTNGRYQTU2?=
 =?utf-8?B?WXBrWjl6Sis0V0hRNmNaaHROVExmZm1qT1JZNTI5SUFFNS9KaitQRmhmSytS?=
 =?utf-8?B?dktSbEhqWEJJMHVmQnRoQmxvQUVYV0taaUJRdWVzMVhMVFUrMnVGVVRJWG5h?=
 =?utf-8?B?YnBuQkF3U2s5dXE5KzVHS0FvNmtmdnFnQ3lnekJIeDNZbWhjcWM4bUxmRUJv?=
 =?utf-8?B?VG1SdlZsNW16dVo3VmFOOXgvRUdaaUhoNVk1eWRMNFM3QnBCZ2dKRUlHbXJu?=
 =?utf-8?B?UCsxdzJ5cjRVQmh5OCt6dEpCdzNEaXhwZW0vV2hWYTd6REpTajkyRDhYaHpU?=
 =?utf-8?B?RkR3RWZuOHlTTkZmQ092Tmc4S0tpa1ZBQTl2ZTNOZEl3cmFack5ldFNEV2hq?=
 =?utf-8?B?WmZvYzdTOEpVZklUeUxQYjhZNDZNZ3FNYzVOZzA3SGRWaTdtck4rUXhJc3VW?=
 =?utf-8?B?Y2NHTHdBTDVzb2xEUG8wOFRHQURzL3d4OGJMdDlSUTZYNDBWQ1ZuMW5CRTRi?=
 =?utf-8?B?RmZsZGJlclVzU2E2d3pRTlNwSFRMMXhIWUduc0hKajRZSVYzZDlCUm9qcUs4?=
 =?utf-8?B?Y3FnSW1SYzBCWWZ5dVRtcVFDaytNQUo3QzFpS0kzS1VqY1daUFUxM2ZSaTEz?=
 =?utf-8?B?MzhHM0pLZHVMdUdXdTBFRCtJMVZ2cVh1TkxLTFI4UWlFYzMxU01JUTFYbnBi?=
 =?utf-8?B?bGYxcjVvRk1Xaks4N0Y0cHhhb21SVnV4cGVsTXNZZ1dkbTFIRGp4b0JyS0xO?=
 =?utf-8?B?dHpoT0VyZkIreHVucW5BZ2d3TnNFNGdKblFDSEZQYVB1YU5LQ1E0SEJkbjd3?=
 =?utf-8?B?d2oxYUtRS1A2dnIvQkJ6SUhwajR5T3hRMFFaVDRqZnBlN3NYNUYzbXRvZ1NO?=
 =?utf-8?B?NitwVjZuMndFL0MrNklSWVNFazlTRDFFRmhUN2ppQ0dhemszUW5NZWFjVWFn?=
 =?utf-8?B?ejZneHFGWWxrRURTRTFISk8yRWlkQmxVWGU0TFVMYk5kb2NhbVlHSXZjTUlq?=
 =?utf-8?B?LytGNm1KK3F5SGYyV084WS9Id2VmdGpWTmdFMVAxYlpPWGZaZ1dWcWlwL1Q4?=
 =?utf-8?B?WmpUWlBnYy9pUExoMXdBTUZZQ0k4aXd2RFBZT1dQSFRZb2hGajNHcVZyblVT?=
 =?utf-8?B?VE1ETmJpZ21UQjZmV3doNHFmWEJ1bHFRU3NEM2xUbkUvTTJHQTE2eWIvTzZI?=
 =?utf-8?B?bVB2Kys0SWtBMEZLcWpxSkJwc1JtdU5yM3ZHNDBOWWtOMkNUOUdPTWIvcjZY?=
 =?utf-8?B?dXVsWFdrV3kydWU3Rm1zWWtRQisya3VXM25PWFhzc1F6U1hldG05dG1Xd3Va?=
 =?utf-8?B?a09uWHpWRWNNWlpLODNvTlZiZHVSM2h2cHlIYWQrREtrWThJUHBBOG51NC9D?=
 =?utf-8?B?WGJoNTJqTnE1Sm5mOTNnOXAyVlhTU1dpUzlIQmpwN09Tc1NHU3dwZHdxMTZv?=
 =?utf-8?B?bGUxUW9jTm1YYnRXQnVVT2tsQXB3c1hPMzVGNzRjMmNBN3I0UVg2WWgvemZ3?=
 =?utf-8?B?RVVEZXdJNWlJVHpGbTFoQk5YanRIb1dTRTNWRlFNbHNIRXFtWlEwdk0zT2lI?=
 =?utf-8?B?K0Z0bFJ2SnZ4VjgzQXk3YlJ4T3FhTUwvU1NqYjVUa3FBTW82SG05YnZkZUFW?=
 =?utf-8?B?S1RNcVpXM0lIQW53YlJQa09JMDFlQUt2WS9NUHhyZXhoMnhpYmtjVjdUUkNH?=
 =?utf-8?B?WjhaZU56d1dRY0VDKzA3eDVhYjloNkRaZXgvVVhOOTViVlUzNG02UlBVWDU3?=
 =?utf-8?Q?Xmppf5y1U8d6UwBDxmroPlu5U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb1f461-a09f-49e2-44bb-08ddb26cde5e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:44:41.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQ8IMbntmvOzWV2UhpgWeLU3lohkjC3PnHSeMDL1HdI3QP5ID43FDyH7EmRPD25YwmXlzRqNG3ceFVJ266gw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262



On 6/20/2025 3:51 AM, Simon Horman wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, Jun 19, 2025 at 03:28:06PM -0700, Brett Creeley wrote:
>>
>>
>> On 6/19/2025 2:45 AM, Thomas Fourier wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> Change error values of `ionic_tx_map_single()` and `ionic_tx_map_frag()`
>>> from 0 to `DMA_MAPPING_ERROR` to prevent collision with 0 as a valid
>>> address.
>>>
>>> This also fixes the use of `dma_mapping_error()` to test against 0 in
>>> `ionic_xdp_post_frame()`
>>>
>>> Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
>>
>> I'm not sure the Fixes commit above should be in the list. Functionally it's
>> correct, except there being multiple calls to dma_mapping_error() on the
>> same dma_addr.
>>
>> Other than the minor nit above the commit looks good. Thanks again for
>> fixing this.
>>
>> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> 
> Hi Brett and Thomas,
> 
> Maybe I misunderstand things, if so I apologise.
> 
> If this patch fixes a bug - e.g. the may observe a system crash -
> then it should be targeted at net and have a Fixes tag. Where the
> Fixes tag generally cites the first commit in which the user may
> experience the bug.
> 
> If, on the other hand, this does not fix a bug then the patch
> should be targeted at net-next and should not have a Fixes tag.
> 
> In that case, commits may be cited using following form in
> the commit message (before the Signed-off-by and other tags).
> And, unlike tags, it may be line wrapped.
> 
> commit 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
> 
> E.g.: This was introduce by commit 0f3154e6bcb3 ("ionic: Add Tx and Rx
> handling").
> 
> I hope this helps. If not, sorry for the noise.

Simon,

I suspect you are right and this probably shouldn't be categorized as a 
bug fix since the change only addresses a corner case that would happen 
if the DMA mapping API(s) return 0 as a valid adddress, which wouldn't 
cause a crash with/without this patch.

Thanks for the feedback.

Brett

> 
> ...


