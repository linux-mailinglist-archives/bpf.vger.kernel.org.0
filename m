Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E294E407C15
	for <lists+bpf@lfdr.de>; Sun, 12 Sep 2021 08:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhILGyf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Sep 2021 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhILGye (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Sep 2021 02:54:34 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BA5C061574
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 23:53:20 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id j18so7860319ioj.8
        for <bpf@vger.kernel.org>; Sat, 11 Sep 2021 23:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:mime-version:message-id:in-reply-to:references:date:from
         :to:cc:subject;
        bh=i79iH2a0+PKb/aBLm+LI18BSt+5UivNtgybZlwOCX/0=;
        b=HGsa9AmEjWlL2E7ilPjlAXutqBWrhrwkUCXoVJGIfM6gExfIs5D5aNxP9Ve4xhX95b
         rMdu9E9j/P6qGCM41yMH5VTVKsN6aSU2+BOeHELZpeIPkP5PLkjYUJ9xS+MHnpxKkRaN
         DhT1tp5R++0b9WxvC8Oz13I8J69JAR6hxJ0tduIQN6aWOTVWH3xw43k/vBphq1gApi+q
         gBFM98XkSeMCNTruOGqC9PK+KQbfGsVxxFHRltshPysvnkQO9RPz14DThudH4G7OhQ8i
         EHpi66TEFYjFnEdi9gA9ftq161C83U39ccedts75CBoQ5x49m/b0jQBTcfz5pP8t2BtT
         mcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:user-agent:mime-version:message-id:in-reply-to
         :references:date:from:to:cc:subject;
        bh=i79iH2a0+PKb/aBLm+LI18BSt+5UivNtgybZlwOCX/0=;
        b=r26x8Yudr0XW73GeyTtHmpngBUotT8LtsUlB0zZ3BVW5GhHc0HLc2M2CuZN+ltT0lV
         z5lZHchHAw7O/ptHLzd1OmUk5pw1P4A4GvPwV845H8l9aE9yWYvFiKvnOpxW9KMFM9q2
         9wRc1xvDv6n8Qr2VXxxrHUKJtB7txQpw1ifytE5E5lQihtFz8iV0Q6uYrsPSyz6cFuae
         RhU4fzoNP9DB7LLMg1WRldbhucJZtibyM1ya93b/NfqAxtPCFMuXxcSXg2ahjuPcO11M
         ByG2QA8ofwHCOJ6ROdNX41w8rlRaXU2q8tKetqs7vYdKGsu/eIdMgG4Lq3ENTWPH/71q
         02xA==
X-Gm-Message-State: AOAM5328SXXBBYSS+s7CE8IDM3rYrjOLit35Y3rgt2Tu570/qdGFpPZ/
        XVSHUTALnbIefT7hPOUrtg==
X-Google-Smtp-Source: ABdhPJwkBlTX67H09D4qPkUDxoYhiZ/QrrBi6xzXyf5iZl3G7351R8r7sl+0Yk9RN/rgUBspfkkllg==
X-Received: by 2002:a6b:905:: with SMTP id t5mr4323233ioi.209.1631429600148;
        Sat, 11 Sep 2021 23:53:20 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 12sm2332274ilq.37.2021.09.11.23.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 23:53:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 12F7927C0054;
        Sun, 12 Sep 2021 02:53:19 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Sun, 12 Sep 2021 02:53:19 -0400
X-ME-Sender: <xms:3qM9YdartBTkX2rj1NBGaZhFkapZ1erm05IpklMJmxLf8Afj9w7W-w>
    <xme:3qM9YUaKjWgcefGZ3ZE_CLSDEycMS4t7akU58ngj8UuTwV3BjuZAtq302079EXGQU
    KpIOi_6Gw-h3jSfEPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeggedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesth
    dtredtreerjeenucfhrhhomhepfdftrghfrggvlhcuffgrvhhiugcuvfhinhhotghofdcu
    oehrrghfrggvlhguthhinhhotghosehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeegkeeuieefvdegtefgieffteeifeejkeejudeludegtdektdehgeeiudegiefhveen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprhgrfhgrvghlughtihhnohgtohdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudduledtkeeifeefiedqvdehheekjeelfeeiqd
    hrrghfrggvlhguthhinhhotghopeepghhmrghilhdrtghomhesuddvfehmrghilhdrohhr
    gh
X-ME-Proxy: <xmx:3qM9Yf8bZ9Isgv1ECffAb0hgSBA4gFFjT-J1aknen_RQdqj3Q9PERQ>
    <xmx:3qM9YbpxBW81nRbLBVZLo90b-SW_sxfzcBgweztV8TvDt6lv8JZGEQ>
    <xmx:3qM9YYpMOomMr3dBpOxTX4tnWA6HZ8Oe6dWGj8YT75ShdTHfs15uXA>
    <xmx:36M9YeF_AklxO33fkFqO3sdUr3Rr8J_H42s-LnqovI0dYF59qdbozw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B023E1EE0064; Sun, 12 Sep 2021 02:53:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1229-g7ca81dfce5-fm-20210908.005-g7ca81dfc
Mime-Version: 1.0
Message-Id: <702a2a6a-aea2-4dd4-8059-23ee87a4f87d@www.fastmail.com>
In-Reply-To: <20210912064844.3181742-1-rafaeldtinoco@gmail.com>
References: <CAEf4BzYPNsgMMU9Xi-Ya53-264MYrQNWWQNAyDJqNEgawk+V-g@mail.gmail.com>
 <20210912064844.3181742-1-rafaeldtinoco@gmail.com>
Date:   Sun, 12 Sep 2021 03:52:58 -0300
From:   "Rafael David Tinoco" <rafaeldtinoco@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii.nakryiko@gmail.com
Subject: =?UTF-8?Q?Re:_[PATCH_bpf-next_v5]_libbpf:_introduce_legacy_kprobe_events?=
 =?UTF-8?Q?_support?=
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Allow kprobe tracepoint events creation through legacy interface, as the
> kprobe dynamic PMUs support, used by default, was only created in v4.17.
> 
> After commit "bpf: implement minimal BPF perf link", it was allowed that
> some extra - to the link - information is accessed through container_of
> struct bpf_link. This allows the tracing perf event legacy name, and
> information whether it is a retprobe, to be saved outside bpf_link
> structure, which would not be optimal.
> 
> This enables CO-RE support for older kernels.
> 
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>

Tested using: https://github.com/rafaeldtinoco/portablebpf

Single execution:

# cat kernel/debug/tracing/kprobe_events
p:kprobes/tcp_connect_libbpf_20166 tcp_connect
r4:kretprobes/tcp_connect_libbpf_20166 tcp_connect

Simultaneous execution:

# cat kernel/debug/tracing/kprobe_events
p:kprobes/tcp_connect_libbpf_20166 tcp_connect
r4:kretprobes/tcp_connect_libbpf_20166 tcp_connect
p:kprobes/tcp_connect_libbpf_20177 tcp_connect
r4:kretprobes/tcp_connect_libbpf_20177 tcp_connect

kprobe_events was cleared after execution.
