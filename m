Return-Path: <bpf+bounces-57303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21A6AA7DD2
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 03:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1430D4C3856
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 01:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878E18AE2;
	Sat,  3 May 2025 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IF4ekISf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C9C2F2
	for <bpf@vger.kernel.org>; Sat,  3 May 2025 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234206; cv=none; b=Q6ebXc9FlzJWEOPecVt2PbTiWBUoBCU20yB1wuIRJIlLjA1eGJcSk2ZKiiOp4q8l5B7HX1fIU3ipiCComIwnQiWK0weMkoNA9HFT6EpZ+tFID/EESC2TUKgsAZM8o1CWfTQsRPlP4nsEd9st6lNHh8DkD29X9mekkP5S1vgjUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234206; c=relaxed/simple;
	bh=i7NFJCCFDpuotila2HQ4ddhSaYNHA5Uqt850LvhSjjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsxmc8phkbzG+kqXkDd2BK0ERrRXzo2KrWHpAd7cLKAnE1xI7t8n6RjpKv2/YEiOjizLfEhTq6XW6uN7v06V8p+Rl7zUZnO1wwD5K0mPIXLhIgr6gdcmUn0WZ/mqcEG7w3ABcQu0eAox5GCVwGrFXpmFPcA/KpVWt0+zTOEPUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IF4ekISf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2264c9d0295so74655ad.0
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 18:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746234204; x=1746839004; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+sxoQJro3lXNQqEyg+Rdvsoi8HWU2XRbsF61iZfZEgI=;
        b=IF4ekISfVaB9/5r6B5JFDxD40zza4eNypuepYCfavnXhE9zzg7ifegppSrltQWNaS+
         L4c/uLmJG0c/U4D8IOCy7CPbLTErqGlP9Y2nZ5Xw/TwrpawjXEtseiKpnkYZhJbF0GRi
         esHESqBl1IPCmrE6FlvWc0hWUdKJQjTxyYYD3JVnUM5BcEOdRVFnqHAsrRbtqnJpCp8x
         eua0EsUyvsmZ7umePE0yyHAGy/vySj1Y5F8QkHwYmCUpzhsXXUchevEswdXS8B4Ztzyf
         09VcLxS8IoDUh6iS3nztSgCByNlD9TKKhUu+pvAbZfk3zGII8+il1V/ISUm3ELHxbPbz
         +hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746234204; x=1746839004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+sxoQJro3lXNQqEyg+Rdvsoi8HWU2XRbsF61iZfZEgI=;
        b=h8i5mmnQsrO+xfv+SkTlLJ9zx9wpJ6c2Daq6fkvnk0pMCdm4mVLJhJj9ayrGfNVU4E
         4OXh2JzQMvnzuZ3GFK1mGcRtoKeOudt8QrHxGEt8Zf2DjCGG6UcdDHdSbIDoiqlTwA/C
         jgsArxDGAihZLx3wRxb7pgwb2ZegRTaGzyxLpImOB2vj8JR2kkITF4c9P/THXI32dsd/
         QoFfaz2xBH1sPFGcgnnRdg8ZqOsZHkCXuk2Iy/kbzT5YxgepxKPFbMuIV8xEpAcXH2XL
         JU2ouluN4E1XDQlhSWAZEk/0mWX5n51bXhfMxMeWCy9vJDlR29YCvel51pp6YnQw8ACw
         olmQ==
X-Gm-Message-State: AOJu0YzwzLRGBKBJ/VBaePYg3Arczyht18Upsp2iIVhLtRq0FlIYEV8U
	AY/j8XFL3hiLnVtkn5PV5gvI9i/eA2KcbvAAaf0w1oVAl1BcYSqUaT1mYhG+dX1y1XHO5ZB0RWB
	rTw==
X-Gm-Gg: ASbGncudEC+zU9/Mf4aUMDyugwvoQqShCrBXZQKidbYZAzc4j9Vxfj6GRCGBuqVfSv3
	bzAffnLUkKIaaMTrvseFuPZxWLieXqihfpWR/IAREE+FYuiMmk0LDpar8uDVU37SP4vP4ze03ag
	JJddCnxZsT0qoMAz+yaCKfFkWLktA3YGJf+qBZylS2FHpeZ0KgA9QoywgwTcCS6UTYS+hdF6wRc
	/YLJOXNpIEjJJ/3TnpPMSJxxtV35c+jBZx23JS3Ra8F1ePbM7TGIqSFEqNU2zVaGkcn+rcoAhwL
	7xxzKh1Bd9Ad1tMVC7TWFiiEO4Vxq6ayMEUSAOFwG821s0bJ5/SRUctHiAZT7Oskm+Nm5FK9X+S
	NXRsDDA==
X-Google-Smtp-Source: AGHT+IEtUkf0uocVKNrUNevFVjkIDwrkvuhXutNiDyyT5o9u+4cz2DnehOSMmC3g0359s6dmSn7BIg==
X-Received: by 2002:a17:903:11d2:b0:215:8232:5596 with SMTP id d9443c01a7336-22e18a582edmr1199265ad.16.1746234203784;
        Fri, 02 May 2025 18:03:23 -0700 (PDT)
Received: from google.com (202.108.125.34.bc.googleusercontent.com. [34.125.108.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e152293casm14076835ad.205.2025.05.02.18.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 18:03:23 -0700 (PDT)
Date: Sat, 3 May 2025 01:03:17 +0000
From: Peilin Ye <yepeilin@google.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Andrea Parri <parri.andrea@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>
Subject: Re: [PATCH bpf-next 0/8] bpf, riscv64: Support load-acquire and
 store-release instructions
Message-ID: <aBVrVfgoKTnWVgk4@google.com>
References: <cover.1745970908.git.yepeilin@google.com>
 <87ldrfm31e.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldrfm31e.fsf@all.your.base.are.belong.to.us>

Hi Björn,

On Fri, May 02, 2025 at 05:43:25PM +0200, Björn Töpel wrote:
> Peilin Ye <yepeilin@google.com> writes:
> > Patchset [1] introduced BPF load-acquire (BPF_LOAD_ACQ) and
> > store-release (BPF_STORE_REL) instructions, and added x86-64 and arm64
> > JIT compiler support.  As a follow-up, this patchset supports
> > load-acquire and store-release instructions for the riscv64 JIT
> > compiler, and introduces some related selftests/ changes.
> 
> Thanks a bunch for working on this!
> 
> For the series:
> Acked-by: Björn Töpel <bjorn@kernel.org>
> Tested-by: Björn Töpel <bjorn@rivosinc.com> # QEMU/RVA23

Thanks for testing this!

Peilin Ye


