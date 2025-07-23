Return-Path: <bpf+bounces-64185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F00BB0F827
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 18:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765DA7AB3D0
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AF1F12F8;
	Wed, 23 Jul 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OSdraD0j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uMvh/Gb+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5FF1E51EA;
	Wed, 23 Jul 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288255; cv=fail; b=eMK7bg0DVYT94hdxY9ZRi9/4WxsCMAA4rZxlLYqAfTilJDSLE7Xgc+v8WredurbEvK0tQ4ef9hWSF3w/ghZ6CNsUREnyOpQNASNxs5VmITAOFCgIYEnfH96UF2WfL881oSi6jrRlhxyoI6VveebOS3bVoZoDv3niBEZUOJ2m8uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288255; c=relaxed/simple;
	bh=SJaE8OnZ6PJINVmq4s2A/RSRVttGTnxdyargxvlt0iw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S2iloqqNbCYTKoiQVnucSf6BXvdG6L4cJ9/3D3X+CKKCuUZR52QAt7At6n30k25r6iOj3x6nAxQH2s4TlZ15BGnctbSw4H/2GkZ06tA2bJHRaS9xm0RjNxZwpw5j78dpm81oWkf1L+xqJMZpPEy6BrwwRl/XkdasgMNWrMprkLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OSdraD0j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uMvh/Gb+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGQOFL015557;
	Wed, 23 Jul 2025 16:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4dnwu+AVgkrDcVXyuYSSr54XrINpIoIvDcNtqDsFxhY=; b=
	OSdraD0jp2Lh+51VV5CpOELNIw2S9aAGpOaMVqB3GRq4tmAu4rsX0OKH7UYkq6YN
	opqbtDgLArdY9aEsW2btSLNnIADPf1j+5IP4DJq9XK6tzPEZuJccHd2TK5LTCujp
	cF1t5ZrMIXpCksaxUOGTY1sxR8syCpC15FbTArM0xz9fqy63MOhpdY2Meuxwsf22
	Idc9TW96zkhWVrskZpC2C1sy5VKKAKG2Vy5Bz0t9i5J2eGwi6JlYiVCslAYhdpLc
	RDx4j6YGRwCeFl+iFCiZBqfiJC2rbyVBRyOpp7/rBJMdSrhThfyhm33raBT2q0h2
	GSP3Dlyo5lBdIWSkG9tQYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057r03g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 16:29:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NFckSU037763;
	Wed, 23 Jul 2025 16:29:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tauc7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 16:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tarGeTWgf9ohq7TbezlTP1wmMhfzSvDuHJrbB/PKvg+yqeqbRWbxjwO+tVh/si3zi7j5/a42ay7XyqxItkLx5j2KatgGNzJZCO3QuseWRC/1HEqTTQfcx5iB9zkpfSTuExl6r5Fc5YAgyPwIOEzz6NF0evJCxZsqyYV0trJk8+k+62Z4r87rUObkQb6RpwteXWXRCud7tle2IEl2OP5DdDJ4+uBPLk4wglFmPWP2eqWRZzVPlW3lKw6OdAAbUeaR9keHE9dJS3Gynz7nC1fK9EqH02Gwkn17GG5vDSZA0pcHjSYzH9Hkm4SKEadqq8AyBF2H565CRGTaj/VR6bsTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dnwu+AVgkrDcVXyuYSSr54XrINpIoIvDcNtqDsFxhY=;
 b=xT0dt9j2OsNzDlsrJBUJiA6pNWolCM89RNQ4E2jEGtGQhH//wB1B6Rg+Sp10BeyyB5KpS420nTXerGj+dqm/4iSkGtal0HB7YBeqcE0zUv63ckQDnRhJT5rTvI2ezNapNFxQKVelz2Oxiq6AvjfA1YKU7St6yhBn2EtgEJi8q4LVnWmt3KmLxRdCmRy98TJ5eZtBWt9ZJclDA1djWMhYw6ysgwaQM+mOUxfco3K2VcAAQrC4uvPRxjzDafgZm4W0IlxNgtKnLz57aCDNemUnpgf0toDE8ftmCIDHptVMn9tk2pP9YDol48ilKEbAYMAQpzoUQzrvqhBxKLuB03vZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dnwu+AVgkrDcVXyuYSSr54XrINpIoIvDcNtqDsFxhY=;
 b=uMvh/Gb+6c52x/8gMRloqbFLhqZW64W+8rSwxhgrcXG8k+NSQngjZdxeFZHloWrVP/oVyN0blzWjNZhjM+cFDta4aWTdW/K5bQSBmkI0UTEUwxrxvFVwXoNuk8TeeFXsoCVbwH5P4XeRFsuDFn4DQQ640rtnid1ae1u7kt7vRuc=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by IA4PR10MB8495.namprd10.prod.outlook.com (2603:10b6:208:55d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 16:29:41 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 16:29:39 +0000
Message-ID: <46d727ee-3675-4f99-92b3-3d9a8d54acaa@oracle.com>
Date: Wed, 23 Jul 2025 09:29:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Jens Remus
 <jremus@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>, Brian Robbins <brianrob@microsoft.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
 <20250721145343.5d9b0f80@gandalf.local.home>
 <e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
 <20250721171559.53ea892f@gandalf.local.home>
 <1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
 <20250722122538.6ce25ca2@batman.local.home> <87jz40hx5c.fsf@gnu.org>
 <20250722151759.616bd551@batman.local.home>
 <ce687d36-8f71-4cca-8d4c-5deb0ec908ad@oracle.com>
 <20250722171310.0793614c@gandalf.local.home>
 <9aabd05c-5769-41fc-a825-e6c6866d9fe4@efficios.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <9aabd05c-5769-41fc-a825-e6c6866d9fe4@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:303:b7::33) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|IA4PR10MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: ed673d23-ed15-4076-a50f-08ddca061f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEg3ckNaL1kyNlJ5TjZvU0Y2RXhxcUdQRFRKSVlLR2hmY1FMV3RMWUZ0aVhV?=
 =?utf-8?B?TlUzT3YzM1k3MWljZ0xlb3g4cXpQaWp3K1Vob010ZWZnMkF6Uk53QjBtUzF1?=
 =?utf-8?B?MTBxN0IxSEhyK3MyNU9LRXVHdTlVOWpGaTI3M1FpOFV3bG53S20xTWZWV0Nw?=
 =?utf-8?B?ZzNXN04wdUs4RnNYTW5RMHhJVlFKbW85OHNreFdWMU9FL0hpMC9tM3YxdGJl?=
 =?utf-8?B?OTg4aGMwQzZGM2tRYzJ1cDM3MnpZZ0t5aGg4TExpc1dQTzNLc2M2RVN0YWlO?=
 =?utf-8?B?bjIzRytndXZheUNsaUdURUNTUzVlOWZSUEJuV2R6UFdPdzRzRW1wWk9aQjdu?=
 =?utf-8?B?Y2hKWjJhOFhHeGpwSDQyaDl4THgwcmVoRm01b1ExdVBxaEhoOGQ1VDdhYklO?=
 =?utf-8?B?dHpZUDNXSlNhWHBOSWo4akRyenhoS1JkNWRIOEUvemtVYnl1R2tTUkwwT0Jx?=
 =?utf-8?B?ZmY4cVNLd1dXNVMwZVdsVjJWZFN6dWlHUGR3VmZHL2FIeEQyQW5NaDZIOENT?=
 =?utf-8?B?VkFEckhmU2hFTS9udXdiNWE5RUNtS3V1dkRhZVBoSGYwdDhPa0tidmsyUVFO?=
 =?utf-8?B?NXYxV25TaHFXMThqV1Axcm91VFliTGd0aUQ3ekRxMXhBVHVrSXRQK01kQ2pt?=
 =?utf-8?B?Qm0wWnRXYW9UcUUyWFpaOXlqU0dvUDN6VkZRZm94cmpNbm5veFZ5RzFkR2JV?=
 =?utf-8?B?d05jMW9Xamx5SldzMmJmN25HUHRIWlduQXlPVXJ1aDVIclBxaEVPM2tLeDht?=
 =?utf-8?B?OUdGRERtM2ozT0xKV3ZIUXdVSXZHdFFSSmhBNXM2c0VEbFBBTzBHWmthb1Nh?=
 =?utf-8?B?Y3B0TWFmcXpxaW5HblRaR2J3bjlSVzRVcVlVK3dPRC9DT1pJTnlkM2VUcXkx?=
 =?utf-8?B?WGNOVDluaHdZMUxpaFhjWWE0TEJJRlZHSlVuMjQyTVFabmpIeVZ1bWVwZk0y?=
 =?utf-8?B?TUY4ZDI5TVhtMmdYRjZwZFhJcys5akNqRVVHNno1aFRNb3owWWZFSGs5Z28w?=
 =?utf-8?B?eDl1dytXYURxK2VkalEwZ2dXK29qS0l5cUdIZDR1Q01aY3hLOUQ4WUREaUNJ?=
 =?utf-8?B?VUxwTHlJRGFIVHpQWGNwdUJJVnVTWFJ6UnVDTGxUZVdqUzQ0MDdoalcwbFlQ?=
 =?utf-8?B?NStJNnUxUGdxMWNRbVU3S2R6SzB2U01HTituV3B6eXZpKzliMFFna2lWVlhV?=
 =?utf-8?B?QUczSW5DdHB6MS9hZ2x4bmtBeVJiRUFCYVhLd3ZXdllWWk81cUZBQnhzZnlZ?=
 =?utf-8?B?TWxSYlZ1ZUdEVUcyVlN1NlNvNElHSGZhcnhyNjNxcFRISkN6QU95Sm1nK1hU?=
 =?utf-8?B?VjlpRHQwNE94dndWVTUvVkkzelNIdkNrRGlxbWF1R3R1SEYvaGtISzlabU15?=
 =?utf-8?B?ellyQWprcXJOeWVrT1QveERXekJqMzBuTVFZdHZoOTZ1WDlpdTRmYXhpcFlC?=
 =?utf-8?B?Um5rMWxTelNrakVqS1V4TFYrWmhXSzEyaTNlczI1NHFrMjNGMTNndFdQRUN6?=
 =?utf-8?B?aWtRdGpHWW5OVGo4UUltU2NGMzZmOVlwekc2QmpCcjdKS05qWmFRc2QvTkxa?=
 =?utf-8?B?WjN4eWp0UGlBSXM2cnR5Um5MOVkwSXFrbVcxZTV0eHFhSWdxRzNJbmk1UmMr?=
 =?utf-8?B?c2ttZ2U1MklybVhhTjdLcUxmOVlVVzg3RlgrWkZzb3ZLWHZWQXB5L3B4SWJ0?=
 =?utf-8?B?eXRqc3VxM0pMUnlQS1hVbkdIMi9aek9jd2Y3Uy9ITnZuYmlPc2FvY2IrcDNR?=
 =?utf-8?B?R1JnZDlISERZdU5XN05FTWhFOC9wQ0pXVHh5YnFGQzl3Z0tMeThIWmJBcXQ3?=
 =?utf-8?B?cEhkcThsTUFkYnpzNHBuUEJzZHg3d0kvWENkOUI2SGk5VlhHeldIN2hreXVi?=
 =?utf-8?B?SFJHY3g0U3ZqaEhzalFLNThtRjZYWnYyNlplR2Y4ZEFCOXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjdCakdLQnBHeGhucUgwcVFIUitMQ2dHd0YyRjF6U0QrUVorVkUybXVGN2lC?=
 =?utf-8?B?SXRvRlFqUXVsNytZYUFBWnBvZk9HTzMybHpiNkkvMDZHeEVZUUp2VmxubEVW?=
 =?utf-8?B?TmJBamJlTE5hMnBrTXJwM1V4V2FLUktIVXYvcjh4R2pCTUhzVjA1OXRvOEJY?=
 =?utf-8?B?Zi85QzhxdkdVYUQrV0I3RlFJempQcU5aNzVxVGt5cmNueE94ZHN5RTJua090?=
 =?utf-8?B?RmdTOUdneUZncWxQa3BnNGpUSlpjeVZySm9hMlRsQmorQ0piL1YxM3NsYnRQ?=
 =?utf-8?B?VHZKUXI3OW5WVHJCNjRKQ0c1UlEwQVpsNTBJSStycU1ySitIbjFMZ1BGVFcx?=
 =?utf-8?B?RHNVL2hLeUtSdUw0VUtVbEgwRW5TbERwK2dFYU01Nm9VTTZKaFlMd3c2SHRF?=
 =?utf-8?B?ZWZ3ek9LTUl0MGdsWDVzenlPOGwwRmdJSHZpY0F0VGVNWi9PUVF5aVYyS3F0?=
 =?utf-8?B?cDRIb2x6UEF3c0JqMGZzVWxjYjJ3Tnc0NXZreTRnREUvSTBIRklXcWo1eHFN?=
 =?utf-8?B?aWZ0bnFFUWEwYnRlRVUvb3I2NTNka0Z5REx1Q2RoUmxEejdNUEtxNWdQRG9z?=
 =?utf-8?B?N2E5N2RORjk5SVR2bjdyTDlOWlcvZEhQbWl1dDR0cjFTVktRS3IwdWloNUtH?=
 =?utf-8?B?RVd5Tml4S0E5Z1FrQ1F5bk8vazVMcEpXdjdMWUZjeER6bTVBRVhRcTM4RE9j?=
 =?utf-8?B?UUVTT1llVFc4V0E3VTRWUVdzVDMwcHRZTGFqQUxUWjVKR0hRejFHVGc5VU4z?=
 =?utf-8?B?c3BWNk5GMXhYNUMzSXNhRVVkWWV0V3l4MUJNQ3pyS3l6VXhBeEVrUjVHbW1i?=
 =?utf-8?B?OENUSS9JaTBQTWI0akZnMW1jcHJWMFo4TFcyb09IcUdiU3ViR21zeGZxRGpV?=
 =?utf-8?B?WjdmZUZMT2lLdHgvYzlyTTRWb1BtbzE5dVM3eW91eHA2UGFQZ2FmNHhwQlRO?=
 =?utf-8?B?TTJ4V0RiWWdMcTgvYnpDeklyMXZVVVpOeTBhR0ErRnY2Y0Zod1EvS1Z0eW9q?=
 =?utf-8?B?dTVDdlNLNnB4K2VpRGVCVW9qZUptQUxzTGo4ZmJWV1prbTdkUUxWMStQODc5?=
 =?utf-8?B?TUhzd2Mrelg0cWdwWFJBdU45aGhuaWVXY1Y4ZkduZlRmVC9idVFLMzM1NlVY?=
 =?utf-8?B?UEV2c3VZWEFhQWlXb1Nmc2tZTkIzam44bWVNNEFIcDBvcnJtNlJodVl0NDdj?=
 =?utf-8?B?bWdoZXlQQTNtUmJteFB3ZlZrT3dyR1JtQUd4ei9kdUtxVFZMVVNCbkdObFVB?=
 =?utf-8?B?emw4elZvd0s2WlVyZ3N5Qyt1VVVXTXkvc0xoeFNEenp2bURCK2xWTjhpWUxz?=
 =?utf-8?B?a1ZEY0lqT2N0OGlRQm9kRTUvUTR5ZWhabGpHci9Ka1prR29yeUpZKytQTU14?=
 =?utf-8?B?SUZrVksvNFM5UXA5c2luZEZiaUpVR0RhTHFOdzBaV01BWCs1MVRLWVYvWGRr?=
 =?utf-8?B?dnlQUDh0dXR4T2ozVi9ySElIeXVaeEZQam1WR0U4OEw5NjM3d1VTeDlPd2xM?=
 =?utf-8?B?SGZaY0FVSnFYUzltTytVNCtNSWxSSUFKTlZoUi9PRE95eTBSOGdaYXltakRG?=
 =?utf-8?B?OFdaMVYxR2tqUUxzODFsN2JZcXBsTTVyaUYySERndUkxdjBvaDVlU3ZNTDFK?=
 =?utf-8?B?NU00aXdzb1VrS2M3STJMRnpXYUsvbjArcmordVFIanN1VjFTSnpRdzVVZklI?=
 =?utf-8?B?MDl0cWRTdDBlTWs0YzF5S0JkdHozOVBCZ3NxRjNuRGlNVE03UHBXZm9WOWtO?=
 =?utf-8?B?MmV6MGNSQzVwVnhBZ0lYT0pMc08ybU5pNC9JMjlFaFZtZnpLMVZTTlprMC9U?=
 =?utf-8?B?N2pzMFVCYnRBTXV1cDBGWFhzTnc5ajd4bkF2bmtxV2VwZVl4aGc2ZUJseXo4?=
 =?utf-8?B?RDNGWW0wQVRIdWM0eFBIVVV1VFQ5YzJnU09uZHNRa0dmU2dpd1EwckpjeHNl?=
 =?utf-8?B?emdGejNDN1UyN1d0a0dOR0Y3RDQ2NDdySWZia0FKYjNjaHZmYVYveldFMFpF?=
 =?utf-8?B?T0pDdUZMb1pyWHJsN3NHTjJ4b3RqSmRMbWtpT1dyMjNiTGpadldWd2Vucjg5?=
 =?utf-8?B?NDgrWUJvZCswbGdpazQxaGRheitmVmNGR2lyb2dCdUo1ZkZQcDYzTUlNdWh1?=
 =?utf-8?B?aFNkUEt4bGczY0lZa2dDSGtrL01uK1VnbzllSEJHQ1pNV01jZUtXcEd0ZUF1?=
 =?utf-8?Q?X+qt1+lMSUeez+Xr5zt2+hk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lqX/6P6weNaibqkw7i4GZaHO1pbgx/wtkYVuKJuB1WgtCzmw6EFtQ49dle3q+0vt10KObm9n8xZStf8f0BWXCtG8irM2G9E8MbnrNi9A2mmIc4jq2p69fPedcTtyVjCkGTGR0vrHm5a37anAMDFDjnsTVVXWpgR8NM2zfDW5fCB8RkPfKvRx1rtfq+uXcwQjnNHEZn4WsYxkTLqxuD7ddNnTK0haf57E0PnvA0er1b+vcvh/To1r7+QItWOk9pMScGCxvg5xFgfHGwqijdgKnXsC7N8VoEbY48tCtteJeFEEsg7v4o0jgl5PWXPbmZe0WSILRVI8EXRJ8MghL+zoAH2E0ftIQKwIFw2KEDSYN1y6jbi5pZFHRiFX4ZftfPQvdy/IrGvB/EQJjPJECY2UMcE4Bn9alYNgw1RAUE0GP3ZFX1YxDE38vwQpFZArgbgfcnMPoV7Jsv4+8QwNt4WUxmE5Lh3UXPUv1Y+eUO7zIWTpDlUVrJFly6YOtxQtCc7vQyFDdSsaYmexb9hq6MMkcs8bBbpwz8Fe4Ou0v6TCiE8oxcq/EbqseDaO9Qo/dkRk7SEnuUkovup6mLbN5t8loiUz4QU7Yz5QC5zQJqODcAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed673d23-ed15-4076-a50f-08ddca061f14
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:29:39.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WfcObr8RZQypu7Bl1QS9VIW1CHZ3Bx0pjSDxGEqlbyWlLebqnfTqzK1M1SYe9C32Yxne9s1XJMr6pgGhOWOGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230142
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=68810df8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=3dpwJ_RRv5mBGn4mkvsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: VlJymai-OyuU-AAsq8zqq0rvMJlxLo4k
X-Proofpoint-GUID: VlJymai-OyuU-AAsq8zqq0rvMJlxLo4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE0MiBTYWx0ZWRfX3x5djwkLZvzZ
 ZKYzGG1RCHkQFwYXckKE6Rj0OuN0PEkLvNHeokWKZ/Z3YqqI5Qz0eAqwT0WgexSx02Mp6jgSAKK
 vvpgCZnbeb6gAgg3Mi34gNvB0Yz/9v50qXLmW2VCtn1m+Va6ZsS7ncNEoSJ+2pVubfIE+2omc3W
 DzS0mjtt9H64BZtfzIC23s2w9vRfCU0jaHGo9O3W8LFJxcI6Pg+1JmuKgoxzYN1uhxxn8oymY8v
 7OKYdtftzGkzxcfPH+XuIyboL7kNVzAhfN/tbQhryApvkXGGlGxURPWzDwSrlmDsQiW42rnr8dJ
 LhXD+jlgYTULFbtRtY6PUCaaZF/OLTYuC/0aIHWsndRFo8sYf5J1WksE/QVgO132KKsMW84evuH
 9MtfhhuC0lkVHLVWA1oOfo37EPbXKBeN3I/qF4f8QQYmpTYJV//fkUJHsjktRCeZqSRsnoBp

On 7/23/25 8:09 AM, Mathieu Desnoyers wrote:
> On 2025-07-22 17:13, Steven Rostedt wrote:
>> On Tue, 22 Jul 2025 14:04:37 -0700
>> Indu Bhagat <indu.bhagat@oracle.com> wrote:
>>
>>> Yes and No.  The offset at which the text is loaded is _one_ part of the
>>> information to "fill in the blanks".  The other part is what to do with
>>> that information (text_vma) or how to relocate the SFrame section itself
>>> a.k.a. the relocation entries.  To know the relocations, one will need
>>> to get access to the respective relocation section, and hence access to
>>> the ELF section headers.
>>
>> You mean to find where in the sframe section itself that needs to be 
>> update?
>>
>> OK, that makes sense. So sframes does need to still be in an ELF file for
>> its own relocations and such.
>>
>> It will be interesting on how to do compression and on-demand page 
>> loading.
>>
>> There would need to be a table as well that will denote where in the
>> decompressed pages that relocations need to be performed.
> 
> If we can find a way to express all sframe "pointers" as offsets from a
> text_vma base, then there is no need for relocations. This would
> minimize complexity.
> 

(So we got into the topic of relocation in the context of compressing 
SFrame sections, the details of which are not chalked out yet.  As I 
mentioned SHF_ALLOC|SHF_COMPRESSED usecase needs to be discussed 
further.  But stating the following in case there has been a 
misunderstanding.)

The SFrame FDE func start addr field is indeed an offset from the field 
itself to the start PC of the function in the text section.  So in 
relocatable files (object files, or ld -r i.e. ET_REL), we see the 
relocations.

These relocations can be resolved at link time by the linker.  So for 
shared libraries and executables (ET_DYN, ET_EXEC), once the SFrame 
section in placed in the PT_LOAD segment, there are no relocations for 
readers/consumers.  These relocations remain for relocatable objects.

A consumer of relocatable object, e.g., in case of kernel modules, will 
need to take care of the relocations when adding the module.

