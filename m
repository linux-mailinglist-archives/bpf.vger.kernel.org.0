Return-Path: <bpf+bounces-65658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DFB268FC
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 568887A2368
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E086B19CCFC;
	Thu, 14 Aug 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DluXtWa4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF41514DC;
	Thu, 14 Aug 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181115; cv=none; b=oYb7PrCaECx7T53Q6CxXVRs4Dw0PxqNcyevcpgmrBbgSvYHx6dz/0i/fBUN+9J8zvLSfMpzYIJ4D2FRBjyXhJirY7ANKH+H2l2/9V2tausypZeTvvAOUeaxZSvl4miZQQ8fTb4m+auFRoGkvTitkmrULwNWmPM4naljffLvwTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181115; c=relaxed/simple;
	bh=cDxMRRN3nGG/IneZ80STg/q0CEsWcsHRsiUKXzouC7k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvxYcetnUohU+HUJO8Xmp2bSeXPiL/CiWQgqzRSil5wOXj87qkRSC10LhKziVeay/frJJY2Nk1J7vGqQjbbx5+hVygK1EHr+ZuuBsJAym4oBuemipXdUTyTOgRUIoBUqUUpFGlTk37F2rhKFNPtFP4hVgDhFz2pIBMUq+a48B4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DluXtWa4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso6474785e9.1;
        Thu, 14 Aug 2025 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755181112; x=1755785912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=munZb2Idj5EmrK5Qup4Vq55yHF7nYHNJeVVYe4G2yfQ=;
        b=DluXtWa4r1LDya4rTX+9UjDaYxYtf8ssAx4WP4wzoBL31z5kwZVNgW0ppyZXzjGed+
         Rs2U//xMDUZf2EnEoJATBKeHuTS870s7kAsZiGXSQuF1okxaNK4kt1YURd9wD5H5R/05
         FbHwIE4D+72xAdenj934DqEmduGlF/cbDg7g2gJi/+V/JZSwtXDe4JsLBpZp0g3fVjyV
         YwXY6a3jsEaPwz+Kh5eNytpxSpx7xPpEPB4ku5seAIkjq0wa479aWEv7diXkSHRDZlf1
         XrywbuDE6tdsZqEr8CFs5qHdBKEI+tZgzMG/JjWpFa5V0WtIq1jYXvJwQX22yKIXDbxh
         FJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181112; x=1755785912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=munZb2Idj5EmrK5Qup4Vq55yHF7nYHNJeVVYe4G2yfQ=;
        b=iNQJox2rxGZHp9YTcB1a7/Fzdu8Vbfn72ngm0VgBYCzYcTV6v4mnsTUoIuIoOYDhiz
         CsgA9cnZhVukhd5abc/z21XOcyF+f0kChmVgBRP0DutZvf4KL4grsAhN53bK3TqvTw9H
         59ZduSr7F6azvmWj8Y5wovfbQ0qCVyFECgFP/TJQZOAY7pHRAgPFPhc09biXVxMMxsnx
         +Cg8H5W9XN5BvKFNybiEEloX3Ce09iDXqnkDikBjUxFNLToUhol51ML6FCuBMfJc8aoC
         mJh3dK0174zwKcZXOV/1iUysNacDSnksvOaGQm+KZ91TmNNphsY0NFZetLF0JyOCXjBJ
         powg==
X-Forwarded-Encrypted: i=1; AJvYcCWO7koucCmGObgmG/8bx4oH+Ty17YBP7AjCS8W8QSLh8hNYekWdC2Dn8sitoxJftK9Y7mA=@vger.kernel.org, AJvYcCWbxod1jbH264qhYITOd4JdJEK6CshgEe3ZZeYrEX2w57NmFlDocXHQNmR31s+nJp3xSIIXQEw3faIpVq2oEKQa5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wiL/cEARy626Q3FgT21TT6dnOR6RPkMloKW80x5ATHgV/6DT
	VmhkxVWxPcty65GA8zedcaC2lu1F0pgZhNKwQXpX/Nmbr75Tvb1UbBw0u8jB5Q==
X-Gm-Gg: ASbGncsr6RQX3tJjQaVS+mASgA9gUPtthcuIyKLpEnGyueVGfgLE1a7m3FY2WJ3D8Rs
	6hmzEPoJZ0jmf3CmkgF3ynoCDErnD5wAa4lXH0munkMTb+d+mrcF897GrtgeVSRTR5BtVNfZ+O9
	0EVhUhqFWHj0wJ7MxCM6i/aps6YVTEcwJ4rddTSumzW8mqrb44elR+fgC1E/hPFq329OdQtAv3Z
	Gegx/NR+HAoGbq483OVqRLxDfE9zSmbHTflC6oCovHR1ZXFTh2qactesEzvYOoWYnOSKpHwmcw8
	9ITELE7uWtsfh0HtCq22WP1L14cLoiOB7zYMSY//vsiH12atbwYqAK4PLMoE7R5FrvJv3L+z
X-Google-Smtp-Source: AGHT+IEJSCepsCsWgS1C0XRMaPGsfColBKegZEB98PwfyIaYK8cTKr4bipT2OmCoLIqfOVq5lolW7w==
X-Received: by 2002:a05:600c:8707:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-45a1b7f97e4mr31355965e9.0.1755181111896;
        Thu, 14 Aug 2025 07:18:31 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6e66fesm23849155e9.17.2025.08.14.07.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:18:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Aug 2025 16:18:29 +0200
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf] bpf: Check the helper function is valid in
 get_helper_proto
Message-ID: <aJ3wNQNodQhnt8GG@krava>
References: <20250813133832.755428-1-jolsa@kernel.org>
 <aJ3qSru3r1is9lxy@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ3qSru3r1is9lxy@mail.gmail.com>

On Thu, Aug 14, 2025 at 03:53:14PM +0200, Paul Chaignon wrote:
> On Wed, Aug 13, 2025 at 03:38:32PM +0200, Jiri Olsa wrote:
> > From: Jiri Olsa <olsajiri@gmail.com>
> > 
> > syzbot reported an verifier bug [1] where the helper func pointer
> > could be NULL due to disabled config option.
> > 
> > As Alexei suggested we could check on that in get_helper_proto
> > directly. Excluding tail_call helper from the check, because it
> > is NULL by design and valid in all configs.
> > 
> > [1] https://lore.kernel.org/bpf/68904050.050a0220.7f033.0001.GAE@google.com/
> > Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
> 
> The same bug was reported before by the kernel test robot at
> https://lore.kernel.org/oe-lkp/202507160818.68358831-lkp@intel.com, so
> I guess we'll need:
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202507160818.68358831-lkp@intel.com
> 
> With that,
> 
> Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

thanks, will fix

jirka

