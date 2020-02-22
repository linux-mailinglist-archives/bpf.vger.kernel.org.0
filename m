Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C7168C4F
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2020 05:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgBVE0H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 23:26:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46178 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBVE0H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Feb 2020 23:26:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id y30so1988015pga.13
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2020 20:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S04MpDY/ruT9R3530Z87j5UAy18sgkgPvdS5rq+kd3k=;
        b=HC6tB5/n3jprjIUAPVp7s8TE+lw3DArPemCjTLFf6SZTq8rdljmvjDQKfwnpDCqu9M
         McuEh8+mx8FGgpNOPUbP/5TCKlQV1w1VEu4/HSjSNXVsfPT9ASGqbZKiIFvVJAlUrr86
         aZuMUWYfnYI9yYDHnbwRw6bEQzeTrErT1JXZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S04MpDY/ruT9R3530Z87j5UAy18sgkgPvdS5rq+kd3k=;
        b=UW0ChcX9kRgJVoG9kFsm44QsTRdFumddBL9Ey1T9Cy6d1sg31yaLVYoMayFqsI4+Cp
         kC0nf18nHP3KGH8pWdidGXsMNRIlwUhfCeoPdi34uLh07xWbdn3lyvMaXjmiTQK/OwGL
         MmDWl6CnH5UkQngN8fuKFvH8GERwiikR/mJcPT8d+V+Y8T7d49TMeyGVb12GagGWavgG
         /KwoGdM1t6mfn/7iE4Gd+GIxnYmkLb1Kw79H3mE9SsAvgpbOCcRcyBoGSwkwqIdUqLDX
         nOhjTQPv5KRYNyA9tIV4HE09yNJW6Q/iKSGl+TVEQ5DixdtbPAW7KyfTHVS+XPtRxgu3
         wdRg==
X-Gm-Message-State: APjAAAXdHd6HpRh81aThNWWqj5oJFRNQPXDd5rU5cmhSb2JaWqvL9gww
        m8JmBmtxPYm4tbEXIfC3fMpHeg==
X-Google-Smtp-Source: APXvYqynLpaT1SHFc7hteRLE/Am8rkGvVcqos0AxtZQFh6Ok/U/TQctt8ObsfFGGlRMXV0KtzIJk4Q==
X-Received: by 2002:a62:1548:: with SMTP id 69mr41986772pfv.239.1582345566578;
        Fri, 21 Feb 2020 20:26:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c15sm4342928pfo.137.2020.02.21.20.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 20:26:05 -0800 (PST)
Date:   Fri, 21 Feb 2020 20:26:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v4 4/8] bpf: lsm: Add support for
 enabling/disabling BPF hooks
Message-ID: <202002212023.1712A8AB@keescook>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-5-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220175250.10795-5-kpsingh@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 20, 2020 at 06:52:46PM +0100, KP Singh wrote:
> index aa111392a700..569cc07d5e34 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -804,6 +804,13 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  			break;
>  		}
>  	}
> +#ifdef CONFIG_BPF_LSM
> +	if (HAS_BPF_LSM_PROG(vm_enough_memory)) {
> +		rc = bpf_lsm_vm_enough_memory(mm, pages);
> +		if (rc <= 0)
> +			cap_sys_admin = 0;
> +	}
> +#endif

This pattern of using #ifdef in code is not considered best practice.
Using in-code IS_ENABLED(CONFIG_BPF_LSM) is preferred. But since this
pattern always uses HAS_BPF_LSM_PROG(), you could fold the
IS_ENABLED() into the definition of HAS_BPF_LSM_PROG itself -- or more
likely, have the macro defined as:

#ifdef CONFIG_BPF_LSM
# define HAS_BPF_LSM_PROG(x)    ....existing implementation....
#else
# define HAS_BPF_LSM_PROG(x)	false
#endif

Then none of these ifdefs are needed.

-- 
Kees Cook
