Return-Path: <bpf+bounces-42933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD069AD2F2
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77684281B0F
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD6A1CCEE3;
	Wed, 23 Oct 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmXByGKk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4898512D758
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704690; cv=none; b=XMPsWweLpbA7lmz/U/aTWqdY3KYnJmRz2ZInV9X6+W5cbbh3czTV/qgLYYNbCxctvACUSd+zL6WxGQMzIkMj7CWaH6ZwFzx3u30SC6Yki63xoTFFNbM8CKKfajj49Kc2Pu0ClLNThjxeEMDkUPpGWs2LxPQmg3AH7yPysbj2AWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704690; c=relaxed/simple;
	bh=3Iz97CXiQT5/wiaoxcFFdGpK/x2ubFFe26XicOiRI0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOKl0IiHrpwfMx9bfYT+mufOlD5U/cUEHEVf+Ce05NwjofXozJ9wHAD21wLgmxAFLWhkfi0J0EDVUZZC0cNvLnneEALCNHT7sqjDuIJj/ss8R8DorjPtJRLyBwDn2REMlVjuRs/c8kBN8FIreU7KuHympiGDROJgLZBVbJw6hlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmXByGKk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db54269325so15297a12.2
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729704688; x=1730309488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R9zjmcXRk30rmW0zXa0fbsYNCPEP6UGuVcrOmQrxWY=;
        b=PmXByGKktUr7SJSptFsdeS1my/r72qRqpyIBW+hHoqJUx9L81rAfNlCfOkpt3xoPS6
         EAqlx2jkBb7yLgyLcRZAM5KP+MPiRxo8iR2Lt98ONvQF89yrfIBn+6Juf8nL8iMGv/O8
         EILf4kTZwtxGFxMIouxgEGahIz/0TeCgaBvEsbiAc4JH4Ize2374x6a9vI93SssD8N66
         6xDGN1Hxn1KGe0oFszYsEAf/BeJw2tP7eKBVAH+P/Z6zQtULlqoK2zkwjNKmrgevpCV0
         sWWBV2HBiybfP+Gx/84pBuJ0EXZMwG13S2Ib5ZLwW9gApDT+Uu8JNAqClsUAmnIURpIF
         L7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704688; x=1730309488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R9zjmcXRk30rmW0zXa0fbsYNCPEP6UGuVcrOmQrxWY=;
        b=Fhd+2yMjIDQdIF9Zm9BCnWeN4b/Wqcp9xj11I7cy3IJLWSijVbiBdv76ZoL9JM7scY
         nj3HFgkcvL3pzaGNv6OjTzPGqZjyU5JiP3/oZ1KNtzdvEpvW5fSShXYgfi7hnCmDv//k
         yw83oy4PBvcfg0/jd/o7h+5xPtMeP7vl9JAoItq7hGtJs1w3y3yEImXFxuOy6/zD9h3O
         kUIin9sC5MNjuTiQTtgoRNrsmx4DpNkzBFDpMMFRg0xSloTzzDyMnty83W365X/qNyf6
         cCE9KPUAZKLdVbsrd6HtUMraatImGduN8NhRPynejj9H6gngSNM0DSADjg8JTvXqN87o
         TJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMgM+twzTZ8DTIKOivmP1dq6UXp4eskry+oCwcStxCUBI73tVsMOo0eesN+Nqss9jFV2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQW6Wm+ZNjMddNmnWuxWW2NwYFACfgbqzpB9zdicrIbiIdpmqT
	+UrKQu4Ag/RMBH27xdvx3dtUhYoYMaZzaxVGpelF+a1Cc78lET/kFfMX/78BxPjo584LaV+MbxP
	hOJ+SmDFx4isMj7CgF/FrwHTycJ0=
X-Google-Smtp-Source: AGHT+IEjaE2xAbuL22kKLg0UbfxcavE+jFhC/GwtC0OgE7QNp0cKof3k2s8fFXr39SxVMbLBVDxQvAIT5SXZO/wovkw=
X-Received: by 2002:a05:6a21:1646:b0:1d9:1c76:6742 with SMTP id
 adf61e73a8af0-1d978b0b4b8mr3922303637.13.1729704688486; Wed, 23 Oct 2024
 10:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018020307.1766906-1-eddyz87@gmail.com> <CAADnVQKtR96Dricc=JiOi3VR9OeHjgT6xLOto9k_QcpPQNsKJw@mail.gmail.com>
 <1564924604e5e17af10beac6bd3263481a1723f0.camel@gmail.com>
 <CAADnVQJa8+tLnxpMWPVXO=moX+4tv3nTomang5=PAeLjVAe+ow@mail.gmail.com>
 <658394292b21edb9b30a5add27a8cd7fa8a778ed.camel@gmail.com> <a9bd25331dbfdd5a968f9c4320608d2949176fc1.camel@gmail.com>
In-Reply-To: <a9bd25331dbfdd5a968f9c4320608d2949176fc1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 10:31:16 -0700
Message-ID: <CAEf4BzYiEE-4XzaOA0oX5BdZp4VHhU9U3j+V+U3tiWfB38dN7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history is
 too long
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 7:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2024-10-21 at 22:38 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > This takes ~10 minutes to verify on master.
> > Surprisingly current patch does not seem to help,
> > I'll investigate this tomorrow.
> > Full example is in the end of the email.
>

[...]

> On master this fails with ENOMEM and the following error in the log:
>

Have you tried applying my insn_history optimization? It should
definitely avoid -ENOMEM, no? It still might be slow, but probably
much faster than that we have now. It would be nice if you can rebase
my old patch and land it (without any of the precision changes, that's
a second step).

>     [  418.083600] test_progs: page allocation failure: order:7, mode:0x1=
40cc0(GFP_USER|__GFP_COMP), \
>                      nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
>                    ...
>     [  418.084158] Call Trace:
>                     ...
>     [  418.084649]  krealloc_noprof+0x53/0xd0
>     [  418.084688]  copy_verifier_state+0x78/0x390
>                     ...
>
> Same happens if jmp_history_cnt check is moved to 'skip_inf_loop_check':
>
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18022,7 +18022,7 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>                          * at the end of the loop are likely to be useful=
 in pruning.
>                          */
>  skip_inf_loop_check:
> -                       if (!force_new_state &&
> +                       if (!force_new_state && cur->jmp_history_cnt < 40=
 &&
>                             env->jmps_processed - env->prev_jmps_processe=
d < 20 &&
>                             env->insn_processed - env->prev_insn_processe=
d < 100)
>
>
> Or if it is in the else branch. Simply because 'skip_inf_loop_check' is
> for instructions that have been already seen on the current verification =
path.
>
> However, with change suggested in this patch-set such ENOMEM situation
> is not possible. Hence I insist that large enough jmp_history_cnt
> should force a new state, and point where I put the check covers more
> cases then alternatives.
>

I think we are in agreement that jmp_history_cnt should cause a new
state. But ok, using force_new_state is fine by me, it actually allows
us to remove duplication of logic. But then let's do this (it gets
unwieldy to combine variable declaration and initialization, it's
non-trivial amount of logic, should be its own statement):

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 587a6c76e564..1f30ef99b246 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17886,9 +17886,11 @@ static int is_state_visited(struct
bpf_verifier_env *env, int insn_idx)
        struct bpf_verifier_state_list *sl, **pprev;
        struct bpf_verifier_state *cur =3D env->cur_state, *new, *loop_entr=
y;
        int i, j, n, err, states_cnt =3D 0;
-       bool force_new_state =3D env->test_state_freq ||
is_force_checkpoint(env, insn_idx);
-       bool add_new_state =3D force_new_state;
-       bool force_exact;
+       bool force_new_state, add_new_state, force_exact;
+
+       force_new_state =3D env->test_state_freq ||
+                         is_force_checkpoint(env, insn_idx) ||
+                         cur->jmp_history_cnt > 40;

        /* bpf progs typically have pruning point every 4 instructions
         * http://vger.kernel.org/bpfconf2019.html#session-1
@@ -17898,6 +17900,7 @@ static int is_state_visited(struct
bpf_verifier_env *env, int insn_idx)
         * In tests that amounts to up to 50% reduction into total verifier
         * memory consumption and 20% verifier time speedup.
         */
+       add_new_state =3D force_new_state;
        if (env->jmps_processed - env->prev_jmps_processed >=3D 2 &&
            env->insn_processed - env->prev_insn_processed >=3D 8)
                add_new_state =3D true;

There is no need to adjust skip_inf_loop_check condition because it
will already work fine due to !force_new_state check there. No?

And I wouldn't elaborate *that* much in a comment about
jmp_history_cnt > 40. It's a heuristic, we keep jump history short
enough. Multi-line comment here is just distracting, IMO. I wouldn't
add MAX_JMPS_PER_STATE as well, it sounds way too "official". It's a
heuristic, not some sort of fundamental rule.

