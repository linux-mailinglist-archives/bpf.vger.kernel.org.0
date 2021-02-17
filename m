Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA54731E114
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 22:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhBQVMy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 16:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBQVMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 16:12:53 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17181C061574
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 13:12:13 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q9so12628509ilo.1
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 13:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=L+gRm7K9FfdUy3HUV9J53BTYYHlldxf9viouDsSAyRs=;
        b=By8ZQYsBxXaf+QsCL+HkxaAOV/LynNvjB4IHw1SdiMwNvmNq6Ou85xnQe/yI2CSfvu
         qnFmlGA3gtaX90QOirTdBm3qC2VFznlb5x9As/gZA8Y9sAuEOaNuRcs/k3PIwDnu6mdY
         cKIyNBbFQW5tX15ExM/VTZvkYVHpknV1D33AyHrHSLo2wbpoOzzUm9gGNDy28HJARUCe
         ZLhLgJat6R/pn7lX8wiXYsX1BFKygS+JAXHhLrdizn9MK3MDSuoj58AiXl0BDnc5p5ps
         7sU8vfpu4UWck6RxqD+OY7D8j7Oomd61FIlRsfqA2zYFwNR0lbg4EH65jPxjHsWCm234
         H0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=L+gRm7K9FfdUy3HUV9J53BTYYHlldxf9viouDsSAyRs=;
        b=abxBMfPuA7ldS9WfztGnikUfR46L89LYXLJxpA70XcC3nuASRVkwm5BI6wR3wJOHJ5
         WC2aR+QAcjE8QyaM09cMCBCNlkiAJiJrA+W6iMUoE/VXiByu60z8agOHCWtkjqM2wd/g
         sYiRUc0ZRrKhnW/RxVY38jsIBSPi/MXekWWDt1LzTsnVT1ZgF04RoGYWw3OX+70r8CxE
         YdyeCV5YIZ9oLu5i2clzCo1WsjEdgHaMFY+NAagdA1la2gAEhNfjbIFNa0EMlDhRqYNh
         A9OHzCntWZgBg8JjM7taXY7ZSctEQYe2r66PVWOJEmV2cKoThm2fH/Ju6RX0PQ5oYG9F
         lRCA==
X-Gm-Message-State: AOAM531sTeUaobEbmiQAoeRqb7pGSIpJZ3EzaK8EI9rnQlXly/o6Iak0
        WACuQfwKr8DFulyPrNMyLAI=
X-Google-Smtp-Source: ABdhPJwPLgFL30NpVDzwTWU88sT4fAD9uuIO10AwQlZ3oOsETTPrHNhVBVaHCczHJPObvK/sObhwjA==
X-Received: by 2002:a05:6e02:5c6:: with SMTP id l6mr890722ils.136.1613596332592;
        Wed, 17 Feb 2021 13:12:12 -0800 (PST)
Received: from localhost ([172.243.146.206])
        by smtp.gmail.com with ESMTPSA id l7sm1831503iln.74.2021.02.17.13.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:12:12 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:12:06 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <602d86a63e754_fc54208eb@john-XPS-13-9370.notmuch>
In-Reply-To: <602d83616c9f1_ddd2208dd@john-XPS-13-9370.notmuch>
References: <20210216011216.3168-1-iii@linux.ibm.com>
 <20210216011216.3168-3-iii@linux.ibm.com>
 <602d83616c9f1_ddd2208dd@john-XPS-13-9370.notmuch>
Subject: RE: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend wrote:
> Ilya Leoshkevich wrote:
> > The logic follows that of BTF_KIND_INT most of the time. Sanitization
> > replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on older
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Does this match the code though?
> 
> > kernels.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> 
> [...]
> 
> 
> > @@ -2445,6 +2450,9 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
> >  		} else if (!has_func_global && btf_is_func(t)) {
> >  			/* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
> >  			t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
> > +		} else if (!has_float && btf_is_float(t)) {
> > +			/* replace FLOAT with INT */
> > +			t->info = BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0);
> 
> Do we also need to encode the vlen here?

Sorry typo on my side, 't->size = ?' is what I was trying to point out.
Looks like its set in the other case where we replace VAR with INT.

> 
> #define BTF_INFO_ENC(kind, kind_flag, vlen) \
> 	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> 
> >  		}
> >  	}
> >  }
> > @@ -3882,6 +3890,18 @@ static int probe_kern_btf_datasec(void)
> >  					     strs, sizeof(strs)));
> >  }


