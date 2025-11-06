Return-Path: <bpf+bounces-73786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F174BC39373
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 07:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 638304F9F60
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 06:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D512DAFA8;
	Thu,  6 Nov 2025 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qqUgUOi/"
X-Original-To: bpf@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73823D7DF;
	Thu,  6 Nov 2025 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409280; cv=fail; b=ODuQTAfRZdAeQM7mWo68fZbuQSrQkWZ47F+r9sGycRTtEUj+R+3gRgFw8+sSAEXDD/pG7I1E5ADi2oFPwZwOOAAnG0QWfO6edLHsm9yggekXwpvjkVg1TH/6Z117mAxJMTxKnOcCUcxKHpQ6ppZsBgHMZKA8NT8ZkmMobXJJtQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409280; c=relaxed/simple;
	bh=Ihzl7Ao2TnZ47MsUZ7C0rnzU2oDrKdyTBrcgnpnqoNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SkmaHGtQGZn0eRYwkgpCxmyciwGZYsy9xS6ipeFgZ8fVp0r59nuYcNE9atL89qfd/tNV4JQuKETjZWDz2fQGDS3hOgLSoGyy6t2FX/5jJtoCTTGk/tmsUNpNXwT2sj4vN0kYRZfn9L2x0I5wGdAK+h9h68UGkrFOy708kIyE9qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qqUgUOi/; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm7mziW1+ITjiwDB3+9gFE16kVqFBz4vnk1NNwBC3qtj2rgwukZfpKOJUBH/2P1oKG9tnBgmeXDBNKvqb0buheLK6RoVB9xH8NSRp4tMavTz9rWk7N2GyiRh3XAeevG8YscRnXrHv8r2Bim4xgm15JCUM61/S2eQ5XDGMpk1unDQ+dv/vWgINXAcCZaTgWCbyQOEoIXcx3QkPLL1/gGbEvqx29ahT8uB2ujYV5u13VU0RD2MrbRYCdyzyo6w7fQ/Z7vO6x+q5M6HFhWGDD/mUD5v34CxJKhFR2uI6+QI7DrZOUjaOkTCaaX0fCuH8WTFaSNcGsWNPsmK+i/yz0+XqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLrGQPJJu6j5xSuwzpP4BOGxhm3EOXqGOtgaSnK5/FE=;
 b=O6gcy49IiMJm9EXC6+HcGE81MuRMkbZWcuQSdqxJgu5det+PmAWPHY25q7miTT4oGI2c2rapmZ0+8pM2kkvxR/MDOVcyaTeGU/sGdizNNxiDtVIEuU4Qc5bLj/549lKK+7B9Mc+QK/N9iR7LpBmG0tQ0ZnTLUMrB5gL2wfNkXdO5c+LQ3WDbSnNepuoSC9qdi372I8E5Nou9Ouzvo3CxyiVpdaQUj/BEJCJH21q6ViD8yNt4cMXnKJnSdVpYpGYeOhhGBauH4E4zEnc5Bt2wzslf46iOjUMuuGr3hu6qtssBAgIp2byi1AyA1ay2UAZkw9lKYcgt+785Im+oS/ZZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLrGQPJJu6j5xSuwzpP4BOGxhm3EOXqGOtgaSnK5/FE=;
 b=qqUgUOi/k061U+stj/DnlV3K3Ci1s62vNcROuwMy9LhUF+k4qxDYZcCBB1S3vaJ/Wq9EO6BYEOKqfY5kS9x/QBhZiBf5LUNhDHBf6QCco7T4OQk57vqj3m+mplkzXxOOeGRcpqPV4Zzm1wwEisnMG5V8frg4Yy/ft4HUbth3t3isPj6PwvfQNywqOPtHQz32rhqQt05iW1C1SGRplxhlhlImhGx+I+Vfp1akuDcKRZ8fitUhuHFKndHVEqErUTMcuswLWxJYCCwJowPCmtXRE7HNvt9gLbu7wlt2OhBGGxAKT1gfl1doABZe27GIw0Fq0lBqZjIATg/yyJq3Y4bc7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 06:07:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 06:07:55 +0000
Message-ID: <0368bc9e-b5de-4b35-9f96-1bdc32aa6b02@siemens.com>
Date: Thu, 6 Nov 2025 07:07:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] scripts/gdb/symbols: make BPF debug info available to
 GDB
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250710115920.47740-1-iii@linux.ibm.com>
 <1eec0bc4-dc4a-4fe1-affa-3b8620dfc79d@siemens.com>
 <ea1f1fd23d1bf4937c91be3bd45744b07b000b1e.camel@linux.ibm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ea1f1fd23d1bf4937c91be3bd45744b07b000b1e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0af609-e6e1-4092-f6a4-08de1cfad3c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzZCL2huT1BmZGJRT2IwYWx5Nk5RTjVBL2VRKzZMdUV4aWwxM1hYdGRkZmFM?=
 =?utf-8?B?Z0xRNDFtakk4SGVtcW5peEVRc0owT0htdVQ0Ny92UXFBK09sSC9XKzFLaDZZ?=
 =?utf-8?B?MnpUU3BpMThwb2prc0ZLV0VqWmNaQVNQTDgwR0lxb2tpQlVYRWh1TDFyaHp2?=
 =?utf-8?B?T1RwKzYzbnVwVUNwWndJUWJ3NEhPV01oRlQ2NU1zV0QzSTlPbFdSelFVL0xy?=
 =?utf-8?B?ZzRXL3BzM1NIY09lNG9uNXEzMjQxL292NnREbmRGcldOT2JtOUROM3FQallO?=
 =?utf-8?B?aWg0KytzeGRRWUJwdGM1TG5kd2hFQ0ZwaDhYYjZtMzV3b2JyQ0tQVDRLbnZk?=
 =?utf-8?B?SWVnaFVER0NOL3hTNDRQNzlNYlBkUVZ5WC81ZUZ4bHhoN2Z6cENXamZSbURl?=
 =?utf-8?B?dy9qSDlvVnIzMEVackJ4YkM3M0s5OWhzVjZFQ1BsMVN3Z3JObzdObVZiNTZv?=
 =?utf-8?B?Q2cwYnBOU1BTY0tpdmNiWTdtdHdnNEprM1hYb2tRZ0pRTFF2VThaYWY2dElr?=
 =?utf-8?B?aVZUM3Y0bGdLWUx5WmljeGpvdDE0ZUdwSGovSXZFWmZvVlI1azVIRUloYVRx?=
 =?utf-8?B?YldYTTVDY1I0aVVJYWhibk85anBKbCsvSVYwWVZtVm5CNndwWUhwSDA5V1kr?=
 =?utf-8?B?UkJQcWVvaXhvcUdCeU8zQktTQi96OFBacGRNc3pkV2pFRnlxc3lXSXNzZTl2?=
 =?utf-8?B?WnZ6UnNTOENaS1hnbENYZlMranJQalA4WDlaRDA2MWtnZm1qb0p2aHdxalZs?=
 =?utf-8?B?Z2wxTk9yMXErakY1WFlOaVNMdFBxNjVYZUNCRW83ZkdwRUNqQU9RNWdYcWJz?=
 =?utf-8?B?QlBKRVhFTXVpRlV1dWJod1VNSElWN0MvemNoY2J0TEo0V0ZCVWNBdHExOWtO?=
 =?utf-8?B?eGovT2wyZzNaamZUYSt3aGNSMmpCbTdpVG1yNGlmcHhFNHFEakcwNFl0Z0pO?=
 =?utf-8?B?d3lLYzE3NWhsNS9uOFZpWnJzWFRoN1p6SHN3MXZvZC9acjAwT2pmSzRWY3Zo?=
 =?utf-8?B?RitnSHZCeXlVMjc3ZTc5NGQrTTJsUmM4R1YzT2lPRTJQOGw0cmdQWUJQNE81?=
 =?utf-8?B?bGJaKzRCNjN5aGdLNXpJZEJvc2lYMHpxRjlHUHM5SjV2NEdseXZzTWdzakNr?=
 =?utf-8?B?SUpQZWdtSXp5R3FmVk5OM0Vtc3daaGE0WVVmNlE0dHIyZzhZU3Iwamw4WWhK?=
 =?utf-8?B?OWdtdFJoTkxiYno0MmNpMzFRMnBLZ2hCcmUxQm9WWUN2WFFwSnZkYmY2dC92?=
 =?utf-8?B?VGxHeTdhOU5Wd3pQU29LcWlmQmpLZnE1d1ltNmNNRHhIQllvbVBpSXg1d2JW?=
 =?utf-8?B?T1A2TVBwUUZzeU1oYUx4UGJZREZKTExBSmtNUXFndFVZY3MyVWVteDREY0Vn?=
 =?utf-8?B?WHk1R2pobEZMZmFBTEVYL2FuOU1xMWVWa250SzlJZVRQcUpNZlMzV01Wa1N5?=
 =?utf-8?B?Vkd1clhwUzdleG9VdEEzMCs0WnVRL0I3YWVCWWRLVjR5T0UwRk5wNmVVdHps?=
 =?utf-8?B?WGJxendKaVE0bUFTZmxnOVRFdVh2eENER1J5aGdhZ1g1L2tsRHlsMURBMit6?=
 =?utf-8?B?UDRZOEkvemFLckVWaEJuS1lJMUVvOTVtTjNDMGlBc0pvNVdTZzdiODgrNTh3?=
 =?utf-8?B?TTZLeGozblViMmQ4clNVT25UeG55cmFsem5ZalJkbjl6eWNSd1gwVXUxY1o0?=
 =?utf-8?B?MlBqeFFHdHY2dlcrd0dyazM3U0J1dTJEeVhERmJrM2Z1eHBuaC9xeEpTck9F?=
 =?utf-8?B?YUhvaTM5VjdSOTB5Z20rWjJReEt4am9NMC8zQmFxbGNMZTVkSldjM1BBbldm?=
 =?utf-8?B?N04wREF1VVZyN3dvTkEvTWxVa0lYUzZTV25WZGFZdVpwaG5EVDBnMDlSa0xS?=
 =?utf-8?B?NXZ4U1JCU3pMWlhvTHVTL05MNzQrMlptZTVVaExGNjBXOWlSZ0FscUliT2RI?=
 =?utf-8?Q?6VbP6nwitQi7mBW/RTML6WJe0Eu+SU7V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2pocWU0UW51aU81ZC9uRUluQ21oTjMxQzRFUk5LcGJMVDE3N0RWZFhyc1dF?=
 =?utf-8?B?cGw4MXY1NC94VEhlazlyUGdLUUpOQkwva0w0MEtDTDlmbUg0OUhIKzhqRjFO?=
 =?utf-8?B?TGh0Y0V6VXNjcUUvSkhJWHgzQ3Y4cUltTVI4aGpxQ2h0a1F0UWcvRWtIcWRC?=
 =?utf-8?B?aE1OaG9GbGF1SDZZZlc5RllScm5MaENJcnZHVk9tQ0w1VDZIZ0dlU2U1WjBH?=
 =?utf-8?B?N29yRlBzQ1ZoSnBFdnZIb0lNK2owcnhqRUkwZXBtSldBU1NSS3o5TEJPK2NJ?=
 =?utf-8?B?UCtHK3gvT3d6RGpDTThsR0JCVHRyMnpJVVhBMGdwbmpkYjk2MUJqa1JyZE85?=
 =?utf-8?B?dXNLZ2duNjlGbWQzUVNyZUVuNDMvbTAxSjJ5QVgyaU56MVVoVXdCUnphTllV?=
 =?utf-8?B?VFBkcFBQZ0JSYllyU0NJS0ZvVFg0OU02N25zNnRGcGh6UUpXMW02encvM2Jv?=
 =?utf-8?B?dHdldzFTU1JqL3ZBdHVVWkNmdnJmRFBXeWJsY2RXMWk3cVVDcUZmT0kvVGJi?=
 =?utf-8?B?UTBHMVl0MSsybUlqL3ZaOTU2S2RYRUZJcTJTWGdkV3JicDVaZUlpaVlHZWNS?=
 =?utf-8?B?RUlCRzhzRERRNHUzb1ZwWXdSMnlCQlFUM0VVd0JGU3BRM3pxVE5ZenN1SnE5?=
 =?utf-8?B?N2tSK0NmZURhTFZUdjJ0emQ3VlVNcWFhSUkybjViMG1Ucy9vRGRTNDFKZTdp?=
 =?utf-8?B?Y2pRMTFheVFEaWtSS2VQWWhCOTRJKysxNThESWtCZUxnYXYyY0t1RFo4QU5T?=
 =?utf-8?B?bGtGQklUTlpoOGZmYmVGZ2pXNGthbUR2M1J6Skl3STZHK1hNOHU3VDhQTnBt?=
 =?utf-8?B?eFUxeUs4VWw0VlNZSmxFcnV4TmpOYTFOZVdUaXlLSjY4TnJVWFVCK25WamNC?=
 =?utf-8?B?bmIxYUFaNG4rbE5OMTBwdm5JNjRvVG53eW1VeXJ1UDk5c0x2OEd4dHlGVitw?=
 =?utf-8?B?bitHdjFjL3VNWXFiK2c5SXNremZKT25UWU1kdzAyZEJ6eG5WQVBSNERvWDFF?=
 =?utf-8?B?Y1RKVXpFaURIb0VRREV0aVc2M0lxamtueEhkc2hMbkI1SXZnQ1l5aVZCSFAy?=
 =?utf-8?B?c2NBL2I4eGtvSUlEMG8zUFByUklLTVExajNLcDI0bUl0S01PaFR1TllLTndn?=
 =?utf-8?B?akpnbnU1bzY1RHFiaGVRRW9HenN5TEdPK0t1TkVjU0pnMmk4R1NwWWoyYnBh?=
 =?utf-8?B?VXJUdnlUWmFhdjRRcWNOMFByR0c3OCtWWWlwdVo2VmVHOUU3MW01Tk9PVDVh?=
 =?utf-8?B?ZVJja01sMmlwZFI0a1VIVzdDNW9iRFhyeDByaGkyUmRwRFczMVFBZnM1ZWZX?=
 =?utf-8?B?eFJBTEUzeWVDZGtXRU5DN1dTdk9xMm5jMGtDUm1kc0NrTnBTSkwySGFqQVMz?=
 =?utf-8?B?YmRpaXZmQWgxWEpDOVZTV0YzWkovMy84SDVmZHhZZVhZc2hzV0hKM3JSVGhU?=
 =?utf-8?B?RmxDaHp4RzdrNUVlYURERUJTbEFNTTJZa0lYbERwVXpsSHk0enk0Uzg0bUwr?=
 =?utf-8?B?MVU3N0dvSHdRVXJnSjNTOTl1YnlDbVpFSTVHSDd5aW9NaTA3elVNTXdiditK?=
 =?utf-8?B?V2ZEOTlEUE5uT09yc1g5WG4zcVVUSDJmQ1k2cWpXMmhiYW9MbWJyQ0tOdllh?=
 =?utf-8?B?QUZxODNaeVRQWjRPMlV0VWF1ZGpvdnRuOWFtS0RQa1JhOXJiclFrbGxKZ29o?=
 =?utf-8?B?ZDVsbnBoTXlYdnpaVmhEaDVoeDNlMnd1b1JxK21LSGxZNGpWekFpS055RE0v?=
 =?utf-8?B?Z1R0cTEwelM5Wk14eUdqQkI4WXMwVDNyVEprNWNQM1ZGRXcvakVFbERvRUFD?=
 =?utf-8?B?aGZqTmpIZzY1c0hJQWJJeFdScHptallTMjZMdEF2aHhRNTN4RWVnWTVOVjFm?=
 =?utf-8?B?Q2VVVURnT0NsdmQyQVFKODc0NmZLck5OOWY2MGdWL0FreG1GaWY0MUxrazdL?=
 =?utf-8?B?SkZsbnZsVFdzdlpHa2N3WTJaKy9ndG1FMk94alVYYTEwTnJ6OEo1dzg3UVFS?=
 =?utf-8?B?T3JReHpWQ1M3MHdQZVRmVFV6bEhPUS8zdWdlSDZYSjhkc0grS3FzSXJkZGhE?=
 =?utf-8?B?Z3hWdUJ5WjkzNGQ5VEdlM2F5SVVyVDFNZ2o0c1lyZ2F0MzRxUzM5T2RBT2ZJ?=
 =?utf-8?B?TXNLTzBiZnNJdmtCc0tWUExUN2Y4UUZMY1MvTTdHK2hOcVZZTGlFTjIweUc4?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0af609-e6e1-4092-f6a4-08de1cfad3c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:07:55.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4u31OXi1ahs2VTd6nWIHP3VH6ZGPPp/rxf/qdzXkU0v1wa0tS0XDIVGAis5qqpUJ3Q+2dTtv6Ok+TTyBc47fnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9260

On 05.11.25 20:32, Ilya Leoshkevich wrote:
> On Thu, 2025-10-30 at 17:47 +0100, Jan Kiszka wrote:
>> On 10.07.25 13:53, Ilya Leoshkevich wrote:
>>> Hi,
>>>
>>> This series greatly simplifies debugging BPF progs when using QEMU
>>> gdbstub by providing symbol names, sizes, and line numbers to GDB.
>>>
>>> Patch 1 adds radix tree iteration, which is necessary for parsing
>>> prog_idr. Patch 2 is the actual implementation; its description
>>> contains some details on how to use this.
>>>
>>> Best regards,
>>> Ilya
>>>
>>> Ilya Leoshkevich (2):
>>>   scripts/gdb/radix-tree: add lx-radix-tree-command
>>>   scripts/gdb/symbols: make BPF debug info available to GDB
>>>
>>>  scripts/gdb/linux/bpf.py          | 253
>>> ++++++++++++++++++++++++++++++
>>>  scripts/gdb/linux/constants.py.in |   3 +
>>>  scripts/gdb/linux/radixtree.py    | 139 +++++++++++++++-
>>>  scripts/gdb/linux/symbols.py      |  77 ++++++++-
>>>  4 files changed, 462 insertions(+), 10 deletions(-)
>>>  create mode 100644 scripts/gdb/linux/bpf.py
>>>
>>
>> This wasn't picked up yet, right? Sorry for the late reply, my part
>> of
>> the "maintenance" here is best effort based.
>>
>> Looks good to me regarding integration. I haven't tried it out, I'm
>> just
>> wondering if it has notable performance impact on starting gdb or
>> interacting or when that could be the case. BPF programs are not
>> uncommon in common setups today. But if you don't want to debug them,
>> does this add unneeded overhead?
>>
>> Otherwise, I think it could move forward if it still applies (which
>> it
>> likely does).
>>
>> Jan
> 
> Thanks for taking a look!
> 
> I have to admit the performance implications are noticeable due to
> having to spawn an external process for each BPF prog.
> 
> What do you think about hiding this behind `lx-symbols --bpf` flag?

Sounds like a reasonable path.

Just one detail: I think gdb only uses a single dash for flags, thus:
lx-symbols -bpf.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

