Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7B31CE1E
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 17:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBPQdf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 11:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhBPQdd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 11:33:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62E0064DF0
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613493172;
        bh=3cSdEU96VCQwh8rNXu8ySSLddvlG4JSbKTBPjImexbQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dwSRjIr9F1pUc7RFYaGAaIMowB7ahBbWpjH8LnWcqNZV4Gus3QXsyWLFa0o1sofcL
         HaF7mP5ZYUdzkHmCV0bBUbnRjqA1QAe/k39EimeKdUlDEO3saj/wiKToi9iPYvqXPo
         OFUprmolu2HfCqPZ+uCJLlID2Ix73GT99eFLcB9i/hCtbPYvgIvADPC+vc3niRzBtv
         dtCeATe+iR51DAHsehvFTM7WbsCWgayU1JaSIhBUp1BZ1ou6YPKKxp4UcS+2fj7qIu
         BXeDLnLRSMbcke/Fb3Lhjd15ggP7OJDt8is/AofbQQWS+fswceV6W475dpkiwi9Aoy
         ItHzV7xpS//CQ==
Received: by mail-lf1-f41.google.com with SMTP id d24so16790839lfs.8
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 08:32:52 -0800 (PST)
X-Gm-Message-State: AOAM533F6u3WquzAGBXZicPe3Pu83vgPpT084nU1/q9HmNE7sNsgpXTm
        yW1wBDiTUMay6DxJlrCv7vmdfZuGv7TPAdsAQVFIWA==
X-Google-Smtp-Source: ABdhPJwRNxCERg4QnzuolSA7E7Yt4tO4+dB9B8wjPdf2+6JTQB3B6NxxlyjS3URsWCdGJPkPHbk/xonb9rwmyY8vAYI=
X-Received: by 2002:a05:6512:398e:: with SMTP id j14mr13016793lfu.9.1613493170694;
 Tue, 16 Feb 2021 08:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20210216125307.1406237-1-jackmanb@google.com>
In-Reply-To: <20210216125307.1406237-1-jackmanb@google.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 16 Feb 2021 17:32:40 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4b5CjVowkEhmML5XbvarQQhcVLGNX84J--hJbNhZ-5Lw@mail.gmail.com>
Message-ID: <CACYkzJ4b5CjVowkEhmML5XbvarQQhcVLGNX84J--hJbNhZ-5Lw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: x86: Fix BPF_FETCH atomic and/or/xor
 with r0 as src
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 16, 2021 at 1:53 PM Brendan Jackman <jackmanb@google.com> wrote:
>
> This code generates a CMPXCHG loop in order to implement atomic_fetch
> bitwise operations. Because CMPXCHG is hard-coded to use rax (which
> holds the BPF r0 value), it saves the _real_ r0 value into the
> internal "ax" temporary register and restores it once the loop is
> complete.
>
> In the middle of the loop, the actual bitwise operation is performed
> using src_reg. The bug occurs when src_reg is r0: as described above,
> r0 has been clobbered and the real r0 value is in the ax register.
>
> Therefore, perform this operation on the ax register instead, when
> src_reg is r0.
>
> Fixes: 981f94c3e921 ("bpf: Add bitwise atomic instructions")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: KP Singh <kpsingh@kernel.org>
