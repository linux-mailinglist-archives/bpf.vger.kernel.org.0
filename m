Return-Path: <bpf+bounces-64512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D0B13B0F
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 15:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897223A9A3C
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38358266565;
	Mon, 28 Jul 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8fb3UBN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241832566F7;
	Mon, 28 Jul 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708395; cv=none; b=fis/xlwbjZgVJyGLAELWxZLltCriWZ2eqjPuc89wrdcJUJSxXDkDD2IgsGjfAyPaazIv/Bz+ccaQmTLRGf2BeG4J5KQsPmw083BfRurC1FwecX79hOddKtdAaBb/xmg2rt6bHlxFPXpHYRimdOBdyn91yTsIb6mhl9LtFTfDXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708395; c=relaxed/simple;
	bh=QnpLGbplVU8WZ8kkrDvGOUPeOR65rzZYVf9MhTKGYWI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9Z/13zJVANDXaLQDzGGWA0Wp9v5jdZu12r6pdyf54CAK/yI8wWLPtgBtjkR+iMHntgVm5Pqt7R+KhE586G1FJqxtwcnuSnJKfb+6I6mg3UAUpbRcpBWYLde5pNhhCYBfD6J20TLIMUMygGPDBX52EuQswzTZs1lRAKSckQWfz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8fb3UBN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae708b0e83eso832127766b.2;
        Mon, 28 Jul 2025 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753708392; x=1754313192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APcAiwvhLI1BWyHpWwSAgoil9Lsrd8sTBWTZU/FOIgc=;
        b=l8fb3UBNcn6SIOniEv0rKwzW+PNeZj9mGhMD1vh1ktQeJfJErFxw3CBfYqMQrCPWOA
         S9B2u3sDu0uXWd6XVFS3TXl4otaUORZ2idLNlj7rREV2zkLHlhh/Cw7tYiDElfu19IJV
         m9L8oseePryHOdnMQ3KpsJFBpUIoTmZ9M6/wO0wvlZCjzgGmEMVCDs1HdJa3J2wi4TJG
         eXU3Y14IPimij0BYerfAXVP+Li5fIQbth+FDi5sVjcbpORZnrGB7QiygAi1M7L0gYW4c
         0Gq/HVy9TMog1K8U6oCbIFfJ5ZEraOA/27ZNcoQqZpgpQ8liUTiotQ0Fq/tqR7Gz3vwD
         3ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708392; x=1754313192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APcAiwvhLI1BWyHpWwSAgoil9Lsrd8sTBWTZU/FOIgc=;
        b=CKTW6Ez9umuNwTmZvzQQMT37WrczK7KsKzOQz2wtUZ5dUv4MPAcROc/n8LpbZaU+pq
         5/aKJTbJVAcyglrLz2nWZzug7do1NjxUOdbhbb0zz9bukEDGH1R8sCv0OgmihCQ/iaAk
         jXzqXZdT4S53TPNngiMLLKHJmF+SegL7ayLlYtGG+P/vc37qH9nW1E6n85OXeyhWSXIk
         bI1hQGozzXQOJv5wyqv6Svf9suaUyOf6gWTtQ3KmHri3Xh+P30SDfj7eb7BgWHt4kKg7
         HT3lI8eacF4dGzePRdJxXXy5l95uAu/gw7H7zMfujj1/kvPdRJX+Lo19JT5uUaed9sAv
         gn1g==
X-Forwarded-Encrypted: i=1; AJvYcCU0imyJvDGZhbhopbHl44UrAj4Jq/sk9BW/84EDWA2snn22+PhvJDVIovnPyut7YOFZPx82CsNNiI/qoUi8@vger.kernel.org, AJvYcCV6L7Y53ebArxKUwzdmbsaWQhss6N3FQO6AjyQXZ6qwKna46an5btuVBX3sJpJ6W4Lgq1XwZTgeWNBo6TFUc1DT7zyu@vger.kernel.org, AJvYcCVfPtt2YzHsJgYFLwzfctjED4gdYse+eRIaHo41dRQgGMKQSg/aet/MCmP9m/dAe7o1cPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrgWXNEP4YZDUl4MezFFQzqmciEVzeKgJ3X6Xpu3FFZT+vVXat
	xFLTtGd2W5DH35otz2jY9Uzbzw/Z1KlPRSUpjhX6H/UMFqA/vB4lR51Y
X-Gm-Gg: ASbGncsH+UaOPI1q4XTun/Vdcca6F/0Vz+2D2g9DBLq4u3C2cpIh6ps99odFC6prsKq
	cUYiwUUxsqHljNxEogeDpCjRUXjePZDrxDyAS1VdSDoAYPpSF1rQeCQangi1rU4WQ/TGCHM7gcv
	3ba8NJt+Wz1jV8m/xtHNHhi8/uld6Q+/nAowUUQunkYkxgqhLhtz903s+hokiOWz/Pqu1/sroMh
	bAJUO+6ZalDeOLEEF5ac/U4kLu8uULSsE1AKnO75h3/7CVZE+u5itWp0aTys4HGZkJvqiHds9Es
	4zQY3S/fRken/XY4/ikNmEGt00GPIKIMUlutBcxF0i9ObH3S+ENneG7KU0oPhMRuP7G4BTMDB3v
	G1NoWttpc6kD2T8d8EeFc2krD9SPcow==
X-Google-Smtp-Source: AGHT+IFxFvoo1uaWCi0japBTc2d8G11avlTyqRxvI8u1fyVQDTxX/+1QkLSM9XPdVIP7XoR7AMfalg==
X-Received: by 2002:a17:907:3fa9:b0:ad8:9a86:cf52 with SMTP id a640c23a62f3a-af616d05720mr1276325166b.11.1753708392057;
        Mon, 28 Jul 2025 06:13:12 -0700 (PDT)
Received: from krava ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635af9967sm410482566b.131.2025.07.28.06.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 06:13:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Jul 2025 15:13:09 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, hca@linux.ibm.com,
	revest@chromium.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/4] fprobe: use rhashtable
Message-ID: <aId3ZSnlZRzoDUHC@krava>
References: <20250728041252.441040-1-dongml2@chinatelecom.cn>
 <20250728041252.441040-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728041252.441040-2-dongml2@chinatelecom.cn>

On Mon, Jul 28, 2025 at 12:12:48PM +0800, Menglong Dong wrote:

SNIP

> +static const struct rhashtable_params fprobe_rht_params = {
> +	.head_offset		= offsetof(struct fprobe_hlist_node, hlist),
> +	.key_offset		= offsetof(struct fprobe_hlist_node, addr),
> +	.key_len		= sizeof_field(struct fprobe_hlist_node, addr),
> +	.hashfn			= fprobe_node_hashfn,
> +	.obj_hashfn		= fprobe_node_obj_hashfn,
> +	.obj_cmpfn		= fprobe_node_cmp,
> +	.automatic_shrinking	= true,
> +};
>  
>  /* Node insertion and deletion requires the fprobe_mutex */
>  static void insert_fprobe_node(struct fprobe_hlist_node *node)
>  {
> -	unsigned long ip = node->addr;
> -	struct fprobe_hlist_node *next;
> -	struct hlist_head *head;
> -
>  	lockdep_assert_held(&fprobe_mutex);
>  
> -	next = find_first_fprobe_node(ip);
> -	if (next) {
> -		hlist_add_before_rcu(&node->hlist, &next->hlist);
> -		return;
> -	}
> -	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
> -	hlist_add_head_rcu(&node->hlist, head);
> +	rhashtable_insert_fast(&fprobe_ip_table, &node->hlist,
> +			       fprobe_rht_params);

onw that rhashtable_insert_fast can fail, I think insert_fprobe_node
needs to be able to fail as well

>  }
>  
>  /* Return true if there are synonims */
> @@ -92,9 +93,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
>  	/* Avoid double deleting */
>  	if (READ_ONCE(node->fp) != NULL) {
>  		WRITE_ONCE(node->fp, NULL);
> -		hlist_del_rcu(&node->hlist);
> +		rhashtable_remove_fast(&fprobe_ip_table, &node->hlist,
> +				       fprobe_rht_params);

I guess this one can't fail in here.. ?

jirka

>  	}
> -	return !!find_first_fprobe_node(node->addr);
> +	return !!rhashtable_lookup_fast(&fprobe_ip_table, &node->addr,
> +					fprobe_rht_params);
>  }
>  

SNIP

