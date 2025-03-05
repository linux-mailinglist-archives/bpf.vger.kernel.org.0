Return-Path: <bpf+bounces-53383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE0FA508F4
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E0216CA20
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13372528E0;
	Wed,  5 Mar 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE7/sBHi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD819C542;
	Wed,  5 Mar 2025 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198367; cv=none; b=Zl24zFa5qe83ebPj7Yj+v6fjYCCc0mXP9jv/JhCyGFVI0H4Uh0kAk1uv6EAPjCJEg0QALJk3r9f1yFjeGYb2KOLdzTxFggSIF17Y0EyET6REJ88Z0FCtu3ZQTybRi8m8VnZ53S20L9aCF2ep7QacQB76Zg8zi1Zr2YxyZc0WY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198367; c=relaxed/simple;
	bh=hLSosc8ZGSMqBJmpjG+Zcp45IeQYgadpHS+5+HJNY54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4djamZfJ8W+wPldakfznybSSFRjCAPCBcQWiqaKMrmGN+UPSD64MAyJ1ijyPU3LFDueV+S9RyyD8albazvtehY8hU9IeFHelfeFHyEt9k1B1R2OXFZd2J3nOYGU3KJ3dY+2Rr9K5LVJXXJ8wY1IJ/RG5W2QtKRX/e2RNkEYzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE7/sBHi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2febaaf175fso9552679a91.3;
        Wed, 05 Mar 2025 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741198365; x=1741803165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxfu5Pa3zywwY6F0O+b5hEcYgMdoVIsyRsVhe+haQdo=;
        b=dE7/sBHiEOhROs28aVyiqQ/Bkc+CYQ5iZpyaYwf0FsErG7OXIzh142qsreacY56GUo
         zbhY6wz+GJktsAzNpzwbunZljAsSc3AjBL0Epfd2Qkcf0zv5cDx9zVfTKvjgJb74v5PM
         XfZ4BuFLrWIw2ouS5C2JTQB8ERGUlcqsDAa6e/k98k0Tl6wODsFVFq7gfTq4CudbnTkm
         uEQ8ZBRNzvFSD3JKvHcTPn0TvOZG6NC1jH4TLwnnx9zrVQ3+nw8fXBc68EDFLuIDrM/d
         4sn/Om3Y2ASThlekFQ0J1w1fpNcXqrj8LzZ+CYudQMskvg9tN6o2fAn62DxTKml4ULse
         QUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198365; x=1741803165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxfu5Pa3zywwY6F0O+b5hEcYgMdoVIsyRsVhe+haQdo=;
        b=oo6o/JagPaC0Z4eoI9DLFd3Cr4Qsya0ftUkoZHMQUgFxE7HTrKzQMMyAXc0xz4rz3s
         d4/OfDF0yuW8vTAZAl86HXoYV9y278fT2pP6DiquoBJTqHsC/Qhy+vMn35LBA9EE/h2t
         YsssyTFnVn1ODkR+x0BXGJOjPVL5eYgbnMCuxSfIMM/GolxXFfxwaV+xjoPPhDOnNHQb
         THzvkMpyZFxizRrD52qQ2+IBo72ZgeBWrtVJ2MJtFQ7/Jojgg2mKwInW0e+BWg2olcCl
         jSILkU3E9COebKBxEIRmtnJtds8L4028EO/d36zCfvbh5xDH+Q2/uI/s7VP9kidCPJ82
         bpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVOjGVSUPKt5vR/Zs9/crm3q/Aoh2xidwFizyBSjV+Sd1JzTS/4tpJFSccna66xyn9kNK1dxV+@vger.kernel.org, AJvYcCWE1NEXM5xC3z4hdROVuzP8SBnVHyEx7x29GZmQ/na4s2io9V+OHChGceXZphpyk0H6PUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGO3CuGcEz++BQaCNdqSf2rrIZ4JweVem10GlvJ8wZ1hDqcBw
	0OunBA/Ltccd5/C2U7YK6p/Zio9gbsjUjsAiP4iWSgGxGPJ7nTk1
X-Gm-Gg: ASbGncvu1jRSWo5/gx+KGE0q4msfZen+HDVeSVeD377K/6LzKrvxW6YYV7EQfJq6RdO
	2hlrBGZblVknYYeXtBsNbTYHZ9VDK6IaXRN4eOzgDuqBm8PalMqgk0qE2Eb+Qzemb6bxYmxToWM
	8Rn6bEMplJh6d689QT4VZ4ADiXfkozimcpFLnUQQndXbKebDVRHB55krpo9TMu/142ZleXt8W2P
	ip8LvP4dBaqfnS/iRWwbUzD6HbxiRqPGOmX/EyqI3j1mwJJ8NT2J7lSrDidUhp51c04ew/490C7
	OQoSkZrMx+wOupFrIhgsHhxpxM8bRyUWKU2BRWdZnniduOBl
X-Google-Smtp-Source: AGHT+IFQZfgQX0YU6/unP7FdjSfq4UkGfCIq09eCJhs2cmYHBhhx/wUthBK9Wcx33K3kaI5ub8EJ2w==
X-Received: by 2002:a05:6a20:734e:b0:1f3:2a1e:f6d3 with SMTP id adf61e73a8af0-1f3495c2795mr7695535637.41.1741198365159;
        Wed, 05 Mar 2025 10:12:45 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf29f4sm12166147a12.11.2025.03.05.10.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:12:44 -0800 (PST)
Date: Wed, 5 Mar 2025 10:12:43 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
	willemb@google.com, john.fastabend@gmail.com, jakub@cloudflare.com,
	davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
	zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Subject: Re: [PATCH net] bpf, sockmap: Restore sk_prot ops when psock is
 removed from sockmap
Message-ID: <Z8iUG8aTF9Kww09z@pop-os.localdomain>
References: <20250305140234.2082644-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305140234.2082644-1-dongchenchen2@huawei.com>

On Wed, Mar 05, 2025 at 10:02:34PM +0800, Dong Chenchen wrote:
> WARNING: CPU: 0 PID: 6558 at net/core/sock_map.c:1703 sock_map_close+0x3c4/0x480
> Modules linked in:
> CPU: 0 UID: 0 PID: 6558 Comm: syz-executor.14 Not tainted 6.14.0-rc5+ #238
> RIP: 0010:sock_map_close+0x3c4/0x480
> Call Trace:
>  <TASK>
>  inet_release+0x144/0x280
>  __sock_release+0xb8/0x270
>  sock_close+0x1e/0x30
>  __fput+0x3c6/0xb30
>  __fput_sync+0x7b/0x90
>  __x64_sys_close+0x90/0x120
>  do_syscall_64+0x5d/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The root cause is:
> sock_hash_update_common
>   sock_map_unref
>     sock_map_del_link
>       psock->psock_update_sk_prot(sk, psock, false);
> 	//false won't restore proto
>     sk_psock_put
>        rcu_assign_sk_user_data(sk, NULL);
> inet_release
>   sk->sk_prot->close
>     sock_map_close
>       WARN(sk->sk_prot->close == sock_map_close)
> 
> When psock is removed from sockmap, sock_map_del_link() still set
> sk->sk_prot to bpf proto instead of restore it (for incorrect restore
> value). sock release will triger warning of sock_map_close() for
> recurse after psock drop.

But sk_psock_drop() restores it with sk_psock_restore_proto() after the
psock reference count goes to zero. So how could the above happen?

By the way, it would be perfect if you could add a test case for it 
together with this patch (a followup patch is fine too).

Thanks!

