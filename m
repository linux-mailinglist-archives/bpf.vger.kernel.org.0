Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405C3242E0F
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 19:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgHLRfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 13:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgHLRfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 13:35:51 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCFBC061383
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 10:35:51 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id x2so1774564ybf.12
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duRMAoeWFxcKnS+HDRwCbr7kX+NmwK6tDh1Ksd1IUOg=;
        b=J3+H9y4fuL2hzOJsrfm3q7Vv7vQEwJq85SbRgF6Y9vLE8nED2fatRAzKq92TS2UX2m
         /Zj0idYEx+Wh5ElczylokYsCJBT35vj+FUtzbf+ekTEAI1C4Kzzen102aa46lA1wwqtN
         jAbimORRv7/BL6h4hBM/fPf+iu+PrwbBOULjJw/ve+RjNl4DBW3jIoOhGp/bGGK83+uC
         /sJhmuBPXnVwKA/UQE3aO0Exzto5ayi1h6n4Kw8/ueEbUDdPbq6aRJsZFhYk3DY9uosc
         KKBkHI050hkRflEzjMaTKeDse1Dtz0N0Fm6Qi9yX36rT6ixqjU7opzQXaEotJICx8cao
         jAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duRMAoeWFxcKnS+HDRwCbr7kX+NmwK6tDh1Ksd1IUOg=;
        b=lBa+Mu9v4dMfHEHrgbnpnXgXq4mLy9E10B9BSZY5QPqaBcwD0RGkGhqSOTaqYNMIUd
         azXAQ+AaV4mO344uxLdR0zfT+tupSeW/ryf1cAl5fWKcZ1JPySuLVRyKsbMl6c58Tv/W
         zq8P66JbITzLY4zf2fJwEzhdcVWt405GuEfM6Fu+L2NFpVBvPsz9vA5137ZcPtUw6z4H
         UXEbIMYmYtj53qHaiLaLXYxoogCP6UNhunHAgDoYP0kfa/s+36fx4dqRavS1DbHpabEx
         NXawtLWDY2AdItZMI7bWjwz/JfghZnMWuNN0Urz0DMr/JAeEAYNCFDSzMGdy8pgMdsMi
         +FKg==
X-Gm-Message-State: AOAM532HFwEkioh3w1NZT2BtttD5OQUePEHBhIOjMLCMsO4wKnQnUVXh
        M8/EztBf9/9qoIx2dpcNk/ucpeila09NzP37dq93e3gZ
X-Google-Smtp-Source: ABdhPJw/AWI1MFTea5shxtGg4pL/MEPyACGxe/d+JZeHaCt29NVlXMWaBd22HNMHxQJGxbSYls/9KU7e0WBCI2RIRgA=
X-Received: by 2002:a25:ad5a:: with SMTP id l26mr650882ybe.510.1597253750632;
 Wed, 12 Aug 2020 10:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200812143909.3293280-1-jean-philippe@linaro.org>
In-Reply-To: <20200812143909.3293280-1-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Aug 2020 10:35:39 -0700
Message-ID: <CAEf4BzZKEfgHSeZMMHfGt=WvcChuDh+a_0pyBbwU3riKSt2z5w@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: Handle GCC built-in types for Arm NEON
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 12, 2020 at 7:42 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When building Arm NEON (SIMD) code from lib/raid6/neon.uc, GCC emits
> DWARF information using a base type "__Poly8_t", which is internal to
> GCC and not recognized by Clang. This causes build failures when
> building with Clang a vmlinux.h generated from an arm64 kernel that was
> built with GCC.
>
>         vmlinux.h:47284:9: error: unknown type name '__Poly8_t'
>         typedef __Poly8_t poly8x16_t[16];
>                 ^~~~~~~~~
>
> The polyX_t types are defined as unsigned integers in the "Arm C
> Language Extension" document (101028_Q220_00_en). Emit typedefs based on
> standard integer types for the GCC internal types, similar to those
> emitted by Clang.
>
> Including linux/kernel.h to use ARRAY_SIZE() incidentally redefined
> max(), causing a build bug due to different types, hence the seemingly
> unrelated change.
>
> Reported-by: Jakov Petrina <jakov.petrina@sartura.hr>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]
