Return-Path: <bpf+bounces-29652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD098C4652
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 19:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29296B21671
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3602224CC;
	Mon, 13 May 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jSFvxQ/V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Obep8iDm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80820332
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621994; cv=fail; b=L1ed/1w+xV8x1lIt8rZQpdLqHvdV7kU4uuRlC2OeEW0nkADPgeqVmbdPl6pkg+3VPjd5ThsVgbEBAH5V5usAISd765UtyhivdofMfXFJf3WvCa7qZ9clXaHbzCR4Z06HKyl0JOgsDQihW5FYMPAzAbj+qkp/0TW+inIuyxMPSck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621994; c=relaxed/simple;
	bh=uzr0ltleOg2HtXjTKFfmmEp5/py9QSm+2ugPgq05/EY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WOnyY1xhbHupogsSWuU9KOM06co8n5EBCXK1ZdckEPnZ/DGgBKiDSwj0XT+5kyHEtyEp/HqXEex0OPunWZVvoJDFQ9zUKMQs49pnnadvJCKwtpxVD/ZU5tI1Y8VZMfvYESBRDGUqEe2Yzi2xBvEL8Z1sj2iNc2zh1KYeY8Yz4e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jSFvxQ/V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Obep8iDm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DHalim026418;
	Mon, 13 May 2024 17:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=t0syhX52Wm4OeFZ8xwVpUGNnkNVkXdk1MRDVaWghkoU=;
 b=jSFvxQ/VMU6pU3gvV+V4DL8R9F2agcmZrk/OsusIeOQSWlqTIOYcNNYLKKHrG7KPVfdr
 uX9R3Rfev2ZvGAVMFovXdJSdeLPaf5kS4nvfnH+mWuTdoqyvN8MgUAsjgUFB1sgKdWX/
 /5rp1ImNubqaK/xjv0VhwsTlqNk2Kyb+daEMqKM6rUOiv0SgFlEs13B+AE/WVImk9zUj
 9xyfXsrw5JZDumapf3DrtAjpj1UU+/4hfS7m2PWC/P1CcaJzpoQcODU8+1zfZw3tTJpE
 vL/17FEr/o0XyETXP9REiaHxUTkPuUY+BOahcHUahjGt+dPHtY41y52J1zOQpHbHlYtI 3g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3qdj00d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 17:39:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DGFdmx017264;
	Mon, 13 May 2024 17:24:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y463hnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 17:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyKYrsQKvwGoN4EIoUAWYc6Zy0OdkGLZY/7EqfVNkeFwomDqmfWeE0RjXZikjL2VNcTuPqUpfbgYabGkHzxnuQhenSIDyYeRPTQu2McImR/jvXpi51uNCbBfKGQOts15M4bAELf5um0D6AtkpvaMohRYTLXzk6c4hI0SP/0lRGlJgYzJH2KHpY26H2A67vBzxlaCoWcJHqRQY++razF5hdaNEXSHfjv9gPC+J2sQL1gkH0UIt9/jng3+AlWn2bcfa2IBCyP1o4wifUlTU7w53GRi7Zv+gOcFrvp9VglPWi9Fbs4m6MCvfJyYnHCHqTUsbVP1tDAJ31I8t8StY24alw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0syhX52Wm4OeFZ8xwVpUGNnkNVkXdk1MRDVaWghkoU=;
 b=Wx5oSeaL4FrqAlGp+9FXYkhqHYmZSqz9cyncprPyYwdOTWkhiva7WSksEO8wqKBBwR8P9MPWhxMFiLB+xg6y+BFj9+rgzhdkYtZXezWAdD82DPWcTlG/+XVJXYc/cAgpz/hZaU4XwzqvKaMu9FtPE5ENXb4vNGaUuVhTKmSK24bE8W0vEGQ27ExFBp47lII6Hcc1IRpK19u7k7MpIdIFe1DYTPbWJR1rAyKY8qC4AHzwg0dDYoVlIufMNIBY+tKBp2mss20GZ1ljhc+8dzXm7cFCQOnzh1MdWNawcJaVCiCF5YgNL11IlBHB6u2bZz8oblttLGN+eOOcRPf+tEo5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0syhX52Wm4OeFZ8xwVpUGNnkNVkXdk1MRDVaWghkoU=;
 b=Obep8iDmujS/5azSs/z01LWGZpYlzT6ElM6A4MoHeLYCI2NqbfMBLttOjZeZRcrO5OHHIGKCUE1ucrP+mbfb8NdnSAaxX+03HxUSmjmSvU4oBRt5XFO6DKmwTbKxwvysOL08JE5P46+M7X7pdr2fP2bnb2Vs8r5LPxDRVaTK0gQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BL3PR10MB6139.namprd10.prod.outlook.com (2603:10b6:208:3ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:23:58 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:23:58 +0000
Message-ID: <57424cd8-c656-4ca0-80fb-288f83156ec9@oracle.com>
Date: Mon, 13 May 2024 18:23:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 01/11] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, jolsa@kernel.org,
        acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240510103052.850012-1-alan.maguire@oracle.com>
 <20240510103052.850012-2-alan.maguire@oracle.com>
 <cdc19260a1d1e37649f64bab731c21cb4e5422ff.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <cdc19260a1d1e37649f64bab731c21cb4e5422ff.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BL3PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: eefcf910-ab81-4bc8-3130-08dc7371790d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S3F2ZzlUT0Z0a2xHZVJ2M2VFWGk0dDU2bE5aS0NGYnZ5bjFPTGYvYkpyMThr?=
 =?utf-8?B?VVlTM3JYd3pSR25CNHZvdVJ5VDVUUmhoT2lHR2JEeTNlYkp3UDlUSW9IQWEw?=
 =?utf-8?B?TkZERlMxQnJzS1NoaUViOEZzdkZWNzEySGRINGFacG8zNk02VEgzTFdiRDlI?=
 =?utf-8?B?UCtRdi9TYnpGcUtqK0Vzd2wxZExnVnNTRXh5TllKbUFVbjNjZ3BlTlBtN3Yv?=
 =?utf-8?B?cnloMm9wcERTUldEY2ZCUmpJak1KS2xuc2VnWnNPdnFyUm1pUFJ4dmRmVWtj?=
 =?utf-8?B?bTRQeTJudGNmbmdIWGs3TitNeHJ5TGdqMm16VG1Mb1c2UklVa2lVdVlta3ds?=
 =?utf-8?B?SjV0SUhFSjZEZFNXcWIwMjNBV1h4cGxMNTJLMFV1Y0hkUXorYUFDNzhTSEpX?=
 =?utf-8?B?bFF6OStSZUx0Q01YMWhMdjlaZ2dxajZkVTdGRUVza0FOa1kwbmJoWHlxQmtO?=
 =?utf-8?B?YjBxS3F5TVNiMnhiYUhPOUpNQndIMVdPRkxVSGozT0lhcTEyeEllclFIdWhB?=
 =?utf-8?B?Tk5OWUFEVTVMTWVTUE4rRUlRd0l2M2d4QWw1eEhLNkRCQ0RUYWF3SzJWM2hL?=
 =?utf-8?B?VFBWZHJ4ZjV5a1ptN0RRRFBOQXc5aXN1OW5VSGcvZkNTNjhieUx3MkJTSHdH?=
 =?utf-8?B?QnZNMms0UGgwUWlFNWNiZXRjNVkzSFRRanBtQjlsSmliMHJTMVQzOWE1S2dK?=
 =?utf-8?B?STlMcmp1T3YxWFpSbUtObktCM0FKV1d5bmd2c1JGNllnN25vbUhtOVFFNFhN?=
 =?utf-8?B?Sm94WFhTQ0draU56akVXcThzZzZ5UHliNkNYSzJ2d2FkSVRLSEZQajhndGJQ?=
 =?utf-8?B?OTJISXB5cDBGVDNva3l6Z2pMZExwbW9mWWFnM1M3SFlZTnJvZW8zRU5nQ1p6?=
 =?utf-8?B?WDdGS2JKYUZ5eHp1RitCeDlJbmFyU2loQnQ4bHk3QzcrcHRWYlNtRDZ0VGJq?=
 =?utf-8?B?WHRZeHF2VjVrNEdRM0RHRXhqZTNhaHhkdDUrZTNvT0oyRCtXSmpTUUwwMDU0?=
 =?utf-8?B?NlF1cFo3OHhKTmt6aERmMGUzeHlUTE8vOGZsYXVwRmRYUkw0RS84bjZvOHBP?=
 =?utf-8?B?MUlBYVhhQlJiSWE4ZjRaZm04OG1pSmNONzVxelY4c09yQzZBSmtZZHBaRU1r?=
 =?utf-8?B?em5HajRsejl1c1BTcEFFZTg5M3hNWGVQVjhaQ1BBNHQzc0d0RHYreUVVeGlL?=
 =?utf-8?B?UlpxYUVESnVDOUg1Y1hIR2FWSkVtWDcrOWdWeTJuN3pNRnZEQWgrdUNmV2cx?=
 =?utf-8?B?aVovZmV6RTZnLzM4ZVFmcVQwdmkwbEs5dWcxd0p0NGxpY0lkbmw5RGpmV3lj?=
 =?utf-8?B?WlgxSHVQUVd4TjhkbTJXNXhWUGRsSVhEUm8ycFZNaGx3a1lobWpPMGh5WEFr?=
 =?utf-8?B?cUd3VEZOZm1HdnI0dkpyUCtiREdCVHlaek5TK3YzaFY0b05TVlFWd2lTTFBy?=
 =?utf-8?B?dHorcGRmMWpON2lzU0xYYnJzTnB5TUhkSk0xc2xYeTZVa29sNTBsK25lUlZJ?=
 =?utf-8?B?eE94UlQvQmhKdHppRmRXczdQbWJ6RnVKdzA4TmlhK3psRk1RaUFHM0ZWNTVo?=
 =?utf-8?B?M250ajZjeExEbm1qakQ5VklvK3JadGRTd3lCcmpLQ1JKZFArQ0g0aDRML1NK?=
 =?utf-8?B?b1ZQcXdvcmk0dTJ5Q2R4Qld4UTdqdGUwL3M2THlvUW10MGt0WkNINmxGZTk0?=
 =?utf-8?B?dTFwK0pNUlVOTi8xcFowaHVyWlNHTEgxckdLdExGeXdFd2ROZUlSRnVRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmVuTWw1K0diY0FkcGFaSXVRMzhOaEw2cENtaVNUSUNVR01pZEEwU2tVdUZk?=
 =?utf-8?B?Z2t4QjhSNjFhY2JBc005VjlZV2gydERYb0hyMzZzUnVCVndscDdLcGhBaUsy?=
 =?utf-8?B?ZDR4eGxyYmwwMGpGNzUrUjFEbkZxNWhHQUNwaFR4OWJVYTZ4Rk42VGRoOHBZ?=
 =?utf-8?B?TUg3NGtyYzZtRGtBaWRHMFJUUUpJQm1rWVZQTnFJZzNIZTE3V0dvUmxaWDI1?=
 =?utf-8?B?RWZsZEJLanNXVkxvRk1PaUZlZFNpNHJJMlptMWM0UHp5dDFxT1dZVFlySkFu?=
 =?utf-8?B?NFNsM1RnSTdMckdsRTVNU3B1T3lvTXhQSWphaVc3RmJGSjJiQko2cEVYQThv?=
 =?utf-8?B?NnUwZHM5V3Y5WklVU2lrV0VSY2dDdGtESlJiUlBIV01HMUs3Z2xxMmx1UWtu?=
 =?utf-8?B?QjVGby9LN0xidFZKUUlIemREaW56UE1VUlNuQkF2eEFXMjYxMmZsVnNyNFpv?=
 =?utf-8?B?QmNEaW9WUlIvald3NmYyNGE1Vm5FdUlFaEFZMUFxSElBakJ4NEhFOVZzc1VD?=
 =?utf-8?B?WFBBWTBIU1Rpay9aVmluNmczWWUzLzMxM3R3cjRBRWtlZ3ZleWtUT2RJSmI1?=
 =?utf-8?B?enI5WW55eTZFKzg5M1hnOUdManhpUWRUeXp0UmNFK2oyOVVFM3lxbXNUYktH?=
 =?utf-8?B?ZnBKNGNMZGJuTmRnVjB3RE80S0FHRjFoN1hqNzd3dkd0RXgyUDBpZzlYTDJw?=
 =?utf-8?B?ZU9oL2VnTlFKdWp1SC9BbVNRbjJxU3c4RzhaSW11NWJuRThQM1BOeFh5bjhi?=
 =?utf-8?B?dlVxekllVHN2QklxalFLRVp5ZkowVWtNV2Z4VkxERkJYc29IUkc5SCtEeFdo?=
 =?utf-8?B?RzB2eXdzekd6MEo2MHlWVFVVR2JkdzhZVWdqSGJ2ZDcyaGtyTDNwK01NcXdN?=
 =?utf-8?B?ZDhaTWVWYTFMZUVDbU9CU0s5bHlOOWczbnBvaUFlVUs0MWpJMGlad2FyKy81?=
 =?utf-8?B?T0Z3bWt3RFFMVTBYaG51cFlPMERRM1F2ZUFJSzcxWXJHY3poemEwWk9tRHRU?=
 =?utf-8?B?UFl5R1I4dkRNOFZpRG9CMFlKTTMvejZKbk1jdkVERmo1YzBFZGxrcVhkMkdM?=
 =?utf-8?B?NldIWjIzK0hIRUlrQWdhVHBGU2l6eDk1OEpMcytZbVNoL3VXRGdMRDFGMWJL?=
 =?utf-8?B?enVlMDhrRXBSRzR1bjZZckcxOW1UYm4rbFduaXFSc1k0TzRhZi9naTUra21a?=
 =?utf-8?B?MkdYRXhoZU04a0RCbWx4VmhYYlZRenpHakpBTzdYUVd3aFhBaVkyUGk0SGto?=
 =?utf-8?B?d0RVN29mTVY0Zkxxcy82YVZhakdPUVVQZlN2QnYweTdXdXNxQTU5QWhDYSt6?=
 =?utf-8?B?TEZxNGZBZkNuT1FQeUQxMmJBSWltWXJER253ZGNPcSt3eXYyV0pmcUc3RmFN?=
 =?utf-8?B?SWY0QTF4TllCVUczQTEwZ0Y4bzczK0tCYnlkR2o0QzQ3dVdzT1c3dS9tY0s4?=
 =?utf-8?B?aVpFRDIwc1JQV3dnUmZydU42WjRvVUdib2Vsd1NnQjJxeWJ0RzdFMFdYOXNE?=
 =?utf-8?B?T3lKK3JDa1ZsTnExSThWWmhReFVEOHh3bS8rOU1RQlVTRGVHUHp3ZDNqNTV3?=
 =?utf-8?B?T2NiN2ZCY1dnNllleHoydzBpbVFOK2Jzb2dwcUtXZUlFR08vWmxrajZ0aEV4?=
 =?utf-8?B?Vmc0cldSL3dpVlhGODlSWXVvRXFsSXhzaDNlWXBHU3F6RE5RQjZVMGdIOHY0?=
 =?utf-8?B?NHRHN2V0dWtZVlU1UWFxdkJWQXhBSlEwQWdOWnFhVjRPRFRZMkxzc2M2T01N?=
 =?utf-8?B?bFMwNmNuTW5QcW9UeGFqTkxTWUQ1Y25rR2x2V0JVLzk2ckxQMXVWMlJxR3pJ?=
 =?utf-8?B?STFZdm1aYkNsOGZPRFZ5czk3OU05MzUrNHFNS0x1cEZJUjBVUU83MXowTE4r?=
 =?utf-8?B?YXBkUTNndE50YktTZ0QvNm55cVllRS9nV2JLL2lpWmI0OUEvRk9PWmdoZHp6?=
 =?utf-8?B?cUNEYnphRUZSQ3hLWGZuQVhQR1ZiOWdUbUVVOUtpcWZzaFlCdEZ1cjg0Sk9h?=
 =?utf-8?B?QW1VN29HL3Q5YXh2eHA2R3U3SHZLaWFJRmE0M244VExtVE5uNFBRODVMWmk3?=
 =?utf-8?B?eHlUUVpLK2t5a2FyZU5IM0l4MEh2UnhYVU50MUdSV1VSSlhpQzF2SGlIM3NG?=
 =?utf-8?B?dWtrbWtucFFMZlUzVUFQRDcyeDVjNUdYOWx1ejJ3WDI0WkJWL3JNMVRMWkNK?=
 =?utf-8?Q?Nsl6jgagXrv36p6JVeU7yxM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	te2Oiwig8OjAPqzMEdZ919ecdCOpzNEl/PMmIzM5K7H089i8jESD4OGsLJtKp42bfh4CwlTp4kp2+2EOK9MmznLcM/vtUEvMO1ZhcjtsvTh6cKXQfAd+uD7MMGLC6loxNcC1HFPPQsJaMvL865aqLqlaadGHG3S7vFa8lxNivuq6bgK2XyHUxGrq60BPn7sJPqM08iXnJ90OIyZhkHbW/9FY7nJTcguWa97Zs9CdSUpwUdDdITH8j/LU2RuobIH3opylJFEFecs28ZYOEhSx1dYzDLYLmfqFkdtn1Iszce95+1Y0Oy0ZEv5oyr1jSy5XIyA2XqhRDrb2bNDWinJIeBLmsUfT7jr97BkRzDUchK/XWjfVKSu4CbGRz3LgnADa7suucopnfgre3huDkFXm8+LFHL8CAYb/eg0N7OROhCK9dT+ZRegtShHhzfs6MoYhaj7RHBNYzFZdXf5TqMot+4vWI23txohEbicXgztiBpXk9+YWyvQRqq8x3v28iS6Jz28FvFIyKi4P4nILuTTE3b6Txm616+VFUkXV6MnDakkOMoyTST7e4AtMRCl13vnxUhYNZ4e1yOtpqIiMDKCkwgTr/w0u2q5OnsxaQWUSbOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefcf910-ab81-4bc8-3130-08dc7371790d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:23:58.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aid9hn/iR1lfsFB0hSMmTOum92TNGJjaqloNGXyPDyZyj3lb1zioyTPiiKX16IfO1s6n3Dw7b4C3ZaRy9zmRag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130115
X-Proofpoint-GUID: -oSMi1YodsSYYuUEgvS4t3x6TP9uywfQ
X-Proofpoint-ORIG-GUID: -oSMi1YodsSYYuUEgvS4t3x6TP9uywfQ

On 10/05/2024 20:14, Eduard Zingerman wrote:
> On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
> 
> [...]
> 
> Hi Alan,
> 
> A two minor notes below, otherwise I think this looks good.
>

thanks for reviewing! Replies below..

> [...]
> 
>> +static int btf_add_distilled_type_ids(__u32 *id, void *ctx)
>> +{
>> +	struct btf_distill *dist = ctx;
>> +	struct btf_type *t = btf_type_by_id(dist->pipe.src, *id);
>> +	int err;
>> +
>> +	if (!*id)
>> +		return 0;
>> +	/* split BTF id, not needed */
>> +	if (*id >= dist->split_start_id)
>> +		return 0;
>> +	/* already added ? */
>> +	if (BTF_ID(dist->ids[*id]) > 0)
>> +		return 0;
>> +
>> +	/* only a subset of base BTF types should be referenced from split
>> +	 * BTF; ensure nothing unexpected is referenced.
>> +	 */
>> +	switch (btf_kind(t)) {
>> +	case BTF_KIND_INT:
>> +	case BTF_KIND_FLOAT:
>> +	case BTF_KIND_FWD:
>> +	case BTF_KIND_ARRAY:
>> +	case BTF_KIND_STRUCT:
>> +	case BTF_KIND_UNION:
>> +	case BTF_KIND_TYPEDEF:
>> +	case BTF_KIND_ENUM:
>> +	case BTF_KIND_ENUM64:
>> +	case BTF_KIND_PTR:
>> +	case BTF_KIND_CONST:
>> +	case BTF_KIND_RESTRICT:
>> +	case BTF_KIND_VOLATILE:
>> +	case BTF_KIND_FUNC_PROTO:
> 
> I think BTF_KIND_TYPE_TAG should be in this list.
> 

You're right; sorry, you mentioned that last time too and I missed
fixing it for v3.

>> +		dist->ids[*id] |= *id;
>> +		break;
>> +	default:
>> +		pr_warn("unexpected reference to base type[%u] of kind [%u] when creating distilled base BTF.\n",
>> +			*id, btf_kind(t));
>> +		return -EINVAL;
>> +	}
> 
> [...]
> 
>> +static int btf_add_distilled_types(struct btf_distill *dist)
>> +{
>> +	bool adding_to_base = dist->pipe.dst->start_id == 1;
>> +	int id = btf__type_cnt(dist->pipe.dst);
>> +	struct btf_type *t;
>> +	int i, err = 0;
>> +
>> +	/* Add types for each of the required references to either distilled
>> +	 * base or split BTF, depending on type characteristics.
>> +	 */
>> +	for (i = 1; i < dist->split_start_id; i++) {
>> +		const char *name;
>> +		int kind;
>> +
>> +		if (!BTF_ID(dist->ids[i]))
>> +			continue;
>> +		t = btf_type_by_id(dist->pipe.src, i);
>> +		kind = btf_kind(t);
>> +		name = btf__name_by_offset(dist->pipe.src, t->name_off);
>> +
>> +		/* Named int, float, fwd struct, union, enum[64] are added to
>> +		 * base; everything else is added to split BTF.
>> +		 */
>> +		switch (kind) {
>> +		case BTF_KIND_INT:
>> +		case BTF_KIND_FLOAT:
>> +		case BTF_KIND_FWD:
>> +		case BTF_KIND_STRUCT:
>> +		case BTF_KIND_UNION:
>> +		case BTF_KIND_ENUM:
>> +		case BTF_KIND_ENUM64:
>> +			if ((adding_to_base && !t->name_off) || (!adding_to_base && t->name_off))
>> +				continue;
>> +			break;
>> +		default:
>> +			if (adding_to_base)
>> +				continue;
>> +			break;
>> +		}
>> +		if (dist->ids[i] & BTF_EMBEDDED_COMPOSITE) {
>> +			/* If a named struct/union in base BTF is referenced as a type
>> +			 * in split BTF without use of a pointer - i.e. as an embedded
>> +			 * struct/union - add an empty struct/union preserving size
>> +			 * since size must be consistent when relocating split and
>> +			 * possibly changed base BTF.
>> +			 */
>> +			err = btf_add_composite(dist->pipe.dst, kind, name, t->size);
>> +		} else if (btf_is_eligible_named_fwd(t)) {
>> +			/* If not embedded, use a fwd for named struct/unions since we
>> +			 * can match via name without any other details.
>> +			 */
>> +			switch (kind) {
>> +			case BTF_KIND_STRUCT:
>> +				err = btf__add_fwd(dist->pipe.dst, name, BTF_FWD_STRUCT);
>> +				break;
>> +			case BTF_KIND_UNION:
>> +				err = btf__add_fwd(dist->pipe.dst, name, BTF_FWD_UNION);
>> +				break;
>> +			case BTF_KIND_ENUM:
>> +				err = btf__add_enum(dist->pipe.dst, name, sizeof(int));
> 
> I think that the size of the enum should be read from base BTF.
> When inspecting BTF generated for selftests kernel config there
> are 14 enums with size=1.
> 

good idea; we can use t->size for both enum and enum64 cases above.

>> +				break;
>> +			case BTF_KIND_ENUM64:
>> +				err = btf__add_enum(dist->pipe.dst, name, sizeof(__u64));
>> +				break;
>> +			default:
>> +				pr_warn("unexpected kind [%u] when creating distilled base BTF.\n",
>> +					btf_kind(t));
>> +				return -EINVAL;
>> +			}
>> +		} else {
>> +			err = btf_add_type(&dist->pipe, t);
>> +		}
>> +		if (err < 0)
>> +			break;
>> +		dist->ids[i] = id++;
>> +	}
>> +	return err;
>> +}
> 
> [...]

