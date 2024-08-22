Return-Path: <bpf+bounces-37876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69795BC11
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95751F21184
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032371CDA25;
	Thu, 22 Aug 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ugisybDf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6D1C9ED0;
	Thu, 22 Aug 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344578; cv=fail; b=rh8nI8pMVGngUDMuF4xzWuAj8i632I6bV10xYw89frG9fmL9DXAT8MeEfWfRBnECwnAnBA1HeqkxDDeqBBo/dzQZU7+/0QNBGfRouP3+0VtPI2A7djs9u1RNwCySD0iWzV4Hwl0GNasS9PtQOQSahivLqTQPzI085FqEWwJbnGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344578; c=relaxed/simple;
	bh=gFJBB9LNLr7DaN6C4PQD87q52Y0kWfi/uvGdAQJc7B8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WaKB0fysVrTGIJWWZzX/oKQp7x3o69KU4PliTaYrrX5GAJzZfnR+J8KRk0z2nqCJbdadMJ0TWzZorS9DsUdKCk5ZRD5K6TIq5PUaVtj1PAjZBGVMJi52m4niWRfvxLs0GouADGPQ6lduxvHVUwuBwzJsl3aEUJ/FXkiAF1OF070=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ugisybDf; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M9WcvW017393;
	Thu, 22 Aug 2024 09:35:23 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4162sp2113-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 09:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnWecAFkXYHRhOfU8jeMi/UVyPmA+gcpzzGL9MYuhBUAASC2NAfCwDEg+4ZoTx9Uen6ker2DxA4Bq07xNwwyzgKIhRMdEbmlSiFw709uhrGdFv4b418fsoqdCrJCLDT7eFyC9TwEapCp6c9HsPV/TW5GjVTv98gIbWyojsMZojt+BmzcuNlkCUfo3fqoAYuFfk1cAmDC0AGbubQJlTGnBKAUirMFFAa6d+Q052DPbrNLNjcPn9u82c8HefMONvfzZpaBxNzYwNxPLfZ/dNhvpsdN4tJaNVOgCg5dliloUfjm1G3A2konilAueBwfFzYVMnLihj6H3v0xr3GcZP3Orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yd408lgW0doSM9KAJ+bC1VcZgAakhrUnCZ4T3qD/kag=;
 b=gYRa5MpnYiRdYqB2qbCFPnMadMUwsm1q4SNnVk4VT2IH+OyW7tKuraL6u9MNn3igZ1IFjA88+2peShbl83cnbIqrffXGiqJhuBco20fwm8wNsFl1corpYvQ0T/ByaudN6aIftrzCYY4B/emSd4dsrtzKfBsIHT0i06D7wyWQDwzaog5g5zscuMJOn6n+qkKZ/9cgqmfCZxOOKnRXtsZzwEBnJ2z0DtEHFi8+15YgReoLJEa6YM7r42QxOwOw1wBYzalYglTiiydUWia5qivOOY6Gm1SA2lnp+HCqJjgOzjF/PcRVMQ7vi47xNq2TfXo86k0bAE+Fn/oe1M9bNeFOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd408lgW0doSM9KAJ+bC1VcZgAakhrUnCZ4T3qD/kag=;
 b=ugisybDfrtuT0FTjd3OU/y0bN4E33jCPWXFbYPtyHJ58c0nH5KDZ+Gzv9yU80ImJsDMiElS0MecO/W9xfea3D4E0NukVKBmosX81QaVRQOrE09CT2ewecVnVnJK7nPOZBBXi/G1T1SCT4yyOUQTpJsGnnuaEXrmBPBIE2nPYRbs=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by CH0PR18MB4258.namprd18.prod.outlook.com (2603:10b6:610:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 16:35:21 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 16:35:20 +0000
Message-ID: <5f7a617e-a8a2-40ca-a54a-19e58d69ab33@marvell.com>
Date: Thu, 22 Aug 2024 22:05:15 +0530
User-Agent: Mozilla Thunderbird
Subject: [net-next v4 4/5] net: stmmac: Add PCI driver support for BCM8958x
To: jitendra.vegiraju@broadcom.com, netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com,
        rmk+kernel@armlinux.org.uk, ahalaney@redhat.com,
        xiaolei.wang@windriver.com, rohan.g.thomas@intel.com,
        Jianheng.Zhang@synopsys.com, leong.ching.swee@intel.com,
        linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        andrew@lunn.ch, linux@armlinux.org.uk, horms@kernel.org,
        florian.fainelli@broadcom.com
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-5-jitendra.vegiraju@broadcom.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240814221818.2612484-5-jitendra.vegiraju@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::7) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|CH0PR18MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2251f247-451e-483f-fb15-08dcc2c869df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjFpWGRWQmdpTzAzbHdNNUoxUHpBbk1YeFBxVUVRc1IwQU5od3lhaHVWRzFk?=
 =?utf-8?B?K3k2QUd2SnFmZG15dGJ3RFhDYks5THFYck5WcEkxNERKamJyWDZLdm5MOFVw?=
 =?utf-8?B?YW4xTDVyZmNIRWVEb1NWYS9hbG9rWkJueGNZY1o5Sm5rK1NKK0cvL3dPbGVV?=
 =?utf-8?B?b0pYZVBlNFpRTDBFYVR2b2lUY2loc1NTYklZcGY1TFg0Nm9tZ0hwQUlGcDMz?=
 =?utf-8?B?S2t2VUtKeXg4NDlSQVJ6Rnk0clRSZ1VjZVZUN1l1eVBvenlZaEFZQ2FsYjk4?=
 =?utf-8?B?TUV3VUlqR0tRc2ZRWGR5anN3TituaUFzcFpyeWNqWVlmR1pjVmV1Q05rT1I4?=
 =?utf-8?B?cHYwNXdkSGc2TzRUR1FZVk43WkhxcFIreEEzaXlBemRIVEtCN3BUY2o5Tzlt?=
 =?utf-8?B?RjJJZHpkUkgwU25kN0RuTnIvbzdYc2FSNFpmOG05RkxoN1gvbUM4ZUN4Y002?=
 =?utf-8?B?dzQzdVh6WXhwc1FLU09MZjJPUmpaM2xVSktYVUlydmcvNytvek5tdEdDb0RT?=
 =?utf-8?B?d0E5WUtOWkcyem50dWtFbld4ZTNGWmdqQmJLZEhXTUN4d2ZmcURBVkZJcndX?=
 =?utf-8?B?TmZYaTNwZUpRRmVySHZqa0Qvc1A4MXpCMjdKck9RaFR3Sm9saUlsQ0V6N2tK?=
 =?utf-8?B?SjArclJQOTdYNjBPeHcrY2NwMDNkU2pKUUpXWmZpbG9NK0xqdmtrNE1GakU0?=
 =?utf-8?B?eEc4cjlKVjQwNWk3aGFmQ05UbVlyb3dZUXVrRG95VmtzYUVHQXI2eVdsVXM0?=
 =?utf-8?B?NXhFbWtoSzF2NkFLb205MkVhbDVTeVFQL0JJQ2NJVlNkNGRMaStJZGtDdVY3?=
 =?utf-8?B?M2hCbEJtU3gyNjJSbmpMWTcrcTNVRk43ZG84U2FKVkFpMlFCYWUrWlNiWkFo?=
 =?utf-8?B?Ukt4SkdRekhvUHExbXB2Qy9VR3cvM2JhRC9SK1Z4bElVTENvdEl3akw5bk52?=
 =?utf-8?B?WWJTL2pJRE5WUm9KVjNNUXNqVVRBamdyOXdSVWQwdE40YW4xbHdqY3ZEbzE2?=
 =?utf-8?B?VzNKZ1ovU1NSZEs1THJBdUcxM3Y4Qnh6UGY1M0tzaWRNU25VekRYOCtUM2Mv?=
 =?utf-8?B?VXV3NEZsZFB6RTFIZVZFT3dnNXVNRmozMHpuZktBTFBubzlhM0VpbmxFeG91?=
 =?utf-8?B?UlFLdDVXMGlGNjlIaXpSd2U1bkczbWt5cHFuK0Z4bXN0K05vNTFyaVJrb3lC?=
 =?utf-8?B?eXFRMytXaFVFNnI1Q1k0VE1EYVoyN0toSnRKakhlcjRQbS84Q3padjl0Tkcr?=
 =?utf-8?B?NTdOalBoNlhJc00wQjd2U0JteDZKbjl6ZjJSSXFmcUZlUFRub1FkYUxxMWQ3?=
 =?utf-8?B?TmJBR215Wk1tTUFrWUxxZjdTdEVtdmhBOEtOWDArVEh6UXdwSXAyYjlKeWNC?=
 =?utf-8?B?dDByYk10T1hBT3p3SmIzNXNGeGhoZDhEUE5LY2pNME4wVm5sSWhucW14dWRp?=
 =?utf-8?B?TW5uZDFvUXBaNjZZM0NBMXV1dW9yZ21BNDZCZkh3RjNZdjRvQnFZZFlTNERh?=
 =?utf-8?B?a0RZd3pIZkhuTGZsY091dzlzSzZFRG1xZ21BUzJCaXc0enVScjRjMFQybUtL?=
 =?utf-8?B?Q21TQjVBSHA1b0hWdzQvUzRRTGNZdHlxdHJHZmxtbkdTTXNOcmJJMUlUYk15?=
 =?utf-8?B?UkZCd200WTNZQ3RQUVk3eVNlL1ExbTRWaGlMOUFLa05aU3c2WEU5UGxRZXFQ?=
 =?utf-8?B?VVhKV1ZxVHg3enRqcGFQakgzbENleGQrQUNFRWh5OGFDTUtvOVB3Zk1XOEtp?=
 =?utf-8?B?cXk0ZHdwazBZQjJZSGZzK1BZVXF1K2dvb3F4VUo2aG0weU1WV2hpT0tac2RV?=
 =?utf-8?B?K3piNTVjWjY4d2Qwa2s3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkF2dWczQk5vaE5FRU5BN2F4c2RTZzR6aHZ2WkFlZHhKSUxNZ2VxTFpXem1o?=
 =?utf-8?B?dXFWbDIvbC91Q0xESjVHNEZjMTBlVmZCOU15M3Y2d09nSjhWNzk1NG96OVdh?=
 =?utf-8?B?T2VpRTBGb1BNazZUWnhOVFMzUTNKWWJIcjVZTjVHU0phMnhkMmNMa05NWWRV?=
 =?utf-8?B?Z24xbFM1ekRabktQbFAvTGdSQXNSK3RjZk5ld2s3ek9mVG5MajhteEQ5QUJJ?=
 =?utf-8?B?VC9nb3phSU9zUGRmUjhLMVRPRzdES09oS0p0dUM0bGU0MzRVSWg5UXE5aVFj?=
 =?utf-8?B?dkp6NXlXU096QkgwdldCczV3M1JTOGdHaTBteUpjRlRzVlFLTnIxMlhsVU9T?=
 =?utf-8?B?aUV6RDRhQVRVZ2tYb0RzMXhUaGdXUS9QYlYwWXhSUWY5dXBpWUpDS0JITGtu?=
 =?utf-8?B?cnY3c1FJS2RkSytIbzUrdlY1SUYzdVZyQlpUN2lDeXRJZVhCamN3UE9pa3h1?=
 =?utf-8?B?NU80alVYY0piWDVsRGR6TEZDSlZ0WFZ4aVFpdmZuOFNxWGU3bHhld1RqZE5Y?=
 =?utf-8?B?Z3IxV0pPa3ZlZklwU1p0M2lUd3Q0S2EzdDZaS2o5c0ZkckVhMEs5VUQvK2ZH?=
 =?utf-8?B?UUErQUdKOVM4UFpFSjlwcUxkdDZJd0dzTTF6Z1ByYUdlZjBaNjNYeS9HLzRB?=
 =?utf-8?B?L05KRVc5OWJVbGJjRTFOT2dlNHVDeDhYajBtTnd1TXNtdjN0eU1BZ0tIVnVF?=
 =?utf-8?B?djJieUd3MTZpeHVPbzIzWUhMaUxVS0FqZ2tjRlB5Z1grK2xISVFkdnljdFA2?=
 =?utf-8?B?bFdiWUwranRLYWIxZC95ZHgxL21rSmk1ejZhL3dhUU9Jbkx1Um9kTDErK0s4?=
 =?utf-8?B?Mk1XUmxMbTlMWEpBMmlURGpTSFIwbGM4QXpqK0V1c255MlgzRE5vbkQ3aVZC?=
 =?utf-8?B?VjhLMjFKeWJGdEFmbkUvM05aekE5a2h5UHlRbVRGUmdpUmZqNUNYdzc1Q0ox?=
 =?utf-8?B?bEp5amxzUSt6cndGNWp1eWpyL2xHcEM2cFNOM05pY2RQVzJEYkJBcktnSTFz?=
 =?utf-8?B?dzhoQUpKNDBld3c4TVV6NGFsZzJ5VDY5R3hVeDNIUlN2MjloMCtEeEpPVGxP?=
 =?utf-8?B?cE1yUXlKQkZyVk1xUWhicThWdDN2VTRZbWk4Kzlla0FpTVptK1BOTzljRWQ4?=
 =?utf-8?B?eUdVSWFvTm5zK2wwamNKOEdqMzErVDM1cGJEU29LQlVmOTJsbzlNNjdnZUJO?=
 =?utf-8?B?QVdPSDRnenhNU0hSV0Rab2dZTUtKUTRXd0JRb20vZVZSYWJLNXBhd2Z5Qjcw?=
 =?utf-8?B?K1o4TDVmK05pS3N3d1d4WjN4L25OcURqaldYSkZMcU9rSzNvbG10MW03dmhL?=
 =?utf-8?B?UU9UUGlUTmFRZ1JDRS9xMkVJQzBRZmFXRlNWdW9NSGt1NzBTaTdxTmNOWG9M?=
 =?utf-8?B?NmdqUnFQdWZBODgzQzBXZkMwQnhuT0orRE01SmdHalhYbmdVMDI5dmJJOFl6?=
 =?utf-8?B?TUd6VDlBWXphUVdEYmo4UEcrbzlkNGVqbGRuOVA1dThrcjhpLzVnVE1OQkRD?=
 =?utf-8?B?UzREeDBQbG11NmtYQk1WYVpOem0rcUl6NHdXUHdFTlRNeFBnTTl0NktrZDZ5?=
 =?utf-8?B?WE1hYnd2N2MyOGh5NmFjYkdVMExGS3l6R2xseHJvejB6SzlEUjU4L1Z2NDl0?=
 =?utf-8?B?QitXNDRXQ2NuelJ3eHlnekRzQ0tYYy9ocHhoWEpKc25qRXVpRHZJOHVZUGE4?=
 =?utf-8?B?ZlZwamt5aGVBeHZ6M2ZiR3duRm53OENtOXY4NEsvS3ZmR1FmK0VIZjhWekFy?=
 =?utf-8?B?Si90L1NJK2xYK1ozMFpZelhuMVBLR3AwRTlFeURyUkJoTko5TlFHKzJjVE9a?=
 =?utf-8?B?cUNKbU1hZHN3bGlFMXloZDBUWVR3YlhGVkdKWTd4OEliejlQVkhJL09kSUpq?=
 =?utf-8?B?dHlaYTJpcEJ5OUFjTUwwQUxWUEtOMEI1dmFpNENkQk1nTFIyMHQwdUpTejEx?=
 =?utf-8?B?WDZZWjMwSVVhY2JvYXU5TEZuWlZTYm0rV3V3WCt2SzVFU21ZRndlblNzd2Z3?=
 =?utf-8?B?K3d0NjVTajdWbmdzcjhoVDdsV1ZmRGlvbUE0WXUycWVWeGcycWVkQnBhSHkw?=
 =?utf-8?B?NGRwRG93L0tUY3RpZDlEWXpicXpKZUl0N0lwVit0WTRRb3Z6OTUxWXZMbENs?=
 =?utf-8?Q?+GczSYX0G54xq+8W2n4l2k+eY?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2251f247-451e-483f-fb15-08dcc2c869df
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:35:20.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYCUTxOiWhK5JLuTMGDX5w6dmMTBAzC4nU/Pq9fTkcEzpy/883QJrap6dnKTUaS7ndArqQ7AomhHTEGDpJAMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4258
X-Proofpoint-GUID: 37dFgqULVddQsfdpjoSnB7Uylj0BEodU
X-Proofpoint-ORIG-GUID: 37dFgqULVddQsfdpjoSnB7Uylj0BEodU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_10,2024-08-22_01,2024-05-17_01

Hi,


> 
> This SoC device has PCIe ethernet MAC directly attached to an integrated
> ethernet switch using XGMII interface. Since device tree support is not
> available on this platform, a software node is created to enable
> fixed-link support using phylink driver.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> ---
>    .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 530 ++++++++++++++++++
>    1 file changed, 530 insertions(+)
>    create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
> new file mode 100644
> index 000000000000..4384f45e86b1
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
> @@ -0,0 +1,530 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 Broadcom Corporation
> + *
> + * PCI driver for ethernet interface of BCM8958X automotive switch chip.
> + *
> + * High level block diagram of the device.
> + *              +=================================+
> + *              |       Host CPU/Linux            |
> + *              +=================================+
> + *                         || PCIe
> + *                         ||
> + *         +==========================================+
> + *         |           +--------------+               |
> + *         |           | PCIE Endpoint|               |
> + *         |           | Ethernet     |               |
> + *         |           | Controller   |               |
> + *         |           |   DMA        |               |
> + *         |           +--------------+               |
> + *         |           |   MAC        |   BCM8958X    |
> + *         |           +--------------+   SoC         |
> + *         |               || XGMII                   |
> + *         |               ||                         |
> + *         |           +--------------+               |
> + *         |           | Ethernet     |               |
> + *         |           | switch       |               |
> + *         |           +--------------+               |
> + *         |             || || || ||                  |
> + *         +==========================================+
> + *                       || || || || More external interfaces
> + *
> + * This SoC device has PCIe ethernet MAC directly attached to an integrated
> + * ethernet switch using XGMII interface. Since devicetree support is not
> + * available on this platform, a software node is created to enable
> + * fixed-link support using phylink driver.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/dmi.h>
> +#include <linux/pci.h>
> +#include <linux/phy.h>
> +
> +#include "stmmac.h"
> +#include "dwxgmac2.h"
> +
> +#define PCI_DEVICE_ID_BROADCOM_BCM8958X		0xa00d
> +#define BRCM_MAX_MTU				1500
> +#define READ_POLL_DELAY_US			100
> +#define READ_POLL_TIMEOUT_US			10000
> +#define DWMAC_125MHZ				125000000
> +#define DWMAC_250MHZ				250000000
> +#define BRCM_XGMAC_NUM_VLAN_FILTERS		32
> +
> +/* TX and RX Queue counts */
> +#define BRCM_TX_Q_COUNT				4
> +#define BRCM_RX_Q_COUNT				4
> +
> +#define BRCM_XGMAC_DMA_TX_SIZE			1024
> +#define BRCM_XGMAC_DMA_RX_SIZE			1024
> +#define BRCM_XGMAC_BAR0_MASK			BIT(0)
> +
> +#define BRCM_XGMAC_IOMEM_MISC_REG_OFFSET	0x0
> +#define BRCM_XGMAC_IOMEM_MBOX_REG_OFFSET	0x1000
> +#define BRCM_XGMAC_IOMEM_CFG_REG_OFFSET		0x3000
> +
> +#define XGMAC_MMC_CTRL_RCHM_DISABLE		BIT(31)
> +#define XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW	0x940
> +#define XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE	0x00000001
> +#define XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH	0x944
> +#define XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE	0x88000000
> +
> +#define XGMAC_PCIE_MISC_MII_CTRL_OFFSET			0x4
> +#define XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX		BIT(0)
> +#define XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX		BIT(1)
> +#define XGMAC_PCIE_MISC_MII_CTRL_LINK_UP		BIT(2)
> +#define XGMAC_PCIE_MISC_PCIESS_CTRL_OFFSET		0x8
> +#define XGMAC_PCIE_MISC_PCIESS_CTRL_EN_MSI_MSIX		BIT(9)
> +#define XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET	0x90
> +#define XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE	0x00000001
> +#define XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET	0x94
> +#define XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE	0x88000000
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_OFFSET	0x700
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_VALUE	1
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_OFFSET	0x704
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_VALUE	1
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_OFFSET	0x728
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_VALUE	1
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_OFFSET	0x740
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_VALUE	0
> +
> +#define XGMAC_PCIE_MISC_FUNC_RESOURCES_PF0_OFFSET	0x804
> +
> +/* MSIX Vector map register starting offsets */
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_RX0_PF0_OFFSET	0x840
> +#define XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_TX0_PF0_OFFSET	0x890
> +#define BRCM_MAX_DMA_CHANNEL_PAIRS		4
> +
> +#define BRCM_XGMAC_MSI_MAC_VECTOR		0
> +#define BRCM_XGMAC_MSI_RX_VECTOR_START		9
> +#define BRCM_XGMAC_MSI_TX_VECTOR_START		10
> +
> +static char *fixed_link_node_name = "fixed-link";
> +
> +static const struct property_entry fixed_link_properties[] = {
> +	PROPERTY_ENTRY_U32("speed", 10000),
> +	PROPERTY_ENTRY_BOOL("full-duplex"),
> +	PROPERTY_ENTRY_BOOL("pause"),
> +	{ }
> +};
> +
> +struct brcm_priv_data {
> +	void __iomem *mbox_regs;    /* MBOX  Registers*/
> +	void __iomem *misc_regs;    /* MISC  Registers*/
> +	void __iomem *xgmac_regs;   /* XGMAC Registers*/
> +	struct software_node fixed_link_node;
> +};
> +
> +struct dwxgmac_brcm_pci_info {
> +	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> +};
> +
> +static void misc_iowrite(struct brcm_priv_data *brcm_priv,
> +			 u32 reg, u32 val)
> +{
> +	iowrite32(val, brcm_priv->misc_regs + reg);
> +}
> +
> +static struct mac_device_info *dwxgmac_brcm_setup(void *ppriv)
> +{
> +	struct stmmac_priv *priv = ppriv;
> +	struct mac_device_info *mac;
> +
> +	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
> +	if (!mac)
> +		return NULL;
> +	/** Update both Synopsys ID and DEVID **/
> +	priv->synopsys_id = DW25GMAC_CORE_4_00;
> +	priv->synopsys_dev_id = DW25GMAC_ID;
> +	priv->dma_conf.dma_tx_size = BRCM_XGMAC_DMA_TX_SIZE;
> +	priv->dma_conf.dma_rx_size = BRCM_XGMAC_DMA_RX_SIZE;
> +	priv->plat->rss_en = 1;
> +	mac->pcsr = priv->ioaddr;
> +	priv->dev->priv_flags |= IFF_UNICAST_FLT;
> +	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
> +	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
> +	mac->mcast_bits_log2 = 0;
> +
> +	if (mac->multicast_filter_bins)
> +		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
> +
> +	mac->link.duplex = DUPLEX_FULL;
> +	mac->link.caps = (MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10000FD);
> +	mac->link.xgmii.speed10000 = XGMAC_CONFIG_SS_10000;
> +	mac->link.speed_mask = XGMAC_CONFIG_SS_MASK;
> +
> +	return mac;
> +}
> +
> +static void dwxgmac_brcm_common_default_data(struct plat_stmmacenet_data *plat)
> +{
> +	int i;
> +
> +	plat->has_xgmac = 1;
> +	plat->force_sf_dma_mode = 1;
> +	plat->mac_port_sel_speed = SPEED_10000;
> +	plat->clk_ptp_rate = DWMAC_125MHZ;
> +	plat->clk_ref_rate = DWMAC_250MHZ;
> +	plat->setup = dwxgmac_brcm_setup;
> +	plat->tx_coe = 1;
> +	plat->rx_coe = 1;
> +	plat->max_speed = SPEED_10000;
> +
> +	/* Set default value for multicast hash bins */
> +	plat->multicast_filter_bins = HASH_TABLE_SIZE;
> +
> +	/* Set default value for unicast filter entries */
> +	plat->unicast_filter_entries = 1;
> +
> +	/* Set the maxmtu to device's default */
> +	plat->maxmtu = BRCM_MAX_MTU;
> +
> +	/* Set default number of RX and TX queues to use */
> +	plat->tx_queues_to_use = BRCM_TX_Q_COUNT;
> +	plat->rx_queues_to_use = BRCM_RX_Q_COUNT;
> +
> +	plat->tx_sched_algorithm = MTL_TX_ALGORITHM_SP;
> +	for (i = 0; i < plat->tx_queues_to_use; i++) {
> +		plat->tx_queues_cfg[i].use_prio = false;
> +		plat->tx_queues_cfg[i].prio = 0;
> +		plat->tx_queues_cfg[i].mode_to_use = MTL_QUEUE_AVB;
> +		plat->dma_cfg->hdma_cfg->tvdma_tc[i] = i;
> +		plat->dma_cfg->hdma_cfg->tpdma_tc[i] = i;
> +	}
> +
> +	plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
> +	for (i = 0; i < plat->rx_queues_to_use; i++) {
> +		plat->rx_queues_cfg[i].use_prio = false;
> +		plat->rx_queues_cfg[i].mode_to_use = MTL_QUEUE_AVB;
> +		plat->rx_queues_cfg[i].pkt_route = 0x0;
> +		plat->rx_queues_cfg[i].chan = i;
> +		plat->dma_cfg->hdma_cfg->rvdma_tc[i] = i;
> +		plat->dma_cfg->hdma_cfg->rpdma_tc[i] = i;
> +	}
> +}
> +
> +static int dwxgmac_brcm_default_data(struct pci_dev *pdev,
> +				     struct plat_stmmacenet_data *plat)
> +{
> +	/* Set common default data first */
> +	dwxgmac_brcm_common_default_data(plat);
> +
> +	plat->bus_id = 0;
> +	plat->phy_addr = 0;
> +	plat->phy_interface = PHY_INTERFACE_MODE_USXGMII;
> +
> +	plat->dma_cfg->pbl = 32;
> +	plat->dma_cfg->pblx8 = 0;
> +	plat->dma_cfg->aal = 0;
> +	plat->dma_cfg->eame = 1;
> +
> +	plat->axi->axi_wr_osr_lmt = 31;
> +	plat->axi->axi_rd_osr_lmt = 31;
> +	plat->axi->axi_fb = 0;
> +	plat->axi->axi_blen[0] = 4;
> +	plat->axi->axi_blen[1] = 8;
> +	plat->axi->axi_blen[2] = 16;
> +	plat->axi->axi_blen[3] = 32;
> +	plat->axi->axi_blen[4] = 64;
> +	plat->axi->axi_blen[5] = 128;
> +	plat->axi->axi_blen[6] = 256;
> +
> +	plat->msi_mac_vec = BRCM_XGMAC_MSI_MAC_VECTOR;
> +	plat->msi_rx_base_vec = BRCM_XGMAC_MSI_RX_VECTOR_START;
> +	plat->msi_tx_base_vec = BRCM_XGMAC_MSI_TX_VECTOR_START;
> +
> +	return 0;
> +}
> +
> +static struct dwxgmac_brcm_pci_info dwxgmac_brcm_pci_info = {
> +	.setup = dwxgmac_brcm_default_data,
> +};
> +
> +static int brcm_config_multi_msi(struct pci_dev *pdev,
> +				 struct plat_stmmacenet_data *plat,
> +				 struct stmmac_resources *res)
> +{
> +	int ret;
> +	int i;
nit: This can be merged into single line.
> +
> +	if (plat->msi_rx_base_vec >= STMMAC_MSI_VEC_MAX ||
> +	    plat->msi_tx_base_vec >= STMMAC_MSI_VEC_MAX) {
> +		dev_err(&pdev->dev, "%s: Invalid RX & TX vector defined\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	ret = pci_alloc_irq_vectors(pdev, 2, STMMAC_MSI_VEC_MAX,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "%s: multi MSI enablement failed\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	/* For RX MSI */
> +	for (i = 0; i < plat->rx_queues_to_use; i++)
> +		res->rx_irq[i] = pci_irq_vector(pdev,
> +						plat->msi_rx_base_vec + i * 2);
> +
> +	/* For TX MSI */
> +	for (i = 0; i < plat->tx_queues_to_use; i++)
> +		res->tx_irq[i] = pci_irq_vector(pdev,
> +						plat->msi_tx_base_vec + i * 2);
> +
> +	if (plat->msi_mac_vec < STMMAC_MSI_VEC_MAX)
> +		res->irq = pci_irq_vector(pdev, plat->msi_mac_vec);
> +
> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +	plat->flags |= STMMAC_FLAG_TSO_EN;
> +
> +	return 0;
> +}
> +
> +static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
> +				  const struct pci_device_id *id)
> +{
> +	struct dwxgmac_brcm_pci_info *info =
> +		(struct dwxgmac_brcm_pci_info *)id->driver_data;
> +	struct plat_stmmacenet_data *plat;
> +	struct brcm_priv_data *brcm_priv;
> +	struct stmmac_resources res;
> +	struct device *dev;
> +	int rx_offset;
> +	int tx_offset;
> +	int vector;
> +	int ret;
> +
> +	dev = &pdev->dev;
> +
> +	brcm_priv = devm_kzalloc(&pdev->dev, sizeof(*brcm_priv), GFP_KERNEL);
> +	if (!brcm_priv)
> +		return -ENOMEM;
> +
> +	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> +	if (!plat)
> +		return -ENOMEM;
> +
> +	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
> +				     GFP_KERNEL);
> +	if (!plat->dma_cfg)
> +		return -ENOMEM;
> +
> +	plat->dma_cfg->hdma_cfg = devm_kzalloc(&pdev->dev,
> +					       sizeof(*plat->dma_cfg->hdma_cfg),
> +					       GFP_KERNEL);
> +	if (!plat->dma_cfg->hdma_cfg)
> +		return -ENOMEM;
> +
> +	plat->axi = devm_kzalloc(&pdev->dev, sizeof(*plat->axi), GFP_KERNEL);
> +	if (!plat->axi)
> +		return -ENOMEM;
> +
> +	/* This device is directly attached to the switch chip internal to the
> +	 * SoC using XGMII interface. Since no MDIO is present, register
> +	 * fixed-link software_node to create phylink.
> +	 */
> +	plat->port_node = fwnode_create_software_node(NULL, NULL);
> +	brcm_priv->fixed_link_node.name = fixed_link_node_name;
> +	brcm_priv->fixed_link_node.properties = fixed_link_properties;
> +	brcm_priv->fixed_link_node.parent = to_software_node(plat->port_node);
> +	device_add_software_node(dev, &brcm_priv->fixed_link_node);
> +
> +	/* Disable D3COLD as our device does not support it */
> +	pci_d3cold_disable(pdev);
> +
> +	/* Enable PCI device */
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	/* Get the base address of device */
> +	ret = pcim_iomap_regions(pdev, BRCM_XGMAC_BAR0_MASK, pci_name(pdev));
> +	if (ret)
> +		goto err_disable_device;
> +	pci_set_master(pdev);
> +
> +	memset(&res, 0, sizeof(res));
> +	res.addr = pcim_iomap_table(pdev)[0];
> +	/* MISC Regs */
> +	brcm_priv->misc_regs = res.addr + BRCM_XGMAC_IOMEM_MISC_REG_OFFSET;
> +	/* MBOX Regs */
> +	brcm_priv->mbox_regs = res.addr + BRCM_XGMAC_IOMEM_MBOX_REG_OFFSET;
> +	/* XGMAC config Regs */
> +	res.addr += BRCM_XGMAC_IOMEM_CFG_REG_OFFSET;
> +	brcm_priv->xgmac_regs = res.addr;
> +
> +	plat->bsp_priv = brcm_priv;
> +
> +	/* Initialize all MSI vectors to invalid so that it can be set
> +	 * according to platform data settings below.
> +	 * Note: MSI vector takes value from 0 up to 31 (STMMAC_MSI_VEC_MAX)
> +	 */
> +	plat->msi_mac_vec = STMMAC_MSI_VEC_MAX;
> +	plat->msi_wol_vec = STMMAC_MSI_VEC_MAX;
> +	plat->msi_lpi_vec = STMMAC_MSI_VEC_MAX;
> +	plat->msi_sfty_ce_vec = STMMAC_MSI_VEC_MAX;
> +	plat->msi_sfty_ue_vec = STMMAC_MSI_VEC_MAX;
> +	plat->msi_rx_base_vec = STMMAC_MSI_VEC_MAX;
> +	plat->msi_tx_base_vec = STMMAC_MSI_VEC_MAX;
> +
> +	ret = info->setup(pdev, plat);
> +	if (ret)
> +		goto err_disable_device;
> +
> +	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW,
> +			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE);
> +	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH,
> +			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE);
> +
> +	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET,
> +		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE);
> +	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET,
> +		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE);
> +
> +	/* SBD Interrupt */
> +	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_OFFSET,
> +		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_VALUE);
> +	/* EP_DOORBELL Interrupt */
> +	misc_iowrite(brcm_priv,
> +		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_OFFSET,
> +		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_VALUE);
> +	/* EP_H0 Interrupt */
> +	misc_iowrite(brcm_priv,
> +		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_OFFSET,
> +		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_VALUE);
> +	/* EP_H1 Interrupt */
> +	misc_iowrite(brcm_priv,
> +		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_OFFSET,
> +		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_VALUE);
> +
> +	rx_offset = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_RX0_PF0_OFFSET;
> +	tx_offset = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_TX0_PF0_OFFSET;
> +	vector = BRCM_XGMAC_MSI_RX_VECTOR_START;
> +	for (int i = 0; i < BRCM_MAX_DMA_CHANNEL_PAIRS; i++) {
> +		/* RX Interrupt */
> +		misc_iowrite(brcm_priv, rx_offset, vector++);
> +		/* TX Interrupt */
> +		misc_iowrite(brcm_priv, tx_offset, vector++);
> +		rx_offset += 4;
> +		tx_offset += 4;
> +	}
> +
> +	/* Enable Switch Link */
> +	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MII_CTRL_OFFSET,
> +		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX |
> +		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX |
> +		     XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
> +	/* Enable MSI-X */
> +	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_PCIESS_CTRL_OFFSET,
> +		     XGMAC_PCIE_MISC_PCIESS_CTRL_EN_MSI_MSIX);
> +
> +	ret = brcm_config_multi_msi(pdev, plat, &res);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"%s: ERROR: failed to enable IRQ\n", __func__);
> +		goto err_disable_msi;
> +	}
> +
> +	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
> +	if (ret)
> +		goto err_disable_msi;
> +
> +	return ret;
> +
> +err_disable_msi:
> +	pci_free_irq_vectors(pdev);
> +err_disable_device:
> +	pci_disable_device(pdev);
Shouldn't pcim_iounmap_region be called here to unmap and release PCI BARs?
> +
> +	return ret;
> +}
> +
> +static void dwxgmac_brcm_software_node_remove(struct pci_dev *pdev)
> +{
> +	struct fwnode_handle *fwnode;
> +	struct stmmac_priv *priv;
> +	struct net_device *ndev;
> +	struct device *dev;
> +
> +	dev = &pdev->dev;
> +	ndev = dev_get_drvdata(dev);
> +	priv = netdev_priv(ndev);
> +	fwnode = priv->plat->port_node;
> +
> +	fwnode_remove_software_node(fwnode);
> +	device_remove_software_node(dev);
> +}
> +
> +static void dwxgmac_brcm_pci_remove(struct pci_dev *pdev)
> +{
> +	stmmac_dvr_remove(&pdev->dev);
> +	pci_free_irq_vectors(pdev);
> +	pcim_iounmap_regions(pdev, BRCM_XGMAC_BAR0_MASK);
> +	pci_clear_master(pdev);
> +	dwxgmac_brcm_software_node_remove(pdev);
> +}
> +
> +static int __maybe_unused dwxgmac_brcm_pci_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ret;
> +
> +	ret = stmmac_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_save_state(pdev);
> +	if (ret)
> +		return ret;
> +
> +	pci_disable_device(pdev);
> +	pci_wake_from_d3(pdev, true);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused dwxgmac_brcm_pci_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ret;
> +
> +	pci_restore_state(pdev);
> +	pci_set_power_state(pdev, PCI_D0);
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pdev);
> +
> +	return stmmac_resume(dev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(dwxgmac_brcm_pm_ops,
> +			 dwxgmac_brcm_pci_suspend,
> +			 dwxgmac_brcm_pci_resume);
> +
> +static const struct pci_device_id dwxgmac_brcm_id_table[] = {
> +	{ PCI_DEVICE_DATA(BROADCOM, BCM8958X, &dwxgmac_brcm_pci_info) },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(pci, dwxgmac_brcm_id_table);
> +
> +static struct pci_driver dwxgmac_brcm_pci_driver = {
> +	.name = "brcm-bcm8958x",
> +	.id_table = dwxgmac_brcm_id_table,
> +	.probe	= dwxgmac_brcm_pci_probe,
> +	.remove = dwxgmac_brcm_pci_remove,
> +	.driver = {
> +		.pm = &dwxgmac_brcm_pm_ops,
> +	},
> +};
> +
> +module_pci_driver(dwxgmac_brcm_pci_driver);
> +
> +MODULE_DESCRIPTION("Broadcom 10G Automotive Ethernet PCIe driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 
> 


