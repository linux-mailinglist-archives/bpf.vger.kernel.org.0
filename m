Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A93D49660D
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiAUTyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiAUTyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 14:54:12 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61337C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:54:12 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i1so2519281ils.5
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LT+Zl/8TL4XkJXFl4FtpyL14TM73vbm8en1pZ/RmQkA=;
        b=IIa5ymwlvHG/RRAQtAHSFgimxXKe47B6FM3KUiLsAqYjiuECkc58aH+uSEJKTQlE/v
         YLwzEEfy3kRy6TT/gs+Up3bn6pvYw7OYxL9YIZUgczFqYvWlc9yFxn/CtnpPyE4GW8bt
         qr29s1EiRx/5QZQHSdRY5MuC/Prq19INiAQpn5qhPPxAU5EqnPj4eyxvpzXeoZum7a7h
         9i1Nc1OPHj9CKQqPKVWxcMgHOlB7Uq9Sflvm6u6aPjWzkSVapw4C0W1t2Du1zj7XpYeG
         ukpvNUlL2Lq+K3JFrlW6r+9++s4BTBdbX8lq5fJzVVtK2IkznWBburjMwmX1vO1ZJ5pY
         nKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LT+Zl/8TL4XkJXFl4FtpyL14TM73vbm8en1pZ/RmQkA=;
        b=0HElR//w3C5gCP8rNnqPblgUJ97fBhxVK8UzggFwVi+fcUgZbtG7LyTk9kaKACMHrk
         EDXhdhvdrzQzfxtYCkygVWddhkFVyPaKTRBw62J45pjrv7fuu8Fho2sXsr2qyFJXBZLv
         OtqIgsTn63Mgx18GzmlnGtsGFP9ZuZutXZXm3ycIxNxE+3AdmKUtvR950eDwFjLU97qy
         EwE1qR5F8LBqKeKqfu9K2BgPoA9W64+UtdB9uMuzmulCCIE2z/quGDuG4+WVeHRPMRUs
         979JyYZpM4OZNih4UxHBx0Vc9V5ZxVAWZ2xqvhbOog+KsxbvRIehkHfXoNp+sFOjq+R7
         R/qg==
X-Gm-Message-State: AOAM531vjXpDoAAIOIxQljNNbjI0LoI7x3rAT5ynJTr/PtOWibBlHtFc
        fTsfJlQOhFRDno15xsMNvvJBNU3rmZ2Awa5DkCw=
X-Google-Smtp-Source: ABdhPJyGKVb1lBIqdLCbqtmR3TQoMkRi3R6qa4EBnJhDhSMAkDHk5GZ33GId+eR7oZ9lm5aD7PfVpd92YVcu78GezjQ=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr2345759ilu.71.1642794851814;
 Fri, 21 Jan 2022 11:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220121193047.3225019-1-kennyyu@fb.com>
 <20220121193047.3225019-3-kennyyu@fb.com>
In-Reply-To: <20220121193047.3225019-3-kennyyu@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Jan 2022 11:54:00 -0800
Message-ID: <CAEf4BzYOsLw7dnC+7YfNORq79JMiHdKxXz5Kqu4wWyC_1QRg8g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/3] libbpf: Add "iter.s" section for
 sleepable bpf iterator programs
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Gabriele <phoenix1987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 11:31 AM Kenny Yu <kennyyu@fb.com> wrote:
>
> This adds a new bpf section "iter.s" to allow bpf iterator programs to
> be sleepable.
>
> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fc6d530e20db..ea7149606e67 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8607,6 +8607,7 @@ static const struct bpf_sec_def section_defs[] = {
>         SEC_DEF("lsm/",                 LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
>         SEC_DEF("lsm.s/",               LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
>         SEC_DEF("iter/",                TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
> +       SEC_DEF("iter.s/",              TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
>         SEC_DEF("syscall",              SYSCALL, 0, SEC_SLEEPABLE),
>         SEC_DEF("xdp_devmap/",          XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
>         SEC_DEF("xdp_cpumap/",          XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
> --
> 2.30.2
>
