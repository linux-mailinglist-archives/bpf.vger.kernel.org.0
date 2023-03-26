Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3E6C9205
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 03:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjCZBT5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 21:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZBT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 21:19:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824D4AD06
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 18:19:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn12so22446602edb.4
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 18:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679793593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdDU9vyrfKibJkYyjEHbU6Lt0ddyyE2FgBxdas368dM=;
        b=o7jJk6zvZsRTN7wZlZzMQO0L/Fz4Uh303YfNMEXLX7ebFmcy5sGQwswwGupjAKZW51
         QkwVgjjm1RaLCKiew28IOgGNOAZ2ay5KweH9H2J6870+PU3MmIy/Q76UV1sUqzMb5xf2
         cg5kJKhmoPRMEL9FtBFPypd4WIsrcC7TajqRcui/olvx0mRIPQ1UdgXf5gv5bOF3OK3j
         dhoG9SUfcm4KQzfT9GmTc38PVNnxt5JVt5OJGxobIhY/dYSQ4vx1hKTkSLqDbvNNjsI6
         03C2sLYhOmJw1VRSPmb2mrhVfzpMMHgVXtfoXIP3C0coHHhDwrpAviPD0+3wyqkEQTZo
         1E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679793593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdDU9vyrfKibJkYyjEHbU6Lt0ddyyE2FgBxdas368dM=;
        b=PPzAfWUCfTOkqz6wk3RN4jgL3FRfUBd+y1tvdNdRuEe14MOMj9t32A+em9lthGc1WA
         V1frVv0hf7AMNQzac4iRHwLN2jla5tTVbO2S7StktQYTGszCI+IS7mGTYB3iBVFlzwDR
         FQ0aazFlgeAHaIkIzkqx9GWO8+EuY5WFExaIdvZ5v0M1rsgKEFyyTz8wOyFef5R0HSGp
         y8fkZwZVR8gYVN0w+w4twMP2qPeueXh1B/z5jtJeVpktW+2jh8uoPOEgwQOiW+LyKYWJ
         6R98pWotJXYolomMh+2+WGc0/zW439Q+cBM4UwXlYfrlB3OnlhBKowltNB2+/gJEalIG
         Hjvw==
X-Gm-Message-State: AAQBX9ebwt9WJp7jRe90JsLuINF3bxOlOdFUIS7hX6GqGW45klKfQhzo
        ZXOIz6llq5u8JvKGQ6b7EdfFziZUlgmYXVnzUXMkhjkbI/xFYA==
X-Google-Smtp-Source: AKy350Y2oBlLL2pXKMZwUo7OLdfQz7ak0qFUSZP0EYM9RQSj851gGXdX9UFV0hy6REHOg8FYqhXIqIUgNXivFL7rjyU=
X-Received: by 2002:a17:907:da8:b0:877:747d:4a85 with SMTP id
 go40-20020a1709070da800b00877747d4a85mr3876760ejc.3.1679793592853; Sat, 25
 Mar 2023 18:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <ZB5pFYZGnwNORSN9@google.com>
 <2ac4f6037719e25e3e8b726def6ece2907d785f0.camel@gmail.com> <CAKH8qBv9vYZsMFivzJ9s=i_w-RakGqECfwXBZfWnDigi6oP1EQ@mail.gmail.com>
In-Reply-To: <CAKH8qBv9vYZsMFivzJ9s=i_w-RakGqECfwXBZfWnDigi6oP1EQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 25 Mar 2023 18:19:41 -0700
Message-ID: <CAADnVQL5O4FaDDOUn0q1urfhquek4dE9nrhWa7mVYwvMhi311A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
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

On Sat, Mar 25, 2023 at 9:16=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> >
> > It was my understanding from the RFC feedback that this "lighter" way
> > is preferable and we already have some tests written like that.
> > Don't have a strong opinion on this topic.
>
> Ack, I'm obviously losing a bunch of context here :-(
> I like coalescing better, but if the original suggestion was to use
> this lighter way, I'll keep that in mind while reviewing.

I still prefer the clean look of the tests, so I've applied this set.

But I'm not going to insist that this is the only style developers
should use moving forward.
Whoever prefers "" style can use it in the future tests.
I find them harder to read, but oh well.

Ed,
the only small nit I've noticed is that the tests are compiled
for both test_progs and test_progs-no_alu32 though they're in asm.
So we're wasting a bit of CI time running them in both flavors.
Not a big deal and maybe not worth fixing, since they're pretty fast.
