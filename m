Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D533D1EC2
	for <lists+bpf@lfdr.de>; Thu, 22 Jul 2021 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhGVGef (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Jul 2021 02:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhGVGef (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Jul 2021 02:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626938110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbeaBbCKHLyJ4xr48Gzl+y+Ld5Xe5na7a5Nw+NIBfBE=;
        b=dLA4PE71qi0Ph3I/uqZL7ISZYd23yn+XqCocdn8FUcI4riojHKf95LnNgnhnE2Rx75QE/x
        NDiWubRJJuikNs5L4siUtq+0aIsjFxmZzxx9E2oLgaTjcWGopQAenklwvWiTX4LV7UVQKk
        Ox9C5fxiSeo7R0UbtYBJqOisI9htlvY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-zUjsOISPMOSZCfaWcx4Tig-1; Thu, 22 Jul 2021 03:15:09 -0400
X-MC-Unique: zUjsOISPMOSZCfaWcx4Tig-1
Received: by mail-ej1-f70.google.com with SMTP id m7-20020a1709061ec7b0290549bc29d4d7so1498988ejj.20
        for <bpf@vger.kernel.org>; Thu, 22 Jul 2021 00:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HbeaBbCKHLyJ4xr48Gzl+y+Ld5Xe5na7a5Nw+NIBfBE=;
        b=S2of2+GuoLPC+9h014sJfC64ad+6qmQl4aoV4BfD2LEbigMTnXiXbvJWa61c7hVXcn
         6/wBHSjEDUZ1uxKjXSlMoMRdXU7Vz1UqHTCVnVJP7RmWiCM+wzmQs9bFE/4/9vwkIijS
         BhJBc/KB1XKTcx8ug8pQI9cY1M8SjSbYRQKp3wIQjtVyzrYJwYRFEzagdT5/v9G4XxxU
         NG5nJL6VIuk0OkzQ05qEFhGzRJAdRWzM8BPFhfS6/b8waMqVA+Bnl2QgOIEZrmHIkIYF
         oJ8PZcgMCS1/T+A9D9u+2IdPp6JkqNwvJn3l1Wx+UtFvi8QxLkb7LAU2fLLLWbQwzNmC
         4BsQ==
X-Gm-Message-State: AOAM530Tfl1tOgHKne130syoNgFcZbHRGNp4iEUy2nFSD0GKr27EWUom
        xX1gHX0B4jvn1OGT5nM54nHSSYuJy9N1HCFx5lbSSmyH1d1Z6XW6DGNJiN2BBSv3IeuChNET6Xn
        QvmcvVLLLGbFT
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr42752662eji.385.1626938108186;
        Thu, 22 Jul 2021 00:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy6xfgeset5dZus4WoJj5fvONkpQK/Ym4JM4fnth0Ivfcf1Q/QMLHjsq53HiTg5oXsndk2Ug==
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr42752647eji.385.1626938108042;
        Thu, 22 Jul 2021 00:15:08 -0700 (PDT)
Received: from krava ([83.240.60.59])
        by smtp.gmail.com with ESMTPSA id lw1sm8064787ejb.92.2021.07.22.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 00:15:07 -0700 (PDT)
Date:   Thu, 22 Jul 2021 09:15:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: Fix func leak in attach_kprobe
Message-ID: <YPka+SuGAQAAhez/@krava>
References: <20210721215810.889975-1-jolsa@kernel.org>
 <20210721215810.889975-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721215810.889975-2-jolsa@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 21, 2021 at 11:58:08PM +0200, Jiri Olsa wrote:
> Adding missing free for func pointer in attach_kprobe function.
> 

and of course..

Fixes: a2488b5f483f ("libbpf: Allow specification of "kprobe/function+offset"")

jirka

> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4c153c379989..d46c2dd37be2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10431,6 +10431,7 @@ static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
>  		return libbpf_err_ptr(err);
>  	}
>  	if (opts.retprobe && offset != 0) {
> +		free(func);
>  		err = -EINVAL;
>  		pr_warn("kretprobes do not support offset specification\n");
>  		return libbpf_err_ptr(err);
> -- 
> 2.31.1
> 

