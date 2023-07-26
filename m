Return-Path: <bpf+bounces-5960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146C77637F7
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C023F281EEC
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05951549C;
	Wed, 26 Jul 2023 13:46:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2737BA43
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:46:32 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83C2718
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:46:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8QbH7010691;
	Wed, 26 Jul 2023 13:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3/JvT/LMW+oWjeSrWp1WE/nWj3Puvw3hAdcNMFjKZP0=;
 b=kuirNngfyoHPEW3D/qYyrYfKuB0NTdkwT8fTKAqLPc5hkm56GpW91Q9xBiTgC/nxxZUD
 z0F6zuWJzMbJY5PmV22LwM0CptY6crcvIugOEeo7e4RSdJlGNzCZSYRehn6HAQ8Vz2Fo
 HLnEU3dvQMiiU4BNGAR2bPRhrghaXywIwPdKI5/Qb6x3nYjirZrx5fvFATtMQ+tor3zA
 waR5BU6sKbI1xvXzu6vtLZv2YcZBj0RatAWfbgxyIxcpSEgL+Y1Dt+DX/ggMd6J5mGUj
 5pGkvoi9by9Yam/dAR9ck4Mrs5axKxapY69iUYz0A7e7zuHxQE1Ba43fIzse5V7nGx/S 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuqepx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 13:46:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QC44fK033463;
	Wed, 26 Jul 2023 13:46:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jch0h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 13:46:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNDhQzTev+m7RKoPhgZiP7/sauRRBuCwG4nea4jFALte22IcXJYTrXGxK4SF7uVdBT8mFgomuQRzQsmvL5Y40SEIx6WvXmeUo1dZ4CBma7UBXgr4Hu+D9s24thRO7xSCSjI1EpklVW17YFflG6yguaaRhCmGr0LciegDFeOJ4gU0rh3On0UvApuF/r56n5+9E8AukeFHj846XIX3oqmiVGmNRGgntkJcVoMzOWDPA1iR+rRMSMrDdSDpPKSCWL5tdErIgZLzt7GfPozEJr9i8uRHso4cav0/DMMl/KXHx+0wGHQW2VmbEqJcnNrIildRqnG2Yyy7RWZP5lKUhmt+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/JvT/LMW+oWjeSrWp1WE/nWj3Puvw3hAdcNMFjKZP0=;
 b=TZtTYieMwZRpoGDEBZrUAetqVa32V4C6TqV5vCKV916Gw5m7SOFpvmM4MhnH8ThcQqzRnTo8+AxA8rEGcfSNbmDqjfZ3BbTX+gxx0PRyx9AwvgeTZCLhkcVNTHknA/WNU0r8T7oBvOLhQKlBsuRI0ObzVwkIvMpUsSozPyTpcbX1DHNBzjL/ZJT36dIqKGPyMph0psWNz0XegPK99KTZwJtIqUv2G+p0E7G1hKVHy9akM0bq2yxs/nZfwmMTXP++InciUG0WfouNNG0CjMkRyCvHc83xIrVKTVK5G2fixOU6ivjHBJjt8Y7Ep+VKNPOr3CWb7naZty4oDFtsSgw9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/JvT/LMW+oWjeSrWp1WE/nWj3Puvw3hAdcNMFjKZP0=;
 b=lTOO4zxpuLbagOIgcM6qbPEatfTczNEYG75w0tMlR9PWuLvfLD4kQ0wfBPq4F/xnZ0CNQwigbtJwgdeB3FeactXyAHnZm31atbeohPDYT7XnhussTywGs3rZKZ0tSoB/Jk7ObBioN9bU/sw8IBJq/VI1JPFuTRfNi3BF7tgkTGk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB4775.namprd10.prod.outlook.com (2603:10b6:510:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 13:46:20 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 13:46:20 +0000
Message-ID: <308bfec7-38d7-9dcd-3130-5602658db47f@oracle.com>
Date: Wed, 26 Jul 2023 14:46:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
To: Eduard Zingerman <eddyz87@gmail.com>,
        Timofei Pushkin <pushkin.td@gmail.com>
Cc: bpf@vger.kernel.org
References: <CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
 <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
 <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
 <883961c3-3ea2-2253-4976-aa5e20870820@oracle.com>
 <51d510b9-fbbd-d30a-9a01-e77c84db52a5@oracle.com>
 <49c9170f7dd0d3e78a12570ae422bce553a1e236.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <49c9170f7dd0d3e78a12570ae422bce553a1e236.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0039.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fa2377-d535-4c4c-08ed-08db8ddeb12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ed1IzVKJN+VBJa0Nr8kfBw35906QEeDORG+nXOI9YA5WFcIJ8GMDVGpZ2irS4j5Vvzn72zoCIabb7gAKvmukzxQYoz2wXqmsg/vbaRHwcn9TxiyXOTrJxIxfk6InnXV3OP1IRehyTNyss3+h+zonp7Yk7cBZp1t4Q3UdOmw/VeJ8WNbPIiPvZadJlPEfvCs0wHI3VhucxwB8sqOAxTEah4QdFPh97o4zZdhncxlVPfHstpXy6EDUkUr0ShJbATc+0xQ5efmkAuiKVUoj4y64MUfpH2RtkbThfTrjJ2AFwdk7Ma2LqzKvyB044SQn86nGLf5EhYPfjmwL3CsFjL00b9QV6kfqgWPUr1vsZVLY2P68rnuVqbsywvnp8P7+WYjDXq1eQTQubcHP1o0HWrIt9wiIfPfDb627F5lo5nTrHshy8Nd+cOyDL6FJ4aCGH6x48ossqyhZYs9ZEtgl4XZ3u9VH8Eg/X4YevuI6mhsgeJkKTWV8nHiHY2cXgJuizPQncoOtdHCVMP95pSS2LtqTvqqMzqSmdyoGfER/F322wLihmJJSO7/K9/kY8+jSn6lymxle4n52WKl86BKPuXZbJxkmEW2Djz0gNaVaFA7Zj1Du7/XAY4gcygrEwbusH4X+kKqyBLXegC1uZxQpkg9Imw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(2616005)(186003)(6506007)(53546011)(83380400001)(4326008)(66476007)(66556008)(316002)(66946007)(8676002)(8936002)(5660300002)(44832011)(41300700001)(6666004)(6486002)(6512007)(2906002)(478600001)(30864003)(110136005)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFFDb0lFaEo5U2JRYWMyUExJaVlDTFBwdmJ1VC9HWUZkSEkrSXc4NVZ2ZmE4?=
 =?utf-8?B?OHgrREJmQTRLS003Z29sbmhjem93dVBDdUV2RGRMbUduZzE4QkhUdXZOVG1p?=
 =?utf-8?B?N3hUS0ZFSTkrRHliOTFpWkdWODByTUZrRitXYlFBTXpaM3U1NUV1WWdkYkgx?=
 =?utf-8?B?WmR5Qkd6ZFJ3d2tCSzJUem9wc1JmV25LbzBLWG1PcUt1eklYMDRLWit0cW51?=
 =?utf-8?B?aWU4dEdRR3dmdVl1ME5XazZFZzVENnhKRG9Rd1JRc0xkQlVYcTZzR3pNVkpi?=
 =?utf-8?B?czVlK1lHcEwwR1JKbHdBcjdmZjBleHgwVFoxNEpXVWN5bHpLQTlvUlhmd2d1?=
 =?utf-8?B?UndYTll1RmF0VGxUYWw3MjYzc3NSa3N6NHZRYmZ2M2FlVzFyTGRpRFY2YTVq?=
 =?utf-8?B?Mlo4Uy9ZUFhmZ2k3YnFoeUZHbExiQ2V2ajZNMXlVL1RWM1d1cXl2alJVVC9I?=
 =?utf-8?B?TGl0c0k1YVEzSGt0aEdWREJJaWx6RFhQbEZ1QVFnNWhqakd2ZTg2d0srMVlr?=
 =?utf-8?B?TDNTR09QeVlNNlNjQkw3WWFDMXpnR0IvbjNPejhFQjRMSXBKd3JvSnh4bFJF?=
 =?utf-8?B?NkFyMDZsOUhaU20wa1BWeE9UcVczeDVsdHdHOXM4ME95Uy9uaVZtTnZGcWtY?=
 =?utf-8?B?d2YxRTM5emEyQTNwVEpHa0lXT1RUV0VFdHRIQTdYMzdhWTFVTDIyeEplSGsv?=
 =?utf-8?B?OEFTdUliYnc5Tkp6MUFMd25CSS9xajAzWU9ZZlZGRllCOC8rVlJsYmwrbDBG?=
 =?utf-8?B?QlY0MXNjVE5QeFBNaUFPZitGZUNaY3Q1MU00VFN6cEMwK0w3Rkx6LzBWMmJU?=
 =?utf-8?B?TExyaG5NVEpHRWJhd0dpT1ZTUGxsdWtQTFU2YVIvajAxaGV5dzAwUUdLNytl?=
 =?utf-8?B?R1pHT2NlNk5xamxsUy90UlRwSEN2OUlqeXkwV2FIai9QZWNpM0RFWnJSOWlD?=
 =?utf-8?B?TVdTdlViN2JPZG84aE9lKytNRUlyWHNEek9PT3Y2YVVVb0trbTNGMFRQRXlC?=
 =?utf-8?B?RzJVTzdENS9INGxxeUFMQjg4R2JwZ25OZ2xtK2c4cjNiNmZyRGRzUDY2YnQx?=
 =?utf-8?B?MGxvZkFhTEkvamxiQ0U1eVZYeGtnT1VoS2FUOG5xZ0pUMmdSMzNhZzBSS0Ix?=
 =?utf-8?B?bUFyN0pESGVscHlEc0poNU5GaS9zdEJVeHhWNkkzNm1XYTduUy9oenBmcFQy?=
 =?utf-8?B?dS8zNWk5b2N3a1IrTWxIMlZCNXVhTmZjRnZ2RkprNVRtUEN6SEx5TlgvOTNM?=
 =?utf-8?B?bEU1MmRtclo2Y2svNXBGa3pmVXBPemhCSTVRS0NHYkx1a2pPbVpvd0NFQ1BI?=
 =?utf-8?B?ZnVEcUg5NENMeHpsdUpIYWlvZDQ2NGhIRjBZajZLQytnMHpGd2h4WFVRREhi?=
 =?utf-8?B?SnpRM2Y5TnRYOE1xWDBWYjlKbXZFRW0yUWNBcFpFcGsyejVmQ2tuVWN0ODZF?=
 =?utf-8?B?elRvS2Z5amNXTVhDeHc2RTlXbmR3b29iZlJWL3BmWlJEZlRJM2hEckllSTZZ?=
 =?utf-8?B?L0N6V1hhWlAxR0Z4cUZJQkpqc2piQXJFbmg4MzZTczJ2YXdZRXZPZHlEZnoz?=
 =?utf-8?B?T0p5T09HMDhoZENWUTJGUEVyc0V4eXBnbjRnWjFvaHNHNlBTNEpTYjltdHQx?=
 =?utf-8?B?TzJJTmpvbHd2Qng0emdja1oxYXN2d242N3F1ZVR5b1VPRjlpYkQzdk90WXh6?=
 =?utf-8?B?dHJONkRMUERReTFIbkV6SnY4Q3BpcXR0N3ZRelN4a1B0KzBhSDViYTBoWnhI?=
 =?utf-8?B?RGNJZFRtdGRCMkR3akxkbDJraFJYQ0ZSaStqSHV4OG1WUHU3ZUlNVEJTMmIx?=
 =?utf-8?B?VmhaMHlvUlBiL0l2UTAzN0Z5SEdsL3FjbCs4dTUzdkJBUlNmVHo4S0k4bHZ2?=
 =?utf-8?B?a25rZEcrV2RUUjZFc2I4UUlMTGl5TW1qbDhXUzJiZG0rRUIxSCs2Mlk5dkxl?=
 =?utf-8?B?Z1g3b3ptSjZwWHorQXRDd2oyWmk3Mm1qdDhOMTZ2ei9yeUFNQ0V6SmlqOGQw?=
 =?utf-8?B?NVVEQUplY3libC9Xc1ZpOVI3MEhmZXhmRU9mWExSditacWp3b0VNMHRKR1My?=
 =?utf-8?B?TXRWbHc0ZXcwdVFRZEpDdjFQMk1Za0pzREszY0w4V08rZXNPc2NnQlFXR2l0?=
 =?utf-8?B?bkQrMEU2cStzZmw1RmFhNFBMYVJLL0p4Z3BSTUN6M2VweFJTWHNRV0IwMTNz?=
 =?utf-8?Q?YaPkwc4EU2y2InCakE8p5Xw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HxQfNsTfjIK8s4Yy/59cOcP8v/gnfRuHvRU3kg0kKn1gfPA9Xyb5Aaty9emEqtGLczFBivoNw014zUWLqE/1Yu/gvgFm6wzQcL0Gm9UO8BaVsjDZkdbITWmVbA8eJdzwsm7mcrBWEhPcS5yVjjZyWdz4adH4tMEDobbjrZi9joaIakv8RqtuvDyXK+p5M5v2+Z5qZDYQVUjju3im2FMXiMu4UtKNuQuz4Sm6SI0jwHd4aa0GJg8UfRdtKy33J6rRwX5NFTYnd0xsp1k3tamihRTW3m9oNoGw2mWHiFEl08+ieN4bHImc0JWtXmgSu4RXIQSAbmBRHi8It+gLn1zo9OK8NXIM/Am4Suc+0zJVDTyk/dDGz43JA08UykGmLf+YCI5rSt+t5vCOJxWCUBCVEmfItJRRVWfHS9uNu+RbKerk4Piw7843SKb/ImiBjWJr33EcDVug478sQnnrKTMUvcRZzCxx8orDn8CCd4Zr/7rWa5foXbR9oS0DkaglqmI4fbSN2j6C2qt1Aiy9nMq0rMSGVkFMSnTBCXUu8ONJDGv2Cl+P1HFMEN8bh5fYRSKjPod6sdGxuNAYGwf+PQsqMpLc/OJdxS479iWcQHP+miZk2uSHzmdIHHqDQc8Bdws1BfwmQri2uIv3IuNAEDvN81iHTUhexifXw2QHhvYLiTiVMYCuhd4N7+IuQEqf4Nn6P5FGRX6gZNLhlZdSy23g7PrPPNjH9YXvlKOy35zSk8UBz4ZkQiQRvGgz5BA9bXiAbbPXWXSyDzdP3XxeIahzTEzgJ9dl+9nqdNo8KKNE2S0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fa2377-d535-4c4c-08ed-08db8ddeb12d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:46:19.9443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gvj3yMo4ukQM5DbZ8mp7jl0UVwfpc03uWmQtJvn5KuYL6MIxYyY1JJv9S4TVVem7tyYo7ewNssM4gVA4rpLarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260121
X-Proofpoint-ORIG-GUID: QgiDPWxE0ipUoZu4wxHTiKoXZnNikbdz
X-Proofpoint-GUID: QgiDPWxE0ipUoZu4wxHTiKoXZnNikbdz
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/07/2023 01:03, Eduard Zingerman wrote:
> On Tue, 2023-07-25 at 15:04 +0100, Alan Maguire wrote:
>> On 25/07/2023 00:00, Alan Maguire wrote:
>>> On 24/07/2023 16:04, Timofei Pushkin wrote:
>>>> On Mon, Jul 24, 2023 at 3:36 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> On 24/07/2023 11:32, Timofei Pushkin wrote:
>>>>>> Dear BPF community,
>>>>>>
>>>>>> I'm developing a perf_event BPF program which reads some register
>>>>>> values (frame and instruction pointers in particular) from the context
>>>>>> provided to it. I found that CO-RE-enabled PT_REGS macros give results
>>>>>> different from the results of the usual PT_REGS  macros. I run the
>>>>>> program on the same system I compiled it on, and so I cannot
>>>>>> understand why the results differ and which ones should I use?
>>>>>>
>>>>>> From my tests, the results of the usual macros are the correct ones
>>>>>> (e.g. I can symbolize the instruction pointers I get this way), but
>>>>>> since I try to follow the CO-RE principle, it seems like I should be
>>>>>> using the CO-RE-enabled variants instead.
>>>>>>
>>>>>> I did some experiments and found out that it is the
>>>>>> bpf_probe_read_kernel part of the CO-RE-enabled PT_REGS macros that
>>>>>> change the results and not __builtin_preserve_access_index. But I
>>>>>> still don't get why exactly it changes the results.
>>>>>>
>>>>>
>>>>> Can you provide the exact usage of the BPF CO-RE macros that isn't
>>>>> working, and the equivalent non-CO-RE version that is? Also if you
>>>>
>>>> As a minimal example, I wrote the following little BPF program which
>>>> prints instruction pointers obtained with non-CO-RE and CO-RE macros:
>>>>
>>>> volatile const pid_t target_pid;
>>>>
>>>> SEC("perf_event")
>>>> int do_test(struct bpf_perf_event_data *ctx) {
>>>>     pid_t pid = bpf_get_current_pid_tgid();
>>>>     if (pid != target_pid) return 0;
>>>>
>>>>     unsigned long p = PT_REGS_IP(&ctx->regs);
>>>>     unsigned long p_core = PT_REGS_IP_CORE(&ctx->regs);
>>>>     bpf_printk("non-CO-RE: %lx, CO-RE: %lx", p, p_core);
>>>>
>>>>     return 0;
>>>> }
>>>>
>>>> From user space, I set the target PID and attach the program to CPU
>>>> clock perf events (error checking and cleanup omitted for brevity):
>>>>
>>>> int main(int argc, char *argv[]) {
>>>>     // Load the program also setting the target PID
>>>>     struct test_program_bpf *skel = test_program_bpf__open();
>>>>     skel->rodata->target_pid = (pid_t) strtol(argv[1], NULL, 10);
>>>>     test_program_bpf__load(skel);
>>>>
>>>>     // Attach to perf events
>>>>     struct perf_event_attr attr = {
>>>>         .type = PERF_TYPE_SOFTWARE,
>>>>         .size = sizeof(struct perf_event_attr),
>>>>         .config = PERF_COUNT_SW_CPU_CLOCK,
>>>>         .sample_freq = 1,
>>>>         .freq = true
>>>>     };
>>>>     for (int cpu_i = 0; cpu_i < libbpf_num_possible_cpus(); cpu_i++) {
>>>>         int perf_fd = syscall(SYS_perf_event_open, &attr, -1, cpu_i, -1, 0);
>>>>         bpf_program__attach_perf_event(skel->progs.do_test, perf_fd);
>>>>     }
>>>>
>>>>     // Wait for Ctrl-C
>>>>     pause();
>>>>     return 0;
>>>> }
>>>>
>>>> As an experiment, I launched a simple C program with an endless loop
>>>> in main and started the BPF program above with its target PID set to
>>>> the PID of this simple C program. Then by checking the virtual memory
>>>> mapped for the C program (with "cat /proc/<PID>/maps"), I found out
>>>> that its .text section got mapped into 55ca2577b000-55ca2577c000
>>>> address space. When I checked the output of the BPF program, I got
>>>> "non-CO-RE: 55ca2577b131, CO-RE: ffffa58810527e48". As you can see,
>>>> the non-CO-RE result maps into the .text section of the launched C
>>>> program (as it should since this is the value of the instruction
>>>> pointer), while the CO-RE result does not.
>>>>
>>>> Alternatively, if I replace PT_REGS_IP and PT_REGS_IP_CORE with the
>>>> equivalents for the stack pointer (PT_REGS_SP and PT_REGS_SP_CORE), I
>>>> get results that correspond to the stack address space from the
>>>> non-CO-RE macro, but I always get 0 from the CO-RE macro.
>>>>
>>>>> can provide details on the platform you're running on that will
>>>>> help narrow down the issue. Thanks!
>>>>
>>>> Sure. I'm running Ubuntu 22.04.1, kernel version 5.19.0-46-generic,
>>>> the architecture is x86_64, clang 14.0.0 is used to compile BPF
>>>> programs with flags -g -O2 -D__TARGET_ARCH_x86.
>>>>
>>>
>>> Thanks for the additional details! I've reproduced this on
>>> bpf-next with LLVM 15; I'm seeing the same issues with the CO-RE
>>> macros, and with BPF_CORE_READ(). However with extra libbpf debugging
>>> I do see that we pick up the right type id/index for the ip field in
>>> pt_regs:
>>>
>>> libbpf: prog 'do_test': relo #4: matching candidate #0 <byte_off> [216]
>>> struct pt_regs.ip (0:16 @ offset 128)
>>>
>>> One thing I noticed - perhaps this will ring some bells for someone -
>>> if I use __builtin_preserve_access_index() I get the same (correct)
>>> value for ip as is retrieved with PT_REGS_IP():
>>>
>>>     __builtin_preserve_access_index(({
>>>         p_core = ctx->regs.ip;
>>>     }));
>>>
>>> I'll check with latest LLVM to see if the issue persists there.
>>>
>>
>>
>> The problem occurs with latest bpf-next + latest LLVM too. Perf event
>> programs fix up context accesses to the "struct bpf_perf_event_data *"
>> context, so accessing ctx->regs in your program becomes accessing the
>> "struct bpf_perf_event_data_kern *" regs, which is a pointer to
>> struct pt_regs. So I _think_ that's why the
>>
>>     __builtin_preserve_access_index(({
>>         p_core = ctx->regs.ip;
>>     }));
>>
>>
>> ...works; ctx->regs is fixed up to point at the right place, then
>> CO-RE does its thing with the results. Contrast this with
>>
>> bpf_probe_read_kernel(&ip, sizeof(ip), &ctx->regs.ip);
>>
>> In the latter case, the fixups don't seem to happen and we get a
>> bogus address which appears to be consistently 218 bytes after the ctx
>> pointer. I've confirmed that a basic bpf_probe_read_kernel()
>> exposes the issue (and gives the same wrong address as a CO-RE-wrapped
>> bpf_probe_read_kernel()).
>>
>> I tried some permutations like defining
>>
>> 	struct pt_regs *regs = &ctx->regs;
>>
>> ...to see if that helps, but I think in that case the accesses aren't
>> caught by the verifier because we use the & operator on the ctx->regs.
>>
>> Not sure how smart the verifier can be about context accesses like this;
>> can someone who understands that code better than me take a look at this?
> 
> Hi Alan,
> 
> Your analysis is correct: verifier applies rewrites to instructions
> that read/write from/to certain context fields, including
> `struct bpf_perf_event_data`.
> 
> This is done by function verifier.c:convert_ctx_accesses().
> This function handles BPF_LDX, BPF_STX and BPF_ST instructions, but it
> does not handle calls to helpers like bpf_probe_read_kernel().
> 
> So, when code generated for PT_REGS_IP(&ctx->regs) is processed, the
> correct access sequence is inserted by function
> bpf_trace.c:pe_prog_convert_ctx_access() (see below).
> 
> But code generated for `PT_REGS_IP_CORE(&ctx->regs)` is not modified.
>

Ah, makes sense. Would you consider it a bug that helper parameters
don't get context conversions applied, or are there additional
complexities here that mean that's not doable? (I'm wondering if
we should fix versus document this?). I would have thought the
only difference is the destination register, but the verifier is
a mysterious land to me..

> It looks like `PT_REGS_IP_CORE` macro should not be defined through
> bpf_probe_read_kernel(). I'll dig through commit history tomorrow to
> understand why is it defined like that now.
>  help

If I recall the rationale was to allow the macros to work for both
BPF programs that can do direct dereference (fentry, fexit, tp_btf etc)
and for kprobe-style that need to use bpf_probe_read_kernel().
Not sure if it would be worth having variants that are purely
dereference-based, since we can just use PT_REGS_IP() due to
the __builtin_preserve_access_index attributes applied in vmlinux.h.

Thanks!

Alan

> Thanks,
> Eduard
> 
> ---
> Below is annotated example, inpatient reader might skip it
> 
> For the following test program:
> 
>     #include "vmlinux.h"
>     ...
>     SEC("perf_event")
>     int do_test(struct bpf_perf_event_data *ctx) {
>       unsigned long p = PT_REGS_IP(&ctx->regs);
>       unsigned long p_core = PT_REGS_IP_CORE(&ctx->regs);
>       bpf_printk("non-CO-RE: %lx, CO-RE: %lx", p, p_core);
>       return 0;
>     }
> 
> Generated BPF code looks as follows:
> 
>     $ llvm-objdump --no-show-raw-insn -rd bpf.linked.o 
>     ...
>     0000000000000000 <do_test>:
>     # Third argument for bpf_probe_read_kernel: offset of bpf_perf_event_data::regs.ip
>            0:	r2 = 0x80
>     		0000000000000000:  CO-RE <byte_off> [2] struct bpf_perf_event_data::regs.ip (0:0:16)
>            1:	r3 = r1
>            2:	r3 += r2
>     # The "non CO-RE" version of PT_REGS_IP is, in fact, CO-RE
>     # because `struct bpf_perf_event_data` has preserve_access_index
>     # tag in the vmlinux.h.
>     # Here the regs.ip is stored in r6 to be used after the call
>     # to bpf_probe_read_kernel() (from PT_REGS_IP_CORE).
>            3:	r6 = *(u64 *)(r1 + 0x80)
>     		0000000000000018:  CO-RE <byte_off> [2] struct bpf_perf_event_data::regs.ip (0:0:16)
>     # First argument for bpf_probe_read_kernel: a place on stack to put read result to.
>            4:	r1 = r10
>            5:	r1 += -0x8
>     # Second argument for bpf_probe_read_kernel: the size of the field to read.
>            6:	w2 = 0x8
>     # Call to bpf_probe_read_kernel()
>            7:	call 0x71
>     # Fourth parameter of bpf_printk: p_core read from stack
>     # (was written by call to bpf_probe_read_kernel)
>            8:	r4 = *(u64 *)(r10 - 0x8)
>     # First parameter of bpf_printk: control string
>            9:	r1 = 0x0 ll
>     		0000000000000048:  R_BPF_64_64	.rodata
>     # Second parameter of bpf_printk: size of the control string
>           11:	w2 = 0x1b
>     # Third parameter of bpf_printk: p (see addr 3)
>           12:	r3 = r6
>     # Call to bpf_printk
>           13:	call 0x6
>     ;   return 0;
>           14:	w0 = 0x0
>           15:	exit
>     
> I get the following BPF after all verifier rewrites are applied
> (including verifier.c:convert_ctx_accesses()):
> 
>     # ./tools/bpf/bpftool/bpftool prog dump xlated id 114
>     int do_test(struct bpf_perf_event_data * ctx):
>     ; int do_test(struct bpf_perf_event_data *ctx) {
>        0: (b7) r2 = 128                  | CO-RE replacement, 128 is a valid offset for
>                                          | bpf_perf_event_data::regs.ip in my kernel
>        1: (bf) r3 = r1
>        2: (0f) r3 += r2
> 
>        3: (79) r6 = *(u64 *)(r1 +0)      | This is an expantion of the 
>        4: (79) r6 = *(u64 *)(r6 +128)    |   r6 = *(u64 *)(r1 + 0x80)
>        5: (bf) r1 = r10                  | Created by bpf_trace.c:pe_prog_convert_ctx_access()
> 
>        6: (07) r1 += -8
>        7: (b4) w2 = 8
>        8: (85) call bpf_probe_read_kernel#-91984
>        9: (79) r4 = *(u64 *)(r10 -8)
>       10: (18) r1 = map[id:59][0]+0
>       12: (b4) w2 = 27
>       13: (bf) r3 = r6
>       14: (85) call bpf_trace_printk#-85520
>       15: (b4) w0 = 0
>       16: (95) exit
>     
> 

