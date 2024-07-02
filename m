Return-Path: <bpf+bounces-33631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10526923F97
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 15:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9118F1F260FE
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886AB1BA862;
	Tue,  2 Jul 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpXAyyW0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933C1BBBDA
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928362; cv=none; b=fZYQ9S98MgF4n0EfEybAh1P7L29MsrBgCOlwsfdlE5Yo3pKPzEHIyslxbUsQ613rgOsrp9RwPTalLJQXq1F0uDYPhDl+bLVYtxiQLtp7FTgsNWkzqa5JSsLfvfMUQ+28HvfgInPdQv2G4x54TUh9Ll5stYyYzLL55T5jf7qCe5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928362; c=relaxed/simple;
	bh=P6S+NowqFefU6p5hl11O9W1QFA8EksZD70L3JdU7PD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzARxgnjPfRjkHJ0RBNt0AzAULWtKw92fUaVA0sZKivSs6L/A4Wg/6huiETdMiY63eKN0tb8FFXkxU/tu5aiYw/D+/RztgPH71KzEJ/lqlsnRcWo6TrS24e/aayHoPkqiNp8rJzq0YM/+dhUDqvpRSlIguvuwAjyuGHDxECLY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpXAyyW0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719928359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P6S+NowqFefU6p5hl11O9W1QFA8EksZD70L3JdU7PD4=;
	b=EpXAyyW0Tx5VOx3+kDByfQ5emII/o+0IwKJn7HUsygP5Wd/gCbIBB58XWmm9BXU7TY8hDU
	nbsaAFK/z1XyJgoIqidtrrlZGNu8VbbOsBqwB47Qs4obNnMbcSBeBRalZDH6c3sDgeHAdg
	rzqVMKNYcoGdyShBfsHhVSnS9EbzEjU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-j7d79QUAPoeilJaTbK_z1w-1; Tue, 02 Jul 2024 09:52:37 -0400
X-MC-Unique: j7d79QUAPoeilJaTbK_z1w-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5287fb139e9so28461e87.2
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 06:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719928355; x=1720533155;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6S+NowqFefU6p5hl11O9W1QFA8EksZD70L3JdU7PD4=;
        b=mLWKdkOw5ee837DuljVf7Gfvt2CRmQwVeW6Vvxrvd970o7Gv+A3h+Y/nIqmKFGoBnd
         LKGdDwZeNJoAs6Y0FnQtkIKaW47GmWP3fk1/NIlqmi8tdY4VE0RwAaxq+bJ12kMDVAeP
         zzEhM4oToHCKj8HtkTQHTkv04lWm88o3k4hA0BFFlih1XQkyY6za0bIlUqFWhsrpUxZW
         4p8zFhNMV+fGx2lynOyz+st3o0kfDG41wTG1KGKH2SupqtWRNDCUJuxlorNYPY8SZAy5
         8nIWrBgwzEmZmBFb1cNbc5kV4A83i1EeNNmDt9hVA+scmvW7PNpi+uMa1B7fnGvieL/G
         nnjg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ksg0JJi8WOQFgJvI/l2kY90FNzFAYQ3FfzR0UYVgc8bmg6KDKjl66Cf6ul2RlKmhvf/Ca8V5Ix8DV2UDt8OyUd0V
X-Gm-Message-State: AOJu0YyrQprEtF2wwllsJbkwRumJXfsUZjQrbjTE/et5P+zgPlJMZRl3
	QIWpLPQu+2Z8FXmahWOI7t+niGN2a5gdlLQLb86Uz0G/2TjdU3rqSSvEozI6SQq8AjDfvQHTjmn
	6AoIV4CmBaMHQ5/XG7OXCkY+eQnwDEcgORd7ICW70wlH49yTxaw==
X-Received: by 2002:a05:6512:1043:b0:52c:dc76:4876 with SMTP id 2adb3069b0e04-52e827a730fmr5447046e87.6.1719928355224;
        Tue, 02 Jul 2024 06:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQj+pGW76WHzqiRnLGjvsGlzmwcV32Dvnzj0uL3mKPLrpmlXe/OQIVf+/a7TR0KyJNNKOiIA==
X-Received: by 2002:a05:6512:1043:b0:52c:dc76:4876 with SMTP id 2adb3069b0e04-52e827a730fmr5446971e87.6.1719928352820;
        Tue, 02 Jul 2024 06:52:32 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0a6:6710::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af376easm199653035e9.5.2024.07.02.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:52:32 -0700 (PDT)
Message-ID: <6566bc6faf4e67e5ae3c7a3ecb93b16efc7ed221.camel@redhat.com>
Subject: Re: [PATCH net-next 0/3] net: bpf_net_context cleanups.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	patchwork-bot+netdevbpf@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, bjorn@kernel.org, 
 davem@davemloft.net, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  eddyz87@gmail.com, edumazet@google.com,
 haoluo@google.com, kuba@kernel.org,  hawk@kernel.org, jolsa@kernel.org,
 john.fastabend@gmail.com,  jonathan.lemon@gmail.com, kpsingh@kernel.org,
 maciej.fijalkowski@intel.com,  magnus.karlsson@intel.com,
 martin.lau@linux.dev, song@kernel.org, sdf@fomichev.me, 
 tglx@linutronix.de, yonghong.song@linux.dev
Date: Tue, 02 Jul 2024 15:52:30 +0200
In-Reply-To: <20240702134546.2CeHYMhf@linutronix.de>
References: <20240628103020.1766241-1-bigeasy@linutronix.de>
	 <171992763353.28501.245433484118524334.git-patchwork-notify@kernel.org>
	 <20240702134428.hUZawCsP@linutronix.de>
	 <20240702134546.2CeHYMhf@linutronix.de>
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

On Tue, 2024-07-02 at 15:45 +0200, Sebastian Andrzej Siewior wrote:
> On 2024-07-02 15:44:30 [+0200], To patchwork-bot+netdevbpf@kernel.org wro=
te:
> > On 2024-07-02 13:40:33 [+0000], patchwork-bot+netdevbpf@kernel.org wrot=
e:
> > > You are awesome, thank you!
> > no, I am not. The last one does not compile. I was waiting for some
> > feedback.
> > Let me send a fix real quick=E2=80=A6
>=20
> Sorry. Wrong series. All good.

Well, I actually test-build the series locally before pushing.
Sometimes that is not enough, hopefully it was, this time :)

/P


