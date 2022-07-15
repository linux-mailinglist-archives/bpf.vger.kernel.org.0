Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85B3576ACE
	for <lists+bpf@lfdr.de>; Sat, 16 Jul 2022 01:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiGOXjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 19:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOXjf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 19:39:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3B813E14
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:39:33 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKnQto016798;
        Fri, 15 Jul 2022 16:39:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0n/AzooK9e00w9jSQtqvfYLNqOt69rfmGi4PxDljpeM=;
 b=m4EchdD19m7N6VevultzofWc0r82f08h4EZhIe2BA/z+6iGcova+Va9vzWdo9MEmuTk5
 m/RZkEKocPis3DLBajPVu7ZZ+Lx/myvEvdgzxqqo9XMFy37przI7vSkERD8Zbkp7EiDA
 qq/qn8CJiMR8Fq6zHri/085s/LuZoNE/idY= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hb892uy7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 16:39:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIoRHEFsvq8L4KINsbAHwNmRi+gLxIIsMs6yXYERCEHwmzcJUjDjRqVu58qi3vVdcLw9U2DMB93tsKUk73nYmcwe0WlcONnAQqXQbMqyuys1XNMrboicM+ozXUpJbSupWCaKFrWYYYACA5ZDSTILIbk2AAOrY6S6/8CPEG/o9XdqTVygQ5c7OvSXaUOE7Ky2KzsUUtsZTchd0aCc2gQ0hc+oqvbpL8wLqzy/1+vsEonaadElYU/K+RvzcN2sX1iTZL/96ksBr8345XrfWcYZgXzye+k/pOKA9gy9vB73OnXkkCY7BkBD4EEizArCJXSvWFaWsr8T9yWdFaCnWQ9EkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n/AzooK9e00w9jSQtqvfYLNqOt69rfmGi4PxDljpeM=;
 b=KkKRwimnEwDsqQc5wNhuB4xr2MiBrIZfd1vv01DH7bHXG4J3ePYfwNVy2ShyDT2nLz8bcjq/v4rYsUOGO+TTOaZe7BOSulfBWdk6byc4i2IvI84aa2OD3Za/vlAMM+DCsHUpV64luuXu7MurKxz7YisSTR68y2duSBI4jg9aQEpQb+ryFrHDjOJuvxJ9YgTqz8O++482cHAuK+bRj5NZ3H4ZUHyHKbKQBiKhB1tD8AeThOJkKJlPEMlXgJ6NMJ8rtz41H6tKCRvx8v1btNM/0KKkOVraJhAVPaj88NANPnC3oS0TQOHMGgyG9DHdz8vdoNB1cAjwl+jysvxS4t4+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4401.namprd15.prod.outlook.com (2603:10b6:806:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Fri, 15 Jul
 2022 23:39:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 23:39:19 +0000
Message-ID: <c3121d2d-8453-18de-3cc6-a01f6b131940@fb.com>
Date:   Fri, 15 Jul 2022 16:39:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: test eager BPF ringbuf
 size adjustment logic
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220715230952.2219271-1-andrii@kernel.org>
 <20220715230952.2219271-2-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220715230952.2219271-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1545a1-618f-44ba-2438-08da66bb3cb2
X-MS-TrafficTypeDiagnostic: SA1PR15MB4401:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOvWavfhkPesrED+EI1t1N48ZL50mtVTrbD+Yhb8xYfsREavuBatBZ9X85KCBV7xtvF1ex6jXJIEcY4JY5qC28Ow8dISj+0BTazqOUU4kAWEzdxY6eVxuRaGdlBKeU7Iol1WvXvg0uFHpwZ3geo65UJkoRESqQ6pyh/Ous/1WTVawPtofKAkqVtvEpcZL9Fw4aktENMRQ/jFJS+x3zIwt3j/LFj9dUYS27MMh2+g4Xk9xdHBwWwlx7TN16bOZRGDvgLia00ZXqw25S6XeaGAkK9GADFbGqPxnOpV9w5R5Tltm4VAdHy+lo/XWQhkeC9qpmlkrZDdfqrSpdsN0FZWQvmYYqGILLMFcnNhkqjHfUGXySUS2SsNPj6EkDTfcZmLXSCdFAkVDQnaiOR+RSNUU8+42vOZ9guFT3OTECoahGFdEgwJhzbIbCurowUXLwUF5hBJcd9Qg05CwMb2sPiREMYXNf3WoWOjCc6hw9FT6s3Io7tH6VHboB0dubYKdZHY06xCgZKrodH9nmWIJb9kcwjYM4/ftH2WvGoppj6nn24Q2MPi4Ec2Kg2VEiNGeZBaVwEqAUM8n5TsCmXBxa25Ku3PejzpdyrYPHlHAabaAyYe7iwXhj4OYGS72CRbCQ2gXY4ctvYcjB6kutq3awikn00soXIJbJ7IHRhDvN+Yx1Rs6PuhR5OnpOAnUTF+CrRxAEl4qKFbosVUWYZsf516pzaeg755BSv/0EGLmAZ2olyBHdsC+3sZVirlrkvWQ3XTkIfFIb/V/Kfe6xq1LA/2R0GR1jb5tL0HxnS62xicDBDsqNZ5uxAIhb/3nY10czXb4PUwBptIXJZGiaaawfwKG419eDzeVrAAK+FUOWzxMrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(478600001)(6506007)(6486002)(41300700001)(2616005)(53546011)(66946007)(66556008)(6512007)(186003)(38100700002)(36756003)(2906002)(4744005)(5660300002)(31686004)(8936002)(66476007)(316002)(86362001)(4326008)(8676002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEFjOVF1Y25oeE40N3RHVjZMb2szWWR2c0ZqMVNNazlpTWx0TlltalExRUYr?=
 =?utf-8?B?bnNFQ2VKZXc4eFpGUWJENlFURVdsM3YzbnNjQ21rbUhzSVVpcGkxZzRRWS9l?=
 =?utf-8?B?UDVEUlNobXd1RTdiK0dFT3VGekJkamgwdXhBd2lwZW5jS1dmb2RlbC90WTl2?=
 =?utf-8?B?andJWDRLZjF2YktLY2Y1UW91cmpsbk8vck1RRTNiTUxIY3FBT0hySFBqQUMy?=
 =?utf-8?B?bE5qVngvZDJLV1pjSG1SWG9idjQvanFTRVZGMmhZMUpERWFvNEtTTTFjcnpD?=
 =?utf-8?B?Q0djTDk0SDNQOStRTEx5QUxwbHJhSkwvQ2c5NGpUS0V3R1h0NzhhTitaUFJ1?=
 =?utf-8?B?eWpHWkltVmxYdGZ4eWgyV3VIM1pYWGdlOXpteUE5VnFQZ1NzdTF3NC9mTlcw?=
 =?utf-8?B?dTdRR2pYZk1rQU40TVh0Y2dVdWFQYy9Ed2M1T1lyQm8vYnVMcVZxalV1eHlm?=
 =?utf-8?B?QzMzaXJGRzRXSmNMTVlDMkYxYnZuZzd2bUw3TXNyOENYL1drRWRYdlNNR0VQ?=
 =?utf-8?B?QmpmRVA3cXlXM21NK3c5ZGZySkN4RXVBb2JYTUVVL2xkSVB2M29YdEhTdHIr?=
 =?utf-8?B?WDVJNWQ1cU5GMDdyL3N0Wm5laFRhN0VrWFB0dE11UlJyQXNGWDMvK1h1V05N?=
 =?utf-8?B?enppanRMUkFsemlINnd2K0szMnRWUVpicjFsUUNSdHNEQjdhT0VBcm03NWl1?=
 =?utf-8?B?amdWYkpldjFENmRnZ1V6RFRWMjVTS0ZJWnVHVWVucFdoazFvMzRXZW1YL0Zx?=
 =?utf-8?B?RHhiU3I3K1ljMHZMeVFyeEt5a05jV056OVZ5bThXU1JydXRBQk5jUWRLUVM1?=
 =?utf-8?B?ZVFtQ1RubTcvQ0RnVkhwVDNaQTN6cFhFdVpSOE9wR3JEb2EyMjFpemNEdFFI?=
 =?utf-8?B?aytOSlpKMzNrcVErckErL3lLQjhjanRsRW5iMlZGbURjVWtYZ2hsZkVablFr?=
 =?utf-8?B?aW9vdXlPZ0V3dTBzWVpDbFRlSCtpZnorclY3R0hEL3JtMndPbk9zaGNHbzlL?=
 =?utf-8?B?WlRtS1ZyV2R1NUR1Z3doTFJTekNVWUFHdHJnWWwxdnVMTVd3OG5STm9iVXU0?=
 =?utf-8?B?U1RIaWNteXBpQnNkdkkvZW8xSDFlajlCOG9oOHZoOEVDTldqL0NESk4rUzhL?=
 =?utf-8?B?Q2NuNHlPc1ZzWDM2YlFaVzZaYUExV0RCamRYS3RqYURjQUp6QkhoVUg2am9Z?=
 =?utf-8?B?YVIza0t5RTdsSlo1d0trSS9oY3FhMGJZQWU3VVdaZzhxN1NHbzFPckRoMk82?=
 =?utf-8?B?dDRGbjJJeHoxek1KR2x4UlpZeE9JcjBZUHVSU1BSM3BsVFA3QVdFN2ZTYmd4?=
 =?utf-8?B?N1lHSkVZR2tMM25LWStRMUh3ZjRWd2t4ampXZnVJTURPUEViWXhrSWh5UVJi?=
 =?utf-8?B?RFk4WUZ1Y3F2eVRmZ1hEZzZiY1hkWEtBaHJxQ05VNFRkb1lzbzlhMzNaNkFv?=
 =?utf-8?B?ZE5FUXZINi9TcVIrRGhBaGdTTkVMK3g3UWhpQzl0NEliUUlhZWhya01jWHVD?=
 =?utf-8?B?cDhPc2d5bzFTbTJUVG9wOHVPNzBsOXkrZ3lkWkR0dG5TREJ5UGtLUjk0aHJY?=
 =?utf-8?B?eUJ0dEtCRk91S1pLWVM5d1djc3RqWDU5d0drb25IZEJOWDhKRDJHK1hNV29D?=
 =?utf-8?B?bUZUOE1TVjFVZ0dCQlBKL3N0dTA5a28vOVVsVDNqeW5xRStDRExPTVhDOHVw?=
 =?utf-8?B?dk1KdytRdVFOR3RERG5sd1R4cWpxRTdrR3FWU3NqdmNiVzhsTDR2R0Z2TVgx?=
 =?utf-8?B?MlBHdnQ0YXFVMm5ZQlZvMmRMQk04NjUrNEJxWEM2R0NaMGhza2Zxam5vUXdV?=
 =?utf-8?B?ZTZaWjYzSUJrdnFhRS9TV3BKUzFTamdjeWVsbzZBMDFrbXMvSlQzTk9aSmlK?=
 =?utf-8?B?ai8wbW91WFNDQVMrQUJFbHR0dFlvN3U2RmplMEhxOFJmRVlYWnpla0QvSGpk?=
 =?utf-8?B?QkloU01FQ0p2M1BxYzFTcUpUb2pCTHhHZERjWHUvMlhMMHdNR2FmWlFCWkk0?=
 =?utf-8?B?UFU1MGFuRllxV2ZyNTlOVlVHckdzbkhUVUNDRkdDRVVML2d0UWxremY1Z2kv?=
 =?utf-8?B?eEgyd2RRMGhadlh6TEJZMkFMU3BxZ3hGalBNMHhUdWxBRmNNNEtFbW5qY3I4?=
 =?utf-8?B?WUVYV2JlNE1GWEhlSDZZUVFIMG9iUERKU2ZhR1pvbnluQ0FQMWxrTnN0bURS?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1545a1-618f-44ba-2438-08da66bb3cb2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 23:39:19.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dwg5UBcs+S9kisp1rqfAksBwvLPXsQU38gv0s8xr2vOck5GbjxKcGZke1T86979E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4401
X-Proofpoint-ORIG-GUID: D9U69YLoJyTDy5DGuPlFREtHhbH75w5a
X-Proofpoint-GUID: D9U69YLoJyTDy5DGuPlFREtHhbH75w5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_15,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/22 4:09 PM, Andrii Nakryiko wrote:
> Add test validating that libbpf adjusts (and reflects adjusted) ringbuf
> size early, before bpf_object is loaded. Also make sure we can't
> successfully resize ringbuf map after bpf_object is loaded.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
