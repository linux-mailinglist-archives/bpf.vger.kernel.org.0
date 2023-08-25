Return-Path: <bpf+bounces-8679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7648788F00
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D051C20A8C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5A18B0E;
	Fri, 25 Aug 2023 18:55:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47033101CA
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 18:55:22 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2981BD2
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:55:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50078eba7afso1943986e87.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692989718; x=1693594518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa5B6Vq/+KMDNgnjyuhJyRP9AioEf9V1BfDOyTkOSDk=;
        b=mQGmo2GFncPEwGTODUwvXu+RHh+Cnw7IcZN28OvsomR11TPWQX8X/8LQFitgvRCeYu
         oBqGapP8x+9fvBFGrkrTx+V7aKtv8gx5a6OedhfHJ90pjBamRvG7MhxP/q9kAkX2dTjV
         E2xkgu7OtW1tpHf7/+QlNvue63SbnKR0VZUtQ0QD4n9Pv1tjP2I/0ZIccD8t7579s3PB
         G8nIYrXT35WeXEPkzcKd670B7fZtLD9JWfYHD+PcvLkPLHwtSnnSkxSM7j8eVwrb6fL8
         H8tMeU6riH4Ujs+Stb7eOpFehrZvrTV5XzxlnefY/uKoVZXd/7p3TSPGhM65TmpMi1XM
         sMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989718; x=1693594518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa5B6Vq/+KMDNgnjyuhJyRP9AioEf9V1BfDOyTkOSDk=;
        b=PKxBJYYognLMliy0PGJ+7/bHLdV9quAYw8CKFAmneotkSkXUAv/B9H1yErLirvc0Oy
         uyF5WSTZLBtm5/7y5ORhLT1jwbTUpUaFd89BJHIYVuluniei1Qpmb/1eS22u9OMHIlqk
         GtTEEgXVWeJjYV/TLiN+DEjewx/aZBIMsuaKYAkBV9GnT+nkcBAIQhKHoY6yafRI+jCS
         jWtbvwv7r8+wOGk3KnTRyou22IFPalfUoUYrq02EtkV12hzQQ/HQSRMk2FCRyEKRrO64
         eIwFQ25yWTJVTZkw7brHXDIsGo6+pui8Jhp3iNmH3WR9EfHWle1o0IwgnF6pRnVZ8+UP
         RXiA==
X-Gm-Message-State: AOJu0Yz+4Y9VBpWlOrXUSG1g5uW4b2MM3ENRZM0R2GCpwEuZ/MFqxqXH
	rbM/im0bcg+UztZq0wtcWfINErKbS8Suw8Mk57s=
X-Google-Smtp-Source: AGHT+IHTxanFfLzWRGYZAmrRZOsDAp0SnhNgAdq9mwYacHj1+t7ahJQsKDzJS/CmOkjOl/RC3hQ4r7C76qjJxUsB+Qg=
X-Received: by 2002:a05:6512:ac4:b0:4ff:8d7a:cb20 with SMTP id
 n4-20020a0565120ac400b004ff8d7acb20mr18151396lfu.63.1692989718329; Fri, 25
 Aug 2023 11:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <CAP01T75MjLeu01FJjxcEF3O1f+4=MiP3St_2M5fmTW9RqkGPnw@mail.gmail.com>
 <87lee2enow.fsf@oracle.com> <f7c404d8-41b5-a48d-f156-5556b38f384e@linux.dev>
 <CAP01T757oTUPuRaxiaNZh2E5FtLdWiYybZy453LUYEE7RmY63Q@mail.gmail.com> <CAADnVQLnNgpjsHMBUhHBhwdUNdqoCEEtxv-mSKS==48XNpMZog@mail.gmail.com>
In-Reply-To: <CAADnVQLnNgpjsHMBUhHBhwdUNdqoCEEtxv-mSKS==48XNpMZog@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 11:55:06 -0700
Message-ID: <CAEf4BzbFcO7x4oXYVhJ95C0fFuP6uxec4JbokPdq_5RQMyxurA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/14] Exceptions - 1/2
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 4:06=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 22, 2023 at 3:54=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> >
> > I suppose we could switch to the ' if (!(LHS <op> RHS)) bpf_throw(); '
> > sequence in C, force volatile load for LHS and __builtin_constant_p
> > for RHS to get the same behavior. Emitting these redundant checks is
> > definitely a bit weird just to emit BTF.
>
> I guess we can try
> #define bpf_assert(LHS, OP, RHS) if (!(LHS OP RHS)) bpf_throw();
> with barrier_var(LHS) and __builtin_constant_p(RHS) and
> keep things completely in C,
> but there is no guarantee that the compiler will not convert =3D=3D to !=
=3D,
> swap lhs and rhs, etc.
> Maybe we can have both asm and C style macros, then recommend C to start
> and switch to asm if things are dodgy.
> Feels like dangerous ambiguity.

This seems similar to the issue I had with
__attribute__((cleanup(some_kfunc)))) not emitting BTF info for that
some_kfunc? See bpf_for_each(), seems like just adding
`(void)bpf_iter_##type##_destroy` makes Clang emit BTF info.

It would be nice to have this fixed for cleanup() attribute and asm,
of course. But this is a simple work around.

