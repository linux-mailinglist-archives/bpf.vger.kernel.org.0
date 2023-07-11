Return-Path: <bpf+bounces-4784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6D674F655
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91062818E3
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D831DDDD;
	Tue, 11 Jul 2023 17:02:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B477168CE
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 17:02:26 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131FF10EF
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 10:02:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so8970038e87.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689094942; x=1691686942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIJrG71pYr4eK59jvlVVnjOliViiL4BE0jQ7QvbN5RQ=;
        b=Bky3ddCL//+CvZmvrD1wkYzQ8Kj6FZg7l6ioxYcr8nNN/n7gZ/h3TnO3a4QWzkQ6oL
         hGvbdHlCeGiVVlOcl8prJYnzW2WxAFSgS3kK7mw8h/l1TpWSe9Z1/F4XKKRCmvCknmMe
         Wdlpj8LKGSXrmYzD808mAQflUuxNfZQ5RIXeGX7h72rqLaEaQCVr++Lh8WlBG8uK2m1C
         8bD1PMMWFOmnyoKtxxcAax1PB4efxy8SrEFaMCdQRJMX/MzmZJWtUlFsQ4QghnP3eKaa
         N+d8aaIJSY4tMRKYUL+G3GbcEVs9o351d0cej7+zOVqrp8W9FQhYPHIaGMSfJg+4Iu/W
         ryaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689094942; x=1691686942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIJrG71pYr4eK59jvlVVnjOliViiL4BE0jQ7QvbN5RQ=;
        b=YTbhmiU0rECtnNFbtg2su//z+nNdmfZ7c2g5ZuCzXcHVNqNgfKhWELkC5kTbKS/SIi
         OmB0OhngYsuAwcbCusfHIhX0MOGxleDlxQ9CEmD2AKLmNJRZBPeagQBENRdkAC7xlzEx
         HENKrkR+sPtxYCsPIIwUUV2evmu/qScm0eh4ayiplR04ICeJBIJW/dsRCsD9ARt9DpKS
         lBHf+r12AN/bX5a16Hm23GHJifCPAg66B0lCIsXYvCydZrLT6BRwr/MbQDCyStlhx9YK
         CDPc2VFtZDZmp24sVIsOKiUrqc9vKDK3XpcLqkQScvj86CRerXbBsJ5M+VzBEaat+aYI
         st9A==
X-Gm-Message-State: ABy/qLYKkiy4iEt2/5AzplWJcS1tRK2tEeiwmSaUXgocn04ClsdoeQMK
	Ke5ZFnpb1mPCazz09w+4NepaisKg0sZe0ux77+w=
X-Google-Smtp-Source: APBJJlF82+WKTe1aWGx7x21A/FXyWoLAu9WENB9v9io52gCXntdH75aFxTfq9Rmu+Y+Jnhvm+ZnF3uThPIjRcqlzKjY=
X-Received: by 2002:a05:6512:2098:b0:4f9:5711:2eb6 with SMTP id
 t24-20020a056512209800b004f957112eb6mr12817314lfr.28.1689094941857; Tue, 11
 Jul 2023 10:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-14-jolsa@kernel.org>
 <CAEf4Bza16nwKNkktW+r-5OoCsAtPhMkRLedWdrQo+2WDvOR8xA@mail.gmail.com> <ZK0bQ5pqKeaAxEUQ@krava>
In-Reply-To: <ZK0bQ5pqKeaAxEUQ@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jul 2023 10:02:09 -0700
Message-ID: <CAEf4BzZkDmPPHVH=wqfyU3GnH_iYQMXj+vO7BKDtxfOiDzphXA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 13/26] libbpf: Add bpf_program__attach_uprobe_multi
 function
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 2:05=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jul 06, 2023 at 09:05:23PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > > +       if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
> > > +               return libbpf_err_ptr(-EINVAL);
> > > +
> > > +       syms =3D OPTS_GET(opts, syms, NULL);
> > > +       offsets =3D OPTS_GET(opts, offsets, NULL);
> > > +       ref_ctr_offsets =3D OPTS_GET(opts, ref_ctr_offsets, NULL);
> > > +       cookies =3D OPTS_GET(opts, cookies, NULL);
> > > +       cnt =3D OPTS_GET(opts, cnt, 0);
> > > +
> > > +       /*
> > > +        * User can specify 2 mutually exclusive set of inputs:
> > > +        *
> > > +        * 1) use only path/func_pattern/pid arguments
> > > +        *
> > > +        * 2) use path/pid with allowed combinations of:
> > > +        *    syms/offsets/ref_ctr_offsets/cookies/cnt
> > > +        *
> > > +        *    - syms and offsets are mutually exclusive
> > > +        *    - ref_ctr_offsets and cookies are optional
> > > +        *
> > > +        * Any other usage results in error.
> > > +        */
> > > +
> > > +       if (!path && !func_pattern && !cnt)
> >
> > weird, I'd expect separate if (!path) return error (already bad,
> > regardless of func_pattern or cnt)
> >
> > then if (!func_pattern && cnt =3D=3D 0) return error
> >
> > > +               return libbpf_err_ptr(-EINVAL);
> > > +       if (func_pattern && !path)
> > > +               return libbpf_err_ptr(-EINVAL);
> > > +
> > > +       has_pattern =3D path && func_pattern;
> >
> > this and above check must be some leftovers from previous version.
> > path should always be present. and so you don't need has_pattern
> > variable, just use "func_pattern" check
>
> hum, right, previous version had 2 paths, now there's just one,
> I'll change that together with the suggested change above
>
> >
> > > +
> > > +       if (has_pattern) {
> > > +               if (syms || offsets || ref_ctr_offsets || cookies || =
cnt)
> > > +                       return libbpf_err_ptr(-EINVAL);
> > > +       } else {
> > > +               if (!cnt)
> > > +                       return libbpf_err_ptr(-EINVAL);
> > > +               if (!!syms =3D=3D !!offsets)
> > > +                       return libbpf_err_ptr(-EINVAL);
> > > +       }
> > > +
> > > +       if (has_pattern) {
> > > +               if (!strchr(path, '/')) {
> > > +                       err =3D resolve_full_path(path, full_path, si=
zeof(full_path));
> > > +                       if (err) {
> > > +                               pr_warn("prog '%s': failed to resolve=
 full path for '%s': %d\n",
> > > +                                       prog->name, path, err);
> > > +                               return libbpf_err_ptr(err);
> > > +                       }
> > > +                       path =3D full_path;
> > > +               }
> > > +
> > > +               err =3D elf_resolve_pattern_offsets(path, func_patter=
n,
> > > +                                                 &resolved_offsets, =
&cnt);
> > > +               if (err < 0)
> > > +                       return libbpf_err_ptr(err);
> > > +               offsets =3D resolved_offsets;
> > > +       } else if (syms) {
> > > +               err =3D elf_resolve_syms_offsets(path, cnt, syms, &re=
solved_offsets);
> > > +               if (err < 0)
> > > +                       return libbpf_err_ptr(err);
> > > +               offsets =3D resolved_offsets;
> >
> > you can extract this common error checking and `offsets =3D
> > resolved_offsets;` to after if, it's common for both branches
>
> not sure what you mean in here, offsets can be also provided
> by OPTS_GET(opts, offsets, NULL) earlier

ah, I missed that it's else if, not just else. Never mind, it's good as is =
then.

>
> > > +       }
> > > +
> > > +       retprobe =3D OPTS_GET(opts, retprobe, false);
> > > +
> > > +       lopts.uprobe_multi.path =3D path;
> > > +       lopts.uprobe_multi.offsets =3D offsets;
> > > +       lopts.uprobe_multi.ref_ctr_offsets =3D ref_ctr_offsets;
> > > +       lopts.uprobe_multi.cookies =3D cookies;
> > > +       lopts.uprobe_multi.cnt =3D cnt;
> > > +       lopts.uprobe_multi.flags =3D retprobe ? BPF_F_UPROBE_MULTI_RE=
TURN : 0;
> >
> > retprobe is another unnecessary var, just inline check here to keep it =
simpler
>
> ok
>
> >
> > > +
> > > +       if (pid =3D=3D 0)
> > > +               pid =3D getpid();
> > > +       if (pid > 0)
> > > +               lopts.uprobe_multi.pid =3D pid;
> > > +
> > > +       link =3D calloc(1, sizeof(*link));
> > > +       if (!link) {
> > > +               err =3D -ENOMEM;
> > > +               goto error;
> > > +       }
> > > +       link->detach =3D &bpf_link__detach_fd;
> > > +
> > > +       prog_fd =3D bpf_program__fd(prog);
> > > +       link_fd =3D bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULT=
I, &lopts);
> > > +       if (link_fd < 0) {
> > > +               err =3D -errno;
> > > +               pr_warn("prog '%s': failed to attach: %s\n",
> >
> > "failed to attach multi-uprobe"? We probably should have added "failed
> > to attach multi-kprobe" in bpf_program__attach_kprobe_multi_opts as
> > well?
>
> ook, will add
>
> >
> > > +                       prog->name, libbpf_strerror_r(err, errmsg, si=
zeof(errmsg)));
> > > +               goto error;
> > > +       }
> > > +       link->fd =3D link_fd;
> > > +       free(resolved_offsets);
> > > +       return link;
> > > +
> > > +error:
> > > +       free(resolved_offsets);
> > > +       free(link);
> > > +       return libbpf_err_ptr(err);
> > > +}
> > > +
> > >  LIBBPF_API struct bpf_link *
> > >  bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_=
t pid,
> > >                                 const char *binary_path, size_t func_=
offset,
> > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > index 754da73c643b..7c218f610210 100644
> > > --- a/tools/lib/bpf/libbpf.h
> > > +++ b/tools/lib/bpf/libbpf.h
> > > @@ -529,6 +529,33 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
> > >                                       const char *pattern,
> > >                                       const struct bpf_kprobe_multi_o=
pts *opts);
> > >
> > > +struct bpf_uprobe_multi_opts {
> > > +       /* size of this struct, for forward/backward compatibility */
> > > +       size_t sz;
> > > +       /* array of function symbols to attach */
> >
> > attach to?
>
> ok
>
> >
> > > +       const char **syms;
> > > +       /* array of function addresses to attach */
> >
> > attach to?
>
> ook
>
> >
> > > +       const unsigned long *offsets;
> > > +       /* array of refctr offsets to attach */
> >
> > we don't really attach to ref counters, so maybe "optional, array of
> > associated ref counter offsets" or something along those lines ?
>
> ok
>
> >
> > > +       const unsigned long *ref_ctr_offsets;
> > > +       /* array of user-provided values fetchable through bpf_get_at=
tach_cookie */
> >
> > "array of associated BPF cookies"? we can't keep explaining what BPF
> > cookie is in every possible API :)
>
> ook
>
> >
> > > +       const __u64 *cookies;
> > > +       /* number of elements in syms/addrs/cookies arrays */
> > > +       size_t cnt;
> > > +       /* create return uprobes */
> > > +       bool retprobe;
> > > +       size_t :0;
> > > +};
> > > +
> > > +#define bpf_uprobe_multi_opts__last_field retprobe
> > > +
> > > +LIBBPF_API struct bpf_link *
> > > +bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
> > > +                                pid_t pid,
> > > +                                const char *binary_path,
> > > +                                const char *func_pattern,
> > > +                                const struct bpf_uprobe_multi_opts *=
opts);
> > > +
> >
> > ok, let's be good citizens and add documentation for this new API.
> > Those comments about valid combinations belong here as well. Please
> > take a look at existing doccomments for the format and conventions.
> > Thanks!
>
> ok, will add
>
> thanks,
> jirka

