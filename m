Return-Path: <bpf+bounces-5116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF61D7568FE
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8EA2813BD
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145E8BE49;
	Mon, 17 Jul 2023 16:22:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7161253DE
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:22:22 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6120D130
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:22:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so6735762a12.3
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610940; x=1692202940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ttg8CZivoFqnVXJfItP54mYanDlPTYtnNKSKb5mEwUE=;
        b=jJV1IsC/ZZ3dDpGJEhm0uWZmSi1bgKNR9ELaAt4E6Z2tzs+mmqOPvuYwBccRf55CF+
         iM5Q+Q3xOEowmRA0oQr918L8GNNgW5zhzVNAZWLQxG5gLcR0n+uhfF6zsVeo2k9TiI2c
         1lhXlq9gYWFSK8WvCyxQLYqKwbHMNiG04Yfp6MUGBw0tH6ipYFCi02Isibt7NVk9628K
         t6UfjGSshbj4EZOZM+LNkiLOK23rM/tPlp2yOe4p84DYFyjexovpUcFMFXOTU7rFKH/8
         IANnwz2trL1sw9dZjz/BAkMI/K8DKIKqvQjwTR8x0ik1S1+HSP3I4eOcYUKwYM6OqV0Y
         n9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610940; x=1692202940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttg8CZivoFqnVXJfItP54mYanDlPTYtnNKSKb5mEwUE=;
        b=ViknSiu5DX6xkww3BVO44K7kndLld0dDAlnhUXOMOXSjnFHHsqGwbunqGYWQ9E7BfW
         434Vw8GfHrYv/QvzFgaEw6kA7l3NZLjOYvcbKbWKTl+zMUr+MccfODkKOBv9XmCEefkR
         RLOIF6PNE+6IWGRlkgaT0q815AMQtwX2g5DkuYGYHVZC6Ab6rQEfExFzfVN6rVHgk0+u
         MrNYoABXEEyLyuFh+WbbtSV85FmZ6e7ADf+ZujgSLg7wCFa1gAre6szNzujgMgJotYXW
         OzWJzeKh70BujWhQEb3my6yQQYQZpEp/a0+Ps4kNB0V+w1iFa966liv8ooP5VAmxBzvO
         /4HQ==
X-Gm-Message-State: ABy/qLaJ8O1VNeWGpBjTpEQF1Ba0gzHRHiC0YoyvqOJFdmX8rdlRUOYB
	WgEFwCS5cipDvv95LckbLmLGmLKjJI9Rg4Lla9w=
X-Google-Smtp-Source: APBJJlHSu/PzklVG6kdB06aOPdH58YkNRsD5LPwRWh068H1R3rR9aoIL47X1mMx6peOmw/iRaJ3eR8vUkmpvG7mFCS0=
X-Received: by 2002:a05:6402:31f4:b0:51a:5a25:6631 with SMTP id
 dy20-20020a05640231f400b0051a5a256631mr12754327edb.3.1689610939524; Mon, 17
 Jul 2023 09:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-5-memxor@gmail.com>
 <20230714215814.fqv5aypobicomszr@MacBook-Pro-8.local>
In-Reply-To: <20230714215814.fqv5aypobicomszr@MacBook-Pro-8.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 17 Jul 2023 21:51:39 +0530
Message-ID: <CAP01T74c7qcjDeAvav064ZTixCCznnyC4SMRB0YK=iN=hkwA8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/10] bpf: Add support for inserting new subprogs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 15 Jul 2023 at 03:28, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 13, 2023 at 08:02:26AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Introduce support in the verifier for generating a subprogram and
> > include it as part of a BPF program dynamically after the do_check
> > phase is complete. The appropriate place of invocation would be
> > do_misc_fixups.
> >
> > Since they are always appended to the end of the instruction sequence of
> > the program, it becomes relatively inexpensive to do the related
> > adjustments to the subprog_info of the program. Only the fake exit
> > subprogram is shifted forward by 1, making room for our invented subprog.
> >
> > This is useful to insert a new subprogram and obtain its function
> > pointer. The next patch will use this functionality to insert a default
> > exception callback which will be invoked after unwinding the stack.
> >
> > Note that these invented subprograms are invisible to userspace, and
> > never reported in BPF_OBJ_GET_INFO_BY_ID etc. For now, only a single
> > invented program is supported, but more can be easily supported in the
> > future.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h          |  1 +
> >  include/linux/bpf_verifier.h |  4 +++-
> >  kernel/bpf/core.c            |  4 ++--
> >  kernel/bpf/syscall.c         | 19 ++++++++++++++++++-
> >  kernel/bpf/verifier.c        | 29 ++++++++++++++++++++++++++++-
> >  5 files changed, 52 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 360433f14496..70f212dddfbf 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1385,6 +1385,7 @@ struct bpf_prog_aux {
> >       bool sleepable;
> >       bool tail_call_reachable;
> >       bool xdp_has_frags;
> > +     bool invented_prog;
> >       /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
> >       const struct btf_type *attach_func_proto;
> >       /* function name for valid attach_btf_id */
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index f70f9ac884d2..360aa304ec09 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -540,6 +540,7 @@ struct bpf_subprog_info {
> >       bool has_tail_call;
> >       bool tail_call_reachable;
> >       bool has_ld_abs;
> > +     bool invented_prog;
> >       bool is_async_cb;
> >  };
> >
> > @@ -594,10 +595,11 @@ struct bpf_verifier_env {
> >       bool bypass_spec_v1;
> >       bool bypass_spec_v4;
> >       bool seen_direct_write;
> > +     bool invented_prog;
>
> Instead of a flag in two places how about adding aux->func_cnt_real
> and use it in JITing and free-ing while get_info*() keep using aux->func_cnt.
>

That does seem better, thanks. I'll make the change in v2.

> > +/* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
> > +static int invent_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
> > +{
> > +     struct bpf_subprog_info *info = env->subprog_info;
> > +     int cnt = env->subprog_cnt;
> > +     struct bpf_prog *prog;
> > +
> > +     if (env->invented_prog) {
> > +             verbose(env, "verifier internal error: only one invented prog supported\n");
> > +             return -EFAULT;
> > +     }
> > +     prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
>
> The actual patching is not necessary.
> bpf_prog_realloc() and memcpy would be enough, no?
>

Yes, it should be fine. But I didn't want to special case things here
just to make sure assumptions elsewhere don't break.
E.g. code readily assumes every insn has its own insn_aux_data which
might be broken if we don't expand it.
I think bpf_patch_insn_single is already doing a realloc (and reusing
trailing space in current allocation if available), so it didn't seem
worth it to me.

If you still feel it's better I can analyze if anything might break
and make the change.

[...]

