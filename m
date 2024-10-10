Return-Path: <bpf+bounces-41612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77E9991A6
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497A61F2513A
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0491FAC2C;
	Thu, 10 Oct 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ0Ze2f6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376831E7C13
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586478; cv=none; b=MwHhh8Q7dTF3pt7ah9ob6JTHYSXodzwkSZ+cr2FZ933pXJW04w/E83GRQ+4DKdxp0VL6sfgTybc9nsRY7bEMah2HDUomC2kMTTGULTbPBGxbYGD6UuFDt3SDHdh8giepIviRU63KVXE5IomJNzQtdwLz9rSn9LND6I1yzMJGQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586478; c=relaxed/simple;
	bh=DC3kCIufk8Kmo3ZTaEPYo5cFXN87dayfuWHsvUuZHmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUpnDOCSMQoXuvusJK3ZreKV72XRY6yJT4jA1VKf4s/4h7cPC9D5OQF1FUbbBU7khqjZIzfMTpWN7c+DjHz+bnJZmxuCiL07Th6FpSTZD7c6pmdfYF56OOB/Dc+toTwYou6UaS0vqtZMOeYA07bKqn4UGe+WT7fXoK2OFeAC1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ0Ze2f6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431160cdbd0so7915635e9.1
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728586475; x=1729191275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/tfv4l0bC8nk33GvovCVQF7z/yeb6nz7m8RBujAGaU=;
        b=DJ0Ze2f6VYgy2y50cATJWfCfhyhsFHREwGc0hM8+5sxuOP4ZlA+9N5u9FH2eXB73Qo
         SymwDLPKSgLANkyhMvnQcvglWO67UbydiVgwCNLhgtzR9ID/2fSivsQWYD4yO2Wjnvsx
         0TJnH5UqICSGYTX9KTtvp5oh2F1NbDu/KPVl1TdSTpALutI45jUb3iW8JaetGI9cqBTZ
         tuSmtLofuLOrkkOjFgfQ8DLxu1x6XGXZvq14+J243l7W1GIY1bfoCTtkMtTmzFiwGO41
         MozhJKzB9M528xSNGyiCryHGOutRVgwUTy/4HEHm36LeWNDnIKGsfvcYyR7czStpDRy1
         L87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728586475; x=1729191275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/tfv4l0bC8nk33GvovCVQF7z/yeb6nz7m8RBujAGaU=;
        b=UVyJatow2rJBvta2Bk7+R1gM3sVPQ4kwgvwaBiBYMAsYkMbyxds7M8bFDmrq2UXSDs
         uUGZ+oI9W9Zd+KYa9P4HG29SWH01b+PNRhjw3V7kplWcczIIjAilLtHwjN1/Mirwcsea
         0v/ZpEW8agKvv0zTpN6QJP5xtPJc6SLilcGsXagZTUwth2n4BGt+1fohVbIMWdFC+/O2
         8p6OLy8e3ZVxCP3cvkr7hXyIC3K3Ex2x8Idy+mxejwaq5La5SfW7ytty6poMWqwuIv3l
         1F8FUkZD2TPULn+Fqy+loAxyVxFmoo2OLKwyTaxBu3yZVeCs9vOrXAMzKwjjYAg705qh
         tJyw==
X-Gm-Message-State: AOJu0YzF3bHtVwckHmI4yzzQtAPLDf7ligXj+PHKZ7dWAaTtWl1Ro8DJ
	xDT0flqAdLiBU5fbKzX7iuXGcJxc+dTN7raNGKkflYyK42tznsUhy1G0orJMtHmUoBUJ5V10066
	3wMKHkML+epFoPPRQlFW4pVlN2Y56WoOC
X-Google-Smtp-Source: AGHT+IFVbK2MIkTIkCzBZOOs7cUM9tt6Fbyvn4Ma54k71V0e38hLl1EgIlpRSX9jhgHFX9xBtlIS9nKYR2keFnl0gus=
X-Received: by 2002:a05:6000:12c5:b0:37d:4706:f721 with SMTP id
 ffacd0b85a97d-37d552d2c64mr132928f8f.27.1728586475462; Thu, 10 Oct 2024
 11:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010184556.985660-1-martin.kelly@crowdstrike.com>
In-Reply-To: <20241010184556.985660-1-martin.kelly@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 11:54:24 -0700
Message-ID: <CAADnVQ+=eb7V6EYYZXghOCqYHcuP4=uNL2DtVghK-7WOHJa0Jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: update docs on CONFIG_FUNCTION_ERROR_INJECTION
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:47=E2=80=AFAM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> The documentation says CONFIG_FUNCTION_ERROR_INJECTION is supported only
> on x86. This was presumably true at the time of writing, but it's now
> supported on many other architectures too, so drop the part of the
> statement mentioning x86.
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  include/uapi/linux/bpf.h       | 3 +--
>  tools/include/uapi/linux/bpf.h | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 8ab4d8184b9d..a2ddfc8c8ed9 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3105,8 +3105,7 @@ union bpf_attr {
>   *             **ALLOW_ERROR_INJECTION** in the kernel code.
>   *
>   *             Also, the helper is only available for the architectures =
having
> - *             the CONFIG_FUNCTION_ERROR_INJECTION option. As of this wr=
iting,
> - *             x86 architecture is the only one to support this feature.
> + *             the CONFIG_FUNCTION_ERROR_INJECTION option.

Something like this is good to add to
Documentation/fault-injection/fault-injection.rst
and may be a link to it somewhere in Documentation/bpf/.

But uapi/bpf.h is not such place.

pw-bot: cr

