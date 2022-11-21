Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A0632AF7
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 18:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKUR33 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 12:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKUR32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 12:29:28 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293088F85
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 09:29:27 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2ALCqTic005966;
        Mon, 21 Nov 2022 09:29:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=13zCBk2Voq6tx8TaZ9gJM3pGRmHmgkP4gn3qpXBkRUw=;
 b=bsSLcnWUVJHY99+8/6TX46orJB6SJP2kFoadG/mDRHoST2guf3vVtsdia49dowa+TNMH
 fMaa3HuL9Paknq1IArajunnhKCjRacM9600fxbGpUSYjdfyd8RVaPWD+MpVoh0iB5eB7
 YvpmHsRdUSz3Ax/PWMJEWoUoMAwQrNQ5KxkNUpXueqoD6yc0pLtdylHLnBMHLK6HTAcC
 0YifcG6oL5fjXPnVBS2pecgEiPSP7I7zozlKOzNZD1VfUZZFtnngrQRGUGU5sbhdudq/
 qjPhWQMCCESjZkYql5pZdoOXqp+caoGDCV7HyPJ8lg5VDxGgkLZ5eq7vpBzWesC7kcCS Zg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kxuq0f1pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 09:29:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWQwlK4YaqEwuRa/xWuTNM1LnAGEaPAb/LB1qsxOH9IokAn4/8g+KKDoT4Zw61EybsS3M1kWcajCcHa2zN2LsP1HnXe5pUdCjQJhNamlYQuijhjJRVNQTpb+wVoSIY6uUY2Y3J6v8qCAeok2pCM5By/ztOztc1UHB8ZCSNV3SCZZd5gy/yrgBa3Nf25y2nhJyLHYJAYj0EnPj5iWBoJnDclATTzwFHaFCrBraZtYByI1mXDUUOEEJ8sb+5OXMvrirNQh8+kc47qEqkx86Dx4hJdeKa2Nw5woYe/AzP2A7IO+Siv/pNpsSFokqYFZroinfOD8KtxKCSPTm9i85C3Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13zCBk2Voq6tx8TaZ9gJM3pGRmHmgkP4gn3qpXBkRUw=;
 b=B9M1aUvX/beFIt/8RIMYI0NM88P4s4N1HjtTTqWJkUua5QeHn6bA0jBr33rtTLtie0UqsDo3eubJ1tx1PdWelYwtjgP9BxsZleFOBcceXotII0yPv8wmYQJnIHElC9Yz7QgQEDDjDYdPf3zXqtiQdLQJxtBwxoF6hj0gDfXxMEBVaczi39d/+bDDwrcq+FmyCO2BpA/rOStBxelaFxORIK5CIA2tDXPLAxfwNWp3jnA76S1HCZW7OYlWtc69R9Mv36Ot5KGgOcASZ9y2wWXeKCHOLLgRTkvdNrFzfyGG7BKpX833nLQnagEI/aC7qtWkezyIw7oh3UZiq32YWpCqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1175.namprd15.prod.outlook.com (2603:10b6:903:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 17:29:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 17:29:09 +0000
Message-ID: <2c4f8cac-6935-2c72-cc1b-34a34708e127@meta.com>
Date:   Mon, 21 Nov 2022 09:29:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Implement two type cast kfuncs
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221120195421.3112414-1-yhs@fb.com>
 <637ade2851bc6_99c62086@john.notmuch>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <637ade2851bc6_99c62086@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY4PR15MB1175:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bb3e40-ae9b-4d47-70ca-08dacbe5e60a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sdw1Od61/KTuF3eUUlZmO4JUwZaqrVAgeyf53hACz37bS/bdeo7NxegJkPYwEeR5znZIPVvH2JO5JwzQa0Sf6fuMDtGvcTihc8d6q0crxVphKdgKdwbsMQbDOBzUC5wIYMS2mgWDfXkFIMRKBY5JhjGRpQD+Gmc/JmtmJd54nbMhzvrBMFo3g5fLBuS48kqmAn6I0uxQeWn096hXDjOZ4G0Bq3ZlSQRGIMDsVRVr4MD5dYgpUuR9crLXq6LpLL36U5+P7Mjc7j0LDcFut2D6ur28V/98QjPrIP9N7NRykWXopsNaso5P22AGVXDWhea2aM8T9KGM2SzEItBgFeezYTeNVhFZbdnN0TRYRCVBVQYRjizDvyPiyzV20HcZDN1x8hzYDyOYuPDqogoGbWUyrIyovbpW0UZfwVu46gOZ7m78SXAXp8dJ/MLqpH33UFNcjLvky7/DLBQL3+DZS8CB2K6y97NSPVU6wcN75zcdtr7TG40MQSViwH3KFtvSZcffDvNRoyuI3+tCXIA7nx2DQC8hLgKT9pdycQTmO/cafAvGhvW/OSynPxGDn+Tz295DIgZnZ1BuowzJtf1lOX5likir0hNMszU436mOa7vbsJPZkIfVufu3m/QOp3YLzdR1UCbqvUBSaHFnKB42g+QmNMnm3e4thoYQssGhq0yuZdA9eTWy8C8ZcPwJI7omO0RbnF0LGz9ut/OfkKd8+Dmr32JxvbwbiOUpr7PgO95ArIfAsshQeT7vuF/uM5pPTNSmOQsiTqn6K9rABTUxVLA1TfzLiO2f8a2qUUhmxktWW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(31686004)(2906002)(8936002)(5660300002)(66899015)(66476007)(66946007)(8676002)(66556008)(41300700001)(54906003)(316002)(110136005)(478600001)(38100700002)(36756003)(966005)(4326008)(6486002)(31696002)(6512007)(6506007)(86362001)(53546011)(186003)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnl1bTJKQ3NSSkpUdzNlNHN0aXU0MS8rYXZCUThpTllyY0FrRkdwRzRkZGpy?=
 =?utf-8?B?Zi9lb01yWG5TcGZLS1k4dHFlaXIvZWp5UVBoOC9Wdk5oZ1VXVy9lQW5hUHpx?=
 =?utf-8?B?dUJZa3ZlT0Rnc0lDSzRxWjJKVUNSUEl0WGpML2NUMENzOFpqVjBGQnpTenZk?=
 =?utf-8?B?N1AzVlBYdUNnYTZ6K0ZnK2ZEYnM0ODk0eG1XR1p4R0NTODZkdHhKS3RqS2pW?=
 =?utf-8?B?Z0VnRFYxMVlzb2RzQ3QyWkcwZ0xwTHdxVHdvT1BGbXdyb0xQdWloZXBFUnN0?=
 =?utf-8?B?bjQ0RDRzRDVKK3FCQmZOOWV5ME9BbHlyZXRKNVRldnlrdE1hVzdOQXpKekRM?=
 =?utf-8?B?UDFIaVhEZExWNk9VdThVMFZ1cVJWWXJDazg4dnp5bFNkZ1hFZDV0WkF6a1V3?=
 =?utf-8?B?RHNZY3lucnNrWndiQUpXdE01S1ppQWNVWmxkVzdCZyt3ZHJhVUN0YTIrV3ZW?=
 =?utf-8?B?THZvZnZNK1VjaUozK1B1WjlFWm54dDFUMHgzQ3phcHNZTFVxdFVZdFJhcmx0?=
 =?utf-8?B?NW5oUUdwVFdlTUM3bDdPbm52eTJ5MkMxaThrbEY1aW1GMzBHdGE3SmlNOVJL?=
 =?utf-8?B?ZWFnSE8rODMzQlQzSlNOTW5wdVVVaUxCVndIbEJSSzVCdk9xSWhEZkZiV0xU?=
 =?utf-8?B?Y3Nva011WHhiVkVtUjFxNHY5SVU2MC9RNHp4U1c5TEtydEl5U0FwdEZ3QjJG?=
 =?utf-8?B?TzNnUHBGQXhPSHdaVkE1NUJOT09KQ1pGZzVJUHM5c2FKd3V5QWMzUTFicnJq?=
 =?utf-8?B?cFovQnY0b3cxRGx0YXEvV0ZCU3g3MW1hODdobTZBK1pEa1NFSkpDSFV1eXlJ?=
 =?utf-8?B?dmtselBzS2xFR2l5cjNlbG5aeFFlTzIxd04rTTFiTmszY3V2NWFpK01vTFFS?=
 =?utf-8?B?aFJSY0RPZStqMDFxZmljeGxBaVBwSDlEQ2duUUhCcUVuenN1MThZNVlGR01B?=
 =?utf-8?B?QWp3TUtGL0lUU2lVS3p5djI5RFlVQURJa2l6SFRSRXEwQjZHUVFXdHlKU0Vh?=
 =?utf-8?B?dENucjdUaDFyNVY4YTQ3NzE2L01lR285WnVGMkd4b09kWm9CYzF4RXc3dHhy?=
 =?utf-8?B?L3dicktQQUVwZjFPT2N4UllmOTVEMzN1L2l6TEQ5ekZjMm10NFd3T3NMRUVk?=
 =?utf-8?B?bEZSSmgvYWNxcFBwd1YrSmdGOXBtU0JMQWZlYXRoTll5NHYxNXdiWU1KWXZ2?=
 =?utf-8?B?T3JGUTVpeFh5c3JPazNFaXNlQ1FXczBuUjVRdVkxeGRGRTBWNU1OQkc4SFFq?=
 =?utf-8?B?aWUxYmwzT2x6ZWNOT1grVzBaZ0dhcktmdVdGM3JlSU1sem4yTDA4dUZ5akJK?=
 =?utf-8?B?RDNFbjIzNitzUFFxTzVJUk1OZVc0SVpLT3k4MFNSUi9sZm80a3dYTXg1dlE1?=
 =?utf-8?B?RjhnUGY1WTdhZWptU2JOL1ZGYnI3Q1pvdVpYcHJITE5jemJoSU9YYnBOWlR5?=
 =?utf-8?B?K3FXNTlsUDlxUExUd3NrUFdIc1k1TVJPdWRlQmtsYkRTbzJmcTZ5L0NXSGZw?=
 =?utf-8?B?enZ0aitrQ1hDajh4WHhYa2hkVEp5bGJqdTVwNVd6ZGZGYWxISDcycG1mVEp5?=
 =?utf-8?B?bDRYYjE0MVVlekFKTTF4U1FJUlhuTjdJc0NrQ2FKTitrU1ZrWkszTGVMdGFY?=
 =?utf-8?B?Vm56WjBpWFE0ZXRCY3dvMmNIN1dGcGZVUDYzYkNSdzNWc1BKNFJQcDA3QmVs?=
 =?utf-8?B?eGVPODZQUE1SRGZmbFdXUUltblJlaXBndjI0RG9razA3aW5HVFZyWUJQRyto?=
 =?utf-8?B?VFovc0p6UEZKVDJaOU5WbkhaZmpXcWJYUHdNSjVZcWM5dVVpclpyK3k4UDJM?=
 =?utf-8?B?SWduWXhYb3hmN0RXWHloMmpIRTlsMSswWjdzaFlhb05TaVMvZ1d3a3RNbU9F?=
 =?utf-8?B?dlg1b3EyVGdaTEk5dHlTYTl0M2pOcHV5cGVaRWplcFVZMkZpOHF3UDd3dHJU?=
 =?utf-8?B?Q2tqSmpUdXUzVG41d2VPVmZSdFFKejlqSll4S1RGeG5UMW1xeEhRY2sxWU1U?=
 =?utf-8?B?cWE0ODZyeGhheGdlckFyM2w2ZTdHK2FKS0pMQ2tPaHpKbXRmWHRrbjhzbFlj?=
 =?utf-8?B?S3pUenQyenlmY3ZCSVVsZTJhSmsrTHo2dkdnbXdHcWZ3ZFdWLzE5cGZsRDN6?=
 =?utf-8?B?K08wZXJRSjRFTm10UUtrSG04VFhBNlNXaVFMNC9Edkt0QmdBdGdwbUY2bzMx?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bb3e40-ae9b-4d47-70ca-08dacbe5e60a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:29:09.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEO35+r1S9RNqMPyD/yZHQLMNckWY5TFPd/a3ZMxfebfsmp8536FwyNvARgwajKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1175
X-Proofpoint-ORIG-GUID: 7g06qTz1mHRB6P6DcVCPckT9iCNpE1Hs
X-Proofpoint-GUID: 7g06qTz1mHRB6P6DcVCPckT9iCNpE1Hs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_15,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/22 6:10 PM, John Fastabend wrote:
> Yonghong Song wrote:
>> Currenty, a non-tracing bpf program typically has a single 'context' argument
>> with predefined uapi struct type. Following these uapi struct, user is able
>> to access other fields defined in uapi header. Inside the kernel, the
>> user-seen 'context' argument is replaced with 'kernel context' (or 'kctx'
>> in short) which can access more information than what uapi header provides.
>> To access other info not in uapi header, people typically do two things:
>>    (1). extend uapi to access more fields rooted from 'context'.
>>    (2). use bpf_probe_read_kernl() helper to read particular field based on
>>      kctx.
>> Using (1) needs uapi change and using (2) makes code more complex since
>> direct memory access is not allowed.
>>
>> There are already a few instances trying to access more information from
>> kctx:
>>    . trying to access some fields from perf_event kctx ([1]).
>>    . trying to access some fields from xdp kctx ([2]).
>>
>> This patch set tried to allow direct memory access for kctx fields
>> by introducing bpf_cast_to_kern_ctx() kfunc.
>>
>> Martin mentioned a use case like type casting below:
>>    #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
>> basically a 'unsigned char *" casted to 'struct skb_shared_info *'. This patch
>> set tries to support such a use case as well with bpf_rdonly_cast().
>>
>> For the patch series, Patch 1 added support for a kfunc available to all
>> prog types. Patch 2 added bpf_cast_to_kern_ctx() kfunc. Patch 3 added
>> bpf_rdonly_cast() kfunc. Patch 4 added a few positive and negative tests.
>>
>>    [1] https://lore.kernel.org/bpf/ad15b398-9069-4a0e-48cb-4bb651ec3088@meta.com/
>>    [2] https://lore.kernel.org/bpf/20221109215242.1279993-1-john.fastabend@gmail.com/
>>
>> Changelog:
>>    v3 -> v4:
>>      - remove unnecessary bpf_ctx_convert.t error checking
>>      - add and use meta.ret_btf_id instead of meta.arg_constant.value for
>>        bpf_cast_to_kern_ctx().
>>      - add PTR_TRUSTED to the return PTR_TO_BTF_ID type for bpf_cast_to_kern_ctx().
>>    v2 -> v3:
>>      - rebase on top of bpf-next (for merging conflicts)
>>      - add the selftest to s390x deny list
>>    rfcv1 -> v2:
>>      - break original one kfunc into two.
>>      - add missing error checks and error logs.
>>      - adapt to the new conventions in
>>        https://lore.kernel.org/all/20221118015614.2013203-1-memxor@gmail.com/
>>        for example, with __ign and __k suffix.
>>      - added support in fixup_kfunc_call() to replace kfunc calls with a single mov.
>>
>> Yonghong Song (4):
>>    bpf: Add support for kfunc set with common btf_ids
>>    bpf: Add a kfunc to type cast from bpf uapi ctx to kernel ctx
>>    bpf: Add a kfunc for generic type cast
>>    bpf: Add type cast unit tests
> 
> Thanks Yonghong! Ack for the series for me, but looks like Alexei is
> quick.
> 
>  From myside this allows us to pull in the dev info and from that get
> netns so fixes a gap we had to split into a kprobe + xdp.
> 
> If we can get a pointer to the recv queue then with a few reads we
> get the hash, vlan, etc. (see timestapm thread)

Thanks, John. Glad to see it is useful.

> 
> And then last bit is if we can get a ptr to the net ns list, plus

Unfortunately, currently vmlinux btf does not have non-percpu global
variables, so net_namespace_list is not available to bpf programs.
But I think we could do the following with a little bit user space
initial involvement as a workaround.

In bpf program, we could have global variable
   __u64 net_namespace_list;
and user space can lookup /proc/kallsyms for net_namespace_list
and assign it to bpf program 'net_namespace_list' before prog load.

After that, you could implement an in-bpf-prog iterator with bounded
loop to ensure eventual ending. You can use
   struct list_head *lh = bpf_rdonly_cast(net_namespace_list, 
struct_list_head_btf_id)
cast to struct list_head pointer. From there you can tracing down
the list with needed bpf_rdonly_cast() for casting to element type.

> the rcu patch we can build the net ns iterator directly in BPF

I just posted rcu patch 
https://lore.kernel.org/bpf/20221121170515.1193967-1-yhs@fb.com/
Please help take a look whether it can serve your need.

> which seems stronger than an iterator IMO because we can kick it
> off on events anywhere in the kernel. Or based on event kick of
> some specific iterator e.g. walk net_devs in netns X with SR-IOV
> interfaces). Ideally we would also wire it up to timers so we
> can call it every N seconds without any user space intervention.
> Eventually, its nice if the user space can crash, restart, and
> so on without impacting the logic in kernel.
> 
> Thanks again.
