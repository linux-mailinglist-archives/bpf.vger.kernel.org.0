Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072D1480F29
	for <lists+bpf@lfdr.de>; Wed, 29 Dec 2021 04:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhL2DIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Dec 2021 22:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhL2DIL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Dec 2021 22:08:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE13C061574
        for <bpf@vger.kernel.org>; Tue, 28 Dec 2021 19:08:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c3so1668241pls.5
        for <bpf@vger.kernel.org>; Tue, 28 Dec 2021 19:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMzszFcQP7Ai+qPEz45iZmfyKJleIeEPPXrWJRzHEHU=;
        b=fhmNaSw//Psz+yuYbaw9lxJhW+qWu+1CbV81TblJiu6CXuTkTQnthrzy87jvditjhm
         0kVl65QVsj9csN19/PdQRN8VuruLeXvL4qZS4GhxR5fCzaGTTFSzTIW7ETbbxKvz8/49
         N4V1ELdTUBZtaSOrqYXpSk0N8IYXlmvvTUBNxtxsI9Xh4iEECLMvYgbX53W6esfqjYCZ
         5eo4yQZv7rQWOpZRszLfEyK+NJsIGFQO8dP6nTMjwbSzVz0HTOwbsY74Ldn+rqjW059z
         LZgcCC7qNX+dThXYkqot/2f+IRix2kk8hiMjSmHMuoZsn9WMZokxzxZ+qVUhrdtruSYi
         ESdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMzszFcQP7Ai+qPEz45iZmfyKJleIeEPPXrWJRzHEHU=;
        b=IT7JYyCZZzdcMrF0VxyTR/5IpNWPBTOXtf0JW6TyCSoa1VNmy5rb2kpDmbgEuNK8ER
         sz0rOJm9TcjuqGGhkHGo68RgwIgxiitWoA3+Pa3VafxLOqKBQzyBuJfDEVn3He/ccqAg
         p4ydykozJ48newSsdiFg1EzxdFObvdGrF3vCVVlZmmn6Z+Qk1HjDl63WyouRDVGa5luC
         LppLuwea9HOPtWKK0A6z5GHj051Ixqjv4trnU75iKdUp0rn0ERHfkZfuBjjPMkBUqL01
         rQFJ92IjZJ+OoY4X1FF+vCtT3q8j5Yt3wIoLLsresL/a5GwlLUmKIfEOJStxWQ39eXXe
         4p/A==
X-Gm-Message-State: AOAM531KNXXFl+GzeapngE0Rw35tBTAOYe4bRS2qztgPbtfU3qIXYSjq
        eQvzD0wrYicbYtt7UuJwXInhy7XC/0L5M9ne0Ys=
X-Google-Smtp-Source: ABdhPJyjivVbgA4sfA00xilNYi+9Q58HS2eXnsjeE9Bl4AvxTQi+N3Rumr/e5KFG4GmW2peJ6hi/WQcDqgd2ihXc/Q0=
X-Received: by 2002:a17:902:860c:b0:149:1017:25f0 with SMTP id
 f12-20020a170902860c00b00149101725f0mr24359533plo.116.1640747290990; Tue, 28
 Dec 2021 19:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20211221174807.1079680-1-usama.arif@bytedance.com>
In-Reply-To: <20211221174807.1079680-1-usama.arif@bytedance.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 28 Dec 2021 19:07:59 -0800
Message-ID: <CAADnVQL5Y4WWnZoz406KNOepBXr16drdSRYGoWZq+r2bhQ1QDw@mail.gmail.com>
Subject: Re: [PATCH] bpf/scripts: add warning if the correct number of helpers
 are not auto-generated
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joe Stringer <joe@cilium.io>, fam.zheng@bytedance.com,
        Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 21, 2021 at 9:48 AM Usama Arif <usama.arif@bytedance.com> wrote:
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
> currently documented upstream functions, but can help in debugging
> when developing new helpers when there might be missing or misformatted
> documentation.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  scripts/bpf_doc.py | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index a6403ddf5de7..736bd853155b 100755
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
> +        self.define_unique_helpers = len(re.findall('FN\(\w+\)', fn_defines_str))
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

It fails in CI:
Traceback (most recent call last):
File "/home/runner/work/bpf/bpf/scripts/bpf_doc.py", line 778, in <module>
printer.print_all()
File "/home/runner/work/bpf/bpf/scripts/bpf_doc.py", line 257, in print_all
self.print_header()
File "/home/runner/work/bpf/bpf/scripts/bpf_doc.py", line 659, in print_header
nr_define_unique_helpers = len(self.define_unique_helpers)
TypeError: object of type 'int' has no len()
