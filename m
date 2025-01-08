Return-Path: <bpf+bounces-48264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DFFA06341
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA747A1EA4
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A11FF1C0;
	Wed,  8 Jan 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zaika1ZK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xVMFJN1I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526FA1FCFEE;
	Wed,  8 Jan 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357014; cv=fail; b=pJBt5nT8+G3KmkJHlM9qip1dDqxbDuTAEDPBWJ94QUcO4HwihUZYBYvGce8YxadLwAi/dGP1Dshs2+MvpSrJWyR43QKlas2G3GSrX8saC15bfC+Nf2S+xP7oZR3VNNW0HAEEq+ikJyvVDnW0oWntiwD0Wt3x4ycCxDxZttlBIlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357014; c=relaxed/simple;
	bh=yuBVXFpKwzwx92T7MH/NRVlffOI/Aq7QW0IcXxjVD+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U2erY+0cQ1wCIvUF6ZyyqAglVvEaC8oRpytK0XWeKaQ5/TcMPOTqF7xDQDGeZWjQTxOovViKAVVnGJe1CJGA+nvOSPaf7bei+HUp2gtvtox1rdtmB7DmO9cCYsnAoFAkHHgcKf1vIBE2dINepGio3QkmL87pTvKptulpMEm7abI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zaika1ZK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xVMFJN1I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508FNEVN029591;
	Wed, 8 Jan 2025 17:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Rp+UgUFPMxyIrXPtkpgTgTmDPkJrlK2pJ/476JPnmQk=; b=
	Zaika1ZKCZUwtmgqTJ+kmw1mDMwYqmpcYic+6mLsiUw874Wy1gBp2u+eBFqgG6dE
	tcgUmwfa01zSDUTc742MxoG+EzeMWw6vW7JvunGQoqBDHxbkeapcqmVBglyzBdGS
	117zympmis0mkLrXRZkEipYwyH83FIXNNH5VjOaviHZt4rU/qdYVTckK9YufyfDU
	WtOfb3sBpKE0euuI7z49jpE9aphdy0rKMKIm1I6nKYewEh8BkGB/SakKpKVpZEi2
	Vj5k0cSjW/esBTA5p7GeHChui/oALNUfqOOrp4gT6tYgZ02tSSz4rbbtnDQXES7d
	qxXPPZ6iwsf/5qIWbvwKUA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvksy2ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 17:23:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508G0gtr002848;
	Wed, 8 Jan 2025 17:23:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea1u3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 17:23:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK8+n1qsPiBadf1iJH1E+LbhiaAJ1R16/XnUhYTknKb4sWpXxXaQlygKjPQlG2dFwGAJU8BuJANcAgVGJyW9X5l0evsqxSjfyQgMylNaZTp5W5EsHj1CgbfhyzO1uJpDmfZPtxLhNW+gyMYqaWxHzf62yUPMtUocDeO6WS45AlQb1nJxsn78a3X551+LxOQX1MUKEBtwOhJaTQoEIz9Nw1kcqGNairk1C00jMHiBiv7+d/3bpFUnlcSz8iHqaovJt9QuOaDJohMPwQkSthFUUe1XdJ/2kkBcGgg4QWCun6TjqNGDY0ZwlYeKQ9NfV5cDvG60aGzbw363LR3Ly1DxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rp+UgUFPMxyIrXPtkpgTgTmDPkJrlK2pJ/476JPnmQk=;
 b=bWifO6Tqpzjz+ZJCKC7zsI1zP58Q9GpeRsNYpf6eVhwSjm9zV5pkX+ELvz65VuCnmr7dE+5t90sFldLfob8n4BGvMmLnw9YHdj4pzaTddUrjgMrNNla7TnObvn4QoP4SOhphGd03CEOoyqoPzbsk0/Wh9+k0xQnDrFhGFCxDUguoGEprz6AP3ZF2ZnB5F69v0gHBKLfkH31/C/l2NLx3x9ZyJpqBWhvIFOKMlQx/bfYMYI49dUXkB6ZkV/IBOFtG9sVF3ptJtLm24hxc2gJKHxZUDinQSTThz3mOTfCwHPlJKO/PpipOh4FtjagB41OtdHpMXOmLet/87n6lXL/qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp+UgUFPMxyIrXPtkpgTgTmDPkJrlK2pJ/476JPnmQk=;
 b=xVMFJN1I17Ines2xy5TrRSXUi83f7+HWgzaqAJZNuc7uxSMpSpT2UcoQ4JBxu2T6TjRjW3u0h3INm8XVP5005HiX6NHk68B37xvrayrt6xeQaf/AeVEMhgSaiep9lDcgfMigA0WhBP3vqnV/+UorXgXzlua7cAVp7qdGspyTK6A=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB5992.namprd10.prod.outlook.com (2603:10b6:8:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 17:23:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 17:23:01 +0000
Message-ID: <bf09b28d-e1b6-4de8-8eb2-410b017679ff@oracle.com>
Date: Wed, 8 Jan 2025 17:22:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] dwarves: set cu->obstack chunk size to 128Kb
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, eddyz87@gmail.com,
        andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
References: <20241221030445.33907-1-ihor.solodrai@pm.me>
 <92a6a095-3a49-4204-af49-643f2db1e3a9@oracle.com>
 <Xfd2PxigaipLv392tfxKUdgwxRMdn9bMsaq4GCJxbX7DooxvxfZAtJceZkZVk14GHODh0twQw598iFTBaYkZ8mJxTCfEhi7S9WgB54C0zN4=@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Xfd2PxigaipLv392tfxKUdgwxRMdn9bMsaq4GCJxbX7DooxvxfZAtJceZkZVk14GHODh0twQw598iFTBaYkZ8mJxTCfEhi7S9WgB54C0zN4=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: c72135a9-bea2-44ca-304f-08dd30091a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGJBQjhzaDc5T2Z4d3YvRFk3OTZhWkczdDU3RWg5Y2QzTmRzNytqREZFd09P?=
 =?utf-8?B?bmp2OTVldG5rblZUUmd1aTErTThQZ2lPWWxFTStUYm9aY0twdW1LR3RyZXFq?=
 =?utf-8?B?d2oyc2hPdXlUbmxlMWhuekVOeXJRaHFjRFZ3OXI2TktpdTAwU01BNkhjbDRJ?=
 =?utf-8?B?TGo5TzVLWkJrWGhVMXNxU3g4UmJSNjQ0Szh0NmNDSGF4RkNuN2pZUFk3eSs1?=
 =?utf-8?B?enRSV1gwVWJlb2duMks2L01GQm0xWjVHWDZvaWt6Y29ZQ0VXWUpuaTlyZEVQ?=
 =?utf-8?B?b3hPeE5TeFY1MUt5MUhxb0JvSGRwWURaNGYxLzNWUW01ZzZhbXJzZW9KWisx?=
 =?utf-8?B?TUxWMzNGTy9NNy9kdUJkSUtoYkRqUWRuTGcvVVJ1d3NVNnVYSE91eXRMK2xw?=
 =?utf-8?B?aUJHWGxreWUzT2lrUFVWSlViNWlsdkpQYi9HKzBTVXJzQ1l1Nksxb2dtNDlh?=
 =?utf-8?B?bE9BbWIyeUM4dVRoMmhKUkY4cm1hMHU1Rm5ibjFFVUNXWDJoQXJxSEVyVkRP?=
 =?utf-8?B?OFJBaFpyblZkcC9qbTdsaDNodVFra0toajVUeXZXbEp3bk9TM1ZvOFNWdzRi?=
 =?utf-8?B?dmhIV01BYUNKVkgzZGpKbVl3NE03VWxQbFUyYWhNL09wd2xTRHMzYVJGa0JO?=
 =?utf-8?B?VC9UeW9FVmI1NHFPSDBKdCs2aXpzWDZyYXVqdy9ud1VIeXpzb296SFV5WGlD?=
 =?utf-8?B?b2xGMFdySnlHdGpaaDZ1WitPRE4wUUcwK2VtQm1CS2FpbFZRSktuOVh4T3Fk?=
 =?utf-8?B?aTlieUErQ2xWeDdFVXYvajlRRlhmUWk0RXl1VWVKTDlPK2xwVmZIZDVnTEZQ?=
 =?utf-8?B?dkIrNmFoWTdxVEc1a0lsbmFwbm9hVUd1bUlHRkQremdWNDNTZ2FpOVRIcWpE?=
 =?utf-8?B?UnAvSVhTV2tJT3BGSFkxUFJLQ1RpWWtJanRuMUZtNXVvNDhUYVdhOS8zcmVX?=
 =?utf-8?B?NWhWS1BMOVViOHZBQmIrMzZrZko5bHhncUNpeGxZT3U2K1ZKaGRIdHQ5WGZm?=
 =?utf-8?B?aTFibXoyY1U1bGRwR3NYWmtBUWhoYzBqQStacFdXc3o0M0l0Zm0zNVI0ZDVW?=
 =?utf-8?B?Zk15NTBxakxOSm9vbXJUSFdqVzNHSWhab2wrUytoVEZvSVZ4MTk2SnhqVEdj?=
 =?utf-8?B?VnlKYXJuNGNJSDB4ZDJ3clBZSUhPdm5nOGZjM0xDQStlVlpHV0tvSnFMRVlP?=
 =?utf-8?B?OVphT1V2a2pHQkcvWUNFZm1qZlRSa2VEVmFWRk9oekFPVDF4QmhWSWlFWm1z?=
 =?utf-8?B?emFLYTlwUldNcm5lTTJIdlNtcHhhZHNIMHhrdjd3MGVCMThvWFBlTXRrRmph?=
 =?utf-8?B?eWdmbytPTDVqbjJNaWF2bVZBa3o0bHh5eitoNEh6MnNtUzIrSlI0OTJNOFE0?=
 =?utf-8?B?S2RYYnV0RG9XKzhRdk9CaU1CcFdDU05KUURCanl5YWZBV25YMmpsVEl2WG0r?=
 =?utf-8?B?aDkraVNOZFBkMGZuYnV3cElsdjRob3NrMFZoWmN0RGJOMyt1L1JjQ3hyRW1J?=
 =?utf-8?B?MTJlNlppS0duby96ZnZiUWYvZXlYYWR0R2RHYTM3ZDZrd09UNjZPOG44djRq?=
 =?utf-8?B?ZVhpQWhOd1Z0dzlpenVJaklrSzdSWDAwU3FtdkdObEEvQmpGbENGem80T2RP?=
 =?utf-8?B?TnhKcFlEK0Y2YTVMNFdOOTBQVTVTNWtYUkRmQ0d0S21OZUt4eGpEUVpJOHEr?=
 =?utf-8?B?Rm5PN0M2S1NkQ0svQmtSOTArZHBhL1VLRlQwL0VkV2tKbytaN05ZZkNFWUcy?=
 =?utf-8?B?cC9DTCsya1BSYW9Zd29qOVlTSjZscXlYSy81a3FNNDA5TUZiYlVwWHA1OERv?=
 =?utf-8?B?MXBnRitiT21vZjdONGFlUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1NxVEZDZTJHN2lvRjFMTEtDTXBVOTFCVEV1cVZTUy9FMitxMDV2Q1AzUG83?=
 =?utf-8?B?NVBoendNTUNDRW1mbzNrdSsvMGZKNjNtQm9KUXJ4M09mVGRrclZHR2RFK1Rj?=
 =?utf-8?B?Wnk1eVNYUFZDVzg0UHRHV2RvYi9OcmtFSXJ2akFDS3ZGQTlEZEZIU1Fma1gr?=
 =?utf-8?B?a0krTzBWdWczNXBuM3VDcjFyL3JkRG5DaWtRcU9NNXRoVmlIczRmT0VlNGNV?=
 =?utf-8?B?bGUzdzZWek5GVmo4dTlPU2FVR0FBL3FUbTVoby9uZEFqSTcwb2dLcGFkUGY1?=
 =?utf-8?B?Uy9PbFdZU3JRTHFla09qY0RWZVBHZ3hLcHl5bXZHd2wyOGlNQktxY0R1WjRI?=
 =?utf-8?B?K2F6RjNUUUs3QjJuQUdybjVSV3VMQVNmL1ZMY0xYbGx3aVByRDFVVkIvZHVj?=
 =?utf-8?B?RnF6bms3dDlSRjg4Tmx2N3VQRGJaRXhhMmZSZWpsMDhGME1HRzluWHFObGJC?=
 =?utf-8?B?Z2k4ckZ2VjlMQTdmTUo0ZW5NdEVUdVFyVWU1Yno1bXM2b2hzSVBXazRGNE1P?=
 =?utf-8?B?bTF6ZStPdUZkMVBaOUJ1QkxtSnQzZ2s2UjkvUDh2VWFNZHl0OFJqWGZJckUv?=
 =?utf-8?B?YTEzVUFDcDVvdCthdGpSblVZRjJTVUVlT0JyZzNNblZSSGVSZ1ZzWVlDczdM?=
 =?utf-8?B?b3g0MFUySHpIUU1McmFPQXRwSFAranBCUWVOMFh5cFpMM3pFUjA1VmZGUUNt?=
 =?utf-8?B?dEhFL2NCVjVPQ0ZlVm5hb2NjSW5QdyswekhpdzIvVFdQbkIrWFBnckl5dmFN?=
 =?utf-8?B?dkxVbWYrMldPd2NCRU5SLzJCSzF4QUF3VitSQmFtN3dzK1NyMTIzUjJnL1A1?=
 =?utf-8?B?QlFRaFFvOGJGRkRjLzFFQ1J4ejJ4UHVteTMwYnBXMmRHU09wYkJjc2VxWEcx?=
 =?utf-8?B?eWJXQnNDN3VjK3lHcVJkOTlIVWY4RFBsZHFDK1I2d1Y4MGYra1RQMkxGc0p3?=
 =?utf-8?B?Z3JjbkVTSTdZK3lkQ0R6QXNpV0xYZFRid2hMeUZMNGhqUmdDV1BUYVpZdk0x?=
 =?utf-8?B?bnJyTlZHNkkxTVpjYW1YYUxuL3J5RWphbG9aOWRtT3ZWRkRoM3AzS2Z6UVMw?=
 =?utf-8?B?U3Uxb0JTRjExZ2pWc3FpcE5Tc3E4MVZXYUtuRlBzdEhMbkVlUGl4N0tpNjYx?=
 =?utf-8?B?SHdLakh0TmM5bVk1Y3RJcmVkdkVUdFk1bldadllmdmpjN2hYb294RTJIb2xP?=
 =?utf-8?B?bk15cmlNLzVDMDFidmRQUnV5V3hzOU9YUTZZMHpEUXlDeExQUlVTZERMWkpj?=
 =?utf-8?B?aFd4UkRRWXJmOHJTUGtMUFUrdXg5aDEzYVN2UlUvV0FSWDdMVzh5Wks3ZTM2?=
 =?utf-8?B?T2oxWnc2MmZuL0tYb1RmV01XSWxPZGhWaHArVS9qbEtuVzVnUVVvN1pMYUNC?=
 =?utf-8?B?Qm9GU1dkTE5DbVpHWmhFS0laVVdWaWdJeCtqMGhtVkZVK3owSFJaN1lPZm5S?=
 =?utf-8?B?MldyVzM4SHMyUTQyTzFwMUMxV2ZOVnlVeU0zZVJCUTNYcTdyS1BRSldLNVZ4?=
 =?utf-8?B?Wm41cGRHTGI1Y3BKeVIwN1FIN0FoY2Y4U0puYllVSXE4czYwNzJWQW0rYUxG?=
 =?utf-8?B?REhvMjNsRmdqYjBJelBNOTdvMDA3TUlyWTh5UlcxRHRVbFc2SmFoZHJNUDY3?=
 =?utf-8?B?b2pVZ09iZ0FFVDM2VFN2UTM1L0lzVHNrR1VYZXFGRU50a09UMmRjcFczNHY4?=
 =?utf-8?B?dU1INnk1WGJPWE5nYmdsdEI3L3I1QXZZbEY5VHlwWXluUVBsZEZkWTVDWnVO?=
 =?utf-8?B?aGIrQjRlRlZHUEI1eG15WmQ2cnFNQ3VLMXYrM0t4MExKc2JodVpqTm1sOXVh?=
 =?utf-8?B?U2xJMzlYVFVBQTVKcUlFK010cEUwQnlnTHNpMm10bXk5Nmdvbnc3dHJLNXpD?=
 =?utf-8?B?dGF1VEdhSE1ETS84N3RUbExIZHZKZWRCNVRST3F0WGZ3NTlHN2l1UnEyN0lz?=
 =?utf-8?B?N2w3ZUpsN2dXdjlaMHlMRDZSOVNlcXpjVzN2NkVUNGFvanJRQ2xHYkdET3hZ?=
 =?utf-8?B?SjhJRk04RXZEclJ1Vi9ySnJuS25SendzSDFDdWZMUk5xd2RFMG51eVV2eVUx?=
 =?utf-8?B?QWl5SnZkcHVoNUZXa1ZEQkdrc25aUGw5aXpJU0xrOEhBSGJ0QS9ibks1Z2k1?=
 =?utf-8?B?VTl5cG9MSnpvdDhwWG1VZThlRjZ2OVF2WHAyTkYzenNWYlBYNUlTNU96c1N6?=
 =?utf-8?Q?e1nDPpIs3KkldJjIOgF9CWQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JFPNz9uogzlcCqNvoPuuxNnhM7uoDnN5kM3U7W8dQ4tOm6MBzk/M4ago/z+n9tXF9S8zqyjDfVV1hXNPvdbpC1w1R56mqDUaRmbFJbvrFTNw2CFCmgOCl2OuZ/SKHLOVAJ6B3lcmAV4IcGlN2CckGUaaukhKX7WqGhu1ogKF8WCKPqc/sEaycvTA1xSa0yEq2Wt8anfXHtUVP1wp91CKkq2JFhAY3qsUK/wwNjkOFc15XaMLOOg+GkkEh84M+tIaUIBFn2jBbxHA5B0QlWfo/am7EsqrTAqdz+ikyNBMNKFPKNRYeQaOAHG5v3OIDjJmtkCJQI/ivHdKMvJeCaITah5xNeJwJI/rWb4ySoSm26k87caZ/ufogkCzlPHQTXc0N7CiIotBh74TmySISW7OASt+wMpAG5Fq9npVLY20HyDRR4EaHVj3v8jy91yNK1IIuNr1hIu+ejBiW9AMBTwy3oeVphPmnZ/ADePh4ODp7gD5LmX1+pEfHMkHPDFpV2H8Ij/jyR1blxpOCzgugwWc2QXkKbO183Sik0SxrqdxeaAOaKxaWz+USDb51zhdVLgnFcOVnu0f/fNRMJGd08uKHZ2tnNgXKvMZ9/BUs5qfhaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72135a9-bea2-44ca-304f-08dd30091a37
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 17:23:01.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAnxuBYfUVmMJIHclBeh9QRNHv3ONuNShfClkT3hlw1kSc7RML0dmTMvtEYJoKP+0Vsa4iABgVbeiiE3l3vZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080144
X-Proofpoint-GUID: vMg7wkztuNESYrSLlFD1nn9lSO9Ot5--
X-Proofpoint-ORIG-GUID: vMg7wkztuNESYrSLlFD1nn9lSO9Ot5--

On 08/01/2025 16:38, Ihor Solodrai wrote:
> On Wednesday, January 8th, 2025 at 5:55 AM, Alan Maguire <alan.maguire@oracle.com> wrote:
> 
>>
>>
>> On 21/12/2024 03:04, Ihor Solodrai wrote:
>>
>>> In dwarf_loader with growing nr_jobs the wall-clock time of BTF
>>> encoding starts worsening after a certain point [1].
>>>
>>> While some overhead of additional threads is expected, it's not
>>> supposed to be noticeable unless nr_jobs is set to an unreasonably big
>>> value.
>>>
>>> It turns out when there are "too many" threads decoding DWARF, they
>>> start competing for memory allocation: significant number of cycles is
>>> spent in osq_lock - in the depth of malloc called within
>>> cu__zalloc. Which suggests that many threads are trying to allocate
>>> memory at the same time.
>>>
>>> See an example on a perf flamegraph for run with -j240 [2]. This is
>>> 12-core machine, so the effect is small. On machines with more cores
>>> this problem is worse.
>>>
>>> Increasing the chunk size of obstacks associated with CUs helps to
>>> reduce the performance penalty caused by this race condition.
>>
>>
>> Is this because starting with a larger obstack size means we don't have
>> to keep reallocating as the obstack grows?
> 
> Yes. Bigger obstack size leads to lower number of malloc calls. The
> mallocs tend to happen at the same time between threads in the case of
> DWARF decoding.
> 
> Curiously, setting a higher obstack chunk size (like 1Mb), does not
> improve the overall wall-clock time, and can even make it worse.
> This happens because the kernel takes a different code path to allocate
> bigger chunks of memory. And also most CUs are not big (at least in case
> of vmlinux), so a bigger chunk size probably increases wasted memory.
> 
> 128Kb seems to be close to a sweet spot for the vmlinux.
> The default is 4Kb.
>

Thanks for the additional details!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

>>
>> Thanks!
>>
>> Alan
>>
>>> [1] https://lore.kernel.org/dwarves/C82bYTvJaV4bfT15o25EsBiUvFsj5eTlm17933Hvva76CXjIcu3gvpaOCWPgeZ8g3cZ-RMa8Vp0y1o_QMR2LhPB-LEUYfZCGuCfR_HvkIP8=@pm.me/
>>> [2] https://gist.github.com/theihor/926af22417a78605fec8d85e1338920e
>>>
>>> Signed-off-by: Ihor Solodrai ihor.solodrai@pm.me
>>> ---
>>> dwarves.c | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/dwarves.c b/dwarves.c
>>> index 7c3e878..105f81a 100644
>>> --- a/dwarves.c
>>> +++ b/dwarves.c
>>> @@ -722,6 +722,8 @@ int cu__fprintf_ptr_table_stats_csv(struct cu *cu, FILE *fp)
>>> return printed;
>>> }
>>>
>>> +#define OBSTACK_CHUNK_SIZE (128*1024)
>>> +
>>> struct cu *cu__new(const char *name, uint8_t addr_size,
>>> const unsigned char *build_id, int build_id_len,
>>> const char *filename, bool use_obstack)
>>> @@ -733,7 +735,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
>>>
>>> cu->use_obstack = use_obstack;
>>> if (cu->use_obstack)
>>> - obstack_init(&cu->obstack);
>>> + obstack_begin(&cu->obstack, OBSTACK_CHUNK_SIZE);
>>>
>>> if (name == NULL || filename == NULL)
>>> goto out_free;


