Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589BF49D2F2
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 20:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiAZT7Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 14:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAZT7Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 14:59:24 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C14C06161C;
        Wed, 26 Jan 2022 11:59:24 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id w5so673501ilo.2;
        Wed, 26 Jan 2022 11:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtLwZ9wolvYhQ4t71Zy4HRm3vN3/8SsJVrsDB3RmbEg=;
        b=WXBluTD1HB9nlcAVq1r0GhNguO1kf/CFU7z+4TpqNHyWsMQWuZ0+KyqxaJqQLRWLkj
         jwYKprkDp2YW3PRPTFsBFni+ihDaGu1okEjU2NRyYQQEvp3TdtIEZoUtMx9VBQJBSOET
         AVlYVUHYPwUMoT3GWuseuLbNScxzcWG9EB8QL8pPqxCmq3lcgdS4rk5HE6Z9z4gLFuCu
         5dnTRXxQ91gobO05D0bvRIg3nTC80iol9HSUKz/GI2ccxMsmXYTryZBAwY0NeAtL3CVK
         r1lItZfe9VeQC1vQmM0NiN4aqHDilcJtBzGd7cvC0kyrLRMBo5JGdKutoA/YrdCDsPrc
         Fjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtLwZ9wolvYhQ4t71Zy4HRm3vN3/8SsJVrsDB3RmbEg=;
        b=CTHWQVw9ofkSlnEWz20aJ8SSrsowDaI9StiPTQblei1VZay9ZV4wF7GyHSnPAMRSEA
         6C8+xMxGgurd5ryCnq19Womo/1ScKSolg5HZwSBYk74O0xdKlZzSSkzwYn8UotTcFg9F
         hhuVuW9bcUDtbBnM4sn7g8hJPL0M4sf9qKNOMSY1wH4sI0ADInGx/lYqlZB1XUO5lMfz
         441NiysGcZeAUannRhS7IjcdRZkXm27iW418AwWLzI9+et3e6gN6AmS/eEmQFqReGyiR
         TFf+Ncjv1dZRNVUKwT/PwILk21ff+udMSEUy8KvDIzZY37YAxcF0InN98B0llIjeLYGf
         rKLQ==
X-Gm-Message-State: AOAM532hk/8Rw5etkaeFcYX1fcyQoOppfuAxCY22RaPqobbOqhX/Vsks
        Lp8sQG7uCrwIsEKq7VYNQzFUZLi9ByFPm+o9Qvc=
X-Google-Smtp-Source: ABdhPJwDaX3L8enllW4nOp+5SVwxs8n29V4yATky8Bgd7sofLBknlew2psujaamcSyWhQrELmPhdgoUr52HsW4TVP0U=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr473939ilu.71.1643227164214;
 Wed, 26 Jan 2022 11:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20220126192039.2840752-1-kuifeng@fb.com> <20220126192039.2840752-5-kuifeng@fb.com>
In-Reply-To: <20220126192039.2840752-5-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Jan 2022 11:59:13 -0800
Message-ID: <CAEf4BzYN426pX_ge1wQS1jceHSm8ooAN83p-BL1y=SfX2k32Ag@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 4/4] libbpf: Update libbpf to a new revision.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 11:21 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Replace deprecated APIs with new ones.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c | 20 ++++++++++----------
>  btf_loader.c  |  2 +-
>  lib/bpf       |  2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)
>

[...]
