Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319D01D3AB1
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 20:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgENS62 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728021AbgENS6O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 14:58:14 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB5C061A0C
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 11:58:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h188so2815676lfd.7
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNZtOuZNCvXep73RZPyIzpAKoJOWSrLB4f/cVGJYlV4=;
        b=eBV96bd4k2zM+n+JyucLNP1MbLQqrKwMF5XNAcqJ2+4oKLsrDI25pVUkh5GqO+h92o
         NxGbZJC2jSf+drQKF30Zgpmjrf9P335BMpN8RHLu0bm/cvcyPa3hE9zwNLWLuNhxKp6f
         h3i6pJu7RNmRyb2ljEONon/Hni9mlshAkWUDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNZtOuZNCvXep73RZPyIzpAKoJOWSrLB4f/cVGJYlV4=;
        b=QfC+3TITiOSEsuhOzMv5Lt1/Y8lVyPEy3tdsur90qs4AalgZIvveablG2ntEppWnZU
         ZlYACF4pae3CwMDnTqmPJ2NfJyXiinVPtCAcOjCdZSjDlEnoZPIS0mB7fS7uwwMGGSuy
         KUShwsAEhleVpgPRz0pg3zcXO4axTnuBhwP95Zht6O5aRLHzu8p7DUTihs3Szoz85Yy/
         ZCZZ++abMHixoV+7nOCCkDZ6IYmIcDGLfOOMhKxtFkCNniTZogExauyHHQl3ALjnPmCt
         sMuHjU1Dbm0TMSmBHLe4Vc8NA65oAl5GJ0iUvHYeXgvhHqEVtZoa14TOlrPwABqJ6tEC
         B22A==
X-Gm-Message-State: AOAM5303b/aeTJy8TIr/HUlJeKCphpZ1YMF3RSItXpDiwD6GtXwyW8CJ
        kCyBBZZIlT6IRqsKQqXH3qyUtQcXLY8=
X-Google-Smtp-Source: ABdhPJwlRhvu87mADkLEHNL5kg8sdqzaNoD7yEAe+dphhtqCGDMslMfuadznJjxC0zUrsy2cjnndPw==
X-Received: by 2002:ac2:414c:: with SMTP id c12mr4158320lfi.47.1589482691836;
        Thu, 14 May 2020 11:58:11 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p8sm1969348ljn.93.2020.05.14.11.58.10
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 11:58:11 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id d21so4700427ljg.9
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 11:58:10 -0700 (PDT)
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr3625999ljj.241.1589482690395;
 Thu, 14 May 2020 11:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200514161607.9212-1-daniel@iogearbox.net> <20200514161607.9212-2-daniel@iogearbox.net>
In-Reply-To: <20200514161607.9212-2-daniel@iogearbox.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 May 2020 11:57:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghQ5dr-56J7CrGR10_bAJsWNZvtHcrYnhVh-RvbPjW3Q@mail.gmail.com>
Message-ID: <CAHk-=wghQ5dr-56J7CrGR10_bAJsWNZvtHcrYnhVh-RvbPjW3Q@mail.gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: restrict bpf_probe_read{,str}() only to
 archs where they work
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        brendan.d.gregg@gmail.com, Christoph Hellwig <hch@lst.de>,
        john.fastabend@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 14, 2020 at 9:18 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> However, their use should be restricted to archs with non-overlapping
> address ranges where they are working in their current form. Therefore,
> move this behind a CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE and
> have x86, arm64, arm select it (other archs supporting it can follow-up
> on it as well).

Ack, looks sane to me.

               Linus
