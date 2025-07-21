Return-Path: <bpf+bounces-63924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0808CB0C766
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319EE16EE32
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16AD2DEA96;
	Mon, 21 Jul 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="p0XpP1Rn"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2091.outbound.protection.outlook.com [40.107.116.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592E2D836F;
	Mon, 21 Jul 2025 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111243; cv=fail; b=XtZYqoWPqRBqSPloBZXtZfbGCebSAzR4ZMpHax1AmG3ZtM0LCKyJatR6UgNlaFsKgPJtFv6YYA11iUIBUBu/DiaRcbSPMlVxKv2OQDL/nNIWH7czd4+z6Fgjh5cikWmVh6702rGxGA7n4GTNhNck0hYCkBzAZm8+FHambCjoHD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111243; c=relaxed/simple;
	bh=l5LcnPYRxCGEGxOSCPAKzRStROFFd+qxi4aoa2RXkzk=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=rsDnEzOuiVPtG5FOKdUuzmkZezu2BDtWjKpOC7LWVR2KxsVI5vhzF2gwQgwvY/19CQhOJDtjgaYIwipcMDxjmbTEOOfizuuRBzkxR3n2tMpsZL1GUjxOCa3q/vLgFKud16Plcf8K5PMZzuXvUAn+GZ5ohEUImqNCCRJTnoyxkV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=p0XpP1Rn; arc=fail smtp.client-ip=40.107.116.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLgGwmpJlgz359vJCHYuIF3L6Lj8YZoeUEWFGu1+VlM/F2w+kS5B1vbjkHOWY+4iBbsfFdSjAWOsrHYJX1wh8GsQmRMZaLjaVt3g6hoPwad3VTE8fLs74oVbzmJz7MjAkCSE/enfZ00RnMbSkdZ5ep5S2fDTDtCe0u4T2OfaxDJFq5UV73Vuj1hOLVH9C1JehFFlnHwOIL7GUQirSvPJF+tcMRPd/nHJ9/LBPow3nyy3yha6VfY9zBiVpgbSw7Sfn9b0YDYDoNwZ/mS1VObsQmPRo3STnlITrW5ftkJZloKf6udlsZ0J9fVFG3QouBQdd4Gt1bKfshvsea7S8SrduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5J2SirTEqaTQ2FEGJVaJZAZizLvcGoy77hdeD/vhKkw=;
 b=ETPEjFUb1SOHPbCXapPyKw22UTl33xoRe2KtVIvmEfuzfW4YFxbGz/o+5tV6kicqaYj54pCp5Lzz/Pwa/EDxOIfNUbnFC+nhtqNeTvlANh93CLl3V7e23/yVSrG9yOG8LjYjN09Pep1OVMHa4ZBQDnvB32t9we3uRVNjmy6tggoVnvW1gIF0B0CS1xRI0KnqbQET6Etk7MaGKfw/+Nfl+4JJxSaK7rl1OSPY52VXUEpeXV+HE1Fa5IWqKdqdGdkxmmjhL0bg3KjsHQRkCXaYTqvbxRsKuUOULSuYK1h/Cg/B3z8sT6nrwyozFJxI6iVkoDS6fbeXCeuSLtVD8DajCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J2SirTEqaTQ2FEGJVaJZAZizLvcGoy77hdeD/vhKkw=;
 b=p0XpP1RnE7B8NpV9A8TuZGRvhCTC8ji9Y8PaS5iGzyI0qTSjMWa4U7sJ1NMuLQf6B2Hul28ZyWM20dnSZ+LVWUT20zVdhkuZRiomqkxO65hSnJSQKcjPya75UHVA6v04U2osKkIDUj3jYSRXkwfxElNmZmqhvqOf2Vnva7CIpKK8mVYRvdDTC/cAJvKjs1JT7CW0FyJB5S5X2NMNnJkI0wXeh+ImaiQcUCs5eIyxW22wNixZ5axUO9bRD9nxr+bG7xswC9/1QSi2LDZ+ovedrpKvol0jI/EZJz9Rgqq1nCx/Vp7CqjX+INkaQ4mgIedVD86C8PY0IZhH+SnXGXEodg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPF22D81F315.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::21e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Mon, 21 Jul
 2025 15:20:36 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 15:20:36 +0000
Message-ID: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
Date: Mon, 21 Jul 2025 11:20:34 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Brian Robbins <brianrob@microsoft.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
Subject: [RFC] New codectl(2) system call for sframe registration
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::44) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPF22D81F315:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f63cd49-65d3-4685-c4d5-08ddc86a244e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU5nZzhid1lrdGZTZURMcThXTSs3UkdtSzhuTFBzd1RWZTRxODZBTDlZcGN4?=
 =?utf-8?B?aWROMG1yRC9BSlFXSDk3eGhrRGNYS2hiNXJsVFFVU0FJUnJRUXBocEtDNFln?=
 =?utf-8?B?YU9LVkhMRDJHbzNJYmpPd0dySWpTdVlDcHdBRTRmSHNsdG44ZWZMZS9uTmVV?=
 =?utf-8?B?TUpxNk00WDFBaG9pZklYWm1YbjliRGdpRUxRTnd0SmhXUUUxbWZkRnZiQ01F?=
 =?utf-8?B?S2lHd0lYaTQ2emdhZ2VvbU1sVE5RSmNjaG1pOThZS081L0MvMGFQL2N3b1lR?=
 =?utf-8?B?OE1GeDczU0w3eWplMEZtTHF5MXV0MGNqbC9rNUtNQ3JyZ1Nac1V1WE1meGxt?=
 =?utf-8?B?RlVMK2dHSVIyalEyMVp3K3JUczJsRFpBRDFUSlFlQVZtK2k4YjhxR0w1MjZj?=
 =?utf-8?B?aWEwendXMnBoVytyMWdwbFhnYmJKRXV2MkRleGdDTGZaN1RpOVk0WVcrOG1T?=
 =?utf-8?B?d1Q2akdhTWk0U0kvcFdqdko4bFBYOE00ZW9MT3lSZDNMTm5qWEZOSEZVSXYz?=
 =?utf-8?B?YnZxR1BkWDZlaUF6ZXFKcVBBdjV5RUtRMk16L2MzSkZ1ajc3cXJ4QjlndVpV?=
 =?utf-8?B?bGFyK3ZGZ0NLVDlhbEJDeGE4bmVCSzlFdUpVVjQ5YlFYRzMxb2QxelQ0ckho?=
 =?utf-8?B?SDhnUDBBQlkraUNSbVB5b2Q4VEk0SFBmTFNXM01UcGx1bk5LRWtzYmwyaUp4?=
 =?utf-8?B?MTVIKzEzM29zM1Jwa3I1SkI5YkJPNnh3b3FsT25iSVlaVGJlWmM1RDFvbzI4?=
 =?utf-8?B?SlB0RUN4aG1SeHJjbXRKdlozZms4TkdCNUlxelk0WndlVUt6NjZYUUdlMVN2?=
 =?utf-8?B?WmMzNGY0ZjE0TUE2NTg2bFl6TTY1eGJ4U3RXTFRScVprOElFNGhrYkpwbnVv?=
 =?utf-8?B?ekFZbE0rWmIySU5FTlh5Z2lpbmdVUmwwOHRVdjV5QmhseVdBOWRsUFN2MEc1?=
 =?utf-8?B?QnFTdHpmSXZTM3EyRFNRdkduK05kMEU4RkF0d3pTUU1IK3JBTVlrZ2lHcWxo?=
 =?utf-8?B?U0RNNEFtMCtLREc5UFBURzRieVdNWDV2OXRmTnVWbU1BL2x5S1pxUVdZblJk?=
 =?utf-8?B?SlMxK1Vqd0VCUWEybWY1MmllUU9rUHcrMFZZRjBrUmYxRWNsYWU0OXJWMmEz?=
 =?utf-8?B?WnJ3d1pQd3pjSE5MVjRmU2kvMEJoZTJDTUdKa0JuaXprNnJHTHVPeU1sZjFN?=
 =?utf-8?B?bDBmTzYxMldrTWh0UTdLZjF1MzBRMEtuVy9TR0Z0aVlNQlhJeVpQTUZOVEZT?=
 =?utf-8?B?NXM4TWg4N3pYUmtBQUNZbHRtdUtKWUtaUVJyVWRnLy8wekIwUjh4NElqTXhH?=
 =?utf-8?B?TVFVZHhvYzBkWGtVM2NQR3BBZ0hseDhWSlNlRHducmtwOS9HUTBGZlhkc1pM?=
 =?utf-8?B?OEMvZjVyaFN4VUl5alU2ZWVGWVdqSDVWMkx6K2FNTXNNT1VRMGJZY0lqa1Qy?=
 =?utf-8?B?cDlSU2NVMnU5dFhjVWs3RFlxZEpOeVl6VFZuMVZMNVlTbWI4czEwaFF3c0ZN?=
 =?utf-8?B?NDBnZXZ1Q0JmQXVmSjVTR2VvczMyRXppWHdiTTE1cndvM2JROEI1QkNaM1Jr?=
 =?utf-8?B?T2VBdHVjVlprY3VNQTd6dHJVbHVZMGsrVE12T1JFSFBrcUJTSUFZMGE5Y0xF?=
 =?utf-8?B?SFUxYlJmWmNiMFcybDNiZ2pGOGJueDU0V2ZEZ2s1bXEyT2ZpZ3F1ZkRRME5u?=
 =?utf-8?B?Q0JYVEs4bWhPa2taS0hXc2kxWHE4dU9NQitZRmcrZk8xTkRFS01GSm9Ya1lp?=
 =?utf-8?B?V3RsUUtTVmVCVGVsc0FPdlNwVjBkYWpWRUNOcmxpT2F5Ylc0ZnNKWFdWUWNN?=
 =?utf-8?Q?7qGHxySbyRzxc7kGAqhIHUv2hEvbctk5qJTW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2VHMWEyOU8zWXBMSUdrY1RndFRuZDFUM3A4Z3dMQkh1YzJkKzdWcHZDN1BU?=
 =?utf-8?B?VHJySHRLWjhBeHhDM0tGbFRVbVJRZWpBODk3TG1MSXhOWWd0QXJ2MUpFUkM5?=
 =?utf-8?B?R3h2cmhpU0VsOVZtdHU5aTUxS0VNanFCa1lXaEROVm1VR1U5Y2M0UTY1NUM0?=
 =?utf-8?B?S1pjMkplc1RJcFFjQldSajFMOVNycGFIRGtJbnVYSTF6M09MOUhkdUp0YnY5?=
 =?utf-8?B?QUFLdjJrdWxXcDBtVnI1TmhTcnBKR3c0M0NGRytaei9QOUdjUVdSNkEwUm1B?=
 =?utf-8?B?OHcrZUlrbDJSK1p3Y3dHaHZTT3ZldGNFVXI4anFJbDNNV2NwNGYrOUtUdzJS?=
 =?utf-8?B?bU4wOFBkL0RiRzRIaXh2OENTbmdNVHU4UVk1NitlZ0hUL09ZQklHb1JaL2xq?=
 =?utf-8?B?STRYdUtYelhjNkpoaTlEUWl5MFhGYmlncnpDRjBPYkt4NlcyTkhoVmdXWEZU?=
 =?utf-8?B?dW91TkEvUHd1MXE5dE4ya2FkUkljODd4VHBCaHVzc1JndkNLMWNDcnNaTHhJ?=
 =?utf-8?B?Y0RJbFBpWmwvdEZEanNDT0lqR0krekgxUC9BVUo0UUExS1YxMFJkbFdMSWlz?=
 =?utf-8?B?THhGem4zaHpzbFBhSkd2QVdmcGEzckZ6M095YWNCRGRPUmZnUmRWZkxKQWxm?=
 =?utf-8?B?aytDUHIzb1lDUnUvTHVGNTdBdVA2czFQQnczL1V3aUhRY2l5L2NTcWQ0SDhs?=
 =?utf-8?B?Q0M2cW1HNFAxNExsQ0pXMUFPUDFxQXVmNWFudjdydlRzM0lYVU5TUVJXSkp5?=
 =?utf-8?B?bDI0QlgyaVlxZlp2Y2NUWU9mcVA5aEEvcC9la3dMTGJHRFJBR3h3aW8wVHdw?=
 =?utf-8?B?Q29qRURDZkpZYlYyMElDZ1BRdjNWQjlCNCtWUk9PWUR6TjVSc3dnbHU1RlUx?=
 =?utf-8?B?Nk85M0g3Z1JHRkh3RllGYUVoSDU1M1Z3MkRIKzZxdzZIKy9SUVFGc3o4Sm9o?=
 =?utf-8?B?M3d0M3JFazZkRVhmcHBEV2g3YkVXb2l4ZFk1WE4yK1pKenBGWWFnR0p0MFdL?=
 =?utf-8?B?NmluYUNEQ1hTQXpVNDh6OUVpNEozdEhDdEg3SGptUk9ndUpaTTRsUWNMT21D?=
 =?utf-8?B?ZDBjNzNwMkplUjRON3JJbCtYekRNV2IyL2hTNGFZUThNYkx2ZW1mT09pTWMy?=
 =?utf-8?B?RFBzQSs0NzJES2NpelNENnFyU2pPcHFqODBleFBoMzNieE9vMElETUNEaGtT?=
 =?utf-8?B?WndBMFhLTVo1bytKVHE0K0hyVUFIMGdqSzNkS1QvaG1PbzM3NldzaW5ZNzRi?=
 =?utf-8?B?ZkhSVUVXTTk1TVVDOFI3eUlJcVdvNzc3V1NhbXYwcFpFSFJWQ1lubVpsQ0hl?=
 =?utf-8?B?VDhsK09IUGk0TzZWVmxuZWJ6UWVpaUlraEEyd25mWUMyVTFtK3M4MzhsNFBI?=
 =?utf-8?B?V0RvOWtHakN6RWJzdTJ6UHhkbnlmMXBoQm1JQXk0YURPK3JKbVNOVjZGMlJl?=
 =?utf-8?B?L0VkY29xdVdBTnlhbkg3elVZdm1VWHRXUlF3d0E3b3dYNnZOY0ZJVVpBZDEw?=
 =?utf-8?B?VCtxdGFIWERUeDZXalkyQnMzVStXNUI1ZVYyV3N1TG9WazZ3emdSRVBvNyto?=
 =?utf-8?B?MXdLa3hpOEtNN2FhYXdhWFpiUkFqK0U5SEtDRkNvcm9OclIzUnh3RFoyTURO?=
 =?utf-8?B?c2ZHbHRhNFoweHFyWGhSMlF2VDhWc0NWS3Rydkt1N2VYWklRQ0dueFc0MWVY?=
 =?utf-8?B?VnJoZnpIUmRFcTF4OE1qc3pFSS9FYm9pWEpkOUhyLzJvZmJ0YzAxaW5HY2tQ?=
 =?utf-8?B?ZWxwaXl0US9VTEkxNW1QM0c1Qi91RHE2bldMRjRkK1JpTDdGaUtpWG81ZVJP?=
 =?utf-8?B?M3BXQVNJMHlrUzVjSUs2bjZEZnFFZEdSd2pXRXM1NEgxS2JZeFZJNmdWT000?=
 =?utf-8?B?SHdoMkMvU1QzOHFlWkhEOE1CN2ZnejA4OXNkeWtMQmE1OVV5dW5SbENUS0tp?=
 =?utf-8?B?UU1VbmpBYWpLWHhqejVweEdmanRUVkVuck0zNXpsMW9Zb3hSTC9nMkgraVYz?=
 =?utf-8?B?OUZLNVh4NVJOSzcrWkZ4ZWVoNTBUTzVNV05tZVc4YW0xTDZ2K052Ri9Kc211?=
 =?utf-8?B?MC9xbGtTQ3RyN3JWdzcxV0I4OWlVT1VnZGx1Rkd4cE90N1RJTTB4VEdtSzUz?=
 =?utf-8?B?QUdmbW1Fd2xESHF0T3FBcWpuNWZqaHlmT3RNV3ErY0pha0VnZ1VLNVB5V1I5?=
 =?utf-8?Q?ijKxcwpU7uOt0KaLyPEkeds=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f63cd49-65d3-4685-c4d5-08ddc86a244e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 15:20:35.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Te7aqfCYFDmqznFo1px/PGNT1KPjJBxbqLSTWCHkAU5GlXFJJdCjzajMQwG39m4Er1/GX3xWKIvfFB76CYxf7avQRrzSaJmPPu7H0LeQtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF22D81F315

Hi!

I've written up an RFC for a new system call to handle sframe registration
for shared libraries. There has been interest to cover both sframe in
the short term, but also JIT use-cases in the long term, so I'm
covering both here in this RFC to provide the full context. Implementation
wise we could start by only covering the sframe use-case.

I've called it "codectl(2)" for now, but I'm of course open to feedback.

For ELF, I'm including the optional pathname, build id, and debug link
information which are really useful to translate from instruction pointers
to executable/library name, symbol, offset, source file, line number.
This is what we are using in LTTng-UST and Babeltrace debug-info filter
plugin [1], and I think this would be relevant for kernel tracers as well
so they can make the resulting stack traces meaningful to users.

sys_codectl(2)
=================

* arg0: unsigned int @option:

/* Additional labels can be added to enum code_opt, for extensibility. */

enum code_opt {
     CODE_REGISTER_ELF,
     CODE_REGISTER_JIT,
     CODE_UNREGISTER,
};

* arg1: void * @info

/* if (@option == CODE_REGISTER_ELF) */

/*
  * text_start, text_end, sframe_start, sframe_end allow unwinding of the
  * call stack.
  *
  * elf_start, elf_end, pathname, and either build_id or debug_link allows
  * mapping instruction pointers to file, symbol, offset, and source file
  * location.
  */
struct code_elf_info {
:   __u64 elf_start;
     __u64 elf_end;
     __u64 text_start;
     __u64 text_end;
     __u64 sframe_start;
     __u64 sframe_end;
     __u64 pathname;              /* char *, NULL if unavailable. */

     __u64 build_id;              /* char *, NULL if unavailable. */
     __u64 debug_link_pathname;   /* char *, NULL if unavailable. */
     __u32 build_id_len;
     __u32 debug_link_crc;
};


/* if (@option == CODE_REGISTER_JIT) */

/*
  * Registration of sorted JIT unwind table: The reserved memory area is
  * of size reserved_len. Userspace increases used_len as new code is
  * populated between text_start and text_end. This area is populated in
  * increasing address order, and its ABI requires to have no overlapping
  * fre. This fits the common use-case where JITs populate code into
  * a given memory area by increasing address order. The sorted unwind
  * tables can be chained with a singly-linked list as they become full.
  * Consecutive chained tables are also in sorted text address order.
  *
  * Note: if there is an eventual use-case for unsorted jit unwind table,
  * this would be introduced as a new "code option".
  */

struct code_jit_info {
     __u64 text_start;      /* text_start >= addr */
     __u64 text_end;        /* addr < text_end */
     __u64 unwind_head;     /* struct code_jit_unwind_table * */
};

struct code_jit_unwind_fre {
     /*
      * Contains info similar to sframe, allowing unwind for a given
      * code address range.
      */
     __u32 size;
     __u32 ip_off;  /* offset from text_start */
     __s32 cfa_off;
     __s32 ra_off;
     __s32 fp_off;
     __u8 info;
};

struct code_jit_unwind_table {
     __u64 reserved_len;
     __u64 used_len; /*
                      * Incremented by userspace (store-release), read by
                      * the kernel (load-acquire).
                      */
     __u64 next;     /* Chain with next struct code_jit_unwind_table. */
     struct code_jit_unwind_fre fre[];
};

/* if (@option == CODE_UNREGISTER) */

void *info

* arg2: size_t info_size

/*
  * Size of @info structure, allowing extensibility. See
  * copy_struct_from_user().
  */

* arg3: unsigned int flags (0)

/* Flags for extensibility. */

Your feedback is welcome,

Thanks,

Mathieu

[1] https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng-utils.debug-info.7/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


