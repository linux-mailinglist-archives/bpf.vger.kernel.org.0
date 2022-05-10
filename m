Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145175226B9
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 00:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiEJWOn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 18:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiEJWOm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 18:14:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E59289BCF
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:14:41 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24AJEIPE007897;
        Tue, 10 May 2022 15:14:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qTfT1y85t9+s7ZRgxtZYbDOTtvLvINYgoUuPnHUNvyc=;
 b=Nt6ytJOoZsD3ff0h+T8iTk6mNwu4N7/j6Hp1yMO89M/65AJSQEyyzgWtmB/10+4jjEGo
 isqhZdYgHTxOg9heGWpRZGUpestPHZuedr814Y3uGwv1OIFcNump2l0hSnEdoVDa4wMe
 HkfLH99l0KkPkuQn1pROEdAYErRrF4KcRz0= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fyx1h18ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1SWz5FrUEUL+WdqVbH3BmIg4FveES7LCfMbIop9bfGjL+f6mKjRhEox+k4CN+8W5DvkJC/ySxUwYsvm8Yz3VRIRaRnpHnayIQmUB+OkFUnzKO4AkPrZR+D/Cvp2Vw6tOAJqMuwTf8/ztzB/q6+PQeO6Yy47MDmQ+QC/VrypgGgZZbvPjsMtxgqeT1cTBCiOjem3reJ3andhsTmvlhE1nxekUENaPEHFAlti5a6YNJjggvqYg2D2qwUCml+FtQLaWXRWJ0SWG2lr2CieGQ3ezX1fKvcWVqCiRzQmVy057gRrjUXUUJ84f4GaMQf/Xly9rxdgN3l/TV6KrELQ3RGrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTfT1y85t9+s7ZRgxtZYbDOTtvLvINYgoUuPnHUNvyc=;
 b=AKgFyaGfKbpK+C2xEEArECIb6aaFvaLyFvR9toIYO5yf2MIo5+rlfUXPnkEVKI3IPjA2E0nM+15rNZBThhSkK/HtW3bSoBKVw5O+qfbkUXJtPd1P9F1faBFjx2dIe8k4lZbY9gWpujAPpqnp0SeIOjLHMdNBcxWQ6EqdMak7RLr2GaVwJTZOB/G3BJJXpCC3ScNuclnud0h5DRdKfszZCPhf3+9JmeRt5EPxEYIZvAMMQurK9nnBzUhKMqmjTDdoVS4z3h/5/xibwtRcjhAfeweslhNoHYaQx7pMRZC3PmrQHHBsK67ACuuFa2Qx42duhAYcjHxY+SU3dHTQJeicgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4556.namprd15.prod.outlook.com (2603:10b6:303:109::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:14:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 22:14:24 +0000
Message-ID: <7246362c-8eca-027e-d43d-8d4955ad5bdd@fb.com>
Date:   Tue, 10 May 2022 15:14:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 02/12] libbpf: Permit 64bit relocation value
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190012.2577087-1-yhs@fb.com>
 <CAEf4BzYyUUjVYEcDJ75DWyg4HoOm4YbFSy84OY01WgENdWrh8A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYyUUjVYEcDJ75DWyg4HoOm4YbFSy84OY01WgENdWrh8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2036966-b587-4148-a41d-08da32d270df
X-MS-TrafficTypeDiagnostic: MW4PR15MB4556:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB45561ED12E2A465A51EF780DD3C99@MW4PR15MB4556.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HQ9BgC9Xyn7zhqIG4CWbYIPCUJNMwakrI7ZhrKuXeBbvXgkWZnZSR++gtLBTwz1J24A+B3wb56TqtCN+pl4841qwsEF8GZoPaQTaCxUASmfTT5+B1cGItRfJ5C2rLJZ9bVbd4U0BLGX+yVP3USigrnuMv5VrBduZWwZ42j83jMXaJ3QUABx/DUUOFmtvazQoG2g3In+hExVCOwEKuEs6JAY5j+IfqWvrLUJMpUQ+6foZO9+4sW2oynSdAAP7tRpUnwvDbaI+0WsRSrp5rB3T01ZFoNqtN6m8VciiKmS5SpcpwSbXcV//TKM5qq/OuU9iTfgtmB+LjNbMN0fiUt2k4TfpsGnVlgyf4sWRuk54XzOZs5ndd85/cN0wzgpjHVEXKFlEMVulSmJigc2aDjSujvHb3rmOiaGowas74iFXn6NHhRT1YOGOLRurdxFTbQ8Z2l5+WtYfSD+WnkIVVGQZpXzq83oKRV3ILrtZyMWigGAO0nIJdXEi7+OJl1173sbzPd3wLLwjrxgl9M/do81o74rwzwqAn7nD4i0XE8AXZ1Y1Xh/W4YamiWClVvgW4ouzdvLiIKQi9FHDH2w0Ja3muspO5dMYi/acrKXJHllWRnCMBe51DWt7Om0OGEROf0+xr9kTmdZR8Z1oReAHYrVGoT7gANDxIl+SXA4hVSm1TJD3rWfO1CjqHzuQ9pn7vtsU9ai6bg2MKkFBQqF80uFO4JMMLMWZ4ax8mJtciA8Cq/m6yy143zqTCHWQE64CW9T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(316002)(6486002)(53546011)(8936002)(2616005)(8676002)(6916009)(54906003)(4326008)(66476007)(66946007)(66556008)(31686004)(38100700002)(6512007)(508600001)(2906002)(5660300002)(186003)(86362001)(6506007)(52116002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzAyNTBORkdFeVpUaUI5c2FCNUw2WSt5Z1lWbVhmdXg2bGQ2bzlobE5mUGRQ?=
 =?utf-8?B?RGVWYi9CQVliT2ZwMmhndk04ekw4N000eXYzT3djQ2xZSS9hY1FWalhlMllN?=
 =?utf-8?B?VkdzWlpsd2QzamtrMnUrdFYweXh6aHR1OS9jVE9kQS9CQUF5dDlyQzVwcE9V?=
 =?utf-8?B?Nmx5ZU9lellrREl2emNQYkhhTXoyNjBGcVE2a2hyMjZkMk5KZ1Z4TEdlSWMy?=
 =?utf-8?B?Qk9RQjlSbVdhcGZHeDcwV0hiQVllODUrZ2tBdFpzMW01dmlIdTVQWDhVOXNF?=
 =?utf-8?B?MklQeHZmbFB6RVNQS1UvV0tFajFNdGNFVi9ZWHdhbWozTmtiN2tRSVU4d0l2?=
 =?utf-8?B?UTNma1h5eit6UUhqaVNzUnBTbmJ0VVlZUTFPK2RQMmNZUUFKLzJwL2ZFWkpw?=
 =?utf-8?B?U0h0T2QyT2JCTHh1WjRCdVF6S1BLb0hwQUxYTUlralUzTnBmL3FVUlRJQ3I0?=
 =?utf-8?B?UTV4MjVrRHVnemtFU3VQc3NXNjZ0eFFsNUVOTCs1Um9aU2g1QnU5TTFMdmlr?=
 =?utf-8?B?NVlBYk0yaGhVcTVXV3JPNExDSXluRkhXTnRLWEVsNEh6RE1NVnpKOERlbmpV?=
 =?utf-8?B?OG90UTQvNG5hRk1qVi9zNkJqU3prYXFKRnRVaHBrZ1dIK2YzU2RHQVRMUmth?=
 =?utf-8?B?NTFNS28zUUR6R09nS0Fldm1TZEtoeVFmT3U2OTlHVk0vQ0puanNvODdBZjk0?=
 =?utf-8?B?U2x3eUcrKzkvYlhZazZUQXRZVFpjOTZKdkt1NWs0Q3VaNEFxV0RtTzZjOXEx?=
 =?utf-8?B?bG9NQ0dsLytoMzBIY1dmcUZWQWQ3TUJHRnViVTM0em9JQ2ZIWmMvYm5rS0JR?=
 =?utf-8?B?S1FkUzF0U3VVSWg3Y2lENmVTdGdqWk9SKzJRUEo5Y2hRSzNDNW9PTEJPaTJM?=
 =?utf-8?B?bVBzTi8wbGZLYmJaQW9SY2FIbXh4T0RjU1Q0ZENidGdLeTBhNHpUVHNSUFFG?=
 =?utf-8?B?dmtDVGVJdmdseHNCMjFmeDVEUW5GdnpLanYyeEZ5TkZXREwzdzdIT1VkODRm?=
 =?utf-8?B?SFY3Y1RSQ0RrcHFKZ2J1NVNQSmlCLy9BZkM5Mk5QSEdlWWpGM0ZjMW5obGxy?=
 =?utf-8?B?cjNuSmpOZndaYU9vcWtrbnF6M1lRZTJpdWlJRnJOblpEdHpSSmFDY2YrQjhZ?=
 =?utf-8?B?bUlrbEF3SnVqenJpSTNSWFpNSy9RWS9ZY1FjWGN2aCtwVmYrSVRsZXNMNkZn?=
 =?utf-8?B?YlFkeWpxZzZ0M3pkYm13UklyTW9rY0d1WU0rVDQ2SW5rQXhYZDlXQnNEUkR5?=
 =?utf-8?B?bTh0QXMwQklVeFdRMHJ3eVRwRStrOHcxUlpMMERRNFMydzd1eDBETGxnbDZ5?=
 =?utf-8?B?WTBhZGlHWWcrbnJkU3Y5eGlxcnlBbUxZdHJTSElZTUFHWkh0K0F1TWd5SnYr?=
 =?utf-8?B?VkZ0cGEyb0VZdERlUU1mWDFrV1VJd0I0dm04b1A2WlZkY1daY3dkNVlwNUZn?=
 =?utf-8?B?TFJSS09wa3hmdUN0MjRMV1kza3pWUGxQWWdiYytGeW5qRFhTZlBMdmpjY1pv?=
 =?utf-8?B?SW55Ykl2S3FmRU1QZDIyQTVTK29xeVpYS0x2TW9lSUV3Z0xFQiszUUhTazM0?=
 =?utf-8?B?UFlrSnJOU0p6R0VDajg0ZGUrblBTRUZEM1lxbElpRG1TVGZGQ29ta0ZDaUVL?=
 =?utf-8?B?ZkxGSXNRL0RVVlY4UHowZk5TbnJGMEoxS2JSck5KYk9MQTBNWnNvT2lJQkI0?=
 =?utf-8?B?aHZLdUJHeTNQUFVjN1E2OEgvSGJZZVV5YXJuMlQvRGUwM1kybW9QeFJaNlVn?=
 =?utf-8?B?MGQ1ZmMxYVh6Y2NvNkhYNFYwazNwTjd1S21WZ2ZwaGd2eTFuWlNFeXVIcVB2?=
 =?utf-8?B?NUZQVzZ1SjM1TVR2UDgrZEpSSzdtZWdjOXJPcjlNTE9jUWVLSE9PQU5KNlVS?=
 =?utf-8?B?c05zL2ZMNWh4bmNac1hwRndtdGNpZDQ4cnhmTkNRV0lLbndzd0JhZDJLcDND?=
 =?utf-8?B?MStXZDFJeTdDSEZCb2NubEh2NmJOdzFsenk5cVF1UEFUUWl1bjN4Y1J0MWdO?=
 =?utf-8?B?Ti9pSjZza0RyUzFKY1I4M2lkcWdMNk5XbldFb1k0cm56RU8zNmN5NXFlajVs?=
 =?utf-8?B?Z2MrWkxaUTBJbHZMc1llZ0lYd1VjT0I0K0M1N0l1cDBkbS9jSU9OSWtUaUVD?=
 =?utf-8?B?eTJiVUJlQ1hIemkreEttelI0MHhxMUVZTkFDLytOMFE5UVhRczVad0ZST2ly?=
 =?utf-8?B?NDZQV2NoTVB1ekpsSThXcHZmZUFFbm5wWnZ2Ulc3eGZRckRUc1JJSVZsc2Ry?=
 =?utf-8?B?L05peTUzZDJFSWtKT1lkRFBvclFwYU8rTFR6UGp5SUpVTG9lNklBTyt6RUtj?=
 =?utf-8?B?emFZK0dKVGdXcldKdU5PQ1BnT1YwQ1o2NmhlZFlkM2EzYUczd2lzS2hJNG1p?=
 =?utf-8?Q?+RRhCj5FEUyF+tO4=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2036966-b587-4148-a41d-08da32d270df
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 22:14:24.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frXwGXoYAluIIiuy7pnhvmoF8lgv3WujxIwDQ3R0Lfth4QUcXVjZMuo0HqwidiQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4556
X-Proofpoint-GUID: 1qGLGZD7JKiikRldmYhpTxKds1B2SG4b
X-Proofpoint-ORIG-GUID: 1qGLGZD7JKiikRldmYhpTxKds1B2SG4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/9/22 3:37 PM, Andrii Nakryiko wrote:
> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, the libbpf limits the relocation value to be 32bit
>> since all current relocations have such a limit. But with
>> BTF_KIND_ENUM64 support, the enum value could be 64bit.
>> So let us permit 64bit relocation value in libbpf.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/relo_core.c | 24 ++++++++++++------------
>>   tools/lib/bpf/relo_core.h |  4 ++--
>>   2 files changed, 14 insertions(+), 14 deletions(-)
>>
> 
> [...]
> 
>> @@ -929,7 +929,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>                          int insn_idx, const struct bpf_core_relo *relo,
>>                          int relo_idx, const struct bpf_core_relo_res *res)
>>   {
>> -       __u32 orig_val, new_val;
>> +       __u64 orig_val, new_val;
>>          __u8 class;
>>
>>          class = BPF_CLASS(insn->code);
>> @@ -954,14 +954,14 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>                  if (BPF_SRC(insn->code) != BPF_K)
>>                          return -EINVAL;
>>                  if (res->validate && insn->imm != orig_val) {
>> -                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %u, exp %u -> %u\n",
>> +                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %u, exp %llu -> %llu\n",
>>                                  prog_name, relo_idx,
>>                                  insn_idx, insn->imm, orig_val, new_val);
> 
> %llu is not valid formatter for __u64 on all architectures, please add
> explicit (unsigned long long) cast

Okay, will do.

> 
> but also in general for non-ldimm64 instructions we need to check that
> new value fits in 32 bits

The real 64-bit value can only be retrieved for ldimm64 insn, so I 
suppose it should be fine here. But let me double check.

> 
> [...]
> 
>> @@ -1026,7 +1026,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>
>>                  imm = insn[0].imm + ((__u64)insn[1].imm << 32);
>>                  if (res->validate && imm != orig_val) {
>> -                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %u -> %u\n",
>> +                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
>>                                  prog_name, relo_idx,
>>                                  insn_idx, (unsigned long long)imm,
>>                                  orig_val, new_val);
>> @@ -1035,7 +1035,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>
>>                  insn[0].imm = new_val;
>>                  insn[1].imm = 0; /* currently only 32-bit values are supported */
> 
> as Dave mentioned, not anymore, so this should take higher 32-bit of new_val

Will do.

> 
> 
>> -               pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %u\n",
>> +               pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
>>                           prog_name, relo_idx, insn_idx,
>>                           (unsigned long long)imm, new_val);
>>                  break;
>> @@ -1261,7 +1261,7 @@ int bpf_core_calc_relo_insn(const char *prog_name,
>>                           * decision and value, otherwise it's dangerous to
>>                           * proceed due to ambiguity
>>                           */
>> -                       pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %u != %s %u\n",
>> +                       pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %llu != %s %llu\n",
>>                                  prog_name, relo_idx,
>>                                  cand_res.poison ? "failure" : "success", cand_res.new_val,
>>                                  targ_res->poison ? "failure" : "success", targ_res->new_val);
[...]
