Return-Path: <bpf+bounces-4208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CD67497E6
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8CE2810FE
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AFC4C87;
	Thu,  6 Jul 2023 09:04:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCB7E6
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 09:04:12 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF81BCE
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 02:04:10 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3668wWhR020897;
	Thu, 6 Jul 2023 09:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uuOpsAXRquuw8lTiZJtzmxk7dRLr9nAsHvqM0jd6sKU=;
 b=HRyWtiM81Lh73uGKMP5cDS3j1TqRAP9aadstSNXgLf3KR50D31BPPzlGzvYcBTAgYKmg
 7Qh9nc+Nn05ALlNA7A2AowYAwIjYdWg+zjvqst2fgbRz6YVfxvKvP7GI/YczC4cILgQU
 zEHVjmgBw2wRt/9lNEffykPSkJHMvLgsWHNVHtM/np3V+4A12XH2kSyQiqLwmsdG5HoJ
 jB+3A49PyBoa9jmQHXjenRRUKX4OVtVOQVi3kaEi0h3J2kS2SmGZbOVH+d3KbtDsVoZR
 pT/PQDA2fD1Adlm+y8yr1O5gt5pWg7DtoAgrPLRJPIrgO1i8GkP8ZzsfaOUjso8SngLv zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnt33822u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jul 2023 09:04:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3667clTU007188;
	Thu, 6 Jul 2023 09:04:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakcqyu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jul 2023 09:04:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gon0p3s1lMyiA1YLMEPScDJ24ymMkMw+LWKWBjKWVShv0Slj1wKKEsI1kwnjS0cZcpg4JuiW79Shg5CFkYhoFCfRov6mi57+B19+76/fXObOshWPIwjLFTI2NKjb43++QnZAuv8kA/r4o5XetfJBQDX9FEgH1IzrgjQKDG1gmUYIZQTF10js6x4Qf8DzHgcoi9902IMWFY+aPUscRYculiIhp07+rPKuo+YA9euI8uQ1WE35ifuIUJAU2lxQr6AbNbaMQq6m6WhU+BMjEmGH6vTiK3ScusNYGIuXaYFE5LdAk6N5kqX2mRegSq7OFrUIhmLhG5QPK0rq9LpbiyGkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuOpsAXRquuw8lTiZJtzmxk7dRLr9nAsHvqM0jd6sKU=;
 b=JWtuwIu0gmGkvOhUmhdlgEZx8T/G8QY2xrn2UCmGs+q3kyo4Yh0GrcJHd/HNMn8cZVVPmpYmx9+EAH1+fN02k7I13Whg8SWWwJy4vzyB9WR+QOesGx5j4JRN84lB+YbycyPppGwu8OB/GOYOhhk+LrXN92z39J7dZI3LKz7PGtdZNmGRVRb9si3MlcVNNZg4C+nKL6Niz5SN0D6xQV7KVoaICKWDB4ZVowDTNPlbKk9x0Bzt5umzPveZPb/cdhq6Jo/pRLLCNwPDEXJcvxjX4X70cNlL6Vq5VL1NSfItvO/WIo5tHK6ZxDMHrpgsTojqI2spZKBA4wt2iG0+qyAY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuOpsAXRquuw8lTiZJtzmxk7dRLr9nAsHvqM0jd6sKU=;
 b=tVFi9at+qiItKIgor5YoHsaikcl5fDFo71EMm2IXZzOdj0xXKA2qbDtkOYfXTFOqJqwpZr0La/AnSsw5vsWqtp+PpUsgxWG1oEhuuN1RR3ptoCHM9iWnCls/YnryYj+5F7Ukg2/Dfm7Qrc6HZDc3nGpZs83JGINDTooCoHFohjE=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 09:04:05 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3bcd:97d3:9742:c497]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3bcd:97d3:9742:c497%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 09:04:05 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, cupertino.miranda@oracle.com, david.faust@oracle.com
Subject: Re: CO-RE builtins purity and other compiler optimizations
In-Reply-To: <CAEf4BzagYTGu3eTVtrY+72-CSHDgrBiM3qeeFR8COc9MUYA9HA@mail.gmail.com>
	(Andrii Nakryiko's message of "Wed, 5 Jul 2023 17:02:42 -0700")
References: <87zg4as04i.fsf@oracle.com>
	<CAEf4BzagYTGu3eTVtrY+72-CSHDgrBiM3qeeFR8COc9MUYA9HA@mail.gmail.com>
Date: Thu, 06 Jul 2023 11:03:59 +0200
Message-ID: <87o7kpqum8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P302CA0024.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::10) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 4644d0ae-4bd7-4cdc-0c87-08db7dfff313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xj1IteztPWNYR9+9nerWvvu70pH1vvGCQoWAHyI7XlYDfFYcDsJKaqHBP+PcH/KgyfcZTNlkKMx4hCD1ZkLZiLvTQtQkP7vM7A2+wD9AYBdblEJ648sYnk+Mb5Xmry7caC40sa13U+QrLVziAsfBoaLH/6MxnIeVDkKoKJUZBqTQMdnha75zBqeMd1a29LV69kxK9rssdmYr1cSt2eZxIJrUaD3ITNy0RPfcgcWlVfD+b4i9LdmSjtsFfE9+TXZI/Mza8EApVZJNs7FSkFU0oTFPlVDCis38H73bp3zCyKJ5UMFB4cfiqgIkeyZ0SKdkcus2c8uxQvSgj25Nu4uGYNT+wrLMNPtcO4YmcQx148PRvVpTDJ4inQh4k5CBttfvJrFSnbGR4uIdY+r72ajgiDss1gZ3fNqgVm7GrU3KtUrL7dfLAKDPIVB/zeF6wp6Z2C4l6q53abtbjVLWozeuce8CmYuscZQ75Hn0sgzvgYe/a7pfwHIISobVWc7P8L5AWXdJ1/QaDxdPABB+6cksG7vAkTEauXTU+LSnOj4DU9U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(6486002)(6666004)(478600001)(107886003)(26005)(6506007)(53546011)(186003)(966005)(6512007)(2906002)(316002)(66556008)(6916009)(5660300002)(66946007)(8676002)(4326008)(8936002)(38100700002)(66476007)(41300700001)(36756003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTFEbUNGS0NuUllPSHBaS2VtelZRYnJYMldHOCtiVEcya0RNK2h5UDYxTFhy?=
 =?utf-8?B?YVk3Qkt4aExXVHlRVXdmeFllM0FGSVhFRTNTVVpHQjNIdHFPVUJGMzJGR0ti?=
 =?utf-8?B?RmdVUFo2R2lVclprcVJHeHBHTm1qVTlkUFpKKzh4bnRqcStZeVNjTnVoRExv?=
 =?utf-8?B?QmhRRzhmdzZpa1RsVDhZVi9aTHZnRTkyNnRlZUZ4ZjdOMGRCVVpSUU1IUk03?=
 =?utf-8?B?QndQdjcyV3pFS2VkeEVhYnE4NmQ1SEJNQlgrQ1JZQnhycDNCZnRrR3ZrZFd2?=
 =?utf-8?B?UXhGbCtBSnVHVkY5S3FWZEhPK29TQ3hOMEtQcWVlZS81akdnclRPeEdDN2pS?=
 =?utf-8?B?c3RqYm5hN0x5S05xWU1TRkVXa1lJOGk3cTg3UHc0dHBZeGZ5VXdnaU15dXYw?=
 =?utf-8?B?czBQTWhPbjZvc2ZoMzlIYm1ldzBhcFUxSUtMS1ZFS3gxd1UvNTdqTVR6TnRh?=
 =?utf-8?B?R0NrcVRuRVFyNHQvQ2xXbjJyYzV4ckFUTk5wMHdkcDhSbUdXTkJvd0hSNWRx?=
 =?utf-8?B?UWhza1QvQUFaTjRCVmZpTzdkQWZURTUxVG95eVpWdUFCSEV2N29SZjI3RVBJ?=
 =?utf-8?B?OFpEWkVSWElUOFpPUmttMVlzaEp4dDRuRXM4RTJraWpJUVRWTHdGVWkyU0RF?=
 =?utf-8?B?UWZSMmpkTlNCalBlUUJCOUpReklNdXljc1BvbG81K0MwNWJOM1pZUFdOT3p4?=
 =?utf-8?B?YU5jWlpZNmxRSkdJbnZCaldvVmh3QWJNUTBYWjlvTjRqNzBjVTlLeVlOTUk3?=
 =?utf-8?B?U2NTbi9iNW1zMFBNajJYL3p0U1ZwSUE0cmlQR3FZcG96KzlmcWJ6ZlU3SVZh?=
 =?utf-8?B?OGxZdGtvcGF3UGNiRm9RVXRmR0NxZnpWYlJIcXFIZ0FjeHEyVk42TU5IbWp1?=
 =?utf-8?B?QUlOR1hwTm1ZWVpSNk8zYno2SHhhLy9YQzlpaUxMWUkrR1k1QmZBaGRvdy84?=
 =?utf-8?B?S2dKc0tkZFBpS1RxcUdRZXpvWEt3K2dSYTRSc0JJQ3M4dFFMS2lkb21PRzgw?=
 =?utf-8?B?MUR2VTc5MXR0VGg5TjVXVkg4elpjS1RhUStJUUFuMkZ6dXg4dmRNMmx5MXJD?=
 =?utf-8?B?YitjL08rUTQ4aWVRY1NaU3c0RVV5dGRkaXFXRnJlazMyV3l4NzY1R2hBNVdO?=
 =?utf-8?B?SVloR0gwOHJMa0dCR1ljTGdJQnRUL2tqZEJhaVVQekFTbDJmT1NnOWgvRkpR?=
 =?utf-8?B?TW9DRmFDZVZ0eFN0d2Fnc1VVTkU5K2taaFZpeXFxK3paREIweTF4dm1rWGFn?=
 =?utf-8?B?eDViK0JwM09USHlBaFhwakU0Zi93Tm9udzhkSmo1akh4R0lmTnI4SElOUjZO?=
 =?utf-8?B?VzB5K2hUSWFRNEN1eGYxb3RGVHdoTDFRY2xzaGdsSHg2dFF6NjMvZkhxYUlh?=
 =?utf-8?B?aVNkQmhYbkM1cW1xeS9tNXJFSDIzQlV3OTYwTWNUZWZLMXZ0Y0pnbTVQY3ZT?=
 =?utf-8?B?ZGZmS2krZmtkQmRVN3VSRzlTNFBnY1poYmYxdGxQOUpJKzZiUE5YZ0cwYkkx?=
 =?utf-8?B?bVQ5akFHMFlUbnIwUko2ZHZKVXhoS2JvYzNGcmQxOU1DNWtrNVRkKzMxelJh?=
 =?utf-8?B?S01LbERzdHhianpEM2pBOWdHZDRoV3Q5aEhNSldmemg5SkFoVTFZcUpmd0VN?=
 =?utf-8?B?ejNRT2wyaFQ4U3BHblNteUpKdHBhOURNQWlScm84U3ZzeGk1Z0NQUU5JT0o2?=
 =?utf-8?B?eU1HWTVEcWxPL3dIbjRBMS9oRUxDY2docm9zeEFObTdBNVZQcWVKU1dreS9t?=
 =?utf-8?B?Q0pCUUlOUVUwSEI3STRnVlRBM2ZIS3ErdjV4cHBHeDBwR1c3ZmpJa29Pdyt6?=
 =?utf-8?B?RVY1NkMyaVhMaCt6cms3NUtiSmV2TStubDdyM1NyWFU4QjVEb1R4M2dsMU13?=
 =?utf-8?B?bHNreDlVR2FMd0hHZCtRTDBIYjJDT01UV2pra2xvWmx5ZFNkb0NqSUlmZ0lO?=
 =?utf-8?B?NXpmeW15OXB0Y1owaUJQalJidkRRTFRBMCs0Y2JqUXgwQ3JtSHNDZ1ZNZnQ5?=
 =?utf-8?B?WkhMS0h5ci9PemxXd2hYVE1yRjl2QkcxdDRrdTNOZTl5NHhRcVB3clNBcG5L?=
 =?utf-8?B?dXRxa3BhVWVpcC9zYjBSR2FuRjMxWk1uY1U5SkthOWUyMjRZWTFpZnpuLzVH?=
 =?utf-8?B?Nkdtbng1NzJlVG11bVJTZTU4M25DZFJzR05JaEFwT21pc3MvQnZxbUl5V0Ft?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/fNfsiOb3xFcuRNmSkgWwBNEDmFMj7PM/pvQWtnWghV3qkR9McTlP4pe8U3x1jaSI55Eg7U2KoPzotYgQ/HBTEHZQbkZZV4naCS+oszeR7AmlGevr/aXrXI/1HyDO0wNlc9JH85tDCz3uZ95IWpfF3A61ssOQprcRSaBD2UntIpt5azq+8UHOWkWhmz6eaxzXp7bq500eJgWj3aFWVw233OVHcOSQ1lppnUeSJ/iqZQvyXrzpW/P1/yftixS8rdhBz/pRGd3GZA8tTzHm4Uu35wZ7yYq4+ZDIw3yfYsRLM8ludSJN3aYL/SR/OAECujEAYrnMBc6EcMSz/2dljYjjIWFpLYE6Qt9NDm65A6BbKUvwJPJDaQPU3vpmsdAQjYAvYNBAzfIaxKbk+LQSnYYxSdFyi7fQz42IVwvEbuaP1IQxGTVGHbAJY+Kw4LmI3qAueFkFLsZDCmNG893DK9g0QE3/hZ4V05S5A0FuDS3hHEFfKvs34xq3U0QwgT6irG6G7Mwg6N1XDeotDb9orYyaGdiYl9Chk+sa5PZ+R9xXOUa1ias4MPNLaB7neQTr3DBRWmAoBAZcplYnKqgRlBTUkGl2PXKXSaMlDYHsxac8qUPuGXEaNfmoFd2Ul1XqqGKK50+9F12w0jLugI+i0sdb75brD7DrQrqGJUFmuQiVyqV05At14JRTd2lj4A/PBSA5ZHs0A8Ga+VuHQaAKpUe4rG4ozJmHgSLmlSiZx+shqVcAFztBzjn0cOBxHSzlRGdtIFHxSjRSe8lOl1h9Fi30r+FoqeWZ9d57Jw+Q74RDkY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4644d0ae-4bd7-4cdc-0c87-08db7dfff313
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:04:05.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5amtjbq/tNoxl/T9UI5IFz2MiVfWpxfQ2ggQlMDElj7pAeUwjltbVqs8BJ1iHtnDDqg57CxbRU/UmqagjJIBq4ycp7RUims+92Udwdsxh2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_05,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060080
X-Proofpoint-ORIG-GUID: phaoEaEYiFNX681kf4HkdcYOUhEIWujd
X-Proofpoint-GUID: phaoEaEYiFNX681kf4HkdcYOUhEIWujd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Wed, Jul 5, 2023 at 11:07=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> Hello BPF people!
>>
>> We are still working in supporting the pending CO-RE built-ins in GCC.
>> The trick of hooking in the parser to avoid constant folding, as
>> discussed during LSFMMBPF, seems to work well.  Almost there!
>>
>> So, most of the CO-RE associated C built-ins have the side effect of
>> emiting a CO-RE relocation in the .BTF.ext section.  This is for example
>> the case of __builtin_preserve_enum_value.
>>
>> Like calls to regular functions, calls to C built-ins are also
>> candidates to certain optimizations.  For example, given this code:
>>
>> : int a =3D __builtin_preserve_enum_value(*(typeof(enum E) *)eB, BPF_ENU=
MVAL_VALUE);
>> : int b =3D __builtin_preserve_enum_value(*(typeof(enum E) *)eB, BPF_ENU=
MVAL_VALUE);
>>
>> The compiler may very well decide to optimize out the second call to the
>> built-in if it is to be considered "pure", i.e. given exactly the same
>> arguments it produces the same results.
>>
>> We observed that clang indeed seems to optimize that way.  See
>> https://godbolt.org/z/zqe9Kfrrj.
>>
>> That kind of optimizations have an impact on the number of CO-RE
>> relocations emitted.
>>
>> Question:
>>
>> Is the BPF loader, the BPF verifier or any other core component sensible
>> in any way to the number (and ordering) of CO-RE relocations for some
>> given BPF C program?  i.e. compiling the same BPF C program above with
>> and without that optimization, will it work in both cases?
>
> Yes, it should.
>
>>
>> If no, then perfect!  Different compilers can optimize slightly
>
> Did you mean "if yes, then perfect"? Because otherwise it makes no sense =
:)

Yeah I was referring to the first question not the second :)

>> differently (or not optimize at all) and we can mark these built-ins as
>> pure in GCC as well, benefiting from optimizations without worrying to
>> have to emit exactly what clang emits.
>
> Yes, it should be fine, as long as the compiler doesn't assume any
> specific value returned by CO-RE relocation (and doesn't perform any
> optimizations based on that assumed value). From the BPF verifier
> side, it's just a constant, so the BPF verifier itself doesn't care.
> From the libbpf/BPF loader standpoint, all that matters is that there
> is CO-RE relocation information that specifies how some BPF
> instruction needs to be adjusted to match the host kernel properly.
> Whether CO-RE relocation is repeated many times, or performed just
> once and that constant value is just reused in the code many times,
> shouldn't matter at all.

Ok, this is good.  Thanks for confirming!

>>
>> If yes, wouldn't it be better to disable that kind of optimization in
>> all C BPF compilers, i.e. to make the compilers aware of the side-effect
>> so they will not optimize built-in calls out (or replicate them.) and to
>> make this mandatory in the CO-RE spec?  Making a compiler to optimize
>> exactly like another compiler is difficult and sometimes even not
>> feasible.
>>
>> Thanks in advance for the clarification/info!
>>

