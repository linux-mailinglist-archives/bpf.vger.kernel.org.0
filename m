Return-Path: <bpf+bounces-38182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F1A9614D5
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2003E283522
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB7C1C9EAD;
	Tue, 27 Aug 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaJ6uBSd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDA45025
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778067; cv=none; b=OarNRyZzvrHf1gkwxLA4UcScGPnUQjEr7YXsp/+XXAPS37tbXQjYWsukGClkavvsyi6s1lNZxw/grPUe2AfCuhuKVkXbrbaWf5Us3l0yhM1NG4thiIqq4XNomG5mmu34UzNLmrumc95OmnrKSb/G0gTNv286cMuDzDg/CZSZqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778067; c=relaxed/simple;
	bh=vytvSJ1kSZta2JvaDE7knomvz0Tex/K7NCAcaU0SSfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=og94uwGzSxbQoBI0NxXHwcaHhYYVgkUeoQX23L8P1j9cQqVewfH+2FY/C114a+x+1i+N2Zym4LOzZJdv4nt6DGE+rObmNzkXELncU0RjEnz2sBvN0wsTZeKIXtl/p7Mgo4iRcBy01RhC5HoQ7WaQjQmOZTFkZmzTb7pl1bCslrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaJ6uBSd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d439583573so4182348a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724778065; x=1725382865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5snOsMKkskeeWvYsLYpbmKWRu6ocqwFH8f+X8NXzeZ0=;
        b=jaJ6uBSdFw5vQmXW/7YQeeU+HTu30TtQ0R64lp652+5CKp+5QmHnnxyIJBACHzUsyi
         Rnq0VRNjMIKgfSK2blC4mglSKZ32TU5VdOAEAr3j8VIlNi/8o24Ia7Wfw6mfufVLDtGK
         t29CYxD2ZUzwyJ+zyHvY3Fx1zs09a87UIBQEVuEoIynkW9HuRL7ksTGnOowWiCmh0AX4
         r9hh9EB/c75BZo2+kgm0hMl1U2GIv6adJWsjDvhXPHfDUItjMEO2niPF+GkFt/eN0rdv
         In8b4YIcgOPJUz6Kn5sk6Rsut7048/F24a4RzEbmt+8tyGalxd4+yN/U+lOYFoJAHrwI
         By2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778065; x=1725382865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5snOsMKkskeeWvYsLYpbmKWRu6ocqwFH8f+X8NXzeZ0=;
        b=tWGQ0IV5O9xFn3byZHsBqyoSNdgsQ6VCo9R4ZSBsB23xbG6/GKtwUl3HlbKuuEt/gi
         R8OW9LWykQ944ihPri0zlt2G91lraqyrMjWOf7psJmlKPdRxMDXZVOvvZRYtC/ZLhGDF
         AoKhYbCo4Ldl7SF25oL/x5RCFJBFpMG+9nkuCfUmQNc+DS2GHYtiiWATJzYhig5MxnyR
         R6QIvp9bvuPQJuxXGP3XkeQmp6vhHmMle4Ur5jzaV5Q2/fV1llHZyEzk3G1DTgRTpt0M
         EXFLaGv3ek/bt3omroiq9fOUUCTMY6P7ogC+UpNbB7sjHExqZZpmoKG+j1VG3QSROgTe
         PiIg==
X-Gm-Message-State: AOJu0YxM9KHn/RRLVGEwTRVLPYpponrznB2WNBF0gzmzyYntkTx8Iusy
	KR0izxN0DoCv41QTxu/lrA4hQz7oL5295wcJeiQ2umhe+FY9ESSVFFeyXKquASpqNQWbQ8preok
	vPCyOfHt8YiZ43k2pYe03+o9cykI=
X-Google-Smtp-Source: AGHT+IH46B8lhU1Q/T5ZE22cJYjojX3tkAbaDnIRjRzHN4KgK/TQMH51QouaR0YR4Ya+YTMOgHbiKsjPOSpU3twsELA=
X-Received: by 2002:a17:90b:3881:b0:2d3:b5ca:f1e9 with SMTP id
 98e67ed59e1d1-2d8259cfe7dmr3804130a91.33.1724778064704; Tue, 27 Aug 2024
 10:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TCvb-R45mBUJOpoW3V-tLkH2XppfNXYbkv7Ph0ae8J9MZKWFvQ3nkJw74KKMbMzzpAvbwXBwRuBmhFOtHl0-jLLrIALH-_2_Zp-MZ9pPXPo=@pm.me>
 <CAEf4BzaixE=-+YnowJhZMDk0SoVdZTHgx-X+3UwnJVUnXxkXzQ@mail.gmail.com> <NlxQiywYmu4MyGt1DSHPsHoslAKqqqeFoMBQ04NZsJITsVCbnucbWel87tw50N0sU_TrQ1osPMNLt5_iTBisRhm2rYn262Ip0ZrJMAL0sYc=@pm.me>
In-Reply-To: <NlxQiywYmu4MyGt1DSHPsHoslAKqqqeFoMBQ04NZsJITsVCbnucbWel87tw50N0sU_TrQ1osPMNLt5_iTBisRhm2rYn262Ip0ZrJMAL0sYc=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 10:00:52 -0700
Message-ID: <CAEf4BzYQ-j2i_xjs94Nn=8+FVfkWt51mLZyiYKiz9oA4Z=pCeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: compare vmlinux.h checksum when
 building %.bpf.o
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 6:22=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> Hi Andrii, thanks for a review.
>
> On Monday, August 26th, 2024 at 2:59 PM, Andrii Nakryiko <andrii.nakryiko=
@gmail.com> wrote:
>
> [...]
>
> > I'm not sure what md5sum buys us here, tbh... To compute checksum you
> > need to read entire contents anyways, so you are not really saving
> > anything performance-wise.
> >
> > I was originally thinking that we'll extend existing rule for
> > $(INCLUDE_DIR)/vmlinux.h to do bpftool dump into temporary file, then
> > do `cmp --silent` over it and existing vmlinux.h (if it does exist, of
> > course), and if they are identical just exit and not modify anything.
> > If not, we just mv temp file over destination vmlinux.h.
>
> >
> > In my head this would prevent make from triggering dependent targets
> > because vmlinux.h's modification time won't change.
> >
> > Does the above not work?
>
> I tried your suggestion and it works too. I like it better, as it's a
> smaller change (see below).
>
> A checksum was just the first idea I had about saving the previous
> state of vmlinux.h, and I went with it. Copying an entire file seemed
> excessive to me, but it's not necessary as it turns out.
>
> Please let me know if the cmp version is ok, and I'll send v2 of the
> patch.
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index c120617b64ad..25412b9194bd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -402,7 +402,8 @@ endif
>  $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
>  ifeq ($(VMLINUX_H),)
>         $(call msg,GEN,,$@)
> -       $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
> +       $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $(INCLUDE_=
DIR)/.vmlinux.h.tmp
> +       $(Q)cmp -s $(INCLUDE_DIR)/.vmlinux.h.tmp $@ || mv $(INCLUDE_DIR)/=
.vmlinux.h.tmp $@

great, just maybe leave a small comment that we do this to avoid
updating timestamps if contents didn't change, to not trigger
expensive recompilation of many dependent files

>  else
>         $(call msg,CP,,$@)
>         $(Q)cp "$(VMLINUX_H)" $@
> @@ -516,6 +517,12 @@ xdp_features.skel.h-deps :=3D xdp_features.bpf.o
>  LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
>
> +HEADERS_FOR_BPF_OBJS :=3D $(wildcard $(BPFDIR)/*.bpf.h)          \
> +                       $(addprefix $(BPFDIR)/, bpf_core_read.h \
> +                                               bpf_endian.h    \
> +                                               bpf_helpers.h   \
> +                                               bpf_tracing.h)
> +

let's split this change into a separate patch?

>  # Set up extra TRUNNER_XXX "temporary" variables in the environment (rel=
ies on
>  # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
>  # Parameters:
> @@ -566,8 +573,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:      =
                       \
>                      $(TRUNNER_BPF_PROGS_DIR)/%.c                       \
>                      $(TRUNNER_BPF_PROGS_DIR)/*.h                       \
>                      $$(INCLUDE_DIR)/vmlinux.h                          \
> -                    $(wildcard $(BPFDIR)/bpf_*.h)                      \
> -                    $(wildcard $(BPFDIR)/*.bpf.h)                      \
> +                    $(HEADERS_FOR_BPF_OBJS)                            \
>                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)
>         $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      \
>                                           $(TRUNNER_BPF_CFLAGS)         \
> --
> 2.34.1
>
>

