Return-Path: <bpf+bounces-46720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700A9EF605
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 18:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF618811D9
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4297E2210E3;
	Thu, 12 Dec 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="DsNF30vw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9553365
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023743; cv=none; b=PVgMDs3IboAMFWfGZw0ihE7vZGyT2Ajs9Uv1CUVsPL8E1mdKTUCAI5VcHs9zi3iVLysOnvHS2w3f6866sQqgMxdCi0csv2Ay0UkFQXrLo4L2BSzo0JrbW6kNKgGX6SehUnafZjoRktFQgQzW5aFpD/81A4/US4lYTAVrtn+LSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023743; c=relaxed/simple;
	bh=NETcqynxIamJMolrIErckuu6GXgBZ5SuUOe/9tKyniM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZevP0hBdHYR+9KBh+YRAoYY3mujlXfyXlmQuWK2gV3dno5tD6aCq0hNpU8N8h0CyOMpIDcxM2Fs+kAUPAaIbz2sQrY8CzIuVl+yN/OXZbkO5E2OAENsJ0YB9DoUB2+fQ1bG+OcA8QAxJlu2LgMTMlUgNN+UtLKHeI1GCLcAx2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=DsNF30vw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa692211331so171484066b.1
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 09:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734023740; x=1734628540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KdEBPxuMhiVLaoXo4BUolB6GNdmtWbV20YyZMWhyRMY=;
        b=DsNF30vwyRFPiJWW5fizXKSw12jO+PDzTEsyKuVH+prmp01s7XUBM3o65v9FKXJZ0e
         yOO/qReC7k/plGFAYm8zLxkezuxC3JI7xVmI5axDSsFoBn3+pFQemBj6XdKujC/Ox9ap
         pNNUAGrMEkWRQ1DeH69OO6TUbGDbVPqRQRZq14cEvypSAJeBMdSS5cESgw/ThngUopEJ
         HhZ4G4d4SZHEz75U9/tJwu31zfJ4Wsqk0T69+je4K/j+EG/Trwxknn9FnxA+wPd650fQ
         lWDaqbvmupi4LFxnIXSkxmyC7p0EbDygnem2R131+xhjnbzch6QrJq6ab4WLz6j1S/QQ
         qKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023740; x=1734628540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdEBPxuMhiVLaoXo4BUolB6GNdmtWbV20YyZMWhyRMY=;
        b=GG90ev/IPKM7ZX+aMWfEd9DkD7CH/oDVy8VU+3HCtYYGCcVKA48D3O+mvM8PnnRbWI
         8/owQzWDcN8Ypt4Rb/VHp+lEt1OEs7JlxWMJ3fLA3H49pFP0Ld5qxpd5yL5VN1/zh0dY
         RbDHCZKBVYOCIv8sNrwrsy1pHWKiOox+SH8ie/KHgFuMQFzibk3kZfJT3Sa7xwhlNIGo
         YamtmH/PFLElPS4sgTbAHZO/kn9tgqLZ8tOXWM4bBa3sUUE6G4of/hJ9CkQEY/zKA9lI
         1QqHZdZVJt5Jsd3WW3xWcigfLf14Pvkp2zN310Z06WG6yoxsJK42r81s0Xoar2rwYJgz
         vqDg==
X-Forwarded-Encrypted: i=1; AJvYcCU62uG1AwudzRIweVcMBra4lN8xw1kuEbQ1Hant493aU/7kZBDFOsqVt07UpROvF/kxmNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QTWkBZH/dq5yP4KyXU518hmZl3oBXLaEuAX+MNffisPCE9lh
	avNJQcBHYAi2+4zcldnIFwkNLmTGiB+dk9kbUWvkmXmbJ8I0XHEO6qpJmWuVl9U=
X-Gm-Gg: ASbGnctRjxNs68hZLVw1VNACP1wD76z60NgS1fMJzGEL8sgbekMPfKeKTQK2BV8n/WN
	CehlvxrNF4EvKBr/lOro9buHiixwmKJ32DDHoBKYfyrVCqKZ3p4nuWsMQjrSSoDPSikQk3s4xgj
	dACs+O+vnQxXJZovFMfFZzu0Wa/S1TzEzokcIRrwOnRkymj2By84aYwuaXVBJM03616zpY5V1aF
	MQdXu871VwAZs5iwhxFou6dOogC0SG73Ug6luFgKRwV+g==
X-Google-Smtp-Source: AGHT+IHINoOr5M53YxdjIZt8uycihWxiIHzGzaRs1kbuXgqe8dVlNa2svuUCPFDY00vQBijH0GjQ5w==
X-Received: by 2002:a17:906:5a61:b0:aa6:89b9:e9bd with SMTP id a640c23a62f3a-aa6c4180175mr321073866b.24.1734023740123;
        Thu, 12 Dec 2024 09:15:40 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66e8f71dbsm761046866b.67.2024.12.12.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:15:39 -0800 (PST)
Date: Thu, 12 Dec 2024 17:17:30 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z1saqkRqbAc+bMWp@eis>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
 <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
 <Z1BJc/iK3ecPKTUx@eis>
 <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>
 <Z1FnPIuBiJFMRrLP@eis>
 <Z1gCmV3Z62HXjAtK@eis>
 <CAADnVQJyCiAdMODV3eVxk-m6C3xAR0mKCJYgYqUzcXypKcWwcQ@mail.gmail.com>
 <CAEf4Bza6i3nda+7XPcfmVEckwGfmvsvPmakf_VQhFHEWoVTh4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza6i3nda+7XPcfmVEckwGfmvsvPmakf_VQhFHEWoVTh4A@mail.gmail.com>

On 24/12/10 10:18AM, Andrii Nakryiko wrote:
> On Tue, Dec 10, 2024 at 7:57 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Dec 10, 2024 at 12:56 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > >
> > > >
> > > > This makes total sense to treat all BPF objects in fd_array the same
> > > > way. With BTFs the problem is that, currently, a btf fd can end up
> > > > either in used_btfs or kfunc_btf_tab. I will take a look at how easy
> > > > it is to merge those two.
> > >
> > > So, currently during program load BTFs are parsed from file
> > > descriptors and are stored in two places: env->used_btfs and
> > > env->prog->aux->kfunc_btf_tab:
> > >
> > >   1) env->used_btfs populated only when a DW load with the
> > >      (src_reg == BPF_PSEUDO_BTF_ID) flag set is performed
> > >
> > >   2) kfunc_btf_tab is populated by __find_kfunc_desc_btf(),
> > >      and the source is attr->fd_array[offset]. The kfunc_btf_tab is
> > >      sorted by offset to allow faster search
> > >
> > > So, to merge them something like this might be done:
> > >
> > >   1) If fd_array_cnt != 0, then on load create a [sorted by offset]
> > >      table "used_btfs", formatted similar to kfunc_btf_tab in (2)
> > >      above.
> > >
> > >   2) On program load change (1) to add a btf to this new sorted
> > >      used_btfs. As there is no corresponding offset, just use
> > >      offset=-1 (not literally like this, as bsearch() wants unique
> > >      keys, so by offset=-1 an array of btfs, aka, old used_maps,
> > >      should be stored)
> > >
> > > Looks like this, conceptually, doesn't change things too much: kfuncs
> > > btfs will still be searchable in log(n) time, the "normal" btfs will
> > > still be searched in used_btfs in linear time.
> > >
> > > (The other way is to just allow kfunc btfs to be loaded from fd_array
> > > if fd_array_cnt != 0, as it is done now, but as you've mentioned
> > > before, you had other use cases in mind, so this won't work.)
> >
> > This is getting a bit too complex.
> > I think Andrii is asking to keep BTFs if they are in fd_array.
> > No need to combine kfunc_btf_tab and used_btfs.
> > I think adding BTFs from fd_array to prog->aux->used_btfs
> > should do it.
> 
> Exactly, no need to do major changes, let's just add those BTFs into
> used_btfs, that's all.

Added. However, I have a question here: how to add proper selftests? The btfs
listed in env->used_btfs are later copied to prog->aux->used_btfs, and are
never actually exposed to user-space in any way. So, one test I can think of is

  * passing a btf fd in fd_array on prog load
  * closing this btf fd and checking that id exists before closing the program
    (requires to wait until rcu sync to be sure that the btf wasn't destroyed,
    but still is refcounted)

Is this enough?

(I assume exposing used_btfs to user-space is also out of scope of this patch
set, right?)

