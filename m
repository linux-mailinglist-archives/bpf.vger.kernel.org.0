Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A086662BD4
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 17:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjAIQzY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 11:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjAIQzH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 11:55:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3A140C2F
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 08:54:26 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s8so1838396plk.5
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FLE8386xU2Fsx7zwxUJ7nfC38jAgbmgp4m04jePO7k8=;
        b=GggFoOFgxDKcJlr3TKLQOKiAoFMQmHCIofXN4RL5tTW7Ztbn9N30jiI83lxno+23WV
         U8p04y4Ix43jwJL8x1k1NV1W5E3q/liCfH/xrmPj1cFubO3kGLTVCmVkrsAf2QyMVlaM
         XCkRBFA0+M12PbMalv1U9kw5JUPrpGZBB0StkUW3V+lLimclbFdoGN7BmlABUC6n0dMu
         /PO/Q1Kmv+yewOh0uKQ76VUaXQDNh6eGqoa3x+z7z9vHAEhPT/XtMkc2QYMt2QUT1UXN
         wi2+kr1zco0HSphgC8V1xdcj5dXH/yAvum9ZyP0uSwm+N5ZRZukr6bm94HiOa7wYeGNE
         oOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLE8386xU2Fsx7zwxUJ7nfC38jAgbmgp4m04jePO7k8=;
        b=qH8l9xWvxC5n2bnt8OUi2ezWBzEY4UrWw4GJd66SttU1zQ2G8EKJHBOH/p3cB1ZuJD
         cnB7D7Dr7ux0f08YyzXKH3S535BN4O2W6mH0pAW9ily0yEWBPjBgpF56L5QSlX2iRuiU
         /lmZ21UJAqjAW6mWoVsbpetAJfNPCMSHZgk2NnV6LT2ug8AuS0cckUQ9aEkfwFuZxd7/
         TSG61nuxbL67c055fRKwiUdEwH4vu2aUY88VpSxTNcfgmC57+1jhGel4+lRQFRXqq1B5
         7TMJamdSuvlIhj/kD9dOouR0o7odzlV8c5LZorZ7GKBCr5+nOWdE1qwuiFv+ZRy/gLcm
         S3lg==
X-Gm-Message-State: AFqh2kqqRIZzB1M4Wap9+gztoa9KkxwE5G3n5RVQfnDvQt+ZF1drNwiI
        7u3V3x8lN4jia6I+ned7GR0chHMFMDDh8AGsukLp
X-Google-Smtp-Source: AMrXdXtLiErnEuSCdbBsHNzFb5ezmM1LJNUPukYbCt9jGL2/BlARypfdrzQgxNL+C2kb8cKjxRIJZx2JwNkBcw6VIGs=
X-Received: by 2002:a17:902:cec8:b0:192:6675:8636 with SMTP id
 d8-20020a170902cec800b0019266758636mr3585415plg.15.1673283266261; Mon, 09 Jan
 2023 08:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20230106154400.74211-1-paul@paul-moore.com> <CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com>
In-Reply-To: <CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Jan 2023 11:54:22 -0500
Message-ID: <CAHC9VhTzBP49x3EH6yeqYxnr4jgcS6RdcvtbX_BSuRJnCH6ypQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: restore the ebpf program ID for
 BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
To:     Stanislav Fomichev <sdf@google.com>
Cc:     linux-audit@redhat.com, bpf@vger.kernel.org,
        Burn Alting <burn.alting@iinet.net.au>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 6, 2023 at 2:45 PM Stanislav Fomichev <sdf@google.com> wrote:
> On Fri, Jan 6, 2023 at 7:44 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > When changing the ebpf program put() routines to support being called
> > from within IRQ context the program ID was reset to zero prior to
> > calling the perf event and audit UNLOAD record generators, which
> > resulted in problems as the ebpf program ID was bogus (always zero).
> > This patch addresses this problem by removing an unnecessary call to
> > bpf_prog_free_id() in __bpf_prog_offload_destroy() and adjusting
> > __bpf_prog_put() to only call bpf_prog_free_id() after audit and perf
> > have finished their bpf program unload tasks in
> > bpf_prog_put_deferred().  For the record, no one can determine, or
> > remember, why it was necessary to free the program ID, and remove it
> > from the IDR, prior to executing bpf_prog_put_deferred();
> > regardless, both Stanislav and Alexei agree that the approach in this
> > patch should be safe.
> >
> > It is worth noting that when moving the bpf_prog_free_id() call, the
> > do_idr_lock parameter was forced to true as the ebpf devs determined
> > this was the correct as the do_idr_lock should always be true.  The
> > do_idr_lock parameter will be removed in a follow-up patch, but it
> > was kept here to keep the patch small in an effort to ease any stable
> > backports.
> >
> > I also modified the bpf_audit_prog() logic used to associate the
> > AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
> > Instead of keying off the operation, it now keys off the execution
> > context, e.g. '!in_irg && !irqs_disabled()', which is much more
> > appropriate and should help better connect the UNLOAD operations with
> > the associated audit state (other audit records).
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
> > Reported-by: Burn Alting <burn.alting@iinet.net.au>
> > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> Thank you! There might be a chance it breaks test_offload.py (I don't
> remember whether it checks this prog-is-removed-from-id part or not),
> but I don't think it's fair to ask to address it :-)
> Since it doesn't trigger in CI, I'll take another look next week when
> doing a respin of my 'xdp-hints' series.

No problem, I'm glad we found a solution that works for everyone; and
thank you for chasing down any test changes that may be necessary.

I'd like to get this patch into Linus' tree sooner rather than later
as it fixes a kinda ugly problem, would you be okay if this went in
via the bpf tree?  With the appropriate ACKs I could send it to Linus
via the audit tree, but I think it would be much better to send it via
the bpf/netdev tree.

-- 
paul-moore.com
