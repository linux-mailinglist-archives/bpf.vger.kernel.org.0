Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF1694623
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 13:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBMMpj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 07:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBMMpi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 07:45:38 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209D1B32C;
        Mon, 13 Feb 2023 04:45:15 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-52bfa3dfd95so161000747b3.9;
        Mon, 13 Feb 2023 04:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BipEjooU0uRoQxtVpfSH69wBzd81GpNG792SE2KMh7Y=;
        b=BY82DidJBYmGlOlQ1ay1T4b/IeyG7rveXal6CH6r3uwDIUn1hX36w7ezSbDTcSAUdO
         not5ZcHyp3KjyPLvwIHI5yscFRnWAC+DLXtuJbiQwUZJaA6wIMkAceOI0wKnbPkH/0ua
         8HAVPOvu/xSAfOEpkZ74QR26xW9N6PXLOT2lIu/sg2y0YdGLyKsRtsO/hMQUOezT1VTl
         Tq8s06zHNRKRvXUwW6DZBuTqO5JgYkqRr8kEaAOJMJurrExuphu4gGGE+VMGya41fFtB
         AxiAslWO9TW7ZJBCuyIe7YXiCmUkK2d4LHcgez8RLszzfnj6hvfB6qOGZas0gm0maW1a
         yRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BipEjooU0uRoQxtVpfSH69wBzd81GpNG792SE2KMh7Y=;
        b=bZdNituk52ndumOks29mqIzwR8e8LRNlDJBbAjaPnVXGBnGpMuVaOhaGpTJm/QnIrE
         5QAmaO2BrVB8xjxQ790Pc858uDoZGKAgdIownFJIWfUKIrPredjogGNaUxKb5+BarzIA
         qIOYZVeJlD53l4QL9MHBJ/Zx0AOdqnAfSs1YAWeIgtPO12uboTciPGIak5cs1JV7kXRP
         EeFLraAcIN7MRWO/CTGAtbRxS0cqP37A/HK6AhZ8KrGCCuDok0QJqrYQgPfz1FPAsGHl
         dmqshJ2EelKF7sJqplVw91/gokxps7+F2Fsz+hE8uu+qC7AZvmdK2g+NeknWRs3y7Z6X
         uZLw==
X-Gm-Message-State: AO0yUKUFSG0gOIi3JAQI3nT7WTi237podu5X6m3olFkaLE7IDZsHVOw5
        9gmlgj9TSLJYg6qScjkhypfnAED5bBmMksqEuVQ=
X-Google-Smtp-Source: AK7set//ALU4hcajxJ4aUqWPUdrEYoS1MAG5H64bQwhe2lEJfidaKhbPMqxSKuNnpr2xe/Ry8bi9k/wBzWM5Hfe8H14=
X-Received: by 2002:a0d:fb84:0:b0:527:9733:fdee with SMTP id
 l126-20020a0dfb84000000b005279733fdeemr2911922ywf.490.1676292313556; Mon, 13
 Feb 2023 04:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20230111152050.559334-1-yakoyoku@gmail.com> <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
 <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net> <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
 <Y+atpJV5rqo08dQJ@kernel.org> <Y+oofL/aJmUjcxIR@kernel.org>
In-Reply-To: <Y+oofL/aJmUjcxIR@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 13 Feb 2023 13:45:02 +0100
Message-ID: <CANiq72=Ghy2awR_+DACyiq_DAtscx3yoKb4tJ+GkpqVCcV_HEQ@mail.gmail.com>
Subject: Re: pahole issues with Rust DWARF was: Re: [PATCH 1/1] pahole/Rust:
 Check that we're adding DW_TAG_member sorted by byte offset
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
        Eric Curtin <ecurtin@redhat.com>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Mon, Feb 13, 2023 at 1:09 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> The namespace.o seems to be ok:

I saw the other message too -- this looks great, thanks a ton.

> The core one needs work:

If `core.o` works, then I think it is likely other things will work :)

I can try to extract the cases for those into simpler `.o` files, if
you would find simpler test cases useful (perhaps for the test suite
etc.).

Cheers,
Miguel
