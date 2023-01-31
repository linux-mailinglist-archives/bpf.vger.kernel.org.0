Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E46820CF
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 01:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjAaAgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 19:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjAaAgb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 19:36:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8CB27997;
        Mon, 30 Jan 2023 16:36:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 5so13464174plo.3;
        Mon, 30 Jan 2023 16:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRK7osZfF2K95EahcXCri7k1dMfEc48RzFCHf3BmHj8=;
        b=h+1IzwlvADs+sWe1MH5UarJ/Q8NnF08IFhqNK10eNZtaK0GkaTj0kCoghkYuoeVSzO
         Fb3gNl8jOVq877Iq9yC93VKW4PxXMfiRJONz3Jy+3fYq0oEfQVNSkCQFOvc/UJgUTqsm
         f238THB9Fnv1UxtbVtr/xXRSNPx9nCLLxlzxy7EOZs4z6kn+3Ft4hMnPPTvoB7CYF81x
         JDYF0/ut7k/w5emefRKm2s9OsTA6StzljBhfLt2pJOoz0EhoS4dJX7sj3mq6EEpjLhuf
         sp2ubKhHRhPzpuwjB953W62Fadj6Cylg4DhG9JjGmi0i4pjzQjPgD+BjYCB67opg8wj3
         Jfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRK7osZfF2K95EahcXCri7k1dMfEc48RzFCHf3BmHj8=;
        b=NuxMZaq6WrQiGwniPBhaBv1AgLS63cLD2E7I6xem16Ho93/sg3pM6gIFxisESvx5Zw
         TQLV8wLbqBbXnaQlEUa+wg/VxysGcDDo9vXjCnh7U+ZPeOsG1Sw1n3CHSveakYge+ghs
         RMx/fODhsPfyc4SjBLq1EItYZ5vMr5aM4dnA4fDT5BD/kfuH9GsvTUUA+A4M+MHEfQoc
         mjZq4+KUIdw4QgiOqx5TkVM/pwr9N2BuzlYkC+h1Go0ywv2+hSuXKsXNxk7dQrrwqol1
         ab5ODND2o8RseijBGOGosZW0LwvuvKyr8LCh+uHpLqyn+oQ81mv7s+xmuo4lLR1TJucP
         rVeg==
X-Gm-Message-State: AO0yUKWpSTQOCE3IgJ6H/R7HfAsxiwOSsGfyxl/vwGPapCbfRFToOG7J
        eiEbzGnsTV5G9/krVK0Mquc=
X-Google-Smtp-Source: AK7set85Xvb+G9Pkj83v9UB+yjAMw7C0E2s3SAZtYIUyfA2MXULD9N096P0Kc3qUx/YnKRXY2lY4Kw==
X-Received: by 2002:a17:903:210a:b0:196:3e78:70be with SMTP id o10-20020a170903210a00b001963e7870bemr13563447ple.40.1675125387027;
        Mon, 30 Jan 2023 16:36:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bg6-20020a1709028e8600b00189a50d2a3esm8366609plb.241.2023.01.30.16.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 16:36:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 30 Jan 2023 14:36:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 27/30] sched_ext: Implement core-sched support
Message-ID: <Y9hiifiFx4TeUdTo@slm.duckdns.org>
References: <20230128001639.3510083-1-tj@kernel.org>
 <20230128001639.3510083-28-tj@kernel.org>
 <CABk29Nt2-CCGnogpfEgJ3ZDk5Esk04n6EwsAqpw_vdeVfKuFUQ@mail.gmail.com>
 <Y9hgLENFI5y3Qtx2@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9hgLENFI5y3Qtx2@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 02:26:20PM -1000, Tejun Heo wrote:
> However, the BPF scheduler is free to dispatch whatever tasks anytime (e.g.
> scx_example_central), so it's possible that a task with an earlier timestamp
> has been dispatched to the local DSQ since curr started executing, in which
> case we likely want to return the first on DSQ as the CPU's candidate.

Okay, a more common case would be when a CPU is forced to run a task which
isn't current by its sibling winning a different cookie and then the BPF
scheduler putting that task right back on the local DSQ. For the CPU then,
the right candidate would be the first task on DSQ not the current running
one which is dragged forward because the sibling trumping us.

Thanks.

-- 
tejun
