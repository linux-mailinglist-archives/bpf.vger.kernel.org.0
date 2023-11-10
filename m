Return-Path: <bpf+bounces-14782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6167E7DE1
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 17:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2901C20AE5
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA67A1D549;
	Fri, 10 Nov 2023 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oe1Ddwtg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eUXd7udo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F261C28B
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:46:22 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E0A402CA
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:46:20 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AACEZ2H022422;
	Fri, 10 Nov 2023 16:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QRCq4BkqjT2OCq0o3auuhpnfEzpBH4/LmV1iTuiF9Sk=;
 b=oe1Ddwtg4sdv7UXzGPcKgdMutaIkibPrscf0Kt7GfKi2ObOebHnmP13eV4fbN0pDUusg
 vnEWFuamhtUGngt6+i6YECiA0/5cTChsCskuVA6WnN8iJLu/+dK7C1VfsOu50y14zMDx
 hQcoppGczGxl+jnlwIYElMDhk0yEmvLcNXhLI3yE9mPusUFzB/5blrqHBYmf1Y8gadVn
 nlTFnsCA8OdilSxl5y9EEbJmcl6ZSg6gWr8xU5nEe+455UE94BKlKyJ16fWq4wFYs7p1
 CKa64LeFVKI0meHV/ehLhx4rNcMMRAalPLBpdolDtVjM9iz2rUDj949gi496qrT2Ip+2 rQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w216q8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 16:46:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAEVdiU011047;
	Fri, 10 Nov 2023 16:46:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1y3jvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 16:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf9ncKtoizTqKIxAJ+XW/HRFS2snIr3ZN8rNB/0r6qVtQpHZi88CaII4OThgIPyRLd++Nwp/BycN5SHkbR8kJXMZb/QqWCwZVvERAk8s6jOibLeTqFUG+qXWNVgU4WXHIDTigjNaLgAxIG6JOCaEnHkcaodoyL9U+AmcOg89SbD52VRM9gA3dKX1odJpaT3K+FW4v/HGh0Kl2Kx7YlFD0FnXRAnUCXmC/2IWIuqzQsIiOO18RRkOcLKePAU8nl1/LyWB1wam8inV52tamNVeWbRTxId/EkMKUG33xVB2ekA/dInvVkae74FJrQsgR/+U8CK9Pucy/+lJel4Y9rI59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRCq4BkqjT2OCq0o3auuhpnfEzpBH4/LmV1iTuiF9Sk=;
 b=hFdp2zZTd2BZ54BUWAbnSTzCkt8Ard8LEvI262Go1oYQ5bjO/qwkr0E3KvtgHQnei1FSBLxTVRT6Z3zkXp9tUHsOyzOEI7PmimDyBlXXbYSXvVmbmTQ1vBtXUenIMSGqmH61W5DdjBi5tlb0hUoLoPF+rWnQ/ZjB0eTarkB7vgM4kEV9SdvZj5ExRs06+qdtzds0JYo9VBVCLWjSwgQ9p1JcWMlh8MsBNzMx38aZKQ6RHW0t6gJAe46WdO/pvejWfjw2rmH+xGb7lytKXlRJFpUXVm8UlWYgz8RNFbrO/dCrb2Sh4UJdgVpZu53qRpFo0eDVxhguUGx7xsCwAqmgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRCq4BkqjT2OCq0o3auuhpnfEzpBH4/LmV1iTuiF9Sk=;
 b=eUXd7udoF6QdjIaEWE00YUP17ISE4q0JNnjaXS53Dx9enzCydBjoCSnDJBLIid7xHhy7LqEZoS+IPbMsmuX2PfQpHKUh7ej69XR1plPGpDhfKeJg3VlfeMThmHnKuAMNL5Mc3M2lq8W9YuexaPIP9RhUaAfdQEw4X9Efn3/M/jk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6651.namprd10.prod.outlook.com (2603:10b6:510:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 16:45:58 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 16:45:58 +0000
Message-ID: <57049b6d-2f25-c68a-4322-5e8b1ea93839@oracle.com>
Date: Fri, 10 Nov 2023 16:45:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 bpf-next 00/17] Add kind layout, CRCs to BTF
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: jolsa@kernel.org, quentin@isovalent.com, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org
References: <20231110110304.63910-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231110110304.63910-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0188.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 1620dec2-fb83-4167-b735-08dbe20c83db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Az1aiSXI7MCaIs36+rp0W6KYK8e35UEL7ZsAzqcmvxnSJTc7vTAaWU0hErOMWkcvlvD8UvsYCRehO9EN4fKQccGpf0rNegtoqTk/PFzYsRWWFMGa9O70KuFcvamZRc/h+E+8FvT7U5Vw+3+4lMPdGuhWj223PJnHNIoKFwB5J6ErgwtFisgK1WMjpp57wcRRzU1XV96qfQ1Ym1sTmF/Isf0gl8NBleuB3DVnX6aUZkUhkzNF+0Ew0s5oeVSeZ+2CDCqWu5RULLLipg3iBO/vhGd8gXVNS3+nlKhNUMIjlgG9nqD/eZmX6zfoxTiX0YAiFqTUD55ke/lY+uTqKJrMXt3FfNGVPlQ79yhPxhh4hH9y67A1rpxm5pomlAdyYBysbrr+tNKEu74xJnSjsHQbkroMz+K6DVN0ZuHZ/pGjR4UGfwo2YY1/mVqq1AItSb0i33Nes+DeukSOSDv1gbdiyiFJmH4q9CR4GAO9H/eR3ixiUoNxiGbg/aBsWD7bqANhqPlMmEYSqAas9KTPK0nu7pORS+qFM8OvIRmfIbj+Ai0s7gVrycctzsTzIJ64zXuuH1cA9UME3wmtMSwjAPDVXdWPmPN/CYX6bsIbCtbs9Sk/6LMQpqw9DYVeEkOS/8RnIr0+sdXZAVHEi/oY8FwCHQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(4744005)(7416002)(5660300002)(44832011)(41300700001)(2906002)(83380400001)(8676002)(4326008)(8936002)(31686004)(316002)(2616005)(66946007)(38100700002)(66556008)(66476007)(53546011)(6512007)(6506007)(478600001)(31696002)(6486002)(36756003)(86362001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dW5PWDVwS2ZDc0VqQWYzWU1YZU1IYmJNZEd2YzUvQUkxS1QrcE1ObDBjc09E?=
 =?utf-8?B?bVZBSjlWNzBiUmdLRU4wSnUrSm5xSUxna1BHdURxNnZwbndFZDhzbmhEZFNE?=
 =?utf-8?B?UHRjYng3QVNmbHBXbDZ3TFJKSndHZklDOThpeUkvKzFWRXdFMGNiQVN6cUQ0?=
 =?utf-8?B?VnNSWEIrOUc3dzVOM0hQQTJ4am5kOWo3L3h1VndCdGcwSGMxN2YvM2NPK0Qz?=
 =?utf-8?B?YzVFbjJtbmxacTNJMm9VcTFOeDhqTkdrV3NmYi9rWW1QMVlHQ3UzdUhTeGlu?=
 =?utf-8?B?NWlrRVBmbE85N2lVM21BVGN1Ty9GQkNFTE5vWmlMdnc0dmlUUXZZM3h2M1Bz?=
 =?utf-8?B?NU41cHVHK01CRndDYTY5WGxxTjB1NGJiSjNMbjh4aGJESDVrNXBEVEp1SmE2?=
 =?utf-8?B?QnlVYVZsY09idDJzMTFCUjZLZHN0VjRoWm5XemZiWmQ0WDUvQUVwWTJqdnk5?=
 =?utf-8?B?UU40VHBFOXVzZW5qdW1UYnRFZjBOMFFTcDlmdXBRcDc2Vm1SdkxuMktWM0xw?=
 =?utf-8?B?NUVwMHBnZnNteG1KdFBERnN4NXpzcVZ2RURSTFczc1RXdVI4SWMvRC9BTzJC?=
 =?utf-8?B?ckZFTEJDaEg5Qm5DUm5ja1RMUW1sMWc5b3FmVzlEaW1SUVgzM2dkOXR5ZGpo?=
 =?utf-8?B?OWdORGw1b2x1WFYrenlML0hWb0h5SWlpRnJVV3NlcVQvdGVMTlg0d3E5UjBw?=
 =?utf-8?B?MEhrc2t5TlYvQzBob0o1N0lqT0U4dGNXOHZTbWV0cTUzYU1IamIzek9UM0lR?=
 =?utf-8?B?ektmejFsVXVreVA2NkpPMmdCbDVOYU5jWUY0ZU84TS92QWsrN24waU1MRXhM?=
 =?utf-8?B?UFNxZTBWbHN0eHlEakJOMHIydjNUSzFDTnNqRjdsa0lFMHdpMnZ4TU1RWkF5?=
 =?utf-8?B?a1VESUdheHJ0ZGhHNU13dk9Wc1BDblNkamtxYmFyeGRRRXZhK1hrS3NkQzhy?=
 =?utf-8?B?eFEzUFVXU0llWmJrVncyS2gzWU5TL2E3U09ybUxMNWNNcXBsVVpwWmxBaW81?=
 =?utf-8?B?d1RTb1RZZnY1c1puR1l2Y3lmUEpKU1ZuZ3Y3K2hBdDBXb2hiVXorb2xJS3NL?=
 =?utf-8?B?UFY1TmxVSUJmQktrOEVpbjFoamxLMGZhbzl1UkdFWWFZZ25YTnJLREpFNFow?=
 =?utf-8?B?MGJBbldvRXk5anZ6TjBZVVhGclJOT3BoOHVJdEJ1NXpNUWdoQ3AxaVZYWXp6?=
 =?utf-8?B?QVNqUVJBem1pWGJ5dzBORk4xb0YzUVNtd2lHL2FWajJqcHkzVm1GeEpHZm5s?=
 =?utf-8?B?U1FPMUwwbTNvUnJXYU4yTnJuMU12dzZqVzFUMjBNeHpFaGFrRVA1QU16aHRj?=
 =?utf-8?B?WVJOUEdrRm03eXorNDJwUHA2a1lxanJzUkMrUE92d2llaFg0LzRFaTQ4aHVJ?=
 =?utf-8?B?allTaXhHRERvV1lPTTVEK2lrdjZTREQ0ajZDL280RE1Hb2NjN0RPRkNqVGtq?=
 =?utf-8?B?TW91a2FVeTh4YmZLOE1IVnF4d2c2a0lVMTlIU2ZiZFhpS2V0RytkSWFyaU1L?=
 =?utf-8?B?U2lObStkRExmNS9SbDdJYXhUSEJYNjJaME9YQmMyN2NUS0FqRjFMVVJTWDJy?=
 =?utf-8?B?cENUSkpKZ0VFYnZFLzFwVWxMWTBEM1YzZFhFMmlwc3dJNElmU0N6d2JtQ2pC?=
 =?utf-8?B?U2N2QUxUNUIxUzR1TVlXZ21qZXozekRsTkFoa2oxNEE4aklNMngrbmNVL1Bo?=
 =?utf-8?B?MWVNbVkrYnQrTmkxK2czU2dXRFVSclRGaitHb1N4bzV4cVNzSEpiUi92VFpu?=
 =?utf-8?B?WkU1cHpjYXU1UWR0di82ZVJCUjJGMGQwUnQ3Q2hnU2hPVERJLytYRThpWW91?=
 =?utf-8?B?b2tDWWpBdHgydU1sR1QvTWNjRURIM3R2UGhOY3pNN2I1djhTaUVEaW9rYlpp?=
 =?utf-8?B?bXhrZmphbGRQdXlEanpiVzlEZEFvTnRmcUNMZEZMY3p4TE5aM0Yxa2tucnFN?=
 =?utf-8?B?VC93bWsvbGxHMWdFV090KzZUYWpDNnkzSjJnSUxRbGhqUVBRc3BsaFd0YmVn?=
 =?utf-8?B?Vi9weFNITlpnUkRoVDZhelYwRm5OK29CaHdsamJGc0l3dWJ0SnFTYzk2T0or?=
 =?utf-8?B?THBlaUxCZndrSkxVdzRNb2ZCemVTUkZSV3pPbVBaemw1RXRydkRHQjNRMmtZ?=
 =?utf-8?B?TC9LdkJxdjF0dnlrTU9iS3V1NFA4ZW52K0FvYWM3QngxaHhTL0FyS0hJWDRl?=
 =?utf-8?Q?0ZU1dcmx6NBCBqReSjp9Pu4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RmhLdDByOUdnWmx5SlRSSi9aSStjaHB5TXpkVFc5WGVYbnh6N3BxZlI3amtO?=
 =?utf-8?B?QjZSY1NxaFp4OWxOVkJQUW5WRnFtbW9CYnVoM2JQZFQrR2FSN2w2Q2MxWWdh?=
 =?utf-8?B?NDBUK2l2b0M1VGJFbWIzNmZmckdDZWVPZHY0bk5Sd1JodDg2eksreG1DU2RC?=
 =?utf-8?B?RGJoMnkvUFEzaTJxdjY2RXpxVmliT1pkMkRCaWhySVlrYXhHZDB1R2dRUDBr?=
 =?utf-8?B?SkZndU5GcGw4SG9iaGxxL01kUmltY1ZWRlZoTlU5WGZic0Zhb3RJSUZqQUJs?=
 =?utf-8?B?V0daL0xRckdScXJTM0EyTjhqMEZjTnE3SWwzWGhMQVpFQ3BKdjVaNTR2Z1hp?=
 =?utf-8?B?MjhIK1R0UVhRN1FGZEhRTUJ3M2dma2JncXJxZ2FibzhXZE41TmsxT1hFbCsw?=
 =?utf-8?B?bUV4TVRaeUdsM0tlK1lpTVc0SGljb1krT0p1c0lDR01QRjFLQmdtSGIxSXY4?=
 =?utf-8?B?Z2grdlJDdWltRjJKY3hMWVJ3MHFXY0JmZFJaTlJZSzIvUHFkWFQ5SWxlZHh6?=
 =?utf-8?B?cUJzTmpBNGlpYURLenZJUUNXVUpGaDRKZzRvbm01SVU5Z2pqTHV3UzkzR1lO?=
 =?utf-8?B?d3BnRW1FUE9qMThreUtpNGNKdWNkaVdFODU0eWRFWFJKMjhnZ0lsMUtBeGY0?=
 =?utf-8?B?WnRsYkhTc0RZWXdOT2Y1RWxFZ0gvUEhaU085NS9oeWtqOHJKTXZteEpxZjZV?=
 =?utf-8?B?cG4vY2ZzM3o2L0c5T2Jwb0xJSGtVOExlN3pTVnVHR3lvYnhscEVSVWtQd1Nh?=
 =?utf-8?B?Z2ViVnE3eEw0ajJ5ZVU3RVFWY2U1dExNOXBla2dmeS8wS0IyZEh4T2NCdHNr?=
 =?utf-8?B?dVQxNGNoNzBVbDVSZlR2aHJMSGRmejV2Ris0M1YzME5uVFFBSGQxbHIweDJK?=
 =?utf-8?B?aG9vWHoza3ZFcDZ3NFZiRjFnVnBMM3dFVHlSeGdjNUdsNTBsTCtqbVhuWW1P?=
 =?utf-8?B?UlpGM1lHbm5uRXBxa2F3eU1lelJhU3U0L0MxVmd3MHkyNjVma2dmVStnclRQ?=
 =?utf-8?B?MjlXcG1nQlo1QkkxL3pvZVJIOWJJdm1LMnlnRzAwaFFGY2J6elpSNHZDRjhH?=
 =?utf-8?B?QUw1MXRmdXFaY3JMSmYrYzJVSmEyVnVwdHB2VU9IZHJPOG9ndFpsL1BQMDhl?=
 =?utf-8?B?Umc3VFVvZnZQNExGV2l4K01aU0E4Yk1jQ0FYQ0tyK3d1eGlYMktCYUU1TjBO?=
 =?utf-8?B?RVQ0ODI3TCtkNzZWYmgxTXJ0SHhxUS81NDVJOUNKTyticFJBRC9MZzFYTHh1?=
 =?utf-8?B?WVo4N2xEamMwQWlLMDczLzBLVTErQURjYXI1a1doWlk0TVlpUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1620dec2-fb83-4167-b735-08dbe20c83db
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 16:45:58.5520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZysRzwgJQzUIfyo59HIDPFftRLw3aYXFoMQiTxPRsvJ5g0nhelpDhMaGkCpOCFT8mBLg3awt/TQ+9/z3XCZARQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=821 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100139
X-Proofpoint-GUID: fEcUn7jm0lhjTEqKlyteGbHEBP2KS0fV
X-Proofpoint-ORIG-GUID: fEcUn7jm0lhjTEqKlyteGbHEBP2KS0fV

On 10/11/2023 11:02, Alan Maguire wrote:
> Update struct btf_header to add a new "kind_layout" section containing
> a description of how to parse the BTF kinds known about at BTF
> encoding time.  This provides the opportunity for tools that might
> not know all of these kinds - as is the case when older tools run
> on more newly-generated BTF - to still parse the BTF provided,
> even if it cannot all be used.
> 

apologies; this series collided with the Makefile.btf changes that
eliminated scripts/pahole-flags.sh, so patch 9 triggers a mismerge.
I'll send an updated version once I've respun and tested. Again sorry
for the noise!

Alan

