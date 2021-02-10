Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B008317182
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 21:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhBJUkF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 15:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhBJUkA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 15:40:00 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B563FC061574
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:39:20 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id b187so3358650ybg.9
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0a0ZcCQlNQxd4L+OetR0iNhd1HNNDb+rpLwn1PDgqSk=;
        b=jiIoa5GTOHLOhAbjQXc/OgD4yur5VMbrJInSqyxnLgpeGPfSJh8X0Ob8Sb4+0VWRlk
         KKYlKHoMnvihQsTgJWLx3rzJ71iG7pJhbsgxGB2HyTIYHTg4tmzzxV891Z/8EdMqaWuq
         7NYf+ilXnK7+G7D3EpSP+IVhzOyl5aWKAAgBZEa78544yM6keBtwLyAJzvMX1RLFojZs
         kCcnWprEzcykRUiJHmpTW6Ced3wVGsU4sl2SBrQNYuN3xMz6fF4OC9oz3Oxx/wl19kb6
         sfZOou7Ma1/nDdbZzteiIevIIOjuTcxWsYCAyPAuqfb/TFBci40usEU1/M+qaIKgtvEt
         pTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0a0ZcCQlNQxd4L+OetR0iNhd1HNNDb+rpLwn1PDgqSk=;
        b=XBxCgTsb7f9rYggi4dnTkYDcgEh39vab8Wm2ZkKEiX6lKPyViAmJgTYCs9pLdxeXwr
         R1lyuiDgA1qbwAsyU6mYygiLEmDD9YYcozFBfUF5XbhlmRGfyo6bZAI1GY5NKxYMlCaX
         Hzys5E0zWoLrgZ71HNXmnsgJcHZUgdC1oa6kG50wcNY05EhkAon4R0xPmBeDUm9yjvri
         VYbOZeMvzUg3L1CMEsszqL6n6h6/UQ6geCwaX68ZTCyfGP5TLe71rfchtTnhVd/OGCIJ
         hWK2Fag0Ci+1PnWBz3UbHxUPyIjudPDaNO1smO0qr87I4ARMZqeMY2o6REgFA3rBzcBR
         Lvgw==
X-Gm-Message-State: AOAM5327OoI/0ZWXT6/UIYTFSk35Sf2w1+PmmiGk6u3Cn0P2ZAjtdNkh
        xwtZyaZEEJqvzFVJvOGORslzbVV4uNuXvOhdJ1A=
X-Google-Smtp-Source: ABdhPJwu3KZlWOJRngPb7KfBwG9lmNL0i930Oylug/kz0+DjwNQySTJYxZ2ihHlkEPV/4bDkQirw37jGWC1s2DriUKc=
X-Received: by 2002:a25:37c4:: with SMTP id e187mr6918594yba.347.1612989560083;
 Wed, 10 Feb 2021 12:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20210209064421.15222-1-me@ubique.spb.ru> <20210209064421.15222-3-me@ubique.spb.ru>
In-Reply-To: <20210209064421.15222-3-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 12:39:09 -0800
Message-ID: <CAEf4Bzb_5nynJeeGRYiNT_XpBaEvMtcJKPq45DBz_x3Ywh2O7A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Extract nullable reg type conversion
 into a helper function
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 10:44 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> Extract conversion from a register's nullable type to a type with a
> value. The helper will be used in mark_ptr_not_null_reg().
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---

LGMT.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> v1 -> v2:
>  - Simplify logic for is_null case
>  - Add WARN_ON on an uknown nullable register type
>  - Use switch instead of ifs
>
>  kernel/bpf/verifier.c | 83 +++++++++++++++++++++++++++----------------
>  1 file changed, 52 insertions(+), 31 deletions(-)
>

[...]
