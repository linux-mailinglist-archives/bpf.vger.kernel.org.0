Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821AD2F1EA4
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 20:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390812AbhAKTIV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 14:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390644AbhAKTIU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 14:08:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B829C061794
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 11:07:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y24so859972edt.10
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 11:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=araalinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wd7NVgXB5CaPVl4tfaKDL8RVQkfmtcnQDbvwLh3kOtM=;
        b=UwxspV6MzEvfRaA/AdrM0H0GjQ5VvMW5pUyrjrbknyWPPlYtP9qFpDuT4meTyzY04n
         72XHYoBiMzhpVE4GHmanEWRotcWk9ctKiXfqBRYaD+8cA0WGHubRNN9fRGFbojmEjUAV
         THz3OBu8l1iVAkjKG1o6FvTnpzmHt0DjbOE6wypTfCtpo91+e//neCBpdcdlsUOmbkwJ
         eJtTXFnovq0OgJlmEq3eBwFAQcSvS7UCrhuXrDG2dzv50MBsRj+8qzUc7eFW/xI4PRHw
         LvtDeGsL6bKrOMx4aOK/mCuUKZuaZUyVFK2TXJsEpY0e6UbloVH/KNPmtHSmxFIXrfOw
         xwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wd7NVgXB5CaPVl4tfaKDL8RVQkfmtcnQDbvwLh3kOtM=;
        b=tMMvo7UzhDTqTqEeVr83/K05j9lus0vyG1Ge9YudLBmoutZTlaCwtDiR8vO5RdPqAJ
         YByabWLH2zbUp117rB/JD32XPBDBSD+ASlmhsyk3u3PqG9C7y53lJFci68nS+SQs9Q59
         6FWF6MQPYdalTeAod3+n69DXOOPYlKcHUk7wpRZQCbQWzcyHUSmJD2ukMpJIsballALx
         K1Y5DkXBwHY1DuGDJF8Fc9B0fZu1BF50nnKJSo7GFyc8LaKpiassdsP1/rcRARmwnsHP
         6RXdwtKdJg25V2MZGluD384Y12dceFN4Zh1FymuMNzyOOCvC53KEceGdbVTUxHX7w+Kw
         wMig==
X-Gm-Message-State: AOAM530ZHxdkhjiQXb8VjU7iqM2r7rn7SQcSqnfWKfU3lrBvNYFDOuJT
        9orKhC/bA48SWqv1B+niE1JON/aNOBrqsXj+B7AVqQ==
X-Google-Smtp-Source: ABdhPJyqTiu+6srNydSch5K0ESKcpO5JVa6fFbNdWmRj6mTyc6m1i7kFaCz3Bdb2OWl8xHt7pOcY6D5IzXoc0pqhXoM=
X-Received: by 2002:a50:f1c7:: with SMTP id y7mr627746edl.184.1610392059281;
 Mon, 11 Jan 2021 11:07:39 -0800 (PST)
MIME-Version: 1.0
References: <B8801F77-37E8-4EF8-8994-D366D48169A3@araalinetworks.com> <f5d58b88-cd96-4c78-ff22-4989c6b2ec96@iogearbox.net>
In-Reply-To: <f5d58b88-cd96-4c78-ff22-4989c6b2ec96@iogearbox.net>
From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
Date:   Mon, 11 Jan 2021 11:07:28 -0800
Message-ID: <CADmGQ+3X7xtrYaKbUsd-0U=-phHvsVBtfMBbEgjvWf7WBzmfFg@mail.gmail.com>
Subject: Re: [PATCH bpf v1] Add `core_btf_path` to `bpf_object_open_opts` to
 pass BTF path from skeleton program
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you so much!. Will follow protocol and get back here.

Best Regards
Vamsi.

On Mon, Jan 11, 2021 at 6:14 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/9/21 3:36 AM, Vamsi Kodavanty wrote:
> [...]
> >       Please do take a look. Also, I am not sure what the procedure is for submitting patches/reviews.
> > If anyone has any pointers to a webpage where this is described I can go through it. But, below are
> > the proposed changes.
>
> For submitting patches there is an official write-up here [0]. An example of a commit message
> can be found here [1]. Please make sure to add your own Signed-off-by before officially submitting
> the patch. If you are stuck somewhere please let us know so we can help.
>
> Cheers,
> Daniel
>
>    [0] https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>    [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/patch/?id=e22d7f05e445165e58feddb4e40cc9c0f94453bc
