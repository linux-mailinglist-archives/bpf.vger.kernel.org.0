Return-Path: <bpf+bounces-38669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966239672F3
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 20:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453D9283795
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444A713CFBC;
	Sat, 31 Aug 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="RLwlTiwF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076023774
	for <bpf@vger.kernel.org>; Sat, 31 Aug 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725128313; cv=none; b=UYN6wIxyDqaAzj15sP47obgSD8ldV2m7T3Cyj1iFeZrTu1/s3VrUj2fa8LCpQedqAtNlIVZufQhF+i/2ViiCXeISlStPqPswTY5amBzSm4wLD/M8Cxff5PMZAEZ1CoMo9Vqv6SfpRlcgfEkzMgq8zdeab6FBEx7t6tXZBv0AhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725128313; c=relaxed/simple;
	bh=T62WkLdFENqPufxx5CQ6virlgnpBPz07TVFDjdTYMzw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4vxnqoHZPZobIm5P/fYC+G26NKTO/lTcaicJg1x/CHEZ9dPIm9tDhWBdZ4THjauXlbhWnpYdrk09gs6sRBsof2XyEIcCDPGniV4QYQtbAb4JTnD2Rky1NljpOam4EaF90NkutGEMB6SxvxtYbG13tQsujTbe8H7ruhFs9ulf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=RLwlTiwF; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1725128307; x=1725387507;
	bh=JAf25GjrwIcktDCFibZxbjYWaI7t+LtIo2r48UOrxKc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RLwlTiwFfkPZ9dZyFZU0Nhb8slQ7ASrrZqxRlavxodDOPJ3qC4xr/91sDp4pi+dji
	 TrCdlsYXK7QsA3+p8jyRykbY5BQAJ1I/kczHOsdyQVNYIXa5MWlo8IBiiF2dgQf9er
	 Ot6UpoAelwUP0329RlkrijVj8b/GuNHjtO9BCkJDhRgOUvsk3XmzyuekPl8f0zWKHw
	 HbA0sApgA8IQttZFeqRkpr+3xQ3EMNdqgf4UShSRniAdWugavJuIDVRAQkOTVElLZy
	 Nfx5E2yqACSv0xv3ltQt9nJ1Mq3f3u2k4i53wMAfUC678w9QzJNTDYXXVUBklVSCwi
	 QaK7YCngygg0Q==
Date: Sat, 31 Aug 2024 18:18:25 +0000
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alan Maguire <alan.maguire@oracle.com>, Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h unnecessarily
Message-ID: <xldWjE0i64YdD2vmNCSi3aJ7kls4eQT-R_EWtcnRaYIZuWvjdIBwjgGcoBYm02UHiO6bz5ZyyMtBDZXeLxC_iXkdo_PqkdWkMejoocJw5rs=@pm.me>
In-Reply-To: <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com>
References: <20240828174608.377204-1-ihor.solodrai@pm.me> <20240828174608.377204-2-ihor.solodrai@pm.me> <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com> <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: b28c0bab96b74b1ba80d8af57cf7ac78b6b31492
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii, Eduard,

On Friday, August 30th, 2024 at 1:34 PM, Andrii Nakryiko <andrii.nakryiko@g=
mail.com> wrote:

[...]

> I've applied patches as is, despite them not solving the issue
> completely, as they are moving us in the right direction anyways. I do
> get slightly different BTF every single time I rebuild my kernel, so
> the change in patch #2 doesn't yet help me.

Thanks for applying the patches.
I didn't realize vmlinux.h generation is non-deterministic. Interesting.

>=20
> For libbpf headers, Ihor, can you please follow up with adding
> bpf_helper_defs.h as a dependency?

I've tried tracking down where bpf_helper_defs.h is coming from and
(assuming my analysis is correct) this header is generated by
`scripts/bpf_doc.py`. From the selftests/bpf point of view the
dependency chain is as follows:

  1. vmlinux.h depends on bpftool:

       $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)

  2. bpftool is installed for selftests via `make -C tools/bpf/bpftool inst=
all-bin`:

       BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
       $(DEFAULT_BPFTOOL): ...
  =09  $(Q)$(MAKE) $(submake_extras) -C $(BPFTOOLDIR) ... install-bin

  3. bpftool install-bin depends on libbpf:

       $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
         ...
       install-bin: $(OUTPUT)bpftool


  4. $(LIBBPF) recipe runs `make -C tools/lib/bpf install_headers`,
     which depends on $(BPF_GENERATED) which equals to $(BPF_HELPER_DEFS)

       BPF_GENERATED=09:=3D $(BPF_HELPER_DEFS)
         ...
       install_headers: $(BPF_GENERATED) $(INSTALL_SRC_HDRS) $(INSTALL_GEN_=
HDRS)

  5. Finally $(BPF_HELPER_DEFS) recipe executes the python script (in lib/b=
pf):

     $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
=09$(QUIET_GEN)$(srctree)/scripts/bpf_doc.py --header \
=09=09--file $(srctree)/tools/include/uapi/linux/bpf.h > $(BPF_HELPER_DEFS)


I don't see any benefit to adding bpf_helper_defs.h as a direct
dependency of anything in selftests/bpf. %.bpf.o already depend on
vmlinux.h, and unless we somehow get rid of vmlinux.h dependency on
bpftool, bpf_helper_defs.h should always be there at a point when=20
%.bpf.o objects are compiled.


>=20
> I have some ideas on how to make BTF regeneration in vmlinux.h itself
> unnecessary, that might help with this issue. Separately (depending on
> what are the negatives of the reproducible_build option) we can look
> into making pahole have more consistent internal BTF type ordering
> without negatively affecting the overall BTF dedup performance in
> pahole. Hopefully I can work with Ihor on this as follow ups.

I still know little about how all this machinery works, but I'd be
glad to help.

>=20
> P.S. I also spent more time than I'm willing to admit trying to
> improve bpftool's BTF sorting to minimize the chance of vmlinux.h
> contents being different, and I think I removed a bunch of cases where
> we had unnecessary differences, but still, it's fundamentally
> non-deterministic to do everything based on type and field names,
> unfortunately.

[...]



