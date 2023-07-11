Return-Path: <bpf+bounces-4775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D992774F4FC
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F601C20FDF
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B67419BDC;
	Tue, 11 Jul 2023 16:20:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EDAA5C
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:20:30 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DDA10DF
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:20:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992af8b3b1bso765015066b.1
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689092426; x=1691684426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLEnxj5k/Aowz3rFCC2fpa7D9cX6Za3i3Ve4WU+vKnw=;
        b=OXgLZrII4RMtSQKWTi2mCvKB3hEebI7Tc6yJ2BQu7DWAo7yyMOBD3cMZi/0U4HEW0G
         cSPyIGxIZy0r0Hzm0vnJkWwqBql8jqq9PvkacIbvilsbddPiW9EXAShggeNCQOK2c3Ff
         8n4tV8D+iSJWn6Zgd8/5vupm5Qq+27/fTyhROHVe569zap6k0CnlKHw+HZ9HZ1xfx2fb
         Zy4swqmaj76BAQMl14dfssVxORi15CO2h5NjwgXdB57BYN2g3r5LOnPsKhpgUr9N83ES
         pZm4FT+b1RbMAs9Jdxyj1PR+8/yivRGAATU5SugsMSWhEzoO3/OB/k8thLNiUM3Z6BP5
         Su+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092426; x=1691684426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLEnxj5k/Aowz3rFCC2fpa7D9cX6Za3i3Ve4WU+vKnw=;
        b=JbuiapWiI3MqDPv5WenuVXKRofZ7lpV59XxuRAAbc7lv/KKJ+OOxinlcw1gvw/0Szq
         sBr34CxCFy9F1cZzyX1BPIjN0XGtDHTkO53VwNII0AoaMx1e7sc0343vAnfavjtEASPT
         JPafbd5+a06L1upD2nNhY0qvnaJPILdC5LLiGd0bjR6vGX+Qd9htiSo6uOIDCLtw5k77
         xHVp/082GxZl9B8JCLzWiJ0+aXrum7ye1sn3gPHLMRZuYQh8Q9ZcDDhZtbV5APvl/SwP
         aIbvmf6zXFoeHoZb/+EKEtgokVwaJfATSYLQzGRFvCkaNVIwqUkFHXbxU5f7E+zflyql
         9t0Q==
X-Gm-Message-State: ABy/qLabtYLVnMaAe68DyOvQhspCWNVKfHYDahaHxEUIABahYxl3QjWn
	45WancTE4OtL76myoUEH1+aTXzCCMZhuVyOtD/BqyQ==
X-Google-Smtp-Source: APBJJlHA6L0c97l1YfiKHcEbSMzZMy/vhPHNphjMrwhjJI0hEATH3d/+sXhj6Ik74tsgKrDpU9ghewJwFg5ixq8mgw0=
X-Received: by 2002:a17:906:77d4:b0:991:dc98:69ff with SMTP id
 m20-20020a17090677d400b00991dc9869ffmr13891520ejn.67.1689092426013; Tue, 11
 Jul 2023 09:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com> <CAEf4BzbSdggvGD=xXZxFa8tjUxGWKrsb5hL9EP_viHqQCG+MYA@mail.gmail.com>
In-Reply-To: <CAEf4BzbSdggvGD=xXZxFa8tjUxGWKrsb5hL9EP_viHqQCG+MYA@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 11 Jul 2023 17:20:15 +0100
Message-ID: <CAN+4W8iOWyZ9ozZ6xaJyQaMO1J5hNoKOkZ8pN8U9mFBZYa3vwA@mail.gmail.com>
Subject: Re: bpf_core_type_id_kernel is not consistent with bpf_core_type_id_local
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 10:07=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> I think it's better the other way around: make BTF_TYPE_ID_LOCAL strip
> const/volatile/restrict modifiers. For all other relocations we rely
> on having named types, so const/volatile makes no sense and will fail
> relocation. It's hard to come up with the situation where recording
> const/volatile/restrict in BTF_TYPE_ID_LOCAL would make sense, so I'd
> say that it should behave just like all the other relos.

Would the relocation then point at the stripped type instead of the
start of the qualifier chain? I found this by running our unit tests
which essentially check that the compiler generated local ID from the
instruction stream matches what the lib generates. I'd like to be able
to keep doing this.

