Return-Path: <bpf+bounces-23284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33F686FBD0
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 09:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A851F219A5
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 08:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179A17583;
	Mon,  4 Mar 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjBkYhLg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87097171C7
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540894; cv=none; b=jSbfJxRbyzQpuxEm6l4LRdTr5GOzLVFnYJo+jUhNy9SSyismzEAHiUOEBtfQZZL5i7ciTCOdBkkwfbE+GWw2Gx1g076jugdtlMaFo8ZHAh418keja4SVPMgyoWA9pT38C/QGrzwc5Vgz1PC+/JKkdhpHkFIt3Aie9v3znNGeOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540894; c=relaxed/simple;
	bh=PUdtcZ3XITfjJPKTsI49VUxZ2SO8tDSHGiBslzbpXxo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5byrQF9BuyOC5Gcq/wNbU4vz4w+YBsKYuB35oLNjcQfMC9vmw+G56FwuUXVksgfGimOqzgjy1euE0wGjguYPb4AlRUNBN2ICDsklByxF8mhKeJpqw6JVwTOaKHnZMeP38mGXNUIh3j/CNMFLxDL9z0GM/0eCw//xquVhAykX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjBkYhLg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513181719easo2457331e87.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 00:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709540891; x=1710145691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDIXInsu+qYsHbhgvB8FyUTwyaLgFX3PgtxISxYhWEU=;
        b=fjBkYhLgj7oKSVmo7BWIszsTvuUcZuBN58HX5+iatKCXSedRrbzo2hMya1M7ysInMJ
         DSIwfujgmu+cTDzaYQe/ezrUe5QgFCvNYNjOUujn1sKIWdj4hxq2x4RMQtMvZYpOPjjr
         EDZZIj2zZVzqnqt5Hux4fWJmYSsGHlLonoDfIA9PeZufPej54W/C8YcZ+3Vtb71oY/k9
         R88GtTRP3z9KEDLaDJsF1xXK4a1xdfkiQmhYGJ0kUB8505A1g2hKLNPZo3NDXVXbdhGe
         m40Xe5vR5Pc5zULCME4skET+iZdxndnAfLaWeu9zeXxgBdFp777ZpIGopx/aYiBLxv7p
         BLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540891; x=1710145691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDIXInsu+qYsHbhgvB8FyUTwyaLgFX3PgtxISxYhWEU=;
        b=SEwfztmqC1qblTbUrnqdjw7cFYkn4rso3ywTioJmEVEX0t6Mf8Rq6waqBFxqftVHOr
         RXOk5EZn2U43C1JZe7wYU/p7Nu5FvU4mn3aGKHvhO1/NQxrjzktL31anNKSGE/UDUFsY
         LUlu6u3Dga5epLAly9hbHDqTquAsRjKCYJzNfKWIEpLm8cBryVQOe6BIlMfFdUmclPmg
         14yMHM8eQQETkYnG4gzXZGqNJmPSkytzE4Y6ux85s3eFBvXiGtLAIvOxdjVu2C5w8Acp
         kg7lJYYbcZbX3w2V94PlwfrZijG5LND9c7wSvWeYXOXocfeEQ+XhWyCAKZTbyrAJvl+q
         Jy/A==
X-Forwarded-Encrypted: i=1; AJvYcCWCaPdCbsV3BmoerfFlFmpzn5OIywi6RK/RtXDfXFZZCkEsDa2maPRBDPaLFBdeEpAk8V2XoYT3BPPCUW0y1LHCSV3G
X-Gm-Message-State: AOJu0Yz0OhKB/xtYxvRHGtjvx79ISzfdn59R+NkKVIgWwOjMYgAWTbSP
	MBidUuqWQGAqygC9zhQ8A1gU8BJ+6IxS3q6BZX9tP4ePdIMZdg10
X-Google-Smtp-Source: AGHT+IGv9ypkK+esZ9QJFAMyTBMvi8aBdo8nge9Ua6RLtVU+nZ0WTVJKCcOu8Zaw1AvnZWOh8ndFyQ==
X-Received: by 2002:a05:6512:108c:b0:513:45c3:c1d5 with SMTP id j12-20020a056512108c00b0051345c3c1d5mr2261962lfg.68.1709540890372;
        Mon, 04 Mar 2024 00:28:10 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7da96000000b005669ce3f761sm4311128eds.59.2024.03.04.00.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:28:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Mar 2024 09:28:08 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH RFCv2 bpf-next 2/4] bpf: Add bpf_kprobe_multi_is_return
 kfunc
Message-ID: <ZeWGGMyJIlT_rGMn@krava>
References: <20240228090242.4040210-1-jolsa@kernel.org>
 <20240228090242.4040210-3-jolsa@kernel.org>
 <CAEf4Bzbga6PK8UNUO5ZHL0Zo3t6xQ8S0tY4Da6aB+AFvm_jjsQ@mail.gmail.com>
 <ZeBZkmZwYqT7o4So@krava>
 <CAEf4BzZ_5-nORBS-MrZBLbUUmZ3j3txJhhZxHPLkP-n1SnFQfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ_5-nORBS-MrZBLbUUmZ3j3txJhhZxHPLkP-n1SnFQfg@mail.gmail.com>

On Fri, Mar 01, 2024 at 10:01:16AM -0800, Andrii Nakryiko wrote:

sNIP

> > > > +__bpf_kfunc bool bpf_kprobe_multi_is_return(void)
> > >
> > > and for uprobes we'll have bpf_uprobe_multi_is_return?...
> >
> > yes, but now I'm thinking maybe we could also have 'session' api and
> > have single 'bpf_session_is_return' because both kprobe and uprobe
> > are KPROBE program type.. and align it together with other session
> > kfuncs:
> >
> >   bpf_session_is_return
> >   bpf_session_set_cookie
> >   bpf_session_get_cookie
> >
> 
> We can do that. But I was thinking more of a
> 
> u64 *bpf_session_cookie()
> 
> which would return a read/write pointer that BPF program can
> manipulate. Instead of doing two calls (get_cookie + set_cookie), it
> would be one call. Is there any benefit to having separate set/get
> cookie calls?

ok, that would be easier, will check on that

> 
> > >
> > > BTW, have you tried implementing a "session cookie" idea?
> >
> > yep, with a little fix [0] it's working on top of Masami's 'fprobe over fgraph'
> > changes, you can check last 2 patches in [1] .. I did not do this on top of the
> > current fprobe/rethook kernel code, because it seems it's about to go away
> 
> do you know what is the timeline for fprobe over fgraph work to be finished?

good question ;-) Masami, any idea?

fwiw there's new version needed for [1] fix

[1] https://lore.kernel.org/bpf/ZdyKaRiI-PnG80Q0@krava/

> 
> >
> > I still need to implement that on top of uprobes and I will send rfc, so we can
> > see all of it and discuss the interface
> >
> 
> great, yeah, I think the session cookie idea should go in at the same
> time, if possible, so that we can assume it is supported for new
> [ku]probe.wrapper programs.

makes sense, even though with new kfuncs detection stuff,
it will be easy to find out

jirka

