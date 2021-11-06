Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD70D447046
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhKFT7N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Nov 2021 15:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhKFT7N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Nov 2021 15:59:13 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D6C061570
        for <bpf@vger.kernel.org>; Sat,  6 Nov 2021 12:56:31 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id d10so32076958ybe.3
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBiLur7cgz5df44IEpiZd5XBiwgdR3uUccMS5wsXqL8=;
        b=g5/g9VHSiQ6dC1Kc11sACKWK/0VFeKgQgZXVeAFFhNs7r4fHVRnA9D/2jLntyHpVef
         7nhW7l4LgE28JXK1/1yCVR9oYxKEzT2jwY3U5men142MeLUMmgkr8XermdWXe8VtLIxe
         nnDsS07LW/mTc9jNIv7GQc9wx483U1a9hT8Uzcl2ISdGm00r8A0QYUXZgXRlj69cNIRL
         8mmvZb2zGQ6WUnV5uFhdO/8rfu7ZfThq61JeNuUsWURdFe8BrSXqDOtXOac0S2sp6omL
         mi30IPxdykE0PDIvi9c9ijECOsfsYZ9O0jrd29vMtgAvFrQX/MnYEsPTugrDHCCSbJ1p
         dFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBiLur7cgz5df44IEpiZd5XBiwgdR3uUccMS5wsXqL8=;
        b=YFxRu4ourM2dmrtdzNxB2hu52gfDjsC6I6PR96I6Chb7C3Q/6wnPMK2IWP6wgP5Pl1
         tOmx62ubgguV1HQig9JJP/7K12BbVHogQeRVhKDiUmsVUalkXyP9IVvHKElqew0TEnFx
         Rq+ALqTZe/PATqjA4xpp0PNtOgNjpghGQiLYuil0bLqFAIycuGvCyKTqB5Ji/0i86lyE
         HIMRC0BnN5Ub/RDYwXtZ0MmFVy9bGg6aO8hJru8UB7HOee1CsxTYvYHackEkcgFkJAkQ
         h26AQ2optMLOaa16qA7lkCDkPsi3b6Q1oXnWqQBL86hY3Dg+FE43AobYHGVKrM12fKOp
         DsFg==
X-Gm-Message-State: AOAM531F/498gwkkwGlargytCTS0j6IppKgHHSfPFvnW9C97Dtg7X2IB
        67ui4EbBNrKWgj3c3Gq1u+8dKM05lgtfBFjAcdARAvSu
X-Google-Smtp-Source: ABdhPJy4g9gWcFCIOGQs+xlKi+9Yyne5oSHT/ZLHJ0AWuj3H4aTbbOHgewD8xaREHeKwhLQpdOAkL9nxddh6+4uwb6c=
X-Received: by 2002:a25:d010:: with SMTP id h16mr67453714ybg.225.1636228590649;
 Sat, 06 Nov 2021 12:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211105191055.3324874-1-andrii@kernel.org> <CAADnVQJ6REFCJZYCLzk0NNqo5p9C5KpOmko9REaF1KYkBEaa9w@mail.gmail.com>
In-Reply-To: <CAADnVQJ6REFCJZYCLzk0NNqo5p9C5KpOmko9REaF1KYkBEaa9w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 6 Nov 2021 12:56:19 -0700
Message-ID: <CAEf4BzaehmbFQ50tZrZYtC+cTe+XTPBs2KBEXsjnmsSHWBYoUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix non-C89 loop variable declaration in gen_loader.c
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 6, 2021 at 9:38 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 5, 2021 at 12:11 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Fix the `int i` declaration inside the for statement. This is non-C89
> > compliant. See [0] for user report breaking BCC build.
> >
> >   [0] https://github.com/libbpf/libbpf/issues/403
>
> I'd prefer to fix bcc and/or its derivatives instead.
> It's year 2021.

Fixing BCC and derivatives is a separate topic. This is the only
instance of non-C89 compliant for() loop in libbpf and I'd prefer to
fix it at the very least for style consistency.
