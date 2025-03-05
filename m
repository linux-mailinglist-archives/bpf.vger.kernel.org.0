Return-Path: <bpf+bounces-53388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3727A50B8D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 20:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746813AEA82
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133F253B6F;
	Wed,  5 Mar 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5fGReeW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7E1624D9;
	Wed,  5 Mar 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203321; cv=none; b=dQglOFeQ9k3LZ6ky2dFaV8RzqzBguV9c8EF0Ghu20RTRvWqNfE8atze1iEpnNb5bQ39tjDq0h1fmgcETdqJv+Vusr3dgGrLrUv2eDgJXurhZsEO1m1WhDEAP8cL2mQ0zb2YWK2doyhS7V9b/KD+PO11ezH9DVKXVjeuR+3e0FiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203321; c=relaxed/simple;
	bh=Yh454Sht2u1oo7qnDRiqyGPg2LiOtpcPuHo6v7e2NI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmq7HGcwt+J2F0gY3UHox8SSef8WPi91dw8r3IEtrv1WKUTNSlgWj9mU/iEZkF8GofYOQCH18xihCTamSU2Kl71jMG713/FGUF0EkZjvLz2LItdtiLMLeBic+83Kzz8NfRu6k73NslYlDoIMdu9DyUf3Tiwu132scYynq+Ed7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5fGReeW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so10679189a91.2;
        Wed, 05 Mar 2025 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203319; x=1741808119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Llw8YvRz84BgByQYrWuqW2Ofkl7NZXkOQfWEZp8siQE=;
        b=g5fGReeWEPu+lI7OHsur362rv5TpExaSSl2qiEG0M+4kC+RhqrV1X3/DCk5WFqA/ZR
         nLnhZtvPSK5gvzyHLAmIP1fgLcWFqZMY0KOKJyShsIzBWT+5c5/5aDkkBjkSscUBURlZ
         8m1Nc9Pr4jx64BHE1233E2T6mGMnHm4DiToMXklGIAN+O8ongLzyN3bcFZ2eSEal0/HN
         xffOKP64p01rrIoj59KwvE3AwxtW8UnqD8VFNAlW1x9G4H4sIkWQ/JICzZ45BUnRazvt
         gTBIz2G3guKAAVg2kJzC2gS03W3er3/glCGRAyXJHOjZQ7t6+tRVZWM2dXaPJfHhOMOg
         62qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203319; x=1741808119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Llw8YvRz84BgByQYrWuqW2Ofkl7NZXkOQfWEZp8siQE=;
        b=cANNNvFQSePso0TDvvEFq2li9bEvApk2RBNvdUIIJuItUFPGW4g2vvSpBqb1DKxsXN
         4i9x6J+ZkdxoWRR/fgugwstN8S4yQR4MTMERacFYsOLcFCf2tqzphwpHiNYr0jkIn0BC
         +sTnydzbovTUgcEngZMR/KsXAxJOGS3Gy6QiNvGGSC8cumdewJDDXtP2LIs4eaxI9g3Z
         JVGMYkKNDgMd9uEcAciIXZqhJ9YFcWx+ZrHigXOuIV4blUIF5pYPcV9coVKg2rJ+vbTk
         UNMfbsAd3O+pOzTYAuW02cgDJ3CE+fD2pTiGPBn1qUf2kFojJwZ6DMwfC/iHbVmpw2Rd
         g5tg==
X-Forwarded-Encrypted: i=1; AJvYcCVsS6tI8yQiTGSRtRZbklofWuIR0Axxot6YUdhJ5eOzHMOgfa1avgOr0h5ZsPwl1CpXX7s=@vger.kernel.org, AJvYcCWuSHNxO+pYn0YwLv9q93fOg2DSvW3r0EQ43sgyIK8/p4+09CJAf7rYNHyPXqhBn+e4jrdtfbJW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyra22wQJYnzko5/v/aM7G6cH3jytmr0cJinGNzX+4sgt/eR7jc
	RvOf/Eb+iKgWqFC7QJ5XLM6DkVZyyg8HdFdVFcsyLUCoVUYiN9c=
X-Gm-Gg: ASbGncsb9CZsXkegPBrECglGByN5BvM5i+fYDUxz6aM1mcaPHC8ziMe42N1jBSCBov0
	C8bu/2JtjoawV7Wszvz/Aj6NLQzAk7PPtDFpnl3YA34v//i9mZQKxtWuEWTl44yv0Aar+Q51Yfi
	2MthEYf5t6FFlnB8NxNQZD7MqmCBgS0q/DRhObOCatFn3GG9Ayr6sQP09et046zWDpDF9yrHuDM
	gySGe0RvpzM14vAxQ1+VBzVHIYUTr+wk+6TYbG1TyQzKGI/aFyzWOXtKdYpV/024eBjd7rlsHF3
	uYx7T6qRzsR8eviCfCRAqG/OwrlxIo9lT5h7hxRD0wVg
X-Google-Smtp-Source: AGHT+IHWDQ7bvzc8HSpPrYG6Z0t/Of3BQ+D8GCvxM3hqH/QqjU61ifgOl8B/HPdAnSCposQaXsNa0Q==
X-Received: by 2002:a17:90b:3d12:b0:2ff:5ed8:83d1 with SMTP id 98e67ed59e1d1-2ff5ed8d53fmr1708107a91.19.1741203319495;
        Wed, 05 Mar 2025 11:35:19 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e823b98sm1717386a91.46.2025.03.05.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:35:19 -0800 (PST)
Date: Wed, 5 Mar 2025 11:35:18 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Dong Chenchen <dongchenchen2@huawei.com>, edumazet@google.com,
	kuniyu@amazon.com, pabeni@redhat.com, willemb@google.com,
	john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
	kuba@kernel.org, horms@kernel.org, daniel@iogearbox.net,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Subject: Re: [PATCH net] bpf, sockmap: Restore sk_prot ops when psock is
 removed from sockmap
Message-ID: <Z8indgh3Gv0ChOIX@mini-arch>
References: <20250305140234.2082644-1-dongchenchen2@huawei.com>
 <Z8iUG8aTF9Kww09z@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8iUG8aTF9Kww09z@pop-os.localdomain>

On 03/05, Cong Wang wrote:
> On Wed, Mar 05, 2025 at 10:02:34PM +0800, Dong Chenchen wrote:
> > WARNING: CPU: 0 PID: 6558 at net/core/sock_map.c:1703 sock_map_close+0x3c4/0x480
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 6558 Comm: syz-executor.14 Not tainted 6.14.0-rc5+ #238
> > RIP: 0010:sock_map_close+0x3c4/0x480
> > Call Trace:
> >  <TASK>
> >  inet_release+0x144/0x280
> >  __sock_release+0xb8/0x270
> >  sock_close+0x1e/0x30
> >  __fput+0x3c6/0xb30
> >  __fput_sync+0x7b/0x90
> >  __x64_sys_close+0x90/0x120
> >  do_syscall_64+0x5d/0x170
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > The root cause is:
> > sock_hash_update_common
> >   sock_map_unref
> >     sock_map_del_link
> >       psock->psock_update_sk_prot(sk, psock, false);
> > 	//false won't restore proto
> >     sk_psock_put
> >        rcu_assign_sk_user_data(sk, NULL);
> > inet_release
> >   sk->sk_prot->close
> >     sock_map_close
> >       WARN(sk->sk_prot->close == sock_map_close)
> > 
> > When psock is removed from sockmap, sock_map_del_link() still set
> > sk->sk_prot to bpf proto instead of restore it (for incorrect restore
> > value). sock release will triger warning of sock_map_close() for
> > recurse after psock drop.
> 
> But sk_psock_drop() restores it with sk_psock_restore_proto() after the
> psock reference count goes to zero. So how could the above happen?

[..]
 
> By the way, it would be perfect if you could add a test case for it 
> together with this patch (a followup patch is fine too).

There is tools/testing/selftests/bpf/test_maps.c that gets broken by this
patch:

	Failed map_fd_msg update sockmap -16

---
pw-bot: cr

