Return-Path: <bpf+bounces-22186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1F85883C
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847021C22C2C
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 21:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7EE1468F6;
	Fri, 16 Feb 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr3pFSYg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F41353E4
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120271; cv=none; b=LkJh5B//uY8GN4ISJwlTydENZVYGZmIxO5mZugxmIgln3XcVCTYysWHpGhAG+5n3m7yGMDXGQfKapcJLo8H3eHmgdZ4PY49kr118+SeH78pVl5zulhljlUaIUyWRrCbuWB4Uw8Bqo5YDAHN3J7GVJWeOZmKuC+ZnNYbK5kMKgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120271; c=relaxed/simple;
	bh=Qk/j6lgdX4EoSPpWyCe+gym0012jLqvesRLRuFcft04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6kOUaMyFEGqCTgQnxVBHWdsSXUBe2n0+VmnC9T9OxGfWPqx2JzEfOKLkBYA8Bp/6g9DQIHF8qCLhBgAYddSYoSUygMs1QTs6poFyQxkCKokF8IUugpWZwCdqHGSszaWb2Af0lRvP3WDHOFFWLk3ttYiH+yI4L/+iitDNF1c95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr3pFSYg; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso1161228a12.3
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 13:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708120268; x=1708725068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M8TwBw4qK+L3ieZoXtTUeQ1CsSCLG2w8qKNE1YhSq+U=;
        b=Yr3pFSYgrBUe7Y+Hwgy6skC5X+5eSDzkwxRaJZ80QBOcdWcwwVArNLH0A4ntNdk0rs
         RRUt8ADL9X8LL1El6zxEvFV5meLZ0ijC+SPK/NiCZJ2Q4qXSB8ceyKxgowZROvgVEfqY
         WZrfKn1TkOnlVujWEYFZwXz582w3CXyk0M67sfAmTojA5nxHcIBdkwB02J3ltCtUlvjH
         uBZJAhha4scf/6GboWGyeDWSicaN9YWvKRRgv+9dnvugxwDLh9IXKzt7OlbUlT/u36G4
         L0D424aQtXhlNiAyNSkQ4mA4UAgUH0idPunacIQ9Xj3BPF3AEmi78ajbQlFYBhaRRXur
         r10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708120268; x=1708725068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8TwBw4qK+L3ieZoXtTUeQ1CsSCLG2w8qKNE1YhSq+U=;
        b=PPdxYGCIOgBRhKU+1EVQcozxKtypRZucKvWdMxxsxxVFCvlTIkUeHxfEN5bl0eqN1o
         Hjxm0EV/zOOIXw2bwCe2+wdY9KvXjelwKWVWaWzJYiTDSs8qLv275bReFEVrirzSC8tp
         orMS7SwGogY9+VlNCEYJ+hN3QdA5zpIJrN3Z+Wk7h0IJTWYRiqZDuphQdNlDt8VGXcrp
         MMiVkltmhbFJpyikJwgqn5cf4ge7r7wGL/xJB1wG1JgtrhAojaE0QkbajIMPAg2WjHWk
         RGuCTlDIouEb6saSLSX/S2qn7FIUAAdUQ/xIN7yKgXRPYKkpdmwE8kNJ59r/Rhl0k2ku
         uGBA==
X-Gm-Message-State: AOJu0YxFDcWbb/U3t/QzkfG4cOtvAre7Ral5gdfYQK5B/ghT70R17QES
	/KsAcJz6Y6U1NmUejigNjrPyZxClp7GyIpGbKY6/YYZEH1Zxh/PiItwWB8BAQhqCVFJBj9uE7yj
	zN3qI6MSehLy9IcwWijy+KMp8u+w=
X-Google-Smtp-Source: AGHT+IF5xNHbRTyH1O9PMtUiToMDqK0dI/SKEC5G0Y0RFWrTIPtpIA+TaW5kHxQte4WvdAMwElWFxYKPVJ0R5gCZFRI=
X-Received: by 2002:a17:906:416:b0:a3c:c62d:81dc with SMTP id
 d22-20020a170906041600b00a3cc62d81dcmr4343019eja.61.1708120267779; Fri, 16
 Feb 2024 13:51:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-5-memxor@gmail.com>
 <95ec346d0b294e9d72b524d07af02c987aa59460.camel@gmail.com>
In-Reply-To: <95ec346d0b294e9d72b524d07af02c987aa59460.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Feb 2024 22:50:31 +0100
Message-ID: <CAP01T751XHSFWNhYKxyqg2rhMoMVEsooM52Phgw67bGHY1d02A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 04/14] bpf: Refactor check_pseudo_btf_id's BTF
 reference bump
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 02:11, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-02-01 at 04:20 +0000, Kumar Kartikeya Dwivedi wrote:
> > Refactor check_pseudo_btf_id's code which adds a new BTF reference to
> > the used_btfs into a separate helper function called add_used_btfs. This
> > will be later useful in exception frame generation to take BTF
> > references with their modules, so that we can keep the modules alive
> > whose functions may be required to unwind a given BPF program when it
> > eventually throws an exception.
>
> [...]
>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > +static int add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
>
> [...]
>
> > +     if (env->used_btf_cnt >= MAX_USED_BTFS) {
> > +             err = -E2BIG;
> > +             goto err;
>
> Nit: could be "return -E2BIG"
>

Ack, will fix.

> > +     }
> > +
> > +     btf_mod = &env->used_btfs[env->used_btf_cnt];
> > +     btf_mod->btf = btf;
> > +     btf_mod->module = NULL;
> > +
> > +     /* if we reference variables from kernel module, bump its refcount */
> > +     if (btf_is_module(btf)) {
> > +             btf_mod->module = btf_try_get_module(btf);
> > +             if (!btf_mod->module) {
> > +                     err = -ENXIO;
> > +                     goto err;
>
> Nit: could be "return -ENXIO"
>

Ack.

