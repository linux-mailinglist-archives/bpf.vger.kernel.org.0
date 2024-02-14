Return-Path: <bpf+bounces-21942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DE685418F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916331C28606
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C6823BE;
	Wed, 14 Feb 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eheZ/S4x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A305220EB
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707878389; cv=none; b=dIo0dBvByYwAXyl//sqk8uXcIspVd1zYySQ7sXwH8J+HniArjj5k5e1aZ0F8BEYeeev9WAv4GMQko61g0xsVb8GXs2HvDOrE+XZU2maMaC2UNIvO66/c9QY18PfqhhOW22V56M8nzUXoscSwJE4IsxpEYp1NicLb+rbvy/+iFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707878389; c=relaxed/simple;
	bh=oPfukEbx9tW+gPECMvtxLpAQmqco4WjLX6ogq+wmvrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFEMG8LohvD6+DGFCve00vfGIj8Ldd00UOMAUSsudC/qNN+oz05cMQyzu5IRTS7yzp/GwRy2yUcPVwhmaWCkp/B9mO0zncb59kdKVY8hgmpz621saiIry2ekIKrD6ZBDXcHsp5acCHgBvvGWBWBftpLN0ZQCuTwGwmf07cVOrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eheZ/S4x; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b28aadb28so3107799f8f.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707878386; x=1708483186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBJ/h8HpFTsRsX9eI2f9wRuJMFFDA4Pr5lBNqUR7Ido=;
        b=eheZ/S4xgaGOj+q8juY5+rWrIgCP9KO0pX3FmVYimkfht+pEdnP6Uck5tNbGdsmGbm
         HR9hzJuy4miCwLxpcyk/4tUTtK2OEixl/pq5QYOzIIaON53VTtquMNZTbP6QlmTFdfQ6
         nGHZYlHMmDNeZtDMofhOcWQ2k3Qh9dMtF8JTYZh8bn6Hc/1BGNpa1DFgJJqX4Os/cXlR
         P7ZhielDRHfqswZ5UKM4Ksuzx+bjgpzhZKLZPTQCY7g26YeBIlh7KCZq+Hjk9tJ3XpAc
         kqLbQVhWKhReAnNsIUBJZO4VPQZtacITdFgw0yrvk16jTThFXQwqJ68H9sFVlJX2gBp+
         6Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707878386; x=1708483186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBJ/h8HpFTsRsX9eI2f9wRuJMFFDA4Pr5lBNqUR7Ido=;
        b=WMgcUKkLZxsImcGAyB+4SAj5dXwW+EtjuaXfPD9f5UWZN6e+zBLz7+ZR2Y70u92A4s
         JH0PJni2FdqWijxNKNDGck/tfb/COHe47gC074LdylL7MJaFvPrtKK23HgObeMux/Hnt
         9eFBSAgf+sXJsbmB574hCaocDQSe2gM+xklu1vk8a7TMbt/L7FCcJoG7oc8y+mX5uw/f
         PaBUVpZ7lUJ9PQtS7rumY8z0YzclETDpBkfyNIs4zZytX8CsC92YO/8turVQwEnLxOZK
         JNdTTkyJdAYq4xfXMSeYNrPJK/AP07H93A12idzXM6ii4duTVydSY4zvThafH3jf9g9R
         +9JA==
X-Gm-Message-State: AOJu0YyZbTckFTiMcrnycY03ApfZ4FanjfTDAfTxINTOKzEGPGNStv1C
	LcLAo0aiDPbe1pEiSqrDjBnnGEkkO3I6JDE8GX6balG+aIkH7Kp5UYNKASjqeoB3bAOV1A9Duf6
	G8VByLrvjEJkzUgY0EZ04+FVE8bcdg6lU
X-Google-Smtp-Source: AGHT+IEmkqCeLSuNPGHm40ofC8anlPtrotFEsVhKQWGpJshiZofVQffcDTg1Ap5YbcR4I3W+UgDE6d4cBXw9NyTidUw=
X-Received: by 2002:a05:6000:1188:b0:33c:e07d:17a7 with SMTP id
 g8-20020a056000118800b0033ce07d17a7mr629130wrx.54.1707878385614; Tue, 13 Feb
 2024 18:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213131946.32068-1-list+bpf@vahedi.org>
In-Reply-To: <20240213131946.32068-1-list+bpf@vahedi.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 18:39:33 -0800
Message-ID: <CAADnVQLvh3dd5tXcJnKJis9bJZNV-_dR203PXVyrubZHBuU2_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] ARC: Add eBPF JIT support
To: Shahab Vahedi <list+bpf@vahedi.org>
Cc: bpf <bpf@vger.kernel.org>, Shahab Vahedi <shahab@synopsys.com>, 
	Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 5:20=E2=80=AFAM Shahab Vahedi <list+bpf@vahedi.org>=
 wrote:
>
> From: Shahab Vahedi <shahab@synopsys.com>
>
> This will add eBPF JIT support to the 32-bit ARCv2 processors. The
> implementation is qualified by running the BPF tests on a Synopsys HSDK
> board with "ARC HS38 v2.1c at 500 MHz" as the 4-core CPU.
...
> Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
> ---
>  Documentation/admin-guide/sysctl/net.rst |    1 +
>  Documentation/networking/filter.rst      |    4 +-
>  arch/arc/Kbuild                          |    1 +
>  arch/arc/Kconfig                         |    1 +
>  arch/arc/net/Makefile                    |    6 +
>  arch/arc/net/bpf_jit.h                   |  161 ++
>  arch/arc/net/bpf_jit_arcv2.c             | 3001 ++++++++++++++++++++++
>  arch/arc/net/bpf_jit_core.c              | 1425 ++++++++++
>  8 files changed, 4598 insertions(+), 2 deletions(-)

This is pretty cool to see.
I'm assuming this will get reviewed and will go through arc.git tree.

Could you share performance numbers interpreter vs JITed ?

