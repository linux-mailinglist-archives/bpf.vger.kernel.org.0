Return-Path: <bpf+bounces-35298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D632939772
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D311C219BE
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648E1BDCD;
	Tue, 23 Jul 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgTLetyK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9C14A81
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694441; cv=none; b=HvIo6z/y4R9zNFfdVz6fi8CZMzrNzzi+oKVS0MLzNcPqdpIkVTl3g2nnU+Z6CrlVs3EO6U7DREI+zVjvkUrrCZhz7xHACassFHmFV4YSaE3lLyvbL1h9UqYn2GSDdhKpZ6n4QINnQzmH4D89JpbPh22iOQydK9uCvuK/ONCh9/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694441; c=relaxed/simple;
	bh=Nnlu14QaWlE1lY/UEIxMwUanBJxZTc7UEfUxePj7sIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7E30lR3sae2pqbQkU8JPphK6+Cod/XTupG/7brQf1C9bi+ZPZPsdDqDi4Kd+imleCVD96LinUiok/BI3+ijZoi35VDor4PpvEA1NU3jncYM0lLUSA4hh98GqaNEHb61cP6MBCseOawStriZUZnRICAi11wHzi4UPk7wf6cr+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgTLetyK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so42350315e9.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 17:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721694438; x=1722299238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCj+oRyfVMEddg0kOofVmpzkaQEEt97Gu96Hx8p4crc=;
        b=HgTLetyKYJsH1+byuIUT3Mb5iywygE715c1McJSQREEuRKw6isuNbasQckrzRGoxL5
         pdSRJHLibohmL/6PuxO11YqSwhvGWAwupsTFUsAezt2FFk9nByHafYw4YNGzMGZh5hST
         mzDbmrhXJwlPw4i5mLCzEe7xu5CpGfb7Qv213ckqIzmbAFy70n9iBYst9w1/i24RIMjf
         We8NPK+NKFe1lCaajh+AiM3Q08OQ8wi4Ql0bgv2YmV4zpHKf+WdqvMkGIP/OjQWTOGlF
         yqFHFDl0sa/neZV5kh7oB3ReUilKQGkkSu3otPWeRWdLz+Hkcun3yGr7NtLtFy+/sNuO
         gQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721694438; x=1722299238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCj+oRyfVMEddg0kOofVmpzkaQEEt97Gu96Hx8p4crc=;
        b=pWO3K/6aWzXa6wb3EkE7m1fIBygem2OsrG3jiCHgtBWDOZV9VgGaKk1RBITn5T08VP
         DESMGQj4F2GzEZ+feSvUU0ladk3LM996BAfELwpVc6RvXfSIzcM83UvQkId+9YJvNr34
         whkAEQMOD3ceMSYZMs/oTGTJlS6arHWJCNgmOiv1TpyolWvs3bHk6DeaChuaQOTjsI4N
         cmcbu18+dbncjwWgUcLF90OAtFCfKgTkR7CYmwwqeAhr6ePDVgGE10JWl04TfgodjnHt
         WjdgoW9Un6zA5sB3azAMttMmacOuyL9L28thJ/BzBNYMJj6ou9NwUBzBiSGeaWtV4X04
         rFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5O0IoA4nn/u0QIeF8/4/ZOMA1lcMmrIMt0x7E0CEVCfp9xC98NfIwklITXDDqIMgDCDzgs7AYP+puCSpB70M1c2j+
X-Gm-Message-State: AOJu0YxkCIY25eIQcaekBA2SVZ6lu4qxC8ATnC5zl9D8tD30AlDd7DEH
	UyMjCGq3csCmeX80hBbd6cauUbE3Gr+IIUWd6FnnueQiiqhfryT+yk8IvhLXOOAApZWIAyHRtRv
	pgglK9XOxlw/16Qfphhrlh/MGbx8=
X-Google-Smtp-Source: AGHT+IFN+VJy4EgYm+MbLdntOsWoLrf1G9xCEWJL8W6+FOvCeV6m2sTYrRqZ60pxP7Y+M4lIT3+eLHHUtv+26hhXa7c=
X-Received: by 2002:a05:6000:ad1:b0:367:90cc:fe8b with SMTP id
 ffacd0b85a97d-369bae4cfcemr7093171f8f.27.1721694437424; Mon, 22 Jul 2024
 17:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEYO4R+m+SpVc2gNj_x31R6fo1uJvj2bK2YS1P09GWT6kQ@mail.gmail.com>
In-Reply-To: <CAPPBnEYO4R+m+SpVc2gNj_x31R6fo1uJvj2bK2YS1P09GWT6kQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 17:27:06 -0700
Message-ID: <CAADnVQJad1uWLh7uN47qYv9eBQZgo_PMP8s30Ae49dsqtGU40w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/bpf_lru_list: make bpf_percpu_lru_pop_free
 safe in NMI
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Hsin-Wei Hung <hsinweih@uci.edu>, Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 6:44=E2=80=AFPM Priya Bala Govindasamy <pgovind2@uc=
i.edu> wrote:
>
> bpf_percpu_lru_pop_free uses raw_spin_lock_irqsave. This function is
> used by htab_percpu_lru_map_update_elem() which can be called from an
> NMI. A deadlock can happen if a bpf program holding the lock is
> interrupted by the same program in NMI. Use raw_spin_trylock_irqsave if
> in NMI.

And there is a htab_lock_bucket() protection and bpf prog
recursion protection logic that should prevent such deadlock.

Pls share the splat if this deadlock is real.

> -       raw_spin_lock_irqsave(&l->lock, flags);
> +       if (in_nmi()) {
> +               if (!raw_spin_trylock_irqsave(&l->lock, flags))
> +                       return NULL;
> +       } else {
> +               raw_spin_lock_irqsave(&l->lock, flags);
> +       }

We cannot do this, since it will make map behavior 'random'.
There are lots of other raw_spin_lock_irqsave() in that file.
Somehow they're not deadlocking?

pw-bot: cr

