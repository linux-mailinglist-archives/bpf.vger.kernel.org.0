Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE53E320F
	for <lists+bpf@lfdr.de>; Sat,  7 Aug 2021 01:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhHFXPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Aug 2021 19:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhHFXPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Aug 2021 19:15:16 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB58C0613CF
        for <bpf@vger.kernel.org>; Fri,  6 Aug 2021 16:15:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id c137so17608589ybf.5
        for <bpf@vger.kernel.org>; Fri, 06 Aug 2021 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khEElHuOI3DbPDFcMisbaPm5UlIpzLcnZqdY0D9rfns=;
        b=VWi9Dh7Fy08OhpMpxXK2vGmlhuJXYkV7lH2SLXr4Q882bUEc+Snv0m1b8zUyvUlUK/
         UArX1OA95er3Kbmv/2RfMlWedc6AagpnCfJOOFC3FflflyHDtPZzuSIl+78WiE1xp2AT
         zvmGpBanFXJ3PEv7IhoxEEova4HExyvQ5lYJqtsj+nobUL1J0Hc596qQZcuPfropc8ex
         Xjb+mvDGxylZZrCLlxxDbG8gWCcuWuRY2DJrD91B8kZ3DBTgss0xfVrZMem50vbev5fp
         544gGlGY/z5UV9GfcFVTNoGxTsaH6iMYwPHe4P9TcaCC1MxtHAF4QYTEB7wYJN+h/fCL
         n7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khEElHuOI3DbPDFcMisbaPm5UlIpzLcnZqdY0D9rfns=;
        b=Gl0OGSaQO54YSpBnaOwvOGIltb/F6MSN6JiVd271M33BIgO1bLaCLTC6O+92H9U+cN
         Vb0Xmmww3+W+lotGNkpSejBPepdiNz7A4uLRzhZ6orVic/BB9Jt7DEbTtRXtMu7qhO/p
         W0w3RUPdKF6DXO2ZhRtmJS1tRGmI5+njOd31/7JfY00pdTt+xsfMaD+G0lDDsOfoyE2B
         JAaakXaf1MboYQGjCupGsgtxYRkVVP1vBzvN3rPRsB74Wpwli+I6pstV82dow23zas15
         6sVz/NeUcFbxbURY7GfDGeQjGBN5YwGE/YidRWaeqkEK3Mf0OKFD2q2baw32u1VUmF94
         8FDQ==
X-Gm-Message-State: AOAM532OL/YuHoINGZ2ltBUt9hV2+/KBcrG5A9S7QAPdZSJgoAjzQIv6
        GqVx/cz7Bt0KNSVJwsoJmxiCBPLJ5naFWIdWHY4=
X-Google-Smtp-Source: ABdhPJzgl27GvQ47lQDq/q0SUzPC8oQpEblVxEvBZVrw9kmyUM30lWZc+WVaLYa1sv0a9Oo8fj99Z7DuvikIR9y8PPo=
X-Received: by 2002:a25:d691:: with SMTP id n139mr16650954ybg.27.1628291698484;
 Fri, 06 Aug 2021 16:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210803010331.39453-1-ederson.desouza@intel.com> <20210803010331.39453-17-ederson.desouza@intel.com>
In-Reply-To: <20210803010331.39453-17-ederson.desouza@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 Aug 2021 16:14:47 -0700
Message-ID: <CAEf4BzaqUTmVVkU1ANXLg-Dchuvc0DW9-Q1K6nz6uLNqzCRyuw@mail.gmail.com>
Subject: Re: [[RFC xdp-hints] 16/16] samples/bpf: Show XDP hints usage
To:     Ederson de Souza <ederson.desouza@intel.com>
Cc:     xdp-hints@xdp-project.net, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 2, 2021 at 6:05 PM Ederson de Souza
<ederson.desouza@intel.com> wrote:
>
> An example of how to retrieve XDP hints/metadata from an XDP frame. To
> get the xdp_hints struct, one can use:
>
> $ bpftool net xdp show
>   xdp:
>   enp6s0(2) md_btf_id(44) md_btf_enabled(0)
>
> To get the BTF id, and then:
>
> $ bpftool btf dump id 44 format c > btf.h
>
> But, in this example, to demonstrate BTF and CORE features, a simpler
> struct was defined, containing the only field used by the sample.
>
> A lowpoint is that it's not currently possible to use some CORE features
> from "samples/bpf" directory, as those samples are currently built
> without using "clang -target bpf". This way, it was not possible to use
> "bpf_core_field_exists" macro to check, in runtime, the presence of a
> given XDP hints field.
> ---

FYI, Kumar Kartikeya Dwivedi is adding vmlinux.h and CO-RE support to
samples/bpf in [0].

  [0] https://lore.kernel.org/bpf/20210728165552.435050-1-memxor@gmail.com/


>  samples/bpf/xdp_sample_pkts_kern.c | 21 +++++++++++++++++++++
>  samples/bpf/xdp_sample_pkts_user.c |  4 +++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>

[...]
