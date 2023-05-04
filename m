Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA66F6FEE
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjEDQ2Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEDQ2O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 12:28:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E619A2
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 09:28:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f13dafd5dcso830499e87.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683217690; x=1685809690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbsuwMwOV2XWYglpS75JTuS2irCkF7NRBTxup2bYrqc=;
        b=AsYcbqI6bOXGTqCNxI7IXPin/bGjLQsZZ1G7ryGrXMdMh97b15V9POeT+hcwF7LOjN
         7U3Srj/nWpb48EAH/rxtPgMmsZThPW2Smsppp8ekIyjXYlJcHdsERVMEDdGfNNKP8WB+
         SfZDYyKCEF8nVHSWy61+p2+6Fb23klMJbYoUZ0zq+yEeXt/9uwRIwv0ImovrLXMv9Sli
         0Y1cLeU+HsebKyIjK4+1xwcJpjPnHgqQr/eBgiLRA+aBiWQYSoOGwKaiq9Bnw+Pw5fKm
         gyixybhPFOk0ywW4wswnkr0mqGybP76KHkdQW+YYzg7PhAUyMZDmzy0r7Y/adWUxDc6M
         mKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683217690; x=1685809690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbsuwMwOV2XWYglpS75JTuS2irCkF7NRBTxup2bYrqc=;
        b=U4i8SeyxAwS9kP3UC+SVJzG5Ko+87Wg3YIp9snuz8LZY+NOyt4rPA5yIFVr31kJ4Cm
         fX07OjO/FTqrPnx/JN460YR8svZahornUXBO35lYnjF8KFlLu6SQwxu9e1yCjUxDTi6R
         luV4uZ6zqJGXVLqwgiAoXE9OwkHfwgswXwnc/NcwOXY+/xWrJI7KDFwJ5K7zIVKVrAeQ
         dzkeBYcsihiMo35NxlXWV/4BjHTYREDSAZ+IeIcgtJrzcrCIfpLZEhH+6RpREI1nrIUN
         Atg0jCOih6UqyT8VYTCP818TamSVSOrujoow8Mxn84olH2E71P2Kz7a2GDDQvfRPtUIx
         r50A==
X-Gm-Message-State: AC+VfDyTo2zqjleCs1UF4QrulyJQr97ec6dMmsP82couIlGClubTroLd
        0IvQjY4nUSsGxtI329vjy87qC2kAmZ4oOALWeWY=
X-Google-Smtp-Source: ACHHUZ5N0luavyRGIuQEK/stH29BzJ1dvJqlOCDkVMdfz/XiSpSZzHotAg9cGIfIca24cNKqcxmNFbKHzjSqFgnnuLY=
X-Received: by 2002:ac2:41ca:0:b0:4f1:3797:58d7 with SMTP id
 d10-20020ac241ca000000b004f1379758d7mr1686189lfi.20.1683217690187; Thu, 04
 May 2023 09:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-7-andrii@kernel.org>
 <20230504160438.l7kkq6eexeudchrk@MacBook-Pro-6.local>
In-Reply-To: <20230504160438.l7kkq6eexeudchrk@MacBook-Pro-6.local>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 May 2023 09:27:58 -0700
Message-ID: <CAADnVQJz17WZ_z7VxJE=w89ad0LBuxu_72Xz4WZZnHoTx0V7PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/10] bpf: fix propagate_precision() logic for
 inner frames
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
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

On Thu, May 4, 2023 at 9:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 25, 2023 at 04:49:07PM -0700, Andrii Nakryiko wrote:
> > +
> > +     err =3D mark_chain_precision_batch(env, old->curframe);
>
> I think I'm sort-of starting to get it, but
> above should be env->cur_state->curframe instead of old->curframe, no?
> mark_chain_precision_batch will be using branch history of current frame.
> __mark_chain_precision() always operates on
>   struct bpf_verifier_state *st =3D env->cur_state;

wait. patch 5 made __mark_chain_precision() to ignore 'frame' argument.
Why did you keep it in mark_chain_precision_batch() and pass it here?
