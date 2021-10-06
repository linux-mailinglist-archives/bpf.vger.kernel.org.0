Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF5424483
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 19:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbhJFRlR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 13:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbhJFRlL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 13:41:11 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B7C0613EC
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 10:39:18 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id w10so7250838ybt.4
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fswf9wGYmE93Fp/vGD6E8ezYOXc2b7MTPTxH5yHFr8=;
        b=bsG9HzzJNrlLGU1BzrNJtO7an+Uclxke13RpK4SCzP98Ag0pQL6tJGdFlZFgFRy0Hu
         D6yiFVoNudTxyBuDaZOL5KWLfVza9AZjIQEhTbiTJTPUCjuVE1LjWpKXifG7VkB8GmRx
         MLB6wt7Zu69lUQ84G5kjiuTvB6wIJG8i0SkPJX7eFamTZ82pYjbsn4uPcxt1ckWNiCub
         TACAbyqdZUIKqvrrsKFlU+mBjFXDVhGFevL5oDQ28GuhpFoEj3oI8XeNK7ps9jx5vp4i
         KszuObaTuNG8tMAvb0+jV9jCmD2HhpsdefPpuphCmDZjtFptpkjSm2Jfoifm2XpVxwU5
         ZwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fswf9wGYmE93Fp/vGD6E8ezYOXc2b7MTPTxH5yHFr8=;
        b=D9yjwq8y/PROB9swpHbuWemYS3T2POFp4k3b0xydsLN1BMM+fJqdLKVFt6eJ3B8mS4
         rc87jZDcThXPTQH0ztIBzTaU0wNWMlrtcjF6h4rlnDkqtCCkEz1DhavBgk6WLg3k/Mmk
         lsbSbqfcRo7jXQsIq1N/CY3qBeowpY3QH/JTkLAyjl5+HybgXBT2jzMIDj2Zp5z+rT1T
         9FnYvkcm5LBT/mjaBwHO0zTxIqDmbrU/OXI5bedR+nZnUOrJey2NJDdCZtQb/cQCpZJZ
         e5Gj9bcv9IbiChghfVbkN4Q5WEk05V/pComTwKllJQjVEhc0VhmWQhFRIai1ux7qqNfy
         +aIA==
X-Gm-Message-State: AOAM530VWHXVlNVP1L4kPnd+ZtjYIdIsWj9f28axzO6XVitsUs6PgRp1
        v0VRj3eFSnmaVxPE5y84zlAYadYiQ4xypdSNKok=
X-Google-Smtp-Source: ABdhPJx9GmyMyVIQguDxd9eNVP9/eWdRPG1GcyFKImgqrpoTig63GiVx5OS2+hvzMFxNZnxYENiMSGIqPnqBYdIMJmc=
X-Received: by 2002:a25:1884:: with SMTP id 126mr30354228yby.114.1633541957412;
 Wed, 06 Oct 2021 10:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211002161000.3854559-1-hengqi.chen@gmail.com> <CAPhsuW7GxToBCDVzD+H-83NAJw-a-EraNVD=+xcFfGqKduejUw@mail.gmail.com>
In-Reply-To: <CAPhsuW7GxToBCDVzD+H-83NAJw-a-EraNVD=+xcFfGqKduejUw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Oct 2021 10:39:06 -0700
Message-ID: <CAEf4BzZ_JB1VLAF0=7gu=2M0M735aXava=nPL8m8ewQWdS3m8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Deprecate bpf_object__unload() API
 since v0.7
To:     Song Liu <song@kernel.org>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 4, 2021 at 6:06 PM Song Liu <song@kernel.org> wrote:
>
> On Sat, Oct 2, 2021 at 9:31 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >
> > BPF objects are not re-loadable after unload. User are expected to use
> > bpf_object__close() to unload and free up resources in one operation.
> > No need to expose bpf_object__unload() as a public API, deprecate it.[0]
> > Add bpf_object_unload() as an alias to bpf_object__unload() and replace
> > all bpf_object__unload() to avoid compilation errors.
> >
> >   [0] Closes: https://github.com/libbpf/libbpf/issues/290
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>

Applied to bpf-next, thanks. I've done few changes, though:

1. started deprecation from the current development version (0.6),
there is no point in delaying this as the recommended replacement API
(bpf_object__close()) has been available forever.
2. it didn't make sense to me to have bpf_object_unload as an alias to
bpf_object__unload, I switched it around, bpf_object__unload is an
alias of internal bpf_object_unload. It will also make further
deletion of bpf_object__unload() simpler in the future.

Please let me know if you have any reservations about this.
