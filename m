Return-Path: <bpf+bounces-9665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F42779AA1A
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CD82813C5
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C09125DA;
	Mon, 11 Sep 2023 16:21:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F5125C4
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 16:21:26 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0176CC3
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 09:21:24 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-649921ec030so26191306d6.1
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694449284; x=1695054084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeFJiodoKA7hHhrPJOWFs8NZnEvUY71O9fR/UOYGmEc=;
        b=p62eb9apu7wcVnKKIY5Kyeihum3ZhLqSJSCfldRTSHTBaHtldWwPO6qbUhvocisFzo
         uUORt3WZXcFbvoYfb1fIvF7WaO0xneJlwBnunLGHluob5WnTlj3RMT/F9tAE+OtFSpGA
         LivOqGkJcTrrSHuR6BM6kkfmqP/6xx1rvQRxDU0p3/6TljlzCU27QV1dYu8kzMGKqAla
         3LHQnu9rxYp/oGBjFLLPNNxOj1b9J+YqZHEi7ob9eSQGd0C4l0Kjxl8/GEKbEHTE+4Pk
         epe1q3NqTRqVRHLSDZR1xrC4OjZ+riicrn9jZsURZWzOZrSM7/bqsNeiazvcN1rVNa+F
         ykFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694449284; x=1695054084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeFJiodoKA7hHhrPJOWFs8NZnEvUY71O9fR/UOYGmEc=;
        b=b7zmomvy+ibO96mUHu4cU8FbPUIb0JUCQtocgUb53ZfnyNYrH2tWSVRfI8DGuu2ys+
         bZbINGEET+e0vR5C1r+aHXqobsGWZ1NddmUaH20cSO/6G+JOWL2AtRwHrctKKqRHXClK
         daOHvP7AcmERIAWCgzUll7uRIWgvtsU8Ct+Q7W2w5s4gTSsKdG6XrUEdkzl/yGD1kzwR
         vsY7ZKagv16vI0rmEPkYGkdzLSvY98q1Eosvg0WhlIVH7tuND3RKzyNakXXeLjDzKgml
         +gv1d+PK+sG4ueYfruKhz5GhXGS1JeigQ/Ap+07l4+krXSKbLCTV3B+6lr51dF2hUX5e
         wQHg==
X-Gm-Message-State: AOJu0YwUPJovlFm8+RPP9Wc5BRKIjGe0GkzOFRPAXfKSZ+PZ7FEyRo7u
	lpCyfyrXjASRLyoJjZfIyo/esZyIIolXuX+aQyfXBw==
X-Google-Smtp-Source: AGHT+IGps5w/lebxuCKKA14q4iU4eqcA7x01Ibg5/Dx8gzqfnml8MGL/5o7ANavlbSOkGBx1RqjeRVpMISBMpPpCFGc=
X-Received: by 2002:a0c:b3d5:0:b0:651:69d7:3d6a with SMTP id
 b21-20020a0cb3d5000000b0065169d73d6amr10206690qvf.15.1694449283791; Mon, 11
 Sep 2023 09:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKwvOdnaEakT_y8TA9b_nMY3kMp=xxqKpGQPc2drNqRdV39RQw@mail.gmail.com>
 <ZPozfCEF9SV2ADQ5@krava> <ZPsJ4AAqNMchvms/@krava> <CAKwvOd==X0exrhmsqX1j1WFX77xe8W7xPbfiCY+Rt6abgmkMCQ@mail.gmail.com>
 <ZPuA5+HmbcdBLbIq@krava>
In-Reply-To: <ZPuA5+HmbcdBLbIq@krava>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Sep 2023 09:21:12 -0700
Message-ID: <CAKwvOdnRDuDSZ=wHHRBFThz368MP-JvdsS-afF6ATje9eeUUfg@mail.gmail.com>
Subject: Re: duplicate BTF_IDs leading to symbol redefinition errors?
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Marcus Seyfarth <m.seyfarth@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Stanislav Fomichev <sdf@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 1:15=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> but I still hope we could come up with some better solution ;-)

I have no preference, and other fires to attend to.  Thanks for the patch.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

I see Marcus replied but in text/html; I've encouraged Marcus to
re-reply for the public record.
--=20
Thanks,
~Nick Desaulniers

