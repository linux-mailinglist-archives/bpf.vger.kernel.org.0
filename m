Return-Path: <bpf+bounces-30299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D392A8CC0E2
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 14:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8899D2823FD
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9DD13D60B;
	Wed, 22 May 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9Ki0jpn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9DD13D53D
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379732; cv=none; b=SVTcaHvRAy63RO7LLGv1qyHnlgxI0YJjHusOChf7QVeiEGODYjFquyFVvgfuYqSsyQAEkmVZMXCdfBtT5uIETfcjKIATQZTNYZmFkq/UsF05IbKhd0PuzEXWPECvv6+b08s/ebdtCmG00b+YbCrgNOu+doYPEGdAS7SSQv1Bd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379732; c=relaxed/simple;
	bh=lCQVcNdlujNqsrb4RnySvZeW3rfwvKxSXFjC+djQKik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0WrzSesUqlbw9mga/+BBzw/5dmpyK0irNyb40bbAptml/a1LQ6ZmhDmrINIfcI+vCCtAx16GPzxU6tlXxCESfO57pUsNVBUzwAmGrlNpoUddZT2WFPZaPLlWWbZUReWTL5eb1fZM25hiF5sjaV6b8nKy0/cU+Flg2vpAULZyDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9Ki0jpn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716379729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m8ofHR/zkZq2uTNi/EY8s+4Ty4W1/mxnDHsktYBgmZQ=;
	b=F9Ki0jpnSLALK7Pqq+gdwlkpD+vQrdrHE3YybkidqNy8ILSvhIwDBXJnJ9vWcczibROZrD
	5LIfYgWcNiBEmWVlQQ87H42HRqw9cQDj3Re9NUVblubw3/moHH4o0TrGBotjJgBEog2ZQb
	RR2CywohiP3mVj38ghWPoP4G60hfxco=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-TqCZn0IuNZWVWePJmEdyBw-1; Wed, 22 May 2024 08:08:48 -0400
X-MC-Unique: TqCZn0IuNZWVWePJmEdyBw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e289eec4bfso282321fa.0
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 05:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716379724; x=1716984524;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8ofHR/zkZq2uTNi/EY8s+4Ty4W1/mxnDHsktYBgmZQ=;
        b=ZSG1kef1q871Qq+dSomL58awcuPObwUkcbrSvbhsF1xMz5ht9AcfN+i/+g4W0jiR/4
         4WpHsOXYTa4zpn9ImX5wrDAI6NbqKNleVTr8CclLmH9t44waPP0gbRxYWQLuED2ZQJTB
         tPGA4JcFJBO+5tBdI0J+r5lObfhgGdaXiLvsGEOniyjPHsUNkiV5A00N7XTV1u0Uf9an
         gTRhSzOevaOPSIvyESrIn6L+73eJ3UNaveZTnysqCW9oC4dJtzwAHJuToGDCmrAxRlIR
         8Am95YnqWAWvJh8wwxXDBa/Lt2i+E5zmOQ6kg3WCbK6SCSriSAx94tp3AV0UHuPlh8eM
         mScg==
X-Forwarded-Encrypted: i=1; AJvYcCVlS1LtgVbmLaS8D857J4jNlPOT4oVQyqIbEdghVbPYvxcfQdDMVXqpx/mMshUDlrl6vVLjOhaALkvxFUGbr+n6eMoU
X-Gm-Message-State: AOJu0YxB0Ka9ijfh2+eeX6zf4BzWt6AdtRsmHzWDM+wvYVQNwPMgw3Mv
	DppbUSePsijHn9/KKC6eLKD3gL5lwUQjfZuCB7C6ET32MiZG6D4/c7GhB1ccz8wx0rVpSJ7Vd9B
	NOhsdSBD6MVVcq2fN4kGHL+QhLMzCBH+tvcySVj02526m6QoP9w==
X-Received: by 2002:ac2:5e26:0:b0:523:68bf:9d55 with SMTP id 2adb3069b0e04-526bf07ee3dmr1034391e87.2.1716379723936;
        Wed, 22 May 2024 05:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGbShGZTyDoasgCPxoWeag611DATTlc3plDJxcUwiepdiBTodpC/4FdFDfus0WiMjljRzXKw==
X-Received: by 2002:ac2:5e26:0:b0:523:68bf:9d55 with SMTP id 2adb3069b0e04-526bf07ee3dmr1034368e87.2.1716379723394;
        Wed, 22 May 2024 05:08:43 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a777dsm33952098f8f.50.2024.05.22.05.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:08:42 -0700 (PDT)
Message-ID: <13b77d180c2bad74d6749a6c34190a10134bd6fa.camel@redhat.com>
Subject: Re: [PATCH net] sock_map: avoid race between sock_map_close and
 sk_psock_put
From: Paolo Abeni <pabeni@redhat.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
	netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>, Jakub Sitnicki
 <jakub@cloudflare.com>,  Eric Dumazet <edumazet@google.com>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
 kernel-dev@igalia.com,
 syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
Date: Wed, 22 May 2024 14:08:41 +0200
In-Reply-To: <20240520214153.847619-1-cascardo@igalia.com>
References: <20240520214153.847619-1-cascardo@igalia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-20 at 18:41 -0300, Thadeu Lima de Souza Cascardo wrote:
> sk_psock_get will return NULL if the refcount of psock has gone to 0, whi=
ch
> will happen when the last call of sk_psock_put is done. However,
> sk_psock_drop may not have finished yet, so the close callback will still
> point to sock_map_close despite psock being NULL.
>=20
> This can be reproduced with a thread deleting an element from the sock ma=
p,
> while the second one creates a socket, adds it to the map and closes it.
>=20
> That will trigger the WARN_ON_ONCE:
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 7220 at net/core/sock_map.c:1701 sock_map_close+0x2a=
2/0x2d0 net/core/sock_map.c:1701
> Modules linked in:
> CPU: 1 PID: 7220 Comm: syz-executor380 Not tainted 6.9.0-syzkaller-07726-=
g3c999d1ae3c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/02/2024
> RIP: 0010:sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
> Code: df e8 92 29 88 f8 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 0=
8 48 89 df e8 79 29 88 f8 4c 8b 23 eb 89 e8 4f 15 23 f8 90 <0f> 0b 90 48 83=
 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 13 26 3d 02
> RSP: 0018:ffffc9000441fda8 EFLAGS: 00010293
> RAX: ffffffff89731ae1 RBX: ffffffff94b87540 RCX: ffff888029470000
> RDX: 0000000000000000 RSI: ffffffff8bcab5c0 RDI: ffffffff8c1faba0
> RBP: 0000000000000000 R08: ffffffff92f9b61f R09: 1ffffffff25f36c3
> R10: dffffc0000000000 R11: fffffbfff25f36c4 R12: ffffffff89731840
> R13: ffff88804b587000 R14: ffff88804b587000 R15: ffffffff89731870
> FS:  000055555e080380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000000207d4000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  unix_release+0x87/0xc0 net/unix/af_unix.c:1048
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xbe/0x240 net/socket.c:1421
>  __fput+0x42b/0x8a0 fs/file_table.c:422
>  __do_sys_close fs/open.c:1556 [inline]
>  __se_sys_close fs/open.c:1541 [inline]
>  __x64_sys_close+0x7f/0x110 fs/open.c:1541
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb37d618070
> Code: 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d4 e8 1=
0 2c 00 00 80 3d 31 f0 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> RSP: 002b:00007ffcd4a525d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fb37d618070
> RDX: 0000000000000010 RSI: 00000000200001c0 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>=20
> Use sk_psock, which will only check that the pointer is not been set to
> NULL yet, which should only happen after the callbacks are restored. If,
> then, a reference can still be gotten, we may call sk_psock_stop and canc=
el
> psock->work.
>=20
> After that change, the reproducer does not trigger the WARN_ON_ONCE
> anymore.
>=20
> Reported-by: syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D07a2e4a1a57118ef7355
> Fixes: aadb2bb83ff7 ("sock_map: Fix a potential use-after-free in sock_ma=
p_close()")
> Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unh=
ash} call itself")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  net/core/sock_map.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 9402889840bf..13267e667a4c 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1680,19 +1680,23 @@ void sock_map_close(struct sock *sk, long timeout=
)
> =20
>  	lock_sock(sk);
>  	rcu_read_lock();
> -	psock =3D sk_psock_get(sk);
> +	psock =3D sk_psock(sk);
>  	if (unlikely(!psock)) {
> +		saved_close =3D READ_ONCE(sk->sk_prot)->close;
>  		rcu_read_unlock();
>  		release_sock(sk);
> -		saved_close =3D READ_ONCE(sk->sk_prot)->close;
>  	} else {
>  		saved_close =3D psock->saved_close;
>  		sock_map_remove_links(sk, psock);
> +		psock =3D sk_psock_get(sk);
>  		rcu_read_unlock();
> -		sk_psock_stop(psock);
> +		if (psock)
> +			sk_psock_stop(psock);
>  		release_sock(sk);
> -		cancel_delayed_work_sync(&psock->work);
> -		sk_psock_put(sk, psock);
> +		if (psock) {
> +			cancel_delayed_work_sync(&psock->work);
> +			sk_psock_put(sk, psock);
> +		}
>  	}
> =20
>  	/* Make sure we do not recurse. This is a bug.

As a personal opinion I think the code will become simple reordering
the condition, something alike:

	if (psock) {
		saved_close =3D psock->saved_close;
 		sock_map_remove_links(sk, psock);
		psock =3D sk_psock_get(sk);
		if (!psock)
			goto no_psock;
 		rcu_read_unlock();
		sk_psock_stop(psock);
 		release_sock(sk);
		cancel_delayed_work_sync(&psock->work);
		sk_psock_put(sk, psock);
	} else {
no_psock:
		saved_close =3D READ_ONCE(sk->sk_prot)->close;
 		rcu_read_unlock();
 		release_sock(sk);
	}

Overall looks safe to me, but I would appreciate an explicit ack from
Jakub S. or John.

Cheers,

Paolo


