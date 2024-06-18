Return-Path: <bpf+bounces-32376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8690C32B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 07:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC77282E0A
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 05:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592CA10A16;
	Tue, 18 Jun 2024 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao7eWz3q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE4433C2
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689143; cv=none; b=Z+TwZ9sCbpHdDXPwVCaomJXDylquzOctwbvLTcdxyVcjqAmC3mkevtwalRFspfjKxSjpYssZDLuJgiFN4Ws3EOmXCQrqWOKa6ueVOv41sjBF2wczBp0+wSRhdENPWwYTtahMXSNKOKe700zYdPn5KQjbbGk+VlvTUDh29aHD9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689143; c=relaxed/simple;
	bh=C/+HMthg4CF6B4TYUiqtD+GFjyGnDCvKWIhOP6cfwIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXwcp4PNqYuo0Imu8JgI7fT2mNhYG+iEPuwNCb5o6BQaK06EDF+VyksZb7yhgbsgcacttDjtw5KRDpmAr2RgQkUowakc8sq6GiCp4owptLcC4A4Jf2H/lGhQTLKJ3ZEXa2QBs/brFEt8CX4VXRDXAwiQafT1iVpnmJe906Qnlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao7eWz3q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70417a6c328so3876212b3a.1
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 22:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718689142; x=1719293942; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCmlCRI+L3cN9UNyVLLerhIovV+AquvpZtvJh7Qa5ng=;
        b=Ao7eWz3qhdTPdft92fy0H2XqsOp8HVQlouce6YLledtHRAVIAjYafbIaZWFG5Gyo8K
         LEvPfwS/kDflzCCmp+xZxp4Bh34m/fZPRg0upLPWjN+WBWyOhLi6P894AOHJf8K4TnD0
         8WUoF7L+WQSxpT3Hp4PRVcNw/QpkldrOQ9wrni0uTU4IkYlD2CcZjb9eyVrkmA0y/foP
         bnI3bCJROeKYDAQrz7ADx1K+H7DJ6QXpuUKrxdMZhXTnk+G7Q79+EnVjqffiDMAE5oAr
         2OFo+28lIb+p/4wzyc3d7CPrN50YpZ7Jtj68SIP+YQQUus6MzUgJzcWb35OejN3SzD3M
         NAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718689142; x=1719293942;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCmlCRI+L3cN9UNyVLLerhIovV+AquvpZtvJh7Qa5ng=;
        b=bf/oyONsJuub3X7rpNhEwCnvrInTqFjIw6qii58CkiIBkRaSMwb3/vZOEdbciIBLaQ
         dJHWlSoor1zPNrPOE3PPkzRokOBl1x5C8DPUvRZanwjzCkwgudq3+3arSE342XVptSEo
         3oL3xFFDeaJcCdwu9rm4e9wYZe9N46h5cLZC/xPAo4s+l2gM8Fmh2ReARX8QOtGlgmt/
         4o2tr3Lz22ny/0Na3GZz5W/USNTtgiaOVudBgj+11UwHjMv1vX/K0gnvDd7DHrp8tbdS
         6uAAkS7SZAvRY7GXKp9bZTeLewin2RljnLHFc1ROHyn6Nf1Z1hM7IwWVpkHscwt+a0XQ
         GTOA==
X-Forwarded-Encrypted: i=1; AJvYcCUXlRyo6BIhlhF3RkuAuGoimcG3DHAv2HTX6vW9ADGNG3M038Siz5ttU+cvSsNiF9awGAlC0WIbqmSP2x8DevbuuSdI
X-Gm-Message-State: AOJu0Ywpk1/bvo6MGN1C3JXMXDI9ENjpTSjdwYMUYavTwRDq/3FoTQYv
	zygmoJNMkwBKNoWH1vxQA0E31TA2Ojh8u8j6rv8o1Ec+rPoivJEL
X-Google-Smtp-Source: AGHT+IEeB6eHZlZirYpIlYWXSZlxW4pHeZdaaimXUAXZOfXo2rDkE0kaUIlSe8XJiGvFmGkE6Obx6w==
X-Received: by 2002:a05:6a00:458f:b0:705:c0a1:61c9 with SMTP id d2e1a72fcca58-705d70f4fbfmr9715656b3a.9.1718689141776;
        Mon, 17 Jun 2024 22:39:01 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d1d7sm8230644b3a.134.2024.06.17.22.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 22:39:01 -0700 (PDT)
Message-ID: <28250a9a52c8a10dc7c37e15df9a9d446976e4eb.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: relax zero fixed offset constraint on trusted
 pointer arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org,  kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
 memxor@gmail.com,  void@manifault.com, jolsa@kernel.org
Date: Mon, 17 Jun 2024 22:38:56 -0700
In-Reply-To: <ZnA9ndnXKtHOuYMe@google.com>
References: <ZnA9ndnXKtHOuYMe@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 13:43 +0000, Matt Bobrowski wrote:

[...]

> * For OBJ_RELEASE and KF_RELEASE BPF helpers and kfuncs:
>=20
>  * If the expected argument type is of an untyped pointer i.e. void *,
>    then we continue to enforce a zero fixed offset as we need to
>    ensure that the correct referenced pointer is handed off correctly
>    to the relevant deallocation routine
>=20
>  * If the expected argument is backed by BTF, then we relax the strict
>    zero fixed offset and allow it only if we successfully type matched
>    between the register and argument. A failed type match between
>    register and argument will result in the legacy strict zero offset
>    semantics
>=20
> * For KF_TRUSTED_ARGS BPF kfuncs:
>=20
>  * The fixed zero offset constraint has been lifted, such that
>    KF_TRUSTED_ARGS BPF kfuncs can now accept a trusted pointer
>    argument with a non-zero fixed offset providing that register and
>    argument BTF has type matched successfully

[...]

Hi Matt,

I've read this and the next patch once, but need more time to provide
feedback. Two quick notes:
- It seems something is wrong with the way this patch set was sent:
  for some reason it is not organized as a single thread (e.g. on vger).
- I see how OBJ_RELEASE arguments trigger btf_struct_ids_match() in
  check_release_arg_reg_off(), but I don't see how KF_TRUSTED_ARGS
  trigger similar logic.
  Do you have some positive tests that verify newly added functionality?
 =20
Thanks,
Eduard

