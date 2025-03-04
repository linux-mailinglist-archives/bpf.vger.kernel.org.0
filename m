Return-Path: <bpf+bounces-53143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE65A4D05A
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6D41764ED
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689751D7E4C;
	Tue,  4 Mar 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qArVyWMM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0771C84C7
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048796; cv=none; b=A9WSgJianESZX8hKBEI0YdfMN5a1/HD2MQdF6tzdWFDQsYmjbV8yqgGGVzfzM+iNyWUxNr/bbFalsYFt9DjfZQS/R7cS24zxVOQpJPSb9W+lojbKSgCyxwTNwXX6BvuT+wVlm4cXOvtdHUY07fO6MpUBA96JcLk8Q3cjmNU7jOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048796; c=relaxed/simple;
	bh=rkWPmAk7WVKWGqIACfOChkzLOcxrNPRKbBUUx4bSPOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddeNn5U5p6LLSipc9r6xTs0fMWoE1KiWewGWgluPwiHlc1WfRbV1/JAMcz9dRQBdrMqJ8OXpwZ842qKgdAqG2c4a49ves/x/lFu52BwsP7w/6sT0oJXvlOfCWG7zhy7KqseXBSarPbkmEMmRm2lyF2Qr/MPko/kzWgpfz9Ohl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qArVyWMM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22342c56242so72215ad.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 16:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741048795; x=1741653595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZZ6RWDnljKub/rNqmhOhGtUl9a9akOzeS+eKL/NSi8=;
        b=qArVyWMMKL8YstysnALLXFKe/gPNIrW4TqIFc7h10y1oBHcQpbcn02BCNoIYmgIhTV
         +zSu89EH96kFAL0/hN423fcHpmQ7Yhu16BMDsBq5lOA3iuFwIOZ7c7pgM0JXAiwzIPeh
         NiGrXZ4oxf53BwmotCbM9EBOEorWKnRGCfUtegitMV9pg5i4EYCvxi/EfcvEHo+rxT0d
         vqPtDKSaBFdIFq2Pjv/oOjjWf/rpAQLcfFzWNfVfBbqzqe0k1gvS5vDu6ngSkAkk8+Ys
         pVr9Ilt1PU4zr+b4kW2MxaKjNPrd+uSNdJBRpL+CrRMaqFpTKY8JUIId9Hels6ei85fq
         kTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048795; x=1741653595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZZ6RWDnljKub/rNqmhOhGtUl9a9akOzeS+eKL/NSi8=;
        b=VjJYd9Yeap1KhaePDxW5Rpe0kQcGMpYhPiqj/EHdLGep2a7z81JghPNM2J0jOtZ4fr
         tQhlfKj/hi/G/s8BZmyWFUViYZhPHi3n1Tg8NYGUrK8FNh8YW+ZBx5shhcGTzGY5ciUd
         YwZa9xBfqLt8JNqk8O4pSSlmDm/VhH6dZWCYJP1M8DpnXHutkAwmaHkdbU55zTZgH1Yc
         Mx2pPfgY9q+vhWCtV0lbmrAT+Me75BqvTj9ssj4bDKB6u5N4hw3MNnf3lN6EQMoIMyUU
         9ElWP8qsQRrKkNIXYg576dPKaAlwfhteTfOVTbwjyzwe9qsHJvFoPWl8SOTsU54E8+xa
         kSsA==
X-Gm-Message-State: AOJu0YxZjgzpoIgvaitHOMsNIsxmtwANMF03XoZ4FaTbHeFAsuqltrxP
	QnyKfPEf/Lo4bm5n3lmNnCSrS+y6wu4mHjivBvrruC0AHsw7DzZNUlbcaPaFZA1hiT0oQWTsozb
	jVw==
X-Gm-Gg: ASbGncsCGQ94LZewK8FKAuDR+b26ikv+AZpvlGfRC02XHy2cD8axyZIx1z2cXvLxfkn
	rp9GBJ1xXLkOGlphwhq/eVlj76HTnSdvl513iBF7aAsUo+4hNd541Vyi9t3YxtQsoVfkrlZzRH7
	J4pZ7TpvcERUcdYOWTURHSf0tN6y0wGJYsjI7VCYCDPSrYW0fukJIOhlZGiAhQbK+OTa05HpWyE
	gLeSrBCSDeYmqDR9FmiJmeIjwjghsx6aKHAvKPd0B/6YW/mZTpu/uyLjydCilGOmZILOU7VoxCu
	NEdZ5ypEC9HkYK4KeN/7AJFpLSK6+mldkeWqJxcNz7Bzgzb9F8kY+d5rW15C5EC7HkcBwTtIQlU
	HlN6Yb7g=
X-Google-Smtp-Source: AGHT+IEFZMvKPvqJtn6porx/jOyYtLyQRQGPPfM3zCCktwuBu79Q8Ew7WkeXkukdVZEY0NkgznAoKg==
X-Received: by 2002:a17:902:ea05:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-223d9e0df5cmr1199935ad.16.1741048794489;
        Mon, 03 Mar 2025 16:39:54 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee90c7e519sm6971619a12.61.2025.03.03.16.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:39:53 -0800 (PST)
Date: Tue, 4 Mar 2025 00:39:48 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 1/6] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z8ZL1L69z8XWm8vl@google.com>
References: <cover.1741046028.git.yepeilin@google.com>
 <b0042990da762f5f6082cb6028c0af6b2b228c54.1741046028.git.yepeilin@google.com>
 <CAADnVQKX+PoSUqPBB2+eZrR7wdq-8EVaMxy_Wur7g8wyy3Dcmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKX+PoSUqPBB2+eZrR7wdq-8EVaMxy_Wur7g8wyy3Dcmg@mail.gmail.com>

Hi Alexei,

On Mon, Mar 03, 2025 at 04:24:12PM -0800, Alexei Starovoitov wrote:
> >         switch (insn->imm) {
> > @@ -7780,6 +7813,24 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >         case BPF_XCHG:
> >         case BPF_CMPXCHG:
> >                 return check_atomic_rmw(env, insn);
> > +       case BPF_LOAD_ACQ:
> > +#ifndef CONFIG_64BIT
> > +               if (BPF_SIZE(insn->code) == BPF_DW) {
> > +                       verbose(env,
> > +                               "64-bit load-acquires are only supported on 64-bit arches\n");
> > +                       return -EOPNOTSUPP;
> > +               }
> > +#endif
> 
> Your earlier proposal of:
> if (BPF_SIZE(insn->code) == BPF_DW && BITS_PER_LONG != 64) {
> 
> was cleaner.
> Why did you pick ifndef ?

Likely overthinking, but I wanted to avoid this check at all for 64-bit
arches, so it's just a little bit faster.  Should I change it back to
checking BITS_PER_LONG ?

Thanks,
Peilin Ye


