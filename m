Return-Path: <bpf+bounces-12729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48157D0237
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C13E2822AA
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA8374D4;
	Thu, 19 Oct 2023 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4GUUD6+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80D2FE0F
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:08:16 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8144112F;
	Thu, 19 Oct 2023 12:08:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso62328b3a.2;
        Thu, 19 Oct 2023 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697742495; x=1698347295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2xXWLhYvowWU8V3Iywrvabpuc1fUAwAUM/Ptz/LUUs=;
        b=m4GUUD6+NVismyF51jiEDvlQHjF6YoaW93ZrgzNNo92sCK9tuq7iv0wE2hfNtmsJRI
         7oY8k0L2wZ36wBXnA6QdlkStysTHNRx5nyXOMgBks6YlJc5yqhjzQBDj13thCjjs5+Ra
         N7iIOW2ioop33UnrJNQM5fspgevK4k5EdXmZGw+V4hruUiU0LHXgWMkZGg5vkCAYrt2F
         LEru+lQoHEPbiyva9UprNntSrOgLi/If3cjztKeDvC/geyRFHe/Ax7rMwDnH2DdA8y+O
         /8kvy/KJpAJ3nNxTKYBn1A5XkyEKDM8wZKkzHHZxl2d4zOR0q00FDDxvOG8w/uxl02tx
         jKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697742495; x=1698347295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2xXWLhYvowWU8V3Iywrvabpuc1fUAwAUM/Ptz/LUUs=;
        b=wREbAa6R83RgsJ0svIqB7p8hyfZmwjWaAXPQdlXsjYUp+2LWgbcdq22A/U0FgyBPDj
         QeunhfklqcnbqeGPxD/pTQ8IFLNeT95COtSxm9DyyacZ0VycWSWHCzXG+95oBCuJ8QSP
         4LOqNtlUeTaTquKwdTfq3215pidBC6xDmIsQLbyeNpMra7DgMQl23UIRxRSHDZXUSL62
         qym0joas1k6kARxEv2vlFpJK37NuV85R8J3mvZf0d5m68SBlun0wigTrVFJsyXcIXYPy
         fQ8vwTl4n1BH187npvgP14+n/a0U04UqP+uapXV6KelN1u+gWJRbBiXxoc4gWVc8tU86
         NdjA==
X-Gm-Message-State: AOJu0Yw8dKhmLGZP9e8BI2KSq3hHflRNpD3U9gja1Q5S7hDlb5YyMo+q
	SBb/VC31XlFUqL9FekkeO70=
X-Google-Smtp-Source: AGHT+IFSkm6n7uix0xQmcoUu4i6Z+poVfqXtPJ20frsWP5fg3iNWdkFkKZ67PviW9fMhXESCSd0NlQ==
X-Received: by 2002:a05:6a00:194c:b0:6b1:cc77:4d2 with SMTP id s12-20020a056a00194c00b006b1cc7704d2mr3211937pfk.15.1697742494734;
        Thu, 19 Oct 2023 12:08:14 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id u8-20020a654c08000000b0058901200bbbsm87138pgq.40.2023.10.19.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:08:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 19 Oct 2023 09:08:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the
 cgroup root_list RCU safe
Message-ID: <ZTF-nOb4HDvjTSca@slm.duckdns.org>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-2-laoar.shao@gmail.com>
 <ZS-m3t-_daPzEsJL@slm.duckdns.org>
 <CALOAHbAd2S--=72c2267Lrcj_czkitdG9j97pai2zGqdAskvQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAd2S--=72c2267Lrcj_czkitdG9j97pai2zGqdAskvQQ@mail.gmail.com>

On Thu, Oct 19, 2023 at 02:38:52PM +0800, Yafang Shao wrote:
> > > -     BUG_ON(!res_cgroup);
> > > +     WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));
> >
> > This doesn't work. lockdep_is_held() is always true if !PROVE_LOCKING.
> 
> will use mutex_is_locked() instead.

But then, someone else can hold the lock and trigger the condition
spuriously. The kernel doesn't track who's holding the lock unless lockdep
is enabled.

Thanks.

-- 
tejun

