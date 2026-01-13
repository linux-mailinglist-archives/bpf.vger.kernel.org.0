Return-Path: <bpf+bounces-78683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E139D180CA
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 11:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5973015AB1
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05035272E63;
	Tue, 13 Jan 2026 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dNB/OlPG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0KRV/qjW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA3273D77
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300362; cv=fail; b=MW1567s7FX/K1ZKmhaymmGxyHi9rctEydqOnc43S4LN9PqYSFrWumN5VHdbbwiQf9U841aCKc3t3GNjoTnkrZXp/fKhyikt7PO27Oe03/t6GFseHtFDS9rPNHODFeMiqbFvducFPacFwV8KPkzvieCgpDtnnbNHWJMWA5+jQ4xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300362; c=relaxed/simple;
	bh=/KVveTxwLEYKfYC30xNCNm3lMXbWe5ndTFvE1unv3ZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OZwM7JpOFCDTXrcfX3UZ89d3ptAloQ+Z6WVLCuwojRpSfjPfWsIe/expb3/Iroa0Wk5YW0SzDfH6tdz4v/rWnOuFx3YpsNUMa5zSA32XRVcBMDmwrfypOeAS58GXamx6Rrl41Jtkkj+uqIodf2+8SK5d5+Qys+iRuhjSSbqFcqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dNB/OlPG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0KRV/qjW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gfmU2753320;
	Tue, 13 Jan 2026 10:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qHuV1ya9I7bAvsWncumnuL9CDINCWhwYxjpCR626KE4=; b=
	dNB/OlPGpUpvNGQs6Nt5M7ftRknhNN9Z5XYQf+DYGw6gL8IoXOmwJsk95nbZ42cb
	2BHd3S+wrW9XEF2EpFPkz73HDtKtLJ1E3P8brHdXd67adWTT0sGdpC0c5NXefTa/
	ikqNMA2dTq07z+MlcHJE/PcWkfJgldnkwAtg8agSHulc8YUJ93xCljYoc5WmwDIR
	kultKmSA0U3vofIb8N9/nMeM9Y86abKO18kzHvOn0NJn2EYYati1Zwh6d81SV4+i
	lr3oMpEGyp3nJsv1S+6rTOABRkfMfDus9kRUkNCiaPmLyhazNdqbtjtvRF+HZlZn
	4ss86kwGEZ6ONt8tELuplQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgk6y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 10:32:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D9kOCw004333;
	Tue, 13 Jan 2026 10:32:20 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7jbqch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 10:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnawckFKJwlcfG1okOGnG4CbvkkPf5cQDUKKPAL/p54X6iO1mVqOMFk/5jOjHLwVbx4tqCbjP55rK/OmU9q5J+DcJyHBnllhpL+F/3YGtR6CEOSAJEQbe3R6Lw2SLg6Islf1wNVsegzL2yuE1uCZmSL6Foz+2iqfz5bIiWOkTvyrhN4e0S4b+PE/DlYDe3P3xKW5rWZ8tCQMuV3skwql+6HBhCdD6GDuxkZXyuVW/63FRDtJdaTZqnLFQiurKrRdGl9MJIWLfyde9DFJOxwBfxU65gS9PsGGAu1x5QdF0Hw93sWavA3nHrujzhLnxwzjhpnJq6yRnzmFjG+y1dtIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHuV1ya9I7bAvsWncumnuL9CDINCWhwYxjpCR626KE4=;
 b=pMCvkukbVGiVX74KElOqhg6VDXEjikU1NLiifxo8CWdHoEUABejr1TpJiSVVuZxGdZI90g5lZW8JaNXkp+LfPtcZID1fJFaKN2MXc5KjmudYY88jVpHW9uAt+A+NTsorycF3mdluxhuT/mKmVsN5jiLMRyim+GxJU0ZRHuVSqfbZTLqiGs4Ez81Kjm4Pxt72VB8OFCdEehfJz/g/vV5qDW3zdx0qyQqSrZ9cJdWqb2kbxmb6yrfM8wyxDBk50o3ctW3bUkGf0I4ybEui4cNtslNegZpWkIbb8G5Fi8oG/s2WtYPNw+HkvCkGzplhYWhV6fxcarYJTxAryeVm3CiAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHuV1ya9I7bAvsWncumnuL9CDINCWhwYxjpCR626KE4=;
 b=0KRV/qjWH019G4urYJhgQ61rKFUJCqNEAoK01p2jNoxD0dMtnVgzifIfdh4EKjIDVYt+RiTsSu2MOAvcpWFKBpKVlbTzEU5cNk4XUnLkj3XJLqBOk25/Y2TTtLKzxbqeukSU2aBWq+SksgfNJVvhi+AmJDmX3acznfhjjvmFaEI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MN2PR10MB4397.namprd10.prod.outlook.com (2603:10b6:208:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 10:32:10 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Tue, 13 Jan 2026
 10:32:10 +0000
Message-ID: <3c1711ad-824d-4b57-b812-5b1648f1533f@oracle.com>
Date: Tue, 13 Jan 2026 10:32:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/3] Fix a few selftest failure due to 64K page
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20260113061018.3797051-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260113061018.3797051-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0238.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MN2PR10MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: acfb0c32-ad29-4a22-34ef-08de528f0237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXdtKzQ0Tk1OSUFvOTZucFRpRmkybEpHQkJ2SktMR09LOTV0L21uTStORnJK?=
 =?utf-8?B?V0g4OFAzMGlxTlJPZGl5U3IxK0doUjF4SWgwNXBjZE9ka05RK2FnTldsd1o0?=
 =?utf-8?B?NkNzRUhGLzNwYWNsV21sejFxR3c5WkhDcDQ1QnowQUNQNngwMWVscnBYVkZX?=
 =?utf-8?B?MmhlKytObU9vYXNZTHdPMFJvajZHcUhVRG9MOThQUTQ5OUZ3T1hwZ0xiVzBV?=
 =?utf-8?B?TG5ldnQ1bElwYTladDExb0c0dEkrcXYzdEVnY2lQYXJiTVBJbEh1eDVpUWFv?=
 =?utf-8?B?YVplYTREUm5kT0NkK1VwWTFZcWU4SXZHWEFrc0lGOE5aTTJGZ28yU2d2TnYr?=
 =?utf-8?B?dlRiZUlOV29oT2x2czdQNzYzM3VZS2ZGVW1TYzZPMjhuOXoyWGhNT1ZBeHVT?=
 =?utf-8?B?N1RjU3c1cGw5WUhQSjFEOVFqYVhuLzFza0Jxb1pCei9Ebk5UaUhmTldKQkV3?=
 =?utf-8?B?cDdTZTkySS9Ob0dRVnc2RVlYZXZ4Y1ErWnorNE5JenVXSXJ4MDRhZGg2M0Jv?=
 =?utf-8?B?bTI3QzVSbGZ0ZUlWQVEvbHFGSWtWUlAxZktQUXRydWprMjQ0bGN3MzU4RWlL?=
 =?utf-8?B?aCtEaHVIdTUwVVY5VkRxNWR2U2o0ZGVVVGJ3d1hwdDFvTmhCUWJucEplWFFw?=
 =?utf-8?B?aGdqdDFZSFNLMG9Jb2NWYUx0QmF0TlhzRTdFNkdJcHN5eE9ERFNGVWcyaGk2?=
 =?utf-8?B?MGIyRC9jSTI3R2p5RFNoZld5QWxIZWwrcldjL0NPOHlhdUtIN0NTL1A1Yytp?=
 =?utf-8?B?KzZBZ3pVQkRvYUlPUGtXWlRiaWhUWHBQR29PNk1EREdZN2ZpNkRRMGFCdWdn?=
 =?utf-8?B?aVk2N1VLSTV3YVV0Vis1SnNkMjMyenZteEpDNXEwRW84TnR3bXk5K3VIYTZr?=
 =?utf-8?B?aFNkRzdHbURkK29DeXJUc0xOOWgyWHFiS1NObHd2VHRjWS9hMHZNU3ZLRURr?=
 =?utf-8?B?VEcvL2xlWlZzZ2Rkek1YOTdFNUVnYWVwUjB4RGtxNC9WS1RrUVdjalNPR1NG?=
 =?utf-8?B?bkFQeDVmMnM3cWdyOEtINjJXd0JTQ0hBN2QvNFJCekIzdUd3RkI2WUF1OFZh?=
 =?utf-8?B?WUYwRGxrUlZONWVEMlY0bHRrZy9zV0NNRzNFY05PUVNrNWR1UXBNdDFCQ3V6?=
 =?utf-8?B?QTJ5RzJUS1E2bWR5dnNaRmtlTTVCb1J6MEQyR21aVDVJL1RvSTlHbG1JSEpn?=
 =?utf-8?B?QTBwRHVOcmtESXZUNjNYdkpBR3FrMlE1UEFuR0l6YWdoeThYSCtrSHBYNG0w?=
 =?utf-8?B?MHY0RHBYMGZqSDNtVE1ZSnZPTno2cGtwdGNBWGx6Q2QvQ2dCSWFPNVVmMTd2?=
 =?utf-8?B?UFpjb1RxOS9oem1WZXUyWC83aWNWb25sK1ZCS3RUS0lXa0NVQVFwSnJjVy9i?=
 =?utf-8?B?R3ArSm5PYk1lZ25VZzNLN2lIL1hSY3JYdmNCRGVKQVNETkl0dTRMZ0dlTG5N?=
 =?utf-8?B?YnpQTWc5eDdIRlJORmJhOUplSUhFaVkrb3dpZk90c0k0NGphcFV2UXphRzJ3?=
 =?utf-8?B?SlBMM2MySm43aG5ocWJVN1B1NS9xdlJEdERRQW1jM2swVUVuTzU2ZnhVYTlS?=
 =?utf-8?B?dGRRemRLamJpOEc3MjFJYkNkdE1GaldoaFdKWFJBdXlrRUhSUmNpSllPSnk0?=
 =?utf-8?B?eUpCR0ozaGxKM1QvTU02eDE0UVFGTnNJUGZnV0g5TmxEVDYzRVhsWUVQMWc3?=
 =?utf-8?B?amJIQWJmL1UwcGQ2amo5MU9lL3R4RzdoZWpVazRsRXVzZHVBZk5YdnZ6Z0dU?=
 =?utf-8?B?YlZUaFRXeTBHczZFZHJ3TktlUHBremZ6elY1RDJWb2xmbWJVUURuaWxnY0ZH?=
 =?utf-8?B?UWxwcmJ2MDRKREVXOUIwRmZNQ1o3aGg2MUdFKzlQSkR6azRzU2svQ3JLU25o?=
 =?utf-8?B?bTJ1Z084clI3dTV5VzZma0YzU0lQZDRLcEVpQ1ZxeEwvYVVNNGJQZkRGNjdQ?=
 =?utf-8?Q?T1ZVCKvoecfQBq3WB3zTuT3MpkUm0AdH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N212NjVPSWRIZTMzbGJrMkYzVjF3TUg2U1J4clhtTXA3TWlHZ0RhOHVhN2lB?=
 =?utf-8?B?QVNZNEgydG5BODlRSjk2SnRJNTUzcjcxb21uM0tEZTFGY1NobytsdGdGeDhX?=
 =?utf-8?B?aGY3UUNpTk9rYlV3a3YxNGpEeVhMUGp3clBIZWtiNzZZTFhRanlIaHZJSVZk?=
 =?utf-8?B?eWVZVWdjMkUycTEyYStqaUJvNXVmVHFIc0lkZ2RGdndwZjFIUFhxcjc3MUpa?=
 =?utf-8?B?OTVRVzJPR0I5WnFmY0xPaWNqNGVha1ZtTkFDQldNSTQ2aFRJeGp0MXhabkVO?=
 =?utf-8?B?UDJXcE5TajZJQ3c0elJZeVkrRjVyakt0cWhxdjFpMXpEVGxEbzc2eW9peHky?=
 =?utf-8?B?YWZYdEJGejZEQ29Cdk5SL2liWkM2Y0lYTC9vUzEybzhUMXZLaCtEL0E4Njlh?=
 =?utf-8?B?QUJUZ0RteU9FRnMzd1JacFZ0cTk0dHI2Z1kzNmVqOW5Oak1GR3BXWlZzSjBy?=
 =?utf-8?B?dFVicmYyZ0RUUk96bFVnOWo4MlBzTlZCT3ZEUEZrOTUzNXUwcFhyR285L0Ez?=
 =?utf-8?B?b000aC9UVnJPclg0NTN6UElMaHZpRk9zVTg1bGhSQU82bEppSkVyajUreVpR?=
 =?utf-8?B?UFRQb0xra0ZWbWRiN0toK085ekRidW8vc2o2YzBGS1dBZTVDRVBZOVdBZjBG?=
 =?utf-8?B?NmJuYmdRa1RDK25CMitPaUhIdFBSVmFoY3RaZzlmQllEMjdhS2drYWRHVkQ2?=
 =?utf-8?B?Q0RBMkE0OTB3TjlaRzhkTkhGcTJPdHJWbEludE9kUjVlaStGNkEyMSt1czNB?=
 =?utf-8?B?T3FjMEdYb3hrakE4T3ozaXhCcERNVE9MbnVWR0plUnBTbnRTR2VlbWF6Tjd2?=
 =?utf-8?B?ZnRyaVVaM2piY3gvbzhsT0tQUytjUVR2b01PV0NWNG9sWUFXRndWMGdHaER6?=
 =?utf-8?B?eVVmWHdOdXNPd2RRUlY5cHl5SGtmazdPbG9jdkNyQmpobjNVa01uMWFQMVhC?=
 =?utf-8?B?d2RqVzFldkdwTWF5RmkzakxhQ2ttd0xqaXJ6cks4dFUzRUhkS2tTelRHZmQ1?=
 =?utf-8?B?SU9qTWQxSXNRSDlXR2x2a3ZWWTR5cFhManVLQm5WalRqVjU0dlE2cXA3ZTdn?=
 =?utf-8?B?WDg5dk1xbldkSmlLQWlYZExFZUtjRW1PMlFjSG0vQU40Vm5FMlBoVHhzWkNq?=
 =?utf-8?B?dUtmMjEyUEptQzkyajFrVTd6OWY5ZXdPN0o0eGFpbXdwSFcyWGo1a0s1eGZs?=
 =?utf-8?B?UCs5citUQS9mWGlYZTNQSzJZMXJBU2dvYnUrdGFleFdpdmtXa1E2SXFBbXRI?=
 =?utf-8?B?WXpnMU5NeWFiUmpnUnpHTEpMb3RZWnZ2YTQzb01ocUxIM2xsVVBkNUhqQ29W?=
 =?utf-8?B?S2JtUUtVMHhxRFkxVVdRNnM5dmpQNHBwamVHZmdrRFJ4Mm5EbVo1cFBCMmxJ?=
 =?utf-8?B?dldXWjVaMWFmR3VKZkIxeWtVcm9oU3haZEdCb3RNdkp0L2F3WlE5Ukp4WnAv?=
 =?utf-8?B?NXh5UUdGT2gxOWttRFZ1SjQ5bnFWVDRmSUdHdTNSeHd5cHZoWEJQeHFRckpF?=
 =?utf-8?B?c3ZFRXN3TVl6NDd6Z1JDOFlLaEVMRXlLOS9HUHczaXFCV2xJYjVQWmRWYnoy?=
 =?utf-8?B?UWNrOWVhQm45aDFxTjNtdmt6WCtwazBERzRIei9ZOVViOFdUbXpXQWttWEI4?=
 =?utf-8?B?ZDhBYUxER2Q2ZUlmSitzVG9HZEMvMTc1eEJ4cjFHSU1iZHdnbjFBeWZKeHRJ?=
 =?utf-8?B?UXhtUWJaMVV1VnVBV2tNeXljOFRCTWszc1VqS1UwR3RHb2E2d1JvYWhHN21m?=
 =?utf-8?B?eENxT3JFRmo5NHBzRXRnZkNTdnJIQ0x4TzJrQ21Qc0JVQjFLYk1sUndxK3Ur?=
 =?utf-8?B?SnZlbEhzUW1BWnIwWi9UOTNCWlZVQ3Y2Q1dQdTdjSHlDVTVKZzBudDZsb2h1?=
 =?utf-8?B?Y091UmhYMDdUVG5idHNjdlZWbkhmbENudDQrSjRUWXRnbTI0WUs2ak9mc3Rh?=
 =?utf-8?B?eE8rM2VzcGpFckdDQ2prVVorRTJlaXFWNmFmTWpMclRwVU1RK3RwTE11ZWo4?=
 =?utf-8?B?ckJxcEVyRkFhbURKVUJiWEl6Zno5RkY4NmtGT2ExVHVGV24rT2YwUWxUZ2l5?=
 =?utf-8?B?eGI2cktwUEtvbm1lTjZhNFVRajRPUlBlTmxVVWRhQ2FNUEhTUkhRcXF5RlV2?=
 =?utf-8?B?MmN6NGFIVWw3OE42ZW1jYjlDa24wNlNtT0JwWXc2T3A4eFJUaFhXeXNybUhn?=
 =?utf-8?B?MTVUQWFCUk5Lemg2dnJDaEJtanU5UytPd1BkY1hOR3RPNUFZQlQ4RVA2TWxV?=
 =?utf-8?B?bnk0T2M5bFhCY0s3aXJWSGVONGMzUXBRMDJydGpMQ0dpakdvWFJURDZWRVVE?=
 =?utf-8?B?b0c4K0Yxdkk0UDhKV2loM0M2eFloSCtLdlBTbmhRUmpmelh6QlBOZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lNJqB//2qZnSsEm8DUZ0eqNngMMDiUxjkbV/dI1RM70SNkZyd7OLIee9zfJlqw6i0QyMAuY32eA57AnYKjCEkMfSjPTAV8G20QLhjC1QwQYTzeGyn/ZNBCpmcigOpC7Ig0sdMEQknTjxWqBDxKjaGG4Sm5h1uLkQmd7ifczmA69KgO5/BF1qveeYv3OAHALb2eMu5l6Ah31jQ5kOFmVA1A+fS22FzoiijsBV7OBKqSwGVA6X/ObQZ64kjJtGlwL1eW1vuANMj8Q7KFEd3s2YEaVV0LMIGrTv6vQuJo8oGbJ0Xl3Whzupee7c51Vy3xybeZ40AUZrCwTZ0b6lQM+lZdxTaUjqKxjQ5xNyVHOfwJxDyRlmfbyYCl4a51nBhMzU7gJUVxvEBm2ySxW19YH7xpd6fz0OrayG0Pr9qjDlnnozAvdXE16LWcue32rCqK4iQk4i8O3tdQ8YrqqFXWKr/JsJlooUWLjUcce/lPBFhT52+QC3TUw9lhimF/RZFODuo89Uc+HSiCKwBvhJ3PlEKBuTsyYNMY4Eq9JcncTpRtcxz2ZSWbk8+BPtHfjmbT1Msjl9jVfObEvZg5Bd0A/l++Ol1FwI3BA4ouacj0mEdUY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfb0c32-ad29-4a22-34ef-08de528f0237
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:32:10.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7gEq54U6ahv9HSS3i2b0DIjHMXVkXFpKfQFaZ+e6qBHHuupK37w0OJG5p04tSU0jkshRHeK9qOEgxTO7hkesg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130089
X-Proofpoint-GUID: 5NDCPGeQ250kgtcFdMvqUKs_6o203g2y
X-Proofpoint-ORIG-GUID: 5NDCPGeQ250kgtcFdMvqUKs_6o203g2y
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=69661f35 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=aSJW_rBkKEeOA63MJzMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA4OSBTYWx0ZWRfXwpBIBXsfVLtk
 81BezJDRrrC726P2cIpDSVx5KmaWMjjBYprhuoVqQ+rFDf0nKs8q3/Uifsey2mYjSN8Ert71H08
 EwM173EF8RtJTrSOyfWJfzPRiYWczeVPqonzEK/mRCB5ypDvRMSuRINbOxYCeNf/XKg24yNedv8
 b7aWicrWAwDPeO77U5QBdOBZOpJX7VNYWLmPwbHPT1+mcDxtsSRXb3RoUip15Z8UfIg3B2iNBTS
 2ylwajl0b+lQ2QWpEFpWu1Pa24QyZsRj/qPDnfqPksNC7ER2u56TOwHaVW51X+UCHKP0T2o7yq6
 GL7kF387sWBKB9lwsg32XhB35UIj8IHfSkd6zj85MOmFt/LezajXlHrkfKTBii3kiEtKvdsRn5z
 WBSWA+nwl6iRz3a4pC29AAKG7MY5yV9ksc333Xtp5aagFr5rpUBzc70lGde6a5+q9NjVlqZCRxn
 z7Le1DYqpKJn5d2gtt7aeb/uFctJGwvP8nuep4uw=

On 13/01/2026 06:10, Yonghong Song wrote:
> Fix a few arm64 selftest failures due to 64K page. Please see each
> indvidual patch for why the test failed and how the test gets fixed.
> 
> Yonghong Song (3):
>   selftests/bpf: Fix dmabuf_iter/lots_of_buffers failure with 64K page
>   selftests/bpf: Fix sk_bypass_prot_mem failure with 64K page
>   selftests/bpf: Fix verifier_arena_globals1 failure with 64K page
>

For the series,

Tested-by: Alan Maguire <alan.maguire@oracle.com>

