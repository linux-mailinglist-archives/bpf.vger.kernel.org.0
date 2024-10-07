Return-Path: <bpf+bounces-41145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B48F99348B
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 19:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FDF283E90
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD81DD522;
	Mon,  7 Oct 2024 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlgOfDuX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521291DCB2F
	for <bpf@vger.kernel.org>; Mon,  7 Oct 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321217; cv=none; b=Z556J/ArYSEcshIUB5byYZaYOUZRIuZvWtxC3uB9ydtL4ezoXOI0lhcMShAluswPqz4k47TnlQwXnM3fmyURaZ3KyngiL2v8kxj8u1iCszHaBmGqhWbxqyTEw1VsmizVPOGhK3ceB+t3pM1FENF3LotkUateKqmQ7aFYQBPBKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321217; c=relaxed/simple;
	bh=vcVItyytBWa0QYz0ktjiHFFTh864cjLhKiwh2B3GZwo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZtRk1zQCoYgBPszHTJxbcTojzyiYy+8eVOJFZA8w2F3QIC4OPDU8/XCKG/gsUkuKh/3+5HaXepbfjnS/CXUFMh5d2qvnJIdKHJAJ5Gqy+DpBfCBpfnHrSBTfCH5VIGwtwRz2UJb0riDjdcNigpyCcNh053ODVlSPG2Lhi7JGzD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlgOfDuX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ba6b39a78so33234665ad.3
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2024 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728321215; x=1728926015; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vcVItyytBWa0QYz0ktjiHFFTh864cjLhKiwh2B3GZwo=;
        b=PlgOfDuX7Xzez3lroXqEddwX9vt25zEOsDEVJSxk+jimV4P70tuvqigwALbZQtCKs5
         xPtLE63sRL154RW9U5Z9rJ5iJFboT/i5j+1fkEMERA5NFDDyqGSMGVa7jzjleh4aHhyj
         6O6aywjUSVtsSQYf4AOG3q91ms3VRI4EPuEbhZTshhtt47nX0BXeWf+Ef/26ieP9PA44
         gC/8XbGi63OnKQIH8niv+EgtxztqlJw9mCgW8dZmG7xPTvjymjRM38dPfOdLIzt0C6HL
         KZPtPVsyJe6XZ6eCM5RwEBUy5RJHRSjIZBFVa7ocEWqoJVlTaexGJNoDlVU94VPKI97n
         ROjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321215; x=1728926015;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcVItyytBWa0QYz0ktjiHFFTh864cjLhKiwh2B3GZwo=;
        b=l/gg9WpAj/0S8uWNlN+iHfl0EPXuoVdjGy8vCkxaJ05NNcg2k0UKXWIW+xqtqjgZcw
         PplCBgFzVvXHJDzwC665kXYObYJFtwcV3NVZEdnKk2FtNBOg/qD8hVKawldJPtroEZmQ
         B8IoKXHKwP6GGMu5u0D09v/3R3R7ipusMRMnba9MTivL4Nc+YtaIKmttrAr4J2vq0EHh
         //zOXUufIiFh2tF0/ANYH0sBZ1xDoQWUJ1KgYMpDOsVmP8RFVsLq2PdbKTz+i+SwOQ+/
         Ane1H7QezHgrooEI9buvoY+Q/uqm7XCCZo6fSiaUaqtuAxcA8MzIrqkIcBjX2jSf7knK
         EpuA==
X-Gm-Message-State: AOJu0YwCjqLVC2cHxPstyey24Ng/2vcE7hwbPC6ufKg+8kNm16Z+faNN
	Oq9LL/1gxYcH8iuZeV9erL44uc+f9CqOr+xpSFFw+/FauUyWREmuQThx2g==
X-Google-Smtp-Source: AGHT+IHREecAK6yvfw18/hLqpZ9Z2x/safNc91IrXFjmp/9VUV3jv8bO4FZHhw4MLP3XMiGZ9h9CJw==
X-Received: by 2002:a17:902:f78f:b0:20b:7731:e3df with SMTP id d9443c01a7336-20bff1a5c04mr180525695ad.43.1728321215514;
        Mon, 07 Oct 2024 10:13:35 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1398d551sm41864585ad.270.2024.10.07.10.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:13:35 -0700 (PDT)
Message-ID: <68c665274343d1c80ef46c78ea21fe2e4b274240.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix memory leak in bpf_core_apply
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Date: Mon, 07 Oct 2024 10:13:30 -0700
In-Reply-To: <20241007160958.607434-1-jolsa@kernel.org>
References: <20241007160958.607434-1-jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-07 at 18:09 +0200, Jiri Olsa wrote:
> We need to free specs properly.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 3d2786d65aaa ("bpf: correctly handle malformed BPF_CORE_TYPE_ID_LO=
CAL relos")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


