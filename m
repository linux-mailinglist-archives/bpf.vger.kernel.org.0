Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107484C3CE5
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 05:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbiBYEI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 23:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBYEI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 23:08:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379161C8D98
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 20:08:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C393F61849
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 04:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28911C340F2
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 04:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645762107;
        bh=rCHiBKlc48URq/e3tOzUs+6u8xIsu3ZXqfjPNGozlJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jgqhnHF4j5rZfj5hJbXA4/CwqAOio/QcqWA94ziSIYNs+E6tEwaaOkWMv2jsmL/N/
         /M5raPQPhlSyTTIBcKHkbEs+iFiDNMWGdqssIHu7SaYel+tkju82HWCl19lkFGghou
         T+ZfFyHly9NJ6JLmGRgeEpco79wd0u2iQ2acCkxGlmJb+uBfHgjO7YSQaM4oIhDAKX
         HMu2j+RWEZRnVkUV8+qJ+M63FvrBEjppt41don4Zlguko+KhMYsx6CdHeIjGOMYajp
         j+HdQI9ysVu2QRsLROhIe91tnCSbOCQGTkYisGoIKhB/SvFm5vL+jvuVDITNQdi6MJ
         JvJBhF+H02dJQ==
Received: by mail-yb1-f182.google.com with SMTP id v186so3543687ybg.1
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 20:08:27 -0800 (PST)
X-Gm-Message-State: AOAM530ppf9MLCxP7wRp67KY2nm7spJQNZQu90e2lFE2PT7qX8BunDXB
        Nk4kgK0yD46MoYALQ8KCTTDPQ09ir7UIPAy9CUk=
X-Google-Smtp-Source: ABdhPJxGM3r6UCEL7WpHrM4KyKd31u26BsRZ4/Xo3oIR3CjNZxAwyHUYRDWryhR1bYwnZOQUwLpt9FirUsm3ar8zA7c=
X-Received: by 2002:a25:bcca:0:b0:622:34dd:d1dc with SMTP id
 l10-20020a25bcca000000b0062234ddd1dcmr5462734ybm.449.1645762106194; Thu, 24
 Feb 2022 20:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20220224214928.826717-1-fallentree@fb.com>
In-Reply-To: <20220224214928.826717-1-fallentree@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 24 Feb 2022 20:08:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4damkazKdMBjy4mRq9UsxuAMFYjTwJGazPuxe70tpdkA@mail.gmail.com>
Message-ID: <CAPhsuW4damkazKdMBjy4mRq9UsxuAMFYjTwJGazPuxe70tpdkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix issue with bpf preload module taking
 over stdout/stdin of kernel.
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, andrii@kernddddel.org,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 24, 2022 at 1:49 PM Yucong Sun <fallentree@fb.com> wrote:
>
> In a previous commit (1), BPF preload process was switched from user
> mode process to use in-kernel light skeleton instead. However, in the
> kernel context the available fd starts from 0, instead of normally 3 for
> user mode process. and the preload process leaked two FDs, taking over
> FD 0 and 1. This  which later caused issues when kernel trys to setup
> stdin/stdout/stderr for init process, assuming fd 0,1,2 is available.
>
> As seen here:
>
> Before fix:
> ls -lah /proc/1/fd/*
>
> lrwx------1 root root 64 Feb 23 17:20 /proc/1/fd/0 -> /dev/null
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/1 -> /dev/null
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/2 -> /dev/console
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/6 -> /dev/console
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/7 -> /dev/console
>
> After Fix / Normal:
>
> ls -lah /proc/1/fd/*
>
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/0 -> /dev/console
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/1 -> /dev/console
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/2 -> /dev/console
>
> In this patch:
>   - skel_closenz was changed to skel_closenez to correctly handle
>     FD=0 case.
>   - various places detecting FD > 0 was changed to FD >= 0.
>   - Call iterators_skel__detach() funciton to release FDs after links
>   are obtained.
>
> 1: https://github.com/kernel-patches/bpf/commit/cb80ddc67152e72f28ff6ea8517acdf875d7381d

We can just refer to the commit ID as

commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light skeleton.")

And I think we need a Fixes tag for it.

Fixes: commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light
skeleton.")
> Signed-off-by: Yucong Sun <fallentree@fb.com>

Other than these.

Acked-by: Song Liu <songliubraving@fb.com>
