Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743EF17379B
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2020 13:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgB1MvL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Feb 2020 07:51:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51893 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgB1MvL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Feb 2020 07:51:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so3091667wmi.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2020 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=67JaZh6n/iLBgJ2e7SLAF9eeegRJPWxZuhWbhapxytY=;
        b=VVtoiXtsIQD5mIVT+AXUikBYsNPMSV/km8yRK2OfcBc7M27c02qYERz7UyN7RYsVUu
         V4lmRsEYcF7ZGsIeabsrqd5B+IqZzZ3nzZr0PnmHrbvOHemeNaNO2aoiHFqzTuOIo2+0
         Trd+A6By7f3vRn2giUmVBq01vdjQOi3lmMSef+tD+4qALzUmBWwVU5n/nKJSpiYDAQta
         36bPkPjnv6Ovaq5A9LyPzao0x3mpTU/ajaq0mtEU+vHN2163+woEgkm5U6aDOBM1+flK
         37OkXa4u6Bbc73AjQGJUTqCM8XXpKWJqgswqR3Nir2m7/UcgRkYNOqVAEfnIKPRnUUkv
         Q3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=67JaZh6n/iLBgJ2e7SLAF9eeegRJPWxZuhWbhapxytY=;
        b=ZZ3Rz7RaVuOrlAT8CiXfQCjDWeny7yQaERRGpv9skqPbZvc7+Cc1Lpd4RXEwwwKblj
         cgpNRZzYF+R8nwuDxU450IH5DmoNgAHfgBujzxKEfE9y21Y+sCesMpQnt9ASpqqQr6cA
         rPZEXzZp8ikWo9hA8HcC28tsudoFX0tpPIsffKpBI/0HNToc+bFhR+6jo/0cnTrAkO3D
         mDLO+WFVE+R3CehYjmolF4ua4fakCGN0/nht979tUWCtEgPOPSfODQ0KdfE+wbhv0GSt
         5eRTmCRVn2tI26duyTHjvxVV0Qqx/3vYUbgMLmryhYLuTBj7s6hNTqg/qiBALyKIwJ06
         Im9Q==
X-Gm-Message-State: APjAAAVGntm47IixNFMA7jeWqJU7f9j87QxfGrKnia0DCEWYUlgn6SJq
        RbUjSBiPrgB4xrla9F0/6RUMIa7WCkA=
X-Google-Smtp-Source: APXvYqw7dBWw+8ytxTESXAdYyrwUdE2mYJoYQf/Qab6c146S3UfXMNpv4en+VCUynxJF56jDsMZ8fg==
X-Received: by 2002:a1c:4e18:: with SMTP id g24mr4912908wmh.95.1582894267297;
        Fri, 28 Feb 2020 04:51:07 -0800 (PST)
Received: from [192.168.1.10] ([194.35.116.65])
        by smtp.gmail.com with ESMTPSA id f65sm2023963wmf.29.2020.02.28.04.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 04:51:06 -0800 (PST)
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, osandov@fb.com,
        kernel-team@fb.com
References: <20200227023253.3445221-1-rdna@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <42af50cc-acde-d7a9-19da-8e2fb87bce48@isovalent.com>
Date:   Fri, 28 Feb 2020 12:51:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227023253.3445221-1-rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-02-26 18:32 UTC-0800 ~ Andrey Ignatov <rdna@fb.com>
> drgn is a debugger that reads kernel memory and uses DWARF to get types
> and symbols. See [1], [2] and [3] for more details on drgn.
> 
> Since drgn operates on kernel memory it has access to kernel internals
> that user space doesn't. It allows to get extended info about various
> kernel data structures.
> 
> Introduce bpf.py drgn script to list BPF programs and maps and their
> properties unavailable to user space via kernel API.
> 
> The main use-case bpf.py covers is to show BPF programs attached to
> other BPF programs via freplace/fentry/fexit mechanisms introduced
> recently. There is no user-space API to get this info and e.g. bpftool
> can only show all BPF programs but can't show if program A replaces a
> function in program B.
> 

[...]

> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>   tools/bpf/bpf.py | 149 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 149 insertions(+)
>   create mode 100755 tools/bpf/bpf.py
> 
> diff --git a/tools/bpf/bpf.py b/tools/bpf/bpf.py
> new file mode 100755
> index 000000000000..a00d112c0486
> --- /dev/null
> +++ b/tools/bpf/bpf.py
> @@ -0,0 +1,149 @@
> +#!/usr/bin/env drgn
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +#
> +# Copyright (c) 2020 Facebook
> +
> +DESCRIPTION = """
> +drgn script to list BPF programs or maps and their properties
> +unavailable via kernel API.
> +
> +See https://github.com/osandov/drgn/ for more details on drgn.
> +"""
> +
> +import argparse
> +import sys
> +
> +from drgn.helpers import enum_type_to_class
> +from drgn.helpers.linux import (
> +    bpf_map_for_each,
> +    bpf_prog_for_each,
> +    hlist_for_each_entry,
> +)
> +
> +
> +BpfMapType = enum_type_to_class(prog.type("enum bpf_map_type"), "BpfMapType")
> +BpfProgType = enum_type_to_class(prog.type("enum bpf_prog_type"), "BpfProgType")
> +BpfProgTrampType = enum_type_to_class(
> +    prog.type("enum bpf_tramp_prog_type"), "BpfProgTrampType"
> +)
> +BpfAttachType = enum_type_to_class(
> +    prog.type("enum bpf_attach_type"), "BpfAttachType"
> +)

Hi Andrey, the script looks neat, thanks for this work!

I tried to run it on my system. Because my kernel is 5.3 and does not 
have "enum bpf_tramp_prog_type", the script crashes on the above 
assignments. But even without that enum, it could be possible to print 
program and map ids and types (even if we don't show the trampolines).

Do you think it would be worth adding error handling on that block, 
something like:

     try:
         BpfMapType = ...
         BpfProgType = ...
         BpfProgTrampType = ...
         BpfAttachType = ...
     except LookupError as e:
         print(e) # Possibly add a hint as kernel being too old?

I understand that printing the BPF extensions is the main interest of 
the script, I'm just thinking it would be nice to use it / tweak it even 
if not on the latest kernel. What do you think?

> +
> +
> +def get_btf_name(btf, btf_id):
> +    type_ = btf.types[btf_id]
> +    if type_.name_off < btf.hdr.str_len:
> +        return btf.strings[type_.name_off].address_of_().string_().decode()
> +    return ""
> +
> +
> +def get_prog_btf_name(bpf_prog):
> +    aux = bpf_prog.aux
> +    if aux.btf:
> +        # func_info[0] points to BPF program function itself.
> +        return get_btf_name(aux.btf, aux.func_info[0].type_id)
> +    return ""
> +
> +
> +def get_prog_name(bpf_prog):
> +    return get_prog_btf_name(bpf_prog) or bpf_prog.aux.name.string_().decode()
> +
> +
> +def attach_type_to_tramp(attach_type):
> +    at = BpfAttachType(attach_type)
> +
> +    if at == BpfAttachType.BPF_TRACE_FENTRY:
> +        return BpfProgTrampType.BPF_TRAMP_FENTRY
> +
> +    if at == BpfAttachType.BPF_TRACE_FEXIT:
> +        return BpfProgTrampType.BPF_TRAMP_FEXIT
> +
> +    return BpfProgTrampType.BPF_TRAMP_REPLACE
> +
> +
> +def get_linked_func(bpf_prog):
> +    kind = attach_type_to_tramp(bpf_prog.expected_attach_type)
> +
> +    linked_prog = bpf_prog.aux.linked_prog
> +    linked_btf_id = bpf_prog.aux.attach_btf_id
> +
> +    linked_prog_id = linked_prog.aux.id.value_()
> +    linked_name = "{}->{}()".format(
> +        get_prog_name(linked_prog),
> +        get_btf_name(linked_prog.aux.btf, linked_btf_id),
> +    )
> +
> +    return "{}->{}: {} {}".format(
> +        linked_prog_id, linked_btf_id.value_(), kind.name, linked_name
> +    )
> +
> +
> +def get_tramp_progs(bpf_prog):
> +    tr = bpf_prog.aux.trampoline
> +    if not tr:
> +        return

Same observation here, I solved it with

     try:
         tr = bpf_prog.aux.trampoline
         if not tr:
             return
     except AttributeError as e:
         print(e)
         return

Best regards,
Quentin
