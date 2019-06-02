Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63232236
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2019 07:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfFBFEM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Jun 2019 01:04:12 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:39868 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfFBFEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Jun 2019 01:04:12 -0400
Received: by mail-lf1-f52.google.com with SMTP id p24so4551326lfo.6
        for <bpf@vger.kernel.org>; Sat, 01 Jun 2019 22:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHyg1SC3FllPgka54jq3AQ9wONvMiE0dHU5mTQEJJ4E=;
        b=Gl1xIZaFyqni3kz5UpBTUS/G2lvufHMeY+O2czSaOtpJTeZyGOFA8+mrpyLcjIkMQu
         9ktjAowVCqOueeyv8WG/7cf1uFrwG46H451FwjD3CayHVFHZnvoBUcXmI9Z2CE6eedDf
         4ZvtQ8ZNVEQScaYrCE2P/xo2SMCZacQwK8DYtHrtzBf8HpWwPo1BsOPUJ7HsQs6L248e
         0ec6vqMwdeAWyQvTwt1p+OI8jojDoL85K+OjjehHb8D4WPVricCo2FHtkoLmtNTv2Pfa
         GuSZBJDtI0cMko7zjXjPXwDEMa1MNhq4x1zttjZCV6Atn9+cemjHYuk67IHLyjZj6t+6
         +CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHyg1SC3FllPgka54jq3AQ9wONvMiE0dHU5mTQEJJ4E=;
        b=VUmG8LJd2oQ986VV7fqHMAe+gLQKCP01lVFcLWlAQgC1U7s3qgfdi95b7JLU77k3kD
         TRIcsahupn7WjPkCEdu+Fk4BhvRCoAcfcEleo9eeqM2WaQYXirdY0h1izRK/vICr54r3
         ZxP3WPmiciFuUG4wwM/QlCIyBvw5peuOvoKL8iL/kY0XgLoMNXlGHMakaJL5LK1KZ+pF
         GoVqtc8e4h68n9QOV70rk/nqDmPk/qK8RElhnoYKBpZ/MltJdXPO0PtI+gIowNEEKgWr
         U3TXFJ0SaVwI5W7SU5MmI7uQbSQrJM+tDrCYXJ8WlEbqSTsJsh0PkuYluOyYpSldbCJ9
         25HA==
X-Gm-Message-State: APjAAAUQizZ3XN9P828Yt7SMCgQzWxCnNYLyDVpjxVcw35Bu27nni4B4
        hz/i9J/ePWq6Xh1K+QPUsri9gsbWlbYQdIw88YBWTw==
X-Google-Smtp-Source: APXvYqwbFWFtHQD4kFrfiCv/4reJB4VO9ftbPmdLCjebGgZ/Fz7Qfu2G0w514nIThZsVSsyBlHyXCxcKHF6UcgW+CD4=
X-Received: by 2002:a19:ca0e:: with SMTP id a14mr1638157lfg.19.1559451850631;
 Sat, 01 Jun 2019 22:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <f0179a5f61ecd32efcea10ae05eb6aa3a151f791.camel@domdv.de>
In-Reply-To: <f0179a5f61ecd32efcea10ae05eb6aa3a151f791.camel@domdv.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 1 Jun 2019 22:03:59 -0700
Message-ID: <CAADnVQLmrF579H6-TAdMK8wDM9eUz2rP3F6LmhkSW4yuVKJnPg@mail.gmail.com>
Subject: Re: eBPF verifier slowness, more than 2 cpu seconds for about 600 instructions
To:     Andreas Steinmetz <ast@domdv.de>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 31, 2019 at 3:55 PM Andreas Steinmetz <ast@domdv.de> wrote:
>
> I do have a working eBPF program (handcrafted assembler) that has about
> 600 instructions. This programs takes more than 2 CPU seconds to load.
>
> In short, the eBPF program selects and redirects packets, does MSS
> clamping and sends ICMPs where required for IPv4 and IPv6. The eBPF
> program is part of a project that will be GPLed when sufficiently
> ready.
>
> I am willing to cobble something testable together and post it
> (attachment only) or send it directly, if somebody on this list is
> willing to investigate, why the verifier is having lots of CPU for
> breakfast.

Please post it to the bpf mailing list if it's reproducible on the
latest kernel.
