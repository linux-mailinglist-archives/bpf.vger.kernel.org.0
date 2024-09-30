Return-Path: <bpf+bounces-40576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0998A3B6
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 14:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597CC281169
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED199191F6A;
	Mon, 30 Sep 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+hSkP2Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221719047C;
	Mon, 30 Sep 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700927; cv=none; b=PM4t7lP6/URyfy7Fj57ETLIfwFtrHHSItDOrOyKlOUcyxUgvDf92yc58pp+/JoV3D0Cn8o2zSEabksmZSf4Dtwf/azKsTddPzL/Tl208rFj3H8Fi0edEP3w8B81lypdYuJxXOcMlke6PU1iktK9xcdjjvzTfQuPjwlOb84Ahmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700927; c=relaxed/simple;
	bh=Gk/MlzXPGsQXnrgmA5gATxDRF2Y8DhE2qfDS+aaSIqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i37ZfXoIC6ldSkAIPSYKWhPl6qQx5jJrMBQVdw5zKkr5k+UOht/udNqEoriI/M4ub+eL2vuja4Uk/4/JZehVS+/vRRb2CUeX32k4mjzC7PqcVTAS2PRqxrgGRZmwgDUyulVjCXJOkwpH2qWxxiIUbbxZ6or3P18b+um82uvHwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+hSkP2Q; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37cdb6ebc1cso1352067f8f.1;
        Mon, 30 Sep 2024 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727700924; x=1728305724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOdgvaXJUr2scM3z+ssnO26BlcF10nfkej0+ZEZfU68=;
        b=U+hSkP2Qmahy6GFsgxkeD+/nyK1hTICLYaLibCoPtJIXK8XGukfJk90je8GhJgbjDn
         yvVlFTaqc53TevtfX4usa/q38HnJZXfDAMmDzyv+/uUrTJjF/vJvqkt1IaJRFi/zh/db
         c6ZBsOnhI9rqPrALivCtwzCK1Q3zfXEgiOcSG30x3OrK+cEUjkk+Lu/rSaPwk5DsNpoB
         RfOriUFlVFeWww0Ri843EBn1LxxhW+GMerxWxpM43rC3CP/3JhRkF1pr7h3BtdWIy7Qf
         jKrze91ZEEeUFo6R11UYauqTk5GVe5wntYYrRcOVc3kEy/pBYI+ZNi0CIfIIt5Y9dO7l
         f75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700924; x=1728305724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOdgvaXJUr2scM3z+ssnO26BlcF10nfkej0+ZEZfU68=;
        b=AjNypndEOW15my9bVISc5yXJXqJenA4G4hZDUgZc+GNe+Qp5TxNGQnVOld+VKZR41R
         nyxUQs9v4EZ+TmQXyCn4CclKv/SZJzxcLFlbJeQVdUWXsbwyzc+YjeTuXVFiYo2CZ3KY
         1DNsVwH5pkKCzhKbu9rC+8P4sZIMsQfXMp6Sjeue8fvJ3zUepkKrxKMTwWNEY195CKu6
         PLIqKPMFCfNG5JVcXY9T+K9ydGErM3CEgrghipJza69+lTQVxsw3CHSOvwuD+EgswoSg
         S2ioITMsUgvm73I3XPfdxCNhmTEbjCSLUkrpcN1BGGW5QY5sVXaRIYWpiDDYoeOulBwd
         iXEg==
X-Forwarded-Encrypted: i=1; AJvYcCVaOeJu89RyEC5FDhuLUkYvrzC5Hs4M6N5DJGVikpqs0aE2JyodqDx+j18yYMpxBXxD1tE5cijBcptteVbo@vger.kernel.org, AJvYcCWIhaJ+2QoCqKkZQafkLn1ntkiVFU4mIquHH4M02TwjoyuszN1SQBG5REgyIQ3jL+ULxMMULIK1H0UnQv8OEQXPcUIz@vger.kernel.org, AJvYcCX5Av0DYrTZ51bmMs2yIucbrqorh/TmmcOZf23s7pu+xEbdckHkW89OSbwyKKmYH+h/vy4=@vger.kernel.org, AJvYcCXmrijLJz55PYrRM52Dt8cUqOPFUQvJGjilPkQR2ZjNBbSbOKjwmMoJfxMxsfIUEzV+KWll2CLhMbpkU9rs@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRwmf68o+NFvGZ41q6yrBFK4JT0NxMjAX0uMavBRtbD6yPO9n
	ruY612/tmfXA/htJFcNWqNhYbQnpR3VkGJKNh3KZW4uxWby7lFDcwQAX6orymcGJJzoaOm1OKUb
	n0/hk7UUI3G5veneEldWRBj7iZgs=
X-Google-Smtp-Source: AGHT+IHymJjkPXI8wOmPdK0T7Ia8AkydMnY3GRDEvq8x/rrmB/r7QHqVuIQcCxZGJgE+W0IpzTVVD77B8tn93lNQMW8=
X-Received: by 2002:adf:e881:0:b0:37c:ce26:95eb with SMTP id
 ffacd0b85a97d-37cd5aaf848mr5807426f8f.2.1727700923809; Mon, 30 Sep 2024
 05:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915205648.830121-1-hbathini@linux.ibm.com>
 <20240915205648.830121-18-hbathini@linux.ibm.com> <CAADnVQL60XXW95tgwKn3kVgSQAN7gr1STy=APuO1xQD7mz-aXA@mail.gmail.com>
 <32249e74-633d-4757-8931-742b682a63d3@linux.ibm.com>
In-Reply-To: <32249e74-633d-4757-8931-742b682a63d3@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 05:55:12 -0700
Message-ID: <CAADnVQKfSH_zkP0-TwOB_BLxCBH9efot9mk03uRuooCTMmWnWA@mail.gmail.com>
Subject: Re: [PATCH v5 17/17] powerpc64/bpf: Add support for bpf trampolines
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"Naveen N. Rao" <naveen@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Vishal Chourasia <vishalc@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 10:33=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
>
>
>
> On 17/09/24 1:20 pm, Alexei Starovoitov wrote:
> > On Sun, Sep 15, 2024 at 10:58=E2=80=AFPM Hari Bathini <hbathini@linux.i=
bm.com> wrote:
> >>
> >> +
> >> +       /*
> >> +        * Generated stack layout:
> >> +        *
> >> +        * func prev back chain         [ back chain        ]
> >> +        *                              [                   ]
> >> +        * bpf prog redzone/tailcallcnt [ ...               ] 64 bytes=
 (64-bit powerpc)
> >> +        *                              [                   ] --
> > ...
> >> +
> >> +       /* Dummy frame size for proper unwind - includes 64-bytes red =
zone for 64-bit powerpc */
> >> +       bpf_dummy_frame_size =3D STACK_FRAME_MIN_SIZE + 64;
> >
> > What is the goal of such a large "red zone" ?
> > The kernel stack is a limited resource.
> > Why reserve 64 bytes ?
> > tail call cnt can probably be optional as well.
>
> Hi Alexei, thanks for reviewing.
> FWIW, the redzone on ppc64 is 288 bytes. BPF JIT for ppc64 was using
> a redzone of 80 bytes since tailcall support was introduced [1].
> It came down to 64 bytes thanks to [2]. The red zone is being used
> to save NVRs and tail call count when a stack is not setup. I do
> agree that we should look at optimizing it further. Do you think
> the optimization should go as part of PPC64 trampoline enablement
> being done here or should that be taken up as a separate item, maybe?

The follow up is fine.
It just odd to me that we currently have:

[   unused red zone ] 208 bytes protected

I simply don't understand why we need to waste this much stack space.
Why can't it be zero today ?

> [1]
> https://lore.kernel.org/all/40b65ab2bb3a48837ab047a70887de3ccd70c56b.1474=
661927.git.naveen.n.rao@linux.vnet.ibm.com/
> [2] https://lore.kernel.org/all/20180503230824.3462-11-daniel@iogearbox.n=
et/
>
> Thanks
> Hari

