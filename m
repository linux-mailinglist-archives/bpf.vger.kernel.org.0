Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFDD64A66C
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiLLSDe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 13:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiLLSD3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 13:03:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE410F8;
        Mon, 12 Dec 2022 10:03:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fy4so640520pjb.0;
        Mon, 12 Dec 2022 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bNS+IL9G3jZOP7BFktoG/NDExOtM0WC4ksPDn3Pgns=;
        b=FfOYp2sZIXs73LIMVCORQIqZ6qqbyX+ljz7sbQviFlaniHEWIw7037gUNEEVVOPLMI
         O2k+KMzV11Yn2XmUCBRh4V3iz16+DyYEfq7a5rYtnxdeO9tlPwEBkh+r3Dfpy1VgC2g6
         3OlNaAU18JTVwgLB2N/HxnVqD0/abqpNs/rGJLlZg4LUnxRlx/lF4J5kCYk5Ea38Y/Dd
         hSbN9MCayy3VlcrJevJX5S34afpV/89JPqLwg4zotC/KgSr3nHG8fTg99bCTynhjNogM
         M/cP4yn8ceZTKwMv94y3ZjOtnPYh4cr+jLsH+WUEd2rLUhIC+/BMhTdPf0e/3A5LvB4f
         z1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bNS+IL9G3jZOP7BFktoG/NDExOtM0WC4ksPDn3Pgns=;
        b=lkmXD8aI3ZBjDUm/buBQL1+B60POvMU+C2AJkVn+3eKp4tpQVccCsU/cCgQWPB0Wur
         EB1+1o4te/TGp4l7H/TIop7YNEbLu7JY84VTsZODVURUc3Tl6cTzcibvICM6uSgCLEh3
         lGIub4isoZIn2Xo0URlmHK5XDQW5sqCs09AevrK1XKEWBbefy+0wy5ivlQRjnz+8zg6w
         /NG7/l6WgIiiKXDW75aPPiwCMSBNIS9nLoa1GRUN81Bw4Pstkk/E9HmlEz9nHMuBEIc2
         u+6CCTTi1YkhvDeBSYioVMBsISomL0U1b2pauWGuADUSIYtmmVpZwpfy1JtJGeGD1nph
         IhfQ==
X-Gm-Message-State: ANoB5plg/JNA8E43+9Vev8EXpyAdFstgiIjJn9Oi9U+rkCT6kOLYc8/M
        TdTagXK5sv5wWOT0GW0vV5c=
X-Google-Smtp-Source: AA0mqf5HLf6ebynEh5N3JXUZHOPS3NmjgLrmyBtErYQjpDTSkA76dHjV7qiQXHjHEk+t/hriWj4nAg==
X-Received: by 2002:a05:6a20:690b:b0:a7:89fd:884c with SMTP id q11-20020a056a20690b00b000a789fd884cmr24471389pzj.11.1670868206530;
        Mon, 12 Dec 2022 10:03:26 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id x2-20020a628602000000b00576d4d69909sm6113443pfd.8.2022.12.12.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:03:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 08:03:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 04/31] sched: Allow sched_cgroup_fork() to fail and
 introduce sched_cancel_fork()
Message-ID: <Y5ds7G7qTmpAyaKU@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-5-tj@kernel.org>
 <Y5cM24M4007WcPod@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cM24M4007WcPod@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 12:13:31PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 29, 2022 at 10:22:46PM -1000, Tejun Heo wrote:
> > A new sched_clas needs a bit more control over forking. This patch makes the
>                  ^
>                  (insufficient s's)

Will update.

> > following changes:
> > 
> > * Add sched_cancel_fork() which is called if fork fails after sched_fork()
> >   succeeds so that the preparation can be undone.
> > 
> > * Allow sched_cgroup_fork() to fail.
> > 
> > Neither is used yet and this patch shouldn't cause any behavior changes.
> 
> Fails to explain why this would be needed and why that would be a good
> thing. IOW, total lack of justification.

This is because sched_ext calls out to BPF scheduler's prepare_enable()
operation to prepare the task. The operation is allowed to fail (e.g. it
might need to allocate something which can fail), so we need a way back back
out of it.

Thanks.

-- 
tejun
