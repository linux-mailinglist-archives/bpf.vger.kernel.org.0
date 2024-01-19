Return-Path: <bpf+bounces-19881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70942832561
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 09:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36F01C23BF0
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789CBD53B;
	Fri, 19 Jan 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e75AlMmF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5256D52A
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651493; cv=none; b=MwW08UtbPWDmCaoWpSnfRnCALI4AdNXF589CJ3mhbDCbVfpJbDr2TtaNpNheVlH92Lhpup/pZyQWQOFJ/hfAVW5OTtXcwfpOFywBNg1wBnaltwqE1F2KMNZYUM9J+xndzYZ4ytycfXGniadiCWu6p9AItmzNikZKeENpMBewyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651493; c=relaxed/simple;
	bh=OecyJg6/3qqVQrWEJdy32/aF6L3WyXkBSrouqJi1hZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrTci6lCLg/jY4VLS6yuofzSPyck6dCgGrKf2rOlHFvWgRPnW+DCCNbKnLXSHKgKJZK0G9C4/AxZZ+a2XJB4xbp+2PxG8lcXw6qQto7UpUjTgPeMNYNxnXji/O3McW58mEDx4U6+nbXJbJyshl1haRetITuIKridiGGU6ZvwYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e75AlMmF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so7156581fa.0
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705651489; x=1706256289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yuEO295s01DTRpkmjprmrg/fuw2+mwEPbofVGNYQgCk=;
        b=e75AlMmFaM0iQa4vnhkR/82t+RlF/oHN6yhcNFZrkqb5txAcUt335HE5F6Nv4ynXAX
         shlYdxycC8wMwiyx4jxvmwS8ituX37NNS1VBmofi85reuX3iZc5QHiMJS6paBORI1noo
         HFMcaYRhGWcrXzVWc/7isgdACg7HHI36JycArhqi4lkHMepfxyAj2LyOfodRci8Q1oiX
         kKsbq3Bscb/FBIG4r3EIH9Dysb9q5LWKRK75rR/h2i3vEVqGYYyN+0gqDbBZSSoSTvDO
         ejs/qybBUaVYrU5Ee9or+8f3RvFt5U2y7XCWFzZc6Z0vI18hl8ueCzLjs6I9/xi8Ndc/
         vYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705651489; x=1706256289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuEO295s01DTRpkmjprmrg/fuw2+mwEPbofVGNYQgCk=;
        b=CuI073g/SIoWjPn7AqQ91RZLgQVgRXwkLCjxSuuUjomWPMwX+I4Lr6gdp9aCyUOSRc
         yeEDakJShvUasBzuCN+vZmEU1rn9tn26zdenI1NDlTiHvyt6/+mhTrWTRp7C8ZUJe5eS
         vo8hH8ZC8n/fYbg9VI0FMX2o5rBj50Qe8ic9f/wLErZ9b+PKQMAaaKK6hyzpjTcLHeZs
         4kMBNm1tQHvBgAxDABEqaCp0RmdqfAAlxMOnue664CQgq78IdPfQTXdnIRv/VRNHT7uf
         LUDE0fqgZ4EoHtSCyEveMTXp3j58Y2+jLOXbIwYHTRQ1qLXdikHigho1xxTGCuta1Ksq
         lFFw==
X-Gm-Message-State: AOJu0YxWq8edbCDdWTEnlC7IgQi5qThfWAGo1mlcCC2ihtzNoooUXvAQ
	NSGEd1AYowe6mzfnK6GMat0FnrpyzBhNjP6Ks5voYw2ywkMCkiHptO8wIXQBun4=
X-Google-Smtp-Source: AGHT+IG5AsMsXtRAuUEG/S1Ec4JuitgLAWzwVWi+qhqWIX75u68417qcG/35Ry9Vl7wnj+waEvYnVQ==
X-Received: by 2002:a05:651c:1551:b0:2cd:cd45:5cc0 with SMTP id y17-20020a05651c155100b002cdcd455cc0mr1642604ljp.9.1705651488888;
        Fri, 19 Jan 2024 00:04:48 -0800 (PST)
Received: from u94a (2001-b011-fa04-1220-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:1220:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id s4-20020a92c5c4000000b00361a7db24e4sm464360ilt.57.2024.01.19.00.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:04:48 -0800 (PST)
Date: Fri, 19 Jan 2024 16:04:40 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
Message-ID: <uf7fpvox2s3ban33ybixlg2buxbh2ys2gl7wjrphuip2qrdsjr@56dp2546tuuu>
References: <f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
 <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>

On Thu, Jan 18, 2024 at 05:58:20PM +0200, Eduard Zingerman wrote:
> On Thu, 2024-01-18 at 19:58 +0800, Shung-Hsi Yu wrote:
> > Compilation of lsm_cgroup.c will fail if the vmlinux.h comes from a
> > kernel that does _not_ have CONFIG_PACKET=y. The reason is that the
> > definition of struct sockaddr_ll is not present in vmlinux.h and the
> > compiler will complain that is has an incomplete type.
> > 
> >     CLNG-BPF [test_maps] lsm_cgroup.bpf.o
> >   progs/lsm_cgroup.c:105:21: error: variable has incomplete type 'struct sockaddr_ll'
> >     105 |         struct sockaddr_ll sa = {};
> >         |                            ^
> >   progs/lsm_cgroup.c:105:9: note: forward declaration of 'struct sockaddr_ll'
> >     105 |         struct sockaddr_ll sa = {};
> >         |                ^
> >   1 error generated.
> > 
> > [...]
> 
> Hi Shung-Hsi,
> 
> One option is to use CO-RE, e.g. as at the bottom of this email
> (not sure if people would agree with me).
> But that would not produce usable test anyways,
> as load would fail with unresolved CO-RE relocation.
> 
> But what is your final goal?

Final goal would be have BPF selftests compiled and test against our own
kernel, without having to come up with a specific kernel flavor that is
used to build and run the selftest. For v5.14 and v5.19-based kernel it
works: compilation is successful and I was able to run the verifier
tests. (Did not try running the other tests though)

> As far as I understand, selftests are supposed to be built and run
> using specific configuration, here is how config for x86 CI is prepared:
> 
> ./scripts/kconfig/merge_config.sh \
>          ./tools/testing/selftests/bpf/config \
>          ./tools/testing/selftests/bpf/config.vm \
>          ./tools/testing/selftests/bpf/config.x86_64
> 
> (root is kernel source).
> I'm not sure if other configurations are supposed to be supported.

Would it make sense to have makefile target that builds/runs a smaller
subset of general, config-agnostic selftests that tests the core feature
(e.g. verifier + instruction set)?

> [...]

