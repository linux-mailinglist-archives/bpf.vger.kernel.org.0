Return-Path: <bpf+bounces-44862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 047199C91C4
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 19:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28539B25188
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E182419939D;
	Thu, 14 Nov 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/ZpFRuQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F813BC26;
	Thu, 14 Nov 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609599; cv=none; b=OB3m0Am1qGQjz5t+EgmTi032ZZU90I8uxm7E5vuBWcPP8uZ0Q3rpZZpADlKAyy1AKKXVjpAjuky/Hp0C+3yEAM5PdE2LMUbHuA6eHgjnzmcAbxvCWK/xjwWZ6JUWNIYAGMZ+3MC8r59iN6YCbcIYggYbBCjTnrlWv8CMSxu5hPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609599; c=relaxed/simple;
	bh=kpJBCkoDrJXx5E6z714QrJryuCmJ0qESrUpl+NIvZSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoaEso4zi6zd+aldzPBEioE2Ad6GqD0NOgexr0GxdGxH4sHuzqc4JRgCoNSKFRvl9scJgZf/tpm9ylLO8aGcIdLj4iTIpTIex2wNvGTY8fE0D1KsU///qQHiktcG9nBQNK1TG4ucS5Nm+1YsxTh6UsmsZ20ubrsQVvVanySI358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/ZpFRuQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cf3e36a76so11073275ad.0;
        Thu, 14 Nov 2024 10:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731609597; x=1732214397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+hz4FbqxA7iO4r+dSd7ifEE9rK3zHg0EFroWRcTaJc=;
        b=O/ZpFRuQbZyu0cZvphYeZKAsXcxqpjdWhry0giOpgtgVlnV7Rli3Va8DYWJA1tk/Sm
         Y+7SvLA5Bh8SSYWhDdkew63k7z9xVAVRklAky3wE4Pa7W9ih+tbZuNWAIOw3J7pqz0Zb
         DIHQJmomI2ihMrrG1+2GPX6OnUOuhmbr1Kbg/kGf17TJatZjfYeodmXvhTuuPGDlyzJb
         OO7EGDr85qqkroyxb7cerx1EE+R9tds9qc+pnGQIhoCK6TTLKZbTSJOlWb2JJUgtyHNg
         bGU+jxnEwEYxprB8+/kBCwuYjGJrGEwfO03WzRDiGWlFtk3QLLbi+aFZHs+uHe0Ke75Y
         dNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609597; x=1732214397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+hz4FbqxA7iO4r+dSd7ifEE9rK3zHg0EFroWRcTaJc=;
        b=CBfEGnPHGmk6PURoj/5rw6cYWxNQIIm6mOS8hFDInixB+dmvn57PiBBqbt+aHYUq1K
         5DfyeFBPiRHmVY2sWTjJsWFULp5ePsncWwaVJsxXAncmqALzC71olIxdVtWGrkLWIMNL
         qL0XpewJl7wN07dHVFGDFJkhjvDvxp/SlMx7oWclOSqMEiuEXUbs2COGhSqYPY5rW+ef
         9lX07SH6JlfZicr/Uj0EsP0+O5q1p40D8vVmTJSU6tZXe5ivLyQl0Jj3lQ8iqto0f4LC
         VxM9YUkX1dIUgTCW+TLbgNd807tgBLMH0k6S1urHz3MZ/BeJL7Tp3/hRNbkEb39LRBoW
         2FrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmSnTMsrzer3HPwkZ4tkCa3MtM+r6GBIXvdSnkJO5qca4j/hMkXdxW7ex3ZGRYu66SEKEJJoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYhT1WwZEB8aL9wB8Ej+40Le2UkW04kznCmLpOUSI7XxKSuNt
	76skZvFYI/ot3SArBFSEP//D9/UYRTjrh4VKXjIocYapkqRBCpw=
X-Google-Smtp-Source: AGHT+IElgCA0i2grlKo51sygl6oZVX5wO8BtSVytfhYkqfQm3SwUy98Lc2quyX+yUvXeIXCmwjfS5Q==
X-Received: by 2002:a17:902:e843:b0:20c:d428:adf4 with SMTP id d9443c01a7336-211b5d2aac4mr116339355ad.38.1731609597208;
        Thu, 14 Nov 2024 10:39:57 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d3e7easm13334525ad.283.2024.11.14.10.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:39:56 -0800 (PST)
Date: Thu, 14 Nov 2024 10:39:56 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Felix Maurer <fmaurer@redhat.com>
Cc: bpf@vger.kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	yoong.siang.song@intel.com, sdf@fomichev.me, netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH bpf] xsk: Free skb when TX metadata options are invalid
Message-ID: <ZzZD_Dh9H8M7JxDs@mini-arch>
References: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>

On 11/14, Felix Maurer wrote:
> When a new skb is allocated for transmitting an xsk descriptor, i.e., for
> every non-multibuf descriptor or the first frag of a multibuf descriptor,
> but the descriptor is later found to have invalid options set for the TX
> metadata, the new skb is never freed. This can leak skbs until the send
> buffer is full which makes sending more packets impossible.
> 
> Fix this by freeing the skb in the error path if we are currently dealing
> with the first frag, i.e., an skb allocated in this iteration of
> xsk_build_skb.
> 
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> Reported-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reminds me of the following:
https://lore.kernel.org/netdev/ZNvB9AUzNIzwMW6+@google.com/#t

Maybe I need to try to cleanup this path. Too many corner cases so it's
impossible to get right :-(

