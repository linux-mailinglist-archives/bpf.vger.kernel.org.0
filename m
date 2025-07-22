Return-Path: <bpf+bounces-64087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD60B0E367
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18227A48E6
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0C28031C;
	Tue, 22 Jul 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="daJCb8J+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IFIHZwjB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1E27EFFA;
	Tue, 22 Jul 2025 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208584; cv=fail; b=BTFeRAeK8vIZOYt9fH3QS5hYw5gf50lMQaorqwkB4FDah5NM7dr6ZqCROfRbq4vx/4yh/XmW0ePg4IDwjRKA95KvUVTe0UKzrOfAMtu+qdFoNVDylJtfE5paib7jgZ7/1VaDrYhfzHk1IOc0QyeYaord97B9/ZsdpSGZLRJ8Z1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208584; c=relaxed/simple;
	bh=kSlUbTsic25lCmNuWHNUzK8NBOxICANV4C7NWCy/GYw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eK2aJZYtvQ8u3qKRJHSovTg4R0FdXawvSM86fDYyYbPj/ehtkJ3pDsQxVB6JticDNOdOLC36dVlGNcCHSUNLUEtwdUF3UUQiqmMJxjvDEE08OBOpIXkMhZNfyV0+oBFhlZDh8AzXubROZy9jqvQY9W8zt3CeTmOD2x6HubnrWxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=daJCb8J+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IFIHZwjB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFXr7A028534;
	Tue, 22 Jul 2025 18:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WHBjIlOIGqlwBuYP7h3uWOGZN15YXyC1djnZ/8lCZUE=; b=
	daJCb8J+eKTecDUD9vTVKEM3SWIXAY20WJ2IWkfU67BpVqE3uJ0iKPatZIebou+o
	D4pP16zvPOnNRxEeoVX4rwK3XufkXMLSg2CN0g48YqS0nD3LdQS54SJUEB3bAclm
	zCE0E7jbJuKBvyLmzT+oKFtzz8l2b7nI/mUMpcpNZyNwg7iBwHDIgDcmz7hg/oCg
	YxM73juUiHmkn9V9D64dpPNHaDBTSDcHwTMdk4bBAH3BxtpVQmlkvKjP2rfDJYHJ
	Uelg7we1Hd+cW1HQGM79UICyw9vGWssDbC+8jsrAoXhN+sC+AyFq+iw5fQ0fiR1s
	DoCE+wpkrubfZoiERd3ifQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 482cwhrfve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 18:21:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MHpIlI031482;
	Tue, 22 Jul 2025 18:21:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tfy73w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 18:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY9/9skzG6tfX/Sk0WgGeSwndv1GorP/OXbaHL1M+DdyMocSGmL5GmRzSDGsEDPkGEeQmdBNtB8PJbaAVN6MFugrSayyMNvVFVbWDFHXkEP9DMDiMr0DjXE8q9hl/Aj8CD+ov/Mn77nQvBZjtM1OpC5KA4Rt6hs9ttIXVm7EpkpHsJ8Etkk8JLlDTsIL4+MgH+H8IqDogtSpQUr+cb4se91uJP9+p8LQ0StN/gqBGoFARxBgyAr26pHIEJMzRac6StuW4rl2Mnu9UJmyLBEUWBIIU3xiYjYQbZ0eEswi8HXGB/s28MYSYRSgSy0d8aKZIsTUOW8HYUG519WfsLxm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHBjIlOIGqlwBuYP7h3uWOGZN15YXyC1djnZ/8lCZUE=;
 b=lb/d74hkfGsQ5rwgdoMwA/xL09twb/3hhWIM73YlNCAMFOlXvh6dBI+fR7CT1fMiKtZGG9Lclz0rBo7lhnZX+VKAzfWrjLxyaws/+g96nT9JTegwHt68sOWThMoxlz+yUxDDOuCn6lWX0j9WNcQzWcz/o2zx3GJ2y6i0VMcC08Fg7CFINS5RFvYXzyUb0VS/3ftDRux1AkrtgjFxw9TyFl2jkqQoUZy7hFmzenyUKgjtPDqMSeaxOHZAvElX1MpiNv8HlPdLaWDT/TkRlWhr/xObcJiLwkMZfawOZATWapDBm/yO/oATST1UEV11ZxkvSqYYtFqABAWM2U1fStuM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHBjIlOIGqlwBuYP7h3uWOGZN15YXyC1djnZ/8lCZUE=;
 b=IFIHZwjBK+WcpN4syNVpP2hzAaR/sAGigrpkVeyb717yafqi+W/idymSzL5HlgMrw1GssHacyj708RA5vmO4qbQv3AveBFGO/JBBkRxnuEv9lyGl2FiqEiPKgZSlmJ6NP8aTuCYLlzPiGEMOUTohbLErZzoRvtEI23jggcgDhUE=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by DM6PR10MB4284.namprd10.prod.outlook.com (2603:10b6:5:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 18:21:23 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 18:21:23 +0000
Message-ID: <69d09381-2315-4c95-ba5a-28d148ffd19d@oracle.com>
Date: Tue, 22 Jul 2025 11:21:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Jens Remus
 <jremus@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>, Brian Robbins <brianrob@microsoft.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|DM6PR10MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: e01d97af-c59f-4208-5751-08ddc94c9061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVJQMUdsY05xUXZQbWI4TWs1K0lVcEwvQ2JjeCtzTnY2TG1XU0hNbTVIV0hW?=
 =?utf-8?B?S1EvVE16VVNRVW9iNCtnK2xyRXVlZmtCVjduaHJuLzZwZGlLTTl6akR2VXZz?=
 =?utf-8?B?d3RxMmY1VjA2dU9ZVkU3NWMwT2F3dHlaNWg5RnBFQ293VnkrWnlaM0V0R1FR?=
 =?utf-8?B?R2hsUjU3K0Q0NW4zcEgrTzFQa1NsbHJZVzlucW1mWGVsWEtXdGZBMjI2L2F1?=
 =?utf-8?B?cmdtYVRuRGp5ckJockhoVnFic1BrallYMDVwUTA2eVQ3Q0xka2hEWlcvVG92?=
 =?utf-8?B?R1J1Y0dWWURLbEwvSnVXS3pHRnI1bFlnNXVpWWhNcW11TDBOY1NBei9WQ2xY?=
 =?utf-8?B?N3QvNVV1KzNwbUJaZFJnOEk5UzZpcTJjejlybWZqeWVXb0M5SVl1N1cxQTVG?=
 =?utf-8?B?LzF3cTB5WUs0SDVGVE8yR1oraFcwOGRidzdUUFUxcHhKR3grV2RETVVwbkp6?=
 =?utf-8?B?elBoZ3c4Wmg2WlJwRGJoREorQzgrbDlQRHk5NUl5MGk5OUJYekNVbFpkREZF?=
 =?utf-8?B?TWhTZVI3aGdZRU9abFNXQ2lhWUthZ0FaU0pNWEpsT2Z1TkRYeGk0ZTN6bjNL?=
 =?utf-8?B?MFZvbTBFVEZOeEJheU1wZ0k5UHYvN2hINnFnaEovMlNlWCs5TzZQQVRvZFEy?=
 =?utf-8?B?WEYwbHo4RVNBWFFHNWpFY3ZkZ1Bndm80UW5Wa2F4QlZaRnlEakowSXRDUkQ2?=
 =?utf-8?B?ZnhDa1pXanRuT0YyVXlkSGlqOWZ0RElSKzVqeWFFT0xkTWRFdnRKc3VHNytR?=
 =?utf-8?B?aGtRT2RHdTFzNTl6ZVVpblJrS04yb0pPblhvNGxxaWQvRkRwRzYzOG1hbnN4?=
 =?utf-8?B?bXY2aWd2VklTMGExOGZEWnpJRU4zK3BLdUxqTVdXb0k5UXhkT1pwdnBNUXEy?=
 =?utf-8?B?LzdIU2hrMCtiL2ZBRXliaU9wVTZKVDI0d1ViaWtNWU1UcjBNczBvOWlMd05V?=
 =?utf-8?B?R3VwL0lpWU05UUVIUWwrNlJLNWtmR2pnUnBqVFNybFZ6TVhNWGNYcVY3VmtC?=
 =?utf-8?B?YXdWdGllZUpmSU5aMitsUjZOQlhqOC9GaVllMURDMU9pZjlmTksxZnk3dlgy?=
 =?utf-8?B?bUR0cTRXcGVUOG1nQzBHMGY3b0pNajYvalY2cVJRdUNoVHBoSVhPZVZsUnFB?=
 =?utf-8?B?RnVjcm5lMGNCemd1SGRiUUR6amdpSFR1Q0xOeTFnYUJodmJwL3FyWGZYRTly?=
 =?utf-8?B?VnA1UVhzc2JpZDB6Sks1aktFaTV5UDIzbFAxOHBlSWhpckRreUx3NE1iVnJX?=
 =?utf-8?B?c0JSSHl4SnhWTUQ2clFVTjFDR1NSS0k5SWtnSW1peERwZGJ2dXNHeThiSFA3?=
 =?utf-8?B?UlI3dnZEOTlIWGZhN3NHdUlVOWsvK3BPbTVJamkxbTEyNzVYcnE4TDdjdi9v?=
 =?utf-8?B?MUVuakpwNkZTZDVCdmlMTUtZUTZMVXFSZFpkUWtMRFg4ZHdlWjQwM01rMG5L?=
 =?utf-8?B?cWU2L0RWNnQreTBEanpvWlNiL3dhNDBGbFpxOTREK3JwMnlsSEoxVjk1d0Qv?=
 =?utf-8?B?enlBM0c5b0xyWTBvS1NrR2ZuTUhTUFFRSW53Z0h3NlRJNE5qTUFxVW03aTNo?=
 =?utf-8?B?QUFnT3U0TlZiYVQyTmpmTk5wOE94b2MvZDc0WittT1FLTEZ6V0JZMzR2Si9j?=
 =?utf-8?B?RTdaVk84ekZad0k3QnBWdnlFN21mczFEZFQrNUhmWDVyek5uZHk2dy83aG1Z?=
 =?utf-8?B?RWxldWdIQW9aZ3NSNFVOSkxjU2xPL05sYlYzclNkS3JRY01tbWRwUFR1K2lr?=
 =?utf-8?B?MWw1di82cm9YLzllTm1LMUFmY2FQWUI1d25KMjlndGpidnNZSlhXYmcybTdO?=
 =?utf-8?Q?AypSZM2r5PqyiqJZcpkPb7k60oPxU8GD2qgw0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGxvK200QnhxdVJzRmFVNVZ5QW5QeFFCTVhBSDV5bm1tanNKSzV0bW9jSFcz?=
 =?utf-8?B?RU5nTXNWL2p1U3FOZ2E1YmJvU3lnaUFxT3UvLy9TYmhNSzUrZ2tuRXdJVDhF?=
 =?utf-8?B?VzJtSHpCcytpemZmbW9udFUyK3pmb0NSUGJTZkViN3pmSzZZWDlJZ1BVdnZP?=
 =?utf-8?B?RllTS2lIb2RCZUg1OUZTelpoK1hPUVh6M1ZMY3pTRkJ2aE5sM0doWVV3dTd2?=
 =?utf-8?B?U0dZaCtrdENRYkRXbzhUcnJ1NStvWFcyMEVvQXFCMGJuQ2tPUGd2L3dSMjR1?=
 =?utf-8?B?U2tNT1VRV3BFdVNldHIweEUyejBYWTB0Q0VoY2lBdHhPeE8zZ3BOcjBLSms1?=
 =?utf-8?B?RTNTTXdGbE1PM1ZHUk9uSjdNOVhrN2g0Q1d1M1BjbVVBOSttZmNUT1g1ZUZ6?=
 =?utf-8?B?aHpNbzZEL3VmN3JTVlFLOS9GbFVmbXhXTnphV0N6UXlmaDk1NlhFNTc0TXhM?=
 =?utf-8?B?aXNFN2xIeVB1UlpjYS9TWkZEMWpmRkg1b3I0eWlRN2JHQUtQdFVESFJWOHM5?=
 =?utf-8?B?dVVPY1c0VVpwcmhQdTdtUlBQYWZpNm5wS0YxN1dUM0kxcFFCYWRZaUpWYUZJ?=
 =?utf-8?B?S1hUbVF1cVNKY1NRV3ZXRzU5bGljeUtIQkRnMGtDWnBqY0x4Vm1ZN2pMcnk4?=
 =?utf-8?B?YlhpZi85TTBoTnMzM1VudUxFeW5wYUoxZlRGQlYzcElzY0xjTlcwUXpScnNv?=
 =?utf-8?B?aXRjL2psTVI4NUVNTkVzZWhhUWV5SkpiZk5HWllXcUF1N2RwL09IYkkxWThk?=
 =?utf-8?B?YkdMd3dHd3djLzBPL3lxOGRwejNUTmhIRmdFUTVuYUR1U3RtbjJIMFJ2SGQw?=
 =?utf-8?B?S2tsYkZWdHhPN09VdkJsVU5pOFdQazNSOWNIcjVRWDl1L0hlcVBBY2lLTTJN?=
 =?utf-8?B?ZVJyOEs0MlJwSGdEUmlkcDdIUVVXOEdSSmxrbEFyRzdoK0dXbEtxdDZXQXJu?=
 =?utf-8?B?V2t2VWswNXRlSDBXNlZpZllMQXlueU1TeFV5U3NrRTR6QytvU3pQZ3g2SzB5?=
 =?utf-8?B?NjdqL0hDeHBPY25HOFkzT1AraWhweXY1dDRiNDZsamtLVk5xWlFXeEdLTVlX?=
 =?utf-8?B?a1pmeE1SNjNmUXZMeVF2ck96VXlKZXpoME9yMlhrSGx6VUZIME5ZZE5LNlpk?=
 =?utf-8?B?T2hFd0Y3TEM2S0pwOHF1VXVrL0JUUmcwL2w4NlBQVVU5K1czS2pCQzAvd2Ew?=
 =?utf-8?B?SnhFT2k2d2FsR1I1NC9HWWxsYlFYaDFTMXBnQzVpTkVWOUxrL1lMSklCTUlL?=
 =?utf-8?B?b1NyZGt4V1BFdzg3YlVNR0dheld6dStEdm9KbFZTNVZ5SUJyU1pZM0JIblhx?=
 =?utf-8?B?Ym00WmFud2h1K24zaGNYYVlCcUJEOG0wNlluWFRXb1o5T3lwaE4wTUZPWmNY?=
 =?utf-8?B?YVY0Z1FDb2J3WGZ3Y1lGMG9qS3kxUWFHancxZDNwMWJabjgxTHl5NThHQXhU?=
 =?utf-8?B?Vk5tYjFYMGtNYUROaVlLWWZBZ05hb0VZZHB0SjdwbG0wQTdvVi9KQWZFcHFQ?=
 =?utf-8?B?a2RGZTdScVBZQTNFZkdhVlhTM2FxRTI0eUlkcm5HMk1TeVloeFRJT0VlYTZV?=
 =?utf-8?B?S2dVVVByZFFwdWNBVm5xak9KNDkwajI0dmJBQjFJNWh4VTQvQ3ArWWN0NUhZ?=
 =?utf-8?B?aHBZTG9GOUlnU2Fsd3czVG5MQm1qQ3BGczdydVBuck40bjlyRGNoYlIwSnFw?=
 =?utf-8?B?eCs4THNGR0JHL1cwY1dzRmYxRnZmUXIxcURldFBpSWc3UmNqcW5LaGtNdWpv?=
 =?utf-8?B?aThkc25hekNUcW5JRlJGWnZ5dGFXT3M2a2F6STJTeVFsakxPZ1NpdS9WZVpD?=
 =?utf-8?B?dmwyM3FYdlYrcm05aGJHZUVqR0ZYdnZoOHB2VzRoU2paVi9VbEVucDFnaDBp?=
 =?utf-8?B?eCs1WUgzWlVLL1FXMVhiL2hySHlmdEpkZHdhZ3FaVGhtb1BqYkM3RUswSFNw?=
 =?utf-8?B?SjRaWk9nUDdBZWtVTEpnWkVUSWppZE5xckZDaWdiR3JBa1hwT2lTU2UxUFlw?=
 =?utf-8?B?SlRlaWp1MjJKM3NIT2V6c3Fxc0p4ajlVTkZVZDRyKytqYVRzbnZqc2c1MVg0?=
 =?utf-8?B?aGNtUnB1VFlFYWVCNDVneEE0U0FGQ3RZRFZSTklaaHllQzBNeTYwU0JyQ3ha?=
 =?utf-8?B?M1paZVk1NWRNMkx2R2xFWW0rR2RwY0dTdXpiazh4RkwxWG1DTHl3L1JRbGxN?=
 =?utf-8?Q?pb+0SB8gYYT8SyNVoY8ZXVM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1qUfiBN2Iak8MK+U6Pi5/0dJUOyY7g/0TGVUfUMcS2854NBEtvn+CbNwYV+d8zpeWPMWSW7ig86FlrU6IVp8nPECSss9bqnpDJF2HM2jzuczhHuu/tSGlPjTWz2eBE+upmhHAsR/QvYoQB+z08t5q218w+jGKBKfb77QaheglkrKwPAZPLt0aloQzpfHdcBbi/JXKBnedEQS5lsSHd+SHQYEpfCYhFEEvzjCcNdeBAgsAuAFkPVNysWru4VIgfQE09e161iup8PbAwVuiyRpuTs41tLiEMNQnwr59oWJ28gBDKGX2wOkrGTTaNYlpxDDR3AoCb1xNLqUiCNl0Yyuunbbo7dpNovum06x1BGpwS/fBY85JiMI4r+hBfz5+h86aO/WVFAVwbRl9y0cEK0JriRbqjacmFXXW2S4YnvKbaVwwv+2BPJTdj5WEPgmLaxO2SBNwgHOlL7hNN+v5I/T9m6VJSDmPhnprynpqX6k1UGMLEgmBfoIBG58x89DQKa2gSq9tdUA7iFa/3u3PhbLavk2aMpvLef0myf9ehImPb+/zNU+kj8F32chVCCrCn/ic8uo5euOqDTP6iRcY/6+ll0V583F6mY5AH9nc5Oao7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01d97af-c59f-4208-5751-08ddc94c9061
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:21:23.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHDPmJzPMHjrCg79dvu8DkIPpcUI0Wbvwn4Bxermv4RmN8mZIWVX2RFSCRIenKGWu7uVKUg9sQhQqvk0m1ftAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220155
X-Proofpoint-GUID: 53g8X7_lA1ATioknsXgiXseZ_jAVJ1f3
X-Proofpoint-ORIG-GUID: 53g8X7_lA1ATioknsXgiXseZ_jAVJ1f3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE1NiBTYWx0ZWRfX0M6mAdoSxmib
 w/mCo2MG73/lfLAi3f7/GANzuMCgXvsnp2nG2FgalauA1hudZ7g1k3TbhaWwkwDeGxlx5PwVPUR
 1jO5zXJJG5XSnYnLock3g8hNgF8kHez63tOgdOfcYd4fPTzx2F+5thg48NZnoSWdCxZgEejBxQY
 RD1XZ09dKre0o76eElfvyzs+xIk1YsVHwArLBbn8xscXbsWXq9GQvB9oShfd++sdXm710fdJzk6
 nKNjSuqXNq8ORV5lzYPZrd6BQlyC8fGPGCku1BVmhtWbisabe189sHEzdFuvvzC6qROxanqXaHN
 mYe778o74LMnV9DcJE/6CIz2TdyyVQOlStDhKKX/oBNcYGVfRcZ6/PNSIfZ97wkA0TMuwe6Qpba
 Y/UUlUrAXJKFgl1+baN+yCPLxpPz2IKMyPlDewOfAKjWCsi9wg73vLcEq94xCgUIAVlLlvns
X-Authority-Analysis: v=2.4 cv=IPoCChvG c=1 sm=1 tr=0 ts=687fd6a7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=U40Yx87jAAAA:8 a=xs52Cs_lJFdGfbY3zQEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=yv_D6YSC6K1Ih23S2Yuy:22 cc=ntf awl=host:13600

On 7/21/25 8:20 AM, Mathieu Desnoyers wrote:
> Hi!
> 
> I've written up an RFC for a new system call to handle sframe registration
> for shared libraries. There has been interest to cover both sframe in
> the short term, but also JIT use-cases in the long term, so I'm
> covering both here in this RFC to provide the full context. Implementation
> wise we could start by only covering the sframe use-case.
> 
> I've called it "codectl(2)" for now, but I'm of course open to feedback.
> 
> For ELF, I'm including the optional pathname, build id, and debug link
> information which are really useful to translate from instruction pointers
> to executable/library name, symbol, offset, source file, line number.
> This is what we are using in LTTng-UST and Babeltrace debug-info filter
> plugin [1], and I think this would be relevant for kernel tracers as well
> so they can make the resulting stack traces meaningful to users.
> 
> sys_codectl(2)
> =================
> 
> * arg0: unsigned int @option:
> 
> /* Additional labels can be added to enum code_opt, for extensibility. */
> 
> enum code_opt {
>      CODE_REGISTER_ELF,
>      CODE_REGISTER_JIT,
>      CODE_UNREGISTER,
> };
> 
> * arg1: void * @info
> 
> /* if (@option == CODE_REGISTER_ELF) */
> 
> /*
>   * text_start, text_end, sframe_start, sframe_end allow unwinding of the
>   * call stack.
>   *
>   * elf_start, elf_end, pathname, and either build_id or debug_link allows
>   * mapping instruction pointers to file, symbol, offset, and source file
>   * location.
>   */
> struct code_elf_info {
> :   __u64 elf_start;
>      __u64 elf_end;

What are the elf_start , elf_end intended for ?

>      __u64 text_start;
>      __u64 text_end;
>      __u64 sframe_start;
>      __u64 sframe_end;
>      __u64 pathname;              /* char *, NULL if unavailable. */
> 
>      __u64 build_id;              /* char *, NULL if unavailable. */
>      __u64 debug_link_pathname;   /* char *, NULL if unavailable. */
>      __u32 build_id_len;
>      __u32 debug_link_crc;
> };
> 
> 
> /* if (@option == CODE_REGISTER_JIT) */
> 
> /*
>   * Registration of sorted JIT unwind table: The reserved memory area is
>   * of size reserved_len. Userspace increases used_len as new code is
>   * populated between text_start and text_end. This area is populated in
>   * increasing address order, and its ABI requires to have no overlapping
>   * fre. This fits the common use-case where JITs populate code into
>   * a given memory area by increasing address order. The sorted unwind
>   * tables can be chained with a singly-linked list as they become full.
>   * Consecutive chained tables are also in sorted text address order.
>   *
>   * Note: if there is an eventual use-case for unsorted jit unwind table,
>   * this would be introduced as a new "code option".
>   */
> 
> struct code_jit_info {
>      __u64 text_start;      /* text_start >= addr */
>      __u64 text_end;        /* addr < text_end */
>      __u64 unwind_head;     /* struct code_jit_unwind_table * */
> };
> 

I see the discussion has evolved here with the general sentiment that 
the JIT part needs to be kept in mind for a rough sketch but cannot be 
designed at this time. But two comments (if we keep JIT part in the 
discussion):
   - I think we need to keep __u64 unwind_head not a pointer to a 
defined structure (struct code_jit_unwind_table * above), but some 
opaque type like we have for SFrame case.
   - The reserved_len should ideally be a part of code_jit_info, so the 
length can be known without parsing the contents.

> struct code_jit_unwind_fre {
>      /*
>       * Contains info similar to sframe, allowing unwind for a given
>       * code address range.
>       */
>      __u32 size;
>      __u32 ip_off;  /* offset from text_start */
>      __s32 cfa_off;
>      __s32 ra_off;
>      __s32 fp_off;
>      __u8 info;
> };
> 
> struct code_jit_unwind_table {
>      __u64 reserved_len;
>      __u64 used_len; /*
>                       * Incremented by userspace (store-release), read by
>                       * the kernel (load-acquire).
>                       */
>      __u64 next;     /* Chain with next struct code_jit_unwind_table. */
>      struct code_jit_unwind_fre fre[];
> };
> 
> /* if (@option == CODE_UNREGISTER) */
> 
> void *info
> 
> * arg2: size_t info_size
> 
> /*
>   * Size of @info structure, allowing extensibility. See
>   * copy_struct_from_user().
>   */
> 
> * arg3: unsigned int flags (0)
> 
> /* Flags for extensibility. */
> 
> Your feedback is welcome,
> 
> Thanks,
> 
> Mathieu
> 
> [1] https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng- 
> utils.debug-info.7/
> 


