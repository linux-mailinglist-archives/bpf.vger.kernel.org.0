Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE136CAF6
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 20:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhD0SQc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 14:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhD0SQc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 27 Apr 2021 14:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619547348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBv0uUVPXgndSKwcI/R1EYyP8Vi9i5g8yF8CVU5/x80=;
        b=MVZanwX7Mn3GoLvFWFvIe4Expp0pLN7xFOw2xO/aHtZ9Cl0TE4ELu/d1FV4McO4WwG8LZ7
        edDoITzvoPP54gm1XFpJ/Z5fewfqH3AXLXxtba/GhKgvNKBNxlTODRirUQniWFj4RI+9lq
        vh8tHWnM2CfnXMAWFrFLFifW7Lb/2I4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-fdMypkMZPaWC-WpM32wHAg-1; Tue, 27 Apr 2021 14:15:46 -0400
X-MC-Unique: fdMypkMZPaWC-WpM32wHAg-1
Received: by mail-ej1-f69.google.com with SMTP id ne22-20020a1709077b96b02903803a047edeso10221043ejc.3
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 11:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tBv0uUVPXgndSKwcI/R1EYyP8Vi9i5g8yF8CVU5/x80=;
        b=GA51DJUa757KewKfEsvlwZwgLmZssN3/VvwxLi/wCfL3mmNNBBKK/uq4TF7cuDBw7c
         vPKfMl83+qUzOObSsTPczN59iORw4iegfjj0SdPPekjlx+Y9My7Z3wkNLZRG/UJ9unNw
         eARBC2yac9i5BmnYZwk1gVPG7vTXKHmFV2Fn5DOYFterhh9Gs1OF3vMfsCigf7nkUJPZ
         GAMp9VfSo1j3jY+T10L/sTbrun28/JQc7GZEHPCB6Vj6dzSM09jRFix8k8IsGCnrMi9O
         zqQ82bIxRbQ6Ye7LjGz5bUQnTPN6GpH5j7uBzLQSRgJXOVPrudUoTDlT+CLZ4maQeBwp
         kC2Q==
X-Gm-Message-State: AOAM530os8ZKQXQGLntuuIROfzEAyb9G5xwUOyw+mq84bVEfrrbVyR2Z
        q7jv4SKET0GN5SekStTgdydCMcWr0Gsu91sw6oqpUZkL0bCsoORUD3g0u62aVQbBJVaW5MtVMMJ
        +jwvVAB7dJ3He
X-Received: by 2002:a17:906:6b89:: with SMTP id l9mr24220367ejr.249.1619547345087;
        Tue, 27 Apr 2021 11:15:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn9fTqS18DCoCBMGZsR0vbk8EoFLp4CL4/Yk8hpfKhrBVt3NA+6igTuf6REozJLYJCOdMpkA==
X-Received: by 2002:a17:906:6b89:: with SMTP id l9mr24220340ejr.249.1619547344857;
        Tue, 27 Apr 2021 11:15:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z14sm2915754edc.62.2021.04.27.11.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 11:15:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 82ED4180615; Tue, 27 Apr 2021 20:15:43 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/3] libbpf: add low level TC-BPF API
In-Reply-To: <20210427180202.pepa2wdbhhap3vyg@apollo>
References: <20210423150600.498490-1-memxor@gmail.com>
 <20210423150600.498490-3-memxor@gmail.com>
 <5811eb10-bc93-0b81-2ee4-10490388f238@iogearbox.net>
 <20210427180202.pepa2wdbhhap3vyg@apollo>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 27 Apr 2021 20:15:43 +0200
Message-ID: <87fszba90w.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Tue, Apr 27, 2021 at 08:34:30PM IST, Daniel Borkmann wrote:
>> On 4/23/21 5:05 PM, Kumar Kartikeya Dwivedi wrote:
>> [...]
>> >   tools/lib/bpf/libbpf.h   |  92 ++++++++
>> >   tools/lib/bpf/libbpf.map |   5 +
>> >   tools/lib/bpf/netlink.c  | 478 ++++++++++++++++++++++++++++++++++++++-
>> >   3 files changed, 574 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> > index bec4e6a6e31d..1c717c07b66e 100644
>> > --- a/tools/lib/bpf/libbpf.h
>> > +++ b/tools/lib/bpf/libbpf.h
>> > @@ -775,6 +775,98 @@ LIBBPF_API int bpf_linker__add_file(struct bpf_linker *linker, const char *filen
>> >   LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
>> >   LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
>> >
>> > +enum bpf_tc_attach_point {
>> > +	BPF_TC_INGRESS,
>> > +	BPF_TC_EGRESS,
>> > +	BPF_TC_CUSTOM_PARENT,
>> > +	_BPF_TC_PARENT_MAX,
>>
>> I don't think we need to expose _BPF_TC_PARENT_MAX as part of the API, I would drop
>> the latter.
>>
>
> Ok, will drop.
>
>> > +};
>> > +
>> > +/* The opts structure is also used to return the created filters attributes
>> > + * (e.g. in case the user left them unset). Some of the options that were left
>> > + * out default to a reasonable value, documented below.
>> > + *
>> > + *	protocol - ETH_P_ALL
>> > + *	chain index - 0
>> > + *	class_id - 0 (can be set by bpf program using skb->tc_classid)
>> > + *	bpf_flags - TCA_BPF_FLAG_ACT_DIRECT (direct action mode)
>> > + *	bpf_flags_gen - 0
>> > + *
>> > + *	The user must fulfill documented requirements for each function.
>>
>> Not sure if this is overly relevant as part of the bpf_tc_opts in here. For the
>> 2nd part, I would probably just mention that libbpf internally attaches the bpf
>> programs with direct action mode. The hw offload may be future todo, and the other
>> bits are little used anyway; mentioning them here, what value does it have to
>> libbpf users? I'd rather just drop the 2nd part and/or simplify this paragraph
>> just stating that the progs are attached in direct action mode.
>>
>
> The goal was to just document whatever attributes were set to by default, but I can see
> your point. I'll trim it.
>
>> > + */
>> > +struct bpf_tc_opts {
>> > +	size_t sz;
>> > +	__u32 handle;
>> > +	__u32 parent;
>> > +	__u16 priority;
>> > +	__u32 prog_id;
>> > +	bool replace;
>> > +	size_t :0;
>> > +};
>> > +
>> > +#define bpf_tc_opts__last_field replace
>> > +
>> > +struct bpf_tc_ctx;
>> > +
>> > +struct bpf_tc_ctx_opts {
>> > +	size_t sz;
>> > +};
>> > +
>> > +#define bpf_tc_ctx_opts__last_field sz
>> > +
>> > +/* Requirements */
>> > +/*
>> > + * @ifindex: Must be > 0.
>> > + * @parent: Must be one of the enum constants < _BPF_TC_PARENT_MAX
>> > + * @opts: Can be NULL, currently no options are supported.
>> > + */
>>
>> Up to Andrii, but we don't have such API doc in general inside libbpf.h, I
>> would drop it for the time being to be consistent with the rest (same for
>> others below).
>>
>
> I think we need to keep this somewhere. We dropped bpf_tc_info since it wasn't
> really serving any purpose, but that meant we would put the only extra thing it
> returned (prog_id) into bpf_tc_opts. That means we also need to take care that
> it is unset (along with replace) in functions where it isn't used, to allow for
> reuse for some future purpose. If we don't document that the user needs to unset
> them whenever working with bpf_tc_query and bpf_tc_detach, how are they supposed
> to know?
>
> Maybe a man page and/or a blog post would be better? Just putting it above the
> function seemed best for now.

You could document it together with the struct definition instead of for
each function? See the inline comments in bpf_object_open_opts for instance...

-Toke

