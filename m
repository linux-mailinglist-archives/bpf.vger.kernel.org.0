Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CDC3E3200
	for <lists+bpf@lfdr.de>; Sat,  7 Aug 2021 00:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbhHFW7h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Aug 2021 18:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhHFW7g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Aug 2021 18:59:36 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E2C0613CF
        for <bpf@vger.kernel.org>; Fri,  6 Aug 2021 15:59:20 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j77so17920334ybj.3
        for <bpf@vger.kernel.org>; Fri, 06 Aug 2021 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6vtbFX4wGAYcAVXo4s5Id8RQxVNBIV7qh2rr7RPZdE=;
        b=hG1o1N1DKIB63r3tPiyBkWe5BceXAUlGLQ1buqPZC9VWajk/Jm+DUy14kqbLwbrqCu
         oZ83igbLcmEkuVf0nehm0ex7lKPtEJ+18hNLKkwSsQDUFg2p/2rYC3y5Xg8MaX7rIiQN
         GymlFv1ubbRNqNFxbdRmgQgwx48ZecL/bOAHtUjCvOZQ9CzdXwfNzjTBESbT5snbvcmP
         TYutK8Fhuh331lpiHLLRsCUf5mEBUONaUgovywsRFh+/eZLay7Ei7VzVejciQhHSaYFQ
         kDXx7JkDIf4H1EFvy/vWcuRa+wXayGRcU5GdSRcJQc9Kn6uzQeOIXQ3pmVNG+YQRc2CQ
         JydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6vtbFX4wGAYcAVXo4s5Id8RQxVNBIV7qh2rr7RPZdE=;
        b=elYDk7Wik/BNBLhrSaIwuhugQUF3ClQ1WKg/Ms4jLwWxYfLH9JLeGryZ7NJtYp+dt2
         c9HedBSUMnT+FfifTce501PEUm/tL5hNQfmhR9utLd+kyuhiTSOZ0iXJJ04GwLR7dXJp
         TV8NpCzRQIIUQDaGJ5Dcy9+F/ZQ4cwGIbqfOZ4Zsk5rXO8vOBnXu7pOwhJMhOm7dunOw
         Ef2sKJ6E40f+YJqGI9bZRj2sCUjwpAevK2+sNV+1X55oOK7GI21xXMgsSxg9A82S5NYK
         mZ4solpA1FWJ7F1AfK2aY0WsCgKGQqqEVhzwofpwVlMs5teEQEz4wYENBzCtQfEuvkAu
         CkgA==
X-Gm-Message-State: AOAM53251XmWPcMFvW49PpUPPxtnVY1OuDVRiIaJ7dbH0Rzx3VwtYJza
        6alA8oJTgCSUt4WjW3KJqSQrQtStUkz46PtTl+E=
X-Google-Smtp-Source: ABdhPJwKU7z/iEs1jRfmRYmd3JTLJj/dyQJkOUzpB1pNmiAM+iN8XOgHgXCfDpcb5PpFi4X4xpLEQLnmqEGzXidjNVs=
X-Received: by 2002:a25:9942:: with SMTP id n2mr16327661ybo.230.1628290759497;
 Fri, 06 Aug 2021 15:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210803010331.39453-1-ederson.desouza@intel.com> <20210803010331.39453-14-ederson.desouza@intel.com>
In-Reply-To: <20210803010331.39453-14-ederson.desouza@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 Aug 2021 15:59:08 -0700
Message-ID: <CAEf4BzZ44wc-+r6o7vthddt5BoePdg0cQn83g8qkyPMAca4vvA@mail.gmail.com>
Subject: Re: [[RFC xdp-hints] 13/16] libbpf: Helpers to access XDP frame metadata
To:     Ederson de Souza <ederson.desouza@intel.com>
Cc:     xdp-hints@xdp-project.net, bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 2, 2021 at 6:04 PM Ederson de Souza
<ederson.desouza@intel.com> wrote:
>
> Two new pairs of helpers: `xsk_umem__adjust_prod_data` and
> `xsk_umem__adjust_prod_data_meta` for data that is being produced by the
> application - such as data that will be sent; and
> `xsk_umem__adjust_cons_data` and `xsk_umem__adjust_cons_data_meta`,
> for data being consumed - such as data obtained from the completion
> queue.
>
> Those function should usually be used on data obtained via
> `xsk_umem__get_data`. Didn't change this function to avoid API breaks.
>
> Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
> ---

AF_XDP parts of libbpf are being moved into libxdp ([0]). We shouldn't
keep adding new APIs if we are actively working on deprecating and
removing existing functionality already. CC'ing Toke and Magnus for
the state of libxsk to libxdp migration.

  [0] https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp#using-af_xdp-sockets


>  tools/lib/bpf/libbpf.map |  4 ++++
>  tools/lib/bpf/xsk.c      | 26 ++++++++++++++++++++++++++
>  tools/lib/bpf/xsk.h      |  7 +++++++
>  3 files changed, 37 insertions(+)
>

[...]
