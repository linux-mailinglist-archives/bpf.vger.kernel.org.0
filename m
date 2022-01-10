Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17E348A319
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 23:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbiAJWoG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 17:44:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36282 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242210AbiAJWoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 17:44:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F995B81809
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 22:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209CEC36AF3
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 22:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641854642;
        bh=+4HsTaP+HoKnPaVgBtAPcznI4xSidJokuk3GJ2NPTX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eoq1+Z4dQuMczo3GIfLwP/oXYFLn0w7fd/ImQBIHn+c47Av04XGrNr+BlIE4k+PO/
         B0JVH6I9otnaX7YGBgDG6fHdJMyAbcOTHcqLQE+X2OB6qxDyxsff9fzP+xfdNEe+2R
         BNUGBvlW1XYZ0rBP07+I+clsPsW7q5JMzbh5Sd/s2JCq2Ou2GWiMjIxxAFHJ101tEe
         CzKLjk3IKkSiUww+ucu4b9aj6Lu/VyPTYnOA08Bd9zLRLljko1OHh5hGhR3MdYAlGs
         3DedakFr7sIGF98xKwiSKW6oiB8++kMKtg/3o98IDbHXpuMFdSCe/XC4bkKP8nErYi
         dlng7JbNwNtZg==
Received: by mail-yb1-f175.google.com with SMTP id p5so34963752ybd.13
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:44:02 -0800 (PST)
X-Gm-Message-State: AOAM533CUz/IUN3d+RHw1aoNk8YYJ8Dw38IVVWm4wIHs2yov3J8ZTibz
        tXqoN07hg/Tr3q6XQ5fB9hGfWsqYdsr2BmQ5NzY=
X-Google-Smtp-Source: ABdhPJwNk+Y6De/lplQzJmL6ksXvzNywr4f8BGb4CqKAkQwU5nCPWRSsnhwInyZzKeJjM4qgq5O+21YMLEXunZm6n7U=
X-Received: by 2002:a25:c097:: with SMTP id c145mr2539420ybf.282.1641854641122;
 Mon, 10 Jan 2022 14:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20220110143102.3466150-1-usama.arif@bytedance.com>
In-Reply-To: <20220110143102.3466150-1-usama.arif@bytedance.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 10 Jan 2022 14:43:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW58rPRsiKXmUNWa11ROzM5GpwbgAGxm80bgiOGPfmu0qg@mail.gmail.com>
Message-ID: <CAPhsuW58rPRsiKXmUNWa11ROzM5GpwbgAGxm80bgiOGPfmu0qg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf/scripts: add warning if the correct number of
 helpers are not auto-generated
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, joe@cilium.io,
        fam.zheng@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 10, 2022 at 6:31 AM Usama Arif <usama.arif@bytedance.com> wrote:
>
> Currently bpf_helper_defs.h is auto-generated using function documentation
> present in bpf.h. If the documentation for the helper is missing
> or doesn't follow a specific format for e.g. if a function is documented
> as:
>  * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
> instead of
>  * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
> (notice the extra space at the start and end of function arguments)
> then that helper is not dumped in the auto-generated header and results in
> an invalid call during eBPF runtime, even if all the code specific to the
> helper is correct.
>
> This patch checks the number of functions documented within the header file
> with those present as part of #define __BPF_FUNC_MAPPER and generates a
> warning in the header file if they don't match. It is not needed with the

Shall we fail instead of warning?

> currently documented upstream functions, but can help in debugging
> when developing new helpers when there might be missing or misformatted
> documentation.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>
> ---
> v1->v2:
> - Fix CI error reported by Alexei Starovoitov
> ---
>  scripts/bpf_doc.py | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index a6403ddf5de7..e426d2a727cb 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -87,6 +87,8 @@ class HeaderParser(object):
>          self.line = ''
>          self.helpers = []
>          self.commands = []
> +        self.desc_unique_helpers = set()
> +        self.define_unique_helpers = []
>
>      def parse_element(self):
>          proto    = self.parse_symbol()
> @@ -193,19 +195,41 @@ class HeaderParser(object):
>              except NoSyscallCommandFound:
>                  break
>
> -    def parse_helpers(self):
> +    def parse_desc_helpers(self):
>          self.seek_to('* Start of BPF helper function descriptions:',
>                       'Could not find start of eBPF helper descriptions list')
>          while True:
>              try:
>                  helper = self.parse_helper()
>                  self.helpers.append(helper)
> +                proto = helper.proto_break_down()
> +                if proto['name'] not in self.desc_unique_helpers:

The "not in" check is unnecessary for set().

> +                    self.desc_unique_helpers.add(proto['name'])
>              except NoHelperFound:
>                  break
>
> +    def parse_define_helpers(self):
> +        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
> +        # later with the number of unique function names present in description
> +        self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
> +                     'Could not find start of eBPF helper definition list')
> +        # Searches for either one or more FN(\w+) defines or a backslash for newline
> +        p = re.compile('\s*(FN\(\w+\))+|\\\\')
> +        fn_defines_str = ''
> +        while True:
> +            capture = p.match(self.line)
> +            if capture:
> +                fn_defines_str += self.line
> +            else:
> +                break
> +            self.line = self.reader.readline()
> +        # Find the number of occurences of FN(\w+)
> +        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)

How about we only save nr_define_unique_helpers in self?

> +
>      def run(self):
>          self.parse_syscall()
> -        self.parse_helpers()
> +        self.parse_desc_helpers()
> +        self.parse_define_helpers()
>          self.reader.close()
>
>  ###############################################################################
> @@ -509,6 +533,8 @@ class PrinterHelpers(Printer):
>      """
>      def __init__(self, parser):
>          self.elements = parser.helpers
> +        self.desc_unique_helpers = parser.desc_unique_helpers
> +        self.define_unique_helpers = parser.define_unique_helpers
>
>      type_fwds = [
>              'struct bpf_fib_lookup',
> @@ -628,6 +654,22 @@ class PrinterHelpers(Printer):
>  /* Forward declarations of BPF structs */'''
>
>          print(header)
> +
> +        nr_desc_unique_helpers = len(self.desc_unique_helpers)
> +        nr_define_unique_helpers = len(self.define_unique_helpers)
> +        if nr_desc_unique_helpers != nr_define_unique_helpers:
> +            header_warning = '''
> +#warning The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
> +''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
> +            if nr_desc_unique_helpers < nr_define_unique_helpers:
> +                # Function description is parsed until no helper is found (which can be due to
> +                # misformatting). Hence, only print the first missing/misformatted function.
> +                header_warning += '''
> +#warning The description for %s is not present or formatted correctly.
> +''' % (self.define_unique_helpers[nr_desc_unique_helpers])
> +            print(header_warning)
> +
> +
>          for fwd in self.type_fwds:
>              print('%s;' % fwd)
>          print('')
> --
> 2.25.1
>
