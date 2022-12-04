Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0782D642011
	for <lists+bpf@lfdr.de>; Sun,  4 Dec 2022 23:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiLDWaJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 17:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLDWaI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 17:30:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EA712757;
        Sun,  4 Dec 2022 14:30:07 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x66so9693526pfx.3;
        Sun, 04 Dec 2022 14:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=saTL4PSjoLp5paD/RUHJjNdKfpC7pjEu98GPWDc6434=;
        b=QX/qX8CRxJITMXFpPEo58Ux5K/dIv37kBaO9HJY8WtuNI/PGoSdAShBXf7pAaCsTnP
         k1wuYgcp2RBNrpuqa7G8KpDx6d9VvEqNSK33wQbHBdYwd1hJp+dXDtpnV/jlAu95iLum
         qPXruxDYLZ6XtRqbMWsRQPB0MpBeg1fFBk9lAirSwXXXU7S6WWjOIF1twLdOgxhih3IG
         HLBQzjcogHslF8YNLXh7wIEmgwJKgCTU1f/77OV4RRtUtVomncrHYs7RyqQwOM28xQNS
         x/wl22/edvlr92P0U/Ac+9L++nX2aWmfnvXWoCc6lj0yvI4RQSL0CDU7U43fCBUmLV0l
         EP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saTL4PSjoLp5paD/RUHJjNdKfpC7pjEu98GPWDc6434=;
        b=oaSySN1uVL2UqaQDxK10fejlCke9Nfujj8roaaFgr2cZ+9KEmtThiINkpH+auT7/UL
         KYFiLwch4+a6BdCOSRRJWi488/Rzq+JZ/eSXD9NCGPbu90iI46xfpDvX3htsDU2TKMUQ
         +fN1k8Hhy3LRt0NnjSoUhVEVAlf45omZTpOgrlFbC1UyaBcKOdsJ1xzbM7VA3IpXS2iI
         U3UfWHANTy5xFKBKpdim5sG1nG4B7Vbdrzeolw5xHnVcVUXd5I5PohJBnCbZUfVvqNiu
         2l7B/GdFZ3hq/lP2ZBDSJqtdEDshudXa0pDuGZ5upOhmluSKgtFtWPzqu1hHjU6YlhpR
         o+cw==
X-Gm-Message-State: ANoB5plSo+LtVH2UfSRofQq4Xhu3Zv5oLbxFaIWa994V3ZIYuSiS2TI6
        05t+KmW3Px4AbyMtI3N5tOA=
X-Google-Smtp-Source: AA0mqf57LevZVBs6euUUGtaozwL/poJCJLlSLNAge5+adn6ImPEsi05ApV+mc70mR8xpvZoJk+bb3Q==
X-Received: by 2002:a63:f850:0:b0:477:f9fa:80cb with SMTP id v16-20020a63f850000000b00477f9fa80cbmr37148493pgj.118.1670193006703;
        Sun, 04 Dec 2022 14:30:06 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902db0800b00186b86ed450sm9249588plx.156.2022.12.04.14.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 14:30:05 -0800 (PST)
Date:   Sun, 4 Dec 2022 14:30:01 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Message-ID: <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167019256481.3792653.4369637751468386073.stgit@devnote3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 05, 2022 at 07:22:44AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the function error injection framework in the fault injection
> subsystem can change the function code flow forcibly, it may cause
> unexpected behavior (and that is the purpose of this feature) even
> if it is applied to the ALLOW_ERROR_INJECTION functions.
> So this feature must be used only for debugging or testing purpose.

The whole idea of tainting for kernel debugging is questionable.
There are many other *inject* kconfigs and other debug flags
for link lists, RCU, sleeping, etc.
None of them taint the kernel.

> To identify this in the kernel oops message, add a new taint flag

Have you ever seen a single oops message because of this particular
error injection?

> for the fault injection. This taint flag will be set by either
> function error injection is used or the BPF use the kprobe_override
> on error injectable functions (identified by ALLOW_ERROR_INJECTION).

...

>  	/* set the new array to event->tp_event and set event->prog */
> +	if (prog->kprobe_override)
> +		add_taint(TAINT_FAULT_INJECTED, LOCKDEP_NOW_UNRELIABLE);

Nack for bpf bits.
