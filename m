Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED959A8C8
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 00:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiHSWnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 18:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHSWnW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 18:43:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA9F1AD90
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:43:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k14so5523893pfh.0
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=y4FKYCBkWdu7eXvvGMhOLWdm9kmZwSMH/OKi5LsDaN4=;
        b=Zvpf2AL/7whxmDf+QfnhQ3jE9XzeDyTNmqLBkc2BbkbQjPcISqwXenOeXBfc78tzZc
         QPJ7RTOWqhrtAuIokwAvF9v3stZItm3L8K6UvhkVl7dPvr1wvtFBht7Aro59O5Wl2658
         9I7we6E9Ap5o+NS8d3fhyrmNq3w9PGUZLUOjcu9q2uqoy/mJ7V9dSjpgs4nwVQefRhbF
         s3GkchEpUZHDs6StcvEjeXrFj53I6BxelQfcI0SLz+FF5VbPZz72IuqFLRtEZPHPR3Rp
         1qkMlXxkwsvt1GjLeIYyH0YzV0c7RwRyu65Z5Hn456ZQ48Oc8KTO5BANSQ1t4fj4WB+S
         sLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=y4FKYCBkWdu7eXvvGMhOLWdm9kmZwSMH/OKi5LsDaN4=;
        b=FkBEUBQHW+TDXIhjYGCF+zrwILdJFGg8aXfdzN53x9d6XwwjjxouzMDeyCCRcofX2q
         A1yG8Beutks2S6VRpOFf9bw0mSiheHnE3/4kvR2HAQP+UdVbGFdHbO2hcTBTEiVNBBZs
         y3C9pVIyLkb8w0j56nIqkQCgfV+M4HlcuoWADZstpQg6TByepzxTIrcIG9R10SN4EP6K
         bjUokleBEuz2/BMTCRCewLW9v4JlBqo0PpSE4gEqp9cauIgGTqllsNz2vxclMTI6/82+
         MmBNbhQ7//jDhQqqxIBMBRyKbx5oOPQ3rB8RAKXr4dEER7WET28/Bpvd/0XGLWtktdLZ
         jmxg==
X-Gm-Message-State: ACgBeo3nORtK9mgHusatoeYqO9uMpsJkMw0kEwn0Y3JVfYujTOsLXXwi
        rQjsQgAq0iUMeryTV/Y9FQI=
X-Google-Smtp-Source: AA6agR4tUmAC3dbsLPig67Vs2UwW+p0yQ82X6KDCRMfxeztCXr5h29oo3cjFH+9wj8ihzgrKK2tTOw==
X-Received: by 2002:aa7:954d:0:b0:52e:b22c:14a2 with SMTP id w13-20020aa7954d000000b0052eb22c14a2mr9969788pfq.45.1660949000213;
        Fri, 19 Aug 2022 15:43:20 -0700 (PDT)
Received: from MacBook-Pro-3.local.dhcp.thefacebook.com ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7948c000000b00535c4b7f1eesm3916314pfk.87.2022.08.19.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:43:19 -0700 (PDT)
Date:   Fri, 19 Aug 2022 15:43:17 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 13/15] bpf: Prepare bpf_mem_alloc to be used
 by sleepable bpf programs.
Message-ID: <20220819224317.i3mwmr5atdztudtt@MacBook-Pro-3.local.dhcp.thefacebook.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <20220819214232.18784-14-alexei.starovoitov@gmail.com>
 <CAP01T75MUMKzacdE+AcKqgXy1jA5FyMwKXxiibD0ML3OFSqvsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75MUMKzacdE+AcKqgXy1jA5FyMwKXxiibD0ML3OFSqvsw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 20, 2022 at 12:21:46AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> > Then use call_rcu() to wait for normal progs to finish
> > and finally do free_one() on each element when freeing objects
> > into global memory pool.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> 
> I fear this can make OOM issues very easy to run into, because one
> sleepable prog that sleeps for a long period of time can hold the
> freeing of elements from another sleepable prog which either does not
> sleep often or sleeps for a very short period of time, and has a high
> update frequency. I'm mostly worried that unrelated sleepable programs
> not even using the same map will begin to affect each other.

'sleep for long time'? sleepable bpf prog doesn't mean that they can sleep.
sleepable progs can copy_from_user, but they're not allowed to waste time.
I don't share OOM concerns at all.
max_entries and memcg limits are still there and enforced.
dynamic map is strictly better and memory efficient than full prealloc.

> Have you considered other options? E.g. we could directly expose
> bpf_rcu_read_lock/bpf_rcu_read_unlock to the program and enforce that
> access to RCU protected map lookups only happens in such read
> sections, and unlock invalidates all RCU protected pointers? Sleepable
> helpers can then not be invoked inside the BPF RCU read section. The
> program uses RCU read section while accessing such maps, and sleeps
> after doing bpf_rcu_read_unlock. They can be kfuncs.

Yes. We can add explicit bpf_rcu_read_lock and teach verifier about RCU CS,
but I don't see the value specifically for sleepable progs.
Current sleepable progs can do map lookup without extra kfuncs.
Explicit CS would force progs to be rewritten which is not great.

> It might also be useful in general, to access RCU protected data from
> sleepable programs (i.e. make some sections of the program RCU
> protected and non-sleepable at runtime). It will allow use of elements

For other cases, sure. We can introduce RCU protected objects and
explicit bpf_rcu_read_lock.

> from dynamically allocated maps with bpf_mem_alloc while not having to
> wait for RCU tasks trace grace period, which can extend into minutes
> (or even longer if unlucky).

sleepable bpf prog that lasts minutes? In what kind of situation?
We don't have bpf_sleep() helper and not going to add one any time soon.
