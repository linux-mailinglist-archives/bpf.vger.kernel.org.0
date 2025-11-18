Return-Path: <bpf+bounces-74927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B09C68960
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5097C35F7BE
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1831B803;
	Tue, 18 Nov 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx2F2TK3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96B31280F
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458537; cv=none; b=Ym/yDCdgKj1QXo37NJOvj+gAt7FG5U+hBxNZVsvPURLSrg63WbO21CLWqBy8PR0n/80F6J8diK/m7TgqeieBImDbXEq2xG3u5NeXYUBMiRQ3EEOoevKdZ2rUR8t734/mBj2e81keBvIQPkPUVJS/hwFZzcxAxqJMysW0Kh5/7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458537; c=relaxed/simple;
	bh=cUx1mDw7CA2PXlhUBXip6UAg9a6UTylS6JmmYkNUnaQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCE2A5qMuY7OQkg6lf1XP9py8beqilD8LYKajjfA/2bEFbzWe/xpI2tFNXXUlc2WNpJ+AKTxrW2ul7P7M8mc2fO0LxLy7i6QFM5nOTCUrQmU28oHps7JzC9/24EJpVefDg880/KoHbPmdGq9IK6ffVUG3J0U+tngtVzXAfIFjD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx2F2TK3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so5847509e87.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 01:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763458533; x=1764063333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mmkM6Odc/QB0X+c5pfn2PvbEetlpGWBu1Jlh7QaZPiU=;
        b=Jx2F2TK3hRN/kf//hdgE1VjNM/EzeXv/1KDblrEeGGv43b1uqLFugaxL+EOz+eiHoD
         Pt/u0FdOR/MLOosm+U47BMTxwXbCUGUj9zoLt1uCOhdBdGZFROEb500oGqFJMjJYZ/A8
         8G7MgzqNw3DH3ibqs6yZr7s0diOB5M/AHWFg4HfNosyxRBVnuZKlkszca9McnJKW3BYj
         RYiF0hDDIMnYPgD6zELHFN+KeKhOiNBxHXzamtwYfR/0bXo/HatdgGV5KchceLK4iGAt
         dCIxpa35otXCx5D4SQkyregr+5Na3UbH7+ZmT1uQvriCBz3KPkff/kXBmNLRVNYJ21Sl
         kHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763458533; x=1764063333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmkM6Odc/QB0X+c5pfn2PvbEetlpGWBu1Jlh7QaZPiU=;
        b=UROHaQpef3FY2qu70IhcK5qn+D8VZgJ1WaGg10/d+66LJljFWOcWOxmUlzbMnvbk/l
         H+3NL/DqNVDSYpA52upS2UwDLieke3Sd5ARpB9yU22ZU2GM3utayg1H3ktvQXog6ZaP9
         u1Bi3mTKOES1TGTF08acRIRayPIzV9/RL+A93Umiwiy8v8br6cE/otHpkuNuu/Wd17Ox
         9t07TslvFhjnW5PIJ8yvydJCAfmfBxP26Qoedxwt9RLqQVPr7QOukuR8tJm5OJW6uzmz
         hKQ6KiCNgWQ1ES0Y6YIrgXXb5iuW+isw8PKZWqCArf+SK/7YwWK0BEVessWFqcvf27+Y
         TMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYwyOE9EvJTDYsQatEglubbyZbUy+8MBPGlRhPpy0PyR+A9iDGV9c4n5Jy4RrsIXzYDAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmPqXGedpDIcrKFU2crUKVMP+SlNg8lTS0q6wPNYi2UT30E9m
	xk4PwBBxeZQG6oG7pFTfgwvpQyE2/CTw5dgR9Hv+d9Q581AiQi1N0BBk
X-Gm-Gg: ASbGnctSL16B973hkh2k9Ddl7wjmhvXW3TAzuEPHlSAK+50nNzJIyvWvZgvhvWSNibP
	3nC8fBQKNoYVqWLX8lrQwFAPUr7atJ1dwJPTq5yUwLDrjfPihJxOS+iYrdLkOFwdRHhYs/m8T0+
	LGG4roqKkwJds1TAPpfZa4zcDLU/M+jSGQuGOQMKQlcCaXQueu47Z/MImJNrdkg0jX4csPBd0DU
	yuBl3q5x7GZZcx634UymGSMJy1DveydWLfImoDrheKO0lZb+ZKAN2mAUoI2cl5aZAZ5d/MD20r0
	5hdetaBLKRhfYG1Po6Z2lmbFjIbApnHhZMkoiDdzMgeT0HnNAMp0BjAHE6V2h1LNjvMNNrbZ/46
	8Zi5b2Sbmp1tjhPOf/VDZc5r2hye/uA4ugA+4Vbk6XNwane3KMMkd9zxmNgCCPgI5aatTmnFI/r
	O/6IwaZHSQt7niLsxBC+TTnOizoCRZsSKvS+eXbdIO
X-Google-Smtp-Source: AGHT+IHAyixml+9d00pn03L9D9JQVUO3otZc1JoJICUNXyrrzweQPTrxGiEHnYlU9O4XvKcrwIkU4A==
X-Received: by 2002:a05:6512:3e26:b0:594:34c7:cb6c with SMTP id 2adb3069b0e04-5959876f719mr812868e87.15.1763458532578;
        Tue, 18 Nov 2025 01:35:32 -0800 (PST)
Received: from pc636 (host-90-233-212-127.mobileonline.telia.com. [90.233.212.127])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9cef41d5sm33577691fa.49.2025.11.18.01.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:35:31 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 18 Nov 2025 10:35:30 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/4] mm/vmalloc: cleanup large_gfp in
 vm_area_alloc_pages()
Message-ID: <aRw94uC_Obxebk6T@pc636>
References: <20251117173530.43293-1-vishal.moola@gmail.com>
 <20251117173530.43293-4-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117173530.43293-4-vishal.moola@gmail.com>

On Mon, Nov 17, 2025 at 09:35:29AM -0800, Vishal Moola (Oracle) wrote:
> Now that we have already checked for unsupported flags, we can use the
> helper function to set the necessary gfp flags for the large order
> allocation optimization.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/vmalloc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0929f4f53ffe..d343db806170 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3634,10 +3634,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	unsigned int max_attempt_order = MAX_PAGE_ORDER;
>  	struct page *page;
>  	int i;
> -	gfp_t large_gfp = (gfp &
> -		~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL | __GFP_COMP))
> -		| __GFP_NOWARN;
>  	unsigned int large_order = ilog2(nr_remaining);
> +	gfp_t large_gfp = vmalloc_gfp_adjust(gfp, large_order) & ~__GFP_DIRECT_RECLAIM;
>  
>  	large_order = min(max_attempt_order, large_order);
>  
> -- 
> 2.51.1
> 
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

--
Uladzislau Rezki

