Return-Path: <bpf+bounces-65337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA389B209DE
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 15:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FB73AA1E8
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF86B2DAFA3;
	Mon, 11 Aug 2025 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Xphowrxv"
X-Original-To: bpf@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012055.outbound.protection.outlook.com [40.107.75.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3215624B;
	Mon, 11 Aug 2025 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918142; cv=fail; b=hiFB5iumaVXHcRp5QStRAduPAwmsRg+P3oolS2MUGaa7qyIsI0t+FIUMuW1B6VB36iS3bakvR6iYpkGMUcssTwwjQOSWiiCN9k0EuIGgXrAsipoCXlz3A0M3CU2dvf/fe2PJpk2Lt4LJCncFdcoOPbf0o4kq6qvAeiJje1L+e7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918142; c=relaxed/simple;
	bh=u28QiVMolRFdiq3YKAlNocuSXeB+NGcK6B9/vDFFkdE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QCnhPAigMri3lzz6J7KXlxUxXv3mg877vSeDSNWKP5zPfNHPJXeWUnxI01z4M0Gurc/5C0XaCuRvjxk9Cx1QfxsPEz1+ACGXVqNOmf+eYZw8RJTdmzsyZrDDQf6nnDMunOV+J1VG19hitTT7lfQzO2GqJ2++JFz3HKuMpy7UGUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Xphowrxv; arc=fail smtp.client-ip=40.107.75.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNgdgd7RGJuHHOCVe3kTpgLuy4k9+Geltv4BV1qRIAB5o8146cd7hyyyrRd8HdqJT8m062nEfwr7NM2uinogbcQICpw77QSGLTCNTba+qT8agNbnrcoDTPY4OhfurD9ia7auvgX1Pk7JtWPwZN+v4Q57fKxnMbB3VV8txV+Snw3AMkk9UKx1aGkd8ib8hYmtFrhN7fmtYMKqhzyijnQhUJoJg+BXxSh4pQ4wLF9PvdEooYqc7D63TA3ti+HQN5SIQcCv1Lm5ljd4O1KHtDTLEyabgQ7AiylihIQRD0tfAPsNaBjWAIMhb/5vWKCEWN+u0WkzprG25WzrRDGQIpAuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vpkw4fEBruQyYoOgowanxq3t/KjlIFL+r2jK+gx594=;
 b=LnWDj6ZGrFPmgi5hPA4k3Yooiokz/FfxNU3V7oPyqO9WGnneQ4igM0ryrt1HXT3bQzdAdYc7xhj7uMn8UkeWSeZwYtesYLewumFpJ0z4G6TgsDXxPoKFwe60vb8pQMR49WducUXZNl7DSG98tYrYTxUO9ZCtEVe6rv3JWk1zwUSYTotFsNaZXo/8193E7UN8Pr2I3xF8X/0eLGfZiZfXIY5GgIF2Wkf8+ITJ2vYOR490CDSY3ueRHsrDbEYXDLk0s4TlTI2/umFtuxqeQXd1tz1IwyUjM4JAwmPaCd4WnQY6R2Ib9vOVOo9c9BpLJCpVq08e4qJY5YUxaHiOl0kKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vpkw4fEBruQyYoOgowanxq3t/KjlIFL+r2jK+gx594=;
 b=XphowrxvzJoV+HgKMluli1BHbp9vpFQTU8DRhhqYU/Qj9rVP0sFT/Bv61sMS8QvX5WCMvgyWZ6U4lXmPuiKCribt0CZ5rtSspqPGLNQMg361fT3bMR2rqJJBS3O5fxaKtk24JXYuSemJ00N5PGdE+8ezSDXYrvA7MUU6Z9lee3s4weqFmDy0giHtOZAbNbQL4zuloRH5zDcFb8HRbsfSqRZcbYez96jXqdN19kLwSdtv4JtqiuEWoOrbawBJj2wvUrH/IssVRMPlsTXUAXlN5ZDOEoU6Az+tqBlEi9X+CNkkSiyMc6gPtFaiTRnUWrSuY6nSvfOUkfWOr3cG/vS+uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYUPR06MB6100.apcprd06.prod.outlook.com (2603:1096:400:357::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 13:15:35 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 13:15:35 +0000
Message-ID: <d106b3c7-6afb-4e55-b2cc-0354f5db4bde@vivo.com>
Date: Mon, 11 Aug 2025 21:15:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: replace kvfree with kfree for kzalloc memory
Content-Language: en-US
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811123949.552885-1-rongqianfeng@vivo.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250811123949.552885-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYUPR06MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f29ebb-65e9-4867-57e9-08ddd8d9280d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWRPSVBuNUZrUTJId0FwQ1M3MXhJSHFsQmlPck5YUXhxMlJNVnFLRjdVclQ4?=
 =?utf-8?B?RzM0TWFyM1NLMmxmdkVaTVNKTlpDemZDKzZ6UEZ3djc5NkhlbmJPdkFvcnNs?=
 =?utf-8?B?NVlSMmlRa2tqR0xYckhQMFVoQldhVHZKUmNqWUhHN0lwSzhmV04wUFF3d0tU?=
 =?utf-8?B?VE1NZExpRWFIWVA3cmJTUEdxZ0RkRkoxaWdPNHQwUUtjaUpuTDJmTlV6ME1B?=
 =?utf-8?B?Z3BpVUZoNE5QR2ZyZHJaY3Nid1Nma2hLWGhHRWVkbEFYRklaT3lsZmNnNVJK?=
 =?utf-8?B?WE5pWWtGQTV4RW0vVFhKbHdOLzdFenVCSll3WHViMnFWMHVPd0V1Q2dGOTJF?=
 =?utf-8?B?TEFZQk5UWVdrZWU2Yk03UWw3WVBnb1lWQ2dEbUxEOUpiQkhITlcrajRPaUxG?=
 =?utf-8?B?NjIyRWJuVFdVVk5rRzU3MjAwZTFHcGs2MXdHMERJL3U2WnYwR0RtQW1UVmtR?=
 =?utf-8?B?WUREQnMwekZWNm5ac1JJOUZXblF6TnB2emxUMEFlN2dWZjE2MVBkaGFNSGRY?=
 =?utf-8?B?aEZiSWxXYzl5SkJtaVNIOUlLa0s2VnVydis2M0pTaEd4YlFZNnI5dEplVTZy?=
 =?utf-8?B?cGRVZzBqWGJCbmFrWGQ4VHNRbVYwVU0xY0JhMFlPVzQwWW5Dbm9UQzJodnNa?=
 =?utf-8?B?RmVTNWlPZnZ5TzFBa0xrZ29Pc3BEeGErb3FuVHdieHJYbW13Q3dYZUlySEY0?=
 =?utf-8?B?QkU4UXQ4NUIrS0cweHdRRWpyNG1teHY4MzB4UlV0aS9VaGtGR3FXWU12OTd0?=
 =?utf-8?B?L2VmRlEwT0lCTU83cDAyOFlvMkRPYlFFNzd4VHJEQjhJK2ZCSXAybFMxSDMx?=
 =?utf-8?B?WXM2SUg3UVRscS9VdEcwVHNRbGF0Y05SYWdKRnN4cEJEU05aeTE3OHArTFlZ?=
 =?utf-8?B?eWNGbGNTTmdrRGpaT3NBenBtN0lhMWkyZTAxYzQ5bm02S0U0UmlJWGNuUlh1?=
 =?utf-8?B?bjM4TkpkQWNjbjZsOTl4RGZtczMrWWc3bmJLSWhPQUJaa1MwcWxxOU1uMHB2?=
 =?utf-8?B?UnZmVHZTcUE0N29VdWI0MWM1MEU1azhqUkFNVzJKU2VpYjFQejcySEVNSDZH?=
 =?utf-8?B?dVJOaVVSZjhockxtVXlYd0hFMzZyTzhaaURmTmRzRGR1bnpUeHhoZElvNTQx?=
 =?utf-8?B?ampHbzkxZk9oaEFNamVWOHN2YVgra2RZL2h2ZjNBSlZDSFZQakRVQU9UenQ2?=
 =?utf-8?B?Z0VzTnZucEZQbjA2Y1c2aklQdkFqeitWSWNNSFFSMnl6cVVacnpxSUYrdW9X?=
 =?utf-8?B?MFVLMUFGeWZ3aXBVMUJsQTBQM3BPMWxZUGc4SVAzOHdISXBkZndWRlQ4a0sw?=
 =?utf-8?B?enNiRmY4cExjMkxYVk1hNVpqMDRFd3VnaGtaaENtMGpxUVFtVjJqY0p3eWpX?=
 =?utf-8?B?Lzd3NXZ0L1c1dXg2R2xVQlpKdDdxM2gweDlOc3hVZkpkUUJHdk9uaEMrQm9z?=
 =?utf-8?B?Um9ZMWpyNmcxenZrS3Jwck5OSlBFcDkwNHk5VnFIaWM4T0R2bUMzeGNJeFRD?=
 =?utf-8?B?Q0F4cU5jL0FESUU1QlpWNDc0dU9BeXZpVWJYdEZicTg4VGkzSkUvWXI3cm91?=
 =?utf-8?B?elVTMXB0RWF3dnNmcUZtdjRoNThKSWVIMStQRnB5amg5cEZ6VGtWeUh4YmZJ?=
 =?utf-8?B?WVd6NE8zOVZVdzFhbDBPaGgzK2FVeW1tQ0dxY29vQzFod1plTHIzM09ORk5D?=
 =?utf-8?B?NGpsc2QxZHhBOGQvT25mLytWRmJzRElUTVlPcHU5bGJKeHlrV084NjlxSG5N?=
 =?utf-8?B?LzdIa1FmM2Ircm1qNGg5VWJEOG4vcHl2OTZDVGdGcGNvYWhtTTZSd0JKalRl?=
 =?utf-8?B?Q04xd0ZoMk9VUVNJNWRrSFhra1FueTYxc3djZm90enlmVnZwUlhWWklaV1RE?=
 =?utf-8?B?ekFSdHNoRThuUDAyMFpRWDF0Nk1rNTJkR01Pd0hIbFdxcERJeDdQUWxtYTlN?=
 =?utf-8?B?YXlEQ2JCQXNXcU5MSXc0cTV0NW9JTjlBT2xCK0gzY2FtMHVud1FkeGI4VFZL?=
 =?utf-8?B?L2dtZkNSRyt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zkh4bGdTa2hkN3VVSHBLY3ZITnRrY3l2eWVuNGNHVkxnM2FabG14bysrZ24x?=
 =?utf-8?B?M3haaFpIWEEzVHVvSnZBVG9FWmloSlZ0VDZ6VVpFWVVhVUpnY3MveDN6UXNS?=
 =?utf-8?B?ekNhNjIwZzJmTDJydEdsMkNaK3VNOHF0V1pnUXZLN1E4L0RGTWYvWDlIdG04?=
 =?utf-8?B?a2luM25CeEJUSXdSTS9QT2UzZ2t5UVVVb2k1VUlZb0VtTzdIY3BOUkFSVUx6?=
 =?utf-8?B?bTE3UWxuNElSUzh0RVEwbHhHa0NFSW1qdXkvMzNPNlZsY25YY0dOZ0pDdDZz?=
 =?utf-8?B?aHJuODdkUUdtTmxIbE0rMFhwK3oyYk10VU9YMElkOHU4ODQ4aU9kU2JXVUJq?=
 =?utf-8?B?SHVTU3hqVDFEeEpIMVVUcXBIRENaMGRSYmNiQUl6cDB2b2YrNjVEN1RQZkVu?=
 =?utf-8?B?UUNwV21ldlVSWTJ2R2ZpcG9LRThiWTJJckg5KzRtKy9SK2tQNUlMQm9zUlBQ?=
 =?utf-8?B?Q0lGWCtCTzhOcjBCL051aVJ0eXBHNjk3WDR0TDMweS9zTXJMbS9JSjZVcS9l?=
 =?utf-8?B?OG55K0JGZ2pQaEJMU0lsT2VyaXhqNDRpOUhRb2pkMC9FNjhENmYzTkxCS3lr?=
 =?utf-8?B?anU1dFNMY0NES25uZlJQRlhtZThKRXY3ZWlnSFA4YUk5aEVJZ21zYW8zcCtB?=
 =?utf-8?B?b3FBdFVCRFdFZmZPdzVucjFJT1AwWm96SDRjMDkrNk80Mm9DK0lKREkvbU5P?=
 =?utf-8?B?N2xKSzNOYitFdDI5aVBWSU5BQkovOW5CSDJuUlZrZmlLZWZiRjZ1QmdPalBn?=
 =?utf-8?B?eTVIU1NDem9UYmgzbjZ0OWhHVWkwVXhZUldMODlyWHkxNGJTa1phbFhQYTBK?=
 =?utf-8?B?U01yVmJXbi80ekplRW5JeEdHYWhJeGR5V00ra1oySnhZVjJXTjZCWHFQeUFk?=
 =?utf-8?B?L3BMN25QMWxEcExCcjExRC8wUW5XWHJ6OEthV0UwaXZrT0tYcTJmN1d1WFJ4?=
 =?utf-8?B?Y1A3akw3RTduUzhzdk14YjRFS08wZks4bEdRMkpXUVlSUnUvQWVCK0tBSVB2?=
 =?utf-8?B?S1g4V1E4UDU5ZVFpcXE0clpiSmhEN0tNM2JyNVl6RjBxVk93ZitucFR0QlFt?=
 =?utf-8?B?WEU0SDNkYlpDQzlmRzl4K2lOMVdBekF5QnA4cThteWt3MHBob1RadzJiREF5?=
 =?utf-8?B?czU2ZzNvK0hOZExtcjlLVmE2Y01tbjU3WjhkQWJxWHVPTy92TVFNVlgzalZX?=
 =?utf-8?B?UXBKNzhTSWRoSWQ2RkorNTQxRG9xblZpSXByQkFJaDFoeEQ4Smx5Q3VvV0xo?=
 =?utf-8?B?SDRNSU4zeG1QaGpoajhnNkxHQVpVWWdOL0xOZktyWXFFY1U0U3ZwTS8yQzN2?=
 =?utf-8?B?NC9ZeldIaDJ1ZVMyMHIyVHFkYzdIbXgzV3hlYk15M2lHZksycVBuNTh0eVFv?=
 =?utf-8?B?NlFJWmVtMEZ3WENWbGtnZWQrRGZKMGE4bG9ILzRWa2JCMEdJc3JJZUdJbU40?=
 =?utf-8?B?bG4xVHE1YWsyNXovR0dwSlhxMWV2Zkd1S3RWL1hNekk5dFNRQ1h2ZkI3MERo?=
 =?utf-8?B?Q1lleTJqQVVwWHV6SXhrWG5XcCt3WVd4MjMzaDVwbFUrRm00RFBac0k5QWxL?=
 =?utf-8?B?RjVqRXZ6QXdkRnZFWWRGMlFsQ1A3b1VYb0FFOVJSTUhva0p2THkyemsza3BI?=
 =?utf-8?B?cDhJQkpxblM3RGpPbXhoTWdMVzFmaG9FaHVLVVBmTXlUdnM0YkVTbFg2eERr?=
 =?utf-8?B?QzYycU1KbThKOFhNRmZ6bFNTWVdCRWdUZ3VJUFBVUzRmN2MvWGFaN08zemxF?=
 =?utf-8?B?WDBOYXg0VVhWVGpxcm8zOStNMlJndWVjaVFnN0ZIMTNnVkpodjRvNlNubnZB?=
 =?utf-8?B?WFFKY3gyRm4xamxSRldZZ1NmU1pjM3JNMkNtZHpHMnRiUXhkYkJEWHlHVEtt?=
 =?utf-8?B?S2NoblFiQnRaanhNR3A2OGlKRmZsUHMvOHpZaVpYNzNEaG1yWDNNZko5WWk2?=
 =?utf-8?B?K1JIZlplalZkc1N2b0JoWHR2TWpnR1NSRGVqcFI4UzFNRTZYOWNNem1HRWFu?=
 =?utf-8?B?ZnpyZEg3TDlWUklYRXF4ZVgxblZBZnlPQ0lmRWsyQWRjc05yTXlyR3Y0dFRj?=
 =?utf-8?B?ZHFPZjBFd1J1emlwSGFBQ2xnREtqTk9wVVA1VlQ3alQvMHRCZ01iaWd4N3ln?=
 =?utf-8?Q?OTmWfhiEuURigvqxJplWJ+MgP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f29ebb-65e9-4867-57e9-08ddd8d9280d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:15:34.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QB5QDoFTfYnnMqKrgMu3hKhBIsf/I40nZK3YXxtutLXEg1fb+Fs3nDgo6uOwEACBU5Yd4XNprUyTLe3Icyp/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6100

Hi all,

Sorry, please ignore this patch, because I found that there are still a 
lot of mixed uses of kfree and kvfree in kernel/bpf/verifier.c. Best 
regards, Qianfeng


