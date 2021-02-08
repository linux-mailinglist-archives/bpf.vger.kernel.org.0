Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F385314313
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBHWhF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 17:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBHWhE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 17:37:04 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61964C06178A
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 14:36:24 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id m76so16261173ybf.0
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dngxVIqoYL0CjN7G2OWS1w/ePKe0TjBYw0lCQdN5t8E=;
        b=pQwcCboiFrpwPE8JpmRkeIrqdRRRndESJY1RvEn/G9wgb2F7wi4aQtA+IdRIVIzbW7
         g6sFhX8SyNZobY6D0OkKhZlJblZ3yW32nJqCkGdWIA5Jr3famcpGX58jowcZ/yRDGE1M
         3Lz33K8aK4KpdKjX4l88N94aKCgQJbTlzSvO+uxagfwiosCRBhwOqg9vHh15k3ZyrFQ3
         maKuD9FiM5GJ7kXadJ0RqrjMFehX1aP1HolYw/QG9XUG/DLeCFSD/Ax7697jouu6U+/g
         ZgBIsEkdtUS52NOKv+qvTvH8MVu+r0jkY5EnqxHKVxDJqB/rw4MiZQtAp0QY8Tya+B9O
         IMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dngxVIqoYL0CjN7G2OWS1w/ePKe0TjBYw0lCQdN5t8E=;
        b=tM27oF2z0wp7vKsccaL/QT78QytpHdQfJAVm2iRUrKXjCIMH8YqmYrxcmVlohDerER
         i+DvKOs7yguYpXv8MKYkrQXF70w11jmqYronk+ew0aMjcryT0poCupKef8ffHITFS9Rq
         xXt0q8BmDcwLJcUUgIYK4guSZm29HaxPlIs7d9ThibbVDCDcB4455uFBl5kjR/1oTAmF
         HC6FL36JBU/ZuB5TP6LPYFhnt2Awsg95E7miM3uawrnWxVclhEesYC1RFneyyIYH2R7B
         q8QhpVRv1/G/lv5FLkEx2rGZb9RuZVz5WOi3BoLKx6VmefQIXRAMy13TwcTFHuoSfMgI
         ZqBQ==
X-Gm-Message-State: AOAM532EqLR3Rid+5FItLAnC8nI3JAHzJhqEsBMWMiFjSBiBcoke02DO
        THve6wcS4JJlrYikNTsqlEFPwQLQu7kKQCOerWEj/ZApVSU=
X-Google-Smtp-Source: ABdhPJxMrIaGiGeKzYm+zHjQPwYwg7UeGwp4S4uABWrN05JXLd7Wg4chOKVBS/8+ydzZlHpG2qjE/YvjAJAfS4wVDvM=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr28734168ybd.230.1612823783771;
 Mon, 08 Feb 2021 14:36:23 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
In-Reply-To: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 14:36:12 -0800
Message-ID: <CAEf4BzZ3OCND+=+4CPnayFt9nf0HaG=yQOS1TLuMQnVk6d_z_g@mail.gmail.com>
Subject: Re: libbpf: pinning multiple progs from the same section
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 7, 2021 at 3:36 AM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> Hello there,
>
> Last year, libbpf added support for attaching multiple handlers to the
> same event by allowing defining multiple progs in the same elf
> section. However, the pin path for a bpf program is obtained via the
> __bpf_program__pin_name function, which uses an escaped version of the
> elf section name as the pin_name. Thus, trying to pin multiple bpf
> programs defined on the same section fails with "File exists" error,
> since libbpf tries to pin more than one program on a single path.
> Does adding the actual program name to the pin path makes sense?

Yes it does, but as Toke mentioned, that would be API-breaking change,
so I'm holding that off to major version bump or at least until we
agree that it's OK to change this behavior from the current
nonsensical one.

>
> Thanks.
