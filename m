Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8678B1EB0FF
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgFAVhd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 17:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgFAVhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 17:37:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739AC061A0E;
        Mon,  1 Jun 2020 14:37:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w15so4814434lfe.11;
        Mon, 01 Jun 2020 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVZG2Doh1PmLAHVn6vdj6AlyPcscZ+MeO0l2qGEctuM=;
        b=US7Mg1/e++fEaTDMd+METlG/dC4cutb6FNfgoozF5Ue8ccMAgVKcCugdaNrzWb4VPU
         bcw6CB2NI7T+mD/zqugAeUqqXcgye0luQGh12pJtl2zldqnCioL4me5utiLPLXHxNUOm
         4Rq5lq6+OP+zjv23VwtY2hZfZAM3wnjNNoff79nWA1onEjrYGtOQSE14r6MGYG6qXpE5
         ILEZMy0+ahc7xSjEHeOGmabLhROPvUs8Dkg/AVUd/UCE6e3CWup2rLjKQu0HlyzsePeh
         3Vct2/OHDp299WBD1lwfk12ws0I3wTJDYPdoMZLuaDcYBKKxXDIK/C59yY+Bpa50q2o9
         Qvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVZG2Doh1PmLAHVn6vdj6AlyPcscZ+MeO0l2qGEctuM=;
        b=Moyqx00LNzhVyygK3d8XWP4ev2nUAa7HTe9NN9HoYPTWiRdfRlq8N0ZFOFXW6fc2PI
         TkzFDRA/smrP5Pu0+wKGAp7eqXHu3ziGJ4eR1DqxyFsqZ4P3suw7vk9xlF2ThfduD0Pg
         vkcEVuhubezhOVAdxrLosxiRJbkPGLkPjMBqo/V65TSz5f/TJnPQDF8BmJayd/E7F/ib
         hFqXSVCrVG9cAh6+2mJIgrD2zTkqPrMBJmLWE9VIYtTbyX799xPA8tekLZralhGnzbU9
         ALyYjzfXaDYFsA4v7sxFm0f3ZmxIH7YU4KJ7Y2yLtTI6EzuSUbkOljWy9fZn4L09J20e
         weYQ==
X-Gm-Message-State: AOAM531xGKsaLZo1NgVNHKrrM4KUBL4RNG17SXOjBIMzj7gjKv1e+GuZ
        bEJmPat2cHIgOkXM5AMWg2L8dqg8gDFCErvotDM=
X-Google-Smtp-Source: ABdhPJx0wKxCx1tuEQz3JPrKzy9DBuNn3hdYHSEyaqvtmamlvctvFYIFXglyfMWBSHgnUsa0WZI7R1VfHAV0noxa5qs=
X-Received: by 2002:ac2:5f82:: with SMTP id r2mr11760068lfe.119.1591047451409;
 Mon, 01 Jun 2020 14:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200601162814.17426-1-efremov@linux.com> <CAPhsuW4nHJ6ewZ6U6EyJYUx7AFpde5D38yRykK3Q_cGf7sgBaQ@mail.gmail.com>
In-Reply-To: <CAPhsuW4nHJ6ewZ6U6EyJYUx7AFpde5D38yRykK3Q_cGf7sgBaQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Jun 2020 14:37:20 -0700
Message-ID: <CAADnVQJOO3eGgmJEhpT4ScC1ps_DSKpoH1Q3X=RjXJiRJg_sVA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Change kvfree to kfree in generic_map_lookup_batch()
To:     Song Liu <song@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 1, 2020 at 1:18 PM Song Liu <song@kernel.org> wrote:
>
> On Mon, Jun 1, 2020 at 9:29 AM Denis Efremov <efremov@linux.com> wrote:
> >
> > buf_prevkey in generic_map_lookup_batch() is allocated with
> > kmalloc(). It's safe to free it with kfree().
> >
> > Signed-off-by: Denis Efremov <efremov@linux.com>
>
> Please add prefix "PATCH bpf" or "PATCH bpf-next" to indicate which
> tree this should
> apply to. This one looks more like for bpf-next, as current code still
> works. For patches
> to bpf-next, we should wait after the merge window.
>
> Also, maybe add:
>
> Fixes: cb4d03ab499d ("bpf: Add generic support for lookup batch op")
>
> Acked-by: Song Liu <songliubraving@fb.com>

Applied to bpf-next. Thanks
