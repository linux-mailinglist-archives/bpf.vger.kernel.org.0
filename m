Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4452431E0EC
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 21:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhBQU66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 15:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhBQU6z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 15:58:55 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BEC061574
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 12:58:15 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u8so15338824ior.13
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 12:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ubr+NmOOIVqWy2ac8Odc94P8t1FxsZe+CXnX3R/bIGg=;
        b=oZZI7+rEHa2vGA+pEGs8gkGz3+hbihptZIQBjK7e+Ufy8GBJpTckmJRN5nRnaO9Cvg
         6q6BtpzmvCgkoBGW8wPsVMZF/fry1qSZ2aEGwSi5aT1bRvQUOw8p4/jyilNxPc1uxeKD
         KXgYtnRRZw8K/zA9kmitSh/M8aYt9vcb8KJtgY63NRZ+ADcjAAzFQQAyGwPPWb28FBjg
         HmiZscjm6x/4oYWJ/ZcixZIEMpHqV14v0r28R8GzDZLw+zIjvTVZ7u3m41iSM7g5p5sa
         T00zs8Q+iSy/z/Kevhtxpfg/8FebzNS/DOQAC9wDEJM6Na9iWPFkcW9w6NmGURYixSF4
         g9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ubr+NmOOIVqWy2ac8Odc94P8t1FxsZe+CXnX3R/bIGg=;
        b=SnkYYa3NrepBGTOCQ5EbHTP6RZokzLuXRBKUn7W8Y+s6JNgdjf4OHElDPiHjCCyyGH
         /i2iC2Tk6cK3k05twr0ELr6enJGBAXOpM/qsbXSwAGXTjEBpndmayq/0ZSryN8KW+aTW
         nK7avEC24gguFK69k0PogXO5r0fuFsSil/67HanIaCIE3LaA1bh31ZaAnvX446NWj4sh
         0V/OEmWvbzWBrZXYBeLh6f3ueADdDmp0Z0xoxhQeKZakQy0JQXmCH+rZsWWWJI8DdHmM
         sgqO3kBYzdAIjWkolE3jeQ/fXCwqkq+XMpcFa02Cnxc7nIq4ytxKb1sgGRusQhqshvES
         kkAQ==
X-Gm-Message-State: AOAM531HCwe+HCqNxqKz4hxHwFFxi645ad2OpyKlBxvkpJ/U1sOQhvXY
        t2YBBdcmSEmIet9EXz15mzk2/SZk6mE=
X-Google-Smtp-Source: ABdhPJyMiC19qeHUq0mYlk/A9qSMx6cPr8rYOwOjBc43HDCisEC3gqfLP6VU8XV5avlZcBQ9/4tdtA==
X-Received: by 2002:a5d:9641:: with SMTP id d1mr734741ios.123.1613595495226;
        Wed, 17 Feb 2021 12:58:15 -0800 (PST)
Received: from localhost ([172.243.146.206])
        by smtp.gmail.com with ESMTPSA id w8sm1769741ilu.1.2021.02.17.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:58:14 -0800 (PST)
Date:   Wed, 17 Feb 2021 12:58:09 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <602d83616c9f1_ddd2208dd@john-XPS-13-9370.notmuch>
In-Reply-To: <20210216011216.3168-3-iii@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
 <20210216011216.3168-3-iii@linux.ibm.com>
Subject: RE: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> The logic follows that of BTF_KIND_INT most of the time. Sanitization
> replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on older
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Does this match the code though?

> kernels.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

[...]


> @@ -2445,6 +2450,9 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>  		} else if (!has_func_global && btf_is_func(t)) {
>  			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
>  			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
> +		} else if (!has_float && btf_is_float(t)) {
> +			/* replace FLOAT with INT */
> +			t->info = BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0);

Do we also need to encode the vlen here?

#define BTF_INFO_ENC(kind, kind_flag, vlen) \
	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))

>  		}
>  	}
>  }
> @@ -3882,6 +3890,18 @@ static int probe_kern_btf_datasec(void)
>  					     strs, sizeof(strs)));
>  }
