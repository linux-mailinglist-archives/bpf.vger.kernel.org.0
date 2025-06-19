Return-Path: <bpf+bounces-61108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D91AE0C31
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 19:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CF61BC2DEE
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E728CF64;
	Thu, 19 Jun 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+T2XnIj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB219D8BE
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355874; cv=none; b=ValHEwdoUOrRHyWhAg/R41OA92PZ/NB+fELxRKF3oht7Hs52DfQbH1djTnCQUSFRSxxKJc+4DunY0dmu4SVI07u/7KyrS8X+VTlDOLzxkNm8Rs91N5WBJc3QxXPWE75A7J/H5ohiqaxDooYvKA9pmUBhyEQWgFP3ImljVtxueog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355874; c=relaxed/simple;
	bh=dcU5fEhqY2C200VafBKRx4av0pROk6AFiylLqFTPBew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JusyHuA128fO5pk+lZPz2q80f9Tx76eXw/stSuq2JiGCRo6YUCzrisu/giIAXDOxTzkFF6Up1THBVu3CuidQ7h7JE4ZhXH5HMmaSdCxeS5yLy7SVo1RGuFSooUHB9NXbzzDuc10HypfemeND07V8jvkVIanatZUlSX67E2GbFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+T2XnIj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fba9f962so752122b3a.0
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750355872; x=1750960672; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9fJa/iwEnHTefe+FjV9d/TgK8h0bV9NtUY/oVjbEZZ8=;
        b=X+T2XnIjvXWJDapOiKkimldh4p65yH0PcATTpVQAp6l7Plw+NEDqdxnjl7YsoSNLSO
         S3PToeqM1hIftC9Bf334ls8EGS+j6GE5YC2wifHcZNZgRjF7oCSbCHYEkxKLrwXD0v4F
         ++OS+Rjgm+LPz5rTmWX8MBKr8lxjPF8Th9urK8Yt7j0t4OOl53VGqCeKzShQ0h8rvEtM
         AwosHldSThBGUGZt1e/pSgtKW4MvYYe7otDau/t20dqikiCUlGtCoWrQa29mbw4ZHBNO
         JztKOv5L+rQiTDb0ufjqrjx2TqX5pu5RJzfubN3BUDGKWGvOJPbUza4E6EGfz21MZcim
         ZwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750355872; x=1750960672;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fJa/iwEnHTefe+FjV9d/TgK8h0bV9NtUY/oVjbEZZ8=;
        b=LdgvTaFWC1NS5oJ+yVBE2QAh8+lzAtRMyJ/M9PluahD5kISBZteAnvZx5SMNkPbW53
         GppAXoReGx0+rT0HuTvnK0kKBnvG+ADp1YG4oo+5UX9/tGztLJsCN4hsK3YCN5mbcYNh
         9FYVKYEsUl6oYp3PiGMF10fhD1BzhR3SlIxc+w9cj8Qjiu0jSj53ZdWYcSXIIz5MZdca
         70mkS1syyah7/PexQHHWe4y0bf7F5GPghMUKY+EiloP70hfyQtfF8bcOgyyN9SKVsVzJ
         aMBLOCddxzm+LEq0blzCArtk/pe43pXmdsIt+/VhlakBDqZKnlf4ciZknCaKVXAxIa0J
         f6kQ==
X-Gm-Message-State: AOJu0YwamiX0E/mdFW78uZT6jOxXJMzhsOzCuRN2pzyde5QGq7EhEyed
	EspK2msLXFktgbGHxm2wRWGBhyZ96dtYWq33mhT2O37+Vd0tcnqMP0+Z
X-Gm-Gg: ASbGncteWXoPDq3fTXeOdeNrgwIi4BUlqOr54WwYLmsuHN9B3IUiGXHQV0IoNZtuL9I
	ldxTIs4WBrX7l4aa3KrelamERNR985t9ry8mN3zP+i4RUak41F9J8wVNLAhO9+rQEz2ZdCuF7Fc
	dAipNLaVPBHNhx1kpVf+1bBvBJPSNAEON/b5yh6SAY65H0e2DQ0vbFxF6jCDBXk9VNv5Zh56jBS
	9q6WEO83HsMVQFtUeqN/dB/9L9KyoG1cbULz6K9/6NiYOMO1vTvSb2GupTcRJkVYjctpzfzCpZ5
	xn8eOlc1Q30lE34h8Q0tfnbVt5IRsgW6rgkC90sQsw7QGDTICZuAdd95qA==
X-Google-Smtp-Source: AGHT+IEY8yNPENTopHSM4ho79NgHb6jJ36aL1OT4QHbW+WYnTwIcOlXyPFUMWe+5TAJgn19TgqCfEQ==
X-Received: by 2002:a05:6a00:4791:b0:746:1d29:5892 with SMTP id d2e1a72fcca58-748f77c0787mr4954347b3a.4.1750355872474;
        Thu, 19 Jun 2025 10:57:52 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a46ace8sm341594b3a.24.2025.06.19.10.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 10:57:52 -0700 (PDT)
Message-ID: <50c2f252620107b6fa6642e281a91db444b032c5.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 mykolal@fb.com, 	kernel-team@meta.com
Date: Thu, 19 Jun 2025 10:57:50 -0700
In-Reply-To: <7e7e4056-e2b8-41a5-a6b2-a2fbe0a94f4c@linux.dev>
References: <20250618223310.3684760-1-isolodrai@meta.com>
	 <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
	 <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev>
	 <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
	 <7e7e4056-e2b8-41a5-a6b2-a2fbe0a94f4c@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-19 at 10:55 -0700, Ihor Solodrai wrote:

[...]

> > I think Mykyta has kernel/trace/bpf_trace.c:__bpf_dynptr_copy_str() in =
mind.
>=20
> Thanks for the pointer. So it looks like memset can use
> bpf_dynptr_slice_rdwr() to handle xdp/skb cases. Something like:
>=20
>      void *ptr =3D bpf_dynptr_slice_rdwr(&dynptr, 0, buffer, sizeof(buffe=
r));
>      if (!ptr)
>          return -EINVAL;
>=20
>      memset(ptr, val, n);
>=20
>      if (ptr =3D=3D buffer)
>          bpf_dynptr_write(&dynptr, 0, buffer, sizeof(buffer), 0);
>=20
>=20

I think so. In a loop.


