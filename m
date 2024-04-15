Return-Path: <bpf+bounces-26768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A898A4EA2
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 14:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C5C1F21696
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD81D67A14;
	Mon, 15 Apr 2024 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezki+IS5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80366CDC5;
	Mon, 15 Apr 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183114; cv=none; b=GMlyPbsjHGbfEjpaa3RDnIU7+7xdpLAmrusNvn1d6nxTQtPXn2bwc1njgOXvm0PuRGVlzuNTp546ibiXAxAhF21SGgsSLJtjHGTVTPVVm3CrQuZbjV5YwxghxT8agT6YvOc12Y5Mp+TmufjjFhj/JWjiO+A2fm5hQ0knR3UlBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183114; c=relaxed/simple;
	bh=hkoBOjYxsty3snJuIsQbwRCfX65gI8d6GqwHifBS7r4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnvNVYb219mc2Ra3bRHVxM9jwZ4O3oEIQz2g/hEb2GjhWyIqpa2ILDaVwv5eB3GV26YIw36sy2Xmw9V4VJ0AOve6a7fo1rzgyO91zX0jI9sboUyZskC1mkUFsVI06EM97fgU4aMRWMl7PbMKfFvHsOduazhnzyxMAQASzxcAAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ezki+IS5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so43787351fa.0;
        Mon, 15 Apr 2024 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713183111; x=1713787911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CEm2g66tvPpsMTaAGcWu3atK5dyjzdV+vUjngnnwu44=;
        b=Ezki+IS5tLJ5cGxExlGph0urU7uOjNiQLYkQbQKw2Yb6Lpt7NHFbPDunKSM8rTyTXl
         uv1c7EIjegXH6pCo6s0agCWguOGqgg36/wgKdHoSqB5iAcw3M8vWuYdpsqTEy3tI/x/l
         m5viNMpots4X/dJb2+lE60BhclvZKlUc7xUMTdZyxU31Aoq/j6V2AAahMj0t3f7tHlsT
         s00VyJ+Zq6YzKW3kQZ0UlItPjXbnayj5kLSQ6MzHvAs7QcWzYlEUGjJI8DiOebvGYVYl
         Si0x7nYwdwkMelexb3IRJi6iX698o8pYmW48wtTKrFT2Pwvnq4nDWDZmt833gBGquPtf
         TD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713183111; x=1713787911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEm2g66tvPpsMTaAGcWu3atK5dyjzdV+vUjngnnwu44=;
        b=ZBm4oyiRWxO10An6tT4IoUZ/+pDn6f/x3h426vJMp5PdC7vzzo+fwWij09qP3iPziB
         LFfyqrX8PwXI145U/8X1Y5DX88EpFGctiaj2+CmP1HPojfMOHcrUYBY2RCbjvNYHhgen
         5JLf80S26CrZ/W6uArkDbN2QY0OO+HJbGoE0MVaAsY73fKkHbcQNMhlFOvOeUaygfRRY
         ciRkrYCwkVdp9JTfmrlXgBG5tHNssCcpzDfE5gSLx8r7aM7BEG40MgECnSmTG4u6xxDm
         oulBZx1FTs8LtV/rGBpM82VqBH/f2Ve2uDYfE1i3kn0VbbQdX3fkX7v9fJoCdP54hBiN
         wusw==
X-Forwarded-Encrypted: i=1; AJvYcCVjZnnZWzi5COI8vh+O2YBv4zxK8VHJROWk2OL0drM9OADJ2B7WrXVlHm9xhTa/sWupW830j/VSl58hjaoCsMruryFp
X-Gm-Message-State: AOJu0Yw/+26r72UMqvm1JXNyFGOmw6ZvFAZjF0OcgnCbO32H3OUH6YAe
	vwBSJhuyoQ4xBOoQZt92d+DFCKcjQTx6MwNQghgE2kEO1NC2+sIq
X-Google-Smtp-Source: AGHT+IHkmDqtWXpk95F4znB0K2E89QOtIqeumJQqmwTgdmM5QN/42EbKjqVSrgAAmqq7tyOHG1x91w==
X-Received: by 2002:a05:651c:4c6:b0:2d8:1267:3202 with SMTP id e6-20020a05651c04c600b002d812673202mr7837133lji.10.1713183110739;
        Mon, 15 Apr 2024 05:11:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b00416b163e52bsm19320082wmn.14.2024.04.15.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:11:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 15 Apr 2024 14:11:48 +0200
To: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, haoluo@google.com,
	sdf@google.com, kpsingh@kernel.org, john.fastabend@gmail.com,
	yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
	martin.lau@linux.dev, khazhy@chromium.org, vmalik@redhat.com,
	ndesaulniers@google.com, ncopa@alpinelinux.org, dxu@dxuuu.xyz
Subject: Re: [PATCH] bpf: btf: include linux/types.h for u32
Message-ID: <Zh0ZhEU1xhndl2k8@krava>
References: <20240414045124.3098560-1-dmitrii.bundin.a@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414045124.3098560-1-dmitrii.bundin.a@gmail.com>

please use '[PATCH bpf-next]' in subject

On Sun, Apr 14, 2024 at 07:51:24AM +0300, Dmitrii Bundin wrote:
> Inclusion of the header linux/btf_ids.h relies on indirect inclusion of
> the header linux/types.h. Including it directly on the top level helps
> to avoid potential problems if linux/types.h hasn't been included
> before.
> 
> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> ---
>  include/linux/btf_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index e24aabfe8ecc..c0e3e1426a82 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -3,6 +3,8 @@
>  #ifndef _LINUX_BTF_IDS_H
>  #define _LINUX_BTF_IDS_H
>  
> +#include <linux/types.h> /* for u32 */

lgtm, did it actualy cause problem anywhere?

there's also tools/include/linux/btf_ids.h

jirka

> +
>  struct btf_id_set {
>  	u32 cnt;
>  	u32 ids[];
> -- 
> 2.34.1
> 

