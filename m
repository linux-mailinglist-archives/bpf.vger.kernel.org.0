Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F632A7441
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 02:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgKEBCE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 20:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731246AbgKEBCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 20:02:04 -0500
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF9A20867;
        Thu,  5 Nov 2020 01:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604538123;
        bh=Fyt70K6DM1SjmE8rtlroW00nv5i8Ug1BoLrDi0c8C1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pzPFT/jVTF5y3KBulJZP4uUwLEzN+HMEygp5iWQ6F6q7Jf/FR56UeIO322MoW/dwp
         xDLJdcUtcrS2bSvKKPPqtP8DolfWOCvayew/YPiaeVfUS8LCnfJcrVm80NIRH1FpxY
         +g3HduPbtp9v+mtO/az1yBojNE0xQ/CZ85P71c44=
Received: by mail-lf1-f44.google.com with SMTP id h6so387105lfj.3;
        Wed, 04 Nov 2020 17:02:03 -0800 (PST)
X-Gm-Message-State: AOAM5327u84RLbxZU1GBSfAgfuQnfSBIipCtBhVi5i5V/5FBePhhAl21
        U7wShHXGPodeXNWGZ+WWUXf/oYCrLpDZndvUZCA=
X-Google-Smtp-Source: ABdhPJxRjxUAjnGSi9aVA/O6g5cLBuxvB4FZT4tQu0egxbhVeI9SYYgwTo/aAw3/La1pxqpiCNVmom2H6wdPxlcv0tc=
X-Received: by 2002:a05:6512:3156:: with SMTP id s22mr96237lfi.273.1604538121789;
 Wed, 04 Nov 2020 17:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20201104215923.4000229-1-jolsa@kernel.org> <20201104215923.4000229-2-jolsa@kernel.org>
In-Reply-To: <20201104215923.4000229-2-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 4 Nov 2020 17:01:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW70S8HmoRFtgzc=r_pBF16kp+E20iaW6awO8TuSfGgYig@mail.gmail.com>
Message-ID: <CAPhsuW70S8HmoRFtgzc=r_pBF16kp+E20iaW6awO8TuSfGgYig@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: Move iterator functions into special init section
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 4, 2020 at 2:02 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> With upcoming changes to pahole, that change the way how and
> which kernel functions are stored in BTF data, we need a way
> to recognize iterator functions.
>
> Iterator functions need to be in BTF data, but have no real
> body and are currently placed in .init.text section, so they
> are freed after kernel init and are filtered out of BTF data
> because of that.
>
> The solution is to place these functions under new section:
>   .init.bpf.preserve_type
>
> And add 2 new symbols to mark that area:
>   __init_bpf_preserve_type_begin
>   __init_bpf_preserve_type_end
>
> The code in pahole responsible for picking up the functions will
> be able to recognize functions from this section and add them to
> the BTF data and filter out all other .init.text functions.
>
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@redhat.com>

Acked-by: Song Liu <songliubraving@fb.com>

[...]
