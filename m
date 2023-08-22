Return-Path: <bpf+bounces-8315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB78784D2B
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAEE28115D
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488A20EEB;
	Tue, 22 Aug 2023 23:06:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000F20EE0
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 23:06:58 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8112ACD1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:06:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso38255291fa.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692745616; x=1693350416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La0i1BfZeF8i5avTzs7m6FlDV7VX+qdbyjpQRnK3xmM=;
        b=hZGG2fpNFKJJBHSurZz6/mYBQ8ip4AwwEJfz2L40wH4+rI/0T3ZwNeLqThPNsK8OQ5
         2yhXU8q7WO6msWe7fO0zdJNXadtuXbBGNMd0Po0aWvofe1OqlbZfAZ31yuO0RI2GrjCG
         mqqLc+wgdWbivXKQx364GFRoyByoAZAssDdf7lgHaYNX3SpKbU5lTkPmOMTKKKjwx52Q
         DVM01J40C+aHQwlUFBpYT3lNAVD2obXzdasKs4OKf2GAMXw4qp0baL+tZ0hRVZW6zFaR
         CRet+LXqHJL6Sc7tWwYRL8JTqZ6Fa9mRCWlyGJSrZvfThQJCtNBeE1haZDjxPffS0a70
         2HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692745616; x=1693350416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La0i1BfZeF8i5avTzs7m6FlDV7VX+qdbyjpQRnK3xmM=;
        b=WvX8m4PIhwgyjYTwSOm/RbMUsg7joa0q1kqXNK/yh9aKNqJpQKofrwpQobLRjMBiLY
         OVjiQGBD0xq2BYpGOlRjNh0I1t62EFAH+NGrAioRAVqrErc/pvxzisce7StVDHfIGEER
         zLO8S0NtfjpbcuaMLiOTjK9sVtlq7N34YjL9kfz2FHkhVDUSlL/S3hKF2S1Q4bEqghNU
         Tlhb9e/NfJzfkg6wjhQnc+gLBfX6y3WAZd9eoWrAnd9KJ5Rv5Pe1jqTOdrUHpqKA7OLA
         XQLTR5hWXUOP3dXclunp9plHHJORx2wr6T8b/ULE9OwY1pOY1KnjpgI/9NDRkw4AV66T
         eCmQ==
X-Gm-Message-State: AOJu0YzARJMLfzS1/w+eZ4QeXXaw5QM95eIXU9igjm1KNOFR7mMsPpg/
	KDjJLWShUoUV9mfE+J7IaPYuQuZpL5BPBhF/3ys=
X-Google-Smtp-Source: AGHT+IEoBWo/uM9RpwSVqKvauEMGJ+UFSqm/w1QTQBZ+laG2wqbaNllcTg6csaQx83OBx582Xo2KUG3jdBqyA6MJSUQ=
X-Received: by 2002:a2e:6e10:0:b0:2b9:cb50:7043 with SMTP id
 j16-20020a2e6e10000000b002b9cb507043mr8666863ljc.2.1692745615633; Tue, 22 Aug
 2023 16:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <CAP01T75MjLeu01FJjxcEF3O1f+4=MiP3St_2M5fmTW9RqkGPnw@mail.gmail.com>
 <87lee2enow.fsf@oracle.com> <f7c404d8-41b5-a48d-f156-5556b38f384e@linux.dev> <CAP01T757oTUPuRaxiaNZh2E5FtLdWiYybZy453LUYEE7RmY63Q@mail.gmail.com>
In-Reply-To: <CAP01T757oTUPuRaxiaNZh2E5FtLdWiYybZy453LUYEE7RmY63Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 16:06:44 -0700
Message-ID: <CAADnVQLnNgpjsHMBUhHBhwdUNdqoCEEtxv-mSKS==48XNpMZog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/14] Exceptions - 1/2
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 3:54=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
>
> I suppose we could switch to the ' if (!(LHS <op> RHS)) bpf_throw(); '
> sequence in C, force volatile load for LHS and __builtin_constant_p
> for RHS to get the same behavior. Emitting these redundant checks is
> definitely a bit weird just to emit BTF.

I guess we can try
#define bpf_assert(LHS, OP, RHS) if (!(LHS OP RHS)) bpf_throw();
with barrier_var(LHS) and __builtin_constant_p(RHS) and
keep things completely in C,
but there is no guarantee that the compiler will not convert =3D=3D to !=3D=
,
swap lhs and rhs, etc.
Maybe we can have both asm and C style macros, then recommend C to start
and switch to asm if things are dodgy.
Feels like dangerous ambiguity.

