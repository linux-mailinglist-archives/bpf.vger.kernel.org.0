Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBCE694666
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 13:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBMMy4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 07:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBMMyr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 07:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7456146AB
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 04:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676292841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzebZ30kzj7N0BnPIfXYRkFkaGqREtgrrb1Fr7Y2rqM=;
        b=NjYSDpJ/dSjs0JAYN6QFpad4u9zBtEB6rxkQp1GlqSrHr6L528599rylFPXevocv6EwdPP
        q9JvCUJVVcQv1OPeUsVSmsx4F0/xuzr6O/WYjEmpYKyxvBEau4ZUjJzGw4a2so8yPbfaPe
        MVad3yDUkV1XBgCXZ6OnLwVwlZgdHns=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-8UIE6464N4qdwK_9KSneqQ-1; Mon, 13 Feb 2023 07:53:55 -0500
X-MC-Unique: 8UIE6464N4qdwK_9KSneqQ-1
Received: by mail-vs1-f72.google.com with SMTP id g12-20020a0561020ccc00b003fd3b1e2740so2444156vst.2
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 04:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzebZ30kzj7N0BnPIfXYRkFkaGqREtgrrb1Fr7Y2rqM=;
        b=B6sXIJnnklRdBHAujCvZOUYT3CQW9Ma0gASm04X5Ls7r/hDqfgu8JN2VL29elZLvgS
         exCsQUQe51C8Zes7kT9PRjFab89fN5RM5cHmS1zf9eWB/ULEMsD027+RhbJ4PLSgcJFz
         VQ6KjLJWmJZVnmN0uEbFEw3IpQYtc//5HWEYqPcuE9uBLugWuoIIGeRxq48tyIXMdxh4
         SwHBaQPX2rql4HU8vgJVzgu+tHPLrSpz2Z8c3nHBLNwrLOv0O+jQpp2f/RppN9YiJHVI
         rMKAFNGqTjm4fYdRy9fJclF3oAFPRlKyiFZV4QBEI/8PjHvyku5fG8x/756KZq0qLF33
         7OnQ==
X-Gm-Message-State: AO0yUKUlXBl4OZXwTYeEmJcsCofKl6uztIuGDmAKm3mR6iw1O2tCMgoX
        G4u9n+Yvy1c2YfcdGv9CQmFCcosYKBbaad92TTHVRhuINXN1WHgZDA3Q63Gz2d3gb3uNA6iCEi7
        gbfSYuSN4TXtQ2D7PEgVGKD0K3id+7CecAoR1
X-Received: by 2002:a05:6102:50ac:b0:412:b77:7822 with SMTP id bl44-20020a05610250ac00b004120b777822mr612774vsb.74.1676292834624;
        Mon, 13 Feb 2023 04:53:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+uR4OQVakWkB0Q6ReN9flfEMIBV6WMTofHt8sSly39IdDoXb8ZlGABx4e3XLMo+mm4AgewLTiPoWd0xMM2jpA=
X-Received: by 2002:a05:6102:50ac:b0:412:b77:7822 with SMTP id
 bl44-20020a05610250ac00b004120b777822mr612762vsb.74.1676292834433; Mon, 13
 Feb 2023 04:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20230111152050.559334-1-yakoyoku@gmail.com> <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
 <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net> <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
 <Y+atpJV5rqo08dQJ@kernel.org> <Y+oofL/aJmUjcxIR@kernel.org> <CANiq72=Ghy2awR_+DACyiq_DAtscx3yoKb4tJ+GkpqVCcV_HEQ@mail.gmail.com>
In-Reply-To: <CANiq72=Ghy2awR_+DACyiq_DAtscx3yoKb4tJ+GkpqVCcV_HEQ@mail.gmail.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 13 Feb 2023 12:53:38 +0000
Message-ID: <CAOgh=FzBjR7V+sQOy2OEV+YXxB0_YzapNTO+-Xf3uGnLfA0Vxw@mail.gmail.com>
Subject: Re: pahole issues with Rust DWARF was: Re: [PATCH 1/1] pahole/Rust:
 Check that we're adding DW_TAG_member sorted by byte offset
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 13 Feb 2023 at 12:45, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Arnaldo,
>
> On Mon, Feb 13, 2023 at 1:09 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > The namespace.o seems to be ok:
>
> I saw the other message too -- this looks great, thanks a ton.
>
> > The core one needs work:
>
> If `core.o` works, then I think it is likely other things will work :)

Hi Guys,

I'll leave this to the experts, but if we get this to the point where
we are happy to enable again for Rust CUs, could we request another
version bump? It just makes it easier to integrate with the kernel
scripts when we want to enable again.

>
> I can try to extract the cases for those into simpler `.o` files, if
> you would find simpler test cases useful (perhaps for the test suite
> etc.).
>
> Cheers,
> Miguel
>

