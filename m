Return-Path: <bpf+bounces-46142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565739E51E8
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F8218817A5
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D772E212B39;
	Thu,  5 Dec 2024 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPfJlDCw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55953212B2F;
	Thu,  5 Dec 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392889; cv=none; b=ctXpWybNkDSNRCgTrvTTwJhYCbleuiTf7kkyGLce9RRa0EqkaC/ogvTQ3J1te064mC9zTd/ngcQZXm1WwEIjCVbwwXKL/Bg41CwIK/mzEqIt4kGY+YzKgGrERhVAvlrfOttXDMiUkXTw57ANqg+sgIWNovHrvg8aACC/CQatWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392889; c=relaxed/simple;
	bh=v21otZvzUkNay7ZFsI1Y15KNxaF2kIaTH+hEyosvgLo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIAf3K9ADb6Bnkk7wSd7AL7BXbTgySyutGegag7cb/U/uiPlW9Ro7i7uxYCHPWTxox5LhyX/6llL0XHNxwLvV8qjXxmXTMGYNJEqE9xvV/nziv2rkr9h9+ZUNZ6JvjFFQk/I+yJ2qwhEwcTk9v+aWhCIx4wH5DZvSMOlsPbZqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPfJlDCw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa5500f7a75so100929266b.0;
        Thu, 05 Dec 2024 02:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733392885; x=1733997685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b6DpBiLftEN8D+gl9wRNAAKrPJWYeb4y6zIoZbJxWJY=;
        b=iPfJlDCw/cHatRfKL+VKcDgwyaMz6CcIMxSP/1sL8sd3RSO1qN7zhEMsRc7qmq2WHv
         Gbo4w26eRUyaMxUyEsxPTKDjCBoz97WQLYLG8WRWdYhckNa6MfDkon4VHyvo7fL6wsyF
         Cf1WPXHaKaZANKrhclNm5Bt+Cpb5JEqN7iZB68Mk/my9C591pUIdpKlk3k5MjC0NyKkD
         GqBimONyotDlAFLfrU7Un5XcOtG9s8dAj6H2CgpgdSlotR7vTf6N6ykUnYU/pnZOn/qU
         3HFzIGZ4iklDU3PJb9/ybhV/w9M1Lv2sepV6ROfmd9TBKuN/oI5a+MrxXu+Oks4ZoSkf
         75ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392885; x=1733997685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6DpBiLftEN8D+gl9wRNAAKrPJWYeb4y6zIoZbJxWJY=;
        b=s1fST8oFf8jxv578S+P1dvjIwKvmf7iktW84Qz0/TDg0A4UPs2JeMuGjqNERQ+V680
         jBQ8T1YS/O+StoTJ8NeKkKvkxsKH47P2uaNPQh+vvj3FGPyg0j4OtKv+rZoNxjsF+Thg
         fhBuLsetQJjMtoyZ0SzhBzagS5uSrPWfJZ4b/l5mqpz/AxhAJkjcZ9fndszZSL9lmo7q
         FPps8HVCA1RYDjzG0+QFoFRUG+lDHvyDHoehfS0IKPoDluO7IwMzR+tiw2coYycS6JYE
         MbniiZDXrmISgTHbllMbaK64SVHsxuGVqP2GwWuRi5wAHdYt1PxUUAVcrysNAisaLUO+
         oLPw==
X-Forwarded-Encrypted: i=1; AJvYcCWXA4Mi6StOqr4UWP+ZyJDPw0SOinfAMdL9t9CGrcNSxqEhVNS46zLeT3eKVnzOhbhwy5M=@vger.kernel.org, AJvYcCWrPHqqyUsGelLWXHX8Y2nz1h1vxe/csM+vKO31vSmEk1GGxQIG+Pw20VBa+9jv96UDJgxnz9/lshxkWyRV@vger.kernel.org
X-Gm-Message-State: AOJu0YwXncTbvrSnEdNsZkhOQhJs2grZKIWPP5wV4K0EPpncIUNcfaZx
	t8ya66EsoyDhfzInofSFD8joM88+WL2fKNUT6swTlsJE6xtHexfH
X-Gm-Gg: ASbGncs9VdAH4VPDM7vh8++JQX6/f3OK21QD906HoURIKnbhMQpk5EghnVVX5DtqdzW
	oG/lRuCCINh979SY1LTHseFcKfV0Xpm5NENcDC7AQlJ1HDI4m/6KKf/mAgvPhpTboaVhlVklqsN
	9KFQwcUhWOjil7zA74DpaEFDWkz8c+dE1aI24mbLnYFOCC4ade+zpBuiEBopxm9zJnVHqhBIKPE
	j4Ydxpa11kanCpH7CFicnMTfPPi7dRGsOHssSZ1GI8+Cx3Jmfzn0OiSP8X/xSNfJNIBvgMUZyIs
	F/GpjcZUVDJiOaqE5BdgMQg=
X-Google-Smtp-Source: AGHT+IG2gW4KauIAqc9H7+S/c1RnImhk15kwQEK5S81eH+MUP7TMqxZDW5jHMC2Ra3qDuj0UirKvug==
X-Received: by 2002:a17:906:2929:b0:aa5:427e:6af6 with SMTP id a640c23a62f3a-aa5f7cac468mr695125366b.3.1733392884726;
        Thu, 05 Dec 2024 02:01:24 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dbacsm68854666b.16.2024.12.05.02.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:01:24 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Dec 2024 11:01:22 +0100
To: Laura Nao <laura.nao@collabora.com>
Cc: alan.maguire@oracle.com, bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev, kernel@collabora.com,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
Message-ID: <Z1F58qzclMgeEMcC@krava>
References: <90b3b613-8665-425b-8132-5b9ac86ab616@oracle.com>
 <20241113093703.9936-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113093703.9936-1-laura.nao@collabora.com>

On Wed, Nov 13, 2024 at 10:37:03AM +0100, Laura Nao wrote:
> Hi Alan,
> 
> On 11/7/24 16:05, Alan Maguire wrote:
> > Thanks for the report! Judging from the config, you're seeing this with
> > pahole v1.24. I have seen issues like this in the past where during a
> > kernel build, module BTF has been built against vmlinux BTF, and then
> > something later re-triggers vmlinux BTF generation. If that re-triggered
> > vmlinux BTF does not use the same type ids for types, this can result in
> > mismatch errors as above since modules are referring to out-of-date type
> > ids in vmlinux. That's just a preliminary guess though, we'll
> > need more info to help get to the bottom of this.
> > 
> > A few suggestions to help debug this:
> > 
> > - if you have build logs, check BTF generation of vmlinux. Did it in
> > fact happen twice perhaps? Even better if, if kernel CI saves logs, feel
> > free to send a pointer and I'll take a look.
> 
> Thanks for the pointers!
> 
> From what I can tell in the logs, the BTF generation of vmlinux only 
> occurred once. The automated build process in KernelCI generally involves 
> building the kernel first, followed by the modules and other artifacts 
> (such as the kselftest archive). 
> The full build log can be downloaded by selecting 'build_log' from 
> the dropdown menu at the top of this page:
> 
> https://kernelci-api.westus3.cloudapp.azure.com/viewer?node_id=6732f41d58937056c61734ab
> 
> I do see some warnings reported in the logs though:
> 
> WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
> WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj

hi,
this is fixed in bpf/master already:
  8618f5ffba4d bpf, lsm: Remove getlsmprop hooks BTF IDs

I can't reproduce this as well, will check the logs you posted

jirka

> 
> > - can you post the vmlinux (stripped of DWARF data if possible to limit
> > size) and one of the failing modules somewhere so we can analyze?
> > - Failing that,
> > bpftool btf dump file /path/2/vmlinux_from_build > vmlinux.raw
> > and upload of the vmlinux.raw and one of the failing module .kos would help.
> > 
> 
> Currently, KernelCI only retains the bzImage, not the vmlinux binary. The 
> bzImage can be downloaded from the same link mentioned above by selecting 
> 'kernel' from the dropdown menu (modules can also be downloaded the same
> way). I’ll try to replicate the build on my end and share the vmlinux 
> with DWARF data stripped for convenience.
> 
> Thanks,
> 
> Laura
> 
> 

