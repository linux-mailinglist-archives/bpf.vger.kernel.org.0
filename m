Return-Path: <bpf+bounces-38422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087F964BEB
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836461C22A68
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2871B581A;
	Thu, 29 Aug 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhr1LshW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE018C331
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949986; cv=none; b=sFR8VZhYQSJ0v1OvOjwV1vPvkuMV0Tz1b8xRWkweJyv1VpuQqfduBm0Tn46X/JNp0tVzy4uy8MLYSsy5INdahTBUd4RH3uI2IiuUc8lndnyhHyWCZGsMGokAYFvU+VP8BpqoyG7h0zf62hGrZ90BalvYtgvCjrI6itdjkmemyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949986; c=relaxed/simple;
	bh=9IJqmXLOf2YxBdyluG7FzTaegsmjOZBfhP1s0VmmWRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HabB6TwGJLB4t8op+jOijogMvqWdW7rQD1DeICMRq8eVyS/VG8D9Rp0bVlPJTBuANT7bdKS+tBHwI4bMmwy+Z+fJouxuazpatWViZt3ACN+QpKtHHP4uRhgGBJaSAy77mAMZK/mrpULoHHRnObv7qwxrpfvEGsOhhrMI5eZGwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhr1LshW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-204f52fe74dso7887545ad.1
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724949984; x=1725554784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUhCP6JjVMDPqL8ZAp2Ra+MI6Lhm8OrZimHxQWVuaJw=;
        b=hhr1LshWNnWSkqrCmovS9WqCAnvKEtk0fOcAi5iPWF6e5Hz/zRthGMUHfKX3s6N6uI
         B5ggGYXw+B4APAIx6QYT4ZlI++IWBAzepo9OU5veeJUG7NyY8S2W4rjWOpkhx8yrU78p
         UyCJU7UzDvV1+krSZ6tQqGoYpms7C6QhJ3coT8k1FJF8cCLIdueGpwE4lOV/jmBLORvQ
         DaKRFQBYZXygLZl3NCTqz1Roi3oImjtjQ3S7eqOv3SMWU8nFcpExYiGNK0SXWAoQKfaQ
         rJDUWgzlmNMWh2jwV5MpUTiRHCN7yg7ipQhyoKfa4XKqlxYR7Q2sIUmodFa8fZNqBvLl
         +I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724949984; x=1725554784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUhCP6JjVMDPqL8ZAp2Ra+MI6Lhm8OrZimHxQWVuaJw=;
        b=giBisuZzROK01fC0qb3m8j/Q/oZ3wn6Kk6Nod23o/c59nD04Q+axrEEketxAZMb81t
         OLDmUKUo3JFms3sh0KB3J3+NiOMJQX6RVYcRTdEls4J1c4uguLHcPJvf8pOroiEz8gQ9
         zoshrjYTbrFFvW0eJJZ/JA7VUkRYdth1C9W8qNwja9GAcOjASS4LmyEiQdVlEifoP+Uv
         2xLKopwJ/bv6Av4QiX0vhPGLQKCYhIeWtnDKtR5K6yaXB1mrm/bbv9rizUEKR5sZlCNd
         HnyyyII3xWkoi0ewoio9I08L724hJ/coZ55Goan/gE5ZAC/ecNdhNqzAQQW5QnBNCFO/
         qGTw==
X-Forwarded-Encrypted: i=1; AJvYcCXuHboGlNv5LJEi69RGUwtQj3cinnH77sjzpstt0hO2qa8KH0nDd622mDM8aPJ2bAcgWO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdB+ADZvp07MnBDLHTE7GN5STKT3s48KcwOL0epz7jSz1TtFyO
	NleuBhRKNU/OABW9cjC8/CmS56v1363oZlz5Yb0ud6NaAtLAGGtLirwkYz+q
X-Google-Smtp-Source: AGHT+IHK+ADi8qoDT7xqVCLr59uopdcwIqwy4qpzKORUnHPH84hM+3/YRKl/YxTMNEqfnbOnInkEcw==
X-Received: by 2002:a17:902:f68e:b0:1fd:8c25:4145 with SMTP id d9443c01a7336-2050c345cbdmr31280565ad.17.1724949983818;
        Thu, 29 Aug 2024 09:46:23 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:1504:7219:cbca:d77e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152d2b3bsm13490045ad.66.2024.08.29.09.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:46:23 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:46:22 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: zijianzhang@bytedance.com, Amery Hung <amery.hung@bytedance.com>,
	bpf@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	shuah@kernel.org, wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: Re: [PATCH bpf-next v2 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt()
 from growing skb larger than MTU
Message-ID: <ZtCl3kQrldshCFam@pop-os.localdomain>
References: <20240827013736.2845596-1-zijianzhang@bytedance.com>
 <20240827013736.2845596-2-zijianzhang@bytedance.com>
 <5186a69b-c53d-4afa-b3be-e6bd272d264f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5186a69b-c53d-4afa-b3be-e6bd272d264f@linux.dev>

On Wed, Aug 28, 2024 at 02:29:17PM -0700, Martin KaFai Lau wrote:
> On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
> > From: Amery Hung <amery.hung@bytedance.com>
> > 
> > This series prevents sockops users from accidentally causing packet
> > drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
> > reserves different option lengths in tcp_sendmsg().
> > 
> > Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
> > reserve a space in tcp_send_mss(), which will return the MSS for TSO.
> > Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
> > again to calculate the actual tcp_option_size and skb_push() the total
> > header size.
> > 
> > skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
> > derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
> > reserved opt size is smaller than the actual header size, the len of the
> > skb can exceed the MTU. As a result, ip(6)_fragment will drop the
> > packet if skb->ignore_df is not set.
> > 
> > To prevent this accidental packet drop, we need to make sure the
> > second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
> > not more than the first time.
> 
> iiuc, it is a bug in the bpf prog itself that did not reserve the same
> header length and caused a drop. It is not the only drop case though for an
> incorrect bpf prog. There are other cases where a bpf prog can accidentally
> drop a packet.

But safety is the most important thing for eBPF programs, do we really
allow this kind of bug to happen in eBPF programs?

> 
> Do you have an actual use case that the bpf prog cannot reserve the correct
> header length for the same sk ?

You can think of it as a simple call of bpf_get_prandom_u32():

SEC("sockops")
int bpf_sock_ops_cb(struct bpf_sock_ops *skops)
{
    if (skops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB) {
        return bpf_get_prandom_u32();
    }
    return 0;
}

And eBPF programs are stateful anyway, at least we should not assume
it is stateless since maps are commonly used. Therefore, different invocations
of a same eBPF program are expected to return different values. IMHO,
this is a situation we have to deal with in the kernel, hence stricter
checks are reasonable and necessary.

Thanks.


