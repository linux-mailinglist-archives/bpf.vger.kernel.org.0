Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC010423641
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 05:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhJFDOh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 23:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhJFDOg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 23:14:36 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EE8C061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 20:12:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id s64so2057569yba.11
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 20:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=by4xYXNAIgaST2Q7gm/Xu2Q2SK3ReXglUDYxxJnrer4=;
        b=cGHdOOtXRdwLnvcggdW/ttJ+Rd9eHpcbxpVKUgDdpPEZZ95u1P+IShQYH7M9Dj9hyu
         0/IMa38d6tnDsBYFdGdE2xnFYYX7KaJ3QKmwzN9fwWkPPGn/Wbf8IUw0e3ICFNqH6B2+
         QMqRV4Jt3VWvU10Pxj0LAa/9OSJM45AYVGk3onK8UXb9TK+L11+8nVW+YKS7sHU+uaO1
         V1HUPxxjq2BXa9ettM3YPK6hNQEESbEi4070mKuyxh+IWqjSbLu5YYZQ1QoHcrWTBmas
         2ocEyqg5HTEKGnLNtHp69UDQuclm9VN6ODz9J/04adEYTpO23dqb6du+yD6K72YI/f98
         WmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=by4xYXNAIgaST2Q7gm/Xu2Q2SK3ReXglUDYxxJnrer4=;
        b=32lbFQ0HCDqFxwApRwGQaXVxJ2TxNWndbAa10+dLuw/oRPHOwSqr07PaCy4L3Bnr8l
         1a+ShoOTvCem2sUavHnwh0rFFK6YN8QNSvlCUOkZYyyAbqTq4J6bKPXdJNQRftfPOELu
         J+UEHYmGEcVe0zVeF7LUeBjF2JeO71lwYsvNM1Uu1JwefEAq3m7l/gSkryZzRG0QelZq
         fcUIwZqDLGVX8ruW9CvSfFAhYgrfcbBgaw/pA9Pmud/Q8O9WqTx+WoOUd1oRCGDLMcrJ
         m+M2Lm00zBsoa4a7Me3V5Ne5GH/W6x51EkrVlqCW2szp5kLqm3RZ6g4uKg7LtYalC/Ym
         QFgw==
X-Gm-Message-State: AOAM532xIYAT+PFhPsGhgrftU8Sh2B2oUFLBca5t5YEnV8hKDm2xq3kq
        LxP9h1R4Rc4E/Xu0XRQlz8eN/SNWVtJVbvjYBmM=
X-Google-Smtp-Source: ABdhPJzNwaTRbIkWjMNNWVRuZjNuGIlstmDltkXWNlxBaPsvFHiEmmn3z1Ea0zAlSgRuyyTC5p8Ub/knuQGGVmDjzjs=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr25445222ybf.455.1633489964285;
 Tue, 05 Oct 2021 20:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211005064703.60785-1-andrii@kernel.org> <20211005064703.60785-4-andrii@kernel.org>
 <12FA0143-6E11-46D1-ACF3-8206D4925E3E@fb.com>
In-Reply-To: <12FA0143-6E11-46D1-ACF3-8206D4925E3E@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Oct 2021 20:12:33 -0700
Message-ID: <CAEf4Bzb3FW84GfrkVYj0ssto4ZuN4PgNHJBr6M4c9QBnWDVijA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: test new btf__add_btf() API
To:     Song Liu <songliubraving@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 5, 2021 at 3:05 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Oct 4, 2021, at 11:47 PM, andrii.nakryiko@gmail.com wrote:
> >
> > From: Andrii Nakryiko <andrii@kernel.org>
> >
> > Add a test that validates that btf__add_btf() API is correctly copying
> > all the types from the source BTF into destination BTF object and
> > adjusts type IDs and string offsets properly.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> > .../selftests/bpf/prog_tests/btf_write.c      | 86 +++++++++++++++++++
> > 1 file changed, 86 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> > index aa4505618252..75fd280f75b2 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
> > @@ -342,8 +342,94 @@ static void test_btf_add()
> >       btf__free(btf);
> > }
> >
> > +static void test_btf_add_btf()
> > +{
> > +     struct btf *btf1 = NULL, *btf2 = NULL;
> > +     int id;
> > +
> > +     btf1 = btf__new_empty();
> > +     if (!ASSERT_OK_PTR(btf1, "btf1"))
> > +             return;
> > +
> > +     btf2 = btf__new_empty();
> > +     if (!ASSERT_OK_PTR(btf2, "btf2"))
> > +             return;
> We need goto cleanup here, no?
>

yep, my bad, will fix

> Thanks,
> Song
