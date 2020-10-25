Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFB29823A
	for <lists+bpf@lfdr.de>; Sun, 25 Oct 2020 16:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416349AbgJYPLl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Oct 2020 11:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1416348AbgJYPLl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Oct 2020 11:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603638700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjAU9qPIyYAXQtfYKBmqHhafGMsTvRy2mqC57zg4U8Q=;
        b=IGNZA5HuzvDUhggcvjwul2yHvYUuZL3abH5+jKry1cL3Bci1WRFFjbhO88PjJTavU1jhgF
        CJw3sUW9hAQg0IG5FVBaKiWsY8uFsqh69lkrVbKfq4AJgcrRoCJKil+ZUP/yHhAb1H4HF+
        y8w3XJSDRgBOL8g7Hsdl4hjw0IOih3Q=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-BM_XNyTgP0u0ye54vp_3Ig-1; Sun, 25 Oct 2020 11:11:38 -0400
X-MC-Unique: BM_XNyTgP0u0ye54vp_3Ig-1
Received: by mail-io1-f69.google.com with SMTP id j21so4283691iog.8
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2020 08:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GjAU9qPIyYAXQtfYKBmqHhafGMsTvRy2mqC57zg4U8Q=;
        b=BjCl2UYFrpyvX0F9m3LQft4CUcLlaAht2Fmgj3pafjk2n4a0z8ui1M2uJL8GK4zo2J
         onYqi1ziTtev/cA1HmyRg2Twzvt86L0Yp8THfhgh5Z7WfViBsLVJTQMi20GKbhFQuBwt
         Zcd+6uOA0uS68S1nhhdNZA59vnjzG1Ye4FVXu2fD/JuZ5VCrD9MSvxi9Z2DFN9R0tFuU
         tQc6QKLob9M2vHIPwiDvP2S94RhxBK+bZ9E0Y6NTqnM+yORS6Z87x0Uy6NIqeiT1UMRP
         tyOq9aE32cAAK1psniE2J3xvJa0JL5xDrB0H9IbyK/53HZVPVONdzrrTgQY6gLhfbs11
         i6Lw==
X-Gm-Message-State: AOAM530yfqzYht3nyAhwNKZwPbyvPU9uqJjn5IQtqwJdBZ7n8NyxwkzO
        gGG/iepoHSTfAQhnTG9q8YCinU1KnJcNH+KALdmY4S2P4KklvXu7UFrCosJ4cYdpchUNuLg0rc/
        Yy3d4902fXhhO
X-Received: by 2002:a02:7125:: with SMTP id n37mr7803712jac.1.1603638697337;
        Sun, 25 Oct 2020 08:11:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZQppTCVUrmWYy+lTKo8RVWnHiTfwGP5iGP+ck/aS23c6NW7HBosSsEjsXi9UbAJiL3bdzMg==
X-Received: by 2002:a02:7125:: with SMTP id n37mr7803703jac.1.1603638696975;
        Sun, 25 Oct 2020 08:11:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h6sm1239813ils.14.2020.10.25.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 08:11:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5DF3F181CEC; Sun, 25 Oct 2020 16:11:32 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Hangbin Liu <haliu@redhat.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH iproute2-next 3/5] lib: add libbpf support
In-Reply-To: <CAEf4BzbPW8itEQjR=DsjJbtoUFWjiC1WC7F=9x_u4ddSAkZPhg@mail.gmail.com>
References: <20201023033855.3894509-1-haliu@redhat.com>
 <20201023033855.3894509-4-haliu@redhat.com>
 <CAEf4BzbPW8itEQjR=DsjJbtoUFWjiC1WC7F=9x_u4ddSAkZPhg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 25 Oct 2020 16:11:32 +0100
Message-ID: <87h7qi5oij.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Oct 22, 2020 at 8:39 PM Hangbin Liu <haliu@redhat.com> wrote:
>>
>> This patch converts iproute2 to use libbpf for loading and attaching
>> BPF programs when it is available, which is started by Toke's
>> implementation[1]. With libbpf iproute2 could correctly process BTF
>> information and support the new-style BTF-defined maps, while keeping
>> compatibility with the old internal map definition syntax.
>>
>> The old iproute2 bpf code is kept and will be used if no suitable libbpf
>> is available. When using libbpf, wrapper code in bpf_legacy.c ensures that
>> iproute2 will still understand the old map definition format, including
>> populating map-in-map and tail call maps before load.
>>
>> In bpf_libbpf.c, we init iproute2 ctx and elf info first to check the
>> legacy bytes. When handling the legacy maps, for map-in-maps, we create
>> them manually and re-use the fd as they are associated with id/inner_id.
>> For pin maps, we only set the pin path and let libbp load to handle it.
>> For tail calls, we find it first and update the element after prog load.
>
> I never implemented tail call map initialization using the same
> approach as declarative map-in-map support in libbpf, because no one
> asked and/or showed a use case. But all the pieces are there, and if
> there's interest, we should probably support that in libbpf as well.

Yeah, that's what we figured; and since this series maintains
compatibility with the old map definition format for declarative
tail-calls, this doesn't have to hold up the conversion: iproute2 will
just magically gain this when/if it lands in libbpf :)

-Toke

