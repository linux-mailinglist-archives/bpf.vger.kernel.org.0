Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F55664CFA1
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiLNSnT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 13:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbiLNSnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 13:43:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620055F43
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 10:43:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so105125pjj.4
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 10:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIokqZCgEMdj0ytQStFSnN5jaYBiTed3UCIS3eVNBfA=;
        b=gLWRdlCX9mg3oyQ6/rIJXYfrA7exYn4tKcanUdPKJGB4upxn+CdGiHjzfoz5Ry0ya0
         iPtp/io0GR0iNFkzz2AIny+WBIxkBoucmCx4CNbxcawYmg5zHGsRT8yxewGHS13vwg1s
         1n4rArbx+l9EHeixCfjZNtJDh0nPKX3NAin+R426WiL4OYH4sfbfCzIhWh3kf0WFnJ4v
         K/kdLb5Wm/nrXG8vnUlTcB22GJNDOrVnJnPcordrCvUIAFc8Oy7rNZGM5YCNJWNnltk1
         hgYz3lC5npJWx3m+PLDU4wes7qcVPrTm8B5cBT+zqOT8JuZEqqRGOu27swTV+y/dAGjw
         jtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIokqZCgEMdj0ytQStFSnN5jaYBiTed3UCIS3eVNBfA=;
        b=LLBOHL7owqZBg/RESf5gloqeLsuJekc0kN8DD4ss17x1Qy+Wi7wPzY0wI0P0IaMzpX
         xpkov74ZSEEOheu9khUgXcf6VC9BxrQfXyQz4zwuLrk17gNx8U2ig4WT09iEcFxeI+7t
         Lu7ZK6W5hW+rN914JnqLdEDeAdGBy7OphTZYXjippTldIpd77bfQopsbnDAl6UFKl3nN
         8th1JarfSUezbuinnoJUxxQZOs73AYpaBL+YUxpSSFTJQHEke+0iQN3UThZ6FBsA5Q6z
         9fJYdu3PUOX+oTAKOmq+hxcnwj7O3myHjRvL35mgr9vzjaKBx/3udR3f9dyrnhfUwIoF
         0qRg==
X-Gm-Message-State: AFqh2kr2askw5M9ruoN13egppKvcFyFqSgi9MoQDTqy8eeff6nEYAmnh
        fzl++niw0wJviZ+Dvr1QNyB3RrLgSa+11oRQlL8G1w==
X-Google-Smtp-Source: AMrXdXt4CFqpaygzmn8jlgk3guTwBMlwAeK88z0tm2ydl3X0iR80W1j/NYLzvlchVyMYfq0mLoORGF3zOH/xTMjn87A=
X-Received: by 2002:a17:90a:c389:b0:218:9107:381b with SMTP id
 h9-20020a17090ac38900b002189107381bmr390686pjt.75.1671043396770; Wed, 14 Dec
 2022 10:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20221213023605.737383-1-sdf@google.com> <20221213023605.737383-7-sdf@google.com>
 <1a0436c5-2198-0c69-1306-872454d2fb13@linux.dev> <87cz8mgtcg.fsf@toke.dk>
In-Reply-To: <87cz8mgtcg.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 14 Dec 2022 10:43:05 -0800
Message-ID: <CAKH8qBudP_oZ55ZQe=j+VyOLycvdr+ec7P4pr+ztN9Y-Gv-Waw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/15] bpf: Support consuming XDP HW metadata
 from fext programs
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 14, 2022 at 2:41 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Martin KaFai Lau <martin.lau@linux.dev> writes:
>
> > On 12/12/22 6:35 PM, Stanislav Fomichev wrote:
> >> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >>
> >> Instead of rejecting the attaching of PROG_TYPE_EXT programs to XDP
> >> programs that consume HW metadata, implement support for propagating t=
he
> >> offload information. The extension program doesn't need to set a flag =
or
> >> ifindex, it these will just be propagated from the target by the verif=
ier.
> >
> > s/it/because/ ... these will just be propagated....
>
> Yeah, or just drop 'it' :)
>
> >> We need to create a separate offload object for the extension program,
> >> though, since it can be reattached to a different program later (which
> >> means we can't just inhering the offload information from the target).
> >
> > hmm.... inheriting?
>
> Think I meant to write "we can't just inherit"
>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 11c558be4992..8686475f0dbe 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -3021,6 +3021,14 @@ static int bpf_tracing_prog_attach(struct bpf_p=
rog *prog,
> >>                      goto out_put_prog;
> >>              }
> >>
> >> +            if (bpf_prog_is_dev_bound(prog->aux) &&
> >
> >
> >> +                (bpf_prog_is_offloaded(tgt_prog->aux) ||
> >> +                 !bpf_prog_is_dev_bound(tgt_prog->aux) ||
> >> +                 !bpf_offload_dev_match(prog, tgt_prog->aux->offload-=
>netdev))) {
> >
> > hmm... tgt_prog->aux->offload does not look safe without taking bpf_dev=
s_lock.
> > offload could be NULL, no?
> >
> > It probably needs a bpf_prog_dev_bound_match(prog, tgt_prog) which take=
s the lock.
>
> Hmm, right, I was kinda expecting that this would not go away while
> tgt_prog was alive, but I see now that's not the case due to the
> unregister hook. So yeah, needs locking (same below) :)

Agreed, thanks! These seem easy enough to address on my side, so I'll
take care of them (and will keep your attribution).

> -Toke
>
