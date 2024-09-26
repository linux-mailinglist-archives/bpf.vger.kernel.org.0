Return-Path: <bpf+bounces-40367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EA8987BAE
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E065C1C22906
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 23:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6CE1B251D;
	Thu, 26 Sep 2024 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzC6TM8L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE41B07AF;
	Thu, 26 Sep 2024 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727392898; cv=none; b=Tj2pgJpHSSdeFO4LNKckCyI+NXa9VAweOZd8U//zTogDmroYQdLoXuud0nzoWtqQ9jcsXV7MZoKDPUAend8Xs6Aa8eqDVyicFjQ99XBX0B6aciVrNB7qntRHhECvcJgBJ6bw3pBInl2mLFBoYC2Hlqn45IDemUhHlQNAdL7xgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727392898; c=relaxed/simple;
	bh=iVsFIGn0iXjuhuu6kaEr4e2KKsQ/k7xOHLW0xF+DNoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O24C9T31RrA13a4d9URm4PG/yzb87cxhBrIuDF0YHNCB8kxxo6ID0mWezJ/NmeqZBJiQHAR0jlklWvJr2vX2juYuyapDyeDv+xTwGa6a/FkLJdQye56WJfSNQi/eHT/HC7NzgCWBMoHOaJCjvfn8m8l678N3iUQHPenigEetbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzC6TM8L; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1036893a12.1;
        Thu, 26 Sep 2024 16:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727392896; x=1727997696; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iVsFIGn0iXjuhuu6kaEr4e2KKsQ/k7xOHLW0xF+DNoQ=;
        b=FzC6TM8LLwn4CdPWw2tO+7aQYZB4mFEQsuhk2od7S6kH7FEyuHe0C2wxIpmUyRaVIR
         snAvYSK57h4B50Pf1g0dRMlvazgfEq1x9SV6wwYkNXyk50XrG8ls7WvPbFdn39zJPMnr
         +yaOGSg+8rnPV5qqeDdHDb3EbLsWSnoNj2IqqeXI9i1GbIaKB0Y9Zb+T/5gOiYfe1uEd
         QnZnylBPeYKj6YSoMcNOwsCEMCywmA6W6Hkm9dXkClazuCeMj9F83jrLUSX5YPvBfzOx
         Ku2aBQoemTzIscNR2g6Hwc+hJVAIZs2WxItac5mi9eDEkJP/vI8LMWzyk17PPFs+RW3l
         zBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727392896; x=1727997696;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVsFIGn0iXjuhuu6kaEr4e2KKsQ/k7xOHLW0xF+DNoQ=;
        b=updaED6TLYxww0EDMo4LPCtmTUPYKGa1u8DgHb3a4FOHm5GJ8Yh5cX4wGqIEe0ASP8
         dOCMxx0SPe/tusZndfag+uqi66fr4dn1RQDZ1y8eumdhBZQBwryX3HCAus90ImDcpRGI
         MD4kg/FyuhH353KUDNUXveBXG9pFVQteFfQR2iyx1+p5myQTn/WheDKCWN+vqIW3SoxD
         0IYGYOO73kKVodO8v9htXzaLmsacDBCa8R+CjqYpcy/EAUQieYzN/gCHShiBFUduTive
         IzFAp4oaX3VwLO8ZxQadrwWjl6wiE4PS278jliVYMHKBl1ayXKs06T9hvc4nFYaUXsAk
         qQqA==
X-Forwarded-Encrypted: i=1; AJvYcCUU42QuaEn7iZKLRZ4D7kZ6O9HYez9oxXGomFEtYctVJoQeZOEP7W6g4zZVCXp8+Yr6nlxvW9y2tE+gwMeVcX6Z@vger.kernel.org, AJvYcCWX2vhdEaftkjTgXMXqgZKBwK7gCIBl/MieJ/VMZVLUbDPjZV5T0HEusqWqXmUGQm5pZG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYowEBvgojsKaWbAiRJOd9SYmbQXGzd7nJ0ZZhy7UdpJtZWlu
	Hx0g6XYR9lM+jMlX2gAkwyI+YWSzgJ1XZ70oTPP4wBTvHAYQByx0
X-Google-Smtp-Source: AGHT+IGupSm+6I7yushU64/Yc/nfwmCMy41lUbNw0Kw60E5UuJZjLwHpBijQmmEnuYIVntfWBGZTrA==
X-Received: by 2002:a17:90a:1f44:b0:2d8:ad96:6ef4 with SMTP id 98e67ed59e1d1-2e0b8ea5e9emr1395059a91.28.1727392895941;
        Thu, 26 Sep 2024 16:21:35 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16f67esm4131242a91.12.2024.09.26.16.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 16:21:35 -0700 (PDT)
Message-ID: <d594f27e7782b318b8eb90fef202d4cfdce59da4.camel@gmail.com>
Subject: Re: [PATCH] bpf: Call kfree(obj) only once in free_one()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, bpf@vger.kernel.org, Andrii
 Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, Hou Tao
 <houtao1@huawei.com>,  Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,  Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>,  Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Thu, 26 Sep 2024 16:21:30 -0700
In-Reply-To: <08987123-668c-40f3-a8ee-c3038d94f069@web.de>
References: <08987123-668c-40f3-a8ee-c3038d94f069@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 13:45 +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Sep 2024 13:30:42 +0200
>=20
> A kfree() call is always used at the end of this function implementation.
> Thus specify such a function call only once instead of duplicating it
> in a previous if branch.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


