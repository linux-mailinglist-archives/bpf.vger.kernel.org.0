Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1285E278010
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 07:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgIYF4u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 01:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgIYF4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 01:56:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D06C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 22:56:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so1976314ejf.6
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 22:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PHvJCnf/e3w+kWddJhhNAUVQMYCOoytl80Q0gn/kXVM=;
        b=ShdjI09HEYlSizD4uVM0B2rxoJnN8U2bQb09Wy+Bt5b05y7VaybgV6048Ct9oMNFC0
         5ZuNRFl1xvZT54kcWZm6nV7++CSa/aNWkwsaYltPyAOfaCPz1p9rS80d1afmgWjIiLfk
         QByKHsiiFOXOgqaUReS6BxYLxrysJg3zJgNro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PHvJCnf/e3w+kWddJhhNAUVQMYCOoytl80Q0gn/kXVM=;
        b=F/NpRd6uwGEJtAbD6dA+DZcenefnyiNsWySjyeMs0P/c4NdNctgsBOMMzEXgGPB0Q8
         OHQDrB2DqCXxGMsb8DlZVg8P033a1W7jwtWljM0V2NORqL5hct/peEhS3czH6tgIHayu
         54HTbvfOfslUOBN3M8sUe7SkEpGPBiMzD0BmJswgeAIvY89imNM5y+SN8Az5olaz0JHX
         UUEgK7LgnkLzA73UJeY44Th/C+/r1HCtVvQ+SKTPp9kex7Mck6hMujCFdhwo/oB+iHs0
         0N6mqEG9u+H2lpgv/l4Znbb1MoJFNLQ7Br9gTJUOrDTbJ0IwGLciaycxW/uVd75TuEQY
         l5Nw==
X-Gm-Message-State: AOAM530IoNd5I9J51WpQ8d7/rSgsJ/Yf9MpU/W24R/VAABV6Q7MI90pA
        MxJP+Mw49MSD3YKOjLGCUFE7og==
X-Google-Smtp-Source: ABdhPJzIM58jxMOmE2zPrllWl3bqZQksl9iktnNDkyFfkSPoqVYRt7Y7NFlYBnC9G6KhTmZPTNAT/w==
X-Received: by 2002:a17:906:841a:: with SMTP id n26mr1099782ejx.213.1601013408160;
        Thu, 24 Sep 2020 22:56:48 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id s30sm1055003edc.8.2020.09.24.22.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 22:56:47 -0700 (PDT)
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
To:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Valentin Rothberg <vrothber@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk>
 <CABqSeAQKksqM1SdsQMoR52AJ5CY0VE2tk8-TJaMuOrkCprQ0MQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <27b4ef86-fee5-fc35-993b-3352ce504c73@rasmusvillemoes.dk>
Date:   Fri, 25 Sep 2020 07:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABqSeAQKksqM1SdsQMoR52AJ5CY0VE2tk8-TJaMuOrkCprQ0MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/09/2020 15.58, YiFei Zhu wrote:
> On Thu, Sep 24, 2020 at 8:46 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> But one thing I'm wondering about and I haven't seen addressed anywhere:
>> Why build the bitmap on the kernel side (with all the complexity of
>> having to emulate the filter for all syscalls)? Why can't userspace just
>> hand the kernel "here's a new filter: the syscalls in this bitmap are
>> always allowed noquestionsasked, for the rest, run this bpf". Sure, that
>> might require a new syscall or extending seccomp(2) somewhat, but isn't
>> that a _lot_ simpler? It would probably also mean that the bpf we do get
>> handed is a lot smaller. Userspace might need to pass a couple of
>> bitmaps, one for each relevant arch, but you get the overall idea.
> 
> Perhaps. The thing is, the current API expects any filter attaches to
> be "additive". If a new filter gets attached that says "disallow read"
> then no matter whatever has been attached already, "read" shall not be
> allowed at the next syscall, bypassing all previous allowlist bitmaps
> (so you need to emulate the bpf anyways here?). We should also not
> have a API that could let anyone escape the secomp jail. Say "prctl"
> is permitted but "read" is not permitted, one must not be allowed to
> attach a bitmap so that "read" now appears in the allowlist. The only
> way this could potentially work is to attach a BPF filter and a bitmap
> at the same time in the same syscall, which might mean API redesign?

Yes, the man page would read something like

       SECCOMP_SET_MODE_FILTER_BITMAP
              The system calls allowed are defined by a pointer to a
Berkeley Packet Filter (BPF) passed  via  args.
              This argument is a pointer to a struct sock_fprog_bitmap;

with that struct containing whatever information/extra pointers needed
for passing the bitmap(s) in addition to the bpf prog.

And SECCOMP_SET_MODE_FILTER would internally just be updated to work
as-if all-zero allow-bitmaps were passed along. The internal kernel
bitmap would just be the and of the bitmaps in the filter stack.

Sure, it's UAPI, so would certainly need more careful thought on details
of just how the arg struct looks like etc. etc., but I was wondering why
it hadn't been discussed at all.

>> I'm also a bit worried about the performance of doing that emulation;
>> that's constant extra overhead for, say, launching a docker container.
> 
> IMO, launching a docker container is so expensive this should be negligible.

Regardless, I'd like to see some numbers, certainly for the "how much
faster does a getpid() or read() or any of the other syscalls that
nobody disallows" get, but also "what's the cost of doing that emulation
at seccomp(2) time".

Rasmus
