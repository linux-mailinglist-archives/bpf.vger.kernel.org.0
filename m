Return-Path: <bpf+bounces-52989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB9A4AE82
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 01:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB79016D1A6
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AF023A6;
	Sun,  2 Mar 2025 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4baTuzd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B0B65C;
	Sun,  2 Mar 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740873937; cv=none; b=qztjBrnib54k+cE9WJ5nvYUW4L22G7YQvkCxY5/tcxOdORVq4JQ4EBKg/3eaINYkvvPtbSijhPUhOPTNe9CwMAwqLYnRW7tfDbfjidoK9hNE5morcxgt65EHQRqwXYv0ZkYb5yOMWVKr4Howxo4OBiAOp2CQbvP+PJmX58NO4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740873937; c=relaxed/simple;
	bh=6HmEk+cr/nQ2AtMeKnZYCKee4X/sipWyEPSonJAexQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsuH4DAS70SahbxtGQ7mLh9Jxw7DxuAGLN2O6jVyWJuW7o0dEEcPjEoRt+pkpH7xej8PyhWXM/VYAIQKBd/SPfGZsp6gsG3aRZkDfYvWlz8WCLlMsRILqBFpGkr8j9Lp6ow8EBNV66+/EtWSwKyrZWLz1obCTZsFgw+yjoAdZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4baTuzd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22355618fd9so54858665ad.3;
        Sat, 01 Mar 2025 16:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740873935; x=1741478735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovnmnKdm/tNRkx7NBVKhQJMM912iJwNvvhmslC2bD/c=;
        b=C4baTuzdso31IOLJ16UsBLrU8AVAKOlghS4rjVzNzqeFgGSO+gScO/2+RchZQt68f2
         q8wwDwdkAl9XLvefp9qBwLvThI2Yle0jHj2znEzzmYNkmlffKLMeAzyTFRclD4L+MRWM
         GS/RTAVHnABoL+Ud7KuWS6bkkK1bRMnJe3C6EsQH1rrYrJSbH/Zhq74eBE2M+pnmlWDZ
         AJ7Q3lsu6ohAh7Bkl/IE5NDdpoc9udZadT9P+tDrFwTRORz+eZ9DffNCJLJOfp+dlzjC
         3bxr0Rg//Q4gGTQWfIqycLV++s1UX+SNsCDV1TxvylFPqhtqy4vAujl9bGdmMwosHeMM
         EPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740873935; x=1741478735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovnmnKdm/tNRkx7NBVKhQJMM912iJwNvvhmslC2bD/c=;
        b=FQXFBjNZP4WjwVZxJYCxyxqwaS8oWUlXadEuLl6qI/FtFeO0QDAkJNP5FNBt3xMua+
         jE9+Fo0h2CBmpE1xrnWeJa470pipuOfeakZcWGZwjk09ZaQwj5OJU+vvz+LytIaXrsGR
         kSB7QenS2OeoNwW7neq0ATbFWA6kASBV5sC+kwgeQgBSPhkidJqv9abkxp/itxRFweDH
         zbxyg9ZLRHMr60uEQaGZVea0cLnE89b/FZsXxOQU2tO/PFQ0bQDChKgK0/FpB8/B0Pbs
         0V71CnwH0acTXyFcEivBOFjQATqApCiR5alZhmFax5i1vPPdGMi0y7pEEMwIHZhC6hXv
         P0ng==
X-Forwarded-Encrypted: i=1; AJvYcCU6oY43SV1XlPW+8lYOcMbaMjZE+ZswElUQOV8wiErl1pz2PrZEBWzu38GmNJr8VEGLOfyxLJIs@vger.kernel.org, AJvYcCXs1zxZIxJ4QjpC8M5iWkqIvDFLC83HWFYMcptI8lxtl7U0YPGh0msQbPZQ+brWYDuXTiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHP8EGPV3FRgiwSgql/TNjFiBWu4/hoa43XIXP5aSTTjVkCiuk
	8VJ/Nl0irFpDaaem/38dhOvVZhDIMGqCHtFAn8ovyzCV0zCjNzM=
X-Gm-Gg: ASbGncspUR0Jk7Gw1nlHPjTVE2zSx3XV9hag1Lw7Jk3YzpkSEeCK9tVGbgiR0f/rIZL
	tDONO6ab2eG0Sn/zrFK7i/7UsVQ9cwgt8dp8+QFUi6V2Jxm8KjhKOPOEdeckixgljtkObVXHbP5
	VqsrdZcYdnRGh0839EkAoIC2dBAaydbc7NLTGPJ8pkT5oTqn1J4F3e25LgNpAZS7gtVw0O9+HvA
	XFSm3D+Y2L8u4DTartqSqFG3KE7IJBAiZGLsWs4XRBELlKtFS354I5A1N7r3NdscrEDJyoSRIig
	TvMBbjnspSrGTapgVHD93ea6ZzPLSNay5S3nD1d5M5UJ
X-Google-Smtp-Source: AGHT+IGhDFEedN3vPaJdoO75I7nJeoxv3+EyseUJ2uqHFQMYoqj+xJQBL01sz3w7O5zFYgJz9qrhPQ==
X-Received: by 2002:a17:902:e751:b0:223:65dc:4580 with SMTP id d9443c01a7336-2236926f40emr114039975ad.52.1740873935421;
        Sat, 01 Mar 2025 16:05:35 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504dc28esm53143055ad.166.2025.03.01.16.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 16:05:34 -0800 (PST)
Date: Sat, 1 Mar 2025 16:05:34 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, eric.dumazet@gmail.com,
	Kui-Feng Lee <kuifeng@meta.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: no longer acquire map_idr_lock in
 bpf_map_inc_not_zero()
Message-ID: <Z8OgzrmLG0uvrsR_@mini-arch>
References: <20250301191315.1532629-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250301191315.1532629-1-edumazet@google.com>

On 03/01, Eric Dumazet wrote:
> bpf_sk_storage_clone() is the only caller of bpf_map_inc_not_zero()
> and is holding rcu_read_lock().
> 
> map_idr_lock does not add any protection, just remove the cost
> for passive TCP flows.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

