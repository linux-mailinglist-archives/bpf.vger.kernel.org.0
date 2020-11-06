Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256042AA097
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 23:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgKFW46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 17:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgKFW45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 17:56:57 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A1FC0613CF;
        Fri,  6 Nov 2020 14:56:57 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id s89so2515836ybi.12;
        Fri, 06 Nov 2020 14:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hs7ttqlbV+33xR6nIh8jySZ0XFrLRFkcyegUzSTWkQs=;
        b=NOiah3kcYhmOM7KDuzi035foooVL9GHh8zI37WRitpCyUjrJuyJuNHpr4CBKGxpk6O
         o8wu2SwK2fXrWSjUsM0K+oP3FPrAbjnsOmvp9nSvui065fOGvREHcELaTDS0sHJi4HU/
         BHB/CYKVdMLG2yL22m0CoZyTzENXceTIBjAw5EZqGEVNtODCS35ZkiZZCP0Mhdwr8JW9
         9ZthYsv5mnv1zONhTVZapkvtVr/a+Bj2B0FCgbTBgcROAdVVkAO+WHN9Xeepxs3v9E09
         DQHBicjgQ55f0Ulp4MJXeZbj7vS++PD2+NtQP5Id2CDpvvIaeb0zeDDFfYCPomISVG7N
         8JeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hs7ttqlbV+33xR6nIh8jySZ0XFrLRFkcyegUzSTWkQs=;
        b=EK6A+BARXvnM2eMMXaKQm5qGfK76hCVxsi1iSlkSpKYe/CE4oNRkTje62ZJeLeEW+M
         YtqhIuz3MVt++jDB/xHuOepzDy8nQJuf63tV0tz/P2bMT9WOwHKr+sKRyU+KIdRLRECr
         mghR4MIcnopeZ7UQbEhMmvPVzix4jE+yASJg0V/qh8hgyHarruNzDg4iyW2OtA+7d3Vs
         zsoG6bg5wX2hcB3eJnqt9YanyNWiQvYs0yw6K4AZX6HB4SkHtq8Y5Nx2KVTOijAj5ZpG
         0PrYCko0zE2lyEnh562BTaTeEK2FaPD5fmciLUztg1CqDjInHEOr0sEcOknqPJeimOmZ
         x+7w==
X-Gm-Message-State: AOAM531NAeG5trwatag0c1lhXLMjCa0+JXFsEf+XlLBTPNsPaGmg2W10
        AwI5/0U8LgNcgygXgVnZnXDqmdjR3NWu+60zbVo=
X-Google-Smtp-Source: ABdhPJx8MPvlQtcznJ0bjLO9IoQ9EU9eg1kRPXXNzO76FqDIe2ILT/6zX+8n+V+FE79WmExgdmAD3JUSdmqeJ65Sv7c=
X-Received: by 2002:a25:3443:: with SMTP id b64mr5876021yba.510.1604703416558;
 Fri, 06 Nov 2020 14:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20201106222512.52454-1-jolsa@kernel.org>
In-Reply-To: <20201106222512.52454-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 Nov 2020 14:56:45 -0800
Message-ID: <CAEf4BzZXOyA0gROk2=G1R+m7gHcqTZHpE9L2G_EBCZET3FpzAw@mail.gmail.com>
Subject: Re: [PATCHv4 0/3] pahole/kernel: Workaround dwarf bug for function encoding
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 6, 2020 at 2:25 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> because of gcc bug [1] we can no longer rely on DW_AT_declaration
> attribute to filter out declarations and end up with just
> one copy of the function in the BTF data.
>
> It seems this bug is not easy to fix, but regardless if the
> it's coming soon, it's probably good idea not to depend so
> much only on dwarf data and make some extra checks.
>
> Thus for function encoding we are now doing following checks:
>   - argument names are defined for the function
>   - there's symbol and address defined for the function
>   - function address belongs to ftrace locations (new in v2)
>   - function is generated only once
>
> v4 changes:
>   - added acks
>   - renames and change functions_valid to be local var [Andrii]
>   - fixed error path (return err) of collect_symbols
>
> v3 changes:
>   - added Hao's ack for patch 1
>   - fixed realloc memory leak [Andrii]
>   - fixed addrs_cmp function [Andrii]
>   - removed SET_SYMBOL macro [Andrii]
>   - fixed the 'valid' function logic
>   - added .init.bpf.preserve_type check
>   - added iterator functions to new kernel section
>     .init.bpf.preserve_type [Yonghong]
>
> v2 changes:
>   - add check ensuring functions belong to ftrace's mcount
>     locations, this way we ensure to have in BTF only
>     functions available for ftrace - patch 2 changelog
>     describes all details
>   - use collect* function names [Andrii]
>   - use conventional size increase in realloc [Andrii]
>   - drop elf_sym__is_function check
>   - drop patch 3, it's not needed, because we follow ftrace
>     locations
>
> thanks,
> jirka
>
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
>

For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>
