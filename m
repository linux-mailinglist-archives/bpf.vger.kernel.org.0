Return-Path: <bpf+bounces-20621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F58411CD
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 19:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65071F23C49
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3A3F9FA;
	Mon, 29 Jan 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eRMaFNJq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y376eL8D"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0033F9DC
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551968; cv=fail; b=CZhrJmDD47LvSp5mNg3hNwcdKqoolYDZYLWzyGUtLdg/BlCPjRz3BhTzyd99edv/KprXOB0byfiVxo4hOZtbfdQFeLr/oNu08/S/9XmWJIuzfSNv/b3+FHsfMxJVFHIA8D8lV7xbkLjxfNR8OTDL0L8CmXTINXzNXHA3Wt+9Pbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551968; c=relaxed/simple;
	bh=P8Z6VHX9Qf5g5qQQF2UTtX+ZBapZ84scwgxHi5cjxYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KPTTyip+MJvbuuVTaIR6zgmBZ23j+XHGZQ6684S/u4Y3ikeLgaVA5DoLaZ7DOhJuNmN1jGDHw/dAmxXp6XWlIdP+a/8NpOvX+HvwZu7FiyvZOq4Qz5QJwMB89E47j+JHrPPhjTpUbX2kSgLTPAzib5xItkjW79EocH1p39HX/+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eRMaFNJq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y376eL8D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGnBKX001211;
	Mon, 29 Jan 2024 18:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EKt5E++pGKllU7iGK6xOQ1OaTKxwJyfNjGwvr51uAE8=;
 b=eRMaFNJqwBYykG41PYfpZhhODwexJ81NgkCPUZKkmVP3CSgnsMibtoDQXtPGPWzaUegG
 z/PbmFFBmCiaYcjWq6qFLOHpUPI+FoDHS++TeYECjoUn3UIR5nJ9BsVnDQah4Au9K+w8
 Nwb+AWy4LL1o/qpFU3N/khyY7rt365tHxSyqloa+hnJtuCgQ5deowhEl7WPSKvlvZy+y
 N/2/YAZMOHQ1DVkpuZFrk1in5cZnL57DDKVMgH6sWorD0V9Aj6cknzDToqUs3n6t/aHj
 vNbWjY5j9TQjGp2IyBvYk+l3y5uCnAkiHeHgDc2PTf90Z3VwgwZUEbKCW0RvIK/Qq3n+ LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqavjpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 18:12:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TI1dA1035440;
	Mon, 29 Jan 2024 18:12:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9c121a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 18:12:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdEKHV7redJ2L7AIFPir6tvXOMCEbzA7kRQ3lr6W71rUF4uHoIgJIM+Y048Gt+84H7Ys6pmoUyvH1lPKkyM9mndBGddicCBBySqf2ga+cB7LUg/RnwUqN1JMSMWBmybKv7kXTnTbkMvtY+AAHrndZDWqzrhWCXSLVs2Xv1DyMBMI9k1IYzT3+S3bF9KeOGD0jeVCIn4EKjp5c79lfSVw1rFeZTrgweMoA4TdbUMJqnGfPhXXeTby8oHUjAjkkM3Qg12kuKrsKD+rPWGfZoa8GO2HNNSA8ry7l21X/+At5knenXeiY267SP84TA6dZKk1VWmYq9zYv4a+RtUpumHOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKt5E++pGKllU7iGK6xOQ1OaTKxwJyfNjGwvr51uAE8=;
 b=M86kM6IetrYDXvDTBKYC/QY/3+OjSsyeROAeVmdxxPWGwB4bL6eWzBT/3qTw59Pj1T8ij3PeapVgiRtAx6yGWb2w2VQjZnjFu+Cv/RdYhGTA3bDOB407JMQaS3qflgosbs/UUPUPMVfbEGW4zB6oXaIAdYe/kzw2yqJ/cxVcIJ0ZPQUhdLXqjSkM2CqxaaMAkg4LV8U728mxg4G/hlNZOWNpunAUjaJVggGvGW6kjDMtqrubYxvIHPmw2pmfOVHF2z+jvJQZuWCSZi/HsAOCT5g+3w2uHF3XyheeRsMMYeKVU1Nfea18b+mlUWaKtnC0/nVqTmBIuTP2nGVJYPsohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKt5E++pGKllU7iGK6xOQ1OaTKxwJyfNjGwvr51uAE8=;
 b=y376eL8DzPNlBKNm4zldK/L0sTXATWlhTZ6cdNg7kkZrDdvRwP0sL9VX8D4WqqB/v9jiFAr9krDKZHvs6+eaGOR64KosxW4Svtxg/uK8ZIUs8kLOHrtZRFp/RIMQ370iWByClTv/pn0YIibLkIMDh59xUnA++KLPxTsPxRmBLk0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV8PR10MB7751.namprd10.prod.outlook.com (2603:10b6:408:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 18:12:19 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 18:12:19 +0000
Message-ID: <c689e4c1-922f-ee17-b7d3-bb642950080f@oracle.com>
Date: Mon, 29 Jan 2024 18:12:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH dwarves v3] pahole: Inject kfunc decl tags into BTF
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, jolsa@kernel.org, quentin@isovalent.com,
        andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org
References: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>
 <49da8aff-1ec7-b908-2167-ee499e7a857a@oracle.com>
 <Zbe1DfHjhZHwIKha@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zbe1DfHjhZHwIKha@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV8PR10MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 592a663d-b1f1-4f88-c9dd-08dc20f5d4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qG0ZGv+6iPCDxiT+3u65ohVkzolHCam/QUAkUNN1YMl9hH0KMSEv/BtDGZKKNQTm0ihQBibVBUwlzYdJuGC20X3DW8P/6W8qF8Qe/Fvqux2wWE6x9+TQXM8Gf3fV5suGcWNpk1b/ExCKJWY4KaQcUm0YZXOqAb/EFOZChs63M//XGma8Wxrcaj0zv+VteR2GneZ5KDNhsuqNs9WaJW5JyBV6uIoxCzWAqsFXQfNP6BiAsGQtTd5L5ZNidg0sRNnqdmLLuBzOtbjzsOXxx+6nvyfJ+kt9u6t7er1TOXWGrZAHjYdkaeTqG7Z60R9tU5usWLSzlyxhArN98WWoC6uWUS8y6+zk7pxPWvbPFYik/mRZLGEMgpJ3+ePz5YD7nLwt46ZSCkN8I4utK5aUMDN1I2uNRW3fJ8vEN2apQZtEqiaubWzn9E9VjJqeVAuhkErQH6dfe8Jaa9b9dLIH8Qk7TTOYXtZAd1LgxTjvoUgclFHhHCeDrmhIKVWPgCRoaOH7bY7taJbXhesfchI+pr7vaJs+Ps7mBfKczykBYKbvkPV9ArvqK7o8goqPH9fdMXKFxvVHbPAKPPP5JJ004rffzrXQ4wkhM1ZcAiHBHEPWbS22bPTLQXeTITQI04Ujkp4KbFuiFMflS3didMLzF6A0Pg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(6506007)(6666004)(6512007)(53546011)(5660300002)(44832011)(41300700001)(2906002)(4326008)(478600001)(6486002)(8676002)(316002)(6916009)(66946007)(66476007)(66556008)(8936002)(31696002)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEdPQlYrdDFEU0JmMEU2MVlLYXM2Tk9ONmt0S3FRTVU1TkNUZStqeURicnA3?=
 =?utf-8?B?M3ZOVW1JTmZuTm1McGovb1F5WGZBM3FPWTBKSEx5Y1l6ZUdyOEw2SVNNeU1q?=
 =?utf-8?B?TVcyN0xZbzdCZlZSVHg2b09Uc1E0NlJObzRwM3dXaVpJbFpTNGE3a0N2TDJz?=
 =?utf-8?B?bzVkakJnOHdGTjBOZWl1M21pazlVdHR6dWQwU0FYTjdVN1J3NmZrSnY3WkFs?=
 =?utf-8?B?L09zWThhSGFyUGk0eVhIZjJWbDlDMEY0dGhwVWQwaTVMeGI3MGhwcFVpcnUr?=
 =?utf-8?B?aGFWWW1hUHg3SlgwY0ZCMkV6ZjNhYmNUSGVubXdrYTM0ZHd6QTh0Sk9iQ0pH?=
 =?utf-8?B?Z0t4N2RwWGpqRGFpVWF3VUVoYTB0aUxSZGwxSU5nN3VvcVpNN1hZZHQwbUpt?=
 =?utf-8?B?RFNEV0dIUm4xamZiejV3aTBFOENObFpFOEpvdm1BSjlnZFQwUXg1aWRnSFls?=
 =?utf-8?B?ZS9XaWFuUWZtVk9vZFJnamw3cDlsK1NRalhBcXRnVTljMkQ5VHhPVHRBamVt?=
 =?utf-8?B?eW9Ddko0TEZkWXZ1SUJBU1VNbU91RzJqZUY0MStYeiswckpqMWVEcUt1RW1T?=
 =?utf-8?B?cjdKYWg2ejRhazM0bjF4NEtpbS9iOGJrbWYxNlhoRTlhMkduZnhidm53VFg5?=
 =?utf-8?B?WWlJTUZ4a1k3S3VPVHdIUXFNRURvaDZWS0xrOFBmVmFpOHprVU1rYURyVWtM?=
 =?utf-8?B?Y2NhaEkvckRiZWFzczAySlNlSDVRT004eDNLZmEzWXkvTUEvcks5aFpSaE5x?=
 =?utf-8?B?eDZuWUxSR2tsRzVjeFlURS9ONTVlZGpCTGc1QzAxQnF4WS81d01iY0dHWkdi?=
 =?utf-8?B?VTV5bGJ2NVo3U1U3WThWUDgvVXRJMCtTNi92RzJiVnBiWTlhVW5NaWt4a0ht?=
 =?utf-8?B?THJCeTBqZVdzSDlSOGx5OUg4RTVMNHBJWUF5L012SElKalAzcTNwa1B6Wkp6?=
 =?utf-8?B?VnJUd0VtNWpUTVVDYnhReE1kVksxWjBvT25lY2ZMeVc4VDh5cW5EYUlFZllP?=
 =?utf-8?B?UHZTZ3MwRnRUV21EQjYxQ3VocURXZzNLV1NleUU1VVZJbjVzSVV1aWRreGtn?=
 =?utf-8?B?SjNzMytPaGhQSmM3UW1PcU9QYk41TW5ScGRKam5UWE5zTmxnZlNQUVZzbnRL?=
 =?utf-8?B?SjNubWlsY1dYTHcxcVVJNUIxZHFldVQxcVF5bFpIcnlQYXRiSEYzcUNGTGpW?=
 =?utf-8?B?aXU1dXV6bkNxNUZwWWl5elZpY1dnVnN4a042SnRlZlhIaXRqeFh2ZVVYU2RK?=
 =?utf-8?B?QWRzdVdFaCt6c1U2RUJkTG1FQ3I5Z3hYMjY5M3Q4a0NSU1UvSllubEovdjdH?=
 =?utf-8?B?WkRvVHR6QVg5OE5JQkFpQzdKZ3kzL1k1Vk9oRnJhWHhCYVp5RFpKWVN6MXJ0?=
 =?utf-8?B?WFcxWFNlbGd3ZUdYZGNTUm1KMWxYUTc1VURYVWpvVUJhL2ZGQ1UrQ05Jemln?=
 =?utf-8?B?SUlhRjMyR3h4RUVydERvUmNQV1ludm0yTDAyQmN0QVgycUZKcUFqU3pWekNK?=
 =?utf-8?B?dVRBTk9iSkZqWS9IeVNCTDB2ZHJzb1NNb1FHTERBZ0FtV2FmdXZ5bWdyT0tn?=
 =?utf-8?B?cWhackI4UkY4UDZBYlMvOVpPRFl6dXpuWGRVYmlWK3dRVzVYRjZDOWttNklz?=
 =?utf-8?B?N09ERVhkald5U1IrTEUzZFV5OG95QVk3azcyRnNTSyt4Rk9HM0VOdTlUTm45?=
 =?utf-8?B?NER4eU84UW9tQ1JKQ2FDMmlkQ2lYa3d4QjBpVlltTFphMHN2akU5R2Y5MHFq?=
 =?utf-8?B?TFgzOWhtcm1vODI1ZmZIbFpLS3VDbTJPdm4xZ3hKbG1WQXY0Rk9xWWtjYmpD?=
 =?utf-8?B?UXU0ajFXOHB4VXgxZzh5TDYrWThMTGIvbVZkNGRreFJjS1NxTGZDb2VET3A2?=
 =?utf-8?B?Ym1QMTFqU1BodVU0UnpuNkVHc2U4Q0kxTzErd2ZFaExwWURtbURCS3VGcFdQ?=
 =?utf-8?B?anZTMGZreUJOT2dnQVNYNTFnaW9OV1JtRWFXNDdoNlVXanBvYXZEWG05YjFq?=
 =?utf-8?B?TG1rTXJ4ZFJNTkdqb2JacFpqdHEyalJWdnlVUEk4U3pKU1FCZUhjbTdwd2g2?=
 =?utf-8?B?VXU1NFNHSG1qVTB3azJNUlFmYkwrK0xnbDNGQkFybUtPeHFSVTlEcGZqd0N0?=
 =?utf-8?B?aVpDZUNSZFB0ZU9FRG5rNitSWkwzQnJIVStKcDh3NXg4bFR1YkQzdG9kek1L?=
 =?utf-8?Q?wHBEsAWHtxhkLKX9/oEkOv8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8uXjM4rDFVkfVOVoJaIg9DLjJDt2bMMYCztBlcyPahZOq7ilFCr16VkI6G58xD9rbFQjK6sK2HwAukDIPRz89i8yT0twUVUKdiPcPLIc6t81Or0m2boTo6o9GGEI9LcawvYb1W8TtBXA1QSp2/A4IHocIfhWDr3rVVQaiMmAvAInZD1r21WHHVp/uiOmi/9vatTy8hNwGP4bOQFdYVML9ILueAoqAbEvbPuqHHe5HBCMlsl0yI49310MOmY8AXfPzfn5LvDEW7nz16Gl/dSkQEv3Y7Z8zF6EtfBI5qdzgdBUJyZIOl8hLoAjW6+vI5gIMXm8u7ZEzDPrEDU/xJpJTAED0TXMxRfdKD9+ZP03aRv0BQDXalKvL0Ljfuq7Fja6HqlvRl5L1fafxzkUbVwyWzMyMcX1drXjmZs44ZUkyU1BgspYZjIJuK3BU56rxEw6T3BxcEeLNziRrItAN2tGrfsAtck/JL04nGgPoI3c5OtMXwlQZNVYim9SX7HL8HK3jNo9eMSPuxJD4M8PbhEXMhVyXkwM16ikjUHQ1SSqA5ZvfcIDnlnHNmkek9bhTtYZKwRxXn16/oXpwOPMquzyjHGmTs9QfVhQ5iqiKn1XCI0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592a663d-b1f1-4f88-c9dd-08dc20f5d4bd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 18:12:19.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWF1YwW71Q591D6tAXzyb76XiJuGjO8lxZTPQ0uBIhWF3rwedWpCwZDcnUUS7mEMD28nqLx3G+gbXI4YAA+Mpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_11,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290134
X-Proofpoint-GUID: -RQ3x5Eg1EHqQh1sxVgmY0gB1GrVlSM2
X-Proofpoint-ORIG-GUID: -RQ3x5Eg1EHqQh1sxVgmY0gB1GrVlSM2

On 29/01/2024 14:24, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 29, 2024 at 01:05:05PM +0000, Alan Maguire escreveu:
>> This should probably be a BTF feature supported by --btf_features; that
>> way we'd have a mechanism to switch it off if needed. Can you look at
>> adding a "tag_kfunc" or whatever name suits into the btf_features[]
>> array in pahole.c?  Something like:
>  
>> 	BTF_FEATURE(tag_kfunc, btf_tag_kfunc, false),
>  
>> You'll also then need to add a btf_tag_kfunc boolean field to
>> struct conf_load, and generation of kfunc tags should then be guarded by
>  
>> if (conf_load->btf_tag_kfunc)
>  
>> ...so that the tags are added conditionally depending on whether
>> the user wants them.
>  
>> Then if a user specifies --btf_features=all or some subset of BTF
>> features including "tag_kfunc" they will get kfunc tags.
> 
> Agreed.
>  
>> We probably should also move to using --btf_features instead of the
>> current combination of "--" parameters when pahole is bumped to v1.26.
> 
> Alan, talking about that, I guess we better tag v1.26 before merging
> this new kfunc work, wdyt?
>

Good idea - I think it'd definitely help if "pahole --version" started
emitting v1.26 alright, as it would allow us to start supporting
--btf_features for cases like this. Thanks!

Alan


> - Arnaldo

