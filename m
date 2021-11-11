Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AACE44D3A8
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 09:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhKKJBx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 04:01:53 -0500
Received: from mail-eopbgr80133.outbound.protection.outlook.com ([40.107.8.133]:33169
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229543AbhKKJBw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 04:01:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY9K0Vo2icgRyHyeo5IB4yXHvpsW8R8PC+LYMAU4KGEY8esufnBqaLATzz1QIWUPHy9k9z52OkTS5CBAfQwXGo90LgoUSATOaCzFcMTr62NiuPrYDD66EwUZPpk8fyNbhQs1Qte7FkcIjcvTrd7ERyQHkO5lA3nhY5nwgVwYSskC0n1HkvsqNeu+LywN4toPZARIPhvDuwTjbDQJSPWnpZdPaGy5+ULdGDrhjs2GkjIINL0u8a88JegHybSnQuuz0CUgbZV6r6sVqseKFagYERG0tEa/sTcOjxB2qQCTCo07T0cRJl9IhXRcbqx7mrxVapoOOBYLiRc5WG4TAyv3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qal7JrFg6uZs9y/LhR84Pblta8QijnZEpQF1MrjpsQ=;
 b=H3aZvrfUBaqVo5AIbjATmiaipjkhNTXtLfj1DXXEJgNAqJntMysd7mdvWGbvir0eTsnQSazYffnGAUXQfezSU6KIB2U9CjeI0+TRurEgdc1e526QHPIHBLgyGX7cJHmH4ALopdmoEErKPRqEu/qqo++i1of4XiWfjDQBlsepUbl7fGPtJmu+N63L3EJXnfzbiUXhyqRW16USFIzj82NPU/zsTvbxi71COONNLhtN2okYfPsG+NfDmu958St4wRI1b2UaaYjzrgXfj4pPKD9VXmLUCy/jwuuuBdnezyxpjG78F6clcPD87qkMIn2+j+QBxViAwyH9Qx2fxGb2pzk/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qal7JrFg6uZs9y/LhR84Pblta8QijnZEpQF1MrjpsQ=;
 b=sUY1FJinZ2xTvWKsY3NqeFY7uBOnd0+Ql5sJT0yaHNv+/f3VWLcjWr1YmtcJcDh+CdtHR5dJ0rp0I5/PQ5pahSpxbt5PuxOnUI0A2hZc+bN0DFLkkiIFghUuHxTlxXOQhMVdvEuJhh4FakoQYTreElYcukNtvB08Fg7xUtIhSE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AM6PR05MB5223.eurprd05.prod.outlook.com (2603:10a6:20b:68::17)
 by AM5PR0502MB2993.eurprd05.prod.outlook.com (2603:10a6:203:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 08:59:01 +0000
Received: from AM6PR05MB5223.eurprd05.prod.outlook.com
 ([fe80::50a7:7a0b:413a:864c]) by AM6PR05MB5223.eurprd05.prod.outlook.com
 ([fe80::50a7:7a0b:413a:864c%6]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 08:59:01 +0000
Message-ID: <a745d3c0-f484-2a0b-4bdb-22f5e8463e61@polito.it>
Date:   Thu, 11 Nov 2021 09:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Add variable offset to packet pointer in XDP/TC programs
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <36467ea3-8b19-f385-c2d0-02e2bd9c934e@polito.it>
 <CAADnVQLszubAWyq+Mch0xRneyhVpqNwQhrW3u_eocN6NzRcpEw@mail.gmail.com>
 <59fac794-ae38-783c-dd02-7506283cc2c4@polito.it>
 <CAADnVQJz_=xCwzG=Da8AgJX6mm_gEv-URjcfEzWmL9+4nzKOMg@mail.gmail.com>
From:   Federico Parola <federico.parola@polito.it>
In-Reply-To: <CAADnVQJz_=xCwzG=Da8AgJX6mm_gEv-URjcfEzWmL9+4nzKOMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::12) To AM6PR05MB5223.eurprd05.prod.outlook.com
 (2603:10a6:20b:68::17)
MIME-Version: 1.0
Received: from [192.168.1.61] (93.88.125.241) by ZR0P278CA0079.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 11 Nov 2021 08:59:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fc14b7c-0918-4bc0-9143-08d9a4f18160
X-MS-TrafficTypeDiagnostic: AM5PR0502MB2993:
X-Microsoft-Antispam-PRVS: <AM5PR0502MB2993F734554122B1E89C8BBCF2949@AM5PR0502MB2993.eurprd05.prod.outlook.com>
X-POLITOEOL-test: CGP-Message-politoit
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PI57QxNtk527S3Yn0RjHlF9PMZwjTJCOG0QqnfBmhYB2OTYKzW4E4TT385jyppaZqy3XbiHHdhDTPS1FPsQC9ADSgjpSgqpfs+mjI7fDWjJqC8AQHIq62uMuNPN89c7HErCZMMDtWt3ypKoTeHMJw1LaNwwWfe7Hcx8Q568fym7dZbNaaDN0a55UsjXpc9EVmKB8D819kEXaThkQlZaDhYOOAab18RNA0HfLXqn3rTo50Jm5eIOZ9zASFNisZ51Q3SRbyhHTkWCsLk8WYJf8mS4Z9TD4aj8e22sWkyIZ658i7kEwQT78MnCWyU8M2l/URoJbqWBrNzKA63ksuyBcCAHpX0LXD6jIXLRV4zruYx6AjEMyA+l4rNASAbUurnw7alBlt7Tw6OwXX7USy/MqjqsgIB++5//kDvdDEyBNaFYVRTXqzfXcL1o2RwRRzffehPJo2Bbk81BWlXqWLOxdSQc8Ebvs3ng8udxRIMOycwmq5qZXMyklX2/UMmTlrU6pLE8r27OxsEO65v509sb81VTKZJf7HIHSEzT4Cq1nZLQTnlbkUklUqDkC29cwzxZj6wZ5NJvXQXVTm7rjLSRJbMd82qSJpzLI5zgIMol2c5JIJDAmn9votgvQiIgD5dv3k31Qkk+wNAaPYd4lAE76bvYvF8c2zUvYJV6PaIZCHfg3pAThPALrvpjisSdTgFS60Or0XfsYwWklwUGLpAOKPsj+hXLCXzmiANEUc/3PJWvk8AT1LTDUMPsQCErnSECIBwKvoW0EALPNzKW3E/Wl3eTY8IY28rk/BPLNMRw5Heo7wbQWusM19dbDxI6Ow9BSILfeO3pOID1D94+BXyLHpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB5223.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(16576012)(186003)(31686004)(786003)(38100700002)(83380400001)(38350700002)(5660300002)(66556008)(86362001)(26005)(2906002)(966005)(44832011)(66476007)(52116002)(53546011)(8676002)(2616005)(956004)(36756003)(8936002)(66946007)(31696002)(110136005)(508600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWhBYjQwZGNIckk2NG91dTYwZjNka0VlWXJiczF2dTdTUURPcEY4VXZrWHFY?=
 =?utf-8?B?Nmp2ZW1lM01DMEprbUN6bmRqYU8wM0lhWTEvWkVOQU94VW9IK1NKYVJxS3ZR?=
 =?utf-8?B?SmxONzRPQkE0UUFzYnlHMXhGT1VTWno2TENMUXE0aUt2T25xaGV4WGRUV09k?=
 =?utf-8?B?Rkd3aytlVVBEOVZydE1ORzZSaXFicmlPeGlnLzFlc1ArbkMzQlp5ZmNDMWlj?=
 =?utf-8?B?emlsZWExdG9vQjArL254bEFLUEtxZDk3d3I2SXRtU2U0VXptSVJpb2E5U1lI?=
 =?utf-8?B?dVFIL290Ykpkc2MvZ0FVL1JDOXZoRVZwaml4b2VvQWt6MnJ3RTVBUVFoMlRv?=
 =?utf-8?B?SGloUlVlNU43Ym1xTVZVN0NIeUhhL3pzR3J5L0pnSlhKOGdyenIwM2IzT0xB?=
 =?utf-8?B?Z25rU0FqUCtaOXVTMEh4bmpEZlNWRE0yOThWc01icU95ZnFFdGhLZS82TUU1?=
 =?utf-8?B?MGdWUHVORmJLQ0laWmViVGNEeTlVUldjbUZCaXNqWXA0REpkWFdETGpxYXdI?=
 =?utf-8?B?NWpNVWRsYnRnMmR1dlNNYXJ0alIxQ1B0RndQa08vMzJDTDZpK1dsZHRhWjlS?=
 =?utf-8?B?bURCbDA2NnZiUEhYb0MzdkJhbWgyb0VHZjhNM2pkMllxa2hIKzJaTWc1QUtI?=
 =?utf-8?B?N3NOWlVQUGwyMDRJK2xMK3pBeEJYNXRjbjliUlJmSzdnZEJKb3VHV3VyeU9B?=
 =?utf-8?B?WWpPcVlNbkxta0szeVhGWHJBMHpLZEVkV1lkUmdXdVhOZXcrL0R1K0RPaW9k?=
 =?utf-8?B?eml2cW84TmdYSmh6ZG9TSVBEbWRuY3F3bHdsYnhoYlQ1YkFWcDN2dkwrb09m?=
 =?utf-8?B?YnhZRS9nM2wyL2p0QVA4dEo2Vi9zd2F6TWxqMHRkSDR1SnpmNmRpdTMyR0Ns?=
 =?utf-8?B?UElLaFdUU0ZaRmtPd3lNbjlOdzB6Q2lsZE5OMkFNck1nOFB4STBBMWVoL0Mv?=
 =?utf-8?B?aGQ2RnZaQXpWdEZHSFJnUW9WOXllV3JKZTJIYVdkNXU5VndXRkxGbnBFcnQ0?=
 =?utf-8?B?eTN6S2ZucUtlc1ZyZ2dJRDlEMFc2UG96L1FCQUlqS1B1dzd0Q3dKVHRONGFT?=
 =?utf-8?B?T0VNMk9SSFNnQTJMem1zSzN2WW1VeEVYR1JYZDZhNVdVNWdwZEtubVVNTG82?=
 =?utf-8?B?dkhrR3FKVjdLcEc2L2tLczBjWnRNRzA5dGNVWGs5b09oeElxcTFoWFgyU1pr?=
 =?utf-8?B?Y1FIT0gzK01KSUpIMVBYZjJlU2RJNXV2NElYV0hFV3VWbG80aDZOOFBKVGxI?=
 =?utf-8?B?SXdSbkpmTEEzQStoZGVtMlZmNWthemlLeHNxOEJHR1ZEalB6dlF3TnJGR2ZH?=
 =?utf-8?B?SFlkdVNjMFZrMnpUYUN1V1lPK3p0YWJUOGZPNWRXT0ZVWFZkYnJFdU9HbXFj?=
 =?utf-8?B?aUtkaW0vVnlMWlB1SldWaEs0bjBWMXhOeFVWQTdYSExNb1Y1amVWNDJnWUd1?=
 =?utf-8?B?bXUyUStpbE44K2ZpNFk5ZWcxNkRjWjhmVjRVRDg5MU4xTjI5OWxtbUdXV2Vh?=
 =?utf-8?B?WEE4MjJYY09PNzdUdFo2ZTBiZFQ0eGxEL1IxZ01haEo4bVpaUzUrd0RNRHhh?=
 =?utf-8?B?TitsVzZRSmVwekkwR2FraDRHSGxQbEtwK25LVGR2RVdpTjZldVNmSXZSQ3NK?=
 =?utf-8?B?bGZ1OFFyRmJ5eFpjWXRlcHR5RElMNTk0R05NOWJ1d2h6SDQwQndrenl1azZU?=
 =?utf-8?B?c3NHN1Y3dUNWdFpybkRPUmMwY2llOEZlOHgyNVJUUFJMYWZucXR4N0Y1L0l2?=
 =?utf-8?B?NzBnNDhldUlneVBkL28wc0lRdFJiVkhkS3N4SVJxSnRsVEJaN0xkR2crRnhx?=
 =?utf-8?B?T0dvT3ZPY2QwQngwcFhNN1JRYjhiU0Y4NHZvUVJVVTVGTWNMZUxzenZhcjgr?=
 =?utf-8?B?NnpKZ1JRNURmcVBzRklBT3NxdlNZNWtaNjdxNVRVSy9RMVJxRWorZGJETVNa?=
 =?utf-8?B?aG5zaWdSOVJDalR6NSt5Z1p3L0pXVzBKbDAwbzdzRmV6Y0JWS2l0aTYrR0Js?=
 =?utf-8?B?MTQxbzhZcVh5VkRlYyt2SmZoc0NHbVlsOE5LSWx1Vll3LzhxeDBaTXBpMENJ?=
 =?utf-8?B?YVNxT2VWMWcvb1JsNjhUamNwckhZMHRKYzFiNXdJellZK0FqNEs5R1RRT3hh?=
 =?utf-8?B?WkYzWURHcENKTSt0eEw3Ulk1K2dDbzNlMjJXVDlrczlzVTYwRkh1cytZUk5F?=
 =?utf-8?B?QzRYbDlmQWpMUVNCK0pwVnJEMGx4aUk5RW1QTzhCVm9iQzViamk5N2VwZXdC?=
 =?utf-8?B?Z1R3a0E3UW5SZ2VKTk94VnZSSTJBPT0=?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc14b7c-0918-4bc0-9143-08d9a4f18160
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB5223.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 08:59:01.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdKKf5XxmmqgVEoISgmxGdc1AGnW+g6Gt717DTFGLc/4xwmnx0Y9WIt2gM3XCQS8SQLVUIUXz8cYMvOJOz0NbJ1TbQxj+o1COQjjKs5oYas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB2993
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/11/21 17:13, Alexei Starovoitov wrote:
> On Tue, Nov 9, 2021 at 5:47 AM Federico Parola
> <federico.parola@polito.it> wrote:
>>
>> Thanks for your answer.
> 
> Please do not top post and don't drop mailing list.
> 
>> If I perform something like:
>>
>> *(__u16 *)data &= 0xefff;
>> data += *(__u16 *)data;
>>
>> To limit the max value of my offset the program is accepted, is this
>> what you mean with "clamping"?
> 
> kinda. I don't think you meant to mangle the packet in the above.
> 
>> So packet pointers are stored on 16 bits? And every time we add an
>> offset we must guarantee not to overflow these size?
> 
> no. the pointers are 64-bit, but there could be additional alu ops
> on them. So MAX_PACKET_OFF was picked as the practical limit.
> 
> Do you have a real life use case where you need to add full u16?

Definitely not, both my use cases can be solved limiting the size of the 
offset with a mask (I suppose a comparison with an upper limit works as 
well).
Thank you.

>>
>> On 09/11/21 06:29, Alexei Starovoitov wrote:
>>> On Mon, Nov 8, 2021 at 6:04 AM Federico Parola
>>> <federico.parola@polito.it> wrote:
>>>>
>>>> Dear all,
>>>> I found out that every time an offset stored in a 2 (or more) bytes
>>>> variable is added to a packet pointer subsequent checks against packet
>>>> boundaries become ineffective.
>>>> Here is a toy example to test the problem (it doesn't do anything useful):
>>>>
>>>> int test(struct __sk_buff *ctx) {
>>>>        void *data = (void *)(long)ctx->data;
>>>>        void *data_end = (void *)(long)ctx->data_end;
>>>>
>>>>        /* Skipping an amount of bytes stored in __u8 works */
>>>>        if (data + sizeof(__u8) > data_end)
>>>>            return TC_ACT_OK;
>>>>        bpf_trace_printk("Skipping %d bytes", *(__u8 *)data);
>>>>        data += *(__u8 *)data;
>>>>
>>>>        /* Skipping an amount of bytes stored in __u16 works but... */
>>>>        if (data + sizeof(__u16) > data_end)
>>>>            return TC_ACT_OK;
>>>>        bpf_trace_printk("Skipping %d bytes", *(__u16 *)data);
>>>>        data += *(__u16 *)data;
>>>>
>>>>        /* ...this check is not effective and packet access is rejected */
>>>>        if (data + sizeof(__u8) > data_end)
>>>>            return TC_ACT_OK;
>>>>        bpf_trace_printk("Next byte is %x", *(__u8 *)data);
>>>>
>>>>        return TC_ACT_OK;
>>>> }
>>>>
>>>> My practical use case would be skipping variable-size TLS header
>>>> extensions until I reach the desired one (the length of these options is
>>>> 2 bytes long).
>>>> Another use case can be found here:
>>>> https://lists.iovisor.org/g/iovisor-dev/topic/access_packet_payload_in_tc/86442134
>>>> After I use the bpf_skb_pull_data() I would like to directly jump to the
>>>> part of packet I was working on and avoid re-parsing everything from
>>>> scratch, however if I save the offset in a 2 bytes variable and then add
>>>> it to the packet pointer I'm no longer able to access it (if the offset
>>>> is stored in a 1 byte var everything works).
>>>>
>>>> Is this a verifier bug?
>>>
>>> It's because of:
>>>           if (dst_reg->umax_value > MAX_PACKET_OFF ||
>>>               dst_reg->umax_value + dst_reg->off > MAX_PACKET_OFF)
>>>                   /* Risk of overflow.  For instance, ptr + (1<<63) may be less
>>>                    * than pkt_end, but that's because it's also less than pkt.
>>>                    */
>>>                   return;
>>>
>>> by adding u16 scalar the offset becomes bigger than MAX_PACKET_OFF.
>>> Could you try clamping the value before 'data += ' ?
>>>
