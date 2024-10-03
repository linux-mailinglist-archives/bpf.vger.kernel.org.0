Return-Path: <bpf+bounces-40833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB2698F1E7
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 16:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743241C21303
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591CF1A00F4;
	Thu,  3 Oct 2024 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e8e8ZbkR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PmB2OAuD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329D149E13;
	Thu,  3 Oct 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967196; cv=fail; b=nJjTw1eCqPUOPCYAVHjGy580O2yHDvBR6PAw62HVfVmVdgqzWFFRQa+ZsJ6yzf49AphP1AuQnex7f4FCxNTJHSPPN9DJjeYCJ9jA9P/nCZlU8WpSeTTHE8yQqxFPK30cme1YC397+IIZ/fXpPbfmiDsZ/qG8zxNZ/2UWlR06Jkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967196; c=relaxed/simple;
	bh=9lLZhFuYttRz34GRpz/eTSwU5Z6acZmgi0oZFXdZx/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O+M2N8fku/lLxtjrMd0Rbhg/fRxN8JG88/y+g/5Ut125wcUjkSnPYOVTruNE/w9De8QTU5a8RP/zryNpw8b9aGhw9zEfxMb1nOXJ7zNp84tGqETAT2AqqAw3LqEdQEAKOvOp9t6AhhJQtEGxGATEIX5Ru9UmIJjmYHLLVKbzLKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e8e8ZbkR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PmB2OAuD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493EfaK9032749;
	Thu, 3 Oct 2024 14:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=6OZWVyIawSgolP0lzRk+MZiBd8n8QJ8Zks7sxqQQEp0=; b=
	e8e8ZbkRw1sEB5RVvfjrVnNo4pOub4j0Q0p5HFw6bz1PL+whbTRfACLHemwwia40
	zkKwpHpPbSU9AbEgxtP1zUksWY+lYChwMkeEA9QKNoNysQYRUC7uqtwd/9E4N7dg
	nzAI/hWzuqKIXrUFK3jx3PaB8M5Al9/qoHHafDmcaEg9YMaxd7XF9JdHVtJP4YM6
	M3GR16gyOwMFizo8Z6vVSzulq17m6XTdfB2a94vv2M5Xt7+WeNqyVF7DI6ZRH+Gg
	HKxgA6UtE8T5NCyE2YKBqefXOKODzVReReTV0fQLvafmaYpIFsZUcY+SMeeps9n0
	bJ3U0A01jojrm4jJ824Ohg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtva3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 14:53:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493EE4Qq017330;
	Thu, 3 Oct 2024 14:53:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88a9kkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 14:53:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2MBdR+NJHH806g/PIa72xwIyGEwcjWvY27tuyp0rB32TKtmpGvojuTZK/+aeXcskh2PuD+SJV18tdnZxD75rVHdcU2PNK6UQX0hHy369rcNn3DtFdHNxQe0q8LnYnr+QiHIp3kwUSwwddExgApJiETZXIEXK3Lq6j/VdmEwXlDntIUOpS9YtwvcyHJ2kLUOUbbVUeH7TidVJcadJ/BnaMRAYXWLD3BmKBfEs8WEbeYoBbLHvlsTcdCPp+8KbyQBVndnClN0kEKeh8S2yPdWLcHmvt3QUtxpgnLwHi8CqpNxU5supn6y1T9F3Rj3KCuvHdV79s06vgUaHBtgumEq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OZWVyIawSgolP0lzRk+MZiBd8n8QJ8Zks7sxqQQEp0=;
 b=j8Phj+LIzo4deIcNApQzlzIWaPnZadfQ1zkgKMBvm+ZFA5jG1G5gCGjOqnVzbAZaTkriwyWO3ocgOolB9O6IxVC33TOTyHzCS9jPw1XHrMUvPDIU4A8ZappkKTdYVxVFGGHzI8FkKgFto+0P4zTMUgc8s40aSBElyljY64Fo6Vnvx+JuXc/zVC7WDL7jfcT5Q9iHvXkQXwGG2KEUxy4v+6FZf0QaG9cXffUQbbDMQ5GMhu+ihGLCu5K05+lig6jC0VeSZiJ01SH97HP71Zqf2GAPMl+EduoBMwz19y3cD7H5WLZdm7KSk1jB4sPCalfSMN8Ep9hUBTVK49esntVLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OZWVyIawSgolP0lzRk+MZiBd8n8QJ8Zks7sxqQQEp0=;
 b=PmB2OAuDZ6QV0uPxjCgDLbUiHWqz7erDSVjK7yJRzg9XmUiC8kkoRuY/1pj2pOylLPQZHLIayeN5AQykwKJqQxpsE79sDh345kx2JRqXelqmgeQuMYowlRAYFajbGfxDiSzPG0kahyilgFz2gzXu8IBraoOGZt2ooVQ6C6J5beo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB4994.namprd10.prod.outlook.com (2603:10b6:208:30d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 14:53:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 14:53:08 +0000
Message-ID: <ab2eb05d-9108-447d-8720-f511263b40b2@oracle.com>
Date: Thu, 3 Oct 2024 15:52:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3 4/5] btf_encoder: allow encoding VARs from many
 sections
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-5-stephen.s.brennan@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241002235253.487251-5-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0200.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: 90597dbc-7edd-4fce-18b4-08dce3bb142b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ci80bTRpbVBnYWZRMG5QQytkSHZUTThLMTJlWnhaMzUzWG1aM1pCYlZKc01l?=
 =?utf-8?B?VVRBYjlmTGpTZ2gzZWwyT2VDSVdWQ1lhdmpvVDgxQUdhTlVMNlJuQkVUZ25C?=
 =?utf-8?B?UGJDS29BV0U1VHpEa2VJRUtCZlBlYjNDeVJISmhrWjU4bXNia0xIRTVldldN?=
 =?utf-8?B?SFlCcGJ1U0tZM3hCd0YxcVg3SlhRQ3lqU3g1ZldQai82TTgwaGdzTXd1TG5v?=
 =?utf-8?B?Mit3OEV2QVBXTjlrV2tuZ0FKcWJBclBUeUdsM1prc1BEVW5NS2RaNXZJTTkx?=
 =?utf-8?B?VmN1V2hCY3F0K292d3YzbnBrL1cyUXI1RFZYK3B0ajJ5eTh6NG9QbVIyQk0x?=
 =?utf-8?B?WEtrUXZQN1Y5TmFyMks1bmxFZFhCYW1hMjdTSG5GYk92TSt3aHk3Sk9IZ29m?=
 =?utf-8?B?bjV0dmp1SWJNcTE2eldYeTJUNTF5aXBxS0dlWHozbjMydkZnajJYN2FlMXd0?=
 =?utf-8?B?YkVNOTRieUlvNE41TE9YUDBwU1orbnhROHA5Z3FnK0puSnhNTGhRQ2xTb1VZ?=
 =?utf-8?B?em1JTHdtdGhUbmlXRnBubWJBUkJ4bDZSZklhUzh5QWNYVTBIZFdFbkEwYmlS?=
 =?utf-8?B?V0ZUbjBuNnYzVHdWb3V4eUhoZzI2Ni9aYWZMN055d3Z5amp1bmhHL2dZNDg1?=
 =?utf-8?B?bXpkc3ozN3VTbU53VEllV0U4WHVwR3EzZXVRWE80NHJaQmVWTGxxK05nSkJI?=
 =?utf-8?B?ZkM5WHlaQ1BDazNJZlpaUHV4cUUzRHoxTEVYNmt1YUUwSEFXUzZjY1hhWlUx?=
 =?utf-8?B?OUozV0VXY05oNHl0WWxkWllFNmlGb3ozRU9QekdSL1RTaUszaHN0WmFmWm53?=
 =?utf-8?B?K2tOb0h0ekxiMlBSYmJoU0JLeWk2T29GbDhJRUl5Vk5ULzlSd1loZ0wzcSs1?=
 =?utf-8?B?RHBqRjNxeWFSNUpTcnI4NjNVZm1vWmdZM2QzdEZyVWhTajdGdDd6aGNnbGRL?=
 =?utf-8?B?RjdiZTFHQjVSSTlRODhRRXpIVUlTMVAzR1kvZFVxT2RrZ2ZCQjVJY2tsYnp3?=
 =?utf-8?B?N1BERXFYZTRsbEozY1hCeFFVSVVrWENRZlB6d0diT2c0U3YvV3JRVjMxZmly?=
 =?utf-8?B?a2NKcVpiVlVCamRtUUFXS2hCUEpVdTV1OFdPV1MyekZKR3Z3Mk9RYU0wZ3RV?=
 =?utf-8?B?R1piSzU1WXN0ZThLMUM0b09TbFU1YXRXbGd6czZKdkZJWUVrNU5OVHZXMElM?=
 =?utf-8?B?SThxemNmelJKMmZCc2l3aHA0K0FZcnBBaldtUzRTTU5WQ3dVTzlZamtDOTBU?=
 =?utf-8?B?L1FFVldtVyswLzVJUUk4OTZlVm8xempad2pJcGlQRVRTa3d1OG9QRWxSdUZa?=
 =?utf-8?B?SklDZXpmbG02NCs0SllXcmdMM2VPRDVtZytMUFRpbm9GeURBblU1WldCN1N4?=
 =?utf-8?B?dDJ5dE1DU1FxMmQzTTFEL0tUU1FmY1cvdVNKQ0FYSWlmK0k1OHZoRnhmSy9t?=
 =?utf-8?B?ZTBVRk12N2lVb3dhT3ZRcklmOTF5L3BwRkl4WGt3UElVM0VHVWpEM1poZk5C?=
 =?utf-8?B?K1haZ2NHU0RTSVBsa0diaVZFTk1LY1FTSXRiQUFVaExWWHpGMkl3d2NPZUVS?=
 =?utf-8?B?aXhVV3VxVGxQVURzQWNpVGFEUFJ3WVhrRzhvSnJ4QktkZGthS1JjQTB6UUZ6?=
 =?utf-8?B?K2lzV3daaHNCWUd6SWNrYVkrRStBZFY4aFVOazROYnhLRnFSTHZiTTdIeXJw?=
 =?utf-8?B?ZklMeThDMThaVm5NNnJXMzVmVDc2K3RLMGpDTHc4RmJHSE1zeVl2eWpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkM5QlNEbGtJL0gyeERDWTIyTkpLbGU2S3FTNjZHT3ozZisxQ25aZ3ZxOTg4?=
 =?utf-8?B?WU5FZzFVZktBc2lPdVVCanNiSEtZYlNXZTM0WS9KM05VeVF0ZnBCMGZITXhC?=
 =?utf-8?B?Y0pSK1pvTjcyT2FHck0xelJrM2VGUzU0NHl2UWRMKzI2V3pWdU4ySlI2cCt1?=
 =?utf-8?B?S0pPMmZTeUlRSGo3NndyNXd1SWYwcXl4RnNCVDFJTXdreUd4RlU3RHZyZ2VK?=
 =?utf-8?B?M3B4YVZkWW1UWHRxZEpGSE5WcmZ6TUZJTDJ1RGtXeWRaMkorRnZUWWhUbXpk?=
 =?utf-8?B?R051RGpFM3Z4eXlhaDlUaFhyaVNNYmVOam5wVDYzckFwU1ZtMEdVT05oeGpv?=
 =?utf-8?B?Q0ptaHgxQU04U2laK0JNOFUyYW52NWJ3dkxzZEF1TXVHNGkwalhMM0dOazdr?=
 =?utf-8?B?ajF3a2JPVnpFT09zaVFFeFB3cnFpUXlta09rcmV5eUZteDRUZ0h5bmpGa2lI?=
 =?utf-8?B?dnowbmRHdjk5dXFib3NLclgwT3l0aTErNkIvRmZ0VkxvekpsaUlabUZNM0ls?=
 =?utf-8?B?dW9Qb0FhTHF0bmJadmFZRVZVaWJhSVpZcG85clk4VklZMzZUajZrUEROaXFU?=
 =?utf-8?B?ajRYdWlzRndXOExLRHJtMGh3aHN5VEFYaHBpalhxTm9GSlY0SzJJK1lqaWdB?=
 =?utf-8?B?WDJqVW5vUHJOOFl2RlB0Y1gwZGdTZkdway9kR0hkZkhnYmh4bTY1ZkxTVTh5?=
 =?utf-8?B?SUxQUXFSSkdJZ2pEa1ZxL0hOUlNzVXQ3SHRUZU9rZ2kzRDh0dlRobVNTdUJw?=
 =?utf-8?B?TklkWElhck1ZN1o2OFdiL0l0TmtLUzJGZll4Rkc5NmRIQWVPZ1ZsS0Y3UWg3?=
 =?utf-8?B?dHVReEZjWFc3N2tiUmx6NFFIV1E1aU5iZXBPSXFtcTBrVUZFSm9GbGVPdlBT?=
 =?utf-8?B?ay9qN08zV01aRi9LY05FbFgycEhaNGxNU3loZ29adzRxZDFYWnJ2QVpBM2kr?=
 =?utf-8?B?NXBQTHpaSUlNb1JySVE1M1N0OGc4L1NCRWhHSkNwK0NtYzAxYTFrQVVmazZG?=
 =?utf-8?B?SGY2KzdGc1lPdysyYzhrL0ZOaUVJVElhK1ptYkk1SGxJby9VbGNKN1dSNFIy?=
 =?utf-8?B?alZaajluQURrRTVBT0tIWmRRWkcwTUhhdnl5V1d1YTJTeEluc2E4dFdqbDly?=
 =?utf-8?B?TjdneWlVYXBGOEVxUWRsY2xOSXpQTWx0MEEvMUZZZ3FnNGpEQk1rWHBjMUVN?=
 =?utf-8?B?Z3ZVYmh0TE90YzhtODNSaXFBT2dGb3lEN2ZTR3ptU0czSVFRUm5aVHJ2QTdu?=
 =?utf-8?B?ekoybTFQVS9lLyt5Mm4wVGpjS2lqRzE5b25FSVd6SGE4UXNoa0RoRnZSWjRi?=
 =?utf-8?B?NzFvTzBZR1FQOTg4WlU4VFExWElDR2Fod0lmUW1uZm9LTXB1REh4UVNzMFlt?=
 =?utf-8?B?dGtMYUNHQUhhQStNZ2lqRlZtRklpcVZtZXJIQkk0UjNhMFhaak5uN1R0bkdI?=
 =?utf-8?B?SjlYemJZNUhxN0lLQVVqNGIrRnAyb1owNTdmNFUvTlZHTzd6OFpmU0o3UmRV?=
 =?utf-8?B?NGRmTnZxYTlCc0N6VGNmMFVveWtyZEQvWStrK1ZhOG1WY1FNdnJqNlJrVEFq?=
 =?utf-8?B?Z0tFcXVwSVRNY2lpektFYUFFTW5IQzFuVjd0TWJLUE5KdEdRMzd2a2NwNVJ0?=
 =?utf-8?B?ejJjaUZtMXpORUt4UEpSZ3RSNTc5c1lReVFCNkZqcVFjWDlrMXQrZWZmQTBh?=
 =?utf-8?B?eElIVWtydlBvS1lHZVhXZjZRUmJIcG9kWU9CTE9xVjVvTEZpK2VGTE1ybUta?=
 =?utf-8?B?b3llMWZVRzhlaEZNTXBpZTBPVkVRdmNlSUlKVHNVL0ZkN2tkWk5NeEFXM3hu?=
 =?utf-8?B?MEtzY0xpM0JmTXkyUzA4WmNhcDFNVCs0WTdnRUVhbzRZR2JjaUEwV2s5c0pS?=
 =?utf-8?B?eU11N3hKZUc4dHFnRk9JVzV6VkE2OExoOERGL3RtY2JsWWpFQkJmMGZIVk1k?=
 =?utf-8?B?cmh0SnRXYk55bHBhaFlHWkdNWkg4V3dmb0VLWVJYdk9EUmx5cU9uOEYrVFRL?=
 =?utf-8?B?Ujl3b1ZrbkVYdlRWVi9wZGtYb0VncXN1ZWQwYTRhUWVaWXRYczN2WnFHUHRO?=
 =?utf-8?B?VWpaNHl3eVFGT0FVTDY0ai9RS21rNGpTams1UmR1QmF2L0ZjL1hJY202S2xi?=
 =?utf-8?B?d2Q0Z1B5T0ppZmZTcEZrc3FXWlZJd2NtUnJhazFvWHp2bzB0cXFJNnpRVUNw?=
 =?utf-8?Q?vUWHbqerZAnazOVJXDEZA+A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pnEX2CNmHOgb+g7+IQ/FByW/6lfkgrhJsoEKxaQKxVlJtWML3GglrGfw97Q8XCm1lfEkKcXVhi3rNlCFIFJ5+XUuc1PcNa5DE/nI4gBZ/94PFZke4aPP/KbTInIrTx3oalOvi4uG0h7FyThDs0mZ1TBMn+57dg9Nyy2qc8vjK3owz+PeFdXcVTRSLEan0MDJDwi6UZwScQLBARHDmJi7iEKHeZ2KzVsMrGBcxwo4UHfwACPUrVhYdsgyw7BGeCUbmCMEi8jOyxooUKELm6f4BeM/Kq72TlV21n6fXn1eXOtC+ti1D7Rkevy5CfkzpKt8GdttLfsxHlPX5r+M9x+5TDI5LEM11dNzO1/YN6+9cPlL0pevKI16y2cRonBpudjkQaqOxhKCmalJmOrzfczXh3qPSsoVjAVqiHDFgzy7V+3UrzKaL7g4rvlvpuJBJQqRbxCi5K9J+8Et6DIIIyotzFLgvwsHjSXmRAuBWQfvg2V73orCkvzk/twm4J29MvKCB5XM33VMjTLjrSXxDGMMH12T+0FzglINR/IA2guPvtrGagTp0vWHaUHuOMFP0KuUYV8xbETy/gmkJmunWdYShuq/3BtWD3cvZ37d1PI6TmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90597dbc-7edd-4fce-18b4-08dce3bb142b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:53:01.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CibZOr20+tOK9mF4nZn8RJXao+6w2xIu3Tl1wS1FWzB0IgsZUKuk2mbrfxi76pO6s4lA2/bdLFLu+zQ3zvlvSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030107
X-Proofpoint-ORIG-GUID: z4553j1Hnhr2_9n0oao9_hmnavjUmknM
X-Proofpoint-GUID: z4553j1Hnhr2_9n0oao9_hmnavjUmknM

On 03/10/2024 00:52, Stephen Brennan wrote:
> Currently we maintain one buffer of DATASEC entries that describe the
> offsets for variables in the percpu ELF section. In order to make it
> possible to output all global variables, we'll need to output a DATASEC
> for each ELF section containing variables, and we'll need to control
> whether or not to encode variables on a per-section basis.
> 
> With this change, the ability to emit VARs from multiple sections is
> technically present, but not enabled, so pahole still only emits percpu
> variables. A subsequent change will enable emitting all global
> variables.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Some questions about shndx handling, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 90 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 34 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 1872e00..2fd1648 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -98,6 +98,8 @@ struct elf_secinfo {
>  	const char *name;
>  	uint64_t    sz;
>  	uint32_t    type;
> +	bool        include;
> +	struct gobuffer secinfo;
>  };
>  
>  /*
> @@ -107,7 +109,6 @@ struct btf_encoder {
>  	struct list_head  node;
>  	struct btf        *btf;
>  	struct cu         *cu;
> -	struct gobuffer   percpu_secinfo;
>  	const char	  *source_filename;
>  	const char	  *filename;
>  	struct elf_symtab *symtab;
> @@ -124,7 +125,6 @@ struct btf_encoder {
>  	uint32_t	  array_index_id;
>  	struct elf_secinfo *secinfo;
>  	size_t             seccnt;
> -	size_t             percpu_shndx;

heh, ignore my earlier gripes about the type here since it's being
removed now!

>  	int                encode_vars;
>  	struct {
>  		struct elf_function *entries;
> @@ -784,46 +784,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
>  	return id;
>  }
>  
> -static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
> -				     uint32_t offset, uint32_t size)
> +static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, size_t shndx,
> +					    uint32_t type, uint32_t offset, uint32_t size)
>  {
>  	struct btf_var_secinfo si = {
>  		.type = type,
>  		.offset = offset,
>  		.size = size,
>  	};
> -	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
> +	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
>  }
>  
>  int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
>  {
> -	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
> -	size_t sz = gobuffer__size(var_secinfo_buf);
> -	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> -	uint32_t type_id;
> -	uint32_t next_type_id = btf__type_cnt(encoder->btf);
> -	int32_t i, id;
> -	struct btf_var_secinfo *vsi;
> -
> +	size_t shndx;
>  	if (encoder == other)
>  		return 0;
>  
>  	btf_encoder__add_saved_funcs(other);
>  
> -	for (i = 0; i < nr_var_secinfo; i++) {
> -		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
> -		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
> -		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
> -		if (id < 0)
> -			return id;
> +	for (shndx = 0; shndx < other->seccnt; shndx++) {

can't we start from 1 here since the first section is SHT_NULL?

> +		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
> +		size_t sz = gobuffer__size(var_secinfo_buf);
> +		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> +		uint32_t type_id;
> +		uint32_t next_type_id = btf__type_cnt(encoder->btf);
> +		int32_t i, id;
> +		struct btf_var_secinfo *vsi;
> +
> +		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
> +			fprintf(stderr, "mismatched ELF sections at index %zu: \"%s\", \"%s\"\n",
> +				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
> +			return -1;
> +		}
> +
> +		for (i = 0; i < nr_var_secinfo; i++) {
> +			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
> +			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
> +			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
> +			if (id < 0)
> +				return id;
> +		}
>  	}
>  
>  	return btf__add_btf(encoder->btf, other->btf);
>  }
>  
> -static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
> +static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, size_t shndx)
>  {
> -	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
> +	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
> +	const char *section_name = encoder->secinfo[shndx].name;
>  	struct btf *btf = encoder->btf;
>  	size_t sz = gobuffer__size(var_secinfo_buf);
>  	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> @@ -2032,12 +2042,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  {
>  	bool should_tag_kfuncs;
>  	int err;
> +	size_t shndx;
>  
>  	/* for single-threaded case, saved funcs are added here */
>  	btf_encoder__add_saved_funcs(encoder);
>  
> -	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
> -		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
> +	for (shndx = 0; shndx < encoder->seccnt; shndx++)

same question here for 0 shndx


> +		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
> +			btf_encoder__add_datasec(encoder, shndx);
>  
>  	/* Empty file, nothing to do, so... done! */
>  	if (btf__type_cnt(encoder->btf) == 1)
> @@ -2167,7 +2179,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  	struct tag *pos;
>  	int err = -1;
>  
> -	if (encoder->percpu_shndx == 0 || !encoder->symtab)
> +	if (!encoder->symtab)
>  		return 0;
>  
>  	if (encoder->verbose)
> @@ -2180,6 +2192,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		struct llvm_annotation *annot;
>  		const struct tag *tag;
>  		size_t shndx, size;
> +		struct elf_secinfo *sec = NULL;
>  		uint64_t addr;
>  		int id;
>  
> @@ -2211,7 +2224,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  
>  		/* Get the ELF section info for the variable */
>  		shndx = get_elf_section(encoder, addr);
> -		if (shndx != encoder->percpu_shndx)
> +		if (shndx >= 0 && shndx < encoder->seccnt)
> +			sec = &encoder->secinfo[shndx];
> +		if (!sec || !sec->include)
>  			continue;
>  
>  		/* Convert addr to section relative */
> @@ -2252,7 +2267,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		size = tag__size(tag, cu);
>  		if (size == 0 || size > UINT32_MAX) {
>  			if (encoder->verbose)
> -				fprintf(stderr, "Ignoring %s-sized per-CPU variable '%s'...\n",
> +				fprintf(stderr, "Ignoring %s-sized variable '%s'...\n",
>  					size == 0 ? "zero" : "over", name);
>  			continue;
>  		}
> @@ -2289,13 +2304,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		}
>  
>  		/*
> -		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
> -		 * encoder->types later when we add BTF_VAR_DATASEC.
> +		 * Add the variable to the secinfo for the section it appears in.
> +		 * Later we will generate a BTF_VAR_DATASEC for all any section with
> +		 * an encoded variable.
>  		 */
> -		id = btf_encoder__add_var_secinfo(encoder, id, (uint32_t)addr, (uint32_t)size);
> +		id = btf_encoder__add_var_secinfo(encoder, shndx, id, (uint32_t)addr, (uint32_t)size);
>  		if (id < 0) {
>  			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
> -			        name, addr);
> +				name, addr);
>  			goto out;
>  		}
>  	}
> @@ -2373,6 +2389,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			goto out_delete;
>  		}
>  
> +		bool found_percpu = false;
>  		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
>  			const char *secname = NULL;
>  			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
> @@ -2383,11 +2400,14 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			encoder->secinfo[shndx].name = secname;
>  			encoder->secinfo[shndx].type = shdr.sh_type;
>  
> -			if (strcmp(secname, PERCPU_SECTION) == 0)
> -				encoder->percpu_shndx = shndx;
> +			if (strcmp(secname, PERCPU_SECTION) == 0) {
> +				found_percpu = true;
> +				if (encoder->encode_vars & BTF_VAR_PERCPU)
> +					encoder->secinfo[shndx].include = true;
> +			}
>  		}
>  
> -		if (!encoder->percpu_shndx && encoder->verbose)
> +		if (!found_percpu && encoder->verbose)
>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>  
>  		if (btf_encoder__collect_symbols(encoder))
> @@ -2415,12 +2435,14 @@ void btf_encoder__delete_func(struct elf_function *func)
>  void btf_encoder__delete(struct btf_encoder *encoder)
>  {
>  	int i;
> +	size_t shndx;
>  
>  	if (encoder == NULL)
>  		return;
>  
>  	btf_encoders__delete(encoder);
> -	__gobuffer__delete(&encoder->percpu_secinfo);
> +	for (shndx = 0; shndx < encoder->seccnt; shndx++)
> +		__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
>  	zfree(&encoder->filename);
>  	zfree(&encoder->source_filename);
>  	btf__free(encoder->btf);


