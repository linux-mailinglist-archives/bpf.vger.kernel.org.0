Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75D107E15
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 11:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfKWKjT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 05:39:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38821 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfKWKjT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 05:39:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id q28so7418291lfa.5
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1xzOfe1y+VyLkuUpRaIsR3HakWyx6MHP2tBZe2b4FVo=;
        b=Nf2SOybhcfFbc7qcG8oCfgPB1F3sccVek4CPtJRKHezBVcazSHN2aJw+5QAX9eXYEh
         Cbx3Jm60uxHF1l9ADTebkK01oApqI6qnfmmUIomyLWvJ/fX+JJPz8ReD7bL1n93TW3j5
         7qxSWaXyqHDjWeiesV9WQf5Yiuqw2komM2xbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=1xzOfe1y+VyLkuUpRaIsR3HakWyx6MHP2tBZe2b4FVo=;
        b=gD5PWU5+HO8ZJD6rwBVEK0Uw2+P1yPfZYVfiYkMV+NrPoGtLCLti90iajx+7s2nZx0
         y3yKcReFOak7Rot0ArWYw9/NJI/8N+guYeFWuDpcUr7bet+XDUkuIyvvvBHaE2fvYNnk
         7vPRRowhFcOREHsCthRaxFb1ze6EoVU+LuYgL16D82iEdV5SZIKhvbVKMwYEyo0sc//H
         sEXh9bdM7AsF/Tt73U5IyqMj4TLK5WIgZleytuXVRfTeWlopODVNAQ3HmmT6DdW8xj61
         uHa5+aHQWa/doLk1QOr+gNm4uV/SlL0Z51CUxUxDKxmKNZWCpbLhoEnREfhTmfJYb5e2
         3VIw==
X-Gm-Message-State: APjAAAW8Ygmqy6iuaGcnBzd2OpCgJTiTupVYNdfR+DjGEsuUS+7jYPF5
        OSc+f0sh7k9ObHnbDmpiqvA1uA==
X-Google-Smtp-Source: APXvYqzKbOVl7yv6R554Y5GMZ59rAHOKllS0NtpqWo0mJ0fMZnjzJ4x2vNDkhXhPKWDZqWpFoB/ETw==
X-Received: by 2002:ac2:4102:: with SMTP id b2mr15000556lfi.16.1574505557635;
        Sat, 23 Nov 2019 02:39:17 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id x29sm566430lfg.45.2019.11.23.02.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 02:39:16 -0800 (PST)
References: <cover.1574452833.git.daniel@iogearbox.net> <e8db37f6b2ae60402fa40216c96738ee9b316c32.1574452833.git.daniel@iogearbox.net>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, john.fastabend@gmail.com,
        andrii.nakryiko@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 6/8] bpf: constant map key tracking for prog array pokes
In-reply-to: <e8db37f6b2ae60402fa40216c96738ee9b316c32.1574452833.git.daniel@iogearbox.net>
Date:   Sat, 23 Nov 2019 11:39:15 +0100
Message-ID: <87r21yop0s.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 22, 2019 at 09:07 PM CET, Daniel Borkmann wrote:

[...]

> @@ -9046,6 +9110,7 @@ static int fixup_call_args(struct bpf_verifier_env =
*env)
>  static int fixup_bpf_calls(struct bpf_verifier_env *env)
>  {
>  	struct bpf_prog *prog =3D env->prog;
> +	bool expect_blinding =3D bpf_jit_blinding_enabled(prog);
>  	struct bpf_insn *insn =3D prog->insnsi;
>  	const struct bpf_func_proto *fn;
>  	const int insn_cnt =3D prog->len;

I noticed this is breaking the build if CONFIG_BPF_JIT is not set:

kernel/bpf/verifier.c: In function =E2=80=98fixup_bpf_calls=E2=80=99:
kernel/bpf/verifier.c:9134:25: error: implicit declaration of function =E2=
=80=98bpf_jit_blinding_enabled=E2=80=99; did you mean =E2=80=98bpf_jit_kall=
syms_enabled=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  bool expect_blinding =3D bpf_jit_blinding_enabled(prog);
                         ^~~~~~~~~~~~~~~~~~~~~~~~
                         bpf_jit_kallsyms_enabled
