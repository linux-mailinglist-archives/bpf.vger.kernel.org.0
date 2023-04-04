Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8606D6D6EAA
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 23:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjDDVGx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjDDVGw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 17:06:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545FF10CC
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 14:06:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id cm5so16507853pfb.0
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680642410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEDq6oeKPz7z6eerYFuMfw1z7iwpq2dGJHCG+7ggRXA=;
        b=XNQrFT/597L8qDGFWuKM3uqB3kvnJGwwFUPsNFZ1HNkBXBzzU8ylAbBN5ihdc7Cz+X
         ogjsSXeDssZionkbmRwSwhLrk+l9o+RhepgQr0iv2A6rCqxhWZvC2mxuEMEmTjjAO6RT
         +FqqWLSuEzm+d1L3zp03TxqMVxhXZl2wqZ8zJMaU3ljXK295QsnFxCso4w5BYfy5wAGb
         cyiYY9Otje7YXaARH8mn2HM5xKGsm/eMWnexhe9ukUqB9cYvm35QA3XJyTNr2Q3OUu9D
         B21LjewvjX6LH/BG14DjfCoeVD5spKaq3sAz0Gjk0fiDUKLakNOEWOh2HeAPJS/QE+CP
         PJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEDq6oeKPz7z6eerYFuMfw1z7iwpq2dGJHCG+7ggRXA=;
        b=F9Fiwfe+Juc8HA4o92yKYwL+h4e0JZSycQNDmD7qwe64eMNfSe/hDDfuD3ocm/Ej23
         RlFEcVU65KEY8DUzNDL4/mU3ju/6JgzzaMhtPzE7Xr1NiMGDn+za1aijyVmdJvFto6Xx
         c+SjFodsJ1KOzUmMcef7zxblcEwoeMaeRzCHOeBf7td9646qaZ0Fr6DVqNQqboyaDSN7
         ntFssN5RgX6ADNdO9eKbQabu1E7kJhlmXbAmZ42CJHDIcbRwwh2Gf+pph4gOLAOjVPuK
         6CRuTwRUJeE289SvLvxhC5e69v6AUt28P2Blxe5SK9LMwiNJ+HalBKCQ+Wbb/Hb57/EE
         NK9Q==
X-Gm-Message-State: AAQBX9fUIKk8pGo45aDBfvlBcpjE9sfhFbVqOyYGxsSyMDnq17HlSOBm
        zuOb37qfGgOERO8f7U3w4qUZ2Ru9Yf05Pca9VgbkfjbTUzEGhtyjj6a5e9n4
X-Google-Smtp-Source: AKy350b6wfCvCDyUKF74+KqHv4Oq/A4Xf+dSs7QtkN2+wASsBqIBXH1+Pn1Tks1Nz1fKBXPQcW+Kket/RiV1jNKW8Ag=
X-Received: by 2002:a05:6a00:a1c:b0:62d:e8f1:edbf with SMTP id
 p28-20020a056a000a1c00b0062de8f1edbfmr1987336pfh.5.1680642409562; Tue, 04 Apr
 2023 14:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
 <CAEf4BzZntoM0fHzgBuGiqiTNkq=jT-f09nwub-MHyguJCfLeNA@mail.gmail.com>
In-Reply-To: <CAEf4BzZntoM0fHzgBuGiqiTNkq=jT-f09nwub-MHyguJCfLeNA@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 4 Apr 2023 14:06:38 -0700
Message-ID: <CA+PiJmSNnQ9DD+JVc9hG7iEj5ZDZfhOhYAMKs+f=kXs=DZxuAA@mail.gmail.com>
Subject: Re: Dynptrs and Strings
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 3, 2023 at 9:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> bpf_dynptr_slice(_rdwr) is basically the same as bpf_dynptr_data() and
> bpf_dynptr_read() as far as fixed length of read/accessible memory
> goes, so I don't think it gives you anything new, tbh.
>

It does in the case of a readonly dynptr. bpf_dynptr_read requires a
buffer. bpf_dynptr_data rejects readonly dynptrs, and doesn't really
provide a way for the verifier to know the resulting buffer is
readonly. bpf_dynptr_slice handles read-only dynptrs, but requires a
buffer which will be unused for local dynptrs. Verification fails if I
try to pass it a null pointer and a nonzero buffer length. That means
to gain read only access to a read only dynptr of size 255, I'd need
to either copy it with dynptr read, or declare an initialized buffer
of size 255 which will be unused in order to gain direct access to the
dynptr data.

>
> I think we need something like bpf_dynptr_strncmp(), which would take
> two dynptrs, one for each string you'd like to compare.
>
> But in general, when you say "I need to access strings and blocks of
> data " above, what exact operations do you need to do on them? strncmp
> is one of them, anything else?
>

For blocks of data, probably memcmp. The upcoming dynptr apis should
make editing specific parts easier. Might want a memmove style command
at some point?
For context, fuse-bpf allows intercepting FUSE_READ and editing the
data before it's passed along. Or at least it will ;) The upcoming
dynptr APIS you mentioned should handle most  things there.
