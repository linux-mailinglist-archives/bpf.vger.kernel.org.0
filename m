Return-Path: <bpf+bounces-42732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136F9A968B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 05:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A410E2847E5
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D8A13B58E;
	Tue, 22 Oct 2024 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHWZt1tP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E91322A;
	Tue, 22 Oct 2024 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566467; cv=none; b=QlI02cMPvo2CzVDzSE7rLWgsq/nWMs4GxMNzI+V6au0XyJ5U1Fuclh2+oSx/EnJL7hZ9sqzhZm6d7/eOEQTZbLSIi4SsiYZ6+VYKg28WRtHSyFq7eT3G0aGXUYcdQh2bv3YM6CwLiirRkPaspEi9FctbYtt9ErBmB7o+CzDKJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566467; c=relaxed/simple;
	bh=pcXWKg3Dwx917197QJAKwJoycbVvQEw1HjCOIri/uL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h51wB7nlkq8FAhPi9llFdf+dAax5mx3tddP5W162ViDLMTfFCxL7Ksy3pH690g7+1R4Bi9N4GRxp0slTmvNq0L5bROZyO6eE7z3Pi16C7aiV9UTPusGQ4XYqnwPNBMZiYjGyKZ7+ZUrizkZitARGkYwqCb3uyxYeOx7a2eXhFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHWZt1tP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71eb1d0e3c2so1981401b3a.2;
        Mon, 21 Oct 2024 20:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729566465; x=1730171265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWq31H5n39331yEuvn0+CKOb9FJ00xa/NHJ9azf7H20=;
        b=HHWZt1tPLFycOLcX/6aTgsXO3+UPFukcWz13yM/+o+k6SXTK9F54K4sLOqPSA4fARW
         VYj3VVwc4zlqOaXOTNPPugog8RqxzJs9LSnIQEBgf3Per7jaoLlK5pB3Vjx8n+vQLJuS
         Y8kV3bSYWyzKTqLxPveAs5FYjZRcQM5L56e3i6Zu0aZFXuosecS04Uvz4EKpSnMHRa2U
         ey7p0LqrdEI2qQOBABX+Cbsqn3iXnKbsE46ku+D6riXfp07vsr5WWWcH1tFg5B5ZgGNk
         DdvI8DekKuH49f7nI0uSTnTfJmFM35AOCwbI3gvzZs/pti5eXlGIF+s0xYPcQ1yXuNX0
         gdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729566465; x=1730171265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWq31H5n39331yEuvn0+CKOb9FJ00xa/NHJ9azf7H20=;
        b=JKfnWGOh6i2eohKMcNKb7LrmTsLkIphuX6acJpNdCEcQ+ixifIDC1GIUPAARkK1q9A
         JIfHIO/UdmQ4HWAxYLs/zjH5NYeYHjPafCavkxdtr13CY85pQ2zQN+6lWIyXtJfu9+qg
         n9q3XU4or0CUTw7ZfDW3gSNCA9ZkDFoMKalGCI1pBmnXZlbfYGyeJPpFiG+sk+NXddlP
         FJJVjQ6YLX6xGTdpQDyGx5XJYyY0htBgspj1HMsAbwjK6+lzrt/3B/gO5vksDaCDIIA/
         s33ZuHuapCdOhw/MJFbMSgaCcGeZKSZArg4bQteIbcHF05GSI6h1VvOl1phf98jBOyyi
         39pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9tPbnmJ+Cf9SrvDXZDt+IQxt38xDiPlf1FBnX8D4YgZwu/drXWhTDmPamoU8bDk+gQK++Zmqn@vger.kernel.org, AJvYcCUuJ0FjrS1M6AHaFe71S4tpkQRPYoXv6oeNcjYU8kGkzBZ7LR4qterFOli3B+Gd/3iIryHtlk1YQ0UWbw==@vger.kernel.org, AJvYcCVUDYOdlWV9w96NC0LCVkrbqZoSmQkhv5qMuO1wjAHHhkDB+CCEBWFzhzsSzLDKEFjJcOY=@vger.kernel.org, AJvYcCW18izol0I7lfYTck5r83aHidw3Le87giIbLTn1fOnPgaODLvYPcRBj3vZDV4oIQ+Xb5TimGobH+mLwzsoF@vger.kernel.org
X-Gm-Message-State: AOJu0YxLG2j0FJM96OnTUiNnhIHeWCxcof3PAxURX5gubPb1WEAODC3s
	Y20WS6ctQXrEMYgQft0rz5lUfdC4uPj2mdCFqBtQtczXc2owJRMN/n8/pk1QqB0+tll+I+BsaVU
	rdNANVZJ5rHi0KesIrLNhBYPJsg4=
X-Google-Smtp-Source: AGHT+IFqKI6HjrzUPwBD8vnjKRXBX4V+2NxfwmmxwYKZ8aFnomTb3ADnQd+7OdNwacjn1UMxhv8nk2zSbu06FB/Uniw=
X-Received: by 2002:a05:6a00:3e0e:b0:71e:19a:c48b with SMTP id
 d2e1a72fcca58-71ea31e49ecmr18822797b3a.22.1729566464727; Mon, 21 Oct 2024
 20:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022120211.2a5d41ed@canb.auug.org.au>
In-Reply-To: <20241022120211.2a5d41ed@canb.auug.org.au>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 20:07:32 -0700
Message-ID: <CAEf4BzamHrmdwRFKAr9MGSmaVtrJT3-ru=KPXEcO981XZsM+Ew@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with Linus' tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Viktor Malik <vmalik@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Simon Sundberg <simon.sundberg@kau.se>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:02=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   tools/testing/selftests/bpf/Makefile
>
> between commit:
>
>   f91b256644ea ("selftests/bpf: Add test for kfunc module order")
>
> from Linus' tree and commit:
>
>   c3566ee6c66c ("selftests/bpf: remove test_tcp_check_syncookie")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc tools/testing/selftests/bpf/Makefile
> index 75016962f795,6d15355f1e62..000000000000
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@@ -154,11 -153,9 +153,10 @@@ TEST_PROGS_EXTENDED :=3D with_addr.sh
>
>   # Compile but not part of 'make run_tests'
>   TEST_GEN_PROGS_EXTENDED =3D \
> -       flow_dissector_load test_flow_dissector test_tcp_check_syncookie_=
user \
> -       test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod=
.ko \
> -       xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metada=
ta \
> -       xdp_features bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
> -       bpf_test_modorder_y.ko
> +       flow_dissector_load test_flow_dissector test_lirc_mode2_user xdpi=
ng \
> +       test_cpp runqslower bench bpf_testmod.ko xskxceiver xdp_redirect_=
multi \
>  -      xdp_synproxy veristat xdp_hw_metadata xdp_features bpf_test_no_cf=
i.ko
> ++      xdp_synproxy veristat xdp_hw_metadata xdp_features bpf_test_no_cf=
i.ko \
> ++      bpf_test_modorder_x.ko bpf_test_modorder_y.ko
>
>   TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mu=
lti
>
> @@@ -301,22 -302,11 +303,24 @@@ $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF
>   $(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildca=
rd bpf_test_no_cfi/Makefile bpf_test_no_cfi/*.[ch])
>         $(call msg,MOD,,$@)
>         $(Q)$(RM) bpf_test_no_cfi/bpf_test_no_cfi.ko # force re-compilati=
on
> -       $(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=3D$(RESOLVE_BTFIDS) =
-C bpf_test_no_cfi
> +       $(Q)$(MAKE) $(submake_extras) -C bpf_test_no_cfi \
> +               RESOLVE_BTFIDS=3D$(RESOLVE_BTFIDS)         \
> +               EXTRA_CFLAGS=3D'' EXTRA_LDFLAGS=3D''
>         $(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
>
>  +$(OUTPUT)/bpf_test_modorder_x.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wi=
ldcard bpf_test_modorder_x/Makefile bpf_test_modorder_x/*.[ch])
>  +      $(call msg,MOD,,$@)
>  +      $(Q)$(RM) bpf_test_modorder_x/bpf_test_modorder_x.ko # force re-c=
ompilation
>  +      $(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=3D$(RESOLVE_BTFIDS) =
-C bpf_test_modorder_x
>  +      $(Q)cp bpf_test_modorder_x/bpf_test_modorder_x.ko $@
>  +
>  +$(OUTPUT)/bpf_test_modorder_y.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wi=
ldcard bpf_test_modorder_y/Makefile bpf_test_modorder_y/*.[ch])
>  +      $(call msg,MOD,,$@)
>  +      $(Q)$(RM) bpf_test_modorder_y/bpf_test_modorder_y.ko # force re-c=
ompilation
>  +      $(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=3D$(RESOLVE_BTFIDS) =
-C bpf_test_modorder_y

This and above will need the EXTRA_CFLAGS and EXTRA_LDFLAGS additions
that we have for bpf_test_no_cfi.ko. For now, I'll unland the patch
set to avoid this conflict and breakage. We'll reapply once bpf is
merged into bpf-next. Viktor, please rebase to take into account these
new modorder.ko additions.


>  +      $(Q)cp bpf_test_modorder_y/bpf_test_modorder_y.ko $@
>  +
>  +
>   DEFAULT_BPFTOOL :=3D $(HOST_SCRATCH_DIR)/sbin/bpftool
>   ifneq ($(CROSS_COMPILE),)
>   CROSS_BPFTOOL :=3D $(SCRATCH_DIR)/sbin/bpftool

