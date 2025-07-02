Return-Path: <bpf+bounces-62148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C821DAF5E66
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD243AA320
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF29B2F3C31;
	Wed,  2 Jul 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DITDyo0+"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2113.outbound.protection.outlook.com [40.107.115.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59354272E60;
	Wed,  2 Jul 2025 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473262; cv=fail; b=Qv9iDVkphUBUtUA2BRe41qZlLr/mgcnXgt2vRrD6qbXdjOf+hhLvolVcuSPfAAsRReuzVMnht1Rx0A9Yd1Bqp4dPyoDJ+M5AjvzKRbj7lNrs6iS4zVrSyUR3tvglJs9piF7idgPZybmS3EVTEvYUdgUapY6uxxfrHsbiwd2W8t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473262; c=relaxed/simple;
	bh=MIpnfMgrEmIxBSAbVY58gvXScID9yVgOcfj25Uci5Ns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p17M0KpvXCZyxLUqwTzvc2RjmpDKQQh+HdENMQzz5UZD4a4bqh0rq8BD3oDwLZ3d/7oNCj49qbRbo/lHWZ0UDRb7RCiAtA5sviPl4PSXit4skAMelO8VbG3SKizQ2FhkN1iMedhcOpmVG6ofHgK4837ftOvgAFNWGmx0bBxQbD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DITDyo0+; arc=fail smtp.client-ip=40.107.115.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eunkm4iL+CZNafStKM0K/z1Dk1ruMXS0GmCdYz6Xc+XK5XwiySkLfl+X06GfGDePDk0GD/rF66fMXvpWGiObblMBd4S0WhKLqmSysDznAfZQzVR+g6p7owdBCUcwmKJUKRzqDE+ooF+z9MyEkGKTPxBq8VGL09Z91rDErqUSOHipQQK1/bvRCjKXZQMFDR1HYkeCrVktBPX8FmqGOwW2cHJEsd2bw+GlWIf/qIiilfNZ05PBtyjmIpwENBCCnHGSTPvzQtbKRngS6KdQd4pcHu1Dxw9f65Cr13eSGS+L/Cp+b7/ImQ753jpEiQxBnXJY86VUC/IP9r8pKt5jL12xFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xx6taUQ57q1yAfv7cT8+bP5dK8w0F6y/keV3a1MJD0=;
 b=PHbF2dFOTN4vfzS5JRpZrvCBzOgzDQeOgt/FUsW4xeIxb7a5NDmSFehc+Lk0GU4Qj+cBayRWMJSNC4g1SkHTTG9Yjx77eqKhtznDnN/Cj/qPePdNIQEWXuWGu/wrC4jlwtmdbq9u3jfTkZ0HbplaaTgLtS0MhOtyrThOjL4ZexZNpd9LwoYVhQsOo5sK56WMQb9gEYqjm3qtaOYh53Ad7NCe2CMDwO5AkGmWbb4QyyHjFgqGZGk0llSjyxYGEXl9L/BBvwjVaF/MS1uNJQ/l7JkA8hhSFhwmCd2ekdkavUH93CfjJX/exFsMQjzF21LDZZLWKse46rOFMeotvQ2VsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xx6taUQ57q1yAfv7cT8+bP5dK8w0F6y/keV3a1MJD0=;
 b=DITDyo0+tjO9Dhosv1cT/QdtI6ZQOjWY9Uf/7tvcA/v2ssK6zfi1bpz6qx5YcgoE1lmSJhq6mhk3PCdynSq/rI8BA41UNScEbbqXzsSsjTrrHXxVsliVDymTKL0x1smHnnfXGfZAtZv4s4sh0p0Uoz+eDGvxZnox+9+LO5Vrgql5hV7yePGdYtzyB9uVCe2Fjd2B/XCSw3tO/S8I8zyQFl35Vi0w5WC1dtfpv9IJtQ6lA1QOaN1GVVZ99mdiIfwjMvavngAGrBaJtWgmftX1ZPkyfXUsRW4Ns5TPHmGCJPWc3hnXMUoyRw6rugpiFTiqQkyLrDR3daa0SrJ/yvZVSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10511.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:82::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 16:20:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.021; Wed, 2 Jul 2025
 16:20:54 +0000
Message-ID: <789666b6-fba9-4067-bae0-60a37b7c8fd3@efficios.com>
Date: Wed, 2 Jul 2025 12:20:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
To: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
References: <20250701005321.942306427@goodmis.org>
 <CAHk-=wijwK_idn0TFvu2NL0vUaQF93xK01_Rru78EMqUHj=b1w@mail.gmail.com>
 <20250630224539.3ccf38b0@gandalf.local.home>
 <202507011547.D291476BE1@keescook>
 <20250701192619.20eb2a58@gandalf.local.home> <202507020751.CB3EFC2D@keescook>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <202507020751.CB3EFC2D@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10511:EE_
X-MS-Office365-Filtering-Correlation-Id: bccafd4f-f703-428d-4612-08ddb9846b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVR5THZtSDRUYmkwblE4bFF4bEVNL3B0UzZCamhtdExJek9WZ0d5eTczeHpi?=
 =?utf-8?B?OWFyN3hLdHRxUjFnZVlCVWx6cldnNnVUenN1ekltNlVnWnl3M0JqTUZrRU55?=
 =?utf-8?B?RUx3Y291MVlDN3JCR0wyMkpmU2NSc2k5RnFVcnJucGsxOXlBQ0wzc2dIRDJ3?=
 =?utf-8?B?dEVPQnZEYmxYeDhlUUp4cHdNMW1hd21UaS9VbW9kRE5vRW03TDVaRjgxV2lw?=
 =?utf-8?B?REpNeVE1c24rQlN4OFNyQ0t6RGR6U1ZDbGZiaFNpQ2pYUEk5UEh4V3VmaTJR?=
 =?utf-8?B?Ynh1ZStTUnE1MEp2NGRtWFBQUDZ2SzQ0RnI1WGFCUHVQcm81THZCeU04R1Ru?=
 =?utf-8?B?SlNKQVhkVHFYQ3NyU0FRUTRVQ0NlNUNtc0x1WW9tRkNBRUFFczRhWmhhcjF2?=
 =?utf-8?B?ai8yVGNvakUxcFdUblBkcmN0WmJvRG1neXg3QzJBT2laSFV5SWFkY2Q0TTkr?=
 =?utf-8?B?eU1mSkZ4YU5sVDd4dWtaM0hBY0JCY2hITlFXNEw1NkJlZXZyQnQ4NnBrTFla?=
 =?utf-8?B?alRIaGhxZnJsa3ZwcHEwYmFLc05QR2dsMzVrbDd6U2xiNWNKYXlWZmsxWGRr?=
 =?utf-8?B?TWpXR1Qwb2NmdVc0dnlBNjlpY21nUFdvb1hvcTRKUkppTWpLR2RkRmZlTmE5?=
 =?utf-8?B?dHFyRjBDeWhrSzJ4MHQyZUlZRFk4STlHOGVDN1EvM2pETVgvdmlseHJkeUJ5?=
 =?utf-8?B?Yk5BZGhZUGNWVUJTTS9aK3ZJbnkwOWdTNlhPYjVVMHdxcUJaaUVCWGVaczU3?=
 =?utf-8?B?ZWRWbWdXNXB2bjh3bXRZcHlJTGVvak9SQ01JVGM1VWlzM1RnaHJtMDlrRjRp?=
 =?utf-8?B?ejVkRjVuU0JUNFpCQm5sR3hoMVZuZFNKL0xSQ01pdGpHZ0lXaVErNWk2QkpM?=
 =?utf-8?B?dkZhZHdpTWVmc0FJeWd3R1diTkpqVXV0UVFQRWd1UXM0S2t0SXV1ZHZ5djBF?=
 =?utf-8?B?dFQvTmorakYzdXZIc0ZOSXErVE5DYVRzeXlXdGhFaDNlcCtDeGpZSGk2Q2Zm?=
 =?utf-8?B?SDZzUTVIdjlkUlVDWUlOdmFzc0RLb3lnSklYbWJpMkEwcE1qUjF3bDFPakFY?=
 =?utf-8?B?QWZNYkFlS3oxTW1QZjd2SDNyVFovUDl1aVRKL2NtMVZnS0VKZEhOTVFEWDBB?=
 =?utf-8?B?dS9TTndGRngxa3RIYVE4U3oxeWhiNXdqb0lSR3ZrTmtuQ1NQU01xYXNzb0tI?=
 =?utf-8?B?TEZrWE83UWxPeVFwUTRtQ3MxMWpmYXRRWWQ3b1IwaDNobWlRdFM2dFc5bGtG?=
 =?utf-8?B?ZmI1eEtGQzJnNDhOOVhRV2VsRDhvWUlpZ0g0WVhmZ2RBMktldWRKMmsxMVFp?=
 =?utf-8?B?MVpEODBQN3pXVXJyaEszci9LekhmUGJNR01GaXJBVGhBa1UxRFAyamxtdkVn?=
 =?utf-8?B?QlN5aUg3amI3eFRONW5TZ2J5RUM2bStLaWdmR0krSXJaSmVHdWx1YTZORGhp?=
 =?utf-8?B?NDJ1aWFjV3pNSndzTUNJai9Gc2xySnRNQXN5cGJtSnN5MmVCREQxdjhvRlZW?=
 =?utf-8?B?Tzg1RFlDbXBzOXNyWW0zUFFvLy80NjJsbmFFaVBGTW5ESnN4ZGwrU3J1aGNo?=
 =?utf-8?B?ZFgvMVI4MG5VZXFGRlViKzhjeEFtNDVWT1d4R0tQN3JiR0ppSmc5VDc3NXdF?=
 =?utf-8?B?RFVLRGFNWTVoWmdhSHp2RFREMTBqR3pYTUdaRHJ5eFlrTnZoQVFUakRaL0JT?=
 =?utf-8?B?RzVGclE4VFRwMEl0OGFqRmhjR0JjbzdFcTZKSjdIRkZ2TW9RTTJyVkN2bVdJ?=
 =?utf-8?B?WDRwZHV5UXEweXRrbWE0SXB4RUkwOXg1a3JIVjFLekczNkJ3ZW9qRnVyL2Rj?=
 =?utf-8?Q?vAu9eERG+0/ise+ipsyBhQSuid4VFhIGNIYlo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0xVSmxLem1JV1RYM0ZSMzNURFhOeERMQUx3U2VsRHJQTVV6aDc1SE9wMEFT?=
 =?utf-8?B?bml6RHlmclBIb0xPSklYWnhLMlRIWVNoREJSd3RCYms3WUh5b3dReW5pTklt?=
 =?utf-8?B?V0JoM3lMa1A0N0J3RnZqbHJOSXV6Q0lGZ0NZZEJhN1JJcER4MFlkSng5Nnd6?=
 =?utf-8?B?T21LOURLNWlPaC9RUWdzbVd6WUF0OE1SQzlSVXE0dlE2Q0ZRSm92RC9icFcz?=
 =?utf-8?B?VUFvU3lyVklOZTBXRHJoOWRSa2lKQ0oxQmZFKytvOHpXTEJPQ3Y1Ti96dUNn?=
 =?utf-8?B?ZXVwR0FJWkVIZ3Y5SGluU2Z1cHZtQURXNGoycXFrRXlWbzBPc1B0WVJiY1lW?=
 =?utf-8?B?UnI2MXZtWklNRmNXaTNRdGZDeFJ0L1F4bW1HL3lmeG40UU5sVTI1T2tHM3ZM?=
 =?utf-8?B?cnlLMXRqZDVNWS9aL2NFUmUrVWx3Zzl5YkdvNGJBWG1tUEFWWjhEM3B6SElN?=
 =?utf-8?B?bTlDd1RLbFAvYmsxTitIbDJRUldlamhTS3F6SElBL2FPT0xTSCtWYkRFU1Rq?=
 =?utf-8?B?eVhaTWFRNGZibVZOSEpvNnp6cTJsdzJpelpIK2k1WWhmR3l2K2xxWjVxWmNC?=
 =?utf-8?B?bnVEY20rTGovR3N6NXd0NkJDYktOdHBuME1pRnlmaStpdlozZlY5SmhyVHNP?=
 =?utf-8?B?dDRuUmlpcTJCcTNsTDU4ek1Cb21vQytYenUwaCs0TzkyQnQwdU1pRDNLakxz?=
 =?utf-8?B?Tm41ZzdmRWNOQzFQQ1NRRUVEam9GZTdpbEdreHVQRndXZDh6KzF2NGtqeGt3?=
 =?utf-8?B?TlhUTHRrRHIwbU9wWCthU0RxMytQd2hOYmhzamFJcGx3UXU0TlFTd2MzT1JM?=
 =?utf-8?B?YUxyVk5jUmxCNjdEYldNTmZOVDFiSE01TS8rbmZ3aHIwVHFCZlZSbUJ3RmZi?=
 =?utf-8?B?WGlNWmd2Lzg1TzRJVUJMQmxkTXkrb05DS2prLzU0OGdIa1B4VFpLS1F3cS9m?=
 =?utf-8?B?M1BHZHZpcUI1eGVOUEg1V1NyeFBzTmVKTk83cVhmR3JTc3QzUC9qMGdQdjBi?=
 =?utf-8?B?MnRzMlJsdDQ1ejF0Mm9UZVhNdFJleGRNak1YZUZlNzdDSFFwK3I0aHFLbmlB?=
 =?utf-8?B?NGdlYXJicmVGbFo4aTI4bmZ3NlMwM3N6Z1ZUZUFXSFU1NEc2YitNUXB4V01C?=
 =?utf-8?B?eEVpdnl1VmpRWW1lU1dwV1lyRTNXRjRYZThnbFozSXQwclJMMTJnWEFPK01q?=
 =?utf-8?B?ZEMyQWNFc0x6MWhsLzlwbmVLejFNaDEraTdUOWZZN0lCb1ArUVROR0FBQ2k5?=
 =?utf-8?B?T1F6Wmx2SXVuQlFDZW9NVWhCdzd3THZkQ01uZG83ZjU3SHgvdURDVTZZOWlR?=
 =?utf-8?B?Z1R5amVvVXJsRkI1ZnBibHExTk1iZUlmOHJXT0ZqWEw4RU9waEt5bXlTZnM5?=
 =?utf-8?B?UUpwYkVSNWc1Rm51NnlCVWpvbk5DT29wTkk2NWZSeEl6TDZLUG8wRmRSdndU?=
 =?utf-8?B?MDRBZVhkbFZ1SzI1SHF1ZDg5bFltOVRrK0hDUlNKcnpwR2hDWUt0NVEwL01v?=
 =?utf-8?B?U25VbEt3UXVaUmVJYkg3T3V4c2hVeEZLVks3YmdxMUwxR0NuSFlIaEt4RVMw?=
 =?utf-8?B?ZWFSdjNrZGh3T0xhMFlhTmJyNXRNNzVPSGY1SVFzRTZneTNJZERIQlNER0dF?=
 =?utf-8?B?Q09wa2hVT1c5S1RlMDh2eTJjc1djenRmY1dGaUZSWXRYeFdkTFhhSUNndWM5?=
 =?utf-8?B?TWo3WDNwMHNoTm9aelVaWmhRckFrOUNqajdYLzFtcndkVDA1c1NaWmVobmt0?=
 =?utf-8?B?bVNOeFNHSGNaSHF6cG9wdjRLcVNmM2ZudWNZVG5ucVJiL0RGb3hDc2QvMTRU?=
 =?utf-8?B?THhDREFsYnZrTTVuTWVlQ3IrbG02NWw2aERPQkZIN2g0NGRDUDNPQW10YWpH?=
 =?utf-8?B?QU9zQ280N2puSStXWGlPaldsV1hQMzdjaXQ3Y2FoWlMxOWdiYzRVN21HSUEr?=
 =?utf-8?B?KzhtSWcyTEVIS1FCREZ2YkEyT01OMWtHT2lUS3loTXltS0hxNEhrcGRiZ2Nq?=
 =?utf-8?B?TjJadGwvM3U2akRVN04zK2p2STJ2bE5TNTZUWUhudjZBRmRRSEZVZmozdUtK?=
 =?utf-8?B?WU5CNVhFeWNGb2IveFc1UFZiQVlHc1ZjRlFFNVRTd2p0SkFyMS9QZjFVczJG?=
 =?utf-8?B?YXFoT3YyUldSSWJIMU5OSyt4UmhEU0wybkZBL2hKZ1JmUjZIMldNSWtzYTg5?=
 =?utf-8?Q?N91L+bKBX1mh13RJVEW/cfg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccafd4f-f703-428d-4612-08ddb9846b54
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:20:54.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vjxacvhDN+Pj5v8BRSkc6SOzOKx5trSGHjgPvVt72vVrZdQMWo/LY9KCtLmADvcNNiuaEKAoHyPWaEvBoKDUi9hh7ihJDWol4zU55QkwFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10511

On 2025-07-02 10:56, Kees Cook wrote:
> On Tue, Jul 01, 2025 at 07:26:19PM -0400, Steven Rostedt wrote:
>> On Tue, 1 Jul 2025 15:49:23 -0700 Kees Cook <kees@kernel.org> wrote:
>>> Okay, I've read the cover letter and this wiki page, but I am dense: why
>>> does the _kernel_ want to do this? Shouldn't it only be userspace that
>>> cares about userspace unwinding? I don't use perf, ftrace, and ebpf
>>> enough to make this obvious to me, I guess. ;)
>> [...]
>> Anyway, yeah, it's something that has a ton of interest, as it's the way
>> for tools like perf to give nice graphs of where user space bottlenecks
>> exist.
> 
> Right! Yeah, I know it's very wanted -- I wasn't saying "don't this in
> the kernel", but quite literally, "*I* am missing something about why
> this is so important." :) And thank you, now I see: the sampling-based
> profiling of userspace must happen via the kernel.
> 

I should add that once we have this in place for perf sampling,
it enables the following additional use-cases:

- Sample stack traces from specific tracepoints, e.g. system call
   entry. This allows associating the kernel tracepoints with their
   userspace call chain (causality) without requiring tracing of
   userspace.

- Implement a system call that allows a userspace thread to use the
   kernel stack sampling facilities on itself rather than reimplement
   the stack walk and sframe registry handling + decoding on the
   userspace side.

For this last point, it's only relevant because the infrastructure
will already be in place for stack sampling from the kernel. So we'd
eliminate duplication by allowing its use from userspace as well.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

