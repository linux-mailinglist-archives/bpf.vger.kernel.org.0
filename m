Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25D14C9087
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 17:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiCAQjS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 11:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiCAQjS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 11:39:18 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EC13F89A
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 08:38:34 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id w7so17083721qvr.3
        for <bpf@vger.kernel.org>; Tue, 01 Mar 2022 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oyHDJPXz4MUJgBElW4MaL2dWxxSt5ih3fxmiK5Gs50=;
        b=biU6fsA9UrmFW3BIfaYv5RzawE4Tvt4q/tuJ4G/JQzTVzsvnQkkFS85DkakG9eiGTJ
         nEcbJvECd4Cha/qgxSiVok0JT6iW0D25p0NyClDMHEu8jgkoMVJk/5XEPiiZIu0vAB44
         z/D5vXpGjby5sIB0dKN9jnm8NzVL8I305WeIf791sBTbYhguhUT9ESBrbMJq+fk1l0vx
         N302M1QWTbmMb49UP8I/VrF37DAe8hQKmIH0qOsKZzkvG9CYmbY2Ir3b82MMAgJUQQz3
         Km6BV7bCnyaUhQROiLxoujwvWrzDPw1KcIFMEHlt8VhJxJ1Z2zzmbk7EPVbS6bHBlpBC
         LltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oyHDJPXz4MUJgBElW4MaL2dWxxSt5ih3fxmiK5Gs50=;
        b=m23Nn4qdTy7yBA4QU+eXrc2NG599cFo6RPL5TgLEofnKOMHfzGyDtFP7Bg+JwlZPJk
         WCw5kigwprThWc27+KUEALspHNve5zA/UMXAuQs7bT5ZfZ9tIrhL6IRiWm84DxUVpZNs
         E5wgnh+d+OFR3K3piAPl4n+TCnzMn1Ijxk26yrwlJtqsOgIR2wRkJaZZoEzWUXS4RkGB
         59N0HKixwfDXhKv08TNc+anXTXb+rnn7upgFOkRBvL6F5IN0SYaloTs0xs7nlUZFkA3X
         Lw6YrTO0a9VP2wApUWGxsH3GV0a9utlSwBxt8PkVwIB0CvFtocJr62og4bjhlDwZselr
         5zXw==
X-Gm-Message-State: AOAM531wNy1uxKEUlPriLEfsFuaJy74QVZaOGHXsPRNixDbQpK8Ke7WB
        /UPFNYteY5Ivdn3wcshntSEtH8x/5fwMg7ujU0jjzw==
X-Google-Smtp-Source: ABdhPJwQugZDd7FBcl55Uiy4B5juwSw6Er9YBu2Rdfc92MOO/fr+SVNg95zVcDNOFOwnICrqENeY4DIQ3xHg0BazFSk=
X-Received: by 2002:a05:6214:d42:b0:431:d89a:66b6 with SMTP id
 2-20020a0562140d4200b00431d89a66b6mr18251002qvr.58.1646152713708; Tue, 01 Mar
 2022 08:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20220228232332.458871-1-sdf@google.com> <6a6333da-f282-09d2-fd2d-cb67e33a07a1@iogearbox.net>
In-Reply-To: <6a6333da-f282-09d2-fd2d-cb67e33a07a1@iogearbox.net>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 1 Mar 2022 08:38:22 -0800
Message-ID: <CAKH8qBuPws+aYA-+sbqA2-NEPXNjmmHVGfU99Xb1LD7LomAa3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: test_run: Fix overflow in xdp frags bpf_test_finish
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 1, 2022 at 8:33 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 3/1/22 12:23 AM, Stanislav Fomichev wrote:
> > Syzkaller reports another issue:
> > WARNING: CPU: 0 PID: 10775 at include/linux/thread_info.h:230
> > check_copy_size include/linux/thread_info.h:230 [inline]
> > WARNING: CPU: 0 PID: 10775 at include/linux/thread_info.h:230
> > copy_to_user include/linux/uaccess.h:199 [inline]
> > WARNING: CPU: 0 PID: 10775 at include/linux/thread_info.h:230
> > bpf_test_finish.isra.0+0x4b2/0x680 net/bpf/test_run.c:171
> >
> > This can happen when the userspace buffer is smaller than head+frags.
> > Return ENOSPC in this case.
> >
> > Fixes: 7855e0db150a ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
> > Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> Do we have a Reported-by tag for syzkaller so it can match against its report?

Oops, sorry, totally forgot:

Reported-by: syzbot+5f81df6205ecbbc56ab5@syzkaller.appspotmail.com
