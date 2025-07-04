Return-Path: <bpf+bounces-62419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1999AF9A3E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F8D178CE0
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA912DEA74;
	Fri,  4 Jul 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="du4caeYs"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2131.outbound.protection.outlook.com [40.107.116.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF652DEA6F;
	Fri,  4 Jul 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651909; cv=fail; b=YYr+fW+YPXJ5WYZx4TgX1umtNXnURPzlRRz4ZKIGYt1EaCsMjjuLa+0N12Lt2fz/zCpHTsVrpoRTMJufsVCYnmWfLAoHgaubyGiyOzLs7pqt6e2uwIxmq0VwhrY9SKR8HmSWA0m2S9db46wIjgGR1DIP6y8zrWrDgemDxTsieco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651909; c=relaxed/simple;
	bh=TtcG0R5hH90rsq6Nrof3IpymhcmCLxfRh9UgQbiqtP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+4WbJ/wjntb3IlWnFFR+3W89PskgXXDZQHkOnr/e9oFHCCcKcOdgvy+ihucarz+A8GT2EXLpI4SnN2h5X/simJuhUY6yJ+6c9+/UhV91RMSf65iPX21cdidsGaB2CQKNmEM/FO8c3gdjtFY716fYLzA43svdaiAcUXjxqFnpuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=du4caeYs; arc=fail smtp.client-ip=40.107.116.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNPqy7QM0GuQAPqWzG1pgpM82VpBb+NtcUkzBevLUfIamz+IxsUPniHD69/AwYZ0Aggbrl3s06DhLHx4uByIbccMa1zj2s2TK+SXweO5ZFGU2aP/LAgb2pg7ASCtSt+glDgBTWMQeSJraLYe7ur9jd/Z4klAnt3Zwr/Y75r1rTIUGBrWFYaeF+Qv5a+xAho6BWRAoEe3Rhr7n/H65xj5OOi+LM3h2tC/bnkjRMZsOT3U5eQsttwBl/YCD5o/oZ8GLXKdW/TaOKGhMMlScat+QGaPkdMI7LLqCLn+gTEkIsXQOHhl7TmCsY+vVD+XnAkOJ6At9Kh8WvoPh3w0+vz1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPGSxM2Z6FL3uYcR1xGYYd92+pg+Q4ArzQnxBZG2bqs=;
 b=Gpzb7qspbul+m+6rmAIvkzmiXPPxwutPO6c4o0d9p9K0VORqgd45Psldtrc0HBftFaAPtNOTnqTAJWP7OH5jkGefmudzaW1NrWKVfhDmfXyjPbq+pohhi3oaS82JvpjLtgXoMJxu1FX6rMUFp8aELyDfxeO5vK34RhRvSaHEiuciauEtqNiMSHPDDycX2JskZG8CxFRDXDWnjlYeSwhD/fDr6+IYVQ7WfJhGNFl6QfwVocsvQhv1+Kc8sPkyA4CaJapGonwfZTXqRBxc6pWdshLBKvQwbGbuNp6k59ZgloGiMabmMrJCiuHHj9DHqTdki98udqH/Jp9kzlvGl1QFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPGSxM2Z6FL3uYcR1xGYYd92+pg+Q4ArzQnxBZG2bqs=;
 b=du4caeYsHIgzCTphGvtRbGGHGNDyEYUDkCKDCkUHBlH1OoKP+mPXh2HS2xrdd/MPl5F8kLILK/ne1B+igmpQJwkhP1aOpqdbmeOGlrAL384sarGGObppSzHokqJwaRvqff10WLt0MY3hW7Lkg5OXyA+Xbkqd7ZDWPnStQ7zNVfH8WU0uVMtUi2P+f6PSFsJ/1/HcfJdsAirRnRBjtiEsK207ye/QI4aQ39Jq+8/0f6BE3RBhtGujKgrgVg5dhDbHRjjuRQ0M9SRq5z4p/7115C/pC0ONq9qfBQvk2eLldhhnPgFqJjSUqL7WSogTuwcTSmtl3PTO7Zb16oy8D//T1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB11038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 17:58:22 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 17:58:22 +0000
Message-ID: <45ac3409-81e1-488e-91b1-167e5dfbe1d0@efficios.com>
Date: Fri, 4 Jul 2025 13:58:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/14] unwind_user: Add user space unwinding API
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
References: <20250701005321.942306427@goodmis.org>
 <20250701005450.721228270@goodmis.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250701005450.721228270@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::35) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB11038:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d825112-6953-4623-3244-08ddbb245d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eThUTFJTaWl1UEFINE5sVVRwK0dOSU00WkxCdFNueTUwQVhQa3NPdGZXb1VZ?=
 =?utf-8?B?MEt1Y1k5SG1PVStqb3VFNVNHd1lhUkRFeXFDUkcweGNHcW44S1JLek1jOVhT?=
 =?utf-8?B?ZjJlV0xjOXhZWk1zczdWQjlSbmRmWTIzU2JnY0krYURuRmt4K281Y3hxaUo5?=
 =?utf-8?B?V00yOEUvWnRMejliNjZVNXdMRTZKWlNNR1JRTXR1RHcxQ3lWeTFZYlVhWlp5?=
 =?utf-8?B?N3IzVDRVRUcxMWQ1OVBQUi95eUp6RUdqRFNnRGxCSml5NFQvUFBDWjlIZnNN?=
 =?utf-8?B?Mms2N0RLQ1pHdUxnS0FaOXFObGhQdktuQ0VKeUoyckVhWEhoRVh1RThydkJu?=
 =?utf-8?B?ODMzVFd5WGNZRzFFVS81N2hNTXl2bVI0eVBkSkhmWVFJdTVFOCtaR3JBNGtG?=
 =?utf-8?B?VDR6dldkZXB1b2dISFlHSVF1YVVWZzBXWitzTjM3MmxYTXFEd0l0bldCNEJI?=
 =?utf-8?B?V05SRHhzUGUySUowU3BXZDZhaTIvcExaRG5PeVA0VG1WT2p6Y3ZuN3pYeWRB?=
 =?utf-8?B?L2UwcHJ3L2gzem0wYStZaVdNdjBXR1NnSUhDcWkzeXdPNllycVZxd1dMb0VY?=
 =?utf-8?B?Njl1K29VUjRiMXlRbnp0cWVzMHlPT1pEcjAxZXRmWTdpZDQ3WEs0b00vUUVR?=
 =?utf-8?B?L3EyTVArOTE1clRIQXVUVTdtSnp6blJ2dy9jOTQ4UWFYbVluZkR3Z2VnV2g1?=
 =?utf-8?B?QUVkazh0dFo1UnFXOFNOcjl6bjd0UEluQWJKaG1vRTNjYlM4SDlZb3dsOTQ4?=
 =?utf-8?B?dWNFa1BiZmlIVkVkN1FvdlBtaTFiVTAzZzFRNEx6V3Zwcy9hd0M4ZWZLaTV3?=
 =?utf-8?B?RXFzaFEyaHBHRUw1SEU1SXF1NFFPSmNiL2ZqdHE1dE5TSGx3eEFnVC9xK3Vj?=
 =?utf-8?B?OW9lU1RHU0lOMk1jaVd6TmJRZmRmSndqZzE0Vk5pSjlQMjhDK0h4WGgzeGVj?=
 =?utf-8?B?Q0dnV3ZldklNU20xRVc3aGxQVTRyVWNiQUcxRTkyVnRiSDNxK2E3WHBVMGdO?=
 =?utf-8?B?TXcvRzdqWkxrdTJnOEszVFZJT3VueS84d3NBQjV5SkplcllTV3JNZ3o5ZUU5?=
 =?utf-8?B?dUhTYmhBVHVEanhySm1veWNON2x1RVl1cHNlVXNxaDkwRGlGZGRJWWlDSGhv?=
 =?utf-8?B?RXZrWDBUWk9qNEdoNnFYWFBRSUVZYUlhMVBIL2ozNGRobzRKeXp4eXBsL29k?=
 =?utf-8?B?dFN2WVZWaGpVQkNkcUJYWmt0aWh1WjVBSFVWTFFXaklnSEVFU3o0bUlUZGVO?=
 =?utf-8?B?M0Jldzd1TER5MWMxV29FZ29KTkVVOW1oVXhKaFp1YzdJbUU2OGlSTVR4Y1Fw?=
 =?utf-8?B?djcrMnRSRG5HVnZvRmVLUHlKVzlhVy94YmhHQVR0dTczQ1VzTGs1OURudEYw?=
 =?utf-8?B?cjA4T3lXbjh6S1JEQU9EL3J4QXJSMVh5aFEveEtiY2hhcjNaeTlpTS9wazdO?=
 =?utf-8?B?bWdKMmxrbXluWTdQU2pEam5MamhMSkhGc0VLYkdvTk83UnRFeVRoT3dwWVVl?=
 =?utf-8?B?OHRTeFJLUm43VWNoZENHcGs5MU9qMFg0T0tnaHVJZnppWlJTR0liNm9RNG9F?=
 =?utf-8?B?cU8yVzVNUVF3M1RFZTNnUlNoVTJ3SHZwMUI1OG00cEJiQjFJNTE3MmRONDhZ?=
 =?utf-8?B?TmsrY0JJMlREZHZNZjE1MVFCT1NiZHI3NEgrdlhPeExkRXV2NTIwTGw0emVN?=
 =?utf-8?B?WGM2MWhQVG5zK1BqeTRnQ3ZzQ0pMVEdwVndUbzZFN1BGVnBraVdrMjR0bFFR?=
 =?utf-8?B?b0NjZTN6N1gyTVMycEExdVAwWUFLRWcvSVhHM3lGZnVzNUZCVENBanJ0eHJ2?=
 =?utf-8?Q?eqzc42XsZKZwHSkCO2S3lAw25Id1cbQ/jIsH0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjltOFcybmFCOGxYaUUycUZINVRxcFJtcFRsVSsreS9XZkhRSnFKZm55eGdX?=
 =?utf-8?B?Wm92dUpudGNJSDRndVFjTzVNMjdHRjRKVGppTmIyL0l0MXhsMTMwZGlHQk5N?=
 =?utf-8?B?U2dLdkFlU2c4Q3F0Q0pqZ0pUckN6bVM3S29MOGhoKy9JTU9VYlE2aU9YNjJH?=
 =?utf-8?B?RmF5MmtlQ1VVMEVrM0tMWmtEQWlzVEZGSldsQU05ZXliS0xvVk9XZzRndjVs?=
 =?utf-8?B?Y1JWYW9vakJtRUZyOVBDam5QRzl0K0ZMRmtqelRCUk04a200WS94TEpwdXd6?=
 =?utf-8?B?M3JPM0ZYcS9Nb04wbzdnNllsalQzRXFROXlicjFzcTZmY0t0eUhvMFNKV3BR?=
 =?utf-8?B?bCtOSFd2MW1GTWZsWVdKenlqUXo5YXlkOXFxTzBTL1V5QVZGMHNHRktUdUhV?=
 =?utf-8?B?bnVCY2U5RFFUWUk4ZW02Wm5rclJFOFZqd0hqUjlZZlZuWnMwUVRvazZRd0ZY?=
 =?utf-8?B?cGRYZVlnazBqNUp2UWQ2ZTh6VnBhL2JNNkl1TUkzMVlETUFjS0lYd0J4WlJV?=
 =?utf-8?B?Qlp0Z2Q4VTU0cUpvdnBPbXVLUkVDc0Vsb3BUVmd1SnpVek9UVEhMWFFtSGJk?=
 =?utf-8?B?eVVSWUx4MFQ1QzZyaW9pc25Ka050Q0NrQ1Y2Smg5U2tXd3JqbzhiVVg0NkMz?=
 =?utf-8?B?ZmNMRTZEWjV3UzdzdkdRRDgwSktKWXltelg4cEtwNldOZ1ZCbTl4K3RZRjRJ?=
 =?utf-8?B?NGRzK2pLWitYU2cxMzAxcTBLWkpadUsxMFBsWXRxWXlMSGdzOU1Nb0szUm9B?=
 =?utf-8?B?UEJvZC9DbWVWOWo2Ri9sWDVHcnZnbmxVaThQRWZROVRRaFE3SnZ2TjRqTUMr?=
 =?utf-8?B?dHpLY3NZQ1hyam9RTzROZnVUYUF5b0p2TUNsZVhJcDRMeEpGWW14WGdGcE5C?=
 =?utf-8?B?QTNhblRpUEhOVGtYV1pVMGVZdlZUL0QzNzI5bk9kdGRNT3lMcXhIVEpRWFYw?=
 =?utf-8?B?UU01ZmlmQkp1aGVnenJDVkFycGY4dE1YNDFVUzBkVDgzZWRpKzJ4VHJGalVy?=
 =?utf-8?B?ekFxN1czTWdnaGgwQjhadFVCUUNTNTNpMlo4SGJvOGlld204SnY4N2VQeUx3?=
 =?utf-8?B?WWhCVnVvQWpyRGR2MHVMWXhJSVNSOXJTbExlKzgwU1R1KzJwR1E2UVI3ZFQ5?=
 =?utf-8?B?UDhHbmlYUzBaZUYvZC83M2lnVlcvVFZGUUtEaGREVjNGd2JKaVA5ZVpGaWxL?=
 =?utf-8?B?MEp1Y2I0NGlCWWVNQXR6bURpRzRMNHhkWGxYc1VmREJ4dGdRTmYzYytmYVZy?=
 =?utf-8?B?NzVpOE0yOUZLVkdrZVd3NlhWaTNZWGFFVzRZcWJiU1VzQW1iNHRaY3VBYkcw?=
 =?utf-8?B?SE1PUXpYTU12ZVR5Z2JvU2pDTzhTNjJGZU1iQlA0M1phbmJ6VnllTjdoVytE?=
 =?utf-8?B?aHZaVVFFN3Q1aDNCRllGeko3UWsySXZLcWd1VGF6TlJXb3NoN0JkMy8zWnBG?=
 =?utf-8?B?enQ0WUlYaFVxV1pVN1hWWS8zdEphOTJ6TGs5b0E3bmpBTGUrUDI5ZTNCS1FC?=
 =?utf-8?B?QUFoN0NING5VTkZYNUxXbC9Xc2pXYzBaUC9IZnBBQVRxSXUzNXM4VWF0NUhT?=
 =?utf-8?B?cGZCNHNTUVNBRUJCMjRYMVVOZWhsM2Urb2E4M0ljZHhYbHJWL2gwTmlFaE5p?=
 =?utf-8?B?b092eEZSM25GazgxVHdQblVsNURudjNtVXFyUExRTzI5TThkdS9xWUl6S2tn?=
 =?utf-8?B?SlVvTWN4emYzekRJcEVVVkllYW03b0phTFdwL041cDdreWZDMHdPV3JSSjNL?=
 =?utf-8?B?Q0lMQm1ORTRCcEY2RU5JV2tobVlZci9GbEtpWm52QkFmSE54Mys1VjZsQmt5?=
 =?utf-8?B?VmMvc0s5WVk2MUZYRysrU2g5RkJ5emUyc2xZY1B5U1p2akRsS0N3NjhidzVZ?=
 =?utf-8?B?eFBCbEdhaFZVbFptZE9ZRTFQd1FXa0psNmNrMkhUZi9rZ2JpMVo4WlY0WTNI?=
 =?utf-8?B?aGk5K2tBOERYdU1DT0FyZDRydk1QTVAvTTZ5a01FQ1QvRzA2UXF6ZXNxaTZE?=
 =?utf-8?B?S1JTeXFtVDRRdnJNRHNGdERmSFdlZ3V4aUkycTlrUXl3QkVaTEZ3bkh5YUFl?=
 =?utf-8?B?Mm9PMFlCTDNwWHptMXdxQ1d1N05OK3JMMkZJY0R5NmhiTUZCaUYybW1idGg2?=
 =?utf-8?B?T2VZemY4YURaNThTcDhyTVR1cy80aWJJT3BGTXJFUHVqRzVzYjduTE9GUVZ5?=
 =?utf-8?Q?ICvqbAjwWpZTPioKoFinH74=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d825112-6953-4623-3244-08ddbb245d7c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 17:58:21.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbzjIIWfbIQ3db1AWcFGS1K5u6RN5h85yHaIIShY4Pb57Cq787OndFcCLjXVDqdFMo0GZVANFhT/lYfrE6xM2Q0KOkvIQ4FdKs69QXAEHHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11038

On 2025-06-30 20:53, Steven Rostedt wrote:
[...]
> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
> new file mode 100644
> index 000000000000..aa7923c1384f
> --- /dev/null
> +++ b/include/linux/unwind_user.h
[...]
> +
> +int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
> +
> +#define for_each_user_frame(state) \
> +	for (unwind_user_start((state)); !(state)->done; unwind_user_next((state)))

You can remove the () around "state" when it's already surrounded by parentheses:

+#define for_each_user_frame(state) \
+	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

