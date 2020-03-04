Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385C2178B3D
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 08:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgCDHY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 02:24:29 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36313 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgCDHY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 02:24:29 -0500
Received: by mail-io1-f66.google.com with SMTP id d15so1301829iog.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 23:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0StPfC8X5r/f0uwQzYAuENN0Fy4oQ3SfFfmaNBTQnc=;
        b=X5H4VtDyPvqJAdUJVPRhTnJNzg0cr0lXQnBxXOFBn70TvIaxwS7X1BhYAA6rW6iMx/
         2KL8fW6WmM9hvIfkxJ9HJLlSveCUGVutVFlbs/Dn3AB07u+7H4rIDUAkprO6clAYF+fk
         Yp/tkE8C0hW1UN84pzTDY8f0QLod+qUSCGqHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0StPfC8X5r/f0uwQzYAuENN0Fy4oQ3SfFfmaNBTQnc=;
        b=JEFaBQ5MxZep/y/Qv2IjdJtOhABdTCWfmH9SFQqu/r3eZIbaeTYOWfIvoO0/Bxo9B1
         OfZgcaTfY9LnFeC5u8M2NMO7bwh7HtJriQeJVJ02u6zmh2qkkv9Q37wcJqXi48gm6Szy
         01Ml8/gkgukXxFgxqVj0eWN/QHz6klbIq61KMt/82CaxwtQzHIrLgLdcmWBrtPWImnX6
         xYUElRxx6ZTZT9a1GCCzCYto37dZLsvwiD5vWTGrfUMK9QBFjmahHIgV42TCmW64U4uW
         2yQ4DWBQcQuYaHO04l85thTbeSYrd3mR5dhTfVEumAJk3Q6VhBPFHOhgnctR2DsM7YY8
         atzg==
X-Gm-Message-State: ANhLgQ01wI5IS2vlEmqfVrkV2FJTrEE484FI1aufFDPcUa1W5Rujcsvb
        mQMSBS8wxf+yp1aLNukXZ1Q2fvjS1eZ/9dUOUg8d3A==
X-Google-Smtp-Source: ADFU+vtDP7J5I0uMr20ywNsGyuaqUtek9TyRHdnutO5YfvwGkuTKwFkRZeZRpw6nW1oXLNcQ+vXM+/g2FixK4+iaGBM=
X-Received: by 2002:a02:a1c9:: with SMTP id o9mr1543147jah.33.1583306668640;
 Tue, 03 Mar 2020 23:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20200303005035.13814-1-luke.r.nels@gmail.com> <20200303005035.13814-3-luke.r.nels@gmail.com>
 <CAJ+HfNjgwVnxnyCTk5j+JCpxz+zmeEBYbj=_SueR750aAuoz=A@mail.gmail.com>
 <CADasFoBODSbgHHXU+iA-32=oKNs6n0Ff_UDU3063uiyGjx1xXg@mail.gmail.com> <CAJ+HfNhOp_Rbcqer0K=mZ8h+uswYSv4hSa3wCTdjjxH26HUTCw@mail.gmail.com>
In-Reply-To: <CAJ+HfNhOp_Rbcqer0K=mZ8h+uswYSv4hSa3wCTdjjxH26HUTCw@mail.gmail.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Tue, 3 Mar 2020 23:24:17 -0800
Message-ID: <CADasFoA3JN7PkvnVAmFZOFeDo2WgWzViankpwwRRWcjebSx+DQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] riscv, bpf: add RV32G eBPF JIT
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Xi Wang <xi.wang@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> I like that, but keep the first patch as a refactoring patch only, and
> then in a *new* patch 2 you add the rv32 specific code (sltu and
> pseudo instructions + the xlen preprocessor check + copyright-things
> ;-)).  Patch 3 will be the old patch 2. Wdyt?

Thanks! I'll make sure that patch 1 is for renaming bpf_jit_comp.c
and factoring code out. Do you think it's reasonable to add the
RV32-specific code to the header in the same patch that adds the
RV32 JIT implementation (patch 2)? It might make sense to commit
them together.

The full plan for v5 would be:

Patch 1

- Refactor existing code to bpf_jit.h and bpf_jit_core.c
  + Including the minor modifications to build_body() and
  bpf_int_jit_compile() (These are unrelated to RV32 and we could
  forego these tweaks).
  + Also making emit_insn and build_{prologue,epilogue} non-static
  and renaming them to be prefixed with "bpf_jit_".
- Rename bpf_jit_comp.c to bpf_jit_comp64.c

Patch 2

- Add the RV32 BPF JIT implementation to bpf_jit_comp32.c and
RV32-specific changes to bpf_jit.h.

Patch 3

- Update documentation.

Patch 4

- Update MAINTAINERS.

Thanks again,

Luke
