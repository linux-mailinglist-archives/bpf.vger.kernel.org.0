Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2086351FBE
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 21:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhDAT0r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 15:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhDAT0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 15:26:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CFC0613A6
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 11:52:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b14so4300996lfv.8
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Q79yaLa6qiQxBv9b9MkvioXf2LOU6WkhvfG8/Umzb4=;
        b=HC6Gds+eSDjH+muA5S2kexIFZZzflJIO1bT0aF6AH24Tcz+d1+wm872mnciOF5deng
         PK5JZXM5T93lfkRPKea99QWrDfzXGBGQzrbfmfIxAJs60/vZNH498A/SnMGx7gla3YwQ
         uK7L9V+aWiApQaCawfKOkf+pQBYwapPsUJHZ9nvtm33/e0xnxficI/Nd71jpDj0eXCl/
         T/DJJaeurUeQMFNDnARPkdVbOeQoFcbr3SB+ufTXudVnWtZeG5jTRTx1Kkdze2JE8kkX
         dYRjmI+jdrpUTFFmlZlvcYCuAgb2fOlQKcWM7aOlLZpqcck4k0hJlLwuE0K6udpgjcvD
         ETRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Q79yaLa6qiQxBv9b9MkvioXf2LOU6WkhvfG8/Umzb4=;
        b=k6JNTvypIJzGoSNa06IV0W/gN/srModvo2qd0ichzqD/OXpnqXXIauhhOOU1H2aySs
         yZKjcDhssPlK5fTT3yzH6u/r4wXc55Q4hPOk4sJnZMEYZo/HWo8T6vFefQSz3u3DiDFL
         g/jTVR4VExWf0RETcb4CHxLwcnx2PlvCB0m4WdnCYJNrNzr1CTpLnMoTbajg4tmx10cq
         IHvaqWv1sZztrGLf895jkAxQ5uBp5QrutlloUTTZgNOEgpXDl9N3Zi5cChQ37YM+B0Xu
         9SVPaJfblGHSp235iBQ6OFb5TE4jJ7AntmHDcxyvL6Nw7n1qOrWW25MAK69ao36Iw8yw
         0HLg==
X-Gm-Message-State: AOAM530U2DLFHxZujgR62Vc0VyFlofWaAr/bXKz1YzlciChxa1+/TuYd
        GjrflwE9bzlojunHM9aG07z0AEne2tkW4M0QQolxcg==
X-Google-Smtp-Source: ABdhPJx9MrQV+dN7F49wOAUNPCOKxeFdRMAvYCyScitDuCU6uGcvX1leOCGXUbV2LcBs62W/8nAQkTIEbGP6xxvaqmA=
X-Received: by 2002:ac2:538e:: with SMTP id g14mr6185269lfh.543.1617303136216;
 Thu, 01 Apr 2021 11:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210401025815.2254256-1-yhs@fb.com> <20210401025820.2254482-1-yhs@fb.com>
In-Reply-To: <20210401025820.2254482-1-yhs@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 1 Apr 2021 11:52:05 -0700
Message-ID: <CAKwvOd=mzDREDAXCxdFzSWnxC1hNc7udMXc7Lrf50qmJk9zE7Q@mail.gmail.com>
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: check .debug_abbrev for
 cross-cu references
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, David Blaikie <blaikie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 39227909db3c checked compilation flags to see
> whether the binary is built with lto or not (-flto).
> Currently, for clang lto build, default setting
> won't put compilation flags in dwarf due to size
> concern.
>
> David Blaikie suggested in [1] to scan through .debug_abbrev
> for DW_FORM_ref_addr which should be most faster than
> scanning through cu's. This patch implemented this
> suggestion and replaced the previous compilation flag
> matching approach. Indeed, it seems that the overhead
> for this approach is indeed managable.
>
> I did some change to measure the overhead of cus_merging_cu():
>   @@ -2650,7 +2652,15 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>                   }
>           }
>
>   -       if (cus__merging_cu(dw)) {
>   +       bool do_merging;
>   +       struct timeval start, end;
>   +       gettimeofday(&start, NULL);
>   +       do_merging = cus__merging_cu(dw);
>   +       gettimeofday(&end, NULL);
>   +       fprintf(stderr, "%ld %ld -> %ld %ld\n", start.tv_sec, start.tv_usec,
>   +                       end.tv_sec, end.tv_usec);
>   +
>   +       if (do_merging) {
>                   res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
>                                                   build_id, build_id_len,
>                                                   type_cu ? &type_dcu : NULL);
>
> For lto vmlinux, the cus__merging_cu() checking takes
> 130us over total "pahole -J vmlinux" time 65sec as the function bail out
> earlier due to detecting a merging cu condition.
> For non-lto vmlinux, the cus__merging_cu() checking takes
> ~171368us over total pahole time 36sec, roughly 0.5% overhead.
>
>  [1] https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/
>

It might be a nice little touch to add:

Suggested-by: David Blaikie <blaikie@google.com>

> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  dwarf_loader.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index c1ca1a3..bd23751 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2503,35 +2503,40 @@ static int cus__load_debug_types(struct cus *cus, struct conf_load *conf,
>
>  static bool cus__merging_cu(Dwarf *dw)
>  {
> -       uint8_t pointer_size, offset_size;
>         Dwarf_Off off = 0, noff;
>         size_t cuhl;
> -       int cnt = 0;
>
> -       /*
> -        * Just checking the first cu is not enough.
> -        * In linux, some C files may have LTO is disabled, e.g.,
> -        *   e242db40be27  x86, vdso: disable LTO only for vDSO
> -        *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
> -        * Fortunately, disabling LTO for a particular file in a LTO build
> -        * is rather an exception. Iterating 5 cu's to check whether
> -        * LTO is used or not should be enough.
> -        */
> -       while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
> -                           &offset_size) == 0) {
> +       while (dwarf_nextcu (dw, off, &noff, &cuhl, NULL, NULL, NULL) == 0) {
>                 Dwarf_Die die_mem;
>                 Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl, &die_mem);
>
>                 if (cu_die == NULL)
>                         break;
>
> -               if (++cnt > 5)
> -                       break;
> +               Dwarf_Off offset = 0;
> +               while (true) {
> +                       size_t length;
> +                       Dwarf_Abbrev *abbrev = dwarf_getabbrev (cu_die, offset, &length);
> +                       if (abbrev == NULL || abbrev == DWARF_END_ABBREV)
> +                               break;
>
> -               const char *producer = attr_string(cu_die, DW_AT_producer);
> -               if (strstr(producer, "clang version") != NULL &&
> -                   strstr(producer, "-flto") != NULL)
> -                       return true;
> +                       size_t attrcnt;
> +                       if (dwarf_getattrcnt (abbrev, &attrcnt) != 0)
> +                               return false;
> +
> +                       unsigned int attr_num, attr_form;
> +                       Dwarf_Off aboffset;
> +                       size_t j;
> +                       for (j = 0; j < attrcnt; ++j) {
> +                               if (dwarf_getabbrevattr (abbrev, j, &attr_num, &attr_form,
> +                                                        &aboffset))
> +                                       return false;
> +                               if (attr_form == DW_FORM_ref_addr)
> +                                       return true;
> +                       }
> +
> +                       offset += length;
> +               }
>
>                 off = noff;
>         }
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
