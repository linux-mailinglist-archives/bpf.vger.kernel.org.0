Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D863020C351
	for <lists+bpf@lfdr.de>; Sat, 27 Jun 2020 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgF0RaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Jun 2020 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgF0RaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Jun 2020 13:30:24 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8466CC061794
        for <bpf@vger.kernel.org>; Sat, 27 Jun 2020 10:30:24 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id m16so6128576ybf.4
        for <bpf@vger.kernel.org>; Sat, 27 Jun 2020 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GME1JBq+HspVyApgfrLuROed4w0qcKFS1lRk/ZMZtMU=;
        b=fjrtmxbZLJy+OjMHl0dGb4e4N2N1iKyUosgpgi9Y9fn5Kz+UO8N5aj2mvow4qDEo9L
         9lrfaPQWhc9JPKRH3UDE60hzMZNfqhe6CpkiZqrB8NqFHW+xNqSYrSBg4JeZWG5Nzoz+
         J5OhrTX3zZQuDjMVCipKzOkOAeAYUmxYmKPfMMU4haWqOwUYy8m53QYg45a4aw0LlaMI
         g+WVfdoSMwI/I6gNaVOH3+KOO32aQC5aeUDqaGjqSwIAStmv0RAjWk2WU2XhLyh6Y+iQ
         Y81VN9ohukfBVhEhogxacfGO3Tp7R7up7rEN11jY0FjwxeCZiTubckyzhP39OO7vTK6i
         8Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GME1JBq+HspVyApgfrLuROed4w0qcKFS1lRk/ZMZtMU=;
        b=U3AOTmpUaU+e7CACqbBHWGiXjIDN1MWwvKF2NesP7e/8W0oED0uddvDUEly8686CkB
         AARt41lpf+NgdXjl9OHp3S2CLkQxzHTk3Pe9lftGreIjHyG5pkiBhxWF/D32qnpSgq0u
         VoIW/C/e/+zITFc6Vn8CsNmA5SRTG9BonPgExqJS8X14Kjf9FzHVNYaernpykQTy/TBm
         WAoQQz8j1Du1zL/hgGmTwztqN3GR1AruQffx+VZtN34lKhfptLNWmMo+QWlcXzYU+0i2
         GiT/fk4MdhiuFY3NuRbKMNavfUyrtDr3fX0E+AO0wPT0SkMPuvWvlf5MnmSstCXIqxUZ
         FftA==
X-Gm-Message-State: AOAM531ebnAzWUCK7fQyZJiA0NsMqslR03DKmvaUBX0WTDrb5Go8YSwo
        JQPxTyKPkGoO/Ghru1lR7vRcTjD+QaZLmmlDvmagmQ==
X-Google-Smtp-Source: ABdhPJx6c688b24t77YorKJzYmcPzKK5z4r6QqYJZi9ydc7RDLBeYO8rli+QuHthtyA3GyIvRbAxWTpxcIucOh/qTKE=
X-Received: by 2002:a25:7003:: with SMTP id l3mr13634767ybc.380.1593279022730;
 Sat, 27 Jun 2020 10:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200626175501.1459961-1-kafai@fb.com> <20200626175558.1462731-1-kafai@fb.com>
In-Reply-To: <20200626175558.1462731-1-kafai@fb.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 27 Jun 2020 10:30:11 -0700
Message-ID: <CANn89iJKO+As==L-NCteYjLakqSJkZsYg-TxbAkS21yNDYwENA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] tcp: bpf: Add TCP_BPF_DELACK_MAX and
 TCP_BPF_RTO_MIN to bpf_setsockopt
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

On Fri, Jun 26, 2020 at 10:56 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> This change is mostly from an internal patch and adapts it from sysctl
> config to the bpf_setsockopt setup.
>
> The bpf_prog can set the max delay ack by using
> bpf_setsockopt(TCP_BPF_DELACK_MAX).  This max delay ack can be communicated
> to its peer through bpf header option.  The receiving peer can then use
> this max delay ack and set a potentially lower rto by using
> bpf_setsockopt(TCP_BPF_RTO_MIN).  A latter patch will use it
> like this in a test as an example.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

This could be split in two patches, but no big deal.
