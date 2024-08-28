Return-Path: <bpf+bounces-38306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F2963050
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 20:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D062816D1
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40B31AAE06;
	Wed, 28 Aug 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEu000+1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8D1D696
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870611; cv=none; b=ivKJo1A7aWwGeIvRDKG8/D7ku8ONGEMltsD4SdFXVSHmnHybrg2BKIrAWjRJZTMFYO1/sFYZUfUheJZgV13DqCL4NnjANAMDrlijO4Fut49ZjHNYsg9/t9qjDhGxLldwkwidcbS85hjjB68yx44xOgGAFgKvoscIXgI5e3ybAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870611; c=relaxed/simple;
	bh=JLfch2l80aGjL5I585jyrdgFI8z+twgwD28pktCNFh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRK6aIAp7Akju+O5QGQqVeJkmgfjrS3AWTwrFUkQzEGWN7U0KDGJ1IMZ3BlH8dV2orkCOM0DoxunuTBOkyf5kOV01N2fzh0+O90kT6xrHu19BbKlUpl+QEczbBhabMl0DDDpUw7w0PMOp3FqQ7QQC+/XXFxBpU5dwmjporCLgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEu000+1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3719398eafcso4102587f8f.1
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 11:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724870608; x=1725475408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCpSmCL/av8nO2rS13wcAAxRAiSBhen3pOGYGJuWs6M=;
        b=cEu000+1YLeREtxHsWmyOu6ssF3uG7vy6HXKOWBbRd7NJsqk6rbRuP4gH8+G9kNAQG
         TNN4kXcm0Wr0j/xKCB3ijrXpkUQnWrwsKai/WyAYWfQF11L3y5M17I1ZQoNq4x5vE+bn
         ADQ8S78yzcgrChZRWzSDS9KfmerMySspdoNkcb48CfJTmyXYxcPbnVxaJKE+fAL6XxNY
         slo1dAfDGuuaBMIzW5hIDo65yyMB/WHEtSGMgtlu/qIm1V138+qrsR/elb0JgMN+6Rjx
         m4GVRxtlS+jjuROmaY4FLQtOp9DX1tjuBhlJiDJpEzEtoPh4GEP82jSLsaogXp6oSWah
         31Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724870608; x=1725475408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCpSmCL/av8nO2rS13wcAAxRAiSBhen3pOGYGJuWs6M=;
        b=La2qBuFVAwMneK+Ln6b34K9lRi/+ZxSu7uP8V7LjACdOW6zbfjd7C8d61GI7DhIc53
         HX14XN+pDLI6pprO38xin4/C7MUNwDeqg4KdFzAqmdYnVE7MVtBwhhBQ63cT236Avdhw
         MvSQ7EuXsPXX9DzVgmbv/FOpHXPpFVKLzx4eP1ABRIYB+htevsk0vaWhx2AqKwHjygBo
         40bdBdaKu305VJgS0w663oTF3dxI7vl56D1pgf33wJHwpJcG2ur4V1JeEyC4M9sW0GmA
         kOsjNeXWQihJ3UxVIxc9tv4N+VK7aChVeLNY9i5Kpa+va/gnlOHYNitcBjTkyBZfPTl5
         mjdw==
X-Gm-Message-State: AOJu0YwVK5CgsbFAblPW8Vx2v+4j9zSbBjAThT0mkbYswtGPzd/JA0QM
	4FSKpblDb4U2YRUbRSFAx9SVuGaSHpvK/BZ3Ri0FFE27hoLPwRTfRtTuqaXAh0/kXNQhZHn5xDp
	lRjypuX5nfOnK6rDzhusejpCc1ZA=
X-Google-Smtp-Source: AGHT+IHaMJgWNpyE3yAO6nXwycDMLebjWyPFhGwhJUUxMIgaDLJgFG/iRcBXOSwKLqwv9JwxIgp8CbSptU28ny2BGYc=
X-Received: by 2002:adf:8bd1:0:b0:362:8ec2:53d6 with SMTP id
 ffacd0b85a97d-3749b5948fdmr291411f8f.61.1724870608055; Wed, 28 Aug 2024
 11:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827195208.1435815-1-martin.lau@linux.dev> <CAADnVQJbGCB5Hjb8NPU7P0ZOwR_EWcREuxsBOvyo7cRggdioDA@mail.gmail.com>
 <669bc1c6-2c8c-483f-8d38-0a705463a25d@linux.dev>
In-Reply-To: <669bc1c6-2c8c-483f-8d38-0a705463a25d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 11:43:16 -0700
Message-ID: <CAADnVQ+0qWRDvRouyZoikYAf=EQepPyuOWrk4oH+h8s1wJW-YA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/9] bpf: Adjust BPF_JMP that jumps to the 1st
 insn of the prologue
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:44=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
> >>
> >> -       for (i =3D 0; i < insn_cnt; i++, insn++) {
> >> +       for (i =3D skip_cnt; i < insn_cnt; i++, insn++) {
> >
> > Do we really need to add this argument?
> >
> >> -               WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
> >> +               WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1, 0)=
);
> >
> > We can always do for (i =3D delta; ...
> >
> > The above case of skip_cnt =3D=3D 0 is lucky to work this way.
> > It would be less surprising to skip all insns in the patch.
> > Maybe I'm missing something.
>
> For subprog_start case, tgt_idx (where the patch started) may not be 0. H=
ow
> about this:
>
>         for (i =3D 0; i < insn_cnt; i++, insn++) {
>                 if (tgt_idx <=3D i && i < tgt_idx + delta)
>                         continue;

Yeah. Right. Same idea, but certainly your way is more correct
instead of my buggy proposal.

In that sense the "for (i =3D skip_cnt" approach
is also a bit buggy, if tgt_idx !=3D 0.

