Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C031DB003
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETKWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 06:22:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgETKWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 06:22:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1DACEE65830E18F0CE88;
        Wed, 20 May 2020 18:22:20 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.10) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 20 May 2020
 18:22:13 +0800
Subject: Re: [PATCH] perf bpf-loader: Add missing '*' for key_scan_pos
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <mark.rutland@arm.com>,
        <guohanjun@huawei.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <wangnan0@huawei.com>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20200520033216.48310-1-bobo.shaobowang@huawei.com>
 <20200520070551.GC110644@krava>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <ac38c44e-ebce-28eb-37f5-bf05572b9232@huawei.com>
Date:   Wed, 20 May 2020 18:22:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200520070551.GC110644@krava>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.10]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2020/5/20 15:05, Jiri Olsa 写道:
> On Wed, May 20, 2020 at 11:32:16AM +0800, Wang ShaoBo wrote:
>> key_scan_pos is a pointer for getting scan position in
>> bpf__obj_config_map() for each BPF map configuration term,
>> but it's misused when error not happened.
>>
>> Fixes: 066dacbf2a32 ("perf bpf: Add API to set values to map entries in a bpf object")
>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>> ---
>>   tools/perf/util/bpf-loader.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
>> index 10c187b8b8ea..460056bc072c 100644
>> --- a/tools/perf/util/bpf-loader.c
>> +++ b/tools/perf/util/bpf-loader.c
>> @@ -1225,7 +1225,7 @@ bpf__obj_config_map(struct bpf_object *obj,
>>   out:
>>   	free(map_name);
>>   	if (!err)
>> -		key_scan_pos += strlen(map_opt);
>> +		*key_scan_pos += strlen(map_opt);
> seems good, was there something failing because of this?
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> thanks,
> jirka

   I found this problem when i checked this code, I think it is

   an implicit question, but if we delete the two line,  the problem

   also no longer exists.

   thanks,

   Wang ShaoBo


