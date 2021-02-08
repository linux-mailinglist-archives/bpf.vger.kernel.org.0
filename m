Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C31312CB0
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 10:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBHJAx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 04:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhBHI7J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 03:59:09 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB7C06174A
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 00:58:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id df22so17194748edb.1
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 00:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKYEJmK9rcagPpO3hZaMVrlh/QuxZwBhXhA1Z35Mpa8=;
        b=NzrSvrYrv8erFFNWpF6GK7qPWJzKANl0XKcwKrg/H5XuJ+Eh94/TNkB41VYW5g3RPv
         cQhOKPtyds3XbsvMj7ViOfhquXyQk/lLq5BNOGqgMVzxWYI5hM6z8oIinIjrXLDGYF8R
         xftnv+XsN8JkyARsX9T14sHKr41CXCcC8hPW0c42+jUYSXo2J1s9/TZvXFeWNz0uIbUP
         uBG4weHYj0Aesf40IKvCuFlI+cQZlUPL+cChAEA+kAA8Fy2HRWBUNXqzs5GN1yZ9aVzY
         Jw/pLcw7GYIEQopGxtBO6T4zYd/evO6LyqY1QC5yTvLZ9Iv7r2hLlTSwUxSvGSYxWf9Y
         VC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKYEJmK9rcagPpO3hZaMVrlh/QuxZwBhXhA1Z35Mpa8=;
        b=L29CQgXa07MEYTVBvJ78DHvLQBFmQl2crKhDUJH/gPxh/8YEH+jdQ4Vwz23ZRTXslZ
         mpWY92JsHsi4H2Y4iHMnGxHX7isEwjd7cEmyJ9ahvY2qckhg7hiBZvv5yGXLRBWvGDpa
         8pPCTjTgf/sePu9ErCEP+3jf1J5Ec3qR2Jr4282sRiqBnajsCduGjoF4jy8kgVpbSSZa
         IlLnE6zKHYo42y7oqtUyG3k+aNo9rs55iz3IPAZpAFIgVjjucU0dHS0MDfpgWpv7wrC7
         KLM09AIwO5te6zpSlfuDFu8bt0XDU9zOxHoG3CkEd61l3ebU9MyjPY2PcD/M028MBHpn
         7R0Q==
X-Gm-Message-State: AOAM530jHJrGB5D9DT3nfnq939d76XL8NQXZrJNlLvjSgtj+44InbuUL
        Ht6OlkcQTJg6a3E37/ZtW0LoPtSiKT2oAQfhwd3VHcmJfW6rGQ==
X-Google-Smtp-Source: ABdhPJxLpQIaGn85m0Usj/hmLOivWT0rhiiDehm/NC8/WK7wKHBqy5m7ri0bCuzN2rDAicZOVt0wiEV/HBFY92tkoGc=
X-Received: by 2002:a05:6402:c91:: with SMTP id cm17mr16556627edb.219.1612774704348;
 Mon, 08 Feb 2021 00:58:24 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
In-Reply-To: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Mon, 8 Feb 2021 10:57:48 +0200
Message-ID: <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
Subject: Re: libbpf: pinning multiple progs from the same section
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Also, is there a way to set the pin path to all maps/programs at once?
For example, bpf_object__pin_maps pins all maps at a specific path,
but as far as I was able to find there is no similar function to set
the pin path for all maps only (without pinning) so that at loading
time libbpf will try to reuse all maps. The only way to achieve a
complete reuse of all maps that I could find is to "reverse engineer"
libbpf's pin path generation algorithm (i.e. <path>/<map_name>) and
set the pin path on each map before load.

On Sun, Feb 7, 2021 at 1:35 PM Gilad Reti <gilad.reti@gmail.com> wrote:
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
>
> Thanks.
