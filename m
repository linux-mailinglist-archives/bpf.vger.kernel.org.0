Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF5F652832
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 22:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLTVEF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 16:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLTVED (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 16:04:03 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E0192AF
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:03:59 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f3so9158341pgc.2
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWU9G/Xx/ih5iSxHWbpwuhZ8D/uAYmk+lQZdCKagPA8=;
        b=dfZN7x44eI3C/dt4rQ6rjpxfHEuyUj96dXLYiJ22o83fIhEW3x7vGh4ebMdmPo/SGH
         NZVx4pNxgPp4GZXRNG/pgnAVDi6GnvFG7ERrtFmAMI9P1wCVGVl7PIOwJ7wto8SX7z05
         mcAU321XkBr5kS2WAPG6o03vkIW0rcn8I/dx22dlrSu9cREAF4CFxC7vJ91AbdF2srBL
         0KhHLEXZNUAah9HKxvBUB2TxTAfUERqkrlnLFdMnMDQQAKA+M3PvflVibgqRpmzvRB8o
         CfZFKmjm/0LlLHhP6lNI/L+b+y5kfYE1nzRMEFWy3qU5ilpqEXp7pPir0r2QAIxaXlTx
         WmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWU9G/Xx/ih5iSxHWbpwuhZ8D/uAYmk+lQZdCKagPA8=;
        b=hUYStqvgvindNsb8vKlSQzQ3oL8iOvgrxGXFroBIoydIXY9CoQt3dh/LsNcr0HNyuJ
         +pLhX+nuloi4u0bJLoCjJ1l3WXbkJnQi12t7bUOZk/y84Mj3ZQNd1fhTPZbmHjpnf3tg
         q2y6nrmz1e8FOHi2WJBRcJYryn9vvv5YOEtIbmLvWN7GVf/yDRNGrbwsGmcjGzs9W7B5
         Zrh9eGYZfrJFlDFv2GY0NoMnQ6AUQnIp/yiOMpBzoFP6GqxKBNFlNWcLW8vbPTyqyyef
         C67yAeWkA85FY6hvO+QZlLfnLtU4+fBjvtm4zdM6xakd7LPVSVtu8Xcx9iLSxDKVh3Aq
         uzsw==
X-Gm-Message-State: ANoB5pmIMQUEbkQMVjgbFeb/VGqzISoo7tpGLAoeAcumtfCNxeDoeuUR
        an4PIZV4kR4LbNyP4r4pCRzXIpEn1s53ShFfJpOT8g==
X-Google-Smtp-Source: AA0mqf7/ae9emvgxI+OmGLvPYzIOrmn9/eyMWKZOfwx1a2OlqykXIvlGqoMPATmeKKxHtaYr+Hy989y1bODlKC/cst4=
X-Received: by 2002:aa7:9006:0:b0:578:8d57:12ce with SMTP id
 m6-20020aa79006000000b005788d5712cemr2152898pfo.42.1671570239176; Tue, 20 Dec
 2022 13:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20221219135939.GA296131@ubuntu> <Y6C1SFEj9MOOnAnb@google.com>
 <20221220113718.GA1109523@ubuntu> <CAKH8qBuerUeU7M2x5cfjJUuSjNTZj84Hd5s+rLZ+h-XHG_a4GA@mail.gmail.com>
 <AA40C8DF-45F6-4BFB-8A2D-F4714B754479@kernel.org>
In-Reply-To: <AA40C8DF-45F6-4BFB-8A2D-F4714B754479@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 20 Dec 2022 13:03:47 -0800
Message-ID: <CAKH8qBukDoBYZh+qvGw_Q4iXd2D9YJoWV5+gzyaU01j5b0tFPA@mail.gmail.com>
Subject: Re: [report] OOB in bpf_load_prog() flow
To:     Kees Cook <kees@kernel.org>
Cc:     Hyunwoo Kim <v4bel@theori.io>, keescook@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev,
        syzbot+b1e1f7feb407b56d0355@syzkaller.appspotmail.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 20, 2022 at 11:08 AM Kees Cook <kees@kernel.org> wrote:
>
> On December 20, 2022 9:32:51 AM PST, Stanislav Fomichev <sdf@google.com> wrote:
> >On Tue, Dec 20, 2022 at 3:37 AM Hyunwoo Kim <v4bel@theori.io> wrote:
> >>
> >> On Mon, Dec 19, 2022 at 11:02:32AM -0800, sdf@google.com wrote:
> >> > On 12/19, Hyunwoo Kim wrote:
> >> > > Dear,
> >> >
> >> > > This slab-out-of-bounds occurs in the bpf_prog_load() flow:
> >> > > https://syzkaller.appspot.com/text?tag=CrashLog&x=172e2510480000
> >> >
> >> > > I was able to trigger KASAN using this syz reproduce code:
> [...]
> >> >
> >> > > IMHO, the root cause of this seems to be commit
> >> > > ceb35b666d42c2e91b1f94aeca95bb5eb0943268.
> >> >
> >> > > Also, a user with permission to load a BPF program can use this OOB to
> >> > > execute the desired code with kernel privileges.
> >> >
> >> > Let's CC Kees if you suspect the commit above. Maybe we can run
> >> > with/without it to confirm?
> >>
> >> I built and tested each commit of 'kernel/bpf/verifier.c' that caused
> >> OOB, but I couldn't find the commit that caused OOB.
> >>
> >> So, starting from upstream, I reversed commits one by one and
> >> found the commit that triggers KASAN.
> >>
> >> As a result of testing, OOB is triggered from commit
> >> 8fa590bf344816c925810331eea8387627bbeb40.
> >>
> >> However, this commit seems to be a kvm related patch,
> >> not directly related to the bpf subsystem.
> >>
> >> IMHO, the cause of this seems to be one of these:
> >> 1. I ran this KASAN test on a nested guest in L2. That is,
> >> there is a problem with the kvm patch 8fa590bf34481.
> >>
> >> 2. Previously, the BPF subsystem had a patch that triggers KASAN,
> >> and KASAN is induced when kvm is patched.
> >>
> >> 3. There was confusion in the .config I tested, so the wrong
> >> patch was derived as a test result.
> >>
> >> I haven't been able to pinpoint what the root cause is yet.
> >> So I didn't add a CC for 8fa590bf34481 commit.
> >
> >Thanks for the details! Even if this particular one is unrelated,
> >there are a couple of reports which still somewhat look like they are
> >related to commit ceb35b666d42 ("bpf/verifier: Use
> >kmalloc_size_roundup() to match ksize() usage") ?
> >
> >https://lore.kernel.org/bpf/000000000000ab724705ee87e321@google.com/
> >https://lore.kernel.org/bpf/000000000000269f9a05f02be9d8@google.com/
>
> I suspect something is hitting array_resize() that wasn't maximal-bucket-size allocated. Does reverting 38931d8989b5760b0bd17c9ec99e81986258e4cb make it go away?

Reverting makes it go away for at least one of them:
https://lore.kernel.org/bpf/0000000000004bee2205f0484e1d@google.com/T/#m60dba18e94e01094a899ab7fe8d19aa1a3cf26fe

The second one didn't like my patch, I'm trying again now:
https://lore.kernel.org/bpf/Y6Iipad5vz55tl2A@google.com/T/#m032bed8c3d47f33a9fccd660446beabce98ff5fe



>
> --
> Kees Cook
