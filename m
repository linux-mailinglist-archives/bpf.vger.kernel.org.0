Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950A8419DC7
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 20:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhI0SF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 14:05:58 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:46867 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhI0SF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 14:05:58 -0400
Received: by mail-ed1-f48.google.com with SMTP id ee50so72747850edb.13
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 11:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=kj9pPYctyJXV7Y3AFdkYGFCnkQGUCW35+qJGPoKarAM=;
        b=6QDyNzEpPjuDxAYUXlSCo43LJlNNTjTkfazRlIHfAyZaueQnjdmL8yutiw1d1dAq7b
         n3kYm4ICUoBBVz8rlExsw+BfoR/8WVfc07KB5/+EC4cecu4RzIIwUVD64Y12e0ajEJxN
         ao1dMpHHyf5iV9OBkjmLgvjYh7ueoAU9zjsJwm0dj/gccJLySxM8NsrhHdnf6yfLtZUz
         Xd7Kut4+qEp7lsO/zGNvTQXO306c8oRgCk1Nof8EF4vQb3QgnWD/6NvDLzNMiUoOhRb1
         GRbrZDmXwYJJFqrQl/LybDzfg3Pup7nxcHYqrGPj4HSZBQgAAWnoF38fhF7NAdpajK63
         8QZQ==
X-Gm-Message-State: AOAM531przAXSiEYOhwXi96YRZ6pSxJdNHBcS014xEIWYi2uYvwckzfW
        Wfe0yJpnnY3CloPixGuOBmk=
X-Google-Smtp-Source: ABdhPJwWIaWRpt9CK0kSZog7TBXWEcguL5J2wAuXgKPXPOEAAXO2t1gxLJj6TZSWRGc/g8BmulDOgA==
X-Received: by 2002:a17:906:9bda:: with SMTP id de26mr1525420ejc.378.1632765859113;
        Mon, 27 Sep 2021 11:04:19 -0700 (PDT)
Received: from localhost (mob-31-159-14-51.net.vodafone.it. [31.159.14.51])
        by smtp.gmail.com with ESMTPSA id z12sm10910417edx.66.2021.09.27.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:04:18 -0700 (PDT)
Date:   Mon, 27 Sep 2021 20:04:10 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, lmb@cloudflare.com, mcroce@microsoft.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH RFC bpf-next 04/10] bpf: Add bpf_core_add_cands() and
 wire it into bpf_core_apply_relo_insn().
Message-ID: <20210927200410.460e014f@linux.microsoft.com>
In-Reply-To: <20210917215721.43491-5-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
        <20210917215721.43491-5-alexei.starovoitov@gmail.com>
Organization: Microsoft
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 17 Sep 2021 14:57:15 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> From: Alexei Starovoitov <ast@kernel.org>
> +	err = bpf_core_apply_relo_insn("prog_name", insn, 0,
> &core_relo, 0, btf, cands);
> +	btf_put(btf);
> +	return 0;

Why not returning err here?

-- 
per aspera ad upstream
