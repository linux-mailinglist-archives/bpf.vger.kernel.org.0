Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B7148461
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 12:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgAXLDg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 06:03:36 -0500
Received: from relay.sw.ru ([185.231.240.75]:60920 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbgAXLDd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 06:03:33 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuwk4-0001UQ-3m; Fri, 24 Jan 2020 14:03:12 +0300
Subject: Re: [PATCH 1/1] map_seq_next should increase position index
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
References: <d6e2df39-919e-8d37-0668-5c4bbf19f278@virtuozzo.com>
 <be6d3c0d-c9e6-d6f0-ac07-0467480e77d6@iogearbox.net>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <468c8645-1441-2f7a-5fa8-8cc7737c44c7@virtuozzo.com>
Date:   Fri, 24 Jan 2020 14:03:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <be6d3c0d-c9e6-d6f0-ac07-0467480e77d6@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/20 1:03 PM, Daniel Borkmann wrote:
> On 1/24/20 7:17 AM, Vasily Averin wrote:
>> if seq_file .next fuction does not change position index,
>> read after some lseek can generate unexpected output.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>   kernel/bpf/inode.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>> index ecf42be..9008a20 100644
>> --- a/kernel/bpf/inode.c
>> +++ b/kernel/bpf/inode.c
>> @@ -196,6 +196,7 @@ static void *map_seq_next(struct seq_file *m, void *v, loff_t *pos)
>>       void *key = map_iter(m)->key;
>>       void *prev_key;
>>   +    (*pos)++;
>>       if (map_iter(m)->done)
>>           return NULL;
>>  
> 
> Hm, how did you test this change? Please elaborate, since in map_seq_next()
> we do increment position index:

Position index should be updated even if .next returns NULL.

Sorry, I've not tested this case.

$ dd if=AFFECTED_FILE bs=1000 skip=1

With any huge bs it will generate last line.
If you'll specify bs in middle of last line -- 
dd will output rest of list line and then whole last line once again.

> static void *map_seq_next(struct seq_file *m, void *v, loff_t *pos)
> {
>         struct bpf_map *map = seq_file_to_map(m);
>         void *key = map_iter(m)->key;
>         void *prev_key;
> 
>         if (map_iter(m)->done)
>                 return NULL;
> 
>         if (unlikely(v == SEQ_START_TOKEN))
>                 prev_key = NULL;
>         else
>                 prev_key = key;
> 
>         if (map->ops->map_get_next_key(map, prev_key, key)) {
>                 map_iter(m)->done = true;
>                 return NULL;
>         }
> 
>         ++(*pos);                    <------------ here

You are right, I've missed it, it should be removed.

>         return key;
> }
> 
> With your change we'd increment twice. What is missing here?
