Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ED25744B5
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiGNFyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 01:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiGNFyO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 01:54:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC4713CCD;
        Wed, 13 Jul 2022 22:54:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id os14so1507279ejb.4;
        Wed, 13 Jul 2022 22:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fddzfmY1VQJk/xZ5uftP/6jRX43mYICKRVm1mF6JZ+Y=;
        b=goDk9hhmMO9rA29ENrdgWRn/vKUdqrMLKd/6Xl85OO1LpbfXvF9sSjJB1ZcZ/CyQhf
         Xl/agqJ4EF1zpgpqYzhtsgHTMYYfczMVOAhRJ0q9Jf5cojatWL5AFedi5DtRuaHXO4Nj
         jLpC/DpkNYCQFAYaSeDa3MDGi2lSgC6RL/0ofd/KJzUnmlo14cwF+R6V+4QkIv+7PHCJ
         hzNxdYgiEvCcxBPxmAvRsRzUTLEsRSDPqLJrJg9wLLH2QsbgixG/5gffyAlcPYp98bVJ
         YvStbUyOiviJrQkQC+ATR0DIRqNG37XeQsmOFd1ff8m0W5ZL5NDQQkDK9WAqhBS60hk4
         it5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fddzfmY1VQJk/xZ5uftP/6jRX43mYICKRVm1mF6JZ+Y=;
        b=OSZzTafmNw9vvUcp3pW9C/D3Gim/pXWBst97/ZWe0g2NC2TKMLgj39r3WCLotnD5ee
         M+wjipqcURC40qT8O0QbJNlzI6nFHHNRnAQGwqBotwOT3wUq82S2vDDPrqfHUoxzWkr/
         23wa/L/uFoVkVGWPk+P9HbfkGFePOPeX8xu4q9XjoJ4ifI3ysMHluIwMRaMYHg+J0PEH
         TB6qnnxLVDO5OH57x/xLS+HLKgrzJ493bfmB+NX03VOVqpfH/PSNwKFBiSrjm3JZgBRM
         9s7hGmig8CPZelg6eOKuJOWvkvH412L30oO/T5MwBLN8ZJgmuOZ0xR1uarJci7vrlD2l
         L/Eg==
X-Gm-Message-State: AJIora9S3GRqvn+Y3rEcv15DsiJdJDnWHQR+9d/ap2BCWVnVlEh36QBr
        +bjRQ1z0ayYFHp1lYAhYIeoWvs+cs7ykLKCtR1g=
X-Google-Smtp-Source: AGRyM1uXqvtjavdNWywspv8Vf9Yqe5SNo6gd4XKrTBc2QrKRy86wjSn7nmWfXv09t9a4UXgKRcojVMqHcEE1nxdzz9g=
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id
 f17-20020a1709063f5100b0071239458c0dmr7086679ejj.302.1657778052209; Wed, 13
 Jul 2022 22:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220713214246.2545204-1-jevburton.kernel@gmail.com>
 <CAKH8qBtkgsQ9snhno3aYnhyc8vG2a0xhgg_sCb4KFhcQt+gfqA@mail.gmail.com>
 <Ys9IBYKqlTzkf3jA@google.com> <CAKH8qBs7FHAT9ZW+xAfJ=3gr8ZhZ7fMQO6K2Cmw8FuKGa7+GPQ@mail.gmail.com>
In-Reply-To: <CAKH8qBs7FHAT9ZW+xAfJ=3gr8ZhZ7fMQO6K2Cmw8FuKGa7+GPQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 22:54:01 -0700
Message-ID: <CAEf4BzZTJ__PKs6GiDccjC+pKbGFeck2AV8UJ+iJEcLPMkdjTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_map__set_name()
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Joe Burton <jevburton@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Jul 13, 2022 at 4:02 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Jul 13, 2022 at 3:32 PM Joe Burton <jevburton@google.com> wrote:
> >
> > > Asked you internally, but not sure I follow. Can you share more on why
> > > the following won't fix it for us:
> > >
> > > https://lore.kernel.org/bpf/OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
> > >
> > > ?
> > >
> > > The idea seems to be to get the supplied map name (from the obj)
> > > instead of using pin name? So why is it not enough?
> >
> > You're correct, this approach also resolves the issue. No need for this
> > new API.
>
> SG! New helper might still be useful, but I'm not sure how safe that
> is, given how much we use the name internally in libbpf
> (name/pin_path). So it might be safer to use Anquan's approach for
> now.
>
> Andrii, any concerns with [1] ? Should we pull that in?

I already applied [1]. I'm uncomfortable with bpf_map__set_name() in
general, because map name is tied into BTF and other things, so it
needs much more careful thinking how to support sudden map renames.
But given the problem was with bpf_map__reuse_fd(), I think [1] solves
it already.


>
> [1] https://lore.kernel.org/bpf/OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
