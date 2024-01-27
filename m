Return-Path: <bpf+bounces-20446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ECD83E89E
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 01:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0C81C2250B
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9472573;
	Sat, 27 Jan 2024 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqeCW+sY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3AE17C3
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316152; cv=none; b=JIo7Qgz3ko+4jnDukQzJiHUMtmEzt8aGX8GRhK1tOxZ/fWH/GQc5xmgIUlnBKoF4NEuLUw72wwlBzhpSjCX8VAGxzj2rFM8Blz0Xp98T6TSIYMyWF4IR8wX0CyjLjohHsWj1l4CobANaqK+GgeNQhiomyvc4HkN3iXpS7vzhCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316152; c=relaxed/simple;
	bh=i2M+J+Ji6E+mYUem+kuS5mfagoSX2N4uofr7Ps+vCC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfgO2KkE7oq+b62RdDJV6kXBxbXSoPcHoqRIIwYcgyXdT2X/kz48BNYMCxBSZwwbWZC2em/istgHCPFt13gfvR6/k7OIGJ6FuggCSpgRTZwDYb75otVRVZLMvDpp3dOsJgI6PntqMu0FIsuOeB5sA+QmrnkfvG3/IBWX2qIC+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqeCW+sY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ddfb0dac4dso761910b3a.1
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 16:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706316150; x=1706920950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js6dI6p/HKrAfHqWYS0kVmSJMEtQzDA6kH9IwY6rcxM=;
        b=WqeCW+sY51PSTRaNHP2CSNZ3Qzdpr/cpFRBB6PpA6SJNerq0uG6uyuQlVZaHix/Chq
         Uy+1Kq790OZYNk6fJ0lGsNwikwQe/KGCDh8g0i3C8uxr5AVn6mJdm+tH6yM4z/TbkWB7
         F7uOfPyfFvyzehgHXk72qL6bZu9/1lvBJAz5BPNFOfgdG6Ih4jqHUkL57E5fNV+t1RJW
         HgDICTHd3Kpv4+IEWl/AEqxUj6hxRwkU+w53MTTT4GUDCRs/XUlaAe/Kn9J3iIA1loGj
         nyGTNK8W/5VSgOdpMXGs5uetUfiDlykWtHbVcjJDiVkeg9LcW14Pz5nDvnpY2uLC4guk
         4wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706316150; x=1706920950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js6dI6p/HKrAfHqWYS0kVmSJMEtQzDA6kH9IwY6rcxM=;
        b=WJ8LtgE2sJloS39mMzsm1cuBGZ4+ibz7LAVrGlv0UG+7Z/fnjd8avGuxtoY4mZE3YC
         mkJkZDdtrPqeLJaQ4Y2Ln9N7jn8BO5fMb4jyalqJQK1RnPurHPZ9pbX9OD6/wagOSBe5
         TOU+tFTtcT/OO4EyGpJnp0aJQWG7Cz7yRWWPAyWGMmcDLNKFIFRNgabmkqMuKCIgyONT
         cwBgGiG254qAUpQwJ7drUFsA1NjIBPxqLaBNMVC84ZbCWQ5QykqIz4/SM5OcLJZbLMm2
         GNaDdVziUC6foB+6FHWFzLXDZIbWJaezk3IgUBLXO5yc4N+5NTiwe4N9kHi9FjOEK/S2
         vFwA==
X-Gm-Message-State: AOJu0YwC8umXfeAPhhj9+CzzNl00BEWrmfktmP7WBbkG0AuezqPK0Ea1
	WSMgIjjaHjQ24LlhTjkeDJydqNrkdM4MmuAob6sU0wR/TIfnBJIFI0TXY1N3X6FIAdXi/uGhCA7
	dD/M74Y7UlJwSJvIaVdsW8g8TdrU=
X-Google-Smtp-Source: AGHT+IGkk4GvodPk11wuaQYVk/t1Ac7N0rBprJuwfNw0REyQj+1Gs63aG6RMTgi5rl5/GkQr1tTZHnGDeLCY2F3vumg=
X-Received: by 2002:a05:6a00:1e13:b0:6dd:a20e:ae8c with SMTP id
 gx19-20020a056a001e1300b006dda20eae8cmr586152pfb.4.1706316149538; Fri, 26 Jan
 2024 16:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122212217.1391878-1-thinker.li@gmail.com>
 <CAEf4BzbQJXGw3w0RnjuUg=RRMDE9jGgOYxVcA9q9hbYnvFBHhg@mail.gmail.com> <d8bedd40-cab8-4270-b4a4-1681c8d0e393@gmail.com>
In-Reply-To: <d8bedd40-cab8-4270-b4a4-1681c8d0e393@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 16:42:17 -0800
Message-ID: <CAEf4BzZJXPm+AXOeqNJMh3Qqf0VDkv_JNRG=DKW74KA7=p97LA@mail.gmail.com>
Subject: Re: [RFC bpf-next v3] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, davemarchevsky@meta.com, dvernet@meta.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 4:15=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 1/26/24 15:21, Andrii Nakryiko wrote:
> > On Mon, Jan 22, 2024 at 1:22=E2=80=AFPM <thinker.li@gmail.com> wrote:
> >>
> >> From: Kui-Feng Lee <thinker.li@gmail.com>
> >>
> >> Allow passing a null pointer to the operators provided by a struct_ops
> >> object. This is an RFC to collect feedbacks/opinions.
> >>
> >> The previous discussions against v1 came to the conclusion that the
> >> developer should did it in ".is_valid_access". However, recently, kCFI=
 for
> >> struct_ops has been landed. We found it is possible to provide a gener=
ic
> >> way to annotate arguments by adding a suffix after argument names of s=
tub
> >> functions. So, this RFC is resent to present the new idea.
> >>
> >> The function pointers that are passed to struct_ops operators (the fun=
ction
> >> pointers) are always considered reliable until now. They cannot be
> >> null. However, in certain scenarios, it should be possible to pass nul=
l
> >> pointers to these operators. For instance, sched_ext may pass a null
> >> pointer in the struct task type to an operator that is provided by its
> >> struct_ops objects.
> >>
> >> The proposed solution here is to add PTR_MAYBE_NULL annotations to
> >> arguments and create instances of struct bpf_ctx_arg_aux (arg_info) fo=
r
> >> these arguments. These arg_infos will be installed at
> >> prog->aux->ctx_arg_info and will be checked by the BPF verifier when
> >> loading the programs. When a struct_ops program accesses arguments in =
the
> >> ctx, the verifier will call btf_ctx_access() (through
> >> bpf_verifier_ops->is_valid_access) to verify the access. btf_ctx_acces=
s()
> >> will check arg_info and use the information of the matched arg_info to
> >> properly set reg_type.
> >>
> >> For nullable arguments, this patch sets an arg_info to label them with
> >> PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the verifi=
er to
> >> check programs and ensure that they properly check the pointer. The
> >> programs should check if the pointer is null before reading/writing th=
e
> >> pointed memory.
> >>
> >> The implementer of a struct_ops should annotate the arguments that can=
 be
> >> null. The implementer should define a stub function (empty) as a
> >> placeholder for each defined operator. The name of a stub function sho=
uld
> >> be in the pattern "<st_op_type>_stub_<operator name>". For example, fo=
r
> >> test_maybe_null of struct bpf_testmod_ops, it's stub function name sho=
uld
> >> be "bpf_testmod_ops_stub_test_maybe_null". You mark an argument nullab=
le by
> >> suffixing the argument name with "__nullable" at the stub function.  H=
ere
> >> is the example in bpf_testmod.c.
> >>
> >>    static int bpf_testmod_ops_stub_test_maybe_null(int dummy, struct
> >>                  task_struct *task__nullable)
> >
> > let's keep this consistent with __arg_nullable/__arg_maybe_null? ([0])
> > I'd very much prefer __arg_nullable and __nullable vs
> > __arg_maybe_null/__maybe_null, but Alexei didn't like the naming when
> > I posted v1.
> >
> > But in any case, I think it helps to keep similar concepts named
> > similarly, right?
> >
> >    [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240125205=
510.3642094-6-andrii@kernel.org/
>
> Let me paraphrase it. "__arg_maybe_null" is prefered for the case here.

See [0], seems like you can stick to __nullable, and I'll update my
patch set with __arg_nullable. User-facing naming will be consistent.
Verifier internally will keep using PTR_MAYBE_NULL flag, of course.

  [0] https://lore.kernel.org/bpf/CAADnVQKx3RK8pK4xpNEPQKYGUemO0VjdRePdr34f=
JwHZs6Urag@mail.gmail.com/

>
> >
> >>    {
> >>            return 0;
> >>    }
> >>
> >> This means that the argument 1 (2nd) of bpf_testmod_ops->test_maybe_nu=
ll,
> >> which is a function pointer that can be null. With this annotation, th=
e
> >> verifier will understand how to check programs using this arguments.  =
A BPF
> >> program that implement test_maybe_null should check the pointer to mak=
e
> >> sure it is not null before using it. For example,
> >>
> >>    if (task__nullable)
> >>        save_tgid =3D task__nullable->tgid
> >>
> >> Without the check, the verifier will reject the program.
> >>
> >> Since we already has stub functions for kCFI, we just reuse these stub
> >> functions with the naming convention mentioned earlier. These stub
> >> functions with the naming convention is only required if there are nul=
lable
> >> arguments to annotate. For functions without nullable arguments, stub
> >> functions are not necessary for the purpose of this patch.
> >>
> >> ---
> >>
> >
> > [...]

