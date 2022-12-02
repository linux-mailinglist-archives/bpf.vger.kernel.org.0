Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75C63FEB8
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 04:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiLBDWT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 22:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiLBDWQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 22:22:16 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DBAD78FA
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 19:22:14 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B21wZkh028468;
        Thu, 1 Dec 2022 19:22:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=gRCnRjogyXxoxJzSZDUHnN48mHsbL2NcQOuRle+T9s8=;
 b=EJttOGm8Fn5esRj2NIHntoLqJ5k/Ei6wghFSz79CQ5YZXYt55xkVv8r9krG095i1X2i7
 JLp4tG3BAGfmUutE3Thkt8sJw2kSspWB2XTlgFZjkPmwAmRViahP+VeISc/qeuO5Q8z8
 uMZETY0msBk36bNwR3Frd9b5XvVTCC2U2I9m1+v2wmthCLHfYAmQKQE01xbc5YIOJ0V9
 Xu/eNpdcB84GN5onG22b9yn9FO1liGBFZgDh2SvQkTpIGCBApQkO3EKr5Jn4+PwzOzW1
 WkNdVrqsijfqKFhkgE7nQp489kwNYETu02rhoYeePFgJmFrZvXpd6Ezij2eerS3VGSmV 2A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m6mbejenn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 19:22:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYkWo0X7XW2twDkRYxLnOC2Hp3DWKc7XvIOwjsyQTS6bfqT7iF7+PBzpwvHNe1fEpGksOTO/pPm99OcjP9/7sKMiNpUnO15wEYxRMEcxzF+1vFnlv2FPL7xI0vYJN3QFRyHj9sFfN99QSV9+WkvoxpYNNXCmjhp2mZocxZKER/jwPied868zMIDywJFpdhBfYlPiFiGPxn+d65MxSs4JN2xv0d1FpLCG6TkPDxvjD+Wt6gGT2964CTc/QAFBV9Q7Raw7/5+//f7k6vmzORS0FDg/NeZk73zrBSsW8TQ+vUDDGDL1WEy/6VKIuQEq3ZkVPetU3tUG5G2pSaev+e+SMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRCnRjogyXxoxJzSZDUHnN48mHsbL2NcQOuRle+T9s8=;
 b=fWNs8kTqV62AdGv3twHEBnd1feAy5PUYUw1OWp13nMMc1RSFZYqW7w3Z2uJL81kiY48HF1GDzZDRa2+XjnAagtbZU6U3iCEj5oSh2mAlBAEkO4C2V48tTRogutgckSxgSrht259nOrC+cg/XbuAivlDNHWzNHc2fQkOKa5NHHamYLjpRpn9mwVdF8PiIxUjmfMhmiQCA0uqBM4trw5V3oOW5YpAA0ZoKf0ZLLlx6vIP6BsTA6wCBf73aEhkX7owbmKYOw25nKcuwdR9JuuXdt90lTaZkqMpY1cJO2ol28lzwnUZsXJkVzdzaXzFlCpLHUmxi26H4XdT73tilMPi6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3470.namprd15.prod.outlook.com (2603:10b6:208:a5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 03:21:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 03:21:56 +0000
Message-ID: <2a535814-1448-151c-387d-38ee75ebcd7a@meta.com>
Date:   Thu, 1 Dec 2022 19:21:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Validate multiple ref
 release_on_unlock logic
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20221201183406.1203621-1-davemarchevsky@fb.com>
 <20221201183406.1203621-2-davemarchevsky@fb.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221201183406.1203621-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:a03:60::49) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3470:EE_
X-MS-Office365-Filtering-Correlation-Id: 68177f13-21b7-4b7d-0dbf-08dad4145d80
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7DrwgI3hHBObW31JlD2adjmVYJuU1XPTJlZS051S9Ql9iHqvHgAVLXFXIWtz1bmQ2GiLLVZ+I1fYaxw8mMAYA8mkhFd3/ZIP6wBmFpDzm3BKMdh+BnXamsDo6nWiMnt5h1BLz3bq7EiXcX+mez7dwYkezZ+E5uY+JQil/Ksg4juJgRqvZp1uZTHrTq/6fbpj+niVtcve0S+1Q1E5QgtoFamxYOefaUZhZPzZiZHHf5W8BJpMqmBh+kvvw/6mlZC3NFS6gBn55bgKVP/AVJIDfXueLjTT9rmon0eXB318BCQGL2XHJk36RwWq+h7Sc5rw1x7obr93RKPoXodnBxPuIZCSR6soDEiw5z7GFZ5+DqpWFEHK4KYlryKL447dKyQ4il9uUIvwFM6eObW/7wUKfhXWvimGme0pZ3k42gCYBYbmYzBJhzos2729suA1eg7CGX26MTC5E/oSNxWX5ry/PFukhI2dG65spt12tWic1aaUUveMPupHxPGXP5YnK2llcXz2ylxpL9mim5uNxM0ETYTUtYrJ18KyJoRq4gVT13BOR39GLg0PDtrqyPYiN2KVMfk/PmXSscyvijMZTuceQkHjHgP4GAXXyE313lihUSACv3S9cWz0aFqD/UErNWgqHWYzgcaZ8bPvwftKl58Pb9VBJz3rPLrKQFG0u8WLW/rN9dxDY/VmWvRSf3KxtrsDm3R6P4bKgx/CIvNnl8493XeleiUNv3+fLas/Y/41D8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(66556008)(54906003)(4744005)(2616005)(6666004)(66476007)(83380400001)(38100700002)(6506007)(4326008)(36756003)(41300700001)(2906002)(66946007)(6512007)(53546011)(86362001)(316002)(8676002)(31686004)(186003)(8936002)(6486002)(5660300002)(478600001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05MNHpzR3JlTDF2YWduYUZxTDdXVkFxanA4SjY0Z0N0WkRIMXM1WE1rSm9R?=
 =?utf-8?B?UEQ4Tm1GQmR5T2ZlamM3NE8xZ3JYaDQ4b2xZeHUzSE5PdzY1SUNobDBSWXZK?=
 =?utf-8?B?OVlES2lWaElmTk9seVoySnF5dXpnY0grT3dwQkNYamJGM21XcnpOdEhYZE5L?=
 =?utf-8?B?WXdKLzdybmpnVnVINzhzV2s3aTRTSksxekRndzFlODVzMGNDd1V6NlM2b0V2?=
 =?utf-8?B?SG12QUlHM0FNMjJhQk5DczA0RXJ1VGFuMjEwaW1IUWYyUG5jN3pPekdlWWtt?=
 =?utf-8?B?dlNSY2VxaDdrM0RwejMyYjdJQm1mdnJRQ0FkT3B3MllVRURGZDM1SVJZenhE?=
 =?utf-8?B?TjgxbzloUTEzTENlNGxYSnZhTkcyQjRRenFFS1RPZjIycEd2Rko1aVVqYkpp?=
 =?utf-8?B?Yno5OXhMT1BwbGlQVFJBL1czYXVTMzFaelRLZUJpOUhoeEZjUnd1bzYralNk?=
 =?utf-8?B?VTI5SDFRZzRwVjc5RTNCb05NbmVqS3QxQ3NPUCtxdFRFNmJaV1hUUUtSc1RG?=
 =?utf-8?B?VzQ5SEhlN05QSHcwSmRETXoycFlFdW1wKzRQYkt6SGZ5L3ZWNm1ybzRwek9u?=
 =?utf-8?B?endyVll2ZmFjZUQ1bTV5ZWlDU0l4MVFpZTNDbWljV3QvT1dJYkVRZWR2dXBm?=
 =?utf-8?B?ZEdxMlFRbStVdlN4OERsNjhhekZ0WlY4SXg2cTVrY05VdTFZYUVNT3MxanJX?=
 =?utf-8?B?S1hUN051aDJQSVZTNFJzVkwvYU54MEk1NnRRbGJNN3pZeXVVQTRKWHhUNVRn?=
 =?utf-8?B?NVJ0TG1YOElqZlYrZzEwd2dyNml6bkRJQmR0SThVVHdTcDl2YTEwaVN0S2tR?=
 =?utf-8?B?NTFaZDVMQ0Z2MTFVbENGeldYNTZ0OXUvS2duTWo4ODQ0L2hLMzlvaXFpL0VG?=
 =?utf-8?B?SUhpTldHMHFCQTB4bFRGQS9YV2l6VWl2bzl5VkdQMHBUVVd2Z2t5UU1pVytP?=
 =?utf-8?B?dDhDSmIzMC94NzBaaUI2bWJ5YUt1RzQ3MGZBd3JiMzFNVEcyTFlGVkJ0Yjda?=
 =?utf-8?B?QUpRVU5XcHpBMVpjS0szSjcrek5udWJnS0tEUHlGM0xXYUgrR0ZFcXNRRnNZ?=
 =?utf-8?B?NHpad1R3RnVyUDhkMHVONWFaKytjV0J2WkxNWmtKNGliSEFLSUpyK2wrQUo1?=
 =?utf-8?B?WUlib3I2aE8vWTJ0QXREaGdCTjgzQlpmQ3gvN1dDUEg0Vmt2aFB5RnV3SGcr?=
 =?utf-8?B?aDQ1MFM2ZVBDTkdtSVJKL2RVQURNRjdDTVN2ZDJWenNxU212c2ZKQUwvc1oz?=
 =?utf-8?B?QWI0VmxuWGJQZmZHWmdZd1NxRGZIdXFWQy9TcXRXZHhvY3lMbGNMK2NUcS92?=
 =?utf-8?B?bndIaHBaTlIvZGRrNzI1c0xKMUNwRG5xV3FSQlplOFBCR0R3Y2VOVW9hL3NV?=
 =?utf-8?B?ZkJaaGc5bEEvN1lrSTdPbmJCbEtFNmFtYmo4YzhZQ1dnOU42N2tkOC9MK3VS?=
 =?utf-8?B?cXRQcXcrekhJVktPZlFRMHRlazB5VGpqVER1NWIwY3VKNzVRcmJUejc5MXQr?=
 =?utf-8?B?NUVXT2x2djBkODZGUUZhWTJnRTd5Wjhib29ja3lXYWJGWXpQQ0VvT2l0Ris1?=
 =?utf-8?B?ZzAyb1BNUE5ia0l4SFkyWnJRQWZMekhUNGg2alZXWDdRenJvQXRwakIzRnlJ?=
 =?utf-8?B?UUtIMjRHUzhxWVhyQUs5b3FvVW5qcG1xTUl4emsyTlg4aGVQOWVSWllCUG1i?=
 =?utf-8?B?ZnUveXNybFg4VEtqS0RLTzF5U2g3TDZSeTJVR2NLeEdyZHhUWW9jN2ZrenN4?=
 =?utf-8?B?K0tjSDZxZis0a3M3RDVZZHpDbTFDTEZUNmtmc0FHOCtQWFR5Qml5S0lwK05a?=
 =?utf-8?B?VFlmd210Y0wyeUdJS2ZQY3VEUEZqUENObE1vZkpUSjhCaHlpYXlFbW1leTZF?=
 =?utf-8?B?bVdSSVA1SXJIb0FnZjhpcTJTSmZvdkw5SVdjTzFvSU9UL3cxZHFrSlVJVXJw?=
 =?utf-8?B?YVFXYjkvQzdURVNyR2M2Tjl0eWZnWlFURGdsOVBnN3hxbTd0dHBIblFtVVAw?=
 =?utf-8?B?dlRraUJPSGlrZHJVbzg0a1lJWDJyZTNyQlhpK0JzQUdad0c3NW8xY3c4dTlX?=
 =?utf-8?B?czM3MU5FODhCWFVGbUFhRGZCUGdFazdoY2MvQnl4WjJTZUR3Tlo5Ylh2bmZM?=
 =?utf-8?B?YWxJNThLYzVJUXFINHcxZExwT2FqRmp2LzBnUGxBOHBoWWVHQ1pEaVhwNito?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68177f13-21b7-4b7d-0dbf-08dad4145d80
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 03:21:56.1172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzR7FRzLTD6OelYkBCe4TLrRxF12bUWYWJx3uIkS4NJtBcDzoiNkkJ3X9jlLq6RE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3470
X-Proofpoint-ORIG-GUID: OvepUqX2JPPEQPHQ0Xy7LZlyqBxQ4MxQ
X-Proofpoint-GUID: OvepUqX2JPPEQPHQ0Xy7LZlyqBxQ4MxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/1/22 10:34 AM, Dave Marchevsky wrote:
> Modify list_push_pop_multiple to alloc and insert nodes 2-at-a-time.
> Without the previous patch's fix, this block of code:
> 
>    bpf_spin_lock(lock);
>    bpf_list_push_front(head, &f[i]->node);
>    bpf_list_push_front(head, &f[i + 1]->node);
>    bpf_spin_unlock(lock);
> 
> would fail check_reference_leak check as release_on_unlock logic would miss
> a ref that should've been released.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
