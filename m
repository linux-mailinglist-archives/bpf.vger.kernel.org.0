Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47C148030
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 12:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbgAXLIZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 06:08:25 -0500
Received: from www62.your-server.de ([213.133.104.62]:34054 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbgAXLIY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 06:08:24 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iuwp3-0006n6-Dj; Fri, 24 Jan 2020 12:08:21 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iuwp3-000Hr1-4F; Fri, 24 Jan 2020 12:08:21 +0100
Subject: Re: [PATCH 1/1] map_seq_next should increase position index
To:     Vasily Averin <vvs@virtuozzo.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
References: <d6e2df39-919e-8d37-0668-5c4bbf19f278@virtuozzo.com>
 <be6d3c0d-c9e6-d6f0-ac07-0467480e77d6@iogearbox.net>
 <468c8645-1441-2f7a-5fa8-8cc7737c44c7@virtuozzo.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a17c846a-f957-1506-d397-bdc1ee957fab@iogearbox.net>
Date:   Fri, 24 Jan 2020 12:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <468c8645-1441-2f7a-5fa8-8cc7737c44c7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25704/Thu Jan 23 12:37:43 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/20 12:03 PM, Vasily Averin wrote:
> On 1/24/20 1:03 PM, Daniel Borkmann wrote:
>> On 1/24/20 7:17 AM, Vasily Averin wrote:
>>> if seq_file .next fuction does not change position index,
>>> read after some lseek can generate unexpected output.
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>>> ---
>>>    kernel/bpf/inode.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>>> index ecf42be..9008a20 100644
>>> --- a/kernel/bpf/inode.c
>>> +++ b/kernel/bpf/inode.c
>>> @@ -196,6 +196,7 @@ static void *map_seq_next(struct seq_file *m, void *v, loff_t *pos)
>>>        void *key = map_iter(m)->key;
>>>        void *prev_key;
>>>    +    (*pos)++;
>>>        if (map_iter(m)->done)
>>>            return NULL;
>>>   
>>
>> Hm, how did you test this change? Please elaborate, since in map_seq_next()
>> we do increment position index:
> 
> Position index should be updated even if .next returns NULL.
> 
> Sorry, I've not tested this case.
> 
> $ dd if=AFFECTED_FILE bs=1000 skip=1
> 
> With any huge bs it will generate last line.
> If you'll specify bs in middle of last line --
> dd will output rest of list line and then whole last line once again.
> 
>> static void *map_seq_next(struct seq_file *m, void *v, loff_t *pos)
>> {
>>          struct bpf_map *map = seq_file_to_map(m);
>>          void *key = map_iter(m)->key;
>>          void *prev_key;
>>
>>          if (map_iter(m)->done)
>>                  return NULL;
>>
>>          if (unlikely(v == SEQ_START_TOKEN))
>>                  prev_key = NULL;
>>          else
>>                  prev_key = key;
>>
>>          if (map->ops->map_get_next_key(map, prev_key, key)) {
>>                  map_iter(m)->done = true;
>>                  return NULL;
>>          }
>>
>>          ++(*pos);                    <------------ here
> 
> You are right, I've missed it, it should be removed.

Ok, please respin v2 then.

Thanks,
Daniel
