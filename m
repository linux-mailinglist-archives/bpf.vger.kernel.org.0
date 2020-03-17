Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D849B188E6F
	for <lists+bpf@lfdr.de>; Tue, 17 Mar 2020 20:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgCQT5Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Mar 2020 15:57:25 -0400
Received: from www62.your-server.de ([213.133.104.62]:43452 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQT5Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Mar 2020 15:57:25 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jEIL4-00075E-GS; Tue, 17 Mar 2020 20:57:22 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jEIL4-000TqS-6f; Tue, 17 Mar 2020 20:57:22 +0100
Subject: Re: [PATCH v2 bpf-next] bpf: Document bpf_inspect drgn tool
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, osandov@fb.com, corbet@lwn.net, toke@redhat.com,
        brouer@redhat.com, kernel-team@fb.com
References: <20200314003916.2753148-1-rdna@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9b7e4709-80c2-7509-6cfd-1a46eef5c5d6@iogearbox.net>
Date:   Tue, 17 Mar 2020 20:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200314003916.2753148-1-rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Andrey,

On 3/14/20 1:39 AM, Andrey Ignatov wrote:
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
>   Documentation/bpf/drgn.rst  | 39 +++++++++++++++++++++++++++++++++++++
>   Documentation/bpf/index.rst |  5 +++--
>   2 files changed, 42 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/bpf/drgn.rst
> 
> diff --git a/Documentation/bpf/drgn.rst b/Documentation/bpf/drgn.rst
> new file mode 100644
> index 000000000000..2ff9ef3e0b58
> --- /dev/null
> +++ b/Documentation/bpf/drgn.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +==============
> +BPF drgn tools
> +==============
> +
> +drgn scripts is a convenient and easy to use mechanism to retrieve arbitrary
> +kernel data structures. drgn is not relying on kernel UAPI to read the data.
> +Instead it's reading directly from ``/proc/kcore`` or vmcore and pretty prints
> +the data based on DWARF debug information from vmlinux.
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
> +Any developer can edit the tool and get any piece of ``struct bpf_prog`` or
> +``struct bpf_map`` they're interested in, e.g. the whole ``struct
> +bpf_prog_aux``.
> +
> +See ``--help`` for more details.

I do like bcc's explicit usage examples/recipes so one can immediately grok
whether it fits to a given use-case (e.g. [0]). Given this is targeted for
developers perhaps it makes sense to add an example usage as you have described
in [1] to the doc as well here?

Maybe last two paragraphs are not that useful. Could we structure each tool
we're going to add here with two sub-headers "Description", "Getting Started"
where the former has the first two paragraphs and then the latter has a usage
example that shows e.g. [1] or as you write in your last paragraph a modification
to dump the whole ``struct bpf_prog_aux``, for example?

Thanks,
Daniel

   [0] https://github.com/iovisor/bcc/blob/master/tools/bpflist_example.txt
   [1] https://github.com/osandov/drgn/pull/49

> +.. Links
> +.. _drgn/doc: https://drgn.readthedocs.io/en/latest/
> +.. _drgn/tools: https://github.com/osandov/drgn/tree/master/tools
> +.. _bpf_inspect.py:
> +   https://github.com/osandov/drgn/blob/master/tools/bpf_inspect.py
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index 4f5410b61441..7be43c5f2dcf 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -47,12 +47,13 @@ Program types
>      prog_flow_dissector
>   
>   
> -Testing BPF
> -===========
> +Testing and debugging BPF
> +=========================
>   
>   .. toctree::
>      :maxdepth: 1
>   
> +   drgn
>      s390
>   
>   
> 

