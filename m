Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE767EE1A
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 20:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjA0TWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 14:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjA0TWV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 14:22:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9A2687D;
        Fri, 27 Jan 2023 11:22:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F941B821D2;
        Fri, 27 Jan 2023 19:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59EAC4339B;
        Fri, 27 Jan 2023 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674847337;
        bh=yNIfrEdohpdh5fCRk3yNBC8sZ5ibSoBtGTcyVnCDfS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VgnxxtA/4J914EEFdi8Mvdo9C14DYENYXeHnbmHAY4sKx879nydxMr5OfEEXt+t4Q
         /T4WLZTjJXzYyrPpIbFi0gsqo/VPrmkqn5lvnmExjEELh4j76jFe6bPjYKK9e0xBck
         lKAOd3pMNnlApcRmQNKmbvdqMielDkKEsw6XI6pDWmBff52c6sgf5lsuoMVgv87KkL
         J8YbLseFd0ntg6Ge8fDhVoDkMnbQwsFQgIc19xZxloHHo72YV4AiPttWeE/vp2wRF+
         /Kc3tscEZ8aqWoTNHGF+inbKRdfrxVlB65B0mJxByMA9+G5Ay3RJBQus5ypgstcEj/
         wMYQoH6BdiqtA==
Received: by mail-lf1-f51.google.com with SMTP id j17so9728768lfr.3;
        Fri, 27 Jan 2023 11:22:17 -0800 (PST)
X-Gm-Message-State: AFqh2kpqIqU1h2pB7Yv71wIzK4EmU+eFJIAm7eWpz/7J0HHVdDaYNPLZ
        DYrwe0dcldgSkSNdJgk0Mw1fNS+kiyiJnFVqWZ8=
X-Google-Smtp-Source: AMrXdXvWdYPofc9LxfNkk+EGQNGgMD+umwhwaK92+e3ejrGJ4tmPk9KEe2Q8GUWGNOVMfoDVwUcwAP6ZEzPKW9ag3yc=
X-Received: by 2002:a05:6512:3b8b:b0:4b5:b767:dda6 with SMTP id
 g11-20020a0565123b8b00b004b5b767dda6mr3962603lfv.398.1674847335772; Fri, 27
 Jan 2023 11:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org>
In-Reply-To: <20230119231033.1307221-1-kpsingh@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 27 Jan 2023 11:22:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4cOELtM=AmskmtwcKm-x=ELRVQ5tGpmaD0b0jwfjoH6g@mail.gmail.com>
Message-ID: <CAPhsuW4cOELtM=AmskmtwcKm-x=ELRVQ5tGpmaD0b0jwfjoH6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        revest@chromium.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi KP,

Thanks for working on this!

On Thu, Jan 19, 2023 at 3:10 PM KP Singh <kpsingh@kernel.org> wrote:
>
[...]
>
> # Performance improvement
>
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3%. Here are the results of the relevant Unixbench
> system benchmarks with BPF LSM and a major LSM (in this case apparmor) enabled
> with and without the series.
>
> Benchmark                                               Delta(%): (+ is better)
> ===============================================================================
> Execl Throughput                                             +2.9015
> File Write 1024 bufsize 2000 maxblocks                       +5.4196
> Pipe Throughput                                              +7.7434
> Pipe-based Context Switching                                 +3.5118
> Process Creation                                             +0.3552
> Shell Scripts (1 concurrent)                                 +1.7106
> System Call Overhead                                         +3.0067
> System Benchmarks Index Score (Partial Only):                +3.1809
>
> In the best case, some syscalls like eventfd_create benefitted to about ~10%.

The results look very promising. These optimizations will make it easier
for our users (at Meta) to adopt LSM solutions.

Thanks again!
Song
