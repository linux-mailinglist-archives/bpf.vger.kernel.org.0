Return-Path: <bpf+bounces-45598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0159D8EA0
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1238DB26CCF
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB951CD208;
	Mon, 25 Nov 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFWlotJB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC118C018;
	Mon, 25 Nov 2024 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573957; cv=none; b=CtCRkHpKNqkJd9b7yrekswoXGnxRJ56WlenQxudktral9AT4SCT9idNR1kRPCByn0BHvANiu1IeFTUU53pYdmKnQyyVjn92fxZr97Grnn1Bf7j5Q38lLqaOBp5hnQB+ZxdQ12Rrd/z/xQ4QQC/GaZ1wxYvP/pO6hQEzFnJw7lqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573957; c=relaxed/simple;
	bh=4TRsrywIbtjl/c6JKC9wgMdaNPJBtQHay9lfaqn9+aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yd+QROR+JjILq52+48xKDNVqhyydYEhC1YFvqFFVP5+A+saC4vAu6OUiFWpvudRJbqNZKCDB4x2ZZRKGlvNJo/oH1lYQMyjiEvVHVixzO7aE8BIoAKZO3S8m4JC0L7FVjOkq6UR+FXtOIw1LGdsT3AjYqsgwAW0ptnYwbIoKo/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFWlotJB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3823eaad37aso3733018f8f.0;
        Mon, 25 Nov 2024 14:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732573954; x=1733178754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TRsrywIbtjl/c6JKC9wgMdaNPJBtQHay9lfaqn9+aE=;
        b=bFWlotJB8i35tD4wJFgi9k2uGRYrynC3Ku/c2cUuKqFwnXBNlVWiASCsmfoGiWw9UA
         ST65BOJtjKiekfXBxV9KeoyyU3KYszD6fpiI42l2rKY46+ZdFg3J4riSgupZERvKnujS
         6AMWJIk+N5uSIZSUNMgCj6kUNcnyPrRcnQQ7sUIHuGVIpzBxbCXsYe+INHyB9eJWdPeR
         6fAy35C4SZIbmUHOTpeX6+vDI/alP97RV9L6YMLzmWwByVXOPvnM7PO3aB9lHBlZN1Ro
         JiGCsfx6zNeH3u40EhD50lx9zRuMXrtqChmISpVTJAFEImoXVZQXDa84aJgSB5la+X6c
         l2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732573954; x=1733178754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TRsrywIbtjl/c6JKC9wgMdaNPJBtQHay9lfaqn9+aE=;
        b=jVVok/vrQTWkgSTm9XPRzXONupcrTp59xVH+0G5yVY43ZteYONYwzvgNoluPoV2v4K
         auaQNC1l6dybJKr3x30L2HlzcEIPET4uTS3pUOv/Ou4lE2GlEKzfkLxXgLm2ON662fFZ
         is2R7suc9wWYkAgIX7PD2Dd99XXv4JDtgH0ThWtWWSkSWVVkr2Vy9zhguvP8r6VMxtog
         xZN7M76qmDCdgY7/j+yTlzIY4JkLhpL9Awem2S3svRb4AM+R8M+/PNbm/VG1RiVBxNz7
         BRzUfTzPi7M10gjfaEltWGGTF7uTYklInJKtHMSSUZHJNHSMeonATCBnTpM9NKDWZzd0
         /4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWWBJHMZcnDXX1srsmavV2eYdTT8tG8FZJIbbGdNnTZ6OPJnAddzwRrxGCILVqWgZ6JKFXFE77ahFgGPdOW@vger.kernel.org, AJvYcCWemmjQMCd7bC+fqTMx2qs6OYE7l8ps16D/+qWtFFwas+q5+vhBHOcyIDgHNiLWW+osMf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfKrIivSm3leqKAmBKu64b8n8G0K3KYyJ2TfP8uOdb3jIt4Gx
	paeNabQF02tnhon+9rFisn8gl+ZrkdRRxtEfnQMJELGEGcVd4iOC7Ph1pP/zI6A7vu0v7z4AEG6
	RhVkg3/7LBfTZX5DRTK8GkE9AxLQ=
X-Gm-Gg: ASbGncusoMsq99nGyMhCBArQiIe8p9qnq0eBGAqw3l6IrnKif18YeW9IPYdizILfyh9
	ZUqEoxHCnWPEPZxsI3RHJFe2FXIAdDJsKUMlpJAzJSjMOVbw=
X-Google-Smtp-Source: AGHT+IHcLSyztw+WyvvdvU1YGVMNVWPtL66vGfR2kLPwi0V8BlgHgiSeamEpI6LCs33pWL2RLg71hxm5o1YeGR8e95o=
X-Received: by 2002:a5d:47c5:0:b0:37d:43a8:dee0 with SMTP id
 ffacd0b85a97d-385bfaf0c57mr963099f8f.17.1732573953971; Mon, 25 Nov 2024
 14:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121121712.5633-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20241121121712.5633-1-liujing@cmss.chinamobile.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Nov 2024 14:32:22 -0800
Message-ID: <CAADnVQKKReb7C9xMoMWjCfZU=kfdYCfW3MXjWL00or286SVLzQ@mail.gmail.com>
Subject: Re: [PATCH] bpftool: Fix the wrong format specifier
To: liujing <liujing@cmss.chinamobile.com>
Cc: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 4:17=E2=80=AFAM liujing <liujing@cmss.chinamobile.c=
om> wrote:
>
> The type of lines is unsigned int, so the correct format specifier should=
 be
> %u instead of %d.
>
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Please use your full name.

Same issue with another patch.

pw-bot: cr

