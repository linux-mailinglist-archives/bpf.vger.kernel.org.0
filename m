Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE281D1E9C
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 21:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390397AbgEMTLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390303AbgEMTLs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 15:11:48 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CADFC061A0E
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:11:48 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h26so468849lfg.6
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlDe1IobgVm68K0PtFybaGZyKFGHK1OfKry00qMtGtQ=;
        b=V1UkNiRNfL733X9vr+6V4+xkxNISM7utjyshsT36quvy8jA5IVqpf+k3EDQxjXOIYU
         JkvVkJQB05ajebE0nuwA1SP0j1/ZNVxXHdyZbBxtTdovrxuSXCzKJOTV20D7eG1vu7ZV
         OomJViLlEUU/v3q1g+qPNyPfCuDydticNEJPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlDe1IobgVm68K0PtFybaGZyKFGHK1OfKry00qMtGtQ=;
        b=iayHEZ+GvXcUhA7t/tglvefIZ71DpOoM88et5JLn3EmoZw1iDnhySrCaerbaWxQ4m2
         VOqDWRnAKNh97L6Pu6Ab54WMGmTdkqwPKyh08flYzL40ubkTxrJGo1m92SKjzt6qOO2Q
         d64m55S16i9rDH1N/DLrjo1z/OKpbpN3KXfPmoR2GZCFXTa/QvV4fwmCO1sbF2/HaEqd
         M7hVNkVdm6zM8h+DO2PYuEwx8lk8BajweTDaZma9Z8KtBTKbsVLYscjXIBohVJWfvOLf
         vgi+hsX+Xm8jqn3aHOZV7z1G+CG410gZvK3Scm3jylF2v+HQ5RF4wwg+X28pT4Hc68HS
         CXIQ==
X-Gm-Message-State: AOAM5304uW0TWSCP0XDNAuT2t3UT2W4eqoRNGw2ga11DLRePVfHFoPQf
        /UEp4+iCBU6II0XUISl77T+2m4oN8RI=
X-Google-Smtp-Source: ABdhPJxRAeXRbmj4ABv/+nLI9KS6I43FYlOq8i10DJfe2lOnCGNgbwP6xlw3i/xgFOUJBTze4sfVIA==
X-Received: by 2002:a19:f70f:: with SMTP id z15mr619747lfe.53.1589397105172;
        Wed, 13 May 2020 12:11:45 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id z8sm287201lfb.44.2020.05.13.12.11.43
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:11:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id s9so497018lfp.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:11:43 -0700 (PDT)
X-Received: by 2002:a19:ed07:: with SMTP id y7mr627896lfy.31.1589397103373;
 Wed, 13 May 2020 12:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-12-hch@lst.de>
In-Reply-To: <20200513160038.2482415-12-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
Message-ID: <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 9:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +static void bpf_strncpy(char *buf, long unsafe_addr)
> +{
> +       buf[0] = 0;
> +       if (strncpy_from_kernel_nofault(buf, (void *)unsafe_addr,
> +                       BPF_STRNCPY_LEN))
> +               strncpy_from_user_nofault(buf, (void __user *)unsafe_addr,
> +                               BPF_STRNCPY_LEN);
> +}

This seems buggy when I look at it.

It seems to think that strncpy_from_kernel_nofault() returns an error code.

Not so, unless I missed where you changed the rules.

It returns the length of the string for a successful copy. 0 is
actually an error case (for count being <= 0).

So the test for success seems entirely wrong.

Also, I do wonder if we shouldn't gate this on TASK_SIZE, and do the
user trial first. On architectures where this thing is valid in the
first place (ie kernel and user addresses are separate), the test for
address size would allow us to avoid a pointless fault due to an
invalid kernel access to user space.

So I think this function should look something like

  static void bpf_strncpy(char *buf, long unsafe_addr)
  {
          /* Try user address */
          if (unsafe_addr < TASK_SIZE) {
                  void __user *ptr = (void __user *)unsafe_addr;
                  if (strncpy_from_user_nofault(buf, ptr, BPF_STRNCPY_LEN) >= 0)
                          return;
          }

          /* .. fall back on trying kernel access */
          buf[0] = 0;
          strncpy_from_kernel_nofault(buf, (void *)unsafe_addr,
BPF_STRNCPY_LEN);
  }

or similar. No?

                   Linus
