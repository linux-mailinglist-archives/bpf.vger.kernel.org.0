Return-Path: <bpf+bounces-66355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B79B326F1
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 07:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38E35E876F
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 05:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125FC1FDA82;
	Sat, 23 Aug 2025 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdW7Y/+S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEA12CD88;
	Sat, 23 Aug 2025 05:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755927933; cv=none; b=Z5YBkbLZpb/a7lBdl7lOvjQg+cWn87ISeyoVz93SAyoaruAeukcMcZHzYHQb85Gl5gE/17irzAMAxYcWmsUP6364bzdz703p4nwuwfVROnKh1XeN+iQlsTvwn+0LdyFRNCqO9+zFRWusvWDOPRJ/q54xU+YOhk6YWA0dFfAWSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755927933; c=relaxed/simple;
	bh=4c1uRTP1ULf8MzVaohNYgZKILmRfZfYAs/EfNYq5oBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCEjerYCvTP+FGjfN4qcd00Ly9L/QhSRHSHe/gBoJAjI/dsNo0swJGpBMmZQz/tHlFtchHPypejkbDIQkvjSV9PhcQRQ7OJr3Z7jQdMUaR2RggEAnTDBNCPpYJbkNq0RcORas4CbEejAitVXRLPjARfHVerV5Nifh0orz88xIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdW7Y/+S; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c380aa1ad0so1457600f8f.3;
        Fri, 22 Aug 2025 22:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755927930; x=1756532730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHyH7SH7PU5UaHOdLMIKMPTSPXJ2+4pLSckTrVkAoLU=;
        b=cdW7Y/+SfJ25MIIYJDoQZyo4ZDuej3jZP7wQiNb8gq4r2iNNA1qgOG4qHGJY640pD2
         RyXpj0BkliUqyBoeqc/sivojM03aS543sTZCap/b2gOJcLcwK0iMdDJ4/ONP+W92NKVv
         R4AAkFg575nOe85MnB9L/xPScELrLFBN6YzIOgK8H09W91JnGUPFYxkzPgY8H3jmOokV
         wf4y1EnnubglXBddPDim/a9n+1KsYU5FVYsCLknDtJePyp1Fjs/Nf9LZ565fakWoEqGw
         Y/RRL+tj16DFr3k5u3bN2ucwf/BexpJ54qvWT33jYRfCR5BZy99owJD4S+oCVMoqekpo
         QswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755927930; x=1756532730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHyH7SH7PU5UaHOdLMIKMPTSPXJ2+4pLSckTrVkAoLU=;
        b=C579PPoGooVvrF6dC5kafLLv/9OxjOnJUOqVu48AgdSblgnaFIrVyJJiUGX1K2ou1z
         cx0fIK84ckIuHeESgYML2/yD7r7GD/oQgTiCr/lO7TWiCls7q9kysXxSgKtPPO5Eq8Lf
         LIFrknGYiwm2HLwLG26Q79TLfcVso6Y+hinryaN0dYhOwi335YaNgXyItQ34CY0xUbHm
         BVgmCaanhFPCIQU+/NmjwvW4++1u6rdEeiWPaZVUyxUUiqnQLgdUuK/LTYKwFX03i059
         JeYT2Vx0DY0/SlsbpdVLICx/vXOJt+koobqWnPAS59gVlCldBzVhd3ZnjtWRYrLhFWFN
         srnA==
X-Forwarded-Encrypted: i=1; AJvYcCXvezAAFntHBB/bNj5jMUoTlIx8EPegE062waLm5ZZvQWPBphYfnrPTTv3XtbC/nUIdsSEa5qy/MHCatfhi1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0q6qIrBY5cwydvgcNGgYGwFL0SjdWA9+YbYO8fbduoNDOTeIx
	bwISB7pJ7iVIbO1dtluHYGxIpY+ZpJC+I4t4KLS326TL/inaCKfGUYzE
X-Gm-Gg: ASbGnctu2e7ljohgXqpOjRwkwpdabkz23jA+A6huVS7XuGlymWGVecitHPeJLGygR5l
	D5Z8sodakiCqfoVzBLDHzXjVwKj4Ax4uW7FcwP6qNGx+hQB2cWSkZ2xa7dXNx0UR1291vqnPQMk
	CvvFHdvikIho94kUc+P6qy8itu2x37nXqph530Y9B6x70uuHy8txE2LNbKUcDBYe2MeQgeUHvzA
	mEh+EjZV37nFbV7EZxh6Zn/0hXU2DBXj01KG925M9lATA/LPpPZolEE48s30je9hS1msCTfiqkv
	hGqdWe2U6fX46O9pW98RRUgSWdjV51TAl9F6wJxLWmL5UrUEgDr43T2HW0gDqWzIGBG95uQZJ9k
	B05WVs5StIHcC1ZNUbEDaxXFuMNao+f0ghaDqzbce7g8SUhHHby3z8pp41L7Uuw==
X-Google-Smtp-Source: AGHT+IE3FSE1VWJjDYenOMyDErlW2oj0xKkBLZx8Cc4Yc5rQNXNSm9CfoU6qDcLTMcTeOkEAQUJEAw==
X-Received: by 2002:a05:6000:2288:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3c5daefc851mr4336870f8f.25.1755927929809;
        Fri, 22 Aug 2025 22:45:29 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ef566dcsm2150299f8f.24.2025.08.22.22.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 22:45:27 -0700 (PDT)
Date: Sat, 23 Aug 2025 06:45:26 +0100
From: Stafford Horne <shorne@gmail.com>
To: Ben Hutchings <ben.hutchings@mind.be>
Cc: bpf@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
	linux-openrisc@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] nios2, openrisc, xtensa: Fix definitions of
 bpf_user_pt_regs_t
Message-ID: <aKlVdonjv3URRmtG@antec>
References: <20250822135848.1922288-1-ben.hutchings@mind.be>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822135848.1922288-1-ben.hutchings@mind.be>

On Fri, Aug 22, 2025 at 03:58:48PM +0200, Ben Hutchings wrote:
> The UAPI <asm/bpf_perf_event.h> header is required to define the type
> alias bpf_user_pt_regs_t.  The generic version includes
> <linux/ptrace.h> and defines it as an alias for struct pt_regs.
> 
> For these 3 architectures, struct pt_regs is not defined in the UAPI.
> They need to override the generic version with an architecture-
> specific definition of bpf_user_pt_regs_t.
> 
> References: https://autobuild.buildroot.org/results/bf2/bf21079facd21d684e8656e7ac44b4218a8fcb9d/build-end.log
> Fixes: c895f6f703ad ("bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type")
> Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
> ---
> I understand that perf_events is not yet supported on nios2 and
> openrisc, so this isn't obviously useful.  However, libbpf has generic
> handling for BPF_PROG_TYPE_PERF_EVENT that includes
> <linux/bpf_perf_event.h> and it now fails to build on openrisc.

Understood.

> I verified that:
> - This fixes building libbpf with Buildroot for openrisc
> - This makes "#include <linux/bpf_perf_event.h>" work on xtensa
> 
> I wasn't able to test nios2 at all.
> 
> Ben.
> 
>  arch/nios2/include/uapi/asm/bpf_perf_event.h    | 9 +++++++++
>  arch/openrisc/include/uapi/asm/bpf_perf_event.h | 9 +++++++++
>  arch/xtensa/include/uapi/asm/bpf_perf_event.h   | 9 +++++++++
>  3 files changed, 27 insertions(+)
>  create mode 100644 arch/nios2/include/uapi/asm/bpf_perf_event.h
>  create mode 100644 arch/openrisc/include/uapi/asm/bpf_perf_event.h
>  create mode 100644 arch/xtensa/include/uapi/asm/bpf_perf_event.h
> 
> diff --git a/arch/nios2/include/uapi/asm/bpf_perf_event.h b/arch/nios2/include/uapi/asm/bpf_perf_event.h
> new file mode 100644
> index 000000000000..5e1e648aeec4
> --- /dev/null
> +++ b/arch/nios2/include/uapi/asm/bpf_perf_event.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
> +#define _UAPI__ASM_BPF_PERF_EVENT_H__
> +
> +#include <asm/ptrace.h>
> +
> +typedef struct user_pt_regs bpf_user_pt_regs_t;
> +
> +#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
> diff --git a/arch/openrisc/include/uapi/asm/bpf_perf_event.h b/arch/openrisc/include/uapi/asm/bpf_perf_event.h
> new file mode 100644
> index 000000000000..6cb1c2823288
> --- /dev/null
> +++ b/arch/openrisc/include/uapi/asm/bpf_perf_event.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
> +#define _UAPI__ASM_BPF_PERF_EVENT_H__
> +
> +#include <asm/ptrace.h>
> +
> +typedef struct user_regs_struct bpf_user_pt_regs_t;
> +
> +#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */

This bit,

Acked-by: Stafford Horne <shorne@gmail.com>

Who do you plan on having take this patch for upstream?  Will you?

-Stafford

> diff --git a/arch/xtensa/include/uapi/asm/bpf_perf_event.h b/arch/xtensa/include/uapi/asm/bpf_perf_event.h
> new file mode 100644
> index 000000000000..5e1e648aeec4
> --- /dev/null
> +++ b/arch/xtensa/include/uapi/asm/bpf_perf_event.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
> +#define _UAPI__ASM_BPF_PERF_EVENT_H__
> +
> +#include <asm/ptrace.h>
> +
> +typedef struct user_pt_regs bpf_user_pt_regs_t;
> +
> +#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
> -- 
> 2.39.5
> 
> 

