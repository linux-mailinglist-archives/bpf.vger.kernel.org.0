Return-Path: <bpf+bounces-8409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79135785F9D
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B6E1C20CB8
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896261F951;
	Wed, 23 Aug 2023 18:28:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570011F928;
	Wed, 23 Aug 2023 18:28:45 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0840A1A5;
	Wed, 23 Aug 2023 11:28:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so57611711fa.3;
        Wed, 23 Aug 2023 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692815322; x=1693420122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnJCtNUR93TcyXIKIwrBGhxaKICGrUKMujSweQQ4+cw=;
        b=JEoBukpGk8amJeqXXiXewlkD4OGiFSWHQ4bha4VTX2dOaFrHzPF9FTv4UPKFznAuf/
         Hntavtc33kXxu16cnQmHRVy12ONkF/wqeKPdkEfgh8eXzVK+cBq0hlBoZ6mnvFvwrG7T
         xkWbwg/ZjpHKngq1ikL6jJWfknvFRkQirSLRDUCKaJuFMhyPspm5KHDqjz5/WE9bZTV0
         JG5B4xBQ1XPjbarQgW83swSe0zeNgYhEdKi35DSNODkz76a6dRwtAklf28TGF8FF1eJ+
         C2JCXfns6tc7g6Y0m8oWugCySPK8kS9OyRyqhtSocmg6AnVIdQlW8/Pl7FEGt7IX5Gj6
         MERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692815322; x=1693420122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnJCtNUR93TcyXIKIwrBGhxaKICGrUKMujSweQQ4+cw=;
        b=iYU7pi8ua68Hy2V+VqLv9/lYY+CQ4YKh+5eAGVP/y45yqSoBNuq0F5ewpNV8XBCzyJ
         MpxKHeKTtARCWwKiglax8p3Y/MhLnywuN7IzoJXdMJ2UgXV4i434Ep4IMKwvTbdq3gN2
         MUQgPbyLemcNbJw+bcuGZ4vEcmKg69uaImO9cKC4apeOil38LEY/ZW/znZuXnaNmcf/8
         TU0+ntnKZ19YCZ4PA5OG6Fx/eXZhuN3omWrUMsQK4WEMri+7wxhRF9+FaPyGDnsoYiL5
         YemlG8jRrLUsnzpW1yo4w8iZaCF1rXCi4b1C6Tk7tNe8YFemC8N6cwvz4AkxEmKFU7gR
         SoQw==
X-Gm-Message-State: AOJu0YylSclh7+aPN+5uFCjqUKrWZIxPR8jVItq9lb0Eezt6APXiTgnJ
	y9ee0wnV/ZDk7bsQNfA2jmHw5xQ5b53KxZOodak=
X-Google-Smtp-Source: AGHT+IF3kB6l7zcwpTYQASbxiqszHAQx1UTOgfwuyKWrwopfUZlC/RAnfkjkfe5oCDX7bkD55tuujrmsTx+zSfQcC4k=
X-Received: by 2002:a2e:8791:0:b0:2b7:2ea:33c3 with SMTP id
 n17-20020a2e8791000000b002b702ea33c3mr11602391lji.22.1692815321818; Wed, 23
 Aug 2023 11:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-8-pulehui@huaweicloud.com> <87zg2hk44i.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87zg2hk44i.fsf@all.your.base.are.belong.to.us>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 11:28:30 -0700
Message-ID: <CAADnVQLu5twbe_UpiJrD0wKq1YyHzZbfzYhsW-mte7vDmyna5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for RV64
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv <linux-riscv@lists.infradead.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 11:25=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> Pu Lehui <pulehui@huaweicloud.com> writes:
>
> > From: Pu Lehui <pulehui@huawei.com>
> >
> > Enable cpu v4 tests for RV64, and the relevant tests have passed.
> >
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
>
> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Bjorn,

Thanks a lot for the quick review!
Could you give it a spin as well and hopefully add Tested-by ?

We still have time to get it into bpf-next for the upcoming merge window.

