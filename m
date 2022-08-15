Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A7B59342A
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 19:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiHORqc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 13:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiHORq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 13:46:28 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCAB286DA
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 10:46:25 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id q14so4017444vke.9
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=x1liWtC1Oit7eqOHpJc33hJLgpzjzWyZL4n1jjOYZxw=;
        b=G7oqZ9YHIR500PLQXPqm/zTeMYHj8eUQsChN8JEhzPQ2KK2EIhpmfUPosUIm+nJ+3l
         btF3tx7z11Gbh478GatEGvfp8KEvTmEybwJ70WcILGcXf1ahCkGf/x3KqFJjNXb6DzAg
         SsUlpIdp2HhnOJ05i3UA0bebP4Jzdjh7VD5m/qZY4TsdchKZKH/B/sivxXJTEtdG/p8u
         eQcyI8ME148zcdHpaKKBeBTqo+u7/1ECaaFWzHLBCctR1rLzk7Sq3oBjBPUVSUUPmyPV
         xWxRjnJ6FzMrvJhTH8mf/cIN1iPlU2yvcivNZj3R8ALz7H+KMzsuBVdbKPYIxStux1K9
         7E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=x1liWtC1Oit7eqOHpJc33hJLgpzjzWyZL4n1jjOYZxw=;
        b=1bIwlTD0995sTxeF0+KXpO2Z8OGyqFC/vzGAtHkBbpoEA8+5bjQi8uW3D5uGInn7od
         JNw9Yzrtu0OPI406xAQE2KwDbmwRqJPyZ0hnrARjDZMENekijMrZK9SJ11wo3E3StJCS
         r4X+/Sj4K848jszyZLsmdujsFNMAVtEc85eyHGaQVNDSwqqsw0AJiCTJD0ApmmTEB2tJ
         ZlZodN4tOPol649FQGyTgTjYyKK3Hnl5hZtyHDb/0uWSTh3mzUBO1CiSp34sY2AYABIr
         XveJbARz2PFv4mv4PNMIxy2aNfQ/JEXa8qWVC/L58p9GRt4HD9PnGQiS3DyH8/fJPFEX
         jfIg==
X-Gm-Message-State: ACgBeo3knovVu/L99+xZs5SwZlpiHRoa2n05/l6+Nv5WxbBRfcDjSw9G
        TMpYm0vueBggXwHmu5jQj1MZG/3TC0fXKCYdgPHo7QjzFfY=
X-Google-Smtp-Source: AA6agR4g1E7UHS+I+KVtoDrM3EI+NzQMgUMy+LYL4UvHJP26MbWB2wdDXbpM0x+uaWm4p1xLdQSL4tubIIAWzrECBLc=
X-Received: by 2002:a1f:2788:0:b0:376:f54d:53bf with SMTP id
 n130-20020a1f2788000000b00376f54d53bfmr6983421vkn.29.1660585584219; Mon, 15
 Aug 2022 10:46:24 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Mon, 15 Aug 2022 10:46:13 -0700
Message-ID: <CAK3+h2zUvfa8pQ37h3ZzSx9n34sTPSUAmSR8grvwQU3OtksiTg@mail.gmail.com>
Subject: Error: bug: failed to retrieve CAP_BPF status: Invalid argument
To:     bpf <bpf@vger.kernel.org>
Cc:     Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I compile and run kernel 5.18.0 in Centos 8 from bpf-next in my dev
machine, I also compiled bpftool from bpf-next on same machine, when
run bpftool on same machine, I got :

./bpftool feature probe

Error: bug: failed to retrieve CAP_BPF status: Invalid argument

where bpftool to retrieve CAP_BPF ? from running kernel or from somewhere e=
lse?

strace show:

capget({version=3D_LINUX_CAPABILITY_VERSION_3, pid=3D0}, NULL) =3D 0

capget({version=3D_LINUX_CAPABILITY_VERSION_3, pid=3D0},
{effective=3D1<<CAP_CHOWN|1<<CAP_DAC_OVERRIDE|1<<CAP_DAC_READ_SEARCH|1<<CAP=
_FOWNER|1<<CAP_FSETID|1<<CAP_KILL|1<<CAP_SETGID|1<<CAP_SETUID|1<<CAP_SETPCA=
P|1<<CAP_LINUX_IMMUTABLE|1<<CAP_NET_BIND_SERVICE|1<<CAP_NET_BROADCAST|1<<CA=
P_NET_ADMIN|1<<CAP_NET_RAW|1<<CAP_IPC_LOCK|1<<CAP_IPC_OWNER|1<<CAP_SYS_MODU=
LE|1<<CAP_SYS_RAWIO|1<<CAP_SYS_CHROOT|1<<CAP_SYS_PTRACE|1<<CAP_SYS_PACCT|1<=
<CAP_SYS_ADMIN|1<<CAP_SYS_BOOT|1<<CAP_SYS_NICE|1<<CAP_SYS_RESOURCE|1<<CAP_S=
YS_TIME|1<<CAP_SYS_TTY_CONFIG|1<<CAP_MKNOD|1<<CAP_LEASE|1<<CAP_AUDIT_WRITE|=
1<<CAP_AUDIT_CONTROL|1<<CAP_SETFCAP|1<<CAP_MAC_OVERRIDE|1<<CAP_MAC_ADMIN|1<=
<CAP_SYSLOG|1<<CAP_WAKE_ALARM|1<<CAP_BLOCK_SUSPEND|1<<CAP_AUDIT_READ|0x1c0,
permitted=3D1<<CAP_CHOWN|1<<CAP_DAC_OVERRIDE|1<<CAP_DAC_READ_SEARCH|1<<CAP_=
FOWNER|1<<CAP_FSETID|1<<CAP_KILL|1<<CAP_SETGID|1<<CAP_SETUID|1<<CAP_SETPCAP=
|1<<CAP_LINUX_IMMUTABLE|1<<CAP_NET_BIND_SERVICE|1<<CAP_NET_BROADCAST|1<<CAP=
_NET_ADMIN|1<<CAP_NET_RAW|1<<CAP_IPC_LOCK|1<<CAP_IPC_OWNER|1<<CAP_SYS_MODUL=
E|1<<CAP_SYS_RAWIO|1<<CAP_SYS_CHROOT|1<<CAP_SYS_PTRACE|1<<CAP_SYS_PACCT|1<<=
CAP_SYS_ADMIN|1<<CAP_SYS_BOOT|1<<CAP_SYS_NICE|1<<CAP_SYS_RESOURCE|1<<CAP_SY=
S_TIME|1<<CAP_SYS_TTY_CONFIG|1<<CAP_MKNOD|1<<CAP_LEASE|1<<CAP_AUDIT_WRITE|1=
<<CAP_AUDIT_CONTROL|1<<CAP_SETFCAP|1<<CAP_MAC_OVERRIDE|1<<CAP_MAC_ADMIN|1<<=
CAP_SYSLOG|1<<CAP_WAKE_ALARM|1<<CAP_BLOCK_SUSPEND|1<<CAP_AUDIT_READ|0x1c0,
inheritable=3D0}) =3D 0
