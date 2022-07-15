Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006F957657B
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiGOQ67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiGOQ66 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 12:58:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826ED101D9
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 09:58:57 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGH2NV031943;
        Fri, 15 Jul 2022 09:58:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QrxBDHPwfXXIzX66fJCcpOQNWOegZ3ArrticbkzHAvY=;
 b=Tkh49f7RoOOHyBs9Mwebw4+54Qs9RKMDlwdECkhV/UT3oMDmx3XO6xA0vmfMBGPqj1Uf
 dJjhBhs50qaz4DSgbfkpDuHfsQqk533vjpPLg4XzugrJi3P/xCvQmBm39OPg4Zuy3znL
 9lpnS7tULXmtkklolPMPlfDUBrfRqcqAxgc= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hat59wfhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 09:58:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0ItlV1jRhWQx392J184bizwhUfqo7rx+N6y15/GOMjKldE2I838RICMK3g9tV4f6LY3BhSS6Y3ud+Z+g+ZQPyBkQmoxaxdXojdoOvY8uJ6zFmiEegAULwCBFK6cI35+D0PFOROFXm9ASHROQuOHpfbDigUqJAs50RPRBzpMEEi2W+qF/EHL2Bh8WriRhZvOpihqRAXYb44+AfXj8IKkXN/QuqKbVE6ZMEuqi5HW+XdsElsbpvA947mxohJNdHgShklzJXtZ8RT7jCDh+aWT55DGE7wkWgTmPwUAnPaXg24lZPUsqFNC8C7DzBzsHP3PvCzfSROdrZjst2LEkWywMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrxBDHPwfXXIzX66fJCcpOQNWOegZ3ArrticbkzHAvY=;
 b=OoEfKLBZXUOQZObvdQDf9gWsmZicEpkEspSrhMVc0/GEN9AE/bnPvuM2ffUbqJpr/RDIGY7kNWLmV2ep4XzruTfQ9zl8izQ5CtLGSJm1ecy+KLHN9njCxQufoZ6CedzgfuLMP/RVbnvvAXeUXbcUmam7ZyH0RcV/QjKImmO5PYfzqh1WdRNpx5Ll0AEFeovzZcMm6HJ+jpQg6ifZlxH+hA4WSmVBjXv4+jQm3g3NykvTe0HC6HDIIuoKSAJuAoWp8nnq4yA9XlDnD0/KVI0xseHklVsNJcInqUtJHkwsCcOodyCdUNoAlStvkmW1G1VJvtpSSiGQoley542Ge2VlvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1148.namprd15.prod.outlook.com (2603:10b6:3:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 16:58:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 16:58:41 +0000
Message-ID: <36d47140-b144-0f72-d79c-18b8f3d3be5e@fb.com>
Date:   Fri, 15 Jul 2022 09:58:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next v3 1/1] libbpf: perfbuf: Add API to get the ring
 buffer
Content-Language: en-US
To:     Jon Doron <arilou@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
References: <20220715141835.93513-1-arilou@gmail.com>
 <20220715141835.93513-2-arilou@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220715141835.93513-2-arilou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0fe495a-ceac-43d7-8c53-08da6683451e
X-MS-TrafficTypeDiagnostic: DM5PR15MB1148:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsKgBJGA3lUSshjQgyUyN+BHTsyQ28b46eZckfzH2z2RTbEpBUZeOfnURApFKNQT+50y0+yNzLYP1Gmllwh/1vO1cjyKvOVuzjNTupcSoB7CM2TpZ1nBRmkLhOXDcgGEeR9A7OIJGLqQrruSJwbaJYBf59KT1Um/yW1WCtY5BbIJ3mjfezjImC9aNN1A2g8CHvNY9WqC9rMQxM2zwb3fbU9XkuPtR+7QoZTaoP7CIWfoLvYr/FkXpVQyOtGCx7OvEvZQRQ72t2IL2Gh9snSSaQy7i/S5ZpAPBzzF3LpNdj6/FBRZDzUve8E+9M8TQVOefb1aBpb7tfjtI2hn16Avz6iFh99XWStOCbf+X/kQgwHCv04VQFK8ky7UOK0ZvY/w5agtZq2znKUOAq4AEO0lRnnhumX9fmW6rsDBTmyyoJH+MWk0GnW8CAdePc9qsLoXbUWShA09wJdP2wJ1Iq7W4RcTx3hMAqgVPUlmqKeLxNC6OoRYZINzKXRD685IenUo9GYXqukkFwjS9gnW1iSqIU0fDKeGtNVbkkMDEgqCAilL8UaMLniKoL1y3ZckpC8dtBHwAqRWQ5l8bZTX6eP+OkzbK1XC2RmFIbdnVZ35lRIzY3hJLPHafCtf7arPUrbPNFff6cTzttGkYmUtIkSJ8suYExCHFNbtuOt6Zkc78kBVaTtE+ouvxtsMxFC4d5k5NTBGPvqJJ0TJ8gFW9AIH5T+JXCFsM+j9L0eiaEYxON+dBTKusn+xaF9PyQA4l1f/DVekw6XuSgMYgzM5ipxWdtNbwvaFiOJqvtb2T5MJxi99RfNi5ux6ZZYpl3VmTMsE00c1xBkUxQ/ceh45v5OE8iyysPiWtxqJ7n2B/cVlaXhCtxqUjqAwINGzm4CSpmtE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(41300700001)(6512007)(316002)(2906002)(31686004)(6486002)(36756003)(6506007)(53546011)(478600001)(66946007)(38100700002)(83380400001)(186003)(66556008)(66476007)(8676002)(4326008)(86362001)(31696002)(8936002)(2616005)(5660300002)(15583001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxaMmFIRlNzYkZYOFZSV3M3ZjdDdFJWcXNmOTFOYnlzNVVhc3VPTEV3VzdK?=
 =?utf-8?B?VlFqTk1oMTMvVTdTSmlNdlBZNGhWMy80cVdybklDWEo1NXF3dFhvTWRkTUJ6?=
 =?utf-8?B?UVp6dm16c2xkYjBrektnT2ZYclllYy9ndmJXb25RSHdrZ1JNemVLMVV5U0hs?=
 =?utf-8?B?alg5UkExWURnWTU1YXhHZ2tSK2dBUzhDRWtPS3grSnp2N0JoVFNKeGtuZUtU?=
 =?utf-8?B?c3UvRU1NbUc0WmV0M2VkTHNVZkE5ODhJOFhpOW52SzRBdUgrblE1QmdUeEVI?=
 =?utf-8?B?OE1XbU1TemZJb2xIVVYyVEN3V1p5ZXBHSGlIMkRGeUZYcy85VTNyOUl3U0hC?=
 =?utf-8?B?TWZaVWJyOUQ3OUI5czZDMG4rVnhxVXpFMHVjWU1UWXNKdmtILzJSQVF6REdM?=
 =?utf-8?B?VXBRSnI4by94QThtKytIYWc4QzJQTkc2OXUzQUgrZGRwanRoMzBHd2s3dXBy?=
 =?utf-8?B?Wk1haDg0b0xuKzMyRXBGMTFQaHNLK0gzRnZYZldnT2dyRWZ4QzJGSlhQZ0tL?=
 =?utf-8?B?MEw4Q0oxTmdlb3doTU1DRW96TWx6WVdsczBLQzFmWVVDTnF6T2p6ZkxZYUNr?=
 =?utf-8?B?dm1WVWd5UlJOTG9Uckg4QzZLVm9ReUJqcUJzN3ZXbm5kbUZ1NUJuM3R3bUtt?=
 =?utf-8?B?c1ZWbXp6U2tTTE9sVGdVTVF6YXpwMlpxY3VYUU15eXZDVjVpS09ZaklVc0w1?=
 =?utf-8?B?WjVENVVHbS84bWNnb0I3MFZxR3I0YVNURlB5S2dFK0w4Qmh1aWFVUGhSdG5Q?=
 =?utf-8?B?Z1I5Q21PQmlmblA5M2VHN0hzWFVLN3F2STRTdUkvUy9ST3k4aFh1bEQyb2t5?=
 =?utf-8?B?VG9mTURicHhMeG5hdGZubmFhZlBDeTlDVk1TT3I3ODVoaVZGWVpxNUdJYTdx?=
 =?utf-8?B?QVdIUFJHUFEyRmt2bjRkWmx4cjZhS1lxVXYzdjhuNFY5azZvTjJJOVNqbGZ3?=
 =?utf-8?B?NnVWMlJSWTM3dytOUENxVGdSa1Qyam1DSXpTRSsyYTdWTnduMGkrSzNZMGpi?=
 =?utf-8?B?ZnhNT1VVSk16cElJUU44NzdJbW1lV1NXeW9TQTZOeEc0Z2NzM2syRDNQTGQx?=
 =?utf-8?B?SlluakR3QlB6cVRlczV6VnZlaHVCdWJ6RklqaGNBK3dHQnlFSUxPNWxNQnFW?=
 =?utf-8?B?OWVmWU5UOVcxWVpOd08vaVZMcmJmdmhEWGR6ajE4MWVYY0oxR0ZGTU5IS3d4?=
 =?utf-8?B?TGJKQWdBQWlRYUJ4NlluMUhOM0R0QTJ3ZmZ0YS8wMERGWDVrZDdVTWNHR3ZO?=
 =?utf-8?B?SmRYbFRZYnNFSStzcStUQnAxWUQzeTVTYXRxS1R5M3hiNkFkdVVuRXNFRGRr?=
 =?utf-8?B?T05jc2Q1eDNUSVRIaEJtSjJreHlNM2NUbHhkUmdnTkt2WENNMlZmOWNDYVAr?=
 =?utf-8?B?NlI4Y1VTZFBYbm15b2R0RUdzdmMxUFZDS2xXbm13RjVBUytBSGE4YU9FRUsy?=
 =?utf-8?B?TXFMc3FJV0VjajRMdC9Eb0pYeWZDN3ZBS0JrU0lTTktmbFFVUVJLb0N3d0tw?=
 =?utf-8?B?NHJxZGZnSTJsWTQvUU1BVU5yWkI1MWp1ZW90L05HYVk1K3lQK1JTeXdjcTF5?=
 =?utf-8?B?UnhRei96ZEV6RkVFZnZ1ODFJdFlEeWZzamZobStBT1l6ai9tQkEvUXNyQVpt?=
 =?utf-8?B?Y0pjR1hKOWVNRzk5M2pndWRiYkhKaEo3YlYwc0MvQnNaVFp2anUwR1RvK3M5?=
 =?utf-8?B?dW8wc2RnUVBvcWllaTVyTXZPTVlac3dheHl2RnNWNE5wbkZUWFYydjVGOGtE?=
 =?utf-8?B?L3lIcmkrdlgvQUJZZ25LdHZ1QnlGc2RrQldaNEdxYVJVU3BFdk9MWEFPTSs2?=
 =?utf-8?B?NFBUZUdVQUF3TE5GS0tacnFzajI1Z3Y1THFRNUlCcUlqcC9xeVhYUjZUazZp?=
 =?utf-8?B?VTF2R2IyVURISFJhejIva2c0RXRuQ2FrQmtNZHg0bWJ0SmNEci9ISlFrRFdR?=
 =?utf-8?B?TnV4S29OUHh5ZUNXV1BwSkNJeVpLRFRHYXE3MjJxM0VhSDhEVFFIRjhqTFpT?=
 =?utf-8?B?ZUVVNFVOTGI2SFh1VWNyK1NkQUM0SUxaUXIrWnUzNXRPR0hHMWlwZllxbWV0?=
 =?utf-8?B?L0JqaXlOUTJVOWRXNHVod09PTUNMMEdGZjdTUlhVUGtpdVRVclM1MWJLRzBa?=
 =?utf-8?B?ZVFYcFZrSU9iYnJuVUY5YXgyTnJrNCtaZFdOTHVzMXcvYy9LZ0l5YkFXUERJ?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fe495a-ceac-43d7-8c53-08da6683451e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 16:58:41.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTvAxSP5UxRIdR0Wp2GboEzwPf5+Zc1QdBRqBPmubjSpVJSs45F5Yg7zQxaNP/Lk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1148
X-Proofpoint-GUID: ru3G3HjODI32nHX8iAhBo8N3XR69m_tb
X-Proofpoint-ORIG-GUID: ru3G3HjODI32nHX8iAhBo8N3XR69m_tb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_09,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/22 7:18 AM, Jon Doron wrote:
> From: Jon Doron <jond@wiz.io>
> 
> Add support for writing a custom event reader, by exposing the ring
> buffer.
> 
> Few simple examples where this type of needed:
> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>     to handle the wrap-around in some other way.
> 2. Since perf buf is per-cpu then the order of the events is not
>     guarnteed, for example:
>     Given 3 events where each event has a timestamp t0 < t1 < t2,
>     and the events are spread on more than 1 CPU, then we can end
>     up with the following state in the ring buf:
>     CPU[0] => [t0, t2]
>     CPU[1] => [t1]
>     When you consume the events from CPU[0], you could know there is
>     a t1 missing, (assuming there are no drops, and your event data
>     contains a sequential index).
>     So now one can simply do the following, for CPU[0], you can store
>     the address of t0 and t2 in an array (without moving the tail, so
>     there data is not perished) then move on the CPU[1] and set the
>     address of t1 in the same array.
>     So you end up with something like:
>     void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>     and move the tails as you process in order.
> 3. Assuming there are multiple CPUs and we want to start draining the
>     messages from them, then we can "pick" with which one to start with
>     according to the remaining free space in the ring buffer.
> 
> Signed-off-by: Jon Doron <jond@wiz.io>
> ---
>   tools/lib/bpf/libbpf.c   | 26 ++++++++++++++++++++++++++
>   tools/lib/bpf/libbpf.h   |  2 ++
>   tools/lib/bpf/libbpf.map |  1 +
>   3 files changed, 29 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e89cc9c885b3..250263812194 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12485,6 +12485,32 @@ int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx)
>   	return cpu_buf->fd;
>   }
>   
> +/*
> + * Return the memory region of a ring buffer in *buf_idx* slot of
> + * PERF_EVENT_ARRAY BPF map. This ring buffer can be used to implement
> + * a custom events consumer.
> + * The ring buffer starts with the *struct perf_event_mmap_page*, which
> + * holds the ring buffer managment fields, when accessing the header
> + * structure it's important to be SMP aware.
> + * You can refer to *perf_event_read_simple* for a simple example.
> + */
> +int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf,
> +			size_t *buf_size)
> +{
> +	struct perf_cpu_buf *cpu_buf;
> +
> +	if (buf_idx >= pb->cpu_cnt)
> +		return libbpf_err(-EINVAL);
> +
> +	cpu_buf = pb->cpu_bufs[buf_idx];
> +	if (!cpu_buf)
> +		return libbpf_err(-ENOENT);
> +
> +	*buf = cpu_buf->base;
> +	*buf_size = pb->mmap_size;
> +	return 0;
> +}
> +
>   /*
>    * Consume data from perf ring buffer corresponding to slot *buf_idx* in
>    * PERF_EVENT_ARRAY BPF map without waiting/polling. If there is no data to
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 9e9a3fd3edd8..78a7ab8f610a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1381,6 +1381,8 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
>   LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
>   LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
>   LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
> +LIBBPF_API int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf,
> +				   size_t *buf_size);
>   
>   typedef enum bpf_perf_event_ret
>   	(*bpf_perf_event_print_t)(struct perf_event_header *hdr,
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 52973cffc20c..971072c6dfd8 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -458,6 +458,7 @@ LIBBPF_0.8.0 {
>   		bpf_program__set_insns;
>   		libbpf_register_prog_handler;
>   		libbpf_unregister_prog_handler;
> +		perf_buffer__buffer;

You cannot add the LIBBPF_0.7.0 which has been released.
Please add to LIBBPF_1.0.0.

>   } LIBBPF_0.7.0;
>   
>   LIBBPF_1.0.0 {
