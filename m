Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D44345B0A4
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhKXAXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 19:23:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46644 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230509AbhKXAXg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:23:36 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMf0lu005943;
        Tue, 23 Nov 2021 16:20:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ILuUuAq4POu7QO6XHLMYb9xgTuw5eu/2eB3Sb18L1Fo=;
 b=FdsqlMkRREOjlZX4LXe7y8WDKQhTCyTalD45TuNdAOEXv1o709go6FXWK/Tnbxp1UUv/
 XiQgnSycyH28SfJGaCF+3VIA6Tp478LTb4uO7E4XisvWAviCAcf8hx4jEkEmDMDJnkw9
 NP98BmfWh1dP0zJ7Efog0+qHErd+5FCj+1M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch3jsu5kp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 16:20:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:20:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Brz+SAXDYbTdbMzjarDvn1p5w2iu6NRUxNJLr/iWxwJlS2Z/nvtikVus0GziEJsVUnLEPNdNF8Wz20LNDBcKGWGrH/IA4wVSQEmf0FxpaqfXIZGidUQ9bwMcZekXSqNAv2w4ONlKWJecbI6oAE+nPQ2i014vyOsgCVYJ9TwhVO1dL6+zQQtITyJr6jz3cTGrBEtFqNURsPDnvpxnvkv+zvJvDnySN4oHLxVZgEIBGqYALDkt+vQkWbuhEUyM+NtbPqmpvgJQvuNwj7FzSEcJUhWI1ZJwqHX6fPueG/gv5DpLc1j9Q3eglLzTzR0/Q3UTHOQXVpEPxqsZnZ+b0eMA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILuUuAq4POu7QO6XHLMYb9xgTuw5eu/2eB3Sb18L1Fo=;
 b=Ep5DMQUrmYli9BAzadrzY/Z40myDMITNg9HePIPDFGWh5ya8t1ffaodG8jNw/CHClcI49nhLQALyuY0FnZPCiSsTecexDnUxdnnRUaEo9foOv5kkCdNR7PmiRK8PzJe5xlHlPVfXWzwr54WmuhsNi9VcoOavcInp54jUZbq5Ej0b8aRcjQ+KdNrR7bUABCLvfYYrbrc97isXFexkXgQO2eBkLjvO0gNXej9fjG2Ju/5de8St6crOIkaV/ZluhwgT9dXksKIgpW5ip8YIE8yR/ZzlChBbuHKDIRamnrv4WpxS/lUTMUb1S44k72q00COtw2ze1Hi+srTBcC0H71YH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4471.namprd15.prod.outlook.com (2603:10b6:a03:374::20)
 by BYAPR15MB2712.namprd15.prod.outlook.com (2603:10b6:a03:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 00:20:10 +0000
Received: from SJ0PR15MB4471.namprd15.prod.outlook.com
 ([fe80::98f:c15e:3823:d98e]) by SJ0PR15MB4471.namprd15.prod.outlook.com
 ([fe80::98f:c15e:3823:d98e%9]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 00:20:10 +0000
Message-ID: <3eaa1a93-c3f1-830a-b711-117b27102cc5@fb.com>
Date:   Tue, 23 Nov 2021 16:20:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop
 benchmark
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <Kernel-team@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
 <20211123183409.3599979-5-joannekoong@fb.com> <87y25ebry1.fsf@toke.dk>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <87y25ebry1.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:303:2b::35) To SJ0PR15MB4471.namprd15.prod.outlook.com
 (2603:10b6:a03:374::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c083:1409:25:469d:91d7:d5f8] (2620:10d:c090:500::2:4d33) by MW3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:303:2b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.10 via Frontend Transport; Wed, 24 Nov 2021 00:20:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e45ca10-a9e0-4a27-daa3-08d9aee02ce2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR15MB271204D3BCF942B5975F5966D2619@BYAPR15MB2712.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILI3QEiCj90hHgKUEDDxPYyJDx92zxBrmMhwlNu3Ih1218lZIJZI6uOvLU+MWwlHGAQBlcGTTKJnmLGvQrmZRztVUBB+gyrP8FmWAWN4iegDRExsk3opvna10nVAARGYl2Nfhj4tFOx9IYxu4lFT/btR85nEhUjjY+YaL6HOtt5KpOMcw62Tq3W8+q0rJBG9d9xjjkjHKuk6iZf/g57zhwntzP/kh6nMeRPrn8CQYKdT70F4ROkEvf6DytSBXxh8ZcdkJ6TkSmc/5v+9ghKNH7wBv/OsQJBkn0Dl6f2Gn1aepynYIDF49rSB6jUyw4VyplpPs/jHwJY0Gmz+PyTWJEpda3dCmMN79W/lc1TOJ5dng9KCBhl0Yk+7m1fN9M+nhYrNViLeIe/q3wPdZ8Y6GnGOU2ne6/YC7RzjOSa5XOHeMtZehWCttODN+89H1XqOvzG9G4U4aSpxQqvULN4jUH5u27z4fhpVKa4AwjTZ0RqGA36K7xqJ5GDaHxEzlRuXMppCAYItiA8JPys5NSv+6geB+9VnUdszKZ604tzXqgqXQwPMeQKk7ZgTUK5EQki2kTiMoVkwRrW7H1Qj2JVuVIEU9jaCNV0x2RNn4ivItudv6N22uPOmg21dXxrswbfG9hUbgE+Lfh9dYF864XOZ3SffA2W7eM1SiKEOHu7zfYTbk5czi6p1k4YYLdjd19vm4L2mQwhmxhtWRI6THZhEEoixMIn8L8/6mfTx1AZhYBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4471.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6486002)(5660300002)(38100700002)(8936002)(4326008)(36756003)(2616005)(53546011)(66476007)(66556008)(66946007)(6666004)(508600001)(86362001)(31696002)(31686004)(316002)(186003)(8676002)(83380400001)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzRXNzVueXVLRHhETVZwdUlxWlNkbFZnTE82bFJEK0NCSWpNVmE4YktudFRN?=
 =?utf-8?B?OUtoZm95YjYwRmVYbDNXdTd2VWxhd1AyOWg5WkcxZ1EvL0xMYWhSQjRjeGdL?=
 =?utf-8?B?bHlSNU9qaW1iRTFEVStuNXVTa3V6d2FMK21kVm5LSkhsbWo5NDRiVlMycWJX?=
 =?utf-8?B?ZHZNbGpFMkRKK0c4NDZTVGFTU2lEeWV3QzhQeTBuQmJkeUI0a08wempUQVFy?=
 =?utf-8?B?cnAwT3NjcUtYa0ViTmtPeDhscUpOcU9wbEpGZ1hZUFZJTXpVR0tudXovQnVX?=
 =?utf-8?B?c0w2ZlcrcGxqelp2Tk9EOUVzckpoczhtMXlUMXk0NzJCOFJjU3BJbzlPclVE?=
 =?utf-8?B?WDZWdFgwd3AveCsrMnRQVCs0dnhUVUFvZU5OK2pPcGUwSGx5c1RKbEJuVFVJ?=
 =?utf-8?B?N0RFa2dBRENCWnFBckpxenlWOVhVc1N0ZEhXa3FaRUpySWR4QU1mNTZXYSt4?=
 =?utf-8?B?amZaYjJtN1N3VXhHcC8ycEhxZ1duWHZKRS9tZ3pKb2Q3aTIxQVFPZk9LZmRD?=
 =?utf-8?B?bGFNTUVvRWNub2ZLZDNKTXkxWUhlWGdaR2Y0Z2krNE5tUlcwaVZyd25GVWdw?=
 =?utf-8?B?VDQ1TkRJbmt0NDZhWlF6ZWZUSzhIZEZtdlY3MVRSTURZcUh0OUpYTVFEMTR2?=
 =?utf-8?B?Wm1QNHRkWGhNdzdVdlN1Z1RPTFFJZXhaKzVQbU85bWZQYi96cUZ6eHBwSndL?=
 =?utf-8?B?VUUwRUlKMXZ6YTdoNy9TRW5yK0VuazI2N1ZOS2pKcDU3YjlPbFRCazBrenJD?=
 =?utf-8?B?NERsOURoTUJJRVZScCtyNkVOYVByb1hsQUdnUW1qWkUxd2xDSllPaytsRXgy?=
 =?utf-8?B?aXViZW9lUjZONXNhZUp6M0hnOVpjMGt2WVJCaklocTdTTzJsNzFEdko1Umlk?=
 =?utf-8?B?b1VsL2psSE1WRUI3UUk3bi91OXJNdGVRTkJHa1F0UW5TNzlwNW85TFh5TlZW?=
 =?utf-8?B?MnE5TldjejhRUmFCcDVLMjBqMFBScE9US2RKMmRvVXBWUElwblI3bUhBZ2RG?=
 =?utf-8?B?aEhxM1ZjUFFCaHRKQmNXZXdDb3VxTUdHV3BINTNGYWFOM1ZHV05UaGtlVGlk?=
 =?utf-8?B?aDlQZGhCWVZDSUZKZzVkME9EdXUzSEdJRkhhQlQ0VDhLK2E3ZU1yYnpiYW4w?=
 =?utf-8?B?dHh1cGhIU0l0SXhVbjZ4SnFNVW1DcmZvQUkyK0crMFJTUVN6U0QxVzRqenVv?=
 =?utf-8?B?T1psc2M4dTBJZHBETlQ1T1ZzZ0wyd3Z2Uy9ldmNjWXJmeDg4Ymt5ZDZMNERu?=
 =?utf-8?B?QVBVMlBBbnEzRk9SL1NCVFBnRVc1NGRpWnY4bEVXUEhEWCtpb1JwQk0wSFZ0?=
 =?utf-8?B?UkIraldXUUZ4ZEVOUVE4OGJCU2FaangvSEd1TXhGZWhBNHdvZG9IeHVKT21G?=
 =?utf-8?B?cHp5QnhPV216K2Y0TkZPNFlQN0gveTI2R0p4ZThXY1NpbjJrN2JIL011OXBT?=
 =?utf-8?B?Y05FUEVjZ2UwYkpiSXRQNmZWRGZzYWpvSENBK0NJMXpDU1dya0plSzZyWU43?=
 =?utf-8?B?VDVCcHk3cHFkM1NiRytRSnMzQ2MxeVk4RFYzZXROa0Z6eGZMUXh3TkR1NHlP?=
 =?utf-8?B?TXBBaUJ1SittOS95MTNuUmdLY3BYdG5XV2NZR09hMnNMNVcvSUFDY05FdWZM?=
 =?utf-8?B?RVJCSVN3a0xFTHVIejB4cGZUbnZDTUowUEVzL2cyL0dVa3dETGZIbjRvS2lW?=
 =?utf-8?B?Mzd0aDJPVE15djhFV2JINlk5V3ZPVGQvQ2NwejZaZTd3SjBGOEQvelEwazlr?=
 =?utf-8?B?bUxhWCt3ZzZnUnAzWUpuaDY1Y3dVUUFlaFExU2ZKeGFRZktXazZwd1BDWEJj?=
 =?utf-8?B?YStuWWc4SWV3SkN1UEdCMnJDcWJyTlF5MEMzSzdFUEpWK0svQjg0VDJjR2Ju?=
 =?utf-8?B?YTRLVzZDTHdiN0lxcmU5R0FBdXZsNkFBTmZRT0xUdnBDRm9Jc1BYZWVPWUl5?=
 =?utf-8?B?c0t5NmJieDJLUEkvUnU1dnp1T2IreitiTEF3K2RLc0hwYXNLTjdPcVBHZEFm?=
 =?utf-8?B?Qk9DYllQNnNtenZJVzhJWGI0VnJkMzk0NllZdmxrbXQ0NC9EaUhEZ3dlYXU1?=
 =?utf-8?B?ZFBQcnErQmE4blhqamlmOFFLMkRPZ0owZEZ4UnlxNGp1bmNUdUZyWFdQOUw2?=
 =?utf-8?B?K2g4SHNUcFlGWTByQW1OcXF3NmI2bjVUcW1waDhjUW1HRWtPcDIwbmpBT1JG?=
 =?utf-8?Q?LYLqbU5v0ajthjmI66qBvFIE0lfY25JFXnxXNidI5ZxR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e45ca10-a9e0-4a27-daa3-08d9aee02ce2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4471.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 00:20:10.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKFiU2NuSD8CcPfMW1DfhEXB94egPZSzp1ohIBhlOlsvACNUEoNlx+ZYPNsmj97KJBtVSjveWDDK5pjMXKmagg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2712
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ho2yDOpbo2W7BfCr1s1xH7Z-a2fQjNlH
X-Proofpoint-ORIG-GUID: ho2yDOpbo2W7BfCr1s1xH7Z-a2fQjNlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=838
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/23/21 11:19 AM, Toke Høiland-Jørgensen wrote:

> Joanne Koong <joannekoong@fb.com> writes:
>
>> Add benchmark to measure the throughput and latency of the bpf_loop
>> call.
>>
>> Testing this on qemu on my dev machine on 1 thread, the data is
>> as follows:
>>
>>          nr_loops: 1
>> bpf_loop - throughput: 43.350 ± 0.864 M ops/s, latency: 23.068 ns/op
>>
>>          nr_loops: 10
>> bpf_loop - throughput: 69.586 ± 1.722 M ops/s, latency: 14.371 ns/op
>>
>>          nr_loops: 100
>> bpf_loop - throughput: 72.046 ± 1.352 M ops/s, latency: 13.880 ns/op
>>
>>          nr_loops: 500
>> bpf_loop - throughput: 71.677 ± 1.316 M ops/s, latency: 13.951 ns/op
>>
>>          nr_loops: 1000
>> bpf_loop - throughput: 69.435 ± 1.219 M ops/s, latency: 14.402 ns/op
>>
>>          nr_loops: 5000
>> bpf_loop - throughput: 72.624 ± 1.162 M ops/s, latency: 13.770 ns/op
>>
>>          nr_loops: 10000
>> bpf_loop - throughput: 75.417 ± 1.446 M ops/s, latency: 13.260 ns/op
>>
>>          nr_loops: 50000
>> bpf_loop - throughput: 77.400 ± 2.214 M ops/s, latency: 12.920 ns/op
>>
>>          nr_loops: 100000
>> bpf_loop - throughput: 78.636 ± 2.107 M ops/s, latency: 12.717 ns/op
>>
>>          nr_loops: 500000
>> bpf_loop - throughput: 76.909 ± 2.035 M ops/s, latency: 13.002 ns/op
>>
>>          nr_loops: 1000000
>> bpf_loop - throughput: 77.636 ± 1.748 M ops/s, latency: 12.881 ns/op
>>
>>  From this data, we can see that the latency per loop decreases as the
>> number of loops increases. On this particular machine, each loop had an
>> overhead of about ~13 ns, and we were able to run ~70 million loops
>> per second.
> The latency figures are great, thanks! I assume these numbers are with
> retpolines enabled? Otherwise 12ns seems a bit much... Or is this
> because of qemu?
I just tested it on a machine (without retpoline enabled) that runs on 
actual
hardware and here is what I found:

             nr_loops: 1
     bpf_loop - throughput: 46.780 ± 0.064 M ops/s, latency: 21.377 ns/op

             nr_loops: 10
     bpf_loop - throughput: 198.519 ± 0.155 M ops/s, latency: 5.037 ns/op

             nr_loops: 100
     bpf_loop - throughput: 247.448 ± 0.305 M ops/s, latency: 4.041 ns/op

             nr_loops: 500
     bpf_loop - throughput: 260.839 ± 0.380 M ops/s, latency: 3.834 ns/op

             nr_loops: 1000
     bpf_loop - throughput: 262.806 ± 0.629 M ops/s, latency: 3.805 ns/op

             nr_loops: 5000
     bpf_loop - throughput: 264.211 ± 1.508 M ops/s, latency: 3.785 ns/op

             nr_loops: 10000
     bpf_loop - throughput: 265.366 ± 3.054 M ops/s, latency: 3.768 ns/op

             nr_loops: 50000
     bpf_loop - throughput: 235.986 ± 20.205 M ops/s, latency: 4.238 ns/op

             nr_loops: 100000
     bpf_loop - throughput: 264.482 ± 0.279 M ops/s, latency: 3.781 ns/op

             nr_loops: 500000
     bpf_loop - throughput: 309.773 ± 87.713 M ops/s, latency: 3.228 ns/op

             nr_loops: 1000000
     bpf_loop - throughput: 262.818 ± 4.143 M ops/s, latency: 3.805 ns/op

The latency is about ~4ns / loop.

I will update the commit message in v3 with these new numbers as well.
>
> -Toke
>
