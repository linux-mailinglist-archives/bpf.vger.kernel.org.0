Return-Path: <bpf+bounces-36697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E5A94C3DE
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 19:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9146C1F23C67
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9731917D2;
	Thu,  8 Aug 2024 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCxzn6hZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DCD1917C4
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139098; cv=none; b=pSS3659/QTMMhdvDrAvgg5EzrHsEhJGLrJsJuSSrSxf6Czw9vfQ48H+kYJ/NuPoa6IH/4QaI3rmI/fQlMKjuIinMLALa0SM5VHsmP32085MfoEaCnFlBtdjYyJjBCF2hDNmOR7uoTnR9NKTY1/KZdLWUM+LBv7bG8+LxLZry38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139098; c=relaxed/simple;
	bh=2tz0vGOg+IgxMEKLZSkMtqr2SwanNaDqqOQaUNZncE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzJwtizSiblXwsp8/s8Hj01lEMrfvlRq25p5iw7hO71bDyRDFdwj52pPsIqdVySZY0wSgKQzj+U8dm4z0FqE4SyhpssYRJ6byga8EG+IsGnZMl1nBaB+8tqD6AK0jX7k/W+ny0KTQI7Ix3nSqtf+BNqMc68J4vIWJRtPpxMCs3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCxzn6hZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428101fa30aso9249815e9.3
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723139095; x=1723743895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OXlU7S7xAtbfrmO+YE5QDS3lBi4RfSu9qyhNk17uJo=;
        b=mCxzn6hZvk9XLFa4ZVTFpMwUZH8uhQrk80VBD7CL+qSoU7vrILsgxd5T50b+lD85IA
         R8N0kSx7cYoDBfV4ezcwnshhKyDiuW9Z9+PFXzIc3Sw5IsjkzOjWnQN7YG2doVyOn8Kg
         EJGWbCBnpEBlGV+K8GLHQLjLKNIwDaZV8vX9ZQYhOdTReB9FBrdZmxSYnRzS7z4TUG8f
         UM3amkAVtN9iLObecKaPbMeDpNpDQkQeVLQQjqFhWcurV56wrgL4NHBwFJATtix+V1up
         72menQgaXtZUu3kgL8vkfBoCmBldq9fkAjW+bItFRlzYT6iODj5dsTFhXgT7j52dTBNe
         ro9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723139095; x=1723743895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OXlU7S7xAtbfrmO+YE5QDS3lBi4RfSu9qyhNk17uJo=;
        b=MgAzsz9BLwgp3Lw0asng+jRR/nXRnTmXf59cPWurnZTE3NhNealAPydcf+j0FgqlbT
         CMW6kVEEnQFe0oJsp/L69KlLPZnLOblQrbXhdAObfoj6/jZvy56GvzEiTj2HuA0RszJ5
         LS9QuNCZTO9fHnYLbWdG1IGGCuO4/QWnjbZ5oMWTfmkfujLkbHPBsjCW8peHfdJpwqK/
         pS874rkiZwh+cDtQy9UB8bcsGCuujtYDcbSM9rr7C3At0oQUrtyg7NGRnTA4hoBUGMTF
         BHMsVF/eQTyVkvp5trNTs4qe7JjGEEQxe/nHyvfUYC7ru9CRM3brZWl/Qbn8fTWDeS2A
         SRJw==
X-Gm-Message-State: AOJu0YyYgI33ybJinuxD30LO3ROYL9AaZ41nGCrEPMZThH66R5kUnxd4
	+uup5caFeEA7/IiwE7i+1VmEPHRDQyGK+ccNEQDTgJNFsbByOyTjSELqkcaT1bMm2DL2LIL4O/+
	oDECamwJdLW89Bgl5kuYOwXkjg2cInw==
X-Google-Smtp-Source: AGHT+IEcb1NrO7RKvLHs9M5I13Pds5y0iqLx900u6F4OidGh3h1XC6meS7lIa9JZ794/9XJUws23t0wa8vyCUurbjWo=
X-Received: by 2002:a5d:640b:0:b0:368:7f59:a9f2 with SMTP id
 ffacd0b85a97d-36d273bda8amr1992166f8f.10.1723139094916; Thu, 08 Aug 2024
 10:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808173131.1128412-1-linux@jordanrome.com>
In-Reply-To: <20240808173131.1128412-1-linux@jordanrome.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Aug 2024 10:44:43 -0700
Message-ID: <CAADnVQ+NFysiR-_wwSn-32iRvgeyfM+j33aB3=eWMR6DXNBMmw@mail.gmail.com>
Subject: Re: [bpf-next v1] bpf: Add bpf_copy_from_user_str() helper
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 10:37=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \
> @@ -6006,6 +6027,7 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \
> +       FN(copy_from_user_str, 212, ##ctx)              \

Sorry, no new helpers. We can only add kfuncs now.

pw-bot: cr

