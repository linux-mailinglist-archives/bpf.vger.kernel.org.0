Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10FD4576F1
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 20:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhKSTUF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 14:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhKSTUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 14:20:04 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8DC061574
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 11:17:02 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id z6so7661121plk.6
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xSZynYUynWkM5YFANOl7zryvqkfsxeB9Av/AgogZmV8=;
        b=TKXeXfoUo753nVgo/KlKO1GRc60cYex+2E5i4kC82b346S3d+GZ+n1FUUq1Uf0IHLU
         6aFdaijtSB359FLV7OTRx0xI8p4tIDXySWTHVozMXZzfjgOckXGVofO/IZehtIn4ayuO
         6zWtCaog4T8WtXFKWz5XQPDmMvGJvetzXo2IQCaO7FWt3KQXplqznMXVkZh+cbTTD16d
         zOOpyNF//RdyuyJ1Wgn7dynGJ2h/G9l9RPk0h2Ape4aSMV7iRjCxKX1lwGXoElC82c9Z
         X4hzvRjZu1fffz3t7Cv+lDQzW9cOCbjsHqfAkyf5FbTQmNDM3N+3+NxjlS344kKenzku
         dt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xSZynYUynWkM5YFANOl7zryvqkfsxeB9Av/AgogZmV8=;
        b=ZUhUike1awNZMmY+QOPmZZMAUi4HkF0zHNmwsxE5GmMQe8QQm9Svyjw8mB8HYJpt+q
         T08MaWClNLaVk6iKMt3+rueMa6vlAzLPowmp5gNVZ7yZwb8oiGlDExvhC4Aobf8wUAuO
         xIiAwj63awSMaMX+e30xPokpV3/Slekjej20BimNdNbet3ARIFxlcv+XPXaNYx23UKrO
         157X7UPna2vqpDrVjBfiSl2hHUoRk6QtiHy3Y9taufhQ4Kp2O95sJaSGKMP/hOSwthyC
         c6Nov1QcQZPqAJ5eBIkJVQTTfeO2fzQo/BPgybKDQ/gozQzP1zaPx+XowU96YQacDWGA
         HdNQ==
X-Gm-Message-State: AOAM533ItLlngF9I9u5KURuOwmthETDnZX7osjfpGqakvDFQicm3T7rh
        Y7615KiipmCT8N+3u6sf6pmUCpva2NA=
X-Google-Smtp-Source: ABdhPJzOoatHiEqht5Hye2xmHgk6J2ckjgQtl75i68qFcef0GkTbxTqJjsikMEDW9mOhE8wONP12EQ==
X-Received: by 2002:a17:90a:d3d2:: with SMTP id d18mr2448405pjw.158.1637349422120;
        Fri, 19 Nov 2021 11:17:02 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:502e:73f4:8af1:9522])
        by smtp.gmail.com with ESMTPSA id q13sm432081pfk.22.2021.11.19.11.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:17:01 -0800 (PST)
Date:   Sat, 20 Nov 2021 00:46:58 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Pavel Skripkin <paskripkin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf v1 3/3] tools/resolve_btfids: Demote unresolved
 symbol message to debug
Message-ID: <20211119191658.4kp5q7qyweoqb5pr@apollo.localdomain>
References: <20211115191840.496263-1-memxor@gmail.com>
 <20211115191840.496263-4-memxor@gmail.com>
 <CAEf4BzaNrXU1rDwHw14aoQYrwY5nWWyFmzgTrpRxVT2yNWHUCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaNrXU1rDwHw14aoQYrwY5nWWyFmzgTrpRxVT2yNWHUCQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 10:50:43AM IST, Andrii Nakryiko wrote:
> On Mon, Nov 15, 2021 at 11:18 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > resolve_btfids prints a warning when it finds an unresolved symbol,
> > (id == 0) in id_patch. This can be the case for BTF sets that are empty
> > (due to disabled config options), hence printing warnings for certain
> > builds, most recently seen in [0]. Hence, demote the warning to debug
> > log level to avoid build time noise.
> >
> >   [0]: https://lore.kernel.org/all/1b99ae14-abb4-d18f-cc6a-d7e523b25542@gmail.com
> >
> > Fixes: 0e32dfc80bae ("bpf: Enable TCP congestion control kfunc from modules")
> > Reported-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > index a59cb0ee609c..833bfcc9ccf6 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -569,7 +569,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
> >         int i;
> >
> >         if (!id->id) {
> > -               pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
> > +               pr_debug("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
>
> This is an important warning that helps detect some misconfiguration,
> we cannot just hide it. If it really is happening for empty lists
> (why?), we should handle empty lists better, but not hide the warning.
>

+Cc Jiri

Sorry for the delay. The 'why' is because in case of empty BTF set, the id->cnt
aliasing over id->id (for non-set __BTF_ID_*) is zero, so it trips over when it
sees it as 0 for empty set in id_patch.

So, what would be your opinion on how to handle this case? Ignore the warning
case for empty sets specifically? (e.g. using string comparison in id_patch for
id->name, or split id and cnt out of union and assign non-zero to id in case cnt
== 0, otherwise copy (saving strncmp for all symbols in id_patch))

Also, if I'm respinning, any comments on the first two which are also fixes for
bugs I introduced, so that we can avoid another round?

--
Kartikeya
