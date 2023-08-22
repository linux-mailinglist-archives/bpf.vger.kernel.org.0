Return-Path: <bpf+bounces-8241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E6A78416F
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B96281004
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2741C9E0;
	Tue, 22 Aug 2023 13:00:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB087F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:00:36 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00305D7
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 06:00:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so5582205a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692709234; x=1693314034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3xOTfkoHMDPjqye3NC6B/W9hpZQezJEuVkOQbjwlCGg=;
        b=B4aOlV0R5eau7cUmV0ggO6OcqPlTr4cSekzWqKdfJ4mEuPyIy5WYLilGqZtrEt36Jp
         /e2KxQPnaMTrQUMkV2mi59e5yG4VSAaYSZpkppl81OVkULvi0L1xOBuuhph0f3/2kWtp
         sWkvOkw8Okbev6R5ium8q6y+04/wcoczbrpLM+KaVL3F6vniV8ez2oD4aiTxnwHJOyWu
         utARlzBLOEz3MNQI7uXcSK//FMDcSTtXiXRtkWg3RUkpHdvj14aH5VpISH4M2QkCngDO
         2ftWnHKUyR59/GJJguS1R3LZZQANLbLYej7fNK7VnA2K75CTI3wlHN6zxf/ytr0xhA13
         j+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692709234; x=1693314034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xOTfkoHMDPjqye3NC6B/W9hpZQezJEuVkOQbjwlCGg=;
        b=bV51knBJ0+JR9DrsaulsuqMl+y6UCkEoVbZskDLzLcHfH9PIhzm2Sa2VlWFKhpz2eW
         lzATg4TMPe5R7HMZV2z/epS+HxcVQ1JDm0YeGnYwCxwShazkqhnU2LIvzisPF7BCdtYW
         59UMtiwS7QtOYpAbXQ6B5UiZ1hiujwyynwTA5hzp872asQ3WJWN3ZPTWsFPECZstP/AQ
         /h+VONz6IgXNPWy2lrmemBKaUilXsRX412V2qF3vjYOdkk8m5Y21myEcDYPKDP8xQ1Pm
         Xb8MJFo2RFvNoWIT9YTqAg/fKYVpa/bMUrcBDFcDQe01hSHBKAOQm18JqTirN0Y/hf1L
         Lmfw==
X-Gm-Message-State: AOJu0YyiiW0tsq55BqtgQYuN/7TVvGw5/uxArBxrl0f2fZezxhr9Fp2F
	56B7hX1tOTS9TN2sLCKq9w+dgZ/ZDaOcxDRwp3WyZSGLhpXX0Q5H
X-Google-Smtp-Source: AGHT+IFuxbOWw5W3KsP8R/IOzPFih+P059aKl+Czivh1/9WjomZDWLrv1dPVoQTcZBdIAawuy1ICqZwDb/eav1rWHXk=
X-Received: by 2002:a05:6402:34b:b0:525:69ec:e1c8 with SMTP id
 r11-20020a056402034b00b0052569ece1c8mr5951433edw.40.1692709234372; Tue, 22
 Aug 2023 06:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822050053.2886960-1-yonghong.song@linux.dev> <20230822050058.2887354-1-yonghong.song@linux.dev>
In-Reply-To: <20230822050058.2887354-1-yonghong.song@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Aug 2023 18:29:58 +0530
Message-ID: <CAP01T76ObFgPvSWNVQvj6zFFXKFvWekVQbgJ1h8bHtGZn2memg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add a failure test for
 bpf_kptr_xchg() with local kptr
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 22 Aug 2023 at 10:31, Yonghong Song <yonghong.song@linux.dev> wrote:
>
> For a bpf_kptr_xchg() with local kptr, if the map value kptr type and
> allocated local obj type does not match, with the previous patch,
> the below verifier error message will be logged:
>   R2 is of type <allocated local obj type> but <map value kptr type> is expected
>
> Without the previous patch, the test will have unexpected success.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

