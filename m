Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54D34B8C7E
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiBPPdx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 10:33:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiBPPdv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 10:33:51 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19C1A8CD7
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 07:33:39 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s5so1393619oic.10
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PKaLnPAVB/8NQZedMe52HBoBwCb2QIATkxMAoUN1Ac=;
        b=pGt9syx90y3aKpAenQxv/logAOmOyibTM4MaiFODGm5BF++2l6Xmu2MDgiOz2URIpf
         c7c/2ImUBi2SwdKb1qZFyTWVwHWd626TpE0FhaKYyao6GaEt5gtYz7Yt1dRWRnu7mhAN
         1rpWemgQJSzpKJhAD7K7ep1gpHPHMxz7gGMOv6oospqZKzp0CrJsGorQ6Ed0xtvRF+KH
         rih1y8bj2grv25UoaoLaMg8HsfyILiL63DdBrCqPaIntOM0zgr4trMtE+yNVsQcQALqE
         xJYSspvCSugN0FyE7JNBUx+qHc2ZpZZagi9pxA+1fuf9tU3OHfL/bk3HYrpVOqDGdXs+
         P3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PKaLnPAVB/8NQZedMe52HBoBwCb2QIATkxMAoUN1Ac=;
        b=y/aRKC/mS0a3EC9OiXRURIxmkgRsr/LV2UmxdEooaHFqao8obbH7372e/UXmhf6nCQ
         +aPf5JpC6KArXA7QHBfTNdm0bqqFUJOBMf0agtGTb6Z2Nlx5oEaSlwmRfNHlRRbOvoF2
         cGb/wdMRaygBA7kR5AJ52Hw7oWmqEPMPqU4TbbvrCMu+guaQ2+KpdDkhLfXwqgDI92Gm
         6uvN5f/wrVg3onrrVFpNIPQJ7dlleGY43V/n8FQaM4IGzVnVWoDXl73d2gwO8fglLUR+
         bhTW8U24Bk1H+0e/PiZvUb29WaeoAmPSQ3LNp4TqWF8LBznaX+V0bQO0uEec4SDn3iZe
         FNqw==
X-Gm-Message-State: AOAM533vLxqLkeYh/6s6vBkxP3z7dzxvDj4ZGEnqY9rxXJrd7agjdLVV
        v++UbAQFs6n+lpZjVP2t06BAYnJWyFHJw+ww3Eum3Q==
X-Google-Smtp-Source: ABdhPJzb4w/ZFWSod0DdN2eXaVNhzE93WJH3MgVi3v/fz28FNbUsunf1/xFQuTDdipvdasxMY3CUm5q2LG5gxGrZzbU=
X-Received: by 2002:a05:6808:13c7:b0:2cf:455a:8ed6 with SMTP id
 d7-20020a05680813c700b002cf455a8ed6mr949775oiw.339.1645025618526; Wed, 16 Feb
 2022 07:33:38 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a16ad7059cbcbe43@google.com> <000000000000e238bf05d7a69450@google.com>
In-Reply-To: <000000000000e238bf05d7a69450@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Feb 2022 16:33:27 +0100
Message-ID: <CACT4Y+bdBqjOTB5nfVyNOT1r7+Fy-wqFHNVp7Qb8Ztq0SRH=dQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in bpf_warn_invalid_xdp_action
To:     syzbot <syzbot+8ce4113dadc4789fac74@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, eric.dumazet@gmail.com,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, toke@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 10 Feb 2022 at 10:29, syzbot
<syzbot+8ce4113dadc4789fac74@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 2cbad989033bff0256675c38f96f5faab852af4b
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Tue Nov 30 10:08:06 2021 +0000
>
>     bpf: Do not WARN in bpf_warn_invalid_xdp_action()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d50baa700000
> start commit:   b3c8e0de473e Merge branch '40GbE' of git://git.kernel.org/..
> git tree:       net
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ce4113dadc4789fac74
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113c8a3bb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16eb4307b00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: bpf: Do not WARN in bpf_warn_invalid_xdp_action()

Looks legit:

#syz fix: bpf: Do not WARN in bpf_warn_invalid_xdp_action()
