Return-Path: <bpf+bounces-50086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74DAA22756
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCE6164434
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E61F16B;
	Thu, 30 Jan 2025 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buuoEBfU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88688BEC;
	Thu, 30 Jan 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198280; cv=none; b=tfQQmJtAOZLZBNuotAsXxrcTHr2hf2k3SWkOhNB+Z4yYfT2L5YavXuZ/CwhJi59/gMgTt+c9fSy/T+DnMmCy2vmWd+ZrhbSQK7QcYnRRvvr1XlpnBkh/wd+5ueYOis0iDgrq16P8Z1oFaW8rpYqZczDvgGtqXCHKpPD5zfVrANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198280; c=relaxed/simple;
	bh=jCfUknLaS1CyXTihImqPVo1F8ohfKeiPfI+MZmVjZ7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwPIf6NH4+SaZrR9GDSBRF9RuRoGG87vfNodLtZbbTy+j4BEel+VWEZ+A0Y3MKhMdY3TqnykK+VB6JkqH1G6XLNTHmcjdvFa2u625x7T+thG1sp/JflYFwKnOCL2Ar937cjJcBG6WGHvxlmjP/ulfCMZ3jsQi8dI0muyuE9r7a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buuoEBfU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2156e078563so3006845ad.2;
        Wed, 29 Jan 2025 16:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738198277; x=1738803077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfbNo5NJ7RPH7bh4Cu1MrHcyTN0KV+XSd/Gkhk5up30=;
        b=buuoEBfUp/fBzkOHNnYZUOPDqNNYXeIV4UqFgGUlzuwln176QUJrROqSJWjJmY9d3i
         I5WXLg/GX9i8G35t00qZ4w4DLeGhMzBtqajl15GZ0+p0kSLtgsGFXLAd3/yTbpZ/9CUQ
         HXfnSailYKCs5uS/aL24O8Ei1mNVxFc/ZVU/XTKAsYniZr5BGfy2LKJ93lmF799nXfYL
         sBrXlxustn5LkW1b7gV2HSkCrShmaxinuuU4CU0SO0FWetagGSui6LkP/koxZCdXKEPZ
         WA1BoDTov4uScaT4blqBZNzYZYO+/v07yMBXvZlHPEWSmHvYCashw/XHeBxum9nUD+/c
         aUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738198277; x=1738803077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfbNo5NJ7RPH7bh4Cu1MrHcyTN0KV+XSd/Gkhk5up30=;
        b=NUgK5HkeBxdzSz6vpd5Gm7WLbO8w8Vq3B6rxlQeQCQfpeukQrQaI9P8dqUpQLP89+i
         0VY0k9Fvc50QkXjxfrvrzCXziEVMpkywmqUiotaSTk71POpVQsXNn1rqz6GReteyvHHc
         2f1nSwxQte4BgZSVX+d9BZ4+fW2S/lVKV8CxmLA4M2kh+rJ9EhxAjwcbMzd/3/U+62Qg
         yQRpdLa6XEMMAC5tPs+VSLRgu5M6PnQVmQav8OPk8T7oHa6Abn1+cei46fkST6vW1NnY
         s+kt4LetIq35G3tjxNAplczVqbkjvw48onhrZ9hqpX+HtLgQ45ES6UnGwQkqBymx2SVK
         mK6w==
X-Forwarded-Encrypted: i=1; AJvYcCUkkHx9Q14QjUN+0bEDc6kTxIOvE1dCNfeYHdmdZo008VS+4J+vEbU57kAkZRrh1kRWBcjAKC1ArojTkWmF@vger.kernel.org, AJvYcCUtQhebWLThWl73qsmOpe51VCZjQrS1y3srX4wCoC5XuCyMQcQ9hQneynNMF6XY3tktD7eNLNOea48qLZU=@vger.kernel.org, AJvYcCVyodWruTKBs6E86KBK5GSK2G3YS0CwKrQKA4QjS/B/hLp1hduxicx+g5+71kfsp5PfZNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ZGZ+RwkPFH+KOhf7LbAExcIy+2cufwwAq4lGJaztcJHmd8Mk
	3X6KVvdea+faCzNafZHpR622Te4XKk9mN73FlhZDt9Qp2ZsfVZEmHn0FJpg7+f31DR6KW1AALht
	APj8a4h1ZPY7P02k6UBS9IJMGo5M=
X-Gm-Gg: ASbGnctv21NgM4SxELKXZCU1bfU7DnzksnqLH1eqy1FMy6NXs9fI/fl41YaGj746xi5
	PV5iZfl/8emqt3WzGfS9gQ+AHiwwCWdsCLkSKMwaS7NKxxY9U0wCUScuSn6QY3ZER/V1Zu93pLu
	jkrRWYHiDFchpn
X-Google-Smtp-Source: AGHT+IGgaBMbfH+DAGW8rfwUFWjT/jC/KKLsk8AdYQ5680s3xyLzrfazlu6u+aG3v6IXn4AndfWzjwNBFBA528z2ehc=
X-Received: by 2002:a05:6a20:9c8e:b0:1e1:b1bb:87a0 with SMTP id
 adf61e73a8af0-1ed7a6b79d7mr11003646637.34.1738198276838; Wed, 29 Jan 2025
 16:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123081950.173588-1-jinghao7@illinois.edu>
 <20250123081950.173588-3-jinghao7@illinois.edu> <CAEf4BzbCm4=NLV4DOyRxvxEtZUONzqmXBOFMp5cg=4hPEEYUtA@mail.gmail.com>
 <2sxhtfdzspkn5umtfpxiueb67v4jhl3nad6i66qtfry52o7sip@nm5oeplybppa> <501166cc-02fe-431c-9258-c2f44227ebc4@illinois.edu>
In-Reply-To: <501166cc-02fe-431c-9258-c2f44227ebc4@illinois.edu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jan 2025 16:51:02 -0800
X-Gm-Features: AWEUYZn8HiygP7sKOljXPFeDY8nAwVLLg472aD4TUx7AZvMx7otTHm9d20Mh5j4
Message-ID: <CAEf4BzbYUsPzyVkDOKYhKc+Gs4O=mZExJ1_gc=t1siMz8kvn2Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] samples/{bpf,hid}: fix broken vmlinux path for VMLINUX_BTF
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <n.schier@avm.de>, Ruowen Qin <ruqin@redhat.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 2:06=E2=80=AFAM Jinghao Jia <jinghao7@illinois.edu>=
 wrote:
>
>
>
> On 1/24/25 2:04 PM, Benjamin Tissoires wrote:
> > On Jan 24 2025, Andrii Nakryiko wrote:
> >> On Thu, Jan 23, 2025 at 12:20=E2=80=AFAM Jinghao Jia <jinghao7@illinoi=
s.edu> wrote:
> >>>
> >>> Commit 13b25489b6f8 ("kbuild: change working directory to external
> >>> module directory with M=3D") changed kbuild working directory of bpf =
and
> >>> hid samples to samples/{bpf,hid}, which broke the vmlinux path for
> >>> VMLINUX_BTF, as the Makefiles assume the current work directory to be
> >>> the kernel output directory and use a relative path (i.e., ./vmlinux)=
:
> >>>
> >>>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "=
  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF =
like "VMLINUX_BTF=3D/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
> >>>
> >>> Correctly refer to the kernel output directory using $(objtree).
> >>>
> >>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external mo=
dule directory with M=3D")
> >>> Tested-by: Ruowen Qin <ruqin@redhat.com>
> >>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> >>> ---
> >>>  samples/bpf/Makefile | 2 +-
> >>>  samples/hid/Makefile | 2 +-
> >>>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>
> >> can you please split samples/bpf from samples/hid changes, so we can
> >> land samples/bpf fix through bpf-next tree independently from other
> >> changes?
> >
> > FWIW, I don't mind if this goes through the bpf-next tree all at once.
> >
> > Acked-by: Benjamin Tissoires <bentiss@kernel.org>
> >
> > Cheers,
> > Benjamin
> >
>
> I wonder how we are going to move forward with this fix? Do we want to le=
t
> it go through bpf tree at once or split the changes?

I'd prefer the split and routing through respective trees. Is there
any reason not to do that?

>
> Best,
> Jinghao
>
> >>
> >> pw-bot: cr
> >>
> >>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >>> index 96a05e70ace3..f5865fbbae62 100644
> >>> --- a/samples/bpf/Makefile
> >>> +++ b/samples/bpf/Makefile
> >>> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS :=3D $(TPR=
OGS_CFLAGS) -D__must_check=3D
> >>>
> >>>  VMLINUX_BTF_PATHS ?=3D $(abspath $(if $(O),$(O)/vmlinux))           =
                     \
> >>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)=
/vmlinux)) \
> >>> -                    $(abspath ./vmlinux)
> >>> +                    $(abspath $(objtree)/vmlinux)
> >>>  VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATH=
S))))
> >>>
> >>>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> >>> diff --git a/samples/hid/Makefile b/samples/hid/Makefile
> >>> index 69159c81d045..db5a077c77fc 100644
> >>> --- a/samples/hid/Makefile
> >>> +++ b/samples/hid/Makefile
> >>> @@ -164,7 +164,7 @@ $(obj)/hid_surface_dial.o: $(obj)/hid_surface_dia=
l.skel.h
> >>>
> >>>  VMLINUX_BTF_PATHS ?=3D $(abspath $(if $(O),$(O)/vmlinux))           =
                     \
> >>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)=
/vmlinux)) \
> >>> -                    $(abspath ./vmlinux)
> >>> +                    $(abspath $(objtree)/vmlinux)
> >>>  VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATH=
S))))
> >>>
> >>>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> >>> --
> >>> 2.48.1
> >>>
>

