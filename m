Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E9945541B
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 06:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbhKRFX6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 00:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242408AbhKRFXz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 00:23:55 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72109C061570
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 21:20:56 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id k22so6370744iol.13
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 21:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=eYMpAXZPsrFY37EnMtJWzWckYb5Sf/fIhaMihY1NPQs=;
        b=M6nl0Z2DiaP7VV2GVkRgDVy76sENzHJR76oT+Urk0b+0nPF0bUso1rIx4boZYEk+b3
         NG7kFgYuZYs921AWGAMtpGKwzzzcwU2c2bbq8dZ6nw6ZllLOmwbhc4vg2Bju63DmNXMl
         kIQRtqvT98S5/N0rFZzMu7PHbAfUwoBxlU0vfP0Q5tj32Y/JpHHLqLKmOTN/lAHo8bEl
         yhiuh1OKdR1B+sd6pesxrnadvOLWmmZlCC6y55n1uYSinSsn+kcBFKpgddX2zviwl8OZ
         qmQ6xVmWbUdK2xx/Gsko7y6H1AFd0NUOV8aGiR2+9sAYXYHKf9LWmtfkFdsqhiTJwEYn
         oaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=eYMpAXZPsrFY37EnMtJWzWckYb5Sf/fIhaMihY1NPQs=;
        b=TIS3uvS1n9PhlzO8x59j+53D19RPeJyKAucf28H15vH9FaLR6gL840kUGgD1TAQ2ru
         nzzbYNgT7f6K0puL6vI2jJVNsjYzBWmkrgXb92qXeBwcFseEZTRDeQJ/A5sBvA9LmlvH
         Xr4zZ1xsQddfEo8iNxbrt7Wrqtns10ORMOYxjbTe9dBz2IfnHeZcjAlE2HSOhd7mq1Rf
         ppWpzoe4vt6z8WtZ00TWsl7fhxOqysQ9vT9050HPfMrxOszj31aKv40SMVGemT4OeGgX
         v8bvW1XgiTn2BfKjgV+7EkXYiUB69PIVYRvpGUE8mzXWjgOCcPwW0wzVdpiSqnrS/X4Q
         zKHA==
X-Gm-Message-State: AOAM532jW7R5QrS4hsVsHo7X70dMv3zOWz3hHJ8IgiIq8FL1KaJ1H270
        zHp98/sIf8cZeudsjKTfz6QDOauQ4mk=
X-Google-Smtp-Source: ABdhPJzjNQi7E7ux6nQAC5aVVxFuz1EMrlDSNQ9Dv8wEBWxOL43ZYYLLdjX8CNyWPnC2Q+BkvemCDQ==
X-Received: by 2002:a05:6638:1134:: with SMTP id f20mr18228480jar.6.1637212855211;
        Wed, 17 Nov 2021 21:20:55 -0800 (PST)
Received: from localhost ([172.243.151.11])
        by smtp.gmail.com with ESMTPSA id g11sm1390141ioo.3.2021.11.17.21.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 21:20:54 -0800 (PST)
Date:   Wed, 17 Nov 2021 21:20:46 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jussi Maki <joamaki@gmail.com>
Message-ID: <6195e2ae7a82f_2b4cc20884@john.notmuch>
In-Reply-To: <CAEf4Bza6HHeVTFxrmPJRUgsLYU7g06MctMoAGy3ayKq8ES9FTQ@mail.gmail.com>
References: <CAADnVQKEPYYrr6MUSKL4Fd7FYp0y5MQFoDteU5T++E6fySDADw@mail.gmail.com>
 <6191ee3e8a1e1_86942087@john.notmuch>
 <CAEf4Bza3OC1pAvVvwoPhyuixf8_VpA1w0F7HAsX09x2DSYbYbA@mail.gmail.com>
 <6195432baf114_1f40a208aa@john.notmuch>
 <CAEf4Bza6HHeVTFxrmPJRUgsLYU7g06MctMoAGy3ayKq8ES9FTQ@mail.gmail.com>
Subject: Re: sockmap test is broken
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Wed, Nov 17, 2021 at 10:00 AM John Fastabend
> <john.fastabend@gmail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > On Sun, Nov 14, 2021 at 9:21 PM John Fastabend <john.fastabend@gmail.com> wrote:
> > > >
> > > > Alexei Starovoitov wrote:
> > > > > test_maps is failing in bpf tree:
> > > > >
> > > > > $ ./test_maps
> > > > > Failed sockmap recv
> > > > >
> > > > > and causing BPF CI to stay red.
> > > > >
> > > > > Since bpf-next is fine, I suspect it is one of John's or Jussi's patches.
> > > > >
> > > > > Please take a look.
> > > >
> > > > I'll look into it thanks.
> > >
> > > Any updates, John? Should we just disable test_maps in CI to make it
> > > useful again?
> >
> > I'm debugging this now. Hopefully I'll have a fix shortly (today I hope).
> > Maybe, it makes sense to wait for EOD and if I still don't have the fix
> > disable it then. Anyways fixing it is top of list now.
> 
> Sounds good, let's hope you find it and fix it today.

OK got the fix, but its fairly subtle. Whats happening is when socks are
removed from a map their programs are not actually being removed. They
continue to live with the sock for the lifetime of the socket or until
the last reference held from BPF side is lost. At which point all progs
are dropped and socket returns to normal/preBPF state. We never noticed
it on our real use cases because once we move sockets into BPF we never
release them until the socket is free. The fix is to null the set progs
and then do the update_sk_prot call which will decide based on the
configured programs what proto ops need to be set to.

So why did the sockmap test work earlier. Before I 'fixed' the logic to
use a recv hook that didn't fall back into normal tcp recv handler the
strparser was being detatched so no packets made it to the BPF layer and
then eventually, with some delay and suboptimal code, we used to fall back
to normal tcp stack recv hook. Packet would then end up being recieved
via recv() and the test was happy. Per original patch its slightly racy
to do this fallback because you don't know, maybe a packet shows up
just as you do these checks and you consume it via old tcp handlers
and skip over your parser or whatever BPF logic is there.

I'll test the below tomorrow and create a commit msg so we have a chance
at recalling details in a month or so. Its a bit subtle to send out
this evening I think and would like to run it through some of our
own Cilium tests.

If your willing to wait another day we should be able to get the
CI going again. Either way fix on its way soon just not tonight.

---

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 1ae52ac943f6..8eb671c827f9 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1124,6 +1124,8 @@ void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
 
 void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
 {
+       psock_set_prog(&psock->progs.stream_parser, NULL);
+
        if (!psock->saved_data_ready)
                return;
 
@@ -1212,6 +1214,9 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 {
+       psock_set_prog(&psock->progs.stream_verdict, NULL);
+       psock_set_prog(&psock->progs.skb_verdict, NULL);
+
        if (!psock->saved_data_ready)
                return;
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f39ef79ced67..4ca4b11f4e5f 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -167,8 +167,11 @@ static void sock_map_del_link(struct sock *sk,
                write_lock_bh(&sk->sk_callback_lock);
                if (strp_stop)
                        sk_psock_stop_strp(sk, psock);
-               else
+               if (verdict_stop)
                        sk_psock_stop_verdict(sk, psock);
+
+               if (psock->psock_update_sk_prot)
+                       psock->psock_update_sk_prot(sk, psock, false);
                write_unlock_bh(&sk->sk_callback_lock);
