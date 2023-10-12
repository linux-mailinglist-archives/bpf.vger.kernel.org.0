Return-Path: <bpf+bounces-11983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32937C626A
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 03:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F791C20CFE
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 01:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263E7F3;
	Thu, 12 Oct 2023 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfaqsih6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE77ED
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 01:48:36 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857FAA9;
	Wed, 11 Oct 2023 18:48:34 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1e10ba12fd3so255339fac.1;
        Wed, 11 Oct 2023 18:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697075314; x=1697680114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nchUXm+rbX4arDXAqlMb8BZfBxWIRFIQATpxfSNMMH8=;
        b=Bfaqsih6AcyhJ7cEEnaxGaA3sEQOhi8hMKfq+eCauNZmzTH8l5jCoF4atOio91QONp
         dusc8RX9ualqXOoXvWMEJ0BAZ1/tEoP1iydJWx5MbAq7K7m85zI/qK+BNr2rDqEotUPH
         NgLSEUkTJvUJ/l58dYutBXBzbk36Gi2ucL2RE+RtNb9RSnoeK8xVicSt4ehF6vamIt12
         1x/480ozIxnyc1+0lckAx+m6LJqGhJjVhIlyPpSHx8CLu4u3OhlwWEAgIcpdkRgrtnYs
         az5uTw1pjGAYxTgOGD0W9pMLZE7o4Vkn2FyYGQDQ1IytogZjH+7UNCUCz33zxoBaI0mk
         ysFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697075314; x=1697680114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nchUXm+rbX4arDXAqlMb8BZfBxWIRFIQATpxfSNMMH8=;
        b=vawRcSmx1NXFCA9bNrs9AsiicIe7DZZTwKM0Ay6VlIoejBCN+b+kuXilUYQy7hV9LI
         XWkTLSaCAtdWeXo+fuzlMQ5ulbjAYc0ANI4Yxtly84ew88gJrFsMzizI5iCT8HPV1pKP
         qbeVWgbJHu37wU1KwU1wO2WuO4++Lv6ZlW8EOo0b54YBWg5x/21xNQyG5Res0rsW4cl0
         ziEpGo/FLHCpcQSlpRaUa9UaNEW2cPFwljxyBFgwDpFY55sr2Jfp0hk8+JGqHjQL/1v8
         ESZG0H6TJl7gx87HGURdvtbvI+5E+Q1TzpqLWkYr5zWv/04DHay5/0hkdms4k7aaH5Of
         G1iA==
X-Gm-Message-State: AOJu0YxJ9CApn5T7MLH5C91AzpSYb9En75ltUjhB8aVz27S3147kx5s5
	R2rupz1F/5lcjhM6Q42NQMlG8rJvvfOmaFNnXOY=
X-Google-Smtp-Source: AGHT+IEhdHpJTKuxHDknu7UulelklUSgYcDsRR2l/HsxebE5TnUl/upt6bCk1mEQTSD1uLpjTTa+Vo+TxFSk1K/xnjk=
X-Received: by 2002:a05:6870:4628:b0:1c8:b870:4e62 with SMTP id
 z40-20020a056870462800b001c8b8704e62mr23717663oao.52.1697075313755; Wed, 11
 Oct 2023 18:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009124046.74710-1-hengqi.chen@gmail.com> <20231009124046.74710-3-hengqi.chen@gmail.com>
 <202310101722.B6D6E6CEC@keescook>
In-Reply-To: <202310101722.B6D6E6CEC@keescook>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 12 Oct 2023 09:48:22 +0800
Message-ID: <CAEyhmHSufv0hH_xY7SBfyc+GrG5ao-cUvjRZotV1neS7f6NGxQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net, 
	wad@chromium.org, alexyonghe@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 8:24=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Oct 09, 2023 at 12:40:44PM +0000, Hengqi Chen wrote:
> > This patch adds a new operation named SECCOMP_LOAD_FILTER.
> > It accepts the same arguments as SECCOMP_SET_MODE_FILTER
> > but only performs the loading process. If succeed, return a
> > new fd associated with the JITed BPF program (the filter).
> > The filter can then be pinned to bpffs using the returned
> > fd and reused for different processes. To distinguish the
> > filter from other BPF progs, BPF_PROG_TYPE_SECCOMP is added.
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> This part looks okay, I think. I need to spend some more time looking at
> the BPF side. I want to make sure it is only possible to build a
> BPF_PROG_TYPE_SECCOMP prog by going through seccomp. I want to make sure
> we can never side-load some kind of unexpected program into seccomp,
> etc. Since BPF_PROG_TYPE_SECCOMP is part of UAPI, is this controllable
> through the bpf() syscall?
>

Currently, it failed at find_prog_type() since we don't register the
prog type to BPF.

> One thought I had, though, is I wonder if flags are needed to be
> included with the fd? I'll ponder this a bit more...
>

bpf_prog_new_fd() already set O_RDWR and O_CLOEXEC.

> --
> Kees Cook

