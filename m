Return-Path: <bpf+bounces-595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008F704358
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 04:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8872814C4
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 02:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E723C3;
	Tue, 16 May 2023 02:21:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F423A8
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 02:21:43 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BF54EFF
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:21:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-61a9bb1b3a0so63691446d6.1
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684203701; x=1686795701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=624NtMjQmBCZlVxBgDoooY+Sp9UOjQ/EuiBmFqlT/FM=;
        b=AEDsdUUym5oICZKXeK8U7ye9L/kSS5QNrzgyGuIbtjiaUamIreDTd2JtgZlm0MMz+f
         R0hbpPNLNZK1jqJEPRAWtRs3ThU1sQmVd35R044vGzWwnSFuuga1rHes+mLHJP1lLEIL
         xPAzLzeg6/PrEYreKiAsRSu6hUEdwtAyGxh4mLMDJFh7ZUlHYskxX4jbJoLa+rMZg/sh
         AZluGq/y1h6o9xVC5wdgt18JxNqvF5rvHDq952ZuwdoefX2JySqNsxlXF6c7f7KEfc9X
         cvYc3nrihk8IwLKOWGRiFTkHtXciRg7gX9nHZv4OLlnjN7j+S/c43bCYj8+v2BBFInUQ
         FqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684203701; x=1686795701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=624NtMjQmBCZlVxBgDoooY+Sp9UOjQ/EuiBmFqlT/FM=;
        b=gbarEmp43M7tzTQY0ofmtJHn3BkwiDTDHCQzvYOavGFC3Ni0PmzXIFgT4gwrxCzHXo
         wtgjHEtITWcqqC8Eq3MFubt5u2Gx7cPp5cpcPQyqF4e8Jd8XUKOTqWHHUH2dYVq0eEvb
         Cx43UWicuHLIi6i92sGdpp/xRD5R4m3GYWZk52ruSXfbCJXSCE/nPDUBIISq2PrTDxPw
         1JeQLsvZAvfQ83NSFnRfIn340/FOOtIzTToIL/MAlQ0mnUaP1EzUaOUoJpKVgNGsZ5WB
         hEFF2bzOtR0OA4xTLKT0ouqTzmX9ZFJUuev5IxStXhhAdbZXaJssuO+/w8yBVOfBt4YJ
         T9zw==
X-Gm-Message-State: AC+VfDwlx4MVI35xsPNcdHtd9MwEdUEkH3HO3hXqJ47xhxOFoNBzN5IX
	stcEIqNRcKI0XYtc4t7hgMQE55Vyf9SiKcPvLJ0=
X-Google-Smtp-Source: ACHHUZ5zP9AianfedrjCu+u7htRkxsI9Zz1Mz8Rg8YOvgCxUOqcJ+MN0gSuhXYInrf+lY0e6eioGAm+MHt1vN6FlfPs=
X-Received: by 2002:a05:6214:c6a:b0:5b3:e172:b63e with SMTP id
 t10-20020a0562140c6a00b005b3e172b63emr46420047qvj.22.1684203701124; Mon, 15
 May 2023 19:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515130849.57502-1-laoar.shao@gmail.com> <20230515130849.57502-4-laoar.shao@gmail.com>
 <CAPhsuW4w6M236koDfMEJtDKNvN4T0_hev-amqgUF1mnfB8fXMQ@mail.gmail.com>
In-Reply-To: <CAPhsuW4w6M236koDfMEJtDKNvN4T0_hev-amqgUF1mnfB8fXMQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 16 May 2023 10:21:05 +0800
Message-ID: <CALOAHbCPP3rrQObHo67ySO5Jy_i-5PCs9yVQK2UJsOEuyJYKvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Show target_{obj,btf}_id in tracing
 link info
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 12:13=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, May 15, 2023 at 6:09=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
>
> [...]
>
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> The change looks good to me, except that we should split the change
> into two commits.
>

Will split it and send them. Thanks for your review.

> Also, this doesn't seem to be related to the other two patches. So it is
> a little weird to add it in v2.
>
> Other than these.
>
> Acked-by: Song Liu <song@kernel.org>



--=20
Regards
Yafang

