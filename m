Return-Path: <bpf+bounces-39174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087296FD6A
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4962D1C22B24
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A987515921D;
	Fri,  6 Sep 2024 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm+TL3Vh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF3156F3F;
	Fri,  6 Sep 2024 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658359; cv=none; b=nS6Z6iXolHVYFlUGbqI0Faet7RmRgSSL+19gV3KpJ+761ySqbvqzuLBcHbivZ1T03MrlQkkTAcqaJ0QDB987ILTT3Dh+aVFJ4h/LVP8MyRlerKInE3hmJYNbWtetWA34a1Q/81h8w5cG+SCtBNsTHm4ZtvZ6M1N6B7nwIekVaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658359; c=relaxed/simple;
	bh=87nxLTW7zJr60yczsffo6e0ZCw0zfrvwV6CWIyDzdeg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r3jvDI7hOsAu2ZXejvENDXOV/LAAO1o0g3iR3BSJro1l9QjgaTE//BKM64Jw6+ddIx+NvmmEP/5pgMDjuGZdTD2T8oN21r2kdtfiHpJaR95KJZPPuX/BQ+N18yOOQgmgoFHrZyjk5i0KqtkUDm66B00idUJ/P3PulxuxiIA0L2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm+TL3Vh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718da0821cbso884798b3a.0;
        Fri, 06 Sep 2024 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725658357; x=1726263157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1d/KkLjmJVBpl22N+MLT4/Qk6TXkPYD8dVjezhr++Y=;
        b=jm+TL3Vha0/HzcBagPM4+Gg7JqzM+OqldRKxYKXRDllJtSRO4c0h522Sk/bPckPiWx
         /1w/apLGPE8e2mesS7PqAGbCNjOp7TLDI+v5bID2bjRZzisnKVQ6ciLCeS7tXe0PmkNs
         UjflnXe5m436bUOHhcPFNGPUlb5jjZR51h/t8V8p/dfsbvIVHWKzoVnfX6O7BWHQp/OT
         gLiMXiq1YDdhSQaaUimaBDU+QLVbvJzROw/tzyuSIL5uUUgp4YKaUWQ33kkaZnoG+Tgz
         DJBHA/rpIPF5PWc2MkNHW+oauGirIYP7HfIW7S/198/wwKWER3Gs9v3YQ0Go9QEiL/HK
         +/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658357; x=1726263157;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L1d/KkLjmJVBpl22N+MLT4/Qk6TXkPYD8dVjezhr++Y=;
        b=wpBfot1fxwvhg4dTBxdPoCUx6jA0YZfrlB7cFjlifOGSX6yGfjcKfnlOBHAlQthz0F
         +W8LLeQTp+R6cNaUmzYt74W3CeN7k7HxfekCNypbqpvSF5PXG+IrU+pdSoGhHczQR6mo
         i0jHLQkgj+nnqKAbBmR+ZF6qrpek2TIAy/XV9Lzjk7Bif8nqaDa88ElgG2wImHgwnv9+
         7ITvnYNXhglXxQdZRGb+Ys1oyqupORQQtlT57xU8rQ8odq1zaoXGRMaFQLLpNJHpR29Y
         2cVdUPKi19N6loNS5Fu1/VeL1KqBdNm5t6PwagDy9mbHf2UOl0YmIsbbe7wTBkZcq2vS
         uP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+cTVCBHTPk78TCwjE0rlL7+SoEErXaR89/IJCYyNY/VytFNqJBAEpK7P8Kyym2y0Fq+vHFbaG@vger.kernel.org, AJvYcCVz20kd6G27ITNZGDxr+VnKeu3dlk5UVtJzkszkfIuFPdwbh/aVtv61sZhmzWXXcyfSrCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgwHYttjvEvAJqEOa5VyhfTTe/mHo0xXV2L0wFnwZeIrERuW3
	9k827JbD0o60vRAxbXrJUNd6wb01rqkBYy2tmMaAB3McjA3cRMMw
X-Google-Smtp-Source: AGHT+IFMBrsNy5G/C1uWGdTEgiNrwDcbFYCp/Wp+znVQ43KgOMFRBTMERdPpZrByrKcCPcRwt2riDA==
X-Received: by 2002:a05:6a21:350d:b0:1ca:da64:4f4b with SMTP id adf61e73a8af0-1cf2ac710a1mr558071637.2.1725658357110;
        Fri, 06 Sep 2024 14:32:37 -0700 (PDT)
Received: from localhost ([98.97.39.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7178899166fsm3619161b3a.201.2024.09.06.14.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:32:36 -0700 (PDT)
Date: Fri, 06 Sep 2024 14:32:35 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot <syzkaller@googlegroups.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <66db74f3cd2c6_169520848@john.notmuch>
In-Reply-To: <20240906154449.3742932-1-edumazet@google.com>
References: <20240906154449.3742932-1-edumazet@google.com>
Subject: RE: [PATCH bpf] sock_map: add a cond_resched() in sock_hash_free()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Several syzbot soft lockup reports all have in common sock_hash_free()
> 
> If a map with a large number of buckets is destroyed, we need to yield
> the cpu when needed.
> 
> Fixes: 75e68e5bf2c7 ("bpf, sockhash: Synchronize delete from bucket list on map free")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  net/core/sock_map.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index d3dbb92153f2fe7f1ddc8e35b495533fbf60a8cb..724b6856fcc3e9fd51673d31927cfd52d5d7d0aa 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1183,6 +1183,7 @@ static void sock_hash_free(struct bpf_map *map)
>  			sock_put(elem->sk);
>  			sock_hash_free_elem(htab, elem);
>  		}
> +		cond_resched();
>  	}
>  
>  	/* wait for psock readers accessing its map link */
> -- 
> 2.46.0.469.g59c65b2a67-goog
> 

Thanks, looks good to me.

Acked-by: John Fastabend <john.fastabend@gmail.com>

