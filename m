Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB26413B77
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 22:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhIUUgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 16:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbhIUUgR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 16:36:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A0FC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 13:34:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l6so219565plh.9
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwO7RCXkYHdiPhnhMWqz812c4ThLWtZGE0StWTPOWuY=;
        b=DeiRn9+XZ2juOod7vypYPkpQoXu/LDZx8n9A5SNHZh4nGlriRWZ3HIeuvKmc6B2LFT
         maBWPI5a3OiYb0JiVFBwCb/eJFpfTTsa/z0NXeXCQ5l8jK1y4D8OejS6b6TYnbsymqQa
         TiXZLq1FUMsQ0vqgAFeJjZQXHtTFSQ43a95VRtS/7345GTqPYpv/zd67r9f8gmtcnpbh
         m7vbD+ekHILzKJuxPBcdXddH6syXzWr2ooK9f4I9fSh+kKeHpYE5uaKJYb9XQawzOMBZ
         NLFX4S7cSatYCl46qUNlE3dwl3NAaHddsQs19jJmSKyEVnX2yhjNssAWn38SqnZUtJBU
         FhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwO7RCXkYHdiPhnhMWqz812c4ThLWtZGE0StWTPOWuY=;
        b=GqfZhtgj34PaEzza/AA8BWM8RxYYlxLLXQTMWsifXAAP+URqM0wn++0JS18Rukv6Si
         yWQUzCp/v7LWbHUQtkxJpwaXhM5aQm66wCRHXtfPJTZ5f+RSkRuwXHbrM6cWJEI1kDWr
         QUERfrZ0J4ulpA3wZsev6ms2jf8E+R02PkOUdj0p2GGgS+jDh/6Td0l+Ip4dXMNHKYNW
         HumssSZMeMbPY6l+JHzMKepkk3ngQr1lKgJh+k8mAyctVcR172ZWteDd6G+ftjv/KsS0
         Kr085NApBoVsCovguM3sCc7LUzu31+IrOHDUlyQ825MtmobiVKZ7/3aDGz4E7z3u3/gX
         Rpcw==
X-Gm-Message-State: AOAM530XEWmlIanUaIn/7K0Ceo7v0jlTG5LUcpCfkayCddBVjXPg3MTm
        26VzPxg0NMZKQyxNIQ3cBMk4NKyPNEzk7kxdWEEwwEXx
X-Google-Smtp-Source: ABdhPJxiKiDsfqsxTij9HLE10bsdgqMn9YJ1rjbCXQNL0U8M+8xdBcy3KFXxaeIRITipZVK9quB4xQ1aEZHQd4u8zqk=
X-Received: by 2002:a17:902:c407:b0:13d:93aa:8098 with SMTP id
 k7-20020a170902c40700b0013d93aa8098mr20890511plk.3.1632256487723; Tue, 21 Sep
 2021 13:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210920231617.3141867-1-andrii@kernel.org> <20210920231617.3141867-3-andrii@kernel.org>
In-Reply-To: <20210920231617.3141867-3-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Sep 2021 13:34:36 -0700
Message-ID: <CAADnVQ+m+DCPBvHd0X_e=YGn+COKT79nCgSGzxCWAtN34xZevw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: adopt attach_probe selftest
 to work on old kernels
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 20, 2021 at 4:18 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Make sure to not use ref_ctr_off feature when running on old kernels
> that don't support this feature. This allows to test libbpf's legacy
> kprobe and uprobe logic on old kernels.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c      | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index bf307bb9e446..cbd6b6175d5c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -14,6 +14,12 @@ void test_attach_probe(void)
>         struct test_attach_probe* skel;
>         size_t uprobe_offset;
>         ssize_t base_addr, ref_ctr_offset;
> +       bool legacy;
> +
> +       /* check is new-style kprobe/uprobe API is supported */
> +       legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
> +
> +       legacy = true;

What is the idea of the above?
One of them is a leftover?
