Return-Path: <bpf+bounces-9680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4223979AAC9
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC8928141A
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 18:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06FD156F6;
	Mon, 11 Sep 2023 18:17:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC0156EC
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 18:17:48 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D24110
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 11:17:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500cfb168c6so7775325e87.2
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694456265; x=1695061065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5gPChrpnRFIH9nIPBCxBWuu23aFmL6bH9FcwiVvWj+o=;
        b=MRIy6c7PU2xu1jqLgJDOgkjbCF+qLBsXk6DuZ57rlUVKK7Ewz5eXC9A3WOCZoI5WaD
         Oqcg9r0aYIBtOwjjTszaR/KYwPOqiAVu8pTuaQysXH/M5zNMFffeYS/0amhc2WY/OeBc
         q4MxoDDo1DQ2MOgMI1gA1o7Ue+KNNDBG3qtQbTeeM8SClQuG8dYqtYdyb73cHAKYdJax
         G98iPahUMcNvwip6n8uoA/I2nsA/0nNcbsa0mkF8I7YL8Q/3e5J4R2Bg7/8pU9OnnJEg
         qqO7qIsb+BstwwRWKMyZB9bzR4wUOfhi48r5Yi7fTs54JfGiNLe0lZe3De+3EJYUGy/t
         1uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694456265; x=1695061065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gPChrpnRFIH9nIPBCxBWuu23aFmL6bH9FcwiVvWj+o=;
        b=lG+2LgJ93GM5hiw82C8z+QX7YGd7Zda+j3sV5GWxtMIxCfc4r2ocv6/jZoEBOrGeCJ
         hIYQoL6SWeab06FkLur0Wd1Oq0WV9asmVtdZDU2off5IUPPM9ZhS3mlPQFBEdIqIQ5X0
         +4+U45CifX567nLuDgrw7RBTGStai/hBwa8ejMXRwVFsDzyh8Pm/63VtGomYUT5AZYm0
         gfKExVii9uVAEdqGlqZm6HaZEq+qOLqdaWPhf636eWB/dvaEQNO2UG9cxsCo3XOkajb6
         +3P4DBqSmPoJ9IUsnCf0jardUhCKrwb8Qc4qJBs7h386DoPOsVbKNeu4DbU10gv2Mvf1
         nf6g==
X-Gm-Message-State: AOJu0Yy7fJ4tR0cOS+/qYhQM3WNjsCoZHef2S2eeY37xXTDPDaEb8Mj3
	0RloepeuA0w4nBJgkg/5173tV9rE2UPZeP5c+Dc=
X-Google-Smtp-Source: AGHT+IGeuD8PkC6LZnVbg3DFRf/dhW6GNRL0CVAN42hta6U5v9PddaAcBPuFi0qHuY+oewo2ylylLiaYtBpTiQm0qzg=
X-Received: by 2002:a19:8c0b:0:b0:4f1:4cdc:ec03 with SMTP id
 o11-20020a198c0b000000b004f14cdcec03mr7464655lfd.18.1694456264593; Mon, 11
 Sep 2023 11:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava> <ZPsJ4AAqNMchvms/@krava> <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava> <CA+FbhJNz4i4pU+8nT7JBvQKSa0VCkzcNzaJ=dRdRn+JCSTdgKQ@mail.gmail.com>
In-Reply-To: <CA+FbhJNz4i4pU+8nT7JBvQKSa0VCkzcNzaJ=dRdRn+JCSTdgKQ@mail.gmail.com>
From: Marcus Seyfarth <m.seyfarth@gmail.com>
Date: Mon, 11 Sep 2023 20:17:33 +0200
Message-ID: <CA+FbhJNbnWORbz0CGQ_9eAOTMqidw4p7rXrdcsGygq2kE8WzxA@mail.gmail.com>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Stanislav Fomichev <sdf@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I hope this one will get through the list as I am not subscribed yet
to the LKML.

From Fr., 8. Sept. 2023 um 23:22 Uhr:
> I've tested the patch from Jiri with a fresh snapshot of clang 18.0.0 (254847fb149fdc03ef601badf69ee08150345a5c) on my custom 6.4.15 Kernel with FullLTO and it also solves the reported issue (the Kernel also boots successfully).
>
> Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>

