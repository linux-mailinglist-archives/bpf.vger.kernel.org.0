Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA495A04FB
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 02:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiHYAJD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 20:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiHYAJC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 20:09:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3F370E51
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:09:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t5so24042763edc.11
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=daI2yVdfpWES6VKmM23cpOtVl/6VtWlL9gVWWX+YU8w=;
        b=h745Bcik7a/etpTJpn7PvWIbqRpyEa0ZxsHP9DF23cGFPoqeEjZW7wQy0OSU4cn6eM
         OL2Pve6XAZ81fYA5oHXyJHFK2buyoqD317Q/7pPlRI1xT0axrQOwCrSZVBDzC8G5+xW4
         J5MLvUtNerULGN5ApeJrwjk5rtojHV4MJ7QlDU2atU9z1KnaMTzMkOvAaOfyd+NJnBxP
         Msyglvg8Hc3PRaIvpR9k6ahJk9ITDVogcDhPnApdhrL3bYye57+AKR44mxUYju2sD0Cq
         tTnyDQeKfI2OALiJmgt23myX3s1ZGhqdw54p6WrPGorj/LiuJskSLvgvhUYHfwQgyQSA
         Ppzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=daI2yVdfpWES6VKmM23cpOtVl/6VtWlL9gVWWX+YU8w=;
        b=fjLgwxZvNZogExe3vndjOX/JMpfIRA9rX7vc4TZGCdq85I0sHvNCABqImiB9mW2KjN
         u9FrgNcWTB4uX5mLXBIUvjzcS03uyKBoytOPu/2t3B+P9TNXmGJ1z+puWFQ1UrBfqDJV
         ugTyJ73mH1FluOzZKVu7TgUAgtSklAskiPX2fqKmlHwT8dEG0EpDwE039rb+xtEX7uw8
         vZlpZ57141L8rYEH32RonNo+Ylhe6RNdlDJEnuOHBaMD3JXShr2VvD9yRDGzhrZ4BJ+B
         d9LGQ7s7xm81X3x1/i+u8bAElqqONIPjaNbhAY/f8JTL6MXl8M6ox3GttIowDMwy4L2G
         Y9WQ==
X-Gm-Message-State: ACgBeo1qohLa2/cLglDTMYIFimo3eaq/WCpya9mocmffwXL43//Io+XM
        H2ua8rJTrBimoEIe7K4o1dfjFnyRac33Zy7p+WQ=
X-Google-Smtp-Source: AA6agR4GDPytrKTHpbw3NVfvRGaUGGlj5T4LpD0MD9p8tOFXQvzH902wCB1OAKcU0xKhS4BFujrS1tE8dXtZp5HmLn0=
X-Received: by 2002:a05:6402:298c:b0:446:a97:1800 with SMTP id
 eq12-20020a056402298c00b004460a971800mr1101234edb.421.1661386139771; Wed, 24
 Aug 2022 17:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <20220819214232.18784-14-alexei.starovoitov@gmail.com> <CAP01T75MUMKzacdE+AcKqgXy1jA5FyMwKXxiibD0ML3OFSqvsw@mail.gmail.com>
 <20220819224317.i3mwmr5atdztudtt@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <CAP01T77A1pqYQKeECDSCoxH1pQ1Vxcm84B8_D_r0xoZv_bbq_A@mail.gmail.com>
 <CAADnVQLXKaNsP7VuGBfnrsNwEZ2BYQYcQ=s3EGS-g6HhM9E1uA@mail.gmail.com> <CAP01T76YDGtF0tV6cDvzANW2oyJTGvSVGsT-F-YDozWjg9HnMw@mail.gmail.com>
In-Reply-To: <CAP01T76YDGtF0tV6cDvzANW2oyJTGvSVGsT-F-YDozWjg9HnMw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Aug 2022 17:08:48 -0700
Message-ID: <CAADnVQKvctFmmWQuEdb3L0KfVgwXfLO2PCnzzZXfJN46iJyDXg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/15] bpf: Prepare bpf_mem_alloc to be used
 by sleepable bpf programs.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Aug 24, 2022 at 12:50 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 20 Aug 2022 at 01:01, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Aug 19, 2022 at 3:56 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Sat, 20 Aug 2022 at 00:43, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sat, Aug 20, 2022 at 12:21:46AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > >
> > > > > > Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> > > > > > Then use call_rcu() to wait for normal progs to finish
> > > > > > and finally do free_one() on each element when freeing objects
> > > > > > into global memory pool.
> > > > > >
> > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > ---
> > > > >
> > > > > I fear this can make OOM issues very easy to run into, because one
> > > > > sleepable prog that sleeps for a long period of time can hold the
> > > > > freeing of elements from another sleepable prog which either does not
> > > > > sleep often or sleeps for a very short period of time, and has a high
> > > > > update frequency. I'm mostly worried that unrelated sleepable programs
> > > > > not even using the same map will begin to affect each other.
> > > >
> > > > 'sleep for long time'? sleepable bpf prog doesn't mean that they can sleep.
> > > > sleepable progs can copy_from_user, but they're not allowed to waste time.
> > >
> > > It is certainly possible to waste time, but indirectly, not through
> > > the BPF program itself.
> > >
> > > If you have userfaultfd enabled (for unpriv users), an unprivileged
> > > user can trap a sleepable BPF prog (say LSM) using bpf_copy_from_user
> > > for as long as it wants. A similar case can be done using FUSE, IIRC.
> > >
> > > You can then say it's a problem about unprivileged users being able to
> > > use userfaultfd or FUSE, or we could think about fixing
> > > bpf_copy_from_user to return -EFAULT for this case, but it is totally
> > > possible right now for malicious userspace to extend the tasks trace
> > > gp like this for minutes (or even longer) on a system where sleepable
> > > BPF programs are using e.g. bpf_copy_from_user.
> >
> > Well in that sense userfaultfd can keep all sorts of things
> > in the kernel from making progress.
> > But nothing to do with OOM.
> > There is still the max_entries limit.
> > The amount of objects in waiting_for_gp is guaranteed to be less
> > than full prealloc.
>
> My thinking was that once you hold the GP using uffd, we can assume
> you will eventually hit a case where all such maps on the system have
> their max_entries exhausted. So yes, it probably won't OOM, but it
> would be bad regardless.
>
> I think this just begs instead that uffd (and even FUSE) should not be
> available to untrusted processes on the system by default. Both are
> used regularly to widen hard to hit race conditions in the kernel.
>
> But anyway, there's no easy way currently to guarantee the lifetime of
> elements for the sleepable case while being as low overhead as trace
> RCU, so it makes sense to go ahead with this.

Right. We evaluated SRCU for sleepable and it had too much overhead.
That's the reason rcu_tasks_trace was added and sleepable bpf progs
is the only user so far.
The point I'm arguing is that call_rcu_tasks_trace in this patch
doesn't add mm concerns more than the existing call_rcu.
There is CONFIG_PREEMPT_RCU and RT. uffd will cause similar
issues in such configs too.
