Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F40449C102
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 03:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiAZCC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 21:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiAZCC7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 21:02:59 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1332C06161C
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 18:02:58 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id w5so14210629ilo.2
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 18:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+cGoY2E4E2BoPP39F3F2HjJbfryqPnc2udABYke5ddw=;
        b=p3HN2Pz7R6Dk/t/LiR17Ab7d9Zb9zi6iyOkAW0DNWmqDsU6twkVlTMqvESZledOlNr
         EwzETEtJr9HnH0TfiCn2YgDxvBDQAFVAQyWN3wJd5FNvnqsjtl1uSrN7RM/mFhYoa0Ss
         8GmQceyJJrpuyFRONvvt4haXUoJp7UcQmzV775Ib1JjYEKmmwGmdplimkdRGoctxxjRq
         iRRmiGBHU5hzM8QAsH+krG/59ffH7isF4UXJhf9WU+UfEmmiFv2E43UrbsYOdAw3VOIS
         4Xd5VJl/LB17sjUMlSpjHKyFCJnu51ot02BdktSlPMC/xyhXthLKVI664s4a+kYYZ9Te
         l+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+cGoY2E4E2BoPP39F3F2HjJbfryqPnc2udABYke5ddw=;
        b=iAxEm5BjNDlaeH9rnEmw0m4EkAPV8e2rNHA7x+9ntqPKm1qQwSBGzHj7JWPoPa2ve8
         9SuaryicyCoQ4Jl08h61u4+6Xomr7IKz6DxVPZFUy6ZbYYl/9W4rIpx90hEbpbU1RROY
         NmSKCuOzcaN2tRFVlWhvAl+jlnyeQ9Hm5HQMZu+2l0rmshvE+H69Q3fLuW/mt0mMFL0x
         6l26JpYjp+V/V0PI/Cne7s6Ale6+bE2ZDssoZXCddFDuqBtQAsXFzDQxWIRFhmPTX20e
         uzi5qFn3BU9KWo/3Cqp/CvRQOZdAMBO8NhT86OW7fxmEjt40W5Vg9g+3fTeAbt+YOmWq
         fQjQ==
X-Gm-Message-State: AOAM532HQKTL59lGFGr9lmKVNiXYYVS8BcXnMntboz7rMcC5MEqbzoyv
        DZqzhfws4Jlcq9NH+Hn2A5Q+P8VItEU=
X-Google-Smtp-Source: ABdhPJx9dyIj4sXTtgH0ll1BhFJWuTXFu8e052oa2VZDt1jgJwCOCmpvtdkVd2dCqvSKqoyHiKd39g==
X-Received: by 2002:a05:6e02:1a8f:: with SMTP id k15mr14185515ilv.195.1643162578227;
        Tue, 25 Jan 2022 18:02:58 -0800 (PST)
Received: from ?IPV6:2601:282:800:dc80:1502:2fac:6dee:881? ([2601:282:800:dc80:1502:2fac:6dee:881])
        by smtp.googlemail.com with ESMTPSA id h3sm8632157ioe.19.2022.01.25.18.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 18:02:57 -0800 (PST)
Message-ID: <18df5b0f-4fa7-f78c-ddf7-67e87de1ad26@gmail.com>
Date:   Tue, 25 Jan 2022 19:02:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map
 definitions
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
References: <20220120060529.1890907-1-andrii@kernel.org>
 <20220120060529.1890907-4-andrii@kernel.org> <87wniu7hss.fsf@toke.dk>
 <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk>
 <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
 <87lez43tk4.fsf@toke.dk> <61f06309dabcc_2e4c52085d@john.notmuch>
 <87pmof32l4.fsf@toke.dk> <61f07b3ac6bbb_30a5920833@john.notmuch>
 <CAEf4BzZ1Aynmb=f2kSE1gGqLb2o_ce8-R87ADGjh=c8ASB05Vg@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <CAEf4BzZ1Aynmb=f2kSE1gGqLb2o_ce8-R87ADGjh=c8ASB05Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

You keep responding with “tell people to modernize their programs, their
toolchains, their ecosystem” - like they have nothing better to do with
their time than to chase the latest whims of upstream maintainers. You
are trivializing what you apparently have never done - ported a product
from one OS version to another and dealt with production issues with
many OS versions in play. If you have not lived it, no amount of writing
in an email is going to convince you of the work involved and the impact
of your decisions.

###

As far as I can tell, iproute2 does not directly care about this legacy
map case and should have limited exposure to the libbpf 1.0 changes in
general (time will tell if that is correct). My argument to this point
is exactly the 'loading a certificate case' Toke mentioned - an xdp or
tc program that loads on version X should load on version Y. That is
consistent with the general expectation of Linux users.
