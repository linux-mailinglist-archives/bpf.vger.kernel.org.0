Return-Path: <bpf+bounces-30843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5508D3948
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420281F272D8
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F91591F8;
	Wed, 29 May 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lw7DCMNr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD41591EE
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993158; cv=none; b=Fpbki0ysw7Zl+44JwaSZ4JWwYMLLSQ3QGmgQE6yvKaDtVlK9PS8pjSMeuZk1T/s+TCSMRD9DLDXvPjHTjCFBKD9SZcDueycxMkVJMS/kmSIBCxH6jhreYlc513Od/wnK1Xraw8PcgRaVGr8Suj/zeqMofj6UH14JrIRovfP9kcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993158; c=relaxed/simple;
	bh=TTnJdiN0dwICsVBBJaHkeqayhfOm8yBlF5WnhM/KfCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3Zz+ivjMlDmOp2+bvO+4JzGjM9OzQ2lnL7gff478OaiaVcQGBYtNeWuKz/SBMbb+ETjI07cUpREY4qgjrvryts01wtJACHqMoKaqRtEebGvBVCdKPTdZlcu+AFhWzc9kvWjyZfDW5RD9jta7PNqzDxA0C1G+Tl31+YdE6+mDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lw7DCMNr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6266ffdba8so217757966b.1
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716993155; x=1717597955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8pfVjY3N0YvfyGWCKtQaCGQHSMzwUk6OlNcqAVvSgk=;
        b=lw7DCMNrQbnyXjW2hU6FsmrTQR6HJC76eLqzcRlSaourB3VMVrLoq3TGUhqx2NTagI
         uyvwU1PMP8gndYGk/QBpU0pcey9uov0xwNa6zGjfeHHVmF3l22QXV852bvroUTC8OwRD
         WOUTbP/e4Y7Nkwk5e+azmOnKTGma2h6pb+oV7kUZKXXWTCCPId6m2vCOfCGRSj6wHYeW
         gRmIoeJ4LOmqKP+/V80gBb62nOI33Md9PPK1GybM0tPHFF9RuSOSGVeChnQnRnTt/qpO
         0vXEcZB2r8yQmQHCC277s8/PmMMRgFzKpXoBBwhj+/QVWJJWs+oSNNaxYSiwwrwYG83y
         97Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993155; x=1717597955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8pfVjY3N0YvfyGWCKtQaCGQHSMzwUk6OlNcqAVvSgk=;
        b=eAqnOTzNThmBjXXPpgIQUDvJoUKvvS9KpiYah6YQNkDExwGk3rWpxH7dyYcga5+lC3
         tNiCam3wU4CGNQPcQFB5pfPcD+u/iQbL93M6D8I7V15KoWl4bUvMArg1JevJPgO+9iLB
         LJGGU/UZRXJVxVjXDWy0NVp/ZTlW8y0GPJ1akN890kE5bNNEPGWLN8+j/n7S0gBheoWX
         MT7egXh3vUhtnc6qJJyo5ZSPhzolY+Xp3XxKr2H4rBlXg1iqjPz708YT+LDV/vh7c9/J
         NdXJ3bNC4SCehIYrg37n8O52o4fiVdyC32QitCPKwyKuq0FuNFKFbA2gT4Ft5AkH9AKv
         TFuw==
X-Forwarded-Encrypted: i=1; AJvYcCUe0z6IkFXK5k5NgXDp1ow/wSWXB3VfBRG5wWwWegXuGS4yV8kffpdqnWB+ZWiSN9qwNv+bmB+UpCVdQusynEBIeMg2
X-Gm-Message-State: AOJu0Yw6JRJUVKqWbZBbzMncsqWZZA/nTYaxEItX5EUDfAMWq4Iev5y5
	LOIeob9kiWFKTVEIjD/FojIv36HybwO6xywT2g26pRVBVlFFnHJUPVk3rlcte+Q=
X-Google-Smtp-Source: AGHT+IEUwk0uKpLzXpRtjkdBL2ciZJRWEWE/oGee9dpShKyJmD7Xq6zpbrYB2/9lN0ss8bGEsHD1fA==
X-Received: by 2002:a17:906:6bd4:b0:a63:3586:a4ca with SMTP id a640c23a62f3a-a633586a5b0mr412085066b.11.1716993154764;
        Wed, 29 May 2024 07:32:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93a812sm726509066b.50.2024.05.29.07.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:32:34 -0700 (PDT)
Date: Wed, 29 May 2024 17:32:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: oe-kbuild@lists.linux.dev, bpf <bpf@vger.kernel.org>,
	kbuild test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eddy Z <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
Message-ID: <6ae809b7-a25e-493b-9488-0bf6e7afbfd0@moroto.mountain>
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
 <91453e3f-66b0-4927-a756-bd18f9e6bf05@moroto.mountain>
 <CAADnVQLWbPd2skY1Lzs8oJ=9Ag9e2qD9Khhb4ycQRimZqdeBfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLWbPd2skY1Lzs8oJ=9Ag9e2qD9Khhb4ycQRimZqdeBfA@mail.gmail.com>

On Mon, May 27, 2024 at 03:44:44PM -0700, Alexei Starovoitov wrote:
> > 484611357c19f9 Josef Bacik        2016-09-28  15313     if (BPF_SRC(insn->code) == BPF_X) {
> > 5f99f312bd3bed Andrii Nakryiko    2023-11-11  15314             err = reg_set_min_max(env,
> > 689049426b9d3b Alexei Starovoitov 2024-05-24 @15315                                   other_dst_reg, other_src_reg,
> >                                                                                       ^^^^^^^^^^^^^
> >
> > 4621202adc5bc0 Andrii Nakryiko    2023-11-01  15316                                   dst_reg, src_reg, opcode, is_jmp32);
> > 4621202adc5bc0 Andrii Nakryiko    2023-11-01  15317     } else /* BPF_SRC(insn->code) == BPF_K */ {
> > 5f99f312bd3bed Andrii Nakryiko    2023-11-11  15318             err = reg_set_min_max(env,
> > 689049426b9d3b Alexei Starovoitov 2024-05-24  15319                                   other_dst_reg,
> >                                                                                       ^^^^^^^^^^^^^
> > Passed to reg_set_min_max() without being initialized.
> 
> No. It's initialized when passed. It's a false positive.
> Try to make smatch smarter?

Ah yes.  I didn't read it carefully enough.

The kbuild bot doesn't use cross function analysis.  So it didn't know
that pred can only be -1, 0, or 1.  If you have cross function analysis
this should work.  Unfortunately cross function analysis is too slow to
scale enough for the zero day bot.

regards,
dan carpenter



