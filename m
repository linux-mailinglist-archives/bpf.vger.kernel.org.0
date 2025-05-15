Return-Path: <bpf+bounces-58359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591F8AB90EB
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 22:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E509E3CD1
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB5A29B215;
	Thu, 15 May 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiVO/aHe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9821E1308
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341769; cv=none; b=EavNdkRNVRrkgOXo1wM1nWvBv2FmVD7RvC6087tX//wby3hxxhGLBkM3Hg2jihnyALuStY4xjneL+OAHrdKJsBbo9fpM4FHFlhgBygYA/9AiHffAJcYEk1QL8SOqsxBwPnIXfd/Qhxh1ovHIAFufbVLhBmk5tNqQl+TdJiNBrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341769; c=relaxed/simple;
	bh=pZMMj/Bf1eG0q2OMxTU2yM5EU+yWjnertJ8XBnh1Mow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZawuLPCVUJEyjFXlhWNCmel3uwiaB8bu+Jys4ycYDWERHeUtOv9v8VJ3yJ8ehrwWjOXyFv9Us4F9OEiL4aiQN0OKs7kqgkWS7MZ3EVH6bJQet541xhwRYistKh6meRbPxkpn71SQbtvwdsthN3ELNwLMSxO4DXT1zSJQO9KJmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiVO/aHe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30ac268a8e0so2200932a91.0
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747341766; x=1747946566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDcbvpaCwdpcZdj0/2+I2LSmWhvhBpKTP/zpPSSEjp4=;
        b=NiVO/aHeWdl8E/iLxhdSRMw2EUTIx626FlHDAKlkHahIF36L1erSIlU2U7lQXml49a
         Qf8jrBQjFHyEhOc+teqFY+9Ms9qUGIBHLck7YR+M5NpxNn1gijNtjhujp/yNE8i6my6F
         JL+OXjMNwoJ1KYqiwWSn+EgyiRMtV0xlgs4VsFcCRuA2zrfe62XG5HJxM5zxxVXnl93p
         ia12cwVgf2LIpH1YQn0fjBiSICrfHZTMYH2xM2IUVTY9M+sgUv8XN/8YN0V5zRguxKPV
         EvW7iH+n6meRTDTIsTL8poU59w7ycYnj76I5hf9899OSCt6oYOq6m9Y5Q0ZRKtm2rp91
         +mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747341766; x=1747946566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDcbvpaCwdpcZdj0/2+I2LSmWhvhBpKTP/zpPSSEjp4=;
        b=gWQ02fh26QF1l303fkcB7OKr5vbsxzLLfSrrnuroM74B/hXCKyJePY/kbQimO2vBqY
         N3T8NA+nqENvEu2vYi2xx8J/NksFWj4nSDgSUUtehF+0eVcOvvG13fyPc0fcc2Kd2rpr
         hsaJuD9m2V/y8DhvY50QY4jOJ2YpZ/MLlChY6XaOFhoy4rYo8VcJo3248gzvy5zs42iH
         7xChw4oJzpVCxdt3QaKGBG9PLCPCALrG58AV5fI5/IVoIcYywmOXOQs80/VJn8NnoQGH
         Speqi5T325SWlmBGjoSONmZf/gQd6YrUaCNoN5CLtbEaFye44/TrmH2TJgxqcRcP+rWC
         Yyjw==
X-Gm-Message-State: AOJu0Yx9DQPFRpwEN+UEPNOsAK+o9WzPbE2BiTJFOrGIoB4akDlOU5f4
	hvdzEQomBiuSCCJq6qbEBxYHU3VN4EzA82UV6E2VR2v8VcaptStDYZLJCNh3f2833VOQJeDpEe9
	qr9en7j1vo0hWMYzu8iDl1vPre8eltzw=
X-Gm-Gg: ASbGncsacnbc8EBCut8nK5mZB2D3pdXCc04etJ/gy/NtpIUORFFFGfdULCOz6ZYPf0Z
	C8E6qenF4HeGmQqw4U23SX3KVgTyXg9CHsUpTY0w6PPwe6yygd58vNHpGXnLcp0gDJI7xxQU6o3
	Kd/vwOiVZcwizF70Aa+FzoGqmzuIejYCP+YykJCz4DXrnwgWU2FtVxNvygHPU=
X-Google-Smtp-Source: AGHT+IGo5hkCJ7NaELrKpN9KFOKECJGLmP/jVsN5v55wx8xddyVc2ufjhlXLjT43+sQ0VW0F9TwebMgi9VRvHS5S0hQ=
X-Received: by 2002:a17:90b:5850:b0:30a:9feb:1e15 with SMTP id
 98e67ed59e1d1-30e4db0fc60mr7113091a91.8.1747341765851; Thu, 15 May 2025
 13:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508223524.487875-1-yonghong.song@linux.dev> <20250508223539.489045-1-yonghong.song@linux.dev>
In-Reply-To: <20250508223539.489045-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 13:42:33 -0700
X-Gm-Features: AX0GCFsSw5VaIzuAF7oy0X8iMusGLVQ0cFtAFiuYn50AF83hbSySjO_Xb7HhzYo
Message-ID: <CAEf4BzbHArO8ds+OguYjUXPf3BHk0FReKvcJg9mA7S2fZuGPig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] libbpf: Support link-based cgroup attach
 with options
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 3:35=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Currently libbpf supports bpf_program__attach_cgroup() with signature:
>   LIBBPF_API struct bpf_link *
>   bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_f=
d);
>
> To support mprog style attachment, additionsl fields like flags,
> relative_{fd,id} and expected_revision are needed.
>
> Add a new API:
>   LIBBPF_API struct bpf_link *
>   bpf_program__attach_cgroup_opts(const struct bpf_program *prog, int cgr=
oup_fd,
>                                   const struct bpf_cgroup_opts *opts);
> where bpf_cgroup_opts contains all above needed fields.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/bpf.c      | 44 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/bpf.h      |  5 +++++
>  tools/lib/bpf/libbpf.c   | 28 +++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 15 ++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 93 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

