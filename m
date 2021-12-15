Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5583475289
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 07:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbhLOGIy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 01:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbhLOGIx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 01:08:53 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAFEC06173E
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 22:08:53 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mj19so1496640pjb.3
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 22:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzmAWLjqnT0tPY/dDcjm0UtmYa2cXOCtUttaYYZv34c=;
        b=OBr2xfJcZNGMCbkEoieqfJ+/xe2kcWC+bp9rETojuiU8BUNKIszYRWVnMELz3Mllrv
         MtlX2LS7aC53+Yti2Z+rXT84wLbcKDMtAjVGVtR3LGb8jjduZk+5pA0HL5BUy1k+tMg1
         AkhZ7RtMAnsuKgvVovOOYZMHDPPqrMm634q3qIu/jz3Q3I2A3ttuRQMCpHKuiCdqFKQp
         EldamULP3WLO+bC0UfY5uPc+zNCDiu7kiWVuEMHlMssRR7sJViTcRcNOJfmjmWka+z7Z
         IWc7Bg5Nh9Aj9l36Dc/5i0NrN8+1nWrtvEEvyZmiIu9i0bG1B0P7KoorkJjPqKgymx94
         tk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzmAWLjqnT0tPY/dDcjm0UtmYa2cXOCtUttaYYZv34c=;
        b=VxDO1WkDvWGI9U5ObByLh1EjMcWw9brfaU9aswl13KfGYi/KR8Sf9rszZNR57Lv/59
         yU3ASYfXBoVD6mNBCKrkH5aDN1iPqspZiyvpAvtP0C5ja5XTlh348enMGQYV8/TGYQcg
         RQm78WjNzx7qLdqeEKTE173NNyHdee53o/QhtmKMToBLDuLx3fRhEh5ffQ1sb+1JFACc
         j9ocqJKRIMCmslugFCeANZsiATP2qNkTK16V0AWY/lmPBrbXqdrYSV4Qo9scUUj+OCee
         3Pal3IPkcrPZ1cB7iC6zsPLmNE7n6E9OJE3sywabbQDsYZAyGIoE9oybL9COQBmYCecS
         a99Q==
X-Gm-Message-State: AOAM532Cpts2l1F1Hf3Ia/JjVD0CL6hUTPct03koM/EwX1x7/hORUH6b
        47rSIkWPpdeqG3C3PgA49vpeOWyikzsvOWVr0e8U0kmR
X-Google-Smtp-Source: ABdhPJzrAlzYyQ5lzjU0C2G+VLgf/SbC6Wc0KaOl/AES26AhDT7HbUW/62Nje4fRZkvdNHVFytm39UfqZzmm+6e2GoI=
X-Received: by 2002:a17:902:e353:b0:142:d33:9acd with SMTP id
 p19-20020a170902e35300b001420d339acdmr9552501plc.78.1639548533202; Tue, 14
 Dec 2021 22:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20211214232054.3458774-1-andrii@kernel.org>
In-Reply-To: <20211214232054.3458774-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Dec 2021 22:08:42 -0800
Message-ID: <CAADnVQJwRwmjNHiiKiAK1ZCBC3cpKgn33KJkV2G9V=AdwLG5vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: avoid reading past ELF data section end
 when copying license
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 14, 2021 at 3:21 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix possible read beyond ELF "license" data section if the license
> string is not properly zero-terminated. Use the fact that libbpf_strlcpy
> never accesses the (N-1)st byte of the source string because it's
> replaced with '\0' anyways.
>
> If this happens, it's a violation of contract between libbpf and a user,
> but not handling this more robustly upsets CIFuzz, so given the fix is
> trivial, let's fix the potential issue.
>
> Fixes: 9fc205b413b3 ("libbpf: Add sane strncpy alternative and use it internally")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Applied. Thanks
