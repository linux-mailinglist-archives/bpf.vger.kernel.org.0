Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0495F7AC0
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 17:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJGPnS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJGPnR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 11:43:17 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183CDD73E8
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 08:43:14 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so3730477oog.12
        for <bpf@vger.kernel.org>; Fri, 07 Oct 2022 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mozf1uPcQjIidCs+o1oK9uZZ1pk0n9LGediWQVUrKKk=;
        b=yfonxeDoQSoLXljq7Q6Kh/DpndNLETkhGeSo22PVD1d4Il2TjCdxonzqlVOcodhncW
         Ur/WEpqD5gav9l8hdcLH3pCNADh5rRK4lgm7BO/a0v6X1Qsgt2bI3yQVUG5ASY08iVnF
         SBvCxtN7HoIwzBi2u1CR6YcfpWDw6UrfC7h/vZ25QhNb5LSXgQVy3TtZX4yT8ov/9PZz
         cOTtXsr8ZPl5gDQzpe6N9fcizAtfVeB5d5ATvA8ND8DTo/qgiK6vASecSDaDXJ55EnPF
         ba3EhSvEC4A4Bcznj4rA9br0Vi4LVjeJeQCtAcbqFZbE6iRN38GLRDI9T0yCAs0A4iCn
         SgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mozf1uPcQjIidCs+o1oK9uZZ1pk0n9LGediWQVUrKKk=;
        b=upeX4UQ9oLa3xh3RgDXy1BKHT1bYf1hwYP1X2BupGW+Y8JnLuxcKZ9UBjT1sfXTAqY
         ZiL9c/+MC5dVayT3QXHBtZQdp+XONcylbMbnfvtN+L9sE2q0Ol/tbQuXaRYdvGD4rH+8
         3KwYegYlo7e1D2Jx4fCqnv/nSp3R4+MiGBBoPGH2F9GOsL2yEYotYAdjbw6DOXBBFUWp
         EF8138EapOTNRJtLv0MaHQ9CI06DeYRiUJH6WSCRhvGHa6ZBs8VKPLQhjRZdWke69nPU
         9NQ+4w1oFbNwtJBBw+YIkOt34R1Ba2E1+NDL+Xj6J0Hlxhc3N4dVyddqboyYXKlC6Fmm
         dOZQ==
X-Gm-Message-State: ACrzQf0kCMQlxznP12ulCsGumxyJT75BpThyQI6cGdshoUO042d5FB45
        cbUY3gdwSAWayJ8SXUAfMyqhdsK8+eyXwKsZ/c3gpg==
X-Google-Smtp-Source: AMsMyM7pAYg0CFNhxWoGp+UiHPlxhNQb0zVdYYoXZebQKrrI8iTf46NQA90kLkfVKpN5AnP/TgRvaJjz+QyutI24hIY=
X-Received: by 2002:a4a:5e47:0:b0:476:2f9e:b30e with SMTP id
 h68-20020a4a5e47000000b004762f9eb30emr2119887oob.46.1665157393773; Fri, 07
 Oct 2022 08:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221004231143.19190-1-daniel@iogearbox.net> <20221004231143.19190-2-daniel@iogearbox.net>
 <20221006050053.pbwo72xtzoza6gfl@macbook-pro-4.dhcp.thefacebook.com>
 <CAM0EoMnJzP6kbr94utjDT1X=e9G21-uu=Cbqhx2XLfqXE+HDwA@mail.gmail.com> <CAADnVQK2tWmZW0=y89mv-r9kO4U2H=azWmbr7g1yqLhU1aX3SQ@mail.gmail.com>
In-Reply-To: <CAADnVQK2tWmZW0=y89mv-r9kO4U2H=azWmbr7g1yqLhU1aX3SQ@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Fri, 7 Oct 2022 11:43:02 -0400
Message-ID: <CAM0EoMnfnp5ULiHU-E769yg8Gj534WADZAthuY7T=mW8WrKp4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/10] bpf: Add initial fd-based API to attach tc
 BPF programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Joe Stringer <joe@cilium.io>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 6, 2022 at 7:29 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 6, 2022 at 7:41 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:

[..]
> > You just described the features already offered by tc opcodes + priority.
>
> Ohh, right. All possible mechanisms were available in TC 20 years ago.
> Moving on.

Alexei, it is the open source world - you can reinvent bell bottom
pants, the wheel, etc
just please dont mutilate or kill small animals along the way.

cheers,
jamal
