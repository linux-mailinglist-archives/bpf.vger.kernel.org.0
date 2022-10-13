Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C85FE101
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 20:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJMSWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiJMSWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 14:22:07 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2DD162538
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 11:17:21 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id bp11so4073682wrb.9
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPEDY8hxCa7q+oLK7imeAg6G9deWfHugRnTg4jKW+Ns=;
        b=lxM9oAsALz6APU9qDQcD/j62A/cdUQCXoSYMeAfnCUgBSiyt5h2Yarrbi9CFaA1ue7
         S6mNXxWfq++h9P7hsvGKYJC5jkiGPxnXMmwN8HStJIjCwSK/bOzciaIUWhX0GT1Jheuc
         4Ht8xU/fJoPeOutRfZSonxjQRCNbSYoDf9+XYWEISV/aHvTqg+wvPMlzB6iLcbriccND
         KQqhAxTcmwyaBQmT8sXi+JSUMOMFlVYD66EzSLNwJENEY78MX/y329CSUpf9KUo1UPaA
         UTlvLp5wVkC/C9rg/KPvKMOPqy+LNkN/rCQEr6offw8aZT0owkbYfnrpPgKG8f+/iThw
         EQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPEDY8hxCa7q+oLK7imeAg6G9deWfHugRnTg4jKW+Ns=;
        b=zqpE415WDGTARVRCD1yKY0CJYTlumUofA7r6NfMAiWsepnyK6eJ0rRuLPLOqJSB+Ta
         /FESV/FI6YRT8l0kVXmPwRPCeEoz9JXNvLzauP3IYdwtg7+WCr3pBHhv2tvKygQROxib
         3/msar/q0KM17PDvvWM37ST0pPzK6x2gRmIvYyTRk9Gr6HqQML1AAu3N9lsbVtTMrtq6
         8KYKz9XZMAo9jTrWddUc+TZ6EYLCbuT8xvWIHOOm1skXxce6iDfxLiq16BPPT+8BsMQk
         xkAQGjVb0vbU1QFBEtSf9y41BI6xgebH60J16DWp6zDoabFXLv9irocIoKXO4yGwY5Dh
         Ac1g==
X-Gm-Message-State: ACrzQf337POWiJxtjO0semtEXAckoyzM0VT9AQQqHVKgLDImDco2Drmf
        TmL5r3Anc5pM847+/Yt96lVqRrMoH1ieOm6ojH3Nbq70
X-Google-Smtp-Source: AMsMyM4ok6KQARDdddNuv1X4DlR8Bm3UVFw4trM7mZoSF+E8PmhfM07Z6ZwSoYxh7hu8A3K7EkKu8nRUL2MfBfxqbx0=
X-Received: by 2002:a17:907:2cca:b0:78d:ec48:ac29 with SMTP id
 hg10-20020a1709072cca00b0078dec48ac29mr733717ejc.114.1665684310112; Thu, 13
 Oct 2022 11:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220924133620.4147153-4-houtao@huaweicloud.com> <CAEf4Bza79XbtYF_04MhdcN0o4Akot0VpWaR+mOoGwXsz7yT=xg@mail.gmail.com>
 <e099e816-d271-ec75-b6aa-3671cfc5b8f9@huaweicloud.com> <CAEf4BzZyfUOfGkQP67urmG9=7pqUF-5E9LjZf-Y0sL9nbcHFww@mail.gmail.com>
 <670cee24-8667-31c9-fe91-368b683d586e@huaweicloud.com>
In-Reply-To: <670cee24-8667-31c9-fe91-368b683d586e@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 Oct 2022 11:04:58 -0700
Message-ID: <CAEf4BzZY5=nGF6HfcKeaZ39bK6dYxJm03zqAzBzzs28MRszVdw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 7, 2022 at 7:40 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 10/1/2022 5:35 AM, Andrii Nakryiko wrote:
> > On Wed, Sep 28, 2022 at 7:11 PM Hou Tao <houtao@huaweicloud.com> wrote:
> SNP
> >>> I'm trying to understand why there should be so many new concepts and
> >>> interfaces just to allow variable-sized keys. Can you elaborate on
> >>> that? Like why do we even need BPF_DYNPTR_TYPE_USER? Why user can't
> >>> just pass a void * (casted to u64) pointer and size of the memory
> >>> pointed to it, and kernel will just copy necessary amount of data into
> >>> kvmalloc'ed temporary region?
> >> The main reason is that map operations from syscall and bpf program use the same
> >> ops in bpf_map_ops (e.g. map_update_elem). If only use dynptr_kern for bpf
> >> program, then
> >> have to define three new operations for bpf program. Even more, after defining
> >> two different map ops for the same operation from syscall and bpf program, the
> >> internal  implementation of qp-trie still need to convert these two different
> >> representations of variable-length key into bpf_qp_trie_key. It introduces
> >> unnecessary conversion, so I think it may be a good idea to pass dynptr_kern to
> >> qp-trie even for bpf syscall.
> >>
> >> And now in bpf_attr, for BPF_MAP_*_ELEM command, there is no space to pass an
> >> extra key size. It seems bpf_attr can be extend, but even it is extented, it
> >> also means in libbpf we need to provide a new API group to support operationg on
> >> dynptr key map, because the userspace needs to pass the key size as a new argument.
> > You are right that the current assumption of implicit key/value size
> > doesn't work for these variable-key/value-length maps. But I think the
> > right answer is actually to make sure that we have a map_update_elem
> > callback variant that accepts key/value size explicitly. I still think
> > that the syscall interface shouldn't introduce a concept of dynptr.
> > >From user-space's point of view dynptr is just a memory pointer +
> > associated memory size. Let's keep it simple. And yes, it will be a
> > new libbpf API for bpf_map_lookup_elem/bpf_map_update_elem. That's
> > fine.
> Is your point that dynptr is too complicated for user-space and may lead to
> confusion between dynptr in kernel space ? How about a different name or a

No, dynptr is just an unnecessary concept for user-space, because
fundamentally it's just a memory region, which in UAPI is represented
by a pointer + size. So why inventing new concepts when existing ones
are covering it?

> simple definition just like bpf_lpm_trie_key ? It will make both the
> implementation and the usage much simpler, because the implementation and the
> user can still use the same APIs just like fixed sized map.
>
> Not just lookup/update/delete, we also need to define a new op for
> get_next_key/lookup_and_delete_elem. And also need to define corresponding new
> bpf helpers for bpf program. And you said "explict key/value size", do you mean
> something below ?
>
> int (*map_update_elem)(struct bpf_map *map, void *key, u32 key_size, void
> *value, u32 value_size, u64 flags);

Yes, something like that. The problem is that up until now we assume
that key_size is fixed and can be derived from map definition. We are
trying to change that, so there needs to be a change in internal APIs.

>
> >
> >
> >>> It also seems like you want to allow key (and maybe value as well, not
> >>> sure) to be a custom user-defined type where some of the fields are
> >>> struct bpf_dynptr. I think it's a big overcomplication, tbh. I'd say
> >>> it's enough to just say that entire key has to be described by a
> >>> single bpf_dynptr. Then we can have bpf_map_lookup_elem_dynptr(map,
> >>> key_dynptr, flags) new helper to provide variable-sized key for
> >>> lookup.
> >> For qp-trie, it will only support a single dynptr as the map key. In the future
> >> maybe other map will support map key with embedded dynptrs. Maybe Joanne can
> >> share some vision about such use case.
> > My point was that instead of saying that key is some fixed-size struct
> > in which one of the fields is dynptr (and then when comparing you have
> > to compare part of struct, then dynptr contents, then the other part
> > of struct?), just say that entire key is represented by dynptr,
> > implicitly (it's just a blob of bytes). That seems more
> > straightforward.
> I see. But I still think there is possible user case for struct with embedded
> dynptr. For bpf map in kernel, byte blob is OK. But If it is also a blob of
> bytes for the bpf program or userspace application, the application may need to
> marshaling and un-marshaling between the bytes blob and a meaningful struct type
> each time before using it.
> > .
>

I'm not sure what you mean by "blob of bytes for userspace
application"? You mean a pointer pointing to some process' memory (not
a kernel memory)? How is that going to work if BPF program can run and
access such blob in any context, not just in the context of original
user-space app that set this value?

If you mean that blob needs to be interpreted as some sort of struct,
then yes, it's easy, we have bpf_dynptr_data() and `void *` -> `struct
my_custom_struct` casting in C.

Or did I miss your point?
