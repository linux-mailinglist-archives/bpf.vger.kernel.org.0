Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558E72064A8
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 23:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393536AbgFWVZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 17:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390329AbgFWVZT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 17:25:19 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C82C061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 14:25:19 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so8214786qkb.8
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lH+ih/vqFpzEdsQlJyuItTRWtUoLO51P5/RAt97fSjg=;
        b=owCwA7l+uTWbmFwqRrzTtv1NrpMNALafzClMrPE/lHv5WdPVyxp/N+avMqRqB3pyam
         BnytARO4coG7vmCecW8fSqq2LJ5vgvz+AyEGH2V3clmZgIQNbZZHk0RMEU5MGm47lFIt
         EgBmLA6NLADkISWikODZyZKKssGNy2hNE3cWjI0Un5PW2gbtSUbMLPhBNS7jz8cOCECy
         A0VSUMq9AwjtE83RUwRRBhad0Yzi5TfCI0zGLRICepI+cFEwwPjgJwkr8cWpiKYcgtq5
         z0xxLYe24WfESiqQb7Ym9pP3hZEobIPoI+4mGwC7hM73cffkvNbby12hJSNADNJTKtH5
         yodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lH+ih/vqFpzEdsQlJyuItTRWtUoLO51P5/RAt97fSjg=;
        b=hC8qwA+R6N3CMFFfpS2/zqMaAeXLswD6Hgr6WlEGvnXkdXoM86r0CnJnpEDJMVz/eJ
         8Z2EZygtPHz0EKO0KZxItLAqFv4GQM6pnXHYracVNUVn3FDsUn+yjy0Kw+GyeDlqMxgW
         oGolxX8Bi7L9J/FrneGN+EaANnGyr/0wxTdhwtx0TH8INA+4bj6wonsPFmw3zrPj+5I7
         dr/X7SZPVwK9HvGbgWcwrKqk+pNBSU/XllunaQJiSS6GceU/lt7Uf7hRSxydON540IV0
         U1W06v0Yqg3+SXRZKE/GydvgYz13xYybdbjmhPg8ikL7xeXu6Q4zQ6xadB3/3iK6ery/
         A7TQ==
X-Gm-Message-State: AOAM533/d4Y5tiwNj1kTGokiu1/k8l/q7Xgkz2aYOYpzajjHAffbHb5W
        5gcBjyeBhi6GCMaMLENixwCv42Ep0H4HWxZaFjIUSw==
X-Google-Smtp-Source: ABdhPJzUhrjoo6e99z5AIDHw42VevQgGkK47alrb0vZxUqaI3G+5aWz3ZMeemCdVB7dOu8MWzWoBDqanPFNdc5VWf0s=
X-Received: by 2002:a05:620a:23a:: with SMTP id u26mr21569480qkm.443.1592947518301;
 Tue, 23 Jun 2020 14:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200623155157.13082-1-quentin@isovalent.com> <CAEf4BzYeP784xwgnSsoCn=vy37-bLa4=jZUDW35t3MNMUGVdmA@mail.gmail.com>
In-Reply-To: <CAEf4BzYeP784xwgnSsoCn=vy37-bLa4=jZUDW35t3MNMUGVdmA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 23 Jun 2020 22:25:07 +0100
Message-ID: <CACdoK4JtoehffN73A-q77JCOPc6O4hK9zMG1XSai2TdM7NCtYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools: bpftool: do not pass json_wtr to emit_obj_refs_json()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Jun 2020 at 19:27, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Tue, Jun 23, 2020 at 8:54 AM Quentin Monnet <quentin@isovalent.com> wr=
ote:
> >
> > Building bpftool yields the following complaint:
> >
> >     pids.c: In function =E2=80=98emit_obj_refs_json=E2=80=99:
> >     pids.c:175:80: warning: declaration of =E2=80=98json_wtr=E2=80=99 s=
hadows a global declaration [-Wshadow]
> >       175 | void emit_obj_refs_json(struct obj_refs_table *table, __u32=
 id, json_writer_t *json_wtr)
> >           |                                                            =
     ~~~~~~~~~~~~~~~^~~~~~~~
> >     In file included from pids.c:11:
> >     main.h:141:23: note: shadowed declaration is here
> >       141 | extern json_writer_t *json_wtr;
> >           |                       ^~~~~~~~
> >
> > json_wtr being exposed in main.h (included in pids.c) as an extern, it
> > is directly available and there is no need to pass it through the
> > function. Let's simply use the global variable.
>
> I don't think it's a good approach to assume that emit_obj_refs_json
> is always going to be using a global json writer. I think this shadow
> warning is bogus in this case, honestly. But if it bothers you, let's
> just rename json_wtr into whatever other name of argument you prefer.

I didn't mind using the global JSON writer, but I'm not strictly opposed to
passing a writer down to emit_obj_refs_json() either, so ok. I'll
still respin to
rename the variable, it will be clearer that the function does not rely on =
the
global writer.

Thanks for the feedback.
Quentin
