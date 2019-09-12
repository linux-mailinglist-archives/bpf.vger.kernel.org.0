Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE742B0D37
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2019 12:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbfILKwE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 12 Sep 2019 06:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730892AbfILKwE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Sep 2019 06:52:04 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD47744BD1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 10:52:03 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id bs22so13383431edb.23
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 03:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6flBUBjs8VPAbAefuygCBR5yf5XU4QbU0qOIz+By8ZI=;
        b=bn+NyJX56hEl85LOMqdtqwDOm87GeDhjI4/wU92G609mEWS0QkJq5+iLacvbCdYTR0
         kljBa9B+VexTDfe8dTkdXH1LppMaqhbyzNCkc2at3VM1Mg7ejNrCWpi/U7/bAUn2U8Q8
         i7xelCksERCUpJ9QNXJf5LqaR+Gf1HTty6mV+Rk4g//YVW/a1xrwxo+0ibGnohGW1rqQ
         kjqd8KXPNV89p7aq/tNLFlF/+mhjynE9idL+i7e7TK61roMKppXWgsKkrrC/qyo9PW7O
         YAvltRoJDK9qsxEedr1j/H7UYKd70klG8FnSWTVE6v6fuRQ3OqaIsI31enxOxfdl1bnI
         DA0A==
X-Gm-Message-State: APjAAAXXTe3uDWbg8Ep1O8+XPyOOKWwnpGvjEXvg6ctBnSkqOBnIlaYs
        93gt+dE/8eqCMERQ6gaGQ93/A1RG6hWe3AZr8a7UPXXZLyg9SXvW7vOymv3sJc8NLW/VE8t/RBA
        VhczpqgIyDwCN
X-Received: by 2002:a17:907:2065:: with SMTP id qp5mr33221224ejb.151.1568285522642;
        Thu, 12 Sep 2019 03:52:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0B4fTUSLQ4Z3x7ogXVND6zxk194V/rQL1i/woELQNZgzJsKoUTobHl7LJ5qZW+w80pa/Csg==
X-Received: by 2002:a17:907:2065:: with SMTP id qp5mr33221211ejb.151.1568285522444;
        Thu, 12 Sep 2019 03:52:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id u27sm4714326edb.48.2019.09.12.03.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 03:52:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8960C180613; Thu, 12 Sep 2019 11:46:39 +0100 (WEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
In-Reply-To: <CABCJKufCwjXQ6a4oLjywDmxY2apUZ1yop-5+qty82bfwV-QTAA@mail.gmail.com>
References: <20190909223236.157099-1-samitolvanen@google.com> <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com> <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com> <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com> <87impzt4pu.fsf@toke.dk> <CABCJKufCwjXQ6a4oLjywDmxY2apUZ1yop-5+qty82bfwV-QTAA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 12 Sep 2019 11:46:39 +0100
Message-ID: <87sgp1ssfk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sami Tolvanen <samitolvanen@google.com> writes:

> On Wed, Sep 11, 2019 at 5:09 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Björn Töpel <bjorn.topel@intel.com> writes:
>> > I ran the "xdp_rxq_info" sample with and without Sami's patch:
>>
>> Thanks for doing this!
>
> Yes, thanks for testing this Björn!
>
>> Or (1/22998700 - 1/23923874) * 10**9 == 1.7 nanoseconds of overhead.
>>
>> I guess that is not *too* bad; but it's still chipping away at
>> performance; anything we could do to lower the overhead?
>
> The check is already rather minimal, but I could move this to a static
> inline function to help ensure the compiler doesn't generate an
> additional function call for this. I'm also fine with gating this
> behind a separate config option, but I'm not sure if that's worth it.
> Any thoughts?

I think it would be good if you do both. I'm a bit worried that XDP
performance will end up in a "death by a thousand paper cuts" situation,
so I'd rather push back on even relatively small overheads like this; so
being able to turn it off in the config would be good.

Can you share more details about what the "future CFI checking" is
likely to look like?

-Toke
