Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0136966A5EF
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 23:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjAMWbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 17:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjAMWbY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 17:31:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06A11C16
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 14:31:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ss4so48295098ejb.11
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 14:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mh3FMD1rJshQ9txOQvMplas3g2ct40V9yFZU42Zc0tI=;
        b=PivHwBZBTsxOYcRljf4s6vNPTKNLHPOY4XUdSXsjYjlN5NonBtSVm26md3HTd6xc3d
         onw3zbrXoG9JlKfrSrpqFcIkp9zEhIynUqkODkrJvoTA0SebbYiYYEO8YndKvBu/cHYG
         V1hVDpxLmd+Ip6DDSjT6wpoyLpOG6FGkTGOJOyAIwETafPJY1ksaQWhO9iRmz5BkJuyT
         7mjYbm1CzjeNkBuiiRv1EuuGFKZyAoGRVEWIxZTAFXUFySrEjT1PY/bjsFcq2qZ4CSIl
         j28PTE2dp+F66WDY5zProqIBk3Mm8I6uMTaOcICc3ohK7HDKzAY4Aextne5nuzcz0mjg
         KDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mh3FMD1rJshQ9txOQvMplas3g2ct40V9yFZU42Zc0tI=;
        b=0/EoeJo80qBXljR5dHcHFkMMawRK6AVh+NSeUEwgKqok5vCIiaJaYnyj9KXEY5/6Kv
         o2LLlgBVDl9o74xM6E9mu0FXuEK1pP5jPjAgR6hryg2f1yeBLl2rJve8UpYngKuuJujf
         8eUqCh3Irn0DBJXID9HFn6oN1g89RYdRytFSetNgRY8n0zMweeDvQZiL05b6V3fhy9CA
         rnkuNsQvqMlGDDcZNVCi35ol3sHS7FfSQpSffeokAR78TCUH9XAOcAj9BG1xCYdUJPB4
         bCgJOYDRZ/zsZN8kz6cjDXbWK8CQsuFhFKa5rUwhRkzOe0im9+PWaxnLM8hvwuXlKa+M
         Iamw==
X-Gm-Message-State: AFqh2kofvKLcY4kuJgxQ7HZ6I8IgbeYQIwHrfSuWSCWGpk9va5ADhrAa
        dtRUTEupMvksr0f9VxyQW8v1S1uKXcXqg4P9Ozgr8J3BgJY=
X-Google-Smtp-Source: AMrXdXt3VGnH2eIr+wemhMsCUDH+5GYWHUy9VuTxXlU/mLpEgCkQHGF+AwOheUJFgZ9sE/08NojVzEZAOhrXPEOZITY=
X-Received: by 2002:a17:906:2ccc:b0:7f3:3b2:314f with SMTP id
 r12-20020a1709062ccc00b007f303b2314fmr6547384ejr.115.1673649082026; Fri, 13
 Jan 2023 14:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <CAEf4BzaZuCWq5KrO-NPZjAya1etM4_zCFxWgva4zVDYaWJ89iw@mail.gmail.com>
 <20230112010821.bous4eprkyaikkzu@apollo>
In-Reply-To: <20230112010821.bous4eprkyaikkzu@apollo>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Jan 2023 14:31:08 -0800
Message-ID: <CAEf4BzYOtUPw6cuPcwgPX+Xs=cpqAJq+MWyzHBs0V89Hh8+5+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] Dynptr fixes
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
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

On Wed, Jan 11, 2023 at 5:08 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, Jan 05, 2023 at 04:21:27AM IST, Andrii Nakryiko wrote:
> > On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Happy New Year!
> > >
> > > This is part 2 of https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com.
> > >
> > > Changelog:
> > > ----------
> > > Old v1 -> v1
> > > Old v1: https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com
> > >
> > >  * Allow overwriting dynptr stack slots from dynptr init helpers
> > >  * Fix a bug in alignment check where reg->var_off.value was still not included
> > >  * Address other minor nits
> > >
> > > Kumar Kartikeya Dwivedi (8):
> > >   bpf: Fix state pruning for STACK_DYNPTR stack slots
> > >   bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
> > >   bpf: Fix partial dynptr stack slot reads/writes
> > >   bpf: Allow reinitializing unreferenced dynptr stack slots
> > >   selftests/bpf: Add dynptr pruning tests
> > >   selftests/bpf: Add dynptr var_off tests
> > >   selftests/bpf: Add dynptr partial slot overwrite tests
> > >   selftests/bpf: Add dynptr helper tests
> > >
> >
> > Hey Kumar, thanks for fixes! Left few comments, but I was also
> > wondering if you thought about current is_spilled_reg() usage in the
> > code? It makes an assumption that stack slots can be either a scalar
> > (MISC/ZERO/INVALID) or STACK_SPILL. With STACK_DYNPTR it's not the
> > case anymore, so it feels like we need to audit all the places where
> > we assume stack spill and see if anything should be fixed. Was just
> > wondering if you already looked at this?
> >
>
> I did look at its usage (once again), here are some comments:
>
> For check_stack_read_fixed_off, the else branch for !is_spilled_reg treats
> anything apart from STACK_MISC and STACK_ZERO as an error, so it would include
> STACK_INVALID, STACK_DYNPTR, and your upcoming STACK_ITER.
> For check_stack_read_var_off and its underlying check_stack_range_initialized,
> situation is the same, anything apart from STACK_MISC, STACK_ZERO and
> STACK_SPILL becomes an error.
>
> Coming to check_stack_write_fixed_off and check_stack_write_var_off, they will
> no longer see STACK_DYNPTR, as we destroy all dynptr for the stack slots being
> written to, so it falls back to the handling for the case of STACK_INVALID.
> With your upcoming STACK_ITER I assume dynptr/iter/list_head all such objects on
> the stack will follow consistent lifetime rules so stray writes should lead to
> their destruction in verifier state.
>
> The rest of the cases to me seem to be about checking for spilled reg to be a
> SCALAR_VALUE, and one case in stacksafe which looks ok as well.
>
> Are there any particular cases that you are worried about?

So I did a first quick pass and just changed is_spilled_reg to

+static bool is_stack_slot_special(const struct bpf_stack_state *stack)
+{
+       enum bpf_stack_slot_type type = stack->slot_type[BPF_REG_SIZE - 1];
+
+       switch (type) {
+       case STACK_SPILL:
+       case STACK_DYNPTR:
+       case STACK_ITER:
+               return true;
+       case STACK_INVALID:
+       case STACK_MISC:
+       case STACK_ZERO:
+               return false;
+       default:
+               WARN_ONCE(1, "unknown stack slot type %d\n", type);
+               return true;
+       }
+}
+

Which resulted in one or two tests failing due to the wrong verifier
message. I haven't spent much time debugging this and I still have a
few TODOs in the code to double-check everything in regards to this
change.

Thanks for the above analysis, I'll come back to it when I get to work
on my code again.


>
> > >  kernel/bpf/verifier.c                         | 243 ++++++++++++++++--
> > >  .../bpf/prog_tests/kfunc_dynptr_param.c       |   2 +-
> > >  .../testing/selftests/bpf/progs/dynptr_fail.c |  68 ++++-
> > >  tools/testing/selftests/bpf/verifier/dynptr.c | 182 +++++++++++++
> > >  4 files changed, 464 insertions(+), 31 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/verifier/dynptr.c
> > >
> > >
> > > base-commit: bb5747cfbc4b7fe29621ca6cd4a695d2723bf2e8
> > > --
> > > 2.39.0
> > >
