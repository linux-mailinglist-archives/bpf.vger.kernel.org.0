Return-Path: <bpf+bounces-75403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4CC82D74
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 132574E16D0
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711632F83DB;
	Mon, 24 Nov 2025 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Q/dPfP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858D0274FF5
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027861; cv=none; b=KOuX1DUF9xxp8GO7V6rEAyHjlQLKoGJ+pansNmewdFffmH/gYq5bTdzJuNXKvxPMpFXW/eYPRxifFXXPPD62/CJV75grzjJuRo3cd3e5Zo9VnKe/YwAHtU8nVkIe7ZgGiMcVnoX1zzCtgoBMQ458+qRkd5a2wC7meorxg6X6MKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027861; c=relaxed/simple;
	bh=DVw4qFRQDZZ1CpraBVhQqXiAO9C3whzWIXvi2Zo1MZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MT3c5zrlmi7VyDcVuIUBY7DXf+NZAqJ8EEnmIZdobYS8tHdSm+8+P99XlaeZBMNnyhUkZ01NHj4wJ5p8GoM7crthOCJxvfQYnEZ3Qq5U/AXeYVMTDNa8sVme+1K1HdDD+8fYItfrP6unFjyEhFMTkzAup+B7ZgSsB0CT0N78BjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1Q/dPfP; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43321629a25so18955145ab.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764027858; x=1764632658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVw4qFRQDZZ1CpraBVhQqXiAO9C3whzWIXvi2Zo1MZU=;
        b=g1Q/dPfPYqEn2iDJ4xlvIDm/CP2UkdOLVjD4ZZfm4iPbVyNEgsrj0JMu7aMYIxXjOT
         p4fbPzdIrtN0zIJVR5litBRCwG8UUqKso9wJyTCEbW7hx3lI8tZa5Sy28RJiTKbPpbXM
         BC1/aPUteC53JfcGBxnLvro3fgKlh+axo4Q1PwpWOxcCjBjW4GN5iTuQ4+hBpfJENCB2
         f7TCMZkmFxIPAtxix2lEM76dupu4ZMCzrWt3RREwUxt7SWb5u2ZyF8AUQuSivUAPddty
         ZjLI/0Q2o3V98/qWz2tlM+XUePUF+XWbVTfXFvqtTXonVp6x8R8byMp+ts+GYYz3Tu9R
         qu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764027858; x=1764632658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DVw4qFRQDZZ1CpraBVhQqXiAO9C3whzWIXvi2Zo1MZU=;
        b=HGKDSR1EsBcP+TP9Mz9Z95M/N082YgtzORTP/js/ziJMUg/IAktAMFxYwWH7Tpg8Ac
         QyHUTzxowy6PkPZd9piPUb5DeigkF4XX2hEBX9YK6f00UZwxsmpzzyC/I0wveEXIj1PX
         3CIAqnpwRjWnaYVDnNpJl2qjMMve+NOt2XNgp6YQJp21L3UJ/J3/bnPfCeeTlbzVisUp
         k/iG3vKiXmMuhtnRa2y3QSkAmYs0erCkxenjZNGf9lkgMY4SUh7GNp3FiSCIBvCmOxoC
         v9WACgV9EhjmzbzgPcDeXL3sFylIF1J2CILkxermcBN7er7c8xAjcA0nWue6bhCaFDIL
         CMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpativay+2bYT3aLqMP9J4d4yJYOhZIvrjmniiDzsFaRJSj/ySKhUnmHSqQSxhL/x+118=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGoiVdflxgAwWSizfiPJJ7D0sDEoT1rMMa7W/bETlhiwq0fg3g
	7i58UeT38uIWiFnyC7Z4DaC6HUP+mtSU3I+a9ynH6NWc4w49iJ4AyoL+0J9XO1VkfN8cFnbLiXG
	7cc+KgouZR/zF/Jxuv9wpCIZcWPuGBOU=
X-Gm-Gg: ASbGncuuiMZJmMkx91yyrkyYTuQoZT1hUDNfmc8Jy/TIasGetWcEez48wlanC9n5MMq
	HTGVKclWx0muIk7fxibLjNYAW+LBKL7Lps91KmbUvPbNl4MabHzCSjFpjE3c3K11JZbMBNoUkf6
	Wj+KxBe13fONnm6gH/I8JB6uEWXHzC683ChmYBI3rMqfaB6z4pgeWjDcCJWj+saDQO3/ffoywj/
	kt80xdN3qOzCbEB04TENM5FWa5A3Y918NSGPvFX/6cWSre+ikm7/PH4tnHRkcPEMXJtALw=
X-Google-Smtp-Source: AGHT+IHeGZlUiSq+0eHau7ANqz8fU8Cx36q0FOMYU0Dj/ajvYhWyZhQEtQk4bEZKainAT2wg4zsuz9wwgqWDUaR0gTI=
X-Received: by 2002:a05:6e02:1986:b0:435:a467:b324 with SMTP id
 e9e14a558f8ab-435b9862f5bmr106020245ab.17.1764027858649; Mon, 24 Nov 2025
 15:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124080858.89593-1-kerneljasonxing@gmail.com>
 <20251124080858.89593-3-kerneljasonxing@gmail.com> <aSStkfeUrYRAKZeQ@boxer>
In-Reply-To: <aSStkfeUrYRAKZeQ@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Nov 2025 07:43:42 +0800
X-Gm-Features: AWmQ_bmp_HfOZky6LJApZqlc-2Wz6Qx6wDGYUvB-gpaHTxZraovxAfZTNIriaSk
Message-ID: <CAL+tcoD0Y=ChSuPfm3K_qRQo9h8eBGVnCi74usTEi8mBmeB_OA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] xsk: add the atomic parameter around cq in
 generic path
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:10=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Nov 24, 2025 at 04:08:57PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > No functional changes here. Add a new parameter as a prep to help
> > completion queue in copy mode convert into atomic type in the rest of
> > this series. The patch also keeps the unified interface.
>
> Jason,
>
> anything used in ZC should not get a penalty from changes developed to
> improve copy mode. I'd rather suggest separate functions rather than
> branches within shared routines.

Sure thing:) Will change that.

Thanks,
Jason

