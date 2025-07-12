Return-Path: <bpf+bounces-63120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C3B02B75
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 16:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35262A62DF7
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78862857EF;
	Sat, 12 Jul 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGrn0yab"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8126218ADE;
	Sat, 12 Jul 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752331126; cv=none; b=WJVcEZJUVdlUxRyIWkeWJhW95dw6qKwY+tdgYaYBeS9e4AT7546AkcXhDYslDTt7TXLLOoKlCEfGoe/dVItCXNMlxEFkuJuln31JtIoQJ4Do+GCy/0J1ak6VZ5eMqq3vkfw0yqmmnD8I0VVvEoAyfNqMQ5ccqGiLzo0R+baGyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752331126; c=relaxed/simple;
	bh=JL0yAS7YGbdfaUG0OW1m/bcaqjrSdvczB5r/M1DxKs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gw30tKGefrRN7oI8qslwAoMUDL1HxvY2bqgOU7b8Wsc+pfM6Us96HWiY1az1J0TgZdjMBm2MfhYFBr6SBYGbr0XprbDlSLtcxRUpeXGk3gklyvoU/UqyHfj/DnlWdzCQdSno0JKySG9oxKLea1tQKnK01YOe9emejD1SpIUwUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGrn0yab; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so5585162a12.0;
        Sat, 12 Jul 2025 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752331123; x=1752935923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koT4tW7sPR7eLhyX94iUXRNXGl+r0eUfBJKco6+0BRU=;
        b=GGrn0yaboY6Yi/ODmn5qaUtnT5tmqTH9lC7gZnSQbe4m2mKISXwbrBbNhJQl1jy/G4
         NaUaK4dGxTfIFULBNt5HKamY9t6EUGSeSPtorGIM5KzNaS6Hx//5OC6o3SKnL6qQgH6/
         Vj+npePqPnJUyX7xIBM1zK7KZBB6o6CZVv77fOfOGOtM9zAsODMr680pXb0QcgzKuQad
         It91lMTAjVoELdMnzcLevsK224Q7QHFc5g4GwbCaZtjakI9KwlwuZeAgRJI55OPFWij3
         SdwwbkhavVkgs5zgU49LxzfzZwnGcI2dc6sSEqkDN3gJYV6ieRnFiKT2XNM161eJfPtg
         sMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752331123; x=1752935923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koT4tW7sPR7eLhyX94iUXRNXGl+r0eUfBJKco6+0BRU=;
        b=t0eze/7iMgJEPah3JrIPEV70pfR+jp3eW1YghHvA1a2MNi2wHcLjok8IgfJ225hQf1
         qY0ZKRm5z7AYVFKfAfbXoW1/qxlKGwTPOQx/8PK/jpzUdIc6ixr/gbshsNbfZijjkmJg
         JWp2qThvE/pXCm88WO70JT8dmldj89eAtgoRtyGBFqil/XdFJUBBFxevX5E1OBcj83nn
         LjShnmrLu2HpykJb1EC7yyQWvBI2Blw5J/y7U47jiwAvyqx+D3uFDWdH7yMCAjZ1An5E
         s3/NMciD6ZoCdaiFX+smsJ62i3otK2RflUXs/T1rpGYMpap9FBuc94O6I039LSuJNxjD
         sr0A==
X-Forwarded-Encrypted: i=1; AJvYcCXIrx242aJ5VLt9CMgQxi2cnL6VPp1oA2i8DiOcRbSoc0wOdnf3DroyCTANXccuxqXlGUuqpP5Z1SNNHQ==@vger.kernel.org, AJvYcCXWx+StR0SkGvpDBHJDqJfASrd5o8j+4wn8Xovtv3PWgh3oIa/52oAaHPZ4Gtj4ASbKjA+JNDHd@vger.kernel.org, AJvYcCXmifwxQY6+45/EkhIRLEtG7Ot5R0VM7aglD4dN4DiJFNn3qkRMAQ6ffVskn8fRSTOVDTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnxVNbhsnX3qz+5brFE2ytU0Ib0eclV5hgJ/qGucHJDrksPi/
	nCxHXYZcn0GvY7qSTsrhk/4kvPQv0LJ5MyE8gnbMzu9arDnrzppsDhHM
X-Gm-Gg: ASbGncvqdIUArJPGxSh+kN0j3of4G0L/z7ZNKHTj5fFrxJygFQ4oVd2baoyGBK4fFXz
	Cciu3MNLAFHNaEuZMcQSKCKXC1leB83Ui7PZoN46yphy77Ki8RWLTX65cbmx2EBlQYxw3LkJAg1
	MD+XtwtaOKNfXklmnxehxvHlu8jlnhgpEw+84zO5oVmyD56qNFWdsKDCS+9wsWXNYu8qR6XEOrE
	Dx+ffuTMU7YGFFlmIDCWT1Ajh17DP6q6mgGVnTExR2b2GUAAzAldzME7wtHKECb56CAD00qQq3B
	Sc+4UdrROSaMInYjEJ51PfqzjB8k6nt7v1/S0NtKasL41fr2CJp6IG7q0HfDUMRM74O/CPzhU/F
	lCCHiG0kv1SOB94V0K8zA/YZfYQzVrsUS1u8=
X-Google-Smtp-Source: AGHT+IFpiBx8aoo3FRRG9yCk+2I/NQ1LWZmLvjhcwcllyNUx2P6pWdBml/WUBj6Iu8ouNjwUof8qmQ==
X-Received: by 2002:a05:6402:1941:b0:60c:5e47:3af5 with SMTP id 4fb4d7f45d1cf-611c1cb7445mr10377973a12.4.1752331122595;
        Sat, 12 Jul 2025 07:38:42 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:b2ad])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611fa28e1c4sm1806095a12.10.2025.07.12.07.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 07:38:41 -0700 (PDT)
Message-ID: <b1f80514-3bd8-4feb-b227-43163b70d5c4@gmail.com>
Date: Sat, 12 Jul 2025 15:39:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/8] netmem: introduce struct netmem_desc
 mirroring struct page
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-2-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250710082807.27402-2-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 09:28, Byungchul Park wrote:
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
> 
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, and make it union'ed with the existing fields in struct
> net_iov, allowing to organize the fields of struct net_iov.

FWIW, regardless of memdesc business, I think it'd be great to have
this patch, as it'll help with some of the netmem casting ugliness and
shed some cycles as well. For example, we have a bunch of
niov -> netmem -> niov casts in various places.

-- 
Pavel Begunkov


