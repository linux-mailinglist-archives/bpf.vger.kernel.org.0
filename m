Return-Path: <bpf+bounces-37973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9586E95D585
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 20:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A692285560
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36AB1917EC;
	Fri, 23 Aug 2024 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aehV1U9x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694C118BB8B
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438952; cv=none; b=aaprztiUj8iwXWWuSw4YWLs6/jk372u4Bx+qnJOOfz4ndEERExaqpVOypnEh+FiyQ5rkNCH+Zy9LZuvkcRjJxKqg05essolkuulT8XNITDfR/dvI+ijuubzjgy1W+Q691b3yCep+/Lwv88DVf+iixrcTwOhKjouTTEv0pYO0oBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438952; c=relaxed/simple;
	bh=E18rTTdMFpNLRCxNJGlGiMukFONqcJvklGS5tgUYreM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8nnPKqhKmv9eJer8WZbR/R+8gF/D9t7t6vjUeI93Vra2gd0k3i6bfrCAD3pe0vVrRuE0FRtVbtt0/7kTg74ekfO7o5sShEkikgg4Gj8bF6vAKXUcVZ/OsM447T7MM086MTCjLRbveJspHFirNgV1K56a1Tyz2HumxyVljhAW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aehV1U9x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso12022205e9.1
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724438949; x=1725043749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjEnIieOGUwavK4pNcXsBSq72pat9RqmmEPTpiExAj4=;
        b=aehV1U9xgcuQin6CUqD4BhUujg1G9WqiVt1HO+4RfCyZLL+7w5bsGVGwVq58KZmhYU
         l1zvJG/RsM9KffETZtRG9Yg+4Y4UAkVpRm+JbKgmPKcf7F083d8cAeJwqPZ9btLT1E9/
         iSWaXq7qaOJAP812mKdK8ZKgta10CQ6GoH9jgdwN3hUNr/laeJTr/JtdEVDFr4rNSgbZ
         PU0V7mBGJbaX/cz+AZxTKA8m9GSO1M0hEZ9jq68you+mszNGqZBMc/+OekIy9tmVenYV
         QeKt8megnc5CMUgifrvURRsh8la0WPrmJLmTvws9JqpHo2ObQ4khvvH65JJegmXkz0Tx
         e6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724438949; x=1725043749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjEnIieOGUwavK4pNcXsBSq72pat9RqmmEPTpiExAj4=;
        b=os6ByUcNrLSDFD9Z/7hCOE4xoWKxTXX/BRsH6peojZf/pHtMDocU61Eg8YAZ4evgMr
         rVFcxOvUGK37x/kZHdeOMuKZ1A60ejHcTbFnVBnH+MU2roma9cAmeynDJ2bBp2mKt5bP
         6mozcOdAsOeaT6mQO919K68HBu9uzimOqcvByi4085+s9RY0ctZdgRmQa7esHjSMPrUw
         P5bs/nC3bQondj8kIpTCYt4EBqqF34bto6VXg4C2GUzHrC5Y++FCnMMnvTeQAoZwmXT8
         /+kA4/lSR/wFD9sKwmYjk+sjjwy2gkDRmbGbj/5YupTy8WCCNKMta5nXj0VfTT7WKq24
         GtJw==
X-Gm-Message-State: AOJu0YwBpKg6HMspuq8v24g0uQ40T17nOi3yKsdPVp1Tra9S3o48prXj
	Zs+MIEUrPc8+pnsPchxNqtmwsNbnjTgsCxxK0TFCQHU379nWYlf56nfkd2LTzhmc8IsUf50r5g7
	AYbtNm7JxHpR1YQhNBQE2nceM16c=
X-Google-Smtp-Source: AGHT+IEevkXA6tdPhM8puuk0znOTa5jll+lBCCbXHsZY82RA5sfOwf+V04nYHBVbYGuxgbU4nTAGDDw9HmTMTF7CGnY=
X-Received: by 2002:a05:600c:4f84:b0:426:6fb1:6b64 with SMTP id
 5b1f17b1804b1-42ac3899ea5mr44323475e9.7.1724438948421; Fri, 23 Aug 2024
 11:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813212424.2871455-1-amery.hung@bytedance.com> <20240813212424.2871455-6-amery.hung@bytedance.com>
In-Reply-To: <20240813212424.2871455-6-amery.hung@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Aug 2024 11:48:56 -0700
Message-ID: <CAADnVQ+JhZMzbioRGQB454i3w+M9P854du=o25-0=47PG2Jbng@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 5/5] selftests/bpf: Test bpf_kptr_xchg
 stashing into local kptr
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, Kui-Feng Lee <sinquersw@gmail.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Amery Hung <ameryhung@gmail.com>, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:24=E2=80=AFPM Amery Hung <amery.hung@bytedance.co=
m> wrote:
>
> From: Dave Marchevsky <davemarchevsky@fb.com>
>
> Test stashing both referenced kptr and local kptr into local kptrs. Then,
> test unstashing them.
>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> Acked-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>  .../selftests/bpf/progs/local_kptr_stash.c    | 30 +++++++++++++++++--
>  .../selftests/bpf/progs/task_kfunc_success.c  | 26 +++++++++++++++-
>  2 files changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools=
/testing/selftests/bpf/progs/local_kptr_stash.c
> index 75043ffc5dad..b092a72b2c9d 100644
> --- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> +++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
> @@ -8,9 +8,12 @@
>  #include "../bpf_experimental.h"
>  #include "../bpf_testmod/bpf_testmod_kfunc.h"
>
> +struct plain_local;
> +
>  struct node_data {
>         long key;
>         long data;
> +       struct plain_local __kptr * stashed_in_local_kptr;
>         struct bpf_rb_node node;
>  };

Everything looks correct and I applied the set.
The selftest sort-of covers the case where stashed_in_local_kptr
is being freed by rb_root recursive freeing,
but it doesn't really check for memory leaks.
It only checks that nothing will crash.

Please follow up with an improvement to selftest that
actually makes sure that recursive freeing of stashed kptr
correctly calls bpf_obj_free_fields->__bpf_obj_drop_impl.

The patches seem to do the right thing in terms of storing
correct btf/records in the right places,
but this is tricky, so extra tests are warranted.

