Return-Path: <bpf+bounces-13084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038837D4442
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3469E1C20A92
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304415CB;
	Tue, 24 Oct 2023 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOzJ+z+T"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827D7E
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 00:47:32 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC1171A
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:47:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f71b25a99so2629261f8f.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698108439; x=1698713239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dcV+wl6BjoBEo6mtf3TaFoELi8dPYQ9jujca3nZVGk=;
        b=VOzJ+z+TEStX2v7AnODdOoMRrAhbtqOBA7jDsHWyAtxwZkNa4UHoJ1gqPNK4FG1uk2
         oWp55HEGENLUDU4TEK1R4gr3OFm4mfNHhO3H5mv/3jWYoDPrVUU7C8GyX8a23zuQoL/M
         Hn9WRJWBjAAZc2mfuWj5mFt5HYA2HSlYsLvymYXT3M1zcxlDCsQS48kIasev984MfupO
         gMY3AQhi39lMhqkP3C0zoVBw4YRH6Nt5FrCGVeUtzyU9OQWdSmvC3Z8HjLYa+X0AfH16
         S4L4P7s45XcpcXV1fC11cM7kPJmwD9OdD+NaXAoiydjGQf2Opn0KelcBZ+Fkeu68QlhR
         ysrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698108439; x=1698713239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dcV+wl6BjoBEo6mtf3TaFoELi8dPYQ9jujca3nZVGk=;
        b=CT3QjSj06bDifTl1TaNKzQgPVDEVUXUA4e3MoG63iF/e8TtYE2TZs1hryaKzIemrJB
         MVO3YbcHJFVKohsLtmOCmtGN70VqdaOPNd6UEr8QxVAXhBZuDlJ67XwgHn6kAaTBJt3+
         wKNSrDvcPEERAGlUstUk9poct2wJ1WT50cc8fDb7+sZvpGkjVfTG3bkMiSyCtmoRA9su
         39Z39yQ0mEXD6nB1/6hxaeKgDawRFDejqwfeeHmbeyH0qIURB62B08jwTCybmSFyxUTX
         trv6y+slRBafpgVzVoQwKaOQV003bzXo2Bcxr436tT0TygoWuqixf2cYFinfykrlaLjq
         l7Ug==
X-Gm-Message-State: AOJu0YxjUhvfjUuK/kT6idcID9yWgq8SXao7ooZoxnMUj4Yhjcvw3xBv
	96Td4RxvcCp6RfIsSq8D5J1qQlWqLAM3f3A9uWY=
X-Google-Smtp-Source: AGHT+IFTp5Mg79CdO61f0WwT4g5nX+6hm6ENK8nNucBy+rXEIbiBj/sXTWMobfZjLJi3HuVXtBJ8Wji2yx+aA1QLkgo=
X-Received: by 2002:a05:6000:1109:b0:32d:a41b:bd47 with SMTP id
 z9-20020a056000110900b0032da41bbd47mr7338476wrw.59.1698108439071; Mon, 23 Oct
 2023 17:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023224100.2573116-1-song@kernel.org> <20231023224100.2573116-3-song@kernel.org>
In-Reply-To: <20231023224100.2573116-3-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Oct 2023 17:47:07 -0700
Message-ID: <CAADnVQKcOvJ5rZRQuCn15mmVp0LLuNnQ=3kHGAEnZ7nVhJ=Ffg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/9] bpf: Factor out helper check_reg_const_str()
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:41=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> This helper will be used to check whether a kfunc arg points to const
> string. Add a type check (PTR_TO_MAP_VALUE) in case the helper is
> misused in the future.

The commit log is cryptic.
Without reading the patch first it makes little sense.
Most reviewers read the commit log first and then proceed to look at the co=
de.
Please reword all commit logs in this set.
'This helper' should probably be 'The check_reg_const_str() helper'.
The log should also say that the checking logic is refactored out of
the existing code and addition of PTR_TO_MAP_VALUE check is the only differ=
ence.

