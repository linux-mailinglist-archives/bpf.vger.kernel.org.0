Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C723941C31F
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbhI2LC5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 07:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245626AbhI2LCz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 07:02:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCF4C061762
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 04:01:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so3619609wrb.0
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Z6L+j4zKC5mwS2K6Vzz9EZbJHlOytxXoT9Hbkkw8oQ=;
        b=EZpKgdzBFIcGT3DnbiBYSbHQHO4PMtixDuggsUkTyxE/zUBk2STDNvWY9uvUUmZh5T
         3EN9ewItLMay+WD4/Q0+xebLviBs5/X6tTGNPYJB4kFfHSagvMyNvXQkwi+xX0IwIE4J
         zV1Fz7Cx04hDy+kyvl6clHt7Q+NAxS6DXamXuKPePpcaaXWlN5O99uWKvFnmCkx7mJaE
         yfITxRegg+hh0X/abwrsQC/bkOCgCIG950CsZdbOrfHdgmEJ+9+YCAlQxw04UE1weIJk
         E1ZQ5LhyvwUTBGItRP+xQF1GYMvKPBY9nctS8Cvn/0+sdKk8zDBE84Fu8mhrfCiyIXtY
         4Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Z6L+j4zKC5mwS2K6Vzz9EZbJHlOytxXoT9Hbkkw8oQ=;
        b=r9LJK86I/HzCjyOML+Wmv4RrPBq4pnvdcgf4SWgNxKcckJJ67qgJsDz1q+u/wyDjzL
         IKucCHA6jcX+4KSn37Z7g2bdiDJEjQCkKagBMWfHy7oYTXhnayRF4+xxMw8mYmQ4Jlja
         05cA/vaAJH/5A76bBaj0GaHzBlZn3dhYzhrwaBBzoEWi6wnvtodWEuwq5F/+Vi8d3MSY
         n31Hy5hAAbCwVVNgO4nXxIRN2O7o0JOjjrP/VcQnrvJl2kD7c0Vq+jqwR1koKqWtK3Yc
         V4Jhaujr17nUZCSrwxScJujSfKVCVYfzZJ1ueisj7VbtVsboddOkFdZSOZskGrNX2qjm
         2SZw==
X-Gm-Message-State: AOAM533h/YwNaBhhHveOIgIRqhDFEE9AiMbg5ec+TSYPmhSuW4WSOLKG
        2KePy0951jJP5B3NEHUeiQ4hG2mKWMH0xoemDaE=
X-Google-Smtp-Source: ABdhPJyVDM0QsNz06BTICVam9tSg0mpnrlYX1XgnGvRAh4h26OfMLHYX+HLe0WgPjBcIR6/oo9j7LoNPe9iEU8GktG8=
X-Received: by 2002:a5d:4d91:: with SMTP id b17mr5884428wru.321.1632913272644;
 Wed, 29 Sep 2021 04:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210923000540.47344-1-luca.boccassi@gmail.com> <1aa77fde2f7f4637d9eae7807c5c55063d6a4066.camel@debian.org>
In-Reply-To: <1aa77fde2f7f4637d9eae7807c5c55063d6a4066.camel@debian.org>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Wed, 29 Sep 2021 13:01:00 +0200
Message-ID: <CAJ+HfNjsJZx62ZnA9Gi-rCuL=yBVLKZke7J+ruQFHAAKarpk=g@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR BSD-2-Clause
To:     Luca Boccassi <bluca@debian.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Cc:     bpf <bpf@vger.kernel.org>, joe@ovn.org,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 28 Sept 2021 at 17:44, Luca Boccassi <bluca@debian.org> wrote:
>

[...]

>
> Gentle ping. Bj=C3=B6rn and Joe, would be great to hear from you on the
> above. TIA!
>

Luca, apologies for the slow response. I'm no longer at Intel, and I'm
not sure if an Intel-person needs to do anything? Magnus, do you know?

FWIW:
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

> --
> Kind regards,
> Luca Boccassi
