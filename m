Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE436D86D
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhD1Nj5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 09:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhD1Nj5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 09:39:57 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC62C061574
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 06:39:12 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id u20so31326573qku.10
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXrR9OhlRlavJZtJOAIqOZn1/vUeMjJTpDcw4n3QP/Y=;
        b=VHw/qfobO0qBe4A4FKHASvhLVOBm0zTzFvnB6bu2nz9T+VUrSuZXS8+W1ppmkfQ5Cm
         /41a9mc3Z3yTYFBBw7v2fXgNLXBb17y6eYK6oTEl9ETzOyfULeZVUroT0NS9RB9pVuNW
         XxluocAGploKls8kx9jLRhsPr5tRkby0jWc0Y/KTikByHvYFYiEBjntXI3IaJio2rOlM
         hZ+dpTnIGtk1Q5XfgXdJ3S+1XhDim1oeFSgIUSttrQyQoqNt9ooxhs+en/w2R1jiOWOG
         KBEkXBM0lA+nqzmZdPIWUgu6KwvTd5Rla0uZY6m8E7fKs7y80gP0Hi/k1RoYpcaj7Lvb
         /QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXrR9OhlRlavJZtJOAIqOZn1/vUeMjJTpDcw4n3QP/Y=;
        b=FfdiGwck/YYsdNmGGIMQNtBmCfzI5nGks86ha3aM8DvE4Kbq0+xRyRVJhTBsfO4g9+
         aTICObIRl8C7mEOFQtFNVUloMVgoRhIVVCSYmSoG64iDV5lvSW2R7JAuUROc2hU5kdwL
         6W4Ypo0cYDzAvnemoIuJnG5pVV/X8p0QRraTH1umQXTPIZSBdEUL5EsCOnwku2gUSF3U
         GGh77zOiVLrSowhVcwWwyc5JsUycnt4TPtpZXbAcSFhRLLPr0ZhlneYFiQIEXo89WjfE
         3MpQ2XvaV26GeI482Y5XNjiUaPVkm6sGMq6d2EFKWQkW1uZZvuzQ+3KS/DZ2MQV+jv73
         flFQ==
X-Gm-Message-State: AOAM533RM5GaVpKdumBGA0/h6QAszKNubj1Vp+uck3b6gMUS4R0OFKOI
        6cc9TWuuFUb2513+68q0cQ8jCY+5rmKKoxdTxcucberVZQ==
X-Google-Smtp-Source: ABdhPJxjT5s8z475hVUXoJx7hmXYcaKgRUJho6DHeYEfPJYQDsHCV2zbFs2DyqcPnOlNmWEJ646HHJaUqKHcFeJ+3WA=
X-Received: by 2002:a05:620a:8c8:: with SMTP id z8mr28673011qkz.32.1619617151669;
 Wed, 28 Apr 2021 06:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210427135550.807355-1-joamaki@gmail.com> <20210427135550.807355-2-joamaki@gmail.com>
 <CAEf4BzZ8iQ=ewupN0COpV78k+fhGvPZ4NHcqckZcQcmV=A6QXw@mail.gmail.com>
 <CAHn8xckARwp_yK477xTvzFCwU9oBwAoZ4D2erg6HRmoe5in3Xg@mail.gmail.com> <5f7259ab-05a5-1e30-a87e-6ae5672c50f1@iogearbox.net>
In-Reply-To: <5f7259ab-05a5-1e30-a87e-6ae5672c50f1@iogearbox.net>
From:   Jussi Maki <joamaki@gmail.com>
Date:   Wed, 28 Apr 2021 15:39:00 +0200
Message-ID: <CAHn8xck0cMKsuXbLiCT8o98_i6iLH4nv8Dsq8LZaFYB_gYcpWA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for bpf_skb_change_head
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 28, 2021 at 12:49 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Yes, please, that would be awesome to have test_tc_redirect.sh reworked to
> run as part of test_progs! :) Then it will be covered by CI [0].

Sure thing. I'll rework it and will follow up with a separate patch
for the rework and then v2
of this change.
