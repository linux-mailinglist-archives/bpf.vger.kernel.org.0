Return-Path: <bpf+bounces-56909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80ECAA0320
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 08:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C939B1889909
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364BA292936;
	Tue, 29 Apr 2025 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di8BSgU8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6B27464D;
	Tue, 29 Apr 2025 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907558; cv=none; b=g0+2r5JtXh0W9DYYYlXNrlm/eVeud7bBQ1zsRQ4clcTb4bmj0V9oaoHw1TSefN6eDac5S/hz0EgP25AENpLCCwdSWr2gK409utNKoZgdLRJgAWalvmYt0OOOB/seMdIHZbNsghO3paTiqFXDJP1Qo1Bugl+tcE5v3U3/CJcwzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907558; c=relaxed/simple;
	bh=to96rNsXBuxik4uZ6ag+2c1WhKm2TcEPMNEp1yi5Dek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkyUzJW9QVXafvOx/eusP52lvU38MU6FKRfkMKq+LnufaRsbvjMkstytxs5Hr2nDT3r0jz9htPSs//yYTDWDMsv7pvfNR9jQ3rNybyqUBBsTcN+b6lMvQBsFViz+xKqZWSdmf5eslA5j2bNGOSrvsN7I+KZfB+uhEDU0tXBD0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di8BSgU8; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fc176825so50652746d6.0;
        Mon, 28 Apr 2025 23:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745907556; x=1746512356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to96rNsXBuxik4uZ6ag+2c1WhKm2TcEPMNEp1yi5Dek=;
        b=di8BSgU87W/DEDYb6h9C+e3Q3sKqyND2/V2tphqaabJb/0UgVk4ULVSQ1rui0fO6UF
         q0I46c2T/PbMjOI7+/qD31mQJd8sLVo6uNKn3ucU8toSnkQyRsy9evto3dH5Mp0CttbE
         slGZBaBi/s90ofGD1NUghwtNv6UVhZpAtsPwLtGv4igQNigyla+dNJqnAAeX3/JZWlo4
         kKNFHz1o7TfBKOxOkdJhv3B6OvyMNAryFexOKTUw6USbA8J4RxhHB7Sgbf0IfXxyphQ8
         SZZoTaDsDJ0uEtQfGN8b1JQ5HWYgHk0zkGZNTNBwZOh3gmpifZmW7pwgqWLXYWP36G1v
         7g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745907556; x=1746512356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to96rNsXBuxik4uZ6ag+2c1WhKm2TcEPMNEp1yi5Dek=;
        b=Uqv6Bg6gJeQhsqbhtzp2aRoCLD47obJsbzg40lEDaHQ0fY/rCiRc315xehTKeKTNyn
         bmvzvB32xK1wO/RlvRzLdrlLGZaxJz8kNx2S80rmw8IQJvG4avt8P2KUds5lLOzVpq/b
         tlAYq4KS1D1fkxdXtRBz2prESnwvmOuIoHZvWAloV2y0sGQP+jRjztVbcnNGHRzK6OUw
         5VSoz1yux21t3roHcqGSJRDfOuZCCOTTjQyvzgMTC8z5qtbPmibm7/gMAcPw4WLx6cHE
         /IbUMKWRsQmOwWNl3cK4RV/HKE73eNVxfWMlZnbJeePBRKyT0L7T7sNynSCX3aDognSG
         sVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNtwvmeAjc6KFcjZjiKRz6Wq+2KZqfNm1yYMFyr+4VRNLrpFFzbuLJc/QinXl+0J+3JNMJhZ4SSvK0Sx9m@vger.kernel.org, AJvYcCX/u+mwEKinZ8dSZ15s1ZIAgnhj9Kwj5eqTx/BpPPLTrDt6iv5TDweXK4iwXf+qxsye4ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCi4pq5wCuKcYPo+I4WwzIyW6HVkirGmXISDBvtT1yiKJ0c8W
	Y7IGKcsZ5Dm43R6S1jiUgaFYG6M7lTOrBw5vAdt7I3lkHmZ+4KqXwMEofVmfaoo5i9NEER1Ms3R
	ppB+4Yb5A9I5qVTu4MOWMH22aWZs=
X-Gm-Gg: ASbGncvg/LPB5oIuTBrIqRn/vZMy/ivhLASR4Hz4a2N0E7Q9jR5ARutGOxpZpC5HUSg
	ih4FgCcMd7qA6XNXYPXLILGe0ELlZz2Rh298xAhS6BF4wl4T8b0i7BRuSWS6eQJkWzgSMv2ucoz
	UTLk1+QSNsu26pza/ysDuyy5s=
X-Google-Smtp-Source: AGHT+IEsZZy0YWcOC4vhoy7fjiYyU0NC/Z/hsYbcXHZ/2rwkSKrvQDaK+4lISyDGN3W/xEMk1b3QRzKcGcygynxBmDM=
X-Received: by 2002:a05:6214:c6d:b0:6e1:a4ed:4b0c with SMTP id
 6a1803df08f44-6f4f1bc656emr28792856d6.26.1745907556075; Mon, 28 Apr 2025
 23:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423163901.2983689-1-chen.dylane@linux.dev> <0a25f585-de46-4e3e-8ec2-47df25947df1@linux.dev>
In-Reply-To: <0a25f585-de46-4e3e-8ec2-47df25947df1@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 Apr 2025 14:18:40 +0800
X-Gm-Features: ATxdqUHu04qteggs8h5a-T20xGufOv50i0ALjGNIVQQS8dTPfwmvBAQC9HTNZDY
Message-ID: <CALOAHbBUaSw=LYYYPwqM+HQz_8t5_g43Y7ARdvMZ-7rBTvS+Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: remove sample_period init in perf_buffer
To: Tao Chen <chen.dylane@linux.dev>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 1:48=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/4/24 00:39, Tao Chen =E5=86=99=E9=81=93:
>
> ping...

The patch has already been accepted and merged into bpf-next:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=
=3D64821d25f05ac468d435e61669ae745ce5a633ea

Interestingly, patchwork-bot+netdevbpf@kernel.org didn't send a
notification about this.

You can check the current status of your patches on Patchwork:
https://patchwork.kernel.org/project/netdevbpf/list/?delegate=3D121173&stat=
e=3D*


--=20
Regards
Yafang

