Return-Path: <bpf+bounces-5793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4667608E6
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 06:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D4A281404
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 04:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091234C9F;
	Tue, 25 Jul 2023 04:51:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67D110F
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 04:51:24 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233F910E5
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 21:51:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fba03becc6so7739435e87.0
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 21:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690260681; x=1690865481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abEzMlR8Miho0eF9yl+eRKvXF+WMtFnXDQYkD/vBC48=;
        b=WIIux40R3vQWnrZAPfytjmb8E1WZf1/2M/5mrSHX7ioxn2vmcITPlE+Trx4ydY9OJ1
         d048B6mTkXPf/pOywhjhZm9HaSewfWMauq0d8fP4o9az2+Dr55iW1Iv+3e6On5C8zunS
         owAbQiQzoqvbaVgSJi/SRJsPNMwAE80p+KZmf39HlLqyr6t87oME6+CLo4PpdHpGrLy2
         irw19G4QqlDc4JrdTJfRl+zFdRX2cWX9U6hiqeazLcFHvn7ZvOZVXfd2vTmKWGfLkf4Y
         6mrk5Y4zHzjFKN28cAX2iPVis/SCKS7MvNnSMJalmLKk5/bu4mlIj6zIKmpWPSQn0hAq
         qBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690260681; x=1690865481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abEzMlR8Miho0eF9yl+eRKvXF+WMtFnXDQYkD/vBC48=;
        b=b8oVQ0J/VA+RLOVOONYSmFx2Xv1wb4TJ7BEgdPB1Ers4L3UVdlrHRn91KPU7o54vOt
         VrQw8hBcHp80yzD/AKu0jrQ7rfuHUla5fWU+QrklL+deRsAsgx7CcU2oBWP7r4VKa8ve
         udVYGJg5Ua0h2AxcYGAXjtami8PuIs2h4/6m6QJWv2O+lZ/jsQWywkCakmKiJNvwAlnK
         cEZyl8aTmqx4tZafJMIiDyO4fa0bPsIMjzQfDa75sLIKazMI9jJA/vVnz+pgZAY+iIbB
         Pp7BOqdRSKY3vwQyondE8H1MKPed0wHsBt2CQKVHyF5+bbTv1ksBZtvKcjvBSZlAgR/0
         cAPA==
X-Gm-Message-State: ABy/qLY6f8UJSSygkkHJ36R0swpU+d8eQWvvYGUYtTbGJ7Mo3SS5RGzU
	7W7mHm520w+PFMOaUx0ZpT6BnHo1N4dN8I9AHPg=
X-Google-Smtp-Source: APBJJlFp9zumitUB2oErNKA1PDlk6weCRd3JwpnV5qVAOnBZhKd73afU/qolCCepMJeCTG1Jlz5dzA3PfoHJBRfiTy8=
X-Received: by 2002:a05:6512:3da0:b0:4f6:2cf9:f57d with SMTP id
 k32-20020a0565123da000b004f62cf9f57dmr556558lfv.2.1690260681074; Mon, 24 Jul
 2023 21:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725044348.648808-1-yonghong.song@linux.dev>
In-Reply-To: <20230725044348.648808-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Jul 2023 21:51:09 -0700
Message-ID: <CAADnVQLrH4V6UxBcT9QSbrS7Zi0EhnG-fpFZStu1QuWoz7oUhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] MAINTAINERS: Replace my email address
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 9:44=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> From: Yonghong Song <yhs@fb.com>
>
> Switch from corporate email address to linux.dev address.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Changelog:
>   v1 -> v2:
>    - Use new address as the Signed-off-by address.

From and SOB should match otherwise various scripts will complain.

