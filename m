Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC21CB9FF
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 23:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEHVoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 17:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEHVoV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 17:44:21 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C33C061A0C
        for <bpf@vger.kernel.org>; Fri,  8 May 2020 14:44:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s186so1513169qkd.4
        for <bpf@vger.kernel.org>; Fri, 08 May 2020 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zFk7lUHHjliqUXLMweQaYQ9LQkO2XiKzxzFPWUgGek=;
        b=Vt3beqixQ5GXNfisemJGof6PqbUqG4LByDmb8BG48HKIWNLCtKiH/Vm5Mgm6KbhbM+
         tfGRmakS0G/69jNk9WwH6Y9t+0nMs2MNottUCSHyI+sXMVx9mubeTuDnb1/Z8WS7r0nG
         v3oEE8KLBVD7p538nS2EA1l+SR0PTH10zqKpLhuIlTET4vSpSEH8pHyLT949edda9GcV
         wgNjU91DTlp9aTOzFDwWXMuJ7GfEohIqLD8exTweDESHZ0fET8Ex9nSl382fwAflJk6o
         P8Ofb1MPyLYVc1+rEdNc78vrCoBGieU/Nm96i0nNn6/+yg8HZMLQ65BA5vaUPjMjUy9Z
         DFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zFk7lUHHjliqUXLMweQaYQ9LQkO2XiKzxzFPWUgGek=;
        b=IEcdEkyBTEiXBfSolfULh7+c56+oJFL96dMesjgTZlFVpnn6iD38/eoLAxGj5tbLYS
         IjR4whO9aDkqYkWzUkCkKYyrEBQ+8aErVxRw1R78F9yXJ3aO6sgbW4mJ5bZ41jtjaXYd
         F/DndHDtWqY0ItRXmB+tWzVXano70V+FIJTcb8OzSyXaDPE+Z2KiOBxnnLrlM90f2aAl
         TP6i94465j10tY0JRinBgLL3ZElJy7fwqxT/Kn3etDFeqToHWB9sn95KDBIEb4hAUYKn
         fz8peqftBCzz1FRmaJvIoXivgfnuceCFJAoyquXxGwqC7p95WTdYRkMTFumo6UJEwdub
         ZU+Q==
X-Gm-Message-State: AGi0PuaWpPMgEtz7xmo/0rx5f/1ZW1LvTpEQFhLywmY/9LCRg32HxWlY
        UDFU5+UUqLRJYlD+RZ/7J7efO7B2OshH14y+SMw=
X-Google-Smtp-Source: APiQypJxSCjox3KaIhDkkEAnGI/A25N8siuLUgXnGR2DZplmIpx6aSJXiIijSaDqTNkUyndDyc+gB9PhiJECd1BmWoY=
X-Received: by 2002:ae9:e713:: with SMTP id m19mr4936742qka.39.1588974260143;
 Fri, 08 May 2020 14:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200507145652.190823-1-yauheni.kaliuta@redhat.com> <20200507145652.190823-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200507145652.190823-3-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 May 2020 14:44:08 -0700
Message-ID: <CAEf4BzZAN+7tn11HW5H5C+8d2PiEK8KgnnJD_dV2feDhzERd8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] libbpf: use .so dynamic symbols for abi check
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 7, 2020 at 7:57 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Since dynamic symbols are used for dynamic linking it makes sense to
> use them (readelf --dyn-syms) for abi check.
>
> Found with some configuration on powerpc where linker puts
> local *.plt_call.* symbols into .so.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Makes sense, thanks.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 908dac9eb562..0c7b06de5633 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -151,7 +151,7 @@ GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
>                            sed 's/\[.*\]//' | \
>                            awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}' | \
>                            sort -u | wc -l)
> -VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
> +VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
>                               grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
>
>  CMD_TARGETS = $(LIB_TARGET) $(PC_FILE)
> @@ -218,7 +218,7 @@ check_abi: $(OUTPUT)libbpf.so
>                     sed 's/\[.*\]//' |                                   \
>                     awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}'|   \
>                     sort -u > $(OUTPUT)libbpf_global_syms.tmp;           \
> -               readelf -s --wide $(OUTPUT)libbpf.so |                   \
> +               readelf --dyn-syms --wide $(OUTPUT)libbpf.so |           \
>                     grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |             \
>                     sort -u > $(OUTPUT)libbpf_versioned_syms.tmp;        \
>                 diff -u $(OUTPUT)libbpf_global_syms.tmp                  \
> --
> 2.26.2
>
