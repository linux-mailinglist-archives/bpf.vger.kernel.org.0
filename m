Return-Path: <bpf+bounces-20079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A2A838C1C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 11:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6AFB215AD
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B385C615;
	Tue, 23 Jan 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vj/itHEt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oRTpMmng"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BB57300
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006013; cv=fail; b=XWYKzVhxyb1dzluNhNKfG7VT36p+zpykC1xIVzl/KBqGtXgjAb6pBhrqv2qCJzoe/DY5+OnwSqIK30nT6uIc6gt3A+GNcGPqrCwLMyW3xWukXHyXKIoAFHotN3i7JpAVojU71xl4COLP3XVHVqtkDsNSCcAZGTgZyLV4Zeaw1SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006013; c=relaxed/simple;
	bh=cNZ5v3a/3hxzZwB8fm2QjvIZN6cknOxEJV/8OVToJf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D9mKZRJHROf8NRYQL7+s3BpavKi5TWl5biHllYWBmCNDqAkGIXQgBLBk5kGUhuJ41WqJxwZzbBSGDUxGjPmd0/Hz+ybE/TQrRoHVyaIz31cOfcxuiJTD8WI/VJ/vZiDWgI/2/kkioLqaJeQZiGI8X/7avsFna6BeLGHbQ1ZJTTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vj/itHEt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oRTpMmng; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N6Z7mu029612;
	Tue, 23 Jan 2024 10:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EjHru6WUCySAOacVbf38DjhIbAZJEmWma+SeGGC7Wd0=;
 b=Vj/itHEtED/Rm1vCtb38ygXzzBmI9AZDpYg+SBjUieUYVernrtrOMDsZ/7Xy8Hy4p6ap
 JF3YGFmrXE76TCp/O2TikvWUcKqCvIy3QpyIt0WnfqAt0mG2IQ1CEas+rGBQl37NC2Gx
 d/kE9GkbNAA7Lr/07oZeA17hSZT93TaFSSLjSvmoNwGULcZlZ51t0L7oHwTp4Iz2ug5d
 dfkIXFc3CA4W4rh7vCxEZZZW8OEDTWU2U+9myQ0Dt+6JO1p1mX2BWjFvsLLSu7wbFqd4
 rupvOZpEBFNUQPPJwHls/hpNWHZWOP6LgvGIcefeOyYo9PV79RgYB6dyDmq0WAU2uvgK kA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cup0nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 10:33:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NA0QRq016285;
	Tue, 23 Jan 2024 10:33:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32qkjdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 10:33:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3O1E6B5fu/E7Nyci3zQBfFDgKuIZLFNHVQSvRUHSY25HtJsWffpd47a8LkfbRUr0ZWdOxllDrFsL9+lDbWa7xtxCBQTS+R8eOK6vzd5JJBrcEhE/2+3q5pn/Ug5UH4LKXu05Ur0i/ZndA5Biuue8rBTYpogD/ENAZ7aPw9Q0QD7GLEUpvbbDFmlpEJ7ajzMR0CEgQjjBu4NisM+EtZ1PWgN21widh+fKxx25xKVxVMZTI7TBiKkGU7D+nazEuvXh7CUERvOpObVaKQnS7PDkGHS17wF7oCJIHKP+DRTM47HSlue7JZ1sLxpzWJ0WWn5iwME+PJIuakdTElkZ7xWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjHru6WUCySAOacVbf38DjhIbAZJEmWma+SeGGC7Wd0=;
 b=Vcgje8BTvdMfjb61LKPmy0n9ym6Wb+IQXThUU5DVgl4ladbYYn6pa0/+wUaozAcBabeNrBtmraWIo3UBUb4ryqRkJAlZkloaoQVrzlUS9jf/rmurPCSc+OMRKjNJ+Bpz2VwgmD1zTSWTdgE/y//fjC1CNNL4PCOyVxm5qIOnUuNzs2BRo2PwMSUrVjFeMK2H8sKMStciqC+2MxjKQZdTzUGCj0oiQqRKDsdQutRFs+wFdvG1fYgoNmvLeu758hbm9cVRu8fwF24Bs7K5oUumvErYvu09pDU5vRZCkCRT8Y7Eh40nzQUz5lxLTH6hCDQkJVG8LB27Zr/CUo+0y2L/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjHru6WUCySAOacVbf38DjhIbAZJEmWma+SeGGC7Wd0=;
 b=oRTpMmngEULeVqhZFlLS1TJIN4rfq0x8Jj3/rUnGiC7MFM/rFSesH23WJOiUlMbV+4qj4wyJRrpyZAhDoAGzh7HB0JhzDbpPPbANKDqk9UhUTODqGaoGwbB2JY7EyAhsFS/swPKBlEmafbEaRBFQr0bprGVy20ENAA6PZDEOm44=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 10:33:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 10:33:04 +0000
Message-ID: <9084d1f1-0f42-b4b6-083f-c792cef14fc7@oracle.com>
Date: Tue, 23 Jan 2024 10:32:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: RFC: Mark "inlined by some callers" functions in BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <songliubraving@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Jordan Rome <jordalgo@meta.com>, Yonghong Song <yhs@meta.com>,
        Kernel Team <kernel-team@meta.com>
References: <B653950A-A58F-44C0-AD9D-95370710810F@fb.com>
 <CAEf4Bzb6kcR3vqvwzQbCEoW63RW7s6X_fEp9gSRSEck-oz31Yg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzb6kcR3vqvwzQbCEoW63RW7s6X_fEp9gSRSEck-oz31Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: a6161c70-4f81-4f94-b414-08dc1bfeae86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4PNi84hmXJnW79LwwBtvPtcojtpi01cZtp1GGc57bSi+7QLCKMhy9nMAuxhQ9X7ZO4AGsoCK3UP1CaWeskiFkXfHqPZEdVcegfBrK/El5blLcjkADrPzMEQhhvvpaRMPTkD3vj1LPWLYQTJoKHG15JRyZXRl2Wa1JT9URB678KAPHbAKGg/QL3CSlaH5JLL4gIdgo+vcgzNpZQRyqQGHNyEHzfLsZ2Oijk1MlNR2tnnITMb4qp2gr+mU8V6fxNsBYkK4gu/YNDRF3c1lNuVBeIxT6admO56L6UK/tcakWK0O4gDIbTJpsSfNzV0yXEZ7Yr7X13DUlC0+qIPmB+y7CRWJ//w+BCp0V+UJe2TMLaFZiP5IdBXFLlaAKt2yfeYUkfkT5DpIhaW9GOXmEbAjTqs17+Q1m/F01XJP90z6tGUU8dTJFxA9B1iIA/DktnapJ2S1zBECyEuDFF2I/wLm0ZJFNFI3V6WrPFMAX0deyfIzOskc12R7bhBhX8ui//tTdKTpko8lVpVZ0cNI+sMIipMHJlecVGYU52qPE3YMl1v1LpFz2HY5aqsTBe7yVS39jjojTVeCItHhPNu2h4u4G6sBd1lPz4ss2B08WTkXPbRCN87/zwpq8/CNpKHP5o9NGlKTOvl673NnawvE4zN+RKAAOnYKlVe1OoeiMHJiFzOSAKH2wg1i/q2pjy9SwG2l
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(53546011)(316002)(66556008)(66476007)(54906003)(6506007)(2616005)(110136005)(66946007)(5660300002)(6512007)(478600001)(31686004)(6666004)(6486002)(8676002)(83380400001)(4326008)(8936002)(44832011)(36756003)(2906002)(86362001)(31696002)(41300700001)(38100700002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L3kxREpvOFpNRUlOSUZsN3RBZzl6Zk5zMExySG8ySE40bUVqc0lWRXZQc1ZS?=
 =?utf-8?B?bmlmVHh6RkhxNmY2WW02RjU4ZGE5UDBTRTgwbXd5NkpWVy9sd2R5QVBLWXRa?=
 =?utf-8?B?MU8xNFJzbkNWNitPS09yWm1mN0VCWE42NGhNcGhxd3U4eFFHbitPdU41U2Nt?=
 =?utf-8?B?eFFqeHhZNlBVRldsaTNBeEVDR1FVMjlwOXdWNWRHcmFETDdUUk15OVFmNkdt?=
 =?utf-8?B?SldhOXg3OXNKVWY4a1BqaURhNllGb2dKdno1cmtyWDZmVzRBczA2dnBrUk5F?=
 =?utf-8?B?NlA2c2M1ZE13emY4SEl0RThiM29ycmpkMUZkVHlpME9EZ1IrWEliREdsczJU?=
 =?utf-8?B?M1g5MjN6TWVWR0w5bnZmeWFXbnRVR2hYdHh5V0p4c2xPNTRDaE9ZZHNiaTk5?=
 =?utf-8?B?Unp4OVhzbTZiOExaR3NMaVZHNVZOYXFDRS91RGJBTTZydm1ieXlwS092TmR1?=
 =?utf-8?B?L1BrTThCNnZOTWJhMzU2cTlaU21YYVJ5cmltZCtMYnpnSmhYZnd1OGFyK0RR?=
 =?utf-8?B?U3JNZ3kzQUpQV1VqOTI3b3dEM0JuRDVNZ1NaODZSbHVwU3hPUGRHVGcxeUwv?=
 =?utf-8?B?RXVNRXlXODVzMnNFdG5zaWY0WXd0WC9heEZURUphaWl6QjZxSTVGUTZaNmRH?=
 =?utf-8?B?RVlPYVJFWmpJSGVzdWI5TU5EaE1jMW1jUk9tWTZHRHZXbmRJTlUxeGNiMUwv?=
 =?utf-8?B?d3ZUdVY5VWlFNEFvRStPSzMrS3gwbXJUUXErNDNBMktVc3MyMGI2ZmtRbm4x?=
 =?utf-8?B?Y0lkbHA1UTJTbzVVOXhPNEFQazR3dnpieXpaZXFReERLc2VzTml5UEJXMzFX?=
 =?utf-8?B?NW5vQjVrZVFvUGY3TmEwVi9SeFJzMDgzUzBVWnRwV3EwTXpCNEIzM293Nzh2?=
 =?utf-8?B?RlA1SWRWNjVDMzdCRVBmWEJQYS84TkJmZ1ptc29LRnpONXZ4SW9mWTlIUHRX?=
 =?utf-8?B?MDJtdnVsZ3FiWG5CUm9oMzRNRnVPcXpYWDk5MFd0S3MzcGQ0VVExOFdoTjNk?=
 =?utf-8?B?SFp2RExZQzhHMzJnQnlHQlNzTVdMeVhSYk53bTdpUGdvOVZ4Y3E3ZUNkYkE3?=
 =?utf-8?B?bmJKc203S25uWm96djRxREhVNDVkcCsrY2psbmc3WTJOS0haU3Y3Tk5YVWtt?=
 =?utf-8?B?V0J2ZlY5V3B3Y2RjSnN2TmtNM0plNGpIV0tzbE1jYnRzZklaajNydlhxczVP?=
 =?utf-8?B?dFFLRU16OFB0UU81UThHVU1wNTJ2YUN4MmZVQVNtWitpUXVaZnUyQTN0MDly?=
 =?utf-8?B?M2JpbXVCbld2cjZLOEFlZjNzb3BKdTVPcVNrZzgvZ1Y1UXlINzVxZkpMRXdD?=
 =?utf-8?B?Uk1KalM5a1JoenZDRlJNV0ZHb3NZVnJ0WENwcDl5bnp3aW1zK3RrM1BBL3Fj?=
 =?utf-8?B?SUdHTnBFL1c0SmdudjlpWXZma0NmRmNCYW1xR2tBNU1zTlFiZTUxMGVhMHBm?=
 =?utf-8?B?K2VMYmE0UE8wdDhKaXpubUd5Y29LSjFwZmtrdTNTeWhRcWlPZDJObDFpWi9N?=
 =?utf-8?B?UGdQc1BySE5QSndlY1V2Q1RFaXFpY25Gc2ZBK0IvY0dnVWdISEdmaXRLblpZ?=
 =?utf-8?B?ZE5rOUFKK1R4bElMYk5laDEwNWdodWZYV3VveXllVlpmNTBTclJHNjIrYjRk?=
 =?utf-8?B?ekh0SDN6NDBveDVwSU5sZSt2bWpKc2pEdEVGaGlJeHZNMVdMMTdkeE9YRDVG?=
 =?utf-8?B?UjJQaFFXbklkSE1DMnpEZEpPc2xidjJHSytwSlRKMExzTWVjUWxHZnM5RXdo?=
 =?utf-8?B?ZFh2WXY1VmxDVzI3VmRUS0NjczVMbGpmSW9pbEo4YmxRNjgreFc5Qk5KSmdi?=
 =?utf-8?B?N2d6QjVsNW1vci85NTFrMVQrMEpncHJ4b3EwNG9nODZjeE5xRGlNWUxKZnBK?=
 =?utf-8?B?cUNud25qRm52SXZLcGhjb1l1SE4yRDJOYWU3eXRZVktMWmFQTUFRMityRWcw?=
 =?utf-8?B?M1pXWnZHZXp4UEExdUltK01wc1JrTnE1dUppdWdZMnRvRnZxUm5vR3VHYTk5?=
 =?utf-8?B?T0NZcTBhd1VteW5SOEJHTUMrSVNxdXVaajJtQnZuamNiUVRRYWJGckVhRlZj?=
 =?utf-8?B?bkljNk9zd1hQNkgycW1uWnJ1eHloMU0zTldFSEdtZnluME81MFFqMzdmY2g3?=
 =?utf-8?B?K0JHTUc1QXNKSzZMVDZVa2Z4UVZrd28rMy9McTFvcTRsV0taWFpFQXlzQ1JB?=
 =?utf-8?Q?8TqX6/rgstqKGGelmpSmr64=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vkkel4zDWhn9vohFZUlK0H1u/+0yF3eZcIFZ2OKDBdUSbXJ2sAFF3PZfRwMHsIw0JH4nx5fBQkjUQFwF+1EraZDH5SeuRbyOTQgGCj+De9GAv5ruy8U2ftwsImhbyMlXUtz3lOONBWJR257j1/4Elzxe+1i9JjAVqCnCy5mFy2pe/FxQ+5N0UEWa0EGfwwXMRQb+GRDjfciK1v/hHo58xjsBrGGhJaLEe9ZI0/hRtPs3Yn7u8NPajHcewzID1UJzA89DBIWSQMvdKFy8lFCUcpO56b6cmnVC+Bo5aTWJBnu/Su1LwUkwbN5OKmquBcU/6ZjyzT9t8uk2CAJa5JGeU+VaWA47IukEVMWGQxqgWHn28rbgBr6l53atFiAo7PXfM0rQmHpyDfn5hDtOSjXLy9p+9Qk2ghxL4JNMQk6qfj/09Fz0Bc6CDLRd+T+d4NNeuye2KZiZ7mPjibz6j/LL94KrHCStF12GBiwXvXAZ/HdJzeHWGAp2dk6MTQTClK78rurqVNVC9KYLXWlyqHCxtAjY6DM4S87oa7oitX/w5ic2uR8sh7ZKmsm26qWsnkduEz1/6zi0d6imZFbi4OoQhdbz9avLDwZ1yMYeHG1R2uI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6161c70-4f81-4f94-b414-08dc1bfeae86
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 10:33:04.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3Uce0Xwsl3PPwFBs+U9utyISD/B0pNEZoisF8pqhIsVWwxE+UTA8aWEi/DcUwqtnA9+gUMpwVdjJjBsIftR9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230076
X-Proofpoint-ORIG-GUID: 0XUPKkoSLq30vYhVPeAMFkk9-X7mjjM2
X-Proofpoint-GUID: 0XUPKkoSLq30vYhVPeAMFkk9-X7mjjM2

On 23/01/2024 00:30, Andrii Nakryiko wrote:
> On Thu, Jan 11, 2024 at 1:51 PM Song Liu <songliubraving@meta.com> wrote:
>>
>> The problem
>>
>> Inlining can cause surprises to tracing users, especially when the tool
>> appears to be working. For example, with
>>
>>     [root@ ~]# bpftrace -e 'kprobe:switch_mm {}'
>>     Attaching 1 probe...
>>
>> The user may not realize switch_mm() is inlined by leave_mm(), and we are
>> not tracing the code path leave_mm => switch_mm. (This is x86_64, and both
>> functions are in arch/x86/mm/tlb.c.)
>>
>> We have folks working on ideas to create offline tools to detect such
>> issues for critical use cases at compile time. However, I think it is
>> necessary to handle it at program load/attach time.
>>
>>
>> Detect "inlined by some callers" functions
>>
>> This appears to be straightforward in pahole. Something like the following
>> should do the work:
>>
>> diff --git i/btf_encoder.c w/btf_encoder.c
>> index fd040086827e..e546a059eb4b 100644
>> --- i/btf_encoder.c
>> +++ w/btf_encoder.c
>> @@ -885,6 +885,15 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
>>         struct llvm_annotation *annot;
>>         const char *name;
>>
>> +       if (function__inlined(fn)) {
>> +               /* This function is inlined by some callers. */
>> +       }
>> +
>>         btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
>>         name = function__name(fn);
>>         btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
>>
>>
>> Mark "inlined by some callers" functions
>>
>> We have a few options to mark these functions.
>>
>> 1. We can set struct btf_type.info.kind_flag for inlined function. Or we
>>    can use a bit from info.vlen.
> 
> It doesn't feel right to use kflag or vlen for this particular
> property. I think decl_tag is the generic way to have extra
> information/annotation.
> 
>>
>> 2. We can simply not generate btf for these functions. This is similar to
>>    --skip_encoding_btf_inconsistent_proto.
> 
> This is too drastic, IMO. Even if some function was inlined somewhere,
> it still might be important to trace non-inlined calls. So just
> removing BTF is a regression in behavior.
>

Agreed; I haven't done the experiment but I suspect a lot of functions
would disappear from vmlinux BTF if we excluded functions on the basis
they were inlined at some point. Running "pfunct -H" (showing functions
that were inlined by the compiler but not declared inline) on a recent
bpf-next I see 22000 different functions, so if even a small percentage
of those were inlined at some sites but not others we'd lose quite a bit
of tracing coverage.

Knowing that we are potentially missing some tracing information is
definitely valuable, so having declaration tags providing
sometimes-inlined info would be great! A custom SEC() that would fail to
attach for sometimes-inlined functions on the basis of declaration tag
info is a great idea too; the original use case could then make use of
that and fail in a meaningful way rather than appearing to succeed.

Alan

>>
>>
>> Handle tracing inlined functions
>>
>> If we go with option 1 above, we have a few options to handle program
>> load/attach to "inlined by some callers" functions:
>>
>> a) We can reject the load/attach;
>> b) We can rejuct the load/attach, unless the user set a new flag;
>> c) We can simply print a warning, and let the load/attach work.
>>
> 
> I'd start with c), probably. Everything else is a regression in
> behavior compared to what we have today.
> 
> 
>>
>> Please share your comments on this. Is this something we want to handle?
>> If so, which of these options makes more sense?
>>
>> Thanks,
>> Song
>>
>>

