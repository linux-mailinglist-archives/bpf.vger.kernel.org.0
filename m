Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD85EEA9A
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 02:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiI2Ahy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 20:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2Ahx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 20:37:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C4CE1097
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:37:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sb3so30342970ejb.9
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=h0t/8Q7psN1oQYy4wNa+NnRls5mtTmx6bafFLrJKyks=;
        b=JSsl6SUhaQIytCOscb82FEeOjOjhVFebX0k7/9FAir0RwO04RwplNhPZ3sOEpsWugq
         D5zUSTrhp6SKylBAfa0UO9XHdL66Xne9Jf7PA1R6GxHg0c7XADO8DCT8b04DNyJ2ybdL
         esrCz70PSJa8Ffd7wznWIJOBKcsEuE3edhBszSBWLjpg+WLdoG0aBfYUR64L61heYNwX
         MS80n684vwHIJtsNtufigcR0iwjWMQ2pVCfYvVQ49jiYaeaamIAh6XMcABERPP9MdeTz
         0M/ulmXZSU+cso7K3zfSBo0uA7tluEZ2JddtrNIibIm58Pj4cL7sHo6NNlMoJf0mmloF
         yGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=h0t/8Q7psN1oQYy4wNa+NnRls5mtTmx6bafFLrJKyks=;
        b=hAJw88xxgNknaNF/BRFBDvW4UkD5yVr4Q1negwmQdGMB/g5ba4h+TSxsjE77YEk1/C
         +SuRxuk5OilpElKxBj/HLHO4BAlKR/s7oH8hFEr5uP6Vehk9dCrfoiYu226GTypiStcq
         GA1lmKIiV6qmtkt4UnIQ4ajH8LmrLxXxOMna7UW87v97tgN2r8PAt3tlSou9DiXhuUsU
         rILPAEgVBLJN5AytNMCnyEE/J6SfdC1odJHplsHZBSTjBRfb9W/kyZFhfo8qL0gch4sz
         hgCQNjB2eX0PyPrbvv/IBjHZocADYRPWbPGwi34lvL2fPAwLJ4agKXQVQIMzKTdO03n0
         56Zg==
X-Gm-Message-State: ACrzQf1Q1gC8AQa3SOnaZ+RtgHL7kmIWi/RpcjxlZ+Arc72YcwAh3jAp
        juBB6+zfh1OdHrbO1LWMdSomCJpm0MSP83tWdRk=
X-Google-Smtp-Source: AMsMyM7aL3bf1+kb1Q1rNW55TB4XLrt7CjkdoSxjnsq14NdwfX8xLDHr6CIojcP7k/jS+IbodWYjM+mpyJ5U5s++Kxg=
X-Received: by 2002:a17:907:3d86:b0:782:1175:153f with SMTP id
 he6-20020a1709073d8600b007821175153fmr461424ejc.226.1664411869945; Wed, 28
 Sep 2022 17:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 17:37:37 -0700
Message-ID: <CAEf4BzY4GARZ7C+rYDuCHAbMRrC=Fx7eVSBZ60txme97it2FLg@mail.gmail.com>
Subject: Re: [bpf-next 00/11] bpf/selftests: convert some tests to ASSERT_* macros
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, delyank@fb.com, zhudi2@huawei.com,
        jakub@cloudflare.com, kuba@kernel.org, kuifeng@fb.com,
        deso@posteo.net, zhuyifei@google.com, hengqi.chen@gmail.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 25, 2022 at 9:51 PM Wang Yufen <wangyufen@huawei.com> wrote:
>
> Convert some tests to use the preferred ASSERT_* macros instead of the
> deprecated CHECK().
>
> Wang Yufen (11):
>   bpf/selftests: convert sockmap_basic test to ASSERT_* macros
>   bpf/selftests: convert sockmap_ktls test to ASSERT_* macros
>   bpf/selftests: convert sockopt test to ASSERT_* macros
>   bpf/selftests: convert sockopt_inherit test to ASSERT_* macros
>   bpf/selftests: convert sockopt_multi test to ASSERT_* macros
>   bpf/selftests: convert sockopt_sk test to ASSERT_* macros
>   bpf/selftests: convert tcp_estats test to ASSERT_* macros
>   bpf/selftests: convert tcp_hdr_options test to ASSERT_* macros
>   bpf/selftests: convert tcp_rtt test to ASSERT_* macros
>   bpf/selftests: convert tcpbpf_user test to ASSERT_* macros
>   bpf/selftests: convert udp_limit test to ASSERT_* macros
>
>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 87 ++++++++--------------
>  .../selftests/bpf/prog_tests/sockmap_ktls.c        | 39 +++-------
>  tools/testing/selftests/bpf/prog_tests/sockopt.c   |  4 +-
>  .../selftests/bpf/prog_tests/sockopt_inherit.c     | 30 ++++----
>  .../selftests/bpf/prog_tests/sockopt_multi.c       | 10 +--
>  .../testing/selftests/bpf/prog_tests/sockopt_sk.c  |  2 +-
>  .../testing/selftests/bpf/prog_tests/tcp_estats.c  |  4 +-
>  .../selftests/bpf/prog_tests/tcp_hdr_options.c     | 80 +++++++-------------
>  tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   | 13 ++--
>  .../testing/selftests/bpf/prog_tests/tcpbpf_user.c | 32 +++-----
>  tools/testing/selftests/bpf/prog_tests/udp_limit.c | 18 ++---
>  11 files changed, 117 insertions(+), 202 deletions(-)
>
> --
> 1.8.3.1
>

Thanks for the clean up! I've changed one ASSERT_OK(err && errno !=
ENOENT) to ASSERT_EQ(errno, ENOENT) in patch #1, that expresses the
intent more directly. Please also keep in mind that patch prefix
should (conventionally) be "selftests/bpf: ". I've fixed that for all
patches while applying.

We are down to:

$ rg -w CHECK | wc -l
1186
09/28 17:36:39.381
andriin@devbig019:~/linux/tools/testing/selftests/bpf (master)
$ rg -w CHECK_FAIL | wc -l
463

Some ways to go still, but slowly decreasing. Thank you for your contribution!
