Return-Path: <bpf+bounces-11388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9057B85BC
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 18:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 03DF01C2099B
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD811C69F;
	Wed,  4 Oct 2023 16:53:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C81C2AB
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 16:53:17 +0000 (UTC)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790DA7
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 09:53:14 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4510182fe69so12673137.3
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696438394; x=1697043194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trfPvWlc2Z4z1gMaB+tLFdm/beJC1nNivy0/WxwIxQ0=;
        b=bNXQXmV0zD08F6kKmpGWVHS9LZQTmtobzoonvvPknnc+av5IWlE5IOzLD1VyE6Ajrp
         6EwbW9JZJnFkMByayCOFR9ZwgPLnfG3roV0UuuPVZrZBDogxyUTwK5+BEj3lxUrq3YjA
         GZCSwzqicVUzcLaaKGFEaDLjcTGYM3mtrTu/Sol5qdhsJ6RSgZgQnMD7cPWPC2/SMGzo
         sl4VCrb+bLBAJPdwhYxdPFP74E1PHHTxaVRx/WiSzwioXf/TZPl8D0+8hOsY9KBgj3YR
         A+AJJ6FMMYg6h3fPTPW/LapnEdQYJjOvcPb3lP277yo7YKijsAeQDU7DeDO4rVM6zUZ5
         O/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696438394; x=1697043194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trfPvWlc2Z4z1gMaB+tLFdm/beJC1nNivy0/WxwIxQ0=;
        b=QXp760ex/VIcTn+YRzkBdU/eBuyv6UJ6X+ac8/L06HXJ6JhvRri/Kx3x5b/ZYnfTad
         22yrFzzPPayGhMsPgoFgjEiy3T8iHUqA9s5+HDuu9wDtAk2ietU74gAskAysTUReprjC
         xd1+20CScafLgKNrPWZYj8OtUKJ8JczOxfZo1VYYL+w4QbQQRZJwm5IlCk0d5P8f1UyY
         vRzhBCOymUjTpVy84igLKmMJ9Tcz1IIk5kQiKB8WTO5VcEmtMfzc5Xfh8gtICifH5qmP
         tJv3bIzmPEx/ggMcVQyEZF3ow3OdEymfgZpldMtiMv8iQ/QP9C6ePcLzb2x8byUrd3qU
         yWag==
X-Gm-Message-State: AOJu0YyN0gWCOcFEK7YU4dSchnFz7ByGbTUaCQEaWsiCdLEQwDKtT56X
	aNeBAyJ6BkDhG9TyoQAIbLvG5L5SduLspYOe5OJ0WA==
X-Google-Smtp-Source: AGHT+IEWCgvkfIvZj/B7L0SlMZXQCDSAI4lzHhqLl6NWb7K31ZFWxOCgbPKOxLXuc0v3xopPwsLqVue5HwUql+5JYvU=
X-Received: by 2002:a67:eb49:0:b0:44e:9f69:fa52 with SMTP id
 x9-20020a67eb49000000b0044e9f69fa52mr2366498vso.22.1696438393670; Wed, 04 Oct
 2023 09:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004110905.49024-1-bjorn@kernel.org>
In-Reply-To: <20231004110905.49024-1-bjorn@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 4 Oct 2023 09:52:35 -0700
Message-ID: <CABCJKue8MW8dsrPG0PFC245jBRFx00JqcCEjzs=Os3TXwkcWFA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/3] libbpf/selftests syscall wrapper fixes for RISC-V
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bj=C3=B6rn,

On Wed, Oct 4, 2023 at 4:09=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") introduced
> some regressions in libbpf, and the kselftests BPF suite, which are
> fixed with these three patches.

This series looks good to me. Thanks for fixing the issues!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

