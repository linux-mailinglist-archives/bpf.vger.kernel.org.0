Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929EB4D4C4E
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 16:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiCJOyl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346151AbiCJOmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 09:42:38 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A8910783D
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 06:40:28 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c7so4497687qka.7
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 06:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ts+dK3ttiY6R8zZea2yK4md86bxaZKIr+AquYrk3oLk=;
        b=T4jwBlYZ27/C0gS7bBdNRi5VTaFy92J44Ybzk0KAMHe8N76j3PisechWpbiJ+ucg1U
         YKnlg9x+UG2ZZ1dLdlUW8DhpFGxJTwkOhTrQEzV8y3cPTMPnKFllQnH1dIzJ6Rc6WEU6
         +VabZFESxEvq3xiZZpCMMGdMqB2PsRZGzLJVuT4PH7rZCIVHuZx91YGI2dP2KpctJrqR
         TmtwU30hLrjjDkk53sxc6uSi1Zr9furEM4pVB0ypgU3xIrBI98XltJE3fua6VaLNSA3U
         PQ9cU4e1bhn9uWp7HGulZ43Pq9QYuaMPEiwP2OJVBjeGfnJKqLE9FjcWXNhWDpFB3oDU
         EVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ts+dK3ttiY6R8zZea2yK4md86bxaZKIr+AquYrk3oLk=;
        b=h6MosogS3WsdwIow1ZggqQdyEbIMxBmeJfsl6cOQg5YUjcphLjDyGEwHgiultCOG7n
         9lTxTC4ZrFDLAYJolZVgZK8AX6hvNvUkpP52IEHkqIPgPMVXy69kaxpyOlr+n/dCrIxn
         9SLbW5PB1nE24BiI9teqyZoxhOzWFffUmMOqktz6MRLDmUfalpnSvkEa1o9wZd36TYtm
         n1R+sGTQElHTkVX5G0w7b1q4s+o8LouTyJ4PP+HiNV5M1F3vFcx2RrT0LUv2pIWgSQos
         NFKf1Zoy0cGBJIDDUl7hH0cmrc5pedERLrH7iQl9nZwfm4yd3ubrrmNZpEzXqRLf8jIb
         86KQ==
X-Gm-Message-State: AOAM531f9gAr0o9Xljj8vHzEb+XyOhfU2h1NcE9nAoZ3ESUNk3NaP4YA
        vH/2b1PyomxBkx+TlNYxcTcoy9wM3Qg=
X-Google-Smtp-Source: ABdhPJyTOAE19SMMeeKOuSwHhfzbxmHu8hrHL2hC+gabn1gNTVwIB8GGie/bkSTG1Cdl6vMIrc8LIg==
X-Received: by 2002:a05:620a:4048:b0:67b:743:8d6d with SMTP id i8-20020a05620a404800b0067b07438d6dmr3088554qko.15.1646923227552;
        Thu, 10 Mar 2022 06:40:27 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id u14-20020ac858ce000000b002de89087e7dsm3203901qta.78.2022.03.10.06.40.26
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 06:40:26 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2dbd8777564so60858707b3.0
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 06:40:26 -0800 (PST)
X-Received: by 2002:a81:594:0:b0:2dc:8978:1d64 with SMTP id
 142-20020a810594000000b002dc89781d64mr4126054ywf.348.1646923225818; Thu, 10
 Mar 2022 06:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20220308000146.534935-1-tadeusz.struk@linaro.org>
 <14626165dad64bbaabed58ba7d59e523@AcuMS.aculab.com> <6155b68c-161b-0745-b303-f7e037b56e28@linaro.org>
 <66463e26-8564-9f58-ce41-9a2843891d1a@kernel.org> <45522c89-a3b4-4b98-232b-9c69470124a3@linaro.org>
 <ff2e1007-5883-5178-6415-326d6ae69c34@kernel.org> <8fdab42f-171f-53d7-8e0e-b29161c0e3e2@linaro.org>
In-Reply-To: <8fdab42f-171f-53d7-8e0e-b29161c0e3e2@linaro.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 10 Mar 2022 09:39:48 -0500
X-Gmail-Original-Message-ID: <CA+FuTSeAL7TsdW4t7=G91n3JLuYehUCnDGH4_rHS=vjm1-Nv9Q@mail.gmail.com>
Message-ID: <CA+FuTSeAL7TsdW4t7=G91n3JLuYehUCnDGH4_rHS=vjm1-Nv9Q@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: fix invalid alloclen in __ip6_append_data
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     David Ahern <dsahern@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "syzbot+e223cf47ec8ae183f2a0@syzkaller.appspotmail.com" 
        <syzbot+e223cf47ec8ae183f2a0@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 9, 2022 at 4:37 PM Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
>
> On 3/8/22 21:01, David Ahern wrote:
> > On 3/8/22 12:46 PM, Tadeusz Struk wrote:
> >> That fails in the same way:
> >>
> >> skbuff: skb_over_panic: text:ffffffff83e7b48b len:65575 put:65575
> >> head:ffff888101f8a000 data:ffff888101f8a088 tail:0x100af end:0x6c0
> >> dev:<NULL>
> >> ------------[ cut here ]------------
> >> kernel BUG at net/core/skbuff.c:113!
> >> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> >> CPU: 0 PID: 1852 Comm: repro Not tainted
> >> 5.17.0-rc7-00020-gea4424be1688-dirty #19
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35
> >> RIP: 0010:skb_panic+0x173/0x175
> >>
> >> I'm not sure how it supposed to help since it doesn't change the
> >> alloclen at all.
> >
> > alloclen is a function of fraglen and fraglen is a function of datalen.
>
> Ok, but in this case it doesn't affect the alloclen and it still fails.

This is some kind of non-standard packet that is being constructed. Do
we understand how it is different?

The .syz reproducer is generally a bit more readable than the .c
equivalent. Though not as much as an strace of the binary, if you
can share that.

r0 = socket$inet6_icmp_raw(0xa, 0x3, 0x3a)
connect$inet6(r0, &(0x7f0000000040)={0xa, 0x0, 0x0, @dev, 0x6}, 0x1c)
setsockopt$inet6_IPV6_HOPOPTS(r0, 0x29, 0x36,
&(0x7f0000000100)=ANY=[@ANYBLOB="52b3"], 0x5a0)
sendmmsg$inet(r0, &(0x7f00000002c0)=[{{0x0, 0x0,
&(0x7f0000000000)=[{&(0x7f00000000c0)="1d2d", 0xfa5f}], 0x1}}], 0x1,
0xfe80)
