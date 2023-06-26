Return-Path: <bpf+bounces-3482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3FF73E8A1
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 20:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD601C20923
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F4813ACC;
	Mon, 26 Jun 2023 18:27:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB913AC9
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 18:27:42 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31E1BEE
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 11:27:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb41682472so2405579e87.2
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687804057; x=1690396057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxGb3k+bZupZFfhTDMfyedSmOpMDxjOHhiNNI8U2pA4=;
        b=QXip6YdL61KwsrA8GoHlOBdncTMzjHIF5S3PgC78ypxTGm/ytgNk6hvpGXGfyw02wC
         /jhp0VBTRb4m1UcKW/g8I86GbeLB/qb7GrQfzo+Y0r30JFnmLuoJHrkQJL96who+Uiul
         pv7FyHhnaSKKzMbISQ1jQWBWOK7G3je02NW3pFtcPgGI3PqfVhKAT5LjbHWeLjswl9Fu
         cQn9RqbGrw4eAVtJSz0X6KCFr26qZsfZKBn+FRM3bdcTXS6NkUj1q0m9A5it/ybSeWUI
         Cxz3AaXRVuKgPTnIEDcXAHhbwfIxUhvSy0AestHfU9mhCcj7zgS6umUCWrXct4WEI/OT
         8qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687804057; x=1690396057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxGb3k+bZupZFfhTDMfyedSmOpMDxjOHhiNNI8U2pA4=;
        b=bneGu3SJFi0NmWmyxy0ZmZC2STnSVlwJrzt9LnkPhSwJQWjmHbwzN6m6Ff31PQnsNf
         X9DcFMttmIXTVhHvuW6sf/ukRTzabr2dtvZkcHYEhOlhS0PouG5KgYcEP8hU8dxzIaaM
         cgBM2/5Ffnr7q+/px73NxQYIke59ZNJ4LpEfcd9rWnPlYquGysGnhmNiTQEuKQ5tIpBG
         GxuNWunPdlOeIoO8nWOrZUCejk0x3VcCdcbTZDvJIeIB2J0k0j2ksqQUmg95VHBsoG8E
         ySmNYrMX5Y0C8W7M8iSikKu2BBtRtQK/cmRFegU3LRe3I0cEDhuWaU5EkJRHhN8qENbJ
         YYxA==
X-Gm-Message-State: AC+VfDyWsI07yrVXueap9GkrvrFEqwxOA1LlX3rIyNswuGTwE/awqw75
	5LCKvtXdmcVTr/iFnsBImHdL58Q5L+tUGSQBDxY=
X-Google-Smtp-Source: ACHHUZ4POKw7gWkw92ufAxnWgfSPpojam7r2McCmK/ov0pJ22Ac/ivPZPnUjSbYDqXh5dF+RaQ1BHSKEZM2owZfp9eM=
X-Received: by 2002:a05:6512:3c88:b0:4f9:6a7b:b8de with SMTP id
 h8-20020a0565123c8800b004f96a7bb8demr9246392lfv.3.1687804056960; Mon, 26 Jun
 2023 11:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-2-jolsa@kernel.org>
 <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
 <ZJVViQEvUnMQN43b@krava> <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
 <ZJeWAiW5qxQPghGm@krava>
In-Reply-To: <ZJeWAiW5qxQPghGm@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jun 2023 11:27:25 -0700
Message-ID: <CAEf4BzYq6DJhWbVFnb2W_qWNDjObAHcd6agRdmp=OsP23A7O7w@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 6:19=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jun 23, 2023 at 09:24:22AM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > > > > +
> > > > > +       if (!uprobes || !ref_ctr_offsets || !link)
> > > > > +               goto error_free;
> > > > > +
> > > > > +       for (i =3D 0; i < cnt; i++) {
> > > > > +               if (uref_ctr_offsets && __get_user(ref_ctr_offset=
, uref_ctr_offsets + i)) {
> > > > > +                       err =3D -EFAULT;
> > > > > +                       goto error_free;
> > > > > +               }
> > > > > +               if (__get_user(offset, uoffsets + i)) {
> > > > > +                       err =3D -EFAULT;
> > > > > +                       goto error_free;
> > > > > +               }
> > > > > +
> > > > > +               uprobes[i].offset =3D offset;
> > > > > +               uprobes[i].link =3D link;
> > > > > +
> > > > > +               if (flags & BPF_F_UPROBE_MULTI_RETURN)
> > > > > +                       uprobes[i].consumer.ret_handler =3D uprob=
e_multi_link_ret_handler;
> > > > > +               else
> > > > > +                       uprobes[i].consumer.handler =3D uprobe_mu=
lti_link_handler;
> > > > > +
> > > > > +               ref_ctr_offsets[i] =3D ref_ctr_offset;
> > > > > +       }
> > > > > +
> > > > > +       link->cnt =3D cnt;
> > > > > +       link->uprobes =3D uprobes;
> > > > > +       link->path =3D path;
> > > > > +
> > > > > +       bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
> > > > > +                     &bpf_uprobe_multi_link_lops, prog);
> > > > > +
> > > > > +       err =3D bpf_link_prime(&link->link, &link_primer);
> > > > > +       if (err)
> > > > > +               goto error_free;
> > > > > +
> > > > > +       for (i =3D 0; i < cnt; i++) {
> > > > > +               err =3D uprobe_register_refctr(d_real_inode(link-=
>path.dentry),
> > > > > +                                            uprobes[i].offset, r=
ef_ctr_offsets[i],
> > > > > +                                            &uprobes[i].consumer=
);
> > > > > +               if (err) {
> > > > > +                       bpf_uprobe_unregister(&path, uprobes, i);
> > > >
> > > > bpf_link_cleanup() will do this through
> > > > bpf_uprobe_multi_link_release(), no? So you are double unregisterin=
g?
> > > > Either drop cnt to zero, or just don't do this here? Latter is bett=
er,
> > > > IMO.
> > >
> > > bpf_link_cleanup path won't call release callback so we have to do th=
at
> >
> > bpf_link_cleanup() does fput(primer->file); which eventually calls
> > release callback, no? I'd add printk and simulate failure just to be
> > sure
>
> I recall we had similar discussion for kprobe_multi link ;-)
>
> I'll double check that but I think bpf_link_cleanup calls just
> dealloc callback not release

Let's document this in comments for bpf_link_cleanup() so we don't
have to discuss this again :)

I think you are right, btw. I see that bpf_link_cleanup() sets
link->prog to NULL, and bpf_link_free() won't call
link->ops->release() if link->prog is NULL.

Tricky, I keep forgetting this. Let's explicitly explain this in a comment.

>
> jirka
>
> >
> > >
> > > I think I can add simple selftest to have this path covered
> > >
> > > thanks,
> > > jirka
>
> SNIP

