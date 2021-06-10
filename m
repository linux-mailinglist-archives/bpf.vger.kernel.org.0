Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2FC3A212A
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 02:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFJAJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 20:09:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhFJAJh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Jun 2021 20:09:37 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15A06dse001787;
        Wed, 9 Jun 2021 17:07:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SVyWCT4myU994Hx+gjsK5JCPXn9aV+0ia5CR3yKB+pQ=;
 b=TdNGZdcjSeqcnlYWDpuBQFhJOk0PQZwCDTxTxHgvYvdtkDkH8e4fvW6aeY/ju5MrZY8A
 lm+0eMuqapGiWQdJMz3Qj/dsBYTUepX8obmDpGV7dhaESyW9UYWnvcdqVe+fEfXV8rmR
 gIdOtWZVXLHUpeuuTX5mZfEg4V+bOV6OqeA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3933qq9j77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Jun 2021 17:07:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 17:07:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqFsnBQXKs7HeHGf6vAEhc6E46qtiw6LDxS2JJOX0lf9FiDExtMwnS/V3hQeRDxwo3hHB/4fY+ChBUorYpqMlvea7bGAmaayVoFXhan5jGYjwEPEiIgo0QVy7gjCLXD1NICaEDN/fB30M1wbjtwOehUIqHT4nSJbgMpxeOtWvjdIiYlAzyfCDcO1evgXA7dYWaXmSIK69c16C7dh7q0tfRbdn5hFKC5Mn4wQnwq030eW4FlOfoNWnIQ1Xga7+Qe5pQiB8tmENpej57A/+/NT2hV8bonXx0NVXkfkGHWQ5RBGW/PavJnhMaiM0/HTWNicpuUcerJkB+TipjkEpYHFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVyWCT4myU994Hx+gjsK5JCPXn9aV+0ia5CR3yKB+pQ=;
 b=UO49R3GOg4C3FP5fen4OGXNDXbkA3qd/vbbo9gX5a5GzXn2ETYxEJfh2xooCUTqDYTCaz2dJlehJa1g60uXY/pE0Wsz6wN/IPJ7t1q60asMBrv+4bMFDIxocnuQKAb0mxvfoH8kPV9kf5Jnsd9DKpxcDMGCyWk8R3jWF1Ffnvj0pn+ycEA/XITS9LD5J1kdEPV/FnPPJIGFp6pdNa5VEhMm6vNGCky6lPs/KKpBrTnd0CGk3hvfY0fP5E+yTWI5apxKIlKZMh670dAtrYTbX41AJPO0SgIDVsWMs/qDmEOIa6z2O7eIBclLrikTh6gnmjdK2g/K0Oweg5dS5jc/OUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4338.namprd15.prod.outlook.com (2603:10b6:806:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Thu, 10 Jun
 2021 00:07:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 00:07:24 +0000
Subject: Re: [PATCH bpf-next v4 1/3] bpf: support input xdp_md context in
 BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210604220235.6758-1-zeffron@riotgames.com>
 <20210604220235.6758-2-zeffron@riotgames.com>
 <f3c5a8d9-6d23-dde6-e9a3-178d9f572f29@fb.com>
 <CAC1LvL1oRTN=F26eOeTvzWUU+_9=8-q++Z+cjFXxZa+A7cLRzw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <89890caf-9281-04ac-8037-f08f0d12a881@fb.com>
Date:   Wed, 9 Jun 2021 17:07:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAC1LvL1oRTN=F26eOeTvzWUU+_9=8-q++Z+cjFXxZa+A7cLRzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:92ff]
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::11dd] (2620:10d:c090:400::5:92ff) by BY5PR17CA0052.namprd17.prod.outlook.com (2603:10b6:a03:167::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 00:07:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 142d4403-7966-4ace-15f8-08d92ba3b9b0
X-MS-TrafficTypeDiagnostic: SA1PR15MB4338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4338092486236B0CA3ECF040D3359@SA1PR15MB4338.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaMeck0nyVj2V4xh4i2HJoEgQH63vM/odpjty8CZEaAoaQxyVojhVxqphd9eHnTxlyCWGrNG2yrwvMo3pnkhe0Juhp4Z8VcQS1WhUF7uN0/5EOgehAisTzisw+uE0+1lFDE8xDAlUL+Z7ljktLWb6YQaQs/t6QhYQA7w1+Eij8Ldit3oUOyE0Dr8ra9tEktBxFLbTpn/cmrkrZroH7Xs+gE5XP3m6cfFvWW3CSYAzkHUy2k4K7uEHF8ryGHb9x9gcel+cFDOE3e6zdmjZqHjj6qQiVIaN9UMHQMVJmqz+Uzc54SL39R3VSLBSC7x331Y3QA4n4GvKxVOe6kdwRRTVvuGMbM6V+/pfePGDv6cVnU6BWqVDm2oXBE+7UHXwWvBb2TJ696607YspssU4ZUz0G39KFRip/MmAWhM1UCFz+adIaP1Vcvwi2TtLJZ6R5ojeuS3MP7X4IBQZVmB8dB5iCOvbzZ5IeyNQ2sc66MUaLp83SV88tzJZTyZ671k4qZouPncMF8oZw+4lIn41KCuXYkv97GOQawLmeAxoFgcrAqt7ZCggajH9rGCp1j7JbL12jUDYmliY0KXq+Hi9QjJdUHaua+4RNl4l2Q/1FmvhrQQ6x3Wpjgo+LdaLn2rUUcKNHVbB4wSIKh2vonG7U/zyZgSd0h0xYoV2xXUDUJUyIts/y904SZTFYc+ygnR3tNI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(186003)(6486002)(31696002)(6916009)(7416002)(316002)(16526019)(36756003)(31686004)(4326008)(2906002)(53546011)(478600001)(38100700002)(66946007)(66476007)(66556008)(5660300002)(8676002)(86362001)(52116002)(54906003)(2616005)(83380400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXlnemYveHU1QTc5bHNuTm5Da1QyR2RRMUN2WGhvdERtY1FQMCtudHZPanpC?=
 =?utf-8?B?N2RUOUJWWTRVWEV0MElyZDNDck8wWW1CNnloR2pKZkQxb3FtK3Q0MkYybGk1?=
 =?utf-8?B?YWVwZ3JJcUViVHRWK1NOVHk5YnZxVmFMWFFoWmtka2MxVTh5UEVoVDUyZkRS?=
 =?utf-8?B?MitoRnllY0c5LzY3cnFoK2Izd0lyY2RMc1RIbnJGNkk0T1ZySEdkTHBtWHFw?=
 =?utf-8?B?SityK29WUXA1VDUzRlRXelVMK1JENGNjdCtMc1lpU2VjaUJwQTBkVFhDSm92?=
 =?utf-8?B?VzU2NENncTFsSS95MWFpUDRueElxM0RoUElUQ3F5Zkx5SjZ6S1NwRnkrQi9C?=
 =?utf-8?B?VkdPVGpDYm1rK0J4cG1PbUF4aGRPYU9RMktFYjdobDBhOXJYM2hGMzJPSWtn?=
 =?utf-8?B?bExqK3JFQmlwY01ISDNXOGRsSEE2eThWUnZXYzExVVk0SzZjUlN1dGNkd3Yy?=
 =?utf-8?B?d0t2eWxMc0JHU2c4SnFXeHdvRURGeU4yTXcxbkc0RTJTWGVBT2ZXY0lUZldO?=
 =?utf-8?B?ZzhmWnJObFh3bFJmbEVOdENCbHNyU0F3WTJId3k5WDJzSHU3Q2wzbEpuYjZP?=
 =?utf-8?B?emRFN1hyMWljV21HR25QbE9TdDFRNFkvdGpPKzhNelVFUGFVQlV2a2NkbFVt?=
 =?utf-8?B?ZGoyaWE5c1NPUmNZRTFVendacVhic2xUbjl5bllDWW1ZWWdCMFJZaExJdXh4?=
 =?utf-8?B?SC9YUUg5TkUvV1UxaVhwdkxiMXk1RWZLTGNaUXpCRUJFOE9BVGp4RzduVVp0?=
 =?utf-8?B?Z1VHMnFURHlWOUxCdDZ6eEdOOHBjR0xDcGtIQzBMVEE2THhhczhPQ2NGVllu?=
 =?utf-8?B?bFJndCs4Yzg2Ti85WDVFb2tJM3FiUVBYV2VSbTdGblJRUXNtMjRnU1pKa01U?=
 =?utf-8?B?M2VmZiswK0FhVnFDZXJRQ1BLOVQ4eTdMbGZibXVpVkpraWhUblpac0pyR0pL?=
 =?utf-8?B?NG8zbGtDaFBCOUV0WlFvY1BPT3dSOTB1TnR5WFY3Y2JWWEpPSnBoSnJkeStQ?=
 =?utf-8?B?MFVDRXg5Nm9qQUVUYWttTzBoYXhBb1pqWjVyMVpZT1ZJVGhIdEdGaTViTCt1?=
 =?utf-8?B?cHlEdWdqUUlGeEJsNElsTnMvOVo4QWlkWXVCWXhWQ3FEeUxsT295NEZTYmg3?=
 =?utf-8?B?bjNCQWtjWG9ZT2NiMnNjcm95Y29QZit5dFhqUjU1L2hnUlMrSldMNHlMTFM0?=
 =?utf-8?B?ak1rLzQ3SEoweWhHT0l4ZUgvSFdxb1YyV1NDamZXRVNjNjI3N3gwQVN1RWs3?=
 =?utf-8?B?US94YmhFalRKVmtLWDhJc1M0VnFCNXA2Q1g2OTRCcnd2NjJJSHJ0dFFlM1Bo?=
 =?utf-8?B?L2RVWTdYUlAxMEZRSURrSXpGSXREdzZUV0txcnlBYlJGSHBQMnM5V09OV3Ba?=
 =?utf-8?B?RWlidXM2bVFkN0Q3bExrSE1DTHBCaCtqUDlUSW5tK0dVVXk1Z2VEci9IcFp5?=
 =?utf-8?B?aS96a1lITUQyNW5aOUlreWhHdWlUbGsxaEtBV3VNa2RQOXVEcTlsWkhJeUlO?=
 =?utf-8?B?R04vNkhvbXcwSU4wQTlyWkZpUVdmdWxzQjBjWlVsdFJWa243V0dxM3ZhcEU1?=
 =?utf-8?B?R2JPeG1jVGNOdlJ3NjJ5VmpyZm5KREY2YVE1N0ErcmZIZkJ4QlB2T3R0ajFu?=
 =?utf-8?B?dzdNOUdvZ3lDZzR4SzRaMFRRdVlTcHlLekpOanF3SHVpVWFWSklNT1RkbThG?=
 =?utf-8?B?SGFQRVRZeFZBeWk1STI4YzJuTVNhQnFGcFNpM25TQWxGV3dqckRGejF2dEJx?=
 =?utf-8?B?VFhsUCtucVNsMkNOZ1RESE1SbURuWGJOeVFNeE82KzVtMFNXTDNsYmh3aG1U?=
 =?utf-8?Q?Mhs10BcBlMG2UtYnIFodnq6vBYiwZV4JJ/k/A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 142d4403-7966-4ace-15f8-08d92ba3b9b0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 00:07:24.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1GMEgl+wZL2sPUAhGCjoCbL6WZRkXxL+dGjyqD8O9E/bnMZ/O7IgpCaVQ76m2ry
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4338
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: AowgMAxJi9Z1D2zZ9gigqVpfqQtdgeD2
X-Proofpoint-ORIG-GUID: AowgMAxJi9Z1D2zZ9gigqVpfqQtdgeD2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/9/21 10:06 AM, Zvi Effron wrote:
> On Sat, Jun 5, 2021 at 10:17 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 6/4/21 3:02 PM, Zvi Effron wrote:
>>> --- a/net/bpf/test_run.c
>>> +++ b/net/bpf/test_run.c
>>> @@ -687,6 +687,38 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>>        return ret;
>>>    }
>>>
>>> +static int xdp_convert_md_to_buff(struct xdp_buff *xdp, struct xdp_md *xdp_md)
>>
>> Should the order of parameters be switched to (xdp_md, xdp)?
>> This will follow the convention of below function xdp_convert_buff_to_md().
>>
> 
> The order was done to match the skb versions of these functions, which seem to
> have the output format first and the input format second, which is why the
> order flips between conversion functions. We're not particular about order, so
> we can definitely make it consistent.

But for another function we have

+static void xdp_convert_buff_to_md(struct xdp_buff *xdp, struct xdp_md 
*xdp_md)

The input first and the output second. In my opinion, in the same file,
we should keep the same ordering convention.

> 
>>> +{
>>> +     void *data;
>>> +
>>> +     if (!xdp_md)
>>> +             return 0;
>>> +
>>> +     if (xdp_md->egress_ifindex != 0)
>>> +             return -EINVAL;
>>> +
>>> +     if (xdp_md->data > xdp_md->data_end)
>>> +             return -EINVAL;
>>> +
>>> +     xdp->data = xdp->data_meta + xdp_md->data;
>>> +
>>> +     if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
>>> +             return -EINVAL;
>>
>> It would be good if you did all error checking before doing xdp->data
>> assignment. Also looks like xdp_md error checking happens here and
>> bpf_prog_test_run_xdp(). If it is hard to put all error checking
>> in bpf_prog_test_run_xdp(), at least put "xdp_md->data >
>> xdp_md->data_end) in bpf_prog_test_run_xdp(), so this function only
>> checks *_ifindex and rx_queue_index?
>>
> 
> bpf_prog_test_run_xdp() was already a large function, which is why this was
> turned into a helper. Initially, we tried to have all xdp_md related logic in
> the helper, with only the required logic in bpf_prog_test_run_xdp(). Based on
> a prior suggestion, we moved one additional check from the helper to
> bpf_prog_test_run_xdp() as it simplified the logic. It's not clear to us what
> benefit moving the other checks to bpf_prog_test_run_xdp() provides, but it
> does reduce the benefit of having the helper function.

At least put "if (xdp_md->data > xdp_md->data_end)" checking in the 
bpf_prog_test_run_xdp() as similar fields are already checked there.

It is okay to put *_ifindex/rx_queue_index in this function since you 
need to get device for checking and there is no need to get device twice.

> 
>>> @@ -696,36 +728,68 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>>>        u32 repeat = kattr->test.repeat;
>>>        struct netdev_rx_queue *rxqueue;
>>>        struct xdp_buff xdp = {};
>>> +     struct xdp_md *ctx;
>>
>> Let us try to maintain reverse christmas tree?
> 
> Sure.
> 
> 
>>
>>>        u32 retval, duration;
>>>        u32 max_data_sz;
>>>        void *data;
>>>        int ret;
>>>
>>> -     if (kattr->test.ctx_in || kattr->test.ctx_out)
>>> -             return -EINVAL;
>>> +     ctx = bpf_ctx_init(kattr, sizeof(struct xdp_md));
>>> +     if (IS_ERR(ctx))
>>> +             return PTR_ERR(ctx);
>>> +
>>> +     /* There can't be user provided data before the metadata */
>>> +     if (ctx) {
>>> +             if (ctx->data_meta)
>>> +                     return -EINVAL;
>>> +             if (ctx->data_end != size)
>>> +                     return -EINVAL;
>>> +             if (unlikely((ctx->data & (sizeof(__u32) - 1)) ||
>>> +                          ctx->data > 32))
>>
>> Why 32? Should it be sizeof(struct xdp_md)?
> 
> This is not checking the context itself, but the amount of metadata. XDP allows
> at most 32 bytes of metadata.

Do we have a macro for this "32"? It would be good if we have one.
Otherwise, some comments will be good.

Previously I am thinking just enforce ctx->data to be sizeof(struct 
xdp_md). But think twice, this is a little bit too restricted.
So your current handling is fine.

> 
>>
>>> +             /* Metadata is allocated from the headroom */
>>> +             headroom -= ctx->data;
>>
>> sizeof(struct xdp_md) should be smaller than headroom
>> (XDP_PACKET_HEADROOM), so we don't need to a check, but
>> some comments might be helpful so people looking at the
>> code doesn't need to double check.
> 
> We're not sure what check you're referring to, as there's no check here. This
> subtraction is, as the comment says, because the XDP metadata is allocated out
> of the XDP headroom, so the headroom size needs to be reduced by the metadata
> size.

I am wondering whether we need to check
   if (headroom  < ctx->data)
      return -EINVAL;
   headroom -= ctx->data;
We have
   headroom = XDP_PACKET_HEADROOM;
   ctx->data <= 32
so we should be okay.
