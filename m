Return-Path: <bpf+bounces-41268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFB29955BC
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BB0B282E0
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC120ADD7;
	Tue,  8 Oct 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4gjgEPn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCC20A5F5;
	Tue,  8 Oct 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408876; cv=none; b=jZynPgM11ka4mwDTy+O47j4H0PTXbVqphE8OH8GHIZCDH74KFx5GKZs6kbPWPG25SUE2RVcCQIyEfT5Lqn3WTVr9BUKouToWpd8msvhKvNzjrI8lGDCVoYgjno8KilMUmfZzdaW0CzpCJx+ATOF+Wt3LA3PSVvDKYvmuQMC8r4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408876; c=relaxed/simple;
	bh=X0TvRFAwJ3/mBkhDmtQJ2dLLo9P2eGf/Py9sSa7q0ew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iUFNdCdhxYVYQ27uZBmZpoKT6gIw2JlDzBO7WpWaPxIa+obMTVX3FuxKT6Z2wFN1zY3gdDGTtQVWmh6SIXYp/7f7AhUVy4Qx0SAKmzI56AKzaPJR3hqPsu/Mpg5Pk+dAXF6VeHIwMFxP0gnIGRn9jv3Bkgrw+p3wNgdCCuBmI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4gjgEPn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so19784b3a.1;
        Tue, 08 Oct 2024 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728408874; x=1729013674; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X0TvRFAwJ3/mBkhDmtQJ2dLLo9P2eGf/Py9sSa7q0ew=;
        b=m4gjgEPn+H7UO2bulZ453QNqnF+aM7JA6khHqPJsVGDEQeP56rU+NoM9cOPjO6fEAw
         0Zo4YqGn2Qe/67ZDAU0IBz4A+oH3kE1JzxnmCaLAqnl0/qRN3XHf3Kw8vOtLAuAvB7L0
         ETZSwbXb1mKFK8CzQI2zQbb7JknB/5TWY88hPiQT5Zgj+SE379Kb3VHNDj5Kiz7adGEe
         J0lTgYumO13rLH1W6LhkznrZpoGhbOv48WKb8l9Hg7uUAl1U+Db3/3/w44RVJ7vEOP3U
         vAUYh+eeteLyGkJLpZiv4NjWB+6MMIGrRg7K6UL4Up372PmplZLQXMfGbPB2YfNVnXmw
         v7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728408874; x=1729013674;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0TvRFAwJ3/mBkhDmtQJ2dLLo9P2eGf/Py9sSa7q0ew=;
        b=qN3O/Ee8yUqGrUSStlSvies5Sz2ZDgkT5WRsjDwZC/qlk5DGGc/haAfhbpraiJ0bLF
         SNqE7qOskctnoc/lwD8xtWNJMy8G3GzDbLV5LBi7KVi1mB2ZVLqNHxcmJKdPOgelpdqD
         gT9yQpT0bmuURdCAXQXkN4Lc2Ut254EQSU3tcaVk88GT/fAUjy+G1AO5H4LkcV27ZkEV
         53PuQ6XfoKebdeDIPsNbaztnmHpM9r5af9GkPsSsX8g3Qs0cmHYG3kvS93d6Hbvq70gz
         GOD066SxGpuTQu10vVMwtlVxwWWoiAjRf5Ox3w5jzaMtkNZXUq0ZHiVk3N2OcXrqXWpX
         N+iA==
X-Forwarded-Encrypted: i=1; AJvYcCXOqRZvbciMIR2HT3Syk6Y1EcRd6QXh2KFV66XOGdllQrAG24pOJ45ZZ/IBM0N6B8hYnU4AJgsn8BllJTV4@vger.kernel.org, AJvYcCXV6ijnTUCOdzN8D7Gydfd0nVOKOlTJf1JRmNxoSNMocI9T52ly/m3OOvBVvfXLRReJyFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOlCAeX+SmFpr8kxqWWXteI8pIdlZSTXXnFo2yxcq6CM7Tq+Qf
	Wi/4T7pQEKcKJiwW16CzZXXZh7IS7/MVW9Rc3pbJHoudKzerLLAj
X-Google-Smtp-Source: AGHT+IETtgrxqR8eMRf5xcHm/B5X18gXb5FppU/GEMg4VpXINOM2nUyAjz7RAqvl/bUJWJRbym3M8Q==
X-Received: by 2002:a05:6a21:3282:b0:1cf:2a19:b1b with SMTP id adf61e73a8af0-1d7073d378cmr6355233637.7.1728408874077;
        Tue, 08 Oct 2024 10:34:34 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4cd20sm7042479a12.89.2024.10.08.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:34:33 -0700 (PDT)
Message-ID: <32f7b86c2426819f75388dbb1deb27c846a99b03.camel@gmail.com>
Subject: Re: [PATCH] libbpf: Fix integer overflow issue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 08 Oct 2024 10:34:28 -0700
In-Reply-To: <CAEf4BzYTuOJ88FR6oN1KDbM5bWuiYo7eVdrrn0FLziuzi3B_Fg@mail.gmail.com>
References: <20241007164648.20926-1-richard120310@gmail.com>
	 <3be8b6307e7576e5a654f42414a1f0f45a754901.camel@gmail.com>
	 <CAEf4BzbpxXqNLa02r0=xw-bHzDoO5BELHqX+Ux35Hh7XRNY92w@mail.gmail.com>
	 <b7c4b77e22bd8005ad5758706ddefe878f949d94.camel@gmail.com>
	 <CAEf4BzYTuOJ88FR6oN1KDbM5bWuiYo7eVdrrn0FLziuzi3B_Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 10:21 -0700, Andrii Nakryiko wrote:
> On Tue, Oct 8, 2024 at 2:49=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Mon, 2024-10-07 at 20:42 -0700, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > Not sure what Eduard is suggesting here, tbh. But I think if this
> > > actually can happen that we have a non-loaded BPF program in one of
> > > those struct_ops slots, then let's add a test demonstrating that.
> >=20
> > Given the call chain listed in a previous email I think that such
> > situation is not possible (modulo obj->gen_loader, which I know
> > nothing about).
> >=20
> > Thus I suggest to add a pr_warn() and return -EINVAL or something like
> > that here.
> >=20
>=20
> That's what confused me :) If it's impossible, there is no need to
> handle it, we know the FD has to be there. So I'd just not change
> anything.

Granted I have a memory of a fruit fly, but it took me like half an
hour to figure out if it is possible or not, and I wrote a part of
that code. At the very least a comment is needed.
Also, adding an explicit cast should silence the tool warning.

>=20
> > > Worst case of what can happen right now is the kernel rejecting
> > > struct_ops loading due to -22 as a program FD.
> > >=20
> > > pw-bot: cr
> >=20
> > [...]
> >=20



