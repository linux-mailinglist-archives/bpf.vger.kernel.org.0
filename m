Return-Path: <bpf+bounces-46589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0CA9EC1FF
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 03:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D839B1673CC
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 02:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76771FBCBC;
	Wed, 11 Dec 2024 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clWa2OK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7A44384;
	Wed, 11 Dec 2024 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883091; cv=none; b=o361BXNfmDsdECp98ejJmeyjfMkqMBDiuuf8RG4SDm1MLBy1f6UPHnasByGFq8wOq6uCDI0l93EHxXs/36nCcyyhcRBfCCxr5jkSzveQ/0qC6qAPVhJBqFKsu3LI0l5Cl7tiTxFJ/MlaXb++Lr7hOBEsWnbf1RI9v2STosy4zgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883091; c=relaxed/simple;
	bh=A5Ova/lwWOPJ/MbkngISMFhMWPWBBdzeCWK0wUhKOTI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=u6ywS/KT8LeiH7xbNWkQTLSnCFbvG5M0HAqLqNncWX+AAoUL7L1Y3junMZTV870sCk3CdkOrjkaGKt9L3SZu+p/J1a/TsbcLrRKmQDO2C+pPL+YwKWWApleqYEBeJbyAPEWpRCrRJywSwUGU0zf9unc0wmw98n4tAaHvSb0h1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clWa2OK8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21649a7bcdcso29043815ad.1;
        Tue, 10 Dec 2024 18:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733883089; x=1734487889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ1DWkHzxFbmz7MOTsa2Rn30WXI+xi9D9OGX6d1SiaY=;
        b=clWa2OK8JgKJPuoliAfFb857Kh2aPD0lClyw3D0qySj13gKHxJl06cE18SHW8zu56A
         FLmazy3zOwx2tHz4X24e+dfeKM5LhpOxoGhuTa7RvS/hYvxhOYjYCM6BSiUe/f7fgVwg
         a7il93h17h9d2F+KovSGyqivys8Mi9FRfcbXfRyX3zBJRW3+cTvJz0wp4dFQ7E32hj81
         ND/NSficmTEnTQggTWT6AFu67+7TzedzBiQnAYwIxaYrakmPpkKCb++vhX7xQkSgsQ9q
         KWfX3duqcf8DyqtAtPI6EbfBROWYHbFw29IjpIf94yifuZLDRROKGakKMKbfbQWa0GHe
         AFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733883089; x=1734487889;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZQ1DWkHzxFbmz7MOTsa2Rn30WXI+xi9D9OGX6d1SiaY=;
        b=pYdOKep33bhXXJ63RywGEQGHWNOQP8O1nCFxs88Scr/rS0pMBuz3U3QKljwyvmb5x6
         tBKDtF5IClnhsaiK89RxMVnWJoxbH3xyvGR7lpmnFZlWQnraa8TCAZybVp+v+LNzuGHi
         9PK4j/Mr6sbXp4J12iEqVUK4RiBEdlfkLcf16WbONGg94zqaoxBTAygRT4534tqKjgmY
         zPhx5FJCuPxU7hs1jVsUsUhfopduey72tYVk7OstxFJRvkURLqAgkhqqTrj6+PrQK39d
         XoLKofiSIEOt4kNKwUJc4Nh36ORmO/nsSGQUnmpN9GoN0kIFk9NT900gJ0fMIcVGLAMn
         n9ug==
X-Forwarded-Encrypted: i=1; AJvYcCUNR3KFhk0a5vz/yW8owAwHWpRvsIGzlsNFV2FAZnZeYSc+2DAdTZ/uG2BOd0Y0Q76kPZx2n1TRDhfEgFGl@vger.kernel.org, AJvYcCVpVgBhyQujnVFmtsuzhRiIXbhmUe7Co1cdel1ibQo9LJQfy950LqihOxt5JkUNuaul9cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOfQRK8SCdt9yRPNwtjzBOAdCZ2dAcJkiGTI6Jc+0XAqQk6nBA
	B1SbYgVQx87mvLwhnuqTJmNy3zJ/+el6GwbM5KJPkargY/Es58QNm4EUkA==
X-Gm-Gg: ASbGncub5vhyEWOJVLEQCtWGY+r7+8/J7djJTh0+auHUXcB4q+YY02eY0KzgyHBPeQQ
	hxb/5tn3+CBusmxmph6rpNFiooaVPWLWCcGXTDeyeK/evFzzPNkSpTp8g8S7ddwxK9T1Pkbxw+t
	4NEVrYinHtCxvxZ3CeH1ZhZVL94plBVFgFIFvmqlq567NsvzCCtiNn9C9lyouBPKRWX8diuTEW8
	wceEVhwA2To8LZ7SsDIf3ta4YNmtMp/mbDT0UZLcYg9WicG7klN2xg=
X-Google-Smtp-Source: AGHT+IF+UKdYygc7fF7WFY9ucLIkh1eYls4XFPGPwUbfQC4yx2CEDQr7hplAFTVDGvfdDQX4VNNHcw==
X-Received: by 2002:a17:902:f551:b0:216:5b8b:9062 with SMTP id d9443c01a7336-217786a22c1mr18877405ad.54.1733883088241;
        Tue, 10 Dec 2024 18:11:28 -0800 (PST)
Received: from localhost ([98.97.37.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm56449465ad.29.2024.12.10.18.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 18:11:27 -0800 (PST)
Date: Tue, 10 Dec 2024 18:11:26 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <mrpre@163.com>, 
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, 
 ast@kernel.org, 
 edumazet@google.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org, 
 song@kernel.org, 
 john.fastabend@gmail.com, 
 andrii@kernel.org, 
 mhal@rbox.co, 
 yonghong.song@linux.dev, 
 daniel@iogearbox.net, 
 xiyou.wangcong@gmail.com, 
 horms@kernel.org, 
 Jiayuan Chen <mrpre@163.com>
Message-ID: <6758f4ce604d5_4e1720871@john.notmuch>
In-Reply-To: <20241209152740.281125-2-mrpre@163.com>
References: <20241209152740.281125-1-mrpre@163.com>
 <20241209152740.281125-2-mrpre@163.com>
Subject: RE: [PATCH bpf v2 1/2] bpf: fix wrong copied_seq calculation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jiayuan Chen wrote:
> 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> the update logic for 'sk->copied_seq' was moved to
> tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.
> 
> It works for a single stream_verdict scenario, as it also modified
> 'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
> to remove updating 'sk->copied_seq'.
> 
> However, for programs where both stream_parser and stream_verdict are
> active(strparser purpose), tcp_read_sock() was used instead of
> tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
> tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
> updates.
> 
> In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
> in both tcp_read_sock() and tcp_bpf_recvmsg_parser().
> 
> The issue causes incorrect copied_seq calculations, which prevent
> correct data reads from the recv() interface in user-land.
> 
> Modifying tcp_read_sock() or strparser implementation directly is
> unreasonable, as it is widely used in other modules.
> 
> Here, we introduce a method tcp_bpf_read_sock() to replace
> 'sk->sk_socket->ops->read_sock' (like 'tls_build_proto()' does in
> tls_main.c). Such replacement action was also used in updating
> tcp_bpf_prots in tcp_bpf.c, so it's not weird.
> (Note that checkpatch.pl may complain missing 'const' qualifier when we
> define the bpf-specified 'proto_ops', but we have to do because we need
> update it).
> 
> Also we remove strparser check in tcp_eat_skb() since we implement custom
> function tcp_bpf_read_sock() without copied_seq updating.
> 
> Since strparser currently supports only TCP, it's sufficient for 'ops' to
> inherit inet_stream_ops.
> 
> In strparser's implementation, regardless of partial or full reads,
> it completely clones the entire skb, allowing us to unconditionally
> free skb in tcp_bpf_read_sock().
> 
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Signed-off-by: Jiayuan Chen <mrpre@163.com>

[...]

> +/* The tcp_bpf_read_sock() is an alternative implementation
> + * of tcp_read_sock(), except that it does not update copied_seq.
> + */
> +static int tcp_bpf_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			     sk_read_actor_t recv_actor)
> +{
> +	struct sk_buff *skb;
> +	int copied = 0;
> +
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -ENOTCONN;
> +
> +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> +		u8 tcp_flags;
> +		int used;
> +
> +		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
> +		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
> +		used = recv_actor(desc, skb, 0, skb->len);

Here the skb is still on the receive_queue how does this work with
tcp_try_coalesce()? So I believe you need to unlink before you
call the actor which creates a bit of trouble if recv_actor
doesn't want the entire skb.  

I think easier is to do similar logic to read_sock and track
offset and len? Did I miss something.

> +		/* strparser clone and consume all input skb
> +		 * even in waiting head or body status
> +		 */
> +		tcp_eat_recv_skb(sk, skb);
> +		if (used <= 0) {
> +			if (!copied)
> +				copied = used;
> +			break;
> +		}
> +		copied += used;
> +		if (!desc->count)
> +			break;
> +		if (tcp_flags & TCPHDR_FIN)
> +			break;
> +	}
> +	return copied;
> +}
> +
>  enum {
>  	TCP_BPF_IPV4,
>  	TCP_BPF_IPV6,
> @@ -595,6 +636,10 @@ enum {

