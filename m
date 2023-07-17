Return-Path: <bpf+bounces-5137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83461756CBA
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 21:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45155281448
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1947C140;
	Mon, 17 Jul 2023 19:06:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B7253B8
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 19:06:03 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DAEAF
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:06:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so10090681a12.0
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689620760; x=1692212760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvLZOWdf5PaIF3cT5A2eYdwIlBIVZ1ki6/OBFszYm8s=;
        b=JigHz+5K6w8KiHk1QO23rlo7Rbny55aPEWU5l2XCsOaO2pLRvJ9LMBbUba79hQKw1m
         XbL4Zel47hmMBo2RPHNZfOIA91M9TJaZgYapkXSMVOde99qfzv4WDf69G65/BiwfAeSN
         UsSaUuTpYuQTOzNFc6tNI9VefVqBmvEgPbBtcIsYuXDtDCE5aIyVL1v883fLu4KMDbe2
         pOz++g1ezpTqLzR5Q78/nPQtn36AJzhp2x58Lax6m7rev/9ZbGQBjWFzDQV4CTZsFTQc
         xUGmN9FVyE3MJD2beEIy90KrmjR09s/WfV0oqg0GdIZuSRJO1lMt6MP/N2pQcDbt+Zri
         muAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689620760; x=1692212760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvLZOWdf5PaIF3cT5A2eYdwIlBIVZ1ki6/OBFszYm8s=;
        b=SNpxvzZheBrNSCW8w5iTXDBi0CCnjFYsGAp+rYwt5DEWXC8VvyxEucdovT3H5rL36r
         zNV1wyKp6iR25FheWXFqrNcj9duxx1MJI6/IWEY24pvirfXfRydAZBVa3DhXUKTSK+Ks
         tLnSOGljc7+l23sQ2Cg9yZyJOPPz6+uDz0d6NGk+xEbKuJknD/he4tyYUPLAjUO4mjp5
         fkw/YVOVrm5Bjn7ozAtX+AQ3KjqbP41vJqzGkaTSdzeYE4AuVdkeo8QJxH2ZzNff14QJ
         zt2lXJVi9qonp4F6PbYpX+olQj2dPrAbTN7Pc0bOkw4NHVPoOiHRvs+adC28SOQneaGX
         7D8w==
X-Gm-Message-State: ABy/qLY0N1DXWaMteDRcV5pewReA0eUjIkYh01etGvXejLWCPWbyXdFv
	HDOEJF8gMFdJrswhlC4BJjp15qdV/ylo4xYEReo=
X-Google-Smtp-Source: APBJJlGG1dSId26/2JR0Zlzn0IyZAAdIIONAfepJZbvxq0RR5ZsCD5c3eElEI0Q6wRBYu6alWoWUynMPZ+WljDqlhbU=
X-Received: by 2002:a05:6402:3550:b0:51e:5aac:6bad with SMTP id
 f16-20020a056402355000b0051e5aac6badmr13046779edd.11.1689620759732; Mon, 17
 Jul 2023 12:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-5-memxor@gmail.com>
 <20230714215814.fqv5aypobicomszr@MacBook-Pro-8.local> <CAP01T74c7qcjDeAvav064ZTixCCznnyC4SMRB0YK=iN=hkwA8A@mail.gmail.com>
 <CAADnVQLz5VtDSXwiK-gL4WFuHHJo7m41DAks8Y79ZaQc242iqg@mail.gmail.com>
In-Reply-To: <CAADnVQLz5VtDSXwiK-gL4WFuHHJo7m41DAks8Y79ZaQc242iqg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 18 Jul 2023 00:35:19 +0530
Message-ID: <CAP01T75+A5EKrgxy1tY6F8CgHnUJT3f5RfJyxENJmgrDsn=xdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/10] bpf: Add support for inserting new subprogs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 17 Jul 2023 at 22:55, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 17, 2023 at 9:22=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, 15 Jul 2023 at 03:28, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jul 13, 2023 at 08:02:26AM +0530, Kumar Kartikeya Dwivedi wro=
te:
> > > > Introduce support in the verifier for generating a subprogram and
> > > > include it as part of a BPF program dynamically after the do_check
> > > > phase is complete. The appropriate place of invocation would be
> > > > do_misc_fixups.
> > > >
> > > > Since they are always appended to the end of the instruction sequen=
ce of
> > > > the program, it becomes relatively inexpensive to do the related
> > > > adjustments to the subprog_info of the program. Only the fake exit
> > > > subprogram is shifted forward by 1, making room for our invented su=
bprog.
> > > >
> > > > This is useful to insert a new subprogram and obtain its function
> > > > pointer. The next patch will use this functionality to insert a def=
ault
> > > > exception callback which will be invoked after unwinding the stack.
> > > >
> > > > Note that these invented subprograms are invisible to userspace, an=
d
> > > > never reported in BPF_OBJ_GET_INFO_BY_ID etc. For now, only a singl=
e
> > > > invented program is supported, but more can be easily supported in =
the
> > > > future.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  include/linux/bpf.h          |  1 +
> > > >  include/linux/bpf_verifier.h |  4 +++-
> > > >  kernel/bpf/core.c            |  4 ++--
> > > >  kernel/bpf/syscall.c         | 19 ++++++++++++++++++-
> > > >  kernel/bpf/verifier.c        | 29 ++++++++++++++++++++++++++++-
> > > >  5 files changed, 52 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 360433f14496..70f212dddfbf 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -1385,6 +1385,7 @@ struct bpf_prog_aux {
> > > >       bool sleepable;
> > > >       bool tail_call_reachable;
> > > >       bool xdp_has_frags;
> > > > +     bool invented_prog;
> > > >       /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
> > > >       const struct btf_type *attach_func_proto;
> > > >       /* function name for valid attach_btf_id */
> > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verif=
ier.h
> > > > index f70f9ac884d2..360aa304ec09 100644
> > > > --- a/include/linux/bpf_verifier.h
> > > > +++ b/include/linux/bpf_verifier.h
> > > > @@ -540,6 +540,7 @@ struct bpf_subprog_info {
> > > >       bool has_tail_call;
> > > >       bool tail_call_reachable;
> > > >       bool has_ld_abs;
> > > > +     bool invented_prog;
> > > >       bool is_async_cb;
> > > >  };
> > > >
> > > > @@ -594,10 +595,11 @@ struct bpf_verifier_env {
> > > >       bool bypass_spec_v1;
> > > >       bool bypass_spec_v4;
> > > >       bool seen_direct_write;
> > > > +     bool invented_prog;
> > >
> > > Instead of a flag in two places how about adding aux->func_cnt_real
> > > and use it in JITing and free-ing while get_info*() keep using aux->f=
unc_cnt.
> > >
> >
> > That does seem better, thanks. I'll make the change in v2.
> >
> > > > +/* The function requires that first instruction in 'patch' is insn=
si[prog->len - 1] */
> > > > +static int invent_subprog(struct bpf_verifier_env *env, struct bpf=
_insn *patch, int len)
> > > > +{
> > > > +     struct bpf_subprog_info *info =3D env->subprog_info;
> > > > +     int cnt =3D env->subprog_cnt;
> > > > +     struct bpf_prog *prog;
> > > > +
> > > > +     if (env->invented_prog) {
> > > > +             verbose(env, "verifier internal error: only one inven=
ted prog supported\n");
> > > > +             return -EFAULT;
> > > > +     }
> > > > +     prog =3D bpf_patch_insn_data(env, env->prog->len - 1, patch, =
len);
> > >
> > > The actual patching is not necessary.
> > > bpf_prog_realloc() and memcpy would be enough, no?
> > >
> >
> > Yes, it should be fine. But I didn't want to special case things here
> > just to make sure assumptions elsewhere don't break.
> > E.g. code readily assumes every insn has its own insn_aux_data which
> > might be broken if we don't expand it.
> > I think bpf_patch_insn_single is already doing a realloc (and reusing
> > trailing space in current allocation if available), so it didn't seem
> > worth it to me.
> >
> > If you still feel it's better I can analyze if anything might break
> > and make the change.
>
> bpf_patch_insn_data() is a known performance bottleneck.
> Folks have been trying to optimize it in the past.
> It's certainly delicate code.
> I guess since this extra subprog will only be added once
> we can live with unnecessary overhead of bpf_patch_insn_data().
> Just add the comment that we're not patching existing insn and
> all of adjust* ops are nop.

Ack.

