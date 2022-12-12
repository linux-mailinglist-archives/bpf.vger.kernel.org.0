Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC666498F3
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 07:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiLLG2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 01:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLLG2p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 01:28:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990F3B1E9;
        Sun, 11 Dec 2022 22:28:44 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so11073592pjd.5;
        Sun, 11 Dec 2022 22:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqd3gKkLyvEjCH/A2NtZjrzcD9Wgo0FBRk/+2/6c0cw=;
        b=ioblb/FoYr1EIHwH1omz15qxpGMjlvcSeotTK20Ps0a0+eITH9r5WF8qJZq58R4B2R
         oazkixrQ8+XM/MLK622RshEBhE2Us/8malzNSTePq5FvpDBVjfbjIkOSWibBS2O+M+/b
         yN1UZsMEEmlE9eeEmdgs0ofLNXWya1nb3obnISoQtH7TE9a36ePmQyabwvD2D9sGpOdo
         J0i7TkPSyWO83Apn0mDIJ35s87xnr9+7sJ67zKch2lSQJTZCoeW2lr0OThceao4E9vRe
         IVVlJl7GzAdmTByc1VUcB8lo0khBuWUQJ67ZVKmvL4U5KOAD4oMQLULrx38iVs83PZn0
         aNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqd3gKkLyvEjCH/A2NtZjrzcD9Wgo0FBRk/+2/6c0cw=;
        b=wDqjcTNkDzyjSSIzOY/Kxrw+9CA4VvfzHlW9kgQRXzDGbZG+OBfjUoY2D8kRED3D+7
         FRCF+sy7+b9nLG0YZtiPPMjHMwwHCGR0/dVC3s8U5BPpF+3C2lP03IxC0dpQRydDvJDx
         r1quczpeLlGZfhkonkh5HcTT9/vJxywhxosG/t3mWCzsvlt51idlAcO0Klb8C9dg7kEG
         6J8ePhl8GFrozQpNFrW7YA67LDuOavveEfQr3yvsz47Mld2cRuiykH42wOWPaTPqFDp4
         V+t8eeB/j1mWYIJXfuN7ebruZlHoTP/GMZeXnNMWAkRmvsV2/K2XchZgv7HAUzvcD7IU
         nG/g==
X-Gm-Message-State: ANoB5pkGlHJGApmzKIXmO8ST447BFKQRqwSJvJip1yWdW6N4AGHvY69g
        7UZeBdCz9ZWgrlSBVUOffH8=
X-Google-Smtp-Source: AA0mqf7z+tUvddeXs4XuhzmgStQqYi2IpE6t/CpKGWCY/dtpxEK3OYM1wMhuG6CYKC8WB70XhwUCsA==
X-Received: by 2002:a17:90a:a00f:b0:220:bad8:b4e7 with SMTP id q15-20020a17090aa00f00b00220bad8b4e7mr8394646pjp.7.1670826523863;
        Sun, 11 Dec 2022 22:28:43 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a035b00b00219186abd7csm4626602pjf.16.2022.12.11.22.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 22:28:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 11 Dec 2022 20:28:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 28/31] sched_ext: Add
 Documentation/scheduler/sched-ext.rst
Message-ID: <Y5bKGXG0o4dReJ8C@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-29-tj@kernel.org>
 <Y5anpn997mR2g8Ur@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5anpn997mR2g8Ur@debian.me>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Mon, Dec 12, 2022 at 11:01:42AM +0700, Bagas Sanjaya wrote:
> On Tue, Nov 29, 2022 at 10:23:10PM -1000, Tejun Heo wrote:
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: David Vernet <dvernet@meta.com>
> > Acked-by: Josh Don <joshdon@google.com>
> > Acked-by: Hao Luo <haoluo@google.com>
> > Acked-by: Barret Rhoden <brho@google.com>
> 
> No patch description? Really? Please write one.

That's unnecessarily grating. I can add some blurb but here's an honest
question. What pertinent information would the description contain that
shouldn't be in the doc itself?

> For patch subject, better write "Documentation: scheduler: document
> extensible scheduler class".

Sounds good.

> ---- >8 ----
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index a2ad963b227a1b..404b820119b4a4 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -15,7 +15,8 @@ programs - the BPF scheduler.
>  
>  * The system integrity is maintained no matter what the BPF scheduler does.
>    The default scheduling behavior is restored anytime an error is detected,
> -  a runnable task stalls, or on sysrq-S.
> +  a runnable task stalls, or on invoking SysRq key sequence like
> +  :kbd:`SysRq-s`.
>  
>  Switching to and from sched_ext
>  ===============================
> @@ -35,7 +36,7 @@ case, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE`` and
>  ``SCHED_EXT`` tasks are scheduled by sched_ext. In the example schedulers,
>  this mode can be selected with the ``-a`` option.
>  
> -Terminating the sched_ext scheduler program, triggering sysrq-S, or
> +Terminating the sched_ext scheduler program, triggering SysRq key, or
>  detection of any internal error including stalled runnable tasks aborts the
>  BPF scheduler and reverts all tasks back to CFS.
>  
> 
> > +A task is always *dispatch*ed to a dsq for execution. The task starts
> > +execution when a CPU *consume*s the task from the dsq.
> 
> Sphinx reported two warnings:
> 
> Documentation/scheduler/sched-ext.rst:117: WARNING: Inline emphasis start-string without end-string.
> Documentation/scheduler/sched-ext.rst:117: WARNING: Inline emphasis start-string without end-string.
> 
> I have to replace with quotes (since "dispatch" and "consume" have different
> meaning in this context):
> 
> ---- >8 ----
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 81f78e05a6c214..a2ad963b227a1b 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -114,8 +114,8 @@ there is one global FIFO (``SCX_DSQ_GLOBAL``), and one local dsq per CPU
>  (``SCX_DSQ_LOCAL``). The BPF scheduler can manage an arbitrary number of
>  dsq's using ``scx_bpf_create_dsq()`` and ``scx_bpf_destroy_dsq()``.
>  
> -A task is always *dispatch*ed to a dsq for execution. The task starts
> -execution when a CPU *consume*s the task from the dsq.
> +A task is always "dispatched" to a dsq for execution. The task starts
> +execution when a CPU "consumes" the task from the dsq.
>  
>  Internally, a CPU only executes tasks which are running on its local dsq,
>  and the ``.consume()`` operation is in fact a transfer of a task from a
> 
> Otherwise the doc LGTM.

Will apply the suggested changes.

Thanks.

-- 
tejun
