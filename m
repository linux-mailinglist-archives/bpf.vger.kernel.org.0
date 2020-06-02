Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAC61EB863
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBJXb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 05:23:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50632 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbgFBJXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 05:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591089808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gdq16SBT3jSfuabnZBfnKDriTex7irwhCGzVQG8zXcQ=;
        b=Yq4tI4Ht4NjdgluqGZ5dky/7LTRbE0xEwdS5JEfOfC7h8nc1KCsIC2Xe3CtYNSZ9PvwR/0
        FuqafrVVmpUgkfgbocn50FUinFrYgTr377+jSZAMxog3a/cfcIS4kz2Hm8wSDpOxV7Jsi1
        yEdbLTMWQr4Po1R1LakDzGwMnNftcCI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-qg3WsF9tNfKDNsSvWW2d6g-1; Tue, 02 Jun 2020 05:23:27 -0400
X-MC-Unique: qg3WsF9tNfKDNsSvWW2d6g-1
Received: by mail-ej1-f72.google.com with SMTP id s4so2088944eju.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2020 02:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Gdq16SBT3jSfuabnZBfnKDriTex7irwhCGzVQG8zXcQ=;
        b=J7+hA4MO6RoW3wFEgHE70XsaN2JNN9Fl3V7LENOs9XxVHAJURbv2cj6mOkpgKzzCT9
         3b0Vk8MCYfSDRQt+MRps+LcbMFjDW2Irqg1nLgc84rC2cSKxrP+9nUmPIB+3ShWf1mFl
         MnYC35C0jNqPxUcIruZ2kBQQYp97BALKvM52nA57vYplsM8dwm9/nBByeBjy4/ErE04J
         JNOtHBxVo3MQ2ztAF9T6vefZpZ/lZgZjr1dRAdPRgjwxEUFweWDr7TsUC4sdrVM1+t9Q
         XIzgPvVJLk8gcMG0VDETb8X9vT3I4BxZ2gRfDghHmWD9BAX/5XmAcRz6cZreCvZoBHB2
         q1Kg==
X-Gm-Message-State: AOAM531gwYEo4xScmv1a5qFMqmHBJ6mIe4REhvLw308jEem+AxSUM8v2
        66Me5JnLyRY9uoMyw9Ka3iVWWcv6ExK6c7t+JNfdX13X5EWa4zrbbIO0DLk+5V15oaWE0wOGT4O
        zn7KNY1HarN9A
X-Received: by 2002:a05:6402:1775:: with SMTP id da21mr26337664edb.271.1591089805862;
        Tue, 02 Jun 2020 02:23:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrBoUAKe6W6JEHkkkUjXBSHHMKtYBfGjrRIe/O0XcKh9qjDaO/6jwObsr942DyKFtxhFpZQA==
X-Received: by 2002:a05:6402:1775:: with SMTP id da21mr26337634edb.271.1591089805611;
        Tue, 02 Jun 2020 02:23:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d5sm1267656edu.5.2020.06.02.02.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 02:23:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7C6CC182797; Tue,  2 Jun 2020 11:23:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, brouer@redhat.com
Subject: Re: [PATCH bpf-next RFC 2/3] bpf: devmap dynamic map-value storage area based on BTF
In-Reply-To: <20200602105908.19254e0f@carbon>
References: <159076794319.1387573.8722376887638960093.stgit@firesoul> <159076798566.1387573.8417040652693679408.stgit@firesoul> <87tuzyzodv.fsf@toke.dk> <20200602105908.19254e0f@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 02 Jun 2020 11:23:24 +0200
Message-ID: <87a71lzur7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Fri, 29 May 2020 18:39:40 +0200
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>
>> Jesper Dangaard Brouer <brouer@redhat.com> writes:
>>=20
>> > The devmap map-value can be read from BPF-prog side, and could be used=
 for a
>> > storage area per device. This could e.g. contain info on headers that =
need
>> > to be added when packet egress this device.
>> >
>> > This patchset adds a dynamic storage member to struct bpf_devmap_val. =
More
>> > importantly the struct bpf_devmap_val is made dynamic via leveraging a=
nd
>> > requiring BTF for struct sizes above 4. The only mandatory struct memb=
er is
>> > 'ifindex' with a fixed offset of zero.
>> >
>> > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> > ---
>> >  kernel/bpf/devmap.c |  216 ++++++++++++++++++++++++++++++++++++++++++=
++-------
>> >  1 file changed, 185 insertions(+), 31 deletions(-)
>> >
>> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> > index 4ab67b2d8159..9cf2dadcc0fe 100644
> [...]
>> > @@ -60,13 +61,30 @@ struct xdp_dev_bulk_queue {
>> >  	unsigned int count;
>> >  };
>> >=20=20
>> > -/* DEVMAP values */
>> > +/* DEVMAP map-value layout.
>> > + *
>> > + * The struct data-layout of map-value is a configuration interface.
>> > + * BPF-prog side have read-only access to this memory.
>> > + *
>> > + * The layout might be different than below, because some struct memb=
ers are
>> > + * optional.  This is made dynamic by requiring userspace provides an=
 BTF
>> > + * description of the struct layout, when creating the BPF-map. Struc=
t names
>> > + * are important and part of API, as BTF use these names to identify =
members.
>> > + */
>> >  struct bpf_devmap_val {
>> > -	__u32 ifindex;   /* device index */
>> > +	__u32 ifindex;   /* device index - mandatory */
>> >  	union {
>> >  		int   fd;  /* prog fd on map write */
>> >  		__u32 id;  /* prog id on map read */
>> >  	} bpf_prog;
>> > +	struct {
>> > +		/* This 'storage' member is meant as a dynamically sized area,
>> > +		 * that BPF developer can redefine.  As other members are added
>> > +		 * overtime, this area can shrink, as size can be regained by
>> > +		 * not using members above. Add new members above this struct.
>> > +		 */
>> > +		unsigned char data[24];
>> > +	} storage;=20=20
>>=20
>> Why is this needed? Userspace already passes in the value_size, so why
>> can't the kernel just use the BTF to pick out the values it cares about
>> and let the rest be up to userspace?
>
> The kernel cannot just ignore unknown struct members, due to forward
> compatibility. An older kernel that sees a new struct member, cannot
> know what this struct member is used for.  Thus, later I'm rejecting
> map creation if I detect members kernel doesn't know about.
>
> This means, that I need to create a named area (e.g. named 'storage')
> that users can define their own layout within.
>
> This might be difficult to comprehend for other kernel developers,
> because usually we create forward compatibility via walking the binary
> struct and then assume that if an unknown area (in end-of-struct)
> contains zeros, then it means end-user isn't using that unknown feature.
> This doesn't work when the default value, as in this exact case, need
> to be minus-1 do describe "unused" as this is a file descriptor.
>
> Forward compatibility is different here.  If the end-user include the
> member in their BTF description, that means they intend to use it.
> Thus, kernel need to reject map-create if it sees unknown members.

Ah, right, of course. You could still allow such a "user-defined" member
to be any size userspace likes, though, couldn't you?

-Toke

