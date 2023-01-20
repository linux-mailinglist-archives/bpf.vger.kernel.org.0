Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995A0674944
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 03:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjATCSJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 21:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjATCSI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 21:18:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C719F3A2
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 18:18:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FD3061DE0
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 02:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0826C433F2
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 02:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674181084;
        bh=2PrCTaCjkG8rOBsJOOm3wGXslPkcR1xqq6T6pH+p4mU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PqxjX0ggvA7R9rfBXXusaZDIcceEg1DYdnJ7xLgRe/3SLqTnE18HUasJJZxxULfaC
         rflk6KgwF8cj+CgvU8NdAWl5TNfwzj2KCT88kK2GpAScmrWS5C25mh3YvI2JbiDRAS
         hjNMx9lep3P4LtDu7KY+mfTyodiBH1ZW+HlP8bUuJMXa1lusVLZADqnfh4cqz4GIfI
         k7VsAloadx7NAsGaJL/49CEB9m29DyrKXmDBDSYfACZHMgWCz3a4lxFgBcGRrd/X/G
         IUkhX0wE1ClMJXYVK7RmCxMCOzs/yYZTt/5yJglHmi0Xb9ws7qa5bzGvqT0Ch4GqOz
         PxwNejohSddOw==
Received: by mail-ej1-f43.google.com with SMTP id rl14so7221936ejb.2
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 18:18:04 -0800 (PST)
X-Gm-Message-State: AFqh2kqgAPMHxS9gN00BAEwp1Y0AKYTJFJ1hDGcsBNeB7ESai9YlpyxU
        W0v5TNVl1HXmUgNsdLTlOUNa+aXHCAJdg1Lb2xzxzw==
X-Google-Smtp-Source: AMrXdXsKS69bduFdqEDXQPj4B6yMaPqYxzlAnuiOv6G42gYiDX+uCuVbm4APDAoGQ2o6hqLDoDqlGRXzop783N+YeSw=
X-Received: by 2002:a17:906:78d:b0:855:d6ed:60d8 with SMTP id
 l13-20020a170906078d00b00855d6ed60d8mr872102ejc.302.1674181083112; Thu, 19
 Jan 2023 18:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org> <1e14f68c-90ba-f406-f08c-6d62bbfef6a0@schaufler-ca.com>
In-Reply-To: <1e14f68c-90ba-f406-f08c-6d62bbfef6a0@schaufler-ca.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 20 Jan 2023 03:17:52 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6DEegggQBRJwe0Z2gChfxficOVmoe2K5mjAx7Zq0aApw@mail.gmail.com>
Message-ID: <CACYkzJ6DEegggQBRJwe0Z2gChfxficOVmoe2K5mjAx7Zq0aApw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
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

On Fri, Jan 20, 2023 at 2:13 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/19/2023 3:10 PM, KP Singh wrote:
> > # Background
> >
> > LSM hooks (callbacks) are currently invoked as indirect function calls. These
> > callbacks are registered into a linked list at boot time as the order of the
> > LSMs can be configured on the kernel command line with the "lsm=" command line
> > parameter.
> >
> > Indirect function calls have a high overhead due to retpoline mitigation for
> > various speculative execution attacks.
> >
> > Retpolines remain relevant even with newer generation CPUs as recently
> > discovered speculative attacks, like Spectre BHB need Retpolines to mitigate
> > against branch history injection and still need to be used in combination with
> > newer mitigation features like eIBRS.
> >
> > This overhead is especially significant for the "bpf" LSM which allows the user
> > to implement LSM functionality with eBPF program. In order to facilitate this
> > the "bpf" LSM provides a default callback for all LSM hooks. When enabled,
> > the "bpf" LSM incurs an unnecessary / avoidable indirect call. This is
> > especially bad in OS hot paths (e.g. in the networking stack).
> > This overhead prevents the adoption of bpf LSM on performance critical
> > systems, and also, in general, slows down all LSMs.
> >
> > Since we know the address of the enabled LSM callbacks at compile time and only
> > the order is determined at boot time,
>
> No quite true. A system with Smack and AppArmor compiled in will only
> be allowed to use one or the other.
>
> >  the LSM framework can allocate static
> > calls for each of the possible LSM callbacks and these calls can be updated once
> > the order is determined at boot.
>
> True if you also provide for the single "major" LSM restriction.
>
> > This series is a respin of the RFC proposed by Paul Renauld (renauld@google.com)
> > and Brendan Jackman (jackmanb@google.com) [1]
> >
> > # Performance improvement
> >
> > With this patch-set some syscalls with lots of LSM hooks in their path
> > benefitted at an average of ~3%. Here are the results of the relevant Unixbench
> > system benchmarks with BPF LSM and a major LSM (in this case apparmor) enabled
> > with and without the series.
> >
> > Benchmark                                               Delta(%): (+ is better)
> > ===============================================================================
> > Execl Throughput                                             +2.9015
> > File Write 1024 bufsize 2000 maxblocks                       +5.4196
> > Pipe Throughput                                              +7.7434
> > Pipe-based Context Switching                                 +3.5118
> > Process Creation                                             +0.3552
> > Shell Scripts (1 concurrent)                                 +1.7106
> > System Call Overhead                                         +3.0067
> > System Benchmarks Index Score (Partial Only):                +3.1809
>
> How about socket creation and packet delivery impact? You'll need to
> use either SELinux or Smack to get those numbers.

I think the goal here is to show that hot paths are beneficial, and
the results are pretty clear from this. I have an even more detailed
analysis in https://kpsingh.ch/lsm-perf as to what happens when the
static calls are enabled v/s not enabled. I don't have the socket
numbers, but I expect this to be very similar to pipes. Is there a
particular Unixbench test you want me to run?

>
> > In the best case, some syscalls like eventfd_create benefitted to about ~10%.
> > The full analysis can be viewed at https://kpsingh.ch/lsm-perf
> >
> > [1] https://lore.kernel.org/linux-security-module/20200820164753.3256899-1-jackmanb@chromium.org/
> >
> > KP Singh (4):
> >   kernel: Add helper macros for loop unrolling
> >   security: Generate a header with the count of enabled LSMs
> >   security: Replace indirect LSM hook calls with static calls
> >   bpf: Only enable BPF LSM hooks when an LSM program is attached
> >
> >  include/linux/bpf.h              |   1 +
> >  include/linux/bpf_lsm.h          |   1 +
> >  include/linux/lsm_hooks.h        |  94 +++++++++++--
> >  include/linux/unroll.h           |  35 +++++
> >  kernel/bpf/trampoline.c          |  29 ++++-
> >  scripts/Makefile                 |   1 +
> >  scripts/security/.gitignore      |   1 +
> >  scripts/security/Makefile        |   4 +
> >  scripts/security/gen_lsm_count.c |  57 ++++++++
> >  security/Makefile                |  11 ++
> >  security/bpf/hooks.c             |  26 +++-
> >  security/security.c              | 217 ++++++++++++++++++++-----------
> >  12 files changed, 386 insertions(+), 91 deletions(-)
> >  create mode 100644 include/linux/unroll.h
> >  create mode 100644 scripts/security/.gitignore
> >  create mode 100644 scripts/security/Makefile
> >  create mode 100644 scripts/security/gen_lsm_count.c
> >
