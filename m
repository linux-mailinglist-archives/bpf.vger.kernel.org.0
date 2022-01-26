Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1154F49D2E5
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 20:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbiAZT4B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 14:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbiAZT4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 14:56:00 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB8CC06161C;
        Wed, 26 Jan 2022 11:56:00 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id y17so668351ilm.1;
        Wed, 26 Jan 2022 11:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6RO97B9TBlJ2OjwiMWS9dWxSyZSPIaBo5bOwKMtyAw=;
        b=Bl02IxqJjTHiHHl9IoB6VqFZyd3eAqeb5UnD11SJFevjMmKeMZeIl4+u7ywiimsb4s
         OvXLBGcE6T21XdR4MBVoBFzmUOgQ06p/0/3o2ZzUBa1GShZVq6rAwj9jqsMYA40shD69
         Yp5gSr7kAOfyrRqrL8Amg4vqkFN3sfF3EgcO96or+Uq6xAxfaXBAZ7vnVipvpuyQOszG
         uZl1ASzLQlFViUjXTJ2Ot2h8BQkO+MH4B5PejgGG8vjuGbRNk05Sguc3MSeTrBbdh7nM
         PoeT2Rxz2jC2mBleb4pRXwuYtVi+NeSrs3eeiLi3FwK1v4X132lC/Ny+HaZW6ylm7qHS
         hwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6RO97B9TBlJ2OjwiMWS9dWxSyZSPIaBo5bOwKMtyAw=;
        b=cLQ5PLDjw4RZVlh0KEEfxkD968m5Dtvj+56NNm2rnjTWCb13OeWPEc/nNYjQsvnTnH
         qggzPte/CitIZ5JGvfn1rViCkArak3HIg/EyN00D/nF7Z7XkPbc+5TkzbpVcil3bO5sG
         CIoTF/t9ol8fZ0UCNG2nDnKa9yErd8vSkrg/RSPzIfIERLklP0eoxBi3hiffL+UkXc0k
         +s74rHyu7yCMdw2/iHxFEEk4oyqppsD585MpEJv56jV8QX+wjmEMP3PWvgXiLCRcW5mO
         lrc7kaBBMcCQau4salW3sFbTGASO6d7835zFmDg7LDfNpGlaWpmQoa2PHJgW8qS//YbH
         sPFw==
X-Gm-Message-State: AOAM53345/aeqUr1S2iapS0TFf3MYrw9qGjOggwwvlTvaSA0wz8nyZYF
        Wb6Mur5XQeuL2usYOy2TQJRosM/501WzwInHElY=
X-Google-Smtp-Source: ABdhPJyP+7trMSyA28gfCiZpZL1IkKGYWSwwKU0ZoUquMvPN88No3O9wC8y3RfIvzPmZJ40XRn67Uf7vMxBcpmvsDCg=
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr470667ilv.252.1643226960163;
 Wed, 26 Jan 2022 11:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20220126192039.2840752-1-kuifeng@fb.com> <20220126192039.2840752-3-kuifeng@fb.com>
In-Reply-To: <20220126192039.2840752-3-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Jan 2022 11:55:49 -0800
Message-ID: <CAEf4Bzaxft_sk9PnzEJZJET6rZMsJq8moJD0VE6B2OhhUDUfoQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 2/4] dwarf_loader: Prepare and pass per-thread
 data to worker threads.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 11:20 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Add interfaces to allow users of dwarf_loader to prepare and pass
> per-thread data to steal-functions running on worker threads.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  dwarf_loader.c | 59 +++++++++++++++++++++++++++++++++++++++-----------
>  dwarves.h      |  4 ++++
>  2 files changed, 50 insertions(+), 13 deletions(-)
>

[...]
