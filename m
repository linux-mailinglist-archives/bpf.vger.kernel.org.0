Return-Path: <bpf+bounces-35653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952DD93C76B
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68151C21CDA
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5119D887;
	Thu, 25 Jul 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG0Eir9q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330418786F;
	Thu, 25 Jul 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926318; cv=none; b=rFj0f+qmRO2z7Oxa1Ozm90ux6dXK67OCGoVAxwZ9/pQx4BbYxm/Y0acD2D//j3Kdn4CYhi7ejDSGT/uG8fOSgjgvo+OeaynET8lcJvzTX/E4qzdknVOJggIW3Xabum6/sdDk+VY+e5xdzbvWuHpXIG4yVJOF/oOuiCxkRgVRjkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926318; c=relaxed/simple;
	bh=LO0trDf3tcvnDiZLS8lZvt8i57f3eDeRwzr9VWx4wMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY8eytKSg54+vE2hXU8HWLByVFbKFO2ze+AqMVS1/ybMP7fLsfIk2bA0mKoGkbCifz7ZPx4QjLNp13u4yseflca9gXZedwmGsFyTdPovFeIWd8K9P6CQi1jNUF3NkT8V8o9Sjl5GugM5QUwLpwWklIO1yCj0SitVI1qjjo3dTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG0Eir9q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso693023f8f.3;
        Thu, 25 Jul 2024 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721926315; x=1722531115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO0trDf3tcvnDiZLS8lZvt8i57f3eDeRwzr9VWx4wMA=;
        b=MG0Eir9qjxwHM4r1/Oc0w+mUX08b959jYRv7lLRI4lxpSnXzXV0qtWjCxGZbPezpqs
         v3Lgnu9dLKa3NKpToU5FACgrVEIBMUgb5O0sj9C6dyZc7W77JzHLJfR5qHVIpUXfTduN
         AV5yIJ91ILP5+PvIkoRgY0dISESAq64PGwhwiI+xm82bsOODsvxWwqsqY3RbE2ELjNgb
         IcvnU7akJvWz7yy6nxmd3G9jiCTINV2dtAOIzeMvf+JdJzdQsp1bNp/KiSe13Q4OGjsg
         j89CD8dWVSjt6aS/+we1LfNRiXwc8GqgP4AHJCI83DwbKJcnL49VjkgDtyC8C4HB81Xr
         11rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926315; x=1722531115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO0trDf3tcvnDiZLS8lZvt8i57f3eDeRwzr9VWx4wMA=;
        b=J3DbCKcEv1WqJoqUsxdsjpOmFs10Lm9WMOjoGJf76GBCYj2QcCBexRrkxOoDiAz26r
         QNOCW+UEDuSNaT3RAvyoqaLxIypKQbOO3TWdZeUJYupQVAVTYXyKFbEx1g3Wj6yNBAZ+
         IPMFVgoKldhySeW8THfsOMlxCT5wt+IYRxY5bSxrco1xEDnW/48wneUfoKaPjFGJVHj8
         6yPcAYN0eL+WFmdA0dOJOVRnDwQKgKKPMyYXjZyQdKsfwBcvtWKuaqyFHqhMVyr3cvd0
         BH6XYDVN4HLAePyYMChrcEc3g5ZINo3uqYVQ7M651tUr3cPcoDl8V/fG3ab3XC33VrXz
         HBvg==
X-Forwarded-Encrypted: i=1; AJvYcCXkSzzaIKVx+NS+ioEOQBMvjJwuB8xD5+HCG4f5rnp6uIvhoNt/BSCJTn2JgiZX5diQIPZ51mBrNS4cbI/QomfeYHkxbAJJdiIEaSL0iB1DFkNgKtIy0B01UyrPu57NJUli
X-Gm-Message-State: AOJu0YwHCjKdoxOTauGMmSCMBu+5IhI/saRk7J9yWDjkJlrymI/3jGjk
	3xriu45feRYOV0PhWoWWEoYGQBSyu45ypcxhr45ELQ34xEnywQek5+tU/OB/KJ0OfXD9BcPN9Lm
	30G/FIc4i7bycpfBFnCIi6UTOdGBxxm0aFK2xLw==
X-Google-Smtp-Source: AGHT+IF6xWzQOYKFBCFTvdcsGzFQ+/gROkMAYGBXJ0cX81+0TMDNQbeuXayLLUmvHN+ae1Tai8qoMUCHx2GnVkBi5rg=
X-Received: by 2002:adf:cb94:0:b0:367:98e6:362b with SMTP id
 ffacd0b85a97d-36b31b4cdb2mr2618471f8f.42.1721926314909; Thu, 25 Jul 2024
 09:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725051511.57112-1-me@manjusaka.me> <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com> <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <43e95369-3a4f-428b-b0e0-329880173167@manjusaka.me>
In-Reply-To: <43e95369-3a4f-428b-b0e0-329880173167@manjusaka.me>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jul 2024 09:51:43 -0700
Message-ID: <CAADnVQKtu1=ybxbzLQUMZQz3pwNJVjB+18t0vAhGAb=6kK8UbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
To: Manjusaka <me@manjusaka.me>
Cc: Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <hffilwlqm@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:33=E2=80=AFPM Manjusaka <me@manjusaka.me> wrote:
>
> Actually, for personally, I think it would be better to get the error mes=
sage from dmesg.

This is a non-starter. We're not going to pollute dmesg with
verifier messages.

