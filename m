Return-Path: <bpf+bounces-73990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61541C42217
	for <lists+bpf@lfdr.de>; Sat, 08 Nov 2025 01:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC53A349835
	for <lists+bpf@lfdr.de>; Sat,  8 Nov 2025 00:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A1224AFA;
	Sat,  8 Nov 2025 00:36:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020131.outbound.protection.outlook.com [52.101.195.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDA1F7910;
	Sat,  8 Nov 2025 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562204; cv=fail; b=CfWzFucmMyaFNGQHqWT6/GxxdhIvV7TC4aEr50kwylDZRZkmBYt9EcCf1TpPRmI737gQ3ANexR6GiQsUH6SSHS3L5iKJ/kU0KBNte+stYzA73hwZKdfhvz4C8FEqTFtgSKoNaFShAPMFMPTUJr1vpXRJ+V9QYRW+pTdKLdmxQuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562204; c=relaxed/simple;
	bh=DnzFj5/d/D0yh5UgRnwNqvFl1wodbQGLxL8vT4at0vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sfj9E5a0SblYeJpjiA30Iosz596jzSkbmabQ+5JjoiOp3qy5K0vTrBoRdHptpBnk5bXqZTtZtiDMjkQUXIufEbGwe9lf8fFxGD6QzGyPQFrbbsTVNEcMsBSrMeUaj/eg8V31b73KCW3V+7j1euEDXGXF7i9pMIWvR3Bk5o8+GR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsdNRG4tgil23oqvBFWyifbGsA/fMTZRCh8yA8KTa189CfXaSRm4lPEQB7Wiy/LV8auI06q6ESgf9kF7BbryFn2PNRnpyM3Qc3ElDxHmdPMOhycWbRBDy8qVdLehA4fWTL3ubJes83tVUuc3YCg8Z3RO+dZG9XcLeQoYdYwhIyssXS9lju2DwWdGH54BXYb6NqhwMZ5bguISllBcuxa/N/dXZ0gEtG0L4DHoC5G6QlNyglkxnEqpO7vbwrygfW+Bnv0gwsoo8NdIHte/cu6LEtgxGQdI60F069fq+tj4g/qCdIDX8cygNkmrSPrgKplVW0nFs1SvnBupKQkImfymsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5Fz2soKAERbqgxX6Tmds1kSnMZKYFQkOQfHuOuAp04=;
 b=N1A7N1Y1Tr0MWTr47KdQETTrgj9FizDTyEv3sWR2h2bx+12bLXp4qWa3A83voEsCdk7TP2C6QDTLsK4alFBsnwcMkMVV760EUZ78KyQNoOeyKocfIMm8SJw3RgsPQ3GZ3xxQkKI7pNiUL5kZdUBE41p8ZKX7ZnWUonml95YYC8EUUsulm3rKDRtbQ5Fv3vsk7XuXhP7vrA7CQxcvlQfyxuafWkwTMOo50c5X0+d5KNSNqdUmraQD+PjSKNn5vieRGj7MUK2QqSmkH8woG7SLA4CvEQpWKKj1cpIY+P5j4VNhKiMcr75Z0EX1kOOQt+GPNvs54cr1CvT7XqWs2WDlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6304.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:28b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 00:36:39 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 00:36:39 +0000
Date: Fri, 7 Nov 2025 19:36:35 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] kallsyms: Prevent module removal when printing
 module name and buildid
Message-ID: <kubk2a4ydmja45dfnwxkkhpdbov27m6errnenc6eljbgdmidzl@is24eqefukit>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-7-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105142319.1139183-7-pmladek@suse.com>
X-ClientProxiedBy: BN9P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::29) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e50fc72-7d5e-417e-14e1-08de1e5ee177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmFhT1Jya1BSczA0amhFRUdVYzVZK0ZhUSs1NXpUS1BabWJac2VSM2loVFJE?=
 =?utf-8?B?NUVsU1VUZDZ0Q3JWdkUvc051REJMUWxLTnRiSnUvTE5tdGlzQVVZSzQybmJZ?=
 =?utf-8?B?enc2aHE5TlZKVE9qWVJabWVma240eVRJaU5KVG12ZUI3RzZJSWRDdy94VkMw?=
 =?utf-8?B?R2YxTExYTjhyenNHTjg3c0Q3MjlXNk96NDN1Q1BIRUJ2TWxRTFZ1dXJpY1F4?=
 =?utf-8?B?Y0ZacjZreGc2SGJSR3NTRHF0ZUJVNGZHMUk2QnBCVTZOYllJYlBlcnh1NG5R?=
 =?utf-8?B?OGJITG40WU9hNjdYTEFVTzQyTUo5c1RzMXJYNHZCRXZQT0lyNldQVCtTZ0dW?=
 =?utf-8?B?YTQ0QnpxN1ZMM2ZmZmFCNGxWSUQ5aWF0WWJnaXVFa2hveWxnNVNCTFdjb1Rn?=
 =?utf-8?B?Uk9sMUs3bERhWG4yYkhlR0dYQW5aYzgySGRKbUI3SzFseXVjRUpDODBiTWdJ?=
 =?utf-8?B?TXhzTWMydmN6Um80ZGZKT3p1WGpkeHV6TG9ZUzhhSzVXb3Z5aVZYb1hSV2tU?=
 =?utf-8?B?d0M1REU5dFdoSzlqaW1hR29BemFFSnJCblk1Rnd1czZ1Z2tEM1k0QjFBL3hH?=
 =?utf-8?B?WHhCM2w0Tk5jZzUvUlFYeVgrRXZoK3dldkNQNDlzcEVmV0JZWnRKcGJ3YUE4?=
 =?utf-8?B?cDVoVnRtdDJLUGxER1FNQ05WeklCVDNCWmsxMnJwdnlCQWxhcXIydGVuUGU3?=
 =?utf-8?B?Zi9TTzh4WVlLbkFBcGZneTV5RmRKdkZEMjRrbUpWbVFIWFdDTm9YeEo4VHZo?=
 =?utf-8?B?OVRmWGVkc1M3Vm5CZE14Yk80V0xxOTB4ekY3cW1MRkdybThOclVzNlBLb2Zm?=
 =?utf-8?B?dW1HZGxMejdkNXl5NlhKbWkybXYwakxUMFAxYUFsRVRZVHE1aTdsc3cza1E4?=
 =?utf-8?B?WjZjS3FGSzFpOFl4aHMyUXJIc2xzWTFFTGdRVXA0amZWSmxPSm1wYm8zdmxE?=
 =?utf-8?B?SG9ZVk1nbEpGZFh5ZmEybE9Ta0lSRE1LQk15RkZRQlJpWGg1ZHlJRkJBUDJw?=
 =?utf-8?B?WHk1K1pxcVd0bmdnSXVnR2RUVk5rSTZudnBnSm9OMEd4SUFVVStFaldZMGZX?=
 =?utf-8?B?RkdiVG5zaW92aDN2L09mdXE2ajVUaEJwNEliMFB4dTAvbFlqQ20wK0RDbTNS?=
 =?utf-8?B?VmdjMjBuNjVaY1A1SFUyTVpodVk1eGgvSkN0cStUOTNkVmhxeXlaTVFEUC8v?=
 =?utf-8?B?L0hvZTVFTWhpTFA2ZE5WbXVOcGZUejI4ZUhmM2xoUkF1YzNGTzF5MnFrVTZp?=
 =?utf-8?B?QWVlR0x3a2xuYVZSK25icjBhNVdFSjFUUHljMXoyV1Zvdjh5LzF1c0JuWmN4?=
 =?utf-8?B?WklHbU5NWWxLajZWdnIzaytoUFNNeVBQbkdvcXl1ekpwR3JhcWNwSXdvMXlH?=
 =?utf-8?B?ZDNIczNESmVqNllTd2JYRk1LbG5DVVZnTGRCbmZFUDU0bk03WU5EeTdaQVJ1?=
 =?utf-8?B?YWpIVlZZY0JNaytSMzBhSGJUTWo1RUYwTitSMU9RRFJyYVhUM3FuUTVPYjlv?=
 =?utf-8?B?NlFWQlNCU0c0UDB6dEc0VWtCdlNGaEw0d055VHJOVlY4aVBweFE3WFdpb3dW?=
 =?utf-8?B?N3NIMW9DVVhMcDQvU242SHovRUZFNHpwZHBhSHA4TVJBTWVPNldiS1ZkWXFY?=
 =?utf-8?B?bHUvWVpIdi9iZ2Z6dFZzaWp4S0RWRzVZWFlRM2Rtb01zcHZYUWZYQVpVU2Z6?=
 =?utf-8?B?S2hJV3JVM3YydWQrMjR0YXFwZGwvWXVjMFh4bzFUYWJCSWhrVkdyNW81ZGI5?=
 =?utf-8?B?NTM1VStXRzZRMFJ0UStxUW1tTVJRNG1qOHd1RUxjbllBNCtjc1BqV0I0Rnc2?=
 =?utf-8?B?RnlHYzRCdVRhTXZVZzZDVU1qbWhOVk9Pa01tVW94ZjNaY21oRGlyNml2SjI1?=
 =?utf-8?B?SDhaYVpzdFhOeENLRzdPZ0VMQjRwbFJEK0JDdncyVTdDeHFBblBnV0lxMnJW?=
 =?utf-8?Q?eGebyZp+EWhRATPR1FA0NaRb7D3nkIA3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlpLS3VoSnpCbEl0RmlvZWFSdnFFc3BwV0ZiMlBYMWNNRXdmeGJHN2VCeU5H?=
 =?utf-8?B?TlZGYS9NSHZVN05la2dEVjhWdW5ocTNnQ1luc0p0Q1NGd2R5Qml5UUdIMVBO?=
 =?utf-8?B?dElDby9aNmx6ZkU3Wkl4aEdnd2xaMjVFQjQzWXNqS09BZHlZK2l5NE0wSFRm?=
 =?utf-8?B?cmh5V2U1U1RtVzJPMlRzbEx5dXVlalFlWVo5U2R3SVRCdlh3R2FFeit3Vm9S?=
 =?utf-8?B?UUtodVZTWmZXS0EvM1JIOWhBc0VjcXZLN0pFcGl6VGY2eENMMDEzUkdraDhD?=
 =?utf-8?B?V3d3VlBuMm1aMkkwR0J2SXJVS2ZvVXd0SUl0T3hiK3ZkZzcwWk5DSFNBZnQ5?=
 =?utf-8?B?VzMzOGNZNmM5amh0ejhWSzZKVTJPVVdZd2RCV1Fabk5Wb3VBWldpS2tBeklX?=
 =?utf-8?B?NXNzRm0ySVBwUG0vQm0zUTQyT0g3K1RPbVVLaURjVmtvUnBTK1ZMcmdJdEJm?=
 =?utf-8?B?a1BHZW83ckRNMGNMMjZtNnZUMGxESHhud3dQb21ORFhMbVRMcTR6VVVSenUw?=
 =?utf-8?B?WjhWeE91L05VS1M0NUNMbTdUVHVuaHFRYXFnQXljYk5SaDh6V2VYMnQrcENh?=
 =?utf-8?B?MXZaR3RUOVgwREhKMldPWEhqcVB5ZnRWSnFGNXlzdEtnYlhTaXU4QVZFbFZD?=
 =?utf-8?B?Z3NYSkdGWE9xMkpUWU9zcmoyeGZGV0kvc1NocE14SzBZVmVLZU9EVTdFdW1E?=
 =?utf-8?B?VnF2cFlRU0hDbkhvZTlCRko5ekQvekJHdG50VDVVb0ZFdzJUN2w0OENXZFgw?=
 =?utf-8?B?YkRRQmVsSHB5ZU90d0ladXRZb1F0ZjI5eTRPRXpkMVhBNHhCSXdRSlVrcGhI?=
 =?utf-8?B?ejdTanZxcGZBQW04MUg5ajBuRGg5ZXdTMFZqUENCOW16TCtWY1h1UUFyaElV?=
 =?utf-8?B?eDZBcGdkT2MzdFpXMnU1TVhqUDV6c2tFL3pnY3NESWlieXRXRVJoQlJoMXNi?=
 =?utf-8?B?M3QzdjZjbHM5c1JsSUVLK1lxV0hZSlJBTWpSTWFMaTNxTXFhK3pic3l2WDJH?=
 =?utf-8?B?TEkwN3VPVDJqZWZRZ1g0NkIxN3ZHMXJHTXM3VmJFeXJZQjl5ZUQ2V2pFSFBn?=
 =?utf-8?B?TjZvTnBUSHhKY1Bya0M2SW5UbWQ0RkVrb2UzS0UxSnNmcFdNY25YZUdEQS91?=
 =?utf-8?B?b0o4U3oyNnYwUEF4NndsMDUwdHNUamtXSHBsY09GY3BxY3FGQlB1WGxxRXY2?=
 =?utf-8?B?bCtkUTBOdmZ2WnZyUVFZR3ZXL0tvWGJqajNQVnRyRTE1azVab1JiSkhMNFJY?=
 =?utf-8?B?ZnhRT1VXNVB4cGl2Q0RZZytuQkFacDBYVkNFejNpN2llNG5UNTRiRm9FQk41?=
 =?utf-8?B?T2tvMGx4bUxFaXgwNzhBSzNsWHNnU2VNM3RsV1YxRGYzaXZzdm9ETG5USzh6?=
 =?utf-8?B?bXRFdHdPVWNLZWxxR3JoV3cybGV0SU9RWDZZUkVIL2VpZ3NFRURDdEVuZUFn?=
 =?utf-8?B?NFFYVk51VWtxZTBVS3d0Ty9zaDNYTkc3YzZPT1BQdjZWUjZRQ25QVndnMWtt?=
 =?utf-8?B?OVM2WHc4SHJkSk9NTGxTam1GY3RrVk9tSngyUC9LUExRQnRCZ2U0L0RhU3c1?=
 =?utf-8?B?dmxFK0h3aFQzOVE2NTAzOGowSWYxOHhkYUVNQ3NVRGE4QXRCOEIvdXMySnBS?=
 =?utf-8?B?RGhMbzl1b2lwdWl0MTc5NnFnTFJ3b1VIc1Nyb3lnMUY0VEdGVzZhcVBUQmFw?=
 =?utf-8?B?cWNkNTVjYzJicDZuMjJzVW1DZ2JNaVdYRUtvQ1haQTdReFluOWYwbDVVU3pZ?=
 =?utf-8?B?UXg1NVB6eTNrVkxHSGM2NVArckJIRGplMXlzVmtPWDFIeXAwTkl0U1dvTjJY?=
 =?utf-8?B?azVBclBrelROUzk5aGoxbjI5Uy9LNkpRVGp0dGhzMWtUTGtCeG1VU0RQV2xK?=
 =?utf-8?B?dnlpTHRtVU5DZ2szNEJQamdCS2FSbVMyOGpWSHZCRnp5RU5mQWh3ODBnYi9s?=
 =?utf-8?B?UTZPemMva0xJeXlUKzdoNzRSeTB6ZGdVcURoaDZjc01acG00dEJ3alpJSmcy?=
 =?utf-8?B?MlQwcTlvT0ZqSUVIeU55aXUyNmk4VVVuM1ZXTW01WG9Dcy9tbGJub2xVYlg5?=
 =?utf-8?B?NXZZb09SbGtndGdNT3RGUjVIOE5nckVheXM3eStxeC9RdFFJOVY4Z2YzY21J?=
 =?utf-8?Q?ZtHExyqorUK1XuWzIqcOYgiQv?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e50fc72-7d5e-417e-14e1-08de1e5ee177
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 00:36:39.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4N6jhj9+b/5OM8ZvF1RAfsYIk5hDo+WZT3axzEOlxkphtqtSNMFfFRHZTqi572FZBpa7yCMroTA+nTllpPoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6304

On Wed, Nov 05, 2025 at 03:23:18PM +0100, Petr Mladek wrote:
> kallsyms_lookup_buildid() copies the symbol name into the given buffer
> so that it can be safely read anytime later. But it just copies pointers
> to mod->name and mod->build_id which might get reused after the related
> struct module gets removed.
> 
> The lifetime of struct module is synchronized using RCU. Take the rcu
> read lock for the entire __sprint_symbol().
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/kallsyms.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index ff7017337535..1fda06b6638c 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -468,6 +468,9 @@ static int __sprint_symbol(char *buffer, unsigned long address,
>  	unsigned long offset, size;
>  	int len;
>  
> +	/* Prevent module removal until modname and modbuildid are printed */
> +	guard(rcu)();
> +
>  	address += symbol_offset;
>  	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
>  				       buffer);
> -- 
> 2.51.1
> 
> 

Hi Petr,

If I am not mistaken, this is handled safely within the context of
module_address_lookup() since f01369239293e ("module: Use RCU in
find_kallsyms_symbol()."), no?


Kind regards,
-- 
Aaron Tomlin

