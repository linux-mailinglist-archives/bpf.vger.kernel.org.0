Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9DD24D231
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgHUKWy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgHUKWx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 06:22:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0EAC061386
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 03:22:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c8so655602lfh.9
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=5nytGNra5OD91xv+bDTLtlhTDCMjbsKBNY0iw1VfP4w=;
        b=egpmqULcE+bTLBbkGJklCmbTsdzrrFlWYR/6vpd6TVLnhQOPh4FdsIS3pKYyR3jCfM
         1fXjdlEA+Wq00jq07thEKpf6qEpBgpC4UozZZOev8XYlCVz1+TV0H3zKI4gQLjPm6l9k
         hl9bkCJyMpWVQF7Gdjvoj/rMXs3kS9mueCsmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=5nytGNra5OD91xv+bDTLtlhTDCMjbsKBNY0iw1VfP4w=;
        b=ceWUjEr2L7lLAaMChOg7cTa05RuJ+NV4sXwPzgDwrf/friDZ9jmEWtjfwd1Fg7ERA8
         KVd1jc27l1Dzn/flulgAbv0QsMwrlUInJbWGPZvRDCZMmqOM14D8rT5Z9CxRJTmL2BSE
         zkFk/urO09v3lLt5pfD/osQkbTD1MGJtJ69m7VkDqKJJ/WlRPaQNR4xBmEtirI8/BcCV
         sQd65lU3SYl4vAuPrZhQXLSQ0+ELqpIy1SO0XYeKjzLzJVxjrFn7Y3klUe0lifGEejr5
         kbEBmEBalNwPBI9lKjzZAFKRRxOZW124llz7wF8w6lzohznAHSjMs0srgBi4Sj0+cRPf
         ox/g==
X-Gm-Message-State: AOAM531ru4KODVDkjknsN6ENklc8SuYNPZFEmCnxaJq38Mdeg+7XnIFs
        Nmoffg7ImGJy8+I2njPJdD79mg==
X-Google-Smtp-Source: ABdhPJxVMjRPYlwXss0xDfjV3MPFKodafcbZ8jOsV3UL2xCeztiEixF5Z3CdKWRlW2kNOLFsTaC6uQ==
X-Received: by 2002:a05:6512:31c2:: with SMTP id j2mr1156217lfe.85.1598005368172;
        Fri, 21 Aug 2020 03:22:48 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id q29sm294512lfb.94.2020.08.21.03.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:22:47 -0700 (PDT)
References: <20200717103536.397595-1-jakub@cloudflare.com> <87lficrm2v.fsf@cloudflare.com> <CAADnVQKE6y9h2fwX6OS837v-Uf+aBXnT_JXiN_bbo2gitZQ3tA@mail.gmail.com> <87k0xtsj91.fsf@cloudflare.com> <CAADnVQ+MXozV0ZFNYmK5ehVzvktXDcrAq8Q1Z9COWnXcACOXWQ@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: BPF sk_lookup v5 - TCP SYN and UDP 0-len flood benchmarks
In-reply-to: <CAADnVQ+MXozV0ZFNYmK5ehVzvktXDcrAq8Q1Z9COWnXcACOXWQ@mail.gmail.com>
Date:   Fri, 21 Aug 2020 12:22:46 +0200
Message-ID: <87imdcs3gp.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 12:18 AM CEST, Alexei Starovoitov wrote:
> On Thu, Aug 20, 2020 at 3:29 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> On Tue, Aug 18, 2020 at 08:19 PM CEST, Alexei Starovoitov wrote:

[...]

>> > Long term we should probably stop doing *_kern style of ctx passing
>> > into bpf progs.
>> > We have BTF, CO-RE and freplace now. This old style of memset *_kern and manual
>> > ctx conversion has performance implications and annoying copy-paste of ctx
>> > conversion routines.
>> > For this particular case instead of introducing udp4_lookup_run_bpf()
>> > and copying registers into stack we could have used freplace of
>> > udp4_lib_lookup2.
>> > More verifier work needed, of course.
>> > My main point that existing approach "lets prep args for bpf prog to
>> > run" that is used
>> > pretty much in every bpf hook is no longer necessary.
>>
>> Andrii has also suggested leveraging BTF [0], but to expose the *_kern
>> struct directly to BPF prog instead of emitting ctx access instructions.
>>
>> What I'm curious about is if we get rid of prepping args and ctx
>> conversion, then how do we limit what memory BPF prog can access?
>>
>> Say, I'm passing a struct sock * to my BPF prog. If it's not a tracing
>> prog, then I don't want it to have access to everything that is
>> reachable from struct sock *. This is where this approach currently
>> breaks down for me.
>
> Why do you want to limit it?
> Time after time we keep extending structs in uapi/bpf.h because new
> use cases are coming up. Just let the prog access everything.

I guess I wasn't thinking big enough :-)
