Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48F607E31
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiJUSSy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJUSSy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 14:18:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFD95FC2;
        Fri, 21 Oct 2022 11:18:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id u21so8941609edi.9;
        Fri, 21 Oct 2022 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBy852p/eFXTHVwkFlaYMzpbGvpT4Vnv3Ued5+TSdT0=;
        b=gmJLVnkwL3+648iF7oobHbK+Rl5eRiwbOP/+YztPxkWicIqLQTvyrjgzSiy9HTd7M4
         2seQ2DnnNHOCBNtXZ5rINSLl9OXcgKKZENY8LBu9QEBNfh8pwaJNzmYdRdzzfiOGi1v7
         d/B+cFbD85GD4/nwfR1KmVoP2s/G0iuipUu4esi32tTz3o3RzLgSphJFZ77c3EuFAXRd
         rwIYPT7Mfv1trYAd0c6Fkaiqh+2V3UYx4DPa3JGr26tjC7AKqPeBHuskUYumlcQfZR+b
         7dVkeEm6hizboBTBaTJYR9+aVREzhcxHyoIZnXdpfhVuG0Sj2J6XNZBLgZAx7HXbeG9e
         CfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBy852p/eFXTHVwkFlaYMzpbGvpT4Vnv3Ued5+TSdT0=;
        b=Vp2lvqEa1XAioiKHcCyOr840y1ExIsMv4bFRbYGEWfL3k1ebNtzsks1MqWKW8d6ptO
         O83dgOwsPuMfj6IZEzcijqoDCQCXxtP6/IgTD3cBlXdRd/W1HIfMJfI2olU4pqwGuAcZ
         rve6gACbCo8yz8acTFsDpMUdRx9YRXHcf9KT3ib6V87ZJ8cl/Qsk/kPM1PCqgavX6BOK
         Z1iiAG9TxR0IcoEieujeZM2+AqQAglyo8Y71zx52IFiG2pnnd0iuRsibE7SFNJ6X4Mtk
         aWmmVv3QgtSMB5mQ5mZ1SPPkvLQPBXlQQXb9eykkvfQ79AG+cXh8XsKwh9ZKcNUKZ4PY
         u5wg==
X-Gm-Message-State: ACrzQf28egm5S5N2IcSKM9DEssA7qkMRp7ldLquK1hzlMJSf6cnbkX5L
        hXkK9rU8KOwPiA0721keZRCevlVkApH1MzY1Ee9aYE2MCFo=
X-Google-Smtp-Source: AMsMyM5tP9EcZoBMgjdZMwEr67Y+wX0+oOJLb6VbWoOSvQbk9JuKQ//RzTpAqxWNhMrPap0yP7GvET0EfnRokuzhjbo=
X-Received: by 2002:a17:907:2cca:b0:78d:ec48:ac29 with SMTP id
 hg10-20020a1709072cca00b0078dec48ac29mr16544045ejc.114.1666376331530; Fri, 21
 Oct 2022 11:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221003214941.6f6ea10d@kernel.org> <YzvV0CFSi9KvXVlG@krava>
 <20221004072522.319cd826@kernel.org> <Yz1SSlzZQhVtl1oS@krava>
 <20221005084442.48cb27f1@kernel.org> <20221005091801.38cc8732@kernel.org>
 <Yz3kHX4hh8soRjGE@krava> <20221013080517.621b8d83@kernel.org>
 <Y0iNVwxTJmrddRuv@krava> <CAEf4Bzbow+8-f4rg2LRRRUD+=1wbv1MjpAh-P4=smUPtrzfZ3Q@mail.gmail.com>
 <Y0kF/radV0cg4JYk@krava>
In-Reply-To: <Y0kF/radV0cg4JYk@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 11:18:39 -0700
Message-ID: <CAEf4BzZm2ViaHKiR+4pmWj6yzcPy23q-g_e+cJ90sXuDzkLmSw@mail.gmail.com>
Subject: Re: WARN: multiple IDs found for 'nf_conn': 92168, 117897 - using 92168
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
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

On Thu, Oct 13, 2022 at 11:47 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Oct 13, 2022 at 03:24:59PM -0700, Andrii Nakryiko wrote:
> > On Thu, Oct 13, 2022 at 3:12 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Oct 13, 2022 at 08:05:17AM -0700, Jakub Kicinski wrote:
> > > > On Wed, 5 Oct 2022 22:07:57 +0200 Jiri Olsa wrote:
> > > > > > Yeah, it's there on linux-next, too.
> > > > > >
> > > > > > Let me grab a fresh VM and try there. Maybe it's my system. Somehow.
> > > > >
> > > > > ok, I will look around what's the way to install that centos 8 thing
> > > >
> > > > Any luck?
> > >
> > > now BTFIDS warnings..
> > >
> > > I can see following on centos8 with gcc 8.5:
> > >
> > >           BTFIDS  vmlinux
> > >         WARN: multiple IDs found for 'task_struct': 300, 56614 - using 300
> > >         WARN: multiple IDs found for 'file': 540, 56649 - using 540
> > >         WARN: multiple IDs found for 'vm_area_struct': 549, 56652 - using 549
> > >         WARN: multiple IDs found for 'seq_file': 953, 56690 - using 953
> > >         WARN: multiple IDs found for 'inode': 1132, 56966 - using 1132
> > >         WARN: multiple IDs found for 'path': 1164, 56995 - using 1164
> > >         WARN: multiple IDs found for 'task_struct': 300, 61905 - using 300
> > >         WARN: multiple IDs found for 'file': 540, 61943 - using 540
> > >         WARN: multiple IDs found for 'vm_area_struct': 549, 61946 - using 549
> > >         WARN: multiple IDs found for 'inode': 1132, 62029 - using 1132
> > >         WARN: multiple IDs found for 'path': 1164, 62058 - using 1164
> > >         WARN: multiple IDs found for 'cgroup': 1190, 62067 - using 1190
> > >         WARN: multiple IDs found for 'seq_file': 953, 62253 - using 953
> > >         WARN: multiple IDs found for 'sock': 7960, 62374 - using 7960
> > >         WARN: multiple IDs found for 'sk_buff': 1876, 62485 - using 1876
> > >         WARN: multiple IDs found for 'bpf_prog': 6094, 62542 - using 6094
> > >         WARN: multiple IDs found for 'socket': 7993, 62545 - using 7993
> > >         WARN: multiple IDs found for 'xdp_buff': 6191, 62836 - using 6191
> > >         WARN: multiple IDs found for 'sock_common': 8164, 63152 - using 8164
> > >         WARN: multiple IDs found for 'request_sock': 17296, 63204 - using 17296
> > >         WARN: multiple IDs found for 'inet_request_sock': 36292, 63222 - using 36292
> > >         WARN: multiple IDs found for 'inet_sock': 32700, 63225 - using 32700
> > >         WARN: multiple IDs found for 'inet_connection_sock': 33944, 63240 - using 33944
> > >         WARN: multiple IDs found for 'tcp_request_sock': 36299, 63260 - using 36299
> > >         WARN: multiple IDs found for 'tcp_sock': 33969, 63264 - using 33969
> > >         WARN: multiple IDs found for 'bpf_map': 6623, 63343 - using 6623
> > >
> > > I'll need to check on that..
> > >
> > > and I just actually saw the 'nf_conn' warning on linux-next/master with
> > > latest fedora/gcc-12:
> > >
> > >           BTF [M] net/netfilter/nf_nat.ko
> > >         WARN: multiple IDs found for 'nf_conn': 106518, 120156 - using 106518
> > >         WARN: multiple IDs found for 'nf_conn': 106518, 121853 - using 106518
> > >         WARN: multiple IDs found for 'nf_conn': 106518, 123126 - using 106518
> > >         WARN: multiple IDs found for 'nf_conn': 106518, 124537 - using 106518
> > >         WARN: multiple IDs found for 'nf_conn': 106518, 126442 - using 106518
> > >         WARN: multiple IDs found for 'nf_conn': 106518, 128256 - using 106518
> > >           LD [M]  net/netfilter/nf_nat_tftp.ko
> > >
> > > looks like maybe dedup missed this struct for some reason
> > >
> > > nf_conn dump from module:
> > >
> > >         [120155] PTR '(anon)' type_id=120156
> > >         [120156] STRUCT 'nf_conn' size=320 vlen=14
> > >                 'ct_general' type_id=105882 bits_offset=0
> > >                 'lock' type_id=180 bits_offset=64
> > >                 'timeout' type_id=113 bits_offset=640
> > >                 'zone' type_id=106520 bits_offset=672
> > >                 'tuplehash' type_id=106533 bits_offset=704
> > >                 'status' type_id=1 bits_offset=1600
> > >                 'ct_net' type_id=3215 bits_offset=1664
> > >                 'nat_bysource' type_id=139 bits_offset=1728
> > >                 '__nfct_init_offset' type_id=949 bits_offset=1856
> > >                 'master' type_id=120155 bits_offset=1856
> > >                 'mark' type_id=106351 bits_offset=1920
> > >                 'secmark' type_id=106351 bits_offset=1952
> > >                 'ext' type_id=106536 bits_offset=1984
> > >                 'proto' type_id=106532 bits_offset=2048
> > >
> > > nf_conn dump from vmlinux:
> > >
> > >         [106517] PTR '(anon)' type_id=106518
> > >         [106518] STRUCT 'nf_conn' size=320 vlen=14
> > >                 'ct_general' type_id=105882 bits_offset=0
> > >                 'lock' type_id=180 bits_offset=64
> > >                 'timeout' type_id=113 bits_offset=640
> > >                 'zone' type_id=106520 bits_offset=672
> > >                 'tuplehash' type_id=106533 bits_offset=704
> > >                 'status' type_id=1 bits_offset=1600
> > >                 'ct_net' type_id=3215 bits_offset=1664
> > >                 'nat_bysource' type_id=139 bits_offset=1728
> > >                 '__nfct_init_offset' type_id=949 bits_offset=1856
> > >                 'master' type_id=106517 bits_offset=1856
> > >                 'mark' type_id=106351 bits_offset=1920
> > >                 'secmark' type_id=106351 bits_offset=1952
> > >                 'ext' type_id=106536 bits_offset=1984
> > >                 'proto' type_id=106532 bits_offset=2048
> > >
> > > look identical.. Andrii, any idea?
> >
> > I'm pretty sure they are not identical. There is somewhere a STRUCT vs
> > FWD difference. We had a similar discussion recently with Alan
> > Maguire.
> >
> > >                 'master' type_id=120155 bits_offset=1856
> >
> > vs
> >
> > >                 'master' type_id=106517 bits_offset=1856
>
> master is pointer to same 'nf_conn' object, and rest of the ids are same
>

You are right, they should be identical once PTR is deduplicated
properly. Sorry, was too quick to jump to conclusions. I was thinking
about situations explained by Alan.

So, is this still an issue or this was fixed by [0]?

  [0] https://lore.kernel.org/bpf/1666364523-9648-1-git-send-email-alan.maguire@oracle.com/

> jirka
