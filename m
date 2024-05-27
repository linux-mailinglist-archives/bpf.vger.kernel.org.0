Return-Path: <bpf+bounces-30682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D88D08ED
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 18:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E161B21BEC
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74015A84A;
	Mon, 27 May 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmetlfBs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256586FB0
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828405; cv=none; b=brjkwcyZLhvkfKP2lMC/ad/lDxG7VkuRHPrDOm6920mp4XyTgsNTSIFDGdV+yoCGtZsqP/GjyNuwyNK6c3XRj47l1TcQ5jsfi6vaTQRGo5Z9CYRzxImD6okQ4d9yrp1aeS1dLkdjfpq/TfNT58hhmmKqKdJvBivKBUH8uAtQvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828405; c=relaxed/simple;
	bh=kSKxzD0TO6MixkNeOBipSVXOJ6QhYzQc+05dxr7l0nc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZSphHlQzVl+xrHgvjJD3zEl4R98fnqG10gqqZpNpAFGWN8XV4K7iZ9SkkCfype4dyDmp6kFXa7mggWmqOG+ur9CTcGJHXzGL27xREQmQDwmdSMZYCINImALQZcDKyTtlykXGuKk64IuVsDsXIF/OEi+/z6Mbv6oty8DcLGU1WMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmetlfBs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f6bddf57f6so6675856b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716828403; x=1717433203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CN1yXgDv0q770CMAlPmv2vFKhcX/cQ37/AiCZKn5pU=;
        b=EmetlfBsmw6GcVtBdcMQ7B4N2nW6t9Xbozk6ftVEcLq4cnMlD7Oy5TSGETPGWO1VS3
         LL6FQ+P37cFosueY16fkrGBgVViItzzErFKvWnQsiB4u9UPA3d+qjHHu/NtiqvLWX3/n
         X7orLipcknVnnZFsoIM1N6Nk4BkITS/GE7Qq71yeF7jaPnLp5+mEPCHleCqgylUld62m
         hg3usTo4waYWHa3wzDYu45lK1TkIO15gYu42AlBAMCIGgMgEImRjgmVHt1Aaiee5hs7p
         MqFb4nWxgZpQSYPWUDiE5p+TC69tm1azchhg3zxJH9BR/g4FHDceGElRIrMksO8CNsA9
         9tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716828403; x=1717433203;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4CN1yXgDv0q770CMAlPmv2vFKhcX/cQ37/AiCZKn5pU=;
        b=ua++zi7jdC5Ap+aQVQ2ItSZVGEeLtlgBanLiFaws2DYFuuDZmRH+OX1wvkgsdz1+em
         qKWWCWP0I8tBqZfj9wrHcTibLohzO2SQzzAZbRFCL6A/DTPMcihxn+jZ3Hzj0S7zTz8X
         8e6NO4tptQV21qMXNrkF5tHuzBnBI+C/l7rXelmmSotqUxE5JbwoqqoDnMzoAy29/BLG
         h2KHrF4tEXtgPZYKCdZMm8QA96RACbQR/kzDdW2sBqDTD/Sm9TsxEUo1CIACs2w7HiSz
         6a/2GD4kWaBzd8v5cneq9Ceye2GWuo6dZWzzpNBl9Sbw+DXxaDBAUSyqRpbpeUXUsUWd
         2cpg==
X-Forwarded-Encrypted: i=1; AJvYcCV4mUYWQv4EmU1h8d4HMiYZz/cy5UQX57RLm6mFTpO+otr9IwptkiDp2T/0fD5alLOCjhGioOYIp9r2pg3NLokJVPOk
X-Gm-Message-State: AOJu0Yz/dc0Mu9VcgvHND8exVz3kn2LybH1UTIWeKhI29yHaTaGMrW6a
	uOZv8cRcL2Ced7xb2lP9z6VgBoKhiUSXNz5M3CYzrpjlCfn0JXJ0
X-Google-Smtp-Source: AGHT+IGYCDG5cLW1yNoclCcOM3FJwQwwVMlBpt9ec6MaEy0/0dkSXbH+SSSCb0OpmzO3GiatOkR5ww==
X-Received: by 2002:a05:6a21:3283:b0:1b2:4834:7a24 with SMTP id adf61e73a8af0-1b248347b96mr1276087637.45.1716828403115;
        Mon, 27 May 2024 09:46:43 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701bb5cc73fsm23832b3a.121.2024.05.27.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:46:42 -0700 (PDT)
Date: Mon, 27 May 2024 09:46:37 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Hillf Danton <hdanton@sina.com>, 
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
 kernel-team@cloudflare.com, 
 syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
Message-ID: <6654b8ede640b_1c7620871@john.notmuch>
In-Reply-To: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
References: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
Subject: RE: [PATCH bpf 0/3] Block deletes from sockmap for tracing programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> We have seen a few syzkaller reports of locking violations triggered by
> map_delete from sockmap/sockhash from an unexpected code path, for instance
> when irqs were disabled, or during a kfree inside a map_update.
> 
> The consensus is [1] to block map_delete op in the verifier for programs
> which are not allowed to update sockmap/sockhash already today, instead of
> trying to make sockmap deletes lock-safe in every possible context.

+1 thanks Jakub. This makes sense to me I've never found a use case for
deleting socks from a tracing program.

