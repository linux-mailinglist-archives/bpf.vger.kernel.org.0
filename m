Return-Path: <bpf+bounces-72587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFFFC15E1C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6863A2DF1
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C233032A;
	Tue, 28 Oct 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AFx+lTO/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0OCrF9SP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AFx+lTO/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0OCrF9SP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA22257852
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669303; cv=none; b=AoHaRwYF4lqrKB76iHgvBSo4yEsSATCQ+9WLVi+/0+jVjPe1nNxoHU2tAOaQjsxxdxwEsdTEYsqCuZy43xRCDkgLarB9W14bhFWE/nqZ/OrlCU9c4ranNb1cXGKHH2CBW5VcrYjXkO/UCy8qyUCdzEV6PxbtoiMQ7dDIcVWxwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669303; c=relaxed/simple;
	bh=ehZTqzLesFvK0zNxNOB5Kro9fA0DfjJGFU5qk0PqFvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+apfveUvi+SLtKcEIttBc9idLyTRSgSgvENtqPUJDUgUZJ8ldrVpTBvjnWfgm4uSoQL0moyDIRfnSZuOlB02rT8hP2DIbGk8ICIRNTP6hxZ+/lwla6e/6hKEnEXmaFDXmFXdL0sbQCl1gBg00GyfVNKycc8Hj1PX0/TOkjIfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AFx+lTO/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0OCrF9SP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AFx+lTO/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0OCrF9SP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0BB3218DF;
	Tue, 28 Oct 2025 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761669299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phyOXUwhpPX8VIgv4J33dCN3/ofby5jscWO6ji9fPD4=;
	b=AFx+lTO/IUHNrg3exXUr8cWEVK1pW+00GEyZYgNubbQDVBMViMr5bI3JkfVRWC62YvAoTw
	5NF6ekZgg2nY9PDdT+dKc9ii/bvOqgxvaeW2L/EY1PhH7fotZxfMrvodEBG7uL+qL6CzYv
	uJsgnDaprGFZ9Z6WOO1Lp/2jpzI5Yao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761669299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phyOXUwhpPX8VIgv4J33dCN3/ofby5jscWO6ji9fPD4=;
	b=0OCrF9SPjgMnAlrDvip9JHtYAXepPyIMRDfWLatFrQq75HbZUI8wFvBR6j3uIo7Zl89oAW
	J+r+HHHwMluaKnCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="AFx+lTO/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0OCrF9SP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761669299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phyOXUwhpPX8VIgv4J33dCN3/ofby5jscWO6ji9fPD4=;
	b=AFx+lTO/IUHNrg3exXUr8cWEVK1pW+00GEyZYgNubbQDVBMViMr5bI3JkfVRWC62YvAoTw
	5NF6ekZgg2nY9PDdT+dKc9ii/bvOqgxvaeW2L/EY1PhH7fotZxfMrvodEBG7uL+qL6CzYv
	uJsgnDaprGFZ9Z6WOO1Lp/2jpzI5Yao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761669299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phyOXUwhpPX8VIgv4J33dCN3/ofby5jscWO6ji9fPD4=;
	b=0OCrF9SPjgMnAlrDvip9JHtYAXepPyIMRDfWLatFrQq75HbZUI8wFvBR6j3uIo7Zl89oAW
	J+r+HHHwMluaKnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54EC713693;
	Tue, 28 Oct 2025 16:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TmCpEbPwAGncHQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 28 Oct 2025 16:34:59 +0000
Message-ID: <c02c0369-ece0-4437-aa56-e8e36d945a23@suse.de>
Date: Tue, 28 Oct 2025 17:34:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 bpf] xsk: avoid data corruption on cq descriptor
 number
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, kerneljasonxing@gmail.com,
 fw@strlen.de
References: <20251028160200.4204-1-fmancera@suse.de>
 <20251028160200.4204-2-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20251028160200.4204-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C0BB3218DF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,gmail.com,strlen.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51



On 10/28/25 5:02 PM, Fernando Fernandez Mancera wrote:
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
>[...]
>   
>   	len = desc->len;
> @@ -804,6 +823,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>   			if (unlikely(err))
>   				goto free_err;
>   
> +			if (!skb_ext_add(skb, SKB_EXT_XDP)) {
> +				err = -ENOMEM;
> +				goto free_err;
> +			}
> +

This is a leftover. Without it, the logic simplified and indeed the 
performance for non-fragmented traffic is not affected at all.

While reviewing this, consider this line is dropped. I will send a V2 in 
24 hours anyway as this is indeed introducing a buggy behavior.

>   			xsk_skb_init_misc(skb, xs, desc->addr);
>   			if (desc->options & XDP_TX_METADATA) {
>   				err = xsk_skb_metadata(skb, buffer, desc,
> @@ -814,6 +838,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>   		} else {
>   			int nr_frags = skb_shinfo(skb)->nr_frags;
>   			struct xsk_addr_node *xsk_addr;
> +			struct xdp_skb_ext *ext;
>   			struct page *page;
>   			u8 *vaddr;
>   
> @@ -828,6 +853,22 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>   				goto free_err;
>   			}
>   
> +			ext = skb_ext_find(skb, SKB_EXT_XDP);
> +			if (!ext) {
> +				ext = skb_ext_add(skb, SKB_EXT_XDP);
> +				if (!ext) {
> +					__free_page(page);
> +					err = -ENOMEM;
> +					goto free_err;
> +				}
> +				memset(ext, 0, sizeof(*ext));
> +				INIT_LIST_HEAD(&ext->addrs_list);
> +				ext->num_descs = 1;
> +			} else if (ext->num_descs == 0) {
> +				INIT_LIST_HEAD(&ext->addrs_list);
> +				ext->num_descs = 1;
> +			}
> +
>   			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
>   			if (!xsk_addr) {
>   				__free_page(page);
> @@ -843,12 +884,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>   			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>   
>   			xsk_addr->addr = desc->addr;
> -			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +			list_add_tail(&xsk_addr->addr_node, &ext->addrs_list);
> +			xsk_inc_num_desc(skb);
>   		}
>   	}
>   
> -	xsk_inc_num_desc(skb);
> -
>   	return skb;
>   
>   free_err:
> @@ -857,7 +897,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>   
>   	if (err == -EOVERFLOW) {
>   		/* Drop the packet */
> -		xsk_inc_num_desc(xs->skb);
>   		xsk_drop_skb(xs->skb);
>   		xskq_cons_release(xs->tx);
>   	} else {


