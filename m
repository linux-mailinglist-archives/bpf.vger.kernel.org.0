Return-Path: <bpf+bounces-12855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112087D1528
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 19:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DBBB214CB
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24CE208A6;
	Fri, 20 Oct 2023 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdEy9t7N"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197821E530
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 17:51:09 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE7FFA;
	Fri, 20 Oct 2023 10:51:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d5fe999caso883401a91.1;
        Fri, 20 Oct 2023 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697824267; x=1698429067; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02puzIEeiYhiJJhgKY07tvx8NVCgLzZBlRnnWhDsfHc=;
        b=MdEy9t7Nfxog0ferh5cs0INWIvp5mPgP+d8wgevJJyLAqq8m6iRh0AEF0nGW/glnwW
         IR+jLxuoXgfDTMnY5vStNBrjz4Y5Ceclz/ToahQDo14cbgVVigrZm0yGJUcvVwLjP6yx
         KojJXgyHkJI+4ZGjidUMqKmsBvDhNZmmW9NE7ItKilMk5kd9tbnYEEguOu4gJVhhdM3u
         Jba+QvHOPLNQr3klHWaLWjejWNunxtblpA2o5gqD2EBWzxjjit7GKJWk2CHD1jVIH/ub
         IcuzrL18wZZgsTPd5M9ruN+Y8qfWuHxMnPRNHep3goThfg1P6nSMlgNpurXq2SBCbCm3
         qMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824267; x=1698429067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02puzIEeiYhiJJhgKY07tvx8NVCgLzZBlRnnWhDsfHc=;
        b=iFs362CbxuMA51OK164F1xDgCZhvW4PFXSykCYriGwajO0K3tporUvkNpAG4nDMeKx
         13YTXQpxN3yYsbI2fyxMINvnHhAouSgLnLN9EGy7N/YEyggQhRIzPSbKJiVbZN2Bgc0B
         VZ1l6tMX2MSxekEnVbcci7nXoSfE7qPYZAXVXcmwfz0wglRUbwxSGHiM2DY4kGTHUuvc
         IOr+NmHgCkE7SuqTqlqqpS+OJPax7Bz3UEb4wC2PHhcfSMOm4wzdl+PIiIDEcWgfmO50
         yy9JF3J97eSaRGkGtKwYYJQmbQalzaroE6X3lKlwle9LQvfBEWja6UvMvMBW4WFKvUKZ
         3eHQ==
X-Gm-Message-State: AOJu0YzmT4Sg8LbFCTILbXIZWVTf7/1+oAguvYnJ0mkGV6qBgsCirVLT
	9qGp+sfOWXyKXrC1RncbPUw2ySiiNPg=
X-Google-Smtp-Source: AGHT+IG6mo8ss51mg8ctTHseVofJa/iBmi1/IxfEKmbkZQJyAbR6M6xjUip0PrtoBmbDUmHeOcvArA==
X-Received: by 2002:a17:90a:19cb:b0:27d:5f1f:8eed with SMTP id 11-20020a17090a19cb00b0027d5f1f8eedmr2412326pjj.14.1697824266393;
        Fri, 20 Oct 2023 10:51:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:a906])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a01d500b0027732eb24bbsm3905843pjd.4.2023.10.20.10.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 10:51:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 20 Oct 2023 07:51:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Waiman Long <longman@redhat.com>, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
	mkoutny@suse.com, sinquersw@gmail.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the
 cgroup root_list RCU safe
Message-ID: <ZTK-CI9juS31kMSX@slm.duckdns.org>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
 <20231017124546.24608-2-laoar.shao@gmail.com>
 <ZS-m3t-_daPzEsJL@slm.duckdns.org>
 <CALOAHbAd2S--=72c2267Lrcj_czkitdG9j97pai2zGqdAskvQQ@mail.gmail.com>
 <ZTF-nOb4HDvjTSca@slm.duckdns.org>
 <09ff4166-bcc2-989b-97ce-a6574120eea7@redhat.com>
 <CALOAHbDO=gzkn=7e+6LMJNwKUPxexJfg=L1J+KZG9a9Zk9LZUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDO=gzkn=7e+6LMJNwKUPxexJfg=L1J+KZG9a9Zk9LZUg@mail.gmail.com>

On Fri, Oct 20, 2023 at 05:36:57PM +0800, Yafang Shao wrote:
> On Fri, Oct 20, 2023 at 3:43 AM Waiman Long <longman@redhat.com> wrote:
> >
> > On 10/19/23 15:08, Tejun Heo wrote:
> > > On Thu, Oct 19, 2023 at 02:38:52PM +0800, Yafang Shao wrote:
> > >>>> -     BUG_ON(!res_cgroup);
> > >>>> +     WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));
> > >>> This doesn't work. lockdep_is_held() is always true if !PROVE_LOCKING.
> > >> will use mutex_is_locked() instead.
> > > But then, someone else can hold the lock and trigger the condition
> > > spuriously. The kernel doesn't track who's holding the lock unless lockdep
> > > is enabled.
> >
> > It is actually possible to detect if the current process is the owner of
> > a mutex since there is a owner field in the mutex structure. However,
> > the owner field also contains additional information which need to be
> > masked off before comparing with "current". If such a functionality is
> > really needed, we will have to add a helper function mutex_is_held(),
> > for example, to kernel/locking/mutex.c.
> 、
> Agreed. We should first introduce mutex_is_held(). Thanks for your suggestion.

I'm not sure this is the right occassion to add such thing. It's just a
warn_on, we can either pass in the necessary condition from the callers or
just drop the warning.

Thanks.

-- 
tejun

