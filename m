Return-Path: <bpf+bounces-9147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992F4790A97
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 04:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460BB1C204F8
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 02:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8138816;
	Sun,  3 Sep 2023 02:44:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861437F
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 02:44:29 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6512F;
	Sat,  2 Sep 2023 19:44:27 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64a5bc52b0aso2635326d6.3;
        Sat, 02 Sep 2023 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693709066; x=1694313866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1GAPNmXBdNBOSiPidq4SuOnNGpXyf62DRjoqSlEOKo=;
        b=N3EsxrN6RNGcIPDhcpHMh9mIxInJfKdN6iWkPBH828yhtVT3OqqV6SSeflQBGwOks0
         VfGoaWfgiygvMpNqUPl57pIxo4d5A6L5CxoQLiS3sW8mOgoWG214ns4m6lhMfUvqcWWx
         7eDAfC2vndGy1LJu5ARi0Xvi8iYZ67xCK+Klp9Pl7gCJVPESu1iPR9ushYnVeraDzFd4
         CqXilWaq08FkJt4MFTqc3hjQILrW12BewbWdhH4m8uCS41ns6BC1ixFJgKDY2JaF3Dcf
         txvEidYgsmfWlS3htEgC861O3N/rSwZNIQpwyM7oE4glV1+XEt4ENFjhIaLanGnqL6Um
         K5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693709066; x=1694313866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1GAPNmXBdNBOSiPidq4SuOnNGpXyf62DRjoqSlEOKo=;
        b=dBK6opNvNViLB1mtj7NHKXE7qhQCTG98fLh5mU86zmmX5gmfroaKbkqgiIhKX1rYKe
         aiHjL4J29tghrLGO8IQ6ZkcU9KzkanHw5H8KHOnWeOgIi6SZHa0Xckd+CuxkRkBT1xm5
         EJ35vfjh9QnvdDc+/HLBwX2V7/kljZYeRT2ftwGA1jCWD71pBZ5jS9kd5SIS6ClKYOJI
         lyBbcO3+ioATZNVokNmVqWIMyEq8Rrfx2Ud8iAJp73y+7wutX6ivDigYtdzNf8dJA44M
         LSD2NvCuN+fm4GXk90M4A4clACw1quZEIW3r5u6R2aDoiI/KrC/kRwhn66NpM3w8Iy4e
         fIAw==
X-Gm-Message-State: AOJu0YysCvNpTwojC6AKkHpqO/r/D5xOu50IfjtzU337X+HrTu5AmR/X
	8FSubYiBQWohrO3AFCQM3Gf2G60rYnRyVn3gnEc=
X-Google-Smtp-Source: AGHT+IHbSGrDC3xasIMg2h9SHHXg5ol1Cyq5w/p/l2eUSGrtnMxS0UghYfA4zwp55tXGNfaK7lqcxQoRN5HcF/N9iTw=
X-Received: by 2002:a0c:a9c8:0:b0:651:75a4:75b0 with SMTP id
 c8-20020a0ca9c8000000b0065175a475b0mr7632518qvb.1.1693709066298; Sat, 02 Sep
 2023 19:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_4F0CF08592B31A2E69546C5E174785109F09@qq.com> <tencent_2B465711F30DC88514B2842F1D54005E8109@qq.com>
In-Reply-To: <tencent_2B465711F30DC88514B2842F1D54005E8109@qq.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 3 Sep 2023 10:43:50 +0800
Message-ID: <CALOAHbDvA8yG0=ep3e+MbsWu0oeHzoDUzWGf9mzApN_4za09LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 0/2] selftests/bpf: Optimize kallsyms cache
To: Rong Tao <rtoax@foxmail.com>
Cc: alexandre.torgue@foss.st.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	martin.lau@linux.dev, mcoquelin.stm32@gmail.com, mykolal@fb.com, 
	olsajiri@gmail.com, rongtao@cestc.cn, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 2, 2023 at 1:24=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
> Hi, every one.
>
> I'm so sorry, that i'm not familier with 'how to submit patch series',
> I just sent some emails repeatedly using the git send-email command,
> please ignore the error messages.
>
> PS: How to send patch collections using git send-email?

$ git send-email --to <outreachy mailing list if required> --cc
<addresses from get_maintainer.pl output> /tmp/*.patch

See also the section "Using git format-patch to send patchsets" in
https://kernelnewbies.org/FirstKernelPatch

--=20
Regards
Yafang

