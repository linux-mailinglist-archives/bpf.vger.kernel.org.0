Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6748D573FE6
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 01:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiGMXCJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 19:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiGMXCH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 19:02:07 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC262A95D
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:02:06 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l11so297262ybu.13
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OSuSJ52wcTOUMRocdLRtm5methg8M/tEQfwjrfRjyU=;
        b=EX0eIDTDv6Op2NFyQjnDuL3ygkxwpxc10ZsVRZ9ZEnjSS6oiGUeLDkvI1GSJwQt9Ch
         KPAhOHA0QidwpyzycO4aCctC/tsY2FchXz8+5pM/yMBZjW8fQlx4utnOpkeGfwz4OkXi
         raDunL8HcgKouLi8O/KOdqAMJZpKWT/cgMkEeQmZlfNyZ+rr9hBfcS4NLKzjkNW2WDcQ
         +UH4Gbx75sWaNPaH5WRQUkyZ8qWVipA8wMUwZU9rFL29p3LxFIeyLQM6XFojw1/LZIEg
         ed1XNXEmtuC5zb0JmErjZWEAtz92nWbpJh//plAe1ba+irJa35poeGnhpFc5N0LE1Lkc
         z5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OSuSJ52wcTOUMRocdLRtm5methg8M/tEQfwjrfRjyU=;
        b=AEenDzSg05BwgBK6c4aLsOGd0z5xikETEn9Uug+RNubsNJEvyIzroN7e3C29p5wgNh
         2BIFhiqMa59WAcIXukpqcYUgxxCdwiH2HZV6ni4stYjo6sxfFZjTCK778isI0rEpLGOj
         lkJm2A6N8xi+gAG3TD5z5nHCzvQ0qGqyHaqDgThgFK1hgG/8azRFgEi4c4hRUJCSe+DM
         c0k+IYOXxsSn4Aa7whXOb3K/GIuoZKYrPu/trYuNtK2WIvF9ifr6Tye7Sycdc1NBbp+L
         0CDwAw0cJyz7d1VM676UGDFJ4m/BThYq8bIokX1QXtdOseP2uPl/QPwyq/AMN0YGWnuw
         wSTw==
X-Gm-Message-State: AJIora8tUghASYGR4wTNW7T2sTy8dATa7IbTwdmOjCKbnVbZOZ2NoCdt
        LzGRxq2OxnPngKMoU9s200hIHpGajh8pgOmdUk+IKQ==
X-Google-Smtp-Source: AGRyM1vEw5SGw7ikM1WmdO80Q3n6WgdPVzJZoC2+wiPT5SqXIkmr/awSwAQRRWZk2+6iU7YkSj92hhvZOAIU8oU5Fdc=
X-Received: by 2002:a25:8b02:0:b0:66e:239a:8f69 with SMTP id
 i2-20020a258b02000000b0066e239a8f69mr6060934ybl.4.1657753325788; Wed, 13 Jul
 2022 16:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220713214246.2545204-1-jevburton.kernel@gmail.com>
 <CAKH8qBtkgsQ9snhno3aYnhyc8vG2a0xhgg_sCb4KFhcQt+gfqA@mail.gmail.com> <Ys9IBYKqlTzkf3jA@google.com>
In-Reply-To: <Ys9IBYKqlTzkf3jA@google.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 13 Jul 2022 16:01:55 -0700
Message-ID: <CAKH8qBs7FHAT9ZW+xAfJ=3gr8ZhZ7fMQO6K2Cmw8FuKGa7+GPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_map__set_name()
To:     Joe Burton <jevburton@google.com>
Cc:     Joe Burton <jevburton.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 3:32 PM Joe Burton <jevburton@google.com> wrote:
>
> > Asked you internally, but not sure I follow. Can you share more on why
> > the following won't fix it for us:
> >
> > https://lore.kernel.org/bpf/OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
> >
> > ?
> >
> > The idea seems to be to get the supplied map name (from the obj)
> > instead of using pin name? So why is it not enough?
>
> You're correct, this approach also resolves the issue. No need for this
> new API.

SG! New helper might still be useful, but I'm not sure how safe that
is, given how much we use the name internally in libbpf
(name/pin_path). So it might be safer to use Anquan's approach for
now.

Andrii, any concerns with [1] ? Should we pull that in?

[1] https://lore.kernel.org/bpf/OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
