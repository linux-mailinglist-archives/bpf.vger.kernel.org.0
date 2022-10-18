Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008F760363B
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 00:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJRWum (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 18:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJRWuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 18:50:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA947D1C3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 15:50:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a13so22733042edj.0
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HI1xKVSmTBali2o3A5fXx4j5E/61uAvFWBWCErw+O3o=;
        b=iMoHDiCMOex5Sm9N+pntn4bBP3CKqKlucSxdNbJfrbCSrMQW+0MMaP6muzHvEC9WQa
         +yDfkczq4iR8m4MGbfY1HexdG7vm3QYhc3lTUuyLizsfm+olKxC/tIjz720eXKWZ6S7Q
         QYVbWBT/wwH+Tc/YlG8PUHgOJTMtwSr/Nq7nuYnbAsZjqERpiSlWsb6ScDwRZh3ejz55
         UeRE50TzkXuK1nLpQZRDMxdvImRfWctKbiyqSOC7Dj5QILrOQiJ5GpmkqPAOdwTqiY+l
         RNQ5KsYO4BHtH3xRUHWEjrD6DZK7DKhqWmg99dNMtroZmyd7FMM2yWQyKdUwTzoS+wSF
         eAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HI1xKVSmTBali2o3A5fXx4j5E/61uAvFWBWCErw+O3o=;
        b=ZlvnK1tAbhuZdcwwU6/U7XsJ+subovs6VMg2SQlHcArdTb5HBFWePFWsIZ3ZPhdSPz
         ptNVOuL+3CSIAhUR50W1WSvslxh+fiF2oGOIXIW/gsGfU0DijQDl9PkUPbJ/z4HE1VoA
         zjWYD8PThDOQd5Fc3w01KgQoZO7xTLIqW+YMB9w0ozo8x6DMBJZE7E0OXI2JJw0GZxxG
         TO5PHGDA/0qa5/vvobMx7MEYjKwcL7uozMksNHKDpDNkRjFXrw2iA6cG8+EY2ZCcowB7
         tKKRE6RxocJYRK7VUSm56lXA0ZQWvbnEG3YI3XnhKeaXfkW4S7IQ9b8x3OUFTWRv8cXd
         /dIg==
X-Gm-Message-State: ACrzQf31/x19vnrrBz4CLkqOZJO93m98XjTXZS4SSkIN+V7uq6TeuIWN
        dCbgE0stH/8n64jqVT6ArBX1VcTHRspS1lwzNAA=
X-Google-Smtp-Source: AMsMyM6qOTCmdU4iVdjjTocmnI+86xESgLvR9ENeNh2aF5FDEk3P1c4GDXa7xvyregaj+61msZNZpK1X9qHtXvIazDs=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr4712634edb.333.1666133437150; Tue, 18
 Oct 2022 15:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220924133620.4147153-4-houtao@huaweicloud.com> <CAEf4Bza79XbtYF_04MhdcN0o4Akot0VpWaR+mOoGwXsz7yT=xg@mail.gmail.com>
 <e099e816-d271-ec75-b6aa-3671cfc5b8f9@huaweicloud.com> <CAEf4BzZyfUOfGkQP67urmG9=7pqUF-5E9LjZf-Y0sL9nbcHFww@mail.gmail.com>
 <670cee24-8667-31c9-fe91-368b683d586e@huaweicloud.com> <CAEf4BzZY5=nGF6HfcKeaZ39bK6dYxJm03zqAzBzzs28MRszVdw@mail.gmail.com>
 <13e2f2f0-1610-4c21-5478-3a3413ef88be@huaweicloud.com>
In-Reply-To: <13e2f2f0-1610-4c21-5478-3a3413ef88be@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Oct 2022 15:50:24 -0700
Message-ID: <CAEf4BzavD_kYwettwNsZBAz6=NPR67_gvdxDA9kaMwrXSkcnmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Support bpf_dynptr-typed map key
 in bpf syscall
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
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

On Thu, Oct 13, 2022 at 9:02 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 10/14/2022 2:04 AM, Andrii Nakryiko wrote:
> > On Fri, Oct 7, 2022 at 7:40 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >> Hi,
> >>
> >> On 10/1/2022 5:35 AM, Andrii Nakryiko wrote:
> >>> On Wed, Sep 28, 2022 at 7:11 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >> SNP
> >>>>> I'm trying to understand why there should be so many new concepts and
> >>>>> interfaces just to allow variable-sized keys. Can you elaborate on
> >>>>> that? Like why do we even need BPF_DYNPTR_TYPE_USER? Why user can't
> >>>>> just pass a void * (casted to u64) pointer and size of the memory
> >>>>> pointed to it, and kernel will just copy necessary amount of data into
> >>>>> kvmalloc'ed temporary region?
> >>>> The main reason is that map operations from syscall and bpf program use the same
> >>>> ops in bpf_map_ops (e.g. map_update_elem). If only use dynptr_kern for bpf
> >>>> program, then
> >>>> have to define three new operations for bpf program. Even more, after defining
> >>>> two different map ops for the same operation from syscall and bpf program, the
> >>>> internal  implementation of qp-trie still need to convert these two different
> >>>> representations of variable-length key into bpf_qp_trie_key. It introduces
> >>>> unnecessary conversion, so I think it may be a good idea to pass dynptr_kern to
> >>>> qp-trie even for bpf syscall.
> >>>>
> >>>> And now in bpf_attr, for BPF_MAP_*_ELEM command, there is no space to pass an
> >>>> extra key size. It seems bpf_attr can be extend, but even it is extented, it
> >>>> also means in libbpf we need to provide a new API group to support operationg on
> >>>> dynptr key map, because the userspace needs to pass the key size as a new argument.
> >>> You are right that the current assumption of implicit key/value size
> >>> doesn't work for these variable-key/value-length maps. But I think the
> >>> right answer is actually to make sure that we have a map_update_elem
> >>> callback variant that accepts key/value size explicitly. I still think
> >>> that the syscall interface shouldn't introduce a concept of dynptr.
> >>> >From user-space's point of view dynptr is just a memory pointer +
> >>> associated memory size. Let's keep it simple. And yes, it will be a
> >>> new libbpf API for bpf_map_lookup_elem/bpf_map_update_elem. That's
> >>> fine.
> >> Is your point that dynptr is too complicated for user-space and may lead to
> >> confusion between dynptr in kernel space ? How about a different name or a
> > No, dynptr is just an unnecessary concept for user-space, because
> > fundamentally it's just a memory region, which in UAPI is represented
> > by a pointer + size. So why inventing new concepts when existing ones
> > are covering it?
> But the problem is pointer + explicit size is not being covered by any existing
> APIs and we need to add support for it. Using dnyptr is one option and directly
> using pointer + explicit size is another one.

dynptr is more than pointer + size (it supports various types of
memory it points to, it supports offset, etc), it's more generic thing
for BPF-side programmability. There is no need to expose it into
user-space. All we care about here is memory region, which is pointer
+ size. Keep it simple.

> >
> >> simple definition just like bpf_lpm_trie_key ? It will make both the
> >> implementation and the usage much simpler, because the implementation and the
> >> user can still use the same APIs just like fixed sized map.
> >>
> >> Not just lookup/update/delete, we also need to define a new op for
> >> get_next_key/lookup_and_delete_elem. And also need to define corresponding new
> >> bpf helpers for bpf program. And you said "explict key/value size", do you mean
> >> something below ?
> >>
> >> int (*map_update_elem)(struct bpf_map *map, void *key, u32 key_size, void
> >> *value, u32 value_size, u64 flags);
> > Yes, something like that. The problem is that up until now we assume
> > that key_size is fixed and can be derived from map definition. We are
> > trying to change that, so there needs to be a change in internal APIs.
> Will need to change both the UAPIs and internal APIs. Should I add variable-size
> map value into consideration this time ? I am afraid that it may be little
> over-designed. Maybe I should hack a demo out firstly to check the work-load and
> the complexity.

I think sticking to fixed-size key/value for starters is ok, there is
plenty things to figure out even without that. We can try attacking
variable-sized key BPF maps (e.g., technically BPF hashmap might also
support variable-sized key or value just as well) as a separate
project.


> >
> >>>
> >>>>> It also seems like you want to allow key (and maybe value as well, not
> >>>>> sure) to be a custom user-defined type where some of the fields are
> >>>>> struct bpf_dynptr. I think it's a big overcomplication, tbh. I'd say
> >>>>> it's enough to just say that entire key has to be described by a
> >>>>> single bpf_dynptr. Then we can have bpf_map_lookup_elem_dynptr(map,
> >>>>> key_dynptr, flags) new helper to provide variable-sized key for
> >>>>> lookup.
> >>>> For qp-trie, it will only support a single dynptr as the map key. In the future
> >>>> maybe other map will support map key with embedded dynptrs. Maybe Joanne can
> >>>> share some vision about such use case.
> >>> My point was that instead of saying that key is some fixed-size struct
> >>> in which one of the fields is dynptr (and then when comparing you have
> >>> to compare part of struct, then dynptr contents, then the other part
> >>> of struct?), just say that entire key is represented by dynptr,
> >>> implicitly (it's just a blob of bytes). That seems more
> >>> straightforward.
> >> I see. But I still think there is possible user case for struct with embedded
> >> dynptr. For bpf map in kernel, byte blob is OK. But If it is also a blob of
> >> bytes for the bpf program or userspace application, the application may need to
> >> marshaling and un-marshaling between the bytes blob and a meaningful struct type
> >> each time before using it.
> >>> .
> > I'm not sure what you mean by "blob of bytes for userspace
> > application"? You mean a pointer pointing to some process' memory (not
> > a kernel memory)? How is that going to work if BPF program can run and
> > access such blob in any context, not just in the context of original
> > user-space app that set this value?
> >
> > If you mean that blob needs to be interpreted as some sort of struct,
> > then yes, it's easy, we have bpf_dynptr_data() and `void *` -> `struct
> > my_custom_struct` casting in C.
> Yes. I mean we need to cast the blob to a meaning struct before using it. If
> there are one variable-length field in the struct, how would the directly
> castling work as shown below ?
>
> struct my_custom_struct {
>            struct {
>                unsigned int len;
>                char *data;
>            } name;
>            unsigned int pt_code;
> };

I'd imagine that you'd represent variable-sized part at the end of
fixed part as flexible array of bytes:

struct my_custom_struct {
    int pt_code;
    int len;
    char data[];
}

> >
> > Or did I miss your point?
>
