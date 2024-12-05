Return-Path: <bpf+bounces-46146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FDC9E525C
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917F4284DD0
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF71D63EE;
	Thu,  5 Dec 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7vlV6rp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F419007E;
	Thu,  5 Dec 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394787; cv=none; b=Ex8rDLzztzmZKSq+r4gbBTxWIVMXlFNFaltttVKcJCYlHgvkXZ+GA3BhQWtNBZwP0w82sC5+2gwgzQF/O7dSn2vnLG9T17EXTytCU/pYkZjJePIV6xXZBonVZm75e301XyfsPF3p3GovlW2zijP6CR4yX+T87OzGajMfwD9Vgus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394787; c=relaxed/simple;
	bh=eQOR06vgtGzzybcdYp0pZ3dmCpAwjfqkKijb7ds4SiE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNXlAT0mSRurD4BO1by1nDLTTgl07FMzVZAczzfXip3vP21LZCiOKN+ujn2izWW+BxPo/8/Ec/ZL+/icRhmyWz73FZ+XGWbojnyzfQ65ywcLxUOl5yNBH/YwcbOKBV7V9xUMP8oMt/PbYOCcGlrw+eX+NMIEwzVyw8nVILGITbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7vlV6rp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa530a94c0eso146153166b.2;
        Thu, 05 Dec 2024 02:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733394783; x=1733999583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLjCmhyfXM5Xf2+HanMqUwO18jM/shPAxxCY/VZ9By0=;
        b=g7vlV6rpf/9BrOQNTjWKyM/dcyktgdlIlBAu5tV/OAVYry6jznxkZ243mNgsohySSG
         mm7frSgHuEAvs6hG635R10ZuBBKzwRRG6eQ+IseW26Hw0AG9IJDcDTHwprzWCyMOncZh
         6DLJgAhKaBvdKFMhUVXrtIJKwDVvE4bGPK8G5r47E657tzP+HqR33fNA6bCSY4qejc99
         RKFcugpiTtxf0LBJFHMFEhEXAWfQdpuz8myJ4SrPR1fNSoVInOOVKIuyA52ZlqISqPE/
         QfoHiEfu4J1DNC4oLcZTw3jQ14QMJ+jwF+Vn8m5vqqKDsCxPyCkmhhQvs/a8391cewpN
         tX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394783; x=1733999583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLjCmhyfXM5Xf2+HanMqUwO18jM/shPAxxCY/VZ9By0=;
        b=jerYEzN2PDGFSccMCnorwqIVA7YEnaxj/xiRz+CbJk9nz4drUchovNJGSsox6SHn+l
         je2ycUkh2d11D23CdYhke0IfK1VO3GRmNX3VgjibAXU/ICs7sSqzXS4WW+I7mI0Z/NWF
         Z+qURDR8XqYE0xDbcD4DxNi1O8XrfaNW/oOdg643EYNmesr7TeHdqToSW/O+YGxB9T+J
         iqdf+5jh9q3ZHrgaY9uKNDq2MN/mEKKrEJwfQZCAzdeSo6RziVoOXoPsp9/bxzjAhFc5
         d3cKORN3bBbt4z0+oISard4X2+yOlSxaXvGuyfy+aMPa8rWRO6ZCxijBOc/OmKAZBQP9
         hB4g==
X-Forwarded-Encrypted: i=1; AJvYcCUJIzmK8qc53drXl+m28MzrWs0dI5W5yAL3tMngQMgbGFEyq4GZlPk718nlDKiEUTpJfaQ=@vger.kernel.org, AJvYcCUuElqwzBMSKWxW4nPCtyncInuRbrj+udnTk7ZmI8QvKFPGJPpKAwXC0SAkYUi8jrgg0DJlQPyzHz0szc8i@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwi6Ulr/2I0FlfxD2rqzO96iRcOhzRefVpLfXaCVtvdztEwwjv
	eRPdY2jEl4H7NAM5ENhO61ujo1JMsAjqhTqLpKSJ7pei3+m737Pf
X-Gm-Gg: ASbGncvqioDV7G4/rus7x1dPYRFM771/8SYgkNnAHf+laVIuZhaSz/o+3C75PExrygC
	BVbZcu4IDWXG2F2mR+eh1bK+LU7rYBRJ/p9h+Xq14rU+T6qMcExftplqm9LYDU75NX8WKyfWP6S
	CWlKMnx5Ava1c/iJYgCmx/mebdFiU+ZrB9jBnfJqBRTWx2rTHxBebpMSbZLjtzmaalJddh1kECI
	R5VvfrwbsyPer2aUyKcmyt48qjwRMyfOPUUa7+IM8Cv0jgyj7zj7iT/QajbDeCCLv8oaJmB67yW
	Cr7sFCa8r0nHzOnwnK+GAgg=
X-Google-Smtp-Source: AGHT+IGqxNFgJLgLNUkI25FRohVwCP0LMbXsdRKL304Scc05fSsjdWcesgSNUZ/hjUS5ftiLlA8Qjg==
X-Received: by 2002:a17:906:3ca2:b0:aa5:3c41:6e59 with SMTP id a640c23a62f3a-aa5f7ecd6abmr749576966b.45.1733394782750;
        Thu, 05 Dec 2024 02:33:02 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e179asm71783466b.179.2024.12.05.02.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:33:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Dec 2024 11:33:00 +0100
To: Laura Nao <laura.nao@collabora.com>
Cc: ubizjak@gmail.com, alan.maguire@oracle.com, bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev, kernel@collabora.com,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
Message-ID: <Z1GBXHM1M4-Ws9Br@krava>
References: <20241115171712.427535-1-laura.nao@collabora.com>
 <20241204155305.444280-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204155305.444280-1-laura.nao@collabora.com>

On Wed, Dec 04, 2024 at 04:53:05PM +0100, Laura Nao wrote:
> On 11/15/24 18:17, Laura Nao wrote:
> > I managed to reproduce the issue locally and I've uploaded the vmlinux[1]
> > (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of the
> > modules[3] and its btf data[4] extracted with:
> > 
> > bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_led_backlight.ko.raw
> > 
> > Looking again at the logs[5], I've noticed the following is reported:
> > 
> > [    0.415885] BPF: 	 type_id=115803 offset=177920 size=1152
> > [    0.416029] BPF:
> > [    0.416083] BPF: Invalid offset
> > [    0.416165] BPF:
> > 
> > There are two different definitions of rcu_data in '.data..percpu', one
> > is a struct and the other is an integer:
> > 
> > type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
> > type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
> > 
> > [115801] VAR 'rcu_data' type_id=115572, linkage=static
> > [115803] VAR 'rcu_data' type_id=1, linkage=static
> > 
> > [115572] STRUCT 'rcu_data' size=1152 vlen=69
> > [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> > 
> > I assume that's not expected, correct?
> > 
> > I'll dig a bit deeper and report back if I can find anything else.
> 
> I ran a bisection, and it appears the culprit commit is:
> https://lore.kernel.org/all/20241021080856.48746-2-ubizjak@gmail.com/

which tree are you using, I can't see this in linu-next ?

thanks,
jirka

> 
> Hi Uros, do you have any suggestions or insights on resolving this issue?
> 
> This problem is now impacting mainline as well. The full context can be 
> found at the beginning of this thread[1].
> 
> Thanks,
> 
> Laura
> 
> [1] https://lore.kernel.org/all/20241106160820.259829-1-laura.nao@collabora.com/
> 
> #regzbot introduced: 001217defd
> 
> 

