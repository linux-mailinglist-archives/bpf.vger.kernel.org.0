Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84F525B84
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 03:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfEVBEj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 21:04:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46725 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEVBEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 21:04:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id z19so392876qtz.13
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 18:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=wvMTdrFUPputvvouLMBvi2pmMD6BVgnc2STEUklDvOY=;
        b=XU66xx4A4SP/8XgRREw8lgS+ZxEFYTSlXrAbdnTJozk6cf1la2f95ITYHyRqqX7qUk
         Fnc6878GtzG6QC9m1e3p411t85Ec5MwW9JBNe8wcckhenozGg8g+IVq7UsgxGk6RhoXR
         qBGvxa9+wDE0p96ciczrlYVI2ld49YdnXu/6nvPZOORZs9kRX5QXbsT0B+kMknS749An
         Wqauy9BYMHQmPr2V8rackRt6NcWW4ZHIW+hZ8c+BfzKLJuPgIE1DfdBJOwczuJzP9Omt
         g/BsTSFhY1xAYSX5HbCp/Q/8O+N+aQNHOLEI3NvrLONfDCXy7P2ePyRkKLjNwKrQ3Xnf
         7WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=wvMTdrFUPputvvouLMBvi2pmMD6BVgnc2STEUklDvOY=;
        b=mFVMdOvY4A4b+3YHj34YAfzb4LeFwfHc7bmxqFZ9H/mpiiYfsd86OTWm5T5LeHJb76
         2d+ZgsPOiaevh1ARXJVnOkUIPj5Am+T7CwsetTHZ+YOAMXxV+4Brh0/s1MstdTbi5An3
         3MoYPJXnoAo5bSH9ivp7hkDKdtblZ2AZScOWlgqHlukcLtkZ9I5hHelWnYZcQ/ZWGUtw
         3lCocNvAiHW3F4NrlUOWTjqd2CtqssnBAArSEYqcLIvb2uqd2JgV5A+TM4y5yu/J01P/
         R9/PbVIL1JljPivh9kBs3EUG9/mrfQ8E1ALgFoUedp3tvF2PqJCALoL9gbFAUnFdg91P
         MWOg==
X-Gm-Message-State: APjAAAXRDaT2hJ0mkIua6IzQdvZoLDG5d08pRnSikwGRVjI3K2zhquAf
        ivRuztkRA2KTj1oF2VmqNtJSrQ==
X-Google-Smtp-Source: APXvYqxjAbjzPuGxyI6XrYZOgCWkgw/8H2bFgHMOM1Z00y0URwt1bARHcPzUrn7DKxvd/wnZFGfuZA==
X-Received: by 2002:a0c:b902:: with SMTP id u2mr13588017qvf.151.1558487078366;
        Tue, 21 May 2019 18:04:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u5sm12294898qtj.95.2019.05.21.18.04.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 18:04:38 -0700 (PDT)
Date:   Tue, 21 May 2019 18:04:03 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     <davem@davemloft.net>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: cleanup explored_states
Message-ID: <20190521180403.0a24e0e9@cakuba.netronome.com>
In-Reply-To: <20190521230635.2142522-2-ast@kernel.org>
References: <20190521230635.2142522-1-ast@kernel.org>
        <20190521230635.2142522-2-ast@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 21 May 2019 16:06:33 -0700, Alexei Starovoitov wrote:
> clean up explored_states to prep for introduction of hashtable
> No functional changes.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/verifier.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 95f9354495ad..a171b2940382 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5436,6 +5436,18 @@ enum {
>  };
>  
>  #define STATE_LIST_MARK ((struct bpf_verifier_state_list *) -1L)
> +static struct bpf_verifier_state_list **explored_state(
> +					struct bpf_verifier_env *env,
> +					int idx)
> +{
> +	return &env->explored_states[idx];
> +}
> +
> +static void init_explored_state(struct bpf_verifier_env *env, int idx)
> +{
> +	env->explored_states[idx] = STATE_LIST_MARK;
> +}
> +

nit: extra new line here

>  
