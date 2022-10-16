Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133445FFCA9
	for <lists+bpf@lfdr.de>; Sun, 16 Oct 2022 02:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJPACT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Oct 2022 20:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJPACS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Oct 2022 20:02:18 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA303C8C7
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 17:02:17 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id 23-20020a5d9c57000000b006bbd963e8adso5089773iof.19
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 17:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTFzBgJgSwbr/DQpi6/QIbsaM9yQ3pzzrj34mApYPQw=;
        b=jUDtSZNZZV4YZX287wLktUsJstkDXurfUQgSpmIattyIMgwhWUb6d1Knp8SiJXXAZD
         K18i7oGpJNEBzz/Lf7HrNv5DBfn0qHXfwW8faPDNC8Ak0AxaAyXMs+7nTpVLUuy4k/wI
         WNkyFiCjvUjLMuVlsCdGtRJHdLcZfqwTJ1Av2ORSrbp2fzJv6H7K/uBQWUBydzgWgA5L
         T8goTNXlcPYkDgNtVA4V88+16+Jt9XatkBwnPSUexEBpQ5jKcVEKINsIrhp1+PYLy49Z
         tJyktnJwUoO/u44zVnniNejzRZuZ56IXBX4UVPgSVT/ni0mIAD3SmnVpgQcdWmdsXSFj
         T29A==
X-Gm-Message-State: ACrzQf1+U5lxvh1SDGkCHoSwwvTczhL2tCNS0iJVI0g+8t0Pey7UwXZP
        nDxbfhsqM0CtU97Hw8xpo2+wlL7b6s30YVNOdq9O6xMUg4fS
X-Google-Smtp-Source: AMsMyM6Zj/1VDtsfAI7vf6E11njjEZCpcpnwTaDHGXoEqMPGQ2pTpRN9x8Xl2gE/Ha9COQXlqe7IQsgI9FXk8ScmsYZX0Mle4c28
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d0d:b0:363:e6b8:2bd6 with SMTP id
 q13-20020a0566380d0d00b00363e6b82bd6mr2359971jaj.296.1665878536908; Sat, 15
 Oct 2022 17:02:16 -0700 (PDT)
Date:   Sat, 15 Oct 2022 17:02:16 -0700
In-Reply-To: <20221015154817-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e720f05eb1b929e@google.com>
Subject: Re: [syzbot] net boot error: WARNING in cpumask_next_wrap
From:   syzbot <syzbot+4d0c5794bff07852726c@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
        jasowang@redhat.com, john.fastabend@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/net: failed to run ["git" "fetch" "--force" "5c96e23a32a280262291fe5d31d8f7dc6f666b47" "net"]: exit status 128
fatal: couldn't find remote ref net



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git net
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0c5794bff07852726c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=176372c2880000

