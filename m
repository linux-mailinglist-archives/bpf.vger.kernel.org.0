Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214F445770E
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 20:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhKSThr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 14:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhKSThr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 14:37:47 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52145C061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 11:34:45 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id n8so8888778plf.4
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 11:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QMrFKIT3oR8UyazbeORxiR0N3a26btD+YS6HbleR1ZU=;
        b=dJm19ot2JQ+yLDsriADiUQAf7cZQDYa40GJIY5LuEszQ+dfZQ9Y6Zt2p6Un5Hnpcnd
         TrnsIcOi6zLGCtEeiKl05HQUUAq/N/bNUoQLwbIyGejos2EkPhX1MNLpWUVnzgNGgbJB
         yPFijzhZobrzMQRoEGYZ3aM3zTRp844OAGuuGM7tYFV3kh5V1k5nBFrmdUI3iXhAHR2F
         xMdk3MrM/dq9R14v87HtagW2NeC1f6c8tlXYi0glkqsIDEe3/Pj1DRE2WaDPZimeDe5n
         WoO0ZqBX5/uYe+RI1C21//WJCL0uJYOAxSAOcLCESJKKaUFRYvrdhlBglqBa9fG2WGMC
         pcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QMrFKIT3oR8UyazbeORxiR0N3a26btD+YS6HbleR1ZU=;
        b=KIttXR0cPmDLAvnKYoyoXS4ly2CPO3jIDJD4biQtG9PiZyNO5NQhBzE1FTRhihfGJB
         c4VdmSrtWQ/9TkP44ZNdYkLGcFkF3SS7CiGzlaXI93Wi5tbzTISEG3sg9NN2rT3LySgW
         WiM2YHZvqF4+U68xVTbZsjDJ3KtSxClygXjksbPB/KRDXu+L30+iVOak5Qa/xSb1qe9U
         irCCktPLpcpukiAAlx+XeIYbJZ4vTspV2sy93jrmDXLAFmy9WYoibAVAFYU5yhkc3L/V
         vR5hLx3L1YE72CRMHgmF4fzmPMQssgzaViA9AMbnZxhXf7JeN98yUi8gU/SWMu11xk8o
         YoHA==
X-Gm-Message-State: AOAM533SH4yYHtEqyLBUidUYOIUm71Mgsic7CHVrIPDpo4t+jdFWjhAF
        wqp9C6XqLylx9NVyh/jxl74=
X-Google-Smtp-Source: ABdhPJwHkGhu2nBNqh7EF7A1v0FvSJLg4X2MdnziaxmvLSjY/0D0vRrmGWhRMARsXWvkqGxtuwLEtg==
X-Received: by 2002:a17:902:9684:b0:143:cc70:6472 with SMTP id n4-20020a170902968400b00143cc706472mr43443910plp.70.1637350484701;
        Fri, 19 Nov 2021 11:34:44 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:502e:73f4:8af1:9522])
        by smtp.gmail.com with ESMTPSA id d6sm370939pgv.48.2021.11.19.11.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:34:44 -0800 (PST)
Date:   Sat, 20 Nov 2021 01:04:36 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Pavel Skripkin <paskripkin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf v1 3/3] tools/resolve_btfids: Demote unresolved
 symbol message to debug
Message-ID: <20211119193436.3lab7arqh2txe4ga@apollo.localdomain>
References: <20211115191840.496263-1-memxor@gmail.com>
 <20211115191840.496263-4-memxor@gmail.com>
 <CAEf4BzaNrXU1rDwHw14aoQYrwY5nWWyFmzgTrpRxVT2yNWHUCQ@mail.gmail.com>
 <20211119191658.4kp5q7qyweoqb5pr@apollo.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119191658.4kp5q7qyweoqb5pr@apollo.localdomain>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 20, 2021 at 12:46:58AM IST, Kumar Kartikeya Dwivedi wrote:
> On Wed, Nov 17, 2021 at 10:50:43AM IST, Andrii Nakryiko wrote:
> > On Mon, Nov 15, 2021 at 11:18 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > resolve_btfids prints a warning when it finds an unresolved symbol,
> > > (id == 0) in id_patch. This can be the case for BTF sets that are empty
> > > (due to disabled config options), hence printing warnings for certain
> > > builds, most recently seen in [0]. Hence, demote the warning to debug
> > > log level to avoid build time noise.
> > >
> > >   [0]: https://lore.kernel.org/all/1b99ae14-abb4-d18f-cc6a-d7e523b25542@gmail.com
> > >
> > > Fixes: 0e32dfc80bae ("bpf: Enable TCP congestion control kfunc from modules")
> > > Reported-by: Pavel Skripkin <paskripkin@gmail.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  tools/bpf/resolve_btfids/main.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > > index a59cb0ee609c..833bfcc9ccf6 100644
> > > --- a/tools/bpf/resolve_btfids/main.c
> > > +++ b/tools/bpf/resolve_btfids/main.c
> > > @@ -569,7 +569,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
> > >         int i;
> > >
> > >         if (!id->id) {
> > > -               pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
> > > +               pr_debug("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
> >
> > This is an important warning that helps detect some misconfiguration,
> > we cannot just hide it. If it really is happening for empty lists
> > (why?), we should handle empty lists better, but not hide the warning.
> >
>
> +Cc Jiri
>
> Sorry for the delay. The 'why' is because in case of empty BTF set, the id->cnt
> aliasing over id->id (for non-set __BTF_ID_*) is zero, so it trips over when it
> sees it as 0 for empty set in id_patch.
>
> So, what would be your opinion on how to handle this case? Ignore the warning
> case for empty sets specifically? (e.g. using string comparison in id_patch for
> id->name, or split id and cnt out of union and assign non-zero to id in case cnt

Ah, I realized after sending that actually would be far more work (and also
confusing/error prone), since it is copied to ptr[idx] as id->id once in
id_patch and then used as cnt for sorting in sets_patch, which would break
qsort. Just recording that it is a set in btf_id struct might be better.

--
Kartikeya
