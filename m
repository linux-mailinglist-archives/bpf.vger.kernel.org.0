Return-Path: <bpf+bounces-15674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357C7F4D11
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 17:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD6A2814B3
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2453D59B6F;
	Wed, 22 Nov 2023 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BSpKh5Bv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fFQ5iPeM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FD5109;
	Wed, 22 Nov 2023 08:44:38 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMG0HOr014284;
	Wed, 22 Nov 2023 16:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4egKiIcH5IShKNvGbrIYR+swKPLeXQo24V0VPT7Y3vU=;
 b=BSpKh5Bvyk/c16e7VeYCNH/sEHiCxrt2hSZMRPE/8uoTfgtITZsTlTNu45+E2F6KQADd
 1D5g4q4XSHNCpkiQxatvyIccHTxw39FrSiB0JiJl3eN61qIz5cd0MZmwa1chmivP8z/L
 DxPl54fIX50wltjPKcFL6cEOdVK9eqi2vEf+ux6QHUlB3hxxgHywcuVzb/VMcvjrH6sP
 HIDAO7jQxfeuDgHwHZQAPhYiSp67OKCjJ36cArh5l37ioVwd29X8pVm76kWeIifct4Ul
 zHZCYF18ZW50LQGPYbCYlg9OMo974oar5bR4yrnd5jnJzOzA9Dr+PmKoeVDEDUhN7lRa JQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uentvfybc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 16:44:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMG8K1b022706;
	Wed, 22 Nov 2023 16:44:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq8uqm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 16:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mut2DqHR53JVT7kmnDLWFEcWtodtIWaYquS7YjuUpb0Q/tMKpwyZiO2D6tqnzSmxxByFC8hzeQ75m5Jut0ldsYg5JRwJnHw3upQ13+N7ujBHtVnjvqvtAlEvrxIuvMmrZEnZa1TXWDLH4a8bFuGtQHlho5GrqbHo9hnaKIkoItDcFSjzk+RaDGAjVQ/svYvMAhfBrkVqqTORfRyR3ZhmMlhNyCITXmfL2LnH+xNVRiYtG7xfsplZTtiiOOgOQ3K61YoSzz6BOHsaoBG5ERTRIhEG3LYyTiZ9IxNRUh5ThZEXUEaviX8cwhpqYfnEdMq8odp++JR4sPOjnP3ylzGmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4egKiIcH5IShKNvGbrIYR+swKPLeXQo24V0VPT7Y3vU=;
 b=CKaZzw9HV1oYV5xV1Zs1wuPB9D2YK7SHpRiuAI4kKUqp8wUMnIznRl1gcbul5Jxx9hR1uTiIf2Ya+7CCdh+dFsmlr3mIqWBwD4dxbYjC3c11484nXzHmTurDxKSmhkgCnLKc9KdW4AQyqnA8hiFjRcoyP5nOC3Rx7zjzx/NagaKrPqYhMEiAPaBRwkHXR40ATzNGxoj9JXWUo0bLQBgkNXLRk5HjdyJ2xpFW8PD7UUcMbiUwB3+qZloJHws/0CpEIEmWH5FYflkUxtTqLAhDM3RCOMkSeVwM1NcDkTCs4se+1yQOlduU2aB7+Ji83K2sF/Wt2PDImFyE81ihadpt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4egKiIcH5IShKNvGbrIYR+swKPLeXQo24V0VPT7Y3vU=;
 b=fFQ5iPeMkN/rpSiC2k21oCa3inmAptZxnY2PFWX5UDUAuNWFQwWFYUoGcNRhrntLH57IR/lm/bty+wuAi8M1KZbnF3eQr/BapEGZF/ALjNaF+U3CycEPGdLfBsLSipoMev4wBnBeqcGo7IR407WEKsWGpVSEpb9MWCVWf16ntSs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA3PR10MB7072.namprd10.prod.outlook.com (2603:10b6:806:31d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 16:44:21 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7025.020; Wed, 22 Nov 2023
 16:44:21 +0000
Message-ID: <8a713266-777f-099c-2eed-7ac13b7b72a6@oracle.com>
Date: Wed, 22 Nov 2023 16:44:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] bpf: add __printf() to for printf fmt strings
Content-Language: en-GB
To: Ben Dooks <ben.dooks@codethink.co.uk>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20231122133656.290475-1-ben.dooks@codethink.co.uk>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231122133656.290475-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::35) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA3PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a711ddb-39c0-4332-2136-08dbeb7a4672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cT8PK+t4HuS7yu2zs3kW1NvTkKs99LyMPUIsD0rvP7QcslD2ZMUsVZrTPdeCp74bSJKQRoXXqFOmvnGB27WzWRf9f4mzf+ZPhH5PGKPe9YL43Sm+fIBtQBNXzFn9YcJJ6+bRvy/FDVaNR+ktNatExW9BogSAif2vt+FQArEP+tKhhHoWe33EWQiWAx2P8HkdO4jIEbqa4fZ7N+6srGY93u0GCDj4Bo/cvXz5v7Ga4NPru04oHgi1v5auilBn3LsZdhotHWdYjCg9ARgZRc9uUWblZf62m+OTqZxoO6srwPR5KC4G1T4kIsX9qEgQmffYyeSwZMSVHjABot7roDHfJzs1AmcV0D7pOVvHBhz6d9wMgH2Wbl5bKXbz57itB80JqzIVRba9YLNG43I+SBdTgiKJ1o8SyGGJ2z+Mbf/wykxYIVO50qGVF47gm/HG/c2SEwMW4weh9Xg3sCCDJTiTnPRb6odIECB6XMwNze8XZEyFhKBtEM2Q8pijQrEMtz0+dWLN3qaOW/D3HeJ1a3+9eoEpwqh0ZaNuNdGzlY+HQC512QL3CxIqcTA7KseHNXRr1m5/of+EipAQXXgjrpygOwB3kpuFNmVL4jRj9nZdJ/b5QQlApE0IHKV53XAsoQwG6pYSuvoPG8AXqWgqTlurmivigYJWHDxCbiuGtStcXVpBnxMZ6rAVa7Lech1qORcr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(36756003)(44832011)(53546011)(6512007)(83380400001)(8676002)(4326008)(8936002)(38100700002)(2906002)(41300700001)(5660300002)(478600001)(6506007)(66476007)(316002)(66556008)(6486002)(66946007)(6666004)(2616005)(86362001)(31686004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnZMTEcwR0FQSEdnWThZK0UxMzBvNFMxdS8vV3RLS1NwUzkwc1grWm5tM0o5?=
 =?utf-8?B?MUFXYVdEaG1DcGQ1SnJucVU1cmE5WUpEUkNGbjF2aCtBVGY0WU1pVUFLU2RH?=
 =?utf-8?B?N2JvV1MxWERUdXExNGRDbmtQclJkMTBPalo0SjVwSDhmL2pIaEY5Z2RYWFpQ?=
 =?utf-8?B?OGdFb1lUWnEwS2FGei9nWVQySnlFY3RCdFI1M1hBZFlpbjRvVnpMUzY5Vk5J?=
 =?utf-8?B?aTUrc3hWbGdQQXlNN0s3YU1YK3VFa2dtczZiUFBzc3haMCtCaElHNWRBNW8v?=
 =?utf-8?B?K3I1azlzMkpRR094cHZzKzVBaDNEWXh3K3g1MVNNeVpHNllweVNYeWlzUGQ1?=
 =?utf-8?B?L2NJblltaU9NbGprQTFURUh2SXVzVmU3TmcybTRaMzZsV0k1VnRWdFhYbTE0?=
 =?utf-8?B?bE1mMkVtTXZTc1NWS0VUemFSSndKQzRqaDdYZ25PWFhrUUc4YlRtOFBJczVy?=
 =?utf-8?B?YndZT0V3OHExSDVsWlh5eUhnYW1sZ20rZ0ovc0c4MStjLzBDUlBWbHJnM1Qr?=
 =?utf-8?B?TVVTYkorUm9ZS0ZBUHdaOGFrbGdqM0NkMmdsUitSaStBNmkyV1d1WFovRHFG?=
 =?utf-8?B?azVTcFNzTU1WYzJ6ZmFFMTE2MmIyQTBkeVZ0SGcxbXd6Y0xPN2JGTkZYUHlv?=
 =?utf-8?B?Y0tlS05XOTF5OGNCVlh0T1hyRVdOTE1OM2d5azRoUVQrcDdpaE9nTXhhdjR3?=
 =?utf-8?B?cDE0bG93L1BCZytUYUMyWEZHVU9BM0xzOXlHT0c1V0x5M1NvdExQMzV2MnhJ?=
 =?utf-8?B?dVVSeGNXNzloNU00azBBRWxmMEEwOVNhTUlHenFXVmgxcjdYYzRtVVh6VDFv?=
 =?utf-8?B?WFZ6b2I1N2dINHJmTDV5SWVxMkFyR0E0TStWVGMwaWcwc09aYUVjcFc4R0Vt?=
 =?utf-8?B?dXVUS09kQXhPdS9ueVZZS0pPY0ZQZFBVZGJXVWFzWVBWR1dMU1Z1dlZDdUwr?=
 =?utf-8?B?dWlQcEc0M0t0KzBhdkUybHc3cVo2QjZrQW5wUFc3TmNibWEySVBWZFArcm5i?=
 =?utf-8?B?RlB2a3dpSytWQ3lKUFZmZG9TVSttY291WkVBLy95Y3VjNDJ5bkxRYytwZ3Bm?=
 =?utf-8?B?RGRmSmhCSWYyOEJiNmdTYU9BUlVCQVovS1NObFRuaGh5MG5od0NvcUVNMGY5?=
 =?utf-8?B?Q2tzRDdHbTFmeUxHcVZvOFRzbmVTNHFyZWd2S1ZTbWIwZnYrSTV0eXpnaWpm?=
 =?utf-8?B?NGNxOFZRcTBraG5wT0p1UmI2cGJnRWVoMjdFdjQ5bHI4UXRHUHF4MXN0VXZ3?=
 =?utf-8?B?VHFkZng3NnYyT0xFdW5TRXVwK2NFT0tTM0pGQ01hYzlCaXEvYU9CS0JEaGw0?=
 =?utf-8?B?Zk0rYUtCSnpsSjNRWDNzNVNTYkhvZFQwK0haTXVTbGtiNThaT2pTcCtGeDlY?=
 =?utf-8?B?T1oyN3loVDlzTTF3L3JjaktKM1dNclZPVWx1QkNtN2tIZFZRMEFWK2pHczNv?=
 =?utf-8?B?THNMRHl0WnZsTnU3UWp3ZU5KQThSUnQwY2QrY2NheTR3TlJxWm1tckhDL2hs?=
 =?utf-8?B?Y0haS1JCc1BDUXZhOFdkS1hIRDk1NDFSS0duL1lEVEtKOERKNVhoUElYMEYy?=
 =?utf-8?B?Kys0Wk56WE5kMmFPTU9IeDYzVGhFSzEwWWtGSUVPZTQ1SktldkVxVUt3VDh6?=
 =?utf-8?B?eHJ6QnlvblVteWhyK0NjRzNCREh5M1Qvd0dJemNhK2ZoWkx3d3llWGFKM29L?=
 =?utf-8?B?aXh6MklJSmhVVks3NThkS2JvV3UzbDZZL0FCdXdSNFAvRUdNTUFXSzl4WGZ4?=
 =?utf-8?B?RXZMY3VPTVJDbm9uMmhTWUVVTWNXakx1NG90amtKN1JBangxSEdSNkI1OG5U?=
 =?utf-8?B?Wm9md0xCVHNkYmdRbFRnRXMxUnNTb1AzeHI3SWR5cTJXUkZkU3BOUThxOGpy?=
 =?utf-8?B?Qks3dGhTRDQrK3VXS25wNDhuRE1WcXhRYnM0SkkyL3dJT0Q4YWxGcGZEUlNr?=
 =?utf-8?B?Wkl1djhVOHYwQmIzZW1YcFdZYWlKbTFYTW5FZHc0dzVPNEVKaS9jbVl3UWgx?=
 =?utf-8?B?VVpvYVNVbW42ZVZUSDR5eWY4Nlo2MUVHdWhWQStQTm5YdVVOeUdZanhLRmcz?=
 =?utf-8?B?QXorUVNaL1Y3T3RmQSt0VTBJaWhzV0dmYzBNdWwyeGx6SSswVFBud0NDc1Uw?=
 =?utf-8?B?emhWbTFVSkhtWVVPT3QyRHNLb2pJQW4xK1JjNkdyWDdwZWlDcmRnTy91NWJO?=
 =?utf-8?Q?P56QTGus4g0i7X0t9KnVNBo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0IFy2qocIUXI/ilWEUzxdArxAR/ovJ5/V4ir1Kr1OzB7VhPAX2QiGKV9lnDReg5fFop59pORPTVdOAsMPLfF4MazX4jBLnGREci/fcjNj2FOnEtQgwSEHPHvfUr7YgNmOUWOzrly5E9U24BlWnhsuBCFBZPh/4FyvsU+dG4S3DIFbiTsxRA9kDNb5xK9kVskFXfljNXjs1OeveF4Dz27CBTlqJQvwOWgzKO++OcuX1xVUErAvN/XF2fYGb4ubJ1iB6J1jmVIKjqkNjF3c+AuwZxK+l9qdnTrMN473foMylF0DMw4J41Y+W/S5qSDOF8MNuXYZHsc8W8/j8jWaj7EgisgIYpPURCIJ6/4/9LGzEPjJ83bmF/P12wG9jRYnPa1z2Y0P3j58Sv6jHeAbcYfuwY3K/ibI8B35XaLK8tTRqSG1+aLGxadiNMBUCiB8dsTa+VrwV4z/F9IyamTy0PoFy2ck4hTA22DEGI+5RIjg9OqUq/5i6bAPJAUfizXm+M/1vc2RYG9YSuLK+18bngBhDau/0CpcnyNwzBu699XeC1BeWV+RDciVqkRAJ4h5CZ2AWh3TYKqa9GDloNTFVNm+stOMLTsRGdIvXEgLaEf0DFxP6aR9YC8SXAMKwQeeVZLp4HJL6QTZa23+COI0mHfWQvsO/QMKos7mYIvgCRQQ7PMC+855at56vAFKRWv+QCvlVlgPennB0zf+vYThV5lBFG3jzbOftaNriCDj26kUd5Gm8XGDVGY5Nk0f6UGt4NHPjHJDl43JmFbRrGEhScin8hABPq2kEHce4//Zn/cMLypRKS+C4Yy0l04OT7sfDv/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a711ddb-39c0-4332-2136-08dbeb7a4672
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 16:44:21.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrLe6ehq2W4dzWKYtBnwkuwkmftA5AC7InN8gPSZKWBek2dPRTd3pMg/OhrNTrhtzClu/xKWOkgeDwGMzwfSjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220121
X-Proofpoint-ORIG-GUID: lQSPnS8QrRaHEcEuFZ7d6qy4BV9tMLfj
X-Proofpoint-GUID: lQSPnS8QrRaHEcEuFZ7d6qy4BV9tMLfj

On 22/11/2023 13:36, Ben Dooks wrote:
> The btf_seq_show() and btf_snprintf_show() take a printk format
> string so add a __printf() to these two functions. This fixes the
> following extended warnings:
> 
> kernel/bpf/btf.c:7094:29: error: function ‘btf_seq_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> kernel/bpf/btf.c:7131:9: error: function ‘btf_snprintf_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Looks good to me, thanks for fixing! Could also add a

Fixes: eb411377aed9 ("bpf: Add bpf_seq_printf_btf helper")

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  kernel/bpf/btf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 15d71d2986d3..46c2e87c383d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7088,8 +7088,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
>  	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
>  }
>  
> -static void btf_seq_show(struct btf_show *show, const char *fmt,
> -			 va_list args)
> +static __printf(2,0) void btf_seq_show(struct btf_show *show, const char *fmt,
> +				       va_list args)
>  {
>  	seq_vprintf((struct seq_file *)show->target, fmt, args);
>  }
> @@ -7122,7 +7122,7 @@ struct btf_show_snprintf {
>  	int len;		/* length we would have written */
>  };
>  
> -static void btf_snprintf_show(struct btf_show *show, const char *fmt,
> +static __printf(2,0) void btf_snprintf_show(struct btf_show *show, const char *fmt,
>  			      va_list args)
>  {
>  	struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;

