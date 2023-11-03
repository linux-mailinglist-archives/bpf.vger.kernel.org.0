Return-Path: <bpf+bounces-14068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF77DFFD1
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E8B2136B
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2049848B;
	Fri,  3 Nov 2023 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIbiVTso"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360B8814
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 08:47:49 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE407D50
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 01:47:46 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso1133395fac.2
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699001266; x=1699606066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKiCuHgbUHqJE9fKnzdwd8OkE2RoxZw2aufrexkhmmk=;
        b=iIbiVTso5ugPAYosM3t7A5FO6ctjvfF47t52Xd7a1+MGDVIe66lpqtohHRICloOqDX
         0fmfC1Npvp5qXcUHEdpOEJK9GZ0QM6l7Lo21vsyMYMTwU0vjTRCJ/+HXZuTXNgQt6psO
         J3WXBPaWkL5t1qkXc7KyCe0kGhtKAZPdZQpoC1D86y/sOZLt4P6XdNzrA9P/inKEPi1H
         fhFH8DCrc7qzmRagaWLcJEBiCZqclt681jG21rEAXSbPc+hjXCjwXR6xOYTRUBUNzHWK
         3pF8xkvpawnuHPYbdgU7UTbD2qOEFzxKytvVzDgDe9LFao3lHRM2j0+Tki1db05hShVV
         RW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699001266; x=1699606066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKiCuHgbUHqJE9fKnzdwd8OkE2RoxZw2aufrexkhmmk=;
        b=WesxOznXcdBrgT6IeeqX4W3lhkj7lb13qGkEKnm7+fQlcEPQxL8o0oHqQs1mydprMg
         q1xwUe3k89Ro3eqm8uRSNWWtVfNkWjj7sgqBZqX7RysbxTdkURc300JhO9BoDu1VNZMT
         T5uG43a/9WWPLASKwWe+7rh5FVgRo9ql38Vy2xeK3dfYapXSwrEepjOo8Ut4MPxO0xX7
         Me8fgukM1uTuIFkOw38+PxObfgOJc8HS3tasiG3uFKuELF1xVJu1Kxzmt5INL5iKM5HJ
         7pT5D0nCnH4d9uBgtfsbBqBWI3cJKqRMpFbKfvHJwcUXX3fy5VCbann4TTVTuJv0Ttgz
         E21g==
X-Gm-Message-State: AOJu0YypCR8KCqnBQ1h6HWAjVZ9L4Pajtt1PgA0Ak9RFccRnHasAifqZ
	RHAmm3Rl+4sDvRCGu1VTU0XlBp8PC+2nA0wodq4=
X-Google-Smtp-Source: AGHT+IEvNFP88OsiJYlB3NhmdP5nlNUnLagh+YKjjVIcgS6duLsE22qacJbYC09uE/zQsm28sjGvZAhRvyTqgxVr2LM=
X-Received: by 2002:a05:6870:f21d:b0:1e9:f6c3:8594 with SMTP id
 t29-20020a056870f21d00b001e9f6c38594mr23921680oao.2.1699001266110; Fri, 03
 Nov 2023 01:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031012407.51371-1-hengqi.chen@gmail.com> <20231031012407.51371-2-hengqi.chen@gmail.com>
 <6F41D669-AE0C-4CAE-9328-B03BFF7F5643@kernel.org> <CAEyhmHSROn4=U2e6w8uxer=_R4+d2vZbwrSbq=dHgD9H0ent8A@mail.gmail.com>
In-Reply-To: <CAEyhmHSROn4=U2e6w8uxer=_R4+d2vZbwrSbq=dHgD9H0ent8A@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 3 Nov 2023 16:47:35 +0800
Message-ID: <CAEyhmHT49jXx_jzc6HbKNEipMet+AbXKomq1MP-h0eQbNY4NBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Introduce BPF_PROG_TYPE_SECCOMP
To: Kees Cook <kees@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, keescook@chromium.org, luto@amacapital.net, 
	wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 1:46=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> Hi, Kees:
>
> On Fri, Nov 3, 2023 at 3:49=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> >
> >
> >
> > On October 30, 2023 6:24:02 PM PDT, Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
> > >This adds minimal support for seccomp eBPF programs
> > >which can be hooked into the existing seccomp framework.
> > >This allows users to write seccomp filter in eBPF language
> > >and enables seccomp filter reuse through bpf prog fd and
> > >bpffs. Currently, no helper calls are allowed just like
> > >its cBPF version.
> >
> > I think this is bypassing the seccomp bitmap generation pass, so this w=
ill break (at least) performance.
> >
>
> What if we did the same for eBPF, a bit harder though, does that
> address your concerns ?
>
> > I continue to prefer sticking to only cBPF for seccomp, so let's just u=
se the seccomp syscall to generate the fds.
> >
>
> That's an alternative. But as Alexei said, there would be no more bpffs t=
hings.
> AFAIK, we could only share the filter via UDS.
>

Just take a deeper look, there are too many
registers/instructions/states in eBPF,
stick to cBPF would be easier for now.

> > -Kees
> >
> > --
> > Kees Cook

