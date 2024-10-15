Return-Path: <bpf+bounces-41954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C761299DCD8
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE981F228ED
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9815A85B;
	Tue, 15 Oct 2024 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z5tdjliz"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E314C8C;
	Tue, 15 Oct 2024 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963161; cv=fail; b=EkMGwfhrYYhkFUSjN0MXVXJJdQ1NN40CydJvi/UJp1lmerOHEOnG9ZLev3F7UieYjqGQFtPDD/J/9h3appvj6SQyPByOn+x4byvlYDvajYZPwmk7KC9jOlk2YXSYTH1cDE2jxi7+8ygmWXDTmvE6/ybMMTmRChxy4Lut0zZ0YU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963161; c=relaxed/simple;
	bh=x4oOCAC0pqS/y7OhUkNYKuYTCAgNrX3gri/zT9naXzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nRbjT/JiRJVkEhmwYF5JEqs0DlCigHc4dovmEQw0fp1Y0ecIlnLWwW/fV7rULNTGQ1ZKJp+/MxpUn9mmmnSkOqxJhzIhcmvTMPKNEHCtRdePTHWpA1pKf25kAy8D+d3Imqr8SzVFIhCZ4lk4oQC5aVZZ5yz3U2yjL0xSyo7hEPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z5tdjliz; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raVTNFxw65H5PDOVn4KF39Bs5pFXx3hr8GWrre12LzA78Tt7a2oJWJkvRxvikc/MvaLWpCHUa3+l1PPzRpEYS9Lw6CpMu7dHO8hTKhxqeujg0AeAd+qsbsyeGPM2xQJBJUWjCOG3w9jDTT6uzXcL9LatlI0OQhbQ6yyYEvYPTnV4WGDY/EzyRTywrs5k9BjsVe9+CskgGTy/kc1YZMltZcSW2wo9mX76+oz4sEqwuhvccQYQ/XCDi6BSQY4dGcv7EI++/W4QKo2TWA62UpRVuOS+t+ahiN41XGGhv35PHQVvvq51ozEx0QQAlsrEEJEMQMqzy7gneKSLfBm3hcRGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0H2rSJrDb++upfOUXJiJinUlCQe+ukojJTjQs4fE0k=;
 b=aXnnaFg6BrUBrVkeB5RPlkaGtCT03PWSGTCFwyahW7vPq6Ib/t8GlDezfWwb5ut3jl431enoYs3uhY7+ZLo4h8JLbIevVtwfLlqRXJwGftLuLWsR7B7vHdci3pd6rZMX7gIMB/r14ZDnT8vEq9yMCZMAkga+h0J1lg/M4hLOH4gNFYo1zTY3DK/y8Ns9XHMSA+oxZwh86kab63cvSDe6416ewsQkBadcMkPHcvQ1iYzyMSWy4X8P0dYT4I3IPe7QbugbHV4ZQyx2QQBCyBgJ4Ch9sx+X2PTs4rCmGcnMWLU3UKKDTHWm3bGW28eRNzOxgLblMt6+D1sgxm5dhtsjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0H2rSJrDb++upfOUXJiJinUlCQe+ukojJTjQs4fE0k=;
 b=z5tdjlizhHR3obkQ+xX85v71O58HCxIRcJuC0QVp3i1SyOC646kBSlQDrU5hN5/O1kfx2hUv658oo0FIr6mZjqoRi251rJnrjv7OjLR1E/cpkqgkefi5kB6DZG82vioft8r7UHvhU1nJBUgGNcrf0lO54vKzXjwmBtosKyRYfzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 15 Oct
 2024 03:32:36 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 03:32:36 +0000
Message-ID: <8f988c33-2787-4547-a6af-e7c52061b48b@amd.com>
Date: Tue, 15 Oct 2024 09:02:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 04/12] srcu: Bit manipulation changes for additional
 reader flavor
Content-Language: en-US
To: paulmck@kernel.org
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, rostedt@goodmis.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-4-paulmck@kernel.org>
 <abf6c382-7b70-4cdb-9227-7dfd21e60c45@amd.com>
 <6f8934c8-8499-48ec-89fa-e3f356fae419@paulmck-laptop>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <6f8934c8-8499-48ec-89fa-e3f356fae419@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: d67846da-a3a5-47f6-0b2b-08dcecca033e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEJPNzNlWWdqRVFmbVoyTUZLMHliYm9JbzFtTHFiK3NMNU00cXFLeUlBenV1?=
 =?utf-8?B?WXZYaXA0UVpwWnZwZy9qUWNyM2kyK1N5anI4cUlyN0VHLytHaktOVndQc3ph?=
 =?utf-8?B?bWg4TnYxY01KanZ3dWQ2dHU3UFpUeU1hak1XQnVUZzJpaEpZaS9SK1MzY0t6?=
 =?utf-8?B?M3J1UkViRSs1UmNZcUU2NUZiYnk2UnlDOGc3cGZyK0xtMUdGYTNIMTgwa0dC?=
 =?utf-8?B?U2dlTzVnU0U1Y3hlVzg2L29MYlFRYkZsaFNYTVRJdWpoYmRHcGYxSWEyRnVx?=
 =?utf-8?B?QXl0b3Z4UThkajdCZ2F4VjFEYjhuQUx2L0dscko0TWpQYjNZUnV1MmwrZ0Y1?=
 =?utf-8?B?VmFVWVQxSmxTaVp2K05xbU1UbForWldKN2h2YkR4QTdOVjlFKzdQZlpObERO?=
 =?utf-8?B?ZXQxQ0JrNlBWSWIrSm9OSjdadWtrdmtKdkxLd1RFSStDaHptZHVDM2ViMXZ2?=
 =?utf-8?B?RXR5NG9XZEV3Mldyd0xtYXQralJZa0xlcERrZy9tNFpZVm5OcHVTNWdTZmFu?=
 =?utf-8?B?aUhYRGFaL3Y3d05PbTBrVnU1QS8zRk5qckxac0U5TTRITFQwT29Tb21zUER6?=
 =?utf-8?B?MFJUQmMxYU9hOVk3cExyeTBzdG1HaWRVZUdDMGs1eHhBRjgybWZjQ01WaHcw?=
 =?utf-8?B?TnFIcEJESWZxVEgzdkVHcGhyUGxKVXFzUlZnR1IxellvRDh6TkxYN0h2b3V0?=
 =?utf-8?B?YTY0SG5DWHdnWG5nQW5MU3ZGeFFscElzYUlVbWhqS1FyS0dQbzFjMmZrYXFI?=
 =?utf-8?B?NVBjV2NBNGNGWVhGTjhDSUpjeDFrV3l3Nm92ZjVDM0FzSEo0SFJlem1sSkox?=
 =?utf-8?B?OUVzVmtQRzNTaVpBNlZ0a011eWwxU29oU0dVT29sRTdDQlF0enU3WmU5c3Nu?=
 =?utf-8?B?WDYzeUZjeTRBM204cXVOR1czUGtuWmd2dVE1SHgwMWY2TGZEUE45VnF0TmNi?=
 =?utf-8?B?c09wUzdGNERLOFJBY3ZkdG1PYytDK1MrQVorYlBCNFFCdHczL2pCcFhka2V4?=
 =?utf-8?B?TkFmV1gybVkzTG5tV3RubTIrNEZMcy9pTi9zRTZmQml1amlnMW1WZGVVMEY3?=
 =?utf-8?B?aFQzdnBSY3JudzJGbjJiVTd5Slc4RDIvWnFZNUxqL0wwZDJjVFJlSVpDQ29r?=
 =?utf-8?B?U01LaEMvdVNBUGQ0TmlucmJ1VGhBaVUxd0VvVFFtQ3lpcEJHTG5ZUlZIN2FO?=
 =?utf-8?B?aGJYNmNObTJjdXpVU2RqRERMYWFQdGxVc0dwYmZGZ25CREJkY2NxdG44Ry81?=
 =?utf-8?B?Q3lvMEhLK3lPSVhOMHJBUThuWXQrdEU1dEhOR1luVXVMSkV5NzlVWjM2RzI5?=
 =?utf-8?B?WkhST2orQXVPSlFHb2t1bkJtalNOVSs4eGx3Mmh5dHNXNUNXNTlUczVtb2pN?=
 =?utf-8?B?YUFSaW82cGdJamcxUlJNdXZtaHNlbVR4bXNSaG5lODc1YU05OGN6TXJQei9p?=
 =?utf-8?B?cDFYem51aU9jdzE0QXBVZkNhS3Y4dTBaWmh1cjdtVWltc3NyaVFORVBwS096?=
 =?utf-8?B?amE3NkYrdUhYb2VvdmN5QThEb092S0lkVkJyUjgwa3diRXVNSFBTaDU0WVl3?=
 =?utf-8?B?VEk0VTVMbkhxNmtTTTBQN1FORllsYmd2dlBjYTcxM0hVN2ZPVTZSU2FzRjdN?=
 =?utf-8?B?QVpiUTlwSWU3YUxvRXVMVFVzNHI2d042aTc4RTQ4aTBXRU9LdDYyWG1MT2JO?=
 =?utf-8?B?WmJqZkEwYmhUamtnWHAzb2FKTXBLbWlFaDV6ZForK0ZscGdNWjhKMGZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFp6QWU3Z1VhZDFETG5ZMVRmUmVpQTBQaktQSjNWT294L2VVRy9qYURyZmhF?=
 =?utf-8?B?YVVLbnd1VW04eEFIL05CdDlOand2VnVBWGwvN1BQTHFzZHBzMDRFZ0svdHZt?=
 =?utf-8?B?elJkRjczMHUxdnUvVUJRcWtybFVyWnlrblVHb2svZjc2RFZlZkdud2MweXVU?=
 =?utf-8?B?ZEZIOEhGMEM3ZllZcWlFY2RHNEtOWWZza1l5bU4vK25sbTNkZldmTEd6UnUr?=
 =?utf-8?B?bWRCVHJkRTJCa1NqNDZuVkt5MFY1ajVOU1FaeEtwY1ZSRXN5R1JzcXNtcHow?=
 =?utf-8?B?YjErenBZcHlUcllaRUh2bWFIcUx5bWJwSXIxKzA2VytUT29kNi9QVnNtT01r?=
 =?utf-8?B?NDJRd1Rna2piQnl5TWU5WWs1UlpqdXBQTFNvbVJGYkNWbzVMTWlnMmR2amJI?=
 =?utf-8?B?UVh1aUJLdnJrVS9MVTdXTkhpa2ZLenJWN2ZZMk5zQVpHdGcxQWE1STZDdWth?=
 =?utf-8?B?YXR3Uk9MUzNKU0ZlMlpnZ2cvaTJFNVNIbEhMWkhtcEFVNFJSMjdJWUk4MmNv?=
 =?utf-8?B?STRuRWxjSmg2RTdZYmY1eDQ0RUdpNFVOSTQzUHFEYW8vV0kyaDl1L3BtNjFM?=
 =?utf-8?B?NUJudDNMdjBQL2k3YlVwL0toQ3lHdG1QUng0UU1pdnN5OTRRbGkzeEdFWnVN?=
 =?utf-8?B?cHJyM0JvcFp2SktzMUd3RE1iNUpTWnAzejdMbHMzM3RGL1MyaDR1bmxLU1ZM?=
 =?utf-8?B?clNRNm1hdy9IUnJ1RENCRFc5cTRzZ1FuYnBMRkkrZFlVZkNVMlkzOEthMlpG?=
 =?utf-8?B?bWhsK29qOTA0NzBlaEtVZDROT0cvWXZ0Z1hGbllrVGdnY3J5ZllueHJaNklr?=
 =?utf-8?B?U21NNXhBenR6RmJia2JUcFVCSlBoaHRxazZzNmk1YTBlV3VNbVY1NndXc3Bj?=
 =?utf-8?B?bTYxRmxPSXBXY1dtLyt6OVdrZ2puWjQwSDdIdFNHVFJ0NUs2M1l0U0hmeVdG?=
 =?utf-8?B?bzRYeWFEVlk3RHVHQVk4T0VmektIZitORzZxZHRiZGk5TDJHUEMrRStvS2Fl?=
 =?utf-8?B?bURzY0dXZTNqcXlxeEhiMEtGcVk2dklWUlJQVkVGdlJrTzNOQkp5bTRPL1pu?=
 =?utf-8?B?SGtBbktSbWo4em5DcEV5cGVDQkRPTEh6YlRISVRRcG92N2xzL0UyVi9GWk5U?=
 =?utf-8?B?ZHY2NTdNT0xmcjRPUm9jcmZ4U01GQ0JNUWE0RXRUbWFLMWxyN1pkWEJCVFJG?=
 =?utf-8?B?N3ZHV28vOC9ibnI0eDVtYnBnellVcTUrczFZeW1xeU1OTmhobkkvbzZlWFFD?=
 =?utf-8?B?R0RCRUd5Y2NrWWJtcmVack9xR3FLR1BKWDRQbmhaTUFGeU8vNEpySW1kUkRF?=
 =?utf-8?B?VmdNRFhTb2REZThUc21wUk92QTJNcW9ZWjk3cjdERUp4cGdVcEFSYjZBUkpL?=
 =?utf-8?B?QlFncTBNNTFmYi91RHBjalN4dkR3YWFXTTNRcVdWeW4zOEk3RTBqTFNSZFZH?=
 =?utf-8?B?UVZGd3J4SW5NbW0yZVdZT3paOWJHbnVYRVNIYklZSGh1cS85eE1uVG95Y0Jt?=
 =?utf-8?B?NEpyQzBYNTg2ZGZ5aEF5VlhiV0Rqclc0VkRpQnZtcDhOemtiNGZoeWdleFhI?=
 =?utf-8?B?a1k1NlN5UTIzaWs5ZGFlN1ZublpYS0EySC9xVUVQRU4zaU1xczdVTlQ0Sm1C?=
 =?utf-8?B?WEtNZWxMUEN5b1pvOERSYy92Tkp6Mm9YNm5UM1ZaaUpzRjlCZGZydWF1UTVj?=
 =?utf-8?B?TmVsVU9PUnlHUkszaUEyK2txbU1EMVZoZTBlK2hDTWlQU1hsMFp5SFBiVjhj?=
 =?utf-8?B?OEtubUpCUEZnRGt4V0RPK0ZxQ0dEUVBtSFd0RHg1RzQxeTkyVW0vZjBkTno0?=
 =?utf-8?B?aWZvNXdDRm5xelR2dmZWSXY1dTFUeEUrU1BHSVZ4cUkyQmFody9sdnVMb1Js?=
 =?utf-8?B?bVNhdmM4cmRWNk5KQVNJU2lIblE0VmJwajVaelNINmY3WlV5dDhtbHcwUVIz?=
 =?utf-8?B?Zm4xKzFIR25ZRThxS2R0UWZmR3dnZVpEVmNZU2xzanBHRnQzMGplYldycGpJ?=
 =?utf-8?B?MXNqK2ZsNisxS1hoYk9BV0Y2R3AwQW54NTgrMUtlZzEyTzhyeTJRbkthenJr?=
 =?utf-8?B?NWt5OUpaSk1Eb21hNVh0cVVXdDZ3dkdicFFITWRpeG9kRi9MQm5icTRBdExB?=
 =?utf-8?Q?ptjAUNvHCZvKzocNBSWP7jJgC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67846da-a3a5-47f6-0b2b-08dcecca033e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 03:32:36.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umuoeScust2BuN7nHVstMp8KlJNPChx6TncU4MRN7LiwYXfaZjthlCuaIlZmf207120TuzUB7+FS3mCviSHS2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009



On 10/14/2024 10:21 PM, Paul E. McKenney wrote:
> On Mon, Oct 14, 2024 at 02:42:33PM +0530, Neeraj Upadhyay wrote:
>> On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
>>> Currently, there are only two flavors of readers, normal and NMI-safe.
>>> Very straightforward state updates suffice to check for erroneous
>>> mixing of reader flavors on a given srcu_struct structure.  This commit
>>> upgrades the checking in preparation for the addition of light-weight
>>> (as in memory-barrier-free) readers.
>>>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Kent Overstreet <kent.overstreet@linux.dev>
>>> Cc: <bpf@vger.kernel.org>
>>> ---
>>>  kernel/rcu/srcutree.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>> index 18f2eae5e14bd..abe55777c4335 100644
>>> --- a/kernel/rcu/srcutree.c
>>> +++ b/kernel/rcu/srcutree.c
>>> @@ -462,7 +462,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>>>  		if (IS_ENABLED(CONFIG_PROVE_RCU))
>>>  			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
>>>  	}
>>> -	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask >> 1)),
>>> +	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
>>>  		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
>>>  	return sum;
>>>  }
>>> @@ -712,8 +712,9 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
>>>  	sdp = raw_cpu_ptr(ssp->sda);
>>>  	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
>>>  	if (!old_reader_flavor_mask) {
>>> -		WRITE_ONCE(sdp->srcu_reader_flavor, reader_flavor_mask);
>>> -		return;
>>> +		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
>>
>> This looks to be separate independent fix?
> 
> I would say that it is part of the upgrade.  The old logic worked if there
> are only two flavors, but the cmpxchg() is required for more than two.
> 

Ok, I need to check more to understand why it is not required when we
have only two flavors.


- Neeraj

> 							Thanx, Paul
> 
>> - Neeraj
>>
>>> +		if (!old_reader_flavor_mask)
>>> +			return;
>>>  	}
>>>  	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
>>>  }
>>

