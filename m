Return-Path: <bpf+bounces-21551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF52084EAFD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E68F1C21BCD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 21:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53CD4F5F7;
	Thu,  8 Feb 2024 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbJGAlz7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066604F5E9
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429525; cv=none; b=fW/YpgSRmVTjX5rI/E9CL+OLQda7GGefd5RlhOJ7BSz8kJd8PDfzze25Wy5gISej+iLKnnjfCx+6a3w1R+u0+xjo1yOq4GkveeMuuBhoKG8SGGEZkVFhSKKsM1ulIx3+p/jOXnTPl8INsoGuKh6HzeGK9LDlTtktptgYO+yeAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429525; c=relaxed/simple;
	bh=oUxuesC6t4aBoVcHoHXMrW9O6qK/2pInZdPmJg7NNZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkMith0AeGIJYZ+cwulwpuLMxJdfwDSfRAPqdn4+OCRnWzGbaXqiy8WntBoKxWKtyq42sg/e646ureWqBoA1i4o+EKbNOVQ4RItUJRn3mQjmRrcsGT8DDWzjsCSPeW1GSBH7nlsax3HwP8ydobg1pk9E3PaSCieVBLU5qgM44zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbJGAlz7; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so124934241.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707429523; x=1708034323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cixsOcAx/ctssVWC8Kd4Sx3gRvo1fWw8sVXsGnCk7gI=;
        b=jbJGAlz7VEQPSoinJ2eL2B5vJJKZVH5nQPkeFMwJOZldvXlbWrFFETwkt9DlRwKUkR
         RsIsCuenxCcQ12OlBo6l5cF5zh0vsBCIlFaH6A+rsV5v/r69T1ZRH3Ul2Yt8IcvFl0dJ
         GE+xhEfzvnCAilp2qnyjucGCJ7tpEa1i6g8GK6bsWO9r4mNzrHX45geKHnlZOtacLD+R
         4j1VigcQfChWNPDe9+eEDvFNgfpy0vfOTYlTvu2ayellu03G2baU+by8bsymM7ZyzI3N
         tubCJP9YkA5Au39QG4DYYryEM2sTWMahCkcvt8LXurpMZBeAwe7MxjSk8WE3LMJfjOI9
         QURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429523; x=1708034323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cixsOcAx/ctssVWC8Kd4Sx3gRvo1fWw8sVXsGnCk7gI=;
        b=R9TbqiJzvrHT8se9hqv1PLX7+rpcPRfKedoYQ5i+17Xeorga7Vf8vVj6arfiGYT1hc
         zqtfwDXZLEZZrNmAzzq6cb3zURwDNC688ktrg/MIi+igjIPAru+gswunf5HMzQADJUww
         8Z8EYnBtY/rBvXj1oGjpSblxP33eh+yovzYLt34pVgRPf1ldujlHl1cc59gUMusuWuSW
         989WpM+ds3aAh4/aPShvgyf8mkM89FM1U/7+sCl60J3R6hipxHQwPNam/IBD0NqNasG4
         m3nF7savzUnT6mpDXhrKjAk8xwgLmpkowOkWBrJ29yHfBQ/oOh5xJoTeOTBmdUX8axlJ
         iTQg==
X-Gm-Message-State: AOJu0YyNWC9GXoIKfQ/4pCN4ecZc3iinxjGInKA+5K1I73PyFT2ZdyTW
	ZDGLiZEDxLIDnzmYa9oHgLJuNenhlPFkCvBlwjg5LYn+MI7agW7QmTTf3WrIcQ==
X-Google-Smtp-Source: AGHT+IFEvx3NbmR/Gbgn7OyPl8YjOnacu1Kbantm+gRpdcdXClbwF5hNI4PwJ4MWEKmCCa/iUeAKwg==
X-Received: by 2002:a67:ebd2:0:b0:46d:1ff1:950e with SMTP id y18-20020a67ebd2000000b0046d1ff1950emr681619vso.3.1707429522686;
        Thu, 08 Feb 2024 13:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUG0UCIud/JVTuJHiD5rEOaz5DOrnkDNona5dc1V+do0F4uTycm+wE6MYEPkIvh5Si4AXpDwh3LOjtYhMY8tjXEApOjr7b2xRkElLV1qAKry9SvIl7OATkSmJdDomnjoJQDHCj9NvR/UNJae1537HykjDqr1jgViWKO2A5hNWPzlS9sDxtlWp+IcFU3+smiEjuKOdLxzY9F05rohUSO1DM9aQXBL7KstcIk78/HYJwrb7dU6Tsj5+UmawxVhIfL0TgDFlyX9yvd1veasy8g6aeWdQiAikxm/KfwdCaUCV4=
Received: from [192.168.1.31] (d-24-233-113-151.nh.cpe.atlanticbb.net. [24.233.113.151])
        by smtp.gmail.com with ESMTPSA id hx6-20020a67e786000000b0046d4b868ce0sm49028vsb.34.2024.02.08.13.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 13:58:41 -0800 (PST)
Message-ID: <b1fe20c8-cd97-4ffc-8043-7fe42bf18c77@google.com>
Date: Thu, 8 Feb 2024 16:58:37 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 04/16] bpf: Introduce bpf_arena.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>,
 Kernel Team <kernel-team@fb.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-5-alexei.starovoitov@gmail.com>
 <c9001d70-a6ae-46b1-b20e-1aaf4a06ffd1@google.com>
 <CAADnVQJJ7M+OHnygbuN4qapCS8_r-mimM6CLw5oee8ixvmqg4Q@mail.gmail.com>
 <d4024acf-97c9-4a16-ac70-739d0bf81a45@google.com>
 <CAADnVQKejmHGDUAuRA+G2Ex0=+FcmTpVZ67DEZJHLjCMckx2xw@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAADnVQKejmHGDUAuRA+G2Ex0=+FcmTpVZ67DEZJHLjCMckx2xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 01:26, Alexei Starovoitov wrote:
> Also I believe I addressed all issues with missing mutex and wrap around,
> and pushed to:
> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=arena&id=e1cb522fee661e7346e8be567eade9cf607eaf11
> Please take a look.

LGTM, thanks.

minor things:

> +static void arena_vm_close(struct vm_area_struct *vma)
> +{
> +	struct vma_list *vml;
> +
> +	vml = vma->vm_private_data;
> +	list_del(&vml->head);
> +	vma->vm_private_data = NULL;
> +	kfree(vml);
> +}

i think this also needs protected by the arena mutex.  otherwise two 
VMAs that close at the same time can corrupt the arena vma_list.  or a 
VMA that closes while you're zapping.

remember_vma() already has the mutex held, since it's called from mmap.

> +static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id)
> +{
> +	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;

this function and arena_free_pages() are both using user_vm_start/end 
before grabbing the mutex.  so need to grab the mutex very early.

alternatively, you could make it so that the user must set the 
user_vm_start via map_extra, so you don't have to worry about these 
changing after the arena is created.

thanks,

barret




