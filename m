Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC15FAA56
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJKBvx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJKBvw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:51:52 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5708F80F43
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:51:50 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s21so7506102qtx.6
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7IgiYSjmBsBJQKeV9u9+8ufTPboAbkwQqpBjZnmE/WA=;
        b=UtkrIZl5gMPWSA/qsg6tr5Xhqg7Ed1Qx2cJ3gkiN3heSI9ROQqfwdKFBPrhuoJm04N
         4BXMNM/jqGdIhXIV9dnSIcTtRvQWRioYHunieCIMH0h2HFORAdlqm7xHDYMCwYe/z/pm
         cPlgcPdJtcijaRaHH0TrWdCaYHcIYvjPZ+5SE5N1bbfbsqwVlbVLwf6jbyTDFBxoymPh
         +012iA8uocvMGzGCVgnCApR5ovxu9RCBTdbQgzOTohrF0wFzs3quhbqcX4To22aC5+5M
         Zq2jUGiKhD6XdpqdGYmlQl9kZxSl/HK8s/l2pima/gHKdzuqB1bOPiEl4gYgK9bqU9/0
         OKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IgiYSjmBsBJQKeV9u9+8ufTPboAbkwQqpBjZnmE/WA=;
        b=tBfFxZTPmpeTx1zQLQ9x8XHOHXFMFU0pMQhlXM0X4BUC3hgnJcBQz7LED7IXM1x2h3
         PDT2fchdQotQYR0D3XdFqUrRxwa2ev3cp319l6wTQQ2anxp9ObnhlTewxKlxPV9M7p3i
         XTGruBgPFd5jISBkQVpBw+eBkrEWO6/gTjMnkjpZlWNcIeBV87L3vrG4CkUmirUk9foz
         T677Cos1z5pMExr9+XGpRpL17LO6+hQMauBAzIVnaBv1xLQsklG9MekU5/xAOBzmWa5q
         hhFnt4bWIo4T7+gWL2HnvimjojfwHZbMXNleeADNIr5dfbtuyUiiC6hFPoevG5TKvkz0
         PJvg==
X-Gm-Message-State: ACrzQf17PHZLnhsQKzlUoh0YcpZfX7CMPbZWwtzdROSfNG7zSQTa/owu
        gfuegWBA+hZI7ImXXK4zKCFNyChJpO6uHy54QfWPIUwDwA4=
X-Google-Smtp-Source: AMsMyM6vSwhUL7Ka6+xOzC/eNavkIqXO3UqlRbYhBXfrpV6NX9e95e/HHWpn2PI47DZMtBHPYV++97ZIPqfm3cMJuOo=
X-Received: by 2002:ac8:5f0d:0:b0:39c:85a4:6747 with SMTP id
 x13-20020ac85f0d000000b0039c85a46747mr41941qta.193.1665453108819; Mon, 10 Oct
 2022 18:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221011012240.3149-1-memxor@gmail.com>
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 11 Oct 2022 07:21:12 +0530
Message-ID: <CAP01T75qtWr=hc-tmLVzSW1yY=Kf0Qn6X1hKa61yhCq37y+05A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/25] Local kptrs, BPF linked lists
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 11 Oct 2022 at 06:52, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Hi, this is the non-RFC v1. This is mostly a major rewrite of the previous set,
> hence complete review of some of these patches is needed again. I have cut down
> the series to only the specific pieces needed to enable other work (like Dave's
> RB-Tree). The rest will come as a follow up to this.
>
> --
>

Ouch, this gets a merge conflict in CI because Roberto's series got
applied just before I sent this out, and I didn't notice.
I will wait for a day (?) for people to respond (unless someone asks
me to hold it) and otherwise respin this again (it passes all tests
locally fwiw).
