Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81AE1EBEF0
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgFBPTs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBPTr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 11:19:47 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A51EC08C5C1
        for <bpf@vger.kernel.org>; Tue,  2 Jun 2020 08:19:46 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a137so12349708oii.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2020 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvDVFb5k9f1aBXkkwHN4jDU3/KgD2yY12rxXo7BrUO4=;
        b=hdmjWHd4hAmo1z5kOZ5jR84jdZJ6vORubN0oewdmpq5DQypsAujz6KZIkF2nCEAhuL
         p43xiszzWhdRq6iAdNJfx+T/o6CZvknOspGrzWPx6HDDmyYAETZYeg6tC57ZYvD8qMlC
         ukNwBkeOTjmQbMr77QWmDqtJj/M+uZHr2WX40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvDVFb5k9f1aBXkkwHN4jDU3/KgD2yY12rxXo7BrUO4=;
        b=N6wBZDgIcAIgakcnwMQmq7SrHNcElV4+Z48+MIl2kOK/sYdW+JgYHSJKDfcIwk9Emh
         ObL+cgjHaNltYJ8l4Bzmyj+jikGsAjQPEjdny2ylW+EQMRNVjluzQpr6oK9pra4MF9Zm
         4u5sn0686Il5TI4g35jtqkw+5Rjq/IiUBxAfHs8uqj4ppVoeZqT1B7BbRDQEo3acdXb+
         u+kQGnIUKo94FJq6h22M+S6HJLJaBc2fDatQlhEFYQpxOZs6Dgtv/OtIY3wXrY6UUxcx
         nYP8YIxkRlqCaOWdqEQntXfCDwf71Zk0K6QP2QSWqvkBjOp47aeioNrifFK/CUEUIgaU
         o9wQ==
X-Gm-Message-State: AOAM533V7H1CF4u3Uq0w4yl6FRZ24nRRj0N6zMtF07nDZgBu+cuAanDB
        Mq8IvMpmk9gfC2p0QMXDIBJoAyt0kRWTj8P31v8Mjg==
X-Google-Smtp-Source: ABdhPJwbtLJGSTLz21infm2e/0C0Cgm7WKmXACcMAeoBuf64HzU9qxQInfmC72fXw/siJm03T9kCqxitlu3+5i+r+Lw=
X-Received: by 2002:aca:d58d:: with SMTP id m135mr3209674oig.102.1591111185503;
 Tue, 02 Jun 2020 08:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591108731.git.daniel@iogearbox.net>
In-Reply-To: <cover.1591108731.git.daniel@iogearbox.net>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 2 Jun 2020 16:19:34 +0100
Message-ID: <CACAyw99em+nj55roygxHFZ6Ks71oSbaOP=nRUv28vUrR+RcjBg@mail.gmail.com>
Subject: Re: [PATCH bpf 0/3] Fix csum unnecessary on bpf_skb_adjust_room
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Jun 2020 at 15:58, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> This series fixes an issue originally reported by Lorenz Bauer where using
> the bpf_skb_adjust_room() helper hid a checksum bug since it wasn't adjusting
> CHECKSUM_UNNECESSARY's skb->csum_level after decap. The fix is two-fold:
>  i) We do a safe reset in bpf_skb_adjust_room() to CHECKSUM_NONE with an opt-
>     out flag BPF_F_ADJ_ROOM_NO_CSUM_RESET.
> ii) We add a new bpf_csum_level() for the latter in order to allow users to
>     manually inc/dec the skb->csum_level when needed.
> The series is rebased against latest bpf-next tree. It can be applied there,
> or to bpf after the merge win sync from net-next.
>
> Thanks!
>
> Daniel Borkmann (3):
>   bpf: Fix up bpf_skb_adjust_room helper's skb csum setting
>   bpf: add csum_level helper for fixing up csum levels
>   bpf, selftests: adapt cls_redirect to call csum_level helper
>
>  include/linux/skbuff.h                        |  8 +++
>  include/uapi/linux/bpf.h                      | 51 ++++++++++++++++++-
>  net/core/filter.c                             | 46 ++++++++++++++++-
>  tools/include/uapi/linux/bpf.h                | 51 ++++++++++++++++++-
>  .../selftests/bpf/progs/test_cls_redirect.c   |  9 ++--
>  5 files changed, 158 insertions(+), 7 deletions(-)
>
> --
> 2.21.0
>

Thanks for pushing this out, Daniel!

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
