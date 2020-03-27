Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CEC194F9B
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 04:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC0DNC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 23:13:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44451 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgC0DNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 23:13:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id 142so3907806pgf.11;
        Thu, 26 Mar 2020 20:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/FAiupbq7ijBqqhfCHQ+LKr/8inE0CiEthvKJQ+FYbU=;
        b=IFwqDYEFF2JE0Ho1LEZF7TRM28eNrRIXyMFmHo87Zsulf9Hpa6gYX7X0GzCDlnpzeP
         wCGDpPPXXkdb56RFBp3Fsf2+nlePxViNgwPpSF7Ag5LKo9dsAKKbWa3Wu2R9dBc/oZLY
         QcNRhcPYRxuYfCvB0+Zng+VDeLtWxj0if8iwAv3jAWGPR7/3klUajWesE/2snH+6OU2F
         BadX/emU+WznC/UBetWnCWLMQUpJXLIFYb2Mr1uLmdUNxj0fcplTgRMYDY5qwSJZ/P9h
         mdY3kqQ88iC7PjlQdO275SvUMY3Dv8rJj+LeIC+9wynVn50FxURecaMxqjKXIqEsKhvC
         g+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/FAiupbq7ijBqqhfCHQ+LKr/8inE0CiEthvKJQ+FYbU=;
        b=ucs5KicKfzekMxfFB28RfOzcnL0Z3cHghMnsc6B05Y7hBEqLVH5/mcV+bPSDdnrlRK
         soDn+8A6XLMp2AVeWDxE0+YGXf/0z3eotDSzy1CB4SGtJ64K7wXoOJPDUEvTdpVWxs+8
         YObF0jF15o1UmTJ7xlHiOmShey66Po+mVFU+Qy4BECCbB4xX+WMtRP84RxN0+dWts17M
         smjnycm2AtjItEg430H1Oa13fBYoOYfzi/kSTFzVxASZ9F8PcZQ+wCdua/GPRVhc6htD
         kIsHtFsxbK9+03ZFhquaEk3MvZDDZd5MigzpoYY1IYtsY0E/EhYuaF60hgj/Iu3nkjsF
         000w==
X-Gm-Message-State: ANhLgQ2xfMLGgzJye3BAFZztpLjKqwKEXCusJGMLeMZCuyoT1DPFv+dF
        yr5nnRB5dY0hZMpTu7Eelp0=
X-Google-Smtp-Source: ADFU+vuHzIddnVm+YomQmVyVBvOX/KHr2ffE0qgTr5m2QJt2oN8z3JjXp3HapiCZWFKI6Lod5I+VdA==
X-Received: by 2002:a63:1053:: with SMTP id 19mr11248314pgq.60.1585278780602;
        Thu, 26 Mar 2020 20:13:00 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:f1d9])
        by smtp.gmail.com with ESMTPSA id w205sm2866343pfc.75.2020.03.26.20.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 20:12:59 -0700 (PDT)
Date:   Thu, 26 Mar 2020 20:12:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200327031256.vhk2luomxgex3ui4@ast-mbp>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326142823.26277-5-kpsingh@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 26, 2020 at 03:28:19PM +0100, KP Singh wrote:
>  
>  	if (arg == nr_args) {
> -		if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
> +		/* BPF_LSM_MAC programs only have int and void functions they
> +		 * can be attached to. When they are attached to a void function
> +		 * they result in the creation of an FEXIT trampoline and when
> +		 * to a function that returns an int, a MODIFY_RETURN
> +		 * trampoline.
> +		 */
> +		if (prog->expected_attach_type == BPF_TRACE_FEXIT ||
> +		    prog->expected_attach_type == BPF_LSM_MAC) {
>  			if (!t)
>  				return true;
>  			t = btf_type_by_id(btf, t->type);

Could you add a comment here that though BPF_MODIFY_RETURN-like check
if (ret_type != 'int') return -EINVAL;
is _not_ done here. It is still safe, since LSM hooks have only
void and int return types.

> +	case BPF_LSM_MAC:
> +		if (!prog->aux->attach_func_proto->type)
> +			/* The function returns void, we cannot modify its
> +			 * return value.
> +			 */
> +			return BPF_TRAMP_FEXIT;
> +		else
> +			return BPF_TRAMP_MODIFY_RETURN;

I was thinking whether it would help performance significantly enough
if we add a flavor of BPF_TRAMP_FEXIT that doesn't have
BPF_TRAMP_F_CALL_ORIG.
That will save the cost of nop call, but I guess indirect call due
to lsm infra is slow enough, so this extra few cycles won't be noticeable.
So I'm fine with it as-is. When lsm hooks will get rid of indirect call
we can optimize it further.
