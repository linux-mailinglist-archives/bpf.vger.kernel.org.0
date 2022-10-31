Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16206140B6
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 23:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJaWcq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 18:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaWcp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 18:32:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962B410FC
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:32:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f27so32986075eje.1
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=vvDTkuaUsux+g6wxPiqq82wGh6VnuNHEffXlBYQbqrI=;
        b=stIVvXYzYw7+erjDVtr/Pon2+3gbP0DW+SmaPbkj0Mci/bZzU0uvv6psHQro1aa1nW
         7TvqUwyFIZPX6SBZopDWhYrnbeeZxHdV1imqye/+Z/BOaG+IPeR3kg7riWZLhoscxSIR
         VZ+OjMbEZBOLi0Msf8VqBbE1BP4q4cWnAxluw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvDTkuaUsux+g6wxPiqq82wGh6VnuNHEffXlBYQbqrI=;
        b=yA/LQKu8OE2AXaQLVglep26atl1ox/J4DlZ9b8bBiZRtvc3Q2PuBw187WGDbkbPYug
         7JBMJFWpSE4/yJbMWJkmaasSxwx3QcREes264M4Pdpd8IqTVF0hAuivY3dbRJ5Is/pZ0
         Ekn0NDZB2MerpXJacX82P/ys6c8nah0CbsywRJiiLDg2yKAyHitMkaZAkuwt2ztECIOt
         H4CVARDxDLd0a8aTHwLTMyLfRwp3XAMzqWFyxXZ7vzPbdFL+/G2RnpW7SgBIKltBrtsc
         b7Sz/dDeuQdp9qMiJnu92nGiaC4vSpnq6LqAH6cGDirV37+Fx3H/s2bRYg+sQOXU9q/J
         esGA==
X-Gm-Message-State: ACrzQf3uOlhESpISxWJFJRggV8MJ+9t40L2ceM/6GJwtrJ+y831WwnQ0
        ejHk/Fw2Wp0Aqhf9/WR8/V3MAg==
X-Google-Smtp-Source: AMsMyM6lr1+QjNnJETiN2xIBWVewGe3NZZMJQjkdypULY30P+2qDkuVSkJlWCsTLvdERofYaUXMZCw==
X-Received: by 2002:a17:906:8a6a:b0:79e:2efe:e0 with SMTP id hy10-20020a1709068a6a00b0079e2efe00e0mr15582247ejc.401.1667255561128;
        Mon, 31 Oct 2022 15:32:41 -0700 (PDT)
Received: from cloudflare.com (79.191.56.44.ipv4.supernova.orange.pl. [79.191.56.44])
        by smtp.gmail.com with ESMTPSA id n9-20020a056402060900b00459148fbb3csm3707005edv.86.2022.10.31.15.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:32:40 -0700 (PDT)
References: <1667000674-13237-1-git-send-email-wangyufen@huawei.com>
 <87fsf3q36k.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        john.fastabend@gmail.com
Subject: Re: [PATCH net v2] bpf, sockmap: fix the sk->sk_forward_alloc
 warning of sk_stream_kill_queues()
Date:   Mon, 31 Oct 2022 23:26:14 +0100
In-reply-to: <87fsf3q36k.fsf@cloudflare.com>
Message-ID: <877d0fpqt4.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 31, 2022 at 06:56 PM +01, Jakub Sitnicki wrote:
> On Sat, Oct 29, 2022 at 07:44 AM +08, Wang Yufen wrote:
>> When running `test_sockmap` selftests, got the following warning:
>>
>> WARNING: CPU: 2 PID: 197 at net/core/stream.c:205 sk_stream_kill_queues+0xd3/0xf0
>> Call Trace:
>>   <TASK>
>>   inet_csk_destroy_sock+0x55/0x110
>>   tcp_rcv_state_process+0xd28/0x1380
>>   ? tcp_v4_do_rcv+0x77/0x2c0
>>   tcp_v4_do_rcv+0x77/0x2c0
>>   __release_sock+0x106/0x130
>>   __tcp_close+0x1a7/0x4e0
>>   tcp_close+0x20/0x70
>>   inet_release+0x3c/0x80
>>   __sock_release+0x3a/0xb0
>>   sock_close+0x14/0x20
>>   __fput+0xa3/0x260
>>   task_work_run+0x59/0xb0
>>   exit_to_user_mode_prepare+0x1b3/0x1c0
>>   syscall_exit_to_user_mode+0x19/0x50
>>   do_syscall_64+0x48/0x90
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> The root case is: In commit 84472b436e76 ("bpf, sockmap: Fix more
>> uncharged while msg has more_data") , I used msg->sg.size replace
>> tosend rudely, which break the
>>    if (msg->apply_bytes && msg->apply_bytes < send)
>> scene.
>>
>> Fixes: 84472b436e76 ("bpf, sockmap: Fix more uncharged while msg has more_data")
>> Reported-by: Jakub Sitnicki <jakub@cloudflare.com>
>> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
>> Acked-by: John Fastabend <john.fastabend@gmail.com>
>> ---
>> v1 -> v2: typo fixup
>>  net/ipv4/tcp_bpf.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index a1626af..774d481 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>> @@ -278,7 +278,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>  {
>>  	bool cork = false, enospc = sk_msg_full(msg);
>>  	struct sock *sk_redir;
>> -	u32 tosend, delta = 0;
>> +	u32 tosend, orgsize, sent, delta = 0;
>>  	u32 eval = __SK_NONE;
>>  	int ret;
>>  
>> @@ -333,10 +333,12 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>  			cork = true;
>>  			psock->cork = NULL;
>>  		}
>> -		sk_msg_return(sk, msg, msg->sg.size);
>> +		sk_msg_return(sk, msg, tosend);
>>  		release_sock(sk);
>>  
>> +		orgsize = msg->sg.size;
>>  		ret = tcp_bpf_sendmsg_redir(sk_redir, msg, tosend, flags);
>> +		sent = orgsize - msg->sg.size;
>
> If I'm reading the code right, it's the same as:
>
>                 sent = tosend - msg->sg.size;
>
> If so, no need for orgsize.

Sorry, that doesn't make any sense. I misread the code.

The fix is correct.

If I can have a small ask to rename `orgsize` to something more common.

We have `orig_size` or `origsize` in use today, but no `orgsize`:

$ git grep -c '\<orig_size\>' -- net
net/core/sysctl_net_core.c:3
net/psample/psample.c:1
net/tls/tls_device.c:5
net/tls/tls_sw.c:7
$ git grep -c '\<origsize\>' -- net
net/bridge/netfilter/ebtables.c:5
net/ipv4/netfilter/arp_tables.c:10
net/ipv4/netfilter/ip_tables.c:10
net/ipv6/netfilter/ip6_tables.c:10

It reads a bit better, IMHO.

Thanks for fixing it so quickly.

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
