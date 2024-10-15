Return-Path: <bpf+bounces-41960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D499DD64
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 07:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52C01C21311
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C404175568;
	Tue, 15 Oct 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LN5yela/"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C79166F1B;
	Tue, 15 Oct 2024 05:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969041; cv=fail; b=eUWq3UPqledMavNptH+EsjC5fnEcvUIo/u0oZyjZ+HsCMZtPoBscH89tBSTwlszBY4/Tt/MrrLuodzOQRdh0eMqjIxQD1e3rE++8RVezYkepTKU92/jdxphYcoWe1UlODF8p5P08srb/T1x0l2I4O4V4eLKH3snbklM/oti4FMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969041; c=relaxed/simple;
	bh=V5c4R8bERyDGwVpK4NvkjUNFJ0AlQnLN6vjJyXdM4fo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEy5jyrAizTg4vGK48MH/6OXQDCZ5ER2b/ZiN8pYSKqtRHmCz4CsOcKU4wg2cQVvhPVHnNfsTx0ISEL+oamEZCL99eNKHu7jGZLsAjy0r6FEPMoIVCBptOLX2qyZu0J/yxrfujUna2S6YZmI1S9/lihVkRk7nzzCTWjLDtXv1A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LN5yela/; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sflmn6yveUZ/dYqLb/mXbvArKG5QOCo3Ze+NnNQUPFoWlvgc+ZuCFhZs7E9ZDeTKCtiVv1Vvy5uQqR65nlE/PPxk8J7LTN2Qud7rXpw7TWQCkqhjnoik8MSIvdgYMxKWXEWHKBvqX0ndAgJ4+8dyS8prkRcjZjG3vkPE31swLbJmFmKJa10UxmL46KHmrN6meh2w3h9ZCyFBaciawXzi465AS66+QBHaRmAPnEtm+dkThQDdRtIrBJGfcheTtqBE11MX2E50WYVcgWvOJGlydyYfKuxs5YREFj31GA9ZcIF4Ghwkl8SDgQXx8P9pONwgBkK9nJwVGuPiHX0DCxe8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qmG3914WUeQLLwZ+RvvDbzk6pOSoFVlfIghD7K1zZQ=;
 b=glzNpZgUzH/Xpl+YDi8Nx6H9d4pnCu8zuJq1BPDzZtnSFp9UQSDofNtVEMKCP+4kbPdLF5jgkeDYAn+OmoDk6s6A/QVM4+Vw8sTPBlhRJyMiT0Pi9cAsF3/IUMUn5t8nVdhUDUeBsENx24Xzk0ec+WKh/vK5HFrvAsMfimbkF+0F3bSUNFrSuAbqm8vO22mKDBcQE4+lTDZy6TyV5hZxu9C7Z0P9TirAIJvTJweGj51gP+jGWVmATHmQgAhrv/hSpNjvoiOgu+a9ouyPyiK6hNv0AWIELb6iLhyZ7yS0VMT3dCi1zGka1AnoE8pWKcANl3el4K0Vaq0+pf4p0CEScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qmG3914WUeQLLwZ+RvvDbzk6pOSoFVlfIghD7K1zZQ=;
 b=LN5yela/olZJL8Y/saGFEVKcGcaPrLw2aS6Bypl6jX711N5xOrauIe6XVF5khJeAuBiCJvfGqiDUz9623eFLBW2Ihptm8NQzVczelJXGD0ymLkiZRYDgdFsIqPOCJTly/lkOTx+yYMIRJDs2NvmgrF7uiJmG/44N4r8l71SJD2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 05:10:36 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 05:10:36 +0000
Message-ID: <72ab4701-3d40-42d3-a26a-a0d76fbe27ca@amd.com>
Date: Tue, 15 Oct 2024 10:40:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 05/12] srcu: Standardize srcu_data pointers to "sdp"
 and similar
Content-Language: en-US
To: paulmck@kernel.org
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, rostedt@goodmis.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-5-paulmck@kernel.org>
 <d0ec401f-f857-4fbb-89f3-f2d13eb34b5d@amd.com>
 <25cd96f1-6d4d-4dba-b57b-da63d228ba97@paulmck-laptop>
 <e63311e5-4311-4b08-abcc-8298a22c52f4@paulmck-laptop>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <e63311e5-4311-4b08-abcc-8298a22c52f4@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::35) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: a19b3ad7-ecb6-497d-9176-08dcecd7b410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SCtiUkh1OVB5MHcrTnl5ZHdSUFptZWhnRjE1dDdqMFZJb2RMYnd0T1U2SUdr?=
 =?utf-8?B?aVNjNm5WT2o3WVFtZEZJNnFST2lGeW5NUG1kTW84b0Z1WlN4WTErdWM0bFJ2?=
 =?utf-8?B?U2RPQVVobXZnTlJaaE5KS0tyVDRqRXdUY3h1N0VRNEdhVWxlL2VhbllmbCtv?=
 =?utf-8?B?SXl5SWUwSE5YZjZMQXRjT05HTWJvaHZGVVk1bEhmRmh5MlIyWWUwaWdBc1di?=
 =?utf-8?B?cEtJRkU2WmhQb2dVWUl0N2RDOXFxVXlYdXRGOTBzY3FyTU03TjNERDRUdXd0?=
 =?utf-8?B?TVQyNlFNZXhmdTcwaW9yZDFEeml4ZUhUTHJUSXpOMXFaTGppdldmQU1FSzk4?=
 =?utf-8?B?aVVET2NJMFB2emE1bTdWYkhFM1BrQkJHNlVXVFFnbE5zdG1RdUtpUjRwNnpU?=
 =?utf-8?B?TElidlc1R1pTWXdlSzNQVFVJS2l0VEh1WVVFT2YzbjBabC9UdldaQTkzMnVD?=
 =?utf-8?B?NEtKMDhZYXRvVllYczcrYmlIYnBoTXJkY3g5dlZhMU5mT0tuSlptOUdHOUpH?=
 =?utf-8?B?NERGc2J2TElLaUtDTms1Q1VSeCtFVTV6c1huNWo4MkNQbFk2MDRhMHZMUDA0?=
 =?utf-8?B?Rlg1QnphQks3TlloeG5ZK0RSMFo4YXNMY1dNRXNRWkRTY1VRVU1IRy9sQTdt?=
 =?utf-8?B?eXBGdzlRcVN4N1NsZm43dUFvMFdGT25TMmoyVEJSOWpDTWdmQXpxV3pZVUVF?=
 =?utf-8?B?eDBaT01xeGlNenFhcTY0UnBGZnA1bExtRmVqMS9BcTdaencxV0lXUTVkbkVB?=
 =?utf-8?B?L0N6Wnl2bWN3TnZ3RU41UTBsRlNjZHIwNElQMFc3SEFhSk5KQjF2cVJ4aUtB?=
 =?utf-8?B?eHcyaUd1NFpBVktPazV6cHRncXFyN3J1bndDWlJLdXd1d2hmSm1jaDRUaEhM?=
 =?utf-8?B?NnFWQ3pEeUY0bC9jNFMxUFY1YlVZNlhQNlE2b245WTNNb2U4dWpJR0IxQ1E4?=
 =?utf-8?B?UjdzQlZmdlgzWmJCamdXSHpoNHdjRUlSOWRQbHk0WjJHZTdhZllkcjdiemxm?=
 =?utf-8?B?VjF2dG9YQWViQWpNN1BkR0IxUTZFeGVXWVBqeisvWU9pN1p5SXRSc1BQUG5j?=
 =?utf-8?B?bHhBSnZabDVoa3RpVTFMOHEySnRycU0wWUlYMlBpc3JMSEFGWEdXUjkxTG5C?=
 =?utf-8?B?d3F5d3VZVDdrb0txOTJKbFhPNVd2V0ZCWDl1SW0rZ0s0czUzTkJLdEFtUWg2?=
 =?utf-8?B?RU9Ja2xPZ0RWQVFRVkxLRUNqYXMwTTduMVhMc1VVS014MUszclhBeEJGVHU5?=
 =?utf-8?B?TmRoc1dDSlM2M3NNR0J5RVgwU3dMaHZCdEdlLzhkaXVXNy9LQkF1U0lGTHk4?=
 =?utf-8?B?NHlhOG9BVkh0V0tHcnQ4Y1VxcGVKdjhZNXFHeEJZbDNpQUlKZFZkTndvZDlS?=
 =?utf-8?B?L3p3YThORDFFa2I2c2dCYlRFZjV5NUtGVUxJQjJWMWFkcDdJcnJoczFQUEZM?=
 =?utf-8?B?SElFOVh0eG85RWdSd1RaRU84TFhSMjJzbG1PdEsvOWhLNE5ZUEk0N3g4bkRa?=
 =?utf-8?B?OXdldXJpK1N5ejhSY2Evd3N2dW42R004UmpXV09xT1JHdWF4aE94STdKRE12?=
 =?utf-8?B?RXRvM3R3Si9uckh1L2QwT2xqT04vSWVjY1FZU1BpWmFSdS82b2IrTjJQMGdP?=
 =?utf-8?B?NzFxNHc3NDdlZWZCRUJUWDA4YVZlQjgyS0VXby9YTXpTTkJ3TUZ4L0ZvU1Bt?=
 =?utf-8?B?dFlGVUpKUVliUVNYTGprZE9FY0NPbWhybWJjZ2syQmR4WnJzY1UxVWtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tkc1VzJhZW5tbUFTRGhVQU9uMm1STWIwYzhBNWJ2bVFjMVRnTEhVQ3FzaHJP?=
 =?utf-8?B?Z2tKNXpWaFozZ1RQdzBPUis2ZmJlRE9UZW5pMEJwdUtheml3NXN0dnZENWND?=
 =?utf-8?B?TWlhb2pYUk0zSXdmVzE1Ny9XZ3Jwd1pVRWFpYmhyY3V6SmR0c1hOZmN2N2Nq?=
 =?utf-8?B?ZEp3UDVYT0hjYStxNzV1OG9XblY3ZGlNbnVpclhPTGlRRmxkTjNTaml4NE5t?=
 =?utf-8?B?MStiOG1EUm5SRm16clBMYzFOb0V2dlZjRmU0YUlpMUJTOEdENjVIWkNSTmlh?=
 =?utf-8?B?a0ZJd2JHa0lWOEd5UFJvZkd6cUZNbWNZRWxwaHpqYW5PK3BEWHpMZ3lBQ2gz?=
 =?utf-8?B?T3NNcCtjVEY4VGVMcnAvUGgraUxJbHF0SURvVUU2MElPK1pEN2JWMXZzbkVw?=
 =?utf-8?B?Mk8ybHlFNHIzVXdVcWxjMy9kc3ErdjZZSmQ0U1VhZGNNWm9KM0xNMjBBSHJm?=
 =?utf-8?B?TytCQzN2VVFiQXpZMkkvU0d1TWJjSWpZNGtzbE8vNGRXcS9YTkRTa2YrS0NR?=
 =?utf-8?B?ZC9JcERobWFtNTFUbmdNMWZHc1M4KzN2QllxcGFjT3BmZk83YWhMSEdRSk1q?=
 =?utf-8?B?U3hDNjNHTGszQnpuQU96eDZ5aXlBQStVUDAybGJkbWtmTFBjMzBENi9BQnNt?=
 =?utf-8?B?bHdsNGVhanJCeTd0YXRZMXlvVktFN09YOGNjeVgvYlp6eWgybzhZRmV0QUdZ?=
 =?utf-8?B?eklhNG9zVXQzdFM4ZXkrMW9QQlYxOTVHMDVYMFZFU05DZENDdzdhakRob3Zn?=
 =?utf-8?B?c2Z5b3lKa1Zibi9xWW9IZFZnTy9JajhLTVF0d0lEN2NnclVrTDV6QXNjYmRy?=
 =?utf-8?B?cDFPTE56SHpYVS9PT0NsMjlUK1V6TTBjYm5vNW1pSTFob09CQUlGenJnYTA0?=
 =?utf-8?B?U3lrT1RUYU8wM3FNSWhLbXFhMU9sOHVtbjhLWGh1U3k1N1d3d2dHakhKTXUr?=
 =?utf-8?B?cm0vVU5LYWRjM0pQN1ZiUzl5MkVSdEdwQVBrbXQ0WC9WY09ZWWpBOUIxTjVl?=
 =?utf-8?B?RW52QUVaNkNKWjRUZHI2UzJRR29xZldUem8rSTdYcGpJMExQVENaYkdYMUpk?=
 =?utf-8?B?OUMyVW03eGlvUWV6S05EcDgyeDh0dVh4VitxWkpUOVduRkNwbHlnSWZSN0tZ?=
 =?utf-8?B?VjlyU1QvSnA3TG5qMEpqMTZlaXFDZU1KRHFRY1hOUkVraHJSRmlUWk9pWTZT?=
 =?utf-8?B?d3E2N1h3QndKblE2RjdGYWQ3REk3UHF3L0FzamsxTlhGWnRDSHZScCs1WWZj?=
 =?utf-8?B?WUoxcUJ0YUlOSzBEU0ZoVnpSaGNYbjVJZllibTdsbEd1dVhHTFVFWUpVSDN2?=
 =?utf-8?B?Q0UxeURCbFZtcXZYOHFLTG1jTUw4Z003TnJsdHdsanhjbFhOcUZ0QjIvU2d6?=
 =?utf-8?B?amRWQ2dOVHk3WHkrZGgySG5neGdNRm9LVTRqaW5RRGUzMFQ1ckdVZmpIVEZo?=
 =?utf-8?B?K3VIdFhUV20rL1hGWTdWdzVtTjJ1Zkp5bjR6ZWZqUzRBbHBVTEtaS3VqK3NC?=
 =?utf-8?B?UHBoVThodThKK0UwQjNFR2ZPQVJpdWlaS1huSTZ4NCs1VnM1L0F5eUhBR2lY?=
 =?utf-8?B?V0lhL1hYS0t4b2MyWVZPRGU0S3o3UEg0M1B5bWVzZkpZbHc5ZzhFcFl5MWNS?=
 =?utf-8?B?b3Bhd1VUSS9UaUJweDJoRU9raEpYdWpwOWZ6bGs1b3hqdWduMi9ZT0VhcVkr?=
 =?utf-8?B?TlZadTcyVk40czJ4bCtjbGNkTTNzdVdFb3pEVU4vbW1kdSttdTdKWXhIeTk0?=
 =?utf-8?B?R0pCOEh2TTJTT2IwK3R0QWJyY01xSllndHF0bWQxTUdMQzV1UGRBT3lheWUv?=
 =?utf-8?B?dW5uWW9xUWQ4WG1MenIza3ZUVEdOanF5NlRsdWRtck5IUUFaUkJCTk04MzQx?=
 =?utf-8?B?TTZub2Q2WnpmNnk5bG9Va0xjN0lvV2RVR3oxMysvWmNzZUU0WU9oY1BtSW5H?=
 =?utf-8?B?cEl6L0NBbG5xRENWVEhRdzdZTWQydGthT3NqVkMzNCt6VXhYd3NBaDZVbUZk?=
 =?utf-8?B?N1hyTkNJSVE5dExDeFdTc3NaelB1NWlnRzYydmxEbDRRNzgvL2VVKzJ0eDM1?=
 =?utf-8?B?M3NRUFZRTy9mZzk2SFZxVExtZ2pWRU5XbEdZajdXODNIRGJJVEpoL1BlbzhI?=
 =?utf-8?Q?NwKV+ivHATx8NmUTQ4kzt0HvZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19b3ad7-ecb6-497d-9176-08dcecd7b410
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 05:10:36.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phQHmXrYi5+GyunkcqCsJGU78Pxqvh2IjDLO7XgS+WkajTSoxLgNDIhfE2kgkcl8fYZGAj3B/8kySe6nTzqZ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973



On 10/15/2024 5:59 AM, Paul E. McKenney wrote:
> On Mon, Oct 14, 2024 at 09:49:52AM -0700, Paul E. McKenney wrote:
>> On Mon, Oct 14, 2024 at 02:45:50PM +0530, Neeraj Upadhyay wrote:
>>> On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
>>>> This commit changes a few "cpuc" variables to "sdp" to align wiht usage
>>>> elsewhere.
>>>>
>>>
>>> s/wiht/with/
>>
>> Good eyes!
> 
> And fixed.
> >>> This commit is doing a lot more than renaming "cpuc".
>>
>> Indeed, it does look like I forgot to commit between two changes.
>>
>> It looks like this commit log goes with the changes to the
>> functions srcu_readers_lock_idx(), srcu_readers_unlock_idx(), and
>> srcu_readers_active().  With the exception of the change from "NMI-safe"
>> to "reader flavors in the WARN_ONCE() string in srcu_readers_unlock_idx().
>>
>> How would you suggest that I split up the non-s/cpuc/sdp/ changes?
> 
> As a first step, I split it three ways, as you can see on the updated "dev"
> branch in the -rcu tree.
> 
> Thoughts?
> 

Split looks good to me!


- Neeraj

> 							Thanx, Paul
> 
>>> - Neeraj
>>>
>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Kent Overstreet <kent.overstreet@linux.dev>
>>>> Cc: <bpf@vger.kernel.org>
>>>> ---
>>>>  include/linux/srcu.h     | 35 ++++++++++++++++++----------------
>>>>  include/linux/srcutree.h |  4 ++++
>>>>  kernel/rcu/srcutree.c    | 41 ++++++++++++++++++++--------------------
>>>>  3 files changed, 44 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
>>>> index 06728ef6f32a4..84daaa33ea0ab 100644
>>>> --- a/include/linux/srcu.h
>>>> +++ b/include/linux/srcu.h
>>>> @@ -176,10 +176,6 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
>>>>  
>>>>  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>>>>  
>>>> -#define SRCU_NMI_UNKNOWN	0x0
>>>> -#define SRCU_NMI_UNSAFE		0x1
>>>> -#define SRCU_NMI_SAFE		0x2
>>>> -
>>>>  #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
>>>>  void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
>>>>  #else
>>>> @@ -235,16 +231,19 @@ static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flav
>>>>   * a mutex that is held elsewhere while calling synchronize_srcu() or
>>>>   * synchronize_srcu_expedited().
>>>>   *
>>>> - * Note that srcu_read_lock() and the matching srcu_read_unlock() must
>>>> - * occur in the same context, for example, it is illegal to invoke
>>>> - * srcu_read_unlock() in an irq handler if the matching srcu_read_lock()
>>>> - * was invoked in process context.
>>>> + * The return value from srcu_read_lock() must be passed unaltered
>>>> + * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
>>>> + * the matching srcu_read_unlock() must occur in the same context, for
>>>> + * example, it is illegal to invoke srcu_read_unlock() in an irq handler
>>>> + * if the matching srcu_read_lock() was invoked in process context.  Or,
>>>> + * for that matter to invoke srcu_read_unlock() from one task and the
>>>> + * matching srcu_read_lock() from another.
>>>>   */
>>>>  static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
>>>>  {
>>>>  	int retval;
>>>>  
>>>> -	srcu_check_read_flavor(ssp, false);
>>>> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>>>>  	retval = __srcu_read_lock(ssp);
>>>>  	srcu_lock_acquire(&ssp->dep_map);
>>>>  	return retval;
>>>> @@ -256,12 +255,16 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
>>>>   *
>>>>   * Enter an SRCU read-side critical section, but in an NMI-safe manner.
>>>>   * See srcu_read_lock() for more information.
>>>> + *
>>>> + * If srcu_read_lock_nmisafe() is ever used on an srcu_struct structure,
>>>> + * then none of the other flavors may be used, whether before, during,
>>>> + * or after.
>>>>   */
>>>>  static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp)
>>>>  {
>>>>  	int retval;
>>>>  
>>>> -	srcu_check_read_flavor(ssp, true);
>>>> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
>>>>  	retval = __srcu_read_lock_nmisafe(ssp);
>>>>  	rcu_try_lock_acquire(&ssp->dep_map);
>>>>  	return retval;
>>>> @@ -273,7 +276,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
>>>>  {
>>>>  	int retval;
>>>>  
>>>> -	srcu_check_read_flavor(ssp, false);
>>>> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>>>>  	retval = __srcu_read_lock(ssp);
>>>>  	return retval;
>>>>  }
>>>> @@ -302,7 +305,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
>>>>  static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
>>>>  {
>>>>  	WARN_ON_ONCE(in_nmi());
>>>> -	srcu_check_read_flavor(ssp, false);
>>>> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>>>>  	return __srcu_read_lock(ssp);
>>>>  }
>>>>  
>>>> @@ -317,7 +320,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
>>>>  	__releases(ssp)
>>>>  {
>>>>  	WARN_ON_ONCE(idx & ~0x1);
>>>> -	srcu_check_read_flavor(ssp, false);
>>>> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>>>>  	srcu_lock_release(&ssp->dep_map);
>>>>  	__srcu_read_unlock(ssp, idx);
>>>>  }
>>>> @@ -333,7 +336,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
>>>>  	__releases(ssp)
>>>>  {
>>>>  	WARN_ON_ONCE(idx & ~0x1);
>>>> -	srcu_check_read_flavor(ssp, true);
>>>> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
>>>>  	rcu_lock_release(&ssp->dep_map);
>>>>  	__srcu_read_unlock_nmisafe(ssp, idx);
>>>>  }
>>>> @@ -342,7 +345,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
>>>>  static inline notrace void
>>>>  srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
>>>>  {
>>>> -	srcu_check_read_flavor(ssp, false);
>>>> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>>>>  	__srcu_read_unlock(ssp, idx);
>>>>  }
>>>>  
>>>> @@ -359,7 +362,7 @@ static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
>>>>  {
>>>>  	WARN_ON_ONCE(idx & ~0x1);
>>>>  	WARN_ON_ONCE(in_nmi());
>>>> -	srcu_check_read_flavor(ssp, false);
>>>> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
>>>>  	__srcu_read_unlock(ssp, idx);
>>>>  }
>>>>  
>>>> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
>>>> index ab7d8d215b84b..79ad809c7f035 100644
>>>> --- a/include/linux/srcutree.h
>>>> +++ b/include/linux/srcutree.h
>>>> @@ -43,6 +43,10 @@ struct srcu_data {
>>>>  	struct srcu_struct *ssp;
>>>>  };
>>>>  
>>>> +/* Values for ->srcu_reader_flavor. */
>>>> +#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
>>>> +#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
>>>> +
>>>>  /*
>>>>   * Node in SRCU combining tree, similar in function to rcu_data.
>>>>   */
>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>>> index abe55777c4335..4c51be484b48a 100644
>>>> --- a/kernel/rcu/srcutree.c
>>>> +++ b/kernel/rcu/srcutree.c
>>>> @@ -438,9 +438,9 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
>>>>  	unsigned long sum = 0;
>>>>  
>>>>  	for_each_possible_cpu(cpu) {
>>>> -		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
>>>> +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>>>>  
>>>> -		sum += atomic_long_read(&cpuc->srcu_lock_count[idx]);
>>>> +		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
>>>>  	}
>>>>  	return sum;
>>>>  }
>>>> @@ -456,14 +456,14 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>>>>  	unsigned long sum = 0;
>>>>  
>>>>  	for_each_possible_cpu(cpu) {
>>>> -		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
>>>> +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>>>>  
>>>> -		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
>>>> +		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
>>>>  		if (IS_ENABLED(CONFIG_PROVE_RCU))
>>>> -			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
>>>> +			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
>>>>  	}
>>>>  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
>>>> -		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
>>>> +		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
>>>>  	return sum;
>>>>  }
>>>>  
>>>> @@ -564,12 +564,12 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
>>>>  	unsigned long sum = 0;
>>>>  
>>>>  	for_each_possible_cpu(cpu) {
>>>> -		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
>>>> +		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>>>>  
>>>> -		sum += atomic_long_read(&cpuc->srcu_lock_count[0]);
>>>> -		sum += atomic_long_read(&cpuc->srcu_lock_count[1]);
>>>> -		sum -= atomic_long_read(&cpuc->srcu_unlock_count[0]);
>>>> -		sum -= atomic_long_read(&cpuc->srcu_unlock_count[1]);
>>>> +		sum += atomic_long_read(&sdp->srcu_lock_count[0]);
>>>> +		sum += atomic_long_read(&sdp->srcu_lock_count[1]);
>>>> +		sum -= atomic_long_read(&sdp->srcu_unlock_count[0]);
>>>> +		sum -= atomic_long_read(&sdp->srcu_unlock_count[1]);
>>>>  	}
>>>>  	return sum;
>>>>  }
>>>> @@ -703,20 +703,21 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
>>>>   */
>>>>  void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
>>>>  {
>>>> -	int reader_flavor_mask = 1 << read_flavor;
>>>> -	int old_reader_flavor_mask;
>>>> +	int old_read_flavor;
>>>>  	struct srcu_data *sdp;
>>>>  
>>>> -	/* NMI-unsafe use in NMI is a bad sign */
>>>> -	WARN_ON_ONCE(!read_flavor && in_nmi());
>>>> +	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
>>>> +	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
>>>> +	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
>>>> +
>>>>  	sdp = raw_cpu_ptr(ssp->sda);
>>>> -	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
>>>> -	if (!old_reader_flavor_mask) {
>>>> -		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
>>>> -		if (!old_reader_flavor_mask)
>>>> +	old_read_flavor = READ_ONCE(sdp->srcu_reader_flavor);
>>>> +	if (!old_read_flavor) {
>>>> +		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
>>>> +		if (!old_read_flavor)
>>>>  			return;
>>>>  	}
>>>> -	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
>>>> +	WARN_ONCE(old_read_flavor != read_flavor, "CPU %d old state %d new state %d\n", sdp->cpu, old_read_flavor, read_flavor);
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
>>>>  #endif /* CONFIG_PROVE_RCU */
>>>

