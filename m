Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75041711E9
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2019 08:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfGWGa6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jul 2019 02:30:58 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:34934 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGWGa6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 02:30:58 -0400
Received: by mail-yb1-f177.google.com with SMTP id p85so3149677yba.2
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2019 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDAh35R/1EFfcE063Gumv97CFVxysUw6D4aMrC2pGTo=;
        b=pKypYOREmjsYFPbfPwAEdwGs++ErdgjvHv730JmLx1bx0BwOfvkoktkuCdtKsq0JPj
         p+Sizs6C4gGqa/1okBmPC/5Lby0MY7d/p5aNyJpwi3sRESww1RShSIq+GbM3prNGRtiz
         tsJEMJrePO5pUKjTaxiezJGLGUBAPzCi31gaL8zhp8v3mbS9CjMDfjXuupGSB4sm8zmk
         tBw7gtogPFDvL1mxrcptVqRC2EljG5W4O1nRo9hFajjLfhuxrXUYILdylr5srOfv69Mg
         hzYvoQHJxPc5D8bZhR+U0ILUinv/SohJfBROAVf5TPak2JzpGUylzn0Nph8w9nuYQoYu
         X13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDAh35R/1EFfcE063Gumv97CFVxysUw6D4aMrC2pGTo=;
        b=qkeTjy7igr/n9zVKOupNQCcQCYy1eNdyT4SKxr9G0azUNM4p1nfDT/LKCQjbb5B2Qq
         F7gQiGFcsUF2OQYwyYr7kuUSUYt4e24Tkr/P6Hp+V3l9lkBonjz0lErRuAK/i4H/Sgun
         pWWFmjza7RW9R+rCqRcq5chOMYsdfu42ody6IxriWJ/eOtTV69x3ibLYWN+dbHJF0Akp
         vwrgFsIpRR+mEv1otevCDkgxg1pLcrUGG3ODgR71Xov8vx+LIWErkgYO1ryLXUxLnMJY
         FshO9mNiGUBc6Q5SsXyZ54eCtBlB6j45+F5yqkpRrqU10GrTaeiwfASvxA+a1GzJJvl6
         Oj0g==
X-Gm-Message-State: APjAAAWmdcZBXc3Us3ah958YnOTSjVx0Ww6ds+waUkVKZp52en3ITEAO
        g90zncpDAiW+LqB4U1M0u6Rts2TV6y9Izjt6h2Zczw==
X-Google-Smtp-Source: APXvYqyV5x17BGj0fV3pIvig/mLJEt7D58ahKIsWD8nZUHYf5Vj/TD43DYV4oiD4rwDPhH/r+kQK84vvkZWnIiR+tsw=
X-Received: by 2002:a25:37d7:: with SMTP id e206mr25861813yba.518.1563863456770;
 Mon, 22 Jul 2019 23:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190723002042.105927-1-ppenkov.kernel@gmail.com>
In-Reply-To: <20190723002042.105927-1-ppenkov.kernel@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 23 Jul 2019 08:30:45 +0200
Message-ID: <CANn89iL2v1gecCjRt7W1dodSWoMP9wf6-0pzvFAEmBuwcJUQDw@mail.gmail.com>
Subject: Re: [bpf-next 0/6] Introduce a BPF helper to generate SYN cookies
To:     Petar Penkov <ppenkov.kernel@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, lmb@cloudflare.com,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 23, 2019 at 2:20 AM Petar Penkov <ppenkov.kernel@gmail.com> wrote:
>
> From: Petar Penkov <ppenkov@google.com>
>
> This patch series introduces a BPF helper function that allows generating SYN
> cookies from BPF. Currently, this helper is enabled at both the TC hook and the
> XDP hook.


Please provide performance numbers ?

We want to know if we increase performance under synflood, or if it
does not change, or even decrease ;)

Thanks.
