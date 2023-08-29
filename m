Return-Path: <bpf+bounces-8930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB12C78CB79
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 19:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6DC28122A
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5871800C;
	Tue, 29 Aug 2023 17:43:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DAB17AAE
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 17:43:05 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B549A103
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:43:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703a0453fso70258361fa.3
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693330982; x=1693935782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stXpHcQJU5m/KmE130Q/B+HeDrgYdCgVMN9BRZLNLxE=;
        b=rNMUgXJqu7JymcGB/IQ9Gv6zoo2Jq88pmS6t2OPxzQt/unTh7HN4sfMpN+SWSgKqy/
         Pq7a2h/ks+awgoZion0JdAv07rhq51Z6915HQ22u1xhIB3udD3uQZ1pE1Sg2lVocSKz8
         4vffY4GaaDOMWBCind7x7qgFsuVK/P3ap/pdZF8bK0oDsDwoBDG8L4Bb1Thw2LjJgK53
         zKW116pxMM1RAsRrra5ZlNjZwJawNYSGZqi/CJZcBPcnvktvz6eRjlBeyh2oCD3v5MA6
         yw/OiWczrO8J1JS2EKHKmP9q1plktlcf9yN5Ba3X2oYm7VyK8PMBL1pVwD4p5dgsbrjt
         G6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693330982; x=1693935782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stXpHcQJU5m/KmE130Q/B+HeDrgYdCgVMN9BRZLNLxE=;
        b=iDcjKukIAHDzl+8pJ7eLKjSRH96wkyH5NfkMRBFxEOzLl0ZMFyF3UItqH1xpIZ2Ab/
         nRe3AiGkncIb0IXhH1By4i19/6zjYNyKEQ/2ABZD2EFnGwRaU5LYaR8qs+TVvNjkX9Qt
         byfhvIW5i6t8n6S6KCRhbo+5DacjZ+FLHup9jhBMfq8UQmoYv2ftyqscDTJyrpwt5OvB
         w1vBZJ44VopH2N3j2BLlGWJJH38GiRUU267+whIqmgtdNH0O+pEbzMrEqKUfIavV5rVq
         Xm5eaDGYbddMKCm7puYRZm74XDFoymZ1KNBemwFrTem7ULHxNHpjAdln53mPYdTT/hIx
         9UtA==
X-Gm-Message-State: AOJu0YwGyNEkp3ZnarPI9LAGVRzzQQcpJsP8ZPPYiYcqeKx5FpkFo1qV
	iGPdUlUahM56kdXZA6MAJLWG4KvzPDGkkgtk3G0=
X-Google-Smtp-Source: AGHT+IH/PtkWTKZw3XDK8hmiANa1BqUyeGXMDIk0a69Ic2TqnaehZacBvdtp4wV09/mPm+EqtNfdxvKjraZfUjONd/I=
X-Received: by 2002:a2e:8898:0:b0:2bc:e51d:89a3 with SMTP id
 k24-20020a2e8898000000b002bce51d89a3mr26145lji.29.1693330981590; Tue, 29 Aug
 2023 10:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com> <20230829101838.851350-4-daan.j.demeyer@gmail.com>
In-Reply-To: <20230829101838.851350-4-daan.j.demeyer@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Aug 2023 10:42:50 -0700
Message-ID: <CAADnVQLvJ3hE73Ag0yLcF6fns5h4jdfT7tJ3dgxTL1LcQTd3ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] bpf: Add bpf_sock_addr_set() to allow
 writing sockaddr len from bpf
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 3:19=E2=80=AFAM Daan De Meyer <daan.j.demeyer@gmail=
.com> wrote:
>
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's add a kfunc bpf_sock_addr_set() that allows modifying a sockaddr
> from bpf. While this is already possible for AF_INET and AF_INET6, we'll
> need this kfunc when we add unix socket support since modifying the
> address for those requires modifying both the address and the sockaddr
> length.
>
> We also add the necessary hook to make the new kfunc work properly.
>
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  kernel/bpf/btf.c  |  3 +++
>  net/core/filter.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 249657c466dd..157342eaa2bb 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -217,6 +217,7 @@ enum btf_kfunc_hook {
>         m,
>         BTF_KFUNC_HOOK_LWT,
>         BTF_KFUNC_HOOK_NETFILTER,
> +       BTF_KFUNC_HOOK_SOCK_ADDR,

Do we really need a new kfunc category?
Can BTF_KFUNC_HOOK_CGROUP_SKB be reused here?
or even BTF_KFUNC_HOOK_COMMON ?

struct bpf_sock_addr_kern * type of bpf_sock_addr_set_addr()
will prevent any other type being passed in here
and bpf_sock_addr_kern type is local to prog
run via __cgroup_bpf_run_filter_sock_addr.

