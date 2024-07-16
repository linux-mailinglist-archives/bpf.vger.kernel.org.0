Return-Path: <bpf+bounces-34902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F693224D
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4471F22EF3
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D32197521;
	Tue, 16 Jul 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EJhp2gdq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C86196C86
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120209; cv=none; b=AQczd3AvJEBL9KKqLvc0tJYme/KgduKxmDVS71OhN22L2cJww6e8gCGWe/WMKXSXl7amL6PV7hOhFCLaDWRbTC7KV3T5byXhAJBzZrkRXanDrAi5IxmiBNWQrgRVLH2JXZ48KMRrveuIrBXyuORmbJF4fH8lbzGwiPNyoPs1kbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120209; c=relaxed/simple;
	bh=kiF3sV5Dm9ZnV4HVp8NFD24MI8K4flPgVeGxlGDhwEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMjNUmIU0IueFTOacOu806SQAc9wJJMk5poJFZRa/ig274Vb1ZHiypKU+5+UN1gW1urY/4YVRhR8+sKgo6HzrGzdC/MSfouvWf5acCbcHSJYS7w11fyf+8NYBfvkX7kHRtAffkjfNdKa6IEcKNxGhhG2i3CrJZGf52u9qKF8/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EJhp2gdq; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eecb63de15so57622471fa.0
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721120205; x=1721725005; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kiF3sV5Dm9ZnV4HVp8NFD24MI8K4flPgVeGxlGDhwEc=;
        b=EJhp2gdqx5PUKDkQqxc57/r7xxwH+S6ehlHCgg2OlAqxQ52rzgJEJaMFrjY+V+SB40
         od5YATii6XRnUCkQ/EjtL9ybehzw4fEVjEnFaJuOWBvM/e1nDubE2Okse54aTOzPJQjr
         JSPF1edtnBBTt9r3070uoFROw5RfY//kP2lv6nZr5uwp59e1mkb+MwVIOgqRcgwvg+r8
         KWHKONGLdItnoJOxuVJojR1TguTUdadZ9uck8EiY9kXFz3Kf5IdItTrPoy4rObBeWGeN
         JE5lgOcgjFa8AGO27wRgoKDTVAex3/wM4z2RiEAzcfyxQ0iy25oCVUau4qEedcNglxID
         a7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721120205; x=1721725005;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiF3sV5Dm9ZnV4HVp8NFD24MI8K4flPgVeGxlGDhwEc=;
        b=g1jmLKaxW+LUauW2TRT38o2zfd4KeernlFLOyH08mheUlK8n4D5Z38jenN/0dDSuQi
         Yn+0q/3sFqcGByimK4ShpPj5r/ICbn4xUQmqUJKUzdNmAtOQmAbtyLPv+44Y9acKNs+A
         IYhHMELdBZgh+o7wkuqy+VWqBmqydrYGCpei7WC4pq59m5m94c5u0vvzVoVdmkH+1ykb
         vaTrA/T/185B8/vbbNDiOMVUtGS7RbH7bvCSMW6B+j1XoGLzAfRzjEsdfXEafzciqhH9
         qsqEbYjih1CzYZFo52x7/Ibe4RK07LWatTZzljAyrDEBXcO1ApoOfN32aAL/XbWV2n6U
         QQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUigxrjadoh+AhK3opyapSmjBX5/RUhyjHdczNt1xega6KA6nu4c53bsqTd+6hJdGapak1xO8QBguSBjiUb3Uof1t1P
X-Gm-Message-State: AOJu0YxBDSuCVGgU6zB/mQQY1QhBJuKzLnc5dFyTf6DfSO1huL46jBap
	0OVFoXxfAEODZdCXrexKs34Kzk7t+50pcHcBa1iudFxr+7W1/KvNnFhP9GEUFrM=
X-Google-Smtp-Source: AGHT+IEQdvfuDxnJ8etOegtPB4r50Dk6zmxNfwinuC9zKCkA005c6mFjsFKbn8ppT0aJYq1zUboTcg==
X-Received: by 2002:a2e:93c9:0:b0:2ee:7a3a:9969 with SMTP id 38308e7fff4ca-2eef415b577mr10062401fa.5.1721120205470;
        Tue, 16 Jul 2024 01:56:45 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a2760sm4510302a12.64.2024.07.16.01.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:56:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v4 3/4] selftest/bpf: Parametrize AF_UNIX redir
 functions to accept send() flags
In-Reply-To: <20240713200218.2140950-4-mhal@rbox.co> (Michal Luczaj's message
	of "Sat, 13 Jul 2024 21:41:40 +0200")
References: <20240713200218.2140950-1-mhal@rbox.co>
	<20240713200218.2140950-4-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 16 Jul 2024 10:56:43 +0200
Message-ID: <87frs990l0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 13, 2024 at 09:41 PM +02, Michal Luczaj wrote:
> Extend pairs_redir_to_connected() and unix_inet_redir_to_connected() with a
> send_flags parameter. Replace write() with send() allowing packets to be
> sent as MSG_OOB.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

