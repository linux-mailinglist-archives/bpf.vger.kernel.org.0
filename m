Return-Path: <bpf+bounces-59675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF7ACE3FB
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23EA1896CF1
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E45E1FBC8C;
	Wed,  4 Jun 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eud9aMut"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBC1F4199
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059737; cv=none; b=nQO3V3DkJLUml/VPubV25+3/0302zw3viSWTFirEAYM0+2uzZmNDrRR7IdFcagrJdD4e+yilyCc7856G/djLMkJoUrrOOCmlOaF3COOuqGwwGqZwTamszdXhsV+9CN1GhWTq4MwFPXFuJ5KxBWzcSdijyzWBhKWp2c8rpEC3tf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059737; c=relaxed/simple;
	bh=eX7xPj3BLUoYtYSGUSRzHij/zi5ZpDJv6BtyyCyJEvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJv+iaFJHIes0qk4qvDs7PATAaWurhxTUQJ8nnGen6gPSuL1LrIKHutSfY8CenmYL+vwtkfgMTXosUzYWSDmmY5z4R2EO7w5PSczFsLOAHZ1MqsBt0XwhvGKvhQt1xEK12HnRtgDvxNN8CQcjZbVmWctPYJCfDpQEzLOq6PGzIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eud9aMut; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d54214adso453985e9.3
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749059734; x=1749664534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX7xPj3BLUoYtYSGUSRzHij/zi5ZpDJv6BtyyCyJEvI=;
        b=Eud9aMutYEO19KFRZ28fnjRzl9eeC79gNvD4uWMrxHvsxlM9AJJxkfe9cE/xpbXFW0
         pXPPtnGzJ9CjQ7N8AjoL6P9QJRHLPKh3l42oem0n4vcnWXcpLilGm4AxsOwmFw1xKb+c
         /uPGsgNJRkfFIs2JG6UGsFoTTgsymI6JZImNX8b2gE8svAdOXz0qDyQ/WvFppRXtsOdv
         AfwLzCp/qc37JKqIQ4/eSap3+deNptBJU1OpTh9TxraRUkAVnRZoZc73OLMextsFuErA
         R8D3+kIePd4KbxRjZBqViJ5MN0tBP6hkXxjCcVyd9T97EuJLA536LaydFIqL3HMHz173
         FRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059734; x=1749664534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eX7xPj3BLUoYtYSGUSRzHij/zi5ZpDJv6BtyyCyJEvI=;
        b=jGdWGOtlIy62abL/1xQeQhY+Im2co/+91QvPZhWQRnyeX2bxKBhIAiftvUF1avHL9C
         qYHTvTh6nIjNw2cRl02N6GpP/wrWACzkwCPFNnf3ZrCNHGtMQv9S4x6mUJDAQI2lalVi
         jVOgFlAMYIpCULnCuXpnZ/I3WqT030ydF1tadn0KeC0/EiXpZtVuA7GyrkqWOkNylD2n
         JuO9Y1HfODZtB+2ufZs2hQkzoEF+lCvHSecVBGxGr60zRxtBoX9qIt8LFiqIzS2UWoFe
         23tumP2IbwsUA1mycPGQB6TQbZnMw/myrFKXEjnRuWeZM/jwee7TTmxGTOC8oAnKpexS
         FLhQ==
X-Gm-Message-State: AOJu0YwcxH0iuHjGROnjJg5BHlieRgdv6jhUO1Nr8Bc7Xw2MlY2/1a84
	txbrbxM2BOv3+SD3F1jqxq+3QPg9lDeEfaqqL+w76f9lLTWKKQOv5Dtn61EujwSZ4j1darQT4Qj
	EIth/ImBM2jbnwXCpoyy4eLklLG7W+QQ=
X-Gm-Gg: ASbGnctPfwR7iHoo7gHswsExGaIK42bXwseiy+T73cKfJkXPAlgudO5qLnXDCDOxi9j
	P3mQ7SAEA8LVuP5H76wFRgo/aIAI/Owa3Tgq2QgjP+VkJZjJ2B+Imu1dg6mWSOia3GQNXTUaqwJ
	7VK6mnLMB2xj+I1WK36s/SFVlHqJBaU90atgNkDfQsEJaJ9j7wc5G/KhFbfEU=
X-Google-Smtp-Source: AGHT+IEE9X6LztzYIrKXdJYoebq04uYUZ8mq3eHv3POGhuX58JYlvMO7N0mvg2jGEcyEmZ/RWYLK4bkDp980rL127iA=
X-Received: by 2002:a05:600c:3b2a:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-451f0a76e2dmr36966125e9.11.1749059733889; Wed, 04 Jun 2025
 10:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526062555.1106061-1-houtao@huaweicloud.com>
 <20250526062555.1106061-3-houtao@huaweicloud.com> <CAADnVQLH3Ut8dF9t=_zB4acbZYuN=9+fgsACossGqFVTPO6EaQ@mail.gmail.com>
 <137a5a3f-c571-5ade-7ea1-d224ec6b36f0@huaweicloud.com> <CAADnVQLBsYU0xysuqzbZCKbSZP=CLdc8FPaMsvxtrwApwVT6EQ@mail.gmail.com>
 <7e0125a1-0a74-8afe-6278-3d3a4387f153@huaweicloud.com>
In-Reply-To: <7e0125a1-0a74-8afe-6278-3d3a4387f153@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Jun 2025 10:55:19 -0700
X-Gm-Features: AX0GCFtMku8ALVua0J2LjF0HED0KLss8nuhWua-GDAaSrx5fbbmKIO7SJUMKnUc
Message-ID: <CAADnVQKYR+m03PuOUww=Gvxd3BAQGg1-0ekuf+h_Dc+d7X5tOQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf mem allocator dtor
 for hash map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 9:01=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> >
> >> Maybe adding a
> >> bit flag to the pointer of the element to indicate that it has been
> >> destroyed is OK ? Will try it in the next revision.
> > Not sure what you have in mind.
>
> Er. I was just wondering that if it is possible to the bit 0 of the
> element pointer to indicate that the element has been destroyed,
> therefore, the second invocation of dtor can be avoided.

but the element was deleted from htab bucket,
so what pointer will you tag with extra bit?

