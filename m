Return-Path: <bpf+bounces-68798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AD9B85725
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 17:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BAA7E027C
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC47AD23;
	Thu, 18 Sep 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6QDDAQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E61F4C8C
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207745; cv=none; b=r1BzGTTZPFYSsOOav/iHzfVAHnUTIyVMi66sm4C+WIzXW1wsr+VF7YBVpDG2svTXSqwYCbZmTL+UOZMCbgC2E1YYjJotL+MTmfeFrAWfbB6/iOWc8RSKiZ6DE3wDzx+NebrRyxFNB88Bk1mcvftf03h0aDU7+zQIe8gAnzj6owo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207745; c=relaxed/simple;
	bh=GMBjwL5rNJGzKXtNvgN4rsLO3pDIFkmGav0nqio3e2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKTirnt2ePDFlxIO4WgzXAW5zTHIszdqgw+mp5rCZIe7ZlifuP67QSqz3Qk/0gnH+h9YbDDLKi1EMFTv6AzlKLIeO2CG91dBBvLbet13Ij8g61lhc50EblnIrBZCBz/FyZj5OMp9abdUJuV10BXPk9mVpybqD0r+mz51tSqXCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6QDDAQ9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1255365f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207742; x=1758812542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRG/uowhqCyGpV4093a/IK9HLZVeJ9SFOKB4su2qz4Q=;
        b=X6QDDAQ9KDmiu3LcjJSG/HY8kb2Zz33en6wEg1DHVKOtBJG8TIIrhUjSJZuYZbz7RX
         CpftpG3P+qTZaOBdKTetX7oRtsdXikW7ajPEBMTB6LPORcG1P2RJoKyrOpOUn7P3DfQs
         Ab2PAQzKUNRd9JJ2PYWjlu0x+gih/YP9V8E0P53w5TuwwJ5KflKoW/TR+fExLCjLvP3l
         6YkxZLwGetb09gRgFP1Uc3/NEXMEgUKb1vIdvK1vyigc3kmGBsIVaoYvSmkQ7D+4OHAN
         dTEI7nzrSWG456d329O2qH6A4l8/T4CqsysV6f/1FXDPjxxaEHeRHl3i1GljqfJXo1uX
         THKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207742; x=1758812542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRG/uowhqCyGpV4093a/IK9HLZVeJ9SFOKB4su2qz4Q=;
        b=nt4SfLqXy62qeE/Thce1+ksCbvwqx93N9hfu56Hw/0nSyMe64jD/8iZTJyZMnwFwtZ
         EdalYAUtQmuBhgfePd+8QxZjjTemJL3XW3l8aawTOZZ110wa2spvMniXE22AvcIy+Bnv
         lIzV2+6cS9ro6N40sivj2ra2gE7kKEY/TXXwZwBHgVXc2bpUMIbYgsaORhoLiskQgwqy
         kDodbOlGr06O7MWQUdJ0JRuxJPpxRODTFq85Mgsi29i3zX6sslNanF4Yd0/+XlTEhqcc
         iyY3QVnoW6s7KO7HrlNGps7GBdVYMK6GgpdStzqt+GQnfHDaVqDR+8GbwyroXOwMhn9g
         IiQA==
X-Gm-Message-State: AOJu0YxbbpQ82e918PAJu2Nr9pX+NTou9fgz1gCk4TNqdt0bWEBzdTGq
	Boy7NEDPx9YcYA/UkLVYh752HBUYN36f1a+pxlPznWAvLp9KBVADo/snHFOjWSNSKypdtl3eL/B
	quhLKX27yNoHwpPGwyGSjDpD87as0Wb0=
X-Gm-Gg: ASbGncs6PUxjULr9uKbFRKpS/YIfQmbAVtEPvQxC1cdfp5y75/24avfH/pP7nEyGXkk
	U0VipFyPtWXcfo9YQqZQcmVSzU8ccNxspNBG78l4Zil6PZTMirPuaRMrA8sdl3r7/3WMROyRbD8
	Xi7lcTH2oKPZ+dTQQAnbEbmjubEI0zluTKczaSC5mWBBlm8e8TWrvxhjRHuvFEcDXPSTP7TL0Zv
	4LyhY5qnFS6xgjFG4OEkol8+eB7Nx+dCWgnff9d5kr0f9eohnW3
X-Google-Smtp-Source: AGHT+IGoNMpd0JrmtAOuR27fpO0X8XGdxncTcdaGK89bgB2G1NuN6zaNag6dLHNX1p146txWND1l6IlME4y60j/Us8k=
X-Received: by 2002:a5d:5d13:0:b0:3eb:5245:7c1f with SMTP id
 ffacd0b85a97d-3ecdf9afcf4mr4846404f8f.2.1758207742279; Thu, 18 Sep 2025
 08:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918093606.454541-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250918093606.454541-1-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 08:02:10 -0700
X-Gm-Features: AS18NWBy8dkyH1kKIgzUtjqr9M80HpC5xNha3_H9FnvnPeleW35Uap_RORM8aU4
Message-ID: <CAADnVQLso776xFQTzPFahmV=JbE3Ca8jQ7UdPuMChjJAK_echg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix build with new LLVM
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:30=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> The progs/stream.c BPF program now uses arena helpers, so it includes
> bpf_arena_common.h, which conflicts with the declarations generated
> in vmlinux.h. This leads to the following build errors with the recent
> LLVM:
>
>     In file included from progs/stream.c:8:
>     .../tools/testing/selftests/bpf/bpf_arena_common.h:47:15: error: conf=
licting types for 'bpf_arena_alloc_pages'
>        47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *=
addr, __u32 page_cnt,
>           |               ^
>     .../tools/testing/selftests/bpf/tools/include/vmlinux.h:229284:14: no=
te: previous declaration is here
>      229284 | extern void *bpf_arena_alloc_pages(void *p__map, void *addr=
__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
>             |              ^
>
>     ... etc

I suspect you're using old pahole.
New one can transfer __arena tags into vmlinux.h

pw-bot: cr

