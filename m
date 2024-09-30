Return-Path: <bpf+bounces-40546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353C0989CC4
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 10:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89701F223C5
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E63C17B500;
	Mon, 30 Sep 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="VTAWOuZ2"
X-Original-To: bpf@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20678176AC5;
	Mon, 30 Sep 2024 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684979; cv=fail; b=ts9fadY3BkQFkACS22uLvb/20rFhkgXoxwDpdCyjIbH4jMtb/1dQGbv+Jcc59nfDexAAGvCyTs8VmooQt3k7T02wqAanI00l/V/siOTwl1jwBeQiUNpBeaJGa7TschuylH/591EAvpvRleVTbdgSI6p6HIhK1OwDJomQKwGt/0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684979; c=relaxed/simple;
	bh=cQfQOf9ZFSpLlphFq+ZD0Ta52dLRZ3SYINerGALio14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KihpgPZ0EsM4A7RjtxuB9/YplhFFub04UEyEizIbR+T4vBiv1KDjtCs5ms3+rA/ePOcfsBbsIt3ze3xdEaPfzlz96IYPwI/1zZV62Xn5DVYsIbC9fSAWhK1HFgEK4BpLlEpPGzNjVAJRssgR/s14DIYbKovygyNqKrYxlQlzWHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=VTAWOuZ2; arc=fail smtp.client-ip=40.107.255.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm4F8mOBFNqQMoqHhiM/aejTJoT9i+E2PpYLqCrVeEm2clqv4LDoq+NQoM2kkUf0dBWPCnXcGhDaooQW0E5zbt+0UTSqjfXoMILElhkHzDdabRfvi+9sdMCZwaUscJX3G/BFvFXK0aTLEoaFXhg8y8yquZXKCR/64UoJg7EqyCkzWmi0eO/CYnjI0HlxrkdmKDYMoTX3KXgDMIyZda0nNkgd+HyvbrEugiK3DREE/x259ramd6PpdjN+yd5baSGihsA/woicOgUcRfceR+ZAqwB2Gh/pEeGRrxN3gzwZytYfLSnnGCQY9u1VBc3BagLPRhUHUpWNfkZkhsU8EmAT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQfQOf9ZFSpLlphFq+ZD0Ta52dLRZ3SYINerGALio14=;
 b=IW/maPGhhP1Vd1JiOf/3ehoK4SHMlP+d5OzDUaCThkA+prJqtHG6NxbDd4xoCTd2aeJgzYxe9ZqZ+fp4sjOqyOLaXSWpqQfgpt6TYwIgQ0r1jxyLJxiGNipQU2eZCF53wK5uPOmfZfygn0A7w6UsMRf3/Ka/hd6h5MrXG85G5WWu07g4EW19AuIrRvBUELX0M0NmGEpAerIJ6NcozLrHWD5j7l+dT3cWuvcuKtD6/vbqTVJIrVWizApWO2dvmeApaVUOw09uLfoJO/o9kWEFo9Vw/M+8arpWPvl6WqjVzvGqnK/RFC+Eb/dpxQpqI4K/pLRXkxd0fBFWbBT2KLhRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQfQOf9ZFSpLlphFq+ZD0Ta52dLRZ3SYINerGALio14=;
 b=VTAWOuZ2qG7eJdm3t9fAH6AasrO9bGPi4oAwkmO7as4I9/I4eFAP20AmueDTRrMxjdtsf5IZHFQroP7EdZKqyYJpJ5W4OQkykbumgcqHu2Yvr7ZSQy1qjWUAhRnXnkKDNLcxlYwdiIsgMw3iQQDAIz5rXP05C9SAwgVn2/C7B+A=
Received: from TY0PR02MB5408.apcprd02.prod.outlook.com (2603:1096:400:14c::11)
 by TYZPR02MB7410.apcprd02.prod.outlook.com (2603:1096:405:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 30 Sep
 2024 08:29:34 +0000
Received: from TY0PR02MB5408.apcprd02.prod.outlook.com
 ([fe80::39c:3571:ceeb:2b8f]) by TY0PR02MB5408.apcprd02.prod.outlook.com
 ([fe80::39c:3571:ceeb:2b8f%4]) with mapi id 15.20.7982.033; Mon, 30 Sep 2024
 08:29:33 +0000
From: =?utf-8?B?54eV6Z2S5rSyKEVyaWMgWWFuKQ==?= <eric.yan@oppo.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: kbuild test robot <lkp@intel.com>, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, John Fastabend
	<john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh
	<kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIEFkZCBCUEYgS2VybmVsIEZ1bmN0aW9uIGJw?=
 =?utf-8?B?Zl9wdHJhY2VfdnByaW50aw==?=
Thread-Topic: [PATCH v2] Add BPF Kernel Function bpf_ptrace_vprintk
Thread-Index: AQHbD+WiXSgC0hqAQkyYnRsLtAKxurJvBRUAgADi0bA=
Date: Mon, 30 Sep 2024 08:29:33 +0000
Message-ID:
 <TY0PR02MB5408EE044112DE9640CB06FFF0762@TY0PR02MB5408.apcprd02.prod.outlook.com>
References: <202409261116.risxWG3M-lkp@intel.com>
 <20240926072755.2007-1-eric.yan@oppo.com>
 <CAADnVQJ5xCsBg057gKOQOYA1+9pD-X86bjYJVrTbpRNstvW=DQ@mail.gmail.com>
In-Reply-To:
 <CAADnVQJ5xCsBg057gKOQOYA1+9pD-X86bjYJVrTbpRNstvW=DQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR02MB5408:EE_|TYZPR02MB7410:EE_
x-ms-office365-filtering-correlation-id: 40c9796e-f6eb-4848-a48e-08dce12a0332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEZlS3czSEN2Y3dNMEplc0IrQXh5SS9FOVhJV3RwUmVtaU1pMTAvQmdEK3Br?=
 =?utf-8?B?bzNpcm9iVnQzWmtsR3lNVmU3SE94dTFRUmxhNXpYUGpHUnVyaVFaOU9janlx?=
 =?utf-8?B?QmdlZFBKWDdOMWVJZHZVOGRSM2xXeEJYWjZxalorSmJTalh5MzJDVnVmZzVB?=
 =?utf-8?B?WXpBaEpuY1FydzlRSytFcjRDSE5INW5oTzRNanAydCszczl1WCthRy8wYm5Q?=
 =?utf-8?B?NXpmc05tMS9scU1QVEF0U1MwN05hQVNackpwZ2p5cHhhQm1EM2xaM0VZUy9U?=
 =?utf-8?B?YS9VSXF2OUdaWHFYK1JDZy9aVitCTVRwNTdmZ2lCWjVxK2JOYWFaNm05bjN0?=
 =?utf-8?B?Y3hzcTdnQ2N2WUZXaEFCYlo1bXZDaEZQVnB5RE5Vd0ozUzloRXB6L3pOcGtT?=
 =?utf-8?B?RjR3c3p0bEQvSjhzRSt5KzA1WlRxUjVhUkhuS1p1clh0TjVVRXliR0V6ZjlN?=
 =?utf-8?B?RnpYWlhPSC9OREc2elhsT2hqQjNFc0NSbWtiS0x2blR0YnBFVmgrSDVzZFQ3?=
 =?utf-8?B?dkpPVTFrSHoxK0lkSCt4T295Zmh5aDJjUjYxN2FPYmxRZFpmZjk1QW8vNlcy?=
 =?utf-8?B?cGhkNzNDRndlL21FcU5aVEZZQ1hLT3k2VGorSzlSMDFqUFVRVVdIL08rZ0JJ?=
 =?utf-8?B?NXA2ZFRhQWM3bCtDSUVXR21WdE9lbTUvVVJYM0ZQdHA4aGZoUzJ4RkpkczNQ?=
 =?utf-8?B?RHdVRGZNZ1BFRUZOMnV3RDkvN0JsRzVxMEdKc0JFV3lRNlJVZVFPalZqVk90?=
 =?utf-8?B?bWtwRTcxZjgzYzhZZUFGQ1RMM05qa2E3aS9ZVFBoTklHRkNINUs3dzB1TXpM?=
 =?utf-8?B?cXFKNFdyTndxb3hzRmc5NEt5NnVKTjdlUGFyUzcreUlPSzBWZUx4UDZ2ZmI4?=
 =?utf-8?B?a211VnVuNVhsalYrcGVuNndTMUFGZDlQRUlxQ3A5RmhJTjdTbWpLVVNCSFdZ?=
 =?utf-8?B?enpiZmVneTBDdXYvN0cvYTdhVnlDbVFBVHhKMURhVmFaZXFFS3pUQXcvblZw?=
 =?utf-8?B?ZjRrMmZzMXJoRDA1cXR4blF3MGhibHU1NUZncUthczh2UTRlUkdIUWQvSERx?=
 =?utf-8?B?ZVNIRFBWU0Q1TnhadTNWckRUOUFDRWpuMkY0N0hyeHBSNjVkd2YwUnoyNTdY?=
 =?utf-8?B?OTRqTm8zUWhjTXNmUXgxNjlDNWxPVlBsQzdpQk1LRVFDZ0JlL01JZnFhdjBL?=
 =?utf-8?B?LzR3ejlLM3BwWGM4TFMwU0ZwaEtsbDcxTHR3TUJHcENwVVBGd2o5ZDRHQ0hW?=
 =?utf-8?B?VXdvOWFKb3E3b2JwdWoxQWNHQ0NybTlBbFBTQnJnZTBkVGZ4UXNvSHV0VzE1?=
 =?utf-8?B?UXlqakFYcWlSQTdrbml2Qytoa0ZQYkRuc2tIVTYyNjRtWXl2N3ZaUy9aanFH?=
 =?utf-8?B?c254WkNxaEsrSm1vRmxWa012ZDU0OXEreFlCaWI1T2ZyRGZLS291R2dxa2t2?=
 =?utf-8?B?cXU0UWtZalZyMUtBTTlIMkFKbkRMbnBYYjNQdldoOUtRcS90RjFPbHZOM1Ux?=
 =?utf-8?B?WlhaWUZqYmNSOTRQNHBCRElGdnFwUVFRVnRuMVYrdk9Wc3lMR1RFelFPVHJY?=
 =?utf-8?B?TUxoNUJlL2JYODgzNXJpdzBPK0t2NEhGS2tyOUl4WHNMZ2U3UkEvY0l5Tkhq?=
 =?utf-8?B?R3hydU9HZE1TNGt5Mnd6UjU5cTROSWVOVm11WURQRWMvaTdPdHhleElJUXBL?=
 =?utf-8?B?ZVNBd0VjOHNlai8yTWw0OEtyalB4TERMbUpYWkQzK3ZXTEdSaEhURmcwbzVI?=
 =?utf-8?B?NDZ3OCtrUFpmREt2eWRtYjUrMHVmb2FyWGdEQkdpNVZoK3l5UXR6R2JHN0FY?=
 =?utf-8?B?YXRMcWIxMWpibVlSZlZaU0xsSFRUSWlHZHpRM1BKYjZDZWJzUEtVWWkxU0hR?=
 =?utf-8?B?RFl3cmNqc2UwdUJFeUxhRmlWSDdHTXZEL0Qxd0J0cytMc0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5408.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mi9pcWVxM2xKNGUzaFJ4YlFDc0NyT0JLSzVVSkRwQlJreFd4ZzgvMnlWOThM?=
 =?utf-8?B?dUJXeGRiMEptaWdmVDN1SnFaVVg5Qm5zL0Z0RUZjSFNyZFVxRzlieEJtZWY5?=
 =?utf-8?B?SzBmTFFVcTNkaHE4YzY4UGFxNzZaVVFsYWVnUEhwSUdkc1pnTXpWK2VmNVhQ?=
 =?utf-8?B?bWVMd0NGVlpCN245QjBYUzlVNW0vODA2dlY1RndGbUk3VFhKYnVPeVZHcXVC?=
 =?utf-8?B?L2YvSWZFTTV3WE4xVURra3BWbWJlNjNRTys2bUttRkZrQVRaY0JNOXhsaU02?=
 =?utf-8?B?Y3JhZHg4TlE0VHpBcnFMTGkrV2s1M3NpS1REU0hQdUFLRnpUNjZPc0NqUVpm?=
 =?utf-8?B?WGxzZVNYZ1k3UW9KeldweUNsYUZ5T1M4QW5OcmFCRER1T054OHlBNnJJR1Y0?=
 =?utf-8?B?K0tmOG9Tb3dpN3ZaLzZPMVpFVkVlQUVmd3N2UFNrZHpvaHVLZCszd3k2MHl0?=
 =?utf-8?B?elFJM0dwTFlOZytoTnNaUHQwU1ZQdUJRM1Roa0tNSnJqQk12ZFZKQ1V3Q0Ns?=
 =?utf-8?B?dG1QalRNRkFhbE1yc0pLWVAyM01QYi9ZenI4YXJDd0NiMFNwQkhWbmY5em1M?=
 =?utf-8?B?SVhEQlNGNG0vTUhiV2VacFNRZGNZMC9yRzNDdkRFalJHcUczTHdrUVhnRVVX?=
 =?utf-8?B?MmdVVHA2SnBIeGZpdEdEWncrZHJjMGp6OFVnbk5sSWx1clR6STVwZzV0V29C?=
 =?utf-8?B?RU9JUTJTZ2hOUEtXd2hsSjBvckdrTHRobnQyNVV0b3ZLZnNYZHdLODhBRzZp?=
 =?utf-8?B?b0k3VHpSUnp4bjYyRjU3QU5UZytLMDR5em51WTB1Z0NncHBsa1YzcEVCN2di?=
 =?utf-8?B?dzNRcEpyN29tcTgzVkpWMnhzYnNDY0JENkx3cWJTd3ZlanB3VkNZOUlJbHNo?=
 =?utf-8?B?M0NMcEJFbnVnSFVkb0xHcjh0YjRzU0NCeU03c1l5WU5Xa0hRN2FxUHcvYTU1?=
 =?utf-8?B?MDkxaGlENDVwdGlLOEMrcGF3RnNkbE4yWUdQbUlWZytFZ0dkMkMwSEFub2R6?=
 =?utf-8?B?NmhSamxrbmJuQkhzSVFlQlc1aHU4VjZVMGV4QmplSGd5VkFQSnRoOE1IYU1z?=
 =?utf-8?B?c1MzbkVnYmNCWWhlZGNoNlVFaXI0dVhON2JLM0ZDa2lpODcrWUYzZGZ2YkFW?=
 =?utf-8?B?Vk1jZUo4ZUNPOGErKzBpMExLaFhjRGRucWs0VjYyeGhwMU04aG5HeitjbUpK?=
 =?utf-8?B?WG1jNkxMNWNZd054ck5VZ01vMUdJdHdocDBBeHhwZ1hiR1d2TEF2WTBsVW55?=
 =?utf-8?B?NERwSnhvNStVSzlPQWRGSkxoa2IwL3A4cklacFJ4WGFza3VseVZnTE0yb0VS?=
 =?utf-8?B?ci9sU0krMzhIaDF3WEk3M1d0R3pRMWg0MTJBcmZsaE5hM0Znem5PMmwyOEtU?=
 =?utf-8?B?M3lVUXJSdCsxcG1VYTJTNUxQc1FnaGlQNHlPZ1lsQnhkbjVrQjJ0ZUlwUmFX?=
 =?utf-8?B?aWt1STluRjdZZ2RSYzVaRFhmL1BCTitQa1FTMXk4cENMdTE0Mm9ER04rajdu?=
 =?utf-8?B?NGxMcThmYkV4YldxbHBWL3RpbnJsWlV5Yk1Lbko1eGJWZFdVOFJjQVRhcG1B?=
 =?utf-8?B?S1FUR3NqNVJsZWJDS0UwRGQzWDRlOEVGUGFJM2RQV216T2NrMDdCaUQ0aEdD?=
 =?utf-8?B?U3R4YzhsSks0cEdSbjk4ajlvZmhvZDQ2TlRwU0Q3anA2WHNZRVVJeWFRT2tU?=
 =?utf-8?B?VEpOZUduOUwzYUtkYXNmM1l6RlExM1lvWHdBbnJacWVsMHJOMFdRZ1B0QWhB?=
 =?utf-8?B?NFZtQWtzSGVqTWxBRzRhTkV4aERjcUUxVHFHNjZ3eW9yWUhDZGdTdU9NcUVC?=
 =?utf-8?B?cDJPdFZmYm1PTlpXWUdXUXBVQm1BMUJiTmk4NVlzaUQ2MzJuRUIyL1BzQXdM?=
 =?utf-8?B?eUZGWk1icERBMzY5Uk5NY0x1M2hhekR4NUJabVFwdmFDOGN1T2lxak5hN2cr?=
 =?utf-8?B?aUtsaFdMYXQ2Zkd2ZWxna1ltaXpGL08wNU84cG4zMjJpSUFWaHFsL29TYk5L?=
 =?utf-8?B?TGtKaHgvNjBwUDh4bjBmV3pPMll3NU9oR3pTZlNpK2tVU1V3NjNXN3dHYmo3?=
 =?utf-8?B?cHFPYnZYNzB3bXJQbWZWUlRzNmhadm4rWGxkUkFrQXIraWtMZTNJc1N1UW55?=
 =?utf-8?Q?OAj0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5408.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c9796e-f6eb-4848-a48e-08dce12a0332
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 08:29:33.8017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+1oRVC3cNB3fbCOcJpi8IZrePxsJ+x0ioymcXnEE4X6VI/rGXYAHbnaH88i/x+bNYXtZE0Rzy+WNFfZvpSPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7410

VGhpcyBwYXRjaCBpcyBtYWlubHkgY29uc2lkZXJlZCBiYXNlZCBvbiB0aGUgQW5kcm9pZCBQZXJm
ZXR0byAoQSBwb3dlcmZ1bCB0cmFjZSBjb2xsZWN0aW9uIGFuZCBhbmFseXNpcyB0b29sLCBzdXBw
b3J0IGZ0cmFjZSBkYXRhIHNvdXJjZSkuDQpUaGUgb3V0cHV0IG9mIGJwZl90cmFjZV9wcmludGsg
YW5kIGJwZl92dHJhY2VfcHJpbnRrIGluIGZ0cmFjZSBpcyBsaWtlOg0KICBhcHAtMTIzNDUgWzAw
MV0gZC4uLiA2NTQzMjEuMTk3MDAwMTogYnBmX3RyYWNlX3ByaW50azogYmxhYmxhLi4NCg0KRlVO
Q1RJT04gZmllbGQgb2YgdGhpcyBraW5kIG9mIG1lc3NhZ2UgaXMgJ2JwZl90cmFjZV9wcmludGsn
LCBhbmQgdGhlcmUncyBubyBzdGFuZGFyZCBzeW50YXggZm9ybWF0IGZvciBpdC4NCkN1cnJlbnRs
eSwgUGVyZmV0dG8gZG9lc24ndCBjb2xsZWN0ICdicGZfdHJhY2UvYnBmX3RyYWNlX3ByaW50aycg
dHJhY2UgZXZlbnQgYnkgZGVmYXVsdCwgYnV0IGRvZXMgc3VwcG9ydCANCid0cmFjaW5nX21hcmtf
d3JpdGUnIGZ1bmN0aW9uIHN0eWxlIGJ5IGRlZmF1bHQsIHN1Y2ggYXM6DQphcHAtMzE1MSAgICBb
MDAwXSBkLmgxLiAgNjA1OS45MDQyMzk6IHRyYWNpbmdfbWFya193cml0ZTogQnwyNDkxfEJQUkYt
MzE1MXxUcmFjaW5nRnVuYw0KYXBwLTMxNTEgICAgWzAwMF0gZC5oMS4gIDYwNTkuOTA0MjM5OiB0
cmFjaW5nX21hcmtfd3JpdGU6IEV8MjQ5MQ0KDQpUaGVyZWZvcmUsIGl0J3MgY29uc2lkZXJlZCB0
byBhZGQgdGhpcyBrZnVuYyB0byBvdXRwdXQgZm9ybWF0dGVkIEJQRiBtZXNzYWdlcyB0byBmdHJh
Y2UgbGlrZSB0cmFjZV9tYXJrZXIsIA0KYWxsb3dpbmcgcGVyZmV0dG8gdG8gY29sbGVjdCBhbmQg
cGFyc2UgJ3RyYWNpbmdfbWFya193cml0ZScgZXZlbnRzIGJ5IGRlZmF1bHQgYW5kIGV2ZW50dWFs
bHkgdmlzdWFsaXplIHRoZW0gaW4gdGhlIHBlcmZldHRvIFVJLg0KDQotLS0tLemCruS7tuWOn+S7
ti0tLS0tDQrlj5Hku7bkuro6IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92
QGdtYWlsLmNvbT4gDQrlj5HpgIHml7bpl7Q6IDIwMjTlubQ55pyIMzDml6UgMToxMA0K5pS25Lu2
5Lq6OiDnh5XpnZLmtLIoRXJpYyBZYW4pIDxlcmljLnlhbkBvcHBvLmNvbT4NCuaKhOmAgToga2J1
aWxkIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+OyBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaUBr
ZXJuZWwub3JnPjsgQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz47IGJwZiA8YnBm
QHZnZXIua2VybmVsLm9yZz47IERhbmllbCBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+
OyBIYW8gTHVvIDxoYW9sdW9AZ29vZ2xlLmNvbT47IEpvaG4gRmFzdGFiZW5kIDxqb2huLmZhc3Rh
YmVuZEBnbWFpbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNhQGtlcm5lbC5vcmc+OyBLUCBTaW5naCA8
a3BzaW5naEBrZXJuZWwub3JnPjsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47
IE1hcnRpbiBLYUZhaSBMYXUgPG1hcnRpbi5sYXVAbGludXguZGV2Pjsgb2Uta2J1aWxkLWFsbEBs
aXN0cy5saW51eC5kZXY7IFN0YW5pc2xhdiBGb21pY2hldiA8c2RmQGZvbWljaGV2Lm1lPjsgU29u
ZyBMaXUgPHNvbmdAa2VybmVsLm9yZz47IFlvbmdob25nIFNvbmcgPHlvbmdob25nLnNvbmdAbGlu
dXguZGV2Pg0K5Li76aKYOiBSZTogW1BBVENIIHYyXSBBZGQgQlBGIEtlcm5lbCBGdW5jdGlvbiBi
cGZfcHRyYWNlX3ZwcmludGsNCg0KT24gVGh1LCBTZXAgMjYsIDIwMjQgYXQgMTI6MjjigK9BTSBF
cmljIFlhbiA8ZXJpYy55YW5Ab3Bwby5jb20+IHdyb3RlOg0KPg0KPiBhZGQgYSBrZnVuYyAnYnBm
X3B0cmFjZV92cHJpbnRrJyBwcmludGluZyBicGYgbXNnIHdpdGggdHJhY2VfbWFya2VyIA0KPiBm
b3JtYXQgcmVxdWlyZW1lbnQgc28gdGhhdCB0aGVzZSBtc2dzIGNhbiBiZSByZXRyaWV2ZWQgYnkg
YW5kcm9pZCANCj4gcGVyZmV0dG8gYnkgZGVmYXVsdCBhbmQgd2VsbCByZXByZXNlbnRlZCBpbiBw
ZXJmZXR0byBVSS4NCj4NCj4gW3Rlc3RpbmcgcHJvZ10NCj4gY29uc3Qgdm9sYXRpbGUgYm9vbCBw
dHJhY2VfZW5hYmxlZCA9IHRydWU7IGV4dGVybiBpbnQgDQo+IGJwZl9wdHJhY2VfdnByaW50ayhj
aGFyICpmbXQsIHUzMiBmbXRfc2l6ZSwgY29uc3Qgdm9pZCAqYXJncywgdTMyIA0KPiBhcmdzX19z
eikgX19rc3ltOw0KPg0KPiAoeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwN
Cj4gICAgIGlmICghcHRyYWNlX2VuYWJsZWQpIHsgXA0KPiAgICAgICAgIGJwZl9wcmludGsoZm10
LCBfX1ZBX0FSR1NfXyk7ICAgICBcDQo+ICAgICB9IGVsc2UgeyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCj4gICAgICAgICBjaGFyIF9fZm10W10gPSBmbXQ7ICAgICAgICAgICAgICAg
XA0KPiAgICAgICAgIF9QcmFnbWEoIkdDQyBkaWFnbm9zdGljIHB1c2giKSAgICBcDQo+ICAgICAg
ICAgX1ByYWdtYSgiR0NDIGRpYWdub3N0aWMgaWdub3JlZCBcIi1XaW50LWNvbnZlcnNpb25cIiIp
ICBcDQo+ICAgICAgICAgdTY0IF9fcGFyYW1zW10gPSB7IF9fVkFfQVJHU19fIH07IFwNCj4gICAg
ICAgICBfUHJhZ21hKCJHQ0MgZGlhZ25vc3RpYyBwb3AiKSAgICAgXA0KPiAgICAgICAgIGJwZl9w
dHJhY2VfdnByaW50ayhfX2ZtdCwgc2l6ZW9mKF9fZm10KSwgX19wYXJhbXMsIHNpemVvZihfX3Bh
cmFtcykpOyBcDQo+ICAgICB9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4g
fSkNCj4NCj4gU0VDKCJwZXJmX2V2ZW50IikNCj4gaW50IGRvX3NhbXBsZShzdHJ1Y3QgYnBmX3Bl
cmZfZXZlbnRfZGF0YSAqY3R4KSB7DQo+ICAgICAgICAgdTY0IGlwID0gUFRfUkVHU19JUCgmY3R4
LT5yZWdzKTsNCj4gICAgICAgICB1NjQgaWQgPSBicGZfZ2V0X2N1cnJlbnRfcGlkX3RnaWQoKTsN
Cj4gICAgICAgICBzMzIgcGlkID0gaWQgPj4gMzI7DQo+ICAgICAgICAgczMyIHRpZCA9IGlkOw0K
PiAgICAgICAgIGRlYnVnX3ByaW50aygiTnwlZHxCUFJGLSVkfEJQUkY6JWxseCIsIHBpZCwgdGlk
LCBpcCk7DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+IH0NCj4NCj4gW291dHB1dF06DQo+ICAgICAg
ICBhcHAtMzE1MSAgICBbMDAwXSBkLmgxLiAgNjA1OS45MDQyMzk6IHRyYWNpbmdfbWFya193cml0
ZTogTnwyNDkxfEJQUkYtMzE1MXxCUFJGOjU4NzUwZDBlZWMNCj4NCj4gU2lnbmVkLW9mZi1ieTog
RXJpYyBZYW4gPGVyaWMueWFuQG9wcG8uY29tPg0KPiAtLS0NCj4gIGtlcm5lbC9icGYvaGVscGVy
cy5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDM0IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvaGVs
cGVycy5jIGIva2VybmVsL2JwZi9oZWxwZXJzLmMgaW5kZXggDQo+IDFhNDNkMDZlYWIyOC4uMWUz
N2RhZTc0Y2E2IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvYnBmL2hlbHBlcnMuYw0KPiArKysgYi9r
ZXJuZWwvYnBmL2hlbHBlcnMuYw0KPiBAQCAtMjUyMSw2ICsyNTIxLDM5IEBAIF9fYnBmX2tmdW5j
IHN0cnVjdCB0YXNrX3N0cnVjdCAqYnBmX3Rhc2tfZnJvbV9waWQoczMyIHBpZCkNCj4gICAgICAg
ICByZXR1cm4gcDsNCj4gIH0NCj4NCj4gK3N0YXRpYyBub2lubGluZSB2b2lkIHRyYWNpbmdfbWFy
a193cml0ZShjaGFyICpidWYpIHsNCj4gKyAgICAgICB0cmFjZV9wcmludGsoYnVmKTsNCj4gK30N
Cj4gKw0KPiArLyogc2FtZSBhcyBicGZfdHJhY2VfdnByaW50aywgb25seSB3aXRoIGEgdHJhY2Vf
bWFya2VyIGZvcm1hdCANCj4gK3JlcXVpcmVtZW50DQo+ICsgKiBAZm10OiBGb3JtYXQgc3RyaW5n
LCBlLmcuIDxCfEV8Q3xOPnw8JWQ6cGlkPnw8JXM6VEFHPi4uLg0KPiArICovDQo+ICtfX2JwZl9r
ZnVuYyBpbnQgYnBmX3B0cmFjZV92cHJpbnRrKGNoYXIgKmZtdCwgdTMyIGZtdF9zaXplLCBjb25z
dCANCj4gK3ZvaWQgKmFyZ3MsIHUzMiBhcmdzX19zeikgew0KPiArICAgICAgIHN0cnVjdCBicGZf
YnByaW50Zl9kYXRhIGRhdGEgPSB7DQo+ICsgICAgICAgICAgICAgICAuZ2V0X2Jpbl9hcmdzICAg
PSB0cnVlLA0KPiArICAgICAgICAgICAgICAgLmdldF9idWYgICAgICAgID0gdHJ1ZSwNCj4gKyAg
ICAgICB9Ow0KPiArICAgICAgIGludCByZXQsIG51bV9hcmdzOw0KPiArDQo+ICsgICAgICAgaWYg
KGFyZ3NfX3N6ICYgNyB8fCBhcmdzX19zeiA+IE1BWF9CUFJJTlRGX1ZBUkFSR1MgKiA4IHx8IChh
cmdzX19zeiAmJiAhYXJncykpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4g
KyAgICAgICBudW1fYXJncyA9IGFyZ3NfX3N6IC8gODsNCj4gKw0KPiArICAgICAgIHJldCA9IGJw
Zl9icHJpbnRmX3ByZXBhcmUoZm10LCBmbXRfc2l6ZSwgYXJncywgbnVtX2FyZ3MsICZkYXRhKTsN
Cj4gKyAgICAgICBpZiAocmV0IDwgMCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ICsNCj4gKyAgICAgICByZXQgPSBic3RyX3ByaW50ZihkYXRhLmJ1ZiwgTUFYX0JQUklOVEZfQlVG
LCBmbXQsIA0KPiArIGRhdGEuYmluX2FyZ3MpOw0KPiArDQo+ICsgICAgICAgdHJhY2luZ19tYXJr
X3dyaXRlKGRhdGEuYnVmKTsNCj4gKw0KPiArICAgICAgIGJwZl9icHJpbnRmX2NsZWFudXAoJmRh
dGEpOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgLyoqDQo+ICAg
KiBicGZfZHlucHRyX3NsaWNlKCkgLSBPYnRhaW4gYSByZWFkLW9ubHkgcG9pbnRlciB0byB0aGUg
ZHlucHRyIGRhdGEuDQo+ICAgKiBAcDogVGhlIGR5bnB0ciB3aG9zZSBkYXRhIHNsaWNlIHRvIHJl
dHJpZXZlIEBAIC0zMDkwLDYgKzMxMjMsNyBAQCANCj4gQlRGX0lEX0ZMQUdTKGZ1bmMsIGJwZl9p
dGVyX2JpdHNfbmV3LCBLRl9JVEVSX05FVykgIEJURl9JRF9GTEFHUyhmdW5jLCANCj4gYnBmX2l0
ZXJfYml0c19uZXh0LCBLRl9JVEVSX05FWFQgfCBLRl9SRVRfTlVMTCkgIEJURl9JRF9GTEFHUyhm
dW5jLCANCj4gYnBmX2l0ZXJfYml0c19kZXN0cm95LCBLRl9JVEVSX0RFU1RST1kpICBCVEZfSURf
RkxBR1MoZnVuYywgDQo+IGJwZl9jb3B5X2Zyb21fdXNlcl9zdHIsIEtGX1NMRUVQQUJMRSkNCj4g
K0JURl9JRF9GTEFHUyhmdW5jLCBicGZfcHRyYWNlX3ZwcmludGspDQo+ICBCVEZfS0ZVTkNTX0VO
RChjb21tb25fYnRmX2lkcykNCg0KV2h5IG5ldyBrZnVuYz8NClVzZSBicGZfc25wcmludGYoKSBh
bmQgZm9sbG93IHdpdGggYnBmX3RyYWNlX3ByaW50aygpID8NCg==

