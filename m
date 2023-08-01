Return-Path: <bpf+bounces-6599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7999C76BBD4
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3FC2819CC
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12772235A4;
	Tue,  1 Aug 2023 17:58:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBDA22EF0
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 17:58:22 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11C103
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 10:58:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371BApOX005260;
	Tue, 1 Aug 2023 17:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PbO4xLDGlQ0ta6gqRGX9xvDsSwq3OKrsxDceXfgfVaM=;
 b=gZTi8iGUcyq3AXCe9wrpMc+f4HbltqZ7pQ+9Fhy+Y7/jNt5FVNw2d6bWJ10BPnvs8Tr6
 WQ9KrzPECo79UckyTXQlOlmLuRDXwp7WY0VvK+FDsGg53O5snMBRfV35hXJ2ajvTU3zR
 z4CHQRem5lgcC6oKpZhPJZh6dLZvKte3tpC3vekDA/IRWkTTSM0gsDUMOxkEl0PcnB3l
 SE311A/EuPw90Bw1r3soMMWYczunrYSIaRtrDxATCoCXAOlvfaX6hALoVYcFOQCDhudp
 o8Bgavhl1HbEU0aM0bge1NMITJRkQu6h/khB5yrmoR2NyHUyyKm88PjucTHg8bkYcNxv aQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tctwh80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Aug 2023 17:57:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 371GXW1g037336;
	Tue, 1 Aug 2023 17:57:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7dabas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Aug 2023 17:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft8eGCf9KQrMraBDrAhH+HgmSYVFiqaQw4DS8Ydv60i4YS3AxwJrdwmK1RxlhkpHpp3YL4oDqoUfezQEfEVErZrqwbPDb4gPhLvgb56v3L2D4sx1i5dM+NESeB362M1oZ2tXtaBDyU9NKGFK2IT4qe7M9cbdxn3jZdkw5jfWpSoBG8FoUqOiHwfPz9O0mMhZ4n4k/ngnVL5PliZuP4N5Y2jm2LEkpT7oTweXY9GOsKWNA5T74+tPqtubj9L1tuCy/EG/Z2ydh6+sx/SpgsEzZ8HIVBZNW28v9+vS5ljqUoW4FTB87ETBw4XIgDVw0WEdZOZfYpwKgMcr6aNSEqyjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbO4xLDGlQ0ta6gqRGX9xvDsSwq3OKrsxDceXfgfVaM=;
 b=AehaHVhb7cODvG0xac+nThMvGILni4DsjZIHhb5Y69z/HR3ClBgoSyibiSK4wEki4RyvCzdEoaFzlHaPWHXNLD7nA5HNdbP2xJoI9uxhMSRry07fyL21tCspC0mRfoxPEVYdfcrtztsbl7cqVuqB/r7bI03CHQOOecFTuFTDGvxTmldg7c4RFYfKWypOIXOnmUhaEAJROdKYDKjvcrHx1NFLe0fU7z8VN8c7NzY9cWqd05sGvjGvp/L0S1wTnFbuYfzXRoY1p4gpvvtFZstfQrEzpDvn/wB6r8tL5X0QCvRT7BNBQb4FhajK7lgKtjOYNogd2Gh8Rp66Sn/r33C07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbO4xLDGlQ0ta6gqRGX9xvDsSwq3OKrsxDceXfgfVaM=;
 b=iuZ3mJaJEO1I/hpDgT0Q2lCnBwjAT+126y+AAuqkSBc1gS8Cr4PvAOrZYRGo48qwdycaiBJiFHIt6FJayWCNuJlQ+4PWD1k7KSPlxr94bEonuolDxDYreb5HvFBoOUB8Eedv4OMmrzqVWlNF0v0+PlWib5NfNxc/njvuOJwUjhU=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 PH7PR10MB6627.namprd10.prod.outlook.com (2603:10b6:510:20a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 17:57:52 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::237d:96e6:7f50:e202]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::237d:96e6:7f50:e202%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:57:52 +0000
Message-ID: <79d0f187-a876-3065-070b-d518ac5854ed@oracle.com>
Date: Tue, 1 Aug 2023 18:57:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf] selftests/bpf: fix static assert compilation issue
 for test_cls_*.c
Content-Language: en-GB
To: yonghong.song@linux.dev, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, Colm Harrington <colm.harrington@oracle.com>
References: <20230801102942.2629385-1-alan.maguire@oracle.com>
 <be06d3c7-fe77-cef0-f3d2-780c6c1e90b3@linux.dev>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <be06d3c7-fe77-cef0-f3d2-780c6c1e90b3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::14) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|PH7PR10MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fed338-20df-4306-5a8f-08db92b8d36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YxM/uttgRozZ1stYEyza0RDs0WrYl09SiIlIpr8pQ74Wil2LwPfReW0c7a0ImVXTJzjuDCBe41J2zsXuye4+1kjoYWBye9i79NWty2+TDArAesdt0PJAPljsmhz7kWYfm26G5NQ65EJx2UfKUmtxGJZx0yscCBM9KSPlSlFWLOZHD3vXy6aG5YtOeQD8R5DhJRxwPuntgGbYnKNNoNV2d/KXB9EoboW8psMrNKXShrJKKAuZE3B8Coge3cT4Lyoe/91zBAyL/o3VA7aWZMXyBT4loXivG7cq1r7J++XZKtM0VkHpAzQgD/6hDnaVJ6xz9ibZTy6mcmPrHEZqWaNLnImHZ2sBh3aXYmH3VjqJZ5zsRvPYXTj6MTaV3bOkEiifVTsnWhpVDerEzaeDY6SoTfuzXKRyAuG5LFA29j401SDglke2seb1sa/MuKPXvEcB2QuGgNRqzpCXL/oKvE6VzJfkzUsJEDYlcheJ36q/IkhZlchPfMhCVOK0TRrcPpnE3U6jE0zQ2I2B5DGHrSb3jQyqJRAgUOgQm8wpqDYBmU/i6Q6f/2//1RjUEq7ha/aqAWtv11a+hickzVaps0NifUY9Tfci30me0IrwQmhvJtNWlY5UD4V/uED87yJh73zKAQXeD2PAg946BV3FG9UWGQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(31686004)(53546011)(6506007)(38100700002)(478600001)(7416002)(5660300002)(8676002)(44832011)(8936002)(4326008)(66476007)(66556008)(66946007)(6512007)(31696002)(86362001)(6666004)(41300700001)(316002)(6486002)(2616005)(186003)(107886003)(2906002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkcrV1RGK2xXNjlDV2ZPYkEvbVlnWFlzbVRiZXB6SEVlZHhqQ3FSTVhOZzR5?=
 =?utf-8?B?dndtUXVLWERJMlZwNU0zZWUyYVEvWENGQSt6RzhtaVluSmI2MDBYUkFURURQ?=
 =?utf-8?B?ZzJ2YnA3NkIwL2VBbXZ3MzN1dU14Y08wN3pFOWI0YURlNm82U0oySGx4QVVM?=
 =?utf-8?B?WnBXalUzbCs1eVh4YnBPMzA2OXlOSzdlVE5STi9IcTlza3lOY09iVGlYZlla?=
 =?utf-8?B?cWQvYjc1OVlYT2o1RnVXMUw4T1RBYWdqMmpVa0Jya2xzdHkzMTl6U2lpS2hT?=
 =?utf-8?B?d0s1SFZlb21LTG5wYk43TnFodHJSNjJJcng0cGdmbGJvZ1lLSmoweHljTmtm?=
 =?utf-8?B?ZEpQc2h4TGZuTUQ4Nldha3ZsUzd3YVNqaVF6dWtPTVBMWkhCRy9XUVdESnhn?=
 =?utf-8?B?UDNzNlhmaFhOMDRPTFpJelJJdWNwQ3lIWVp1WUlOSkFmQUhHd3NFOU5jRkFU?=
 =?utf-8?B?WUlFUDA4eFJvQzlKQUNEVnF5N24yT3BkdzlZYjMyTnJFL1ZpbldSODZIN0d0?=
 =?utf-8?B?NEZtN3pxQmJic2hxVDh2VXQ4Wk80T1llUG82blg3SndyOVJzOHJsNkpNNjVD?=
 =?utf-8?B?SVgraEJUbTNabXhqbWlpNjc0aWVTZkxZL1lydDZtb01zeUhzYlBqbXNPRng2?=
 =?utf-8?B?RXphK2FWZ2hOVFNPcFBKUkViYytHTEI0Z0RBdWpTb0NiTUpPcUZ4L3F6MWV2?=
 =?utf-8?B?QzEwWUwxSXNTQmFraUxzZDNrSkUydnBnMXBzV2VuZUVmMzI2TVdYWnlGZmV4?=
 =?utf-8?B?UTFXSUZBNDl6UnRtTWNPQjgrdzg0am9NUkpkeWNDUFBGR3JENHJaMU1xUWxX?=
 =?utf-8?B?L2RSUXV3ZHk2djdZdkhwaWJtVVRpR1pFOVcwbmpNOEEzcmozd2FoY1hwU2Zl?=
 =?utf-8?B?bVlFNkVUeFVoYW5zZFhTMTFnUVZNUXZxNEVtaHk5U0dLQWl2REQzQjBnbmtk?=
 =?utf-8?B?N0JyWDFGWmJ5R083WGs2TWNYazNRalY1OHJyTkg1MmFXZlVWMXRqQmVSUzRE?=
 =?utf-8?B?Q3pIQzhpL2hIaVpIUUI4TUZldHlZUUFtTFI5QmZ3RlNtdVpNQzdSaHRlS2xn?=
 =?utf-8?B?b3MxMWNHWEZmamJRaHdYeG8wNUlaQS8zNHV3THFPRFNuWW5lYTJPTVoxKzMr?=
 =?utf-8?B?WkUzYUIvWExwU29KUytpL1hUM1pVYUw3M2RrUkNPYmphMDNpRVovSHl2MUk0?=
 =?utf-8?B?UE9qV0Rkc0FUc1U0OGZvZGJxbWxVckEwUVpsN0xJcVFzOVh5d1B0aENIZ2Uz?=
 =?utf-8?B?SUoxbG4ydzhoWFJqTHE4Sm9DQWUwc0RsRmRPNDJCSmpFSzU1OGJNNCtzdGNU?=
 =?utf-8?B?UHRrK3NXVVFIOExGQ3NCRTU2M0J1OExhc1hIQzhlcnVQTmRnd1RtcHY4OHhV?=
 =?utf-8?B?SjJ3Z2xDcXVhTTRIZVdIa3BPYU1IcnRTV09QWHl5YWNhbjhtWC9yaWNiQjFF?=
 =?utf-8?B?MzExZCtZc1ZUcW92RVh6TTZmdG5IWjNPUVpQQzJaMUdnaUYzSWhXRWZMbFg1?=
 =?utf-8?B?ZC81SURRYzBSaUlYRkpQYmZ2ZndrNHpKYVpYTkpvWmRDeGFlNzdVUjZqL052?=
 =?utf-8?B?cmhja2djTVFrS3VMZ0NONkVYejhFeUFBU2EzV3BXUlhRU2YwdHdoSkJCVFBC?=
 =?utf-8?B?Q2RKYSsvRTlsZEZYbC8zSGk5YzlIR01RWEdQVkp6YzZhd3hXN0dPSWQ1b2c2?=
 =?utf-8?B?WXhxTHVEUjdqbjdhamhZSGtkbWxQcWN3U2VXU0wwS3JPWldVeDVqZkhwcHRW?=
 =?utf-8?B?R01FZ3JZdUlqMmV4Mlk3REdwbVZWeUg3N3ZQNEtvTkRUY3l5Ynl0TGtuR3hq?=
 =?utf-8?B?aEpvVmRiRGNOZURJQU5KSUYvQmVWSGhTcUpOcmFzT2lGVGU3VUJrVUFxL090?=
 =?utf-8?B?Y1ZIZXB2S1pqYnJpMzVScC94N3d6VGVMUWhlZmhibUNmWWVrZFRob2FYa3Zk?=
 =?utf-8?B?QmlIVFpUNE1SZm0rUVRWS3RkdmtEZHdWbjFHVEJJcWNOUytBNlpvclJ1UGox?=
 =?utf-8?B?SEN1dm9wSWxiOGpQelN3a05BT0NlbFdiSTd6QUJKV1kvVjByWG1DeXJlaGo1?=
 =?utf-8?B?VkxBZWkvMHdGaUIwMkUzbCtDMWNncHZQTzV2UlB6OFNNN0RpLzArRFVhaDJR?=
 =?utf-8?B?RGgvR0RjMWtneG8rM1RrNlVFMEczQ3BJc3llVlRuMXZVS25yR2xkTzZJUVNL?=
 =?utf-8?Q?32VUXVwz/lzDQ9LcGAAH2p4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qm+NOJBV9LZ3OhxUxuU0qycqYm5L8d3hRGN3LJHNPznH+XzmJcw/SWFOuSLHFiXmtWTgwsdyeWoShSIgHjcWC7k3nYJ+wiYRTPzaFpYkKvDhjbxVFhO+O0fjqf5NNyYUgley+C2zGRJuvU3oqaBEXfJfdhLtYCAw8gkrKkPWOCkD/rZUuIyt5qfqR4XEJAyutvugAh7I5hNFg5Q5SQhvVxpOXtlZYop+j+6cq5Gicg2a64yDZP5CEQWWVJhdiPy+ujL7fdUGUhNdlmJjSNdiVp3iE+54QXnvG2QKmXdw806J9dfokQWlGzMtzZtTRrxB/IU5lCkVZwGKjz2Wk65+/aahmlpSyjE+2UAoCv4yp4D7u2CGdO2ZhS9+2Pr5oGRVgCKUBLq7HngaVoD8nO7yd7JIdh1/F3Rolm9CrzPtd/oS0ZKOw+WTbUcO0FihUZH+vjzipq8RvCsSua+YZSlDF6QKNTXyvyNJfXF587krEb+Rv2em+v6ALNZBVBH+hcxDLvRrblC/y/h9loFoHNsodxo08TicF3AWCoCKEr5GgClk7hw74H5msw9G6bGQrQWfirj3B3eHVlw2Rr4cHqPfUGHagfXUpGGcC9ENe0h0U5E2pTgRkGqrWH6mOqigScx3sVqkEWDJ2EhvBLueFqpmXPypvCKnErRSX8vQHg7fQjfPIMO4VHjC6m58wCAfTVEORYug82nlqxSMvlfPTh3XlXawK+rOGn7ADE7ziMIlkC+3BFj8ISjQPDcvu6+CWPsz8IPjr2lSs/wgN5+JbPQfgxLp27vEG7qVri4M8qDaYO0+jFzo+/qrYlB71IDkosQHQ2p2RaCtdWXEDGbehPd8KtOID6HGTVLAMb67hUOEnm8wJHLPGq9mqo5DDpxFaxS9OYkqXe27SibWCdhOB4UY6MsA7YwgjuE6S0Cb+ME6HN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fed338-20df-4306-5a8f-08db92b8d36b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:57:52.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wmrn9PJGDmd+nmIhcjaELAFblTFY+NZ52/Hs73fAUB0PR617H19mC3/GukV6tPacgrGDLhrx/Kwa+mEJvHd1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_15,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010162
X-Proofpoint-GUID: mjlXSId-qp670eJETmgHkx2zszOkLpXQ
X-Proofpoint-ORIG-GUID: mjlXSId-qp670eJETmgHkx2zszOkLpXQ
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/08/2023 18:09, Yonghong Song wrote:
> 
> 
> On 8/1/23 3:29 AM, Alan Maguire wrote:
>> commit bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to
>> work with CO-RE")
>>
>> ...was backported to stable trees such as 5.15. The problem is that
>> with older
>> LLVM/clang (14/15) - which is often used for older kernels - we see
>> compilation
>> failures in BPF selftests now:
>>
>> In file included from progs/test_cls_redirect_subprogs.c:2:
>> progs/test_cls_redirect.c:90:2: error: static assertion expression is
>> not an integral constant expression
>>          sizeof(flow_ports_t) !=
>>          ^~~~~~~~~~~~~~~~~~~~~~~
>> progs/test_cls_redirect.c:91:3: note: cast that performs the
>> conversions of a reinterpret_cast is not allowed in a constant expression
>>                  offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>>                  ^
>> progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
>>          (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>>           ^
>> tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33:
>> note: expanded from macro 'offsetof'
>>                                   ^
>> In file included from progs/test_cls_redirect_subprogs.c:2:
>> progs/test_cls_redirect.c:95:2: error: static assertion expression is
>> not an integral constant expression
>>          sizeof(flow_ports_t) !=
>>          ^~~~~~~~~~~~~~~~~~~~~~~
>> progs/test_cls_redirect.c:96:3: note: cast that performs the
>> conversions of a reinterpret_cast is not allowed in a constant expression
>>                  offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>>                  ^
>> progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
>>          (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>>           ^
>> tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33:
>> note: expanded from macro 'offsetof'
>>                                   ^
>> 2 errors generated.
>> make: *** [Makefile:594:
>> tools/testing/selftests/bpf/test_cls_redirect_subprogs.bpf.o] Error 1
>>
>> The problem is the new offsetof() does not play nice with static asserts.
>> Given that the context is a static assert (and CO-RE relocation is not
>> needed at compile time), offsetof() usage can be replaced by
>> __builtin_offsetof(), and all is well.  Define __builtin_offsetofend()
>> to be used in static asserts also, since offsetofend() is also defined in
>> bpf_util.h and is used in userspace progs, so redefining offsetofend()
>> in test_cls_redirect.h won't work.
>>
>> Fixes: bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to
>> work with CO-RE")
>> Reported-by: Colm Harrington <colm.harrington@oracle.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>   tools/testing/selftests/bpf/progs/test_cls_redirect.c | 11 ++++-------
>>   tools/testing/selftests/bpf/progs/test_cls_redirect.h |  3 +++
>>   .../selftests/bpf/progs/test_cls_redirect_dynptr.c    | 11 ++++-------
>>   3 files changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> index 66b304982245..e68e0544827c 100644
>> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
>> @@ -28,9 +28,6 @@
>>   #define INLINING __always_inline
>>   #endif
>>   -#define offsetofend(TYPE, MEMBER) \
>> -    (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>> -
>>   #define IP_OFFSET_MASK (0x1FFF)
>>   #define IP_MF (0x2000)
>>   @@ -88,13 +85,13 @@ typedef struct {
>>     _Static_assert(
>>       sizeof(flow_ports_t) !=
>> -        offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>> -            offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
>> +        __builtin_offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>> +        __builtin_offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
>>       "flow_ports_t must match sport and dport in struct
>> bpf_sock_tuple");
>>   _Static_assert(
>>       sizeof(flow_ports_t) !=
>> -        offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>> -            offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
>> +        __builtin_offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>> +        __builtin_offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
>>       "flow_ports_t must match sport and dport in struct
>> bpf_sock_tuple");
>>     typedef int ret_t;
>> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
>> b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
>> index 76eab0aacba0..1de0b727a3f6 100644
>> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
>> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
>> @@ -12,6 +12,9 @@
>>   #include <linux/ipv6.h>
>>   #include <linux/udp.h>
>>   +#define __builtin_offsetofend(TYPE, MEMBER) \
>> +    (__builtin_offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
> 
> I think this can be simplified to undef and re-define offsetof like below:
> 
> #ifdef offsetof
> #undef offsetof
> #define offsetof(type, member) __builtin_offsetof(type, member)
> #endif
> 
> Then other changes in this patch become unnecessary.
> 
> You can add comments for the above code to explain
> why you want to redefine 'offsetof'.
> 

That's one way to solve it alright, but then other instances of
offsetof() in the BPF code (that are not part of static asserts) aren't
CO-RE-safe. Probably not a big concern for a test case that is usually
run against the same kernel, but it's perhaps worth retaining the
distinction between compile-time and run-time needs?

Alan

> 
>> +
>>   struct gre_base_hdr {
>>       uint16_t flags;
>>       uint16_t protocol;
>> diff --git
>> a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>> b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>> index f41c81212ee9..463b0513f871 100644
>> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
>> @@ -23,9 +23,6 @@
>>   #include "test_cls_redirect.h"
>>   #include "bpf_kfuncs.h"
>>   -#define offsetofend(TYPE, MEMBER) \
>> -    (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
>> -
>>   #define IP_OFFSET_MASK (0x1FFF)
>>   #define IP_MF (0x2000)
>>   @@ -83,13 +80,13 @@ typedef struct {
>>     _Static_assert(
>>       sizeof(flow_ports_t) !=
>> -        offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>> -            offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
>> +        __builtin_offsetofend(struct bpf_sock_tuple, ipv4.dport) -
>> +        __builtin_offsetof(struct bpf_sock_tuple, ipv4.sport) - 1,
>>       "flow_ports_t must match sport and dport in struct
>> bpf_sock_tuple");
>>   _Static_assert(
>>       sizeof(flow_ports_t) !=
>> -        offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>> -            offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
>> +        __builtin_offsetofend(struct bpf_sock_tuple, ipv6.dport) -
>> +        __builtin_offsetof(struct bpf_sock_tuple, ipv6.sport) - 1,
>>       "flow_ports_t must match sport and dport in struct
>> bpf_sock_tuple");
>>     struct iphdr_info {

