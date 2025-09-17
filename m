Return-Path: <bpf+bounces-68623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BBAB7C4C5
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A32A8605
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 04:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021DD2367AC;
	Wed, 17 Sep 2025 04:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXiM7ktY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03B231A21
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 04:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084666; cv=none; b=QkzpPfjonfygRE9CvoUT34J/7Fh5mbZY8y943dCJp1N0Ejp1Mq1pkDso+n8yqhqomOBbs5CNnECG07Q2A9fNj+d9kpbQBk2cbqQGMd1rE60FkVhoXWDAWpSPP57Q4ZcwtpuSLKVDa9oo4CvJekm9aRS9I0UKtaWeYnIQKVmph78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084666; c=relaxed/simple;
	bh=m4OYt4T61H0r1d3DBrOPc9Raadvl2oXOydODxCa004g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XGre4x77BycbVU08TQxaS6zGvpvY21klaR0OtwqFwEnl5sXp9FbYT9yWJrU0UO+Bxlg47UMwM2dK+2AkfP/YIZTIXzMJLCfibOq4afY5hhbxZ1gKqypsz/UyGyrZL4wAVS5UAR5bzTTW9iDyrBw67rGv0ZuhHENKvJ3wrE9C8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXiM7ktY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77b0a93e067so1192867b3a.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758084663; x=1758689463; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIJEfYJZthAGbzZBYyT8ykZD4iPiRThZGMW3pUavVl0=;
        b=KXiM7ktYSz69OhXaACs+Z7ImTYld4HwrFhIHEsWL6c4/wB3kBo645wDtwYxxzQI0kW
         T2i/0HjbSd2AiRoMh1xs8ZVgAO3WQXByfC/Ca25bF4NBts3t9zdq6HDgsu06r+qp2tt4
         JSLs6LBtU3LzQadywDemvXo0oIaC/GAjA23g5OMDVM8gY70Wgd1HAQDwtp33OjIZ6Qrj
         Bc9Ujpv/GwS8Y3w1t3BmGelj1aiz/l8UdOe9AIYzQy8hYOjFZ0UW2Swgl9658F4KQGp8
         4e7xtev+88A98su6FHY4lh6mGqGkxHHsWs50nu2rAqvwDh5A24fcFEHr+m3G6IuiP/GV
         4S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758084663; x=1758689463;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIJEfYJZthAGbzZBYyT8ykZD4iPiRThZGMW3pUavVl0=;
        b=UqFtvEPJepg1MrS0sJ5/GNOU9capUfPe2i7wa2Z1///esPS6XCFTIj3oRtIm+F2ET5
         yE9qh0GaEjHW4rmijLDzpyX/eM7JDbcPgEn3j61qNZVKdlBTv/4Cnd84RweKmWsBoSSt
         eWaCsDwQR5lxwnFed90bou9DwA/preEeVvgExq+BmMCuwTKM9gCh8aBTWc+yd49w9e/t
         XyRWqR0fFqrYRSt5h1BqT891Ncj5SkynLa1/0wz/YeN1XfsIE/x3YfoUfPsk2yiNyhQ7
         CBK0c6CzxTrgalrHn2oYafADV8dJU+smd+/pRIIi7DuHS/tIBbU+tnh5wnTFccS7l69O
         /IzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpLzRSgXbKSqJuFKx/HF4+2w+UUWUeyJBzzKjp0pkKrJ6OB2d9zcjYlzgxjgfe/og6H8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCx9oOsreELxrCphx8FBeJVowXkZrR+vyl4G8uCivMswHO0VG
	DaA55oe3Juf1PV8Yd7dole+o20coGvlXhIHa/zlqWHwRJOMhGiWL8MsH
X-Gm-Gg: ASbGncuXyUd8ZOPQHIENs8Mc1tqo1jSaU22r39ii2ExrVOWdkmNRzIbzWeTX+sNOxbE
	JbsGAw+2cU5SilyaK0MEtNlQpZO/Nz1FaYj3xiscGaZfpMs6qH9E7TAtJFuQN6q+7uDnqP+IT+6
	pzNHResWr1FXbK5puRGtDiZ8oER1jLMdS8/ytAaEil8OKlNg4taW13NskRDVOtAM7GUPrRkHLu0
	gvU0eFu4b7sOjIasoDCTiLatSxb4ZzZlTtLVyplSNJfVfgWN9zw6nnDYp04LFPl5nhwIe3eBfy2
	fDBslqE1b+Bn7KyN3YC3uvjV43PTkXCrDkz4W7vdob6BA93Se/6b4qiSilJ8xZM9GnZI629En4d
	O47kL+3dLAuaYFg6UW0E=
X-Google-Smtp-Source: AGHT+IGRVvvpHAmN4qIJwnmckCt1zMPGL3dXR8GQXd/DHkrRmJZcQQge8RoC7qTUlU/tHM/kzSHN8w==
X-Received: by 2002:a05:6a00:a8e:b0:774:1f59:89de with SMTP id d2e1a72fcca58-77bf75bda2fmr920348b3a.11.1758084663394;
        Tue, 16 Sep 2025 21:51:03 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761f8b1bdasm12206339b3a.60.2025.09.16.21.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:51:03 -0700 (PDT)
Message-ID: <bf202c1aabb6247cdc6c651c6cac3ff3982115db.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 0/8] bpf: Introduce deferred task context
 execution
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>,
  Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>,
 Kernel Team	 <kernel-team@meta.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 16 Sep 2025 21:51:00 -0700
In-Reply-To: <5e2fff56d3465ca921dbee96f512bf0443f66346.camel@gmail.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
		 <3b65db27f2cd4575875a090f9cce0ca0f138daea.camel@gmail.com>
		 <CAADnVQLe+5C8MH9SEU2MxHP9iaCHJHXdnuXTHkqvnVwsHTynwA@mail.gmail.com>
	 <5e2fff56d3465ca921dbee96f512bf0443f66346.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 21:44 -0700, Eduard Zingerman wrote:

[...]

> In v4 the function invocation looked like:
>=20
>   err =3D check_map_field_pointer(env, regno, BPF_TIMER, map->record->tim=
er_off, "bpf_timer");
>=20

One option is to pass an address:

  err =3D check_map_field_pointer(env, regno, BPF_TIMER, &map->record->time=
r_off, "bpf_timer");

But still looks a bit ugly.

