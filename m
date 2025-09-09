Return-Path: <bpf+bounces-67868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF56CB4FC41
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 15:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2131BC7784
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD5933CE90;
	Tue,  9 Sep 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j1WYv0wI"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D9214204;
	Tue,  9 Sep 2025 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424080; cv=fail; b=ph8LZBifZlAGC7dyCaPdnegXr6nsQ2Nme1eas23j8qhgpT+WyXq/ADf8zPsWlAqkNCJUvEtPExnXmnPfDvi1nEduJRpN2vrGajBR09dWYz2S/U5dCi2cW/mLhhpLKvg75I2LFUZlwF+50rLxldaORqOSyX4cMEwU67nso+KShW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424080; c=relaxed/simple;
	bh=QrYtgfaV7FU845i5SqQwshSbqdYhPeMkMX3GbECaY7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BfVL9qbRKu01mBoDaPO/Ql3CGqdas02Aj4HUGEGO5ibGzdRJI1FPATIceBCYukPmHHBlGINUml14ESPN4XwoLOwwow0ICD4SpydhDbwhJOykw1cUUmYQwjuny3iOS282hGcUldPnePhXmQo/XHV7hHxC/aTbZeEEGswAcurYz6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j1WYv0wI; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDgl+ZMSnyynFxHlc5mCvaDXPZZr3MRzpo01l2lskJZzTiPL/HsiDWTQpMJiR0ciiKi0VbhEZhpPvLqL1F6EBtkBRyj68FwRIzhx9F4EQKHobN4RXfBE+WiQjbAbBWNJyL1lMom/R6J24j6iYKXzkNbvOToJO2GZg3ktleu5UhMl+Z7bkhvARXOE81eNkiaMpi0/NcZ8Y7jxzTOI2hsje2pasUTgSTXi0K1Ka24fY/VTeswGkAjEzwQ7fxZeVbc15p+FaFWH2ALfXkdr0ZFhfz1QEZ5He9P+hxA8NxkAZPiotuTVM21ATprGQxibYC+DusVF1D87SQ6Jv7AGcB8pnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPAe5W0YjB43/HYuPMMex84KXVBiRAIJ0/HomsFDR1A=;
 b=E+IASa2nqDQGiLdRoo1K8YMowKCVkUktcNK8QpyhFzzzuIaWbNPKp54uvGP2xTiVsDQQxmAJbnixYuMxyARSKinXRYqtHoTyL4rwl3p2+ZN9rLErEeWwWjWzShqRyaPiG/h5cLW+rLcxFnAz2jSWcvC3jCeC5o/5e73aAgKMSla8lumNAH7syAbsopsn0ZcUyuSs4TmxfVHAHMeuBypdvGv4n7x33/N5TrYforQgnGxP3UpDQCka37y2yRp/bYFgP23k87S1/dGqOaWQ4nPzU+tJwWv6t0nHGxbNJrsLeEDcaehzfdw1lvcFXmhahnMYiQs8tU6maTnYu7yyemJ7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPAe5W0YjB43/HYuPMMex84KXVBiRAIJ0/HomsFDR1A=;
 b=j1WYv0wINkkFwwSUuoB+tA9kFkz+bXwdnuhII70fCvPh6rBlYcN5nOPmua/CT+9p7VECuG83RlqWVLreTWhs+op/DQ1AdenPiDfTSL52uuH8gW/2l5ukvFxeOCRzv9UtvQ3jANUbI2qwIQrUTr6MVnypRcYXPnyKKZ7zsJCTGqOj6vlCQNWd8AvatwhnCNaAqVRre7C64JNjKZ9fQTQkq5WdtlsEhcBN5Bw7SUetSN4vBmqRZR6I7Ac83z91T+a4YX49UyxB2wslv7pA4dOSqndfJwqgQ+40VD6d/f/KsyztmHVFq+Mfuczy/wqURWXPspju8GVvnwCueHH/Y7CSow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:21:15 +0000
Received: from IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b]) by IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:21:15 +0000
Message-ID: <19e4aad7-c4ab-49a4-9be4-28f464e6789f@nvidia.com>
Date: Tue, 9 Sep 2025 16:21:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 kuba@kernel.org, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
 <CAMB2axMk63AAv13q2QREn--ee-SMCwjhtv_iPN8EsrjN1L5EMw@mail.gmail.com>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <CAMB2axMk63AAv13q2QREn--ee-SMCwjhtv_iPN8EsrjN1L5EMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To IA1PR12MB6186.namprd12.prod.outlook.com
 (2603:10b6:208:3e6::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6186:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: e65bfe32-ba3c-4d5b-0f36-08ddefa3c108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFYwZm1KZXlLRE9uTHRLbGNPNG9ZTVArUVNjcXRycTNZMHg4emwxcER6Q0Nu?=
 =?utf-8?B?bExkR0JkVWZqUDR0Ym5vYWVVYXNpY1IrSU1YVkpLQzhwRk9LeW0yTG0vYzVQ?=
 =?utf-8?B?d2IweHdqUlp6cGdNcVhDbVZ4dnQxYWMreG1hSlpyRjJBQWRnUVF5a2NYV0RH?=
 =?utf-8?B?czd0QVJSYlZnOHdiMU9qQWk2QWRjVDZqZ1ZPdFkvQitaWDhQNXR0ZEtHMUZ6?=
 =?utf-8?B?QURjSVUzYnBFZk56V0JCLzYxSkE3ZzIzWStxVmpDYjQ1d0JqL3RGUUppK3NV?=
 =?utf-8?B?WTBLVjFhTVJPVEtGZHI2cHJhWmQxNC9QYlJmV21pajlSbU92bVFrSC9aZ1Bl?=
 =?utf-8?B?cSt4angvaWxJZVhSWG5rRzlDV3Y2S2hvSHFKdGRwYmhIWWVUaFAyREloU0Fy?=
 =?utf-8?B?NDZLSW9pM0k1eEJseHIyTDlid0QyMGdmOS9RM1RMUzk2cHJSK21RcmprZjhM?=
 =?utf-8?B?Ry9wUFdINXhqeTJjdFlGSGFtUWd3NkpVWXBZYmdrVzVhQU5rQjBsNFpEMzFh?=
 =?utf-8?B?MkpqUmRwU2JyL3ZCWW5YRmU5alc3UFZxeVN4NU9JSGtDZ0pOR21FOFBDNEV3?=
 =?utf-8?B?TVFSN1RxcUNzbnVDaXRzbWFicnV3Q2tBTFZzWit4ekJ0RXpvdExpbkNUWDlW?=
 =?utf-8?B?L1NDaGlRQ2dNaTFiS0lnTkpFVEU1SW5iTTkvMnJpVUIxcERhallDZ2lWamFN?=
 =?utf-8?B?aWdUYWZ3WUpISHhOaVp0RUZ5M2xaN3IrdURqbWdxQmJSR1M0OHVnQWVKM3RK?=
 =?utf-8?B?U29QeFVjZm56QlVKaUVGenZxZVlxMVJqWlltYThPUUFLNUpONXJXTmZCUG1y?=
 =?utf-8?B?RDV3NWtMZmlyVmRXNGI3Qmt4V0xRNFN1RlJPM3JsMEh4NVVXeEpGWUxhUmF2?=
 =?utf-8?B?eTQ2L3ZPTjJob2JhRHlHVzhWWklueUY0cVBVNUxlMElaVnlpc01jVGVkbVd1?=
 =?utf-8?B?ZHNFOHFsTnh3QjdIUUZWWWlSRFBGVm9IWTFVSGVheGRpdGRkcThOUGlEQ0JT?=
 =?utf-8?B?OGhtK3NJeTllQ1JCK0NmN1RNZmdQczluajlZYkYyd2RwZ0h3UklzNHdINjI0?=
 =?utf-8?B?UnovU3I5VDFMYUZmVTRGV0twVGhTZTdxUUNIN3IyZ3Yxbk1PcDhkc3MvVWZI?=
 =?utf-8?B?SUFsU3Z0WXFDK1hQWkFoNnE0a0pVK2pWL0lSYVBxK3I4dm95QkZ0RGRFSmZR?=
 =?utf-8?B?dmpuZ1dMa1Y1NUozL0lsOG1vbGZrdHlnNFlvOGZKa0VsZzBWdTZ2NElhQTlS?=
 =?utf-8?B?RWNDdzN4VDNDaFlXcTVXSW5JcXlMcnhzTVFEZFNWdHFSN3ZEYlBHL2hHZTFn?=
 =?utf-8?B?RDFnUnhuMHB1L2lhMWNXMmFjSlZ4QXFQakoxWThCK2F4bDJ3OEw1WDdqWmd0?=
 =?utf-8?B?QWxCUitpMXkyTUpvKzNqMG1Xb2laV2ZYMFNrTTJKelBFTnVRMFZ0QWE3RytB?=
 =?utf-8?B?blNOV3diWFJzbnhvT3NLVjdaWURUOUgwbGk0R2JYQ0JZMGwwV1FHSmRvcHpv?=
 =?utf-8?B?WDFJbjhab1ZqWDV2WnFuV1RodllQTVRXb0srUTltWEtxSjAvd2lzQlRVM1hn?=
 =?utf-8?B?WUR2TjNlTUx5Zno4TWlKZHFGb3B4R1BnSWppazNBOVpCTXVZTWhqVDZIdEhV?=
 =?utf-8?B?WmpmYjZpNllRM2dtZGZodTd6TjNsOUFCeGdzVE5ZaHFkZUNNTHB0QkR3TCsy?=
 =?utf-8?B?SG4wUG1JSmJYQjNsVU9EOXBPcTlwZ082WXYyQVRXYjBPWWJJUGtzam4zeWZY?=
 =?utf-8?B?VHdqblhtMFBuZUNJMWxodkx2K0dyQlBWTUVqcDZpZ2s1Zmt1a0piQWFnajlU?=
 =?utf-8?B?bFlaTjFuMW9CcHZvWXdYcEhBTVZvaWIyd1RDM1hUVXQzRi95ZlhzUU5Mbk5m?=
 =?utf-8?B?Y3VsbDZQbi9qMDcvbExaYTJJaTBoWGtWY0VyVmxKM3FsRkl5elZsc1JRbTd5?=
 =?utf-8?Q?OXaCNn5TA2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0hFdkdxRUQrdGNkVjMzbkF3Y2wwcFJtYzdudDQxRGlmMjlxSmZXK3VRTFBt?=
 =?utf-8?B?Rkl4bmRkb2tWY2daaVRCWjNWR0xRa3B6SlVhMUpzWkRLYzBZaTkzTlowTWcw?=
 =?utf-8?B?c2JmZDk0WlB1RytGNjFORDB5OVFuNDFyRjB4SGFXN29yeGJ0eWQ4TGhrdEx1?=
 =?utf-8?B?YkRiTmNwa29qYm5jaDR3TjdQdElvVjBoZ2RhSDBpL1g5L2hQWURjQWIrVFhk?=
 =?utf-8?B?cDNZZ001YWYyeTRhZVJ5QVo2dGpUVjhIMUpkVzdpTHh0R1MwRkFWN1FCb3dj?=
 =?utf-8?B?aGRnR09aRGpEbTd3YzRqR3V6Z2hFYis5Z2NxY1JOWCtMYXVONHROYk5BcjJr?=
 =?utf-8?B?bXVkeWI3cXhGdFBrS2JZQXdKQnlLYnRycUo0bmVIc25xUGlQWXlUS3IxSVdZ?=
 =?utf-8?B?MEFzV0s4T0JlWnh4Z2habFcwTFc3SXZ6L0J6UkZyK1p5elczbExmbzVnNGxE?=
 =?utf-8?B?RXBLdkxIb2pvQ20zSUMxWEhlNVp1UmZFSXltRml3K0djc0pvdjI5MDVnaEQx?=
 =?utf-8?B?ck0vK0RWNnQ4WWlJUWRDdDROVzRTbUFZWjB6eHM4UVVqNitOeEcwVjlyazRl?=
 =?utf-8?B?VWM1YjhwTlJJV1FUL0JnYm9RVmdtTUY0aVp2RmxUSFp5K2pvNVN6U3YwOGE2?=
 =?utf-8?B?Y2g5T0lrczlLaFMrcElkNVl3SFVGM1hLaHhQUVRNNGZqOVE2NWF0djkxcStD?=
 =?utf-8?B?cWk4WmdFd1Q1SlJuTmtNakhXUlkvaGRWRE1KN0I0d3dOUXlRVlZSdWRUa2V0?=
 =?utf-8?B?Mm5mQitXVTNlYnYvVkVEZm00S0ZnTFRsUHFSYkYrRFpoMUVFcWpxWHY4QUxx?=
 =?utf-8?B?ODIvcnh5ZUJ1LzkwWWdOUisvM250TDUrSUVzVzZnNFJWQWdEeldzRHVWYXZp?=
 =?utf-8?B?NzlpclpCUlhHK3dtYkorYWsra0J1dzg2YmpsL0N0Q2RzL2pTMC8zZ2hibjBy?=
 =?utf-8?B?NzEvVWFKZG90UnpZaG9QbGlUbDNacUd2anhwTlFOcXNzcnorMHlTNk5mV21x?=
 =?utf-8?B?bHFTTkJjWVJUcVhSYmdCZGhCRXpnU2pxazRjLzFGV3dCakpSb1pyQ09BMXRV?=
 =?utf-8?B?bkhpZG14Ym5YNVRqbmRyMk1lV1NCR0E1blRyOVl2UFpwWlA2VGhnVlg3SEoy?=
 =?utf-8?B?N3hPa2tkZGpNY0pEd1RNUVBsNGxZalZRT2FjZXJQWnYrM2VwajNRcjh0SmJU?=
 =?utf-8?B?cU5nSjVoRjlubXFubWhRTjllWUp4dEZnd2lkWHFHTWxjSHFaVU1kOHYzTCt1?=
 =?utf-8?B?MVZDV21xVm1aOE1FS2hweStSdjJLMEhZR2hQYUhONzZLVENidktaWkQzZVRG?=
 =?utf-8?B?RTdrSlVkZnh3clFyMzdFRmYvV0RycDdKOWdoVjdSeXplZGpNRHBVN1N0LzBN?=
 =?utf-8?B?OXlNenRkRG1MVFJkazdvZWZwSjcwOGdYdzJ4R2dVZU1qWkRXbE84MmlsM0I5?=
 =?utf-8?B?M3hDRmpVd2RmS2g1M2NYRGtMVElrLzIvY3hVUWJxc01XeWNaM05uQnhqcVFw?=
 =?utf-8?B?Nnh0NlpVRUlBd0ZIYUYrU0JaeG42RkJtSWU5WGJ5QXNnL0JVQjJ6WlNvb0Ix?=
 =?utf-8?B?blF1WHZLcEdNeVA5OFh5WC9DZys3LytUMHZTWVNINFpDNUJNS2Y5N1M1MlQ4?=
 =?utf-8?B?dmF5OEVSWG96VlhiTzRTVUpiS2VFQmM5b1NUR3JWM3lRUTg2Ny8yZldHVzM0?=
 =?utf-8?B?VHpxVm1yUi9kUG1kekhJcUZ5QnlrZGRPeEZINmV3QU9NbnBFRTJwdUxUMnFK?=
 =?utf-8?B?QlVtRFV5RjAzRFd3TURFL2NjM09hYUl6V3ZEMGQrcHFNemNHZFcxQ3VaVHht?=
 =?utf-8?B?WkNXVEpyKzZtTmlrMjljTWM3QTVBeUxqeGhLS1lQZ2p3bHA3dk02ZjlrWUZn?=
 =?utf-8?B?akZzbys2UDlWSzdVZzBqVzcwU3lNWkMrRmhjTFpObmlBY3M3cXptQzYwZEI5?=
 =?utf-8?B?UDM1NTF3NFdhS0JrOWNxNVNTbFpTMzF2di91SnR4bXJrQ0c4TmhCUEpqc2pi?=
 =?utf-8?B?dGFXTTJFdDBFWXB0VFlRS0Z3VTFyTG9HU2tiT1dtalpIblVzTXRMeTY3QXFB?=
 =?utf-8?B?RXphQWcyRzU2eDN3OVQzOVZlaFl1djlJLzRrdUptMWN2S0JkcHRvcFBmQ1hz?=
 =?utf-8?Q?RZPWdr8OM/aEzg7hxaBHYAKWe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65bfe32-ba3c-4d5b-0f36-08ddefa3c108
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:21:15.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7zstXjojAx15+P1aPzpD0GZdPUpFiv6RgJzPjOG747/5kvZPxnebJr1KXqDpJyjqsalWsKM6gcEHKjZpzs3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

On 05/09/2025 1:16, Amery Hung wrote:
> On Thu, Aug 28, 2025 at 6:39 AM Nimrod Oren <noren@nvidia.com> wrote:
>> I got a crash when testing this series with the xdp_dummy program from
>> tools/testing/selftests/net/lib/. Need to make sure we're not breaking
>> compatibility for programs that keep the linear part empty.
> 
> ping.py test ran successfully for me. Is this what you tried but
> crashed the kernel?

Yes, that's odd. Is it possible that the native multibuf case was
skipped over because of an older iproute2/libbpf version?

If it's helpful, I used iproute2-6.16.0 built with libbpf 1.7.0 support.
I am able to reproduce the crash by loading multibuf prog directly with:
`ip link set dev eth0 mtu 9000 xdp obj
tools/testing/selftests/net/lib/xdp_dummy.bpf.o sec xdp.frags`

