Return-Path: <bpf+bounces-64946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4182B18A02
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 03:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84911C848AE
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 01:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240082866;
	Sat,  2 Aug 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDCRLbWa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AE42AA1
	for <bpf@vger.kernel.org>; Sat,  2 Aug 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754096402; cv=none; b=hg/KDNguL3VMQ9nHgXJ/j3L3deSUIFSVzew6SYnmy/YjTId7MFLBQ/1cOwXphdp1ZmMTvR5C9mkgjkxuPPp/yOWB3hhu4HgJLHl5H2WTR2OL4J/B/ouDFnEjfNJFpu8MUYWplUjbtDmap9V2AP48ldzCnGZpEwpTgKkKGm4I3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754096402; c=relaxed/simple;
	bh=ovlKYORNEhqvNIPiAWK1BCd2oFByUESH40iWmDCJKhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II56yLuU3tJDKpaDbNcsYSTspCQR0LU8FYGrqwWuguGji/I3riJu3jEszjy+qTE30xBu80UlGNjhEuA96nqYXApWaMMhi/kcU8/5dYcwyRRaASrfsUniBxTSqeazKR4S91W3LlbGxwzBs1e4cJ6hchhiZKFttQEico7/p2tCByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDCRLbWa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4560d176f97so15496665e9.0
        for <bpf@vger.kernel.org>; Fri, 01 Aug 2025 18:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754096399; x=1754701199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovlKYORNEhqvNIPiAWK1BCd2oFByUESH40iWmDCJKhE=;
        b=CDCRLbWaK8WqYxT9mLMmkEDSdu3THEs6XrefhTlOKyv5c0jMTDncCQzpvTvi9l0XQS
         Ws86Qd+U1DipicxH7H1BJxb8YAZJYvPbBrAci7J2jssIocuZ0RWxw6TAKAT6ZU2Kr+Lv
         pxyEmWFnZEeAQ2kg6OaQKJh24U8LAaO9DwXMF95Ko2/kmSOy9iY0azAzOsUFjAaRPMQ8
         aZVW9zTkRkS0xCR9eLxa60cQddcqljP2z2azwinmvSZXpgzJvEk8gcfic2cPoxd2khPJ
         ubf0iD5FEroD520ezlHCL/jWfJThkvC3a+JIv2diy6rb8FeSEURhN1xQJC/sx2DEMcgC
         SZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754096399; x=1754701199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovlKYORNEhqvNIPiAWK1BCd2oFByUESH40iWmDCJKhE=;
        b=Xuhu3Y08cG7wUQZVh3XYjJlzqyLIU+nTY9AqeMFQgOqugWvvRHtXIZJCTkOUlEjFt+
         q2VNNfYmRYl1Sm+LXy8eMS3V/mPBiucYiYgWIsTe22Ynm9ywTscAjnCsrL+SagWkzcZb
         bu75hvqHd9kJKe19KFmZf2e9GRY05FV+YzlgdRWxuBZK6UfsgXwrbtO/8wvYbOgyjjG5
         XQh6nOtQQG+HTJZOptfAmO0X6uGdYTr6rHMFp8JiwcPkB6XP/SQ2COK5QgKRAMWSPWMp
         Z/buDeO8zsC86XYGwNgQF4A5HBvp7misc/nSZOkaCXLl7G8C3we6kgb0kwlOzPZxFkPb
         mGuQ==
X-Gm-Message-State: AOJu0YwZ3Dg8LN1JF6lS32785dla0nFE7uO9muLfs73vSvQffPAC02Ow
	s3fkOL0QsYn8PuVJu1fgvdXmsx0GjaeZkMmxbScai+rIOnIzItL1LMS1oxRBpFvV82cq+Kmsit2
	RcaVuZdxRpy0KwHAnKOhcIC5eRCc37zI=
X-Gm-Gg: ASbGncujgCcqVByvRdIC+dEZecHA6BIPbw8xkYoIce5qFgHH4mkEplLv2ONBqhFiuAg
	YQxjlYfNfHkGXY2reWVP1UycPswTcRtpIYIRmNq0Md5Q7mt0FDM9pxVgNjeK8V+1U2hAAFyKz55
	edk4MNW/OxrBdZtop7etdXF6+4JcfN28Qbj3qBc3pNWih+ohUJJpNfeend7DE+1IxyeRb7RBHQf
	sH3aDqFIoxlzgiL/0+KragGO5ZGGnK7HGmH
X-Google-Smtp-Source: AGHT+IEh5tBb6Tw9bXFg2OnNQWItP8temluXvgsAWSACuDvgZqu+c8y5IACNawZLEZnC/K60OyN0ucq0BVXfdrP999c=
X-Received: by 2002:a05:600c:1e87:b0:458:b01c:9d with SMTP id
 5b1f17b1804b1-458b69dec92mr7960295e9.11.1754096399257; Fri, 01 Aug 2025
 17:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801232330.1800436-1-eddyz87@gmail.com>
In-Reply-To: <20250801232330.1800436-1-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Aug 2025 17:59:48 -0700
X-Gm-Features: Ac12FXw54qO6tH9wlmzs0w_NEvrNN5w7byKJx7BhY03FqTw3DHUXF_j78Han-eo
Message-ID: <CAADnVQK+NG=sTdxfDgAj3Pjs68dbc0-wRRFa12P3FsdzFr+W5Q@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: correctly free bpf_scc_info objects
 referenced in env->scc_info
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 4:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> env->scc_info array contains references to bpf_scc_info objects
> allocated lazily in verifier.c:scc_visit_alloc().
> env->scc_cnt was supposed to track env->scc_info array size
> in order to free referenced objects in verifier.c:free_states().
> Initialization of env->scc_cnt was omitted in
> verifier.c:compute_scc(), which is fixed by this commit.

Applied to bpf tree and slightly reworded above commit
log and subject to use imperative language.

