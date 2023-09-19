Return-Path: <bpf+bounces-10397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B937A6C52
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 22:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BBE1C20D93
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 20:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95865347DE;
	Tue, 19 Sep 2023 20:33:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15956881E;
	Tue, 19 Sep 2023 20:33:20 +0000 (UTC)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA493;
	Tue, 19 Sep 2023 13:33:18 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4935f87ca26so2566645e0c.3;
        Tue, 19 Sep 2023 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695155598; x=1695760398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6KdRxXe3NG2yUcHW7SlJlH2IMG9FBJD4N+pc6L0OCw=;
        b=W8lvLiZbE5UpJMMPRBtMDD0b2/hOsWLuEG0tAb32ycUmstVCAdZw97wlY5P3qiEIFc
         fvLXw3rCqEUfYOgGRXzj1y3UKAAbK3E2rPa4Y5tKOwyuFC2uqLczA5bBfKsPPfvWZH6C
         jmK/cv1QDqiknalBiiRrgwIOGAWYjkBUG4saftLefT+e7ZDgdXZI8Nr0L0Y2CjtM6dXm
         GWmd/lzfdgwkTKoe1O3V8/+e+xA/r5JRsK5Q8f1ndn1eph0QaQaalRMA1S4fa001fMO8
         OIbdQmvg4wpsGZUIEEFMbdvadLUaNiPI5f1KB9ElNSQIFFLX00gYndDGwQfhSxsIgGA4
         xU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695155598; x=1695760398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6KdRxXe3NG2yUcHW7SlJlH2IMG9FBJD4N+pc6L0OCw=;
        b=RkHlvU4BDHcOrT4tzwbOG4Z7j46Fd4SASyyNoEziVCvUsgXuYgdntxXhlgMTmwKBGA
         1XieNZVgtC3AJIkxfvLNEmXCbmsUk3peO6JipsuZU2TlQo+yS7d4iXQ54xPeeWWTH0da
         q8xOKAr0WBT4d/ZkfeB7i1JDb1KltVW4QNvyxwXCfNTTP45BjCe5eGgLFevO4bskvG57
         uFdzklYZGGQKGSw1No7W219D3do9inkecJN6NuV3PdybMCbWmuhEqng1yQ+mSoKAf3e+
         pRyjWXCTtFnkV+eKu/nTXUKKulweblCFQdPGY1fegLjF9ap7cZKfas8VCB4wpvU7Bj/H
         jWvQ==
X-Gm-Message-State: AOJu0Yxj3RoEsCL+iuNFWTZVW/5FW/Qgf3w4lv8vrf3vNzyUlASpU9Tg
	uaMOPLu9zX4g3XhHYZRKOrRPiD7vywDplsbJDlE=
X-Google-Smtp-Source: AGHT+IFU73/krHfowX0rGifMwb28FTrBBP8twVOBgxIIyFR/I0TFdqMaosdLc3nk0jga7waHwcp1UiyRKxtXsVRDEKA=
X-Received: by 2002:a1f:d502:0:b0:495:dc43:7440 with SMTP id
 m2-20020a1fd502000000b00495dc437440mr1012432vkg.9.1695155597814; Tue, 19 Sep
 2023 13:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75315.1695139973@warthog.procyon.org.uk>
In-Reply-To: <75315.1695139973@warthog.procyon.org.uk>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 19 Sep 2023 16:32:41 -0400
Message-ID: <CAF=yD-+kRXmwuKHVrUUL6oBPhWiPKucm_5-Y+YM==9Bp3DQiGQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, 
	syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	bpf@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 12:12=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
>
> Including the transhdrlen in length is a problem when the packet is
> partially filled (e.g. something like send(MSG_MORE) happened previously)
> when appending to an IPv4 or IPv6 packet as we don't want to repeat the
> transport header or account for it twice.  This can happen under some
> circumstances, such as splicing into an L2TP socket.
>
> The symptom observed is a warning in __ip6_append_data():
>
>     WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_=
data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
>
> that occurs when MSG_SPLICE_PAGES is used to append more data to an alrea=
dy
> partially occupied skbuff.  The warning occurs when 'copy' is larger than
> the amount of data in the message iterator.  This is because the requeste=
d
> length includes the transport header length when it shouldn't.  This can =
be
> triggered by, for example:
>
>         sfd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
>         bind(sfd, ...); // ::1
>         connect(sfd, ...); // ::1 port 7
>         send(sfd, buffer, 4100, MSG_MORE);
>         sendfile(sfd, dfd, NULL, 1024);
>
> Fix this by pushing the addition of transhdrlen into length down into
> __ip_append_data() and __ip6_append_data(), making it conditional on the
> write queue being empty (otherwise we just clear transhdrlen).

I'm afraid that we might start to dig an ever deeping hole.

The proposed fix is non-trivial, and changes not just the new path
that observes the issue (MSG_SPLICE_PAGES), but also the other more
common paths that exercise __ip6_append_data.

There is significant risk to introduce an unintended side effect
requiring a follow-up fix. Because this function is notoriously
complex, multiplexing a lot of behavior: with and without transport
headers, edge cases like fragmentation, MSG_MORE, absence of
scatter-gather, ....

Does the issue discovered only affect MSG_SPLICE_PAGES or can it
affect other paths too? If the first, it possible to create a more
targeted fix that can trivially be seen to not affect code prior to
introduction of splice pages?

