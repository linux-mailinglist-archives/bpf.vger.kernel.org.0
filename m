Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01BD4883EC
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 15:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiAHOKH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Jan 2022 09:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiAHOKH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Jan 2022 09:10:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BCC061574
        for <bpf@vger.kernel.org>; Sat,  8 Jan 2022 06:10:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso6994811wmc.3
        for <bpf@vger.kernel.org>; Sat, 08 Jan 2022 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Wvr9B5Og2idB5f4e8kL+4mc9ZlXpKCsICKibs4hTE6U=;
        b=HNPCe7KrRLoYAhuKcXaBwu3uQVsuefqIavkpBVgi20r855XuhUIUKodE5uplvoIgNn
         bdo0c0Kz7FUkdZ59y8SbcSGG7YMN3crNHrLEkMJsmCCdGJoqYinG2WgRIZ/IeaNaaGZg
         xBqfCv/aLCTn5N7bb2vGTtyg8H0NgmT7xHpds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Wvr9B5Og2idB5f4e8kL+4mc9ZlXpKCsICKibs4hTE6U=;
        b=jpbgHLJkp5H+luz6pBJ2JYGKwf1Tf6U0+bHCq0g99d4wN4WXANYPyQ748gE+5lMZLl
         EgbPwfR9/fEpQxv1PsTgldqLl3KMY/vHLeW8f3BsYvH7fuYAJerIq5rnqlhPoMT6lkXu
         fga0jaZTTXpJtryf0thyNvQn58tSl7Yc+2DZeozsHl7yYUBfRyqGEChWyQe1b01FiVgD
         opn8z2A3dsnqCr39+u0xsXFc/SK8ckF9VLGrkM0sNNe3bD6lB+l7rKcgbjl1dnxbMm7w
         Pk48Urx7Ac31mbDYllW6EzB26SmbWFKNbUFcgqvM+r0BVka7EQSpPQM9ZDuo3oyXs/pI
         e3Yg==
X-Gm-Message-State: AOAM533Aff6XXAgql1KVWSC0hnBq/juIJwGytnLXkfXyljAAcQ/X0Qm9
        NMR5IPayM3VuiOLVuJOnLGuAJw==
X-Google-Smtp-Source: ABdhPJxVHH4OnlGxc7mRvX1WqD4jFqxAfvGCz4ewLcCwoU3VfZlQPCOWpUu1qp1IfNnkqU8vjlNPgg==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr14754929wmq.166.1641651005070;
        Sat, 08 Jan 2022 06:10:05 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id o1sm1701644wmc.38.2022.01.08.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 06:10:04 -0800 (PST)
References: <20220104214645.290900-1-john.fastabend@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, joamaki@gmail.com
Subject: Re: [PATCH bpf-next] bpf, sockmap: fix double bpf_prog_put on error
 case in map_link
In-reply-to: <20220104214645.290900-1-john.fastabend@gmail.com>
Date:   Sat, 08 Jan 2022 15:10:03 +0100
Message-ID: <874k6epbd0.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 04, 2022 at 10:46 PM CET, John Fastabend wrote:
> sock_map_link() is called to update a sockmap entry with a sk. But, if the
> sock_map_init_proto() call fails then we return an error to the map_update
> op against the sockmap. In the error path though we need to cleanup psock
> and dec the refcnt on any programs associated with the map, because we
> refcnt them early in the update process to ensure they are pinned for the
> psock. (This avoids a race where user deletes programs while also updating
> the map with new socks.)
>
> In current code we do the prog refcnt dec explicitely by calling
> bpf_prog_put() when the program was found in the map. But, after commit
> '38207a5e81230' in this error path we've already done the prog to psock
> assignment so the programs have a reference from the psock as well. This
> then causes the psock tear down logic, invoked by sk_psock_put() in the
> error path, to similarly call bpf_prog_put on the programs there.
>
> To be explicit this logic does the prog->psock assignemnt
>
>   if (msg_*)
>     psock_set_prog(...)
>
> Then the error path under the out_progs label does a similar check and dec
> with,
>
>   if (msg_*)
>      bpf_prog_put(...)
>
> And the teardown logic sk_psock_put() does,
>
>   psock_set_prog(msg_*, NULL)
>
> triggering another bpf_prog_put(...). Then KASAN gives us this splat, found
> by syzbot because we've created an inbalance between bpf_prog_inc and
> bpf_prog_put calling put twice on the program.
>
> BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_put kernel/bpf/syscall.c:1812 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_put kernel/bpf/syscall.c:1812 [inline] kernel/bpf/syscall.c:1829
> BUG: KASAN: vmalloc-out-of-bounds in bpf_prog_put+0x8c/0x4f0 kernel/bpf/syscall.c:1829 kernel/bpf/syscall.c:1829
> Read of size 8 at addr ffffc90000e76038 by task syz-executor020/3641
>
> To fix clean up error path so it doesn't try to do the bpf_prog_put in the
> error path once progs are assigned then it relies on the normal psock
> tear down logic to do complete cleanup.
>
> For completness we also cover the case whereh sk_psock_init_strp() fails,
> but this is not expected because it indicates an incorrect socket type
> and should be caught earlier.
>
> Reported-by: syzbot+bb73e71cf4b8fd376a4f@syzkaller.appspotmail.com
> Fixes: 38207a5e8123 ("bpf, sockmap: Attach map progs to psock early for feature probes")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

FWIW, late :thumbup:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
