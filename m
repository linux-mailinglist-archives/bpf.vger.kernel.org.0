Return-Path: <bpf+bounces-67149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15A5B3F68F
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 09:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA8217BBA9
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29562E6CB3;
	Tue,  2 Sep 2025 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HRIfzRi8"
X-Original-To: bpf@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012024.outbound.protection.outlook.com [52.101.126.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA6282E1;
	Tue,  2 Sep 2025 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797808; cv=fail; b=V6yiX6aKTTayCqnt3A9A83NHFkoAJKwdxb59l+FBJxsc0Az2k7GZz11pI9cFIsMmc5RFEkkfTuFCRQC/ejPkeCuWPFvBLxPMDSv7+eX/u9mZBMsQVJpU2Jk2gIPjHQlLc5FXmGmoZDxyLKLTNH1JWOQ6qq6YbSfGXDSXHLTrYOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797808; c=relaxed/simple;
	bh=cjnJEPvUgsY1aew+MrIgqDAqOa0eIavnzN5qw+InKdw=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=mWnbXzwuIFDyXnrfCHYwQteH5LeAhQNneOSwI9p41jCIlIO9jFFV6e8XUgx/axngn4k9jAstIpe11dbJb1Q2gYy0wyUOPmJZa1excb0U7XIU2B2scEDtHFEvysQBRLcQ0duHSDOrQ6sjNYlBf4rHe6KISJCqqeMYXJ/gWH8dwLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HRIfzRi8; arc=fail smtp.client-ip=52.101.126.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jzlm/ydII/sc4/NA0F2OOPlqIoY+Tf3MM2of3pytdQ6fwiMh4cjVD0qbd9UBNng+4Ea0yoKRCig5g5ovrVuOFokx61O1Zp40W0MbbmflMk3rMD9T2fDMUjUvVoF1JruFR4XhG8beY6F7JZ9Olx3FOtpLukeTTgu/nZUJ0bxO/w8eJdkwEZjf+F0UzjNN0V5bJSVFmswlO7P82Z6Z4lvJPs9VqlJCCqg8Pa4blydpXRtJkc7a/TV62qSyPkGQQ/7ROfXFxHOWVkIuG6QaBe2pq+66ggqm16dfEiaRPyMyNhuE0IxX9nQmKtnZHgFHXdHlYYSBmmaxHSHAB8MTLNNCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwB5oNHXSQ3qLGwdFxV6hPwf/mGh03uhBQWdRsUeT80=;
 b=zGOoZY7Xgn/IPrDYS64DO0fnhX7JVY8WtPBz40HYxUmPgeJlhYDKyMH6J2EKff8FkFjXxmUCqR/xqy5lSPaHWNqR1wNG4+vwwMjgcKkDMVwt9gHmG97nkh0Fj+81AQRh5JF0Gbut+71Pj3IoTCtYY2wMwH66GamoGaM18taGqJ2Z6vQZFtW3LzU7kfi8RRQKWUXFGxLExyAdsJFMVFqP1G8l+NPjyw9S5R91fJ1QSwJOiW4HHfEKYIgvs23rFCtrX2EVcTypYN2bP0h8Ama5NXb9bbgYVaLmxyqRBbFXciFv0/DRpRArU5WwkBktmigFG9or+WaewnIMEWtNpVW/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwB5oNHXSQ3qLGwdFxV6hPwf/mGh03uhBQWdRsUeT80=;
 b=HRIfzRi8CfiPfWDNDpH1+G6kdAaET9RNcsEGP9PCi2A1LNK0Xp1yTTUBbuE2zKh1ZdOGOuUSzW8/KXS6DWo2Oxoj6uBWjXLtwhwYep15k9O0SOMXH7P7zt0TzPn4QGbQQIBzQrpsnQpsC+MFn0Fuay80iYs49OC9yC0O1fKMGC/f7e649LA7EXjGqXPwSktDUROF0cYNZ5WY7v+5x2pwvpT96LI9Aagp+kHxVob/wkgSylK3ffYmLCKWy8vvlOhL6QWF2RPwroMgyPeR2jDHP0a+dJxOyLX+kheX06ITIq7AYRt1+KKSYE6vJPNdztsyxhuwEBU52+uK3qrutJWlIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by KUZPR06MB8026.apcprd06.prod.outlook.com (2603:1096:d10:4a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:23:22 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:23:22 +0000
Message-ID: <42c374fe-3ffb-4285-b982-add2a14fb65e@vivo.com>
Date: Tue, 2 Sep 2025 15:23:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V1 0/2] cpuidle, bpf: Introduce BPF-based extensible
 cpuidle policy via struct_ops
To: Song Liu <song@kernel.org>
References: <20250829101137.9507-1-yikai.lin@vivo.com>
 <CAPhsuW4PGfmFnJ-huFFELRQDJ7SpgWOLxYVBhRtsZnsLZhB6rw@mail.gmail.com>
 <37d6f4a3-89dc-464a-b5fe-dcfb3e7882cc@vivo.com>
 <CAPhsuW4h_-Vskzxjt19b_muULJ+wAfze6izswjVS4XN2daUTmg@mail.gmail.com>
From: "yikai.lin" <yikai.lin@vivo.com>
Cc: bpf@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <CAPhsuW4h_-Vskzxjt19b_muULJ+wAfze6izswjVS4XN2daUTmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|KUZPR06MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a53e45-0681-4a05-f840-08dde9f198cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1lMVXlhTFk2U3U4aC9oc1ZMTE9zZ0xlbWpWZk14WUVtaVpaYWoydnhkbXdF?=
 =?utf-8?B?L2Y4VWZLdXRZUEpaMlBDSjVWN0l3MDNQWmFoZXZBM1hibTNiSm1IK1pWeFZB?=
 =?utf-8?B?OXJOMnljeDgxcmpkM2FZNzZHdWJJSkw4T3B5T2dGK0xiNS9QemVLOUMzSE9C?=
 =?utf-8?B?S3hRcHo2dDA0WUpuSFdWUkRtRlRkWUNRRWhiV0hpb3o2Ym5BMmFvd2xwZVVp?=
 =?utf-8?B?M1N2Q1FURlJ1Mk9sL2IrMjZ5SUNQSHFhaFZMYnE0N3E0c3R2NllBdjAyc3Nu?=
 =?utf-8?B?SkRiTlZ4U1pSVCtlUm1Xdk1MUXRtSnNPYWNLOVF6dTlZdEFBSERuaWJyQ3c0?=
 =?utf-8?B?MGFINFpGUVB2czExR1p1VnY3RmEwcEFoVFl1SE5rRVBFeFJGS0NYV2hQNnpM?=
 =?utf-8?B?bjA1ZUlDRkZSZnFlSHExZHhHZW9kVFdYdWoxSkNBYktFODBOaHlwNTgrVjJL?=
 =?utf-8?B?UzNvK25yUEpJQjVOVlNjQm55VTI0bk50ZHFBQWl5Q000TXBjM2J5ZnhaUG5V?=
 =?utf-8?B?VkFVdnBwTUxacXRwbVBKMXhaN1BzclllSFVUeGxZMDlUc2NxV013bXdqS2Y0?=
 =?utf-8?B?a09WaHZEb2VGTE8yUkwwMVhxbW1YWURDNHZ2RGFwN2dudXhTR1UyeFZ6TFNk?=
 =?utf-8?B?aEx6TVZ0OFVZWDNvek90dGZaNTY5dEQwWlpmTXpBb3pDbFRNdjVhd1hyczh4?=
 =?utf-8?B?VHZOWFVtdzh3Ni8zRjFtYjhYK3N6UEZibmtmNXdaQ2VxbGR3T0pJclloZ01j?=
 =?utf-8?B?VmRLREhEM3F6OW5rZmF3VUdGUFlobmxTeUtuclBVWnY1RU5sN3h0bFdqWGlH?=
 =?utf-8?B?M29CcDlWL2FodzVFOVAwRitnVUZpbXh6am5zMXBOMFUyVFJsUW83UUdHZEpl?=
 =?utf-8?B?dzlJaHhXSVphTUJ0VXJnWjJCVWZZQXpQOGZsbisxSEdQcnVya0FBUFV2ZTZP?=
 =?utf-8?B?Y3VRaXFKb2thb2ordmxkNHBxK2dmMlA3ZExTRUxacTZIK1JDcVcyVEtSYTBZ?=
 =?utf-8?B?SkNJRnVZcnJ5cXlDSFhZSkE3Sys0S3ZvS3lKWkxXRVVQVnJoc2RYQlpBYnJa?=
 =?utf-8?B?bkdxSWFrUHdaOHZaMk9RMG4yTlRiMU1pZHIzNUw2ZVZYTkJISksxRzN5b2pT?=
 =?utf-8?B?dzZGRkRrODhsWG0xUUc3dSs0UHZBUEt4NTRGL2tMM2U2MVBkc0Fnelo5QWRP?=
 =?utf-8?B?Q3hsTm5CeGFmR3A3Y3lBU2hyOGIrUVVMMjNVcyswejFQYm0vMzVHZzlqc3ND?=
 =?utf-8?B?dm9qSHlHdEJSa042bmxXRlJ5bmRBYU1EWTAzYy9kcjh0OWdjQzdWRWlaSFNU?=
 =?utf-8?B?L0pLZ0xueGwxQXlKOS9BMGJyOUxBaCtEcldmb2djV0dGKzVxMWVVclY2UEQr?=
 =?utf-8?B?Ky9vK3RaN05YNFl4dSthYkVGb295U2plbnZBWEVrVWQrcmdHczBPdHdoQ1NG?=
 =?utf-8?B?dVlWdkE3dW04ZFpNaWd5Sk85R2pUZUZPSCs3QzRJRjFEemRzVkl3TWRnSCt3?=
 =?utf-8?B?bktibDBSdWRtdXhjR2p3RWpkMnFBMTNPQUpMaE80a0pNbFdYcDluM2I2ZjEw?=
 =?utf-8?B?SjQ5K3pUVzhhSTJkQ08xaVJQcFVlVkJwZGhqeHlOc0ZONmVKbjFjYnlvejA3?=
 =?utf-8?B?b3lxeTMvRElMRHV5NTVpRU41K0JrVEk5dG9IMUVwYUdsUy85VTgwVnBBeDB2?=
 =?utf-8?B?TUhUTHUreFFFdkdkancxb3V1VFJaR3M3M1BmVGFZNVJLQ3lJdEEyOG9CNklK?=
 =?utf-8?B?NVJyb3Zxc05md29GblNCNzVLeWpRZmZESm9icFp1VXFaVldRR3l4WmdEK3Nt?=
 =?utf-8?B?K0EzQjBOOE9EOUd0MVdEVVpjM1I3WGMvaElYS0tjWCtJSnBmRW02MEtHWVlR?=
 =?utf-8?B?ZERybEtYektMWWFKVGJ0UHFCSG9WN3hBcktMVVFydjVvZUJEcmk4STdYbTc5?=
 =?utf-8?Q?GMy9mFvUSJI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtKYTRlZDlEZmZEOXhidWl1UDRDdm1CaVp5cUxHS3dNdnFZTTNWQTRRTFhB?=
 =?utf-8?B?R3M5QzNsN3VMblF3UVp3eXk2ZHVQZS9iUlRpQWZtVXJjMCttSHJPZjFWOVZ3?=
 =?utf-8?B?RWlneUJWS1dtMjJLVmpZOWhkRE0zbFN2eUVOVm9zUmFvbjNSSmRGdmhSdSsr?=
 =?utf-8?B?U2pvc2xoQ3N3bWhHV2c5K3dleGQ0SW1Bd3FTYklCZThFb1ViWUVyazM2bFVU?=
 =?utf-8?B?SlhSN2xvWWhkK0VHd0xrWmhVWnE0eE5PdnVWenZBVE9lS2xGUGxnRWpiaXlv?=
 =?utf-8?B?NzJpNXFqMUxudkxJWGNsVUhWQ1lUY3FJdW80d2MzeUFmQlZab1ZGdlpkZ3dy?=
 =?utf-8?B?UnJmalBPK1g0b3U4OFpwdm5LYVpON2NYRWxkSHZhTDdKTFhOelJKMFAzWlJO?=
 =?utf-8?B?ZlVxSHREQmszcG5zQ2xXa2RmMjZqdmlCaGNaQzRhWkUveENPaUJyWTNNSmhW?=
 =?utf-8?B?Ymc3QnNFQTZPbS9ZTTA5THZsNUM4OHZmZFdPdkFXQU1jYmljSVpvbUhWVDI5?=
 =?utf-8?B?ZXhDVlJCZ2hncGxBbDk1aGVnR28rSCtGc01CVGg3aXdzSzk5a2tYU1h3Q2xH?=
 =?utf-8?B?TnFCV3pXN3lXYlNzYlJYL0h0MzhFWmpNTnluMFgxcWNzYUVVbGZlSTR6OUF2?=
 =?utf-8?B?djFPMnRrL3BLWEJJcUk0bnVsZkNEb0c1WDI4THc5N0pmNElMa1BQdzJqOVhr?=
 =?utf-8?B?QkJRRmNVdWROa2NZSTRuVHlQRUZRbCtpaFNjY0tzRXlGQUFuSHJrS0JyQnh6?=
 =?utf-8?B?UG1BRVU4UDJ5ZlA2ZnlaYlZLb1JzSE5STmVlaytXTlg5cU9WSTNiYnc4UVM0?=
 =?utf-8?B?SjlvZHpOcmV3ejZBVlk2SnhmbDR2K2ZkbFZkR01vSXhGOHlmYW5ObXhzYlBG?=
 =?utf-8?B?NDRpU1pjYnBtZ1BTVTcxSExjdU5NWkQwRWFnMUZ6cFE0aTdUMFdxRCt3SGdM?=
 =?utf-8?B?dzlnS3BpNGd4QXkrcitpWlN6RnR3VkhFMmhvTkNycnhzQytuMDIraXBwOUp5?=
 =?utf-8?B?ZzJrVkZ5Mm51dGxyL09uaFhLdWFhY1FVK01EUk5DQ3JXYW4wNk1wTWhlc1lz?=
 =?utf-8?B?OVgwRHY3VFhWWEx4d0pBSklHNC90WDIvNXhHSDJoQzc5SGViQnpXM3ppSURy?=
 =?utf-8?B?Z0cxZFpwSkdEMjNBTkVkT3JJNERzdlhYc2F2S2hmVXJpSGpjVmQvVHZFME9v?=
 =?utf-8?B?aHFhL0hNRXg3VWdLKzVrNE42bi9UVitjWUx5T0JZejNFV2t5eXE1UnEzMmVP?=
 =?utf-8?B?WHdBU2doVEdNVVBacy8vc3hSWkZTQ0lLSDNIZ2lZdisyNWlYb1VyTUhVRkc1?=
 =?utf-8?B?STlYbis5Nmt1SUFvU3B2QWlrdHdtSTUyNlJTWHdJNzBscGlJVkQreEtyc3hW?=
 =?utf-8?B?eWVsNnVTR0pxOFN0MlBrL1lreTFtZC9pZ1d3bUhneU94SDNOUW1iVm5WTDVo?=
 =?utf-8?B?eG02UVRvSjkyNHQ0dUlFbWlGQ0JkVFdQZ2xnWTNZSVc4TmgyVmFaZnhUcDhF?=
 =?utf-8?B?K3VjN0ZWR01lNU13SklGT3NLdzV1NmhRNUErT1ZOd2QvSG9ybkI5Z2lUV3d1?=
 =?utf-8?B?a3dLYXdldm1waU5MRnpqMU9lUE03bTd5dTF0NWtQcHZSSkpJL3FoazVoa2lx?=
 =?utf-8?B?bjcyUmcyVWt5WW1kZnM2cXRjWFhJOW15VXJoTnN1b0JMM3ppRU81SGFpRHQy?=
 =?utf-8?B?a3YrMlZTS0JMOE83U1l3RjZPcVRId1c4dnRhRHhkTHJOYzkwT3lvMXN2T092?=
 =?utf-8?B?MUhZUkJWRyswVENqZ0Noblg0UVNnamxjcTVKNTNDNFhJdFBaa3EvZnJLekpW?=
 =?utf-8?B?TWFPeUtnK043ZGFPczQ0a1BoeGw2TGM2WTlldTBNdnRGN0FxK1VDS0pncHlL?=
 =?utf-8?B?YUJpdUpFWXF3NnFrWkRnUXJHa3l1NmUwV0krazBzMWhCSnFScmZ1THVhUUEv?=
 =?utf-8?B?ZHA2aGc4OFM3VS9ReWdHdGJNSCtYSWNmOVA4Q1lDV0ZuWm8vdnA1dGRrZXIw?=
 =?utf-8?B?bWcrc1J4K1I2aFF4WHhnMDFNRzdTZEc2RXh1dmJqQ2ZxUjh0cGVaeG5hNTRq?=
 =?utf-8?B?cGdNWTkzdVdhS3l3dFhpd1dKYUxaWk56VmMvN01iWnNUTWllZndGZUZCYVZS?=
 =?utf-8?Q?MvYSoTGXTLhnYPiErukWfmQ//?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a53e45-0681-4a05-f840-08dde9f198cf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:23:21.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIztfsQi7LlDFOUWHA4xeinm8tP21+TYJ1+b8fda3OmIVS/KZ2wRHHPvm2BAaWPCtBj+kFVkI/LESx3R2LyEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8026



On 9/2/2025 1:51 AM, Song Liu wrote:
> On Sun, Aug 31, 2025 at 11:59 PM yikai.lin <yikai.lin@vivo.com> wrote:
> [...]
>> Thanks very much for your comments.
>> The cpuidle governor framework is as follows,
>> and I will include it in the next V2 version.
>>    ----------------------------------------------------------
>>                   Scheduler Core
>>    ----------------------------------------------------------
>>                       |
>>                       v
>>    ----------------------------------------------------------
>> | FAIR Class | EXT Class |           IDLE Class           |
>>    ----------------------------------------------------------
>> |            |           |              |
>> |            |           |              v
>> |            |           |      ------------------------
>> |            |           |          enter_cpu_idle()
>> |            |           |      ------------------------
>> |            |           |              |
>> |            |           |              v
>> |            |           |   ------------------------------
>> |            |           |       | CPUIDLE Governor |
>> |            |           |   ------------------------------
>> |            |           |     |            |           |
>> |            |           |     v            v           v
>> |            |           |-----------------------------------
>> |            |           | default   | |   other  | | BPF ext  |
>> |            |           | Governor  | | Governor | | Governor |
>> |            |           |-----------------------------------
>> |            |           |     |            |           |
>> |            |           |     v            v           v
>> |            |           |-------------------------------------
>> |            |           |           select idle state
>> |            |           |-------------------------------------> 1. It is not clear to me why a BPF based solution is needed here. Can
>>>     we achieve similar benefits with a knob and some userspace daemon?
>>>
>> Each time the system switches to the idle class, it requires a governor policy to select the correct idle state.
>> Currently, we can only switch governor policies through sysfs nodes, as shown below:
>>     / # ls /sys/devices/system/cpu/cpuidle/
>>     available_governors  current_driver  current_governor  current_governor_ro
>>     / # cat /sys/devices/system/cpu/cpuidle/available_governors
>>     menu teo qcom-cpu-lpm   《===Here we can switch governor policy by echo this node.
>> However, it is not possible to change the implementation of this policy through user interfaces.
> 
> It is still not clear to me why we need this feature in BPF. From the
> overview, we need two different governors for two different scenarios,
> which can be achieved with a much simpler interface.
> 
Thanks for your comments.

Below is a comparison of traditional governor methods
with a BPF-based approach for dynamic optimization of the cpuidle governor:

1.Agile Iteration
-Traditional:
   Governor policies require being predetermined and statically embedded before kernel compilation.
-BPF:
   Allows dynamic policy iteration based on real-time market user feedback
   User-space components can be updated via cloud deployment,
   eliminating the need for kernel modifications, recompilation, or reboots.
   It is very convenient for mobile device updates.

2.Dynamic Fine-Tuning
-Traditional:
  Involves replacing the entire governor, which is less granular.
-BPF:
  Allows granular tuning of governor parameters.
-Examples:
  --Screen-off music playback: dynamically enable the "expect_deeper" flag for deeper idle states.
  --Gaming scenarios: Allows idle strategy parameters adjustments via user-space signals
    (e.g., FPS, charging state) – metrics often opaque to the kernel.

So, by exposing tunable parameters through BPF maps,
user-space applications could make more run-time parameters adjustments, enhancing precision for specific scenarios.

Conclusion
----------
This approach aims to preserve the common logic of existing Linux governors
while adding flexibility for scenario-specific optimizations on certain SoC platforms or by ODMs.

Welcome any additional insights you might have on this.

> Thanks,
> SongThanks,
yikai


