Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519A732A464
	for <lists+bpf@lfdr.de>; Tue,  2 Mar 2021 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578067AbhCBKfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 05:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381334AbhCBFVD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 00:21:03 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831DC06178C
        for <bpf@vger.kernel.org>; Mon,  1 Mar 2021 21:08:29 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id l8so19405059ybe.12
        for <bpf@vger.kernel.org>; Mon, 01 Mar 2021 21:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPgcs4YS6eZgUZc7B9+48QsU7eT/LBFcMNTzG59UqOA=;
        b=uhAeV1TfripxAituyEmM1XmVxfCtvlc08dlJE8RfBt9VlhUfQtv5FRA8OQpu0EqdKo
         LTIG7Z+f95Z9dYMB5znMi3lnKcBwJevRQuvPih+cdz6oeDg8ZO/dU70gBUo9Ru6QfDHm
         OdXg7YXpM2qvDmstKVOrxsF7mpEiSw8IVcJjB4TrriRckiQKlAFMwUQTsjBL1OQn8CAe
         ZXXe+8LXiKZtX0ABg8tfuN4W3PVI/AfpvsfJmgMwduS+7eu885xQiVP3ulXbGUF3SX3B
         xMaaAvt3Vz6K4+7TbYaa/y0VaJE8pF4ltAgNAVPscdqnn8LJPD7l21L4IiWgC7HVeqsk
         58Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPgcs4YS6eZgUZc7B9+48QsU7eT/LBFcMNTzG59UqOA=;
        b=pQXgPzeinEDTRb3YsCafG6uqfjhIkdLFtheeKmRybzsRhcInapAYd8M8luBFU2hGgm
         DR9LTzdwAaK5nfQlmYtNvTbs+QsA+jtjADw/mPYFofeV1WasJccOVzVtS+eH5CifW3dT
         lgNJARriV866CBdRDNlgl7Usqaz5vCXqhgPI16846RmVzaO1QWNsiLndzI7uYXqvNZKd
         sq0s4gv3/hbcaxVYhGTbCHFPZjElzirvQviwoza0r1VYNMZfKQzhyMxnev89+lxLKUBw
         cvTc5XM+k4gLahJScc2IiQQWP09BkalHoO7zEGNVtj3A/sbdrZO/p3Zx8dc9FLHJHD/i
         b86w==
X-Gm-Message-State: AOAM531WGLDXr7Zqgjjh6k1gB/epTj4EbJxroK7cdkQJ2nEC5jUmoPmH
        twO6GXcPqgAyTeQ18mZsnK9XHW/jUa2i5vqngmApFDtgwI8=
X-Google-Smtp-Source: ABdhPJz2sMC6KFigzzQ5+1IVPBucZReTJ0ldiVX1syvezSQdoPWV9nCJgBfJhOd9LLmTzGev7gopKIigKvXURoyyDEk=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr28616736ybd.230.1614661708392;
 Mon, 01 Mar 2021 21:08:28 -0800 (PST)
MIME-Version: 1.0
References: <xunyim6b5k1b.fsf@redhat.com>
In-Reply-To: <xunyim6b5k1b.fsf@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Mar 2021 21:08:17 -0800
Message-ID: <CAEf4BzaAokQ0vgsQ4zA-yB80t2ZFcc3gWUo+p4nw=KWHmK_nsQ@mail.gmail.com>
Subject: Re: bpf selftests and page size
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 1, 2021 at 1:02 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi!
>
> Bunch of bpf selftests actually depends of page size and has it
> hardcoded to 4K. That causes failures if page shift is configured
> to values other than 12. It looks as a known issue since for the
> userspace parts sysconf(_SC_PAGE_SIZE) is used, but what would be
> the correct way to export it to bpf programs?
>

Given PAGE_SIZE and PAGE_SHIFT are just #defines, the only way seems
to be to pass it from the user-space as a read-only variable.

> --
> WBR,
> Yauheni Kaliuta
>
