Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255125BF613
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 08:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIUGLe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 02:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUGLd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 02:11:33 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F727F0AE
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 23:11:29 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KL3FZ2014507;
        Tue, 20 Sep 2022 23:11:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bS6nXET60+ISQFf8iZOFfhiCEdESd7RyHmCr4Xc30GQ=;
 b=C04eqpnT7VwRKayfC4z1Qe3Im1LN51AyNDgOSpGrb6tO+fc5e6X/gQDgIhh2U0ang4aF
 ihcm5Jlsci0dR9MTGoyQq2knMQyq0hqrKSZ+vVLGaP3yCu2FiVhKtu+SPva0L/04e2nd
 DlY9TMgBPQefNu+Y5AKlig/24MQBWhMoKhY= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpyt7u0ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 23:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcG2eXE1ow19pxaCRdGgP199bfCYzlSsKgLUZntElTH4BTxO9fQWs+ASsfnLPNOh+bRYpdabYY7mW3/dL0CsoNBrFvbm67UoAQI4mW/72wyCcYTwvb5K1fprzmiVUDKmS5izRTO/ewZOrPZjkPlrqHGP7jyJZVXOvW6z3b2lmnQazrmVypmwiNQZmr9C/aeBWA1zFQFeG6gNL9IO9zPcFLS8tT/ZGfAQHBS6UImY8YlA5lxQDvq+VIn8WcAQ+ehJyMeL2dMsQH5PHjHZLrZx2vad8ksq1l137SOe4T2IIDbtoK1flCDwvhWwKw/ENUQs0HPFKzWibJsCzg81/72WrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS6nXET60+ISQFf8iZOFfhiCEdESd7RyHmCr4Xc30GQ=;
 b=gBF4pcsxcgo3907E4nxZwUbhk9K2+3OOajoABGaX3rUxz83bNDvag0rpBt4M59LdgarOLoPP8J9z8wCYeKzM0ys5FnlsUOpLerpZwladI5OqxyiZxG3WaRFDtb6AOHLo9yV4YIz14JAf6f7saSRhueS0cRJgHOzdwWYquuDTBwmPVbD6AKL1IsVJthWTXascwyMUM5upDUNKsuzIc0maD3Q7SSSnvM9Eya1JHcuB44Myx+B9/5Myi/5Jerj2CeqEo9eYApO5mbfFgCDWxRS/5sdY6pTKlN19CKglDpe7j+FI3u+PL2cn71oL+7MuPHOWMI8wfLYE8ksvnPyUmEdBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3018.namprd15.prod.outlook.com (2603:10b6:5:142::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Wed, 21 Sep
 2022 06:11:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 06:11:07 +0000
Message-ID: <303ca18c-f0d4-a808-c7e8-c75bf2c0b479@fb.com>
Date:   Tue, 20 Sep 2022 23:11:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v7 bpf-next 4/4] selftests/bpf: Add geneve with
 bpf_skb_set_tunnel_opt_dynptr test-case to test_progs
Content-Language: en-US
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
References: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
 <20220911122328.306188-5-shmulik.ladkani@gmail.com>
 <65c2f50f-d7ad-a979-a7ea-2b79b4886d15@fb.com>
 <20220920082254.4672d5e4@blondie>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220920082254.4672d5e4@blondie>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:208:239::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3018:EE_
X-MS-Office365-Filtering-Correlation-Id: 84da345c-5821-4eeb-f0bf-08da9b98123c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ab4YQrs0a8zYgLdviyqPxC05qMADqXRQ068h2DD4tsncdrXHTtHctscw5im1nT2+38pNMzgekXFPfGgD6Da5rUUL8fYTf/i2ykPj4LGAVox0R9IC6OiSBjuWvyYXvnxJWeZR8WAIXsWrWogOjD6+DAZPGt5tgutP0etsCHBDFfEEVxIg1bqLWYLxv9tX4LMA2niqgyu2D6lHOoV0OOnQT7vpG3W20ijLlie8UpMVXl7VbyC72g1ROdZJ8VRjG5xe6/yINeGYy2ZXktW4wzj01wFHO7LTbu8m6+0DRjNSMiy8yVf02nFSVaY5jVj30h5kvdqlL2jEPqVeST2hthwOh1D2f3HmD52XmNWj2RhOL1iMJYzrY2lXjQ91LQs94hSPBBjFGkdHfN9YiFOSOg96IOt7Y+oITrgTDN1ZuFpifwJXIT0CMDx95581E+wVt9V1Igk8QjsieMtr69LrteXtXxGufTRdyAaQc9+yCo/WYCorBoUP7iksdyeRR7Pa+hFtgAshU7K7dc2wevdeTeKbJWlVFuBjceEsnxpJmV6uzM/ViEBARavw4CGYmD7alWSZuWcUQn7cIu3oyPcpmc1ru1NCzAGe+vcPUSf5Abx7woRG2+vwiPLY2e0ol8xXE7LJ0YIIXzz6M108coGs+tRUsOHXS8GlQg51oSLLHG3efMIAkVn2kL0ZEdL8xWxwrWLGjThN/UwCogNzhgc2wSZhubwDx9+bKXe3ODirNLTwSQwfG6sCRjYeJaevmuSv09ppVma1A4rAl2Lj0vay4mtMFe8rp4hgu5CUWEUJmAIDBSP1ieqhFSpaayfAjwGDZLbn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(66476007)(31696002)(86362001)(36756003)(38100700002)(6486002)(5660300002)(478600001)(2906002)(966005)(4326008)(316002)(8676002)(6916009)(8936002)(66946007)(54906003)(186003)(83380400001)(41300700001)(66556008)(6666004)(53546011)(2616005)(6506007)(31686004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRoRUJRVWRoZyt1eGtKTC9OZmEwWTFvTGEvV1RQR1VsUFVmbHRhUE1MeWpq?=
 =?utf-8?B?VlZIQ1Y0NnVyenVPZWVKaTE0ZHJaOG1xMSs1V1dudG5aN0FUT3B6WTM1aWJx?=
 =?utf-8?B?REdwcWgyQVFKeEcwd2NOaG5rM29ubjhkZTl3MnFyMWZHQitZc05DMkg4aWxV?=
 =?utf-8?B?TlAvTjlIVVFlc1FUWFc2Y09GR0RWbnlvam1KcGUvMzBwUmdzc2dBYU92NkND?=
 =?utf-8?B?R2kxK3dQYSt3WHNveVpiaXk4Y0NncmZaNFpTTm1OSjQyMEZLME9rL3pWUTRn?=
 =?utf-8?B?cHZyUUp2YUlMbmx5cklzTmU4cEpPM21CNFlqaE13VDlFV0tRWlVPb2hOUEk3?=
 =?utf-8?B?TVlYMUd2MmJUM1VnY1R3d01QWGZLUU1rUkYxSTZ3MFBHYkxYazBQbGFSVEFh?=
 =?utf-8?B?dkZFVlpyYjlMcHFMbmhBYklwVG5ZN2xOZ2hGQUpNVDJMYWZvV25QOHhoRTRK?=
 =?utf-8?B?OHVoS2xTT3c2TTZ2aTRqT0dPVmdiU285cnByS0M4dUd1L21ScWZQVTJLQlNt?=
 =?utf-8?B?WmJwdXhmSnh5c0E0ekdPcWhYbmJnVTR4S2ZMSW1OaWhGR2RUV21yVEc5UDdV?=
 =?utf-8?B?SjE1aUZ1R1JTREErMEVmaitDY1ZvQklDOFdJTm1FNzZoWUdGbXBLQ3lwZkdD?=
 =?utf-8?B?MU5kaERUM1B6a1VETXFha2xIVDJiUkRkclVPU2l3MDFJQUY1VkRkeXlwL204?=
 =?utf-8?B?WDVmaUQ0QUV3ZURFKzAvSkhwcklWcFhkdy9JbUZBTGt4L2FyQWtJTzBrVVlm?=
 =?utf-8?B?NDlmY2ZhSkNEUXVrVUNaMGx5SjRBZkkzZ0paaC82NmJBMzdZZHl4d2RUNitJ?=
 =?utf-8?B?d1JPSnZ1WDg3TFRoNG9NZ01vWFdiWEJ2MUdoR3ovTUpldVdCSVdqRUo5YkRp?=
 =?utf-8?B?YXJXM0VWSktmd3NZaW1rVEpYUEowM29vTUVBY1ZaczZieWlQNG5SSGhJNDRN?=
 =?utf-8?B?MFdFN054VXVOcjM1RHRqMEFPQVJHRUtZam93ZlIyM2dsS0FSUnpxaHFyeEw1?=
 =?utf-8?B?NWVweHIrbDVpMUQ4TXptQjFxUHBCMFJqZm93dHgza0RUTzhFSTkzNVhzZGJD?=
 =?utf-8?B?OEdGQi90WlhSdVZNaTJ2MHRaSDZWM3hwQ21XUDlXRFRSWEMxNXNmYUZoRDAr?=
 =?utf-8?B?OU1aOUxmYTUwVW1GUXlTOXQ0VW9XVUlNUCtpU1ZLNnN6UmRraHA4bkxZWW1C?=
 =?utf-8?B?citXVnZIMkZqZWtZK0lMSFhKbTJBQjJnaUF3UEFzajQ0ZDFiT3prR3MrUjdh?=
 =?utf-8?B?VmNROXNJUU1tM3lBNEg1dHMyajQxbFY2MWwrMGxnLzMvc3BiTnRmQm1vYm1E?=
 =?utf-8?B?TDFGWWFIdkhvb3BuNGErMVFnaXZIdW1CNExZci9SK0pkV0duWVA0Lys1OUZY?=
 =?utf-8?B?Y0V1L1RCdEpIeFpWbmt3d3NiZ2dBNjFmT1lOeXdhV050VDlUQjBoMmt2UHZK?=
 =?utf-8?B?WURUYng1SGp3dTdFdTEydHRLS0tCTC9HdDIvUG9zc1ZDWFpsZ2JSaG5rMzlU?=
 =?utf-8?B?MC94bUdNdTdHNXcyWTVHTmNicGdmZ3JqN3kvL0p5ZmNwMUtyaTFHbW1LTExZ?=
 =?utf-8?B?emZaQnhMQjJJZ1R6OHVTeGRrV3l1ZFlhalJ0SThXT1pNc1puUm1EMEhvR2Fu?=
 =?utf-8?B?bnFQc0tPYlBTNzhlMHl5dkcwb1d5cmZraDR5Wm5ubURDTXF3cERxUjdRaGs0?=
 =?utf-8?B?c3g5UDdxRmV0eENLUmw1V01TY3poMzEybFNhMXlwWGZvdEhGcGFKRDVzZkxX?=
 =?utf-8?B?Wmx6UllWaHRsejJjckx3alM2QkJwU1FUcGdpS2hGb3JxelQvMExieTBYdld4?=
 =?utf-8?B?YTdIN2xPU01NZ1gwamRXcHd1M3drdVphdW9pSUJDT21HREFEaUkvK0ZNVTI4?=
 =?utf-8?B?c3JaYS9nWnJqUTRFaTZ6K245bGNvMlc1TjhJSXd1TW0xTzF6ZTBBeXErcDJ0?=
 =?utf-8?B?QjZZRDZUWmp4Z3ZUS29QcWYyZXpjN0E0WVh5MDlZZ2JTSnI5UEVnWkdxVWts?=
 =?utf-8?B?ZmgzaGd1bDBQeGVueGhMMkhPMDBzV2YxdlZ0dE5WMnpBQU1tSjc2VHpXWERX?=
 =?utf-8?B?YllHYjZvYlVYamdHVVJHTXowM05ncGgxWjlmUU9lSUVFNXl0SHB6OGRSV2NF?=
 =?utf-8?Q?QGK5KbyXZZAl9cUcJ7b4UXg8+?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84da345c-5821-4eeb-f0bf-08da9b98123c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 06:11:07.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNcPPbddjvE17jfQiAyyunAiYzQ2Pniuq62H1kDu2XyvCzj7CbYcsKHELqo4Zczb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3018
X-Proofpoint-ORIG-GUID: c-XvmD6noon8Dg_oHqTiqMmyI5juJvgi
X-Proofpoint-GUID: c-XvmD6noon8Dg_oHqTiqMmyI5juJvgi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_02,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/19/22 10:22 PM, Shmulik Ladkani wrote:
> On Mon, 19 Sep 2022 19:58:20 -0700 Yonghong Song <yhs@fb.com> wrote:
> 
>>> +	/* set empty geneve options (of runtime length) using a dynptr */
>>> +	__builtin_memset(opts, 0x0, sizeof(*opts));
>>> +	if (*local_ip % 2)
>>> +		bpf_dynptr_from_mem(opts, GENEVE_OPTS_LEN1, 0, &dptr);
>>> +	else
>>> +		bpf_dynptr_from_mem(opts, GENEVE_OPTS_LEN0, 0, &dptr);
>>> +	ret = bpf_skb_set_tunnel_opt_dynptr(skb, &dptr);
>>
>> I think the above example is not good. since it can write as
>> 	if (*local_ip % 2)
>> 		ret = bpf_skb_set_tunnel_opt(skb, opts, GENEVE_OPTS_LEN1);
>> 	else
>> 		ret = bpf_skb_set_tunnel_opt(skb, opts,	GENEVE_OPTS_LEN0);
>>
>> In the commit message of Patch 2, we have
>>
>> ===
>> For example, we have an ebpf program that gets geneve options on
>> incoming packets, stores them into a map (using a key representing
>> the incoming flow), and later needs to assign *same* options to
>> reply packets (belonging to same flow).
>> ===
>>
>> It would be great if you can create a test case for the above
>> use case.
> 
> Yes, but please note dynptr trim/advance API is still WIP:
> 
> https://lore.kernel.org/bpf/CAJnrk1a53F=LLaU+gdmXGcZBBeUR-anALT3iO6pyHKiZpD0cNw@mail.gmail.com/
> 
> However, once we settled on the API for setting variable length tunnel
> options from a *dynptr* (and not from raw buffer+len), we can just
> exercise 'bpf_skb_set_tunnel_opt_dynptr' regardless the original
> usecase (i.e. we can assume dynptrs can be properly mangled).
> 
> In any case, I can later amend the test once all dynptr convenience
> helpers are accepted.

Could you give more details how you could use these additional
dynptr trim/advance APIs in your use case? It would give an
overall picture whether bpf_skb_set_tunnel_opt_dynptr() is
useful or not.

W.r.t. your map use case, you could create a map and populate
needed info (geneve options, lens) in user space, and then
the bpf program tries to get such information from the map
and then call bpf_skb_set_tunnel_opt_dynptr(). Maybe this
could mimic your use case?

> 
> Best,
> Shmulik
