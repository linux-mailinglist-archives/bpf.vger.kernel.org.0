Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE761108BED
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2019 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfKYKkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Nov 2019 05:40:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40681 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfKYKkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Nov 2019 05:40:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id v24so10593361lfi.7
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2019 02:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ZlLLkT47FyuFfN9fxxKmEsBMtvvHr273+tzCjCjwgk8=;
        b=f3s99WwTGEwa9gVBoAirIBHgkesQUtftFxGLnkkzsZ4QS9JCAOqc6QEETD6F1fij/1
         CaMeAWH8l0z0RhUJNKTHo0e8kblkfhxsu2HDlwIlZ7OnDNHohlza30/8G5/XoBIuDSlP
         ojxjx0TsKeK8Ousu93yP2t00T3+14LvRN3hDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ZlLLkT47FyuFfN9fxxKmEsBMtvvHr273+tzCjCjwgk8=;
        b=KnFj2SUMI9aCIjtWwAnNhWy9J3mWtahW4E54XNODQopq/j5w2zhc2agc1SPPdEYwTw
         zgEvBS/iMisfNJDgkdvCIezOSdWTHD/j82sZZJvIKZ6vzrM9b01m3zIE8q5qD14RJpUv
         tPTDKaIuwJwTRGUHFaxKE8KYXD3IfUKXksuEQn+9euhL5hVXH/3WmtAwYH5ZkCV1ZyC4
         uP1Of5A8WwwvDTJ2afokhieWg7QEtOVLcFVYfHrUjX+XMvbgMlVXh5MOJRlXJBYfqpJU
         tKC4Abpr+nzkZY4piDwdM7BNUnovgdUI5q7ipx+Nld9m52bRLGfsuR+ZgNe55VLGUX9p
         XKfQ==
X-Gm-Message-State: APjAAAUvA+VZUs50eMLTYVpsdzmDCvG8nv0YXZ402vIvdAMQwN5kFTod
        iPdZUl9OenaeXZNzJPe/IwRGuQ==
X-Google-Smtp-Source: APXvYqybnqU2QFtI5OevLSB2FWw3P1omguHOdK5asTKGbbLhopHa0EKu9SH3JrodF7Yxh/YSufBZqA==
X-Received: by 2002:a19:c3ca:: with SMTP id t193mr7054719lff.40.1574678442688;
        Mon, 25 Nov 2019 02:40:42 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id g23sm4133151ljn.63.2019.11.25.02.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 02:40:42 -0800 (PST)
References: <20191123110751.6729-1-jakub@cloudflare.com> <20191123110751.6729-6-jakub@cloudflare.com> <20191125012440.crbufwpokttx67du@ast-mbp.dhcp.thefacebook.com> <5ddb55c87d06c_79e12b0ab99325bc69@john-XPS-13-9370.notmuch>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next 5/8] bpf: Allow selecting reuseport socket from a SOCKMAP
In-reply-to: <5ddb55c87d06c_79e12b0ab99325bc69@john-XPS-13-9370.notmuch>
Date:   Mon, 25 Nov 2019 11:40:41 +0100
Message-ID: <87o8x0nsra.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 25, 2019 at 05:17 AM CET, John Fastabend wrote:
> Alexei Starovoitov wrote:
>> On Sat, Nov 23, 2019 at 12:07:48PM +0100, Jakub Sitnicki wrote:
>> > SOCKMAP now supports storing references to listening sockets. Nothing keeps
>> > us from using it as an array of sockets to select from in SK_REUSEPORT
>> > programs.
>> >
>> > Whitelist the map type with the BPF helper for selecting socket. However,
>> > impose a restriction that the selected socket needs to be a listening TCP
>> > socket or a bound UDP socket (connected or not).
>> >
>> > The only other map type that works with the BPF reuseport helper,
>> > REUSEPORT_SOCKARRAY, has a corresponding check in its update operation
>> > handler.
>> >
>> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> > ---
>
> [...]
>
>> > diff --git a/net/core/filter.c b/net/core/filter.c
>> > index 49ded4a7588a..e3fb77353248 100644
>> > --- a/net/core/filter.c
>> > +++ b/net/core/filter.c
>> > @@ -8723,6 +8723,8 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
>> >  	selected_sk = map->ops->map_lookup_elem(map, key);
>> >  	if (!selected_sk)
>> >  		return -ENOENT;
>> > +	if (!sock_flag(selected_sk, SOCK_RCU_FREE))
>> > +		return -EINVAL;
>>
>> hmm. I wonder whether this breaks existing users...
>
> There is already this check in reuseport_array_update_check()
>
> 	/*
> 	 * sk must be hashed (i.e. listening in the TCP case or binded
> 	 * in the UDP case) and
> 	 * it must also be a SO_REUSEPORT sk (i.e. reuse cannot be NULL).
> 	 *
> 	 * Also, sk will be used in bpf helper that is protected by
> 	 * rcu_read_lock().
> 	 */
> 	if (!sock_flag(nsk, SOCK_RCU_FREE) || !sk_hashed(nsk) || !nsk_reuse)
> 		return -EINVAL;
>
> So I believe it should not cause any problems with existing users. Perhaps
> we could consolidate the checks a bit or move it into the update paths if we
> wanted. I assume Jakub was just ensuring we don't get here with SOCK_RCU_FREE
> set from any of the new paths now. I'll let him answer though.

That was exactly my thinking here.

REUSEPORT_SOCKARRAY can't be populated with sockets that don't have
SOCK_RCU_FREE set. This makes the flag check in sk_select_reuseport BPF
helper redundant for this map type.

SOCKMAP, OTOH, allows storing established TCP sockets, which don't have
SOCK_RCU_FREE flag and shouldn't be used as reuseport targets. The newly
added check protects us against it.

I have a couple tests in the last patch for it -
test_sockmap_reuseport_select_{listening,connected}. Admittedly, UDP is
not covered.

Not sure how we could go about moving the checks to the update path for
SOCKMAP. At update time we don't know if the map will be used with a
reuseport or a sk_{skb,msg} program.

-Jakub

>
>> Martin,
>> what do you think?
>
> More eyes the better.
>
>> Could you also take a look at other patches too?
>> In particular patch 7?
>>
>
> Agreed would be good to give 7/8 a look I'm not too familiar with the
> selftests there.
