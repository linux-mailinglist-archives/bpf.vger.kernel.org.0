Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F6620998
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 07:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiKHGfD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 01:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiKHGfC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 01:35:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707C91EEDE
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 22:35:01 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A7LKxIT028485;
        Mon, 7 Nov 2022 22:34:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=E0bh+tnZYHCIey4tB+66o3J7dEcEgGxetK0t5TyNGZQ=;
 b=Qjl/gnMjW1OTqKV0E//Tse4mTjDAcvrFmq/1irIFkiIejE8iwY51uCjREGMaecixMYCh
 n3MqApJFbKV48LJAEIy3wETi6y8JHifrhSWLG4Dws5EYLEFA0wYMBoYbZ+nkNYEkPwAv
 PopqrCVDMZeEyOobYfypXfxYDkP6toKyTGSyIKDOc/OptVqJE4BvnniAJ1w9mlyph+P9
 8QqdijQz2OkYLF3y+eTPgEpCKCVNog21R8Ht14XrSUKcgHrDtShXcb4S6fLTgxqS7Kpy
 Rpn42L2WuiwKtUkQJo7W+xk9GeiKGK5liPlbbnD7gWIKZhdJKBMr2Ni+PwceJFUZZzq3 WA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by m0089730.ppops.net (PPS) with ESMTPS id 3knkb86j86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 22:34:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XngA8tjeQR9PIdyG9zfWOrgNMAZ7WXbpK2NV31q0t5FNazqMinyfcEi/d6hBVDsjiYDQZg+6t8CvLO5K0LaU5s37nseeO43fmGyGThZrQsTZhEo4sYRxfrysWFuDBONb9XuuhAuyVEIUa6ydnFQkVtwQ9IgUj7iwWiaGpVspJtottSWV0r2eveVUxGfz1l2ZduRPCkfpDfc3PC6ooEwFrUaA5uHLhbWjmxpoBMcqfUztLwcmdCl4Ys+2HijIDWAtxGbJ5efdUUXSWM6nTi3NvFx1t3RVmnzBZpiqc8hhNqss+OpYoip9uWzLXthlSyiQ8RH5StAPic9/KYxDYG5oJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0bh+tnZYHCIey4tB+66o3J7dEcEgGxetK0t5TyNGZQ=;
 b=WUA2C+FjmOX9TzQ7XKwRFIGeyFd07c8VDFCGw9Gu/aVj/ZGgfHiQg4a0H+mszlA4JxqsWkdgP8bOx/lU4nvwiXlMJrGTMOe1uHp4WnYqf0/qJnBRWxnldNJrBlS3knqe1IQH5GE2mbuFAj2Qfb65dPp6pgE7EXlcm06mVmV6UBEQwLbC5DnuVQKbPBJHKj5dHYgrKtD9NsI67Z46dg+VaFVt91+KG3xR9m2TnxsryQkkVOyPBiK9Dxk87AhT8HGgOUsxFXn06PCrmbMf030X7oJZsLnfNyuQhp5/9mxyb9ocB6zXhzaKBm7AOVYpg4UrVSnlUk1hwnMNRWv9bUoKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB2660.namprd15.prod.outlook.com (2603:10b6:408:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 06:34:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 06:34:24 +0000
Message-ID: <d520f61e-e19b-c094-028d-72d481945ffb@meta.com>
Date:   Mon, 7 Nov 2022 22:34:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next] bpf: Pass map file to .map_update_batch directly
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>, houtao1@huawei.com
References: <20221107075537.1445644-1-houtao@huaweicloud.com>
 <ef14ccf1-fc17-57df-fba7-162845be4722@meta.com>
 <7d81cf6f-9881-32cf-d981-9360e33b5f4d@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <7d81cf6f-9881-32cf-d981-9360e33b5f4d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB2660:EE_
X-MS-Office365-Filtering-Correlation-Id: ea51fe80-0a68-44db-7a0a-08dac15346c6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wW2M+Si7syZWBYCu+4QQ3JwV17bYLu6pV5eSRYjC45q9ZQepjrn9m/wUCCHPSCz2sEYXxkQBNBKxop2ARS4O9FWF/sRg2m8l0dr8Z/Wb8LUwvVtfSkRWEddD6TtAuuLlsGuYlaNJFWHVDG9+E/5y7HrLbEbykd+5536qTA+GyVpXJM8aKi8Igqyqlm4fnT95nxFehZf1t8msDwSbjHAObsK8JF78KHp13ZGyB38CUc5FcNh0rLHLGPw9APEoNVlorIOROutybooBuu/dhc0keeVe3D7iKPgLWr8EouyR7Ltu6UqdVHCpmZzffcw4RxMC5h0pxLgc9sMJ8qNVWC2bJvT0ezn3xxZ0uuEQBstbLA2Y8vZNTWBXs5Z+BaIhanGZZE4ecuNBJq3gzGUUe7ICRvtZP92uamKgA998oHp0lmW1p/+cTnNRr3SlgAreZd++qi94qJpSI6G/XEzXY/VlKMpu+L6L3GykXzHt7ipxrMR81HCYqgQrVs0dvvwAeoqT6LKCoE7F3dgjVrqPr7fdfx6zxQWDXslfpCudyJk0asHFeGQV/5+muQpFcNeneQDAjHHb1IOvQimnmt5YptRGItsZFg6UVL3GjWJYMdOhhYaUJwyj6832T130DF332hswuAUQz8wgX/N8bIIG3/HkfatuabflvOoFXLu/IWLtlYr7WD2zWKudoHmrHwPqRbpPQynJBKsZZ8v8YVYu6yEhzvtuo4eaHTr1ryS8cM9KJHtE0+eYwj7q8GrJZrAdHp7NeQCcxHmvzU2VYoKldKAktzr5yIl3TGHIXVyFiCsWHUjZgRUqgQAJrnngS/VmQT6p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(41300700001)(6506007)(36756003)(83380400001)(6666004)(316002)(2906002)(54906003)(38100700002)(86362001)(31696002)(6512007)(66946007)(66556008)(478600001)(2616005)(7416002)(66476007)(8676002)(4326008)(5660300002)(6486002)(186003)(53546011)(8936002)(31686004)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUU3d3NWcU1PVHZmTzlGQkhGRTNIWXJqeEM3bnlKK09MQWtsWkNMc0RiRVlT?=
 =?utf-8?B?K292Si9GT0tpQzdJQUgwb3dVb1VzU0lYYnVNNDdsdVNmSUg0dkppYjErN2pZ?=
 =?utf-8?B?ZHc4S0p6K1I5aWhzWnpYU3FVVWJ5UmNwZE1tVk1rdGNmbkl5TDdkUTNONk82?=
 =?utf-8?B?bWpvbzNSQ0FrYmRvK3F1dktHcWpSS2V1WG4yeEc5UCs0ZjM0M0VhcS9JM2Nt?=
 =?utf-8?B?ZGRCM2VZNGZmLzA3TlpQbFQwU2Y0azJBa0NVbnEzdzF6YXVIdnpicXhnRHdk?=
 =?utf-8?B?K1FidzZzOVl4ZlRYZzRGR3VrN0Z0cCs3aE1IeTduRUx0eXhhTkpEUFNvTERL?=
 =?utf-8?B?TEVST1lRbmdMRmtKK2xzc2lDWnVubnl6TmM2aWVHSXNWaXRHK2tIWFdHY25N?=
 =?utf-8?B?QWVPT21IUWxqTkNEQ3c0MHZ2NWtaQ2ZWdmh3RkxONjBvSlZ2K3NnUXVrZElI?=
 =?utf-8?B?UjRTdHZaSHNPY0o5T0EzRVlwejg3SFA3TXBhR00vaHFtbWd6UkRKUmNnN096?=
 =?utf-8?B?RzV0bUEvbHN5SFpNMXE4enRhb3dWQUw4VmpIZEplQ2ZxeUVVY1ZNSFp1UjlT?=
 =?utf-8?B?VjNRMmNlTWZJa2xydm5SYlF3endIL0NGZXN3a0UrNHdaVWNzZWZLUG1QZ0hJ?=
 =?utf-8?B?bmFqSE1lKy9NSkh4TGlnTXJQZFNSckVmL2t1eDhxRzZjZVMrbHN6ZXJ6ZmRq?=
 =?utf-8?B?eHhNS0JWUW9tdWFabUFpb0JVanZwUmpxRW9DMjhreDJjZ1F5MGZVRE5hSTlB?=
 =?utf-8?B?bExmU1FzNDZxUkFGVmc3YlU1NXMrU0Nac0krZndiRHhXWUQ1VWE0bzgzRWRo?=
 =?utf-8?B?eTIwWnpOUnZNTmdGaStNVkFhY1JwS1VRMy9NWTJnRUc4Z1pDWUxZMGZnOCt2?=
 =?utf-8?B?UHl2YkVseEdaL0tmVWllSzJNenNVcDFjcFFtb3JpUnlzK1kyU3U5Q2Z6djdn?=
 =?utf-8?B?SE1yR2VCbC91V2l5Yi92SG5WUzhxNUVYYjY0alNDaDErNFJlUWhUL05LVUhP?=
 =?utf-8?B?VXRrUE1WRlV3SFo4eUdzQTEvMWlEMm1yekpuZFpRdXpqV3NRcUhnMXMzSmhN?=
 =?utf-8?B?RXMwNTlUTmNhbU9xS0ZmQlhLZ2tLSnUvS2Z2SDViQkNLanRheXRtZXhUNjRm?=
 =?utf-8?B?RmNpbGRNanJ4dFNrS2R0V3ptWkFvZWNGM09LWDZLU3hobnl0Q2YzaTROM1NR?=
 =?utf-8?B?OXErTEFVd0lqZUs4aTBMS1JaQWdHQmdlSWlHUnRqeVBMOUlBYVBWcDFId0V2?=
 =?utf-8?B?emxYWEZZYjUwZXVidGdncWUxZk1hMFNBZElRNmJ0Y0kwKzlvYjF4b0c1Rm1z?=
 =?utf-8?B?TEcwdmV3MzBVQ00xZlNmQjhOUkdOZ2NteWFrYW0vSTA0aU1pdGYxM01VUG4z?=
 =?utf-8?B?U3h5WjdTNnpOdDNuV0ZCRW1ORDd1Q2Q4cDNSYXlEOHNVZG11cEpuUU51cis1?=
 =?utf-8?B?VmFrOGRjV00rNDlzM2JxWERzNEFvcVJnL3pjVDdtNXJCbG1qZkRyZGZnU3ZX?=
 =?utf-8?B?OUxWSmd1dlpRN2ZnUE8rQ29pODRlUVJoa3hsTHl3MHdad0psTWdrYmpBRVpk?=
 =?utf-8?B?M0R0TVpHMTJOeXh1SWpmTHVQbmF1azQ2NlI3YWV6VlhUeU9YK01uYTY0TWJx?=
 =?utf-8?B?NDNHZ29YTGdvTDdTNW1IQlZUVTkzZFUrWHNReUh4OHBZVUZBU0hIVm10Rkox?=
 =?utf-8?B?STgvZXhJc0RzN3BWUS9EWGVRNklEbDMyVzZZcCtXREh5cGxkMVlQeG9CL3cx?=
 =?utf-8?B?MFFadnAwYjlOcnI2UVdqY21JWEFwaGhDTXBoRmF4RkgyaTJXRVd4TmJiV08r?=
 =?utf-8?B?RU9OUzVmNlpzMG54RXNuRTU4N2hyT08xdHVEVVpMRjV6UmVBaEZjblAyT3kw?=
 =?utf-8?B?d2Ntckozdjg2Z0l5Y1hHWFJhQXZnV296QWRhbVk0ZFdiZ05NcEZuejNjMmRi?=
 =?utf-8?B?M2YwUUpueHNHQ0Y1ZmtnS0h3Mk1mVlBxbjZIZlk4RzFpcC9tWHYxRlRhY2VI?=
 =?utf-8?B?MWw2WElxdTZYTGpURlEzSVhRSnQvOWhGMXVnMUE2NzYyK3VYanNHZkRDZkhP?=
 =?utf-8?B?eVNCTjNDVy95ZHhkMkJxRENhS2orOTB1NnVOdWVLMXlaWjhzZFkvejN3YWdR?=
 =?utf-8?B?bU5RRmpZaDZycHpnUjVZeW8zeG5FcFdjWVNDaTRqYXVNdklzSndlam5ZZVc2?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea51fe80-0a68-44db-7a0a-08dac15346c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:34:24.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kx5+EZXAV6sYBHxF5Ck73qEjjnTBUOJv4WQDnbIXu91dB7OQjfA0L9xayB6+ClBn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2660
X-Proofpoint-GUID: O8AlOvWxJSWCSzL-j8E-CTAN64KiRC-D
X-Proofpoint-ORIG-GUID: O8AlOvWxJSWCSzL-j8E-CTAN64KiRC-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/7/22 4:53 PM, Hou Tao wrote:
> Hi,
> 
> On 11/8/2022 8:08 AM, Yonghong Song wrote:
>>
>>
>> On 11/6/22 11:55 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> Currently generic_map_update_batch() will get map file from
>>> attr->batch.map_fd and pass it to bpf_map_update_value(). The problem is
>>> map_fd may have been closed or reopened as a different file type and
>>> generic_map_update_batch() doesn't check the validity of map_fd.
>>>
>>> It doesn't incur any problem as for now, because only
>>> BPF_MAP_TYPE_PERF_EVENT_ARRAY uses the passed map file and it doesn't
>>> support batch update operation. But it is better to fix the potential
>>> use of an invalid map file.
>>
>> I think we don't have problem here. The reason is in bpf_map_do_batch()
>> we have
>>      f = fdget(ufd);
>>      ...
>>      BPF_DO_BATCH(map->ops->map_update_batch);
>>      fdput(f)
>>
>> So the original ufd is still valid during map->ops->map_update_batch
>> which eventually may call generic_map_update_batch() which tries to
>> do fdget(ufd) again.
> The previous fdget() only guarantees the liveness of struct file. If the map fd
> is closed by another thread concurrently, the fd will released by pick_file() as
> show below:
> 
> static struct file *pick_file(struct files_struct *files, unsigned fd)
> {
>          struct fdtable *fdt = files_fdtable(files);
>          struct file *file;
> 
>          file = fdt->fd[fd];
>          if (file) {
>                  rcu_assign_pointer(fdt->fd[fd], NULL);
>                  __put_unused_fd(files, fd);
>          }
>          return file;
> }
> 
> So the second fdget(udf) may return a NULL file or a different file.

Okay. Thanks for explanation. It would be great if you can describe
the above reasoning clearly in the commit message since this is
where the bug exists.

Not sure why BPF_MAP_TYPE_PERF_EVENT_ARRAY matters here. Or you just
show BPF_MAP_TYPE_PERF_EVENT_ARRAY does not have a problem. If this
is the case, there is no need to mention it in the commit message.

> 
>>
>> Did I miss anything here?
>>
>>>
>>> Checking the validity of map file returned from fdget() in
>>> generic_map_update_batch() can not fix the problem, because the returned
>>> map file may be different with map file got in bpf_map_do_batch() due to
>>> the reopening of fd, so just passing the map file directly to
>>> .map_update_batch() in bpf_map_do_batch().
>>>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
[...]
