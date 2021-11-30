Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A8A462BE8
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 06:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhK3FIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 00:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhK3FIT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 00:08:19 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC34C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 21:05:00 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s37so8783215pga.9
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pfnVjrsQMUj+gWRc5poJ5O5pLsISPX7dpAUUWAdLAOc=;
        b=G0qGwXtrFsYUucg4XImt+0JtYh+wOA7PT6VE42vA4kSqcjT1bCD/e6HGs9eF3b7gFA
         HG1gHeJoVTC/04491fm0atWNOtDfSRcOwM19FbujqmsG5NJm/6OVlbSFf633iriK2ZYd
         6LVtLpF3zN7u04ZeSDkucVO4TVnDXimPUUDyTcQRcZq0QczvePrQoD34xtIwIiQnEQkt
         WzcQLboCrPJQscuHAdffYnr5kA+WIzYTDBW7lxTIUq20XLRHDg1HY49dV08MvnzYP4y7
         WGPq2avYcuiCQoU9uWGq09V3GteVbAJhEvKj4iOZW2uSqlc+X7qQh1daCPgMcj0ZZVNl
         FkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfnVjrsQMUj+gWRc5poJ5O5pLsISPX7dpAUUWAdLAOc=;
        b=eAA7Po1f8SrliavJ2o60JAzQRgiP4vPkYMrMwEghkyPNpLYnBTLMmv7AM18LuiLor5
         nVtncoCaXXZ0CE1WdDU+T1ZhFjIkclZOnwKR206eXVA6lULeo+o+BDQja4wCB4j2bkDI
         ipCBoeDgw7LjrgYPdSsyMc8qLPJ53Y7FZNkoZXungK8eBqnpnLJQR8nJYZLV+dOTMeVF
         HSl//oq0aQaUCewcGhxrQwdPE0875a+XBm0oQqB9HtK5ENvOxXlFGC2c3+qSErmQVbMT
         hMebVmPMGt9tXAHQbDQyOt2TbaxciiLbpLartAI452BeSj05eggqfhyuOPB9ftlL2nb/
         N/XA==
X-Gm-Message-State: AOAM532mTCaYaZVXDXCIeNsc0mTfKsokpYcku4RBHuaOuZ5pFjlJ8nio
        7ECi05gVssHGFFQme/yiUHo=
X-Google-Smtp-Source: ABdhPJyfV5kTXeDTTIBxpucBfirP8Spnn7DNULtCVj4mtKeTREyLk8cdTgaRwRH0f9qC9ymelDHm5w==
X-Received: by 2002:a63:82c3:: with SMTP id w186mr38351814pgd.301.1638248699835;
        Mon, 29 Nov 2021 21:04:59 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:1efa])
        by smtp.gmail.com with ESMTPSA id d12sm18749480pfh.165.2021.11.29.21.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 21:04:59 -0800 (PST)
Date:   Mon, 29 Nov 2021 21:04:57 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next 07/16] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
Message-ID: <20211130050457.o7da5r6hj6zqfbll@ast-mbp.dhcp.thefacebook.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
 <20211124060209.493-8-alexei.starovoitov@gmail.com>
 <CAEf4BzYNkgP-t_icXjLAxddOPWgN7GZZ7vWrsLbCDycN=z9KzA@mail.gmail.com>
 <20211130031819.7ulr5cfqrqagioza@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb3E5qyf3WtOAWHWSiq9ptPLXErGg5pCFQTAdz0LhZCBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb3E5qyf3WtOAWHWSiq9ptPLXErGg5pCFQTAdz0LhZCBw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 08:09:55PM -0800, Andrii Nakryiko wrote:
> 
> oh, I thought you added those fields initially and forgot to delete or
> something, didn't notice that you are just "opting them out" for
> __KERNEL__. I think libbpf code doesn't strictly need this, here's the
> diff that completely removes their use, it's pretty straightforward
> and minimal, so maybe instead of #ifdef'ing let's just do that?

Cool.
Folded it into my series as another patch with your SOB.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b59fede08ba7..95fa57eea289 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5179,15 +5179,18 @@ static int bpf_core_add_cands(struct
> bpf_core_cand *local_cand,
>                    struct bpf_core_cand_list *cands)
>  {
>      struct bpf_core_cand *new_cands, *cand;
> -    const struct btf_type *t;
> -    const char *targ_name;
> +    const struct btf_type *t, *local_t;
> +    const char *targ_name, *local_name;

I wish you've inserted the patch without mangling.
Thankfully it was short enough to repeat manually.
No big deal.
