Return-Path: <bpf+bounces-19069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA99A824A2C
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE0C1F23D70
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B22C6A1;
	Thu,  4 Jan 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9jzBb6b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB23E2C68F
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33674f60184so855621f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704403203; x=1705008003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqPrY6TGsbQLkA0VSH3sxo1v/helSaaAMGTDit9ZPmM=;
        b=k9jzBb6buijXzbIJFBhjtMZj5ksfaT9MoS2GfydPY5QqrqhlUpv3LUxZRKtjIysUZc
         1Zmngj6kxbjfifoIhIDxoT+McDH2mPWkNN4P52kZQBjevZW3FOlutGvJ2MuNVbHV7RNr
         z7eRY0qg2w8MhcUf9GglwaDz59CidyDLregmBPw/FwiVWD4lR9mjgh1vFxyUkjVpFuy2
         FYtG1FMzRr/I1u9r7uuxAoTbKjLvuWRvRvfNJFXGvK0ITYIVIvnH0pstsf9GCxAJEPs2
         GV1/Z97MQ/7I7WE87FrTuMLeFskEPily0VmZwH2/JynCJMWrV2CAYA7Ry4MZdgi7VnD8
         nN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403203; x=1705008003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqPrY6TGsbQLkA0VSH3sxo1v/helSaaAMGTDit9ZPmM=;
        b=ZcsV/cYE19vci7L2LvmrmW3g3iCjRvZO2AoiICfxuFjCs1PaGwdwRBYhu9Dl3BeaAC
         w5r+sTl8fvol98EUaU9KYQO9zMn5wCtjbdHHl5HYzicYdzoavnF8wprq5hmsIUnJmThD
         cYkj8dzZ9qVlQtnPwyvs5EwjTkJ7fSL+3UNcffOenwU4p+GtQy1vtj4fPKpgftz0U+We
         ZMFlvmi6AAWVn19kWQB/w+PZQmYc2HZvICeP7/wEvTJIeOXtShbq69FGARqUx6CFelh+
         AWtdDPt87rhF05U/rBUBGt6DHfAKWwHvkp0vBCFDoal64M1njFhos/zmaM7hMEVHOW74
         r/9g==
X-Gm-Message-State: AOJu0YxjesiB5pppKSlMiP7s0SG9FS6vQK3CH+y2sD47t4xvboEMx1I1
	oI0wPWQESvV+wO8bdC51lkadAQ4OZxgN0de1tMQ=
X-Google-Smtp-Source: AGHT+IHimhUK2Q8gqi4k3Mi+CUdkED94rvGTmRBSm6oWWSYmxOWO2Eqz4I0b40p1H0KbnuxIUCcoLPJaHSanrTobASI=
X-Received: by 2002:adf:e747:0:b0:337:3f72:3de2 with SMTP id
 c7-20020adfe747000000b003373f723de2mr630446wrn.36.1704403202893; Thu, 04 Jan
 2024 13:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102193531.3169422-1-iii@linux.ibm.com> <20240102193531.3169422-3-iii@linux.ibm.com>
 <6f05eb0d-4807-4eef-99ba-2bfa9bd334af@linux.dev> <958781f9b02cb1d5ef82a0d78d65ecdbb3f26893.camel@linux.ibm.com>
 <3ac01843-9dbf-4c5b-a1ac-9acda8c47f19@linux.dev>
In-Reply-To: <3ac01843-9dbf-4c5b-a1ac-9acda8c47f19@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jan 2024 13:19:51 -0800
Message-ID: <CAADnVQ+Y1MXe1WJg+Uv3to9jytL-6_qCdxgFsiB6rdzmwSf_MQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Double the size of test_loader log
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 10:15=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> Okay, thanks for the explanation. I applied the patch set to
> my local env and indeed, with this patch, I can see libbpf returns
> an error.

How did you repro this?
I've tried reverting this patch, but the test in patch 3 still passes
for me without errors.

