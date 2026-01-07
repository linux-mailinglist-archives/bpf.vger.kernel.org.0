Return-Path: <bpf+bounces-78086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E51ACCFDD6F
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 14:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B0D30596A1
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 13:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04F3191B9;
	Wed,  7 Jan 2026 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR+PBtZx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB782EA169
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791018; cv=none; b=Ofn4n5rOxcRd36lr5xBRAQMVz739ylOgdyxxnRY9IKMDTKsm3Anf57H/y5Npju0HQS9urds8O2igCh2qGOksj7tqh2I0JKWdvf5B1s2sA6zFspwZO8BrtX7bFdhLiF23rJWavnQ/96j/A5DYEnogeliW0YYBDUFhuZb56Z+6hjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791018; c=relaxed/simple;
	bh=s7GTh11L2i2KI3LvsWAFeFcx8JWTGou+tuO3WnXU218=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RzBMymSFyhcwYml3OR+CHmmgKqC6h3e9OBylBXc/0PBJ7QRRkGVBVugfXcLzn4AaSriJ8wPl5STZXUQtNLW0cSuHtj1efd4QKns62Ef2U/MtI5tLxoUCUEijjA/OY5OrqzuCClc+3X3BMNYlYfmyg0ge35wSB+vjoNT69GZYtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR+PBtZx; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-121a0bcd364so1612723c88.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 05:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767791016; x=1768395816; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7GTh11L2i2KI3LvsWAFeFcx8JWTGou+tuO3WnXU218=;
        b=fR+PBtZxEY+N0Njaja/uKAKcp5uQMBZcHwjdMwGFFFrkviInaQ6jX6hZSFgvoqEw3o
         fEQU3b6aDbISNzAIfXKmPuUXuUhgU8LHhVp0uBucCxUSsWC87Fng6bj/y0/LCsVscJ0P
         s0SAvUH0BR9KDX9/wEgpgtuS0JRexJFF5ejooEfkz4RwoXA9rEL0ET4Z4goCU1S4lCu2
         56FVZ0/3YAW+B5ak8XjSAk2TRhKGmopesDakWfY3WxKDLcFy6w4hSU6Z+pPR/4icehJR
         RjFOIPAyoNa9UIiZVMmQd94OsvCbI2pTJ6Y8XsPmAHTOlE31U0oqw29G9H8Z4xiS95yL
         iYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767791016; x=1768395816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7GTh11L2i2KI3LvsWAFeFcx8JWTGou+tuO3WnXU218=;
        b=VHeNOrpct74AfHbWmNkqZwkyURRpX51nWy+BeChvj5ka4COcxPxmDFlNCTKgflpPNu
         DID3UGH9x5hMh/DMcIzgJf60ZtfynUy/N9CqTZPTzVVCmpDBmm6cjXRGeppSLq/1wRqh
         2sRohYsP7b4y08Qpfl5lGq/V7HRJ3U6s/QbD++3gTjVqQDgC/oijeqvKX/XrwGM4tqj2
         3ckY5wE6JeXpmR/eB1qPWvIOabvWzxhu5oUZqYnnOfWMiTa52kTDIAqKEaKjkgt89EAm
         2IesePMZmv+iW2OIg46RPR32VnYZXDwO0A8EB9dR5/gPbvsmgdvafteUwsY5V1GgTfZo
         uS5g==
X-Forwarded-Encrypted: i=1; AJvYcCXaeuqHP45JYO6rhdZXS8q3uTVW0IN8T9z3khAp2nuiw0d1zB9Q7Q4RN0P2oMJAF/rxJMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI97sKEZz2ECbPPWl2BamrdtPMu0teT3JpwOXPUCHlqZt6KJIF
	zFI6muiE1esirc6nCWbry1lYm07qXpZAk7pYALsmxZxfq/GFv7wsroLa
X-Gm-Gg: AY/fxX5z9Xm6/FOtGgH7CM/n7+ObDttfLU45tMjY/k2ZeLvNYJ3mI2q+EOHz8uQYpgJ
	abiKPgzaTKn5wZmEyn+xBPRvJ+Tsv3G743jC2vuzWSJFjgAkIGAWBVcjs51c9H3xG2nFy2pVZeF
	orcQlpYSJERrQtoW2OTNS7yOKYbUaxzY189Wdt+g/LQlxXCRWtOeCDyBY51XTSB8Cyj4R/arWKI
	UIiwABVIlszrlfKBbHApJVObk0GWJsbaXRjM1Jy++SnMhIv0M0DjJB/jtpCs8Tax1hZ2h51lg2D
	zGfktfpYM6BYdqouHP+02uMhcAYitACNp3GYE/4lnLMtwckSQvqX+7mOvnXbVIpyyZbQftGGUfI
	Sp/owTTh6U/q78KgcifnV3pY1PXag0PqVWlGTZujH2+sh8owmY+pLWt83UFCxew0ETPgVv8TyBW
	B1bTjRUHUn7vWosWHlZLZtgX29
X-Google-Smtp-Source: AGHT+IGnL2xjS0GT/VWvHOK4H+jFG4Caomv3SQN7QcEqr0Gwfdq8sN01qehGzYICVgdBY7YOseFREg==
X-Received: by 2002:a05:7022:eacd:b0:11b:79f1:847 with SMTP id a92af1059eb24-121f8b14836mr1854896c88.12.1767791015447;
        Wed, 07 Jan 2026 05:03:35 -0800 (PST)
Received: from smtpclient.apple ([38.207.158.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24a65b9sm7985515c88.17.2026.01.07.05.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 05:03:35 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <5be9eb70fb41e7278771d9ff1fe3493444a7c33d28f300f04fb8e3be73005ec4@mail.kernel.org>
Date: Wed, 7 Jan 2026 21:03:16 +0800
Cc: ast@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 martin.lau@linux.dev,
 eddyz87@gmail.com,
 song@kernel.org,
 yonghong.song@linux.dev,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@fomichev.me,
 haoluo@google.com,
 jolsa@kernel.org,
 mattbobrowski@google.com,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 dxu@dxuuu.xyz,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 electronlsr@gmail.com,
 gplhust955@gmail.com,
 haoran.ni.cs@gmail.com,
 martin.lau@kernel.org,
 clm@meta.com,
 ihor.solodrai@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A68EC8A-3F7B-4CA0-B75B-195BE5E7495A@gmail.com>
References: <20260107-helper_proto-v1-2-e387e08271cc@gmail.com>
 <5be9eb70fb41e7278771d9ff1fe3493444a7c33d28f300f04fb8e3be73005ec4@mail.kernel.org>
To: bot+bpf-ci@kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

You're right. I'll add the missing flags to these prototypes and address =
this in v2.


> On Jan 7, 2026, at 20:44, bot+bpf-ci@kernel.org wrote:
>=20
> Would these helpers fail check_func_proto() after this change, causing
> BPF programs using them to fail verification? Should these prototypes
> be updated to include MEM_RDONLY (since they read from the memory), or
> should the check skip ARG_PTR_TO_FIXED_SIZE_MEM?



