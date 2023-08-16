Return-Path: <bpf+bounces-7890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C68677E0ED
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 13:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A432819BE
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0C10794;
	Wed, 16 Aug 2023 11:54:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C8FBFD
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 11:54:47 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D12D78;
	Wed, 16 Aug 2023 04:54:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FNPDWr011126;
	Wed, 16 Aug 2023 11:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=24ISPZKswOm4J6Dq0u6+kUhfGf1w0wXrnHHaPCbcq0U=;
 b=adDxmHeNycSLAX2b7O4+91yS/SVjJClKsG2K1kxDd8bIIy630jOFq6h9vcGG7ZEQus30
 HFkSLy4YoSAXvCsKp7LrQSyEAFZGWFZE+vxhdk1nnUMxL1cxx5qR5tUcKaU8QZC+q4vu
 Y6cWPQbLVlDIHGADwt71+A87nwehNksX2KuYgsq6K4JMOhVmYeOug0WKjPWK27o6QRR3
 1rhdTATr4Gz6z79JJgUYs1X4Nq+/PzbA3et+KWCGFQf2s6ML/P/Yh0BkiBSJvquX/jD+
 W1hVLppt2vunMy6lXm7hU4PgFSZINsfdNa7pLmjnjr7pS2jwwNAsfm5EvPkLVWjH304L 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c6rf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 11:53:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GAAdSE039586;
	Wed, 16 Aug 2023 11:53:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey71aye9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 11:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAjNfs9EYesSiAnHnEC+/6G4WOzpIFVbHdDhaoQrVstE+QMoVm8yuN6ZFRjskmQ6O0wqm8XQy+B6KF5yQrdDMV6HoFKxvFXWadBEvPLA43P8Ear3p91GrXYXR5MEZqucOjajh+q7RSOsHeAck0HqnsSRssTI5EESKepwYmSqerAaoGuqw5rmK5tp9Oma4HtIkutmlknkbUjNdbYF+4x7X25u5ACFRFp1Ko4bsSEa/GYVZdwTjEleDGx8vM6vDJwPnSrjK/DqI2MpDrAgHiAuMHEn/mXndhbg9PX0JprlSH9LjbotWCQYhflzF4xIbWEs6CQzMR1nahcJ3byrsMbOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24ISPZKswOm4J6Dq0u6+kUhfGf1w0wXrnHHaPCbcq0U=;
 b=QrYT/T7nLGRS3WKOMbto8U0N7b6Ysg5oiTvtZpq+0kFtxSMm6wL/gRvC7pQzYQt+mGoJUyhcpmYMe5kN1EUqvwwbaRHyeqmlpIgdjKbmNdJmo5jCzAx18sPEVZDdmSbD3BlFy/oe1OuiQO37i3bgVLt7kd543rPj74ULZd9AQQiVdioHlMBP0ATIzkFzIv0inBt7EjWN5LsK4c7SoLW9aKQHalviiFsS/ysHx1IrqbSHjptEomAfiElZwBG5nYW1+ul4niCbjlTO3CBDA8rslgz+h9M72CWQ538RTtLaHpWmEimv56laZZuT4NV9J5bVB9cVXiuGYbNHyi9ni2IkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24ISPZKswOm4J6Dq0u6+kUhfGf1w0wXrnHHaPCbcq0U=;
 b=DlqyIDhGLjQs56sbdb0MK4gzW3+3yDydmbNqnW8S/ZFIZRwYEgPqFghsZYG3aOYXkbu2QcuySYwe124n6RjIB1wNMx5YNzWjP97YO+0xeQoUzfRiiTSWmBX3BWrNfNCuy4MZJDT11OBkDIJkYsHJGWjMggXJIOhKesnj0sZMC0E=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB7635.namprd10.prod.outlook.com (2603:10b6:806:379::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 11:53:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 11:53:08 +0000
Message-ID: <5bb59039-4f3b-49b6-d440-3210d7a92754@oracle.com>
Date: Wed, 16 Aug 2023 12:53:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 4/5] bpf: Add a OOM policy test
To: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-5-zhouchuyi@bytedance.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230810081319.65668-5-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0067.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: f8103dff-b338-4efb-c5e9-08db9e4f5ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FT7SnUqbv0i7AiWwA0OFmxigs8mCOM0NExc+O+N7ulO4vAKrPYC3N/yu3nZRnMbjfdnNzU6c8tDkefogMwftRI6SxQDI1kZxElzFETKIX1hhQ8CYLjp3xrbzGLZ4QId3Sp5ik+B1av0LJxRbhl/4fWMjFEK2tc0PTbmoOZu56S3PtUpu2rtQkMfd+W8AxcExLdGyJS4pWAUkmGBkNyLAWN2+5vRJ6SRVN7weDb8n1h/crhi175B2atTfBQOzPq+kAcj4tmhXri4wa3s6rSecAC1Ars76n29J0+l8IGi63qYjytIkN1htfA4uwrDuusHHCLaVGWPvo1WGZHDbjkCSbwA9DjaWZD1hNCqiA0942dolK0onWxPRzuYAA+GgApO5jXhqkvaCFp6g5dDae3tBuhovvMdo6h7TDoN327OB3dhvzjHujXl9nJ+w/Uhe5wlohZuZtPH7NPkiEgJ7Kni4Mg4vRTJFELdxDtDXBA51W6thuGvu+AV/Of35v5osvQipLxq3X9dYAs+4W56Y0+YF0AyzOY23n3uC1r+s2FehOnF+GhAmpcEO7sPVv7i7+LEKuhSmbdUQHm/pHjlsHIjbE8pvW8+l2jg3kHpLWeeu6JajwcXilQ/w4Hx9IzNZ6jnp2Iq4ktSXqRvbryKqLw/abA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(478600001)(7416002)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0pISkViOE1mKzFLZEY4VjVqVzZ2TWFCaFdkdEx1MllaK2NNUlZHK2hhbUpM?=
 =?utf-8?B?a0g0MS9tTWlXN0hFUEc3NExkUmhVQTdzTTlFUG4wMnpEb0lqcWNMRlJ5cmRH?=
 =?utf-8?B?WFluOUhFcitBMlM5VFBkWWJqb3FLVWg4YjY1L3lQbzBXRW1Qa2ZUc1FMSEhD?=
 =?utf-8?B?aVpIMjdmbExBR2piRjg2SllBY2p6Mzd4eUZQYUZwTGgwQmlNK1g1U1BuMDBD?=
 =?utf-8?B?eDEzUDBpaFY5dVM1ME5IOENzazFrMzhIRUpIMXlxVUV0WHg3L3JrbkhLOGho?=
 =?utf-8?B?VWxGekJNMmJMY0QzTU5YV2JnL2VPMkdETzVuVjdVZFNJU0swbjRrQ1daOVR4?=
 =?utf-8?B?MkJPb0NabktXbTJvRFhNZk5oQ01wWVZvSjJGdHZYTkdSRW9jWGJzRXQxTGtH?=
 =?utf-8?B?Zk9lZEZXRWVSalFTaU83UEZZSTJKSTdyWTJXcmRtZEk3Z3VqY1cwN3RZN2w2?=
 =?utf-8?B?ZGJUWXcwT0poblF3ZUhINFhkaE9oQW5VY21wOFhScE53ZVBub0RaQnljSGhB?=
 =?utf-8?B?bUE3am4rMFM5cUQrOTJyVjVnQWxFN1F5VHlYMUtOOHlEaS9IWEpXa2MzUTVu?=
 =?utf-8?B?NytMdnh5L3BZQlowY3grM1cyaVlsK0gwV3JaVU5FcE1WRTRIbnNISWJocFpP?=
 =?utf-8?B?bmdlTDBlNytPRm93Sjl3ZHJWNExiRjBuTDVDanJ0WmxyWUlHUWhobFAyYXFh?=
 =?utf-8?B?SWQ4ODVjUlZVYjVRSVEvcVhXNUt4dURRblEraUJZM2d5b1FnMzRpQVNKM2pv?=
 =?utf-8?B?OFNCRGovOUp4UkIydHFNaGZQZFFwWTR6MEhWWXVzSXVpTEloeGdkU0tjVkwz?=
 =?utf-8?B?bkM3YURUVWtxN1FLcTZOcEdIeFlWQkNobXEzMDZiZGxGTHQ1N1o1dVltcmto?=
 =?utf-8?B?Mlcrd1RCa3NBOERDWDRqTGFGSW1GelZJcWQ2WTNlMUVLSFptcVoydDFKNGZs?=
 =?utf-8?B?d3pwUklXZlBKRDBNbTZUeU44dXA2SnhMZ2hPZ1JjbkI3ek5Xc3UzSmRpOXpT?=
 =?utf-8?B?V0hJWjR2cFJjMW5xcEM1aWtKNHE1ZURIanBRclRDcklaSU1jZnRSdnpBRkM3?=
 =?utf-8?B?NkY0L281bkwrN0VTZ0hzd1F1dW8yU2s1NkExejdJcGpYb3Axc1phSEtMZit2?=
 =?utf-8?B?YWJhRDQyZHpnY3psUWJ0K0pIdWtaV2pGVTJQNXNxeWNqbVE4VmFXcHVCWlZp?=
 =?utf-8?B?bEV6TGh1YkpSTWVLellxQ011LzRobTB2dHQwRE1WMjBDbXN1c3Y4Y2tlUEVV?=
 =?utf-8?B?cVZkMU1mVGh6WlVJRFpnNVhoTXZmeDJzb1Mzb0lESm11cnFGekVENHlrWHVK?=
 =?utf-8?B?VFFZYXIxRUUvYUV0WVJHbll4bEZ5dUhIVENYTVhMRm8zRHZhYmd3bml5bWNZ?=
 =?utf-8?B?WENzMHAwRTA3d05EUWlVb0dPOXBocW0yR2NuQ1BMNWpIazJoTTk2RHlXVUhY?=
 =?utf-8?B?cm5GR3NyL2FVaW9BNlN0LzhHTG44M2taWVZTWUQ1WDVWSzdBSDBzclZiYXlE?=
 =?utf-8?B?UkhXVUdXcTFlcldaTFUwNTdpa3BRK2FFL2ZDeEtPQlJINmpzTFRORHlMbXJF?=
 =?utf-8?B?UDVOZERxNkYxbUNEWmdtVnoxNGdXYzhFZVJCQzZrdFdwMEtKejFXY0RFVVZJ?=
 =?utf-8?B?UThqeSt5TFo3U2ZscUJwNXFzeStrNlBzeXdmdEwrMFZqMzdvUWtXL2Y4RXht?=
 =?utf-8?B?dDM3N0J4WDU2Z2tYSzEzcWtqT2pNSW4zMFVuWXJiQnhONFVkMGllZ1ljRDU1?=
 =?utf-8?B?d3hRNDlVV0lPaEp6am1CWU8rSm1QT2lnTEozTXBnUndHUlJWUUYza0RtdkIx?=
 =?utf-8?B?TWhEVVk3WVFuMkpPS041MktwK3d4aUtSTy9aWXB6Q1lJZDcwNitBUnFvM1ZI?=
 =?utf-8?B?cXAyVFBjK3VMS2xEWjhWOWcwYkxTMHZoSGNsK0FvWmM2NmowVVRqaGozRys5?=
 =?utf-8?B?blNXUjYvWkR5Y3ZLSFkzWlQ1NmdoNXJRM3Fpb3pCOEVWT090emZwZ1YwbzFE?=
 =?utf-8?B?UnQyaUhFTndGdnE2ME82ZEUxeHFSend0SGlHN1c4WnBUckFoaTJLNVVLRXpk?=
 =?utf-8?B?N0lpRkFkcE0zNkFyWmpRQXJNT3pxOWRJMlNraERhN0xOZklJTnBhUitRMFkz?=
 =?utf-8?B?M3E5cWFPV29jclBTYWZTN1JVZTR4dG1ma05xV2RLZEZEMTAxeE4wNnhJTjNX?=
 =?utf-8?Q?O4tLWJcouNCM3P2M5XIcp28=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jEEjDUkSf93Rb7WemM5ZShHiSNtrGidDpE2AvtsnQ+huNTiYJA4MMPOnMGpv/qOuuE2DZ/Hdq2kib7XqUZnHHK88oEkSYR14mzu0pp4JMpA69X7FCEVGdOhJxrcbsmk7pSco6WXsjfhCZ0QLDq/0eA/fAk9u3gUU7p6c7wnov6SpktJrircKzlIxCI7/RqFuKVnJHJRwcEw1Hv9OqUjnfTgYSGDxJ3+viPtbbUBoiR3xFj+ZiuRnd26hyCy+LZTZlBTvsnfgFyJaSlLabs0lVrcq192SnyxrcYNJJbfweE8xfIMiCxToAlXDAz6H85cAdUdy1tTN1AqaaHWJrM7OVlyfWEcXGdF/LLUP34gosALr5hj67FK5T8gn2IvnxUY4i3l5hQ+PGqhTSuK4Irde0QNzkkDRpsQQq2Qx/ryPMBylOoBrPHqQh3wF9XxrpvQl3ltlUjBNyVQ4dBG5vIgniSMRIhsaj69K8CMoSGF/5Dnyj2Se3/BOFtofGq1p9054+pADbgeA70UdxOIAITg0G+SKa/aIAAQngv2RYc42EA/WSDEAxzcAowD487xgrLOM4IsTTGOkOuAXD5nbHyqExaxXdiRCm/jJFez7er8Cek/hKw47sS3Oce5cchHWgnm85nqB4hHv5JBrWb9dBuAZ+2b7rzg8eKrmn4DtXq84sfl5dCW7IGTR8TqZgXif3hijy/qRbubgIzOWjFiyeWvuOagcfeXocYLDSdaJelbgnovrDD1LjJD+IAy4LDx6g5jaw87Zgzb8RGyJwQyAPaS4k3qP2vDS8Pu4Yo+/1YEySf7Bwcdg2ABlm2TtHX++ZS0Oiia93F2l1WtG5skPpmyV8fQAYy5wdAWmWtutO48bg4CW0uLsjyKtFLvlILMXOaKPY6Mb9fXCJMmZd86nrtBBqEejHssSe1PfRaiZg1GIwjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8103dff-b338-4efb-c5e9-08db9e4f5ba8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:53:08.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQUyo460bePT5eTwftlBCLoaF81S1reouEhFhQPSRh5f8cPka4TBaArZK8mYKZ6AzQJ2tjNW6nBvnYXtAxKRlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_10,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160103
X-Proofpoint-GUID: voJeKetUawbtyPQ4xoH7RETdJWnDgI9Q
X-Proofpoint-ORIG-GUID: voJeKetUawbtyPQ4xoH7RETdJWnDgI9Q
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/08/2023 09:13, Chuyi Zhou wrote:
> This patch adds a test which implements a priority-based policy through
> bpf_oom_evaluate_task.
> 
> The BPF program, oom_policy.c, compares the cgroup priority of two tasks
> and select the lower one. The userspace program test_oom_policy.c
> maintains a priority map by using cgroup id as the keys and priority as
> the values. We could protect certain cgroups from oom-killer by setting
> higher priority.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  .../bpf/prog_tests/test_oom_policy.c          | 140 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/oom_policy.c  | 104 +++++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>  create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
> new file mode 100644
> index 000000000000..bea61ff22603
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <sys/stat.h>
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include <bpf/bpf.h>
> +
> +#include "cgroup_helpers.h"
> +#include "oom_policy.skel.h"
> +
> +static int map_fd;
> +static int cg_nr;
> +struct {
> +	const char *path;
> +	int fd;
> +	unsigned long long id;
> +} cgs[] = {
> +	{ "/cg1" },
> +	{ "/cg2" },
> +};
> +
> +
> +static struct oom_policy *open_load_oom_policy_skel(void)
> +{
> +	struct oom_policy *skel;
> +	int err;
> +
> +	skel = oom_policy__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return NULL;
> +
> +	err = oom_policy__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	return skel;
> +
> +cleanup:
> +	oom_policy__destroy(skel);
> +	return NULL;
> +}
> +
> +static void run_memory_consume(unsigned long long consume_size, int idx)
> +{
> +	char *buf;
> +
> +	join_parent_cgroup(cgs[idx].path);
> +	buf = malloc(consume_size);
> +	memset(buf, 0, consume_size);
> +	sleep(2);
> +	exit(0);
> +}
> +
> +static int set_cgroup_prio(unsigned long long cg_id, int prio)
> +{
> +	int err;
> +
> +	err = bpf_map_update_elem(map_fd, &cg_id, &prio, BPF_ANY);
> +	ASSERT_EQ(err, 0, "update_map");
> +	return err;
> +}
> +
> +static int prepare_cgroup_environment(void)
> +{
> +	int err;
> +
> +	err = setup_cgroup_environment();
> +	if (err)
> +		goto clean_cg_env;
> +	for (int i = 0; i < cg_nr; i++) {
> +		err = cgs[i].fd = create_and_get_cgroup(cgs[i].path);
> +		if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
> +			goto clean_cg_env;
> +		cgs[i].id = get_cgroup_id(cgs[i].path);
> +	}
> +	return 0;
> +clean_cg_env:
> +	cleanup_cgroup_environment();
> +	return err;
> +}
> +
> +void test_oom_policy(void)
> +{
> +	struct oom_policy *skel;
> +	struct bpf_link *link;
> +	int err;
> +	int victim_pid;
> +	unsigned long long victim_cg_id;
> +
> +	link = NULL;
> +	cg_nr = ARRAY_SIZE(cgs);
> +
> +	skel = open_load_oom_policy_skel();
> +	err = oom_policy__attach(skel);
> +	if (!ASSERT_OK(err, "oom_policy__attach"))
> +		goto cleanup;
> +
> +	map_fd = bpf_object__find_map_fd_by_name(skel->obj, "cg_map");
> +	if (!ASSERT_GE(map_fd, 0, "find map"))
> +		goto cleanup;
> +
> +	err = prepare_cgroup_environment();
> +	if (!ASSERT_EQ(err, 0, "prepare cgroup env"))
> +		goto cleanup;
> +
> +	write_cgroup_file("/", "memory.max", "10M");
> +
> +	/*
> +	 * Set higher priority to cg2 and lower to cg1, so we would select
> +	 * task under cg1 as victim.(see oom_policy.c)
> +	 */
> +	set_cgroup_prio(cgs[0].id, 10);
> +	set_cgroup_prio(cgs[1].id, 50);
> +
> +	victim_cg_id = cgs[0].id;
> +	victim_pid = fork();
> +
> +	if (victim_pid == 0)
> +		run_memory_consume(1024 * 1024 * 4, 0);
> +
> +	if (fork() == 0)
> +		run_memory_consume(1024 * 1024 * 8, 1);
> +
> +	while (wait(NULL) > 0)
> +		;
> +
> +	ASSERT_EQ(skel->bss->victim_pid, victim_pid, "victim_pid");
> +	ASSERT_EQ(skel->bss->victim_cg_id, victim_cg_id, "victim_cgid");
> +	ASSERT_EQ(skel->bss->failed_cnt, 1, "failed_cnt");
> +cleanup:
> +	bpf_link__destroy(link);
> +	oom_policy__destroy(skel);
> +	cleanup_cgroup_environment();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/oom_policy.c b/tools/testing/selftests/bpf/progs/oom_policy.c
> new file mode 100644
> index 000000000000..fc9efc93914e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/oom_policy.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, int);
> +	__type(value, int);
> +	__uint(max_entries, 24);
> +} cg_map SEC(".maps");
> +
> +unsigned int victim_pid;
> +u64 victim_cg_id;
> +int failed_cnt;
> +
> +#define	EOPNOTSUPP	95
> +
> +enum {
> +	NO_BPF_POLICY,
> +	BPF_EVAL_ABORT,
> +	BPF_EVAL_NEXT,
> +	BPF_EVAL_SELECT,
> +};

When I built a kernel using this series and tried building the
associated test for that kernel I saw:

progs/oom_policy.c:22:2: error: redefinition of enumerator 'NO_BPF_POLICY'
        NO_BPF_POLICY,
        ^
/home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75894:2:
note: previous definition is here
        NO_BPF_POLICY = 0,
        ^
progs/oom_policy.c:23:2: error: redefinition of enumerator 'BPF_EVAL_ABORT'
        BPF_EVAL_ABORT,
        ^
/home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75895:2:
note: previous definition is here
        BPF_EVAL_ABORT = 1,
        ^
progs/oom_policy.c:24:2: error: redefinition of enumerator 'BPF_EVAL_NEXT'
        BPF_EVAL_NEXT,
        ^
/home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75896:2:
note: previous definition is here
        BPF_EVAL_NEXT = 2,
        ^
progs/oom_policy.c:  CLNG-BPF [test_maps] tailcall_bpf2bpf4.bpf.o
25:2: error: redefinition of enumerator 'BPF_EVAL_SELECT'
        BPF_EVAL_SELECT,
        ^
/home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75897:2:
note: previous definition is here
        BPF_EVAL_SELECT = 3,
        ^
4 errors generated.


So you shouldn't need the enum definition since it already makes it into
vmlinux.h.

I also ran into test failures when I removed the above (and compilation
succeeded):


test_oom_policy:PASS:prepare cgroup env 0 nsec
(cgroup_helpers.c:130: errno: No such file or directory) Opening
/mnt/cgroup-test-work-dir23054//memory.max
set_cgroup_prio:PASS:update_map 0 nsec
set_cgroup_prio:PASS:update_map 0 nsec
test_oom_policy:FAIL:victim_pid unexpected victim_pid: actual 0 !=
expected 23058
test_oom_policy:FAIL:victim_cgid unexpected victim_cgid: actual 0 !=
expected 68
test_oom_policy:FAIL:failed_cnt unexpected failed_cnt: actual 0 !=
expected 1
#154     oom_policy:FAIL
Summary: 1/0 PASSED, 0 SKIPPED, 1 FAILED

So it seems that because my system was using the cgroupv1 memory
controller, it could not be used for v2 unless I rebooted with

systemd.unified_cgroup_hierarchy=1

...on the boot commandline. It would be good to note any such
requirements for this test in the selftests/bpf/README.rst.
Might also be worth adding

write_cgroup_file("", "cgroup.subtree_control", "+memory");

...to ensure the memory controller is enabled for the root cgroup.

At that point the test still failed:

set_cgroup_prio:PASS:update_map 0 nsec
test_oom_policy:FAIL:victim_pid unexpected victim_pid: actual 0 !=
expected 12649
test_oom_policy:FAIL:victim_cgid unexpected victim_cgid: actual 0 !=
expected 9583
test_oom_policy:FAIL:failed_cnt unexpected failed_cnt: actual 0 !=
expected 1
#154     oom_policy:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
Successfully unloaded bpf_testmod.ko.


Are there other implicit assumptions about configuration that cause this
test to fail perhaps?

Alan

