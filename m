Return-Path: <bpf+bounces-39860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E197891A
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632D51F230FE
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E514830D;
	Fri, 13 Sep 2024 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDcvzDSU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4564A06;
	Fri, 13 Sep 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256932; cv=none; b=B96U/XEmDrEpsNtYFK5HQL++3XNsmWfp5CeqnsHdTrIn89fMQZAgo7TkVEcge8lxXJRBqLLBRSftGSTfbhk8v7mKkOXyyUfHRMmIu+TgRudEd8zPxFr0lm6AQ6oPzwrCOk4lQg/EL4+VMdv1M914MoR709Qiy/VFyY0Mx/sIAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256932; c=relaxed/simple;
	bh=wXx6gycub3wwaBxUU3Rpj/KlRbaF2yP/lASR3+ACbBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqe0pkPV3yVs7lgT+J8V+BRMxqb6kcJyh2wR70eOdLWDS9kgzH+3xnDgX0CBPUIeNo77AizZDLGG4z3hSxQbNkiP+Fbkx/EQkfaVATRdJ6pP1vuR+KT+10Fpibu5M29sD5tJS76ujc5kmx+tQi2jmLI2o6gl6exk4/RIZcixcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDcvzDSU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-375e5c12042so1440335f8f.3;
        Fri, 13 Sep 2024 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726256929; x=1726861729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXx6gycub3wwaBxUU3Rpj/KlRbaF2yP/lASR3+ACbBk=;
        b=CDcvzDSUpS+EUwvAnsz7OPuCP1OT4LtSuNCrJ6Q00NEG9WtP9wDgu+Y4Bf1MGuEMPF
         /JFDmHGRb8/j9TpwvjvphH29wx8BUzHWKQgViiaLUQsvlKRItqhaUxaMomO/rOeq4MuD
         CTg8x3CsUW2fyJqp5bFReqfL03iWla9d0gfohVv6natnMkQgSLqC47tRaAT5he5DxE04
         LSif5X5mohvRR4WjoBTTWYzTrMknmhdf/wM6q4bq5Tbvgmxld54Rd0Usu0Uawj+QrHJb
         Si9wz215W1Dxu8hUBC8ItJwy+duhuc9J930OuzuaTRybSZblzJRjzTwqWacm0h6mnXQJ
         ft1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726256929; x=1726861729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXx6gycub3wwaBxUU3Rpj/KlRbaF2yP/lASR3+ACbBk=;
        b=Kb8q7BDFtEIGTb2y5UYfT6UK9z03HPO3urHYaWsQE1R5Q5qUn6LSEU/PRPwUqYx+3j
         ya40TqKa72tPbykh3B4Doi71kw3AbKsXWVU7bWFXOtq5dMFx4yZxHDtUpBY2SYmxLEKu
         lxfCjzgzjYY30ZvaH+m9vw9SHobhgqvydzxEQJ36Cwes38SjQVYR2bdsZdaidVE3bXPX
         NchSE4pARMiMOFJZYciZYWCh+Eke3n83W5sdTUn6llHflQH0Q+6nF/avxeGb7bqpTZ65
         ABWHZvz7KAAd0mYCC5By+Y/HKQ/dXl6bVJZgWqEmrG9G+/yP+kV2WmK44jdsndK9LSnQ
         5EcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU345LYxQrO6efZpCd+OpHC4c2b7uZYVdwJsRpp59JK/DfOKhDHZl6dqK7Cd38Rh6cJcYA=@vger.kernel.org, AJvYcCWofrATTgI5Ce6hPlCdLNl4MiTMOlJJ4JAMJiBdFWR7Te3vtQVp93PF4LD0L1eBVC1cduAZOGE0@vger.kernel.org
X-Gm-Message-State: AOJu0YwPj+XDn516Xl1U3ugkmy7SmJ3hDGszmP5JCjtDouBHyMxrSL5f
	YHCMdizuHS7fOtpxPFs72mDgKaFwqBuksSMlnfn78cONKxspVmn1HTg+ypwLFXL9uzI7HeuWlPv
	ilv3QA1pEWVMmsP9yayjqy6s7Ixg=
X-Google-Smtp-Source: AGHT+IH8W9syhiarFLSK3Fjj/YKDt2NVpTG2U4vHTeBbkIoBtlQfC46UefLlGFgRTVDOOIGuvDF5QDu3CeDPWQYT+0M=
X-Received: by 2002:a05:6000:1f89:b0:374:c040:b00e with SMTP id
 ffacd0b85a97d-378c2d5a827mr4487423f8f.39.1726256929310; Fri, 13 Sep 2024
 12:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911191019.296480-1-maciej.fijalkowski@intel.com> <CAJ8uoz2yjB7nj495x3CuiwHfuU+T0g3MXy4DScG2iT6gtkQsqg@mail.gmail.com>
In-Reply-To: <CAJ8uoz2yjB7nj495x3CuiwHfuU+T0g3MXy4DScG2iT6gtkQsqg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Sep 2024 12:48:37 -0700
Message-ID: <CAADnVQKUsT3vU_bcPYBNbnD-W5+CkyEcshW7e2c0Ayj-G1D0HA@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: fix batch alloc API on non-coherent systems
To: Magnus Karlsson <magnus.karlsson@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Dries De Winter <ddewinter@synamedia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:04=E2=80=AFAM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> On Wed, 11 Sept 2024 at 21:10, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > In cases when synchronizing DMA operations is necessary,
> > xsk_buff_alloc_batch() returns a single buffer instead of the requested
> > count. This puts the pressure on drivers that use batch API as they hav=
e
> > to check for this corner case on their side and take care of allocation=
s
> > by themselves, which feels counter productive. Let us improve the core
> > by looping over xp_alloc() @max times when slow path needs to be taken.
> >
> > Another issue with current interface, as spotted and fixed by Dries, wa=
s
> > that when driver called xsk_buff_alloc_batch() with @max =3D=3D 0, for =
slow
> > path case it still allocated and returned a single buffer, which should
> > not happen. By introducing the logic from first paragraph we kill two
> > birds with one stone and address this problem as well.
>
> Thanks Maciej and Dries for finding and fixing this.
>
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

We already did the last bpf and bpf-next/net PRs before the merge window,
so reassigning to netdev.

Acked-by: Alexei Starovoitov <ast@kernel.org>

