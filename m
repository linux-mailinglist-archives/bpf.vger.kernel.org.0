Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C8458F1FD
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiHJR4y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiHJR4x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:56:53 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5510F43E76
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 10:56:52 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuWcn031076;
        Wed, 10 Aug 2022 10:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Uade//gCvV2oi9MMDAxJNmYxVMRRUGCrGFMGQzd6D+Y=;
 b=F5cb4e6k+mV9pjmrUeVzm3s9T9KsErxAd+H+JpTX9Xg1eBKx0iP0S3nYqJhXEXJ8qR2B
 0SEr82GCQnT2z0x+rF1LnAF1bcpzuhmzlcpPlpD/m4WQSuxvoj7JGoI4GcDrEM96ykLT
 MGCmHMcBm7HdrrxNNyV8ltUqPm54LdeJrtM= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb4aex7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 10:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SusNQJ+Y5RK0PNIaFUfcNhPKprCFEOZ5UsoqvJtjkJosQHpbj3EPUW5kvKeuJx/HvA6qktc/29DWPZNl/1lGauwAzwWxzbCYzBqCPcfX/0tWqIy3D1D5X4AdVV4T+HipRF6XFXIhzNC9IoMmpzLt26hVhyVrOrGvtxP1w7QVEzobENZJTGzN6b4fsby2iH2u9U1wHx33KdNXkVKZEFdxFQdc5rxYkw4Lx1iO+1tdq3owa1xVQ2Rh+qNGfqh9iwexGQTMHu1El+WfHa2Fze9D3fO48LSyQFAqRU5e39uOxk8h0m58R6yAsLdCClNl3wfa5mLE7QUASLv9Jx2LACCUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uade//gCvV2oi9MMDAxJNmYxVMRRUGCrGFMGQzd6D+Y=;
 b=MXJeP8WuJpk7JjgvLm2TZBDB/yeZRxprW9Z4WDUDT2OKnWdcasI3m+uGLu4erk07TFHPTqkzQOFoHdzbcutBskgzAWHchxKp9QcnszeVAwzaC8SKWWtK+0avD5HbFvZv9uZbN8mZFLrS7Je6f0grWAF2euY+bxm1IQruMGQSApnUtNF5qxiffuCtKIt2awqYmhUKL3UNU86gfZ82oq7eiWpP3GMFkeKj7uVqUU4rPlnq4lYh3g7lkwOgkqfWjtCWDzO20YGSq+ovDx2tklPirdsyPYjP5NYNh+14QXaUMhjuMmpPCEp1H7dID2k1J+Wxyt/Mob10MElNv7xdkbkAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB2649.namprd15.prod.outlook.com (2603:10b6:5:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 17:56:36 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::8500:4ce4:51fb:6a8e]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::8500:4ce4:51fb:6a8e%7]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 17:56:36 +0000
Message-ID: <03303873-4dac-ec6d-fdcd-9f529468ef2e@fb.com>
Date:   Wed, 10 Aug 2022 13:56:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH bpf-next 10/11] bpf: Introduce PTR_ITER and
 PTR_ITER_END type flags
Content-Language: en-US
To:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-11-davemarchevsky@fb.com>
 <33123904-5719-9e93-4af2-c7d549221520@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <33123904-5719-9e93-4af2-c7d549221520@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::12) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c2200be-2dbf-4498-11ba-08da7af9ab20
X-MS-TrafficTypeDiagnostic: DM6PR15MB2649:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ndo/oXjfpLGoxdA0FGWbNRqZnI7MAgFgrIz9Nn43EFFOIC+C07FlVouV+rZmUHk0147xda72dNalLogFDbMzgNRx9zsZEkcVt4h4wEjD4ExOLgQhTTLj1ycpbS2elfoa99e0PHjW0eWs7oaXuYRKSX0GSRudd/qYYktb2y73CJGGVkVGiCw1lVAlvR730XJ9zwederVpUTZo3R9St6yV0G5RZnaxcLd11MP4NKHKTRQmjKHWfGn9rnDf253Ei1yfsGihY98nMGs4h9fff6+x+Ow2wYVMpZCS/8PH2bCtYYMl0LemZiQ0RiK4JLAY7mF8fPfkMbYxJ8/jdYTvRkLBPlcDESMMvbMbyQf/eIgTH7AtU64fFkn0NS52ZjyBiC4Rr1ATMYlBQ2gH3M9e1ci5VF0eQ7KZUDLStjMkmIvjiz3Ng3LwNTwueZSXbNOD8Xouwo41M0LCH/OF4kAqotxD2d8fZAwLsAD1Mekzkc526MnXbdysqVlnu2/vIe3TUGJ1QbsCVEdx1CEBHB83HXMdRZ6CTlXpfkTGNiEjGaK/rhfQMHlnhweb5wCgUPQQNaK+1j4kAHBiSRoo6xl6L6/J9GXO3uogy3u1E78JnJf4jEs3k7iCiXRtljGjKPi7XqMEWqTovfgIRdXxRYvyxLbB75R/nhRij9CP2Fr2OFze4ZORCTYlmakj4b8/P31Xc9DhAO5xYy6DjxZBMHWtcOaHbHO/Dm6JHjU5pqLunGIW7SrVrYLvNU2MklpUIwgngSfDYw1id8+0lN8CcwswoC2jPMXrVUV+WH/KF3Wd5B0h1aByRYb01Wla+C9C443wMvwd9+X66vScNsMpXkMeZcaWGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(6486002)(478600001)(41300700001)(31696002)(86362001)(36756003)(6512007)(6506007)(186003)(31686004)(2616005)(53546011)(54906003)(83380400001)(66476007)(8676002)(4326008)(66556008)(66946007)(5660300002)(316002)(8936002)(38100700002)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDA2MmJSYTFicVNZUzY4cm1zR3BTYlBlMDJXMko4QmZEK25SSHR3TytxVERV?=
 =?utf-8?B?S0d6S1p4RTVwTC9vdmNiV0RNMEdpcGtjVnJMNnZ6VVdsSkZ5U0hoQyt4Tzd3?=
 =?utf-8?B?YWlSbGJFa01BM0tlVXdFUndNeU9KeFRPMkYxTjVwTGZvbUFDLzdQUlorNkd5?=
 =?utf-8?B?UFE5bVVPZkNIeWd5ck5adjNHWjNQSXEyanRXSmgwS2xrdHdRY1ZENC8wclBp?=
 =?utf-8?B?d2dVYmhiLzlKZDRKbkFMNzVTU1g4RkxRWENmOXppUXp0OURpakdwNE9mbVZC?=
 =?utf-8?B?b2gwZW5JMHk0Q3VWaER4enhkNndXWWRWaEU4NFFjVGdYOGFRTUlMdTY3WUZ4?=
 =?utf-8?B?S1E4SnF5RnBTWWxodWhUUnZkajQwQ3ZGVjlkaXNwY3JXeDA3UHBSbWlOS1BP?=
 =?utf-8?B?dU1PZGlUZkVUZ1oyREhMOE9wb3JYclJReXVwVTM3M2lkaGs1UTZHZUIySGZ5?=
 =?utf-8?B?UzFzcFpJbWJTVm5VY1h2SXMrMW5UaTFOaXNwTmMxWmRYbVljUmdibWxmV2wv?=
 =?utf-8?B?UFpFK0psNUU5YTRRVXExbThVbFhPN1lnZEd5cGowNTBFMmhhVm5ZOUhhTzFH?=
 =?utf-8?B?aVVmTUhzekhZMzF0QWt4Qit1Q2tQVXRSNXVaTm1FQ0NKK3ZrU0xXZWdxUDY0?=
 =?utf-8?B?T1pzZ1BzeTdWcnNvaUhSN0NKOUNhOER5N1dWeWJ3WG9Wd1JhSy9GQW5CZUN4?=
 =?utf-8?B?VlhoZUF4dEp6N1FiV0RrVUlyQzZONmVzVnUyb25CU2F1R0tKblRLNGRXN2c3?=
 =?utf-8?B?Q1N5cnRKc1hySWlkVW1xS3ZQWHpIQVQ4TUNYWmVTVGhoUGFKdGNVaDdKWmFx?=
 =?utf-8?B?aXRBd1liOTlTdGd0VHZ2Mk1YOFFWc2hLWkJ4Zk9nUnM2VlN4SU93T3BEMmZl?=
 =?utf-8?B?MjZTc2hkanpEb1Q4SUwvRGZXOGEzOVlaSCt4ZlJmTUpkRU1zalkvaGc0UDRU?=
 =?utf-8?B?a05WNlNiN2kxT1dKeEVSeE96S2RncFllV1RCd256MTdWOU5EYVBYSVZZbkJ4?=
 =?utf-8?B?WUJUV2hkbDFDNE04QVI4c2M0Rmh0Mm1LZmhLWWppOCtmWTdVVVlGMjdUMDRz?=
 =?utf-8?B?V2piS3B1Y0FxRjRhc1ZjWkNRMjJPMEl1YWgwQXUvUFRiME1Zbk5ZS3FpRC83?=
 =?utf-8?B?SWkyMFpyaW5vOE5JNDZQemZULytwU0NKTDd0VVpLaG1jRWJMUmhDYzE3NlN1?=
 =?utf-8?B?WXIzZFp1SFBaMzR1S0QrME9aQVJ5L3ExSmZsUEF5UFdRRjhBU0RoUm8vYk1l?=
 =?utf-8?B?UWR3UEpZL1F3TDAyY1JOWnFYVEZVbG5sTWF2L1d4YW5rYSt6RVZCRWU1NFJk?=
 =?utf-8?B?bXQ1Z0RrVDI4UHdxYW44c2dlV3dMWVBwYTVobFZMMFVIcGZoZHVZc2FSdXdK?=
 =?utf-8?B?cHZxRGtMdEVsbExGNzdIZ3ZzYUxSRjRweW5WRXpWTE5XVnFTeld4R1VSTEd0?=
 =?utf-8?B?Z2hZblJrZlN2ajU4T2pYTXljNnBwTjBCdFJzZ3NjMXNudnU5TzhiTVRxZmVY?=
 =?utf-8?B?QWpnMWVXSDBYdEkzMDdiT1dtclFyMzIzK3FJSVZKeUJVaHFzR05TbWxrd2R5?=
 =?utf-8?B?K09BOThWSDNWZ29ZQTVDWUhzYW9QSGh2MTNGUm40SkppU0N6OVR0bmxpajdU?=
 =?utf-8?B?QktQMXB6TUF6bjBPS3dvRTA4M25FdkMwZXYrcy9JVGdPT29NSWtpdzIyd2dl?=
 =?utf-8?B?K3pOUmFpQUI2dWtQTDRzM2drcnJtZmVmeW8waGtnV25Ub2NtSUtWQUJ4d3kw?=
 =?utf-8?B?ajhHVGdYb1NLazlwM24zQUtyb1NzMjAwTkpqakZzdW5ScW5KejNuczVDeE5N?=
 =?utf-8?B?emlvSFVSdHBFTGV5cGNUdlBMNlJ2QVNDNjJvOEdWZFR2WDFGOFRNRVdnUmxw?=
 =?utf-8?B?TU1lWDlIK1Q0VE1BSytmVG9MM3VSYm9RdkpsaitVR3NRYU5RdkpvVTBSQkg1?=
 =?utf-8?B?RjhGS200Wi9FeGkvbElwdWpmZFpwTFpVcTYrY2dtYWdBc0N2dE5tS3VaQklD?=
 =?utf-8?B?cWQ5VnJ6Y3JaMDdGejV3V3AybXBhbkc0Um5abHFpaXhnTjJYYVhqSlhldkhz?=
 =?utf-8?B?aHgyR0VvNndJQzAvZ1BCQkR3TkZpbHBRNm1IeE52NmIyQ1V6VWk0dXdhZEV4?=
 =?utf-8?B?b3pUZmV5OUpscVZvaGtvTWN0QkhnMHFGODU0akRRMGhUZDYrTVdZYVdBM3Uw?=
 =?utf-8?Q?5q9M4FXKikByjRCp2QLxpRc=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2200be-2dbf-4498-11ba-08da7af9ab20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 17:56:36.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTSFKo/FIoiyZlf+LyPp71MwIf18n0/4t6Bz7AolMonVDmn6SePLhOhe9GXFNX47iRF3l3I/xPKWwnm64cwZlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2649
X-Proofpoint-ORIG-GUID: KvFIvPlL0_p3JL63kOeeg0vVgKOoEAj6
X-Proofpoint-GUID: KvFIvPlL0_p3JL63kOeeg0vVgKOoEAj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/1/22 6:44 PM, Alexei Starovoitov wrote:   
> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
>>       if (__is_pointer_value(false, reg)) {
>> +        if (__is_iter_end(reg) && val == 0) {
>> +            __mark_reg_const_zero(reg);
>> +            switch (opcode) {
>> +            case BPF_JEQ:
>> +                return 1;
>> +            case BPF_JNE:
>> +                return 0;
>> +            default:
>> +                return -1;
>> +            }
>> +        }
> 
> as discussed the verifying the loop twice is not safe.
> This needs more advanced verifier hacking.
> Maybe let's postpone rbtree iters for now and resolve all the rest?
> Or do iters with a callback, since that's more or less a clear path fwd?
> 
Yep, I will drop and move to callback-based approach for now. As we discussed
over VC, getting open-coded iteration right will take a long time and hold up
the rest of the patchset.
