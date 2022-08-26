Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7031A5A1DB1
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 02:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiHZA0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 20:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbiHZA0P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 20:26:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4505A3C3;
        Thu, 25 Aug 2022 17:26:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z2so314314edc.1;
        Thu, 25 Aug 2022 17:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PilN/PyNDQnfqWQWI9Sn81QI/FxZsIeadEYzYbxzAhw=;
        b=RoPkm16yenisneME8U935sfgTkOtLPbUpoXwWiRAlbJz10D+L++EhWZUwaGaNsmiE0
         6yIQPSNqrJvU61VMOYLjknaR8Ce+WS8M+cwE6zXgiuBd4vxsgpgYsNY8Gu70ArD6ulDl
         pDA4ds+3gQFNfrCXILr3HH8fIaRSt32ipGhhdrD71lJ10qll0ght9WfxzAfKaKfEP6sR
         Ij/UJy7X+FrAvkQ4NWDZDMS6Wow6AtqecmImPsWVqfQlCuPiJaqhUzB7ggV53cl5xTuy
         VSdvEVZhj9whbpAXUYcqNuQZMOkQvniCGgflV84eE8qxEHZNNgIqES6C+zuJTpIBZc3d
         a0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PilN/PyNDQnfqWQWI9Sn81QI/FxZsIeadEYzYbxzAhw=;
        b=Z2w3xeW8UuHxPCWhiyz5hjhI4zdU2itLfUGyE7/qPOgEBfDEBmLnXYBadnFz68t7Ma
         McXE6W/MJRKqmnf4Zv3Hr9l+cy/neLW05QZ/PJ0oTqEpTtEmXhya87v+5ru2iMLue+uY
         PxkUomRzwM1KMmyHA7xuojBYZS92Ea1kZsfbzc54+homjW88rdTmj/A0XxrUxb61Cz1Y
         Xo4L1q5Jz3sInMjqqGAcFyZv8St7xDcKEh5pMfgbStGHTgwhLGfiyBprE6t/2PHyy5fC
         yFeehg7m0mWqcRXvkk0LflcHouZ0cdPOxUJpVeocsMoH8IqHGGqY8DLIeEvUoj6kLMsd
         XhOg==
X-Gm-Message-State: ACgBeo2y6sRuWBPr0JkzGYySF7E9H/lAqwUyl//clc7VHgl+zYcXVg2r
        oWY0aoUZ3/mSRtmQg/b+qwVYuB8crgoXqTIJiMsVKAtp
X-Google-Smtp-Source: AA6agR6Vg3tNo6txlY5V4/T/z3ITds6BH74nzIS/w/mglPg0yK6JRhZlfWf3RXMF4/kbNIqBr6UhjeaKALEcbuvP41I=
X-Received: by 2002:a05:6402:27ca:b0:43e:ce64:ca07 with SMTP id
 c10-20020a05640227ca00b0043ece64ca07mr5104912ede.66.1661473570817; Thu, 25
 Aug 2022 17:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220825175653.131125-1-alx.manpages@gmail.com>
 <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com> <20220825225425.hp2ylp5rxq453ewl@illithid>
In-Reply-To: <20220825225425.hp2ylp5rxq453ewl@illithid>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Aug 2022 17:25:59 -0700
Message-ID: <CAADnVQJn=-zMy9b6ctFj0w4BMgPwqYWG-aoDo9ddRV-+XSeA9g@mail.gmail.com>
Subject: Re: [PATCH] Fit line in 80 columns
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        bpf <bpf@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 3:54 PM G. Branden Robinson
<g.branden.robinson@gmail.com> wrote:
>
> [sorry for the big CC]
>
> At 2022-08-25T11:06:55-0700, Alexei Starovoitov wrote:
> > Nack.
> >
> > We don't follow 80 char limit and are not going to because of man
> > pages.
>
> If someone got a contract with O'Reilly or No Starch Press to write a
> book on BPF and how revolutionarily awesome it is, it's conceivable they
> would be faced with exposing some BPF-related function declarations in
> the text.  In cases like the following, what would you have them do?

If they're using a script to write a book their contract
should probably be revoked.
