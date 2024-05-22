Return-Path: <bpf+bounces-30301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC0F8CC18E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A981285698
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835413DDCC;
	Wed, 22 May 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eY3zJIq8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B51859
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381966; cv=none; b=i092kkY9KtDt5AN5JhvEXNxl6vFs2DRoExenQshyY0SHv3v++OeyqlcmGH16f+iqjidx/zBLQw37qUR+tAncRwIdyo+1rISupmghaIyxqhHXmhbMcVcFALAKY5xkmkV77/A42ephsyHNwNDZg+xZ19jbnroh+1Ez+tXaAjmqTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381966; c=relaxed/simple;
	bh=ZQJQmXhWg9nPg2zrXMvCQ7J/HQIRLAQCnGo6p6LlhiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DETZZHo/iOc/NS6eGbfUuqdepjp+evfbmu13pJPKyKbdO1jTbgC1Dtz/RREIJYyV18oHM0FB0o491+iOstM5UduKGAPYqutkTTPyxRSJDuw8NKPiemUo60C7XQZvPdNyD6EwoKYrrZmy/Gw4qmy1biF9Xhzw/jJqiFuogKO8yXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eY3zJIq8; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24c10207d15so1797372fac.2
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716381961; x=1716986761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WijfuUs+156edccXDFhHVcWXKQ+B4/XZiPfwdG70AgA=;
        b=eY3zJIq8qYY3iPPEEG+Ui/t+RVk6COnu0Icn3wSiWx2s5jUXUf902XD1btzA5YgLZ4
         jnkSwAb7+qIpUckLOOgLLpDMs91Bp/VMXgtBzC7ZVLNOfiwFIz9v5L857FQNlXouNUVw
         BcLWAkaSYpowlFkGkiwuF5PXIIeZM2nXmLIqKPdgZOvIUXQVg4oIfQ7jrMJrp8UlNfjW
         IiYWCdbvt7W96FE+2Y6p3Jv5pkKZ9Svfql7bjSVJ1hOseXJcKUnevTW3Io/dyzG+Cdio
         v7r38r4L55lhsrUngYmIE0RSfkh/gQTDkm7EFzB4M9Alxh5oG1hwM4hqywjV0itViPwN
         51PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381961; x=1716986761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WijfuUs+156edccXDFhHVcWXKQ+B4/XZiPfwdG70AgA=;
        b=Pk/nsj2f7Ff1VKsX1XeAVAy9QGZEfdpgqyKSC9Qs8b0mfvxlVqLCBHckxvMsloG+s/
         XM5oTcZUgTRyxyRVgY3amtv+EeVUT6EiQ+qKo0N+yid5PMBfW6LR3NSkmFT/4LZyZzbs
         KhLhcIbTWg6qdfNos/2rtIjpEI7/bcm1haheaPLb4sSo2hHqN8LQ4Sgf4pNdtrg7XS8a
         Qwuh4HvdUHV5Q7bWF0z+VCG88uC1AdJic3Z+iYhm/GzXhOmZb/XsIO2Bxb0MT2Yd07wn
         nsGXQlFaV+Rw2hMt/ZZMxqiXvPrculOkl5AROh2ORudgsr4WIqyO+bi4+4hy1SuqDUiw
         0ikg==
X-Forwarded-Encrypted: i=1; AJvYcCVe1Qlk2xthkZOdE0kMwN0/6469VcWye0NWJyRHK1m+MWjhbmZNi2aqnClcEMoK2hIhqCN+ptHgrQL7p04tzwVUMwU+
X-Gm-Message-State: AOJu0Yw7min/URhtf6kA1NcXkps775xsGmuEhcAHrqlKWDjqZYHa0bpR
	1XJLrzeTQEgMFtLdEjMyOMPC6BmzTiZ2r8PY6Al6lMHnOrS5OqizKfW0FvetM1I=
X-Google-Smtp-Source: AGHT+IETP3qReUQJuxRlhxnWJn7QpbV+LVqvRpkT9nppkVGnw4JfRUuMImdtGPF2qcpBugAZnHpoew==
X-Received: by 2002:a05:6870:d88e:b0:23d:a1d0:7334 with SMTP id 586e51a60fabf-24c68a33ae2mr2153288fac.17.1716381960558;
        Wed, 22 May 2024 05:46:00 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e074719d1sm151805451cf.35.2024.05.22.05.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:46:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9lLy-00C914-Bg;
	Wed, 22 May 2024 09:45:58 -0300
Date: Wed, 22 May 2024 09:45:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v5 23/68] selftests/iommu: Drop duplicate -D_GNU_SOURCE
Message-ID: <20240522124558.GC69273@ziepe.ca>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-24-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522005913.3540131-24-edliaw@google.com>

On Wed, May 22, 2024 at 12:57:09AM +0000, Edward Liaw wrote:
> -D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/iommu/Makefile | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

