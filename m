Return-Path: <bpf+bounces-31189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269818D811C
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 13:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D544228501D
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62984E0E;
	Mon,  3 Jun 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xha9/jXo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B184A35
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413774; cv=none; b=PuDSqPcRdPa4FPA3prsLDAT9NNq/Q+Sm8nl6qVvFTaIiWEKGpIb6+tFv7COeL7MjUzKLX+DZbJoHhU3/boh+peuw40brmB38GESzELleH+Uu0MINaIUEG1s6xg35diCQUltabBXb6z4KHiSuvgim6JlbncbK4qN4IeGlSUXlBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413774; c=relaxed/simple;
	bh=G2AXoJWTaAoyfkfoCz6ZyOinQKV1M5bcGxfieTviH68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjd7AxsWZ3DLpoFM1tIe+wv4wAdt7U57xNHmCDxaIdzlHlytCfpKx6Qnu2wotwpWCO//AF+8P5CNT/plqxebntVClr7tpDBP93P5ugMHpr+tw4CV7ariAKibkMUKYJz/tRRkTWDWMGVmpspC/2zmJoiW799hG3YQt5ACtr6iNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xha9/jXo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68b334eb92so76827866b.0
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717413771; x=1718018571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3mokEQDy1RJCGWxi/+5KZaqblRGioaxI2aR7oEqy/PA=;
        b=xha9/jXo1582QkEMmSO0qigK8gEjcS6YYgLTnDkrk0p3BuveqB4Q4uOEoFscn3kysS
         p44h9p9e1U5uNWsXSRrcHVRVEzAveI4FCXI2SChb+/nsryXtVqQRfvFPcxHtAiLffs+4
         bAdpH7u2hJUXYhtfkGKS7tOIo9zPf6H0fgLeLa5W8sSejXBN1Szb3tTL8NnX4/5YG0hB
         fyzaKl5QcpKZGYnFWRUx6CzVlJToo4gzH3aEpufC4Wwky1RLs5fuNZ6QukFsvc9SdlRc
         koVQKguj5qD9barMYQmcA6TOux2a9vC5nCudcvxytDvKoq6mwSC3PCh8zwDlhdvuIZPp
         LuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717413771; x=1718018571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mokEQDy1RJCGWxi/+5KZaqblRGioaxI2aR7oEqy/PA=;
        b=uV//+R/LVEbh1yKzbvKDK8nTthWZUdUxuaPHeXeo3eM+aPcxlqKWPeMWvHSGKABq0W
         xqkXHuhq1xnAkKwIUgH9yzwGpG/G9O7BofGmwSHBHcbgytcFQ5V3HQozGWxZqJCJhMdG
         LGIwgY9rFgjiEDHpLGsOdqA6nuh6KbRuGI2/XCW11LWseN9yNK29jydQjOl2oQrdXW4/
         RnV3Wd4D18rlwmjWMNY0Ze9RjPWyOE5POzPRY+nv7XniutAXZOoupfwNBW9Z8gb3499N
         TiZ6DsfD+6RxAo2CGd9NeeGC8coD8Ed6k2IuOzzyQC3VZMdf+1aawvINeuGjdKiyPVSq
         y2+A==
X-Gm-Message-State: AOJu0YzsdH+2zY6zq+STCxcSyIoVYQEs8B4H3GAYYYOvqejfPudmUyJG
	HF01jmHDDn/DrVxMdnPS2zUp/HfNUooK5SA10o72/QwezX4bmttEpSysEcZZNhg=
X-Google-Smtp-Source: AGHT+IEJ4JA3WwXxRNNtwtkc8f/jOeCsVusfaOUAAy0TpjcK1HBjOvNwFwECFmM8qTbQEqHACqOscA==
X-Received: by 2002:a50:c30b:0:b0:57a:2763:c29b with SMTP id 4fb4d7f45d1cf-57a3647ffecmr6309974a12.41.1717413771268;
        Mon, 03 Jun 2024 04:22:51 -0700 (PDT)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a3ebc6751sm4490452a12.51.2024.06.03.04.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 04:22:50 -0700 (PDT)
Message-ID: <68e734cc-c049-4414-a8a8-47151a7f650d@blackwall.org>
Date: Mon, 3 Jun 2024 14:22:49 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] vxlan: Fix regression when dropping packets due to
 invalid src addresses
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, David Bauer <mail@david-bauer.net>,
 Ido Schimmel <idosch@nvidia.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240603085926.7918-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240603085926.7918-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/24 11:59, Daniel Borkmann wrote:
> Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> has recently been added to vxlan mainly in the context of source
> address snooping/learning so that when it is enabled, an entry in the
> FDB is not being created for an invalid address for the corresponding
> tunnel endpoint.
> 
> Before commit f58f45c1e5b9 vxlan was similarly behaving as geneve in
> that it passed through whichever macs were set in the L2 header. It
> turns out that this change in behavior breaks setups, for example,
> Cilium with netkit in L3 mode for Pods as well as tunnel mode has been
> passing before the change in f58f45c1e5b9 for both vxlan and geneve.
> After mentioned change it is only passing for geneve as in case of
> vxlan packets are dropped due to vxlan_set_mac() returning false as
> source and destination macs are zero which for E/W traffic via tunnel
> is totally fine.
> 
> Fix it by only opting into the is_valid_ether_addr() check in
> vxlan_set_mac() when in fact source address snooping/learning is
> actually enabled in vxlan. This is done by moving the check into
> vxlan_snoop(). With this change, the Cilium connectivity test suite
> passes again for both tunnel flavors.
> 
> Fixes: f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Bauer <mail@david-bauer.net>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  v1 -> v2:
>   - Moved is_valid_ether_addr into vxlan_snoop, thanks Ido!
> 
>  drivers/net/vxlan/vxlan_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

LGTM
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


