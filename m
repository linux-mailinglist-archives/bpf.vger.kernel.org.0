Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4350D40E
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 19:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiDXRq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 13:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDXRqz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 13:46:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382DCD399D
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 10:43:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v4so3145583ljd.10
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peeXpSGRMeGEzoalpORyTqQLMLKNcHauKDKhUxOBeNk=;
        b=IekpBZl+Z1RTJbQ89uIac/0pvqJlPZbLqqT1M3FrGlhuNapxhk9LXvDklkTRji31Iv
         YqTjbVNa45HZCZIFzco0ewinoAbriHZX7UDnNI0FvzoEh8a8GQ8BBe2n2fDNj6t+nH15
         eBbh3tx/hkS1SojrqBNx+y9nwQoRTjBiF36VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peeXpSGRMeGEzoalpORyTqQLMLKNcHauKDKhUxOBeNk=;
        b=GAIThxHFhabucMdXg2fbsF5Hpa7T0PBwzaXL7TqYKQjSbotAiTPezCakVBXlVhziwv
         D90keq3MQ2Fo5ho0ZdXTH2luA7ks/G50XLOUqjARyk3xcLFWVs1GRfFoF20GAmAReU0Z
         U7vCpu6XNfzPY/uYI+WErjkcoCBLQHwMbTjJSkBGU92hg16Apa8C7jHu+1u0oXuu7yAk
         j0is79oF/axuZjKeRJRW7nLlZNkmgTiQJfcdDdP8v+kVv6qc/nGTFt941x7r46hGYv/T
         hzMFvSjvZi2/Ry9+RexYXBv131pVFxgb4neCY8+LfvrD71ufnBxyg/Vk3jhjViaHGPXs
         GaaQ==
X-Gm-Message-State: AOAM531z/CDC0EuFk0/cvB0zPVa5djQd2HafmmQPl+7rKZMwF2/E9T2H
        fY54K7WAFFZsuQasvoGMoc74HdK8k2BVS5Bf
X-Google-Smtp-Source: ABdhPJxchxg6O/hSfzOX1+c17FJxnCrZBwGHbR0iz6N/GUyza+FkamMzwCQIii6jLCFjZsZc4IyfTg==
X-Received: by 2002:a05:651c:215:b0:24f:3c9:e3 with SMTP id y21-20020a05651c021500b0024f03c900e3mr5262733ljn.487.1650822231218;
        Sun, 24 Apr 2022 10:43:51 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p26-20020a056512313a00b0047206a0e6e9sm115649lfd.289.2022.04.24.10.43.46
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 10:43:47 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id z18so5419803lfu.9
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 10:43:46 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr10677909lfu.449.1650822226569; Sun, 24
 Apr 2022 10:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
In-Reply-To: <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Apr 2022 10:43:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whadDF2MGN_THUo-n9S-m9isA-+vwhMeVvwGvmuZaYb6Q@mail.gmail.com>
Message-ID: <CAHk-=whadDF2MGN_THUo-n9S-m9isA-+vwhMeVvwGvmuZaYb6Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Song Liu <songliubraving@fb.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ I see that you posted a new version of the series, but I wasn't cc'd
on that one, so I'm replying to the old thread instead ]

On Sat, Apr 16, 2022 at 12:55 PM Song Liu <songliubraving@fb.com> wrote:
>
> Patch 2/4 enables huge pages for large hash.

I decided that for 5.18, we want to at least fix the performance
regression on powerpc, so I've applied the 2/4 patch to enable huge
pages for the large hashes.

I also enabled them for kvmalloc(), since that seemed like the one
ObviouslySafe(tm) case of vmalloc use (famous last words, maybe I'll
be informed of somebody who still did odd protection games on the
result, but that really sounds invalid with the whole SLUB component).

I'm not touching the bpf parts. I think that's a 5.19 issue by now,
and since it's new, there's no equivalent performance regression
issue.

               Linus
