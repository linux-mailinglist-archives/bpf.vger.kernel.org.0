Return-Path: <bpf+bounces-34945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 447469337FC
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 09:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4731F21D60
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BFD1BC39;
	Wed, 17 Jul 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yc5SLZ9o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F21C287
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201282; cv=none; b=PVt3AZjmKA+An0wHPsbcnx5lJIGfuvNRtRR1gmAN9fvqAoKAyVMI4bu6kRbnWwmjWGyWc7NsmIETkTWPtRLnp4Z6lD6b9HVngIySJXzokoyC/nyUB0IakoGsggtsiFbkstlesWMrrRSHUNtW7OOEkrdQ/990vF9uPwKPR2F7gNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201282; c=relaxed/simple;
	bh=YrZFAr3t0o35EkxMvDKncTU/njOgu09D4dJSZCyCxXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwf1O5Tp0N2kA/iSKQdLE0hWyDjrBYWt1knG0ZgXXvKA8pTK4o3GxKGcIDUZGV26gaLWr7vj/i9GJUhyLhjuY5kXYop3Ur29BUTuDlub1ETfThM+boJYAxR8ycsNNFRFnH6RaBdHJ1NNtXwqOSnbZZQ4Ox+8FEVci8XY6NbKoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yc5SLZ9o; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eeb1051360so59766151fa.0
        for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721201278; x=1721806078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLNLJ8bHGRvsudMSUMYbziDqJLLKDwjnKWI2Kgrl46A=;
        b=Yc5SLZ9o/t0s17fKruull9RpAakaTPXvQI62CsPw+Mhvb3Br846Yi5I68BGBs8lKNH
         XkaPe/FzBaJWfyNzog/FBrtgE9DxI2uhiFtqWx3aYIZ0pPk/QuoyjAs82oLHzCHVwz/m
         rrXg8Lee15wSnED0DD6SAyj61MnO489mrpy6/+yEtedlufaqnpXXRz542qfjYjaqkpjd
         koCgODYwGttrSsLYiY3HqxAdBoAA+8zxil74RUB/m3FJw42Dt+ZHvCNcBBJASCSmiX7Y
         3d0m+JOimIn+qTvoDcAa+5c7PNieLqC8m7VSo9gPW/C6kmyEGIHHddmvfZVHbi74LYFz
         iZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721201278; x=1721806078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLNLJ8bHGRvsudMSUMYbziDqJLLKDwjnKWI2Kgrl46A=;
        b=sgzKMhb4ryCL5CVMLrUkaTmR6sGfxW70WP/yCbXDzLpkzoppY0vTrcfdhYL6tKdEk1
         Rkd7DVFr3fRtbQLdVoU2XC8IUpZQ++Or1MuwyMWPVJKWbv3OSttFxBn50d9EFKcawLSG
         yawBgLoxedfnr70VZF95QPmYjLxXttTddx37+lns12ejrL0ZmF/C15xBjI67g0MvqV/l
         oD7jGTu2NFnqTABSbQ+2hfk1O0kITdYw+xKu+XSjWZ7fbIzj/Fqg8qmR27XgJNelYuUL
         FDgRXPTGrS48x/gQN8fXoIrQuwmOWqMmF0d6bdFQgtQ5aMghYB5sXEhh+qAZ2dy/H2Cf
         Ep+A==
X-Forwarded-Encrypted: i=1; AJvYcCVsqUGFkpP7902UjKjP3g/STYjH6SKhiKq+MF4XEXU5glackH8omnsubs3MK+GOBecZdhHQFG67+EklF73C9AJqlD0T
X-Gm-Message-State: AOJu0YyPNj26Rn9e8Gj2JzG0+dpYH5Req5YuCxNapn58O1u6IDQzvcKr
	7yhKYBQeppfW6/C5r3/kKqiloUiYJws7uq/aW1SgK8nXni7b2NBR16igb3Sn8IU=
X-Google-Smtp-Source: AGHT+IG6XmZH4UYIkcTfuy5FHCZsKDoPhst7HcH4jHW3silflQorsYFZ1QHhfpLbCBbvKsb+5Cbpdg==
X-Received: by 2002:a2e:a378:0:b0:2ec:1810:e50a with SMTP id 38308e7fff4ca-2eefd1c26a7mr5121551fa.32.1721201278216;
        Wed, 17 Jul 2024 00:27:58 -0700 (PDT)
Received: from u94a ([2401:e180:8851:4128:f220:4127:f2c8:abfa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c995sm7752290b3a.15.2024.07.17.00.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 00:27:57 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:27:48 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Get better reg range with ldsx and
 32bit compare
Message-ID: <gdvrw45gkbvavrjydfqildqdjkttvyy5xfow3gghebtmlwvw6j@kluzdoxhnotf>
References: <20240712234359.287698-1-yonghong.song@linux.dev>
 <3594134da3dd50a5e7fca62d9843c47a8b47ce9a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3594134da3dd50a5e7fca62d9843c47a8b47ce9a.camel@gmail.com>

On Mon, Jul 15, 2024 at 04:55:42PM GMT, Eduard Zingerman wrote:
> On Fri, 2024-07-12 at 16:43 -0700, Yonghong Song wrote:
> 
> [...]
> 
> > This patch fixed the issue by adding additional register deduction after 32-bit compare
> > insn. If the signed 32-bit register range is non-negative then 64-bit smin is
> > in range of [S32_MIN, S32_MAX], then the actual 64-bit smin/smax should be the same
> > as 32-bit smin32/smax32.
> 
> [...]
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Other than the already mentioned typo LGTM,

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

> [...]
> 
> > +	 * Now, suppose that register range is in fact tighter:
> > +	 *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
> > +	 * Also suppose that it's 32-bit range is positive,
> > +	 * meaning that lower 32-bits of the full 64-bit register
> > +	 * are in the range:
> > +	 *   [0x0000_0000, 0x7fff_ffff] (W)
> > +	 *
> > +	 * It this happens, then any value in a range:
>            ^^
> Sorry, one more typo, should be "If".
> Maybe could be changed when the patch would be applied.
> 
> [...]

