Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F012E21007A
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 01:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgF3Xfe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 19:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgF3Xfd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 19:35:33 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71709C03E979
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 16:35:33 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id j19so7982105ybj.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 16:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0F8vRF7FG/PmZ2g7D4qS+C0vzq8AzEmPQZfZWSdh8t8=;
        b=JQNj0YwGs1q0Op3C1DQ/IyH20Fk6fr1hMAmR2ZG9OBuvn2Wk4vGsbXSBqQQbdclmvS
         AjdEOk/C8Nv7674b1/7TWuoOmMjfQ/rzo35mFoVXwGkRIFbDet5yazY9TGYE8d8rPz0F
         7wutxLf/s3kyFQHjLJvyx13dYxJrONWXqkvHOgHGNHNAfnKGLXv6CJCnoMNktvWxRHrY
         bBgz/ck5v5+AzMfHBkHP1tDQOT3DbkYtwGbR5rDLmVVbK9PMxy39nc8dvJhmsnzvU+mk
         aGazopAfZ4FunEfTmohq2edxbE1YP3roL1Lga2KMIL6qatIZcSduTcGSU7J83kQg9rR0
         1AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0F8vRF7FG/PmZ2g7D4qS+C0vzq8AzEmPQZfZWSdh8t8=;
        b=lC4RwIeUBN+urs9F1+UA9AYj4TEDy3rTkNrW0oexfoHloPjNrF0VkaafpaRUO826cH
         vn4GEXYv1HjPmkblIxl/lQB2W4kAWGi6GMlifKDOhUiAB6puXU9+pFh8NRJbtO3taUeX
         U1TGbKoah16tjiLpCRD8D75Qtik288ZXcj8AZtSACVFYzmvyn529dvLpfHJVwScIrhkl
         WN7TkI/KpTxxXJVmfNi5mPalbOUFkBSGsokeYGFlf7Tyf3eMj7Ezivs/LptVNM5lN7xJ
         uVbQRHqPAzV/vgJP+V5TDTRvvGEWT0hfMOuhrQf7HcFy5XN9VqK/3DhNn4XguXZoC2Tc
         qS/A==
X-Gm-Message-State: AOAM533M46Q82Zb4j6b/EeeL2qT/PdbKwvoiQaQLYoyTRL39Zpb0/z97
        gbP7+wrnI4lKJKm7qKRC7EfjnMzSeVOgKjijMFWaLA==
X-Google-Smtp-Source: ABdhPJwfI5teRlieTKunjXebBLbTtdL6FHmmt7Dnqbioh0wVFJe6Ug7M0TYPDKZumu8hXK10U6N36FjIBdZZsfSFUFU=
X-Received: by 2002:a25:7003:: with SMTP id l3mr36625730ybc.380.1593560132411;
 Tue, 30 Jun 2020 16:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200626175501.1459961-1-kafai@fb.com> <20200626175508.1460345-1-kafai@fb.com>
 <CANn89iLJNWh6bkH7DNhy_kmcAexuUCccqERqe7z2QsvPhGrYPQ@mail.gmail.com> <20200630232406.3ozanjlyx5a2mv6i@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200630232406.3ozanjlyx5a2mv6i@kafai-mbp.dhcp.thefacebook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 Jun 2020 16:35:20 -0700
Message-ID: <CANn89iKj-okNmJhUnOmzdGVbOHi8zdF+=oO4RUFOo2X6M1kZHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/10] tcp: Use a struct to represent a saved_syn
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 4:24 PM Martin KaFai Lau <kafai@fb.com> wrote:

> Interesting idea.  I don't have an immediate use case in the mac header of
> the SYN but I think it may be useful going forward.
>
> Although bpf_hdr_opt_off may be no longer needed in v2,
> it will still be convenient for the bpf prog to be able to get the TCP header
> only instead of reparsing from the mac/ip[46] and also save some stack space
> of the bpf prog.  Thus, storing the length of each hdr would still be nice
> so that the bpf helper can directly offset to the start of the required
> header.
>
> Do you prefer to incorporate this "save_syn:2" idea in this set
> so that mac hdrlen can be stored in the "struct saved_syn"?

Sure, please go ahead.

>
> This "unused:2" bits have already been used by "fastopen_client_fail:2".

Oh that is possible, I have sent the patch as it was when we merged it
years ago.

> May be get 2 bits from repair_queue?

Hmm... this repair_queue is used in fast path, I would rather keep it
as u8 for better code generation.
