Return-Path: <bpf+bounces-17554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E198380F3D1
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C81C20A53
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E57B3B6;
	Tue, 12 Dec 2023 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB13AhPq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E81114
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 08:58:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33621d443a7so2296432f8f.3
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702400296; x=1703005096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TDdOculQXaKmsGvIol4bkbjlHbJWdTHQ4vD/in3UMU=;
        b=SB13AhPqYxXB9a5cEaoW+qfp4QYrFHftFNrbW9x3vjqEAWz76YhtNLkV+r4wgePPWE
         NEvV+ceUOOJzOfzVjD/LNdOl6pqi5q8THoov3kmoTKMUvsLaEB4iQ/eI6DY1H7HJ0sb1
         3LhYM0QWeAipoopAcrBncM8oCKga41GiIjrs3ZewfCU+XW3Humz2kEAtA6h4tj2hqsjy
         WcQju+m37h9Qq1yeqeX+OBPmZhgEWwIGgELVJhkemrv3Bd4z25OOVuIZPKr/af6UvDH2
         7/yXGQGjEGnTcHoeAwCT3kq6wQnFGWCWWjKvhxMrOTfl+qiK5j1h/te6Brn7POd8cULe
         6OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400296; x=1703005096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TDdOculQXaKmsGvIol4bkbjlHbJWdTHQ4vD/in3UMU=;
        b=ORhGTNn8bRQYy0aKt93HSDgsglHrA4hZAu/YXlf6EyHLVDnLLPCINZVWw2pXnZtACB
         +6G0xnF3tWXSV+S4h+SG9jEpLmZMd9D208WU8mm2dwBi+cyFA2RII5ArUZ0unbyHj+cx
         zhjVHf6g/IZfGBOd2LJymgYzO6ikgEr+G/zI6msZthD6C34OuFR76iL9Zo4yX0YcL74U
         G94j57tcpNTwB6THrK+NozZCT0UXZ3MKcBVivj4WL8C3D6MriE0t1irzH23UDPjaco5W
         BQmdbEzRYo7lXObANLLGSGMLsbvniNBx5z5r3kwPQs5t3ya5RdKWzvezQ7DgwUavBKi4
         Eqmg==
X-Gm-Message-State: AOJu0YwtMMiaUQzo4GEYVORDDxJZ7hA/aHty4JwXf7cXPqGYEFxgO/Nu
	sCa3Ga0N/GSzlQDZjNfPOLuyTzIp5p3pXixR0z0=
X-Google-Smtp-Source: AGHT+IGvGKSmeHOxumtz/P6BA6likjqBweIsDz8H3F9rgpxMwJcXdI2Wt3qkatObk3eLQyYcgqPQuLcwD1s/7aOlw7E=
X-Received: by 2002:a05:6000:44:b0:333:3c19:d3d2 with SMTP id
 k4-20020a056000004400b003333c19d3d2mr3101749wrx.31.1702400295643; Tue, 12 Dec
 2023 08:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
 <20231211112843.4147157-2-houtao@huaweicloud.com> <CAADnVQKYE7ijTtcWrdsGpTNvS0r-TTXgkw8-R5U7rWTj+-kqAA@mail.gmail.com>
 <8d17436c-66ea-dea0-38e5-6edcea6c1eea@huaweicloud.com> <ZXgt5kLyk9BsFRBq@krava>
 <5f63e895-8320-2200-7452-83959db8be27@huaweicloud.com>
In-Reply-To: <5f63e895-8320-2200-7452-83959db8be27@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Dec 2023 08:58:04 -0800
Message-ID: <CAADnVQ+mmPAYE7Er-XAg4wDVBVfuQy0iuQ6UJNr3vcJ3WkDLSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Use __GFP_NOWARN for kvcalloc when
 attaching multiple uprobes
To: Hou Tao <houtao@huaweicloud.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	xingwei lee <xrivendell7@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 6:06=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> > anyway to be on the safe side with some other configs and possible
> > huge kernel modules the '1 << 20' looks good to me, also for uprobe
> > multi
>
> Thanks. Will post v2 if Alexei is also fine with such limitations.

Yeah. The limit looks fine.

> >> can not be fulfilled, right ?  Because kvcalloc() will still return
> >> -ENOMEM when __GFP_NOWARN is used, so the userspace knows the malloc
> >> failed. And I also found out that __GFP_NOWARN only effect the
> >> invocation of vmalloc(), because kvmalloc_node() enable __GFP_NOWARN f=
or
> >> kmalloc() by default when the passed size is greater than PAGE_SIZE.

Right, because kmalloc of more than a page will likely fail.
But vmalloc() may fail for all kinds of other reasons.
Suppressing them all prevents those messages appearing in the future.
The warn is there by default, so that users think about memory
allocations they request. So it served its exact purpose.
Just returning ENOMEM to user space would have been unnoticed
and cnt > INT_MAX would continue to be acceptable which potentially
opens up DoS, and other abuse.

