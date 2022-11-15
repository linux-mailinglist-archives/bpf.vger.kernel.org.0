Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A08629FCE
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKORBW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 12:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKORBU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 12:01:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3189326571;
        Tue, 15 Nov 2022 09:01:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id h186-20020a1c21c3000000b003cfe48519a6so573234wmh.0;
        Tue, 15 Nov 2022 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VRNh05oNOBSO3e3N+oS8ulifbW6+Wo/eunoiGxes4G8=;
        b=g1NyMIiDpe6R9MGBxnLQr3ww8IkrMfGj+/F+Ujq9sFGVdDhevPGMcvV+g+KiH/LJEr
         0siG0y0WOZd23PsQHaYswqIZ6C1Gz/y777cidMA9nzbgf8S25nCP2rXcyKpmF+02T+vb
         T3HEcJ4nhxBZZtmpU2q1sAFsPvhOpyxtotGiZEjvXOupv2Hx3zsqLaL9gJlSdNpObWxw
         +dIfy2WBgM8KKaXZiq/lJHPGQAsrpvvlIMF1mx9t7T1FbGClj8phSukYi5TRvo2Pgacs
         0UHwvJ7jwFTJ25X150i0XD6OfoWURgx8po8DoHcRFCzxtkEST0W7AMkv20bBu5eXcJt6
         /2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRNh05oNOBSO3e3N+oS8ulifbW6+Wo/eunoiGxes4G8=;
        b=uFnofKf5PdLm6+wrU4amvLynrVw3u1dr5xEg59O/+hFxY55OtLUzw04fRbNKQma7oT
         lL//E2MfzC/0i0o5GOOU/x3JIICH9QjGKe6f6QpiTeX9AoXiJe4vRn87WTYrVqSE6Lxm
         +MGkOD+DDA0sBvtUid1fsFIh/YuaLtCbiInFSJ2Mt+xTIaeupjTjkb666xLnkDciSL8M
         9d1u4SNxspL/6+2VcKEnndz6KMfh0yRkx6mUAnnMqvZJxyLwS2SQo3O+oo6ERSYciwla
         OeXRTNmMbjh5LL8ZZByfPGALdOxZ5LotZFF40sfudhKVbu4xv01+aI2fZ1CCBQN9Dj+1
         3Wxw==
X-Gm-Message-State: ANoB5pmR87kSPEQTOJWzqX9i/zfBxOSDzHsaCtC+LyUrWmLIF6FUTa58
        JxWEu+GC7DzBi1gG3RXPhfDvlAzl+wj/Tw==
X-Google-Smtp-Source: AA0mqf5+1RjbicfG5Y9WBiX6EQHrLKSXKRhJUNaLjr8chFjBqW3aB89mwjpEY9/q7lKC4GC8GWe00w==
X-Received: by 2002:a1c:2581:0:b0:3cf:6a83:c7a3 with SMTP id l123-20020a1c2581000000b003cf6a83c7a3mr2110946wml.21.1668531677496;
        Tue, 15 Nov 2022 09:01:17 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id cy6-20020a056000400600b002416ecb8c33sm12682146wrb.105.2022.11.15.09.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:01:17 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 15 Nov 2022 18:01:15 +0100
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: WARNING in bpf_bprintf_prepare
Message-ID: <Y3PF22jvCUSJA7uK@krava>
References: <Y2j6ivTwFmA0FtvY@krava>
 <CAADnVQKXcdVa-gDj2_QTrBuVea+KMuFUdabR--HCf7x6Vo6uXg@mail.gmail.com>
 <Y2uv/GjnSdr/ujOj@krava>
 <CAADnVQJp0ZrodRu8ZtvvtXk6KAbjxmwqD-nXgFAxNpNxN6JM=g@mail.gmail.com>
 <Y2w9bNhVlAs/PcNV@krava>
 <Y25gFdliV7XqdUnN@krava>
 <CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com>
 <Y3H2qayW0hKlzBkK@krava>
 <Y3LFgI6mmC0SKiFw@krava>
 <CACkBjsZpz9WqHgPY3oMj4BKuDPwU_QNkkCh2OeHL+nersyrQQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsZpz9WqHgPY3oMj4BKuDPwU_QNkkCh2OeHL+nersyrQQw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 09:48:27AM +0800, Hao Sun wrote:

SNIP

> > > > Hi Jirka,
> > > >
> > > > I've tested the proposed patch, the warning from bpf_bprintf_prepare will not
> > > > be triggered with the patch, but the reproducer can still trigger the following
> > > > warning. My test was conducted on:
> > > >
> > > > commit:  f67dd6ce0723 Merge tag 'slab-for-6.1-rc4-fixes'
> > > > git tree:   upstream
> > > > kernel config: https://pastebin.com/raw/sE5QK5HL
> > > > C reproducer: https://pastebin.com/raw/X96ASi27
> > > > console log *before* the patch: https://pastebin.com/raw/eSCUNFrd
> > > > console log *after* the patch: https://pastebin.com/raw/tzcmdWZt
> > >
> > > thanks for testing.. I can't reproduce this for some reason
> > >
> > > I'll check some more and perhaps go with denying bpf attachment
> > > for this tracepoint as Alexei suggeste
> >
> > the change below won't allow to attach bpf program with any printk
> > helper in contention_begin and bpf_trace_printk tracepoints
> >
> > I still need to test it on the machine that reproduced the issue
> > for me.. meanwhile any feedback is appreciated
> >
> 
> Hi,
> 
> Tested on my machine, the C reproducer won't trigger any issue
> this time with the patch. The test was conducted on:
> 
> commit:  f67dd6ce0723 Merge tag 'slab-for-6.1-rc4-fixes'
> git tree:   upstream
> kernel config: https://pastebin.com/raw/sE5QK5HL
> C reproducer: https://pastebin.com/raw/X96ASi27
> full console log *before* the patch: https://pastebin.com/raw/n3x55RDr
> full console log *after* the patch: https://pastebin.com/raw/7HdxnCnL

thanks, looks good on my end as well

jirka
