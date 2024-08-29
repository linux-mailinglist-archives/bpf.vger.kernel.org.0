Return-Path: <bpf+bounces-38342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9109B963839
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 04:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02261C2207D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED424B28;
	Thu, 29 Aug 2024 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giY4Mga0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D52421D
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898822; cv=none; b=GVhisOG+eqKiwSV1r85aMk+MSyP/n8CqXRisoj5PJ43hLBhM7xni0QUqa2AXQ/NrA/tGn67+6yZXRjsVDLmDlb0p+/47rVYjoW+INNxC5WhpV2Y6/QRQntSZ01qRyaZbWK1NX9ARjIADSkGziCwGkjkgFdQwtehbUcluGI0zsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898822; c=relaxed/simple;
	bh=hU0f5uraqyND93UzrlzIsNFKVMC//re40+/RP1qaBc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE75oiU4cGw94FZdgim65x/4cXRL4kimpvCGeELdBmid809YQfmI8bXyOJvjpegmbTN3xXhS2GE88pme6cH3X+T8D49e6IkEPVUBiRww0poaP4K9iYP9RLS0fiRDqGVQ2P66SQK7s7eIjbeuwvn05xhLWW9yG2zqWCBDr2YRCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giY4Mga0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3718706cf8aso81586f8f.3
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 19:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724898819; x=1725503619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU0f5uraqyND93UzrlzIsNFKVMC//re40+/RP1qaBc0=;
        b=giY4Mga0e8yY3kj9xZ5L+7gVmEEXUAfvIjBnfP9yKR0QF6VLAuZs7wcatzhevOmx24
         BSr3NFKyI53fhQjAuxUehENbgG/68rIaniP6moAuJxNat55VGlnB92hzTIV84duJ9rEb
         jnZTvDM0/W6egJ+FZzj3aGgjOAMyvjemnQVUZBo/vy7QfIPu8JUpxlr6EC2NH7mlva3O
         jqMGkxDxZTZdQ0qjOpPb0ugu03+SgW/egCtgJ6Ema5OiUBqxzCp9miEsV+NQWh/Ti5Pe
         AxeVN/+phpO7jIH+DI0UpzsVbWstdsGGQdceEtSOuFOl1BuSQWCEHXFXyyXMJbWiTvy0
         Rk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724898819; x=1725503619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU0f5uraqyND93UzrlzIsNFKVMC//re40+/RP1qaBc0=;
        b=aElXWk1Wqm1SoNuF/g12d+cpk02B/8rINuWLS7RW0jWPHom8JUypN6ID9bHvrfmzBa
         r1ufb/5GXnQiKkmf/EaTS7RS54RA/WN2keyGY+4iO/C/wNeXprxU1DVnPOJhiPCo58t0
         vQE/5TV/YdIPSop94LEdRZiCv5LgWtLFlkA79SN8w9fz51OgFlA5pi9ES+WpQPRgagZx
         HWn/KaSJPyXdQShN6HcByzeAJrEHcG0smuxmri8VV7R999hrbpJ8GhpRNDZsQlWWcDPV
         oBQI6I4p6dIk0yI7x+hORkXqUmVHJZnXo7/yql5vSFgglVYukPmqKzCPWFJJwJ5UCMv3
         jDPQ==
X-Gm-Message-State: AOJu0YwfRqO9We2HBqPTx14uVhHgJddJ6hhyiLv968zWkskFJMWXjOIx
	cX+XFfv7KeKRlxGTboOn58B3yHMpMEn3NW+kpszGAh/iFicYp0tLVQz5GVf3LIe+CPX3IPKN4hj
	QWgMfU4Gf9ev/awLDm3G30SI8vtM=
X-Google-Smtp-Source: AGHT+IFpET6K1BlpHt61uIi6ywmzvac8FvJ48t2m9Q3xfsc7xiMvfpgRXtZVJ/3WAtAnLRuI2LrXDDGUuDRdJL18wPc=
X-Received: by 2002:a05:6000:a8b:b0:371:8c27:4cf4 with SMTP id
 ffacd0b85a97d-3749b54fbfamr856550f8f.36.1724898819065; Wed, 28 Aug 2024
 19:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819212230.50343-1-kxiang@umich.edu>
In-Reply-To: <20240819212230.50343-1-kxiang@umich.edu>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 19:33:28 -0700
Message-ID: <CAADnVQKp0uH+vt5e43rOtFtamSs4zssh+RHKwQrRfgSDh98E9w@mail.gmail.com>
Subject: Re: [PATCH] docs/bpf: Fix a typo in verifier.rst
To: linsyking <xiangyiming2002@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linsyking <kxiang@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 2:24=E2=80=AFPM linsyking <xiangyiming2002@gmail.co=
m> wrote:
>
> In verifier.rst, there is a typo in section 'Register parentage chains'.
> Caller saved registers are r0-r5, callee saved registers are r6-r9.
>
> Here by context it means callee saved registers rather than caller saved
> registers. This may confuse users.
>
> Signed-off-by: linsyking <kxiang@umich.edu>

Thanks for the patch, but I suspect "linsyking" is not your full name.
The kernel patch rules are strict. Please use your full first/last name
as an author and in signed-off-by.

Thanks

pw-bot: cr

