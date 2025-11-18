Return-Path: <bpf+bounces-74946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FECC694D0
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7124F5BD9
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5643101A2;
	Tue, 18 Nov 2025 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hDyX0iUs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G2jkhIH6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04852F25E6
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467722; cv=fail; b=q+rYuifniZLJKzEGITj6/3nyIReDJDjIns0F7uPMgZmuzGQnIutpG3lYXXJSJWgAOcBfsi9W3k1AFemVXGDS7duWVBv/HiNXUm1VBfV2dDlihYDhjet1xjdxnDkAdezf+dFmjx/htk8T607211UKH/DFHlAnb/WFKgAI8jbCpVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467722; c=relaxed/simple;
	bh=kLSGNiEmPKFxQeZX+FMxnxgijCFnipoXkRfcTdx7qt4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VAT6DLYBOTmOZHt6Je1s6+9xlYHab6PrO1RwLUpIoENm+GfierzFgwxZlGUtiHH7Wmd/Vq3qM7c+aImRQCzbu0icjcqjj/lb3NbeYlvM/DsCDWz/1waDkCJWeE8qpA2KHofRNwY09gNGacOfjzjKq1SF0ZN5lSrrnKvh9siJ9V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hDyX0iUs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G2jkhIH6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIBRHGM018885;
	Tue, 18 Nov 2025 12:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uF0eqPabI+XsRb7CUhGsSZ6OXW9ocWheRY8foAPM32k=; b=
	hDyX0iUsejH1U3uuW5+vXopVJvygdd9Sc62vWAPj4j2ZNPMLXJQD7JVEnB4aSk6J
	IbiMDEtMaGQzn2P/rXbneVeYjd4Xhqzj6h2Jv4zFbI88XPbqTIQMte+YlwSzuvRj
	IZf43lje/aYUt9FeLAj2Y1QLjkAIxq9Dzl3bBMoB4iAZWBlgho5SpTey8GDsjpOl
	fiwB80ltlOwnZ41mHsGX4kos1KfBibn/E3bck9tX0ctzX4bcczWNnQTrt3/Cam7/
	jyxfuUMHbWEskbk90IAtZaRfc0qpSW2MohR/rQm0xloCI6l6ExYAKg50L17Gau8k
	S0H2Eaky68lz34x+JxKgWA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbvnp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 12:08:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIAIaRU004488;
	Tue, 18 Nov 2025 12:08:27 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8t5b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 12:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPsSh30u8JVii3cpyZDPyHj+ECutIl/1NrkFugiZ+4o95zp46NiqQbiLDd1CwDM6MEXcY3/5ZXwWNfYnnoa50gZGFjvLJ66RjOUMeNpEJg3BWEf4y8u17O3B7BVmrmEN+smueFK+s7vIubOPJg9BUZ5awcZBrVtttdyxs32bzlAF7hJhek2MI762a0FbIOPxzhroXMi3WLhK6C5btiMO1IYZ3gG4r8WfpxeQqB87p36zefZ91HP5aXEHjRNR6QFHri3jocfup/rwpBkmynhpRopO/OHjp3GhIEAKeLMylZVoZiyeyK/XM18dHiwISOpbC4G8A1Isno7fKav+a82o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF0eqPabI+XsRb7CUhGsSZ6OXW9ocWheRY8foAPM32k=;
 b=eNUXJh32RtPFhJGfQpUFmmgSdGu8EROqX6w+M+Ces8dczVns5xr5T6gnOLQ1EBvuJ6tmgSBJHlNjjlGLXkS4c0/8Fr3iXcCbQ+jMyhXowtXXZJxnGhbzdZE4z3HiNmqkz/V0ua4WulrJiUbDkKR0nXIz3R2gn4LMy1pbRswatdFHH9Xwan+D4sjXf3wg6jYYcC1MmWQ8UtQE24fSx0d6VRFLxDCtinp/3qsbhnVsvM3V8+UQE1ABbPlswwyOw5QOggyocNAhyfD2apIg3q0yaHrhBn5vroYPzwBO9IoJIV6LkEPMI9PKbQ9fZbsDkGRXaBD2+5kXy6PAV5/NAfo3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF0eqPabI+XsRb7CUhGsSZ6OXW9ocWheRY8foAPM32k=;
 b=G2jkhIH6p0Fi63vr5f7yeUzPm25RjK5RqHaq7DzxbTBlrHJpVCmO1C58LO/wQgpn/yo5cjBt2BR93Pg5uoeZ+fFvLeSvgpKfOsxL0sDDled4R1WV5cv6DUsNa6lYr7jYUoY/5Pq8a1GUXNT1EiDhHAyqGBPiGOM6HSaJZQelADg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA1PR10MB5686.namprd10.prod.outlook.com (2603:10b6:806:236::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.19; Tue, 18 Nov 2025 12:08:02 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 12:08:02 +0000
Message-ID: <d296ec97-933a-4b19-aa75-714e69b3ac4f@oracle.com>
Date: Tue, 18 Nov 2025 12:07:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel build fails if both CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN
 are enabled
To: Bart Van Assche <bvanassche@acm.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nilay Shroff <nilay@linux.ibm.com>
References: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA1PR10MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: a164f579-72e9-45c7-887b-08de269b1f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1BtWlZNaUJpQXllVW1zcEtkaU5YZ1k0NEdhbzIyVUxvSThTMC9VT3VtUHhD?=
 =?utf-8?B?S2VoZjFrTUk1MS92YVNxVW5sRGZIZ0dGSTB0RVF4d1ZIOTJJdnBianB3MldD?=
 =?utf-8?B?N2NNY0NWNkVYSkxobFBCNXJpeGk4MXZzT3pVWStVbXVNaGl5dUdzUXBzREF3?=
 =?utf-8?B?UnM1MCtweU1QNHpMWGV6Rkh3NncvMGFPZkJVZTdMbVYzdEg3SHY0cEp3QnI5?=
 =?utf-8?B?c3pHTTJPRE9pdFhDTjFkZnR3YmV5MjJNTTl5TnpadWt0ckMvZmhzNW1SY3l4?=
 =?utf-8?B?dUJ4dGR5Z3FqRGJDbVdaZ1dMamltMnVMdzdGV3dPRU9lNkVnTUM3N1puL3BY?=
 =?utf-8?B?bUExTUVDL1g0dVVVL1RiTStKTG83b0pOQ2dnNGlaMmI1YXVMei9OZ0xMc0JK?=
 =?utf-8?B?TTFIbmxpQTk0OFNmZSs3TkRtV2IrU1N2bDNmbXdKN0trMnFOMnBZN0x1R0ZT?=
 =?utf-8?B?WEY0dllKOGJrcWw4Wi9kaTV5bklEdEY3TS8wQ2ZaWmd0emFERCtPd2lxWHZz?=
 =?utf-8?B?WElLZERPNjVVdVpXL3RXY0srUHNrLzExUVZnNGRsZTBvRG5zMklrY2o5T0pa?=
 =?utf-8?B?YWpWUTQvazVJZFFSZU10d3RtZXB5Q09hM3FKb1V1UmNWdks5TUlwSzRkcUVz?=
 =?utf-8?B?L2RXUTFkcXk5ZkNPZXVORFJ5NVNYUmJYbEpRR0dGdXVlWWhwUG56L2pTSlVP?=
 =?utf-8?B?NUVJR3pOa25vVmpnWXZlNU11V0c2ZVZiRTR5d1hUNjVEbzhOUkJBZy9maVo1?=
 =?utf-8?B?clNRMVJBRlZzUXNFOVpoOTlTRnVSbUU4YWp5bnhseXBZTWduTjlSS0x4UTRG?=
 =?utf-8?B?RHZGaXh6b0V5WmV2czc4czN6WE9vYklZQU1mYjJoVTBDOTN4MmFEaHhvaGts?=
 =?utf-8?B?Q3ozN2V0azNiOG9IWlZ5bWppOHMyaVQ5ZzU3aTJtazhDMmg3UnJlVHNWdi9R?=
 =?utf-8?B?S2ZpRGhyTnV6Z25XaU11STRLTXJGS0xMTENRSWlhUGlIT1U4UlZBRUQ0N3cv?=
 =?utf-8?B?bG1aVVF2TmpPQ2hhczBWblQ2WTNGY1hGWWFCNlpvUmFDMEh1Q3NseHVCVm1a?=
 =?utf-8?B?Y05QVCtZdHVzdVNYWkxjNmJCTk0vdjNXTDRlTXo3dmE0Y1lJNllYVHZVYUNy?=
 =?utf-8?B?R2t1ZVVRdzhkTm0xcTdUcHBTMUphanhKY0pGTyswS09DN1R0SDI4QnhxQ0Fa?=
 =?utf-8?B?aElxaFE4TEtmNk9pSWlWczhaTHROa0dXSlJlNnJmMUlSQ1Mvd1FNUGNicDRU?=
 =?utf-8?B?ODN5dythOXpvVEF5VWZ0VkI1c1BTNkFiVDU2T1FCRXNNY0lVdHgvS29LRHEv?=
 =?utf-8?B?QWh2VkZhWlg4TlNlODhJY05mWExvUVRKUFI4L3lGbzNGR1ZIZW53Q0JLTDBS?=
 =?utf-8?B?MG5oUEpEZnUwZG5HaEdTclZyb0o4NDhjdG9wM2R1UmJDZ3VDejVKOFBiWmg2?=
 =?utf-8?B?LzdNNGh2TGhQd1o3bW9sY3ZHQnlpa2ExN1Q1ZE1BMTl6VURTTjlOOU1BMnJh?=
 =?utf-8?B?N3lMN1ZnR0Z1YUg5bU81VnJLTS9rZ3BzcGVhMkpKMXhPRzRZVG9kQzQ4cGl1?=
 =?utf-8?B?eVVSVXYwQVl1NHBYTzJ2TThuMzJNdkZnVmVpVS83OUQ4TmM5WVhqRmZJUytG?=
 =?utf-8?B?cFliaDBNYzVOa0hhT3NNRlNjNFYyMU1KeE1XZ3VreFhjbWFJbEpaR3N3dkdH?=
 =?utf-8?B?VHdNaDl5TlRZZjBmSXI4bnk3VnB2dFZRU20xK25IVHFmT3UxQmw3STV5dGsr?=
 =?utf-8?B?MnlXUyt6Q1NiZUFqRHMzalp0Y1duOUZNRGNjVGNmR3FWaWpZaFpHTE53b3BM?=
 =?utf-8?B?SXA1UnBkZ3ZHejU2YUtheG9neU54VGJEUHMrVm1xVHowNDBldmNVeFlmREdX?=
 =?utf-8?B?R01Hei8vSWFDMHEwOHN4Mk1rYkpKdDRXeVZyaFZIUFJBNnRydDZ4U3IvaE1n?=
 =?utf-8?Q?zu2OA7Sx4gc0Ag8mue+CEZb4P4Ps/Emg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L29WOHNEQUxRdkRxRk5oNzBFdXhCRFdwbWpzZmhNeXNRSFlNUkgvRUtaRG5X?=
 =?utf-8?B?VEZpTk9tY29YUUpCZHNaZkpMMmNPL2gzREdmTGo2cGRpUk84RDJ3QjRYdzBZ?=
 =?utf-8?B?NU83OURpNmxteEc4Vm50OUpDVXNOT2dtUTl3OEN3WmIzRXFUL1lueFVDS3cv?=
 =?utf-8?B?OVZ1RGtLZ25SclJaRGFNbXR6dVgyVFdRYmsxQWlLMkdUT3RuWjkrQlRWa3Nj?=
 =?utf-8?B?S1ZhbFZUZFAvU3BDQzRBZ2k0WktKN3QwaGlVWFRwbmhRejdzaU5ESWJ3SUlt?=
 =?utf-8?B?S3FmMFJmMzBzS1BiNUFRMWRmYk4vaGRZdy85aDZQYU5pcUxtdW84c0JvbmZM?=
 =?utf-8?B?TmtLVVZuT2p6SS94amZaRzVFdW5ZZkNjMlhXNGFjckRnOXVsenV3VENVeEZL?=
 =?utf-8?B?bTE2bHVlWlNtVys4aXIyNzUvZEh3emR5OVg3UHZoRm9hdXlMRDEyK3ZwWUMv?=
 =?utf-8?B?ZGpJN2RNTnI3NGVkUTRGcTR5Q2MyaS9FeDVLeGZRbytzQ1dyelFPSTRZZEIr?=
 =?utf-8?B?a2tiamt2WVBkY3Y0S1VVTmszMm1JcUtqS0pKRlcwejBYK0p0cUJ2VDZhamFz?=
 =?utf-8?B?RlRFWnBYbjI0UFlKRW8waGJoN2tlc1VRK044M0J1WG5FK3pZSWlMa3ZYUVA2?=
 =?utf-8?B?UmZUanN0TjVqaHpuWG43NEpKOUo5ZkNQNVF4WHg1SFJLbGFjR25MVVZvQ2lL?=
 =?utf-8?B?SWZCMlBnNEN2akV0bjBpRG1jU25FQVVGU1RsUXh6ZEk0NzdQTGxaN3dOeGtT?=
 =?utf-8?B?VWsvektBSGxwemJtQ0N2Y0k5aDgydHFibitzYVdaZlZjMmkwQnF2MXFhUlky?=
 =?utf-8?B?SHVnb0d6TEMvZ25iRUtRMkU3OGdWUEZ6MGZNME5oSlU4eWRBeXRCY3RBSnI3?=
 =?utf-8?B?dXhFajQ3OEI5RTVKSFVrcTQxZWRES3picnNMU2tmYmozMXFzU1pqVDlIZTA4?=
 =?utf-8?B?REVodVluWmpHYnkzdXEzcnlDQld5RENoMUVBSHZNcWdxT3lGdmFYMDFHejhE?=
 =?utf-8?B?MktqNWpURGphaWV0WHRTYWlzQXBNeTF2ZEJGSHZhdFl1dnU0ejBTSWw2TzhL?=
 =?utf-8?B?cTROS21OWkMrajBNWlR0anZDU2p4cHM5QWYvaUhHcDlkS2JSVGV5cE9xblB6?=
 =?utf-8?B?ZW5nUEJmQy92VjRqWkNydEpQTmpqaEY4TzJzUXd5OWJnVmxIeVhhbjVibUpl?=
 =?utf-8?B?aGRKUUQ2L0xTazhmdFVrV0M0S3FybkR5VzZoeVBRVHpBTzZxRzgzYmJYZ1FW?=
 =?utf-8?B?SVJCRkVZS2xYWFU4eWtLZnBiWjJ3WU1NY1RZdXE1alN6Ui9sQmZOd2s5VHNH?=
 =?utf-8?B?ZjZpb2xvV1ZuTE5tVnhNTW5UMmRpeVdMT2VKa2R3ZXZOOGc5QkV1d2s5aFNV?=
 =?utf-8?B?MjJ6ZHM2WkNudEtMckNya0VjRUdvT0lQTEkyVm5YMEkzcUlHbGc1Z2p2dytE?=
 =?utf-8?B?V2ZKTFZGR2JTM2NpRnRsdE5KZFlIMnhxOFRYZTlvVXM1Qlc1RGgxbkZGMTE3?=
 =?utf-8?B?L2tldU5Mb0gxNmxFZkNzdGhoaDRFNjU0Zk56Ulp2ZGpocXkxSThnMytEdFJr?=
 =?utf-8?B?UEpTSzZENXVZMjZLMDE1QmthenNJdk50MjBaOHNFMTI5aVZiSW1aWG83TFRp?=
 =?utf-8?B?U2pIeStuTXNBWWNSQzFsSXVaZ1owd2NJVEZPYmJNUDF6ZlpmQ2k4bXFlZFdH?=
 =?utf-8?B?MVZTOFNSaTVTSzAwaGN3SEJxQXdBSU9aNkhZOENGTXhDV2pQbW5zMnFzcUUx?=
 =?utf-8?B?aWE5cmN2ZFNBMC95ckZzY2VzdkJkUjArTWc1OHB5QUtEYU15WVBtSzhSRDQ2?=
 =?utf-8?B?Wmx3SStES1d1a2ZwLzNzaGhEWkRVc0JtR1hiSmhBSW1wZTNEWmFRSTZwVkdu?=
 =?utf-8?B?bEdEQndGYU9qR05Ma0RvLzBwTTMrK1Jidko1cWJxaHpBbE9hMW03WjJEOGxh?=
 =?utf-8?B?MU56L2tac1FTbGRBTkQ5L2M4aDc4MHRDVGQydHdkR3hlRDRCdEZxZVd1aTE2?=
 =?utf-8?B?UTU4ZlE5enVHM2Rib0NZZXpEc3FDalVDVGFwZlllTndaV3ZPYkpRRVdHaHc5?=
 =?utf-8?B?ME1hcEl1WnRHekdxZDB5T3dqOVNtQk0wajZSbFBtUG9EUm5QdUI5ZE9MdE9E?=
 =?utf-8?B?dEFxMmxscmRNOFczWHAxTXNSRENnMklLZU9LSlJNcXpBck9mQnNhTVdMZnVj?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1fmx/hK2EJxSeI+tn1p7irX5YJsrr+aqK7rdO3lG9cfS7/XVTzZmCTPC+1HnrvM4hj2oN4AGoNx/68BgjMqc2IQYdlh1KeYBykm8CzKsEqQx5QEEgwdvzbABIaCz1fpm6wKTJNoUHk8djdK4nLljZBwB2hWR0qIL9EC+/SKOkj2ntNsFGmqmDFG6KPjqcdpfhM8AixWWKeR14fwqfAzx6ShkLvmDE8dLey1vqqWThtxKoxktzLqlk49tdYgMZlkGAKPOHcTA6CVRhDd9kcACBlcelcxWsYY0KXSgKlb0hOVT70vb9TTJ/0wQ2qiCljFa/2HvzjWkK50pZG2mWuyM8x+mkwtDcFipL97gdBOS4W3B9zl12Y83UNMd+CUCU235gzTgOTHeSgbwm0m2D0fwdl5W8cyoD52xGLFrbepvlmsVr7TzvNuPtzia2OZMNp+OsIw3KVRozD32F2036Wu3T59f11MWrK8FzbPEU5AKA8l+D/Cmqiz5aUW8JWCHEx+YP2UTCZ+ZVEIFOXMv8q+RLFyu3Hcjkv2lIGj0s4WYbG6uw3CngHEGoKtoPsZ2nnxcq+mgVW/ovs8FhaPHU84bduk6PzF27pQmks5KwmxCkJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a164f579-72e9-45c7-887b-08de269b1f29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 12:08:02.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hw2hLIgrObDOjESLZ71OHsIa5azZ+5ZOqdWLmujVRdyo7oyN8HnHzPZC2oxPKKaT3Eszs7J+nRhLWA1Ctf3New==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511180097
X-Proofpoint-GUID: 5C7hYvuXvZY3E3vH1wb3r_8sBhrkTKSd
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691c61bd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EuBOgC_IxCKCcqtj-RsA:9 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: 5C7hYvuXvZY3E3vH1wb3r_8sBhrkTKSd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXwfb4f8Gos4oJ
 ZsU5cjmVVo/l/tuyGZ6toPge3AwgaCjbVnnBDGIxHAx3qKrIn1xB7tC3LC+yRw7Y3fsOpb0t6xV
 scWZxEmNrRSeyggBWbCZc/hBBCCClOv9nA6brJmMAnUkVcXfyswmf+diiN0WCZV7XhHSfMl6/Fh
 BGGSvShsmUu9tGWGJwT73apF+KkrHHuvTHRXlmsBRe+9AZ+BN0WgMBU3XhYoulWvTUpLXph81kU
 k23HNO0cBdy+p2tfcYsEQOq0w3nuUuc4QfCvhZflEZcR6qlmpjyMivUZRKNClj5fzl01nGL+lCj
 Bex8AhqkxtMcmqUM2s5s2v8eH89bZz9aehEjJJJG8dTEU0UACl8YmLvCZGNZc7v+Yh9r1A20ynS
 OIR6i71MdoqnArVczdu7HtJCo3t7jg==

On 17/11/2025 20:40, Bart Van Assche wrote:
> Hi,
> 
> If I enable both CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN in the kernel
> configuration, the
> kernel build fails as follows:
> 
> $ make
> [ ... ]
> WARN: multiple IDs found for 'task_struct': 107, 36417 - using 107
> WARN: multiple IDs found for 'vm_area_struct': 271, 36434 - using 271
> [ ... ]
> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> make[2]: *** Deleting file 'vmlinux.unstripped'
> make[1]: *** [/usr/local/google/home/bvanassche/software/linux-kernel/
> Makefile:1242: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> Is this a known issue?
> 
> Thanks,
> 
> Bart.
> 
> 

hi Bart, thanks for the report! Not a know issue to me at least; I tried
to reproduce it with pahole v1.31 + gcc 12 and no luck. Would you mind
sharing a few additional details:

- compiler version
- pahole version
- full .config

Thank you!

Alan

