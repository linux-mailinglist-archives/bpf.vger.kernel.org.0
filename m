Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EEA679E51
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjAXQMb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 11:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjAXQMa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 11:12:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7A45893
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 08:12:28 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OEmqoS021417;
        Tue, 24 Jan 2023 16:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=U9oumzdmOCtcpBzEg+C3sneslKgq0mcRtIWdNuJ039E=;
 b=gknFuCLPrxQtUCf31U/i3w5hLtOYdwf2l7/sqf58J6tZ4atBQvPWQYM0M/rBW9QtSja5
 lXT8z2vtUL7c6J+E4qc1ZnN/m0RFJ6jcjujsupk4sUT1RrJYeiZzIOz1uGb+5qbd8kDk
 n+dns5NcE3TefuPZaJCqldvRQBiiwC2I/YJWX0Sk6dk5qS+mGnb2NkncEM/jpRNHFx/A
 9U3VFPfs86RQfW8XnOhthedl6p7AQsDsWs9yR7EYnXe5qFjD+joAJG4deaP4rAanOamG
 XyWMV3olCG/C7EXnsfhgezyHsa1MRp9AciqsGWgHl4YGpZdvErUgTbIhmT3nUFNf40Rn KA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87xa5pp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:12:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OFarrO005932;
        Tue, 24 Jan 2023 16:12:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g546de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 16:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+0V6Rvpdv1qcrOeQH5dpLohR4mwDTE+qbnjDIn7KvEidWtwixHFi3gb7o8JVhHJzURKG71djUfFAgV4K10f7SjB6slvm+gttZWF1gVVuLZGAy4Hod6U1U8qSOyogIqOOjHxrXnQlAqPMKtClknchvSVMe/BmwLkoGMrSvMbMhfBFp9Jqc7HF+OlOLq29aBhXZOGYoQ2JWrpzKPbx3A5pHTzhkLwuTzrYSE0WXz7UOp63xoa4IsEAOQUIELx1Tp4SONf9JDsIW6WygvlnmY0CkEAEYImbxrj/TRWNV/OkIDVCk84YNnja8HYAvYshbku38VO3QE8DaWdlb/XmtVc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9oumzdmOCtcpBzEg+C3sneslKgq0mcRtIWdNuJ039E=;
 b=g/ebX9khpPt5RN51mpcPeQO51SBUvwdrZgR9pqWa1s89XklbAzjO4EvaOXoaF6TBBwhdEtFsxHotGcN1pB4Ah6bzD++RMU7Ua6BqK5U1+3C4zqY2m64+h7eRG4a83Rn1sYl4qB+L32B6jo+oLYxmpf5HYOtDsdw6KVqciGhAWGz0i9KHdFDIaKC4Bn3BWqnPevBsd00TEz4C35nBP9DawI7jjh+b32xrqbIoYeyT9JrXOdTciANJpMvdZQh8rgLYxI7ZcYjRaqL7KdW234lpf3JrNzJ5We+gllQJBzXra5JXzVlbl+Ulf0o/clQ7G7DZI3ylX1q+byYp0fsC5/00BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9oumzdmOCtcpBzEg+C3sneslKgq0mcRtIWdNuJ039E=;
 b=dktrkfui7v3fiG+qt8tr/8lrqt9xPJCKrO3XRc6OHy/6g59nBTkdXUFYt/BinXwaxs7SvfNFqzeFp4QCDpfJLNCFeFQGQQKCcvLoOyGmafZUXIsekrkMXo5p+AG8/RgP8h8n9OvI1fKtgCmz6Xzv2OMFoLj7fDi8+bmRqXkbvt8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7092.namprd10.prod.outlook.com (2603:10b6:8:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 16:12:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 16:12:01 +0000
Subject: Re: [PATCH dwarves 0/5] dwarves: support encoding of optimized-out
 parameters, removal of inconsistent static functions
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     acme@kernel.org, yhs@fb.com, ast@kernel.org, timo@incline.eu,
        daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <Y8/1vY5vaPcerfYw@krava>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <d37a3596-4274-7ac6-615f-3e71393cc5d0@oracle.com>
Date:   Tue, 24 Jan 2023 16:11:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y8/1vY5vaPcerfYw@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::33) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 46eb894c-e7f3-4ff5-e4b1-08dafe25ba1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tPcsmEXVvIdNKS4c7RMSCuVs6TPnV1LURXkyprdDaF78Agq3F9tUulZodgkvrvGydGm4oSBUPZ941t+EaCOSN4qyyME1kZyu1nQsvTN+9qM/AxwYbOgMq907xnF3YS2e0QBt2zzdA5E4YcmhVTKqQAjKay6x4uVNWXuC+C0cisDz3UXL4oLdOlbxvXyc6CheJT/48nS6o4cF15ybAAoAl5zb+EvCW+kbfO2LVMYKca9M4XVhpHXA81bxKq16bOeizcgnVEMkD9MA1MfYhFgaOe9xf3INax3Xh6usPeim38YFzJCC7DIQR1DM/J3tkHPwe55LLvKtRUbMYx18rB2sXHoG+cfChEnSySvrUuJ9az8XF15y1qRmMTQy1mhXYpO5WHHCK64KnG1playS45DYuPqqfimn35ZBAMe7GhXwF+3w3l7XvH8qRW8uLvHGa9BiYQ2QiyQo1Ejg3crveoL47pMsqQH3O6ibEHf77owgPisTWQmzgvVyZ/ZBUDRQZxgcJZxR9eZ9u4NE7pN3mmvfy517+ufjhHHtldef/O0GqNYqEpmFNBmZ8m8dY7bY4sInoPv9qvCVrGxWJ7V1fxbxfdIvR9XVHp6agXFE+1Tps3HNV4kr9RYZTSxOhualRjy8Hh1GB2J5EocyZBO3E8O4qQINDBthUwSyHHMlVlH5dnj2Mlxfglsd8PNgH0NjivnJXJrn4R4O3C+8UsUI6Me+/iUu9scnEkuJH3uLHZcVjerZngc2N45N3Abeuxd8Xv2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(86362001)(31696002)(36756003)(316002)(478600001)(6666004)(6486002)(966005)(44832011)(5660300002)(7416002)(2906002)(66476007)(8676002)(66946007)(4326008)(8936002)(6916009)(66556008)(41300700001)(6506007)(2616005)(38100700002)(186003)(53546011)(6512007)(83380400001)(84970400001)(31686004)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHRzZkliNlB1V1ZnQWRaNytJZjZHTTEwajZtYnRQTlBTUFJpOFFDL1d3dnE5?=
 =?utf-8?B?ZktXSGhrUDQ4K1UxdzRCTzdlQUtEY2hiQjBuM3R0M0x1RitETHNQNERnSU52?=
 =?utf-8?B?N3UwekE2MndvTWJkV0JyTVBSK1d4dTdTVGFEcWVBc09HQ2VSc3VsZGNYZTI4?=
 =?utf-8?B?VjgwY0VPVnRlUWZqR2EwSmFvTFZmMm15cDc3SzBUbWVtc0VyMWR1dkltczUy?=
 =?utf-8?B?VW43WjJiaU1QY0NGaWU3YVM3TU5WNUhlZUthaHJ1R2xsWThMRndHcDRiZTdH?=
 =?utf-8?B?QlB6T2FDSitnZ3VhL3RLRmNOY3RuNUptWks1Tm16Zlc0cEdIVmVOYkZHMlF3?=
 =?utf-8?B?R1RoVXJhWExRZkFienlsY1psNjkvNjBHdXExMHcvUXhkOGMrMG1BZE9CZFNs?=
 =?utf-8?B?TG04ZzJoZWVmaTl2UXZ2VnkwQ01jZG9IbVZTQ2pyNXFnMk85eXZNdEtmYmRP?=
 =?utf-8?B?VGltWkpTNGNQSzRqTHMrTHFpUk1PRXlITWQ0eFpOMjF3WUZMaFF2bDl6UTlM?=
 =?utf-8?B?SUhuOGlJLzcwWEc2Zk9sQzBTWThZVjBCN3N5L1QwaktiUmUreGNDSldZS3oz?=
 =?utf-8?B?V2FaZy9oZ0Fna0Z1d3BiREQ2RWQxcTBrdDhQQ3JIVTdGWW56RGJ2dzBacE10?=
 =?utf-8?B?YnlCMHNyN2hhSEtzMDNtWVl3YWdxaWRUT2RBMEQwdUw2Z0pwUFBjYldaN1Jt?=
 =?utf-8?B?Wk4rUlFqUXR3RnJoMnBSMmlOTE1IUVZaOWNrc3lGbUVoQklDb0ZoWTdsK1VF?=
 =?utf-8?B?U1dDU2tnNUJsY3FGQWk0ck03bm1lRjN1cGMyTzgvMjJLZjV2cmF3bThuQ0dp?=
 =?utf-8?B?SUpPVVJLMmtGQUhYWkRJTW5tKzVnTkNEcGdkT3VYRi9mTm9YcmRaU0ttWkVa?=
 =?utf-8?B?UXMrajlYclM4M2NxNVQwcmtFQW5PNkR6eHIyYmlvQmw4S3VCd3ZxSDdLZFB6?=
 =?utf-8?B?ZjVDTHdtOTlXa2ZPSmlmaitvZXlQcG1GWlFnL2pSQW1LUVhiQWxzOEp0Mnc1?=
 =?utf-8?B?Z0lLQVlCeE1RK0ErenJJdDkwNGhVbTlxRUNsSDBsTGtVV3BTd3oyZW1kOGFU?=
 =?utf-8?B?VlY1bmV2SGE0QnVyQXdkN0U2bjJQSis5dWZXY2NVSlFMVXpjWFExYm43ZVFG?=
 =?utf-8?B?ZzhlNy9YTU9qMHZvalhjSE5HVXdGQUhxc21DcElESGhXQjBEb0MyNlNERk5s?=
 =?utf-8?B?UG8zUUpGdWZVZ09YeU14TUlTRkVuMXlWVVg4d08zR05kaXpMRHFDUWJWRHVs?=
 =?utf-8?B?dkxMSitqMkZMcm1BOTVzOGJneHhTTUlWUHVsdURvU1J4SjNRNWVrSlNudmJi?=
 =?utf-8?B?OTZkMnpiUnR1QWRndUtpM3QwWnk4OHJ6Z3I1RGhZa0dSM3BjY0xTT2x4ZW9u?=
 =?utf-8?B?V0ovcThhbGJFamJOcXFZbzlRQTJBRTBBYms0d2o3RHlJUEFSZFFwZm5zV3Yx?=
 =?utf-8?B?RGNObURsWlowSGFMa0dDYi81YXdwU2ZpOEVuQzcxZHNsTWlpUVRUcUMzcnh0?=
 =?utf-8?B?aGZGbGRKcGFxamhvRU56YzNYWDI0ZzFZKytGOUlBRkNXVDJWNGszVWQzSFMy?=
 =?utf-8?B?cFdOc3NtV2MyWjZrbXRpQyt6cW1wOTN6WERjZHhuOEwzZFJXdzlSVE50cWNq?=
 =?utf-8?B?OXlibStaQnh6NVhJd2JtT3BVMi8yVjFYcGQ4WnU1SlE2YW1tSDU5UG1XZDV1?=
 =?utf-8?B?cXZSekxzcHB4Y1RSN1pJa041WVZRSjAwZGRWV2FoZ1NZdjQwRDN0UC8yTTBu?=
 =?utf-8?B?NTdmRkh1a0EzWWtLR1htL0VjemsyTFZMVStBM0FrSGFmS1NJZWd2aGRxWExU?=
 =?utf-8?B?SldFR2d5RDFBZVRGeE9HM2FTMFd6bWNZWXB2cFhSb054UHYwVmo4NUVJeGZv?=
 =?utf-8?B?UDZadFRMKytBOHVVcmUrdEp5V3A0VWJRdGtyV0srNGVaQlk5cC9TZEIwYmo4?=
 =?utf-8?B?UGhhV0FWNS80Y3k1ZHNLbHhUR05WbzZEV0FqelZldlBsWXcwZC9LNXRHb29o?=
 =?utf-8?B?MXhEVnVYNUIvMHk3dTZNZi8vSUIvRWdZMjRsMm4yOXE4dXdXMkhHNENTQlJv?=
 =?utf-8?B?NGh4ck5JY00yWmxKcTROc3UzeVRXNklqUlhhakxqdE1YV1h4NDdyWGQ2SnRJ?=
 =?utf-8?B?T2FLcG5nbVdnckpzVS8wb2V3TDJpNWY3L2c2NkFLVnI5cHpmVnBkb2E4Z2hC?=
 =?utf-8?Q?pxme9OmHB2EioKvU3pl70Xc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VTBHc0k5R21DNjVXNWtIYzkyL2RSWW1McVF4OW9JcmcyY21HZnZmU0t2VkYv?=
 =?utf-8?B?N0tIbTZObEdpOC9SMUlzekFVaTVveHVjU1pIQnJ0bDEvVzE3R2VYMDE5MWUv?=
 =?utf-8?B?RWZZalNidy9Yd0dvMERIcVV4RkNhSWR2U3NTVXhFUHM1YWpxOFpjNU9sclRS?=
 =?utf-8?B?K1Q5NG5rUVRvN2E4ZTdNUTZsQW1xSFc3K3RDR1YxRENuQXdIK2Z2V0xjMndE?=
 =?utf-8?B?d3ZhMXJSS09FK203cUYvL285by9Edi9qQkVvR3ZyckhoM2pETEdadmhrL0ht?=
 =?utf-8?B?OU5kck1BdWFCNG5lQzMzYzVTVHFnUUttM25aUHFoNk16QU5EL3JqOHpuTGVx?=
 =?utf-8?B?WTNQN01tT3RmckdwN09BMHhPUmM5Y3ZQTTJXckhkSkEvRXRpTkxkMVc2TTMx?=
 =?utf-8?B?Sml5ekhZcUhwblh4b0pDQU9ya1laUkUzbmtrb1NuY3BBbWlINnZzT1M5NFZo?=
 =?utf-8?B?SjBtT0NXSHExU01ZR1FsU1hIaVVGSmh4eDlZK0RKblNXR2lUQXVXQjgzMXRX?=
 =?utf-8?B?Z0ZHT25YRkZuYUFkMFoxTjBDMExWQ2YrZEdTb1plZ0pNT0xYZURzamp5RkVX?=
 =?utf-8?B?WGlGWkxLZG9jSGtnbk5wRExISnpjam1ibTMzaUhuTVY5cnpNNzA2K01kNHpl?=
 =?utf-8?B?d25KSzdwdG9OS3V0K0VNemJ3ZWlQakVPNDhjNTFJc2JxUG1xR05kY0xBUXFH?=
 =?utf-8?B?blFqSjJyRmdPWGN5eVVpV2VPbll0OURURW9ETmNySE40YndNaTdnVnREdGpB?=
 =?utf-8?B?ekszSVdIWU9HdlhKVFFCbk5LUGdhMHFkLzhxUzczanpVUERYTVpub1EwSWNI?=
 =?utf-8?B?MnQ1SUl6allPWDc5TmM5K21iUWFqbTVrQVFvakxCRkRoaVR0WmRjb2RUa2pj?=
 =?utf-8?B?TkRJZW5Sbm9wQUMxZW1FVXJvS3F1Qlo3bEVRVDduNU1BdTM3OWxpMUNUc1hn?=
 =?utf-8?B?UnpRMm0wUGx6TmV2TFFBdWtRaGJQL3lEVUVkMnN4WlI4bGxLVWVLbzZ1aGgy?=
 =?utf-8?B?YXhUc0FMZTZvK1VUa1loYVNDcE9BN0t2QkJmVjFVSnZyVVFwZWFjdnJqYlc1?=
 =?utf-8?B?Ykk4RkI0KzFWU2pLY2QwbUtYL3JEQ3FsUFR4c1A4dWlXM0pWdjlZTnNsTGZN?=
 =?utf-8?B?RExDdE4zdWt6eTF1ZlZvcnlWZVJjNGRqVStvV01Id2dNdkh1YVQ0aGVld0tF?=
 =?utf-8?B?YUFBd1RaMFljNkVWQ1ZOZ214Q0ZiVXZkMU5NWVUrdVBmS1hZUUF1RWI0dHpo?=
 =?utf-8?B?aDFOWm9yOHp0Zk5oWVlaeDc5SkFJUVFOYVMxU1JjTDgxcFJ1dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eb894c-e7f3-4ff5-e4b1-08dafe25ba1e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:12:01.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gZ0Pr7qlUsobe+qj2PHBleKXFQXB2pgrqECNIwL33i8aQ/QVTkC1lsUfCbIy1jxcib3OqIL8/CRZASPufUVTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240147
X-Proofpoint-GUID: 2meR-TU03v4nhhrNHZVKGwDF7BLg3X6g
X-Proofpoint-ORIG-GUID: 2meR-TU03v4nhhrNHZVKGwDF7BLg3X6g
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/01/2023 15:14, Jiri Olsa wrote:
> On Tue, Jan 24, 2023 at 01:45:26PM +0000, Alan Maguire wrote:
>> At optimization level -O2 or higher in gcc, static functions may be
>> optimized such that they have suffixes like .isra.0, .constprop.0 etc.
>> These represent
>>
>> - constant propagation (.constprop.0);
>> - interprocedural scalar replacement of aggregates, removal of
>>   unused parameters and replacement of parameters passed by
>>   reference by parameters passed by value (.isra.0)
>>
>> See [1] for details.
>>
>> Currently BTF encoding does not handle such optimized functions
>> that get renamed with a "." suffix such as ".isra.0", ".constprop.0".
>> This is safer because such suffixes can often indicate parameters have
>> been optimized out.  This series addresses this by matching a
>> function to a suffixed version ("foo" matching "foo.isra.0") while
>> ensuring that the function signature does not contain optimized-out
>> parameters.  Note that if the function is found ("foo") it will
>> be preferred, only falling back to "foo.isra.0" if lookup of the
>> function fails.  Addition to BTF is skipped if the function has
>> optimized-out parameters, since the expected function signature
>> will not match. BTF encoding does not include the "."-suffix to
>> be consistent with DWARF. In addition, the kernel currently does
>> not allow a "." suffix in a BTF function name.
>>
>> A problem with this approach however is that BTF carries out the
>> encoding process in parallel across multiple CUs, and sometimes
>> a function has optimized-out parameters in one CU but not others;
>> we see this for NF_HOOK.constprop.0 for example.  So in order to
>> determine if the function has optimized-out parameters in any
>> CU, its addition is not carried out until we have processed all
>> CUs and are about to merge BTF.  At this point we know if any
>> such optimizations have occurred.  Patches 1-4 handle the
>> optimized-out parameter identification and matching "."-suffixed
>> functions with the original function to facilitate BTF
>> encoding.
>>
>> Patch 5 addresses a related problem - it is entirely possible
>> for a static function of the same name to exist in different
>> CUs with different function signatures.  Because BTF does not
>> currently encode any information that would help disambiguate
>> which BTF function specification matches which static function
>> (in the case of multiple different function signatures), it is
>> best to eliminate such functions from BTF for now.  The same
>> mechanism that is used to compare static "."-suffixed functions
>> is re-used for the static function comparison.  A superficial
>> comparison of number of parameters/parameter names is done to
>> see if such representations are consistent, and if inconsistent
>> prototypes are observed, the function is flagged for exclusion
>> from BTF.
> 
> should we remove all instances of static functions with same name?
> 
> Yonghong suggested in the other thread, that user will assume that
> the function he's attached to is the one he expects, while he will
> be attached to any (first) match we get from kallsyms_lookup_name
>

The problem is that many static functions that have consistent
prototypes are encountered multiple times when processing CUs,
even though some have only one System.map/kallsyms entry. I tweaked patch 5 
to count how many times a function was encountered when compiling the
tree of static functions. It turns out of the 25872 functions, 22608 
are found once, leaving 3264 that are found multiple times. This would
be a lot of functions to leave out I think, especially since many
don't actually have multiple kallsyms entries to deal with and
the prototype is consistent.

BTW there's a bug in patch 5 that can cause a segmentation fault,
apologies about this. I don't want to send a v2 yet as folks
haven't had a chance to look at it properly but the fix is below.
Thanks!

Alan

diff --git a/btf_encoder.c b/btf_encoder.c
index ee0b032..e89c1a8 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -786,7 +786,7 @@ static int function__compare(const void *a, const void *b)
        return strcmp(function__name(fa), function__name(fb));
 }
 
-#define BTF_ENCODER_MAX_PARAMETERS     10
+#define BTF_ENCODER_MAX_PARAMETERS     12
 
 struct btf_encoder_state {
        struct btf_encoder *encoder;
@@ -869,7 +869,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *en
                        }
                        parameter_names__get(&fn->proto, BTF_ENCODER_MAX_PARAMET
                                             parameter_names);
-                       for (i = 0; i < ofn->proto.nr_parms; i++) {
+                       for (i = 0; i < ofn->proto.nr_parms && i < BTF_ENCODER_M
                                if (!state->parameter_names[i]) {
                                        if (!parameter_names[i])
                                                continue;

> thanks,
> jirka
> 
>>
>> When these methods are combined - the additive encoding of
>> "."-suffixed functions and the subtractive elimination of
>> functions with inconsistent parameters - we see a small overall
>> increase in the number of functions in vmlinux BTF, from
>> 49538 to 50083.  It turns out that the inconsistent prototype
>> checking will actually eliminate some of the suffix matches
>> also, for cases where the DWARF representation of a function
>> differs across CUs, but not via the abstract origin late DWARF
>> references showing optimized-out parameters that we check
>> for in patch 1.
>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
>>
>> Alan Maguire (5):
>>   dwarves: help dwarf loader spot functions with optimized-out
>>     parameters
>>   btf_encoder: refactor function addition into dedicated
>>     btf_encoder__add_func
>>   btf_encoder: child encoders should have a reference to parent encoder
>>   btf_encoder: represent "."-suffixed optimized functions (".isra.0") in
>>     BTF
>>   btf_encoder: skip BTF encoding of static functions with inconsistent
>>     prototypes
>>
>>  btf_encoder.c  | 357 +++++++++++++++++++++++++++++++++++++++++++++++++--------
>>  btf_encoder.h  |   2 +-
>>  dwarf_loader.c |  76 +++++++++++-
>>  dwarves.h      |   5 +-
>>  pahole.c       |   7 +-
>>  5 files changed, 390 insertions(+), 57 deletions(-)
>>
>> -- 
>> 1.8.3.1
>>
