Return-Path: <bpf+bounces-64759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DC0B16985
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC1563167
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 23:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB68239597;
	Wed, 30 Jul 2025 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bpt2H7eO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h06WiSi3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1D72637;
	Wed, 30 Jul 2025 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919961; cv=fail; b=AP2DroNhBKsgIfZPd5wyf24P84ZdtDNsQrT/lXfcQd4CNCPV9LQ78kVdF2WJXY8eWOKLWdFNOdFs+uIxRxoqZT4UZHsZ2wnoJaQ5QeztFahRTZvh3Ic8t4yN//17mx8ywCmWXgMXPyWWg2gyOEGtkZ0ri+ekThBX2LgvUR7Kv/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919961; c=relaxed/simple;
	bh=qS8xPCoWi9NsTFnjRCQumGSnFdaptoukfwmJTU2OAqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mSP8qfuqZ50DS2jtlX+oVgUZ8V+OCUREVzHTNVNkfXkbBiscPxJe0V69dNnLqZGaLAHst3JywqpFNuECDytjLpeG8wmdEw2KUbbckjQ3qtfLyjNhZEWM9Jy9e7D+VJgJCEzWQnuTGhM+2QvwdMSGkzFzDJBoxrZ5AgcMfOv4Xfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bpt2H7eO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h06WiSi3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UJC4Ou020012;
	Wed, 30 Jul 2025 23:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O9+sybIGje+FoEFxSes6pF6RtsFkNZI24LdmiNawaW8=; b=
	Bpt2H7eORpH4pz6FZ5d2GgoFGi4kYgD1EbhrXjmBviRH7qCg6WeAno5HD+8aFja+
	geP78UXWHEUM8wRsEbLGqtBOz0FWbQmKh3hFTxyAh1A+NuxFP+JQ+eoGjGyVxGae
	N5novU/8kdo8UV/IjMjNiS2D8ntZd2mManSE7FCQNeHiesW3vfMz2jDcQZ2yo0z7
	DdP6ckU2uWz6nimveggyo9lFl0L34bwTnk5CrRpedHbfE3k5AII2SmuBtuE8IhdF
	EBDWi8T0W3YCLs4WLAKzXp+dQZjxlbaM2kbiyClCDjL4iP30uQP0wjoQTli1sRgH
	XQbQgywRN4yx7v7jUISDOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wtuh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 23:58:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UMP9KI038823;
	Wed, 30 Jul 2025 23:58:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbjkfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 23:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azVffDMwfQ+ciK+No2ofs7ZJSuppGR/avQBfZaT5/SIYgSTBPzoRhNhgL6IjQoMKSQ6NP/r495DjdPFcjbBNQ06r6fsw7PHZ/pi8fii0Nqpfme/24RDwv42F/ZAUKw5NP7BS+oPF1n4821OjlObvJ4ob5/EgrUSBxEyvzqxBOWAFDlWE3Z6feZwd0HuzgzIZdvBGP/+Oa/QQasRu07eDlykbFRa7qKOg1n2/LTZ+9ybAXzs9p4rjRvolg0cXyAneuQjMygF9pII0TqYJ2Nt2IA7QYP1zj7NJW4QiEu1DcpjgFmdpAqyPAHSzc7ecQ5906sRgDxrKgGv/n1HhrH6y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9+sybIGje+FoEFxSes6pF6RtsFkNZI24LdmiNawaW8=;
 b=T8nKGFeAtPQizwRgcPF0Fl293D4f5CxEtJWkCgAh2rABC3rO9PLbaZtzsKP8+rCnuNWCf9HRxToKqaMfps4oBJiGYNV9xdCGFq9qkY2MI3K1aTn6QdjcANtH6XvBH+lartRZ200wrTtHzWaKxqGgjz3OC2z2//Mw91LAUfCy2HghJh5sZBpNmVNQgubFSOUCyUbJLN2KtyehEtxBvO9A22G1o5UzD7RzhieH+uCMqYLUJCY1cMYwz5bzdGXtVZpx6UemKU+gfBRxdmZM4fhkdsbv8RC/Ke7SWGiI/WnkRs3dJQfbijIMXdbVBFPrU5K49lP+DiCM8B+E9HgPsgxXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9+sybIGje+FoEFxSes6pF6RtsFkNZI24LdmiNawaW8=;
 b=h06WiSi3IT7nkewSEDCZGy9I82DQXNooNMszgaoMjxKhKdbLn7tP5NI02jMTENUgwwMMz/CMXVj7F7MpzNHKQpA2nhXZ8LZckTAhm/uywMQMzJfRrG5G7RzbLKzVxdAfKR65qYNCbNAb5D1BUQuI+f4IiN6PF77l/kAkFGzfJpg=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by PH0PR10MB5683.namprd10.prod.outlook.com (2603:10b6:510:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Wed, 30 Jul
 2025 23:58:19 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 23:58:19 +0000
Message-ID: <f64326cf-ac2c-4a24-9267-4f2a25045828@oracle.com>
Date: Wed, 30 Jul 2025 16:58:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 03/10] unwind_user/deferred: Add unwind cache
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Jens Remus
 <jremus@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>
References: <20250729182304.965835871@kernel.org>
 <20250729182405.319691167@kernel.org>
 <e0f46e35-5152-4d0a-a2f2-54b2f83a56c7@oracle.com>
 <20250730093249.4833be14@gandalf.local.home>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <20250730093249.4833be14@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0247.namprd04.prod.outlook.com
 (2603:10b6:303:88::12) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|PH0PR10MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 000a905e-85fe-4272-c6e7-08ddcfc4f54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3FJblV2dTV2NWMyR3ZYVWI0b25SMTc1ZEhhbGttcFdYVzhWanZDY0ZvUmgy?=
 =?utf-8?B?emlhY1pHcXQva09RaTNkTlJCSmkxSktqcnpZM25sTHJXOHg0anFIOEdGaVRR?=
 =?utf-8?B?VU9NOWxKRElPNHJOanczK2VUai9KcUhQQ2U4MC9xOG91Q1NVcTFabnlMVnIw?=
 =?utf-8?B?VE45b2RHSmN1QXpnVEdNSm1yOG1EQ2VoMjFJWmdXckg4NFlVNHRWV3lVRHpT?=
 =?utf-8?B?UWV5cFlIOTZxUDVFaStYMThrN3QvSkZBM3Qzb0RXOWZiVEVJc21tcFFsTWxj?=
 =?utf-8?B?VUZvNytHVjlwNTB6T0VqSk91bmN1ZFdoYVVmbWxDbU1xZXpHOGRhWUtkYmxi?=
 =?utf-8?B?YXR0ZnpoMWRnQjRDdlJLcjFuOU1SbXdnM2hYNXhSUjAyT05pUWo4L1FsdU5F?=
 =?utf-8?B?RXZyL3IwVXQrNDJqNitsajczVWFWTzFQWVFUMXFTZGJsNHYySXVxZUJSdDZm?=
 =?utf-8?B?MEFidi95bVc3QWQzbFdQTmlCSXo4R21kQzcyOTFlb0Fac2VIUHMwOFVCNGc1?=
 =?utf-8?B?SjYyQXdUcTJpdnlJZ1pqelhuWGhQRUtvODlDMTJGK3JRUDVVWGQ3REhYb2tT?=
 =?utf-8?B?K09sSTAzYlM5NVlWb05VUnU3T21lTDhDVk9xTVNGcy85ZithenphWmFzdURi?=
 =?utf-8?B?S3IvZ29WNjk5dzBzSFM3UHU2M1dzQVVHUDRNWmVzVy9TNjJhVmorcVBNbTJP?=
 =?utf-8?B?ZFA3WXhNNEJ4K1E1RnlSSzVYdG82eXhBRUo4WDdvWFRSOTVZd0dLZHlHZjNC?=
 =?utf-8?B?Z3BWVTloek5HYU9SOWJWU056TDNUY1hnOUxLRW51cng1dGVNYUw5WElpd29j?=
 =?utf-8?B?b2hVQklyeVNqWEthOGllOTRvNTB0dWVkSXZ2NWs1NHo3dHBrNCtjVmtOR0lW?=
 =?utf-8?B?bWxpaFhMbk9XNWk4ekhRcTdaQXNjcmZOUGZOdnlrRk9DK0RmcUdWNUh6NzB1?=
 =?utf-8?B?S2p3SmZhT3dlbUU2bGFmV25XY0ViL1Vqd1UxRitncGp0QVNkaHViMjNFa0FZ?=
 =?utf-8?B?MzJhQ1NxeE03dWJFK1RBeFNzSEx5STA4NXlzNUFTMUZyZjU0UW5HN1Ixenpm?=
 =?utf-8?B?YXpQdTZ3SCtFUmxFUVBLS0pBRUN5TVFIMEEvZnc0Y080TDZ1KzQrdU50RVhG?=
 =?utf-8?B?ampRMHJBK0hQbjNvT2M3SVhYSmNtSWdwT0VIU3MydWoxUjRpZjNjSUVodlpY?=
 =?utf-8?B?TkUyWnpvNHUySTZMc2VSMW9oM2lZMnN4bjVQSm95UzAyTEhUYlRKQ2FhblZL?=
 =?utf-8?B?SFpncm8xT0k3NDkrbTRwZWVnZStQOFhxUmY0RUt4M0RkSUJPUGRqVkpLUnhL?=
 =?utf-8?B?TWVhcEhuNTdzMm1zUk45MzR0VWVabzNVR2Z2ZzJhcG1nc1pTYnM0U3k5WUtv?=
 =?utf-8?B?UEdRdlcxaXlKNTVLTkRxZm00djZSZWVYQWRhbXRjZERMbWtCY1hEa3dvdXNI?=
 =?utf-8?B?N1lPSWIwNjlxb3puRERCSlh1VEhPd0djMmZKU01WSFI1WXJ2MXhhWnI4alpN?=
 =?utf-8?B?TWpoQ2ZCYUVZYkVTN2h0LzNja1VKVVlMRmhOb0ZINTBoZU9FeVd5Wis2ZGVQ?=
 =?utf-8?B?OVJzWjBSV2NoUTUxMU4wVjI1ZWdQVTltRmRRK1hGQW05bGRGZnBSanAwd29Y?=
 =?utf-8?B?aC9yL09qdHdNQmx4SGowYWlncG5EZ0I0ajVDemtJVTRvalNpV0J6aVhpNHFF?=
 =?utf-8?B?cngwN3lzS2RzdFVMV1JoVVkzOWVVWEdyQmtaZlVLdlNUcTFYMGRoUVZwZGl6?=
 =?utf-8?B?Tk1mRWVFL09ZMDZraWJ3aHkrdTI5UGFIYUlZclArZWlMMXJUdVFzTytlQzFa?=
 =?utf-8?B?M1RWdERGdzJpSVJsbDU2MTFKaDVHM0w4K2tlczBFa3hESmgvVzFpZXZoRHFV?=
 =?utf-8?B?amI1aXJiNkVGT2RrOUlEenNaOXlxTXMrcG40MjRqekQrbWs4a1RjSGNreHpx?=
 =?utf-8?Q?/dyKFwvs7mc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnEzQnp5VWxUMThKVjArWHdTTGNkVWp6VGFGcVRJOGd4VVdjOHdHdC8xbVAw?=
 =?utf-8?B?M1NxQnh3bGJaS2cxTnhrVzJKbWZCemIwaU1KUlYyS2F5WVd3UUV3SDl3R1h3?=
 =?utf-8?B?MjNMTGRVK1BzVktTclJRcDZCSHF6SmI0eW9ML3BodE5OaFBJWnU3VHZDamw5?=
 =?utf-8?B?RFlZS3ArK2lQZEdoR0d4d25DNlFObjBmU28wM3VCa3BTQnhKeHlkQkJCQ2lO?=
 =?utf-8?B?NytyVDhKUTl6eUtZckxCZEVnTDhOTlBLZ2NIT1RvSkhQalc4a0tteUtybGVD?=
 =?utf-8?B?V3FWR0gyNnpVaW4zUndsN1dCbnc0YytYSVRlL0FQMXlqRGczSVUxdGhKSElu?=
 =?utf-8?B?ODl2WUh0aHI3U1dIOFVDMFltM0c5cnc4bzF4Mmpya29YaDdndEg0eDJvZnRz?=
 =?utf-8?B?dCt1Qmx4eG96YTJxdGtYSTMvTG1wWjVMNGJ0RmsrNFFYanlHTVNuZFdlZVAy?=
 =?utf-8?B?Y3RoYnplSW9mZXJTc0VCbUhrVHBuQnJSZ0JsbVpnME9VZ3BaMFZ2TzhNZCs4?=
 =?utf-8?B?b3ZFc0NURkdrNDk1am1PdUw0U2ovL3RuSmR6TXQ2Vi9JMldCT1k3TTJIS0Qr?=
 =?utf-8?B?K0xGYWRrNmNZeVJsMnRlamhZUXl6eE5jbmgxV3pQRnliY0tDNXcrNWw1TC91?=
 =?utf-8?B?dGtvQVBOUDFwY1ZXemRtSlVyOWhZbEFBQjVuVXNYejdQQ29TeCtBZmhyUDMz?=
 =?utf-8?B?RDhNZFRjWkZhN25ZTnFuYkZRWVFnQjZEMHd6SkFxcURyNkNha2t3REFUckdW?=
 =?utf-8?B?emxZWkxsWldtbXZ2c0R6NEU3bFBXVHF6TFNCeDJzc2VwMmp6RXZYYTVzREZv?=
 =?utf-8?B?TU1TaVkwUmFYM01EZVRSRHZZSzMxdkN3a3FrWXJiWmwwU1pFVGZRSFRNeVh5?=
 =?utf-8?B?ejZDamdCd0d1VE96ZTEyeENoQUlRMjFKSFpqTzR0cm5ES1FtOFhrbTlaYVdn?=
 =?utf-8?B?TytzQjEwS25LWHVuSkJQL3ZPbTJXYWhSTGhxbjE2NWpXWms5VUpFbGFkSTJD?=
 =?utf-8?B?R0VCU09lVEMvUGpaSkc3dW5jWXhBa1VvUUFmR25YUVUxNExEYWtKYmFJWXhN?=
 =?utf-8?B?ZDZUQm43V290Ny9BK1E0UzgyL2QwMVl2MlNJeXNQR05wcjNkVk1aUk5wQWV2?=
 =?utf-8?B?UzQyMTJlaWhVcGNUVUZNZnAyblpVYlBGN0JsbXRCK3dUT1RxQlNzQXFSMVBN?=
 =?utf-8?B?dVVCU01oa1NabEJqWHNmdDhEMDdmSy94Y3dVNFJmRHZFMEsvMG1HOTZrNldp?=
 =?utf-8?B?YlBMWGttZnhoaTkxQXM4cDAyaEk2UDQyR3VidTI0VDZzMXR3alVzR0lsVmlP?=
 =?utf-8?B?Mlp4aXNZRFh2RVFrbFVTbUtReUhJS2hGaHE4OXN5NklrSllFcDM5THoyWFkz?=
 =?utf-8?B?ckRNU0EvbjI5N3BFSHdBbjMrL2RDMDlxK2ROVVAxMlhia1RGQnJmdjBSNXdh?=
 =?utf-8?B?Qmhob3dkVDdmTWpNbWJMNFpvS3BqZTNRV3hPS0xTd3BZemt4VWpSVTBLaE02?=
 =?utf-8?B?L01KNjZhdjNLa0pGeTU5L0RtY1lXUENoTFZkZTBqOUNqUTF6QjBaSThDcG1M?=
 =?utf-8?B?eFhLalBVZW1KSFNOSFVCQXIxcGZ1dnJuT3djTWJKWlNTb3dnUnNkYzFCUENL?=
 =?utf-8?B?ekZEVWs1TXNnSCsyYS80SmUxQlp4QmhoNU5SNjNCbERsdXl4RnBlb2JVK2gv?=
 =?utf-8?B?Y1IvdlVGemRxWDByaWdKZ0FrZTdNNjcrWjZtNlk1YUdvOHI1RjFqOVBMazlu?=
 =?utf-8?B?dzBvVXhjcVlNbEx2TTdtRW4wTXdrd1Z4V0FwNmYvVFdFUW9yQy91VUs1ckNq?=
 =?utf-8?B?dWt4TGlpbWdnaVNWWDUrVVMycDMyQ00wbE5TVlJNd24rcy9oTEVpRDdPQzc5?=
 =?utf-8?B?TXJCa0xJQVhJazNwWlVkR1EydHpmRCsvalU4VndUQUJjd2NMZndKRU9RMFZK?=
 =?utf-8?B?Q05KS3RqWjVSbjFpTHR6aTR3bTZ6cEpGdDh3TFNwcU1FRzFpb2RCKzUwNEl3?=
 =?utf-8?B?NHRBSlZkY3JHSENjYisrUGFJMTU2SkZIUmRZa2FIbkVQZEZBTmFiN2YrNFNR?=
 =?utf-8?B?MVpIMmJJM1VESVlPamR1MGNMeXpEUVlKZ2pyUC9XaU9jSEtYWkRUZE91ZEFN?=
 =?utf-8?B?WXBBZTJwZGQyZWt0eVYrdkQra0wyOHdXOWE5M3dpM3VoRWdtUjFoN3BNUzlP?=
 =?utf-8?Q?Pe/+Jpgvq7pZawrCEKRWsf0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VKhebeW+1YIVZEaoUk0rm1C0kwUcUJfAwK1BR04JrIqZZuXyqm1MRV7+5YXKMjr5WDlsaGYqAoNlaYZ6nXn/ZGcgjp+qTQh5btH6vgObZ3gGCkZVyvArGvjKLWRoOn5PEeWVOiYLVmrS+ACbntnFBJaXX4i4rEZL8uxtKVo0lBdvIgHu/yBQLzxx0lgKFhdbg21l9if4YCB1rZdhC0l0k1QkzubMHYGp+xPOg8mPrG9PpJvkbRf5ulttwihjgQnsKsIH1L/yMmW31m6LU2B7+CSTTm4onSooCw+n2lHoj6xnD9JK8M205jI0eEArMJCzPBH/vPBDajlnZEqOxq2jn4UYNVidDH6xqRzMgxvvsKS/10mQyFHc+9N0NrVmKVL/itsLL4FgqFfzjHumhfmLcTMdNNxcuLC1UZSFv3+r4VUV2JYx1WVe5M36gQlwDWxvj0J9Zwhmk5yju+JN3h75YNLcCetl9JDW1qpSBfvveiqOqHkSy/7PI9uw37UqBgaG2W7MGukd2m053YT9kwuptmzQSieb8FrrkGblOEznQN4t6+xt7FCGp1bzhHiiLtNbADvAgWmoi535xOT+LjN2gpTOrDxBGH6iU8rBADj3+D4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000a905e-85fe-4272-c6e7-08ddcfc4f54e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 23:58:19.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R4pDEs9ace8POQaYG8UrQWVsAANZpsedT3Y0sxI1J5GYyetb0gOcQSyAMGpPy/Xv6pzfrBiVtVL5txDTsiVog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507300178
X-Proofpoint-ORIG-GUID: mx7IphNo48IxID-6H0A1wkmd7h_dVqCf
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=688ab1a8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=qWbYbpd6aP1NntcuhEkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE3OCBTYWx0ZWRfX2RYDLEWcKemb
 chS7DawlIyHj5oXihdjrfBaJjlFc+JSIynKvKshfe/ZQW3l9LnOH9gb6HHDxlmJFd1cL4FOQu2c
 nYbWpXKUsdFeTnTTmY4jWr2ST4qd2udBy4waHNOCyZpyhPjyWGmhM3k0HLAGpSwYL+Rn33lBvZ/
 CoXCa9FyEAiOLY8jarWc+/d2UAn3QWOCxpE54kr8aWG24bbT2rfdR/UCNiz+DvwGoYqU7NIqBiZ
 v+n9vEXvcSmDIYyz+MlK/6O+0uk0mHzsiZUG655VqYW4gHzZ6NGqoiuKXa9UGy4X6WpbXUSvudY
 MSWvKu6/rxTIWdzDk+wEutuh6drNceda8GqaCpjjXZFoY4VaN5CQppWzmiFcEs5loCBunBPUfBG
 rt4JP4MWaqJeeX1JGDenjuZqlakRB4xTpw5wCKPvfbLQ7ghEGfFBQOhkqxMDPlO8dBrI5VxW
X-Proofpoint-GUID: mx7IphNo48IxID-6H0A1wkmd7h_dVqCf

On 7/30/25 6:32 AM, Steven Rostedt wrote:
> On Tue, 29 Jul 2025 21:55:39 -0700
> Indu Bhagat <indu.bhagat@oracle.com> wrote:
> 
>>> diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
>>> index a5f6e8f8a1a2..baacf4a1eb4c 100644
>>> --- a/include/linux/unwind_deferred.h
>>> +++ b/include/linux/unwind_deferred.h
>>> @@ -12,6 +12,12 @@ void unwind_task_free(struct task_struct *task);
>>>    
>>>    int unwind_user_faultable(struct unwind_stacktrace *trace);
>>>    
>>> +static __always_inline void unwind_reset_info(void)
>>> +{
>>> +	if (unlikely(current->unwind_info.cache))
>>> +		current->unwind_info.cache->nr_entries = 0;
>>> +}
>>
>> Should the entries[] items upto nr_entries (stack trace info from the
>> previous request) also be reset to 0 here ?
> 
> This is in a critical path, there's no reason to reset to zero. The data will
> just be stale. Nothing should care about anything over nr_entries.
> 

OK.

Reviewed-By: Indu Bhagat <indu.bhagat@oracle.com>

