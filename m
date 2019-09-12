Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339FEB1612
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbfILWBk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Sep 2019 18:01:40 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44630 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbfILWBk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Sep 2019 18:01:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id w195so17267897vsw.11
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9wRQrow4UfJ6ztoHYRc60iXbG4ypvNvP3NWX1o5yGbc=;
        b=PxELN7yrSwTB4xo+2bLpaVJfsP1CZ2XgWh4CMmNQvMkqXfQeFK5XwkVPe2b+VnYE+T
         aWltXDhAKAhl4Lo0eaUv1JtyqdJ17dnMJrI0kWwghWC4TKIlZl6BPMLwqSR9GvwnWpXL
         3dQq6KK38SlBWbbBlJ/0K+vRSQXhJOZPXgflx2PBroAmY67bxncD7pbewZaNmvtPqex1
         ePDs8fRmPHjPeXMj1NIYkGC78AZ9pL27uLr9CC3DxmsNegLlJgpSZqflsteh22E+fZe1
         CYeXys+yzL6ieW45Q6qHa8+IByR8hLKatwtP9WFg+vSd0+2i2XO+R6j8Qkp9q53J6ZWc
         TFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9wRQrow4UfJ6ztoHYRc60iXbG4ypvNvP3NWX1o5yGbc=;
        b=H8Nk3EB1f2TaGwH0ETVsfltXSdD4c1A1rwm0vU87p+Um4Z68w1xJIMXtxmN1YILPu5
         LwMq3A6vUjDBvye4NWaEYWsVaMb4zOrvV/nuWxMRU07oD9NKldOirYsrdallc75vUvDH
         2NZbYrATTjAQEIlQqRn4se1QXV3q6WXeVg9xyjhDmcNSnQPbYaP36yOwukj/VNNqxLWU
         NtZo2gwIcGZD9C0mxt0y4gTBFFMNI1PCVwHQHDZfhprWtg35e9LI9tddzvebCTWZStjP
         hH39nzYz/znp1BAUSXgCMr6h6fP7Q4HDbu+nxnp889RrRRB+xEnfSMGrGYbxtLscLVot
         M/mw==
X-Gm-Message-State: APjAAAWbH5hPJKLKme+sHrhyJea/K0xoTfvXoT8hnCBHuCESAq6v+Gqi
        lQgAqG6X6RaUYuyeTp/fEKdqkgN2W20d9jlYnXPQBQ==
X-Google-Smtp-Source: APXvYqwOIR+nO2xo9jz6XlWFxYmYYiHtr3f+5//ql3mmEGAjn0NapuCi/tlDGlTL/LNaZEX6ibdgwOplPpvgIHFSOXE=
X-Received: by 2002:a67:b911:: with SMTP id q17mr22872278vsn.104.1568325698476;
 Thu, 12 Sep 2019 15:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190909223236.157099-1-samitolvanen@google.com>
 <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com>
 <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com> <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com>
 <87impzt4pu.fsf@toke.dk> <CABCJKufCwjXQ6a4oLjywDmxY2apUZ1yop-5+qty82bfwV-QTAA@mail.gmail.com>
 <87sgp1ssfk.fsf@toke.dk>
In-Reply-To: <87sgp1ssfk.fsf@toke.dk>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 12 Sep 2019 15:01:26 -0700
Message-ID: <CABCJKufGy0aRDSUPQEOKYZ9tLjqwQDcDaTW-6im-VfjkB_gUsw@mail.gmail.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 12, 2019 at 3:52 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
> I think it would be good if you do both. I'm a bit worried that XDP
> performance will end up in a "death by a thousand paper cuts" situation,
> so I'd rather push back on even relatively small overheads like this; so
> being able to turn it off in the config would be good.

OK, thanks for the feedback. In that case, I think it's probably
better to wait until we have CFI ready for upstreaming and use the
same config for this one.

> Can you share more details about what the "future CFI checking" is
> likely to look like?

Sure, I posted an overview of CFI and what we're doing in Pixel devices her=
e:

https://android-developers.googleblog.com/2018/10/control-flow-integrity-in=
-android-kernel.html

Sami
