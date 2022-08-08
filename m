Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C07658CE0B
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 20:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiHHSyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 14:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHHSyO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 14:54:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400A10B5
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 11:54:13 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l24so7827756ion.13
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Gu4APyIQFRbZfzkJ5je/Azih0088hFBE2H/T3xQmeVw=;
        b=k22v6YAS3jtcZ2sgAscRT9pweYjU4LchFUJyhDk6dl+ke6QpWdYU3x0LvDmka68xlD
         YREfyhdwJbbjUZalbUwYaOGdJ8qrTmME+uP/iQWdS5csQdJTm6f19fwYkfYI6ev9XMlK
         0unHIiEZi8jOK0h9boXmaHP55OIKoRK7gmPG+bMoPjfSbzzCrN+h+Aoy4iJkhMAfZLAP
         4kTa7YSjVKsF1GZcsewj4OLfOYzN1PC4lTUD95mHfzWxPRetoUftipNs+VpBYb001041
         VF2rTrZPFBkXNLJc5XsgqhV5Ll/v7yu3c8BErHJ6wXArKnrqehjo+J+HS/3QAkwALPiN
         sfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Gu4APyIQFRbZfzkJ5je/Azih0088hFBE2H/T3xQmeVw=;
        b=oxPaoLDIqp/EvpfBPQVjDByz2swE2reuQUbJlSSJvgVuGLeyU1VDFGvXBHbJk63qS4
         w82js/6L5e3TyobDHWsPFsTBnEAnfgmOiuImln9ZIVK/CrvQT/PnCAyjX2bj4Qz+eepI
         23Qq99lpvG8z5ObZpdTWKa1+1SoSqtcVzIjVV3W1zIiaqFhJ2jPML6eWBr1+Hb05kH4x
         lPYabIekV5Xq0LBhM7OsYMwhJMq1wDwYk7JxfHNipZXkkuw26zLZsiVuKa3RaGsjYstz
         v4/Hmo55pAfiltajFY4S9Tc0w1+XHW0vT9Ti/QYaCf8rRFIcF+YEcf+4ajJmItj3ndRL
         UtpQ==
X-Gm-Message-State: ACgBeo2eoGU7iDF92RJIOolyH+9JKAuyUXPa3/4RXdDZ8FtYjdFeFFiY
        dTykNLPePmb5g/egExPu5x4VpurYchLzEFZOvGw=
X-Google-Smtp-Source: AA6agR5UREtFcHwrTn5qKFyYUr3kSihdeA6wzekuAykF40V20SqrNYwvJ4HgcvE6SorZWMxdvz/tgJuG383xb8d7eDI=
X-Received: by 2002:a05:6638:210e:b0:343:1748:910 with SMTP id
 n14-20020a056638210e00b0034317480910mr1881804jaj.116.1659984852732; Mon, 08
 Aug 2022 11:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220808171559.3251090-1-davemarchevsky@fb.com>
In-Reply-To: <20220808171559.3251090-1-davemarchevsky@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 8 Aug 2022 20:53:33 +0200
Message-ID: <CAP01T77pj6nkH=JdBJ3vvWz4gsZO0rejTobbT-hc=MFNfpmCpg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 bpf-next] bpf: Cleanup check_refcount_ok
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
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

On Mon, 8 Aug 2022 at 19:16, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Discussion around a recently-submitted patch provided historical
> context for check_refcount_ok [0]. Specifically, the function and its
> helpers - may_be_acquire_function and arg_type_may_be_refcounted -
> predate the OBJ_RELEASE type flag and the addition of many more helpers
> with acquire/release semantics.
>
> The purpose of check_refcount_ok is to ensure:
>   1) Helper doesn't have multiple uses of return reg's ref_obj_id
>   2) Helper with release semantics only has one arg needing to be
>   released, since that's tracked using meta->ref_obj_id
>
> With current verifier, it's safe to remove check_refcount_ok and its
> helpers. Since addition of OBJ_RELEASE type flag, case 2) has been
> handled by the arg_type_is_release check in check_func_arg. To ensure
> case 1) won't result in verifier silently prioritizing one use of
> ref_obj_id, this patch adds a helper_multiple_ref_obj_use check which
> fails loudly if a helper passes > 1 test for use of ref_obj_id.
>
>   [0]: lore.kernel.org/bpf/20220713234529.4154673-1-davemarchevsky@fb.com
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Acked-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
