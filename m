Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09EC59EDCC
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 22:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiHWUwG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiHWUvs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 16:51:48 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C852468
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 13:49:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cr9so11313264qtb.13
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n7iAgpk3JimOtuXrPhwZo8+NSq6FJ0IGL4M4aRkN+Qo=;
        b=1P2LC7yCNjUuP4kbWl5J1CM/ehXIHJPIZNRWVDxcHS8dqt3VtGt7sPTt1BWNKJfOck
         XzE7hv1fHNkF/OBk+GuZWMghLUuJBHpGljDBtwnZ9YsG3V0WzFx1+eWysh4hrGtkpW3h
         OxRcIhopLax+RDQNj41qswj7sR0nFiyUaREtAeBEddKgAjJXkTVwHAHNOUcxLBaAq1q2
         a/UepP36U22fcDYOOFN2QR0Ghyp+p+xyx4snz/XDPT/y/uy2hVhruAfV5FnH1s3TQEva
         V/yap8O2V+8n1KXCXDHYYfH3WiX2pTP4GDSM2l0h8f34aPVQRQvZ0yU8hOUcQpv7KukY
         ytBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n7iAgpk3JimOtuXrPhwZo8+NSq6FJ0IGL4M4aRkN+Qo=;
        b=VDvc/G8JpihflQ91HnRPNB+cO5vzr6knp+d/aHCwWxr4xn2PSTOF59l9GyC9W5Vf9K
         fyljSy6tJ5KuOGkVSB30kMI17MmwsO5opiUY7u1T4aHHy3OaWvBqvsVrNrMHs/OHV23p
         f8RXMCwQtzfBEQ0R/LdXcM+dHh3Tk+QL5A29TJwxDxFalY6oIfBFMhBK83mLZck6ifa8
         23BhUbW76uEKatOInmVDy2YWbK8yBYVf85ZeZDaY6aRRUbt/rSK6CjeW5aEeKJvBP+F6
         3IOJPe0am02YtKSwQefJmAeTSMxBZaISnO9n801A+QrjxMA1hAVFpRv0mLsnyJWCf8if
         wXMw==
X-Gm-Message-State: ACgBeo2F1+mp+I5PjE/sfoUG1xhEmlU5SHlachZlxGU0LxshiA76SXMZ
        iV/uT/pSvdF82seoLIPdJFSXAtsg4rW+ou/hP/pO+Q==
X-Google-Smtp-Source: AA6agR7nsdRRQYspAW//jX4ntUqBPEIpOLKFJR1475J3sHkG41V9o95L+e/0K6/v59Ov27mWfVPdE3FVUZdPYGCWQTs=
X-Received: by 2002:a05:622a:20c:b0:343:f3:b191 with SMTP id
 b12-20020a05622a020c00b0034300f3b191mr21927412qtx.389.1661287781586; Tue, 23
 Aug 2022 13:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220819091244.1001962-1-eyal.birger@gmail.com>
In-Reply-To: <20220819091244.1001962-1-eyal.birger@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 23 Aug 2022 21:49:30 +0100
Message-ID: <CACdoK4KY6W=CrBXGTBx=su7UZ6ryna2CsjNw=zeNWc_pXzkrrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/scripts: use helper enum value instead of
 relying on comment order
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Aug 2022 at 10:13, Eyal Birger <eyal.birger@gmail.com> wrote:
>
> The helper value is ABI as defined by enum bpf_func_id.
> As bpf_helper_defs.h is used for the userpace part, it must be consistent
> with this enum.
>
> Before this change, the enumerated value was derived from the comment
> order, which assumes comments are always appended, however, there doesn't
> seem to be an enforcement anywhere for maintaining a strict order.
>
> When adding new helpers it is very puzzling when the userspace application
> breaks in weird places if the comment is inserted instead of appended -
> because the generated helper ABI is incorrect and shifted.
>
> This commit attempts to ease this by always using bpf_func_id order as
> the helper value.
>
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> ---
>  scripts/bpf_doc.py | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index dfb260de17a8..7797aa032eca 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -88,7 +88,7 @@ class HeaderParser(object):
>          self.helpers = []
>          self.commands = []
>          self.desc_unique_helpers = set()
> -        self.define_unique_helpers = []
> +        self.define_unique_helpers = {}
>          self.desc_syscalls = []
>          self.enum_syscalls = []
>
> @@ -245,24 +245,24 @@ class HeaderParser(object):
>                  break
>
>      def parse_define_helpers(self):
> -        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
> -        # later with the number of unique function names present in description.
> +        # Parse FN(...) in #define __BPF_FUNC_MAPPER to compare later with the
> +        # number of unique function names present in description and use the
> +        # correct enumeration value.
>          # Note: seek_to(..) discards the first line below the target search text,
>          # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
>          self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
>                       'Could not find start of eBPF helper definition list')
>          # Searches for either one or more FN(\w+) defines or a backslash for newline
> -        p = re.compile('\s*(FN\(\w+\))+|\\\\')
> -        fn_defines_str = ''
> +        p = re.compile('\s*FN\((\w+)\)+|\\\\')

Nit: I think the second '+' should be removed, I don't think you can
have consecutive "FN(...)" without at least a comma. But you didn't
add and it is harmless, so it can be a follow-up or wait until a
future clean-up.

> +        i = 1  # 'unspec' is skipped as mentioned above
>          while True:
>              capture = p.match(self.line)
>              if capture:
> -                fn_defines_str += self.line
> +                self.define_unique_helpers[capture.expand(r'bpf_\1')] = i
> +                i += 1
>              else:
>                  break
>              self.line = self.reader.readline()
> -        # Find the number of occurences of FN(\w+)
> -        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
>
>      def run(self):
>          self.parse_desc_syscall()
> @@ -573,6 +573,7 @@ class PrinterHelpers(Printer):
>      def __init__(self, parser):
>          self.elements = parser.helpers
>          self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
> +        self.define_unique_helpers = parser.define_unique_helpers
>
>      type_fwds = [
>              'struct bpf_fib_lookup',
> @@ -761,7 +762,7 @@ class PrinterHelpers(Printer):
>              comma = ', '
>              print(one_arg, end='')
>
> -        print(') = (void *) %d;' % len(self.seen_helpers))
> +        print(') = (void *) %d;' % self.define_unique_helpers[proto['name']])
>          print('')

The code seems correct and should make the script more robust, and I
checked that the man page and header file are generated identically.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

However, I would recommend against inserting the description of new
helpers in the middle of the current documentation. Having the helpers
listed in order of creation is maybe not ideal, but at least they are
ordered, and the list remains consistent with the items of enum
bpf_func_id. I'm not opposed to reworking the list to have them
displayed in a more logical order, but in that case I think we should
reorganise the whole list, not just start inserting new descriptions
in the middle.

Thanks,
Quentin
