Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE552BDBF
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiERO6a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbiERO63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 10:58:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E319FF45
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 07:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E99B0B80EA7
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE2AC3411E
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652885905;
        bh=C6D4LIf8HlYFTqAV2/sOWrBoL9eB5yi4jDHkyCghsCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PcSW5ChKBPwVjelCssY5RlQxmM8GLf42R5CrVeyOydE+3KFhWslrPx0Jw+qUz+E9m
         EWOGVXC9DdrDwwGmrl+Tbz/42HFk6Mjw23+XSNQzy546AUX785Bis/L3oX9tdHkL6L
         w0xZdHPhkaLVQzuRpREPr/tiJ4tSn9gklz/2oncZnUg9EouGIAAZZHA4EubHCShsQb
         e3MGHERAjnO8TrESbZKz7OGfk9Ck2I4srLkQheItjCVQSohR8l4HnfnHadFAAnO4GO
         v0b6WYTG4oCCwMf160I6nkkb9vcnga4b7/MCDqurGIpNLVm0uOyQIYmVSdjirUrkgl
         z/c4tyB5yYQyg==
Received: by mail-lj1-f169.google.com with SMTP id b32so2878518ljf.1
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 07:58:25 -0700 (PDT)
X-Gm-Message-State: AOAM530UH//9qn3vORWvsxXTP2IkdV2klOJ+hWyrlikO531vZ61mZxG4
        P7Uwzzo5eeNlyFtTt38ZSnepmpUL+OYDHobH7WaUvg==
X-Google-Smtp-Source: ABdhPJzCXWuLXUdyiw1JlShMEc9xIVqWElG0K5bhpjqdaG26JCpzmZrJgSfgXxXrJCSxFe/aU+/XiBnz6syUEk/3kno=
X-Received: by 2002:a2e:9105:0:b0:24f:2558:8787 with SMTP id
 m5-20020a2e9105000000b0024f25588787mr17236394ljg.65.1652885903568; Wed, 18
 May 2022 07:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <1652880861-27373-1-git-send-email-alan.maguire@oracle.com>
 <1652880861-27373-2-git-send-email-alan.maguire@oracle.com> <YoUA9k9iowy0meN3@syu-laptop>
In-Reply-To: <YoUA9k9iowy0meN3@syu-laptop>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 18 May 2022 16:58:12 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6xjTBWq5jNPc-VDMmgOL4=eMevJNUBMj7ki=BYot+=WA@mail.gmail.com>
Message-ID: <CACYkzJ6xjTBWq5jNPc-VDMmgOL4=eMevJNUBMj7ki=BYot+=WA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: refine kernel.unpriviliged_bpf_disabled
 behaviour
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        keescook@chromium.org, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 18, 2022 at 4:21 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> On Wed, May 18, 2022 at 02:34:20PM +0100, Alan Maguire wrote:
> > With unprivileged BPF disabled, all cmds associated with the BPF syscall
> > are blocked to users without CAP_BPF/CAP_SYS_ADMIN.  However there are
> > use cases where we may wish to allow interactions with BPF programs
> > without being able to load and attach them.  So for example, a process
> > with required capabilities loads/attaches a BPF program, and a process
> > with less capabilities interacts with it; retrieving perf/ring buffer
> > events, modifying map-specified config etc.  With all BPF syscall
> > commands blocked as a result of unprivileged BPF being disabled,
> > this mode of interaction becomes impossible for processes without
> > CAP_BPF.
> >
> > As Alexei notes
> >
> > "The bpf ACL model is the same as traditional file's ACL.
> > The creds and ACLs are checked at open().  Then during file's write/read
> > additional checks might be performed. BPF has such functionality already.
> > Different map_creates have capability checks while map_lookup has:
> > map_get_sys_perms(map, f) & FMODE_CAN_READ.
> > In other words it's enough to gate FD-receiving parts of bpf
> > with unprivileged_bpf_disabled sysctl.
> > The rest is handled by availability of FD and access to files in bpffs."
> >
> > So key fd creation syscall commands BPF_PROG_LOAD and BPF_MAP_CREATE
> > are blocked with unprivileged BPF disabled and no CAP_BPF.
> >
> > And as Alexei notes, map creation with unprivileged BPF disabled off
> > blocks creation of maps aside from array, hash and ringbuf maps.
> >
> > Programs responsible for loading and attaching the BPF program
> > can still control access to its pinned representation by restricting
> > permissions on the pin path, as with normal files.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Acked-by: KP Singh <kpsingh@kernel.org>
