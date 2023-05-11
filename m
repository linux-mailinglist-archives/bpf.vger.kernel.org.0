Return-Path: <bpf+bounces-353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3736FF703
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE4D2817D4
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15D6130;
	Thu, 11 May 2023 16:21:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281F654
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 16:21:51 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0551212E
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 09:21:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso9899982e87.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683822108; x=1686414108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X1AbCG5pdBhy/P3yx47iteO9at1EbB8pfn9S3G/nNQ=;
        b=eXNmUqRq2B4ULb7czkClrDgSixcsR0iab/ZjQMmoh+TX2S0WLvdIg4LGWJkfPnYau5
         iMcJyHIGhak09sxEOHHyBW+4f8N1Tj3j0rHick9sr6/AHjUDq7Im4e2kbbf2iH21eClm
         NPpGGk9r8AiDJ16SLrlPZHd761k2/uqzTM6mwFu4vvtw6dffacY7s4o1UiTpKnOR7VC2
         fMYPiTySzloLSGqUajuc01PGXarvIP/uAOZkuk5PjpVk5av1QxJec5ZkefmDDt7Us6Op
         HxNUIot2s71K5zen05Wfr0HaRxnZEuSliPAyo3BT1fR+IrUNnILIbtLkNfJMgoJrjFYQ
         8i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822108; x=1686414108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X1AbCG5pdBhy/P3yx47iteO9at1EbB8pfn9S3G/nNQ=;
        b=JWx8fC6bJ1jRCOaUv66REyTlrJwCkzCDwmDQzWtVfxUkUpCt1qeQOQil0ZYGegs9Db
         CBg+iSgwUYO+3dJBAl0vfpETwr93ZXHMp/3aEP0y8/qlEXuXNS9wGhNjrIqjMQfaRk/x
         dNFBEOUDsJlp67O/Cmoh5BTfJLYjp1/m1xg1LrjLxm9QH1eAxq8Ifxco11vPGepzXPUM
         kh0gmlnb8cjTrbGmn+r5GAadtnLON9ObbU2cmrAlYe8wCAbxspka4KjSb5xaL6zZ914f
         Y6+p8/zI3ihqXOjG8Nv6i7lGKjn9vUkO4y0vNOLcsqWMqcP+edkg9PQgajxR5h00ouS1
         FYRQ==
X-Gm-Message-State: AC+VfDyneEdn9X24QeBdFv4Kv04NMaAB/Ywq6Xq2HRVbJEHiDBduAIw6
	ZLQqFiS3xZDu4NnkrhTU2JwEV/HDTagxZwOd5I/pZQ9aB77A8g==
X-Google-Smtp-Source: ACHHUZ5P+ewF65tnG+w9f6E0aDoxPq1AuaDS9QGMn47VUiU0b6T7qNbz52SsBtfz2VyrOfWxrMBPj+m4K7NbG5PNibQ=
X-Received: by 2002:a2e:984e:0:b0:298:ad8e:e65 with SMTP id
 e14-20020a2e984e000000b00298ad8e0e65mr3428723ljj.21.1683822107524; Thu, 11
 May 2023 09:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-11-andrii@kernel.org>
In-Reply-To: <20230502230619.2592406-11-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 May 2023 09:21:36 -0700
Message-ID: <CAADnVQJWbXvHqy4wdP3iC+UcewQNJbJ_rbGGLX5+sOUJ1+yeyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] bpf: consistenly use program's recorded
 capabilities in BPF verifier
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 2, 2023 at 4:09=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> @@ -18878,7 +18882,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>         env->prog =3D *prog;
>         env->ops =3D bpf_verifier_ops[env->prog->type];
>         env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel);
> -       is_priv =3D bpf_capable();
> +
> +       env->allow_ptr_leaks =3D bpf_allow_ptr_leaks(*prog);
> +       env->allow_uninit_stack =3D bpf_allow_uninit_stack(*prog);
> +       env->bypass_spec_v1 =3D bpf_bypass_spec_v1(*prog);
> +       env->bypass_spec_v4 =3D bpf_bypass_spec_v4(*prog);
> +       env->bpf_capable =3D is_priv =3D (*prog)->aux->bpf_capable;

Just remembered that moving all CAP* checks early
(before they actually needed)
might be problematic.
See
https://lore.kernel.org/all/20230511142535.732324-10-cgzones@googlemail.com=
/

This patch set is reducing the number of cap* checks which is
a good thing from audit pov, but it calls them early before the cap
is actually needed and that part is misleading for audit.
I'm afraid we cannot do one big switch for all map types after bpf_capable.
The bpf_capable for maps needs to be done on demand.
For progs we should also do it on demand too.
socket_filter and cg_skb should proceed without cap* checks.

