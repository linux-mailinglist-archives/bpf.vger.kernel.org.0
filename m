Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2671415607F
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2020 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBGVJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Feb 2020 16:09:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44697 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgBGVJx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 16:09:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so739898ljj.11
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6lJ3eVihQzhnpgygVKaGhku6xBoNivJFfNePtZ2oQs=;
        b=TrrZ3kVS5imwLo759RwTKG3OqsyLhZUlxnAA+DnvviLqnGblA3PndVuRaan5cEIn2B
         fDO/Eh0Y9ertNh2QXFLyHH7JFlC/NZfw8IQCgDzbnZWNJJMIDk4r6RxKlVQfHhc4yu/e
         AJBrqOK/YW7HtJ2q3NS8MvmmaiG223SOALKgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6lJ3eVihQzhnpgygVKaGhku6xBoNivJFfNePtZ2oQs=;
        b=IUns4Ev/i4OrW5qqRmONizUXr99EBm/JZQemyUGyfFuBH1pG0W/kulTIyc0+yFTy/R
         b5Rfpqk3M10tcjeJLa/3/AFvKcVf8y6xdn+dV87s55xiI+vGruWy+RKUIvQZmA/r4Hq6
         ZnLg3pysQdIut9SLDbJEx+Qaa1hsejBNJh/w1+vrX3f7BPrNXVsEe85eF1oR2BoSCI21
         Eb4Qta1pi6FMz93sdXYSVo+ZnoP6wv8qVIhsyjkokAQUoxf2ENN57H3RFB+ubeRwdHnl
         ADpzMgqIp2CTpUya6C0cskkasIBJrUFgpS2MMXZbri084qf+L4aSaOmqM5eXbyaF9oTU
         ruwA==
X-Gm-Message-State: APjAAAWS7G16psLPOaFRA5W4spRXd/VKql1KYresxACT8A5tq0+iVAQy
        91dQhp9EvKcY1mU+CD2lG/3Q4YvNZ7sY8A==
X-Google-Smtp-Source: APXvYqxw3jRQeHP43mlHtQzzXl6ftNwAs3Rk6LHuXiSKvW4h9I1XpXAnh23R8FCvxA4RmZMXg9UAFg==
X-Received: by 2002:a2e:9b52:: with SMTP id o18mr661626ljj.270.1581109789990;
        Fri, 07 Feb 2020 13:09:49 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i19sm1582984lfj.17.2020.02.07.13.09.48
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 13:09:49 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id q8so798303ljb.2
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 13:09:48 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr682642ljj.265.1581109788445;
 Fri, 07 Feb 2020 13:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20200207081810.3918919-1-kafai@fb.com> <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
 <20200207201301.wpq4abick4j3rucl@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200207201301.wpq4abick4j3rucl@ast-mbp.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Feb 2020 13:09:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdCXgQyBSSx-ovfiZ7WFR6fStOZ_2R9mxkX3a+R5MkxQ@mail.gmail.com>
Message-ID: <CAHk-=wgdCXgQyBSSx-ovfiZ7WFR6fStOZ_2R9mxkX3a+R5MkxQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, kernel-team@fb.com,
        Linux-Sparse <linux-sparse@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 7, 2020 at 12:13 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> In addition to this patch I've tried:
> +#define __const_ilog2(n, unique_n) ({                  \
> +       typeof(n) unique_n = (n);                       \

Yeah, as you found out, this doesn't work for the case of having
global initializers or things like array sizes.

Which people do do - often nor directly, but through various size macros.

It's annoying, but one of the failures of C is having a nice form of
compile-time constant handling where you can do slightly smarter
arithmetic. The definition of a "const expression" is very very
limited, and hurts us exactly for the array declaration and constant
initializer case.

Oh well.

          Linus
