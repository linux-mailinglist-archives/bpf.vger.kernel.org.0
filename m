Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3005B58E436
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 02:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiHJAuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 20:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHJAuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 20:50:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527D7E802
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 17:50:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z2so17200316edc.1
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 17:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MhhgyIJgtztxTH+RBKzQC8npYWpaFRAtUWAA7+LP2hI=;
        b=Bn4LbZCBdTk+86X6w1jLdSsySom4FySaok1ab79Kgf1c6VOQRMlAhw9CBt9wrU8IUi
         PmwKtkzvvJ4rua0S6w8ENXqlZ6uC2qn3BuZQNIiBOzHKdTVjjxwJlH6VA0+JccG+Z8+j
         KqeM4CGe+uTxI8hCFbmQ75nxIv4OHb/IxQLOAHJetccVoT0rSpFlcKQM18r9Fj0ULudt
         dB9qLK3n1hA4gPE2lZDD+39HpTjYmuZTut+nB0EENiCO4nvEUdWM+Ni6NrSZMQerKNem
         z1sWyOsB8WmQAdqh2qwpjJekBBvrq7hS5VMpcNDgx/Chwj6yv/x3ShSKgF9zyKN+s8+6
         XV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MhhgyIJgtztxTH+RBKzQC8npYWpaFRAtUWAA7+LP2hI=;
        b=UGSDxwRptGFfM+JYYtoI3I5YfrhMFbkuRV5zMCG7xMKuHxEON2yphSDbF+duqeP2i1
         gKcGg8QbfXzaV2nshltnbfT7SqWW57IUloFawtXH0p/6DU0RCIIBc55kSYmknajeom57
         xBQyZG9OkpJdSJk7P/0PjIFcMmJlQV/u6YN3Igr8w8CRgLhDYRcMJW28x2fvVfnYcBbI
         MK2O6T4Bfd+HPsPJ2puSSBBhWp7OGNK2LtCNew1/yl04uRnuLxdx+Y/znULE86ZK3bPr
         yy8RkOq1ZJ7TV1ptH1JKHBf4tyT88XKdx3HQpgM6/8XcpyTLgC1OT+cOwkdWMHShnWXX
         /LLg==
X-Gm-Message-State: ACgBeo33h9I9gU5OWMMypXr+R7Kx4kYoHgZ6bUFZeYD2EZz2tcxp/G0H
        A3V35Ck9IM0Gn77Tpgf+NJG151Vaa4v0KN0HEfXER2iL
X-Google-Smtp-Source: AA6agR7pHZiCLQV7ibLT8fb5to7qhmH2JdCYhK1Z+Yko+szMUw/jbDNcjKKKpgJ8WpeGc+GMIRMJaqDIUMnNQL2j5es=
X-Received: by 2002:a05:6402:2079:b0:43d:a218:9b8a with SMTP id
 bd25-20020a056402207900b0043da2189b8amr23699834edb.357.1660092602976; Tue, 09
 Aug 2022 17:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220809213033.24147-1-memxor@gmail.com> <20220809213033.24147-3-memxor@gmail.com>
 <20220809222908.hmy4pz3ai6howqhm@kafai-mbp>
In-Reply-To: <20220809222908.hmy4pz3ai6howqhm@kafai-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Aug 2022 17:49:51 -0700
Message-ID: <CAADnVQ+X3qxf2ksRSLT0ZK792Pz4LA5xc3G+EPL8cAQEUS=tGA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Don't reinit map value in prealloc_lru_pop
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 9, 2022 at 3:29 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Aug 09, 2022 at 11:30:32PM +0200, Kumar Kartikeya Dwivedi wrote:
> > The LRU map that is preallocated may have its elements reused while
> > another program holds a pointer to it from bpf_map_lookup_elem. Hence,
> > only check_and_free_fields is appropriate when the element is being
> > deleted, as it ensures proper synchronization against concurrent access
> > of the map value. After that, we cannot call check_and_init_map_value
> > again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
> > they can be concurrently accessed from a BPF program.
> >
> > This is safe to do as when the map entry is deleted, concurrent access
> > is protected against by check_and_free_fields, i.e. an existing timer
> > would be freed, and any existing kptr will be released by it. The
> > program can create further timers and kptrs after check_and_free_fields,
> > but they will eventually be released once the preallocated items are
> > freed on map destruction, even if the item is never reused again. Hence,
> > the deleted item sitting in the free list can still have resources
> > attached to it, and they would never leak.
> >
> > With spin_lock, we never touch the field at all on delete or update, as
> > we may end up modifying the state of the lock. Since the verifier
> > ensures that a bpf_spin_lock call is always paired with bpf_spin_unlock
> > call, the program will eventually release the lock so that on reuse the
> > new user of the value can take the lock.
> The bpf_spin_lock's verifier description makes sense.  Note that
> the lru map does not support spin lock for now.

ahh. then it's not a bpf tree material.
It's a minor cleanup for bpf-next?

> >
> > Essentially, for the preallocated case, we must assume that the map
> > value may always be in use by the program, even when it is sitting in
> > the freelist, and handle things accordingly, i.e. use proper
> > synchronization inside check_and_free_fields, and never reinitialize the
> > special fields when it is reused on update.
> Acked-by: Martin KaFai Lau <kafai@fb.com>
