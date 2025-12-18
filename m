Return-Path: <bpf+bounces-76965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90251CCB1AB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 10:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC5630688DF
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2572F6197;
	Thu, 18 Dec 2025 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aVMlaSDD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684B72EBBBC
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048961; cv=none; b=XUmeCKMJ9aXIFVRBAX6nVIyGxv+ypa7gwWEilr7vn6hX39HlSiNbNDNpbGpGqA9pmArw4pVWzMhAogmlUqJnrMTG1MgBVNJHOqP3vmEtXm5vKK46O143QH7wU34HG9Of5Q1lrrkN/fp3HUpWTJXQfxcGzekj57syj1yH6EbHAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048961; c=relaxed/simple;
	bh=xxT/SxIGJkljEhPJaJG/jzfe8Jhuf+sTOhwp7mqcsqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2UaRhd1oT1oxbP3aFWec/DuBjsJZzlLZyS/tTkPsJKlbPj1cm6fybmdMI3k9uUlkzUScjsU2XrscdrDxdYVlvlvzzqZe8ERpRUKg1LtWnkgxenSdeyNk3dRZYsZ1waxIK4i/5/3J9U65eWyPO6paFVMgeVGaOYtkXFIraqYgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aVMlaSDD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-431048c4068so206207f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766048958; x=1766653758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwwKGkT8jQ+mkcWG3dVItAZ5McCTnVMRZyiBYaakX04=;
        b=aVMlaSDDCtEqbV8823rRbTgGwbSr5wrQfzelFk2mtGAtWY7inpuBZRbJqiyM0Ea9Oa
         mAoYXYxr/KnrunWTeckjTD4nHWq8PbvK1LK2c5hSE1SbYR7m5mD77/M8vZ+3LyRYdvjy
         otlANRz3raKSFBpQ/GT10HZEsy7ujRKgxhUw7aOzApankECs3Q4LBY0C1PeCpEU08PoE
         YyrDz2lxXbU1c2Z6lGbexmpNiuTHveEA+3duEGzeWrN9s+1NHaVtfp6dkx0XU0/xF17l
         bQuYMPvnvbIpXauLVusF2nHUKu/Swu7Hj3lY7cZvYG4F5N0GCcj8kYTAGE0OvbQscyjI
         LvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766048958; x=1766653758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwwKGkT8jQ+mkcWG3dVItAZ5McCTnVMRZyiBYaakX04=;
        b=UtoCt7a84mxLwqFYGfxGhDzGgG7f6jF1t5xv3xe2z2EYrWXSVLGiv5W6mc1Cw+rsDw
         NLcUXnwOaMkFz+5HItjZeI0vgKN0mVMEhETEjX6YeAVGSB7ACmHcir88+GqtxcgjheYo
         +1UGu6ckaKd5up5tKl4srYaXIaGQxyIw486vZ5ob3RnkBz5JUbkTIO2OUyBBoa4d/xLI
         niYc1Q7E8jtLJxq5F3y0Nk6InKOBjbhq/bucMUdy2XqyFQ3ZygluHXB1NxDe4nbp/ik5
         3QgPM2AA5fVPiWiTLi0q+usG/g0BNktLDb0IikhWfRsDn4Jh+lovtyrngg6/tCYXsWJN
         0jsA==
X-Forwarded-Encrypted: i=1; AJvYcCUwZGEZT7je0MqR407bnwTp6uvLVyveqidHwDsajhbxIfV21yRcciTl1EobJWB/dXTJ7no=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVqfNBHW9dGd34WB9LlYUvVeZO56dE4T8fVXuewAHwdXGDCaP
	LmGJL2nDqf0DVTmN2J4HMKh5+soQfnVlXRxc8xu8+iq4gEM/v48+PaOwNzQ5cdozCeQ=
X-Gm-Gg: AY/fxX6NyI9XJhkC4x/mfQU6ulfrxZDESptdBRiBKEPf6gKJ5hL5TQbIB2I7nWAJPuT
	bghqOwiw/s+7QzdHvrvNJhQIqEvtojj2IqKP1yQ5bSPGIxDnE6ZeqRQxNhltmZeqsyfKpUXPZRi
	1IiNYjzx0GQxOKxT21wZ/7TkJfE4oRXZPLHPWY0hznZLvKaQmuHYBFmUgKAjhg8auWf6hdcfysi
	olXek2pjc54kDBbjeojhy8Xf55gOSrYFswrt2QpocNsJogPmqcrzPmEq8oEOqGI5gofeZpBE2B6
	w8Jk/RmGEb2MIdLuZlN1JAWOP/eeqVRIMEDbIBtZHz3Crx+tFHDZczIx09ERmgtMCFUEPzxiYmC
	g4NenCCZ+2dwcC35+Kq3KBI3WeqRvWs0Geh8rU+ktckkehxtsNDBumlE7jy4TCs6K7nBRHorAu/
	G5yzmwkO/X7PDU7Q==
X-Google-Smtp-Source: AGHT+IF2Dw3MO5Fpz/OaFRcBV9fS9cLrSTXBGYv7yLVwKCoH2iVNb+O20dDu2owV0ukJ+8lTxdTkqw==
X-Received: by 2002:adf:cd91:0:b0:430:f2ee:b21f with SMTP id ffacd0b85a97d-432447b2173mr1831219f8f.22.1766048957796;
        Thu, 18 Dec 2025 01:09:17 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244949ba6sm3846440f8f.19.2025.12.18.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:09:17 -0800 (PST)
Date: Thu, 18 Dec 2025 10:09:15 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kallsyms: Prevent invalid access when showing
 module buildid
Message-ID: <aUPEuwRpMlAoy5SR@pathway.suse.cz>
References: <20251128135920.217303-1-pmladek@suse.com>
 <20251217130904.33163c243172324a5308efe9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217130904.33163c243172324a5308efe9@linux-foundation.org>

On Wed 2025-12-17 13:09:04, Andrew Morton wrote:
> On Fri, 28 Nov 2025 14:59:13 +0100 Petr Mladek <pmladek@suse.com> wrote:
> 
> > This patchset is cleaning up kallsyms code related to module buildid.
> > It is fixing an invalid access when printing backtraces, see [v1] for
> > more details:
> > 
> > ...
> >
> > [v1] https://lore.kernel.org/r/20251105142319.1139183-1-pmladek@suse.com
> > [v2] https://lore.kernel.org/r/20251112142003.182062-1-pmladek@suse.com
> > 
> 
> It's best to avoid sending people off to the WWW to understand a
> patchset - better that the git history be self-contained.

I see. I'll do better next time.

> So when
> staging this for mm.git I scooped the relevant material from [1] and
> added it to your cover letter, as below.  Looks OK?

It looks OK to me. Thanks for taking the patchset.

Best Regards,
Petr

