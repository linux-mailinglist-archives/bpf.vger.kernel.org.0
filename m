Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C262B2411BA
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 22:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHJUao (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHJUao (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 16:30:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF41C061787
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 13:30:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so11088917ljn.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Wx2TL88AwCBQcmpYr8LVVD9gSnGGQQkuczGbUFBwHNU=;
        b=lRZ/I2ITyYH8yKnqJMpTCHAl0RZOLS0aghIyVE8vmklILdMvvsQV5BJrLRyDPaKImn
         ILibmO6QjBqY8rqrAE/5JtkeNyoddnQVe0SnU7a9eAhCFcLGk3xN66MesvmUVkFB+c+i
         N1eE6yVnbukHcAlpzSqo38y9qKVU93ePP8xxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Wx2TL88AwCBQcmpYr8LVVD9gSnGGQQkuczGbUFBwHNU=;
        b=YEe6HB5pDGqFC8T3Hb6CXfzi9fBFph4BEEunrNADIlTcb9rKbeD/Cug8GkP6/81ggN
         oYsPX/MPvyelSRaypAfWg+J2RLGUadQuCjfANQB9KUTYOu99Q1qYVt3L69vy8+Dh1pRX
         gEiQ6Vty52MfbAbAOf02lLAY6dt4glj1xuagqfpBY3egTrIhhSOaSeTzRgGo4fQdYtrG
         TLRSD1MpH66U2Ql4u1YBAzG7yxik0/+vNjaq0JeqRvAgBKig4d7dTnaHtsLCGsrtvTyv
         wAh936cw71fwYXtzrPoj+ACh2Q6rJa22r/O3JNKuVg+ewmZwmfq2T34ESQQqeOdyUC+N
         zB4w==
X-Gm-Message-State: AOAM533MBeXdfpmtNqz7aGCrCPKtaws2i6xUVIgDT+OvrjspoSQ0qBgS
        cLTw1lK6oHb1I3+gryFXwV9tZjpIaeuFCw==
X-Google-Smtp-Source: ABdhPJwzPpUtd6cyUfe/+Up71tMI4D2v1fkMcIG8zDGa8TM9+ZHXZ2+pquRCSVUKRvUU0nQoW3ygyw==
X-Received: by 2002:a05:651c:310:: with SMTP id a16mr1308524ljp.250.1597091441235;
        Mon, 10 Aug 2020 13:30:41 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id p28sm9472447ljn.69.2020.08.10.13.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 13:30:40 -0700 (PDT)
References: <20200807223846.4190917-1-sdf@google.com> <87zh756kn7.fsf@cloudflare.com> <CAKH8qBswCOU6oK2rLkUADRF-NUgwcHB-MyWNV+ug_cLRxnQBeQ@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] selftests/bpf: fix v4_to_v6 in sk_lookup
In-reply-to: <CAKH8qBswCOU6oK2rLkUADRF-NUgwcHB-MyWNV+ug_cLRxnQBeQ@mail.gmail.com>
Date:   Mon, 10 Aug 2020 22:30:39 +0200
Message-ID: <87sgcus0pc.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 06:14 PM CEST, Stanislav Fomichev wrote:
> On Sat, Aug 8, 2020 at 11:46 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> On Sat, Aug 08, 2020 at 12:38 AM CEST, Stanislav Fomichev wrote:
>> > I'm getting some garbage in bytes 8 and 9 when doing conversion
>> > from sockaddr_in to sockaddr_in6 (leftover from AF_INET?).
>> > Let's explicitly clear the higher bytes.
>> >
>> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> > ---
>> >  tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
>> > index c571584c00f5..9ff0412e1fd3 100644
>> > --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
>> > +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
>> > @@ -309,6 +309,7 @@ static void v4_to_v6(struct sockaddr_storage *ss)
>> >       v6->sin6_addr.s6_addr[10] = 0xff;
>> >       v6->sin6_addr.s6_addr[11] = 0xff;
>> >       memcpy(&v6->sin6_addr.s6_addr[12], &v4.sin_addr.s_addr, 4);
>> > +     memset(&v6->sin6_addr.s6_addr[0], 0, 10);
>> >  }
>> >
>> >  static int udp_recv_send(int server_fd)
>>
>> That was badly written. Sorry about that. And thanks for the fix.
>>
>> I'd even zero out the whole thing:
>>
>>         memset(v6, 0, sizeof(*v6));
>>
>> ... because right now IPv4 address is left as sin6_flowinfo.  I can
>> follow up with that change, unless you'd like to roll a v2.
> Up to you, but I'm not sure zeroing out the whole v6 portion is the
> best way forward.
> IMO, it's a bit confusing when reading the code.
> It will work, but only because v4 and v6 address portions don't really
> overlap :-/

It's not that hacky :-) We copy sockaddr_in bits before overwriting ss:

	struct sockaddr_in v4 = *(struct sockaddr_in *)ss;

It could be easier to read, perhaps by copying just the fields we need:

	struct sockaddr_in *v4 = (struct sockaddr_in *)ss;
	uint32_t addr = v4->sin_addr.saddr;
	in_port_t port = v4->sin_port;

> I was thinking about adding new, on the stack sin6, fully initializing
> it and then doing memcpy into ss.
> But I decided that adding memset is probably good enough :-)

Makes sense. Either way sounds good to me.
