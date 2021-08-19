Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26B3F2317
	for <lists+bpf@lfdr.de>; Fri, 20 Aug 2021 00:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhHSW22 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 18:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhHSW22 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 18:28:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB40E6109E
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629412071;
        bh=OzBCSSWJ97ptHE9a21JwPYypwnMEhpfPwBNttiOYvGs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tDcF6R1Yckso3iuIGY9SHeuLOoew6vC89Kx8Qe41+iZoAygNeaPnLyRqxApgoCsBL
         WRdEA8QD6S7e7SRueS2N/RzMBPaAg7Zdt14TrfLWGD0XuVSf8qUWQu6k4mXLVYcf0v
         o6QYEiZEcvOkKo3f4kKJYmZ4zMUKP6+goGxb+BwAsnbqDXtPplvTtQN3QX/Il8UX5u
         q//gypZIZmKxvyA91ColNLx/jCd05D90aGsYMuz1pazYMg5Kw8HE9dJxzMHDkMczgM
         IhzW5ob2coymM1nx7rzJbo+0eVxVz2y9pfaKd+ee1tX12lMlLQo1FVRE1re2LA+/jJ
         eJk52NmVBlgKg==
Received: by mail-lj1-f176.google.com with SMTP id d16so13995942ljq.4
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 15:27:51 -0700 (PDT)
X-Gm-Message-State: AOAM530YjOUl/kW806DrguoFXviYT6cx8xeEI9IF7rMfG8D15oyocV/Z
        6ZDW6KFMRE27mc6XJ15LApjieKVAVq8vYM2VDQ8=
X-Google-Smtp-Source: ABdhPJy2DuncuSzwCZVSAIicWTM0wAOME6fYIl8Fo9nOlILJHB06hAFP8o04Hrcg+nDGCt6x9oT0BSYcCbs9vR95mas=
X-Received: by 2002:a2e:a713:: with SMTP id s19mr3919090lje.177.1629412070171;
 Thu, 19 Aug 2021 15:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210817224221.3257826-1-prankgup@fb.com> <20210817224221.3257826-3-prankgup@fb.com>
In-Reply-To: <20210817224221.3257826-3-prankgup@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 19 Aug 2021 15:27:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7FvKx0X-ap+4eOwanBtOg81qnsOtW+9_O5kDO_piX9nQ@mail.gmail.com>
Message-ID: <CAPhsuW7FvKx0X-ap+4eOwanBtOg81qnsOtW+9_O5kDO_piX9nQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for {set|get} socket
 option from setsockopt BPF program
To:     Prankur gupta <prankgup@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, prankur.07@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 17, 2021 at 3:43 PM Prankur gupta <prankgup@fb.com> wrote:
>
> Adding selftests for new added functionality to call bpf_setsockopt and
> bpf_getsockopt from setsockopt BPF programs
>
> Test Details:
> 1. BPF Program
>    Checks for changes in IPV6_TCLASS(SOL_IPV6) via setsockopt
>    If the cca for the socket is not cubic do nothing
>    If the newly set value for IPV6_TCLASS is 45 (0x2d) (as per our usecase)
>    then change the cc from cubic to reno
>
> 2. User Space Program
>    Creates an AF_INET6 socket and set the cca for that to be "cubic"
>    Attach the program and set the IPV6_TCLASS to 0x2d using setsockopt
>    Verify the cca for the socket changed to reno
>
> Signed-off-by: Prankur gupta <prankgup@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
