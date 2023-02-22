Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1189169FC3C
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 20:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjBVTbT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 14:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjBVTbQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 14:31:16 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADFC3BD9E;
        Wed, 22 Feb 2023 11:30:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ck15so36094931edb.0;
        Wed, 22 Feb 2023 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jfa5EiufQKP9OPphX3roUqj0yqYAjmS8TtgTAmBE/U=;
        b=mkgmKYHarWH9fGnIpuYcuLJ7Yy5cyqcD4316A+SDk6ZgaQe0aKjfUiYux77X23BHHm
         CXQ+Se+WvW5KIy8brB8Njgm6+inysY38vuUH3h4LVwNj4e/Kq8Wve9nhLsKwySM62RHp
         DvJw8LseADFCqZEHB7yCoDt7jGY0Rr+6sxM5vv1ZOK2dLLKXMRU5NPgWdK83NuiPY+uQ
         hu3+ijqzcy/UyT274HqoEyMpsT6BgqwuJ302V9D9W/moqodBbOwUc7vmYdAh3B6CuEqC
         q+1CrP5I1DHENVI9z2KE/64EpTpEkjlQksZaxdddSosOkOxBr8M3wMzfjhhrF8oQjLc/
         5dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jfa5EiufQKP9OPphX3roUqj0yqYAjmS8TtgTAmBE/U=;
        b=J4Safe6qzpNuU6bvSEWG0VyvIux2S4Aqa781BnIoO8LbGJKLb3Zf1jWWvEYP4s7A8i
         4KlfFObREq9faGmoxoPT5Do7omX7SlIQzvHAc6+GdslGO/9Y93CX+KMdgpOMRCEFX9WC
         XPvbd+B/BmheSAgMpOCSxQou7xS3DtLXD7aZFTtrrOz5LuI0dQndm+UyFBFuys/B3m3c
         tL+cFzAmXaVZykXOAOhBHBzu64BZjlwI6+V+Ne2O6cEspXtjHXHKns78ISOV95uBjFXM
         Yeyq3hoVKSyfWzjvQZe48GUPlqCo04zOlZyPgcgWy909foMa91pX20pSp8t67m+dxsXS
         Q6aQ==
X-Gm-Message-State: AO0yUKUPqJnY5XhcgsjREihwUqKZ5RaCYPiXPB4VOTPsqh2GtOizBTjb
        OukN8zWY62SwR3JlJcTouIqui2vGRQPOtzsvtWhwCj/Bihk=
X-Google-Smtp-Source: AK7set+ji1WSyy02mR/QZRbPzkh/w58QQTnXrJcsrpi6sdNyjCokbtxiz7Da9T+202DSRzSW/2jW19SnSG228L+lg2s=
X-Received: by 2002:a05:6402:35ca:b0:4af:62ad:60b1 with SMTP id
 z10-20020a05640235ca00b004af62ad60b1mr2075358edc.3.1677094252642; Wed, 22 Feb
 2023 11:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com> <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com> <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com> <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo> <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com> <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
 <CAADnVQJzS9MQKS2EqrdxO7rVLyjUYD6OG-Yefak62-JRNcheZg@mail.gmail.com>
 <e16811cc-2d44-73a0-6430-d247605bc836@huaweicloud.com> <CAADnVQ+w9h4T6k+F5cLGVVx1jkHvKCF7=ki_Fb1oCp1SF1ZDNA@mail.gmail.com>
 <2a58c4a8-781f-6d84-e72a-f8b7117762b4@huaweicloud.com>
In-Reply-To: <2a58c4a8-781f-6d84-e72a-f8b7117762b4@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 11:30:41 -0800
Message-ID: <CAADnVQLg+WHzym=SC0KF0uzWw0J7ADjABBdZ9QDepdAT0z7V-g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 16, 2023 at 5:19 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 2/17/2023 12:35 AM, Alexei Starovoitov wrote:
> > On Thu, Feb 16, 2023 at 5:55 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >> Beside BPF_REUSE_AFTER_RCU_GP, is BPF_FREE_AFTER_RCU_GP a feasible solution ?
> > The idea is for bpf_mem_free to wait normal RCU GP before adding
> > the elements back to the free list and free the elem to global kernel memory
> > only after both rcu and rcu_tasks_trace GPs as it's doing now.
> >
> >> Its downside is that it will enforce sleep-able program to use
> >> bpf_rcu_read_{lock,unlock}() to access these returned pointers ?
> > sleepable can access elems without kptrs/spin_locks
> > even when not using rcu_read_lock, since it's safe, but there is uaf.
> > Some progs might be fine with it.
> > When sleepable needs to avoid uaf they will use bpf_rcu_read_lock.
> Thanks for the explanation for BPF_REUSE_AFTER_RCU_GP. It seems that
> BPF_REUSE_AFTER_RCU_GP may incur OOM easily, because before the expiration of
> one RCU GP, these freed elements will not available to both bpf ma or slab
> subsystem and after the expiration of RCU GP, these freed elements are only
> available for one bpf ma but the number of these freed elements maybe too many
> for one bpf ma, so part of these freed elements will be freed through
> call_rcu_tasks_trace() and these freed-again elements will not be available for
> slab subsystem untill the expiration of tasks trace RCU. In brief, after one RCU
> GP, part of these freed elements will be reused, but the majority of these
> elements will still be freed through call_rcu_tasks_trace(). Due to the doubt
> above, I proposed BPF_FREE_AFTER_RCU to directly free these elements after one
> RCU GP and enforce sleepable program to use bpf_rcu_read_lock() to access these
> elements, but the enforcement will break the existing sleepable programs, so
> BPF_FREE_AFTER_GP is still not a good idea. I will check whether or not these is
> still OOM risk for BPF_REUSE_AFTER_RCU_GP and try to mitigate if it is possible
> (e.g., share these freed elements between all bpf ma instead of one bpf ma which
> free it).

Since BPF_REUSE_AFTER_RCU_GP is a new thing that will be used
by qptrie map and maybe? local storage, there is no sleepable breakage.
If we start using BPF_REUSE_AFTER_RCU_GP for hashmaps with kptrs
and enforce bpf_rcu_read_lock() this is also ok, since kptrs are unstable.
I prefer to avoid complicating bpf ma with sharing free lists across all ma-s.
Unless this is really trivial code that is easy to review.
