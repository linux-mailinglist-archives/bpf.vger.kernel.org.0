Return-Path: <bpf+bounces-28381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2CD8B8EBA
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FC01F217DC
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC017548;
	Wed,  1 May 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky1/gGMx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DF11CAB
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583050; cv=none; b=prYo6OVUz9gkOMtFGZJwagIQOraEbnrjbXJ6eeyqCmkpyr8UwEVlrTwwC58fLMJYwUfEO0vldyQKBUwdNAm0biErg47VMbwHcunlLI1mTYRX4JB7dNsB+FHsgUzKkhWA5PpS6Q2zI9c3UNa10RxKluDSJSoDYCoBHT8Mmd+uSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583050; c=relaxed/simple;
	bh=bod+a9SXQigFO9yfPO1ocBQDxIaFDCdfchUVh0+n9Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNNVsAqtcr4aHZhCWVXmHTAwom+BXoAuniDOxijlBn21F02DND09F/hEeLUj8Gxl7DWsXakOG0YgGCBcxAjY/Wk1ztCMryK95K5fJD+8JMHLzelf7+Q434CDxSytlOLUGlKUothpTh/KCcBvyo2eFqDMhcXvJnlkBGlvSPu70DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky1/gGMx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b239b5fedaso2291848a91.0
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714583048; x=1715187848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umwnRDARfhfaoXnNGS4PJ79T7/j7jwcYGd/k7xTzkT4=;
        b=Ky1/gGMxYyMHFWGCgPc81xdRhiQl/dpdsWXxsxaoDrKbYwrsR6kvKcn+J/KKdkaAi2
         n8ZyWSjrklnPiuQMIuaGL3Mc2nEBCGwjSMQAO0yEU+tfE0Q1iHTv4Ee1ZV4+RJARKSQc
         Iu3vEbptHuT6k6d7lCwZDV2pHHQrzy5YkvVKre48jZ0A6EeNwtfKb2SfEGscZCnPYBuN
         wLafZ88Xe84yRYPYm+7qs16gY2nmL1QtRNTrz/2xeMt6hv8ItybldY8H19tCcrBwYihc
         Jnag4Ko32/RcLgTmuvzqWy9jzSiWjtMSYhELAsfVNwcetrWSmlWQ60xSa1/NjiDbJ7IF
         g6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714583048; x=1715187848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umwnRDARfhfaoXnNGS4PJ79T7/j7jwcYGd/k7xTzkT4=;
        b=sUZKH7CKjdK2IVHRquI7iD+vdfSXGHmrf1VTG2VMRSnAmDhD8XVwHJ3VMmUDbkTR6u
         qP8DBnCFWrfR8Uyi4lzCSJnWFfatTeCp8X/FaRpSy2z0L0CNa2NM0uVd4ZeHpwL8aJ4p
         Vd7WR2tDLjMkIIXkm4Cz2+UZRfRbgrQ8/N1Mb4Qb8iQEuoSzQMKSn0plmH8eRrUyunBh
         AwO/0PKBRmqnOKwg6Nk0i2nXCBueLirNyLMtLWNqdGWqcLFQ7n91olv4xYUFZlUeHkJq
         PZzNcIeHjR6oHktpDbZjxeDYFZNS2vnR/H6acLii715qHtI6k8ucuOJpZEcdc/UzpcQl
         puVg==
X-Gm-Message-State: AOJu0Yw/46+G8HSqQGpm+wAnEb/Dif/iRfcWZORBZivAzJLiOYuvIGYL
	S5YYEsLZlN5JvjizPiGlRCBYUXskkKw71v1hYWU7YzTLki4vmS9HPDJM/bpLUCCBYrYQJQR9aoL
	MJbpX0PzxA5ZzRcP9b0+8s6HJZ6w=
X-Google-Smtp-Source: AGHT+IF8trU2aG57IdQeGKZlq0isQ97tmnLLsRMvl9gExK9m44L9PFFK/KMzsmvACJyfL26ujd3UOzMppJIt0u7nU0Y=
X-Received: by 2002:a17:90b:4f4e:b0:2ad:e004:76e6 with SMTP id
 pj14-20020a17090b4f4e00b002ade00476e6mr2854103pjb.7.1714583048062; Wed, 01
 May 2024 10:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429213609.487820-1-thinker.li@gmail.com> <20240429213609.487820-6-thinker.li@gmail.com>
In-Reply-To: <20240429213609.487820-6-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 May 2024 10:03:56 -0700
Message-ID: <CAEf4BzacheKXJRfnDimQYhqQzhPcMD9TEZBaT9mFqqKFK2B0BA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: support epoll from bpf struct_ops links.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:36=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> Add epoll support to bpf struct_ops links to trigger EPOLLHUP event upon
> detachment.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/linux/bpf.h         |  2 ++
>  kernel/bpf/bpf_struct_ops.c | 14 ++++++++++++++
>  kernel/bpf/syscall.c        | 15 +++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eeeed4b1bd32..a4550b927352 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1574,6 +1574,7 @@ struct bpf_link {
>         const struct bpf_link_ops *ops;
>         struct bpf_prog *prog;
>         struct work_struct work;
> +       wait_queue_head_t wait_hup;

let's keep it struct_ops-specific, there is no need to pay for this
for all existing BPF link types. We can always generalize later, if
necessary.

pw-bot: cr


>  };
>
>  struct bpf_link_ops {
> @@ -1587,6 +1588,7 @@ struct bpf_link_ops {
>                               struct bpf_link_info *info);
>         int (*update_map)(struct bpf_link *link, struct bpf_map *new_map,
>                           struct bpf_map *old_map);
> +       __poll_t (*poll)(struct file *file, struct poll_table_struct *pts=
);
>  };
>
>  struct bpf_tramp_link {

[...]

