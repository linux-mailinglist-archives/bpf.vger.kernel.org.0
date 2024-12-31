Return-Path: <bpf+bounces-47722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 644D49FEBFA
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 01:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F61B1883040
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 00:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17148BA2E;
	Tue, 31 Dec 2024 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0sI4LQi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46222F2D;
	Tue, 31 Dec 2024 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735606256; cv=none; b=u9fTQXL+bvx4XizMylYdzaZniQKKAG9IodV4QMNJKvSbgrmpcYG6hmlzrApS0lFFEwIWlgjUA+guBI48EL0zrCAwXVm5J9YTR4NRtaC2AWbJfkxvGe0WXDVwk0oCK/Tpk8aKnWbvFXGM0LGrULoltsqrbaVj9hfcsKljMse6tDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735606256; c=relaxed/simple;
	bh=jBkqqQJEX4PILbfyFsL7OxaUiUrJXdz4wzgXDhfUd88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HumEDAknCdmDClNJaRBOFr19kLpFT810UTf94QmQ2mhvBo9SMBbM8F5sWKoYMiMmBBKNw+qiw61xk5RKaJixXWnsn000pNAwviP+eeoIcIZNkJyohcgYroj0cL2EsPVtAMFGPpPhMfjKvlN6Bhif8OYj7CnqfSwfA/Bhg8VgKNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0sI4LQi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4362f61757fso96326395e9.2;
        Mon, 30 Dec 2024 16:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735606253; x=1736211053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBkqqQJEX4PILbfyFsL7OxaUiUrJXdz4wzgXDhfUd88=;
        b=m0sI4LQiQcT8Fkb7LarhT0Kjr7jPe4/TcPj9y7Nw8Yq85Jca2xVZZrwAdTcMq9hO8E
         XrSyWDy/JVA/Tj1re0leH0GF8wOgwkSh9mjy/Fjn/FEQa4L70bYWY1ukxHl9wbPXvahC
         WKc4JAroMhA49Mp3hPPYr+Y5Z4g5RZQWDyI97h2DSh4fE5yLsEh1SW75JpTnEF+kY+4C
         Arg/YfPj+X/T1BlPGjyn52T5a/tw6Ob8gR+0OQlFEr48zpqDTkGTUB8CdcEwSVFb//JD
         v1BrOK9Gpe1/yO3amgWd9+gGOv+iAusVIUCBpfbYuJ+znCFR/1rLDHFaHuvWgP69akZe
         viSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735606253; x=1736211053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBkqqQJEX4PILbfyFsL7OxaUiUrJXdz4wzgXDhfUd88=;
        b=OIdXW+SSPxFbvk6rWXx352M3QUdHUwXk5Y0ws7YmynW/hY+1ZxHqWrEA6PuKPVu54c
         h6bhwYBbWg2X6Vht2o4wCJ+r5helEkT5r29vN0kLO2mQsTGn62StopLgXUsOJlHHVcNp
         htwujjcgzx2G0/OWMHoDLFpWMQUWdwCcHERZNiKQi6d83DVIQ021wedaW4g60KwuRAIW
         6Xod49tnBj+rVjBOdZH2RovQe6afwuNCQRVdVW0ewaS+yNSe2YHWyKIdiW01NkY+pFSU
         92jLaOamSSUKZirq9mDs/cpglZb2FwN6aP1bysMI19RQCfOHlNUvgE0QR76WQmkyfbcj
         2g9g==
X-Forwarded-Encrypted: i=1; AJvYcCUmAfnbmkcM/mHzplmnYj94s9wa/5lgpiFd1tVUnna1/gBl1UDn1n3VjejowWxfDULFXz0=@vger.kernel.org, AJvYcCXfGpZbCQTB0Yyu1P0jhbdhEncL3YuSdIYI6gE07EWnL0kTMIeEY7nxpM17ec57XOMGU6XaWBzlnzD2J5pE/Q==@vger.kernel.org, AJvYcCXiRGMA1ZJOkiqtPD8ILnLsuqyRNr7yGnIoPEtG5HxaLdlv8UjeGzNDtXQ7OdvKHNePg+NcTJmX7EuOFiXz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq/tN+AOqWKToyZqQP8hGzZ9Jrc4QT+jzd2G9z401Ro4BDnk3D
	XTJTgCMoD+oG+v2h4w8oHS2iXTbHBTpoSrTawBUQRy1MxcyCYKrJEi4OCtACRkl/095TQ5yZb5w
	dv7LbplWnZpBn92ctP+Ccc5iemuI=
X-Gm-Gg: ASbGncuZNt07B68wjd1a9BaDf3+W1yChqZMEmki8pHS2w0iqbYOQ7DKcBXqy/vlFYP1
	NF/yqf6zihIa7zoj9V8w/Jx0mqP/zFpyq90hmFAjG/RLly1sntHouYdYxEr+iz3//8fzOwQ==
X-Google-Smtp-Source: AGHT+IHYZ3UJyt6hDvoR2xtV+VlHNg98hIR1jdQVb8Ns3euF9qlwYgJ4dQnlgdHYZ0r/ahF8PnTZBtAZCh5A71J/EuE=
X-Received: by 2002:a5d:6d0a:0:b0:385:dffb:4d56 with SMTP id
 ffacd0b85a97d-38a22408d23mr38366182f8f.53.1735606252876; Mon, 30 Dec 2024
 16:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
In-Reply-To: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Dec 2024 16:50:41 -0800
Message-ID: <CAADnVQ+E0z8mY4BF9qamPh1XV9qs2jZ03bfYz2tVw8E4nFVWBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] sysfs: constify bin_attribute argument of sysfs_bin_attr_simple_read()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 12:43=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
>
> Most users use this function through the BIN_ATTR_SIMPLE* macros,
> they can handle the switch transparently.
>
> This series is meant to be merged through the driver core tree.

hmm. why?

I'd rather take patches 2 and 3 into bpf-next to avoid
potential conflicts.
Patch 1 looks orthogonal and independent.

