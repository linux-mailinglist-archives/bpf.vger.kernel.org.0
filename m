Return-Path: <bpf+bounces-41792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC1799AE88
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 00:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D3B23087
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E631D1E95;
	Fri, 11 Oct 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmmwfeDn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796291D1E72
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684669; cv=none; b=FdoCOYd1FTZUe8t4UR6XDrw1IrbbpqOVYqXx6G1vrgRuy8Dy4F0/n9ugUYkn5Y+eM9i5mr0kKFJzfdCmBOXXvQCKUzOtcMUdO3ZpI67SQvmKKcuKRSau1BR6ZvTwZIQhVRSf6IvjuJNkwm6VF13GEcpszXPV9+jf0a65Zc9aGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684669; c=relaxed/simple;
	bh=VLezwHP1XLuTrJPsKV31DFExz1lzRGUtbSf3XdyU2tA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZdLIJnV9HUo9W+skA0u79EnO17+nZONNfbIj1j9p1F9QXLYCh5iCUJtGduN7cbWUJSqMeBydL2b+Dc/BS7TqH5IF4oe7PEkwrl4xC5ldFN3cNIoHWm/5X1U69QWkTfEwJLJ4d/ARJGhD4vWjjLV5uDXFHhcP5XUoTS0wXJDN40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmmwfeDn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e30e56ce5so1405765b3a.1
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728684668; x=1729289468; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VLezwHP1XLuTrJPsKV31DFExz1lzRGUtbSf3XdyU2tA=;
        b=MmmwfeDnDHDQXgR64u8Md8ZiPv8kWViP4YKdMnPyr0gw/4pY8MJ4poX0+JPTVRbom4
         fO426fgE5uN70FipI5EB/B3oPe2Kssuxx+lBLyzRBx2PEzSvHzoOfsIVot9ixHz+kHki
         rD3Wzkj4Hp45XUB84H4ae9MqRvd4QFJm9jxyBt3QbF2wEJSyMsr2r0nyTBl3rE1+0ceQ
         NsK9x+aShR8lPKRLidELkVv5cz+q9kJQwcY3T7Vbktb0Ku4ZJWTowFxJ0G/NP/0rF83V
         g083+lSJeRcsQdo2bA4Lg9bQpapPB5dXteKMFOLrbq3jBwwEYmpVKMMIRqf2BRwedgLU
         fcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684668; x=1729289468;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLezwHP1XLuTrJPsKV31DFExz1lzRGUtbSf3XdyU2tA=;
        b=dj1r8mKuX9e96LE+MTHaVN07B3fxLKj/i+pg/GmgmxID/ySFQKfRPrqPC2qwjlVrl3
         SLNu3K/nJibc6gChtEyxiawsEz4US9OzZfRU+dH7YVjGOvKhlxRemcUe4jcyikPKhtQ9
         E5sXSaWuf2r8LCD35PE2PzW9kuA40rGU8EuAe3cFxD035LDH1kANPytcBAJeOO+i0PjC
         30kR82bZMc57Fz+05QXNkuhAknvzWTtDokeWmmi28SuVXsBMIJPJlYp9WjicdrPX1WRp
         gVVUyQz5QLiQvcaz/aN0wJ5MvdokVQfNzqN8PCrOlHs54pURDnTdJFQ9g/r9wWfG0Hjx
         YA0g==
X-Forwarded-Encrypted: i=1; AJvYcCUeBbwXL6lrnn3kiMEX34sBAcdDA1kK/IMaGDsvJI+Vg1F/bQ0Um9qPuXwn0EagXyDrhYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3qnNzG2l3hgKgnNbtTUwKKWcY71a/8Wz8tFijlmkjkhI1OoCp
	CGAl074pMZKCvdUhuAI2/X/iGe+nJOPoyINJR9BadeJJdR2xC1+n
X-Google-Smtp-Source: AGHT+IEMZhmJS3XDtzXny0ickzz9ITf1XXoh8ToQBhz8UPAdTtD/XOx0R9Z+66eGjbCXdp+oEBo5ig==
X-Received: by 2002:a05:6a00:b87:b0:71e:19a:c48b with SMTP id d2e1a72fcca58-71e4c1cfc30mr1487885b3a.22.1728684667653;
        Fri, 11 Oct 2024 15:11:07 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e9843sm3113605b3a.24.2024.10.11.15.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:11:06 -0700 (PDT)
Message-ID: <2fcb579b5f35c600c542f677da94e0e9b30b6199.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/16] Support dynptr key for hash map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Song Liu
 <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
 houtao1@huawei.com, xukuohai@huawei.com
Date: Fri, 11 Oct 2024 15:11:02 -0700
In-Reply-To: <20241008091501.8302-1-houtao@huaweicloud.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 17:14 +0800, Hou Tao wrote:

[...]

> As usual, comments and suggestions are always welcome.

fwiw, I've read through the patches in the series and code changes
seem all to make sense. Executing selftests with KASAN enabled also
does not show any issues.

Maybe add benchmarks in v2?


