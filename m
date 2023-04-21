Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC46EA270
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 05:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjDUDql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 23:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDUDqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 23:46:40 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C4DE69
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 20:46:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b992ed878ebso500529276.0
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 20:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682048798; x=1684640798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLb6j6Jbecj/k1AahEPbNOUA0V64hSK8KLiUkqWelEM=;
        b=AYvS6z1asGYTs+8l7+uXdUABw/V9NGF+Nu/qpdCriK5Wu/4vtOHPnLnTQ4wEfJb5MM
         fA+Ak8oiOYP49jQyGUCi9O1pygjSN2lzuTaTXBPvDdDOVvXeDBfgJa/42QDmnkQV0qNc
         250t1rxANo4dfFiRfplVL6jp0OwsanrJ2q7hpucdy05er1Rb98iLoPwIb89wjtgS2qUA
         b86osJNJkZGw8dKw3kvqUmb2G/nhZXPf9Zw8dtqwr/ZtLZAf1kN52Wu7BAaANJZbt9Rx
         FyjRheojB1BWCID+5TztNX40RwA5HZ1kv9nWeG5b4BdEJQsRhi0IkCyhxNpJBDu9l9fF
         VFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682048798; x=1684640798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLb6j6Jbecj/k1AahEPbNOUA0V64hSK8KLiUkqWelEM=;
        b=aDKTu8nMw9tdJSILrWoQAVoBJ6rwkOtYRCPM+rRwWHg1bashkphgvidkJUkK32YaHv
         yQPyAboFyLWE5ozrtfZh1GhHDXfY3gWftQ62innZUubCVAyIcDIZ4uTmMlr4tvGF3B/R
         YHlanZiQkJmBx1ftZAlZXuPc5RmYsF/AH5bvb3N2lZsjUYMngWkzTTyABJuPaQ3KWNu+
         fiQ/D+oJonas28ihvMLx9ukUw7ifUDRsuU8ZJOsm4fAqWB2y38BAkVDJZbidEq88/wff
         oYagrHoWiI4/rlcr2ajPNvJ313VQj08Kxq1+fq8sxelGsRk3mK5a/NSvO5IwiVKiUx/e
         ryGQ==
X-Gm-Message-State: AAQBX9fzY3Pf1o48vgiBS2NxhS6urJVKsUwBAPMkRfefRqDYZ+ItQTQ4
        q9OQHRuu9lzv28nC75ITXo6oy/OYYAMORR0vStQ=
X-Google-Smtp-Source: AKy350YXO70h6Xai9E0lwL6LGa9rMgu9THuXvMoiwdcUFfPNxgQX1Ev3eblfkHERbV8f8bJ2bMsjAA4fwDuNgC3Liic=
X-Received: by 2002:a05:690c:444:b0:54f:dc41:8edf with SMTP id
 bj4-20020a05690c044400b0054fdc418edfmr872118ywb.2.1682048798308; Thu, 20 Apr
 2023 20:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com> <20230420183809.hgzvfn627vc3zro4@MacBook-Pro-6.local>
In-Reply-To: <20230420183809.hgzvfn627vc3zro4@MacBook-Pro-6.local>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 20 Apr 2023 20:46:27 -0700
Message-ID: <CAJnrk1Z_FQatT2-utcMR0NjwQt-3RWv6Vbr871fX8xCHE-buDA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
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

On Thu, Apr 20, 2023 at 11:38=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 20, 2023 at 12:14:10AM -0700, Joanne Koong wrote:
> >       return obj;
> > @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_=
NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>
> I've missed this earlier.
> Shouldn't we change all the existing dynptr kfuncs to be KF_TRUSTED_ARGS?
> Otherwise when people start passing bpf_dynptr-s from kernel code
> (like fuse-bpf is planning to do)
> the bpf prog might get vanilla ptr_to_btf_id to bpf_dynptr_kern.
> It's probably not possible right now, so not a high-pri issue, but still.
> Or something in the verifier makes sure that dynptr-s are all trusted?

In my understanding, the checks the verifier enforces for
KF_TRUSTED_ARGS are that the reg->offset is 0 and the reg may not be
null. The verifier logic does this for dynptrs currently, it enforces
that reg->offset is 0 (in stack_slot_obj_get_spi()) and that the
reg->type is PTR_TO_STACK or CONST_PTR_TO_DYNPTR (in
check_kfunc_args() for KF_ARG_PTR_TO_DYNPTR case). But maybe it's a
good idea to add the KF_TRUSTED_ARGS flag anyways in case more safety
checks are added to KF_TRUSTED_ARGS in the future?
