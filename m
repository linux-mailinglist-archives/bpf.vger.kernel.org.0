Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6610643B3C
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 03:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiLFCRH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 21:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiLFCRF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 21:17:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD4A1D0FD;
        Mon,  5 Dec 2022 18:17:05 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x66so13238988pfx.3;
        Mon, 05 Dec 2022 18:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcP8NKIZlYUePwBhMMJRQewkzTKwifvCi6pycP1f6GM=;
        b=M4ZhPc6YO6HttK4ywN3HPaaww0bQbW6IqEAKMTrjp/IMfsfO8+xnm2+YJop6UyTrEK
         7VVccYUVV506+O298iOMvIR930wlw/moGT8lQVHtwmLaUJROtCslAwhPkofA99kTq2m4
         3megxLBRZGC8slz4vdO/Ka4wgaIgD5DLiKQpFvd9ORxhsd/AXaSYJolf6lrLQg4D1Nmh
         Tx6vmvvFQh2Q43WyaXTabKB0HMCxp5GNmnVcX5M0wDlegxWpB/3IWSKTMv+2xtlTaSLz
         QbWszRnOyJC4lju4I/te/UBIIXfsbDqIpJgzUE01sX1HrlO3OKAslvxpKiOR2+DgOzy6
         eHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcP8NKIZlYUePwBhMMJRQewkzTKwifvCi6pycP1f6GM=;
        b=mk1Lrvuk6tx4+hp4PosMhOqQ/ar/pBJaMGarLsUWa6brSzn9l0BTSQi7XXj1AAmrtg
         sJvifAmeWGJGSMXqDJ+ImLJb1/v70A8EGTtANYR1fqqJ/Jot2k18NVGAMI8XFHFjy0sk
         xL2c5UOpD/Vmfn83WIKLflcJFEE5EHprlNpZwiA1+HNHf5BcKJAqhmIfVxGi8sNsHPX6
         lr1I643/ZtxNxnCntnkfAuBh+pwgdte64fNlJHd4MsV6GyPSP7mxrW+Yu+9QGUcZ4zpi
         zqgTx9whQqW1ZutbTJbrapTTfcEasgyX2EpGoABS+pveWmFlw2iUvoV21WMj9Rlem7KS
         OMfA==
X-Gm-Message-State: ANoB5pnIQabuFw1sRX7oF/V1HVSeP9trjRkceNohTzCiy6vYe72hS4XK
        yO+Y4OyypdsmHbz+XPQXB64=
X-Google-Smtp-Source: AA0mqf4CQ3OBT41PKIEho/5N2NtvXuHvpJK+I3Pn6WJT0jq2MJyqN50dy29mBI8Gr+upaZ1fQvXD5g==
X-Received: by 2002:a05:6a00:21c8:b0:562:e0fb:3c79 with SMTP id t8-20020a056a0021c800b00562e0fb3c79mr67299904pfj.39.1670293024432;
        Mon, 05 Dec 2022 18:17:04 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id v129-20020a622f87000000b005761c4754e7sm8901215pfv.144.2022.12.05.18.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:17:03 -0800 (PST)
Date:   Mon, 5 Dec 2022 18:17:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
Message-ID: <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
 <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
 <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 05, 2022 at 07:59:21AM +0900, Masami Hiramatsu wrote:
> On Sun, 4 Dec 2022 14:30:01 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Mon, Dec 05, 2022 at 07:22:44AM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Since the function error injection framework in the fault injection
> > > subsystem can change the function code flow forcibly, it may cause
> > > unexpected behavior (and that is the purpose of this feature) even
> > > if it is applied to the ALLOW_ERROR_INJECTION functions.
> > > So this feature must be used only for debugging or testing purpose.
> > 
> > The whole idea of tainting for kernel debugging is questionable.
> > There are many other *inject* kconfigs and other debug flags
> > for link lists, RCU, sleeping, etc.
> > None of them taint the kernel.
> > 
> > > To identify this in the kernel oops message, add a new taint flag
> > 
> > Have you ever seen a single oops message because of this particular
> > error injection?
> 
> No, but there is no guarantee that the FEI doesn't cause any issue
> in the future too. If it happens, we need to know the precise
> information about what FEI/bpf does.
> FEI is a kind of temporal Livepatch for testing. If Livepatch taints
> the kernel, why doesn't the FEI taint it too?

Live patching can replace an arbitrary function and the kernel has
no visibility into what KLP module is doing.
While 'bpf error injection' is predictable.
The functions marked with [BPF_]ALLOW_ERROR_INJECTION can return errors
in the normal execution. So the callers of these functions have to deal with errors.

If kernel panics on such injected error it potentially would have paniced
on it anyway. At this point crash dump might be necessary to debug.
Whether oops happened because of bpf, kprobe or normal execution
doesn't matter much. The bug is in the caller that wasn't prepared
to deal with that error.

One can still walk all bpf progs from crash dump with tool "drgn"
(it has nice scripts to examine the dumps) or "crash" or other tools.

> > 
> > > for the fault injection. This taint flag will be set by either
> > > function error injection is used or the BPF use the kprobe_override
> > > on error injectable functions (identified by ALLOW_ERROR_INJECTION).
> > 
> > ...
> > 
> > >  	/* set the new array to event->tp_event and set event->prog */
> > > +	if (prog->kprobe_override)
> > > +		add_taint(TAINT_FAULT_INJECTED, LOCKDEP_NOW_UNRELIABLE);
> > 
> > Nack for bpf bits.
> 
> I think this is needed especially for bpf bits. If we see this flag,
> we can ask reporters to share the bpf programs which they used.

You can ask reporters to share bpf progs, but you can repro
the oops just as well without bpf. It's not bpf to blame, but the
bug in the caller that you should worry about.
