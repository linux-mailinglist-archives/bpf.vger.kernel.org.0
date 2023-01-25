Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3F067B94D
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjAYS2q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjAYS2p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:28:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942CE10246
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:28:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFQApO029166;
        Wed, 25 Jan 2023 18:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3PoNHUXiG10+ibLqpVZNxnIOnQJ5JH7yBtryC5Kz5aU=;
 b=XHHpLjGy7mYPJXvYJcQUiRG2dFhi3vvSBPeJjZMDJzh6S+Lp6D2a59JujnykKrqoWm0B
 MxTmfvmttwcCvPrGcDJGs38w0viTXVjwtb5YY9WL/virNEDcH8bRBWG3XEZAk9tk/jaX
 J50M3UjhFObRmp+MM4dY5/p0f49OUySjL+8sUGnokrgjQgvm8f3RsixCPazl6Vx0MVVV
 XqC1F+szM7tS8eTf4g9RVIGNVR09Cm2mcQNIBJw76+6RbLZxp94adawKb4KEj+cIxahY
 ZDcZ5DU/KIycEbEzO+HpRO3B9F9mYRZNrkyAZD0+PXpQtp7EPtM6ad+3NwNgWqttIIEm wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ku0mqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 18:28:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PHTeiP009064;
        Wed, 25 Jan 2023 18:28:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g79c4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 18:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLAz2l4KoZvuUHs8RBfzQRmKbuP1k0qQaOpw2LGjJtcOoz3bQ7LUFvmEhrBj+xj7ym4oi54lwuVLnBxXQAxkBWO+3u07zfcG4RCBoZexlsSu0DltyP6LppGc8F7y8jxyp1cArcdOEBAchL00vMug8qxYzzcMGIjnR9qNScXiihndrIRR9N0POGuZeaDZ9q3x/Wg4BDrNMkTCdmF7tM4LIIhyEcRbodrULTdykif1ScgWiOgTB812I3s+TnF1DMQiCHbyTIxVPEz0VEvMXL8uDuKAQqU37zpMhmD7pR4ynUtePwcJTxABalZL9coxV7m+YJ1nMUIi0ZkGK9O/+a67Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PoNHUXiG10+ibLqpVZNxnIOnQJ5JH7yBtryC5Kz5aU=;
 b=Bs4FBL6cTqNNdOK99pH5L5837zIuDLmut+PG0MRewUv7DWYqHqHTTTX+nv3VYN1WUeS8HWoZkFHTT7kobSQQ5wRTjkF9pLavYW4YZ3vkgXr5IhvpkmxAk+s9LqkcPElSexaCls7kQW/mu32lJGl4hQ/dbL4U4v30rWuuGa9yt2DncQ4s4f9dAVdnLQQ7NtbERAYt1PbtuGcwyIREloLYhxyN0RrTngrKy6E9H4GS0tu2fCj3AxYQLcnyoMmNEyNvK3XKWcRJAxNaRA9UAiX7i93UzDSO8XGijPgxSEtqJV3iM6VgUmBWNTbOawwu9ul2k/gxkX+2+E17NKCB7GrGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PoNHUXiG10+ibLqpVZNxnIOnQJ5JH7yBtryC5Kz5aU=;
 b=hqVSBnRZdJ3a/cLh3z2VCXqwmZ1D7SaoOeTcmyXRvzXPqXE7hhTbugLeXD+rgXfiz61/2seRQOq8fPCHnShWpgRHnWm2VkcATVZFQMM9qoG1OMKOuY2TiKiJPJxYokRtbhPKSAiLt2iWzav/tnQk4mRJTuO4PKSQ1xtbc1uBMVU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7231.namprd10.prod.outlook.com (2603:10b6:208:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 18:28:16 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%5]) with mapi id 15.20.6043.020; Wed, 25 Jan 2023
 18:28:16 +0000
Subject: Re: [PATCH dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
To:     Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org, yhs@fb.com,
        ast@kernel.org, olsajiri@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
 <eb706138246821aafe0f3e88a98933348ba343ac.camel@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <3ca14d5e-5466-fb4e-b024-01ba33370372@oracle.com>
Date:   Wed, 25 Jan 2023 18:28:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <eb706138246821aafe0f3e88a98933348ba343ac.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0189.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 642ba335-19bb-489b-9604-08daff01ece5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Al77b0MA35lJRLZghh5wSX0OIsKTleOzeN/laGsMietijifRIwaKG4DyHIr48Qr8Tsbmn3ofy+h1Z0Emu8q8lMYc1QgdSfD0PaskJx4iZJuyQSVH9Nn1YFVHZuHqVUAf1XtR6gCImQ7wSmFh3g6oHm78PjtnwvxyBG+ki6mWHT8Wmw5FFZ+nXiPkQr9v/Yqc5xcUJUMIighj4iBcTBA9KrSqUNf6374mtT3X12b75BoZhf8A/2/PNBOfHZ/XvrJ2s9Z1Y5TQJ86JlYkbtkhYnMe7LhO3cZHPEsLJNVDx5bV2ASMstur1Mf3AAzLQRUOhFVJSuRFPrqDVGV2t2pwiivXh4qmDHbmttr83y6JRtwruK5O+w/VvLMFUHysncllN3FtLLnLvk1hoYvD/IQQ3SbydDa0vuEtbCPBY8exhwCQNa0v+DnbSkzK5V4XZ5v3AUYWZhrwDGF9kuLU6eckAUXBvfKHSLbEw9D1KYXiECzsGoSZoBn6D7gAAjNmDMGoAwZS7COORwsZEajqTPpnNDYpOrbMO3OB2ybLv+wrxww5NWvX0LHfUD4r18lUarFNOSLZNyO77Obc2cfbhDmi7mlCPOGsn5sepmyPH+iUZlES3bjJeqWiRzP7af5BhHpZjzEp3JpC++zl8qpBTEoe7sEoH1l8LlK7D0gDZhWeVKboNwwz9ptTdt7IbwuZRAlZSIL4NNreR4IkaU5d9Zz36PStokm1UDez7pXsS8I6sK70=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(316002)(38100700002)(41300700001)(2906002)(8936002)(44832011)(36756003)(30864003)(7416002)(5660300002)(8676002)(83380400001)(4326008)(66556008)(66476007)(66946007)(6666004)(31696002)(2616005)(6486002)(478600001)(6506007)(53546011)(31686004)(186003)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlyVnpONlVLNVJpaDZrWkdZY3B1eGZmU1FrMWtUZE5reDhpQysza0tMM2xk?=
 =?utf-8?B?aUN2bDU4cTZYU0hxM2ZLL3kybHNwNlovR1RmbFQ3cVhPNVhRa3o0dkZEL2Nr?=
 =?utf-8?B?STRWV3FSTFRrTkVlNTMyWVRjclREZDlSU0dKVUpkQW5LZmNNUlA5YmJYUEZO?=
 =?utf-8?B?OWI1bW50WUJaamtmTktpZktuL0Exc1BvbzZobG5BNGpZUjVqczVpQ0FYWTRT?=
 =?utf-8?B?MmhZSmVkWjBiYU56dTU4dTF4Yko1d0tpblFUeEpmUW9pL0o0RWtwTzNTc1Va?=
 =?utf-8?B?UmZPazZzbWJzMHBHOVpkV3h0dVltWUZoeTl2SjhMQ3hEN291ZkJMZ2lITk9l?=
 =?utf-8?B?dHEyTmUwSmEydEdFU2IvSnNjQUQvcXRZNXJzK3R4MWlDVUxLK3l4cklZa3BM?=
 =?utf-8?B?NDNUdVhLUFhFenNsRmdaVEZlZkplUzYzTE5FUVlJY3lMRmE1V3lZSHpocXlZ?=
 =?utf-8?B?MC9zeUVGd1NpTy83aEVaQU1GZzJDcFZOblhiUVFtMmZzTVpxc0t0ZzJJOHdZ?=
 =?utf-8?B?cXhMSEhJUnc1dHVmNDdaNEpSbHBPcXhDcERaOGFkWHRiSmVxMmFzbXhvU1Aw?=
 =?utf-8?B?alJUK3lHOGRBWjF0UVdUVWo4Qy9xUUNMZ3lWWmJMK1BqWnpBUnJ1RmNpdE1F?=
 =?utf-8?B?d2Z3ZXJBVEQ0QUtvOVJ4SytCMjd4VnZkbkNiUmRmNzEwcXk0bVVLOW0ybHJo?=
 =?utf-8?B?Wm9vdm1WVnNpRVQwRjdjRGk1NzVOaEFKYUMwQUNxMXp0c21RdHVRazZDMW5o?=
 =?utf-8?B?bVV4Sk1LWTZQSTUvS2NCZjkrVGU3WlovRCt4ZkQ5OUd5SVBqODdGY1lJc25W?=
 =?utf-8?B?aFUxaFlpWjhrZks1eUQzU0NGL1hsOElJNTRKRVZPWjFwdTdyVUtGczVnYk1h?=
 =?utf-8?B?MFFsWi83ZXpaeVVld2xxZmYwSGtwQnBwSTVVWW9xaXcvRWgrR3oxelBVMERZ?=
 =?utf-8?B?WForQU41K0hVQkZtVjhCY1pHdzdob1JMdWs1Q1hRb3gwVm9vcDBYQ0JiM3lX?=
 =?utf-8?B?RVZVanhGNGs1WWVuZ2dMZG9CVnozVWNmTWhVTFgvVHZRWkhtUTJmQjZGYU5p?=
 =?utf-8?B?bWYrc0JndVoyZEJnMXI3WThUMy9nWmVRM2JVTG4yTHJsSGRlQXdVR0pJVERI?=
 =?utf-8?B?TVlwRVZYVGtwNXBWbVI4U0pkb3FUemhybUtkYi9RWDd6YjdYd2xRMk9BVThz?=
 =?utf-8?B?SHpDcTZJNXBXalprdHhqNkFta1BFL3ZyT1lkSXI1cjN6Zi9Jby9oYmpxek9Q?=
 =?utf-8?B?TGdQalRMaGNyNFN3K1Z2RjVxeWNPN1RRZVcrbUszUHRTc2hqbDhDSW5KSjQ3?=
 =?utf-8?B?UjBMalo1QWFHNjREcGZacXZtWi96SmJNSW1PTG8yS3g2bFYxUDl5R0FtNWNn?=
 =?utf-8?B?c1drZkR5L0FuR1lZUkRrcThnK0lxYi8yNlRKeTB6MTdxV3FVb2k5d084L3NM?=
 =?utf-8?B?L2lieXdieVYrZFBlRUsybkpCMWErdFRkeU9UajBlODJ0UThnREF3Z1dFUlVx?=
 =?utf-8?B?MUxuazhrWTdKSEhucFliYVhtTFZQM05tUHg5MFYwRlpEcFkxTTVab3pZRHBo?=
 =?utf-8?B?NU82U0ZCdFlLK3p5NFZ2RGRiRW5GWkdQNUViU3hZVmwxSVhvV3dubVhzMG1I?=
 =?utf-8?B?UHNLZ1Z1TDJCK1A2NldNYXMvRXBUWkxkd21Bc2hQWEFNejRlRGhCTmRVY0ZC?=
 =?utf-8?B?TWhiaTBYUDJ2aTI4VTlKaFFGZkwvMnQybDkxaTRNL29jSnJQQjdDZmtlQ3dH?=
 =?utf-8?B?ZlZNN0RveWJYUTFxVXpJMEkzTDlwRElSSjJSNEZPKy81dE42T1R5QUdIcEdB?=
 =?utf-8?B?UGF2SFJJajd5RGNlRDlYVFg5bTg3eHh5bUUrZXlidlYyQzZJN1crU0JDT2dn?=
 =?utf-8?B?WWxWdlRGRklCSVZIeEVOUU1SMUVCRDlOM08zaUp3aEVzd2FiUkVUOHhvbUJH?=
 =?utf-8?B?WmVnV1NLbk80UzVRekxqdlhTNzU5Ly82TjR3aWNZSzdFbTA5ekwvazRJV2pG?=
 =?utf-8?B?dHVERTJ0UmhrSmU5eGtTRCtYRzMxdnFxNjZUMHR2aG8yVzRkdnFsUENIRjJu?=
 =?utf-8?B?Nkc5b3VwWDFqQlBOcGowRGt5QzBIWjNodXpFU2xOMUhnbllxTFk2aVhSWGh4?=
 =?utf-8?B?aUc0aUd4ZzVUNkZRVUtUekFadisxc1NIRnF0OERzVzc3dnhTeC9nWG9SUTVR?=
 =?utf-8?Q?++mZFMJHEkJbCsokc4y/Z4Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N3VGdzU0VU04SnU5OFluY2FSRTBBRGo0cENWQTlJNlVUOFcveDJtY2NrY1hw?=
 =?utf-8?B?NjUzdFhPK3NHWGt6Uk9nNTJ5QkNhalo0ODJSYzAxQ0QzeDNablZBWW1RZzdG?=
 =?utf-8?B?WUNkYnVKVmw1OXVnd2VmVVREc0RDVU9HZk1qeFFZOUdVQmpKdW5laGdpLy84?=
 =?utf-8?B?cFcvQ0JBTnAyQWtSNDhPem1Pcm45Yy83T0FLbGgxcUVWcHhVSzNkQ2dEMEcx?=
 =?utf-8?B?MHhMN1RRRnBMYWZkclJ3VFo2cE1GclBwYnRydW1HbEowVkJsQ05Pc0dlNTZJ?=
 =?utf-8?B?L0o3WlRyUkk2a0ZMaVM3ajlXNU1DZzVFY0JtSnFqUjdXdWF3dEpicUZnaTMv?=
 =?utf-8?B?UXlkbys0N05QWTR0LzROTlYvL1VHRUJtNDJWaHpXWklNZllteDRXZWovd1M1?=
 =?utf-8?B?a0dxZkI5ejFoYUI4RFFzVkVmeGM0Vmg4MTB6WkFlc3M3K1ZlQ3RqdnFtT1Bl?=
 =?utf-8?B?WS9JMWU3alUrWXBMV09QVndxWUlCS2lRaVlGblZweHdyaEdHWjRDeEovMkZF?=
 =?utf-8?B?STlNRExrSitaRWZUQWxBMWtIWGw4UkhORC9URHcxdXlaT05lZDl1MWl3ZlR5?=
 =?utf-8?B?Zm1aSkN0cHU0b1FhUGovcVc5V2E0Y01PNjkzVEgzanpwc2tXT2lMZlF5c2lZ?=
 =?utf-8?B?bHZEK01OZ05VNjVnUlBQQWJ2MDZtR3NhM3owRjVGZGR0N0UxRUVUK0U5Zzl0?=
 =?utf-8?B?WUFrWmREUEdxZ0VHK3loZkRsTkg3U2ZyTkpaM0srcFc1VHpkRVdEUFQ5Kzdx?=
 =?utf-8?B?dHZ6Um9ZN1UwZFBLV2w3ellwSzNJdG00Q09TVFNyc1JmR2UzTEc0WjF5RWJK?=
 =?utf-8?B?YlgwM3ZYalNXbUIxNDhPcTd4L2wySkdqRG14dkVzTVYyNnJOeDd6YW5CallX?=
 =?utf-8?B?aE8zb21XcXgwdVJjRUU2czVYcTFzMDBKMjBKbXhPdkVQckNYY2RvclBMYWdD?=
 =?utf-8?B?QXpZdHcwYUhkZGxyNEZPMkRpejJvbDhTcEM3Tk9veHNxVDR3c0RJZUNSNHp5?=
 =?utf-8?B?eEFyZkoray9iMFN0VWNRcWFtL3lpOUpxQXRORzVvNU5mV0lweHJuMmlJTk5S?=
 =?utf-8?B?WEhpaXh5TndqQktTcUV5MUZFYWsvUUpKS1R5b0NqYUdPTGR1RnppbDdEQ2Jv?=
 =?utf-8?B?MlNwVUc5WkFRMXlETno3MTNIMUtONW5aSndmaC9MNTRUTVNxY2pnZVdLOHhJ?=
 =?utf-8?B?cjYyWThRZ3FZRFo1TVp6dU5CNUF6VXBGblFMNnMyelJkcWttaHI2dHRRT2Zy?=
 =?utf-8?B?bTI5cm5jSUJRUzZibGx0Mkp0d0s4QTBYTmZETXQ0WE9Eb1R2UT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642ba335-19bb-489b-9604-08daff01ece5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:28:16.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDJD/M9fBlWEIA5UWLx8HbUFH2RbjBdruVxy2CBckfD8vbpGnM69f9xgAnzLsz0PgJOm2hajPK38GSjrZwiJPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250165
X-Proofpoint-GUID: 72KZNY4XpKj2_7Lg7dg0I3BDOI2VoZ1S
X-Proofpoint-ORIG-GUID: 72KZNY4XpKj2_7Lg7dg0I3BDOI2VoZ1S
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/01/2023 17:47, Eduard Zingerman wrote:
> On Tue, 2023-01-24 at 13:45 +0000, Alan Maguire wrote:
>> Compilation generates DWARF at several stages, and often the
>> later DWARF representations more accurately represent optimizations
>> that have occurred during compilation.
>>
>> In particular, parameter representations can be spotted by their
>> abstract origin references to the original parameter, but they
>> often have more accurate location information.  In most cases,
>> the parameter locations will match calling conventions, and be
>> registers for the first 6 parameters on x86_64, first 8 on ARM64
>> etc.  If the parameter is not a register when it should be however,
>> it is likely passed via the stack or the compiler has used a
>> constant representation instead.
>>
>> This change adds a field to parameters and their associated
>> ftype to note if a parameter has been optimized out.  Having
>> this information allows us to skip such functions, as their
>> presence in CUs makes BTF encoding impossible.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  dwarves.h      |  4 +++-
>>  2 files changed, 77 insertions(+), 3 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 5a74035..0220f1d 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -992,13 +992,67 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
>>  	return member;
>>  }
>>  
>> -static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>> +/* How many function parameters are passed via registers?  Used below in
>> + * determining if an argument has been optimized out or if it is simply
>> + * an argument > NR_REGISTER_PARAMS.  Setting NR_REGISTER_PARAMS to 0
>> + * allows unsupported architectures to skip tagging optimized-out
>> + * values.
>> + */
>> +#if defined(__x86_64__)
>> +#define NR_REGISTER_PARAMS      6
>> +#elif defined(__s390__)
>> +#define NR_REGISTER_PARAMS	5
>> +#elif defined(__aarch64__)
>> +#define NR_REGISTER_PARAMS      8
>> +#elif defined(__mips__)
>> +#define NR_REGISTER_PARAMS	8
>> +#elif defined(__powerpc__)
>> +#define NR_REGISTER_PARAMS	8
>> +#elif defined(__sparc__)
>> +#define NR_REGISTER_PARAMS	6
>> +#elif defined(__riscv) && __riscv_xlen == 64
>> +#define NR_REGISTER_PARAMS	8
>> +#elif defined(__arc__)
>> +#define NR_REGISTER_PARAMS	8
>> +#else
>> +#define NR_REGISTER_PARAMS      0
>> +#endif
>> +
>> +static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>> +					struct conf_load *conf, int param_idx)
>>  {
>>  	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>>  
>>  	if (parm != NULL) {
>> +		struct location loc;
>> +
>>  		tag__init(&parm->tag, cu, die);
>>  		parm->name = attr_string(die, DW_AT_name, conf);
>> +
>> +		/* Parameters which use DW_AT_abstract_origin to point at
>> +		 * the original parameter definition (with no name in the DIE)
>> +		 * are the result of later DWARF generation during compilation
>> +		 * so often better take into account if arguments were
>> +		 * optimized out.
>> +		 *
>> +		 * By checking that locations for parameters that are expected
>> +		 * to be passed as registers are actually passed as registers,
>> +		 * we can spot optimized-out parameters.
>> +		 */
>> +		if (param_idx < NR_REGISTER_PARAMS && !parm->name &&
>> +		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
>> +		    loc.exprlen != 0) {
>> +			Dwarf_Op *expr = loc.expr;
>> +
>> +			switch (expr->atom) {
>> +			case DW_OP_reg1 ... DW_OP_reg31:
>> +			case DW_OP_breg0 ... DW_OP_breg31:
>> +				break;
>> +			default:
>> +				parm->optimized = true;
>> +				break;
>> +			}
>> +		}
> 
> Hi Alan,
> 
> I looked through the DWARF standard and found two relevant entries:
> 
>> 4.1.4
>>
>> If no location attribute is present in a variable entry representing
>> the definition of a variable (...), or if the location attribute is
>> present but has an empty location description (...), the variable is
>> assumed to exist in the source code but not in the executable program
>> (but see number 10, below).
> 
> This paragraph implies that parameter name presence or absence is
> irrelevant, but I don't have any examples when parameter name is
> present for a removed parameter.
> 
>> 4.1.10
>>
>> A DW_AT_const_value attribute for an entry describing a variable or formal
>> parameter whose value is constant and not represented by an object in the
>> address space of the program, or an entry describing a named constant. (Note
>> that such an entry does not have a location attribute.)
> 
> For this paragraph I have an example:
> 
>     $ cat test.c
>     __attribute__((noinline))
>     static int f(int x, int y) {
>         return x + y;
>     }
>     
>     int main(int argc, char *argv[]) {
>         return f(1, 2) + f(1, 3);
>     }
>     
>     $ gcc --version | head -n1
>     gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
>     $ gcc -O2 -g -c test.c -o test.o
>     
> The objdump shows that constant propagation removed the first
> parameter of the function `f`:
> 
>     $ llvm-objdump -d test.o 
>     
>     test.o:	file format elf64-x86-64
>     
>     Disassembly of section .text:
>     
>     0000000000000000 <f.constprop.0>:
>            0: 8d 47 01                     	leal	0x1(%rdi), %eax
>            3: c3                           	retq
>     
>     Disassembly of section .text.startup:
>     
>     0000000000000000 <main>:
>            0: f3 0f 1e fa                  	endbr64
>            4: bf 02 00 00 00               	movl	$0x2, %edi
>            9: e8 00 00 00 00               	callq	0xe <main+0xe>
>            e: bf 03 00 00 00               	movl	$0x3, %edi
>           13: 89 c2                        	movl	%eax, %edx
>           15: e8 00 00 00 00               	callq	0x1a <main+0x1a>
>           1a: 01 d0                        	addl	%edx, %eax
>           1c: c3                           	retq
>     
> However, the information about this parameter is still present in the DWARF:
> 
>     $ llvm-dwarfdump test.o
>     ...
>     0x000000c1:   DW_TAG_subprogram
>                     DW_AT_name	("f")
>                     DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>                     DW_AT_decl_line	(2)
>                     DW_AT_decl_column	(0x0c)
>                     DW_AT_prototyped	(true)
>                     DW_AT_type	(0x000000a9 "int")
>                     DW_AT_inline	(DW_INL_inlined)
>                     DW_AT_sibling	(0x000000e1)
>     
>     0x000000d0:     DW_TAG_formal_parameter
>                       DW_AT_name	("x")
>                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>                       DW_AT_decl_line	(2)
>                       DW_AT_decl_column	(0x12)
>                       DW_AT_type	(0x000000a9 "int")
>     
>     0x000000d8:     DW_TAG_formal_parameter
>                       DW_AT_name	("y")
>                       DW_AT_decl_file	("/home/eddy/work/tmp/test.c")
>                       DW_AT_decl_line	(2)
>                       DW_AT_decl_column	(0x19)
>                       DW_AT_type	(0x000000a9 "int")
>     
>     0x000000e0:     NULL
>     
>     0x000000e1:   DW_TAG_subprogram
>                     DW_AT_abstract_origin	(0x000000c1 "f")
>                     DW_AT_low_pc	(0x0000000000000000)
>                     DW_AT_high_pc	(0x0000000000000004)
>                     DW_AT_frame_base	(DW_OP_call_frame_cfa)
>                     DW_AT_call_all_calls	(true)
>     
>     0x000000f8:     DW_TAG_formal_parameter
>                       DW_AT_abstract_origin	(0x000000d8 "y")
>                       DW_AT_location	(DW_OP_reg5 RDI)
>     
>     0x000000ff:     DW_TAG_formal_parameter
>                       DW_AT_abstract_origin	(0x000000d0 "x")
>                       DW_AT_const_value	(0x01)
>     
>     0x00000105:     NULL
>     
> When I ask pahole with this patch-set applied to generate BTF I see
> the following output:
> 
>     $ pahole --verbose --btf_encode_detached=test.btf test.o
>     btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
>     Found 0 per-CPU variables!
>     Found 2 functions!
>     File test.o:
>     [1] INT int size=4 nr_bits=32 encoding=SIGNED
>     [2] PTR (anon) type_id=3
>     [3] PTR (anon) type_id=4
>     [4] INT char size=1 nr_bits=8 encoding=SIGNED
>     [5] FUNC_PROTO (anon) return=1 args=(1 argc, 2 argv)
>     [6] FUNC main type_id=5
>     matched function 'f' with 'f.constprop.0'
>     added local function 'f'
>     matched function 'f' with 'f.constprop.0'
>     [7] FUNC_PROTO (anon) return=1 args=(1 x, 1 y)
>     [8] FUNC f type_id=7
>     
> Meaning that function `f` had not been skipped.
> A trivial modification overcomes this:
> 
> 		if (param_idx < NR_REGISTER_PARAMS && !parm->name) {
> 			if (attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
> 			    loc.exprlen != 0) {
> 				Dwarf_Op *expr = loc.expr;
> 
> 				switch (expr->atom) {
> 				case DW_OP_reg1 ... DW_OP_reg31:
> 				case DW_OP_breg0 ... DW_OP_breg31:
> 					break;
> 				default:
> 					parm->optimized = true;
> 					break;
> 				}
> 			} else if (dwarf_attr(die, DW_AT_const_value, &attr) != NULL) {
> 					parm->optimized = true;
> 			}
> 
> With it pahole seem to work as intended (if I understand the intention correctly):
> 
>     $ pahole --verbose --btf_encode_detached=test.btf test.o
>     btf_encoder__new: 'test.o' doesn't have '.data..percpu' section
>     Found 0 per-CPU variables!
>     Found 2 functions!
>     File test.o:
>     [1] INT int size=4 nr_bits=32 encoding=SIGNED
>     [2] PTR (anon) type_id=3
>     [3] PTR (anon) type_id=4
>     [4] INT char size=1 nr_bits=8 encoding=SIGNED
>     [5] FUNC_PROTO (anon) return=1 args=(1 argc, 2 argv)
>     [6] FUNC main type_id=5
>     matched function 'f' with 'f.constprop.0', has optimized-out parameters
>     added local function 'f', optimized-out params
>     matched function 'f' with 'f.constprop.0', has optimized-out parameters
>     skipping addition of 'f' due to optimized-out parameters
> 
> wdyt?
> 

This is great, thanks Eduard! I can add an additional patch
for the else clause code above, attributing that to you in v2 if
you like?

Alan

> Thanks,
> Eduard
> 
>>  
>>  	return parm;
>> @@ -1450,7 +1504,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
>>  					     struct cu *cu, struct conf_load *conf,
>>  					     int param_idx)
>>  {
>> -	struct parameter *parm = parameter__new(die, cu, conf);
>> +	struct parameter *parm = parameter__new(die, cu, conf, param_idx);
>>  
>>  	if (parm == NULL)
>>  		return NULL;
>> @@ -2209,6 +2263,10 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>>  			}
>>  			pos->name = tag__parameter(dtype->tag)->name;
>>  			pos->tag.type = dtype->tag->type;
>> +			if (pos->optimized) {
>> +				tag__parameter(dtype->tag)->optimized = pos->optimized;
>> +				type->optimized_parms = 1;
>> +			}
>>  			continue;
>>  		}
>>  
>> @@ -2219,6 +2277,20 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>>  		}
>>  		pos->tag.type = dtype->small_id;
>>  	}
>> +	/* if parameters were optimized out, set flag for the ftype this
>> +	 * function tag referred to via abstract origin.
>> +	 */
>> +	if (type->optimized_parms) {
>> +		struct dwarf_tag *dtype = type->tag.priv;
>> +		struct dwarf_tag *dftype;
>> +
>> +		dftype = dwarf_cu__find_tag_by_ref(dcu, &dtype->abstract_origin);
>> +		if (dftype && dftype->tag) {
>> +			struct ftype *ftype = tag__ftype(dftype->tag);
>> +
>> +			ftype->optimized_parms = 1;
>> +		}
>> +	}
>>  }
>>  
>>  static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
>> diff --git a/dwarves.h b/dwarves.h
>> index 589588e..1ad1b3b 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -808,6 +808,7 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
>>  struct parameter {
>>  	struct tag tag;
>>  	const char *name;
>> +	bool optimized;
>>  };
>>  
>>  static inline struct parameter *tag__parameter(const struct tag *tag)
>> @@ -827,7 +828,8 @@ struct ftype {
>>  	struct tag	 tag;
>>  	struct list_head parms;
>>  	uint16_t	 nr_parms;
>> -	uint8_t		 unspec_parms; /* just one bit is needed */
>> +	uint8_t		 unspec_parms:1; /* just one bit is needed */
>> +	uint8_t		 optimized_parms:1;
>>  };
>>  
>>  static inline struct ftype *tag__ftype(const struct tag *tag)
> 
