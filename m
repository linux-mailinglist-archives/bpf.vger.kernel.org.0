Return-Path: <bpf+bounces-9551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB5798E54
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC20281D9C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C3230F87;
	Fri,  8 Sep 2023 18:39:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B631A30F80
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 18:39:28 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5948E
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 11:38:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2be5e2a3c86so41536901fa.0
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694198256; x=1694803056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAZqvl+LMCtYO/f2XX4HXWKOKAHGnekM7M2HitN8j2I=;
        b=FdZH4cdOP4sNxtqTq6e2ztA4RKSIqWDMN0JZndZ2Qtx6z7fBn/MPO62N8PUu8NDz0p
         aZau6Y3KpfrlSumg5HNk33Z/WP3XzrfRzHQNLcsavuS9IdMnNkGOfShKZpgZc3R/WGj5
         ti6NPkm/RzGbDXKmlEC3g3Tza7XsFRGPOZH6GAYcNazkAsSt385ZBRyFqjy7klA+HrYM
         dL2jGVrIotyjh8KoVeVcTc687FCdOv77HDq7kRwfF5+sXB5+HjHCCUtScnXyL9iGMcPS
         qTEUFIzxgr4Yg2hqZ9yOr5eZcqOzcFLLoWfsuWFuiCnJxZBiBvC6WCvwIdgSk9kD3qu8
         J9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694198256; x=1694803056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAZqvl+LMCtYO/f2XX4HXWKOKAHGnekM7M2HitN8j2I=;
        b=kQr6/PXWfeQAFBg+QodDkODwrDeAs5VQ8FcECtMUcplIfQTcd4PFyWK0OvccjRLiZ1
         gxXNq+yTpimR2wnv9nZIsntR/1k7s+GzQFg7NMIjhCKcQ/aFgqFrQT/C0ohMMprvcvZp
         Hi5/YOdPuTSzxuh2krdpPitK7Kl4PklgaoFwtrRLX6z8IkHVj8biCvQH2Hs7OX0l3yR8
         qTBO0LRK+US2ZtzXGEYyRVW2kTqyDSb8r+2Iv4F+PrmBhvi6L/25nXHUGaocqK7Dw/nc
         tEA+74t0Bi6P1sUaX5SyeX+al44R+pIR2RBIthlGgCb5tbw01ty0gFq18zYhz0MwKXEY
         sY/w==
X-Gm-Message-State: AOJu0YxdziJyt33rnf/2HbZFYLu2gYjqdkr/I2X85vC7bY00VuDmdCId
	mNLsyvDb3yRWipLmaiW9n0W8+/mAOZnJK62BeLgdBLMfA6Y=
X-Google-Smtp-Source: AGHT+IGAjZrlKCPfY75eQJu4gQeDr3+qjO9/Kdcxv9Z/pGQgD45f81swhATCma+kzwFZasgjRQ4wLo31WzvWAQKaj+4=
X-Received: by 2002:a05:6512:3ca5:b0:501:be4d:6dc5 with SMTP id
 h37-20020a0565123ca500b00501be4d6dc5mr2328299lfv.8.1694197482614; Fri, 08 Sep
 2023 11:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907203202.90790-1-thinker.li@gmail.com>
In-Reply-To: <20230907203202.90790-1-thinker.li@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Sep 2023 11:24:31 -0700
Message-ID: <CAADnVQLAmvNewqyVUZkcFt8RRvs+W0RJfyExa-gZ=-0-nwL16A@mail.gmail.com>
Subject: Re: [RFC bpf-next] Registering struct_ops types from modules.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 1:32=E2=80=AFPM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> Resend to remove noise!
>
> Given the current constraints of the current implementation, struct_ops
> cannot be registered dynamically. This presents a significant limitation
> for modules like fuse-bpf, which seeks to implement a new struct_ops
> type. To address this issue, here it proposes the introduction of a new
> API. This API will enable the registering of new struct_ops types from
> modules.
>
> The following code is an example of how to implement a new struct_ops typ=
e
> in a module with the proposed API. It adds a new type bpf_testmod_ops in
> the bpf_testmod module. And, call register_bpf_struct_ops() and
> unregister_bpf_struct_ops() when init and exit the module.

register_bpf_struct_ops() api implementation is missing in the diff.

