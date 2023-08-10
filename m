Return-Path: <bpf+bounces-7504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D357783C1
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 00:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C6F281EB4
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E456AB5;
	Thu, 10 Aug 2023 22:46:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F01877
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 22:46:21 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABB02D40
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 15:46:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5867fe87d16so18047097b3.2
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691707580; x=1692312380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjd4vkpdCNZjHu9BtGW8X6WGb20e5wp6H/aYsqXsyEQ=;
        b=vuxVUQS/Rd+IBKBm1b7ikeBESL4jyxpR8mKK8cQmpQ+hmVJHXNQjOsb5p6NReTCEhM
         igBaQaVx6ysaNlCaP8vRvg3YEouXmY7Y+9yOdNEpgrMyk9kUzP5kQzNIgv5xJHtJdlwc
         kpW63jCiWVKAiyvbhJi6fXJZbABZguB1XML+0jfYC3kd5xeiOvQDwXMnUyyOFwJDmFfA
         DS7IVEibz0kQAN8dXFuPkmgDa8GIR7fHDANa362Jmqzwt01IxSo8b+kNKWy7wNCj1zNT
         Po/ySyBdBUGf2JhqrHxzwxht/rjqP0vn2uXGS0PtjW89+U8p9q35C+Oim+S6FawDN2Qq
         ze0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691707580; x=1692312380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjd4vkpdCNZjHu9BtGW8X6WGb20e5wp6H/aYsqXsyEQ=;
        b=YS5cEPVdNzkKuQjeAHRtJ8GqDbWIdcGi6lG4I903UAwGv9GCF22Ob6UxkzhQf8MbDU
         kLPpOksf7n60D+ecc+K88UlXDoZX/ErionpfiwTAPj7xK9fEmSIg0S0AVfR9KSO9hpa1
         KFUTqZc1GFxwc+Ozg8cDWpG7jE039cSY1iAWCRLXA5kXIimQepkfOCh2ABqcFpKe3C/C
         hUPFZwJI+0tTUEuZDnGebbqmaDI1a5YwxtUnjJ/1SPsvOPueaR6GjwIW3QaBnq75ofG6
         8psiHIR6vEgIkfM4Q+iuNBZUd0G76V1kTnmwPy0Pa5z2GspRD4nCEH0dZ0CIssYedQoM
         kkJw==
X-Gm-Message-State: AOJu0YyiEEdgTjR+UH20grpi1Rqclh1BJm7ww1ExMqVskK1l26idG0J8
	x3Quh4lamxJf2oYTZlpRKEsWZTw=
X-Google-Smtp-Source: AGHT+IGL0cU/OgNlmX6HF6UNubkpMQKosZNdhYWpVGifdB9x5uIbsl02rc0lbeMuVFPl9CKTW9Er8qg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:b654:0:b0:586:a6e3:88cd with SMTP id
 h20-20020a81b654000000b00586a6e388cdmr6521ywk.5.1691707580066; Thu, 10 Aug
 2023 15:46:20 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:46:18 -0700
In-Reply-To: <20230810220456.521517-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810220456.521517-1-void@manifault.com>
Message-ID: <ZNVousfpuRFgfuAo@google.com>
Subject: Re: [PATCH bpf-next] bpf: Support default .validate() and .update()
 behavior for struct_ops links
From: Stanislav Fomichev <sdf@google.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	tj@kernel.org, clm@meta.com, thinker.li@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/10, David Vernet wrote:
> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
> define the .validate() and .update() callbacks in its corresponding
> struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
> in its own right to ensure that the map is unloaded if an application
> crashes. For example, with sched_ext, we want to automatically unload
> the host-wide scheduler if the application crashes. We would likely
> never support updating elements of a sched_ext struct_ops map, so we'd
> have to implement these callbacks showing that they _can't_ support
> element updates just to benefit from the basic lifetime management of
> struct_ops links.
> 
> Let's enable struct_ops maps to work with BPF_F_LINK even if they
> haven't defined these callbacks, by assuming that a struct_ops map
> element cannot be updated by default.

Any reason this is not part of sched_ext series? As you mention,
we don't seem to have such users in the three?

