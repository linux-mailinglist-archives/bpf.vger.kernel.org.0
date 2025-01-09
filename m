Return-Path: <bpf+bounces-48485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E0A082BB
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 23:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 098A47A369B
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62020551F;
	Thu,  9 Jan 2025 22:22:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F101F8F08
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461320; cv=fail; b=ch5/hu1VimqmVIVgephQ0JUcTMqwdNFudHlvED4WjJMWAa0KbrKvVFdiCpjxS+uX9/W9tHkRobQhjD9EgWEa1yfCqrY/z2Sb62PTgegsumu2OUK30mrtRuQli2625pq+E2hGHLMFglGLr5d/7IsGpWbGzmL6sBmcV68NAl2RHUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461320; c=relaxed/simple;
	bh=fq/wfoW+v70T8xM96upE0MCDbYhpTTuyCpltkrGbHSM=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Yg/5rea/KufchrgNgjst5Pa1qsNPJXwsLcrOH3AablXpV8xp/ADx5vjv2HnD+jEZ/RwkM7+JjhO08m1xoUK79G0ENNsKjRKI7CdGCypMV+C2VK9SFkQGMjMqWwrAQTJeMxGffDItmPpjBPOi+tkkCjuohng2DPvyiAq/PAh66kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509DSNwu007433
	for <bpf@vger.kernel.org>; Thu, 9 Jan 2025 14:21:57 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 441fkpacb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 14:21:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWzWS4nGADCFR6pSFrxFtGN+yxlUGdPobntXMyR6HdR2qvTVbRQ2WXd7ii/HyDoRcbFfNZ0NMwTQGUd0/Q9eG1uL9SLnQ+akwBsYxRRrRACf9xvpRA1K5DRNI+Dcow/IlnJ+Xfevxr0zlsGp+mAgJlCGJlDG9UC/rrd4MNQZaMaslPdu8L8BRDQYr/i/4P2ORynYIzAocQtm7V92DZJuGURidvzED8BR4uQ4a01PhObkp6wAWkRxw98GP4daYK/x3R/1BvFI5zg21BHAjQ6Lsv7EAPMlSAniMosXNlNWmpb7tyxcj1CXs6USi31fieSL33gZPjUfuK5NOtuMqyHNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmlE6efTlC/RyTR/WylskJAY7e7LmT9I0l9ZyrQjQhA=;
 b=t5Gi4gLfqclL2ebCRFN41fv+6PN8prmMAJmZjj/p1TV9y/Ybcyp69F0q+FXzhI6AINc3dg9+/8fwV9+ZlbU0s7i85RLmf8tMPQHsQd4nhYs2ccD4Wyjkktsc55yAWXHDtNYU/KlYIuJy0ZgLKixGqfFlqnw4T4kvj2v0Qe8qylIe4EYxHdfoaDT7FE9EpiSL5+FkSgXU6S1b/iFZudccdB89Xd+YofAIKwSWkbVCy8ryE1+KDv1FqgUpwA9+P4RdysdkM055xjKw1k2ovoY7JRfY2s7soM3LXNevkViO4jDlJFVd5B38ItuSviR58ETBd6kar3MU14uhELphOtIvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by BY1PR11MB7982.namprd11.prod.outlook.com (2603:10b6:a03:530::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 22:21:53 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%7]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 22:21:53 +0000
Message-ID: <48d18ecf-41eb-4025-9bec-1dc606f343c3@windriver.com>
Date: Thu, 9 Jan 2025 16:21:50 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf@vger.kernel.org
From: Chris Friesen <chris.friesen@windriver.com>
Subject: status of BPF in conjunction with PREEMPT_RT for the 6.6 kernel?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0062.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::17) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|BY1PR11MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 641bfe73-0833-4ee6-37b5-08dd30fc04d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmU1aE5uVkJZQ3lSUlVLcHpvYXpiNnpDV29jNTJXSUIvUFJLOFI0KzZMVGNF?=
 =?utf-8?B?YXBiMGdNNFRIL2k1QzJJeGxRTDkxSHRIR3hSOHRIRXlBVlBuSzVkSnFidTU3?=
 =?utf-8?B?RlJLVVpndFJpemhvQmw2Ui9qanZmdktuWjh0UUY1WFZXdTdlSkVMaS9NV21a?=
 =?utf-8?B?UHl3aUo1MU9JTnVJMm1jd1gzOFNmaXVGUnh6RDR1RUoyamdWcXVZRWU0T0Y4?=
 =?utf-8?B?VWl1ZmIvYnMwWjNYcnFSb1FjR1JnN0hrRHAxc3dSbHQwVy9zajZQTFZZZkpN?=
 =?utf-8?B?elV1V1pTK05oRXB4OVdMeHlNM3Z1V0k0elBhRHcvNmhOdERIR0I1VWVURjlk?=
 =?utf-8?B?a3JIZWxKU2N6SHUxTlZ4d0dUbVFBWk5BSE9lYnFuOGhoMnlGeUlOaHptV3cv?=
 =?utf-8?B?cW9KVVQzaUxkazBaT1dxUnZFOTFWejdjUWxSWEVXem5JbGY1ZjVwaFVPdHVX?=
 =?utf-8?B?N0pZbjE5Zm1EQ0xtdW1CWjUzVDJSNThjQ3FrYXVNVlBHSmJZZ1VMaXdrN0NC?=
 =?utf-8?B?ZkRiZkliMEdRdHJUMHRzK0dlSFljVDlXNDVpSmhMUEd0d0szWG5DOWF3QVk3?=
 =?utf-8?B?TzhKemd0bVdPVzU3Y3pJWFJOV1U5NjJ2K3cxa2ZkVEVkQURHb0lHYzNtMGlp?=
 =?utf-8?B?SnpWVVJ1TlNPYVZRVyszWmI5aDViQXFxQW1DVHFObTQ1S293R2MyeFl1ZW9m?=
 =?utf-8?B?eFpMUGZpMWFIVU1TcWgwbURNSUlXR0p3Z1h0LzhUSGJNc2hRQnBhb2tlTkd0?=
 =?utf-8?B?U3BGTXg1VlQ0eHRxUWJqM0piUVVVOG1ITUhYRFRKd21HNE1LRUNjclFYQmhv?=
 =?utf-8?B?TDU1WXhKOTVPZ2ZmY1Z2cjc1SUVRVU0rRlphdktwSWc4NHNNalRNUi9VU3RD?=
 =?utf-8?B?cWZCbFJlMGJjdVJSNzRiNGNiWEpvTEJSbjVVWWg0WUhhSGt5ZXU0Q014ajZ4?=
 =?utf-8?B?eHUvUU9wakhiRVFRanNSb0M1TGYzRXFJQ3RicGl6Tk1STVhHZ1gyVlR1OWx5?=
 =?utf-8?B?UHNEL0FMSW9KelYzMUYrV0htbUZnaXFpdE1VRE1NbE9UaEVScTIyUEg2dXM1?=
 =?utf-8?B?UmV5WlNKeHhUeGYxd2RPRENsRlJmeWs3WEp1ZjA0eEY5OWtqNCtuNENvTGRK?=
 =?utf-8?B?d1dkMHJJWUYzOFpKWWtIK2w5RmFLOVBPTUkzQ1ppbk85NzNUWFdUUjRhN3V4?=
 =?utf-8?B?eGNYeFdZVHE4SW9VeEg2b2p3REYyS3FSM1hWVTFJaWtYcWFrcVB0eG5LekxX?=
 =?utf-8?B?RUN2Nk5CMFlnSlJOVHI0WllFUjBaZ3FybisrQkYvMUFVRmEwM0twRGxwUTJI?=
 =?utf-8?B?ZzRTSCs3bGNROXZRdUZ1b0ZNQkZBZjBxTjlselllc2VqaHNXOVZadHhHaE1R?=
 =?utf-8?B?M2o1T1RSKzN0d1l3RnRhL1VJME1PSjJVT3RLUjV1QVhEdjYzMlF3TDVCNVhQ?=
 =?utf-8?B?cDdvQUs2L3JlNk9uZ1BQM1ZxYlUvUGRieDVpYVF3NXc0Umw2R051WVdTcFZN?=
 =?utf-8?B?Vy9VNTFET212RUdyUUJmU1VLSnNTdmE0WkI2OWVrNUwyajVJQTUrN3ZVYzdH?=
 =?utf-8?B?UE9IQ2ptVXdBZUw3ZUhISGU5ZWo0Yi8vSXhWMVJtWGROK2UxdENZY3M5ZWp2?=
 =?utf-8?B?Um90UEdITUs2N0htQ1ZtRTBEKzVOemRyRE5FbHl5TDE2Mm9WYjlRSDl1TkJw?=
 =?utf-8?B?Vm5rcFBGdkJQY1JxQkVKNm9mUFVyTHZNRXNyWEdpUzNJeFE2c2E1dGIybE9G?=
 =?utf-8?B?aXVsNlhScWsxUGJKNGRwTy83UkZwWDBYb0xVVkJ5bzhFVU9vMHpYNThRSVJj?=
 =?utf-8?B?dWJtY1hlMEJRaXJCc3F6dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUFOSGsrQXZlWHBiRU5JMUQxMFFWV1EwMjdqWFptclkyL2FPMjhvSEFtQmhO?=
 =?utf-8?B?a0RVR3FTRytCUlZoTHN0UlNGT1RGTzgrMVVLWGxaTlMrbDhyTzI0QzlvOTN5?=
 =?utf-8?B?ekVhUWpXZUpuS0dDN3puRjJCakRRdndDQ0dZUG9ZSUpjK1E4cXRnTnFnUHIw?=
 =?utf-8?B?QWZlOFFhU0gwM0VPWENqY0pzYkFSZVRlS1FhUFJ0V0FOZDRMajJ3Y1YrRzln?=
 =?utf-8?B?YW1pZk5IcEZwUWwvYjlKeDdULzNwaXo4WDdCdmZub1NDQkVoSDlxSlFTNkly?=
 =?utf-8?B?NVJBOExtR1dxZ2pUQjRKc0ZjU0RMWFdPaHhmNXJIRkkySHZBOElkYXBaUzVZ?=
 =?utf-8?B?Wjl2cjRFczJzS3NQTitXY2hOWDdNSU9RSktjMEtFL1JnTDRiT3ZIZzh3SEkx?=
 =?utf-8?B?ek5hYi9raFdEcGZ1RTRRQnBaejljOVNNajI5K1llNUdyZ3IyakMvQ0tsbTNN?=
 =?utf-8?B?YkE1bFN1Nm93S3YvRHZEV3BMWmowWW1zNFl1enpwUi9FV2RDV2h6WFdleGdQ?=
 =?utf-8?B?OHRMUjVGUWl2eUU2VkVwb3lCVEhvMUI2UXJVOWxSaFlrdytKRnhGVGlvRGR1?=
 =?utf-8?B?MVZJS1E1QVFGZE13L3V6MXhZOStucWpUSjIwNXZMdldUeGJJZ1JTd0VOS1Zy?=
 =?utf-8?B?NENRdUYwcmQ2MDNOU1puSjRZUHNSVzJUYTM0MHB4M2dLbFFKZldYdUdQYmhP?=
 =?utf-8?B?Mm1PdmVGM0ZaTGY4VHpaenU2clN0UXZUaERIVm5XdElRVVpiYXhKN2tRenJO?=
 =?utf-8?B?OWk0clpNaHR6cHl3NUZ6bkdyTS9iNy9tREsrTjk2aXgvaEg1QWJVSjV5eTMv?=
 =?utf-8?B?SC9EZWRjUGVPZzZhUEx0NENCRyswZkFwby9Qc2hDSklwQ05MR3BrYkJjY296?=
 =?utf-8?B?SEUwbnJwRUJOVm5LWUNmZGFqNlFsUGZEYjY4Ry90ZVprc3hia2YwQ1RnZERZ?=
 =?utf-8?B?Q04rNmdVcTFhVUozbXJwc2M2YUlNd0lSNitMbmJtVkZzdmJ6cUdKZGtRZWJ4?=
 =?utf-8?B?QWtnb3NNOTU4WVJJL1M1a0Jja3JSYmFwaW5wWUxiV1lxRUFVRUxWVWVkT3Zw?=
 =?utf-8?B?TmFYcWo2VHB3SDF5NlQzblZmVWd6SmFXNHJrWS9mY0JaWGJjeHFJNG5sSk1K?=
 =?utf-8?B?SG41cHQxMUhRbXdFbG5qbUZWRG5DL2FkRm9VTUMzRWJxbkpPM01xd3FFa2lE?=
 =?utf-8?B?NngvcjVCdFI2Z09aWm5YTXY1WC90ODlCVjR5QUtFMHg3Z0Nvc2J6TWpGQ1Nl?=
 =?utf-8?B?VHI2clMzUEZKUnFTQk5YT1dvM0J3cVpnMnNoV3NxMWNVN1VkUkV5NXVpaGsy?=
 =?utf-8?B?RnFaWStoTzN4SEVKbms2MkVkeHhiZ1ppSWQzeHRtazE0eHk0TkR3d2x2WVJa?=
 =?utf-8?B?eGZoVWVtaUJPaWFSRzhDODZITlkra1hib3JvNUs1RTkyRDc3UG5XaXoxNUV4?=
 =?utf-8?B?L2wzOHBtWTdtaVd1cHN4Y3YwQzA3dmh6WVFDNmd4aUIyQkx2NGpPRG8zRkxm?=
 =?utf-8?B?ZmNPUkJlSlpyelJhdW8zcnM3azlCVGtud1JvVDRDS1RJSjloMVMrNEZTWHlU?=
 =?utf-8?B?YlJJbmNkV2RCMlY4Z3ZZQlk1Q3RXZG41eVJLcUdoT2I1SzlHeXE2aDJUWXFV?=
 =?utf-8?B?WFk1WU9wNDRGSkoyODcrY0s0cW5RZzZPeDBQZTBlQmlBd25oRSt6ZzRueUhH?=
 =?utf-8?B?ZnR0ZzFjVVg2cnU2MGRvQW10WGFxOUtCNWM3Z1NEa3J4WTJ1Q29CeTZzcTVk?=
 =?utf-8?B?RUtCNnJhS0FrRnBLQUJLQ1QzZStnRnBUOVQ3ZC83a04yTTM1aXkwYjFFRUdt?=
 =?utf-8?B?VjQydzh2djJTZER3MGI1bEdGQ0d5Nnl4MzNwZVRoRDhqOW8ydEpweDJRanlS?=
 =?utf-8?B?ZDhwVUQ3U3NlSVZoUThTZTl6cndmL0dXM09GaWp3eDVVL2ZaWXpWQXFDZkQx?=
 =?utf-8?B?VGRrL055bi9XSStrZUVsUVVuNzdwUVhoMCtRNGMxL1pacU1TdEkwMTE5WFpu?=
 =?utf-8?B?bXA3bG1FTUp0THBTUUFMWWVkc0FaaGxuYmRkdm1SVXhIOE96WlQ1U3ZPUDkw?=
 =?utf-8?B?VHcyczdDVmNoQ3h0bEFUNUd4Q1ROckxWRkpaeFV6WVQ4Rk0yTmQwZmFPZnFJ?=
 =?utf-8?B?NGJwazhTNVdmNDcwM2IxWUloUjAzRzk4ckQxUDRrNGliUTRod3VYVjZJVTdl?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641bfe73-0833-4ee6-37b5-08dd30fc04d3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 22:21:52.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3RlKJSXam/01VNM9MtTD05X//7Z9qD0b8iEldjR+Fl0Z5QD2XO0NQ5DoP18otPyE45ZaVrSXexsABUlSSHKf3DkPzn6NugmxXxHfhb6z7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7982
X-Authority-Analysis: v=2.4 cv=XZxzzJ55 c=1 sm=1 tr=0 ts=67804c05 cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10
 a=07d9gI8wAAAA:8 a=Q0owcCfzYGnIPQ6CMb0A:9 a=QEXdDO2ut3YA:10 a=2oxvT_mG5pAA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-ORIG-GUID: mTkWLqKCIIYY2MNQg_KIqINyAgoUNNzF
X-Proofpoint-GUID: mTkWLqKCIIYY2MNQg_KIqINyAgoUNNzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_09,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 mlxlogscore=541 spamscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501090176

Hi,

Back in 2019 there were some concerns raised 
(https://lwn.net/ml/bpf/20191017090500.ienqyium2phkxpdo@linutronix.de/#t) 
around using BPF in conjunction with PREEMPT_RT.

In the context of the 6.6 kernel and the corresponding PREEMPT_RT 
patchset, are those concerns still valid or have they been sorted out?

Please CC me on replies, I'm not subscribed to the list.

Thanks,
Chris Friesen

