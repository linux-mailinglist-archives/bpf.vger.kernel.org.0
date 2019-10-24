Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A889AE3CCD
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 22:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfJXUM3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 16:12:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41130 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJXUM3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 16:12:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id l3so1431385pgr.8
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=annlQ4B89TXMT/av8hRxmdJ0GCp4n7975nArSdnuAaY=;
        b=DpdZEu6bBmQYSSli5HB6IC+qFnG+mBIBKUBYnJIE+zrHnKQoAbmcJ3lZjE1AplyNem
         eNeeVq/GvUiYhIvCFMz41K91SMZlpvn+tBagDz+Yyg1JXZJdjdVLbkwm07/spoAioZAY
         lbsDMFFWMeeYt/mRag6CZqxcIzE0EdKF590PAC+btSpu+OKVjLzeoNVVHGGkY/rn5twB
         8upJkxM+XVNeLKGg2YZljoY0F3p6n1sQ5AMWS8T5dDgISKoXKaG+52To3IkfFOttRsvb
         RzfHSLU422JBJ0nLxAJbQ6QtZbkLlKwJDznFsM0+1BIt7KHMHDdYz2gqK/K3SsN8M8Vw
         J7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=annlQ4B89TXMT/av8hRxmdJ0GCp4n7975nArSdnuAaY=;
        b=DzhNJ1EMGkzlcKj4AygzvQH3x55tE4nlmI0y+F4mcHjCqeLJp39bnQhS4ln8Fh4Kwo
         yT10oVOjaWrETzvt1bQJTEWEX1zhDzMIbtgqXZYygwO8t0OCVjfjFV6K7JMZfR7q8S6d
         /VkNkU24L5MycKZ4gdV8hapnh0OyR6o0hhafY/RAkZf22ZlJLF5z2K3BaNyCO0xYLcxK
         yy+quZqOqlr7LY3KxAsM7BNShBbsWZglxo4RI1OVlbQaxbd8VtQWxL1ZDfn2n0kjvYm4
         Kak1eloWPDL73/eBspcdXKpX3hx4sjAwrFHQx1Cij4FiIfZxMcQMR7ru2i86FMmw9b3M
         b9NQ==
X-Gm-Message-State: APjAAAWAHicSJKWLOEGh0EsvfiQ50pioOuP4+WSKvhDodSVocloGr6Gg
        TX/stRmTCHkIO2JK1CKgn+9R6w==
X-Google-Smtp-Source: APXvYqzR6uvpE3/TLYNNn9aluGT0VzDU6IJUZCOiZXhjmP56Bkh1EHv7xLBAO4znpM+zGzoE7GmScQ==
X-Received: by 2002:a63:e08:: with SMTP id d8mr16923374pgl.41.1571947946733;
        Thu, 24 Oct 2019 13:12:26 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net ([2601:646:8e00:e18::4])
        by smtp.gmail.com with ESMTPSA id n2sm28380349pgg.77.2019.10.24.13.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:12:26 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:12:22 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Toke =?UTF-8?B?SMO4?= =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= 
        <toke@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, magnus.karlsson@intel.com,
        bjorn.topel@intel.com
Subject: Re: [PATCH bpf-next 1/2] xsk: store struct xdp_sock as a flexible
 array member of the XSKMAP
Message-ID: <20191024131222.70ca703b@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191024071931.3628-2-maciej.fijalkowski@intel.com>
References: <20191024071931.3628-1-maciej.fijalkowski@intel.com>
        <20191024071931.3628-2-maciej.fijalkowski@intel.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 24 Oct 2019 09:19:30 +0200, Maciej Fijalkowski wrote:
> @@ -92,44 +94,36 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
>  	    attr->map_flags & ~(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY))
>  		return ERR_PTR(-EINVAL);
>  
> -	m = kzalloc(sizeof(*m), GFP_USER);
> -	if (!m)
> -		return ERR_PTR(-ENOMEM);
> +	max_entries = attr->max_entries;
>  
> -	bpf_map_init_from_attr(&m->map, attr);
> -	spin_lock_init(&m->lock);
> +	size = sizeof(*m) + max_entries * sizeof(m->xsk_map[0]);

Maybe the array_size() I suggested to Toke was disputable, but this is
such an struct_size()...

Otherwise you probably need an explicit (u64) cast?
