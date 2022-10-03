Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D65F390A
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 00:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJCW3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 18:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJCW3U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 18:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0710656B95
        for <bpf@vger.kernel.org>; Mon,  3 Oct 2022 15:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664836156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KloP+jS2Ou38p085MiqdGw+v9zYs5zl1rg3Sta17Wr0=;
        b=az5UuowUrFHuLIZ5FBNghj8ryJ71MF+tOtwnuGPCmskST4Hz4jUmOJO1MCYi4XFQ0CQz4z
        v32jiGnQMcca3tx6x/Revr0cwdknjjqrRDe4zHanS4wmYn8irdiwqfFvXV7OeAgVoW6tL8
        M0ztluseJ23afGI8YEXYMolro1T98sE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-skhA_xFXO6GX9V5YYZsAlg-1; Mon, 03 Oct 2022 18:29:15 -0400
X-MC-Unique: skhA_xFXO6GX9V5YYZsAlg-1
Received: by mail-wr1-f70.google.com with SMTP id g15-20020adfbc8f000000b0022a4510a491so3449661wrh.12
        for <bpf@vger.kernel.org>; Mon, 03 Oct 2022 15:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KloP+jS2Ou38p085MiqdGw+v9zYs5zl1rg3Sta17Wr0=;
        b=5PHPO6ADYue/BgJR735uxHpYX7oy1jauPKS5jZ+VapE8Y1o+p1zdZAovZhR7rXNhfT
         7f+bxiehweDfD93jmwoX7C1ZZiciZNqKMyAm25qhDvyrFhWtSeXUNU95jbkW1mMqjScc
         MSBtq4/WfUbCQ1r0LKtsYdUErsMiDFybV0qunU6yQAfTM/vRg81EXxJqV6QnWqG4dW37
         QYUiioTAGUI+wV33D01HXYUtkNvWFUtFLwxqIBRS8bH9MV3NtK+XFEUdLRCQ3MNDO0ZM
         RNqQyBe/HkEFixPU868ocfxAhRq3JVXV3kwd6dry02bSD7QzDN/V99JT9vYTU+9Slt30
         oXbg==
X-Gm-Message-State: ACrzQf3beo4tSw+xin+xvQLinkx9o777eUs8eJZMty2Hf1kvgwGWmvX2
        I6qJ5qhYZH3wObX4h9nN+yxk5ZB+HKxBhsrew/o9UmXcuZ8r3U5+KVKJaYx+bbVYN79lS+Do/+0
        wg2XXdolLCFLMBb/BlD0tQyYFpNhT
X-Received: by 2002:a5d:6d0b:0:b0:22a:ca5b:a37e with SMTP id e11-20020a5d6d0b000000b0022aca5ba37emr14115712wrq.383.1664836153802;
        Mon, 03 Oct 2022 15:29:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Re+SW0nBPW1pAT37RKgPYOtNOxJuAVwHz58co/cIlEH1Oa9upJ4cl7K3c5MM5koSeqMJUjBX0ew2I02IX+GU=
X-Received: by 2002:a5d:6d0b:0:b0:22a:ca5b:a37e with SMTP id
 e11-20020a5d6d0b000000b0022aca5ba37emr14115697wrq.383.1664836153606; Mon, 03
 Oct 2022 15:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <5e89b653-3fc6-25c5-324b-1b15909c0183@I-love.SAKURA.ne.jp>
 <166480021535.14393.17575492399292423045.git-patchwork-notify@kernel.org> <4aae5e2b-f4d5-c260-5bf8-435c525f6c97@I-love.SAKURA.ne.jp>
In-Reply-To: <4aae5e2b-f4d5-c260-5bf8-435c525f6c97@I-love.SAKURA.ne.jp>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 3 Oct 2022 18:29:02 -0400
Message-ID: <CAK-6q+g7JQZkRJhp6qv_H9xGfD4DWnaChmQ7OaWJs3CAjfMnpA@mail.gmail.com>
Subject: Re: [PATCH] net/ieee802154: reject zero-sized raw_sendmsg()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     patchwork-bot+netdevbpf@kernel.org,
        "David S. Miller" <davem@davemloft.net>, alex.aring@gmail.com,
        stefan@datenfreihafen.org, shaozhengchao@huawei.com,
        ast@kernel.org, sdf@google.com, linux-wpan@vger.kernel.org,
        syzbot+5ea725c25d06fb9114c4@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Mon, Oct 3, 2022 at 8:35 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/10/03 21:30, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> >
> > This patch was applied to netdev/net.git (master)
> > by David S. Miller <davem@davemloft.net>:
> >
> > On Sun, 2 Oct 2022 01:43:44 +0900 you wrote:
> >> syzbot is hitting skb_assert_len() warning at raw_sendmsg() for ieee802154
> >> socket. What commit dc633700f00f726e ("net/af_packet: check len when
> >> min_header_len equals to 0") does also applies to ieee802154 socket.
> >>
> >> Link: https://syzkaller.appspot.com/bug?extid=5ea725c25d06fb9114c4
> >> Reported-by: syzbot <syzbot+5ea725c25d06fb9114c4@syzkaller.appspotmail.com>
> >> Fixes: fd1894224407c484 ("bpf: Don't redirect packets with invalid pkt_len")
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - net/ieee802154: reject zero-sized raw_sendmsg()
> >     https://git.kernel.org/netdev/net/c/3a4d061c699b
>
>
> Are you sure that returning -EINVAL is OK?
>
> In v2 patch, I changed to return 0, for PF_IEEE802154 socket's zero-sized
> raw_sendmsg() request was able to return 0.

I currently try to get access to kernel.org wpan repositories and try
to rebase/apply your v2 on it. Then it should be fixed in the next
pull request to net. For netdev maintainers, please don't apply wpan
patches. Stefan and I will care about it.

Thanks.

- Alex

