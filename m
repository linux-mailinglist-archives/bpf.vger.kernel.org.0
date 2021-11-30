Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F27462C58
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 06:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhK3FyF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 00:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhK3FyE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 00:54:04 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E8C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 21:50:45 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y7so14076858plp.0
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 21:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTpZqctJglp07mk5y+WGVOrGMyH+leu2kdhzhVTi7io=;
        b=q60UgHG5wpk+ziwPpcyrLhN8W/IvFgRdYdq8yJNUwcV8f/zqNrkc9ULfDQgaATx8OV
         nYtLYgdW1yeQDcru8xY+wffXMShdV/GKaEh8C9mkgXaiIQDNIY351NNOrNZiw5bUWUaQ
         qV7KoAxuylKzcXUiSl62Q0w7YPrbdhgFg3+c1U51/Hj/X4KR49HlK/Sa6kAaltuYTJ/w
         Ou0UigBuh1nVipazTmdU/d8mUBo7NpgXKLQ6Bx8bmpWpkSyEOppPX0CBvfNPNsmcjHzn
         yqtx7dnfRG/9PnxvAM5pdYkXkvKmkTS8sx97sWEIpAxW7EQbP1obxj9td7MiHIGPCnfq
         Zm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTpZqctJglp07mk5y+WGVOrGMyH+leu2kdhzhVTi7io=;
        b=f3CarN+d0851HOs1Ji9WuboAQqZhH91tc9QECWJpJa+cEp8Hws3/tBCDsRSDhNhCUz
         mWo7hMoyHl6P31cxu/Y2sRm8ULhizUhMOjr30WXxzyuazAwzoBwuPEHbf3JqHqZzJeKI
         BU8HHpE8cBS9ivjXW5Ythhs3rWAtya/T8zvU8zjrggEnM0DX1+PYu77s95XurlyvkBe4
         ZkEDxTNXIeGXOg7ZaBHeRxNAtJ6sqZ/kyQ08xwrMMXIUX5AyeuXpv69mzOaFGTG16Xj/
         N0YmCyDRUcI+03uA7L+dC0Z92Ooo/vEfCuR6Nmbaa56RSILbYVDGLTozOaNpnquAjUO4
         QnhA==
X-Gm-Message-State: AOAM530EUZIllREpwHPAhUqK+d8bbynxfpvaUiaXceGCEh7ntVNxjwJo
        8xtgSeDyjh/UJLME4+k+8xomXqw89HYcO3akuEo=
X-Google-Smtp-Source: ABdhPJyQxR7aWSBZmKntxYDevvFT9aMq2Z4OPmsB+RbQ5xgptu+Dy5FsiZw6ZnDvjQZTXAzmO0ZWZwXc83IkQXl0gYc=
X-Received: by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id
 c17-20020a170902d49100b00142892d0a89mr63541213plg.20.1638251445409; Mon, 29
 Nov 2021 21:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20211124060209.493-1-alexei.starovoitov@gmail.com> <20211124060209.493-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20211124060209.493-8-alexei.starovoitov@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Nov 2021 21:50:34 -0800
Message-ID: <CAADnVQJFbRSTPtVz6tmjdCYp2vjmMcBZOQ6yzm1ADQh7PpWDfw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/16] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 10:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> +
> +       /* Attempt to find target candidates in vmlinux BTF first */
> +       main_btf = bpf_get_btf_vmlinux();
> +       cands = bpf_core_add_cands(cands, main_btf, 1);
> +       if (IS_ERR(cands))
> +               return cands;
> +
> +       /* populate cache even when cands->cnt == 0 */
> +       populate_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
> +
> +       /* if vmlinux BTF has any candidate, don't go for module BTFs */
> +       if (cands->cnt)
> +               return cands;
> +
> +check_modules:
> +       cc = check_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
> +       if (cc) {
> +               bpf_free_cands(cands);
> +               /* if cache has it return it even if cc->cnt == 0 */
> +               return cc;
> +       }

Found another issue in the above: When cache is populated
with empty cands the above free_cands() will make it uaf.
Fixing in respin.
