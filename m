Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F19608398
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 04:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJVC1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 22:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJVC0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 22:26:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C8D41D16
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 19:26:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g27so12214969edf.11
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hg/ZJ+LMq3lHhWfCSxcql+bKb3eB+QldEPZAw9ueEGY=;
        b=B6xNExvURScOrnPRdv/GMqA9u0DUTyU+5UCkIXJrWqlDq0xWmwY4M9Eg9OsJA8fDVH
         x2wW/e+PNoQiQbEnaKhhUUaLPr5H2394rwhlOJl4l6a7k/60esiDGY7Sy2zgx2YiEwsN
         2aPxouYgMG2MtTirtMhpI6M/5vwT1I3tVfyqgkbfOi9YT55l4Mehy9+882SwuCM+L+Lv
         O5Iod76tn9Q+dTeZ9OGlfbe6giCUv6yMy/RuL2JzuBKNRsa80m8IqPd9gf45ErVZ48un
         jA8xsULjT2mi2gPVxLhoiP9M2S15GExiMrtxBeIdBQGDopodCxokjYvUDxbIwStDIeu7
         j/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hg/ZJ+LMq3lHhWfCSxcql+bKb3eB+QldEPZAw9ueEGY=;
        b=k6cKN48lvqaSVMpyOUxBEw7ydQn7gZMn4kqukCvlfWcnf1t/nZLV7xkH8PIJr53lhN
         nTPPolCXK3ImkYUocCVARw6w2p3RvOtZUzfySC2qE9va0U3ulsforEd7fn+P70pGyuGJ
         wzY76ZdZu/rppcBsWSzzQ25cA7QseOacjmvuaszuz0kPdf2aGrZhajK+aRGc31S5BAea
         QIOptnCT9HFsk2oNzpnt6nQRBy0G1CHzXcACN4OsM5TnyOTgAWAtQATdwA2Gj54TTu4z
         OPryBqOQhkKHbf0r3LIrqXf3uiNTx/QhuBTmC+/7qRNkninT2sXfkqoQEu2B7DkXNEzt
         K3EQ==
X-Gm-Message-State: ACrzQf1dtNjtsWUqCCNyuFGIWquaa0Nn9+G3DFvy9JV0bcrn0NPcj5QD
        DsO9xLU7hM8GxM+d/1c0l8dWNNbl9ol8+hqDdl4=
X-Google-Smtp-Source: AMsMyM6bUxi5L4nqz2LmvzXtDMW9vqn3vPBhWZdmWbiKrbIILvtTsbveLooOX/RUTJursk9hsYjTWojP+aMnnopRQqM=
X-Received: by 2002:aa7:c6c1:0:b0:460:f684:901a with SMTP id
 b1-20020aa7c6c1000000b00460f684901amr9592823eds.6.1666405592808; Fri, 21 Oct
 2022 19:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221020160721.4030492-1-davemarchevsky@fb.com>
 <20221020160721.4030492-2-davemarchevsky@fb.com> <CAEf4BzYK939fgyc3LwNvoz3vPk2avyskP_3wRZO344irubXPtg@mail.gmail.com>
In-Reply-To: <CAEf4BzYK939fgyc3LwNvoz3vPk2avyskP_3wRZO344irubXPtg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Oct 2022 19:26:21 -0700
Message-ID: <CAADnVQ+wzEV=sYVSY9sQjh0VW=3gXOeyh1kVAnzpvYpfm-KStg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: Consider all mem_types compatible
 for map_{key,value} args
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Fri, Oct 21, 2022 at 4:04 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 20, 2022 at 9:07 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > After the previous patch, which added PTR_TO_MEM | MEM_ALLOC type
> > map_key_value_types, the only difference between map_key_value_types and
> > mem_types sets is PTR_TO_BUF and PTR_TO_MEM, which are in the latter set
> > but not the former.
> >
> > Helpers which expect ARG_PTR_TO_MAP_KEY or ARG_PTR_TO_MAP_VALUE
> > already effectively expect a valid blob of arbitrary memory that isn't
> > necessarily explicitly associated with a map. When validating a
> > PTR_TO_MAP_{KEY,VALUE} arg, the verifier expects meta->map_ptr to have
> > already been set, either by an earlier ARG_CONST_MAP_PTR arg, or custom
> > logic like that in process_timer_func or process_kptr_func.
> >
> > So let's get rid of map_key_value_types and just use mem_types for those
> > args.
> >
> > This has the effect of adding PTR_TO_BUF and PTR_TO_MEM to the set of
> > compatible types for ARG_PTR_TO_MAP_KEY and ARG_PTR_TO_MAP_VALUE.
> >
> > PTR_TO_BUF is used by various bpf_iter implementations to represent a
> > chunk of valid r/w memory in ctx args for iter prog.
> >
> > PTR_TO_MEM is used by networking, tracing, and ringbuf helpers to
> > represent a chunk of valid memory. The PTR_TO_MEM | MEM_ALLOC
> > type added in previous commmit is specific to ringbuf helpers.
>
> typo: s/commmit/commit/ (but not worth reposting just to fix this)

Patched it up while applying.
