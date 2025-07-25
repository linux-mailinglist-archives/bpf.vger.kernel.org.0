Return-Path: <bpf+bounces-64358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EE5B11C03
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F681CE4BF5
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6592D9492;
	Fri, 25 Jul 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LHfD1J0V"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706962E6108;
	Fri, 25 Jul 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438314; cv=fail; b=EC0rCJhnOoVL3jemtaUBFagKaypuGBLCZYrTCmSVmp7sYAFYkhTuN0RpELIiqCck9yfgbmVo/AlsnkiNJiX9HD+5V1p7T5S9mWuOAyKtNAK6q5uroXCrNKeVQju5EYrxSejNnKXj6putiXd3xw/2gy1ywG7rxoIdYczc4VB0Gf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438314; c=relaxed/simple;
	bh=1Ap8VQeTy/fiVwYtoxF6NuzGMf62si1Qh89OcEiywFA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U/HKeYvBgc8je3R2If7oLTUu/bKCwXIGNC3JM9ucjtn3WJppmSikYWQPmXQu6MTCI5XsfPD76P4QpmZ2QXT0407mBsDC1YF56CPhleFJLsOvhsvHzCiWEd2NN6WDKjtnfM56w5vpkRAjzJGW7wSU7oom2WBGLqXpshNN0CrsAKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LHfD1J0V; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xunxnCpX3EhxfIsz/VnmuraehEwx+a+0sSaHVFDsnf9b2deri+rfa3y+w+9rEzMxFBANRtozcMIVcBZROsjmhxzOJm/G5JjRNEk2ATJAinCrbXL4cpWiB9Vg1EsRUSC+Qwa5/QvlsqHuQXEuu0WS6m3ERg4n0DEY9qA9iY2DmKDecvx/fseMcpFeeVqELrLSqq43x/f7x2CpRTnQTJvtpbJX5Bo7rk6GGfKjecSV8Yk0UH++CmD8E/3XRYsqEPNBo1Pnv88r+vdl13EsANXqGgbVefjGHuObgDAc+Vv8IOJnGBqDHCV0fc5ndw6/Sa7zkyCoLg0OubfASeLyyPqOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PMp2y3/2s+F6g7ux2NuP+W0Odh/gPPTMoOHcyejMf8=;
 b=obtaraYN8G8urSvnLLpOdpW1kdTvmyVmyVNhlw3u9nUtleFDo6SFxdFTLz/xZE7Xn7QiNneSbD8uRv1CxKQC8d+wXUUnM7z0sxKCwtM1KDiQjcgcBG+MMDuZD9eGHPX3VR20U2VaRy5fj1irCi6621MRS5HZVrY6AZhV05JqS2y90T2u8iGHq3vSFMA2DAL5gosoSwdBGl2C8YkFeKnjk+swT7Fyd93f5u0tK8evNAQ5MrJyqa9iSaKNh8t3tjZWPYV5L7+il6xkZAF9MQ9Jg8BIw2ro75D30JgjaNlre4R2fpJhlXslymbX0B4qf6yDwo/JnnU3iHwZ6WhaA7Rg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PMp2y3/2s+F6g7ux2NuP+W0Odh/gPPTMoOHcyejMf8=;
 b=LHfD1J0VMKBazFPk3+kHqdZZ2a5yDQijcOGzoAC1Ap0YOqBBnR42slnF/1c0DnBIyfZ/jzrGPJVkUes4nyZUDZw96i8i+gBT8xB+H7Y9YqJO7dp1xKHED55p4/B6WF6C9ASEfMqPjFmesHnrTWr/5W/G5NDK5nJ/squJvWhbUYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) by
 CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Fri, 25 Jul 2025 10:11:51 +0000
Received: from DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::6392:e010:ed54:1606]) by DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::6392:e010:ed54:1606%4]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 10:11:50 +0000
Message-ID: <de14f60e-b1f0-432c-80b4-a2f0453e0fe2@amd.com>
Date: Fri, 25 Jul 2025 11:11:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Chenyuan Yang <chenyuan0y@gmail.com>,
 ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 zzjas98@gmail.com
References: <20250723003203.1238480-1-chenyuan0y@gmail.com>
 <045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com>
From: Edward Cree <ecree@amd.com>
In-Reply-To: <045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::38) To DM4PR12MB6207.namprd12.prod.outlook.com
 (2603:10b6:8:a6::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6207:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bc8b4f-fc30-436d-b4e4-08ddcb63abd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1ZnZExsbkh0N3prVGM0VEVQcUxUK3ZMUzVYQ1A3YXpwZGJ3QzQ4R3dkMFRJ?=
 =?utf-8?B?UWNzTUNSV3RJK1pvMTJ0a0pSQUhCKzJFNitUeWVETHlBVXFwWWZDV1huZ0Qw?=
 =?utf-8?B?MThRT2p0UzhHRVdMMEpadFpBY3BPZVd4QWlYSDRMMG9kSFRkQldUK2dsV3BC?=
 =?utf-8?B?Qll3Y29QeFBNam1jNVRKanpsTTJJdzNFQnZPL2swUVhHY00wbWVXaFErNUlh?=
 =?utf-8?B?ZU5qK29XUVNXV0pqcDFvN0luZmNaamVOZEhmMVdPbXRQOXUwYkdhUUJrc0U0?=
 =?utf-8?B?aDJLcHVqR0Q5LzlhQXZnc2hXWmUrWitkaW5GR0NFMzFGS0liMjgrdU5EVkc4?=
 =?utf-8?B?QmtjY0pnbkliaWl1SUpXVHFoZFpFM3h4eHhoWnVoU1BGTHJrQW1OQTF6alZ4?=
 =?utf-8?B?c3NVNE95ZlAyR05naXpUTENLOTN6U0RlSThBSkFSQyt2bDZpQ1F3UDV3eC9N?=
 =?utf-8?B?VFpkcWFjZVV6eEgvSjBxelZCb2E2SzFTSDArK2szOHBBbUpxWVJSNit4Nnhq?=
 =?utf-8?B?eFlpVlp5T1QrNlJoQVg1RXUrbkh2NVk0cXF0amR2Nk9wZWg4aVFvU2dONWgz?=
 =?utf-8?B?dmtjQVFMeVZON3R3YkJuRFNKV293Rk1ZWlNPQm91cER3Sy9SMGd6N0pwclNy?=
 =?utf-8?B?c1NEZFIzNjFISm1RclQxUlRNYWRnMEZxU2YxelFrRy9vUldaTE5lbG1tQUhH?=
 =?utf-8?B?RVB6eWtXMm5hUnpQeC9DSXd6dmMxQkE5VFY0ZWdoTjFBdlozY3gyNERCdEZs?=
 =?utf-8?B?RFlBRVlTTmlDdWJ2d0d0K1FIUGRMUUFsSkxQa1FNelFodGdDUGwxZFljUVdV?=
 =?utf-8?B?aUQvZjJJbkZpUnJYcllLS0xwL2JQeDQxcnlvQkNhRGIydlhSMG1USmpZTVIz?=
 =?utf-8?B?VnlOT01zQTllSWVESW9KclltcWtnRlBzZTVyMzZsVFRvZ0l1YmlJN25UeVoy?=
 =?utf-8?B?RURHVnJCR0dYa2pnNWc2aHNWaEhjOFljejExTXJicUtCQmJENldRYXM3a2Mr?=
 =?utf-8?B?WEM4eFl0R3RoeGxrY3A2UG5RNWh2THo0R3hOY1l5cmV3TytRMWJ2WlIreE15?=
 =?utf-8?B?b0N3NFlrZVJJNDFrVU5icFpaSlZWcnp1S2FVVGVVQzJsS0VOV3FJZHVWMUtj?=
 =?utf-8?B?QnlRNW5vTzVSQ3pPZmNXaWJmZWxTWVI1c1hLMmxpRHMyNW5LMW1MaGxqR3Nq?=
 =?utf-8?B?eHp6OXI1TGNpR05yc2xHcnI4RHhEbFZyVEg4dFZLK1oyTHpPU3oxODFJYjNY?=
 =?utf-8?B?S0FqTlpyVlU3cG5ERzlTRVRGVC9GelIzSUhCb21RTitSaGZVYXhQMDg1SjUy?=
 =?utf-8?B?UW00NTNLT1lYd2hEODFaV0NoR1ZBNlU3US9nZTk5dnJSaUc0dHNFeEk4OEo1?=
 =?utf-8?B?b21EZ3MzdUYzRUNkU2R4ZWZsMkkzWlhCdmFZbjBsYlN6RTlaOFR3Ti8vb1Jq?=
 =?utf-8?B?TlB5N3FvcWN4OVZPMlZkU2ZuVndPVGxqWVZ0VjNyVFMzVDgyaFRKcVo4UDlz?=
 =?utf-8?B?eGwxRnN4aHZ1MDFrQVVJenUzM2pnWm9ZcVY5cWllY3NjVmgzZXhMZHpwejBi?=
 =?utf-8?B?NkhWR0xwbVhoUmhjaFhNRGdKQm5GVlVaNXlWay8vTjUxNTdmRm9UcUpQbXZU?=
 =?utf-8?B?cnk3QUZEb09DL0FtVFdVR3l4aFhick8xRnBJbVcwaW43ZXc2amdjWlBvaHV0?=
 =?utf-8?B?dTQ4LzFBbkl2VTY0TXErVVhZOFQ0bmIwSWNxZVpybUJ0YTQyUitKTXJqU1Mv?=
 =?utf-8?B?TjJQQjc0K1pQb2x3L09WYkxDNWc5cEVVVUpiaTMvTENCeWEwWjRER0RjYUx5?=
 =?utf-8?B?UXlVVFdZanJHZjR3RGRFWW1QdGNRUThpdDQxQjR5Zm9ZNVlWRDlENUpBeVo3?=
 =?utf-8?B?T1FNMDZubHovbkZHbDI4Tm1nQzg1MFBZeWkvRVJkZVgxWnhlWWdLVTluMktK?=
 =?utf-8?B?M0hrQlpzMVBuMXVUV2dkckk2NDNWVklnUjkweGNNanVXelVxdnFmQWRMcjJi?=
 =?utf-8?B?UUZVaDNPWStRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWJOUkNaYWhObkJac2R5VzBybzBBaWZpSUZJVHd5YWNqNnM2NEZaUjRkdURK?=
 =?utf-8?B?bituS3Ywc2U4YzhHQzczNWxJRnBMTmhNdU1YcjhSVEdyRXF5M2FIY1FrT25M?=
 =?utf-8?B?aTA1NWdMcWMzSjk2bjNTV1pLalE0bzBIVHRYZGhxZkNkOWVERXJIWEU1OWJw?=
 =?utf-8?B?dzhHemt3KzFjZTJLdDl0RlIvbEFKY2trMVV4OWdtRHBSL1lhSGpPSlBVNkEr?=
 =?utf-8?B?L000bXFIVU9VTVFWV0F5RkJhVFRZR1pRK2c4TXRJR2Z5cVBraFc2N2xFNXJZ?=
 =?utf-8?B?bGVsTHFKSmp2dzNQelYrMmRWTGlDT1lnYlBTTWl6aWpxd0VTRmNxam14NUxk?=
 =?utf-8?B?M2UyNVl4dmdjd1dZcy9FS1NMcUEyb3BrNjNRL2svN1djQ2hySVVBbU1OclBr?=
 =?utf-8?B?TmlOOHlBMzUyM0ZqV3RmdVM2Y3NjSURzdGljUFJBanpnTnp4MWFWUHlhbTVa?=
 =?utf-8?B?MnpYelR4VERzSXJDMXNacWhKUG1Sek0vK0FXZ3BJdXBSZjBuN0hsekNuOC8z?=
 =?utf-8?B?TVJaVXlJTkY1bmRVRGdJR015N1lkUFZtUzhpMTJOVEZqVFQyRlN0MW80aGwz?=
 =?utf-8?B?QXV0UmRJcTdTVmhCRjBHVXgzMzJ2RUtLQXM5NkU3RDBYdjZ5MHlvRXlDOEdQ?=
 =?utf-8?B?TnE5LzZWZysrSnlZdkl6R2x2MDlpN1JjOUFGMzZoZDdXamdlWjBRbXQ1dTcw?=
 =?utf-8?B?OE9hSjF1SG40dTc4N21Ea1ZXN1ZNL01yOXJkKzB3c1JJd2xMakZwOERrRm9j?=
 =?utf-8?B?MjdyM1o5aC9lYSs4ay84alVnUkxLeU9RcWdRbUtoRittUWZ4VHNJYmRzeG1s?=
 =?utf-8?B?YmZsejF4SzlYMXRubS9LREd2T0RHYlhwU3Y1ZzdHMnhDSDFHL0hlYVJWeThM?=
 =?utf-8?B?S2ZUZHJXc0daMG1Fa0tPR1hmeE1ndWZlVEF6R2ZOckVnZXRhTC9kUUNPVjBr?=
 =?utf-8?B?dWNxb29aaVJoWFhVWEV1STNXUXdQY0ZKaVBNbzhKbU9EYnRYZUpjcjBjVmZC?=
 =?utf-8?B?M2tiUWNiRHRFUnRneGRNMk50b0tzZzIxeVNtOGVsNlQ3Qm9BVExEWUxNbEVS?=
 =?utf-8?B?aTE4MVhMcDFkUUovY0xoSExvOERUVnY2amY0WjVmaEhLajI0MTBNVTkyMUwz?=
 =?utf-8?B?Yk43UjlLaHpac0x6N3BBdDFyQ2NRdzdSYzUyM1JnbFN1NXVKMWZiS0kvK1Qz?=
 =?utf-8?B?Zkl5M2YrOW9rNkpqU2hUYklGUFVwcEY3RGdXMGM2ckJVVFVZTkR4SzQ3c01n?=
 =?utf-8?B?SkczTjBCdi9lenp6VnAxMFdZeE41MlVGOWZDdFNGdGhaTm1Uc2pOcEJXQ2FG?=
 =?utf-8?B?a1cxaWV5MGhabEh2QVRIVVgyZDREVkJTSWVEQ3BMSlN3TDNGbmlRZ3RYQkla?=
 =?utf-8?B?RGF6eEpxcjY0SnFWSFV2R2FheExzSmtxU0s5bkRqTG1saEpUcER2WU4wb29j?=
 =?utf-8?B?ZHU0YWUrUmVJS1BEcFliY0RiR2VLNDFnMlFKUFoxOGVBRlJ4WWcrVkRRaE9E?=
 =?utf-8?B?emx5OE8vOFpScUh2OC9yTGxTSVgwWHk5TnB1aTlWSVRwcnBKSTY2bTkwNXJG?=
 =?utf-8?B?dXlqa2tlWDJ2RnhaQm1tc012QzhxaG5ZU0V0eUNrRi9icTN6bURPSFJocXBS?=
 =?utf-8?B?bDAzWFo2VjRraVBlTm53elYxMjdKa3dOcDVnOEpaYzhkZGhrRXRtKzdwUFlz?=
 =?utf-8?B?WndvSng1b3F3cUVnZks1NE9zcHdpR0ZmTWdodzZORG9iakNBZEpiWjFWMXkz?=
 =?utf-8?B?M2Q3cStGY1FraUxPekFmMnc3TWZrTFJzS091c0k5YWJDQUFDUUdlY3NpRnVV?=
 =?utf-8?B?VWJBa2t6MXFlWVlRVGROcVo2YkFGY3FhSzdNMlg5TFVYcGppVXl6dWI2VFht?=
 =?utf-8?B?RmxNNVBlVkJvaklCdG4xWUF4cnlpMWFFSXQxOUVIZVAybWpsZktRclRLc0xQ?=
 =?utf-8?B?MGtLTG9RY1ZOR29IdnJjZTIvNThHeGozVUJ3STNqS3M5cHgzTS9jRGZCNDhp?=
 =?utf-8?B?S3JVZVpldVM3MlNQczNFQitGVE0xd3FMZHB0cGtDQTRZWUx4NmlYTERWUU8z?=
 =?utf-8?B?a2Y5NDhpbGVXaHFldGpFYlZKM2RoMDRLWnFpOHNHTEJpYktrTHJyb3JCYU51?=
 =?utf-8?Q?lJK8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bc8b4f-fc30-436d-b4e4-08ddcb63abd7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 10:11:50.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxjDz7GjSdkto7FzSQKxTQBw51pMSuz+oSe5qnT+E4t2290KdRyxuGR0ZzsCsW8S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

On 7/24/25 10:57, Paolo Abeni wrote:
> On 7/23/25 2:32 AM, Chenyuan Yang wrote:
>> The xdp_convert_buff_to_frame() function can return NULL when there is
>> insufficient headroom in the buffer to store the xdp_frame structure
>> or when the driver didn't reserve enough tailroom for skb_shared_info.
> 
> AFAIC the sfc driver reserves both enough headroom and tailroom, but
> this is after ebpf run, which in turn could consume enough headroom to
> cause a failure, so I think this makes sense.

Your reasoning seems plausible to me.
However, I think the error path ought to more closely follow the existing
 error cases in logging a ratelimited message and calling the tracepoint.
I think the cleanest way to do this would be:
	if (unlikely(!xdpf))
		err = -ENOBUFS;
	else
		err = efx_xdp_tx_buffers(efx, 1, &xdpf, true);
 so that it can make use of the existing failure path.
Adding the check to efx_xdp_tx_buffers() is also an option.

-ed

