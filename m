Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB64354FF
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 23:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJTVLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 17:11:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231358AbhJTVLR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 17:11:17 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19KJuCLI008375;
        Wed, 20 Oct 2021 14:09:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nfIjbZW6Uyg6c+ggrVKFiPjbQRgtOSzSbQVKHtrcADg=;
 b=gH3sjBvaMWT1Da9vYFtt+kTB83vuXZkLL7p+N93vnFU9LE9qNLUry7fM5eWp733+TEFW
 quKityUqZ042pao+Ro/94bUgD5k8giNHMQ1c4nOffWOHPOQYyg74v3DBpxWgsi4uqG8T
 os2F2VOrYKo7gcZ15J8N0u0ZFglimNsMc3o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3bt9uwfd87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 Oct 2021 14:09:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 14:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYxLLLoAxVjpJcRagYmaaDQ1U3nv7Cj1biagTqpGVjNelODjRixUpgaHwoe3UtVkns4Vhg2VXym12xNSEGjbwhB8Kzn8b4GuP/tLkxRHKwOVT5HyHNTUYNAIPrwKwY6tc47Cg1cNIbmQE/y93lqzJFH+N+Vat4f+Zl0c3oG1F3WVDC+sVWiuIBiNq59EmbIDz4DmdKpdHTSR3n+dp2rtlAy3tFn2m+mJE7kg+u84PT0algBeQhYgpUBj1HgW3C0WNP0hLcXVX9nFz14oDeryO2qVIEhBJJEDOkeqBsr2YLMCZuoql0AHx40OptG4WNa7U/WAlPgn1bRknT5H7in1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfIjbZW6Uyg6c+ggrVKFiPjbQRgtOSzSbQVKHtrcADg=;
 b=VuIfSQvo0UsNtlja24tNdy9zFjh+Cv+8TFC+GjgsX9oVnTwJZKF0rppUS43ur7F8j8SnG9L+VrEL6+BnpWXxzj6OQYtgrpIO9+LVl1t4TVvCIIwzSX+r1Pw6+bKLyoi26mZLmS9yO2lyPuEHSF3fG0iXmrTdSdSTMffvGI76GPKBdjtpY3D/wtyTSRsPjWDR/ZoMKwx4G8GrXfnVPQxtChwiJ99pl0HyIq0eyY6Qh0RVWEguzOZdzkHtQ+QQ9btQU7SzDyjbk+GlJGidCIrvqt+dre9kKtI1ZywS1uyrkT4YkIGgonLCOffE3cDcE5eFKQo8Qlo5wyz1lYVt2L467A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2464.namprd15.prod.outlook.com (2603:10b6:805:25::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 21:08:57 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::24b3:adef:9e0:a96a]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::24b3:adef:9e0:a96a%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 21:08:57 +0000
Message-ID: <c7b2715c-7c67-a91a-32b7-d613853e4ffa@fb.com>
Date:   Wed, 20 Oct 2021 14:08:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH bpf-next v4 2/5] libbpf: Add "map_extra" as a per-map-type
 extra flag
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-3-joannekoong@fb.com>
 <CAEf4BzarQqJc38ZQGTtSgfbkVtWPoRgj4xLqkkc7nEGw8RvkRQ@mail.gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAEf4BzarQqJc38ZQGTtSgfbkVtWPoRgj4xLqkkc7nEGw8RvkRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:303:8c::23) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::14a5] (2620:10d:c090:400::5:9d0c) by MW4PR03CA0138.namprd03.prod.outlook.com (2603:10b6:303:8c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 21:08:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eb9b153-43f0-4a6a-86a0-08d9940dd4d3
X-MS-TrafficTypeDiagnostic: SN6PR15MB2464:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2464FC089B621EECEC640C98D2BE9@SN6PR15MB2464.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsiibvYdjSlrnD6DattULfPnoO+GFnNSKS/NYkNF53TCO8o7lz7gOzTRySidb1OpTq7imGtQn8D+GAHlHH6F01P9LKRmLmW8Zk0voI3kBVYI34oayxfnUNgTSiT87uYbiJG6Vkr3HQAzRp4+WaOjqb+EwTgZ+aIiJQ7QSaeEIxCVa0FEp8DymE4SAZ8eSLdJB25mWgCTqQYnB/cUUmfVugCqvKggLqvv+zQGXYQmh8FbgOVvTUPHEJ/3v7rgfe4PLBxPNP8YqU/PdI2CIvDiUVwq8jhsBTjVnxHxGUDWlpFxhCZWzlQ7o+znF6TmNubWfIhmJEGPO+0Gm+UIEgkL/n+KUWjzBNs7WkBExpRW8Ghrj9mKeZXT372wBGkM+l0z9W2FdYrMXiYPyBsQuLFmy3KX03qmFt0NXSKXCEpC8tFhcn5tGWa0OswMxlYoTmnP+k77NYyscQUaz6beNV5D2LCxiahaMQ9WomYkW4MItstZ1fgkW2Nj5oVvznjicUOHcM6eIF7hdeVI5fwK/Kf4bJL8KYBErZYjkQQVdKqTKGC61rsRWVlOvaycI7eZlOMbIWC9ogKkraYwTyDjVmsVgiAigeBw/F5D5CH80aU0i/UA/DDxwlHKQPbrfDc7M53LRxuV6UhK2nBO54vw3g7jxIUnS5DtCEVi5Aw8wWMC2BwqQBjA1pMXgJPYtHobyQkgyzRKQtkTdOcweDewvSpLXdpKXvlpXeKfd6JY9HFqfak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(186003)(2906002)(316002)(86362001)(508600001)(54906003)(31696002)(38100700002)(5660300002)(36756003)(8936002)(6666004)(83380400001)(66946007)(4326008)(6916009)(66556008)(8676002)(53546011)(6486002)(66476007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk0rWXlkQ2Nyb25nL1VSdVRwU0FYM1dNZkFrMkFVZHBGMXczVG1pNkFZS2F2?=
 =?utf-8?B?UklNUldRai8yQTlUR0pTYjQ5WXdOdmJkeUFSSWQ2cXIrOW9jeEh2bU9NYlNx?=
 =?utf-8?B?VDc5NWpIS0J5WlZWSEdrOWVmeXFKdU50REFEcjdvZ2lLU2RkQUQ0WGd1RVNa?=
 =?utf-8?B?SFg5Qy92dE1SaC9LSDRWd213UWJrelJ2QkNLOWthcDA2YnhjZlFyTTZIazdM?=
 =?utf-8?B?bXVWQXFyTjlIb2RqYWlZcEkrUko5UzUvaGQ1aFBGVWpPbUVDNFp4b1JrR1Zj?=
 =?utf-8?B?SWxhdDRCUTlra2VyV29VZ1Q3YTBqbm8xK2RKeDRVb3hMMklGY3N4elY1cU5P?=
 =?utf-8?B?bUdsL3h4QVlVRUVXbkhkR2VjLzRDM29rTUhFT0QzSXRxSmdhOGNjazU1M0Q3?=
 =?utf-8?B?bDBvcnZqTndBTlBnSHYvTWxXS01JU094cDRReHowRVlHQVNxTHdMN1hwZUk0?=
 =?utf-8?B?TFVmUDFIZzRtRFh5eTl4S1ZodjQzdUR1Q25FampjakhhMklXOGRWeWpxMDhP?=
 =?utf-8?B?aFJsQk9Pc1djSzlINEczMjlCUVQrd3NlN0hLNU0rei82cW9CWXVidlU2Q0lD?=
 =?utf-8?B?OUR2YUhEV1k2OGwrZFJQYnhQUndFZ1g4NGpzZGd6Q1FCdU9uUlUva200TEQ3?=
 =?utf-8?B?WUgyMWl2OWN4bmJHZDhaYVVXWkhZR1E2WG9HRm9FMFZhZVVIdTQveGpLd3Bo?=
 =?utf-8?B?YVViZDFkMG1FTFl5SmY2R0xRS2JzczNoVm0rY1IxK1FCUGV6bURSempVQUF1?=
 =?utf-8?B?REJOUm5ZcHlBbzZxTUZRQ0sxc0JUS0dXU001RmxydzFRTE9kM1BQMWpMKzhw?=
 =?utf-8?B?L2hrcThoZXNqQjRVYzVrMjc2bXh0VWIrSmU1VlhjbUlyOEM2SDVNQlB6dnR2?=
 =?utf-8?B?bktJNWNXMHhiY1c1Y2lxZDExKzVWMGhsMWNxbkxnRkhjeldTL1hGUkhoVVNX?=
 =?utf-8?B?N0RxSXUxS2Rkb3l3bWJnbm9VWDZUWmY2RTVtdFFnRk9qaUdQa0pqaVlEZlVD?=
 =?utf-8?B?K21SQVlHMkNFOS9HQmhYS0pET0pmdkowaHVlck54aDFkNm1tL0MrVXYxM0tT?=
 =?utf-8?B?ZXc1MUNFWlRWWEpPaWpWVUpLR2M1bVF0NVdBa3NsWEFLc2pzTzlTN3Nlc3V3?=
 =?utf-8?B?aHcyRTZkK2dCeXEzWldCR1NxYWJhNUJPWDIwaTU4QXpiM2JNRlFneng5Ull5?=
 =?utf-8?B?TkNINm5aYnZHVW9zVGtQeW90Qzg4NWhpdzZ0OG1pL1QyWGdQV1NhN0gvYXgx?=
 =?utf-8?B?MFRZT3BUOU9nLzloWmtMcHUvQlg1SUVIRlF5NEFWWXRFSjJXUU5RYkRTKzkx?=
 =?utf-8?B?THB4THV1TUo0ekZSeGNVb2xjOEZ2aTRDV2dkMkwvbi84ZFBFZlF6NVVDR3pN?=
 =?utf-8?B?NUVzMDBLZWFpcHhjcDJmSzFpelRoTjB0TS9jaGk0Y0lYd1B1SUNVZTNTMDNp?=
 =?utf-8?B?TmZjb2treGJDTjZVRXBsYWVMTmkraWRkQVZDc0xTNGhaOWtOZzU3NERienU3?=
 =?utf-8?B?SERQK2lvSkVJMWRsV0sxcDZLcUR3Y21TZUc0M1R3VTRPT2NRbkFjUWE0UWFT?=
 =?utf-8?B?Rm9mYVhWc1RLbG5IczNYck5jYS9VZTNWWDUvM3NGMnNEc3lhTytQaU9HWDZU?=
 =?utf-8?B?UXJsY0Z6blk0eW9mck0vZ2dEWStUWmpucG9ndzR6TmNNVklzVDRPSlN0MVcy?=
 =?utf-8?B?elhneEVGMU9PR0I0eDRwS2drTW9QYkdvd2ZwSms5VEdPNHpkVjZmeWlBMU5F?=
 =?utf-8?B?N0syZGxhOUlOZUdKYUxYbG40L3pNRXVIdXd2SnZZUkdRa2lqZFFYUzJuc0sv?=
 =?utf-8?B?eFcwcDBFNUxWT21QMFJZQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb9b153-43f0-4a6a-86a0-08d9940dd4d3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 21:08:57.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joannekoong@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2464
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: j09ygMfhF5cX6HafhFStVfGeusEJpJY6
X-Proofpoint-ORIG-GUID: j09ygMfhF5cX6HafhFStVfGeusEJpJY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/8/21 4:19 PM, Andrii Nakryiko wrote:

> On Wed, Oct 6, 2021 at 3:27 PM Joanne Koong <joannekoong@fb.com> wrote:
>> This patch adds the libbpf infrastructure for supporting a
>> per-map-type "map_extra" field, whose definition will be
>> idiosyncratic depending on map type.
>>
>> For example, for the bitset map, the lower 4 bits of map_extra
>> is used to denote the number of hash functions.
>>
>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>> ---
>>   include/uapi/linux/bpf.h        |  1 +
>>   tools/include/uapi/linux/bpf.h  |  1 +
>>   tools/lib/bpf/bpf.c             |  1 +
>>   tools/lib/bpf/bpf.h             |  1 +
>>   tools/lib/bpf/bpf_helpers.h     |  1 +
>>   tools/lib/bpf/libbpf.c          | 25 ++++++++++++++++++++++++-
>>   tools/lib/bpf/libbpf.h          |  4 ++++
>>   tools/lib/bpf/libbpf.map        |  2 ++
>>   tools/lib/bpf/libbpf_internal.h |  4 +++-
>>   9 files changed, 38 insertions(+), 2 deletions(-)
>>
>> [...]
>>
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 7d1741ceaa32..41e3e85e7789 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -97,6 +97,7 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
>>          attr.btf_key_type_id = create_attr->btf_key_type_id;
>>          attr.btf_value_type_id = create_attr->btf_value_type_id;
>>          attr.map_ifindex = create_attr->map_ifindex;
>> +       attr.map_extra = create_attr->map_extra;
>>          if (attr.map_type == BPF_MAP_TYPE_STRUCT_OPS)
>>                  attr.btf_vmlinux_value_type_id =
>>                          create_attr->btf_vmlinux_value_type_id;
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 6fffb3cdf39b..c4049f2d63cc 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -50,6 +50,7 @@ struct bpf_create_map_attr {
>>                  __u32 inner_map_fd;
>>                  __u32 btf_vmlinux_value_type_id;
>>          };
>> +       __u32 map_extra;
> this struct is frozen, we can't change it. It's fine to not allow
> passing map_extra in libbpf APIs. We have libbpf 1.0 task to revamp
> low-level APIs like map creation in a way that will allow good
> extensibility. You don't have to worry about that in this patch set.
I see! From my understanding, without "map_extra" added to the
bpf_create_map_attr struct, it's not possible in the subsequent
bloom filter benchmark tests to set the map_extra flag, which
means we can't set the number of hash functions. (The entrypoint
for propagating the flags to the kernel at map creation time is
in the function "bpf_create_map_xattr", which takes in a
struct bpf_create_map_attr).

1) To get the benchmark numbers for different # of hash functions, I'll
test using a modified version of the code where the map_extra flags
gets propagated to the kernel. I'll add a TODO to the benchmarks
saying that the specified # of hash functions will get propagated for real
once libbpf's map creation supports map_extra.


2) Should I  drop this libbpf patch altogether from this patchset, and add
it when we do the libbpf 1.0 task to revamp the map creation APIs? Since
without extending map creation to include the map_extra, these map_extra
libbpf changes don't have much effect right now

What are your thoughts?

> [...]
>> --
>> 2.30.2
>>
