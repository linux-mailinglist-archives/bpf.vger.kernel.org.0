Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6316E1B25
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 06:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDNElf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 00:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNEle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 00:41:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6C4697
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 21:41:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so2448887a12.3
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 21:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681447290; x=1684039290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edffEn4AH9sYjpMYtxjKzE2Nwhbh4DHkh7/h5oQUc2c=;
        b=kMPQ529SbfttGrCEG+VSOL0klF6xe8uFjoBts0nKleQ7/zWmHOeDXeM0YpKfePTI9E
         PDHm83mnmfxRqh3iMvAHsEYEwo01I20LS1xz+wQq08jzoXJOoL4aJhw/f95UachnpCUC
         M+mOt+fc1J3tLu+BQst6eHh/bNJexq+tgTbjb/jkZ5lvUT4qYwLp5QLSQF9CImUbwyYH
         gjUUa3Dp3pY5xeVu8OeX66GiBnBNt3kk0BZCnvIMX5iN0HqsGJ8ZE45d2yuxTZUZyBJ2
         Zn48xaIUDPF1P/Fd2tnjRf5b5fpa5d/h3VngSSIH2Ww6TSR/qofE035+xzF8T8z6WOzM
         wXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681447290; x=1684039290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edffEn4AH9sYjpMYtxjKzE2Nwhbh4DHkh7/h5oQUc2c=;
        b=NPT1ZW7Gy5fzhf/GkysBq4or0bgDcB670Qe0BnE2sdhgfVhOBhHt8/gRJRN2DTU0Hs
         biZRpXA9ZKHJBIkJgg0PVsx3jdvZMJasvWS7KFHxub8wY9h2CZguA7KpzaM4uPOgW/Qb
         v6wjW/FWjsqkKtu5dWwl8HUM5GYkkzTrsYJHTCYw6IDTtdVXmGB1WTGLnaD7tm69/mJ2
         p6nqvGvQ+BD2p5qHv57VddSVgr/6QmGPfDucjXNKhvRFzdIETlN3UYvi/p0EsSD61bw3
         OU2bl21LBIvEBA9uQmDyrodXBJlT0QMeI34+Pv1jE/t0+FoAY6kL/OmCgEpYgAjB7nlP
         Z5jA==
X-Gm-Message-State: AAQBX9c81mXyqeSNtguMwHJ7vseAkpp1IcG5Lf5llPxBCmzhoCB1lH6y
        PJxzlA+CQBc+Cmgt0qb6C3FghI8EIenoQu9IYj8=
X-Google-Smtp-Source: AKy350YDHVo0Y5rbGmlir3xffJmNNyqzqtfH31DO3dfDcD0DK6MvKQcY5WUMDWCCNNX5Ct/ltJx2ZgG7PIwD3WNHlPw=
X-Received: by 2002:a50:9e45:0:b0:504:efc0:9f97 with SMTP id
 z63-20020a509e45000000b00504efc09f97mr2445274ede.3.1681447289538; Thu, 13 Apr
 2023 21:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230412230632.885985-1-iii@linux.ibm.com> <ZDhUgMyQHiNxDB8l@krava>
In-Reply-To: <ZDhUgMyQHiNxDB8l@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 13 Apr 2023 21:41:18 -0700
Message-ID: <CAADnVQ+5prESGMfK_QiGJbQUOL2_z9tF8ngdOiYURM39haMPxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7] bpf: Support 64-bit pointers to kfuncs
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 12:14=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Thu, Apr 13, 2023 at 01:06:32AM +0200, Ilya Leoshkevich wrote:
> > test_ksyms_module fails to emit a kfunc call targeting a module on
> > s390x, because the verifier stores the difference between kfunc
> > address and __bpf_call_base in bpf_insn.imm, which is s32, and modules
> > are roughly (1 << 42) bytes away from the kernel on s390x.
> >
> > Fix by keeping BTF id in bpf_insn.imm for BPF_PSEUDO_KFUNC_CALLs,
> > and storing the absolute address in bpf_kfunc_desc.
> >
> > Introduce bpf_jit_supports_far_kfunc_call() in order to limit this new
> > behavior to the s390x JIT. Otherwise other JITs need to be modified,
> > which is not desired.
> >
> > Introduce bpf_get_kfunc_addr() instead of exposing both
> > find_kfunc_desc() and struct bpf_kfunc_desc.
> >
> > In addition to sorting kfuncs by imm, also sort them by offset, in
> > order to handle conflicting imms from different modules. Do this on
> > all architectures in order to simplify code.
> >
> > Factor out resolving specialized kfuncs (XPD and dynptr) from
> > fixup_kfunc_call(). This was required in the first place, because
> > fixup_kfunc_call() uses find_kfunc_desc(), which returns a const
> > pointer, so it's not possible to modify kfunc addr without stripping
> > const, which is not nice. It also removes repetition of code like:
> >
> >       if (bpf_jit_supports_far_kfunc_call())
> >               desc->addr =3D func;
> >       else
> >               insn->imm =3D BPF_CALL_IMM(func);
> >
> > and separates kfunc_desc_tab fixups from kfunc_call fixups.
> >
> > Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Applied.
Should be able to delete a few entries from DENYLIST.s390x, right?
