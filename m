Return-Path: <bpf+bounces-8304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26511784BF6
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ECC281116
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193C34CD5;
	Tue, 22 Aug 2023 21:23:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0422018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 21:23:29 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECFBCF0
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:23:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso1217151a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692739404; x=1693344204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyGnyzArzaDCVCzqlgcUq6dvFmvWr5Aa8F1l0UpM4qg=;
        b=cqwpxiOBAzyh1v9xcVZUPuKLokdDwwFciBe3Q0/Pv0parNXIESV8jK5My+q98k0O5M
         c1r2d/eRU9JnMxX2bKb5DoswtvOpMbW3uisvNBQ1e5aLpnbozopeLK19GqPyBRZVjplT
         ihBPlJxx7U9SP0vH7YXs8AJ6ztQQKo3hp+WnDFEzHWCHBp2CbsP3rnMKv8O0eJwgC9Jd
         gSm9l2nBkhT3aSi/9UDwkhMWYGeNvhTS0KaScooHHT9dqGlae+Gmuqrfq+/bF1Y7K9Rg
         Xl8lsTTusDR7ZVzpQn3H0FaP9OokCtdGBjXjbcN3B+OgR2dNe14VK0BDebOMa/u/WiDn
         ykKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739404; x=1693344204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyGnyzArzaDCVCzqlgcUq6dvFmvWr5Aa8F1l0UpM4qg=;
        b=Usw44SoRjet0AzAQXOjJEF+QWgopETk+Zp4znEOMornibNCe1kXPMyM2IIxSS0EjL7
         dNR5V9DhgE43VOYQ8twPZjmlqODlMbtzdT/vtzJNaTsvee1Nh9tyJrcKLDvTVTOeRSPM
         a4eYADYEYnHmfvXYtwcv13imZJffvORKTCZN2ntwuJK9M8I71h1ceS7kZ4pE/Xma1FYO
         h7YkW6C0gX5zjxyX+2CzsKU5lqhYXiavwDGpHwPryUcHOlkspI8Re3fZbfx0FQnT3eoU
         PAHkfVhThyt8A/zSHTfzPqklDksirViUTxCrAJ+U7L6ES4c/GhQmlFTM0oTcXy6D4K3H
         igDg==
X-Gm-Message-State: AOJu0YyjdyKOglFujbSPPqatFFQrbNtJL13y8PBAQfzBX2syoLEB9qsv
	i/ukD2wIF45GmaNLDEdAETwb2NRL/JhZ11LQDBSHLhOVuh0W2w==
X-Google-Smtp-Source: AGHT+IGy0tySHbq4mrJUfjNQ4smN/dxWcOJd9Ud1Rlwkcs468WzC1k4Wv3NfGNLHszNfxYb75678UzCqAlS2GANEiVA=
X-Received: by 2002:aa7:c603:0:b0:523:3fff:5ce2 with SMTP id
 h3-20020aa7c603000000b005233fff5ce2mr8074643edq.41.1692739404272; Tue, 22 Aug
 2023 14:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com>
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 23 Aug 2023 02:52:48 +0530
Message-ID: <CAP01T75MjLeu01FJjxcEF3O1f+4=MiP3St_2M5fmTW9RqkGPnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/14] Exceptions - 1/2
To: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 9 Aug 2023 at 17:11, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> [...]
>
> Known issues
> ------------
>
>  * Just asm volatile ("call bpf_throw" :::) does not emit DATASEC .ksyms
>    for bpf_throw, there needs to be explicit call in C for clang to emit
>    the DATASEC info in BTF, leading to errors during compilation.
>

Hi Yonghong, I'd like to ask you about this issue to figure out
whether this is something worth fixing in clang or not.
It pops up in programs which only use bpf_assert macros (which emit
the call to bpf_throw using inline assembly) and not bpf_throw kfunc
directly.

I believe in case we emit a call bpf_throw instruction, the BPF
backend code will not see any DWARF debug info for the respective
symbol, so it will also not be able to convert it and emit anything to
.BTF section in case no direct call without asm volatile is present.
Therefore my guess is that this isn't something that can be fixed in clang/LLVM.

There are also options like the one below to work around it.
if ((volatile int){0}) bpf_throw();
asm volatile ("call bpf_throw");

