Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D235A38EC72
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhEXPPc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 11:15:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54499 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234546AbhEXPIK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 May 2021 11:08:10 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14OF5a1M003941;
        Mon, 24 May 2021 08:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LaRdz4LlQ8MWphvuljDL+1HeFh4hcqMd91I0zxq+gLI=;
 b=jeZYVa6uQftDJVOPttJF3ScneUvwV6dADW7AOtaHkXeWGy8cDhVM5e2LtadTjDFyzTRe
 xxegoT6DMlNZadzEjEwdIZdgnKVZnmhn0FivRbqfJn0UfQpWscMhwnKvojNfiBjv1Jd3
 Fc5Y+cltTULVAynqpNcqvqGEWQXTgy6Lckk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38qhq4e191-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 May 2021 08:06:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 08:06:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyvRBGZeWDWj4H5Wp/8dVkmGD4JtjrF6QsuiKurMWHgZ9ayf3aDZnAz8+XgovlzX/i7NmQ7H19t7HwzDgiaNE1chHz/3u4Buz9vYMzgOJRg23cJVNKhsqzc9z32FZ4vY2wzmhWypnMXWAjJsHRepugMWmUuQtFoMiDYTiDMgv4fdBLD3oy9cpPJWfr8404aR0UApOeJZ88vgIM45UA1OQImEm6gua0njBdH4zCodpcGFCMMdlHlXMygtwR9Bq7pxtAXnZI2jfhyeKW5xpw3vavnsokwGupEobVk09hM20rzUYVWFmDxfNGI+TcUduQAg9J+e+vci33XfoDucZ9n8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaRdz4LlQ8MWphvuljDL+1HeFh4hcqMd91I0zxq+gLI=;
 b=PtMZ0+KvenYagO5Q5q2BFGADkkjgaom69zDIXpNTgFZpx/TLAkDgm655syJPnVSqCtdKfafo5acxAwec8ZHIZGJ9gRY2utkAPTrD5bYXx0KwH42Yxp1RekTs7aXzN1w724mMz52CraWhDFCrKy8Lmp68PJLrJvovT7X+P7IOzEtTTjesdKeuAC3VV7ckLLMQKCB29Cw2XDKq/HXu4THQb7ajq3rKkwtFpDsjl/Z3a40gv2bATe7MvCqNj/10m//niDkfIsQz671CkblHevLVEnJs/hQ1bIZeEHT2Psdi6dHGa+liBj6/QzddMBT6FtNnl782KOEFGFoYNpR40ShgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4339.namprd15.prod.outlook.com (2603:10b6:806:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 15:06:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 15:06:10 +0000
Subject: Re: [PATCH bpf-next] docs/bpf: add llvm_reloc.rst to explain llvm bpf
 relocations
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <20210522163925.3757287-1-yhs@fb.com>
 <aae741ff-d609-5796-d860-d234884f5ea2@fb.com>
 <CACAyw9-G56AC5D_wqTi6wURk2BFrF-buuLS1S0F-ngDukb9qEQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <14599907-6a2c-d13b-2dcf-11fcf5f83219@fb.com>
Date:   Mon, 24 May 2021 08:06:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <CACAyw9-G56AC5D_wqTi6wURk2BFrF-buuLS1S0F-ngDukb9qEQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ac27]
X-ClientProxiedBy: MWHPR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:300:95::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1160] (2620:10d:c090:400::5:ac27) by MWHPR13CA0033.namprd13.prod.outlook.com (2603:10b6:300:95::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Mon, 24 May 2021 15:06:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 743f4c0f-b6f8-44fe-9a7f-08d91ec5770b
X-MS-TrafficTypeDiagnostic: SA1PR15MB4339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB43391F66623533CF36EC745AD3269@SA1PR15MB4339.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UInx10i2ux3CJ1NHwQKUI34gP1qGje6nYSA/bELeE34bZTsFvlGXqAXiggmiXN14diAfmhICQZW2iOEn2RyqTVUgc18MlAY2v27Lm1PfyHtn5FD9KZqLX/te509ksGwx6u83NKQQQGdy9hErLMKx1CHJLp/d8WLtRh/fdq0KF1x4yqBfhlmfvCM3BIwfFM0+7u7sD14Aupcr8qJr4ByJy577prDOH0lK/4FwojuSsQauiBsTIV5f36vG2EW6l0c6z+2JW/ErmPPnBGxt/qyrNwwIIwAhZhquFiq0TsWSe4pyCas/ubdEzCo3ZywTAgZ7MqaL4OCBmogCLleF7QUpzhR8AIiQMm2GAJPmIcDVLLg9/ql5pWQJmEB4p/La+BmV89b7GWPJG+PBXMFGY4KeFgHBhNpHXdT0oWBo0tG1gQ/Wo78vX9/udW+FFdsaO1EUWR1uIhfP/0sVOXdzM4jS5Owy7xvITHQGgp8abpjqFzoD5NjBlbFAp9v0f8b2uiK4xK+VCjMzkbsl/5Hv83fct1yaGJN4njJ3/NJOmR699VtFBm22iHVpYLSD3Afc8uTq7YYmc7Fs+oJCAUC5/F1rq7FORY5hn5g/7ZurkP99P8QACkGOnq6NZmMVPi7wEJMIvBdKvYQrnbhHVHRMnhfCnbTyPmfSK4LRq/peWF6to9qQl67ftDc0G0Wvw4iw568s5Je1c8zGkVmpBH5OOO/v1QXXfcZYV4/xZwD4AQVex+q2X9c7liR01O+dfMzlKw4kDimXLFBQ6ROE7ulerzfwdGVnfXuhaC7e3EmH7nMPr2w0AFJt0MIGjlxpj5uBY22
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(38100700002)(2616005)(31686004)(83380400001)(8936002)(6916009)(36756003)(8676002)(66476007)(16526019)(966005)(4326008)(53546011)(54906003)(478600001)(86362001)(2906002)(31696002)(5660300002)(52116002)(66946007)(316002)(66556008)(186003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZFNJTlNIVWF3N1NzZkxIR2hETVI0bTdwbXI5OWJiYU0rK2ptcnhGRlMyZDNS?=
 =?utf-8?B?UituUjltZ1BQcWl2M0dacnNxR1loVWZFYkRKVlFETDVJQ1RxKzlKSGNmKzRO?=
 =?utf-8?B?UTZicnhMdVNLcURadFVNc2xndVZ6aUthdE1rUHMvcmlWL2FoRHdsZGhQTkhm?=
 =?utf-8?B?bERYcHhzRHQwTUd1Smg0RWZmVzRuek12QlRjQkFiZCtxNGRsdXNUd3pDa3du?=
 =?utf-8?B?eUhVWGRieGlsa0xGRER5eGFITklqV1liK2FsbTFhZVUvbWpLR0hkcnZreXRr?=
 =?utf-8?B?S2ZrajI1YmVKTzRGOTZUYjhGcFh0dDB5TnZrNTdqOHdKa04yL2M3c1I3alhV?=
 =?utf-8?B?ckIvUlZ5elJIQnBlb1R6bm5Zd1gvbEF3b2dZUFBkZk5tTmZIeGgzdXBVVXhW?=
 =?utf-8?B?RWFYV0FRdEF2QTU3OUpMN1pxS2owd0hLeTRLRTgremRrc01FUU53WmxCaDBr?=
 =?utf-8?B?Um5ic2NSSHdvZ04vanp0aDA2eSswaE82OGV2dGlxdCtoTnRHNHk2RnJtRERV?=
 =?utf-8?B?bHdHSTlRUGZpSitpTThJSGRkRTRFc3QzcFFkZHZ4cG1BR2h4NWxXSEorYWRp?=
 =?utf-8?B?WXJ3OVZkb200cnoxbFNXamx1MDMyU0I1RkM4SVdkbGV4YWczeUV3RVZGa1Rp?=
 =?utf-8?B?L1d5YmZPSC9OWnZMTWo5K1MxTkYyeEFsZ0NpZlVlbTBTTWpkMHJoNXpIdjg3?=
 =?utf-8?B?WmxhZmJXOTBHbyt5bFhwVElhR29scnNtQzQvanFNRlFRblJVVFYwS0xhcU50?=
 =?utf-8?B?ZWVpYVJKSVpIT1lHbXBBUkRCUjhqN0w0UXRtdndJZTIvczdWY3VraUs2ZDVl?=
 =?utf-8?B?WnN1V2ZlUm1xaTJKaWRDNEgvbml1Umt6NlRjb08rR0gvUW9VbmV2RFhmdGYv?=
 =?utf-8?B?QXMxcmN0eG40ajZBU0JmQ2N1MUZnY2FwT0ppejUyOW02OFFwZEo4SlNLOGlO?=
 =?utf-8?B?RElUTy9DSVo1MnpoSzZHai9VMkpWVXNsZFBFTTNFNlF6T3laZHVmM3QrWTFW?=
 =?utf-8?B?MnFkSHFIcjZEblRmTHNZSXhTeGRRcXZzNk5VWHk3VDJxVy9FR24wVHhKK0JK?=
 =?utf-8?B?RnNoeTgwcldtWlNPYmV4VytZd2dVY3VDM0tFYXdOZVVEQnJISmdpUDI1UGtV?=
 =?utf-8?B?K1BtUFp0Mkdjb3cyenFVa3dvOERiT1hxaTBYa1QxVWJ0amoxbG1BcEJLc0tn?=
 =?utf-8?B?c3FnS3FlcldjR2crZEo5YlBNdUZ2MTBjUVp6dHNKdFo4N0NKRnRxd2paWFU5?=
 =?utf-8?B?YkN0Q3BQelNQbHpaV0JsV1hHdDYyMlZtQnRKWTE0SnlSZ05EZ2JXSWVsaDZO?=
 =?utf-8?B?Mk5zV1EwZjlZKzlVVUpYY1dqSHArN2FYbE5lT1kyMjVNNDJ6MFBhK3EzaFlt?=
 =?utf-8?B?c3E1Ry9INzVIRXVESStDNmdOU3VONmJhT2R1UWErdEVDNkRRZ1h6eW1kMytZ?=
 =?utf-8?B?b1BmWk54SWlKOGxFQnBlQko4VmdrdndvQ08wN2JzLzZmaUZEeWZWN2U0UHdY?=
 =?utf-8?B?VjFwcHBjTVhNVHduSWtDR0EwT0hWSUJTYW9FQ2Jta0hQYlZ4WTRHakxSdjVr?=
 =?utf-8?B?Qld2djFnZXRsYUN4R1JnQU5uOVVxYjBYWGNyNXhiVUwvYmdmeXFERUc4Qkw5?=
 =?utf-8?B?RXQyOFNFN3FSQ3liRDFlakhVbDhNbUdIZWZQeFlTdVRBbDVrSnZvOFdVZ1U5?=
 =?utf-8?B?aHYvYmN6NHArVkxJbUQ2TEZQMDlpZlJoRHl2aHRnUGVWem84ZXFudmtIQXZi?=
 =?utf-8?B?RFVkeGZPWTRxeUVHbmtnV04yQllCRm9mQ05pVmhUN2FleCtjQldTb0ZzK0M3?=
 =?utf-8?B?MXpsMnNYVStKVXhFZGNpdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 743f4c0f-b6f8-44fe-9a7f-08d91ec5770b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 15:06:10.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96hjkUONpD7FkSTW3Nivdw7/l4Nmv5GY2yk/li9a3C80QPw5YNjfqUSEs/akPl3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4339
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: l09-hbvj25LrxTNlDCQbESN-O8slo15C
X-Proofpoint-GUID: l09-hbvj25LrxTNlDCQbESN-O8slo15C
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_08:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/24/21 1:33 AM, Lorenz Bauer wrote:
> On Sat, 22 May 2021 at 17:44, Yonghong Song <yhs@fb.com> wrote:
>>
>> Daniel, John and Lorenz,
>>
>> Could you help check how the new relocation scheme
>> may impact you? libbpf has a similar issue and is fixed by
>>     https://lore.kernel.org/bpf/20210522162341.3687617-1-yhs@fb.com/
>> In most cases, you should just change relocation enum number,
>> no relocation resolution is changed.
>>
>> Please let me know. Thanks!
> 
> Thank you for the heads up :) cilium/ebpf currently doesn't look at
> relocation types at all for better or worse. We simply collect
> "well-known" sections like maps, programs, etc. and only process
> relocations for these. So your change won't break cilium/ebpf, but it

Thanks for confirmation. So yes, you should be fine though.

> makes me wonder whether we should check the relocation type.

If the library is used in a control environment, e.g., the object
file is generated by llvm, bpftool linker, etc. You should be fine.
But yes, checking relocation types will make the library more robust.

> 
> Best
> Lorenz
> 
