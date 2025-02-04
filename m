Return-Path: <bpf+bounces-50374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BCEA26B9D
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 06:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8E518872CB
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 05:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D506C1FF7A5;
	Tue,  4 Feb 2025 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqkRr7Ni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A441FC118;
	Tue,  4 Feb 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648689; cv=none; b=LSaJid8ysxP+WmcYQ5Rrwa6LLaqSYSec+U7SkFcJO2eNAAgfzgosKVuinsTpPewpxpnQ4huGk5l8TB45LeZPAulh7qTv7U9W3lq/3bB7M2Lh62WS+rGxkFyY/yoP5+Rq6fCmcgdtuVJp/t0oV8e4EkyigHGBxrwEAPy/JQb8ZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648689; c=relaxed/simple;
	bh=bErJjXSGvtCa0iF8y/s9LH/JDhESd1/3yoI6OYHOjOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AII76S+WEJqQwrHObEcUjiEadF//r9uG1EEIgTnaQOipqU2Q+7QSRG7yqrJSIA7BIvowJrzueVvmXHPdPA/EY92Aj4Y1J8HxAmR2kOc0Afne4uYP+/Etfi971RpCwKnRheGHeMxql4Ynyst/HGoY3YGTri2aNnu8qYk9bMC/2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqkRr7Ni; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21ddab8800bso72569115ad.3;
        Mon, 03 Feb 2025 21:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738648687; x=1739253487; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bErJjXSGvtCa0iF8y/s9LH/JDhESd1/3yoI6OYHOjOg=;
        b=UqkRr7NiAf13Cpt1jzZRwDIRGk9nMGHeGGJ6g5ExW8AMeTnWmnpZG5bN+cBVOIRfHi
         LM55LmOAwWv7DSAcnZ3rhACn/LNbPvcfkP79w2ivhe87LZz9fe9TGW3omcRnJCkue8Ka
         aqVlK4oymrguKSHjqEAL2gOQ2Cq1DgVYcIsmVhmnS9QrsWk3bSVvA6gXnXE4iHBwFdsw
         LQJSFTO8MFEXV+XfWi16h+qaP5iDIgjxbsfBrixZHvTyhAlymwpQx4sHKL1C+fWIPOBA
         jUukcugXbGek4/omlgBe4UwnbP9+qFCYXIO7SNIeUW+W1F4NfH2AhDmZ3C1B2xQGgb7Y
         mzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738648687; x=1739253487;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bErJjXSGvtCa0iF8y/s9LH/JDhESd1/3yoI6OYHOjOg=;
        b=d+Dk5m6WZDiXSKWNIG+5aZHFNCSap2AW06lLWE/2v6PHEfJCxilTjhdhB0m0UkHJbY
         L6Z5y8ZcBR86axCkm3NXjJ7m83UVLyzYDQ4mzOWkKhRJPAkhAYAcfHLYUYFiyy7Ps3Bn
         //uahd2Pf6toTSHMnC2CzYa737VjpyjU3oCEyzS/h8CFAlO3MEAboeQD9XLw7tLorTkU
         7UWHKV5HhaExCVIzMGDC+abjkprI5wLirik/ptsuPp883GSsETvloxG/P2NNw2ctJ4x7
         iby1LR+CGJdYcxaO9dZQLWyNEDdB7ffh91djEFJQf259Yib6+nR9eosm1szXK5dl/WYN
         QjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL8zW7199B0kwVMnOp3tXEw1jU5P7GjYNVX3lXRX6P8Jq0kPtlZnBtTlGcOYHJs/qnPAUo+7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/VQzhuPTSnyM97F32LHi8a6+GCV+o80bY47MQxk+XRYc8JD2
	KmD6RdwMVcZ9m6d3QFp6HdZ2G4AbUepRE5AwLfHIex0bUEl56t/1
X-Gm-Gg: ASbGncu45PZjVTFmm79kOpoMOHDAoOqzsyyevkXBwLld370UXZiNLdXJ8WwYEJxdCJ5
	AcfVeWpHv0QQiw33O+PzonAiM4hNCWJcAkTvcN8cqGTza6t+RusCZztMe0NqgNAiojBQgU0132Z
	1K/cSj6er6Q3EqKqYSOBWLwNzNYG/pJfG/vgOjHN+VbFAfn85nJc5AZUI1v/PIlRY1f3cjZu+0K
	V5Pc+NQKd8gnb3y5QkbY5KBozO8B1JuzI70aGpfCUqT25xwzOFL5q8KderfJO0jpHPFAY7QKFwi
	TXM1qLu+sYvT
X-Google-Smtp-Source: AGHT+IH53zYAYKrf60dMtFyvL4VCB/kgRH1iyvRB2Q7Y3S+sLbMwdRz/T3Vhgv/BEGl4Yb2RnV7jIA==
X-Received: by 2002:a05:6a21:32a2:b0:1e1:9fef:e974 with SMTP id adf61e73a8af0-1ed7a64f4a5mr40847782637.24.1738648685612;
        Mon, 03 Feb 2025 21:58:05 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe384771sm8996379a12.27.2025.02.03.21.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:58:05 -0800 (PST)
Message-ID: <a3e6a8cbb7962c2ef49246be380a6bd7d2279196.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 03/18] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, 	yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Date: Mon, 03 Feb 2025 21:58:00 -0800
In-Reply-To: <20250131192912.133796-4-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
		 <20250131192912.133796-4-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-31 at 11:28 -0800, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
>=20
> Test referenced kptr acquired through struct_ops argument tagged with
> "__ref". The success case checks whether 1) a reference to the correct
> type is acquired, and 2) the referenced kptr argument can be accessed in
> multiple paths as long as it hasn't been released. In the fail cases,
> we first confirm that a referenced kptr acquried through a struct_ops
> argument is not allowed to be leaked. Then, we make sure this new
> referenced kptr acquiring mechanism does not accidentally allow reference=
d
> kptrs to flow into global subprograms through their arguments.
>=20
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


