Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCBD5B81BD
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 09:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiINHDW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 03:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiINHDW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 03:03:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880C553013
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 00:03:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l6so7469515ilk.13
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 00:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XAKLckvt2TXJNshuzlwrPNB2vVdgm9+OAr5spnIlnQ4=;
        b=WmcObu18Ku/9s/Rz322hL6OSK2fGoxXjIKfT47IfWtfijWh+8GCQj3cfWFamyBmU9d
         ++Y3NO9YN2LykAmtQ/c+nba9qTwco2s4Udkr+NFcUU6Tjx2u6Xaw1+DQ3Ml8Qou8s/JJ
         HNlznH2jvvb3mi72HZ5b5PziGGVtnF0V0xlAsgNJeqAXnNo8dRAWbu4l6AErWrK1Yeo1
         us0xI3lxYCDw5dbH9FqhR024rg52zro16/Fo4od2YukY2PWgCSJ5U6HkJK5RA8zaju1s
         yLuGbh/nvm6wgJhXAEKJF4tCll45afGJ/3o5qxa1AGHRXRr8O8nN4HXA9dqnfB5+pQPY
         xqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XAKLckvt2TXJNshuzlwrPNB2vVdgm9+OAr5spnIlnQ4=;
        b=OQivccMPB87N4N73Xv8hZsreb7YD9+KXun2aA3XacNUwvXc/HGAnHHosCr8oUZap8Y
         vTMZfnBEeQ0zMYR2XEoSuYwxEPyabEJBRXLt8xGk/DY1nZcBchGVtZyoy/zyfX5oTlLc
         fR5nNI2Dkea1OE3JeQTPSZ2Rz5PPZeT/I1RXT5vl9+2pNRjtSRTNrt0ldhsAHvgz91k1
         bQkA8d05e7o0+wI63jFFwVCuMy2nu92W/lYmOwT7IVu3cs7IvPA2z+kw7UJFtjiUVZ68
         BcaCqc1o1fZwTssoXzqGgl3JVqt4ThUnqY2bUr9GsSsbBZKq7s8swgZ76iIxIfUtjgcX
         heuA==
X-Gm-Message-State: ACgBeo2jgHTWuCEWQE980ou1sriZh+AGr+wC8dcRKgvH/Ygd4dEnxQCL
        B46lcetqZhMHD8Vh1+/LFS4UvnasN2hI8OXNZyM=
X-Google-Smtp-Source: AA6agR4/eS4VLvgZVsDQPy7wg1wDypuokjtA4dLJnQmXaWsgolAM4x+TAo0bxS43jlFojx/L6ClZW/8jB1nma6KvIP0=
X-Received: by 2002:a05:6e02:1d0b:b0:2eb:73fc:2235 with SMTP id
 i11-20020a056e021d0b00b002eb73fc2235mr14220368ila.164.1663138999795; Wed, 14
 Sep 2022 00:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220912154544.1398199-1-davemarchevsky@fb.com>
In-Reply-To: <20220912154544.1398199-1-davemarchevsky@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 14 Sep 2022 09:02:43 +0200
Message-ID: <CAP01T76s-GRkGyhOD0MNbZfOg=7S479rATfREWj7--4MR77K-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add verifier check for BPF_PTR_POISON
 retval and arg
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 12 Sept 2022 at 17:45, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> BPF_PTR_POISON was added in commit c0a5a21c25f37 ("bpf: Allow storing
> referenced kptr in map") to denote a bpf_func_proto btf_id which the
> verifier will replace with a dynamically-determined btf_id at verification
> time.
>
> This patch adds verifier 'poison' functionality to BPF_PTR_POISON in
> order to prepare for expanded use of the value to poison ret- and
> arg-btf_id in ongoing work, namely rbtree and linked list patchsets
> [0, 1]. Specifically, when the verifier checks helper calls, it assumes
> that BPF_PTR_POISON'ed ret type will be replaced with a valid type before
> - or in lieu of - the default ret_btf_id logic. Similarly for arg btf_id.
>
> If poisoned btf_id reaches default handling block for either, consider
> this a verifier internal error and fail verification. Otherwise a helper
> w/ poisoned btf_id but no verifier logic replacing the type will cause a
> crash as the invalid pointer is dereferenced.
>
> Also move BPF_PTR_POISON to existing include/linux/posion.h header and
> remove unnecessary shift.
>
>   [0]: lore.kernel.org/bpf/20220830172759.4069786-1-davemarchevsky@fb.com
>   [1]: lore.kernel.org/bpf/20220904204145.3089-1-memxor@gmail.com
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
