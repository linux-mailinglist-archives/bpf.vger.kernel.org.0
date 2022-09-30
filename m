Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2FE5F14F9
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 23:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiI3Vfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 17:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiI3Vfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 17:35:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B832EDE87
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:35:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a26so11611101ejc.4
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5Sqv6EdI/vgyCRiuxK0EfM8HHlkLDfH+XVet6vcUcY=;
        b=FbxnFDm/sWLpTfwrj+voG+soaWNQFyiSw2r2680ilwP4Y27Wlz8Wl7TqxgQ+whF0bS
         HcQQF7GIz5Kuu/ARz9ognF70obzp0lZLGkEfKBoN6dKnNvfgKeqt4pLyW8B8HKwHj6k8
         S1JsRR/aCycyXBwVAFTxrsCUKf70SC3PT3WsF59GeUo4ISJWUQaloAQz7UPUlxZwn9PM
         bYyXEHV7PT/zXLlxItdd85CVZP7NGQMi283yMxMwwz7NyK/H+VaUjEOa9qucB1pJCJzs
         ML/X171r+WUjLdKfSGPlS8nWJuwKqQpVxJihdauL+RNWKEfEBy/Sw46632kFsLY0RLM8
         b48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5Sqv6EdI/vgyCRiuxK0EfM8HHlkLDfH+XVet6vcUcY=;
        b=DF2ziK7OpPZktOWkl9fkeolsxyJ9sGxpV/o54cNVJhwOpNSKHRj0bfDKL43tinQmrX
         9pGAVaAnshcz+NsKNmMIRTezJkf/McLBndbri9a/nkLY8wFQvzb8hwo4i3NzXtOILnYv
         1NtlPcx0ir9LVUE1gIP2HKWyikRYPPuyh4er9YBNS3VXenwiiO/UwW3gTc209qpAIpt1
         GUTWG6RKKPGO6/s6JHxzJcs2En7Dv9mFeBLqyiapK/otlag+XV0ZAHkdzGE0+QXwrhTP
         XAEIy7FuWd6kK002lVKHci1pOaMN1bFl/RguVbZvoCS1B5pNw7WOSqj5RRlRXOwfIH6f
         mUuQ==
X-Gm-Message-State: ACrzQf1yV+lToD1DXq5thCpkRsvKnwYl8ABiwutrf8y74Elg6s2hwV0S
        i9MwPz6zMachUbxqx8v5yOSIqr6uKiM6y0Z3hDEwSwmxZuo=
X-Google-Smtp-Source: AMsMyM5chPxIy6NyUQyWs/Exkwbw6f822mWgw+zYIBupmhYR/LE71uF18+yhYVtbDTpbG1a7tlBe9JXGj4pUz2+WjBo=
X-Received: by 2002:a17:906:8454:b0:772:7b02:70b5 with SMTP id
 e20-20020a170906845400b007727b0270b5mr7749761ejy.114.1664573744861; Fri, 30
 Sep 2022 14:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220924133620.4147153-4-houtao@huaweicloud.com> <CAEf4Bza79XbtYF_04MhdcN0o4Akot0VpWaR+mOoGwXsz7yT=xg@mail.gmail.com>
 <e099e816-d271-ec75-b6aa-3671cfc5b8f9@huaweicloud.com>
In-Reply-To: <e099e816-d271-ec75-b6aa-3671cfc5b8f9@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 14:35:33 -0700
Message-ID: <CAEf4BzZyfUOfGkQP67urmG9=7pqUF-5E9LjZf-Y0sL9nbcHFww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Support bpf_dynptr-typed map key
 in bpf syscall
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com,
        Joanne Koong <joannelkoong@gmail.com>
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

On Wed, Sep 28, 2022 at 7:11 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 9/29/2022 8:16 AM, Andrii Nakryiko wrote:
> > On Sat, Sep 24, 2022 at 6:18 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Userspace application uses bpf syscall to lookup or update bpf map. It
> >> passes a pointer of fixed-size buffer to kernel to represent the map
> >> key. To support map with variable-length key, introduce bpf_dynptr_user
> >> to allow userspace to pass a pointer of bpf_dynptr_user to specify the
> >> address and the length of key buffer. And in order to represent dynptr
> >> from userspace, adding a new dynptr type: BPF_DYNPTR_TYPE_USER. Because
> >> BPF_DYNPTR_TYPE_USER-typed dynptr is not available from bpf program, so
> >> no verifier update is needed.
> >>
> >> Add dynptr_key_off in bpf_map to distinguish map with fixed-size key
> >> from map with variable-length. dynptr_key_off is less than zero for
> >> fixed-size key and can only be zero for dynptr key.
> >>
> >> For dynptr-key map, key btf type is bpf_dynptr and key size is 16, so
> >> use the lower 32-bits of map_extra to specify the maximum size of dynptr
> >> key.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> > This is a great feature and you've put lots of high-quality work into
> > this! Looking forward to have qp-trie BPF map available. Apart from
> > your discussion with Alexie about locking and memory
> > allocation/reused, I have questions about this dynptr from user-space
> > interface. Let's discuss it in this patch to not interfere.
> >
> > I'm trying to understand why there should be so many new concepts and
> > interfaces just to allow variable-sized keys. Can you elaborate on
> > that? Like why do we even need BPF_DYNPTR_TYPE_USER? Why user can't
> > just pass a void * (casted to u64) pointer and size of the memory
> > pointed to it, and kernel will just copy necessary amount of data into
> > kvmalloc'ed temporary region?
> The main reason is that map operations from syscall and bpf program use the same
> ops in bpf_map_ops (e.g. map_update_elem). If only use dynptr_kern for bpf
> program, then
> have to define three new operations for bpf program. Even more, after defining
> two different map ops for the same operation from syscall and bpf program, the
> internal  implementation of qp-trie still need to convert these two different
> representations of variable-length key into bpf_qp_trie_key. It introduces
> unnecessary conversion, so I think it may be a good idea to pass dynptr_kern to
> qp-trie even for bpf syscall.
>
> And now in bpf_attr, for BPF_MAP_*_ELEM command, there is no space to pass an
> extra key size. It seems bpf_attr can be extend, but even it is extented, it
> also means in libbpf we need to provide a new API group to support operationg on
> dynptr key map, because the userspace needs to pass the key size as a new argument.


You are right that the current assumption of implicit key/value size
doesn't work for these variable-key/value-length maps. But I think the
right answer is actually to make sure that we have a map_update_elem
callback variant that accepts key/value size explicitly. I still think
that the syscall interface shouldn't introduce a concept of dynptr.
From user-space's point of view dynptr is just a memory pointer +
associated memory size. Let's keep it simple. And yes, it will be a
new libbpf API for bpf_map_lookup_elem/bpf_map_update_elem. That's
fine.


> >
> > It also seems like you want to allow key (and maybe value as well, not
> > sure) to be a custom user-defined type where some of the fields are
> > struct bpf_dynptr. I think it's a big overcomplication, tbh. I'd say
> > it's enough to just say that entire key has to be described by a
> > single bpf_dynptr. Then we can have bpf_map_lookup_elem_dynptr(map,
> > key_dynptr, flags) new helper to provide variable-sized key for
> > lookup.
> For qp-trie, it will only support a single dynptr as the map key. In the future
> maybe other map will support map key with embedded dynptrs. Maybe Joanne can
> share some vision about such use case.

My point was that instead of saying that key is some fixed-size struct
in which one of the fields is dynptr (and then when comparing you have
to compare part of struct, then dynptr contents, then the other part
of struct?), just say that entire key is represented by dynptr,
implicitly (it's just a blob of bytes). That seems more
straightforward.

> >
> > I think it would keep it much simpler. But if I'm missing something,
> > it would be good to understand that. Thanks!
> >
> >
> >>  include/linux/bpf.h            |   8 +++
> >>  include/uapi/linux/bpf.h       |   6 ++
> >>  kernel/bpf/map_in_map.c        |   3 +
> >>  kernel/bpf/syscall.c           | 121 +++++++++++++++++++++++++++------
> >>  tools/include/uapi/linux/bpf.h |   6 ++
> >>  5 files changed, 125 insertions(+), 19 deletions(-)
> >>
> > [...]
> > .
>
