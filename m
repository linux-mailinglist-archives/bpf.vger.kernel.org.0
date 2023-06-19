Return-Path: <bpf+bounces-2862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1345773591A
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 16:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18E5281121
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CBC11C8F;
	Mon, 19 Jun 2023 14:03:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4C11C88
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 14:03:20 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF2B10D
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 07:03:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b549e81cecso4851475ad.0
        for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687183398; x=1689775398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4zA2x2rf1p5pzoQJxSBuzoBeRkUzNS4Bq8HFTmaCoE=;
        b=b+fkLYr3MnYz/OQ9BhX6fL07uLzvPcMpQDFVDzDecktXyoL50Q3ZJxYZPSun/2NE/k
         KAeGe8M8bNjBkwmPAz++D+U7I948YLAmWCn1fOit3orWSOPF/RnJZYfh3GMaN9pBA8N3
         3V7ScFFz8VQoikvuMgU/IicArKbCOUt6tCa2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687183398; x=1689775398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4zA2x2rf1p5pzoQJxSBuzoBeRkUzNS4Bq8HFTmaCoE=;
        b=aEhnLGvD/MVCXIfhjW78BQuTzq0bG2hRYGV3OzwxG/cNMQB1lNsrL5QPyZPHAC6tx8
         oaAWGju7Cj0eBL8iUv5h7JJDkRXIL4a9n47ThPyOZVSDNd8ThMzrlozniqyuHV46OE7c
         y50SgrIXyjFzQHJjphTldzmb+EamseFGhUzMWqZpm8JujqKP1tk6Mg4o5Zc7jhYi6n9v
         qhka0tkg/ZDJ5Sv48rHG7e12yeJZhhu4zBS9WT1hqaBqZ25wHtl9IhhBp31JNrpVAkJ/
         t3XqOkOhrdiP59AJVElmGq4gZ5Qevt7xVik5jBx7MuOLFZ7BGEKJ6vBOo0BIOyX+quU4
         dPUg==
X-Gm-Message-State: AC+VfDyD6bSGbxc/W8ftRnA4kFGXm66RAJFtGzbb44k+Sb5yyTwY5Emg
	b2bW/0IaVdsTIchIctJ6ujJ3f2/2RD9NPTRNOxueZQ==
X-Google-Smtp-Source: ACHHUZ4v3i2RgZ9YWY86OIWqNc5hX+EADjk5U09Liihu9nq6bBliCQ8oKBwC0e38lv6wShZ5U2kDtW6XiCKfFXAjnS0=
X-Received: by 2002:a17:903:1112:b0:1af:a293:e155 with SMTP id
 n18-20020a170903111200b001afa293e155mr6269262plh.16.1687183398115; Mon, 19
 Jun 2023 07:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615145607.3469985-1-revest@chromium.org> <CAEf4BzbjCt3tKJ40tg12rMjCLXrm7UoGuOdC62vGnpTTt8-buw@mail.gmail.com>
In-Reply-To: <CAEf4BzbjCt3tKJ40tg12rMjCLXrm7UoGuOdC62vGnpTTt8-buw@mail.gmail.com>
From: Florent Revest <revest@chromium.org>
Date: Mon, 19 Jun 2023 16:03:07 +0200
Message-ID: <CABRcYmK=yXDumZj3tdW7341+sSV1zmZw1UpQkfSF6RFgnBQjew@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, trix@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 6:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 15, 2023 at 7:56=E2=80=AFAM Florent Revest <revest@chromium.o=
rg> wrote:
> >
> > When building a kernel with LLVM=3D1, LLVM_IAS=3D0 and CONFIG_KASAN=3Dy=
, LLVM
> > leaves DWARF tags for the "asan.module_ctor" & co symbols. In turn,
> > pahole creates BTF_KIND_FUNC entries for these and this makes the BTF
> > metadata validation fail because they contain a dot.
> >
> > In a dramatic turn of event, this BTF verification failure can cause
> > the netfilter_bpf initialization to fail, causing netfilter_core to
> > free the netfilter_helper hashmap and netfilter_ftp to trigger a
> > use-after-free. The risk of u-a-f in netfilter will be addressed
> > separately but the existence of "asan.module_ctor" debug info under som=
e
> > build conditions sounds like a good enough reason to accept functions
> > that contain dots in BTF.
>
> I don't see much harm in allowing dots. There are also all those .isra
> and other modifications to functions that we currently don't have in
> BTF, but with the discussions about recording function addrs we might
> eventually have those as well. So:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks Andrii! :)

> > Cc: stable@vger.kernel.org
> > Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec"=
)

So do you think these trailers should be kept ? I suppose we can
either see this as a "new feature" to accommodate .isra that should go
through bpf-next or as a bug fix that goes through bpf and gets
backported to stable (without this, BTF wouldn't work on old kernels
built under a new clang and with LLVM_IAS=3D0 and CONFIG_KASAN=3Dy so this
sounds like a legitimate bug fix to me, I just wanted to double check)

