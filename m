Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC1C5752A5
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 18:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGNQVN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiGNQVM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 12:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A579E624B2
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657815670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZrd88vA65IAM29+EyEva7WRDVagjfNyLnQBYjfHAAc=;
        b=QiQhWBv0s9Ivuv4l0xCUzIAoVyI0IHepIeFDpnO6Si8O2Uar8gKpyFOiOpfpUBFJ5VRLGu
        cYyVFUHZ8M3nsZoeizAHrcIPhUiIpYBZSZFySmP3A7VhRvoPzd28Rs5iRSy6PGQHAXAopM
        y32psQI3E9/IrhN9cL/kruTIs//x1uc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-hAr0_8UwNjGOctkr79smbA-1; Thu, 14 Jul 2022 12:21:03 -0400
X-MC-Unique: hAr0_8UwNjGOctkr79smbA-1
Received: by mail-ed1-f72.google.com with SMTP id w13-20020a05640234cd00b0043a991fb3f3so1798974edc.3
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 09:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mZrd88vA65IAM29+EyEva7WRDVagjfNyLnQBYjfHAAc=;
        b=IszGid+TOLB2EdsaxbU1rynjgevv9PWJTUJecK74C7je5rNoy0F/FTgL8+hB4fYUpd
         IETyNg1pVoaZ7rcfDtrbAU9DDUn6L+tYxXO1dSYeHnAPvTzcsYyYPuMT8pQfqfFRWuyw
         CeuxVBRCfTs6Jc4Zh7OMr0z6bIzKfF2vG+5S9cPaBtnLSqEn+ykWVnXFyCfqvq/YJSoY
         jot0Cdnz79gEgsfo888P4cjPtzYSAy6mpIO0aP0HvSR96BITYqysM6ysRwItVTM0ghBR
         aC3UuokoSEljAV7ELSNAtdWwCCqP2B0L5Zdy21YCTNv17rzrCKMSyrMBQuUsVWZ+vVl3
         p9uQ==
X-Gm-Message-State: AJIora8OuL+omWtCipsNQ+4wHUMkNCkm7Zmxy6SKuYXC3KZKBTilyyY0
        NWu5DMGS/LqE+7MTVtj/Go97LF7C18jeGzg2Tqv2EaRIYrrYx8kl8Un/TqDASwHx9B84e71AIeA
        Cu6oB2UiOLfWM
X-Received: by 2002:a17:907:1b03:b0:6ff:78d4:c140 with SMTP id mp3-20020a1709071b0300b006ff78d4c140mr9798181ejc.554.1657815662179;
        Thu, 14 Jul 2022 09:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1suZy3eyfgIgGnufIGbSJyZzwXtSM3/fp0F8BczXQFtHwmk/uLXmanS3Tc6S/xx69LkMl3j5w==
X-Received: by 2002:a17:907:1b03:b0:6ff:78d4:c140 with SMTP id mp3-20020a1709071b0300b006ff78d4c140mr9798146ejc.554.1657815661832;
        Thu, 14 Jul 2022 09:21:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0043a4a5813d8sm1283249edb.2.2022.07.14.09.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:21:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A6A9D4D9B7C; Thu, 14 Jul 2022 18:21:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Freysteinn Alfredsson <freysteinn.alfredsson@kau.se>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [RFC PATCH 00/17] xdp: Add packet queueing and scheduling
 capabilities
In-Reply-To: <CAM0EoM=Pz_EWHsWzVZkZfojoRyUgLPVhGRHq6aGVhdcLC2YvHw@mail.gmail.com>
References: <20220713111430.134810-1-toke@redhat.com>
 <CAM0EoM=Pz_EWHsWzVZkZfojoRyUgLPVhGRHq6aGVhdcLC2YvHw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 14 Jul 2022 18:21:00 +0200
Message-ID: <87sfn3oec3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> I think what would be really interesting is to see the performance numbers when
> you have multiple producers/consumers(translation multiple
> threads/softirqs) in play
> targeting the same queues. Does PIFO alleviate the synchronization challenge
> when you have multiple concurrent readers/writers? Or maybe for your use case
> this would not be a common occurrence or not something you care about?

Right, this is definitely one of the areas we want to flesh out some
more and benchmark. I think a PIFO-based algorithm *can* be an
improvement here because you can compute the priority without holding
any lock and only grab a lock for inserting the packet; which can be
made even better with a (partially) lockless data structure and/or
batching.

In any case we *have* to do a certain amount of re-inventing for XDP
because we can't reuse the qdisc infrastructure anyway. Ultimately, I
expect it will be possible to write both really well-performing
algorithms, and really badly-performing ones. Such is the power of BPF,
after all, and as long as we can provide an existence proof of the
former, that's fine with me :)

> As I mentioned previously, I think this is what Cong's approach gets
> for free.

Yes, but it also retains the global qdisc lock; my (naive, perhaps?)
hope is that since we have to do things differently in XDP land anyway,
that work can translate into something that is amenable to being
lockless in qdisc land as well...

-Toke

