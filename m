Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07614FE57A
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 17:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357456AbiDLQAm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354266AbiDLQAl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 12:00:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C427F5C642;
        Tue, 12 Apr 2022 08:58:20 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h4so5557657ilq.8;
        Tue, 12 Apr 2022 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RNQurpwxbSDB/GNvCzbmKeS9pihN4PulfOu76DM56U0=;
        b=hfUuDSUM1HmeElzHTjmqNg8yECgIBWMKYO2tgw6orqHdm2pjE6bnmFmvnBiBBLnUIY
         63APZnd2B6nRDr9EqfH7Wi0qWtkOnC4KqXUeu7HBCCg7owdrnAIoZbYmwCxzuxodR/XG
         wMu34I9Tkvlo//uZzZVjhEHgAQxLYm4sR6kid0QwYWh1oS/LWts2e3RL53RTYhHBnrlY
         ppiG19Va/ZEd1G9y8+7q9ThgA1bFVcE78ChrRokDnar6yHnrDiobPdnz+q+2vOCNJi/j
         TxUT/MOh6IC/z1GYhyPfNtoHbNQCsyukqgO5+x9cP4UCpL+YVWWHGAyfn36/IS5qucie
         WOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RNQurpwxbSDB/GNvCzbmKeS9pihN4PulfOu76DM56U0=;
        b=vKT9duTIhSIN2s4t699hGTrfFN31zxsABYNuuJTh+OKuT/tRWm+BoC7m60KsWdj1M8
         aBX01JsQyaiEzaoHrmv36WytKy/Jl1wsqQmK2wJv4maMqIvnSyiPiR4jd+FrNhju2kUx
         diCKdR15D4C1mW4rXOaYDNxKRVaF5tNs66SOEZZE6ToHHxPUKHOM8tlV0mAFSUW1BPJh
         hpYyhpPCvwfZvvxlijZwFhM/AuX6vVuJ2xil0ETovJ8CCl7eV6JcgRvFfvHBl8Thn5v5
         Z0AgdpvNPCqAufZZtnfVUABQ4a9DEdJSlbEwdmCWUq9Lwl58uO/dqUM2I/bfn9D0RSZB
         HVwQ==
X-Gm-Message-State: AOAM531dnuzxBfyfRZUAWVhqXn5fZ/kxX2Qbo7u++dF5id5qV9dvL9en
        cMGsPCfLu5Pmowm+mHTa4UirwMad4a3JLAJgQ4Q=
X-Google-Smtp-Source: ABdhPJxbAXF/WsPH07smVA7+Wx9lrm5oWtBWjRMHZN8Cb8yL0AoL6xNsLkjrlwKfwh+UcvWUU226qk3bdpDJXqf/2RY=
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id
 g13-20020a92cdad000000b002c67b76a086mr16973527ild.5.1649779099710; Tue, 12
 Apr 2022 08:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220412153906.428179-1-mic@digikod.net>
In-Reply-To: <20220412153906.428179-1-mic@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 12 Apr 2022 17:58:08 +0200
Message-ID: <CANiq72=ogSxwz8iJLZaYD4nSkE71sBhT4dZyDv1HYyo5R43=pw@mail.gmail.com>
Subject: Re: [PATCH v1] clang-format: Update and extend the for_each list with tools/
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf <bpf@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Micka=C3=ABl,

On Tue, Apr 12, 2022 at 5:39 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> Add tools/ to the shell fragment generating the for_each list and update
> it.  This is useful to format files in the tools directory (e.g.
> selftests) with the same coding style as the kernel.

Sounds good to me. There have been discussions about doing it for the
entire tree too, so we can start with this.

Cheers,
Miguel
