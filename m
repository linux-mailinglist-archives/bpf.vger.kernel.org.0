Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCFC3272A7
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 00:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfEVW6s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 18:58:48 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:40155 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfEVW6s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 18:58:48 -0400
Received: by mail-lf1-f44.google.com with SMTP id h13so2923133lfc.7
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiPzMyOs63Y3bxLy+vXT5x7xyRvI6hSbEVGCGU88yC4=;
        b=e2qQHdYny//6XgV1qInDJKyzy3lKA4vNtPGobrytTzIE5Zt1tJWFnLSorBYItO5L2r
         djaLoKDryHAkr7+vT1ccUSj37CnuuNWiH2gaJF3kh44ruw7xmTKsLuaDnrHoBquRTwaR
         GauDd5nCf/U1Bkr2RsNGvQYVeqwPQChdN9428=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiPzMyOs63Y3bxLy+vXT5x7xyRvI6hSbEVGCGU88yC4=;
        b=gSaKQVEa7v5QPGw32UmbReIff4PcaHWBnwYJ//UFGsWEocCm+xtdLJMWy4lOoIvMHq
         +Ix+vVM148PKbNGNRj6pA+EOsfuv/7cUzaAUHaC4wN5yLbXvY3zu561ags2GVpWKp9ZL
         qbuf1kRqoyP/4OhgdwoTo1FrVxte6yrqiTmRWrCyJhjA4QwGPaJtoWRGGl+mlInB7UHQ
         UZPMUeDttjvXPgKZlW5ke3pM7m0SIQW92lTasWrY5M8N3amz2FvvLRLtp6HgOQHnedi2
         nFZvFwIXXnv55pHF371qQYuRe33TNnSExSZwLPD2+n+yB3x1rWZ5Cs/1etft3srKxAuT
         6e1Q==
X-Gm-Message-State: APjAAAVoILvVsVWbR7PyblBuIJsWwk0D1vCMUWNm/SyxNXVOj0GANllF
        QrlKj7z47E2/iT1PRzwDU1h85LDXbhQ=
X-Google-Smtp-Source: APXvYqyN9tOoPzskzQZhyJniXn5VgYKErIXqtkkG6xWLaqde9pWMkNk9dCAU8WkjsYXFZ5t38yafag==
X-Received: by 2002:ac2:533c:: with SMTP id f28mr34274468lfh.81.1558565925353;
        Wed, 22 May 2019 15:58:45 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id q12sm530422lfo.42.2019.05.22.15.58.43
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 15:58:44 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id y13so2908018lfh.9
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 15:58:43 -0700 (PDT)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr38374010lfc.54.1558565923584;
 Wed, 22 May 2019 15:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fd342e05791cc86f@google.com> <000000000000e7e3a5058980ee7b@google.com>
In-Reply-To: <000000000000e7e3a5058980ee7b@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 May 2019 15:58:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjq3q6ey_S41R0kzR0BwYBrg=h4G+x_TAJregrnkKK6=A@mail.gmail.com>
Message-ID: <CAHk-=wjq3q6ey_S41R0kzR0BwYBrg=h4G+x_TAJregrnkKK6=A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sk_psock_unlink
To:     syzbot <syzbot+3acd9f67a6a15766686e@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, john.fastabend@gmail.com,
        kafai@fb.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, songliubraving@fb.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 22, 2019 at 2:49 PM syzbot
<syzbot+3acd9f67a6a15766686e@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 48a3c64b4649 ("Merge tag 'drm-fixes-2018-06-29' of  git://anongit.freedesktop.org/drm/drm")

That looks very unlikely indeed. I strongly suspect your bisection is broken.

Looking at the bisection log, the problem sometimes happens only once
out of the ten tries. Presumably it then happened zero times a couple
of times, and the bisection went off into the weeds.

Any possibility of re-doing the bisection (the ones marked "bad" are
clearly bad, so you don't need to redo it _all_) with many more runs
for each test point?

                 Linus
