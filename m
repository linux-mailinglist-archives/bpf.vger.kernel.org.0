Return-Path: <bpf+bounces-56707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77703A9CE6F
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6620F1BA3D7E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805A1A83F5;
	Fri, 25 Apr 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lYUrATCr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vMrxlUvt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17186348;
	Fri, 25 Apr 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599446; cv=fail; b=MrFwPJXBgYDPXJJx27lE7rHzpCRxNyQZCN7mwVn5G9YHhSss/+HB2VpBDK+J7onDhyDHJgGDvj5asOuhyaeynRFrg2pNuFHgggEHPvAFDw7bkk/gk+N8H2LjotqAkvfzxs7aI2tHjpvke9yprUGqm31Hdifvz5kXMGvFHcZmpZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599446; c=relaxed/simple;
	bh=iqxF0NQ7Oz4LZNyL/un64mFxZL0henFoFJDi+/lgBFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cCcgbFX096RhpwvD3hQuMtQwkq+FdMUQTV2Sl3iVhZu3MSJOOaDREzKhRaF5AWKCtwCsymI77+mh8n1Jx304OS9MELZm7LiNIB1TZqPXyr2fibHGhfnhN9RrtuWk/VQVF5wyqPysXKQ9ug4POXcSDTFQ45x9SLGzqTmjcyShj64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lYUrATCr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vMrxlUvt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFqVIR008419;
	Fri, 25 Apr 2025 16:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UY1AaVfRRKOX/Ei5WsdK3I4MAQdcgumJsxe7p27YpIc=; b=
	lYUrATCrTIcg4XAiFzAaDk/XE9Xnrg3fzBzlMhcFjvfTCrgZSW7qKISe/AgJs1Yb
	72hW49b5/I09Ec+tryUQnk30rv00om31rLVLT2I/Sus06v3QPok8vZI2GGXjPLfK
	M6+bN9o1zFYTGW/asJOZ6wjsEu3swmSMH5ChbCkq+py/utkul+hy00Fu5dWJWNHC
	yfUrRTcg+XoYZQziGuwkqWmbqpWT+hrgJUU0shLXizgWiLx/lrDw1yPUN0oXJ/vr
	Wz1NnFGUtpBwEssASOdgH2HkEWp4oiJNAiwJYJmOc1nE7xJpZZp453Lj/DPNhHc4
	aS4vdpDAj/e6twZ9c2V/Ew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468d45r980-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:43:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFsYS4017300;
	Fri, 25 Apr 2025 16:43:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvj4bn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:43:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrdl9rzggn2G8KsCsmLbE5bCHHBRufeFcNa65ZcOM1JIIbpEvnEWp+syXZdiK+VSlXWhrEfajP/7n0uFW6dFn+SU49hzUJ7tYxODjlpvWfiPoKLF/sHKFw8rvSCMjZLfDNeIey+dYDhdV2DxB2IdalL+iJYRjvnSN6E5O5clP3UOJKsKn8Bph0HoOn6PiieTE9XgU8Oy2+w/8ToojsSuGpsUBGpVvM4WZyksxqxRMV7uL0F9+Upn3IJqWPqydPYtBEhRRsWg/MUDOmNOPWTRjMhz6JQ12FxwXCBpDiYyNTX/KAcrM5CSLhlbDFW0kMA3QZ6Z/6dZafNtd1SvsB6ezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY1AaVfRRKOX/Ei5WsdK3I4MAQdcgumJsxe7p27YpIc=;
 b=XO6RIVhYFfrcPR81wLwtzWanu4Pq9eioXkql8biTC1pkzcOYIPyBDfUmZz+feSBp61i2pX2y0Vee+ByZgdHfDef0G4Rzh775HMljosJqRlGvyyvq+p8SPLV+59yuV/G6sTxvVhxVlus5ldoMp9hsP4KxvFD9eJ5FdRTfRsW9If//QGoW3vFMSdavr+zTi3n7AHpv6eg8ZwuPxk5yDHcX4ZrBiR055S5NW8JMgW5adM5KeWM2NYFVywud2PhNUofuQYH+4Hx1XMFaXVML77Ha7MyfKaEOuQdWHs57NA5K4HNF6GmbsDHvy+TpXjkIAgRwev5AXGRgnnOdpXDex/jS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY1AaVfRRKOX/Ei5WsdK3I4MAQdcgumJsxe7p27YpIc=;
 b=vMrxlUvtt2A+xJsQgjO9E4CrjxMapH+QubTtnKIYuM7IxP/Z7/oLZnsNJGKP2DAPuDYj7VELzXEyENDAHLP7ulfAkuB91h9NhdRog7BFZuR9dG4XvDmRhs1FzA7KdnSDvKYE9nSOeeEqpHQURdNfFz9fMgmb9vgdv1WpmZoi1+E=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA3PR10MB8162.namprd10.prod.outlook.com (2603:10b6:208:513::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 16:43:40 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:43:40 +0000
Message-ID: <112a01c8-4ff6-445e-acc6-5a493a4862b0@oracle.com>
Date: Fri, 25 Apr 2025 17:43:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: die__process: DW_TAG_compile_unit, DW_TAG_type_unit,
 DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0) @
 115a4a9!
To: Paul Menzel <pmenzel@molgen.mpg.de>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org
References: <2b3986f2-7152-4c11-957a-b08641dfe132@molgen.mpg.de>
 <03a0ad73-325c-4d6d-ba32-13a4938dc4cf@oracle.com>
 <273137fb-74c3-4c74-b228-099cde3869e7@molgen.mpg.de>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <273137fb-74c3-4c74-b228-099cde3869e7@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0095.eurprd05.prod.outlook.com
 (2603:10a6:208:136::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA3PR10MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: bd90f6b2-b3b7-4c98-1589-08dd8418558f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmx3SHVaY1VvT0E4dWk4SmY4azFUZlkzR295RjU5QytlWVNUU2Y4UWJaeVlD?=
 =?utf-8?B?bElHZFRNOTVlTUdlNkd2Ymd4OFV3eFRWU3RLUDBPdkx6T241MjJ1MWJkUi9t?=
 =?utf-8?B?NmRwZE80aTNQSUtpd3VGS0UwMXQzazBVMmJaUHA2ZXhTcXRnRVpWYThZam5w?=
 =?utf-8?B?SDNLNzlTSk1EMGV3aWFkY1FDWHdCTTkxMjlCR2ltc09veE40RmVXNml1NXli?=
 =?utf-8?B?dUZ1SUxQR0VJT3F0aDNhTlhqL1B2akc3NU8xeGI5cEM1S3FKR3g2ZGJtSGNx?=
 =?utf-8?B?YTZFeEUzTDVQOGV0T1B6WWp1TlRTK09EYkZWWHpYQmpDcHNscXVaMGQzRnEv?=
 =?utf-8?B?OFFlMkh5UDlleUNyVzFBajczYjExaWsyMi9NWXphMndEYTdSTi9pbVdvMGVr?=
 =?utf-8?B?ZGZ0cW5YRjlaSHU1YVdQVFVuUFpEakk4VG82QlM3TXdDL1RYMktkTUdDSitP?=
 =?utf-8?B?NURGa0tDallaZHNDR0JTUU1VNE8zV04zT243ZG5ieEpKVjFZRU5PVE10ampG?=
 =?utf-8?B?WEdCNURFeDEwYjllNEhwNjlxaC9JZDcyeW1YWVcwaGE4WWRNR1JNWEpHb0VC?=
 =?utf-8?B?VWdsMVdZRjJRMzg5VHNXOE5tTHVVeUV1SUdIZzhRN2l5bU45cm13QkVGZm5D?=
 =?utf-8?B?dHBZK2o0ZDNGTFFIYW1iSVdIaDcrbzBjdjdzRmNvZ2gxUjdZWWY5bzcxbjdQ?=
 =?utf-8?B?VnNHTldvZGgvWlJ1ZnZqaDNPYlFLSldMNUxTUHE4SFpnN3ZoSUVqZDk5SUVX?=
 =?utf-8?B?c3pUTnBibW12WXhQblNlV2dqbUlnQ1BGbjdqREVZYWRQNFpTOXR0bklmN0ts?=
 =?utf-8?B?cEhjTS9GeGZ3ZjA5MitKcGVkUGVDdm9WOUE4bldVMzZwYkFISjBqTE5ySlBp?=
 =?utf-8?B?Q2RjU1R6RkVldlhhbnJOSy9LYjI0anZaVmFwK3lranNkR2tHQmdzUUlqYnNV?=
 =?utf-8?B?TEd0TmVEbkZWeHNjdFQrbXFqNGkrV2VrSnpXS0hWVDB6cWhmVmUzTlBrUXE5?=
 =?utf-8?B?enBOZXIxSFN4YzBCK2FTdmNkcHRhdVdvQXZJdEQ5eEp0NTlQRWYrT0RKQWFJ?=
 =?utf-8?B?VzBOLy9TdFdUZ2g2TjhIc0FOWTkva3BVU21JV1hzLzRjWDJPRHZYTXFJMnBP?=
 =?utf-8?B?ZHBOS0ZXWGs5dDVMTHg2dk1DSnVmcTlZbWI4bzRub3crOXEzV0RDdFhDZ2RY?=
 =?utf-8?B?czViOTQxT3lQL2tqa3d6c2RGS0cvUEVkd1hHTFNsazkxNFk0NzVhcWhndEdP?=
 =?utf-8?B?RVRJTEVZc3VVZEFXVCtzZjkvM2N6RnFHaUFlNkdxNjB1VmwrMWRnUlo2UEhM?=
 =?utf-8?B?UDZUVnRJWkhEc1V0eXhSTDFiMngzRU0ydUp6S01UN2JRbzVUSnRNaEJUTG9q?=
 =?utf-8?B?eU5RdDBWSHc1emFqRmcyVDdTRHJXM2VzeTJaY2ZoNVBwekxBbTd0bGloYzkw?=
 =?utf-8?B?dFRsczJjb1NZY0QvZWNKMW54MldlZzYzdTFqYnNsWkljRjlDVnJxdGhNQjFU?=
 =?utf-8?B?ZjNYc2U1YlJrcEh4SGlINm4vbytXcmdleUtiVGhGYTloUmtPdnIvdloyRC9Z?=
 =?utf-8?B?WWpsbC9OL2lLK0wvUjk5TUdURzVEbEowVWhXMjJtQkU1cFQ4Z1d2UGxIcWkz?=
 =?utf-8?B?eHc4ZXB4Qk9raVFicjRoNHNKc1Y3UjBQL1hWci9vUmtsbHlKU2NhL2ZBdFo0?=
 =?utf-8?B?ajFNMFJtRE9HeWw1K0dpdjZjdTl5emtxVnpqYzBCTUlscFVPdVVxOERUSTl6?=
 =?utf-8?B?WHhyQ3RobDhRWE0rYWkrV09lakNDVEZWQlMxZU1aekhydHZoV0xqQ05OKzZm?=
 =?utf-8?Q?OsDMqDJRIPmAivVsp9hIRwIUHR/N+7tnDWPvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2JJVkJia1YyMmFOei8xRjFodUMwaUEzczlwQmRHR3BBQktOVWZCT2pRVHZn?=
 =?utf-8?B?RHlCYjByemx0bVEzNTRvNG9kUXI5SWxXTFlRRlZ4T1hZM1dEc2V4L0Y5WGJM?=
 =?utf-8?B?WjdPbVRVU1E1THViY2tXdXp1ZGozL0tiWU9LV21IVTRPZmpUR1Y0OXByaG83?=
 =?utf-8?B?aHBSYlN1SE1nNFM5REVnYmgxMEVCUE9wMzF3TW5sV3BOMnhsd1ZNRXBQYWhK?=
 =?utf-8?B?UnVVcURuVWltNi9OSjQxTExJakkrL3ZJcFFubCs5cy8rdWs3dlF6K1Q1N296?=
 =?utf-8?B?OW82Tzc0Q2l0d3Ntb2tCQ3M5VzhaQklMNTE3UXJMbm5OditkWStiUmhuOWp2?=
 =?utf-8?B?SzJlNG1uTHJhWWNFcG9jQjFLRzlocHpVaXo3YkVnblUxR1B1TEU3M1htSmVV?=
 =?utf-8?B?bk14STVma29NZXo3UDQvQXpnb3JTUTByRklHaG84NG91VGh4TVplbGxSWnY3?=
 =?utf-8?B?SEU2OTdhMGQreUpqcVJPckFLSFpCazNrT2Z1ckhQZW1FU0F0b3lDMHlYQjdt?=
 =?utf-8?B?ZGpKT0xQZ3FCd05YamVISlJBWVZJSHR1N1FNVmxxdEl6b1BhcGpMMFBxaDZP?=
 =?utf-8?B?MFNpYm9sL3NuWHA0NnBGTFlsMjd6SXhPUjJFVEYzV0lYUEMvWEl4NlRWdUlC?=
 =?utf-8?B?N0N5bElnS3R6dW1YSFNlSytpMGtpQXY3Y3RsQ0F0V0tTWElHa21kTXd2eXkr?=
 =?utf-8?B?QXZiam1QUHlJT3lPQmVTWnJuc2kzamRZQlpndmI0WWkxeWluMi9HczYzMjhH?=
 =?utf-8?B?WnZPZS9lR3pvV3BTS3VtTW9rUUh6T3VDVXd0czZDa3cxVldSQmw3RklIbzNy?=
 =?utf-8?B?eUhrUEVHS3U3bjhMcTFJVEZWQXVQQlc4ZFlkaExVdW94cWtZRFlySUFwQllJ?=
 =?utf-8?B?WElJSXVmcExwMHJnR1dTT2pnQ1Z0di9RMXNuRHczTHJCaE5PL2ozYldhd2RR?=
 =?utf-8?B?RHBFQ3FFbVJYT1JTTXJJV2dmdkJlK3ZWSE9NakFkT2pZNGxiSENCL0hQSVJY?=
 =?utf-8?B?c2k4UllVbStEN0g0QXhDU1Z3VnNhQ09yNjR5UlhSRzBFMW5BM0tvblJ3QjlS?=
 =?utf-8?B?cGt4enU2ckFMWnlKUldqdHNibEQwRVU2bGFVS1ZuR2RkbllEd1MyRWNXWi9l?=
 =?utf-8?B?SUlJL3QwL21sYXlPaXBuNHNXUk1lM3NPODFJdFppYzdubzBVakJ0NTRISlZu?=
 =?utf-8?B?NVhsb2wvRVlBWm5LK3dGU2VJMll0V2xxRDArOTZRZ0xySmVWSGI3UHNFSWRB?=
 =?utf-8?B?aHVzbzV4blRVN2F1THpqcGxwZjcrL1F0RWptU2U0djJiaVYwWkdFZ3E4V2pa?=
 =?utf-8?B?Qmlpc2FuUlRzazhLZ0FkbURIc0REK0lubWwzTGQ3YnBzYXM0TDJNQTBHRmRX?=
 =?utf-8?B?ZkpocXcrMEpNT2xldlROcXVDaTJRR05GSGxKTnpEVUdvallMYUpHMno4eDd3?=
 =?utf-8?B?NmdyOUNiUkU3bnJUbml1anN5M3hIVVBYclVlOGRlTjNRT2JoYmVZbitUSzlz?=
 =?utf-8?B?TUNWNXRjTTJEa2dQTHFLOFR1cUhIUkttU3FnNDZTajV6QTFBN2hGc3lPUjZG?=
 =?utf-8?B?bkFPWHp1QytWbzFCZUR4bzcyWVhxSWtRY01sbXJ4c0NQZmkvSkZLZDhObThy?=
 =?utf-8?B?b0trcnROU2JPVU44TDhzcEZidXNCeFowVC94WEt3YU9RK1dDT0VpSkNWc2dz?=
 =?utf-8?B?a0lnQ0lqaFdPdWFrdUhTeG1KQjI3NERqbCtUa1NFajhOellEUWJueDNZSnN6?=
 =?utf-8?B?R1lJZy9wcDVTbEQ5a1VPV0FGMlRDMFIvejErc0xxNnBnck5oNlhObXRtNDJl?=
 =?utf-8?B?aDRVRitsWGF5ZTFVUkEyYWU4bGFwZ2VzYzZKTkNUUjZqZkZRMjdkZDg1ZVJH?=
 =?utf-8?B?YjJNVlZNRkdma0dOYXI4VEhxazlpV2gvSkJjZThla3NiUDJ5MktPUDhtZzBr?=
 =?utf-8?B?SGtTZXVabVE3MjlDNWtKYzVXR3lUalZYb011anZtTHE1a0lERUVWYXpGVExQ?=
 =?utf-8?B?U3ROaEtpT2NUbk5uWHpFTlQ4b2g2S2tiRTFhYVdEbzk2Nno3eHVTRkVCMHZ5?=
 =?utf-8?B?SFUrckExYkxjM09IUzdxMFh1b2hIenRwUDh1WWZMa3NxRmxxd2ZkVlJwOGZJ?=
 =?utf-8?B?SGVtYm1IVnB3V3NnT2V3eXVMWHJSSDV1OHFZWG14dGVhOHFZcWlQYUFaczd6?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sYorqudsVeXwXqb3/9Mzd15MVfBGSeU9FK0nwwZLeMp5k3LkkI9jOui/rcVzRbe0ZOL28IUNrgT0CNJv4+pdfIL9ksiczT9aTRyVYlZVcBfFWhU1Q7s67umq5TzNzxoNgljqAx6B6+NJ7eQKwJycQ9huthwYqPe/AK317G77J+SYz2uY/TeZh1XWBUlGyZpWaNTCRngfZiS5xBTGQ9XL+rkny+xxltpY3MU2SZpBkPDEj+Ny8mwqiTyTX5waMj5eBGblQ5tNvzrEf6t3rcNnR9QVSPop4tozGWc5l1LBd1x5hRj45e8/g9nnViHP+OKvrWpkX81y7l5btqcwCE1r64Rqnt8CoYMHmSX5QyUtpzdANSKW6P8DYXnjlibTCEkARvjnBvhifJPlGdnrSjTLFMa165EvK2IdL9VoveZ+z4oATZdyLc10roSHFH0sUkbVwsCu2NrDRKXYn3FhOPG4pnFNwqm5njoxvgOOMjnn8CaTFVv/EFtJVnR+50+LhggLBp8F8R4rjurdTbRzAElVUQmxg72X6wiaxjorEvxmxt1tUyRhKa1gzH37EBK7+gNvMvmqzabLf0HxzC69Ofde3s+HNcQAqpAvYYNAZeqh6yE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd90f6b2-b3b7-4c98-1589-08dd8418558f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:43:40.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9M1pZIr4LlbDkXPBIPFLIhBkcWg4m4git/IghBA2IdaDvow1Eu/3jhv/T70mmuWgNjoB0pJltL730nGpqvh3SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-GUID: 3YplOqrQmwGfkl2XdIlceQgV_6kSgMo0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX9hEh2Su3ZgVt nlu4HMEt0jImAnWyjuOmx66OYHO+R9CKErhTEa3XHn1aPvVASRBIF5NsPruc66d5wN4h7QAjvfU hBJaOgDQaGeJBtwf2ToczWBl7mW2swlWK6V+jdPwvVre6gQPhJ/DPhjnnmBNAplDLFXrT4ORkKc
 OOBaEgy+dmxht+xH63IvuZ+Kjithw9TFpRphqinEtyrPTYEgarNAZEoNGILifeUYHveF2ATYv/H PKZEoeFCaRvncdocpSj4Y89uTX95Z74nMZQysEx9/pvTl0jeqZlzKHto55+SyV58f9RMXESwskg 4Uw1A06P63NPCV8xFDJG5H4/MS7GbitVBDqgSvlBMz+x8Hsh3qZG1gQA0gYWSwvZT0vtjUHeFoL JmU5O7i/
X-Proofpoint-ORIG-GUID: 3YplOqrQmwGfkl2XdIlceQgV_6kSgMo0

On 24/04/2025 20:58, Paul Menzel wrote:
> Dear Alan,
> 
> 
> Thank you for looking into this.
> 
> 
> Am 24.04.25 um 20:07 schrieb Alan Maguire:
>> On 22/04/2025 14:33, Paul Menzel wrote:
> 
>>> Trying to build Linux 6.12.23 with BTF and pahole 1.30, I get the build
>>> failure below:
>>>
>>>      $ more .config
>>>      […]
>>>      #
>>>      # Compile-time checks and compiler options
>>>      #
>>>      CONFIG_DEBUG_INFO=y
>>>      CONFIG_AS_HAS_NON_CONST_ULEB128=y
>>>      # CONFIG_DEBUG_INFO_NONE is not set
>>>      # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
>>>      # CONFIG_DEBUG_INFO_DWARF4 is not set
>>>      CONFIG_DEBUG_INFO_DWARF5=y
>>>      # CONFIG_DEBUG_INFO_REDUCED is not set
>>>      CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
>>>      # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
>>>      # CONFIG_DEBUG_INFO_SPLIT is not set
>>>      CONFIG_DEBUG_INFO_BTF=y
>>>      CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>>>      CONFIG_DEBUG_INFO_BTF_MODULES=y
>>>      # CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
>>>      # CONFIG_GDB_SCRIPTS is not set
>>>      CONFIG_FRAME_WARN=2048
>>>      # CONFIG_STRIP_ASM_SYMS is not set
>>>      # CONFIG_READABLE_ASM is not set
>>>      # CONFIG_HEADERS_INSTALL is not set
>>>      # CONFIG_DEBUG_SECTION_MISMATCH is not set
>>>      CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>>>      CONFIG_OBJTOOL=y
>>>      # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>>>      # end of Compile-time checks and compiler options
>>>      […]
>>>      $ make -j100
>>>      […]
>>>        LD      .tmp_vmlinux1
>>>        BTF     .tmp_vmlinux1.btf.o
>>>      die__process: DW_TAG_compile_unit, DW_TAG_type_unit,
>>> DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0) @
>>> 115a4a9!
>>>      error decoding cu
>>>      pahole: .tmp_vmlinux1: Invalid argument
>>>        NM      .tmp_vmlinux1.syms
>>>        KSYMS   .tmp_vmlinux1.kallsyms.S
>>>        AS      .tmp_vmlinux1.kallsyms.o
>>>        LD      .tmp_vmlinux2
>>>        NM      .tmp_vmlinux2.syms
>>>        KSYMS   .tmp_vmlinux2.kallsyms.S
>>>        AS      .tmp_vmlinux2.kallsyms.o
>>>        LD      vmlinux
>>>        BTFIDS  vmlinux
>>>      libbpf: failed to find '.BTF' ELF section in vmlinux
>>>      FAILED: load BTF from vmlinux: No data available
>>>      make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 255
>>>      make[2]: *** Deleting file 'vmlinux'
>>>      make[1]: *** [/dev/shm/linux/Makefile:1179: vmlinux] Error 2
>>>      make: *** [Makefile:224: __sub-make] Error 2
>>>
>>> Help how to get a successful build is much appreciated.
>>>
>>
>> I haven't been able to reproduce this one yet with your config;
>> I tried with bpf-next + gcc-14, then switched to linux stable 6.12y +
>> gcc 12 as that more closely matched your situation; all works fine for
>> me. I'll try more precisely matching the gcc 12 version; things worked
>> fine with pahole v.130 + gcc 12.2.1; from your config looks like you
>> have gcc 12.3.0.
> 
> I also tried gcc 14.1.0, and now Linux origin/master (e72e9e6933071
> (Merge tag 'net-6.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/
> git/netdev/net)) with gcc 12.3.0. We do build GCC ourselves [1]. Maybe
> there is something missing?
> 
> I built with `make V=1` now, and here are the commands:
> 
> ```
> $ make V=1
> […]
> + ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments -z max-page-
> size=0x200000 --build-id=sha1 --orphan-handling=warn --script=./arch/
> x86/kernel/vmlinux.lds -o .tmp_vmlinux1 --whole-archive
> vmlinux.o .vmlinux.export.o init/version-timestamp.o --no-whole-archive
> --start-group --end-group .tmp_vmlinux0.kallsyms.o
> + is_enabled CONFIG_DEBUG_INFO_BTF
> + grep -q '^CONFIG_DEBUG_INFO_BTF=y' include/config/auto.conf
> + gen_btf .tmp_vmlinux1
> + local btf_data=.tmp_vmlinux1.btf.o
> + info BTF .tmp_vmlinux1.btf.o
> + printf '  %-7s %s\n' BTF .tmp_vmlinux1.btf.o
>   BTF     .tmp_vmlinux1.btf.o
> + LLVM_OBJCOPY=objcopy
> + pahole -J -j --
> btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --lang_exclude=rust .tmp_vmlinux1
> die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> or DW_TAG_skeleton_unit expected got INVALID (0x0) @ 1229728!
> error decoding cu
> pahole: .tmp_vmlinux1: Invalid argument
> […]
> ```
> 
> I uploaded `.tmp_vmlinux1` (295 MB) [3].
> 
> Copying this file to a Debian sid/unstable system with *pahole* 1.30-1,
> and *llvm-19* 1:19.1.7-3, there is no error.
> 
>     $ ls -l /usr/bin/llvm-objcopy
>     lrwxrwxrwx 1 root root 31 Nov 11 12:42 /usr/bin/llvm-objcopy -> ../
> lib/llvm-19/bin/llvm-objcopy
>     $ llvm-objcopy --version
>     llvm-objcopy, compatible with GNU objcopy
>     Debian LLVM version 19.1.7
>       Optimized build.
> 
> In the problematic environment, we have LLVM 18.1.8 installed:
> 
>     $ llvm-objcopy --version
>     llvm-objcopy, compatible with GNU objcopy
>     LLVM (http://llvm.org/):
>       LLVM version 18.1.8
>       Optimized build.
>

Thanks for the additional info! I tried BTF generation with the
tmp_vmlinux1 you provided, and all worked okay for me. From the above it
looks like pahole is using objcopy (LLVM_OBJCOPY=objcopy) rather than
llvm-objcopy to copy the ELF sections around, so are there differences
in objcopy version between working/failing systems perhaps? Or other
library differences in the built pahole on working and failing systems
revealed by "ldd $(which pahole)"? If we can track down any differences
like that it might give as a clue as to the source of the issue. Thanks!

Alan

