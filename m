Return-Path: <bpf+bounces-45995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A69E1925
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 11:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B932F286C70
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713CF1E1C04;
	Tue,  3 Dec 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="J8Pc1DKE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092172A1B8
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221401; cv=none; b=oMOjg4eIrSzs93PD7xCz4uqbnC4f4W+5VLFfGR6Ser/IDEK2RCSrM3yIu4pw6iWHte+t7V8SVA+92AJuZXfr55YmMVTAqf1+wroNvo32TbEAKjaLY6EmA197PZ5asTD8tWSOpLXa2L6DGVaWR402WdFMIH+7l9JL9pjZRVKdAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221401; c=relaxed/simple;
	bh=bgTHgbuxjzHkYHLvcYifB2xqDSAeidJN0x60UzfUDvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEvOoZE0M7oBYIHcTd6VK1mD2vN05OMgFDTRuBn36n0UHr/YjoWaomPXCjS49OtaGxt+tqJwUc5VLPXQf5wYc+ytvKGOR8RlZ67Lp3qOanqSHMpGjLq8z55qt+yhU07swFhKSHofY963pOgb8I1dxiNFT6MV2ZaovP7vbx0KJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=J8Pc1DKE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e27c75f4so2216971f8f.2
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733221397; x=1733826197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5BvMmXXOf3FtKEhduffj0W3qStzaDBkDEq9ypMipFAo=;
        b=J8Pc1DKE25vTHjbMu8JM7ZiowPQK+qru5p4658esqj5e6xJc2QOp8pv02bMakvEZ4Q
         XebLD8RGn64yihVZnFS+owk89EYIJJ51sEUk51e+MW/xslqTWRB0Dnt8WvYGm5rCa3gK
         wmkkVAqBumZg4sn4Q2vSK/0KToyyzG6o67csRShCMwUkzu1WEMmCXwhJnqfiSLSNp6ti
         CBY7QWcMKXPToJ+JVgUHUPTK0JqzOvlQZTBUA4jfdaaczrXAFBPBJ+dcc81Cy0b7uWMk
         AexKV2IP9/jvqQzC/eLSus6m7j6qDWGpZgTDarG2+SYO89kxDn9UZ2qqjB+mQAtjJlE8
         gakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733221397; x=1733826197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BvMmXXOf3FtKEhduffj0W3qStzaDBkDEq9ypMipFAo=;
        b=OnrjxpY/KKygQ1LLI9W/m0gzebe17DtBEYXtM3Hxd0lmkDwOkH3PKtb+mEzezR864Y
         HiZM8iNwQet2bVo9RmOxtW3iOx6UhgNr97n3Lif1mPlJhW9RBBohczmnJ+wGUCBGOisn
         MFAUC+QnkvGjce1UTJgSrx1+OwjlGdrHL4slYWb/BjbdK8nJ5UKAO7rxVhBqvWRXqnjD
         cqRtIwCWPozL8Khm5kOKCoG8eWj35gYpkl5rgfRlrI7/SV9AE/G6R7yww64f677hgaW0
         y3q5R1mO74vOewts9xnWsArf32TUFX4W4wdC6jx9d/Fz/yUpyIDebK+GzdVy5p3TD7N+
         T5/Q==
X-Gm-Message-State: AOJu0YyiKbZI1f4ApXq+USTbaKM9yt+bSAKiounAcNczKyVvL+AjLHNs
	om2EYaOPWzxWQ2+1bZNzSY/3l9RRDFk/+tf2T40R15rGouJeMPNvUie/IqSponwtxz2nU+KcWWe
	I
X-Gm-Gg: ASbGncscWiHVCXybdhb87x/gmE4n6y9tFb2dUGdn5GRiE4LhENfjZ9iWDzW3WGW94Cd
	ajpvCltxhT/OY0GcQ3DY/5r+4CL+ZNr0Vu2KLOOkYMz8qXmwtFT9PVl/fNt0T6qvNM5efCyFZa8
	syc917BL/O1tNeMpdHiA4p7c7rOKPNVCBKTQxbHrAQe1xNGUH2qF8ELyykyd+YZsqKsywysD9fJ
	AlG25hCfknSN6NaqVVkLhO+aM8EWllpEMr+GLM=
X-Google-Smtp-Source: AGHT+IEeq7QJ6C3JJfi/mmMcj895rf0D+pN8rhEmTW7MCTeyDU+K4X78K0BBw5vkRpja6Zc34AFcog==
X-Received: by 2002:a05:6000:401e:b0:385:f7a3:fecd with SMTP id ffacd0b85a97d-385fd3c6864mr1594754f8f.11.1733221397118;
        Tue, 03 Dec 2024 02:23:17 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bed7sm187443045e9.8.2024.12.03.02.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:23:16 -0800 (PST)
Date: Tue, 3 Dec 2024 10:25:33 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 5/7] selftests/bpf: Add tests for fd_array_cnt
Message-ID: <Z07cnVjOyo7ySULu@eis>
References: <20241129132813.1452294-1-aspsk@isovalent.com>
 <20241129132813.1452294-6-aspsk@isovalent.com>
 <CAADnVQKdsaxfYBn_SPOyUt4=r0uPXZ8ejP6ZFyy7EqdFGULg2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKdsaxfYBn_SPOyUt4=r0uPXZ8ejP6ZFyy7EqdFGULg2A@mail.gmail.com>

On 24/12/02 06:37PM, Alexei Starovoitov wrote:
> On Fri, Nov 29, 2024 at 5:29 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > Add a new set of tests to test the new field in PROG_LOAD-related
> > part of bpf_attr: fd_array_cnt.
> >
> > Add the following test cases:
> >
> >   * fd_array_cnt/no-fd-array: program is loaded in a normal
> >     way, without any fd_array present
> >
> >   * fd_array_cnt/fd-array-ok: pass two extra non-used maps,
> >     check that they're bound to the program
> >
> >   * fd_array_cnt/fd-array-dup-input: pass a few extra maps,
> >     only two of which are unique
> >
> >   * fd_array_cnt/fd-array-ref-maps-in-array: pass a map in
> >     fd_array which is also referenced from within the program
> >
> >   * fd_array_cnt/fd-array-trash-input: pass array with some trash
> >
> >   * fd_array_cnt/fd-array-with-holes: pass an array with holes (fd=0)
> >
> >   * fd_array_cnt/fd-array-2big: pass too large array
> >
> > All the tests above are using the bpf(2) syscall directly,
> > no libbpf involved.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  kernel/bpf/verifier.c                         |  30 +-
> >  .../selftests/bpf/prog_tests/fd_array.c       | 340 ++++++++++++++++++
> >  2 files changed, 355 insertions(+), 15 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d172f6974fd7..7102d85f580d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -22620,7 +22620,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >         env->ops = bpf_verifier_ops[env->prog->type];
> >         ret = init_fd_array(env, attr, uattr);
> >         if (ret)
> > -               goto err_free_aux_data;
> > +               goto err_release_maps;
> >
> >         env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
> >         env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
> > @@ -22773,11 +22773,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >             copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
> >                                   &log_true_size, sizeof(log_true_size))) {
> >                 ret = -EFAULT;
> > -               goto err_release_maps;
> > +               goto err_ext;
> >         }
> >
> >         if (ret)
> > -               goto err_release_maps;
> > +               goto err_ext;
> >
> >         if (env->used_map_cnt) {
> >                 /* if program passed verifier, update used_maps in bpf_prog_info */
> > @@ -22787,7 +22787,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >
> >                 if (!env->prog->aux->used_maps) {
> >                         ret = -ENOMEM;
> > -                       goto err_release_maps;
> > +                       goto err_ext;
> >                 }
> >
> >                 memcpy(env->prog->aux->used_maps, env->used_maps,
> > @@ -22801,7 +22801,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >                                                           GFP_KERNEL);
> >                 if (!env->prog->aux->used_btfs) {
> >                         ret = -ENOMEM;
> > -                       goto err_release_maps;
> > +                       goto err_ext;
> >                 }
> >
> >                 memcpy(env->prog->aux->used_btfs, env->used_btfs,
> > @@ -22817,15 +22817,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >
> >         adjust_btf_func(env);
> >
> > -err_release_maps:
> > -       if (!env->prog->aux->used_maps)
> > -               /* if we didn't copy map pointers into bpf_prog_info, release
> > -                * them now. Otherwise free_used_maps() will release them.
> > -                */
> > -               release_maps(env);
> > -       if (!env->prog->aux->used_btfs)
> > -               release_btfs(env);
> > -
> > +err_ext:
> >         /* extension progs temporarily inherit the attach_type of their targets
> >            for verification purposes, so set it back to zero before returning
> >          */
> > @@ -22838,7 +22830,15 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
> >  err_unlock:
> >         if (!is_priv)
> >                 mutex_unlock(&bpf_verifier_lock);
> > -err_free_aux_data:
> > +err_release_maps:
> > +       if (!env->prog->aux->used_maps)
> > +               /* if we didn't copy map pointers into bpf_prog_info, release
> > +                * them now. Otherwise free_used_maps() will release them.
> > +                */
> > +               release_maps(env);
> > +       if (!env->prog->aux->used_btfs)
> > +               release_btfs(env);
> > +
> >         vfree(env->insn_aux_data);
> >         kvfree(env->insn_hist);
> 
> verifier.c hunk shouldn't be mixed with the selftests.
> 
> Looks like it should be in patch 3?

Sorry, wrong `rebase -i`

> Not sure what it does though.

Yeah, thanks. I've simplified this part of Patch 3,
this diff will not appear in v4

