Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEFB493F4F
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 18:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbiASRr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 12:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiASRr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 12:47:56 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E8C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 09:47:56 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 188so3296709pgf.1
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnLO/0D3w/yH0Y8W3q/93fnUY/zsIz+y633NxyB277k=;
        b=eHwwSsf72N7rkZXbOscvVc5s46D+3dDZcQL4fH2Kfqe0gBgvnMRnGzlBoum3D1EFQm
         w+8ENWfKcAqxCxqk6F0hXHgNIHTkvzbQMfJTM5GgE7BYbFz45rtUw/ykKuwYf0hgfRnn
         z9Q054G9s4jghp+4Gie0UH2hISPYFeWzykZOXWh6QeHQCU2o5mUNbSa6woiGHB8B83de
         UuSMSW4YLmMG5t1tqVoZOVNfvrTEsQT4BYn4lADhtcjuEpn80JgW0rQaT+y3x5HFd1ff
         FdCAqtsJmxkjOZYr6mePW44U6NtrF7B5ivD08T+co0GmcFDoIQr31IwdZaOe3POEZtNA
         t+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnLO/0D3w/yH0Y8W3q/93fnUY/zsIz+y633NxyB277k=;
        b=M9xCKJYWadAA7KsD0792oqD+c3+0m6Ytbl0af9xygxxso7pIVbYHpEhVSsII03ZKx+
         wxapLZKWPkwlzmOyqzn0j9aRZawCki3gEWQG97NQ9nuUQdVF9wuGkX+IB9QCjGPSWXkh
         7BACuWS1OC10qj8csXF3320t4nuu+XmGuyKZPO++I+tBKjhSiqD5MLhEKVJD+fQWG+cU
         xuhdmDgFm6hKpUbg9W+y9ShkogdBb+8AEcI22xcizkEfER9NM6p+h2odbgm2tGK63h1N
         VMQzmPNCjo7qDcy9XhcA2zCVw9JF1pxBUsM2j318e6p42TePdEd92Lg/r9oRtZnQ8V/W
         hbXA==
X-Gm-Message-State: AOAM533UK4vroLSilqzdoTUapizlAoPZmrJNibfi5MHY4NO7k0GXTT4P
        3VNuNQ+ilN8p0q3oR+vYuVrM2poNB1fHMR70al8=
X-Google-Smtp-Source: ABdhPJxmshNGR2+Qsm/iUcc6S6O8H5gcRKfmroEHEgjoZuM3y6A9nPannahw4AWMlZkhMDFwjUKFiL2Uj0Kat8wgjGg=
X-Received: by 2002:a63:1ca:: with SMTP id 193mr27567643pgb.497.1642614476148;
 Wed, 19 Jan 2022 09:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20220112201449.1620763-1-yhs@fb.com> <20220112201500.1623985-1-yhs@fb.com>
In-Reply-To: <20220112201500.1623985-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Jan 2022 09:47:45 -0800
Message-ID: <CAADnVQKY-uvYic=4iXmHMdyiYOSzT1Nx=Zv_70pL+8ypNWQjYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: reject program if a __user tagged
 memory accessed in kernel way
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 12, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> +
> +                       /* check __user tag */
> +                       t = btf_type_by_id(btf, mtype->type);
> +                       if (btf_type_is_type_tag(t)) {
> +                               tag_value = __btf_name_by_offset(btf, t->name_off);
> +                               if (strcmp(tag_value, "user") == 0)
> +                                       tmp_flag = MEM_USER;
> +                       }
> +
>                         stype = btf_type_skip_modifiers(btf, mtype->type, &id);

Does LLVM guarantee that btf_tag will be the first in the modifiers?
Looking at the selftest:
+struct bpf_testmod_btf_type_tag_2 {
+       struct bpf_testmod_btf_type_tag_1 __user *p;
+};

What if there are 'const' or 'volatile' modifiers on that pointer too?
And in different order with btf_tag?
BTF gets normalized or not?
I wonder whether we should introduce something like
btf_type_collect_modifiers() instead of btf_type_skip_modifiers() ?
