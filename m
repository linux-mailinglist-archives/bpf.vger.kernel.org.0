Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5233C183EA8
	for <lists+bpf@lfdr.de>; Fri, 13 Mar 2020 02:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCMB0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 21:26:53 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56037 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMB0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 21:26:53 -0400
Received: by mail-pj1-f68.google.com with SMTP id mj6so3162930pjb.5
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 18:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fAYGHRHgSFPKk7NruJVdpy863W0ES9xtwAiAQlNSzlI=;
        b=tpKtNG/KG/jPRnfoeq9RAq4x4Ab09uvoaer4tT8aekZFd9WpTWBvrACWQh7diL4vF5
         CRKF4TyANfAw/dDPiry+gzvLkwWXq3RK/GqzFv15QgHOu365SUjc7H8greE6DvkdLPwB
         V0g/zBwGO4HLvZH1AC/FzV3iWpytNx1h5QvExVrMb9M4vTfsHRgeA24/GxMeyDDWe8p8
         4ZcWYcwJz7GCfRCveMqzJzkQURiCjQHm90FrH4NbHQNNvW25seCUebaLaVusydx/Jjk5
         n2j8iItNBiBlEUfioS8CPQTxBwja/A+lfPP+mJbQS7r6r9B+eqySC0AxhtnELMVWxM1X
         M+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fAYGHRHgSFPKk7NruJVdpy863W0ES9xtwAiAQlNSzlI=;
        b=PecsA667I2o9beAKxboVYWLyJeCjJsV4ydWHCtg/AsIyklPiJQvujwVKdTR2Dp8CXt
         fVEiVbrmc83O13AEXVlCjKZDBlhhrA9kSVZAY0EoEG5hAY2O5eRJ6Tm0/0bCTPwEm0sM
         McauE7KMdUvuSQk/q6bP8s/3l4z7Te4Tb8wRLcHWuwkISB+2tdXIKSCB2dWK44Rtknvu
         W3SxJJapIVkml7LVUUcYAWRBYZrMsOlwUJd9CaxpNolpRiPIYOJWbkbWx9ax3tK1lKaq
         GuNy/72gkEIGSb+oC0aBsKMC7FtWyc9rj92LtAwnY+mkHIAaPAZQk6balHdN1A+TdDXE
         esaQ==
X-Gm-Message-State: ANhLgQ3qpG4R/DxQzHwQV8KGkstTbLE23WF9YJTsPZ3FbRCQa4eo59rU
        27oA2F/Rrd4wpJIo7kLBPzc=
X-Google-Smtp-Source: ADFU+vv8BWLHRUpY0ibo1rdSm6qQMY4JS9XjlqZ9471Qx7V8c4w8CBxVjpIGriYjrpSaeeoHT6m8bg==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr10658642plf.255.1584062812156;
        Thu, 12 Mar 2020 18:26:52 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:df27])
        by smtp.gmail.com with ESMTPSA id g16sm55556757pgb.54.2020.03.12.18.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 18:26:50 -0700 (PDT)
Date:   Thu, 12 Mar 2020 18:26:48 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        osandov@fb.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf: Document bpf_inspect drgn tool
Message-ID: <20200313012648.4sttadqm7g52gldw@ast-mbp>
References: <20200311191440.3988361-1-rdna@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311191440.3988361-1-rdna@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 11, 2020 at 12:14:40PM -0700, Andrey Ignatov wrote:
> It's a follow-up for discussion in [1].
> 
> drgn tool bpf_inspect.py was merged to drgn repo in [2]. Document it in
> kernel tree to make BPF developers aware that the tool exists and can
> help with getting BPF state unavailable via UAPI.
> 
> For now it's just one tool but the doc is written in a way that allows
> to cover more tools in the future if needed.
> 
> Please refer to the doc itself for more details.
> 
> The patch was tested by `make htmldocs` and sanity-checking that
> resulting html looks good.
> 
> [1]
> https://lore.kernel.org/bpf/20200228201514.GB51456@rdna-mbp/T/#mefed65e8a98116bd5d07d09a570a3eac46724951
> [2] https://github.com/osandov/drgn/pull/49
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  Documentation/bpf/drgn.rst  | 42 +++++++++++++++++++++++++++++++++++++
>  Documentation/bpf/index.rst |  5 +++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/bpf/drgn.rst

Location looks good, but I gotta nit pick on wording...

> diff --git a/Documentation/bpf/drgn.rst b/Documentation/bpf/drgn.rst
> new file mode 100644
> index 000000000000..9a9ad75ab066
> --- /dev/null
> +++ b/Documentation/bpf/drgn.rst
> @@ -0,0 +1,42 @@
> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +==============
> +BPF drgn tools
> +==============
> +
> +drgn scripts are great to debug kernel internals including BPF and get
> +information unavailable via conventional kernel UAPI.
> +
> +If there is a piece of kernel state useful for a small number of users, e.g.
> +only for BPF developers, or too expensive to expose to user space, drgn script
> +can be a good option to still have access to that state but without extending
> +UAPI.

Above two paragraphs are true for any piece of kernel data.
I think they're unnecessary focusing attention on bpf.
May be rephrase the whole thing like:
"
drgn scripts is a convenient and easy to use mechanism to retrieve arbitrary
kernel data structures. drgn is not relying on kernel UAPI to read the data.
Instead it's reading directly from /proc/kcore or vmcore and pretty prints the
data based on dwarf debug information from vmlinux.
"

> +
> +This document describes BPF related drgn tools.
> +
> +See `drgn/tools`_ for all tools available at the moment and `drgn/doc`_ for
> +more details on drgn itself.
> +
> +bpf_inspect.py
> +**************
> +
> +`bpf_inspect.py`_ is a tool intended to inspect BPF programs and maps. It can
> +iterate over all programs and maps in the system and print basic information
> +about these objects, including id, type and name.
> +
> +The main use-case `bpf_inspect.py`_ covers is to show BPF programs of types
> +``BPF_PROG_TYPE_EXT`` and ``BPF_PROG_TYPE_TRACING`` attached to other BPF
> +programs via ``freplace``/``fentry``/``fexit`` mechanisms, since there is no
> +user-space API to get this information.
> +
> +But developer can edit the tool and get any piece of ``struct bpf_prog`` or

Just drop 'but' and say 'Any developer can edit ...'

> +``struct bpf_map`` they're interested in, e.g. the whole ``struct
> +bpf_prog_aux``.
> +
