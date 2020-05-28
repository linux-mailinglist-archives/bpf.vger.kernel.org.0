Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F7C1E6E6E
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 00:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436905AbgE1WOG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 18:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436899AbgE1WOD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 18:14:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4970BC08C5C7
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 15:14:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so1073331wrv.4
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 15:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tt0Tg3GLkWHkJ4q+k/gu/XYcvqOHbgKe/WyfRdpAP/U=;
        b=NIRVprwfOqmaFPY2/MsnPb2FBS7znrCdz9xh0fbhHmsYVeMjGHTDSK9OKZL97YPxyP
         DAipmlwnZ1w9h7bw2rV+phj5v36UMhCXKZSvD2E1auUvIJB6jaXiJUvNDmOmpKNs9n2v
         wixHY+rGyxwaPhFExshTNmHgt6FUP/iiNW9kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tt0Tg3GLkWHkJ4q+k/gu/XYcvqOHbgKe/WyfRdpAP/U=;
        b=ZpH33l6i80SvQbEzLiAddFlRnKZlT6s6+rZ6884zVFMV29PmbbN6WhnGgOpPsTraeK
         uaqPiHeG5JHOdkAmKYLDZV96GPb/g/Mi5oTAGf9dIhvvXAo0bHCUHjk0Cc1V2HxLyuIm
         +5qFc3kSJv0ecMtlP+EwQGRi6odf1dx3vbr3NsNbgy76FNugARfR0TkLWW863sAmj6e7
         6PJ84d9VvHNBxG2bVynYhIrzo/oxysIRc11JhNvWEmv7I4NuS6NpwXUPVEmy83cW3WK0
         KiIprkrIjqBnlAM5fEI3ZVb24I5m2FQ3XF278Gnr+w/LZFUDIewbTJGbqF0pMapUEzG3
         aoaA==
X-Gm-Message-State: AOAM533tn50youE75Nb+mcml1b4tQMK9zTzCJfXEzr/32UHSMT/lMOoL
        gjQv7a4roQRzWUdKC1oc56iZXg==
X-Google-Smtp-Source: ABdhPJwfAgrEzcAXD3IXN5g8f8HN7as/5MyOVRQimV416kIZ2vLW4lxys2MDPVjtah5gG0Us2mXIYA==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr5433935wrq.222.1590704040991;
        Thu, 28 May 2020 15:14:00 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id 10sm8559672wmw.26.2020.05.28.15.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:14:00 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 29 May 2020 00:13:59 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/3] libbpf: support sleepable progs
Message-ID: <20200528221359.GB217782@google.com>
References: <20200528053334.89293-1-alexei.starovoitov@gmail.com>
 <20200528053334.89293-3-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528053334.89293-3-alexei.starovoitov@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 27-May 22:33, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Pass request to load program as sleepable via ".s" suffix in the section name.
> If it happens in the future that all map types and helpers are allowed with
> BPF_F_SLEEPABLE flag "fmod_ret/" and "lsm/" can be aliased to "fmod_ret.s/" and
> "lsm.s/" to make all lsm and fmod_ret programs sleepable by default. The fentry
> and fexit programs would always need to have sleepable vs non-sleepable
> distinction, since not all fentry/fexit progs will be attached to sleepable
> kernel functions.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: KP Singh <kpsingh@google.com>

> ---
>  tools/lib/bpf/libbpf.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

[...]

> -		prog->prog_flags = attr->prog_flags;
> +		prog->prog_flags |= attr->prog_flags;
>  		if (!first_prog)
>  			first_prog = prog;
>  	}
> -- 
> 2.23.0
> 
