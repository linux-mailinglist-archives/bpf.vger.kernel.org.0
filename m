Return-Path: <bpf+bounces-73084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAEDC229A7
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 23:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9D504EA297
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3258314D2A;
	Thu, 30 Oct 2025 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y09QIKyF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630434D395
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864675; cv=none; b=YqklFNl+An12r2man1KnBiw7tdoIx4Kvkkzku6bPCZsnWZPSS1/oi7f5e7OVzn5jcB7lepppm0rd5ldRQI2r2szkrAhQqh9MWGFZPpsRrKmblgwQ59Jfgt34HQmjCh1ur3fpENE0Pr0SWdPRepRp+uAsvXD8dtQnM3lE6OSdjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864675; c=relaxed/simple;
	bh=qgp0aT4ZBy37CHwcwps5+JxU1CPuU0uQYHe4J3AJWug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3vN3s59XOXGk+1+YO8Ry47f1TIx0rz13SfurS7gJ8mDceKM3yzkZ4S3zZ8638MmrMa2oOsm29YcUCUw9osikOqBnuzsoujNBTmXR6r1UOJmX59NVsdS7Z7sJmCVh7pok88LtokSyb6DHLF2ZxJND7D1RwCot6Erij3qUaucPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y09QIKyF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429bccca1e8so338031f8f.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761864670; x=1762469470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms2UbODv6bHlRdGHOdBj0CB6vwFknHcvxyDVomETvyY=;
        b=Y09QIKyFfxVou31C0yVLJHO2aabLblv0QqJil1RP5XarC2vPFx3RqL8IdNj6WCtrtl
         85eyzKX2+xvBR0nJgncN6QdcJ0SSlbJtFA1ZJDvbG2ADJgJOeiHkjByfa5HMrCtIx+3v
         Rbuc/1vsTql5mER631des0h6E+SWXQtRc5W4mdYoI3u72zAfdtHLxteZpfipN+rSyDN9
         LZayhafuFY0H/XHwzObk1ClCe8K0P3frViJlk1ZsSxP5/T5BWMSTwhLEIllikQ+TweDQ
         O7Qmp4LQtR6a66OcLfbaS+QDdryBO0JcaokBFCucGY6FyX66HHh9Fuu0yBuBnsT5Q3Bp
         OpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761864670; x=1762469470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms2UbODv6bHlRdGHOdBj0CB6vwFknHcvxyDVomETvyY=;
        b=hSGWuUNEZLBAkUFZS62VMsl/1nG+icXoXXEXQIg0wtkXUNcexRfusrU+6z3gu13llN
         pY98WpBrUCXCVSS9gyPm5qfCPanEbHk762QZ8kdS1YjfYJRY9EDKVx0PNmZb6uht45JT
         RnafaVrm7UEbCPaBMx/Ckzp46kQqtemuLbwSfmm3l5nHQ56sTdzEpb4i36+3BtHmNd0f
         e2UvoadE+M2j/VUrDi3pLkyBo0wBJbEzYUWDdq+SoT16O5n8ACYoSqfEs0SVzLts0aNF
         3iA4Lhldl2n5JJE1qFGOi7mAWntbDAKShY2qDmpBSO4VIzJCVULG7k2waMW2VilwNWTY
         WcQA==
X-Gm-Message-State: AOJu0YyPyd9UfpjULhDVGz6dfjTPnBcD3eT6QbHMmC252vk77U7X/CP0
	xOTMZ0FLYhSTo/Fsv0Xj2tt66/5FLhe4x9ZlSQ/LRDSxb2HAFLnhNy9R+jivPIqA9tLZEJPHbI8
	OFwRtaT6fJ/+sB9T+hGPBhLPYa2qk9MM=
X-Gm-Gg: ASbGncsOFTssoxQ73lhvqAR7HyEo/Ab9Pub2eCnwnpzOxZhM4c6X4YUxiBTWtNSKSVW
	UYDHXqtLTATEkQkIv03bxsnnNrK369A5kzxK/icOdOe3EV3KaSfEDw7XL/HWlGGq97K8f90I6ms
	iVbLUvER7Q0dQ+yfzaT4dQ5XZlifu1o3cHX96uu46ulhzQ3jpia8A01n5XnaCijag8EVVQENN5q
	YZsnBCx4T+ro9H8TtZX2KHM5s8KxDrEbU463kCBYbs1QiM7YA/chxqwyL62rjC26Dq1HJGQAJ14
	UmybaVMzNsNEONEeyeommvi3RfDS
X-Google-Smtp-Source: AGHT+IHGsif8iu7GfVWi1C2xVxrcOdKfx7n9hwQGoMfORbFrQM38sY+m6K/HUfRzY/SjHJZrPMhN/K7BTQNnfNsrB1g=
X-Received: by 2002:a05:6000:2301:b0:3e7:68b2:c556 with SMTP id
 ffacd0b85a97d-429bd6836c2mr1061965f8f.26.1761864669781; Thu, 30 Oct 2025
 15:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com> <20251028142049.1324520-2-a.s.protopopov@gmail.com>
In-Reply-To: <20251028142049.1324520-2-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 15:50:58 -0700
X-Gm-Features: AWmQ_bk1Si3VB1UinCWn_5Y8kA6hFJ61tfMZAFI2S3T8m0kIxrnfL3uZDxTxpew
Message-ID: <CAADnVQL1nznRsfdSgFPxSf1Rdhq7hpQMcmT7BKaRn9KHwD=P6A@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/11] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:15=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>                 }
> +
> +               bpf_prog_update_insn_ptrs(prog, addrs, image);
> +

I suspect there is off-by-1 bug somewhere in bpf_prog_update_insn_ptrs() ma=
th,
since addrs[0] points to function prologue.
addrs[1] is the offset of the first bpf insn.
See how it's called in other place:
   bpf_prog_fill_jited_linfo(prog, addrs + 1);

pw-bot: cr

