Return-Path: <bpf+bounces-62810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D4EAFEED0
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9073AACE0
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F220AF9C;
	Wed,  9 Jul 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXSmIGbb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vuNtU1U4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA535207A3A;
	Wed,  9 Jul 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078131; cv=fail; b=QLNisAXYW3eDdGF/KXIc0x2dZ/8ZZ+/paLDPGQ7D2IvKUd8psUJ1wQaKrPg3rpt1luSKaI+e8ugpFwEgBPXiXUrfJh0hCZw4l3UDe8FQRCfoFE3rBdWKUjGwPSEkfVLb8bMwWmOyxMUVP89r6Dg4y0/Uqi9nkoHaa74zHf8QpC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078131; c=relaxed/simple;
	bh=iKdoT90fAvG8UHGtv/qcHqpT1QWN0b3SDX5fVowvFQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g/wVCX9q+bEOABGio5e9hGrKwEBDTjOszmnoGkKzzfTg5AgcKQlJ7/yDLswG67E3ZBLME1ucp6SWiwg7JCAD3rpnOyn8dF1WfxPSiG9WmgNuu4d87ISOuKhVNCxBj9ZbVvQSPN4Ct2ExlVzY4s08sV6rfYGu1oKnnXMy3AeHhUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXSmIGbb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vuNtU1U4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569FqEuu010531;
	Wed, 9 Jul 2025 16:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=E3so29DUngQnf/s2899CEimynWYnz9miFNo4lhBALQI=; b=
	TXSmIGbbNzRacVMy24419DU9EicstGGjjACgXG0NEq7PYnRdkLkH7ni9NAszd6k2
	hJb8F0ErazzyqYCJu4VLq0/z9pjdglzzKoa6Zv/AkEpjF4E/+nSgDe4Z0hASirYg
	B4pnpdDlHBC+5zWCz8TxlilTTC9F/BHGS+AqH2UU+SYLdzZzLhf9nDG+X25lWenA
	P6E3MQzaTs/LbLK9V0GFwW3qw2LL3J243q4UUyecgCk4Gxc0AGtNHsYFVWl3ERF+
	w3mwAqMPSUa+cdj/lrkX74OG7GmRWMVQvqWwz+guZkyx/srjkO0zgkqrGvZ2Tzfw
	Ieg5N0libqUtfJZAp4ChLQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47suek02eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 16:21:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569GL3Rb014203;
	Wed, 9 Jul 2025 16:21:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbxtjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 16:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjq1dfabraVxJz7u168TjPvuA8RTwWj9GLiMV6y6snMna/bSciNkFdEtlUt0ALF4p10S+xPqgY1AaC9skBp/GIWWytNPId0eXHSu3vgdwR8muTkyme+dhySR+DHwIar+mnuuSG5mOqgmAvNUs+yTefn4tBUAQPXQSVF7kfdU7CheXOZT/CwghH6gCYbwjFylQKzWlGf37bXrZ2DpTU6XH0C23JYxja7QI2Wt8F+1Ora7hUFFmcjsO3VF29Wy8P+b/EQY5ARWMeVrFVgzdLUQd+rP+qbxpoOH6GC6IkviBC0s2K/l4KuO8SSRaL/FrvY+nTDCs+Qgmw/WJsRq5iiC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3so29DUngQnf/s2899CEimynWYnz9miFNo4lhBALQI=;
 b=Ix4SdUP1cnrFx3LlTtRi8CmUvuixx4xdwuJ8PLq7IrvzkuUSV7RQutmbDzI+zUDI+fYfYGeWOW/vtrMCXgVm6PWj0IdTumbAe6y+9dIR5/+oj9N8uvJKNInEMHjEgSl6lR29DYrX1GOA9J7U23TBYKoW5twEKvQTKzxre61D21WNuduMELkfPVOrS1xQNqZGRescYZ5qvE59iR13mHTecWxhV20BcfD9ViVD2OGfvi315Qn6qyGnVTm65xhDWa4N2CWyxLLhBa/Ce4AHfzS8vmHas0QtvKEk4f9fl+n1SUFjX0T9Ve5Ac5tkBQ2nHy2jDH8XVXsYsdxSsVyEongYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3so29DUngQnf/s2899CEimynWYnz9miFNo4lhBALQI=;
 b=vuNtU1U4s8DUYMX/SbcsPrg+u11AKYu2+OftT2sTMspoByGUbhBx7ubniyXlDYEAMfsb8ptuJvazSnxbSpSyIbHymENJBLDQVSrzJKU2KpvrHJ4ugpn+4TlgfbLuo6L9Qe7CjyPLW4BZISpLvK6Q7vzTDx6vBIsi7LWmOChoudg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Wed, 9 Jul 2025 16:21:50 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 16:21:50 +0000
Message-ID: <680c6507-af5f-41be-8823-c8c9dfceaf5f@oracle.com>
Date: Wed, 9 Jul 2025 17:21:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tests: add some tests validating skipped functions
 due to uncertain arg location
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bastien Curutchet <bastien.curutchet@bootlin.com>,
        ebpf@linuxfoundation.org
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
 <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
 <DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com>
 <d26bb031-e88c-4d4b-8ce2-439aedc7a4a8@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d26bb031-e88c-4d4b-8ce2-439aedc7a4a8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0128.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::25) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a55d1e-8ac6-45cf-721c-08ddbf04b54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUIrYVU3MUhqYk9qN2x3UGVRZEtEQ1ZIdjVjSWJGVGtXOE5Kczkza21sME9n?=
 =?utf-8?B?QU5yS3FSemtDUUZTL0srMWdoaGE3Qkw4NFpINVFXY09wdWkwaWlBbHhjWTUz?=
 =?utf-8?B?QnpZY0UwSkh3OERVWEVmRGJxRmw0UFlJM0dkZW9iNWptTnpGcVdHa3Vhd2dr?=
 =?utf-8?B?UjFYOUNiL3M0UVVzQnBDaHo2QU03dkhaTG5XNTM2UmtpRDFpQWI5TVhrSFRZ?=
 =?utf-8?B?TkQ1WUZNMzViVDc1RGxSVHJsNS9SQzA3SnkyVHF6dUxIVmo4YS9EaUt4Rmdm?=
 =?utf-8?B?dGJOV0RrU2JhamVyeXpQeFFWK08vSmxXSTVsZk5DWnpaSE5FaUVCQ3pORHNi?=
 =?utf-8?B?Q2lhMDRhTzRmY1A5aE4vekIxTVFNclFWUkhSNXpxYkJSbXZ3blV5ZDFkb2Nu?=
 =?utf-8?B?SHhHdlE4eFcwK3NwZUgxTVMxcnlCQmVtcEpTb21rYTZmblUvaTVGU3kveVJy?=
 =?utf-8?B?U1dEMXV6cXhDaTVaSWdRRkZ0S2M5SllRemNxMEJtMzgvODZEdHI5NTRsQ0pU?=
 =?utf-8?B?OEltN054VWlJVk9neXFrL0MxY1dIWWdZUmx4ZHVQTExPaWRsK01FbldDa0pQ?=
 =?utf-8?B?ckhId3EvMXlGU2RXc3NOVWZaT2xDU2t2blRURkFxK2pzSXNUR29QeWhqcHUx?=
 =?utf-8?B?Rnc5U201QytkTEk5ZUFCNHdxMkxwTzRqMmEvRUl0VGlKdHRHVDVDR3FUeU9W?=
 =?utf-8?B?cVZzZFFJMUhxamRzMkRHRmRpSkQ1dFQ4RytJQmxWM3ZrYjIwek5HZXcwU25j?=
 =?utf-8?B?a1hEUmliYkl6MFJKeHJRTGlCMEh3eE1vcVhCaVppUXVxSmZnVmkybFk1NUUv?=
 =?utf-8?B?bkd0YkRCTUcvVDJWanUvbUR1SmtHVlFlcEVpMmhacFM4TndJaVRUc0tGZ2hp?=
 =?utf-8?B?WnBLQmlDeUFhMVNmMW93U1Z4Vnd3QWh3YWROdHZXVjRNcGJTbjhVRnYzbTRq?=
 =?utf-8?B?eStoenZBSkNjWlRhREc0WFFYaXZZUWNJRTI1L3UvTmJZWkl1WFR5NHhxazVH?=
 =?utf-8?B?TzlEd3F4dzZ6Y0tCVEtnSE1HTmNYL0F0WFFaMlNQQlZBUmZDT3p0eUtMWUhx?=
 =?utf-8?B?WC9PM1JZZk5KZUFwaHMyQTRXelB4Y1MrMVhSV3NQWlF3ZWZrR2JJMHZvREQz?=
 =?utf-8?B?V2UrZURkbUozNUtMTEg0TisvbVVpT0pXVUhKSUcrajJod0NqTVptWnBXalM0?=
 =?utf-8?B?M3BXdW9yQ3JxZHpzZndWekdnYUg2THJ5UER1V1laTWtUTUoyOGdXS240SnhS?=
 =?utf-8?B?QWFYVHFwWkJacThZMGpYSXErUW40VnVIeE45eWhic1pSZFRnVmVCS2tLMlph?=
 =?utf-8?B?RUdaTlRlS0xpVy9WbDZMMElTUFpjbWxsWDM5Smt3M0lsVmhXbWQva3BXUTg2?=
 =?utf-8?B?bE9IZ0gvVlE1QTRTbTl5RG9mc0NKWWpYSlpKc00rb1NKUk43cnBYbThRNSt3?=
 =?utf-8?B?NmNKdWxMT1FaTjJ4S3dpdGErTXZpd240UmgwaVdtMDI0S00xbGF6QUQ2UVdM?=
 =?utf-8?B?SXcrOEx4TVVKSnQyUk9oLzMyMWRJbXoxWUZDTDlRTmJBeFEzVWhsUlpnamdn?=
 =?utf-8?B?ZTN6TkxsZmFZWWRMQURFZ2UrdGw4ellCaVpIb0o3TTJjbzFTT3pjNGprQ0lR?=
 =?utf-8?B?YVBMM0pSakxuTjM0ZUdzbHVLbkJXZkZidkVaK295TUlOSUxWRnM3NFpLNGFR?=
 =?utf-8?B?YkpvMXZWYjZxa3RuTEw2cDk5Ym5UYitlZ25RSWk4QW5vT1hBZXAwaitRZE4v?=
 =?utf-8?B?UVo2emE2QjY3aHdmTHZjbWJ5SkxjMmhXTXhQVW5wZG9XaWdHWFVwZHlHSTdJ?=
 =?utf-8?B?dzlVNW0va0VUT0FYZTFsUU5VTFpUNHFhbmtxWDFseHh3WFZwZWhsVnN0U2l2?=
 =?utf-8?Q?LaQvIrKXzrSOj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlFQdnoreGNoK3VtY1pQWkZxS2VZOGxJTVFnTzlqdkJRcEkyZlhQa1JUWDF4?=
 =?utf-8?B?ZmRWZmVWOGhiMGtSNGk3R1ZXKzQyN0lTR21jSDliamFUdE9yQWcyTFZGY2I5?=
 =?utf-8?B?dFl5disyZGpQMUZTUjlJQUdFeUMyTHY3aE4waHVIb0k3VDhqcXFEYkljanpT?=
 =?utf-8?B?VHgxRjBoY1VSSFJNU3NTcTVKN2ZLWEVJV04vcHRTN0hQWUpTNzJzUDRNbTY1?=
 =?utf-8?B?RmZXU29FOEpyZkQxTDFPdjgrM29vWmpXSzRrVTNRa2FXZWxYRlBGQ0x4Z0Fw?=
 =?utf-8?B?cHdCOXJib2V1TTRpYXJSc3FTZDZ1TW9pY1d3Q0ZQNWh6cnk0azZkSE5rMHhs?=
 =?utf-8?B?b05qZmZqbXhoaDFYQ0o5ajRaTVV2MFRzR21PY2RZcUNqM0I3ZjlHUTRrTUpx?=
 =?utf-8?B?K0xXUTVQZWRoK0w0YVRvdVFaK1EwZlByL1BMOU8xM2ZBT0tDeDFleVZrMmw2?=
 =?utf-8?B?Ny8zUkR5akRHcG9YeWp3ZkdRUE1uT0JaUkxOMDhyVjFkVEcyWlgrUWZ0Qzlt?=
 =?utf-8?B?TUY2VndRSjJBSWs3MGVTcjBqQ1FWMCtNSEFXRDg5UUJoQTJadUJjNGI3M1p5?=
 =?utf-8?B?SkZVU2s2NWJMSXJKQkVyTHhyb1NLcm9mQXp1WVF4MHVmVmtsWVo3S3MvUzYy?=
 =?utf-8?B?SVpvbjdhSkdRd1E0Znk0bm1yS3NBYnRzSnYxUlozWXR3d0dXOEJab0xoYnhw?=
 =?utf-8?B?eGZ2SnpybVM2b0QxbjJvTm8vYktRWkdKQzJ0a1U0U3AyWkFESEgwa3A3UTln?=
 =?utf-8?B?TEVNNGtOd2RFQjdITkUzT3FCckc4MUZWbzlDV0cycnd4a1M4SjVQOVR5SmV3?=
 =?utf-8?B?QmVuRHJKc2tKR0pwVnVKbVdUaEd4SkZRZ25VUlZrc1BXVkxJTFVsQk9KcGxO?=
 =?utf-8?B?YXYzci9jaEpaNmJUWHBQVlpnNldCdUlhWWhpWllvZTBJN0lseTN6L2Uxc2k2?=
 =?utf-8?B?MEJqeFZiS2JuaGNSK2RtT3U2KzJteEFBckdYSmpMMCtaMkk5TGNGWFhaY3RC?=
 =?utf-8?B?dEtXQW9CUnllWW5WbnpGU2hMUUEvblpmd1BQNzRtVVhpNXQ2Qno4R0FKb0Vt?=
 =?utf-8?B?QU1hRE1ZeUM0Tld4SVhxUEpNRnFhWHJmZXE5ZExBMURKZHZabHZkcElkMmNH?=
 =?utf-8?B?M1BWTDg0NzlCRWNISW5NRy9mQ0M1Vm5xTXJ4V2U0ZkpzR20xV2J6SVhGRStY?=
 =?utf-8?B?ZFZ0Q0cvYXpMRXg5QlhOV3hPZkNyR1pPQWJaNjBuUnhHWXh6WjVpTUZjY1Qy?=
 =?utf-8?B?U1lKQ0lDeW1SaVpFQWE1K0YrdXdBcjY5bTkxVnV5d0hlVitzWGFzOVp5aHZm?=
 =?utf-8?B?bHFFOGJjU1U5RVJQRTJGT1FtY2JhemdpNTBoV0lEZTBCNzM5WGlnNklkZmhY?=
 =?utf-8?B?dS9MR2NwZU5sOXJmbk5tYk5wbUlxMTlEa3VDdzd2Wlg3SzBPNHUwYVNhWGZn?=
 =?utf-8?B?Z2wzdExSV2FjdGoxb3NSN2ZDVU9YakFJaGV4amMrZit1SFBKbTdwYnZCSHJB?=
 =?utf-8?B?NGMyY0ZQQnBleVZXUGFHem92aEpLcXQwT1QyZk9IOVdNOGQ1QnhhOGl5WEk0?=
 =?utf-8?B?US85WGRrRzFyL0h2T2xkZ2h3VllhOUFna1VrUloycVV3WFJDb2czdnpXOVo1?=
 =?utf-8?B?MURTNHlpc01CTWJ1WDdVNGo3cjlaZXNmSlNxcW80SjRDZ25QYVhCazVnaStU?=
 =?utf-8?B?MEZXczU4d21heXJmemgvNnpudGFhY04rZjZYL3Q5a0c3OFRneG1sTkJ3TG1s?=
 =?utf-8?B?QUkxb1Y0SjJtSWszaGlseDRtT0k1c3Rmc0Yxa0tqRUJGMFhyYmpscnNLV2VN?=
 =?utf-8?B?TWlEckhITFphU25Za09sRFFjUUFlejExdVA4RWFMSXJ6ZkhQMlEvekZNUncy?=
 =?utf-8?B?eFN0bWwvQ01hQ0ZRK2NHdml1Q2U5SW5EUi8xdGFkM3Aza1lIaVU0RmJacy9G?=
 =?utf-8?B?NGxCejdZNEErSzhoNUVCV0lnY0xUcndjUVhpSithanpKWEF3R1dJMi9Xa1NX?=
 =?utf-8?B?ZnpkcTJQRi9NTUdpRDY3QzViQXBKTnQyMGNQcC9jcWVTMTUrd2liV2tmdWRB?=
 =?utf-8?B?ZnNlTDdRakdnR0YwUEVFdnBaVjhTMmYvTkNOZklnUzRPWEtvNmJ6UlJWS1R0?=
 =?utf-8?B?SmFXcHhXWDByeFJaUDJvWlpxZ2VYTmlHU1p0ZGVYM3ZNNmdpRmJOdThpa3ox?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mv3SbiG2RPqyx1MuzQ+yHQ0v+4AJ4og30knEv98tK+443fBkc3f8CinsDP1Bs1wwHzghlrYf4dITBY++INSlHy9mhjR/u4GFU5h7PZ3VPsxX411YaVYQBbGbjRGF698j0561i+ari24aZLeIc0Vu9cHzRP8O5KgALSGAb0/tFscA5NcqrfvtBPbXDU8JuqGmv8zi2UPOVjwcsCe6TAYlvFuj7mwvy6nK58VDSCpwS56dR/voEAWMDjGMyQjw8MY2jM7BezHY5+z79/cYD6Bu6r6ciMn+Jqfnroh8TuF8hVkNMFFDsQXm9Q+1gJmk9OSqYLOXIWRhCqfokI2sfWprXd1mgoB3m7QKbvLqN+s6fySlzdX3IPOki3riqJRGgX0nv3b1QHd+hreCOTUSsX9xIe6k48eKFzZfzhM2GSwoJGSew61w4dFp2UZV4VWbqEy2cPB2/2Ps6ARj8gvKuh58jd3IkyOvgD1ONdIIM/zofZoWN1L3QO01YVfA+CSOdY/KzuquXO2G6LX3II7wF/kfVZBkFyVIVAH82eEVJZlsKzqgy79Mfwr3PkGWWyVTYREabRfB8lLPfQQ4/Ipm34zI5gN7MUnuIxJqDciC5asX4P0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a55d1e-8ac6-45cf-721c-08ddbf04b54f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:21:50.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DOBQbcoDSQfZoNAWuBCh2u3pu5sj/1EOH6pw4pbdj6y9oBlRuBgqQxckdF73tGrfe0svOMpll9KmRWoLrnR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE0OCBTYWx0ZWRfX4HC9rinCgYI/ ferpoPUznRz9/42RpusQzSkuHjdf8Rmo2yF1ai28YNA1fH1J5F6h5nDvWHcMFfZp8bt5HgSKAfc TGqc1YfBDvpicJSdmSC1g8fSnQ0Yugxz3ajso9tevfaSLwJtW1pGcCshl9qefem/AAKTgbFz5cv
 XkRqFYwD9tTo0GnXo+6YWoDsMIQnxYt2KUkV7f3cl60r9dLpFEl16JPQH4+Mv7FtgSXOposn3aD L8vYAOfu6Qn4HN+C+8fkRrb5E5A7Qbp64SPHglQ0lrkW6zd9+IGm2w/6MjRB8RSKx8onDrVduv2 sQDatulcFEJikuiCZdA4OVtEGIobb+j3c0eL8zE1KrXJlrzqwDJfamjGgAlwwYXlgFJoP5q1Nsx
 wbosUZUHur09tQt3rQUKZ584sVZ8VrSTbqacSkANX4VJTPw9SRs3sM6f5VUYuP7s+vEuDnJM
X-Authority-Analysis: v=2.4 cv=ZLvXmW7b c=1 sm=1 tr=0 ts=686e9722 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=6gDWLzeyIwtyWPffrL4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 cc=ntf
 awl=host:13565
X-Proofpoint-ORIG-GUID: KKADULwfH5dEs_KE_AdYwx78Aiv1Kkbe
X-Proofpoint-GUID: KKADULwfH5dEs_KE_AdYwx78Aiv1Kkbe

On 07/07/2025 20:36, Ihor Solodrai wrote:
> On 7/7/25 7:14 AM, Alexis LothorÃ© wrote:
>> On Mon Jul 7, 2025 at 4:02 PM CEST, Alexis Lothoré (eBPF Foundation)
>> wrote:
>>> Add a small binary representing specific cases likely absent from
>>> standard vmlinux or kernel modules files. As a starter, the introduced
>>> binary exposes a few functions consuming structs passed by value, some
>>> passed by register, some passed on the stack:
>>>
>>>    int main(void);
>>>    int test_bin_func_struct_on_stack_ko(int, void *, char, short int,
>>> int, \
>>>      void *, char, short int, struct test_bin_struct_packed);
>>>    int test_bin_func_struct_on_stack_ok(int, void *, char, short int,
>>> int, \
>>>      void *, char, short int, struct test_bin_struct);
>>>    int test_bin_func_struct_ok(int, void *, char, struct
>>> test_bin_struct);
>>>    int test_bin_func_ok(int, void *, char, short int);
>>>
>>> Then enrich btf_functions.sh to make it perform the following steps:
>>> - build the binary
>>> - generate BTF info and pfunct listing, both with dwarf and the
>>>    generated BTF
>>> - check that any function encoded in BTF is found in DWARF
>>> - check that any function announced as skipped is indeed absent from BTF
>>> - check that any skipped function has been skipped due to uncertain
>>>    parameter location
>>>
>>> Example of the new test execution:
>>>    Encoding...Matched 4 functions exactly.
>>>    Ok
>>>    Validation of skipped function logic...
>>>    Skipped encoding 1 functions in BTF.
>>>    Ok
>>>    Validating skipped functions have uncertain parameter location...
>>>    pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument
>>
>> A word about this specific error: I may have missed it in the previous
>> iteration, but I systematically get this error when running the following
>> command:
>>    $ pahole -C test_bin_struct_packed tests/bin/test_bin
>>
>> I initially thought that it would be something related to the binary
>> being
>> a userspace program and not a kernel module, but I observe the following:
>> - the issue is observed even on a .ko file (tested on the previous series
>>    iteration with kmod.ko)
>> - the issue does not appear if there is no class filtering (ie the `-C`
>>    arg) provided to pahole
>> - the issue occurs as well with the packaged pahole version on my host
>> (v1.30)
>> - the struct layout is still displayed correctly despite the error
>>
>> A quick bisect shows that the error log has started appearing with
>> 59f5409f1357 ("dwarf_loader: Fix termination on BTF encoding error").
>> This
>> commit has "enforced" error propagation if dwfl_getmodules returns
>> something different than 0 (before, it was propagating an error only
>> if the
>> error code was negative, but dwfl_getmodules seems to be able to return
>> values > 0 as well). As is sound unrelated to this series, I pushed this
>> new revision anyway. [1] seems to hint that the issue is known, but in my
>> case I don't get any additional log about unhandled DWARF operation. The
>> issue is pretty repeatable on my side, feel free to ask for any
>> additional
>> detail or manipulation that could help.
> 
> I looked into this...
> 
> pahole_stealer may return LSK__STOP_LOADING in normal case, for example
> when a class filter is provided [1]:
> 
>     if (list_empty(&class_names)) {
> dump_and_stop:
>         ret = LSK__STOP_LOADING;
>     }
> 
> And in the dwarf_loader we abort (as with error) in case of
> LSK__STOP_LOADING [2]:
> 
>     if (cus__steal_now(dcus->cus, job->cu, dcus->conf) ==
> LSK__STOP_LOADING)
>         goto out_abort;
> 
> This was not an issue before 59f5409f1357 because of how errors were
> propagated to dwfl_getmodules(), as mentioned in the other thread.
> 
> I think a proper fix for this is differentiating two variants of
> LSK__STOP_LOADING: stop because of an error, and stop because there is
> nothing else to do. That would require a bit of refactoring.
> 
> Alan, Arnaldo, what do you think?
>

Would it suffice to treat LSK__STOP_LOADING as an error in the BTF
encoding case, and not otherwise? That's a bit of hack; ideally I
suppose we'd introduce LSK__ABORT (like DWARF_CB_ABORT) and use it for
all the failure modes, reserving LSK__STOP_LOADING for cases where we
are done processing rather than we met an error.

> [1] https://github.com/acmel/dwarves/blob/master/pahole.c#L3390-L3392
> [2] https://github.com/acmel/dwarves/blob/master/dwarf_loader.c#L3678-L3679
> 
>>
>> [1] https://lore.kernel.org/
>> dwarves/933e199997949c0ac8a71551830f1e6c98d8bff0@linux.dev/
>>>    Found 1 legitimately skipped function due to uncertain loc
>>>    Ok
>>>
>>> Signed-off-by: Alexis Lothoré (eBPF Foundation)
>>> <alexis.lothore@bootlin.com>
>>> ---
>>> Changes in v3:
>>> - bring a userspace binary instead of an OoT kernel module
>>> - remove test dependency to a kernel directory being provided
>>> - improve test dir detection
>>>
>>> Changes in v2:
>>> - new patch
>>> ---
>>>   tests/bin/Makefile     | 10 ++++++
>>>   tests/bin/test_bin.c   | 66 ++++++++++++++++++++++++++++++++++++
>>>   tests/btf_functions.sh | 91 +++++++++++++++++++++++++++++++++++++++
>>> +++++++++++
>>>   3 files changed, 167 insertions(+)
>>>
>>> diff --git a/tests/bin/Makefile b/tests/bin/Makefile
>>> new file mode 100644
>>> index
>>> 0000000000000000000000000000000000000000..70bcf57ac4744f30fe03ea12908e42c69390f14a
>>> --- /dev/null
>>> +++ b/tests/bin/Makefile
>>> @@ -0,0 +1,10 @@
>>> +CC=${CROSS_COMPILE}gcc
>>> +
>>> +test_bin: test_bin.c
>>> +    ${CC} $^ -Wall -Wextra -Werror -g -o $@
>>> +
>>> +clean:
>>> +    rm -rf test_bin
>>> +
>>> +.PHONY: clean
>>> +
>>> diff --git a/tests/bin/test_bin.c b/tests/bin/test_bin.c
>>> new file mode 100644
>>> index
>>> 0000000000000000000000000000000000000000..ca6a4852cc511243925db905e55e040519af9cfd
>>> --- /dev/null
>>> +++ b/tests/bin/test_bin.c
>>> @@ -0,0 +1,66 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#include <stdio.h>
>>> +
>>> +#define noinline __attribute__((noinline))
>>> +#define __packed __attribute__((__packed__))
>>> +
>>> +struct test_bin_struct {
>>> +    char a;
>>> +    short b;
>>> +    int c;
>>> +    unsigned long long d;
>>> +};
>>> +
>>> +struct test_bin_struct_packed {
>>> +    char a;
>>> +    short b;
>>> +    int c;
>>> +    unsigned long long d;
>>> +}__packed;
>>> +
>>> +int test_bin_func_ok(int a, void *b, char c, short d);
>>> +int test_bin_func_struct_ok(int a, void *b, char c, struct
>>> test_bin_struct d);
>>> +int test_bin_func_struct_on_stack_ok(int a, void *b, char c, short
>>> d, int e,
>>> +                                      void *f, char g, short h,
>>> +                                      struct test_bin_struct i);
>>> +int test_bin_func_struct_on_stack_ko(int a, void *b, char c, short
>>> d, int e,
>>> +                                      void *f, char g, short h,
>>> +                                      struct test_bin_struct_packed i);
>>> +
>>> +noinline int test_bin_func_ok(int a, void *b, char c, short d)
>>> +{
>>> +    return a + (long)b + c + d;
>>> +}
>>> +
>>> +noinline int test_bin_func_struct_ok(int a, void *b, char c,
>>> +                                      struct test_bin_struct d)
>>> +{
>>> +    return a + (long)b + c + d.a + d.b + d.c + d.d;
>>> +}
>>> +
>>> +noinline int test_bin_func_struct_on_stack_ok(int a, void *b, char
>>> c, short d,
>>> +                                               int e, void *f, char
>>> g, short h,
>>> +                                               struct
>>> test_bin_struct i)
>>> +{
>>> +    return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b +
>>> i.c + i.d;
>>> +}
>>> +
>>> +noinline int test_bin_func_struct_on_stack_ko(int a, void *b, char
>>> c, short d,
>>> +                                               int e, void *f, char
>>> g, short h,
>>> +                                               struct
>>> test_bin_struct_packed i)
>>> +{
>>> +    return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b +
>>> i.c + i.d;
>>> +}
>>> +
>>> +int main()
>>> +{
>>> +    struct test_bin_struct test;
>>> +    struct test_bin_struct_packed test_bis;
>>> +
>>> +    test_bin_func_ok(0, NULL, 0, 0);
>>> +    test_bin_func_struct_ok(0, NULL, 0, test);
>>> +    test_bin_func_struct_on_stack_ok(0, NULL, 0, 0, 0, NULL, 0, 0,
>>> test);
>>> +    test_bin_func_struct_on_stack_ko(0, NULL, 0, 0, 0, NULL, 0, 0,
>>> test_bis);
>>> +    return 0;
>>> +}
>>> +
>>> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
>>> index
>>> c92e5ae906f90badfede86eb530108894fbc8c93..fb62b0b56662bb2ae58f7adc0a022c400cba5e0f 100755
>>> --- a/tests/btf_functions.sh
>>> +++ b/tests/btf_functions.sh
>>> @@ -193,4 +193,95 @@ if [[ -n "$VERBOSE" ]]; then
>>>   fi
>>>   echo "Ok"
>>>   +# Some specific cases can not  be tested directly with a standard
>>> kernel.
>>> +# We can use the small binary in bin/ to test those cases, like packed
>>> +# structs passed on the stack.
>>> +
>>> +echo -n "Validation of BTF encoding corner cases with test_bin
>>> functions; this may take some time: "
>>> +
>>> +test -n "$VERBOSE" && printf "\nBuilding test_bin..."
>>> +tests_dir=$(realpath $(dirname $0))
>>> +make -C ${tests_dir}/bin
>>> +
>>> +test -n "$VERBOSE" && printf "\nEncoding..."
>>> +pahole --btf_features=default --lang_exclude=rust --
>>> btf_encode_detached=$outdir/test_bin.btf \
>>> +    --verbose ${tests_dir}/bin/test_bin | grep "skipping BTF
>>> encoding of function" \
>>> +    > ${outdir}/test_bin_skipped_fns
>>> +
>>> +funcs=$(pfunct --format_path=btf $outdir/test_bin.btd 2>/dev/null|sort)
>>> +pfunct --all --no_parm_names --format_path=dwarf bin/test_bin | \
>>> +    sort|uniq > $outdir/test_bin_dwarf.funcs
>>> +pfunct --all --no_parm_names --format_path=btf $outdir/test_bin.btf
>>> 2>/dev/null|\
>>> +    awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|
>>> uniq > $outdir/test_bin_btf.funcs
>>> +
>>> +exact=0
>>> +while IFS= read -r btf ; do
>>> +    # Matching process can be kept simpler as the tested binary is
>>> +    # specifically tailored for tests
>>> +    dwarf=$(grep -F "$btf" $outdir/test_bin_dwarf.funcs)
>>> +    if [[ "$btf" != "$dwarf" ]]; then
>>> +        echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
>>> +        fail
>>> +    else
>>> +        exact=$((exact+1))
>>> +    fi
>>> +done < $outdir/test_bin_btf.funcs
>>> +
>>> +if [[ -n "$VERBOSE" ]]; then
>>> +    echo "Matched $exact functions exactly."
>>> +    echo "Ok"
>>> +    echo "Validation of skipped function logic..."
>>> +fi
>>> +
>>> +skipped_cnt=$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}')
>>> +if [[ "$skipped_cnt" == "0" ]]; then
>>> +    echo "No skipped functions.  Done."
>>> +    exit 0
>>> +fi
>>> +
>>> +skipped_fns=$(awk '{print $1}' $outdir/test_bin_skipped_fns)
>>> +for s in $skipped_fns ; do
>>> +    # Ensure the skipped function are not in BTF
>>> +    inbtf=$(grep " $s(" $outdir/test_bin_btf.funcs)
>>> +    if [[ -n "$inbtf" ]]; then
>>> +        echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
>>> +        fail
>>> +    fi
>>> +done
>>> +
>>> +if [[ -n "$VERBOSE" ]]; then
>>> +    echo "Skipped encoding $skipped_cnt functions in BTF."
>>> +    echo "Ok"
>>> +    echo "Validating skipped functions have uncertain parameter
>>> location..."
>>> +fi
>>> +
>>> +uncertain_loc=$(awk '/due to uncertain parameter location/ { print
>>> $1 }' $outdir/test_bin_skipped_fns)
>>> +legitimate_skip=0
>>> +
>>> +for f in $uncertain_loc ; do
>>> +    # Extract parameters types
>>> +    raw_params=$(grep ${f} $outdir/test_bin_dwarf.funcs|sed -n 's/
>>> ^[^(]*(\([^)]*\)).*/\1/p')
>>> +    IFS=',' read -ra params <<< "${raw_params}"
>>> +    for param in "${params[@]}"
>>> +    do
>>> +        # Search any param that could be a struct
>>> +        struct_type=$(echo ${param}|grep -E '^struct [^*]' | sed -E
>>> 's/^struct //')
>>> +        if [ -n "${struct_type}" ]; then
>>> +            # Check with pahole if the struct is detected as
>>> +            # packed
>>> +            if pahole -F dwarf -C "${struct_type}" ${tests_dir}/bin/
>>> test_bin|tail -n 2|grep -q __packed__
>>> +            then
>>> +                legitimate_skip=$((legitimate_skip+1))
>>> +                continue 2
>>> +            fi
>>> +        fi
>>> +    done
>>> +    echo "ERROR: '${f}()' should not have been skipped; it has no
>>> parameter with uncertain location"
>>> +    fail
>>> +done
>>> +
>>> +if [[ -n "$VERBOSE" ]]; then
>>> +    echo "Found ${legitimate_skip} legitimately skipped function due
>>> to uncertain loc"
>>> +fi
>>> +echo "Ok"
>>>   exit 0
>>
>>
>>
>>
> 
> 


