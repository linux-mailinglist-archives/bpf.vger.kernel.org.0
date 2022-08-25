Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759625A1947
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 21:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiHYTCZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 15:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbiHYTCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 15:02:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B5AA4046
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 12:02:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w20so11552523edd.10
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tP8yI3rqwDjMWGFpKX3Qt14ti3qpf7TSg9CfNIXmIks=;
        b=pKnKhE+SW/ldxPhjprX++7M9ffA0BkbriSaoqSlMND9onkRw7T/eXMKu/eLk7TQoHb
         6T21CdvdYZQ8f+00SUpHi68/l1a4dKaJA/XeLK28qAqOnhKOkISDlCaIjy39zQoFfRJz
         BYNQZlYEV6ehM4LChouKwAPW+Vsex/6vDAugv8yBI/Rx+DNfXsG2q6qhw7UengyELtff
         ZcTI6aBkIbqyyTnESNqikIfq6omMCa1aLt8A52vuKJ0cQIneXkDLSGmrWkgtftRB7ADW
         lIftkwUnOXAErVfW5ewIYXmTYwDHh62WgeKUe2JrD90hDusIaROCSeLWYOnAF23bqpD/
         dftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tP8yI3rqwDjMWGFpKX3Qt14ti3qpf7TSg9CfNIXmIks=;
        b=mFipEJT+/JToBR6NbpQ8ntZIQ3MSw1trENOphWHWON0HJ3uNTPUqiEdpT08XSh87Fb
         0YBMzYCQOiOyXttSUNF1pK+hzQJ9V1V7ZTByS8ofsKAjWqUa1NinZMzxdHbITyB1NFRx
         aQYiDBW3aB5q2+KKZmBQOZKtVqB3hn3y+qHgWs9aISoDjIXhZ10J/AvQXjGYfLfNERrq
         A47J31AibJ2f5X4aadziTIq5MqH/Ny9//poLOP2upCXaPGgsqjZwRBG4KDKGAqHIsvD9
         Vr/CNJExZVLhAwiD3v4CQ66K8kJuQudUGJUpyahiURYbm5Rip7djf2TsAsBIyAwSv8Pg
         WviA==
X-Gm-Message-State: ACgBeo1ZZLKj6UK+62jYDhNqzQ0up53o/OuZpHlqfMLYpxUmHMnurGiI
        BJUOSXUYf+IUKmedermdx79laaHoEJ+uFn4+QkIGMXetgwU=
X-Google-Smtp-Source: AA6agR7PTxPL540IpIabVGErD5iAT/Ks3rvs/0ygTfGi89EqqGHocVL1Xhk+XWADv+hsQkZpiKW+6LEQXBOtzcj4gX8=
X-Received: by 2002:aa7:cad7:0:b0:446:5d20:6708 with SMTP id
 l23-20020aa7cad7000000b004465d206708mr4248505edt.224.1661454142403; Thu, 25
 Aug 2022 12:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220823185300.406-1-memxor@gmail.com>
In-Reply-To: <20220823185300.406-1-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 12:02:11 -0700
Message-ID: <CAEf4BzbhScSmzeAOw76Hisi+XPTY5bua1O5XUpJE+NFPgxbBew@mail.gmail.com>
Subject: Re: [PATCH bpf v1 0/2] Fix incorrect pruning for ARG_CONST_ALLOC_SIZE_OR_ZERO
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Tue, Aug 23, 2022 at 11:53 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> A fix for a missing mark_chain_precision call that leads to eager pruning and
> loading of invalid programs when the more permissive case is in the straight
> line exploration. Please see the commit log for details, and selftest for an
> example.
>
> Kumar Kartikeya Dwivedi (2):
>   bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO
>   selftests/bpf: Add regression test for pruning fix
>
>  kernel/bpf/verifier.c                         |  3 +++
>  .../testing/selftests/bpf/verifier/precise.c  | 25 +++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> --
> 2.34.1
>


Makes sense and LGTM. Thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>
