Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06484D25B8
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 02:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiCIBLh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 20:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiCIBL0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 20:11:26 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E0E134DF6
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 17:04:32 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id r11so1065055ioh.10
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 17:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6ZVDamFNliYpGoOU9HrXxos34ciX1Nor40Ayrh8z3Q=;
        b=Uri3n2A3wAangs/X15vt0eD/2PrYd7tk1g1fjTk8lbh6OQD7mTw/4UMRqNColqXws9
         fOAq9TrMwqZbRMK64vMbhUUvR/JqZEqRXquabGqxID30eFQii5UOAtalji1cT4rlhDfF
         lNe2BjaV0pP3Use9Du7vmPmmCmzx48DMk7nR5v5o2zPc8F0UUbt7kyjhMxXWmQ2gLRo7
         kFTTg9bwsH7lVV2hNSxb8s8rmj0NxmNOENPjRpzfpUwpBg34eGGXrqhsMxUTBcH5krJO
         vH/giFd7eDFrDgPfZRUGA03a77Gh/9cnDJRv4uNi/8E8OsGghlCKUALUFQokgNPqMXkC
         qb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6ZVDamFNliYpGoOU9HrXxos34ciX1Nor40Ayrh8z3Q=;
        b=nJ7dkmFIWAv6Uuxqr0rjYahiwsVCoIWZyO9GexsFZ8UPU+9EagNVix0T8L1sUf5mlB
         vgC4U03S7QvjkcbWyGk30R5x7urVrvhg8TWMdRSI8r7VkSVGZOqE9BvU0sFyIE9bnjCc
         Vkl+00hOL+D0y4v0H4aHNvuEIciBoyvhxB+G1do+HAbw2CdKG8GAyRPd18Ka1MRjM+dv
         Kan7O0biTxuN0KP3XhLrK2tpnYvrkZT3sCt0R3KW5I2M2xb8koLzuCURH3PASh2RqCe4
         WiToqnjYWoTgLS5gFbJP6UjTRo6RiUT4/2iQdwCUpwfZrTlBTzBR+6yDCia2b7ocDT9D
         kogw==
X-Gm-Message-State: AOAM532PT0HpsxNaSeMR4NmZ1lndSqHQjVoTwdaOWrW9U+g3tsEaow4I
        8bklWgEI+qUA1CD8taO537yDWLwoZ0NmSD5+nxUELyvJN8lu7A==
X-Google-Smtp-Source: ABdhPJyItVfvGGB7rQYArwwozOW4DWFZokB0UVxNuKpJSv+U/Z5bX4LP56QXGiuDofXUUoaeucSxR4S91XhRmJZxLfg=
X-Received: by 2002:a05:6638:1035:b0:306:e5bd:36da with SMTP id
 n21-20020a056638103500b00306e5bd36damr18025550jan.145.1646783357271; Tue, 08
 Mar 2022 15:49:17 -0800 (PST)
MIME-Version: 1.0
References: <CH2PR21MB1430AFEB81F5F7930E8027C1FA089@CH2PR21MB1430.namprd21.prod.outlook.com>
In-Reply-To: <CH2PR21MB1430AFEB81F5F7930E8027C1FA089@CH2PR21MB1430.namprd21.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Mar 2022 15:49:06 -0800
Message-ID: <CAEf4BzYsGVSTS5t=OBPpMKcGm8F0aB4PG=dxK+Pg=UeP18o0NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Support load time binding of bpf-helpers.
To:     Alan Jowett <Alan.Jowett@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 8, 2022 at 9:20 AM Alan Jowett <Alan.Jowett@microsoft.com> wrote:
>
> BPF helper function names are common across different platforms, but the
> id assigned to helper functions may vary. This change provides an option
> to generate eBPF ELF files with relocations for helper functions which
> permits resolving helper function names to ids at load time instead of
> at compile time.
>
> Add a level of indirection to bpf_doc.py (and generated bpf_helper_defs.h)
> to permit compile time generation of bpf-helper function declarations to
> facilitating late binding of bpf-helpers to helper id for cases where
> different platforms use different helper ids, but the same helper
> functions.
>
> Example use case would be:
> "#define BPF_HELPER(return_type, name, args, id) \
>     extern return_type name args"
>
> To generate:
> extern void * bpf_map_lookup_elem (void *map, const void *key);
>
> Instead of:
> static void *(*bpf_map_lookup_elem) (void *map, const void *key) \
>     = (void*) 1;
>
> This would result in the bpf-helpers having external linkage and permit
> late binding of BPF programs to helper function ids.
>

Ugh...

BPF_HELPER(void*, bpf_map_lookup_elem, (void *map, const void *key), 1);

Looks pretty awful :(

But I also have the question about why different platforms should have
different IDs for the same subset of BPF helpers? Wouldn't it be
better to preserve IDs across platforms to simplify cross-platform BPF
object files?

We can probably also define some range for platform-specific BPF
helpers starting from some high ID?

> Signed-off-by: Alan Jowett <alanjo@microsoft.com>
> ---
>  scripts/bpf_helpers_doc.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
> index 867ada23281c..442b5e87687e 100755
> --- a/scripts/bpf_helpers_doc.py
> +++ b/scripts/bpf_helpers_doc.py
> @@ -519,6 +519,10 @@ class PrinterHelpers(Printer):
>          for fwd in self.type_fwds:
>              print('%s;' % fwd)
>          print('')
> +        print('#ifndef BPF_HELPER')
> +        print('#define BPF_HELPER(return_type, name, args, id) static return_type(*name) args = (void*) id')
> +        print('#endif')
> +        print('')
>
>      def print_footer(self):
>          footer = ''
> @@ -558,7 +562,7 @@ class PrinterHelpers(Printer):
>                  print(' *{}{}'.format(' \t' if line else '', line))
>
>          print(' */')
> -        print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
> +        print('BPF_HELPER(%s%s, %s, (' % (self.map_type(proto['ret_type']),
>                                        proto['ret_star'], proto['name']), end='')
>          comma = ''
>          for i, a in enumerate(proto['args']):
> @@ -577,7 +581,7 @@ class PrinterHelpers(Printer):
>              comma = ', '
>              print(one_arg, end='')
>
> -        print(') = (void *) %d;' % len(self.seen_helpers))
> +        print('), %d);' % len(self.seen_helpers))
>          print('')
>
>  ###############################################################################
> --
> 2.25.1
