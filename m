Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D1A43E6AC
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 18:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJ1Q6y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1Q6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 12:58:53 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D29C061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 09:56:26 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 131so5397143ybc.7
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csJiIIjiJMNWhFJko0MsNXKFYvRsB3UByW2/bv79s1k=;
        b=P6wyZUMWj/WN2XBi04Hxd9c08MsF3PXEI+U0QBcxk+QmTVajsg9pFoDcDDn8K2djje
         e0Ui+gsRk4foDzaMOJOwRP0HIXx15nj42/DQgkN38aleV9iNlwioACLDhWQQ9ABekJPo
         k9rMJxPhfd0Pvi6ju0P4F+XcoZU2GJ3pJGMrJQlbwIydJmtbFG9+nvgj99eX00ciQG9h
         7b7j/M9WjnIbxTyj8cy5/cKb3+Ch0TJCOHkSOnwzYMwGHL2qtHs3GetAXHkSg2Kccwkq
         yAVjgZb2hZq53UZG8eFJXQz0DqvOaZeZEDrvCjfwPRZjye5yYuDFbqx/0ZyKwQTvf8fB
         Xxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csJiIIjiJMNWhFJko0MsNXKFYvRsB3UByW2/bv79s1k=;
        b=FSjYbVa9xT2HqCVx9ap/kIKjDkGFwOMzkAMb6p0r85VZik0mpneaYsug5ERMnlv7df
         A53Qhyv3/piyPZSds/bSX5m3996c7WqujrNxSDcVTpf7quAp09sMeISAFTUukfgrvTXW
         B3yWqpHzoW00qNPd38BYvCHrsptkPnEJfPdgf3L4dDFCA9p8JCyPrsJszWeprMAmkKdP
         rBEBGyjDBEZ4/H3yec9KruDIT2qZlgcnK5tufZ8Z/27wvtNuPECYp3qW9ha1IM/hrBOV
         mnJsSEJ8vfBz5XKhow04wa8bNBXHbnyKK29BTQKUxVVyrNgplTwW0VTeWERXhvXl4IC2
         j0gg==
X-Gm-Message-State: AOAM533xQpdLpTQRYSQIU/Lf2eR7RojJp8pMAVlh8vrDt50ARJ3hWDTz
        ebuxS/fu+/JjpU238NjhRBnJaFBaAwucP8ETMYo=
X-Google-Smtp-Source: ABdhPJw1uJnbBQtwHN5fpoBdT3gH+LP0cBs1QG5aXeuKDcVHUJt+NNbpeTgb7Fmyywv5gj1s8Ol7q2Dt4bbd90/p0Fw=
X-Received: by 2002:a25:bfc8:: with SMTP id q8mr5846425ybm.455.1635440185435;
 Thu, 28 Oct 2021 09:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <829e159a-b573-345f-fabe-fe68a756b21b@redhat.com>
In-Reply-To: <829e159a-b573-345f-fabe-fe68a756b21b@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Oct 2021 09:56:14 -0700
Message-ID: <CAEf4BzZhkHT7MrwYMt-pU8zS2ME0KaAoGjdPY0ugkh6i8M_dDg@mail.gmail.com>
Subject: Re: libbpf - why find_program_by_title ?
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Toke Hoiland Jorgensen <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 5:02 AM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
> Hi Andrii,
>
> The libbpf API bpf_program__title() is getting depricated (which is
> great BTW). (p.s. Instead use bpf_program__section_name()).
>
> Why do we still have bpf_object__find_program_by_title() ?
>
> Shouldn't we also deprecate that?

Yes, we should and we plan, see [0]. The only reason why it's not yet
marked as deprecated is because there are still a lot of uses of
find_program_by_title in selftests and we need to clean that up first.
It would be great to get help with that, of course.


  [0] https://github.com/libbpf/libbpf/issues/292

> And introduce bpf_object__find_program_by_section_name().

I didn't plan to because there is (in general) more than one program
for the same section name (section names are not unique identifiers
for a while now), so which program this API would return: first, last,
random? It's just wrong API with wrong assumptions.

The right way to go about this is to do a loop over all programs with
bpf_object__for_each_program(prog, obj) and compare
bpf_program__section_name() explicitly. And then do whatever your
application needs to do with every instance of the program with
matching section name.

>
> --Jesper
>
