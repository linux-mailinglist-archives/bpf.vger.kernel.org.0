Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9027539FB2C
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFHPv7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhFHPv6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 11:51:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF927C061574
        for <bpf@vger.kernel.org>; Tue,  8 Jun 2021 08:49:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e2so27661187ljk.4
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5j/M5QZNZfhQkLP/CuNBeP/vLcyCK1JxVCvewsMpIwM=;
        b=lj4zCUN3gXcO8kdh54u7nfPGRj2dXq92fwYLPSCyLt+ZiHvCSCXxF5m2U/q4yKxrDf
         Dh+Iw5EqHer5/cnV+ss0LT1l2gwBsUuUfmV5IanKuExnL0/I5iJ43q2MFKWiAxkooYFz
         17P7KoV8ap82rrWq7rBAXCy8UViuDeL4JQrOHEai+uOv/Zju2UlDLhD0mJr/rJwXOig8
         P8VeV/zKq0zCbDiagRVQA1t740ikxaHT3hHW4/1GLbaKNSRqNzUVs3jl5iSVk97RFL25
         5oM/GjfQZtjFWAjeSZG73HbkJGCyElem7Jq6q8kxneFK4EkoW/e3V45pZtxUYt+pX2wf
         ImuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5j/M5QZNZfhQkLP/CuNBeP/vLcyCK1JxVCvewsMpIwM=;
        b=e6RvCHuKfbnGt1uIF3Pg+hDGN8kMm6L3oYIQJvnlmuvHOF+QspwmytEaihdopyDbUq
         4Eafao74EsX+xlJJfTO9gQHQeU5vFvnnaxIwThnaeADar+AmAylAcqth+avOzBE5F7AW
         9VAbCZDWQH14fk8FKYpPGmAZaBbo7j0VjhbFNURr7GkJMxGMk9OsgeJDrhXXinDJvd7O
         4Ag2BAyW3P3qVUmQ8eponePH8bIVfpWhov1WTqLuWZBt3WpGIUA6imb6YkcCwD8H+qKm
         pns1bQ0Hkw/+jf5yNImBXo07+Le0Epbt32k7VNNFeeV49RoBL2DZTyMaj7kA1g6PF2LQ
         JNmA==
X-Gm-Message-State: AOAM532Gn51nKJLr3tHASrhzk+LBcY8Epvu+nzr7prGJ7TbXe6uJqYoS
        rdByAb7B603tlgLw4Mk8z0u2NpaTSxMCckXQH28=
X-Google-Smtp-Source: ABdhPJyxQVF7BusirVG8cdpw1tjQDMO9htU2ezi+jR60u9xuNX3a9iN8RlYt20Q7X+aEiAEJe/SZDeVIJk5PxMAe/aY=
X-Received: by 2002:a2e:a4a5:: with SMTP id g5mr18454498ljm.32.1623167393104;
 Tue, 08 Jun 2021 08:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210525033314.3008878-1-yhs@fb.com> <20210525182948.4wk3kd7vrvgdr2lu@google.com>
 <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com> <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
 <4410f328-58ae-24e4-5e63-cfde6e891bf4@fb.com> <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
 <8abe01cb-da8f-514c-6b52-b92686a16662@fb.com> <CAFP8O3JeGtDMATPsnjhRO3Ru+Lap2uJSG_jYzWcK4AWeBtXquw@mail.gmail.com>
In-Reply-To: <CAFP8O3JeGtDMATPsnjhRO3Ru+Lap2uJSG_jYzWcK4AWeBtXquw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Jun 2021 08:49:41 -0700
Message-ID: <CAADnVQ+sD7ELvEwKf5Ui1dVkXPYEyjkwFxogxP5_4vrH3nMhPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 7, 2021 at 10:51 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@googl=
e.com> wrote:
>
> You can rename R_BPF_64_64 to something more meaningful, e.g. R_BPF_64_LD=
IMM64.
> Then I am fine that such a relocation type applies inconsecutive bytes.
>
> See below. Just change every occurrence of the old name in llvm-project.

No. We cannot rename them, because certain gnu tools resolve relos by name
and not by number.
The only thing we can do is to document why such a name was picked in
the first place.
Back then 64_64 meant that it applied to 64-bit field in 16-byte insn.
Whereas 64_32 meant that it applied to 32-bit field in 8-byte insn.
64_64 used to be called 64_MAPFD relo, but was renamed early enough
while we still had time to do such rename. Now backward compatibility
is more important than odd looking names.
