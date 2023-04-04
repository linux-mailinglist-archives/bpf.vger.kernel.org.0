Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99A26D7057
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 00:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjDDW6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 18:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbjDDW6s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 18:58:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD8196
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 15:58:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fi11so13131494edb.10
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 15:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680649109; x=1683241109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1lIEYFUzVAnuc72LKs1jWLNDguO1OG+ad8p6onzEz8=;
        b=IKNhvEzjFXCJte+M+KUW8OW284Z5I9SGH6pMpKJKJ8u/Hm7Z1p9gkkeIpxnCBiZZVb
         VzIMXez8bD+XOjFedqetfeNXY2GoBq8XncL3bhyB1iEYDt+ZnP1v8XcbBiKmXmn6kX8M
         x/5Cc+ymTakTf9H1sqAJSntrJGvzcnKQe+klVI+X/yO8TuyK/Y0ih4qYYMBN2qjxvatm
         vRsvIaGokg5HOAxWKklb0C+KKSzjDiQf+NTc7RX1w+O0/3gq5a7qNfSRqmd+ezUTLMLR
         XZhnL2fXllGIX/r/KwoUEsQA63FeqpAfArXETCVU+GadWld7pr91yIyYoYE5yQ+8gwOr
         xC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680649109; x=1683241109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1lIEYFUzVAnuc72LKs1jWLNDguO1OG+ad8p6onzEz8=;
        b=QIdPOKo0QGTRdsBsS/T6zgUaDrNX1Gos6L1nTNBsRIn/9AS7SfLVzJysbZHdVtVTiC
         SI6xD/3EIoQqab/tP85bbbK5Sk7MA5I6kw0TRYY49VN2D12Ab/r9lpRwKoBE/gh0yPOc
         5ftxuUrff7tJjnOy7cDL39MrfiRWcAKR8ZJ52n9rs6HNDIZ18dCXTOkDXG89kv6179ol
         7eS3QeOsiQFXFoad3UIXrobrjt10XWiiAtxNE3bj/KvKqVznKRWjx34VPf3KQbjNTMXR
         RK8szjmlKpd9XB2HndBiQV9JsRtwHKt4H4n2byA24gXemiXh0Q4WO4YJmyASF4JngF4e
         6IKA==
X-Gm-Message-State: AAQBX9dQu5euN5qUgAsiz+684i8F9Q87ETffFNof42olQGjvolkrCu99
        BFHeAUuJ+hYIdAJ64aokQExWKpXnzLtoNG2n0HI=
X-Google-Smtp-Source: AKy350ayVIWCj5UOuAehSmfU0wWICsd1eCQu6ZgAiNePxY0Mi6Nb0nahZJnEPfiC3gYGjUhRZMphvl+MbVs1VKs8wJs=
X-Received: by 2002:a17:907:c20:b0:926:8f9:735d with SMTP id
 ga32-20020a1709070c2000b0092608f9735dmr671673ejc.3.1680649108515; Tue, 04 Apr
 2023 15:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
 <CAEf4BzZntoM0fHzgBuGiqiTNkq=jT-f09nwub-MHyguJCfLeNA@mail.gmail.com> <CA+PiJmSNnQ9DD+JVc9hG7iEj5ZDZfhOhYAMKs+f=kXs=DZxuAA@mail.gmail.com>
In-Reply-To: <CA+PiJmSNnQ9DD+JVc9hG7iEj5ZDZfhOhYAMKs+f=kXs=DZxuAA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 Apr 2023 15:58:17 -0700
Message-ID: <CAADnVQKMrsc+Dxz3uWeKzCPDfr0XKWaWsbn3AeEm+RCmp-apUQ@mail.gmail.com>
Subject: Re: Dynptrs and Strings
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 2:06=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> On Mon, Apr 3, 2023 at 9:57=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > bpf_dynptr_slice(_rdwr) is basically the same as bpf_dynptr_data() and
> > bpf_dynptr_read() as far as fixed length of read/accessible memory
> > goes, so I don't think it gives you anything new, tbh.
> >
>
> It does in the case of a readonly dynptr. bpf_dynptr_read requires a
> buffer. bpf_dynptr_data rejects readonly dynptrs, and doesn't really
> provide a way for the verifier to know the resulting buffer is
> readonly. bpf_dynptr_slice handles read-only dynptrs, but requires a
> buffer which will be unused for local dynptrs. Verification fails if I
> try to pass it a null pointer and a nonzero buffer length. That means
> to gain read only access to a read only dynptr of size 255, I'd need
> to either copy it with dynptr read, or declare an initialized buffer
> of size 255 which will be unused in order to gain direct access to the
> dynptr data.

I'm pretty sure we can make bpf_dynptr_data() support readonly dynptrs.
Should be easy to add in the verifier.
But could you pseudo code what you're trying to do first?

Do you expect bpf prog to see both ro and rw dynptrs on input?
And you want bpf prog to use bpf_dynptr_data() to access these buffers
wrapped as dynptr-s?
The string manipulation questions muddy the picture here.
If bpf progs deals with file system block data why strings?
Is that a separate set of bpf prog hooks that receive strings on
input wrapped as dynptrs?
What are those strings? file path?
We need more info to help you design the interface, so it's easy to
use from bpf prog pov.
