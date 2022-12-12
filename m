Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD546498D6
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 07:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLLGIQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 01:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLLGIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 01:08:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3331CE1F;
        Sun, 11 Dec 2022 22:08:09 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so14523773pjs.4;
        Sun, 11 Dec 2022 22:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9W9EiEDru65oG/XN8FDRzHu0aSp1hC8sberwuq7Mks=;
        b=CqY8VlyG+dEp9cRlmgvgHjyQ36OO79+gOS7IfcVmddHRAZnTtnMesWwZOAFh+zSXCC
         qVL4WYmGX0raYcKbCnXn4fCT55AGmstP0mmXLnk3oXBYzhxKn9y106lhAulkzHkf0ahL
         7ulKonFKlc9pncfjxhgEiVq1l62gfoQouduqJIECqTXBu8ez3zDaLGj1QGk1qBzvb7WE
         /1SfaNGbGCS0RKWZH7DFXu3qSdiMBYozKCU/uyBWBbN4GTRSrr/TpI24LWE52d4mqX/v
         hBy2QDrAwfgjqxV6hc4fUDyySSczOlJdidX/FZ/7SFJ1BrEayDuyhfi/VBJs6lvODx5x
         mgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9W9EiEDru65oG/XN8FDRzHu0aSp1hC8sberwuq7Mks=;
        b=kundJaqvEV3YdfpXpUFopunwrEEsXXf58SDianIxEt8JoUcSmOpsNsoKJilv4IgXo+
         hQL2mqFCOj9UQqIBvaZucT6xB4AEF1frG/ER3hJ/UelhSzG3ZocKjU4Xs+lst+4+gBy6
         CyV+jRTViyp4njygiu0TkQj/WyfMT33sQOqm3yCI1x3c8Hi4Cbnrf0/t4s/oZ6lEuie9
         DGOTfYeuqqmcV7mlAsZ8HnY7+1tMx5Pz6uKAiNPgXkVBR5KQjY7g6NXE6awEcpAWI/Tt
         TBUHMcWGR6zpUjhO7Dj9IGXw6n7abZkisg5pXPBg8RN5zRwKS8dkBCx+D3+DU58zfE05
         VwwQ==
X-Gm-Message-State: ANoB5pkPICnl0DvywmOU3eScLlS1o+cBKPK/DduT59bA8nPMTifK1ZKb
        KtG+zl24GL+yWlQkZarfkU8=
X-Google-Smtp-Source: AA0mqf7GBbgEide84hMsx8LQgELDCNBGhjZFob2nLZ8jwsQwHUGUEy+VIaXXuGjVKNeRGhyQNsL5gQ==
X-Received: by 2002:a17:90a:d906:b0:219:b015:58d4 with SMTP id c6-20020a17090ad90600b00219b01558d4mr17238795pjv.28.1670825289089;
        Sun, 11 Dec 2022 22:08:09 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id c14-20020a17090a674e00b0020c899b11f1sm4611886pjm.23.2022.12.11.22.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 22:08:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 11 Dec 2022 20:08:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
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
        kernel-team@meta.com
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Y5bFRym3iFSvcFMW@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <alpine.DEB.2.22.394.2212112331150.29296@hadrien>
 <Y5aO3y23uoQFCazr@slm.duckdns.org>
 <alpine.DEB.2.22.394.2212120702560.2971@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212120702560.2971@hadrien>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 07:03:56AM +0100, Julia Lawall wrote:
> > Yeah, scx_exampl_central needs to either set ops.dispatch_max_batch higher
> > according to number of CPUs or flush and exit the loop and retry when
> > scx_bpf_dispatch_nr_slots() reaches zero. Will update.
> 
> Since there could be any number of waking threads, maybe some kind of
> flush and retry solution would be better?

Yeah, cental is a bit unusual because it's scheudling for other CPUs too. In
most cases, this doesn't matter that much because whether to retry or not
can be determined by the kernel core code. There are a couple ways to go
about it. When slots run out, it can explicitly queue another scheduling
event on self, or use scx_bpf_consume() to flush the pending tasks. Either
should work but neither is particularly pretty. I'm trying to see whether I
can remove the static dispatch buffers altogether.

Thanks.

-- 
tejun
