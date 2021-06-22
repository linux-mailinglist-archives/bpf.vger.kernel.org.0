Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7604B3AFCCA
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 07:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFVF6T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 01:58:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24024 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229853AbhFVF6S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Jun 2021 01:58:18 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 15M5sCqQ016804;
        Mon, 21 Jun 2021 22:56:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/3j9Pyru98pbQjnxiXxrb9ZZYzx8s/9se26mFKs7FxA=;
 b=ii2Kp4i0nS4OlkgHujGZ555t8++E5xd9F4Pn5dn/zEulylYp24bQCx7Bz5sBsi/IVek2
 0qqv2NGwnzk4t279xX0KC/0C9eEz7p5e+JtS8uai0O9798JUYMpV97RP4BUvDU1X7Sgi
 XcSTPGJ4PBRagFONNRvvqUdCKqRKQ5U/JeU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 39arbfxd4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Jun 2021 22:56:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 22:56:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWgkCUjdRCRZhyv17lgqfVypkgCmf9oxVUVgqbedr+EZGhtrubYiSMUciBALRXyFLQtdro2vdLEgjDvl+E0XZGnGF+WRi5xoMHuVl4Vodg8Br2kXXctB8vwwusUWz9cp7/6kHL7jCePOk1Dxe8eLKJL5jx4FNk1k6nh/WfroPW7HULNuEGXga/wPdHREfz8I0+3XOSrLqySP0QCjjqD6gJQWWyqW/KqL3lbHno1BW3dho2nwNHabzzp5Ltcxf+1CT9/sFuf6047BEJA1QDzNoY/fV2cl/Bv0+2krwKgD4c0DJO6lD9Ec+j37itrPMhieBPo1irUhwKAdhUzYmRCr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3j9Pyru98pbQjnxiXxrb9ZZYzx8s/9se26mFKs7FxA=;
 b=EZsI5bY9ipwbH6Q94Ybji6tLOaf8NBSuNYslRsWTsm/ajMqzeKth8HH2ZPjMkqgzdkKoqvshZoybzRG9RH2qkXke887KxkIAHMI7CFVHqSW/WG60r1DBh02zclhd4jZ5Ah8thidX0OtOHQXTZ/uCq9NmBfDxgw1koJYK/QmTaFU/jhBMoHm+Dm7zxk1hZV7rKHXrmVgPddW9xnVtnZ2XSpMDckt5JZ/RL5hY+Ptp1uDAu9vkFLHtpaQt2Fs3EBSzAay6qjeMFwlvdVRWSmKJhKpSqPPS4ttlPfRJOQRfpqYd38lQrPlyQwrubt10HzzeHCA08HyikgX2P5Sphq2qLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3982.namprd15.prod.outlook.com (2603:10b6:806:88::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 05:55:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 05:55:59 +0000
Subject: Re: Create inner maps dynamically from ebpf kernel prog program
To:     rainkin <rainkin1993@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAHb-xau6SrWN0eU1XB=jjvae3YxnAK0VsU08R0bH4bbRqo4aBA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8e3a8a21-f973-a809-d005-bcde3546e32c@fb.com>
Date:   Mon, 21 Jun 2021 22:55:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAHb-xau6SrWN0eU1XB=jjvae3YxnAK0VsU08R0bH4bbRqo4aBA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:4008]
X-ClientProxiedBy: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1643] (2620:10d:c090:400::5:4008) by BYAPR08CA0059.namprd08.prod.outlook.com (2603:10b6:a03:117::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 05:55:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08a2c92a-87da-4b60-5431-08d9354268b9
X-MS-TrafficTypeDiagnostic: SA0PR15MB3982:
X-Microsoft-Antispam-PRVS: <SA0PR15MB398234E4F37689A9BFAB1E8DD3099@SA0PR15MB3982.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgCIEy1azu4q6wMIbqUnjghjXgzzkEPA7erdq+r9ATvltw3rS7lpFJDKrIibuOEUm8aWnu6qYhlN6DlhaMfOwZH7aaHXLzEY6zUWTDs/yc5E03HQXC1Xk/HBCLaIYclWUQxVID9Kmc+XEVDFzCNXsJ11kg4kd4bA85yg8DAiNx0LAaD/lafhRmO/t5fUhAtLGoQ96LOboox9gEIuXQHulC47Fc05yiCy7SNhVB/OhzpO92CEImukXK/gaeFkoLLzgnC/aPG8EN3ibtIp5uHFTIXM/U5mJY7RS4A0kgWh1fWR2L0jX6iGAjw6a1w3VbjpZT6+VUs0wLzAKhMCC5HLkn7H8jKwt7Ijl7Sb+S2ZIa7epTzmujjOwBS6BVfHUIiklU/jjlICrizSdct6nwXx3ANkejlL93439ntdq1euk5w63VVSO3AYhiuJgSUlN0Sc5o+gD1y+a6R8VswBZSavN0A4GuB/96u5tYLGYqYrsWZljQbXIimofTCLo6qpeOtfW7k8FYkeA+OcBn34fcQDTuxfch31WWBl4TGb03SehqffmywO5YkivMFPN1deeS0LUDDtCgUnMDK0b1YozgPCbmgnMRj/XC0BVSRHKmLS40gVBP7YQSFJc+Hj+p41T4hWVPcyWs+qTFb4V+JKp5IvPa1vLRTGYDGe4u6U8HyN4Yvu5GnS2KdOiQjG3/CIFFyJcNdX0AbXGHGnSA21csXBgO7aD1L5cYzQictyW/cCI3vgtY3gWcqWnLMyIucGRvBDugKkTWGSh7zhY0Xlo4zVapG9dAO+WYgom9qymZqkDzBG74vpXj1AaMt18oaJ9vb3ZO2Fkv3cAtF7fnPdWVXQTraRv/c032AmjwOMXCcvz2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(66946007)(31686004)(53546011)(66556008)(478600001)(83380400001)(52116002)(6486002)(966005)(66476007)(2616005)(110136005)(8936002)(86362001)(38100700002)(2906002)(16526019)(186003)(8676002)(316002)(31696002)(36756003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJRS29aTHliZXZ2RFZwUm9uM0ZGSDN0MVBXeHVwc3gra0RkSE1kWEIxN1lK?=
 =?utf-8?B?d3hyY0xLM3RpcmY2bUU0MnA4dUFlaEZyWGVzODN2bHQzWEFDTGcvNkxYNXpw?=
 =?utf-8?B?cTYvdjN2aHBOQm9odjgrNE1vNXpkbW5uLzMwcUg0Q1ByNFBUa1NydFFDcmh3?=
 =?utf-8?B?eng5dVo1WUZpSnBTVFppVjhGQlpaQTlnYjk4UlVPZTFhVmNneE9QMGpsU3I2?=
 =?utf-8?B?U0JHT05WbVpwelN2U2xjOUFjR3ExQk5rL05SUU1hODZRQVBWZ2d4T2FiQ3Np?=
 =?utf-8?B?dmZiTVg0ZUo4Vys4M0NqMnJVTXNvY2NwZXhUZkpvd0NWTWtRdjloV1ZsZVRr?=
 =?utf-8?B?eFpoblRMQnJQeC90R3pIRjRRbHFyV01rMUg0bVI3c00wWVd0bFBPZnlYSWtY?=
 =?utf-8?B?U3R2YnpobUpTZGNjNTJ4cE1BdWY1ZGFXNnFIOWRSK3RwM0g5SEVBZzUrV3hz?=
 =?utf-8?B?OVY0YXMyL3ZQejdSQitIQ3FncVR3cE04MVpvKy8xMzN2MVdOdUVjOTU3M2ZE?=
 =?utf-8?B?WlpWei9nRWR1M1dZN0pEUVNXaHp1T3hteEhnRFFUaFprWnNMdUMzckt0Y3dw?=
 =?utf-8?B?ckR3SjJWT0x3NFV5cGgzOEN6TWcvMzNPeW1CQlBxSGg5SFo0aDhuQ215RzRM?=
 =?utf-8?B?VHJtSzNWWnN5MGlqWWpkRVBycEk3bVN1RW9mZUJFUWVINlhCTlAzd3luV1BF?=
 =?utf-8?B?VTk4dTlxWXRsU2tORHdHTXdXcHBqdVg1VzJWZlArQzljWldqN2M4eDdFNlRZ?=
 =?utf-8?B?T3JZNVdXTlFLOG85NWpINW9PamRkQURvQS9kT2dpNGtGemJYNE9LRkVlc2N6?=
 =?utf-8?B?cUkxTE4vU0Z5c3NNelMyTzYxTFhZckQvVEs4QmFIaEx4SFdKMnZGSkdlK0wz?=
 =?utf-8?B?eGJVS01hV1BGc3BWU2krenl5UEZIOS8zaXAxUWd1UnFMbFk3KzFpYXNVbWR5?=
 =?utf-8?B?YVhYR1dRN3ZJK1Z1OURjUTBrK29uRkhJR0ZMOVN5QmtUVS9ocTlRSFFuVHBa?=
 =?utf-8?B?WjcwaUZrdllwcDY0cmFoSEpabjUrMVdSTnFJeHUxcWhOT2RjNWVSeXJqZXJR?=
 =?utf-8?B?RXpyaC84eXdtc3BqcXlEVDhGamdMQ3phalBTK0hxNVZwdlN4Uzlqbm9oWG5E?=
 =?utf-8?B?T1NoWG41biszWk0xd2FweHo1ZWVDcjVZUGg4eElneU5iTWhQcGFqSDI2SFhU?=
 =?utf-8?B?STdZUkpiZnFtN1k3Zk9JL205WG95SmxvZWpONTBDTXdYSmkrU04xczdPUDZV?=
 =?utf-8?B?emI3N2o1VFZCd3RDSjVWUXBjNkp5UTFaa0pXelAzNnFGcXlMSEZvU0F0dDQz?=
 =?utf-8?B?czM2UHJXazkxR0Z4TXNxaWxwNVRkNEd6LzZoaGRwcEtac2ltTHA4T0Erb2Ez?=
 =?utf-8?B?TXpOY3dKU002OVN1Sktadk1RUmZvMWd0ZHkvcjFFUk52REpnUm4yZkNTSFZM?=
 =?utf-8?B?VDVwSnZXM0t0Tm1FUk5vd2FiR0RxbkxYcUNyd3Y1OUw0Ky92QnNBaVpKOHhr?=
 =?utf-8?B?bHVkS1JNVEh4eGcveWhlSSs2VGUzMFBtUEE0OHdHc2E0dUlmL3diZUl0NlFP?=
 =?utf-8?B?QjFaZVZiYWxxYUVCQy9PVDhRRmpsNnE3QXVFUFdCNlh5eXRoM0M0bk43akQ2?=
 =?utf-8?B?U1J6d0lKVk8wd0w3YS9sRzNOOXdQa3lTTVlKb1pjM3NBUUl6TlNJTXBpRzhu?=
 =?utf-8?B?dktkODdzSVI1VlZtK2N3QW83STREMEEzemlnNmdrZ3FvNCt0czZuajFsU2w5?=
 =?utf-8?B?NmRHNFEraWczc3N4YzErK005c3VjNlNheW1IdkxFMHh3UENneWhLVFhwUUF0?=
 =?utf-8?B?NFkyL2ZXQ0VkMzN6cTJDUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a2c92a-87da-4b60-5431-08d9354268b9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 05:55:59.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0FI+Wss/JLTRlUzHtDn+pOnV8emRZJI09fXgvNgi6Xy/ATDJV8a4+LuPOou08HZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3982
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: _hNS45aRB92Q0S5z7piuB6pHKvcR83aR
X-Proofpoint-GUID: _hNS45aRB92Q0S5z7piuB6pHKvcR83aR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_04:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=913
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220036
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/21/21 6:12 AM, rainkin wrote:
> Hi,
> 
> My ebpf program is attched to kprobe/vfs_read, my use case is to store
> information of each file (i.e., inode) of each process by using
> map-in-map (e.g., outer map is a hash map where key is pid, value is a
> inner map where key is inode, value is some stateful information I
> want to store.
> Thus I need to create a new inner map for a new coming inode.
> 
> I know there exists local storage for task/inode, however, limited to
> my kernel version (4.1x), those local storage cannot be used.
> 
> I tried two methods:
> 1. dynamically create a new inner in user-land ebpf program by
> following this tutorial:
> https://github.com/torvalds/linux/blob/master/samples/bpf/test_map_in_map_user.c
> Then insert the new inner map into the outer map.
> The limitation of this method:
> It requires ebpf kernel program send a message to user-land program to
> create a newly inner map.
> And ebpf kernel programs might access the map before user-land program
> finishes the job.
> 
> 2. Thus, i prefer the second method: dynamically create inner maps in
> the kernel ebpf program.
> According to the discussion in the following thread, it seems that it
> can be done by calling bpf_map_update_elem():
> https://lore.kernel.org/bpf/878sdlpv92.fsf@toke.dk/T/#e9bac624324ffd3efb0c9f600426306e3a40ec
> 7b5
>> Creating a new map for map_in_map from bpf prog can be implemented.
>> bpf_map_update_elem() is doing memory allocation for map elements. In such a case calling
>> this helper on map_in_map can, in theory, create a new inner map and insert it into the outer map.
> 
> However, when I call method to create a new inner, it return the error:
> 64: (bf) r2 = r10
> 65: (07) r2 += -144
> 66: (bf) r3 = r10
> 67: (07) r3 += -176
> ; bpf_map_update_elem(&outer, &ino, &new_inner, BPF_ANY);
> 68: (18) r1 = 0xffff8dfb7399e400
> 70: (b7) r4 = 0
> 71: (85) call bpf_map_update_elem#2
> cannot pass map_type 13 into func bpf_map_update_elem#2

This is expected based on current verifier implementation.
In verifier check_map_func_compatibility() function, we have

         case BPF_MAP_TYPE_ARRAY_OF_MAPS:
         case BPF_MAP_TYPE_HASH_OF_MAPS:
                 if (func_id != BPF_FUNC_map_lookup_elem)
                         goto error;
                 break;

For array/hash map-in-map, the only supported helper
is bpf_map_lookup_elem(). bpf_map_update_elem()
is not supported yet.

For your method #1, the bpf helper bpf_send_signal() or
bpf_send_signal_thread() might help to send some info
to user space, but I think they are not available in
4.x kernels.

Maybe a single map with key (pid, inode) may work?

> 
> new_inner is a structure of inner hashmap.
> 
> Any suggestions?
> Thanks,
> Rainkin
> 
