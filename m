Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7143F3E8
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 02:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhJ2Acn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 20:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhJ2Acm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 20:32:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57843C061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 17:30:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f5so8106884pgc.12
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2EXEUGd36mDs8XGh5F/pWpvaCnHopa79OYuGNtli+Y=;
        b=ALINJ503w71ZuI63mwPiZ6QWP1fXHjS9uF+ytS7wIeWYNSIAcx1iJDsIQTRag2uxqw
         NY4hb6EprjFVccWOio5t1KFoqpvKV7iYnKr7atMPYqj8tuw2QQkMhMFoIc0spQMt+34v
         w5oLstnb9lKHxh1GJflr7XdsRvMFnlSHGZ9d6iTUsBW42h9+coS+RwBKFWYNQ5VgNoyV
         0Y8V/4cAe8mxWcPn3Bu/0CaZ819ye95ETM0Jy/7Krp40kq2TEXvv/SQruQMmXL2CQrwI
         i+x1RKSANLPjZl8UDXNzUhnTJdUGnL49UByi4BLOIkzSx60iaUsilE6LiKMPoEYQtDmN
         UZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2EXEUGd36mDs8XGh5F/pWpvaCnHopa79OYuGNtli+Y=;
        b=ocANz3g9IkLl+TM3FJQgSnFB/uA+eSLMwVXxZscW2ViAtYJJvrICh8tnkJoSMBC539
         4cP42ZesuD9sxf05m9xTbVDMYs4YTKZWZ4L90uc1Jv0Tda4jFTd4L1BphzKu4WIa4IP5
         UmdKlvRWRf4Ya9PUuPGDD1ZwX8ynU3gNnBCiE2E9+eS6NfCo4SgWkH2MPNg7lagphNiq
         7DrKb0OwnN+GEHh3RJ2O+3KOGR746CuR9KXaX5rkSaI1hcaBMWEk08w8IIEt8R1D65sx
         2ZWoX1GvuWTs5LMma/CRtfFDQCJVzL1/7vsx3OZWRZsXT4fgnDC9dsfU1f75iTpX6i2/
         Ty9Q==
X-Gm-Message-State: AOAM530bynXNdsQe1blqC+yW/GbrRuk7fgbuDIKn8dggOKAotAoAiKLN
        +iCAomVaY6pwiX2yTyE/9R6FzfvJYLI076PCsKc=
X-Google-Smtp-Source: ABdhPJz4mvekOy5/a8CiADVBtD3XFKXvtGA1M5QJunG3qdtAOqfTnbZQ23DCGg0xv1o+boyrwUKSHf6mifuER09F0yg=
X-Received: by 2002:a63:7b5d:: with SMTP id k29mr5643674pgn.376.1635467414482;
 Thu, 28 Oct 2021 17:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211027234504.30744-1-joannekoong@fb.com> <20211028221019.oinkfqhb3keuuzau@kafai-mbp.dhcp.thefacebook.com>
 <CAADnVQL8jdVfcekJ8Ch7xDJCU5nyXr-q+ZrqXY2enCb6DJPRqg@mail.gmail.com> <e8b531f2-71b2-044f-93be-2a42dfb3610a@fb.com>
In-Reply-To: <e8b531f2-71b2-044f-93be-2a42dfb3610a@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 28 Oct 2021 17:30:03 -0700
Message-ID: <CAADnVQL_fc7kCNha1rfWKv0kExHJc3-pSpCskkS76pDASV5K=Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/5] Implement bloom filter map
To:     Joanne Koong <joannekoong@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 5:24 PM Joanne Koong <joannekoong@fb.com> wrote:
> > Thanks for the detailed review and sorry for pushing too soon.
> > I forced pushed your Ack.
> >
> > Joanne, pls follow up with fixes for patch 1 asap, so we get it cleaned up
> > before the merge window.
> Should the fixes be in a new separate patchset or as v7 of this existing
> patchset? Thanks.

The v6 was applied to bpf-next. Pls send a fix as another patch.
