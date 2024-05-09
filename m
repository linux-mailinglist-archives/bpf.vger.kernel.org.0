Return-Path: <bpf+bounces-29323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760348C18A0
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77371C22178
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5689F8595F;
	Thu,  9 May 2024 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaIAdscb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E585653
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291353; cv=none; b=KynZmvMG9GSavSxOBVPcPoHq7N2uuQxYvLbtDGxs0ytKyyK8Sgt06DKUT9YnAwj68oWZ/BdGXFvYN9WqHmZ4/S1FuZjsKai7LuH/1JZkMxpdnHMxqwun8WgdtYWj39DWZP7rb0VT8xRayVN/XthEpsop6//42l+w7cnYhL/OdqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291353; c=relaxed/simple;
	bh=2kSlUOnRmiyl9I2WeYhnlvlbU7+WoxAsRqrhU2dfpP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Stk221F4HgpAJToHLCjltlBSO2R+7k+4ySiP1oo8DwhXrQuwdx4iGqQXdmMrBhTw8CJATxUQ5VY0wqr6yZNcU14YYghKdQobgjUy6hpJGwajSlV+t+pSPcD2ZloYUqQkPBk7tAbIVLqMUoYAQkywZWePHFMRoE+NEAEA/+mSmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaIAdscb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b79450f78so8787665e9.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715291350; x=1715896150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt8ELTxs7gZoCJlDuM/tMkXITIbgBbqUJJXVHh9YZOk=;
        b=GaIAdscbftoE3co3YLqoKGO1gBiswlEiHfL81htOvaxUEaLBnmh2UXDTvppmUIbLAE
         SlnjgvEooxic32izKdfuxeNIY7NjmU5SSHK5cRAEGHt9OZK8P5WdmVC4tV7o2NXwB2x6
         awgXLh/bhL2IVJggrR3rORTleOe8KhUDNk6+GWJGbbcRVM0fDuXuY87RH5nH77dp+K5S
         No2YmPEDgk6sWL7aOReGcRKKOSbT1GBu/cuOT2VVRN2ypsBKZdNP/2Xy6Kk0oSKQcYWV
         w4Q6sHo4H7aZAGGeANSgcHxqeisKR6KxpRew8ari1QPN9bQmj0lO+2cOHE6yfu6Kx82X
         zC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715291350; x=1715896150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nt8ELTxs7gZoCJlDuM/tMkXITIbgBbqUJJXVHh9YZOk=;
        b=MkbnpWVbcw7IhbtrqVVeIllYUpbOvrUWDk9F/RxM3w8mKSRwbdSYpyh4Eq55o3nWIp
         mAZAsPfTiReTkR7tC5yorNkoijF648Qip6lS1V5HDFrM3XySLdnJw1BgJ+EqCmgASvwt
         QZ4+5Iq976L7ZWROpDZCX+1Vv4vDMBo38bU1mV93WL9dFdXRejO6ibdhRtVYVvuHLBcc
         MxFXza4bMpuSMkiCXCuHxqsjzxFn0kI1v61+6aJAh0uNf6IqeJ8AwnPxyVZYL9y/XnUO
         BJ69hOKPk8xUpMvHUzaIXPP+2S5XD+IDP3v/POeKXxlgzxd5rowKZ3Is928+RnLh5AoB
         g/Qw==
X-Gm-Message-State: AOJu0YyK1DyIm8wzgbswc8KtXow2OxSZGHCXPHrVK8DL4nPxlaLieQOM
	KkoAVszAh/E94P423p7fZ+YctNMXmG9GoWmFtqgHQybNSAgHibmjb/Al3yBoes5wuZIFpIMLFQg
	fyJ+zuhwL/uCzT2U9cGG4DtOhEyg=
X-Google-Smtp-Source: AGHT+IGyC6QcTxEowEB/rZt2rBtCooP4Q5MD0C5RY5pg/dCQg8O5ZZsb0+tK90l75VYcSKsruaKg285y8iqGrr79wes=
X-Received: by 2002:adf:fe88:0:b0:34e:27f0:e48 with SMTP id
 ffacd0b85a97d-3504a96aa1dmr593608f8f.58.1715291350334; Thu, 09 May 2024
 14:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509084650.17546-1-jose.marchesi@oracle.com>
In-Reply-To: <20240509084650.17546-1-jose.marchesi@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 May 2024 14:48:58 -0700
Message-ID: <CAADnVQJRpCX+vmwCu3xYz+V4Bq1gn3vnCAZk3CAJcB3KUq_-Cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make list_for_each_entry portable
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, David Faust <david.faust@oracle.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:47=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
> +/* A `break' executed in the head of a `for' loop statement is bound
> +   to the current loop in clang, but it is bound to the enclosing loop
> +   in GCC.  Note both compilers optimize the outer loop out with -O1
> +   and higher.  This macro shall be used to annotate any loop that
> +   uses cond_break within its header.  */
> +#ifdef __clang__
> +#define __compat_break
> +#else
> +#define __compat_break for (int __control =3D 1; __control; --__control)
> +#endif
..
> +       __compat_break
>         for (i =3D zero; i < cnt; cond_break, i++) {
>                 struct elem __arena *n =3D bpf_alloc(sizeof(*n));

This is too ugly. It ruins the readability of the code.
Let's introduce can_loop macro similar to cond_break
that returns 0 or 1 instead of break/continue and use it as:

        for (i =3D zero; i < cnt && can_loop; i++) {

pw-bot: cr

