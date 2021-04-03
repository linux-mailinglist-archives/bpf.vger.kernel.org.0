Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EB0353495
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhDCPue (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhDCPue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Apr 2021 11:50:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E2C0613E6
        for <bpf@vger.kernel.org>; Sat,  3 Apr 2021 08:50:30 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g38so7999583ybi.12
        for <bpf@vger.kernel.org>; Sat, 03 Apr 2021 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZTZ+aEe3KZLixpZNSp8J6l+yzx52sc5FFdAZqgehhA=;
        b=er4tQaqEP/WoYZkTwOj55NeadtFShKaXnrOQJuI0BQxboHKaYMqxvHcDEshbIWovDr
         WnvoBQ8HcktRK4VhAhqr29Jeufr/jhUwbRWDzf3UyZxTMbO5XseYz1aTZK1fs8LdixKc
         WiiXdj7c6ecew2SOBYMIVK5SU9tGU6rKPBOmwYjx9n/CBjLU4aLeup31r2T1z+9PTkiR
         LJ58dKWvgz5NAIe9PhGyZeocqfr4sSdSOugnzkX3DB/9b6DAYsuQzHfKy7BvW0lHGg0r
         Fw06H9jHiBvtMrqVID0KqQludwz6PiR27+XJm4rBIenXUZ2iS7sL9R9IvO2yh+Nn1T/x
         UpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZTZ+aEe3KZLixpZNSp8J6l+yzx52sc5FFdAZqgehhA=;
        b=Fz+O6K77wpGSg68noDdS6stA0RkCY8zS4657jQimsvi593vFv9uoaOoOhmaqhabtq6
         kZhWsOvUAN38R4W7OHnfamspfcsXmR9bM712W9E12p3SQ34dZAAeN4Ejts0T6HvgZ3ys
         rjB1RtsqfV3MMSEQjnrkOTGvO9s9jqzxTz5d+V/LQGmMaUbLFAukU9quo6DR+4juieZo
         uKBFGhZ7Db3BE5h5ifrsRaQUo8tfeW2t33yt4CV3/pgywSj5NkLUrwgcOIyN/hU8Fywz
         jyIT2I4fuzuJQqKtMgFQxFwyIUVaBEc7m4ny/H6Zbl25JhEMNKjyzhVAFbYxrELAaU/z
         I8bg==
X-Gm-Message-State: AOAM530xyHdmgYn7i855FMIl0i9cRh2tFXRoKTrb8UebYZKp5O7i9fXB
        cEJRh6FjdVU6OjrpB6aIM0P7ZlAkdMBn5Q18FJUQ+FrD/Co=
X-Google-Smtp-Source: ABdhPJxRiqsQYunSEebbXe9nL+iSQJOf0Eq1rCfH9u6qGvw7SiBTVgp70uHzWKIVRQVbkxPGMWjP/hiyUZFu/hBw7s8=
X-Received: by 2002:a25:ab03:: with SMTP id u3mr26008123ybi.347.1617465029097;
 Sat, 03 Apr 2021 08:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <45cb2bbc-202b-00d6-7422-738a025be068@felix-maurer.de>
In-Reply-To: <45cb2bbc-202b-00d6-7422-738a025be068@felix-maurer.de>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 3 Apr 2021 08:50:18 -0700
Message-ID: <CAEf4Bza-w+nOMOJU4+rL+ZiF++vbDpXBvPWz2kgei3fcNzRSdA@mail.gmail.com>
Subject: Re: libbpf: failed to find BTF ID for ksym
To:     Felix Maurer <felix@felix-maurer.de>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 2, 2021 at 3:47 PM Felix Maurer <felix@felix-maurer.de> wrote:
>
> Hello,
>
> I am working on a tracing tool for which I need know the address of some
> kernel data structures. The tool should be CO-RE and I am using libbpf
> (through the libbpf-rs Rust bindings, but this is not the issue I
> assume). However, I am having trouble to use ksyms with libbpf.
>
> To get the address of the data structure (in my case
> skbuff_fclone_cache), I use an extern ksym declaration in my BPF code
> like this:
>
> extern struct kmem_cache *skbuff_fclone_cache __ksym;
>

Due to skbuff_fclone_cache being a static variable, typed __ksym
(where you specify expected type and thus BPF verifier will expect BTF
ID and will allow reading it directly from your BPF program) won't
work. If you need to just have an address of the symbol, you can use
untyped __ksym, which will use /proc/kallsyms:

extern const void skbuff_fclone_cache __ksym;

If you need to further read any data (e.g., follow the pointer and
read struct kmem_cache's fields), you can use BPF_CORE_READ() macro.

[...]

>
> Now, I am not really sure where the root cause of the issue can be
> found. Should the ksym be present in the BTF information (i.e., the
> issue comes from building the kernel) or is the BPF object file broken
> (i.e., an issue with clang) or is the identification of the ksym wrong
> (i.e., the issue is in the libbpf loading code). Or something completely
> different? Does anyone have a hint on what goes wrong here?
>

As Yonghong already replied, pahole doesn't generate BTF type
information for static variables right now, so it's expected.

[...]
