Return-Path: <bpf+bounces-66098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE882B2E2F6
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D0A16D6AD
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12399334364;
	Wed, 20 Aug 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVZdys1b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4536CE0D;
	Wed, 20 Aug 2025 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709607; cv=none; b=FuXofJr2WF93xXdK5kmFS/jumgsR7VvW7pz62vYuU7LzDYi/zXKymo6pfC9DvyZLvur6pCUPoWGv2QbNam8cy4p41xZULKcOcFb6OCA+q0C/ZcUueYyUvSvdj6Qi0VAyLE8VSHcrLgrDkhxFYLWd6VxV+XJhYLtZSgXkBEYP5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709607; c=relaxed/simple;
	bh=IQUsg5cvVqy3HqgYcOB3CxMyauJ9YJlgKAd8e1YvGDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNGNQbx1xvBEopVqTEMU9Sc2oIOUR3n8QxOG43s7Aaqm5Y17xFjwheFXO2FlYZU3KcY/haC+MRfZmlAE2gSIRosBvA8jJney/UEz/QWE+BQbwWkuohva6+BsMszw5wRzLUavoBK79ZsZxrtAxWO87sEQuuz8YcZNuWkc79Xq0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVZdys1b; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b472fd93ad1so32405a12.0;
        Wed, 20 Aug 2025 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755709604; x=1756314404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8W8/wWuM+A08MdToSUhnUGmguQ8smfR5MJmNoOHi5O4=;
        b=AVZdys1basU8tJKaazvOh1WKdTRxo0YnCSUCzfY1TiGiwrHqG8Krl+72nO8hdqKKkI
         L8bUEu6Vp73rMdSxIidEmPGSjiQNrZ7pDOgAyuF7a8rbNszN3b8AqgXVLxo6n4axHr4F
         w7SK4SbNg0WS5Ll/7VOh1k/3h9TzivIrHzUKJMLIiRgxiGYoplQbX/RWXfwUrMpI2awW
         CwHja3WJTI/S4W1WEovoYTpIV+l4nN8AegbAsJ4c+Y4OmMZRCkcYaNfsEy/QWLDxjZIj
         SViZptmQXcGkqwMZzzkMa2eQVvmMXaS4Dx1l4CDbTJs2qEl58SCRWjGtRkF/jfIpX2l1
         AMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755709604; x=1756314404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W8/wWuM+A08MdToSUhnUGmguQ8smfR5MJmNoOHi5O4=;
        b=Fr8dQoXChvHT3bw1A/V5V+0oJ/y3a/GvZtycLedWa3u0Km77eSGYTpcB+RVL8qboOd
         KBAgCGEseu0Zrco/CoKLVyMxYxZyyPQz/zLmf8IydEPwviZV/HbHweVfg7DdvKVkzA44
         GfUSBD8Kzi5Yg1bWVD0o2a1uxzs5NTDcsn/grVcTOdKaLZHR9MWH3sOxEXw8WV0o7aqG
         AocaMO/VEjCljw+BIz70wHGJQQCFKiSrd+l6m65MESf9on5jOcpyPBr5KC9LBkU9UpNa
         FINfeZKSnsTo50T6SqjDbvPwkveF4tWczXIF3XE2bs8wGAESeOFdpFzhrCp/ai5ZhglC
         wLwA==
X-Forwarded-Encrypted: i=1; AJvYcCVkiW0/RELBf7jbmye7ILnq8S8Kat13rHDUUgKTqrvjj5LbH88OCJxIRQYlX3lfYu0xPBhRRog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJ/HMRmNTRYrO/GtendymimesuI4t0FEcRMospbF3BPhA2pl4
	QCTk53Jtz8exqUuJwKw9FZSapUnYTW/0yyGIRO2MjVhlwTORY5caawc=
X-Gm-Gg: ASbGnct0gv9PVTYq+617Ph+3iYqOYKwhODb7Et/8reebnURRPgmsgE114+nrX5M5D06
	9bXXNSUNZon23y8EeMsXpssVQ7RzH3OzJyHHI7Q0NpLgiW9505VdbZ1le+HSEyPolQIBddKvX03
	y2JNRhDhn/9UcjafEUDBGyW4B4nzqcvnhwVmjTST8D2HPNHO7EDEVkURrqfaJUNgqa3Gq7Vzlh8
	UuIBJFCT4YwrrysE025JWXQ7fTW+1SfkCSfqMOT7VaiJjpk2U5D10jMmm1z9agVN/tcaXvQh+Ae
	bkczVYllDq6jQuFsshekxf2ivBz4QLtXxe+iVAIKOFTBTQTa74NfoWEbhfwkKrjEguT4rGpZ922
	+rzoXu6gj4nPpfQqYmJdUK5zeARnvf2kmiVT7YM7dkAGaXM3eJEHYwMHilvk=
X-Google-Smtp-Source: AGHT+IHhrnS4bO5cF6D66gvRd6lpOM+6Asj4u4plG7wTD1l3FOElbOmm14MXfP3s7mtRa9SLL1vJ7A==
X-Received: by 2002:a17:903:b0e:b0:240:6ae4:3695 with SMTP id d9443c01a7336-245ef113d53mr43278745ad.4.1755709604160;
        Wed, 20 Aug 2025 10:06:44 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed4fa5c8sm31466475ad.122.2025.08.20.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:06:43 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:06:43 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, aleksander.lobakin@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
Message-ID: <aKYAo2pNMp3Ahvog@mini-arch>
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>

On 08/20, Maciej Fijalkowski wrote:
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
> 
> Introduce struct xsk_addrs which will carry descriptor count with array
> of addresses taken from processed descriptors that will be carried via
> skb_shared_info::destructor_arg. This way we can refer to it within
> xsk_destruct_skb(). In order to mitigate the overhead that will be
> coming from memory allocations, let us introduce kmem_cache of
> xsk_addrs. There will be a single kmem_cache for xsk generic xmit on the
> system.
> 
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when xsk multi-buffer got introduced.
> 
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> 
> v1:
> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> v2:
> https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> v3:
> https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
> v4:
> https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@intel.com/
> v5:
> https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> 
> v1->v2:
> * store addrs in array carried via destructor_arg instead having them
>   stored in skb headroom; cleaner and less hacky approach;
> v2->v3:
> * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> * set err when xsk_addrs allocation fails (Dan)
> * change xsk_addrs layout to avoid holes
> * free xsk_addrs on error path
> * rebase
> v3->v4:
> * have kmem_cache as percpu vars
> * don't drop unnecessary braces (unrelated) (Stan)
> * use idx + i in xskq_prod_write_addr (Stan)
> * alloc kmem_cache on bind (Stan)
> * keep num_descs as first member in xsk_addrs (Magnus)
> * add ack from Magnus
> v4->v5:
> * have a single kmem_cache per xsk subsystem (Stan)
> v5->v6:
> * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fails
>   (Stan)
> * unregister netdev notifier if creating kmem_cache fails (Stan)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks!

