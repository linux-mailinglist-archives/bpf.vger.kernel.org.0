Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C9859A8FB
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 00:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiHSW4v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 18:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiHSW4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 18:56:50 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981CC10E789
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:56:49 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r141so4361575iod.4
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DLOUyCCY0hq75QhLqDKmn7t1fk6HIbRSoz8cQOqRdjU=;
        b=WllZ1MyUYHokH1yJZE09n63r/dBEstNHftlfD0HAp1KhpKMqF1/Z8XvMuaekNj6D2E
         yiaAcDBfUp0Yw2oo6Jrb5Frpz35VRZ/eux1BikHDsMjZj1vJB0Jfa2GBq/bBiEc8V7Ro
         uxvaskCOrN0VdjHKDLnxHduDFDG2N1wNW4UsguZjx11yzAsk2gdVaBEXD6gOrQ3p8fby
         /b16skGWxU/jPFChheAS3mVmTpOz8JEkyH3wEjopxe/4JFHxiXEzxZSvhivGgjyjTHnf
         sfBNDs4203lfXqSfiznvIOV9m6Gyez1/cRDsoPcxapDh4ovwegds3i5PBHPS8b09g0DU
         D0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DLOUyCCY0hq75QhLqDKmn7t1fk6HIbRSoz8cQOqRdjU=;
        b=V87dC+rvcV+1ChfmNuRx9DVWB7Hl5V6k1UjHlV2WS7mvbmjnYXBZnx9KzS2DfDHV4i
         I1YEUDcB+j7M63KQ2N3rswd/epvuhbjIzGj450tr2QOZL/2idmv7QCiauagMlNipjCTE
         yvfk1+jwk57zULEF4kNsUsQuK0a0XumNY94hplUuE4stGRH+tMSERdhhE7xxvsdZ/oaO
         PV5MMyCYpokH2lb6B4EmjPoH15+I7UEXWivc+OfVkcvnXDUIdfWkOd8O0J53QL2OEAVV
         Qi2ducLN8awwSIUfeensxQnK9jeGZQuko5v69KOKvRq1qdC0QTslGmDNAE3nlbSWDNaJ
         xZjA==
X-Gm-Message-State: ACgBeo0zemV0iU6iomojO258xeFc+zq2432BO6xe1oYkbRtG7idbqlfI
        PnBOC96tzkgkVd6yF7noDmqQbXsV/0V1Ap8mP53HrwVz
X-Google-Smtp-Source: AA6agR6GPCNEdJAZnj9Er+xf1cG/9xaEXyLAtHplHeKYSLQ6x1oJrO/7bZ/1cr8ThdGT3GBdrweoQ+xhMYkKBtIWDy4=
X-Received: by 2002:a5e:dc46:0:b0:689:94f6:fa3e with SMTP id
 s6-20020a5edc46000000b0068994f6fa3emr840750iop.110.1660949808896; Fri, 19 Aug
 2022 15:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <20220819214232.18784-14-alexei.starovoitov@gmail.com> <CAP01T75MUMKzacdE+AcKqgXy1jA5FyMwKXxiibD0ML3OFSqvsw@mail.gmail.com>
 <20220819224317.i3mwmr5atdztudtt@MacBook-Pro-3.local.dhcp.thefacebook.com>
In-Reply-To: <20220819224317.i3mwmr5atdztudtt@MacBook-Pro-3.local.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 20 Aug 2022 00:56:12 +0200
Message-ID: <CAP01T77A1pqYQKeECDSCoxH1pQ1Vxcm84B8_D_r0xoZv_bbq_A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/15] bpf: Prepare bpf_mem_alloc to be used
 by sleepable bpf programs.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
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

On Sat, 20 Aug 2022 at 00:43, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Aug 20, 2022 at 12:21:46AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> > > Then use call_rcu() to wait for normal progs to finish
> > > and finally do free_one() on each element when freeing objects
> > > into global memory pool.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> >
> > I fear this can make OOM issues very easy to run into, because one
> > sleepable prog that sleeps for a long period of time can hold the
> > freeing of elements from another sleepable prog which either does not
> > sleep often or sleeps for a very short period of time, and has a high
> > update frequency. I'm mostly worried that unrelated sleepable programs
> > not even using the same map will begin to affect each other.
>
> 'sleep for long time'? sleepable bpf prog doesn't mean that they can sleep.
> sleepable progs can copy_from_user, but they're not allowed to waste time.

It is certainly possible to waste time, but indirectly, not through
the BPF program itself.

If you have userfaultfd enabled (for unpriv users), an unprivileged
user can trap a sleepable BPF prog (say LSM) using bpf_copy_from_user
for as long as it wants. A similar case can be done using FUSE, IIRC.

You can then say it's a problem about unprivileged users being able to
use userfaultfd or FUSE, or we could think about fixing
bpf_copy_from_user to return -EFAULT for this case, but it is totally
possible right now for malicious userspace to extend the tasks trace
gp like this for minutes (or even longer) on a system where sleepable
BPF programs are using e.g. bpf_copy_from_user.

> I don't share OOM concerns at all.
> max_entries and memcg limits are still there and enforced.
> dynamic map is strictly better and memory efficient than full prealloc.
>
> > Have you considered other options? E.g. we could directly expose
> > bpf_rcu_read_lock/bpf_rcu_read_unlock to the program and enforce that
> > access to RCU protected map lookups only happens in such read
> > sections, and unlock invalidates all RCU protected pointers? Sleepable
> > helpers can then not be invoked inside the BPF RCU read section. The
> > program uses RCU read section while accessing such maps, and sleeps
> > after doing bpf_rcu_read_unlock. They can be kfuncs.
>
> Yes. We can add explicit bpf_rcu_read_lock and teach verifier about RCU CS,
> but I don't see the value specifically for sleepable progs.
> Current sleepable progs can do map lookup without extra kfuncs.
> Explicit CS would force progs to be rewritten which is not great.
>
> > It might also be useful in general, to access RCU protected data from
> > sleepable programs (i.e. make some sections of the program RCU
> > protected and non-sleepable at runtime). It will allow use of elements
>
> For other cases, sure. We can introduce RCU protected objects and
> explicit bpf_rcu_read_lock.
>
> > from dynamically allocated maps with bpf_mem_alloc while not having to
> > wait for RCU tasks trace grace period, which can extend into minutes
> > (or even longer if unlucky).
>
> sleepable bpf prog that lasts minutes? In what kind of situation?
> We don't have bpf_sleep() helper and not going to add one any time soon.
