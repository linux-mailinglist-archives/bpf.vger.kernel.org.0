Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580263C7B4
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiK2TBa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 14:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiK2TBK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 14:01:10 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AFC6579
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:00:03 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id b6-20020a170902d50600b00189a5536820so639102plg.16
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrIwK5afTQO/qKn0v/ZglneBEpq38VdgdU3mQcxlua4=;
        b=EBjGumsrY5Y5QyAnSraQ55klyb/pQXqKTxNShaOM1O5rJik2ldrYH4KRR8RH+E4JCo
         gAvD8Qeb/he2WS8XgAb6peWZHaP34pqdV46cv9RUDaZ6cHxVC3y8of9uRM51QB7ce0jJ
         eHoJDAZH0L5MYqb1AfKTtFKxYR7W/w8aMZy/Mi4dsg2mGIYZUGzAbE4e/g7fEUebpOrE
         yc9o+cOJMT2+BeBOajcj5XPbcF6eBJyfv4qN6IzcQxJLBTlmBoiNPjOSzMecrIthAJrv
         kFpJMp4v6u8YH84d124t5XA0+9ogrVIHdLD62SIDe59KHo9IerPTk1G51CLaDbuopb7m
         y7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrIwK5afTQO/qKn0v/ZglneBEpq38VdgdU3mQcxlua4=;
        b=lBdTa1Vgs8xwpBJDf/qALSL/Hh8RmlWsYYkp8wWq/tBO3chSLSzqUHrkEhuHMcjHj9
         cnVJJgcSvMuZyEB/6xIu2G8b22baL8H0NBXlz5ytwqdVIq06q7JEofgGYJuZrpLTUP/X
         n1CvqlGf5rUjpqXpS3TaO+nA3/gye4EWWBNCPn+vOPZzsUcCzKpEa4BOS1x3Y0LeraQM
         GaKBDCTuI2bHVwoQ5vgAw+ejXPH2x5Oa+dkn2LBJqLUzXw1Ui21qqkf0htubO/XWoW+J
         YX5HIQBJydZB46Bxc0SeOQ+NAtPFo+HEjwdk1FZWaXafB4SO5jyrUWfV8cMfHYzQEGf0
         SbdQ==
X-Gm-Message-State: ANoB5plJmKv+km8JdcktFbwMQiKyoZ3wj3e6Z2jqSp81iluKWD8Iv8Gq
        Tto4AYDR2g8aqKLH6E7rvgiCL2s=
X-Google-Smtp-Source: AA0mqf6yaLWhuR8bIayxNbDI4HnwARh6uJn9P5nMloOp9WGH7Slq6WE/y5Au7kTMPq7oL4gy269oPxw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ce90:b0:187:19c4:373a with SMTP id
 f16-20020a170902ce9000b0018719c4373amr50967842plg.163.1669748402714; Tue, 29
 Nov 2022 11:00:02 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:00:01 -0800
In-Reply-To: <20221129070900.3142427-1-martin.lau@linux.dev>
Mime-Version: 1.0
References: <20221129070900.3142427-1-martin.lau@linux.dev>
Message-ID: <Y4ZWsXKTKgm/e7P8@google.com>
Subject: Re: [PATCH bpf-next 0/7] selftests/bpf: Remove unnecessary
 mount/umount dance
From:   sdf@google.com
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, "'Alexei Starovoitov '" <ast@kernel.org>,
        "'Andrii Nakryiko '" <andrii@kernel.org>,
        "'Daniel Borkmann '" <daniel@iogearbox.net>,
        netdev@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/28, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>

> Some of the tests do mount/umount dance when switching netns.
> It is error-prone like  
> https://lore.kernel.org/bpf/20221123200829.2226254-1-sdf@google.com/

> Another issue is, there are many left over after running some of the  
> tests:
> #> mount | egrep sysfs | wc -l
> 19

> Instead of further debugging this dance,  this set is to avoid the needs  
> to
> do this remounting altogether.  It will then allow those tests to be run
> in parallel again.

Looks great, thank you for taking care of this! Since I'm partly to
blame for the mess, took a quick look at the series:

Acked-by: Stanislav Fomichev <sdf@google.com>

> Martin KaFai Lau (7):
>    selftests/bpf: Use if_nametoindex instead of reading the
>      /sys/net/class/*/ifindex
>    selftests/bpf: Avoid pinning bpf prog in the tc_redirect_dtime test
>    selftests/bpf: Avoid pinning bpf prog in the tc_redirect_peer_l3 test
>    selftests/bpf: Avoid pinning bpf prog in the netns_load_bpf() callers
>    selftests/bpf: Remove the "/sys" mount and umount dance in
>      {open,close}_netns
>    selftests/bpf: Remove serial from tests using {open,close}_netns
>    selftests/bpf: Avoid pinning prog when attaching to tc ingress in
>      btf_skc_cls_ingress

>   tools/testing/selftests/bpf/network_helpers.c |  51 +--
>   .../bpf/prog_tests/btf_skc_cls_ingress.c      |  25 +-
>   .../selftests/bpf/prog_tests/empty_skb.c      |   2 +-
>   .../selftests/bpf/prog_tests/tc_redirect.c    | 314 +++++++++---------
>   .../selftests/bpf/prog_tests/test_tunnel.c    |   2 +-
>   .../bpf/prog_tests/xdp_do_redirect.c          |   2 +-
>   .../selftests/bpf/prog_tests/xdp_synproxy.c   |   2 +-
>   7 files changed, 178 insertions(+), 220 deletions(-)

> --
> 2.30.2

