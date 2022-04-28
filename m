Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD3513B9E
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 20:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351025AbiD1Sg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350876AbiD1Sg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 14:36:58 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F015BC84A
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:33:43 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r11so2555834ila.1
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPTE2zqiqfl8MjFVO4S/QyFCcKqjkZwNGfa0sQJzAF8=;
        b=FvQ2+Q4RQu01qtY8U7C2bhckoiZMfB1tB/JQ6IDvB6d/jk/5ODfYhIcuT4mbgJNOzP
         GYto9Vdu58Q5XOdd/c6DsqgxqqEGrrg2oBVjVCJSIFJxDmCZYgSyiLC0DxItbrcoKDZR
         CB4z/uSb6UO+hyKFqYllH7jMlmCrdqLHkIz2AdVDji3dcoyiF8hC8QkGixoXmEaRvfle
         Ow4Hg6JrP40XJl/oaAi8ChbJKZtRTRlNPdF9Yndkm8Wfn82PUCZdat4g0Ikmi6N6VY5y
         u5VDVYOcNFIyzAjRZmbYhfEkAMhF5qjD+hHAuHKjrvEIg/OVnywdquAoP45unTBEDtjA
         XXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPTE2zqiqfl8MjFVO4S/QyFCcKqjkZwNGfa0sQJzAF8=;
        b=eQu7wlm4IglaTPm3DEDPRJBIf5mLrMmsSZt1IpiarUyKYptKZUt8NpdRRB8ptqU8wB
         YBoHGjM8irWQSHwNSQ7I/plpSgmSF1BgHhHu1g+Qz1nQP5DkFED2ziWC0hQYHYctaxG/
         YSxBkJVh9XlkjgU3XoREaNGOoChMgHZQFK0sk/FFxiXbzxqFpbLOWPEB4tc9fSC1gUDa
         R4olbD07xECVXfFEusSisFBAhw5nFn6R3V4GBCw0prEI322pMKHAgT7WW7KhcIl7m43q
         c2T4Y9kC5eZvIz+WmlJd/qB7+GFHe27Jz795D8oldmquVbyo03LmI3pvaUDFb7Px0kjl
         SRRw==
X-Gm-Message-State: AOAM530e+QUKw/9bohf4GRSuJZhRmBQ80AgBYd82HMEEHH2CPNt8WS4g
        H9lSoRbZQs7HZ+DxBHCeuXTsyetzLwv/RBl9MngWeWHO1LSS2w==
X-Google-Smtp-Source: ABdhPJxHoIPt8VowSMjsNN/k5+nGk+ad+KGXoW2e8RjXHCs9QHNcYouOjBHFN8hVo48YF+9frw2dkc90VnAtDEVUsVQ=
X-Received: by 2002:a92:c247:0:b0:2cc:1798:74fe with SMTP id
 k7-20020a92c247000000b002cc179874femr13714760ilo.239.1651170822482; Thu, 28
 Apr 2022 11:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651103126.git.delyank@fb.com> <aac0c6adae881f57c247d7bf35e3047f7bf6cfe0.1651103126.git.delyank@fb.com>
In-Reply-To: <aac0c6adae881f57c247d7bf35e3047f7bf6cfe0.1651103126.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Apr 2022 11:33:31 -0700
Message-ID: <CAEf4BzaSXuKj9VyaKtRpQfztq40L9H1OEDYtDC2zBfgPMU7HhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] libbpf: add support for sleepable kprobe and
 uprobe programs
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 28, 2022 at 9:54 AM Delyan Kratunov <delyank@fb.com> wrote:
>
> Add section mappings for uprobe.s and kprobe.s programs. The latter
> cannot currently attach but they're still useful to open and load in
> order to validate that prohibition.
>

This patch made me realize that some changes I did few weeks ago
hasn't landed ([0]). I'm going to rebase and resubmit and I'll ask you
to rebase on top of those changes.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=630550&state=*

> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9a213aaaac8a..9e89a478d40e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8692,9 +8692,12 @@ static const struct bpf_sec_def section_defs[] = {
>         SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
>         SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
>         SEC_DEF("kprobe/",              KPROBE, 0, SEC_NONE, attach_kprobe),
> +       SEC_DEF("kprobe.s/",            KPROBE, 0, SEC_SLEEPABLE, attach_kprobe),

but do we really have sleepable kprobes supported in the kernel? I
don't think yet, let's not advertise as if SEC("kprobe.s") is a thing
until we do

>         SEC_DEF("uprobe+",              KPROBE, 0, SEC_NONE, attach_uprobe),
> +       SEC_DEF("uprobe.s+",            KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
>         SEC_DEF("kretprobe/",           KPROBE, 0, SEC_NONE, attach_kprobe),
>         SEC_DEF("uretprobe+",           KPROBE, 0, SEC_NONE, attach_uprobe),
> +       SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
>         SEC_DEF("kprobe.multi/",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>         SEC_DEF("kretprobe.multi/",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>         SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt),
> @@ -10432,13 +10435,18 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>         const char *func_name;
>         char *func;
>         int n;
> +       bool sleepable = false;
>
>         opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
> +       sleepable = str_has_pfx(prog->sec_name, "kprobe.s/");
>         if (opts.retprobe)
>                 func_name = prog->sec_name + sizeof("kretprobe/") - 1;
> +       else if (sleepable)
> +               func_name = prog->sec_name + sizeof("kprobe.s/") - 1;
>         else
>                 func_name = prog->sec_name + sizeof("kprobe/") - 1;
>
> +
>         n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
>         if (n < 1) {
>                 pr_warn("kprobe name is invalid: %s\n", func_name);
> @@ -10957,7 +10965,7 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
>                 break;
>         case 3:
>         case 4:
> -               opts.retprobe = strcmp(probe_type, "uretprobe") == 0;
> +               opts.retprobe = str_has_pfx(probe_type, "uretprobe");

it's a total nit but I'd feel a bit more comfortable with explicit
check for "uretprobe" and "uretprobe.s" instead of a prefix match, if
you don't mind.

>                 if (opts.retprobe && offset != 0) {
>                         pr_warn("prog '%s': uretprobes do not support offset specification\n",
>                                 prog->name);
> --
> 2.35.1
