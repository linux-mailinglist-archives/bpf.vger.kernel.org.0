Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A169A44DBBA
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhKKSrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbhKKSrs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:47:48 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C67C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:44:59 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id s186so17339570yba.12
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dx8iLrnJRodcRna55MlvJZmYfBhMWK9bTglOo8uKliY=;
        b=hn1iulPQWcDlG42FPiDhqUh3jiidpZT+wFOL6AQxU2FGmsGNkhXbf4rZmAmqVF6fo6
         X/REyNSh57J7clm9w5S7HbFyg0/YaLsEjw6swJl8Hq5Fzbxthl7DMHPB0mIsBu1I3oTk
         3+p9/LySTe/LVLX5fsyPxZcaxGC2NFaah3/qJc/RpD14LOtPzopmRrpxR+lhEZDwhtWV
         gejBiqZES6a4dtibHqLA6Bj2Rn7aXO8dbAeM5NQKFX2FE6G4TQD7ti3v+vXFOY/DAxyk
         TxCN/KI5mI/c0xQPmUlubuoTOMNsLaQ+Vj/BQtKrFXQocW3e7LSPz2t6reT4l9ggEkFv
         gN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dx8iLrnJRodcRna55MlvJZmYfBhMWK9bTglOo8uKliY=;
        b=1aWCj6ID2sBUFEmzNRv8hP4FmOPAVTQE5ihJznzSyZvTMlq4uvB9dKupHk+9eJvTIJ
         84x6lpES01aSRwByXK7G51Lx1g7uPHY40I2t5ggqF8zujx7Csw0Kjc9yWcShywOrKIg5
         WSDHdO/exKxUhsvofjB7C3IHkaiMDuYXqHOiEHK7jz7mqo23KRTPmEHGQPUd9J4Rwp7s
         m1EiJLAYNAZD5mCRaLFURIRWa9HeuCje3/4EslEeLwtrtBRV+/yVjD1ZqR83uSfz6mcn
         OR5u/QeXa3FWVZn5RyABfHZlTFbcs46oBGnz618kHmlit9pHJMWDUXVAOcRzL4r7P8gm
         zMcw==
X-Gm-Message-State: AOAM533sngz2cPsn6MKzJ5tB1Bc0Jnx1YFk3xjXY1DOR4gKYorgZ3Wu3
        PHKeSQbi6kkPl9WVpCjaWF2ez2YXn6XILl163T4=
X-Google-Smtp-Source: ABdhPJwJNcFS2fHOc1tbmag2jQ18F7HTkQX2OdMHkcvn/8f8jokzLwpTVDj1Gec6bUTGw6sLzxlFZezW1zB022Gz+sA=
X-Received: by 2002:a25:d010:: with SMTP id h16mr11165801ybg.225.1636656298681;
 Thu, 11 Nov 2021 10:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110052001.370523-1-yhs@fb.com>
In-Reply-To: <20211110052001.370523-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:44:47 -0800
Message-ID: <CAEf4BzbuVZZnSO04e1nOaPhdS1z_UnQscjuZijCVDjPMLz+fZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/10] selftests/bpf: Test libbpf API function btf__add_type_tag()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:20 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add unit tests for btf__add_type_tag().
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/btf_helpers.c     |  4 +-
>  .../selftests/bpf/prog_tests/btf_write.c      | 67 +++++++++++--------
>  2 files changed, 43 insertions(+), 28 deletions(-)
>

[...]
