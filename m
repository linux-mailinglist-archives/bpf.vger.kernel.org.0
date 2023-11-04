Return-Path: <bpf+bounces-14211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0673E7E10FF
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 21:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135C41C20993
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B8249FD;
	Sat,  4 Nov 2023 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJlp/ojj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F618F4D
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 20:54:20 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0148D51;
	Sat,  4 Nov 2023 13:54:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083f61322fso24197995e9.1;
        Sat, 04 Nov 2023 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699131257; x=1699736057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEnf+Mjt/VcCd8wJsoTVNtSmXZ0N2eZfMiVlDZVdZc8=;
        b=nJlp/ojj7wSb8OnLMCoOK9tKzvCN25X2E9Jmx2Dqft0mDijS41Behhcf8c2KLfthhm
         duMXTgMTUDQXMWSgj8+ZyUj8L2NtxAdbKxlUmyocz4MLcwAVQtuPyqvPaQyJaljLR5IV
         LLkAbE+KGFetE4JXHwm7S6T8GTLH6KD/ugB4WdXJ99Aj3CFU74/F0UyWxRW4DBVpmSPt
         dyq5RP03j9C9MuKTYfMWzKx8ZBRa6LSoRV5ln3TEsXRmbrZ3vywWCEgcPj4Vh2xKjiWK
         DI8g08iXsC22OXmJMwztB59ux4TOtqgbm1AA6p+gX9SKNOvIeumL3ug2muYLhxT1W5a5
         NYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699131257; x=1699736057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEnf+Mjt/VcCd8wJsoTVNtSmXZ0N2eZfMiVlDZVdZc8=;
        b=N/ob5/VASI21wM4h5aFiDr/xJh5bvRgflj5ujI9IM84v2AuZ9tD5jZATEcEU27bbUg
         OVqj1oBT1RJokH6LU4j3MvpYZPLMl/WBiRBxH7zOmjWNogvUoPjdSCuQ9/whZb4Yhupe
         /wjlaCyGbPCb7GfnohUZ6WUwjYoQICZYXO+0ZiffnncO8MtZpau3xKkvPT3Y3MQUiwhu
         X/HsqAk8NdN6FxhlgbyYVP79MV0SNy8+mkRni8mDFCLLttB82Zj00un2LVN9RiVqkze2
         nevZDg0sX9CGRzbleEw06ECAfJKetNql6NQnx4uShLfb8254VtlUs+0pVhBuTMrulunn
         QDtA==
X-Gm-Message-State: AOJu0YyA5K9b+EWszMgZSpRHrU4Vh1p9Y8/zYIarjFW9rtVYDA3k6xQ9
	NsYgQ5gdFehjN0oOgXA1L7Mz5KdraGhyNznetqA=
X-Google-Smtp-Source: AGHT+IFFoJD1UkMfimuYH/N/pj7dQMX9XdrwFUB3GAWsh3pV1gWF5S18EVp/oNhi6K81yRty/l0kW/0QyBDxilmUqfI=
X-Received: by 2002:a05:600c:3b93:b0:401:b2c7:34a8 with SMTP id
 n19-20020a05600c3b9300b00401b2c734a8mr21604216wms.7.1699131257054; Sat, 04
 Nov 2023 13:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104024444.385484-1-chen.dylane@gmail.com>
In-Reply-To: <20231104024444.385484-1-chen.dylane@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Nov 2023 13:54:06 -0700
Message-ID: <CAADnVQ+1pNzLRwNNzL-0ai0P281hG=eNO2COrCxuCv2VF3KGUA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Use E2BIG instead of ENOENT
To: Tao Chen <chen.dylane@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 7:44=E2=80=AFPM Tao Chen <chen.dylane@gmail.com> wro=
te:
>
> Use E2BIG instead of ENOENT when the key size beyond the buckets size,
> it seems more meaningful.

seems more meaningful?
Sorry. That's hardly a reason to break someone's code.

