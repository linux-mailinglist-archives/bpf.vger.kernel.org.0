Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7556759F7EC
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 12:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiHXKj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXKjZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 06:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7073679629
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661337563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3xYfW0v9uJkKzARGFEY8k9gHPAe+Br9uY2PeY9ESPQ=;
        b=BG/3/z+46Lo6NI0507I0yH1KZJE3kWc1RLzDRYHjFRdgc/W6opY0M9pzGqLmt6wK4bi031
        nV12oXXCMcsyRxH1oJllRobjk5HGNU0yUhwvx/Uevty4aP1xLAsgLsEcuAzxbz0mL3oUxn
        OE1C7JbjaM3/swj7IP3DpGFTILMUCqg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-LOT47Z6RMg-XZAJXUJo8aw-1; Wed, 24 Aug 2022 06:39:22 -0400
X-MC-Unique: LOT47Z6RMg-XZAJXUJo8aw-1
Received: by mail-ed1-f69.google.com with SMTP id h17-20020a05640250d100b00446d1825c9fso5093177edb.14
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 03:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=O3xYfW0v9uJkKzARGFEY8k9gHPAe+Br9uY2PeY9ESPQ=;
        b=yn79pjWV0trjLLDVvJ8JQDH67mHxbG+b/okqg/Bee3EB1+UutT1c13Q38hpX5Yz/VL
         H7dnayL5UgCCX+zDthfbTr47Rok6ViP+f0vXuPzofpUMSqJIGqPQtkDw7lUMW4Ja4u03
         5Rnz+p4FWNyJA9EyloerYOaI9RR1dPbCaTpadf3h+DJy6ydZFkpdwhbq4E2z/UBLZvbA
         z9VQ4UraU6oi7iMnfFJd59s5VscyeLkz64HZqR3nLewr9WNHq4BaWwwKLgANh74xn/Tc
         NiYypltAuicodC9W3C1HE/LTLi8Jk70KX9Q/HvFFyXXgHtwC0ni1BS9qhwj6Vizkp6Ux
         9dBA==
X-Gm-Message-State: ACgBeo2yWq28aBhD22XpxKDlKqdUlCd0XT2AysnWrtFKvKM15BbDjjPa
        X8K/vDDkZpKrU24zjnlqyIoLCVUJwZcb11Kt1ez6b+9bk9gKrliYSCG0EaLo4FDtRJbKVffkcWq
        7IIYe9YZmOOwE
X-Received: by 2002:a17:907:960f:b0:73d:5b08:68b9 with SMTP id gb15-20020a170907960f00b0073d5b0868b9mr2486520ejc.337.1661337561142;
        Wed, 24 Aug 2022 03:39:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4frG6Hu7UO0my/xwTI4Uji4WMDAPw7YPxEoZhKLbqOnHpY4ukOnnfrWUBRZ49+iEhrhZZ4Gw==
X-Received: by 2002:a17:907:960f:b0:73d:5b08:68b9 with SMTP id gb15-20020a170907960f00b0073d5b0868b9mr2486500ejc.337.1661337560723;
        Wed, 24 Aug 2022 03:39:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a170906604f00b0073c0b87ba34sm939345ejj.198.2022.08.24.03.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 03:39:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3443856052B; Wed, 24 Aug 2022 12:39:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannelkoong@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, kafai@fb.com, kuba@kernel.org,
        netdev@vger.kernel.org, "brouer@redhat.com" <brouer@redhat.com>,
        lorenzo@kernel.org
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Add xdp dynptrs
In-Reply-To: <CAJnrk1aq3gJgz0DKo47SS0J2wTtg1C_B3eVfsh-036nmDKKVWA@mail.gmail.com>
References: <20220822235649.2218031-1-joannelkoong@gmail.com>
 <20220822235649.2218031-3-joannelkoong@gmail.com>
 <CAP01T77h2+a9OonHuiPRFsAForWYJfQ71G6teqbcLg4KuGpK5A@mail.gmail.com>
 <CAJnrk1aq3gJgz0DKo47SS0J2wTtg1C_B3eVfsh-036nmDKKVWA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 24 Aug 2022 12:39:18 +0200
Message-ID: <878rnehqnd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannelkoong@gmail.com> writes:

> On Mon, Aug 22, 2022 at 7:31 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> +Cc XDP folks
>>
>> On Tue, 23 Aug 2022 at 02:12, Joanne Koong <joannelkoong@gmail.com> wrote:
>> >
>> > Add xdp dynptrs, which are dynptrs whose underlying pointer points
>> > to a xdp_buff. The dynptr acts on xdp data. xdp dynptrs have two main
>> > benefits. One is that they allow operations on sizes that are not
>> > statically known at compile-time (eg variable-sized accesses).
>> > Another is that parsing the packet data through dynptrs (instead of
>> > through direct access of xdp->data and xdp->data_end) can be more
>> > ergonomic and less brittle (eg does not need manual if checking for
>> > being within bounds of data_end).
>> >
>> > For reads and writes on the dynptr, this includes reading/writing
>> > from/to and across fragments. For data slices, direct access to
>>
>> It's a bit awkward to have such a difference between xdp and skb
>> dynptr's read/write. I understand why it is the way it is, but it
>> still doesn't feel right. I'm not sure if we can reconcile the
>> differences, but it makes writing common code for both xdp and tc
>> harder as it needs to be aware of the differences (and then the flags
>> for dynptr_write would differ too). So we're 90% there but not the
>> whole way...
>
> Yeah, it'd be great if the behavior for skb/xdp progs could be the
> same, but I'm not seeing a better solution here (unless we invalidate
> data slices on writes in xdp progs, just to make it match more :P).
>
> Regarding having 2 different interfaces bpf_dynptr_from_{skb/xdp}, I'm
> not convinced this is much of a problem - xdp and skb programs already
> have different interfaces for doing things (eg
> bpf_{skb/xdp}_{store/load}_bytes).

This is true, but it's quite possible to paper over these differences
and write BPF code that works for both TC and XDP. Subtle semantic
differences in otherwise identical functions makes this harder.

Today you can write a function like:

static inline int parse_pkt(void *data, void* data_end)
{
        /* parse data */
}

And call it like:

SEC("xdp")
int parse_xdp(struct xdp_md *ctx)
{
        return parse_pkt(ctx->data, ctx->data_end);
}

SEC("tc")
int parse_tc(struct __sk_buff *skb)
{
        return parse_pkt(skb->data, skb->data_end);
}


IMO the goal should be to be able to do the equivalent for dynptrs, like:

static inline int parse_pkt(struct bpf_dynptr *ptr)
{
        __u64 *data;
        
	data = bpf_dynptr_data(ptr, 0, sizeof(*data));
	if (!data)
		return 0;
        /* parse data */
}

SEC("xdp")
int parse_xdp(struct xdp_md *ctx)
{
	struct bpf_dynptr ptr;

	bpf_dynptr_from_xdp(ctx, 0, &ptr);
        return parse_pkt(&ptr);
}

SEC("tc")
int parse_tc(struct __sk_buff *skb)
{
	struct bpf_dynptr ptr;

	bpf_dynptr_from_skb(skb, 0, &ptr);
        return parse_pkt(&ptr);
}


If the dynptr-based parse_pkt() function has to take special care to
figure out where the dynptr comes from, it makes it a lot more difficult
to write reusable packet parsing functions. So I'd be in favour of
restricting the dynptr interface to the lowest common denominator of the
skb and xdp interfaces even if that makes things slightly more awkward
in the specialised cases...

-Toke

