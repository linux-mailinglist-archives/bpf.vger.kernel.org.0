Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B8E47375A
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 23:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhLMWUA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 17:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhLMWT6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 17:19:58 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C54C061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 14:19:57 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 131so41790368ybc.7
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 14:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGiqTdE3bWXIaR9pX2IGMYfnjAgXIg7pLCWDaLE49Yg=;
        b=f69QMQ5Lxgku561uCYeuspW7m7gv54PtmWMPt+HjgLFtEf+3uKo3LNb1qFFwnlHCPb
         7zP+q5eJ3m1xR3J9xeBjyLLNr2d2BId529pBXtGchCtAw5ATFWbpgM5s8d3qL4UxZJI5
         rXWS+4MuyZd3S3xXoaNEVMuDKsbg7LnQ9pRit/jkBlTve8SrWBIzVxXyOhkp/DxfqkGg
         xgph57MJoUTu7SYNV1MPNkMfqNSKsBCNzjVH427CDv6DSeLHQkh6dnABqYAn3smtS4RR
         R+OQrZAPhJm2m38MmQqbKRxoCfbNEkrsmuPaH9Pvonbg2BEh3O9NzPDItdrkbLhlsrmO
         +kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGiqTdE3bWXIaR9pX2IGMYfnjAgXIg7pLCWDaLE49Yg=;
        b=cMxRFDkWW783UwjrbcnzhNFSgkvr4u4+Cqt8NTFFflFxYUub53sl99HU+z0XdV6Woc
         wiJ8znZZlJ0gzJ9YMJCYTcUVA5ffqwYeeBqeUvsu8nwF06YLaEI7EZE0MGKwVCKRAvbM
         T+hR3jfVkUzM/fz+ccqfWEytQQik5zBGxwSBIrZNGB2t8rsGhMkwLzdowB27mByem4lQ
         6aGSfBHnRBpN7Vui63drmCLPxseN4vYDDSRfVYTShATDV00/KbZuTQLb17OuDzSCW65n
         z2mf/aBxiXOmsK1oz9Klwf7kaUowVjsduc/ZSyTvqgHiEnvlV5W1qg+D3sEGZnsU/bif
         JsTA==
X-Gm-Message-State: AOAM5321X4RWq+V6v0r4UBWV6K/xQWEeD5i+3E7FuL05fPHlqMeEnGTM
        idDY0hvLPX4IOKtwmPSX2sGBp9Ujx3f2gIu5JV+x9OHsKm4=
X-Google-Smtp-Source: ABdhPJz3hzW1NJkANtxn89dE4RtYWLDgrbgPhmcjZmKeW7iTKpmVU9GHH73d2SAf9pZFwdZSJKnndPsJB041J2excWg=
X-Received: by 2002:a25:2a89:: with SMTP id q131mr1672955ybq.436.1639433997107;
 Mon, 13 Dec 2021 14:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20211211003608.2764928-1-kuifeng@fb.com> <20211211003608.2764928-5-kuifeng@fb.com>
In-Reply-To: <20211211003608.2764928-5-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Dec 2021 14:19:46 -0800
Message-ID: <CAEf4BzaanagG00ZT_1dx0BjArNXTxM8xH+6t0QPZNTfnTPSyBQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] libbpf: Mark bpf_object__find_program_by_title
 API deprecated.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 10, 2021 at 4:36 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Deprecate this API since v0.7.  All callers should move to
> bpf_object__find_program_by_name if possible, otherwise use
> bpf_object__for_each_program to find a program out from a given
> section.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Forgot to mention that it would be good to add:

  [0] Closes: https://github.com/libbpf/libbpf/issues/292

So that when this patch is synced into Github's mirror it will
auto-close that issue. Please add in the next revision.


>  tools/lib/bpf/libbpf.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 4802c1e736c3..cd9dec4def41 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -187,6 +187,7 @@ struct btf;
>  LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
>  LIBBPF_API int bpf_object__btf_fd(const struct bpf_object *obj);
>
> +LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__find_program_by_name() instead")
>  LIBBPF_API struct bpf_program *
>  bpf_object__find_program_by_title(const struct bpf_object *obj,
>                                   const char *title);
> --
> 2.30.2
>
