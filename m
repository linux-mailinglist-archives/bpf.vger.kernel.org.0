Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A16496820
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 00:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiAUXNH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 18:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiAUXNF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 18:13:05 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D008DC06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 15:13:04 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id w5so4667812ilo.2
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 15:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwLuBrwe75SQOIMRGoQTXbtTN5NgEGbvHUDJG0ei2hY=;
        b=WyngFcgMiFelBlIP+WVV8v/BFzS8n+7p/g+BwI/2VgfB9gqx/nvNNaMkQMHqturdKe
         Wp7fblgjxIDfxHl9Gk4R0jlLA+Y9CCPq7vp9AqinFmy9NaUOQMg/iAgbBuGnRhxeMTzV
         Wwh6Mfqk50LbJVFmP48wz98DLDhu97ICd+ZeRhKiaCUetF0CAh5erWDpU17GEa1bxd/b
         BmJw7lHGHYT/+fNOKPMCZUhy3fPW6o730OPPzI37JW5WIkOAeyRWg2MlubaS+2tN5lo4
         skVi+gQU+ayONOcOQXSYeUQSohoO9HVn4EMiLrb8z4l9W/m888b6uSP0Cs+/PHt7Rlns
         uwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwLuBrwe75SQOIMRGoQTXbtTN5NgEGbvHUDJG0ei2hY=;
        b=O05BfcN7SLXj+f2IxwJ8X/4o1M5HKZLLnf14mE5VmJZ4BHEpiTuxZCKcktbv96lt29
         YXbCOSlKwA84vQE07jE6EKYEX0b1YQJsD2QGxu0gMtHJCcPpM+Iu/DbnRTgKG5ekswWZ
         O+YD4jvtTp5NP4TE27zW2zwCRXtRlFgbMfXXT6MLmQCL603DWXvr1z6Pn0ycVwRTcqQh
         e20E6seAQwgy4GibUJX/SgqYAbd57/2uxOuMaJSPYXwWs8CTjLVHNKOqgZjj7Z+54jRa
         lifxhzbYikEVs5XHSWtNakoxOwolhnZkI19hN0JdWd1hrTRON6GXFtv19u9kbIBJ0x99
         +6Bg==
X-Gm-Message-State: AOAM532qa6ymmfvRGVkzKSihbKNRc5TYHV/bnZh29T4A7cs+d626sxsN
        Bg2bXRYsDENoC+U42sRgN/akOB4KfyZhnAHBW58=
X-Google-Smtp-Source: ABdhPJxu/as4t3i8XoslFFqVzHdE4XI4lVCDTFWNCQWLOjRP3S+i0HMpUxLIvFCIcHdkzqeurZxwwNxhFpvBQRfi51c=
X-Received: by 2002:a05:6e02:1c01:: with SMTP id l1mr3531844ilh.239.1642806784098;
 Fri, 21 Jan 2022 15:13:04 -0800 (PST)
MIME-Version: 1.0
References: <551ee65533bb987a43f93d88eaf2368b416ccd32.1642518457.git.fmaurer@redhat.com>
 <87tudynstg.fsf@cloudflare.com>
In-Reply-To: <87tudynstg.fsf@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Jan 2022 15:12:52 -0800
Message-ID: <CAEf4Bzby9dSfwaoSKmxCRx9kOwz=HbrS6pfZ85+xqeVJ4v71WQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] selftests: bpf: Fix bind on used port
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Felix Maurer <fmaurer@redhat.com>, bpf <bpf@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 2:32 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> On Tue, Jan 18, 2022 at 04:11 PM CET, Felix Maurer wrote:
> > The bind_perm BPF selftest failed when port 111/tcp was already in use
> > during the test. To fix this, the test now runs in its own network name
> > space.
> >
> > To use unshare, it is necessary to reorder the includes. The style of
> > the includes is adapted to be consistent with the other prog_tests.
> >
> > v2: Replace deprecated CHECK macro with ASSERT_OK
> >
> > Fixes: 8259fdeb30326 ("selftests/bpf: Verify that rebinding to port < 1024 from BPF works")
> > Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> > ---
>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

I've applied it to bpf-next yesterday, patchbot missed it and I forgot
to follow up to notify, sorry.
