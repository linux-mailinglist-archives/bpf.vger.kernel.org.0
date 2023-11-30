Return-Path: <bpf+bounces-16275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D8F7FF2F3
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9615BB2103D
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC1482F8;
	Thu, 30 Nov 2023 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoADjwe5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08290133
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:53:45 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso10783a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701356023; x=1701960823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCn18EbYTvQN6Hx5SPwp2Hrn3+cuHj5r6QyCYUKQz1g=;
        b=ZoADjwe5HdRUJImOHKCyzd2+M25lXDdUiOL5o/7uHeu7AnLnz0gr75+dOSpVdSttg4
         Wrfl9A/LurnYPnf5vZJAz/IC8TDypNvrb+kc1H2pvPvB9y3OnfBo8suPLqmppl7FDlnc
         Zcgjf7Uap+CVo6V8Y09K+4NCOw/0Ven1baMW4ZhPAvU+gMcQ+XlRUhtLl+dv/nUp9sgi
         bSTmCB5HNxM67+KJrUKkL98xUFN6vBl3+TeN6ZWcpbH5fAzGo/0rgND+1JZcZ9imUFyJ
         CkS2N3gdFHa3jlpx266bd0fCKNYxjdRIxC1Zvyj/rZ0OkFOOUdBBxOaULqXZGy3g8xcI
         XZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356023; x=1701960823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCn18EbYTvQN6Hx5SPwp2Hrn3+cuHj5r6QyCYUKQz1g=;
        b=rVm8ZbkKPDTENzluQVAM24ev90Ca/55/0S1RP8Gou6AOk1x8QEC2WkIAMyJxM1MyDI
         7Qg42wBLeK3GRn1GmbXQP170dfsblu33XY/6TRpaIRd6xWZBZwLh1+s5ZECjG/cHF1Di
         J9h3TrIs9AhFTFhAinKwsHeh01KtI2W7kSpAboCmjQNEHgUYwROpPSA3myv6did+hnro
         n8X9Qxq8OGklTWhfs9taPyRsX2uYtzIB3YVfJgkRqnnU9HH/800/tmHXyhUQ7zGI1g9t
         yF8mNmg3sdruB3a862WktA/VepCw4BzwtBZCyHBdSXRp6bQk9m/I2ivQUWAZbzxITEM4
         +cOw==
X-Gm-Message-State: AOJu0YxQU1fpcoO2lO6t7dJMrDUYiOJMyBJZHBAs6LCwU9o+7WRaWPcD
	OSetYNSbHlF/VA5gNa/nObmOldu48UbRKWHoQf5hwA==
X-Google-Smtp-Source: AGHT+IFw5LXEARjiFdEk0Hh6YkSO8IVJfZ4dQPB1Q86yBLt/M6hCAybSTpLWdQddRpJBjxxo9owtUpWZZ2e/l1SI6tI=
X-Received: by 2002:aa7:c6c1:0:b0:54b:8f42:e3dc with SMTP id
 b1-20020aa7c6c1000000b0054b8f42e3dcmr166944eds.2.1701356023223; Thu, 30 Nov
 2023 06:53:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129234916.16128-1-daniel@iogearbox.net>
In-Reply-To: <20231129234916.16128-1-daniel@iogearbox.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 15:53:29 +0100
Message-ID: <CANn89i+0UuXTYzBD1=zaWmvBKNtyriWQifOhQKF3Y7z4BWZhig@mail.gmail.com>
Subject: Re: pull-request: bpf 2023-11-30
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	andrii@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 12:49=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> Hi David, hi Jakub, hi Paolo, hi Eric,
>
> The following pull-request contains BPF updates for your *net* tree.
>
> We've added 5 non-merge commits during the last 7 day(s) which contain
> a total of 10 files changed, 66 insertions(+), 15 deletions(-).
>
> The main changes are:
>
> 1) Fix AF_UNIX splat from use after free in BPF sockmap, from John Fastab=
end.


syzbot is not happy with this patch.

Would the following fix make sense?

diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index 7ea7c3a0d0d06224f49ad5f073bf772b9528a30a..58e89361059fbf9d5942c6dd268=
dd80ac4b57098
100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -168,7 +168,8 @@ int unix_stream_bpf_update_proto(struct sock *sk,
struct sk_psock *psock, bool r
        }

        sk_pair =3D unix_peer(sk);
-       sock_hold(sk_pair);
+       if (sk_pair)
+               sock_hold(sk_pair);
        psock->sk_pair =3D sk_pair;
        unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
        sock_replace_proto(sk, &unix_stream_bpf_prot);


>
> 2) Fix a syzkaller splat in netdevsim by properly handling offloaded prog=
rams (and
>    not device-bound ones), from Stanislav Fomichev.
>
> 3) Fix bpf_mem_cache_alloc_flags() to initialize the allocation hint, fro=
m Hou Tao.
>
> 4) Fix netkit by rejecting IFLA_NETKIT_PEER_INFO in changelink, from Dani=
el Borkmann.
>
> Please consider pulling these changes from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netd=
ev
>
> Thanks a lot!
>
> Also thanks to reporters, reviewers and testers of commits in this pull-r=
equest:
>
> Jakub Kicinski, Jakub Sitnicki, Nikolay Aleksandrov, Yonghong Song
>
> ----------------------------------------------------------------
>
> The following changes since commit d3fa86b1a7b4cdc4367acacea16b72e0a200b3=
d7:
>
>   Merge tag 'net-6.7-rc3' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/netdev/net (2023-11-23 10:40:13 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-ne=
tdev
>
> for you to fetch changes up to 51354f700d400e55b329361e1386b04695e6e5c1:
>
>   bpf, sockmap: Add af_unix test with both sockets in map (2023-11-30 00:=
25:25 +0100)
>
> ----------------------------------------------------------------
> bpf-for-netdev
>
> ----------------------------------------------------------------
> Daniel Borkmann (1):
>       netkit: Reject IFLA_NETKIT_PEER_INFO in netkit_change_link
>
> Hou Tao (1):
>       bpf: Add missed allocation hint for bpf_mem_cache_alloc_flags()
>
> John Fastabend (2):
>       bpf, sockmap: af_unix stream sockets need to hold ref for pair sock
>       bpf, sockmap: Add af_unix test with both sockets in map
>
> Stanislav Fomichev (1):
>       netdevsim: Don't accept device bound programs
>
>  drivers/net/netdevsim/bpf.c                        |  4 +-
>  drivers/net/netkit.c                               |  6 +++
>  include/linux/skmsg.h                              |  1 +
>  include/net/af_unix.h                              |  1 +
>  kernel/bpf/memalloc.c                              |  2 +
>  net/core/skmsg.c                                   |  2 +
>  net/unix/af_unix.c                                 |  2 -
>  net/unix/unix_bpf.c                                |  5 +++
>  .../selftests/bpf/prog_tests/sockmap_listen.c      | 51 ++++++++++++++++=
+-----
>  .../selftests/bpf/progs/test_sockmap_listen.c      |  7 +++
>  10 files changed, 66 insertions(+), 15 deletions(-)

