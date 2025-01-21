Return-Path: <bpf+bounces-49347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB16A17994
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 09:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F98D1880352
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6AF1BAED6;
	Tue, 21 Jan 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="MGepBNnn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A90192B63;
	Tue, 21 Jan 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449623; cv=fail; b=qQ5/AMP+v76Vn/ObwMk1yAnsZSJEmHwlEFmy9Da67GrzDcpgmYVgJQOMx6QvhptKMucqf9NqfvCFmrpiY2sl+xOydO6HvWmv7nLalatqyrah92qHnCsh+M3M9RFWN8gIekR8g2iR/Saagpt5CGGOCOQ8qCLdxcuqCfBYtPSl2lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449623; c=relaxed/simple;
	bh=fuAJMnJdDdZy9NNIE7EqSSKlobewZDh5ZmPKKg+qC9I=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qbLgWhrUurIZmzfQ134fPrXUC1aNa+t2WJRCn6Vbubsxh+ybE4mUt4tqmMZ3xlm+UmAHjwCeShH2JjY0kXxlmAc3jQzZUTfEnZqRomGeQS0wpDUVlRNrQL2a8Q+q9uwPlf2R5YEqY8D0A1d3uGjaFQH74duwOR2/gT80a38QU/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=MGepBNnn; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272704.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KNpgcW018291;
	Tue, 21 Jan 2025 08:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=BIeCVhhtSSvavQOStAkbYBFi2AFOT3HiiBghkNw0rs4=; b=MGepBNnnUBtz
	ucd47YNtEAZF6CR/QUbSIuv+a1T0BdMlIFiAgm3lhXfXpDwrsCubXfCwjYo2+PNr
	IT+iGmVDYAbzjTRtJFZRqnzD3sLlVJ8vEyzYvbGIoYS18sAwcpsd9OS+9D72Hr6E
	E57HUAZRFcAeF9SLFj5OQIdN6xca19I2f68Z6BQPzS1UpLIxML7144mAStwKe7kQ
	m8velS12XrkvCc+WAL08wCGHl01bJqr97N+QLedHW1hmuomATAzaOA7CIuxYmLpF
	dHPF5o7Wzk2mRJCBEPbMnh08fogQVnDMcBq53JwmmP0C978mVM0aAEZMb+MzpbOs
	bhPqUQIrWQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 449wx3k142-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 08:53:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVEdl1qI+gGMxE2R6ODLVAiqloZ+VpVwiYBDE2W4oZHP3YpbI+VR0KaIJUFV2hxvccVLj+LFP2ysbSVDz8KXo3O0i6bqbGHcwX9PFnhB8yPAVfA1Ii9H6BK5DuCqFA9GHvG6Fa5j4u7SdTzCG2NgNVLqjZfaiaEJKA3+DAr5RduEFshpVFKfCrJFCDg7yIj4ccHmJnAgRCa3BWt63Ozbp44wA+5xt+IZJIQ7kXDrKrKfEkwDTCJe7j+NFbRygrP+4ckdLcRZpS0ri9TEVkrGYhynyKJTWgLIx8DaFrmw/OOE6zHktZsNZwbHKddsek04mwhRY2fyzEwIwKP1qAwjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIeCVhhtSSvavQOStAkbYBFi2AFOT3HiiBghkNw0rs4=;
 b=wcNYgDkL3bMvrm5q7wiRV9RmvNHNeJYHDon+e0jhyy8rRDS647+laYoE5dTZml4I+dxUkyU6uHo4JPTu0eMndlg+h7O99NdbbU6MykDJmv7jAXbiTjCTCNq66y3NDhwR367sk0YCMKYWMKPoID7RC4+qBPqdaYDfIMyslkR18rjCdtfwKXdHyeX8gHikr0IS0A/uWblkSm4/lGpEWFVr/EFbvA2ZHjOrOkIJ6F2jWeE3a+rulJAuZOJgpXa9a84XzawWnPa+EPk4rdY0C3qPxlMhSI/KY6ud689XSdJLtxY0TMRpE3UY2rGsmX5dnb7yi2IyGvjHTu3RlE1D6a8x4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 08:53:07 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808%4]) with mapi id 15.20.8356.014; Tue, 21 Jan 2025
 08:53:07 +0000
Message-ID: <2e2d05b3-871b-42f3-8d66-d92653f01a72@illinois.edu>
Date: Tue, 21 Jan 2025 02:53:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
From: Jinghao Jia <jinghao7@illinois.edu>
To: Daniel Borkmann <daniel@iogearbox.net>, Ruowen Qin <ruqin@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Masahiro Yamada <masahiroy@kernel.org>, bentiss@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250120023027.160448-1-jinghao7@illinois.edu>
 <938b3544-535c-487c-92d3-6f544231b7f7@iogearbox.net>
 <ce79eb50-fceb-4e84-9219-a71fe3e6dd6e@illinois.edu>
Content-Language: en-US
In-Reply-To: <ce79eb50-fceb-4e84-9219-a71fe3e6dd6e@illinois.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:610:e4::8) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|BL3PR11MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: a16c6fd3-84a4-4409-8f9e-08dd39f9063d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUNpYzdKZEhjRzIreEZDM2NxT0ZES1N6TzUxcnlvcTNGa1lmbGN3emFhUFBT?=
 =?utf-8?B?bEQ1SUNKWXJlckpTTThjU3VQeVI2RTJxVDdJT1RnUHdxeUM0K0w0cnlCS0Z3?=
 =?utf-8?B?UG0vdFY1UmFXZnBUOFBIT0JkSjk1ZHVqUjJ0bTVudWZ3SUpRalNIeGI3V0Nr?=
 =?utf-8?B?ZlJGMkFyejRnekdxTlIxd1NUTzRvWG5ZTDlJR1liTTRLY2doTzIrTi8vSFor?=
 =?utf-8?B?ZVVhdVQzcTlBUnJMOEVicnQ2OUlZeWdMS2ZPaDJ3c1pGOTZxdnJXcjJWaUtv?=
 =?utf-8?B?RHBTcjBPbWs5eGJoZTlndXRrWWVHd0Y5bEw4Sm8vZWR2WkdnSXJWVUJsVjMv?=
 =?utf-8?B?YVhRQmdOdHRzYXZKUzVkZFBVcWc5ZzRjUUUzbTFteVpyWjFhTDZWL0dWMVVM?=
 =?utf-8?B?bmx1c3NKVWhEWlYwUEh4OWZmNWZaOUJJYmtDL0ZHc0IvRDg1TnJ4RHlXZzN1?=
 =?utf-8?B?Q0FYd0VPZkZ4ak5SQ1M3NGJuQzcxUGRsU3BZSHdBeEt1NTAvcEpGdmsyVTkx?=
 =?utf-8?B?elRXa0VyQ05HZXZzWVhVUCtoMzRIRjE1NXZjdEduOUZXTTJDSVJaQ2ZzUytP?=
 =?utf-8?B?RjRwZGpQcVVVK3g2bTBFMGR5RDNsbkNSSHg0S2VRMERERGhUU0RJMFNXQjBw?=
 =?utf-8?B?by85VVZXS2ZLOWpOWFZhWDZabWs0TlpXMElCNVorMmpYSG5EMUl2SCtDaUI2?=
 =?utf-8?B?aW5HVDhkRkF4aE1vQTJ5aTlBUnRxWStwNWpCVTlCeWdEc2F3L3hCdGl4SHdv?=
 =?utf-8?B?RGUxa1d4cmlvWjRBT2l6MVhtRzdUNXorTmtFeGc0NzJRWHVlZkY4RkVLU2M2?=
 =?utf-8?B?ZzF6d04vNmgrQTNFSTdXdUwxMkR0UkFFL0lGcWNseUdWcExsaHRNK05RWEpo?=
 =?utf-8?B?MTlsV2hkS1BuVmx4N3NGU0FHNU5aUm4wbWNUZmd1bG9mZ2tiMEQ0VUEwNENT?=
 =?utf-8?B?VUprRU0zUGpGcS9IT2JxbGRsSlp3alZic2JLVXFSQVd5eER0cURXcWVQYjRJ?=
 =?utf-8?B?ME5OQjc0MkhPK1d0Nk1odzhjTW1jZUMvZTREQW1WQTZzWG1maEdPeTRsSEsz?=
 =?utf-8?B?azhUeDBTZngwWW9ObTJ1NnFLT0pBVFJmQVdFY3NiSEpmakxRNFBacUtaWjlS?=
 =?utf-8?B?T2hCdGxtNjNrTEVqQnphSW5VYnhsVmsxaTNSdWovWTRoeFBhNjk1T0NJelpN?=
 =?utf-8?B?aEZSV1ZGK1drRmhNdnlDMVVqT2RUbml5R2NDNldqNGkzSnhaYTMvcEE4dk5I?=
 =?utf-8?B?SzVyVFgxTW5aaVM3SjU2T24xVDdUZllPa1J3dkZqdXBqSnNKK0N5QlJrNWh2?=
 =?utf-8?B?ZjJDa2ZpYlh2ZTIydmp6Wkhyb0crRnFPdTNMdGllNEtRWHVicFBSS1lEUDNE?=
 =?utf-8?B?RHkydC9ONmVZazhXc3BtWHo3TjdNNDE3SWxpc1ZLKzA3dWhmYURIV2NGbFM5?=
 =?utf-8?B?aTlEWkk5endUSEZPenVZYUllS2g5ZXJacU93THpnRmk4UDVQTnVYWGY1cmlR?=
 =?utf-8?B?MGNmemJwL2hiVGxvK2lOOEpCcE9TOWcvRzVTWTFqZWFSeEczUm93WWhQb0ZR?=
 =?utf-8?B?NWlyVkRmeDlDMVFyTm9menVBSjF3TjFUa0QrSHZ4UDNuNGhkOElaR3hIYXJz?=
 =?utf-8?B?WUU3MEIrZ1FXNWt6OVBYRWgraU9YRUJCTGJvSHp2a2E3TmwyNUlUbTlvNjZK?=
 =?utf-8?B?eFlhZG9EQXpxU0JIRlVmU29GeFFXdEszZFFGYVZKSlNzaXhITmdCWDhCTENy?=
 =?utf-8?B?cnhNaElUUlZUanB1VW45N01HM2VJc0xQdUo4Wlk2cFpPQkZBNEgyZ2hZdnR0?=
 =?utf-8?B?UEtmK2Jadmg5OWpzYmRTc3RpcnRwWDVGczFoL0ZvTEJtNHZlWUN4T0dPaHJI?=
 =?utf-8?B?TUlhc0RCZFFvbDZCZVUzRk1Jay9MRDM5ZFhPTTJXRmJ2WHB4ZitmVU5rZm1q?=
 =?utf-8?Q?VbWDd+Vcddw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OThMY090NVZyRWJ2QkNpT0I1M2FhcXZWYXRqUTBFcHd4VWxtT3daeUtVYldQ?=
 =?utf-8?B?T0FteTFMWkhzcWYycHhKUHVUb0xHcWdMbXFKRGFDVVVqS0VMMlN4eVVPTWdZ?=
 =?utf-8?B?RGNVWFBGQmFLcFl6UHhhR3IxSDBjS2twZ1VHU0pYNXFhYytRdnBISVN0Vzcr?=
 =?utf-8?B?K3k3WWtydzBMN2ZuamZ5ckVsNDBMMk9WeUV4dk5XWWV0L2x1aFhBL1JpNUxR?=
 =?utf-8?B?OWZPbjVlSHZLNXFZZnBZZ0JrdlFTUkpnSGZXTFAyeEdqNmxHQm1NUTdoZVds?=
 =?utf-8?B?WVRmNWNhTTIySmNML1EvNEJoNlYzRWEyYjEvYlNqeHRnWDZwbTFnTVRja2h1?=
 =?utf-8?B?c0RnVkJ5T2NjcTAxdHU4VmE1aXJ0WmpzNzd5KzhxdWtLVXdFVlRKUTExSFQ4?=
 =?utf-8?B?QmpKelM3b21pMFVPdloxVUxPVVV0SFIrMHEyMDU1TCtXOXc4R2FVQVNLQmlE?=
 =?utf-8?B?dGxKQS9hY2hZYVNoYnJ1NlA5UGU5WWRPWGt3bVFIWXY4NzhxUWdObVczeGsz?=
 =?utf-8?B?N2tHc0syVzNtQmh4NDRxZ2Y4Njl0UXV0Q3ZMeUp6TkY4TFVDc1BtTDBkNzQ2?=
 =?utf-8?B?TW1ub0pvRkhWSk92Vnp2VTZpWncrZ3hud0ZRd0xHVGFYeUphbXdqVEtML3dZ?=
 =?utf-8?B?dDVGZzhYNDFYd1M3cHBvRnMzYjlpRmJxYVBmd0FOWllSMVMzcEVIamJpY2Fz?=
 =?utf-8?B?L1h5bUdhVXcvK3dWWDBLNzZNcVNIVnlJa3VlMFlHS2RCRmFmeCtlTExVRUtX?=
 =?utf-8?B?ZDJGNXJ3d0dJU2lnejRvTi9ocmdrU3REYzV0VVNHY0ZaZ0Q0ODdrZWNQZSti?=
 =?utf-8?B?cjJTS1F5OTdtQmpVd3Q2VEJzaWttVVJyc1RhODFEZTR2MmZqbU12ZjYvRFV3?=
 =?utf-8?B?MG1lMU9rK2xhNjdGMlBpaitHUGxKYStmR01LWGFBRFZJRGJwNEd4dWZIbjUw?=
 =?utf-8?B?ZHF3czQ4VXByZWE4VGtwNFBKQ2ZzcVhxNmVjckdBanh0RWhteXFlcU51aTFw?=
 =?utf-8?B?QkZBUXE5VHBNbW1jcEVqeTFYU2x3dWcwMnZ4U3RpUjNaYlNySjFPRWIvVzB6?=
 =?utf-8?B?Zy9pRSsydTN2WC9lRjM3REdtYS9haXQ5dU82V1pralFkUEpaaS9JQmREWCtj?=
 =?utf-8?B?OC85ZTlmdHY0TXYxQ211S0wwUlF0YXorUkpaT0FsTEhYNUVJUEFxS2FNOWNU?=
 =?utf-8?B?MnlmSmRYNWhWcDFDby9EZS9FVk52eWluRmR4bW5oVGI2ZG10SVY1a0lZUFo5?=
 =?utf-8?B?VUNrMENkOFovdFFJQmFYbjlUSzcxaGorV1g3ZW5ZaDVZR1Bwc3ZaUkp5dE1Z?=
 =?utf-8?B?QnhOb045by9iODJoeEdGaWF1WWtDQm5obkdqUXFkUHlKSVpOR1NwMTdhby9q?=
 =?utf-8?B?dm9Ha1FUWnhQcmFLYm5HSW1aR3AvL3JYM0F5dFEzT1I3WFB3Szl4eU5RMXY1?=
 =?utf-8?B?b2R3dWlXVS8yMlNNRlFxM3ltQW5NWGxrRUlGMFlCZGM2dTFnV2h2VG9rRTcv?=
 =?utf-8?B?bG13aWFzZytac2dqYmp5Z0xyTFAyQWpKOVlIUTZoNlQ0a1Q2OFBIeDZ5bWFB?=
 =?utf-8?B?b0d0cWw3Sm5SbGRvVlNlUnRQZWVjR2QxbkdMTys0bmZLSzloN1NXUy84T3hT?=
 =?utf-8?B?dzEvakZVdGNvNkpLSTVISEFNNWtMTXFZTitiTyt2dE9ESHQxcDlaWXpuU2xB?=
 =?utf-8?B?ck40YnVEME45MER1eVFIYkJHQjdib2JkeTNvSVVUM0RibVE0UENHbms4WlVT?=
 =?utf-8?B?UnRTNnBjQUlCYTBnaTRURGw4UWd0SXd2ZkxvcTVocXRudGtQZkc1bmIrVHl2?=
 =?utf-8?B?Y3hLVm14UXF6Tml4bGxFZmkwUjUreFRQSVN3U1NhYnU2Mnk5eTdOVzBiUGFQ?=
 =?utf-8?B?RFRwVUZ3MGFISjF0aEFjb2hDbE8zTGpHek9KOWRIVURETlRLUTI3dDUwa0Y0?=
 =?utf-8?B?ZnppeEdZeWgxMmhUMERIZGg3QTdYS05Zc1ZzY2tYaWNlcFJSaXovVG51NVNw?=
 =?utf-8?B?U0VIYUQ0RmVKTk8yNnJocTJzZUZMczA3MTZtSWg2VkQvZFBzVGJrdG5FWlFV?=
 =?utf-8?B?THh4WWwvT0xMT1JaeGd0Z2hxc1N3WGIvWkZmMUxNYi9PSFdZNW1ZNkdrSGpa?=
 =?utf-8?Q?V3crDiSAZio5XasGDBN9AMK1n?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a16c6fd3-84a4-4409-8f9e-08dd39f9063d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 08:53:07.2056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0BTkEyey9CVRW1E4/KV0eqT1LVZg9iFXm+EcdHK5l21oqIm/43zn8RsvL3ZAufMQ7UqKmXdLQx8JSnt7GzPvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-Proofpoint-GUID: ysaYjKrAJw2mKA5bpzNB3uqjNKLqTDfx
X-Proofpoint-ORIG-GUID: ysaYjKrAJw2mKA5bpzNB3uqjNKLqTDfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 phishscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=721 clxscore=1015
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501210072
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 



On 1/20/25 5:59 PM, Jinghao Jia wrote:
> 
> 
> On 1/20/25 9:51 AM, Daniel Borkmann wrote:
>>
>>
>> On 1/20/25 3:30 AM, Jinghao Jia wrote:
>>> Commit 13b25489b6f8 ("kbuild: change working directory to external
>>> module directory with M=") changed kbuild working directory of bpf
>>> samples to $(srctree)/samples/bpf, which broke the vmlinux path for
>>> VMLINUX_BTF, as the Makefile assumes the current work directory to be
>>> $(srctree):
>>>
>>>    Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
>>>
>>> Correctly refer to the kernel source directory using $(srctree).
>>>
>>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
>>> Tested-by: Ruowen Qin <ruqin@redhat.com>
>>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>>> ---
>>>   samples/bpf/Makefile | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>> index 96a05e70ace3..f97295724a14 100644
>>> --- a/samples/bpf/Makefile
>>> +++ b/samples/bpf/Makefile
>>> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
>>>     VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                \
>>>                $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))    \
>>> -             $(abspath ./vmlinux)
>>> +             $(abspath $(srctree)/vmlinux)
>>>   VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>>>     $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>>
>> samples/hid/Makefile needs this fix as well :
>>
>> VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                         \
>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
>>                      $(abspath ./vmlinux)
>> VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>>
> 
> Oh yes you are right. I will roll out a v2.
> 
> --Jinghao
> 

The samples/hid Makefile also has the same problem that was fixed by
5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from libbpf
EXTRA_CFLAGS") for samples/bpf. I will include a fix for this in v2 as well.

--Jinghao



