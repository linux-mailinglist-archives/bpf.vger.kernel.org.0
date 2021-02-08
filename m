Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766923142EA
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 23:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhBHWZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 17:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhBHWZ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 17:25:27 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C7CC061786;
        Mon,  8 Feb 2021 14:24:46 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id m76so16233238ybf.0;
        Mon, 08 Feb 2021 14:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUFmS99f+cuEVGOeUI+Prrn0Ad24FTVD3GjEysWCokE=;
        b=f8VXElXaMRE8ldRYSzZmTn0q//yTnJoCO9i8ktlnh8wkquRVWsBM4KfQ89OdYmiQG3
         hdni31U0GyqPU2rvTuijzAqqtaxJqmYx8NqpyjCBZhsDHbVtjZnqqoyUOCElCPR1wpQm
         PTrnrXd2rBgLOyW5bmtiNSWj0bwsnmTJCOe7+Iun09oDEmqbcNnHmuRopdGLQa/Q5/Rv
         fJmBJZSkQOJ5tvk/ESj90I4erE/FYpu0wSUQM20shde16O9ADWPY2rH8CVQ1NmtDViK+
         Zd8cL8pT45Yb4pSBJfWaJpvUlaQZk7gmc049PWW1F+G7styAwJlElN6xc901DS3aP2/1
         ghKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUFmS99f+cuEVGOeUI+Prrn0Ad24FTVD3GjEysWCokE=;
        b=pj0UyxujY/TkC5OrRjYYkTQzoB5qAiV3+kUWYRBVwXV7SWx2/DPzhg3rHRuHqrRDs4
         Hju1N5bXD+KfzdmDhwr+Huhs+wUw/v6SqOJ8gb1YtCPu6bi9gsoE851x2DRfKyhptRy2
         iOikoK2FP0ZHZfSPgiJ9NZ0Qq9V/rfn6Ee7dai9l+zoUQ6whipMatiCeD/veFLCddPSV
         dYKHCOTQq45gxCuXaeVkDVfQde+ZMQE8TzphNF4Thdutt4E1DKRjmHG6r5M3KhQCZnJC
         pFmZmhRPbzTmcj8J8SUcyXr57gohF7T4/W/jq4MoQ6ifnV5slxkj7OrMeBQwzY25504u
         urnw==
X-Gm-Message-State: AOAM532F/5eq9sJ9TYDSPAC4ldRLyDA9hIev/UOWZEW4k1Tp0DLtNwtr
        nt6XwKvNcRZOODKxhRdIa2NCtVKOxn4xV9Pn2aQ=
X-Google-Smtp-Source: ABdhPJxzu/gWB3VNj1sqXwd3q25Ivs+YB5u5T+nGh7Djk7JbJFbRWeQhTG0IPKkTp8fk269ZuzgrrOx0Rw9M2J2+g5c=
X-Received: by 2002:a25:c905:: with SMTP id z5mr29107120ybf.260.1612823085651;
 Mon, 08 Feb 2021 14:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-4-gprocida@google.com>
In-Reply-To: <20210205134221.2953163-4-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 14:24:34 -0800
Message-ID: <CAEf4BzY4URifNvvFFyM2KYURh0c7-=ftHfyR5AxXGE_ZMDMy2Q@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 3/5] btf_encoder: Traverse sections using a for-loop
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
>
> The pointer (iterator) scn can be made local to the loop and a more
> general while-loop is not needed.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index ace8896..4ae7150 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -700,7 +700,6 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>  {
>         GElf_Ehdr ehdr;
>         Elf_Data *btf_data = NULL;
> -       Elf_Scn *scn = NULL;
>         Elf *elf = NULL;
>         const void *raw_btf_data;
>         uint32_t raw_btf_size;
> @@ -748,7 +747,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>          */
>
>         elf_getshdrstrndx(elf, &strndx);
> -       while ((scn = elf_nextscn(elf, scn)) != NULL) {

this is pretty "canonical" as far as libelf usage goes, I wouldn't
touch this code, but it's up to Arnaldo


> +       for (Elf_Scn *scn = elf_nextscn(elf, NULL); scn; scn = elf_nextscn(elf, scn)) {
>                 GElf_Shdr shdr;
>                 if (!gelf_getshdr(scn, &shdr))
>                         continue;
> --
> 2.30.0.478.g8a0d178c01-goog
>
