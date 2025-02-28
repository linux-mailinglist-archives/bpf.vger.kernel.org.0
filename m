Return-Path: <bpf+bounces-52938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5134A4A69B
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AD5189C04A
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B21DED5C;
	Fri, 28 Feb 2025 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh9NIRYl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A951C5D51
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740785609; cv=none; b=qI7W/wAxQ9jW3iaH+c7UxI0co/QNYnQxkToUS/7QxDG5JwwprUOCE3u2azavm+gCzEueZ5LpTN1SeOZKsNSwpGbBqI1I8ZNVLK7dfk6bVgwGLU2vBa31vYZxpsGxVYSbgR+QXCF+RhKTEnD7Jl6L5jbY1DoxFtgIic2iJmyIUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740785609; c=relaxed/simple;
	bh=ykfp65bWyuc5H1E1ihjSbMcZIX4CluH5amMo6NZ5IJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwLm3mL9LDMOtSe8+hWURF3D6zV1AJnN59mi3dfoEZ288i8AumZSj5ac3qnrhITEui5JXAUI23Ru4MTQ04frRkC2OuLCdwd60mWNdaxacYxKQ5qPjDhqE2tWsnZKyF0pHoTLkOof1mR3EAtc1kLDhKPzmQYwgGFPF+nYvwxHGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sh9NIRYl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43998deed24so25302925e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 15:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740785606; x=1741390406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sFcxFViAGFC7IxqiGo6yMlaqfG9kPydHc21DOdQq/M=;
        b=Sh9NIRYleXbRKhlutQtIsa2CPsiby/QveGlFMtUnvPpCeY/iLKEYfUe0XBRWI2qHp5
         Yt3/W3O47c+E8O+wUEKHQOfbmbL4vy/mC0LEp+1BBhhqdPpVA5+6gUQ+GM6aK1m/iMhl
         UEATYUGyV9KfIpi30JA2dvxg4NyKdJ3o19llQ4/0HrOT2qHQprSZ3pzQ5qKU6JB/EuXn
         cQ989KmPPHWpO7wVhMBHr6WHVafy5h9DX++ncxeltunt1+dI8o38zrfdyZO5c1jJyDpm
         BTyC7H/Q9KxTmsybdM2AbbqXeN286IxYRE/2nlT0nkSVuS6eTdTiIust/pt9M/UVhFXI
         nlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740785606; x=1741390406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sFcxFViAGFC7IxqiGo6yMlaqfG9kPydHc21DOdQq/M=;
        b=uFSZAZHHxciYK5FzfRmk0TF3Y34ge06OK2GZFNA+y6kaajGz13BEC5+W69JdANr6NB
         rgE55xpDlOaZdlE9Sr4zVFIMY1ZF2CmcJGf1/rTVFQrdtVOrTJelY4hKBGitqh+9dse2
         vDx8Wsbfpr5ta7FttrxsuDtLXvx/CH/L5wXu/YaNQ4XtnWqB7Uz9XZvex55qYOZ3lZXI
         DXzA5M7e3wYkuknwaZmPXAuEEoVwnGesGQEaaPJ2EfWcTGCh/cXLc4X6rV2K3Qef27OX
         tBQJwTspyNW+U0VfhRVozd+5KZvvwkQd7Z5hZhxnGM2Cq+6n9Tu2CQvOqNrplYSWmszI
         4I4g==
X-Forwarded-Encrypted: i=1; AJvYcCWaCc/saPgc+8DJ3Rjbgxzb3Q+eOV2SRM5IuWUxoLpFCD6U1yBD2I40vozQsyo3VamKYjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzik/5G9dKQc/YfYxMWa46tIt3pfFtXIDoMwppFel6AJ0RhRlEZ
	uuAi42CcDjOxkt+sZicQszJBRgsm1FixgWD0fh3El1gaQOf954Pk
X-Gm-Gg: ASbGnctTk3+mUUCjF9qMR88ZtnfK2OBeM2cNjvEg6PNtILQsVt7zvkxsA8SiNlvu+a4
	FC44MXkzTgy/EHGHcDZykVa76tgDXlWQ6rpAzBhaPTrg0kVSr9Zh6VkjTyWgcFbG1k/BjLg+2ee
	AD36SUydCm0kcXK6TFVnO3j9ENH45Ppu38IBm/h4K+6P1wnSNhcxDgXRLxaVoxCghf8xstjJNGf
	XZw+O0WtgnIZjr/cSY+z1wEdsormlD4WPPiNvTfmiRUmDa4duNXGVzjUWjB1iFO3hfZSkXubUzp
	S5AeJGr4ZeZ5d22Rw8Dpv4nRc8NjUDC1XWItIhWyNH3rQnw2jYqhhoNbCaAD0vne0o8qVDPJPM2
	Ql2O9NdEQ1poP0Ef+ZZokKyPc3BOnRZt0TVPMBJd/
X-Google-Smtp-Source: AGHT+IEfArbB1fQLW9VXIN1/Y5dNo8cqqPEdKtAg4HS5dhkjygRsTX/21bQ6U51s9FFn8ZCcHDt76Q==
X-Received: by 2002:a05:600c:3ba5:b0:439:9361:13d3 with SMTP id 5b1f17b1804b1-43ba670b6ebmr46975875e9.18.1740785606037;
        Fri, 28 Feb 2025 15:33:26 -0800 (PST)
Received: from [192.168.0.18] (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b88asm102795845e9.4.2025.02.28.15.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 15:33:25 -0800 (PST)
Message-ID: <3ee39a16-bc54-4820-984a-0add2b5b5f86@gmail.com>
Date: Fri, 28 Feb 2025 23:33:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/3] veristat: @files-list.txt notation for
 object files list
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev
References: <20250228191220.1488438-1-eddyz87@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250228191220.1488438-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2025 19:12, Eduard Zingerman wrote:
> A few small veristat improvements:
> - It is possible to hit command line parameters number limit,
>    e.g. when running veristat for all object files generated for
>    test_progs. This patch-set adds an option to read objects files list
>    from a file.
> - Correct usage of strerror() function.
> - Avoid printing log lines to CSV output.
>
> Eduard Zingerman (3):
>    veristat: @files-list.txt notation for object files list
>    veristat: strerror expects positive number (errno)
>    veristat: report program type guess results to sdterr
>
>   tools/testing/selftests/bpf/veristat.c | 70 +++++++++++++++++++++-----
>   1 file changed, 57 insertions(+), 13 deletions(-)
Patch set looks good to me.
Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>


