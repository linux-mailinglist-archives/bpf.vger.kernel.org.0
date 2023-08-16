Return-Path: <bpf+bounces-7906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629B477E4EF
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F79C1C210AB
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E1156FA;
	Wed, 16 Aug 2023 15:21:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138E156DB
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 15:21:28 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709762733
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 08:21:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe0c566788so10538799e87.0
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692199281; x=1692804081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo+bJl+y4f/gcBpiSV3BMiHVoCuXZGbyDLViIJN4HNU=;
        b=woCGuL35AXyt6Hws5akvROlF7RqebS9eOYXxHntzLeGYVk1NTV0JRHtHtiO3R5vUpJ
         /E3V4iORbL295JckGqfv6muslFFEb3myhBYmvFMBP6Mz2Qmi0ZaHuXIPB6T5SZ//1xWa
         QXnna47bdllgzRJcsO5lD5J7lUBa6Bo8Y0qNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692199281; x=1692804081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yo+bJl+y4f/gcBpiSV3BMiHVoCuXZGbyDLViIJN4HNU=;
        b=kDM8vHZXr9jt9xwWer0EGlnMXpzGl3l+iJWlr4HTa6wMY4RVL+1JxuzijpWD2bYz0o
         1MQ2Jtv9ZYFuXgalwCTPhyiGuE/f3EblwwZu9DZHFOGepHrzRMYODfVBLHIR6q8fxVRE
         W+q6e5voR/iaMMO65loMTy7sYGlQ3K4GglVadsot5d53v7qfZVUqiUaKJwFTp06vKOsb
         03u2i/aZm7gcVixejXOouburwslIehKFvcT/wrnGinWBU8azrqlWJro3QeAiuwA/30XF
         Qk2of4IYGdPYEsEMVa5C5mlIIbj3nWuAltR15XZoW5PL5sU/igTS9CUWfI2cKnFiQsU5
         WauA==
X-Gm-Message-State: AOJu0YzZm9HjZVxcWYMhRSyh1DMZxLVIeGRpqCsuOuUBpfGfsp85++4k
	XvH8qwbTJpe+URR62O98MFOfwrzXTSbuRxkkY0X5kg==
X-Google-Smtp-Source: AGHT+IGOaEOXBm5YJbq2Nr3ga0OHEs0BPsZyI6sJDQwGTEIIZLfE3bIwVhGo62MewvuCU7hiVbW3/zj70F4NdmA6V5o=
X-Received: by 2002:a19:675b:0:b0:4fb:8aeb:d9be with SMTP id
 e27-20020a19675b000000b004fb8aebd9bemr1593548lfj.30.1692199280579; Wed, 16
 Aug 2023 08:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1692153515.git.yan@cloudflare.com> <9ac9d459-9bc3-bcee-b912-3ab66d2a7fe7@iogearbox.net>
In-Reply-To: <9ac9d459-9bc3-bcee-b912-3ab66d2a7fe7@iogearbox.net>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 16 Aug 2023 10:21:09 -0500
Message-ID: <CAO3-Pbp5kopV+AOFZqJuJjiBFqkBTLM9Ga0JR1iU9kig7pqA8w@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 0/4] lwt: fix return values of BPF ops
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Graf <tgraf@suug.ch>, 
	Jordan Griege <jgriege@cloudflare.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 9:27=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Yan,
>
> On 8/16/23 4:54 AM, Yan Zhai wrote:
> > lwt xmit hook does not expect positive return values in function
> > ip_finish_output2 and ip6_finish_output. However, BPF programs can
> > directly return positive statuses such like NET_XMIT_DROP, NET_RX_DROP,
> > and etc to the caller. Such return values would make the kernel continu=
e
> > processing already freed skbs and eventually panic.
> >
> > This set fixes the return values from BPF ops to unexpected continue
> > processing, and checks strictly on the correct continue condition for
> > future proof. In addition, add missing selftests for BPF_REDIRECT
> > and BPF_REROUTE cases for BPF-CI.
> >
> > v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/
> > v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com=
/
> > v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/
> > v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
> >
> > changes since v4:
> >   * fixed same error on BPF_REROUTE path
> >   * re-implemented selftests under BPF-CI requirement
>
> BPF CI failed: https://github.com/kernel-patches/bpf/actions/runs/5874202=
507/job/15929012788
>
> Looks like due to dummy device issue. Either you might need to add this t=
o
> the tools/testing/selftests/bpf/config* or perhaps just use veth instead =
for
> link_err dev.
>
It is indeed the dummy driver issue. I will update the config. Thanks
for notifying me, now I know where to look at build results.

Yan

> Error from the above link:
>
> Notice: Success: 370/3177, Skipped: 21, Failed: 2
> Error: #131 lwt_redirect
>    Error: #131 lwt_redirect
>    test_lwt_redirect:PASS:pthread_create 0 nsec
> Error: #131/1 lwt_redirect/lwt_redirect_normal
>    Error: #131/1 lwt_redirect/lwt_redirect_normal
>    test_lwt_redirect_run:PASS:netns_create 0 nsec
>    open_netns:PASS:malloc token 0 nsec
>    open_netns:PASS:open /proc/self/ns/net 0 nsec
>    open_netns:PASS:open netns fd 0 nsec
>    open_netns:PASS:setns 0 nsec
>    test_lwt_redirect_run:PASS:setns 0 nsec
>    open_tuntap:PASS:open(/dev/net/tun) 0 nsec
>    open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
>    open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
>    setup_redirect_target:PASS:open_tuntap 0 nsec
>    setup_redirect_target:PASS:if_nametoindex 0 nsec
>    setup_redirect_target:FAIL:ip link add link_err type dummy unexpected =
error: 512 (errno 0)
>    test_lwt_redirect_normal:FAIL:setup_redirect_target unexpected setup_r=
edirect_target: actual -1 < expected 0
>    close_netns:PASS:setns 0 nsec
> Error: #131/2 lwt_redirect/lwt_redirect_normal_nomac
>    Error: #131/2 lwt_redirect/lwt_redirect_normal_nomac
>    test_lwt_redirect_run:PASS:netns_create 0 nsec
>    open_netns:PASS:malloc token 0 nsec
>    open_netns:PASS:open /proc/self/ns/net 0 nsec
>    open_netns:PASS:open netns fd 0 nsec
>    open_netns:PASS:setns 0 nsec
>    test_lwt_redirect_run:PASS:setns 0 nsec
>    open_tuntap:PASS:open(/dev/net/tun) 0 nsec
>    open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
>    open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
>    setup_redirect_target:PASS:open_tuntap 0 nsec
>    setup_redirect_target:PASS:if_nametoindex 0 nsec
>    setup_redirect_target:FAIL:ip link add link_err type dummy unexpected =
error: 512 (errno 0)
>    test_lwt_redirect_normal_nomac:FAIL:setup_redirect_target unexpected s=
etup_redirect_target: actual -1 < expected 0
>    close_netns:PASS:setns 0 nsec
> Error: #131/3 lwt_redirect/lwt_redirect_dev_down
>    Error: #131/3 lwt_redirect/lwt_redirect_dev_down
>    test_lwt_redirect_run:PASS:netns_create 0 nsec
>    open_netns:PASS:malloc token 0 nsec
>    open_netns:PASS:open /proc/self/ns/net 0 nsec
>    open_netns:PASS:open netns fd 0 nsec
>    open_netns:PASS:setns 0 nsec
>    test_lwt_redirect_run:PASS:setns 0 nsec
>    open_tuntap:PASS:open(/dev/net/tun) 0 nsec
>    open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
>    open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
>    setup_redirect_target:PASS:open_tuntap 0 nsec
>    setup_redirect_target:PASS:if_nametoindex 0 nsec
>    setup_redirect_target:FAIL:ip link add link_err type dummy unexpected =
error: 512 (errno 0)
>    __test_lwt_redirect_dev_down:FAIL:setup_redirect_target unexpected set=
up_redirect_target: actual -1 < expected 0
>    close_netns:PASS:setns 0 nsec
> Error: #131/4 lwt_redirect/lwt_redirect_dev_down_nomac
>    Error: #131/4 lwt_redirect/lwt_redirect_dev_down_nomac
>    test_lwt_redirect_run:PASS:netns_create 0 nsec
>    open_netns:PASS:malloc token 0 nsec
>    open_netns:PASS:open /proc/self/ns/net 0 nsec
>    open_netns:PASS:open netns fd 0 nsec
>    open_netns:PASS:setns 0 nsec
>    test_lwt_redirect_run:PASS:setns 0 nsec
>    open_tuntap:PASS:open(/dev/net/tun) 0 nsec
>    open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
>    open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
>    setup_redirect_target:PASS:open_tuntap 0 nsec
>    setup_redirect_target:PASS:if_nametoindex 0 nsec
>    setup_redirect_target:FAIL:ip link add link_err type dummy unexpected =
error: 512 (errno 0)
>    __test_lwt_redirect_dev_down:FAIL:setup_redirect_target unexpected set=
up_redirect_target: actual -1 < expected 0
>    close_netns:PASS:setns 0 nsec
> Error: #131/5 lwt_redirect/lwt_redirect_dev_carrier_down
>    Error: #131/5 lwt_redirect/lwt_redirect_dev_carrier_down
>    test_lwt_redirect_run:PASS:netns_create 0 nsec
>    open_netns:PASS:malloc token 0 nsec
>    open_netns:PASS:open /proc/self/ns/net 0 nsec
>    open_netns:PASS:open netns fd 0 nsec
>    open_netns:PASS:setns 0 nsec
>    test_lwt_redirect_run:PASS:setns 0 nsec
>    open_tuntap:PASS:open(/dev/net/tun) 0 nsec
>    open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
>    open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
>    setup_redirect_target:PASS:open_tuntap 0 nsec
>    setup_redirect_target:PASS:if_nametoindex 0 nsec
>    setup_redirect_target:FAIL:ip link add link_err type dummy unexpected =
error: 512 (errno 0)
>    test_lwt_redirect_dev_carrier_down:FAIL:setup_redirect_target unexpect=
ed setup_redirect_target: actual -1 < expected 0
>    close_netns:PASS:setns 0 nsec
>    test_lwt_redirect:PASS:pthread_join 0 nsec
> Error: #132 lwt_reroute
>    Error: #132 lwt_reroute
>    test_lwt_reroute:PASS:pthread_create 0 nsec
> Error: #132/1 lwt_reroute/lwt_reroute_normal_xmit
>    Error: #132/1 lwt_reroute/lwt_reroute_normal_xmit
>    test_lwt_reroute_run:PASS:netns_create 0 nsec
>    open_netns:PASS:malloc token 0 nsec
>    open_netns:PASS:open /proc/self/ns/net 0 nsec
>    open_netns:PASS:open netns fd 0 nsec
>    open_netns:PASS:setns 0 nsec
>    test_lwt_reroute_run:PASS:setns 0 nsec
>    open_tuntap:PASS:open(/dev/net/tun) 0 nsec
>    open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
>    open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
>    setup:PASS:open_tun 0 nsec
>    setup:PASS:if_nametoindex 0 nsec
>    setup:FAIL:ip link add link_err type dummy unexpected error: 512 (errn=
o 0)
>    test_lwt_reroute_normal_xmit:FAIL:setup_reroute unexpected setup_rerou=
te: actual -1 < expected 0
>    close_netns:PASS:setns 0 nsec
> Error: #132/2 lwt_reroute/lwt_reroute_qdisc_dropped
>    Error: #132/2 lwt_reroute/lwt_reroute_qdisc_dropped
>    test_lwt_reroute_run:PASS:netns_create 0 nsec
>    open_netns:PASS:malloc token 0 nsec
>    open_netns:PASS:open /proc/self/ns/net 0 nsec
>    open_netns:PASS:open netns fd 0 nsec
>    open_netns:PASS:setns 0 nsec
>    test_lwt_reroute_run:PASS:setns 0 nsec
>    open_tuntap:PASS:open(/dev/net/tun) 0 nsec
>    open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
>    open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
>    setup:PASS:open_tun 0 nsec
>    setup:PASS:if_nametoindex 0 nsec
>    setup:FAIL:ip link add link_err type dummy unexpected error: 512 (errn=
o 0)
>    test_lwt_reroute_qdisc_dropped:FAIL:setup_reroute unexpected setup_rer=
oute: actual -1 < expected 0
>    close_netns:PASS:setns 0 nsec
>    test_lwt_reroute:PASS:pthread_join 0 nsec
> Test Results:
>               bpftool: PASS
>            test_progs: FAIL (returned 1)
>              shutdown: CLEAN
> Error: Process completed with exit code 1.
>
> Thanks,
> Daniel



--=20

Yan

