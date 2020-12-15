Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA332DA58C
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 02:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgLOB3Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 20:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgLOB3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 20:29:14 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E20C061793;
        Mon, 14 Dec 2020 17:28:34 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id u203so17397569ybb.2;
        Mon, 14 Dec 2020 17:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tG4gNcU9i2iNKiEYjEdTI+569AyOvt13AV3wALhN/mo=;
        b=j2SaQNpPHRg0iV7Fb1p+8e7aNHnDY8xe3sgUW+fg8vUcmdeuyBp9OQK/oiUSL5CyeQ
         hiUy80lw7ffA+V9YiXClgATfgAiBJKuRSeJYa4KQ4x9Sd2+TZU1ZAb4jqTtLwLlU7qsM
         wHC1OpoFLiZUJRZEAVjA7Pca0IEwEdpQ/sdBwmivoPJYjdl8hfOZNLk762LSp2LuC1T1
         kLPBySL8DKjlwUJ9cnpoJ/OSd518OUo7P6pMF9sHeHf3bZ563MO7NJMbpWjJykR7y7uy
         TuxE48E1yRGBKZnC5lvxWs0/1ietiEMn/LmaxIYW1fJLpUqv+iCKH/oAYPhgQ7eLNzvG
         1x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tG4gNcU9i2iNKiEYjEdTI+569AyOvt13AV3wALhN/mo=;
        b=lT4oymFUP1tRVwSoI6P5NTqE0ACClXs5lZhC/qVo4pDtM5611YHLjUDAwJRQi/xQjK
         85yASOzuw+SkDP2Z0ZbN4KvlGiwUbiWb5H1/Sclb2hvLCJMlYmyBtv5kVeghxKFvMieL
         BNOZhYVlbjhxruulPTkR6i9Qse0TwpMM3dj98MuNEhn1IanHgBtsXFK0FuaeldNG6PH2
         ACzqqxChBBjbIfg1rmVDNGq0LxevUq9vVmyGI8R28TqKcIUTFQNFXgZoy61tbvSBEXqW
         p3ojvIIdiXUeS/J6BIyIyKhcJuzlxPVxsMhOsIVtQxu96gH8iiYAnkwUXytwVH2UVPih
         a+jg==
X-Gm-Message-State: AOAM531221JHPMh00dnsOMw1Wjcv0zVyBtHAHdFW/QkIWZ/WMd8IY7jN
        GrvM9H3IUvNqZYW7rtNSSZn1vrQgyrrLkXHEBdE=
X-Google-Smtp-Source: ABdhPJx1EON1g23rM4g5exfClm1Q6eM4bhm5ptHpvDxWPNeOzoSTcV9a9ZY0rkb5MTgHDKPXUZVMVh85YC645kJ0qc4=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr39879121ybe.403.1607995712900;
 Mon, 14 Dec 2020 17:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20201211041139.589692-1-andrii@kernel.org> <20201213202757.GA482741@krava>
 <20201214134343.GF238399@kernel.org>
In-Reply-To: <20201214134343.GF238399@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Dec 2020 17:28:22 -0800
Message-ID: <CAEf4BzbCeeVuZaEkykNpc35+7xRcWtPCbwGpGNwET_5mBBPN7A@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/2] Fix pahole to emit kernel module BTF variables
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 14, 2020 at 5:43 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, Dec 13, 2020 at 09:27:57PM +0100, Jiri Olsa escreveu:
> > On Thu, Dec 10, 2020 at 08:11:36PM -0800, Andrii Nakryiko wrote:
> > > Two bug fixes to make pahole emit correct kernel module BTF variable
> > > information.
> > >
> > > Cc: Hao Luo <haoluo@google.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > >
> > > Andrii Nakryiko (2):
> > >   btf_encoder: fix BTF variable generation for kernel modules
> > >   btf_encoder: fix skipping per-CPU variables at offset 0
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> Thanks, applied.
>

Thanks, Arnaldo. I'm not seeing them on
gitolite.kernel.org/pub/scm/devel/pahole/pahole.git, did you push them
somewhere else?

> - Arnaldo
>
