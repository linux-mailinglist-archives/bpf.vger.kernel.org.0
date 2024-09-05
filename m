Return-Path: <bpf+bounces-39052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D696E222
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AE41F2536E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C3F186608;
	Thu,  5 Sep 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec2nDvy5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7C17BA5
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561622; cv=none; b=ARN+eOPlzhVVn3jC1CGUOouXK5MIhC6HE9UiijTUWyxE5uTMUgK3Cudw/hf8SFOLM7tr9owsH4y9fy4k3PN2ePWGgJKV1QSw0Ox5ooQP+ODV2rBn3A2dP/Q/Ygl3UUhubt7/0dY5JaDntGegLYAtTmlU2T5AorN694NRQqmu0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561622; c=relaxed/simple;
	bh=3Yto6cdnaD2ro9NzN5nrhtdjaCvbe1zTM5uoOJ2nwmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brv80kZYqKwaWZeInYccsEu1h63eAV9/P1Y1gpcixDWJ9yM2qFD6OBbxfI8m/h7WXkDDNypZUMlY3AhBF4w7gMKlPbFEha2D9veoZ5yNiTCYXI9uSkNAYEsQh8DGHReF6ze/BRiethZz2KoSzlIZj4DU/glFp7NlXSHpbIi3atM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec2nDvy5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso1942664e87.2
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725561618; x=1726166418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Yto6cdnaD2ro9NzN5nrhtdjaCvbe1zTM5uoOJ2nwmY=;
        b=Ec2nDvy5j5Hcr+LkLaE9I1P7UyYsees6QFlreJtKQ2nqq8LxvLlhaIuBmEoeR3ZPE9
         c8eQtImqSQOiTf3d0pVr2ATU0xw9Uxi5cZVXYEyVH3nubGiQSArjZPl2I/ELLEJBBgMu
         TJh8oXM3EhqqjCGj7XYXqT8yPJy1qIStLV1o1goLHSdDy977IAvJ29x9PlRDm3QSuhvz
         RNJ2j9/SnXVd9bmmi5JbtwnEetlFoz1ZthWPnWx/D8EiPXNpvUQTVUY51I7IPzDkH9Wi
         aG0csugJ0wsgfijKDBzlQ9XMQcGsdLOxRWn29eIzoZEbqcnBi6nPqzjUksBvFrKQDt/7
         soZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725561618; x=1726166418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Yto6cdnaD2ro9NzN5nrhtdjaCvbe1zTM5uoOJ2nwmY=;
        b=epvh3yf+J/rwuXrEZPIq0PskICO6C2GjYSUlE7833oB/1LYBXzYT6CCjGPj31YpG9M
         lWXPh5l4oX0bYu7A7XeXnU66j0xqMYUQFhxKUFEn6TfOB3JEuf/cIvlMJtpIGUubpjrs
         1IkwMRc8Nq+5tN0TNFCfimK9+ZYmQdUXIAir5upUp+eRi0f46p5EP528LZOe1EHoGCW5
         5ennJgZZcZXKb/OQA6tJMSgkZRpFNvF2sei2iRl2y8s7nNIqtOI/kt1tlRNLxuNZSkjm
         ZUUyMqiuPHBTiWTi4euIQc2SZ79VRCQctwFUorMrrjOnYyNr6ZmJie8O0GvdU+wqjQAX
         jJJA==
X-Forwarded-Encrypted: i=1; AJvYcCUGFhOpWy5DYNK4AiW/eDpSh6pxd7k7+Q/4HGGpEqybfVRitdYz5hH+1V4+RgZ6loIZWSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4O21A+dfSoeLNDNfaiUwYHksdPzX1aQYEoDc5eCSYuToAXkoP
	e/jvUXtJzLtqv9gQw4uz9k2Z1CKxxCkVt1xc3c07BqsW1wZDOyAP4L+Va9BA4esIe/f1Cb04jAW
	lcmrhn+d4LnxRtBwniwsI11eak6k=
X-Google-Smtp-Source: AGHT+IHvddmWPSxcmhlNbBSHD3jQtGUDqTHB2mdmQbBvvlerJeeTdqbniWzLESErXZ3cZr3nrn8CP36ckqx6HyaM7Gs=
X-Received: by 2002:a05:6512:1151:b0:533:3fc8:9ab9 with SMTP id
 2adb3069b0e04-53546b5a311mr17165476e87.34.1725561617665; Thu, 05 Sep 2024
 11:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEa1_pZ6W24+WwtcNFvTUHTHO7KUmzEbOcMqxp+m2o15qQ@mail.gmail.com>
In-Reply-To: <CAPPBnEa1_pZ6W24+WwtcNFvTUHTHO7KUmzEbOcMqxp+m2o15qQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Sep 2024 11:40:06 -0700
Message-ID: <CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1WjB1pP9AzJLhKuLQ@mail.gmail.com>
Subject: Re: Possible deadlock in pcpu_freelist_pop
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Hsin-Wei Hung <hsinweih@uci.edu>, Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:37=E2=80=AFAM Priya Bala Govindasamy <pgovind2@uc=
i.edu> wrote:
>
> SEC("kprobe/__pcpu_freelist_pop+0x58c")

We should disallow such recursion in the verifier.
All these "bugs" are hard to prioritize as bugs.
When people shot themselves in the foot there will be pain.

