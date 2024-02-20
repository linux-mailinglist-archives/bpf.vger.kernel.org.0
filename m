Return-Path: <bpf+bounces-22316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809AC85BB78
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD29282A2F
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BAF67C70;
	Tue, 20 Feb 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao8//Trv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F4664D1;
	Tue, 20 Feb 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431055; cv=none; b=oMXxLeUkAy/RbgeAqnWI5TUxrBaDgSzTrIVsTDKsqyEdA50yNp5yz69ArGAFBockUjLwoBAkVsfTIHGY5IJJihMLGQ7cQ75LRnxBHEwlXjVjT454T7y8LnFFD2fpaXbeU5/AVhSk2rPUGkQzmdR5XgNhdlH207NEpAndzKfhI8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431055; c=relaxed/simple;
	bh=k1DCEyn4H3hveRLD9jSJCoJrvBuN7qI3Q1DXFckiSKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuQnEdUW4ezrjIsCgmWDnwr5cOnayof/AERqhAl2uz7Z29fTypbfHl4E6UQxlLyI8Of31KBZKjCphuQPtSIsMyEVQnZv0GXq/GMRTu7h4nMZLbNUEp+aANA7xCjdmrR0H9JLdM9fLyuptKfDUMnymqQkcz19Kf17pkMWPw+ZLNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao8//Trv; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso51193331fa.1;
        Tue, 20 Feb 2024 04:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708431051; x=1709035851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k1DCEyn4H3hveRLD9jSJCoJrvBuN7qI3Q1DXFckiSKI=;
        b=ao8//Trv598y0x2xVpOrqxYwMMJQ6343h3CkYYk2xCJBfPdNP2ooN5icZLiRcLNivS
         CUJ7ezNw6ZfTr2We43HlW8ZGTvPorPY6Gr2jbs7cnLnmYrvACN5cQlmG21Z3/mjDB5O3
         s6OLU/ah9wWjAnVo1lQieX8en1BlqTy2oi3RYDANEDqmjqnYXhXhadTJjmwM3v2pntaj
         mAPNbmxx8pkWiapzZHRkqhNDA86yaiAjX2xG7sij8hxYqMnm+LyYaSfkdv+/qcQPSJtP
         IE/bjx/oZYSIUWdVcuyC+GE9MG0oTcnNMY/btiuPHIF+oTpkR1IT786AG5crBJbXuiWM
         GGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431051; x=1709035851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1DCEyn4H3hveRLD9jSJCoJrvBuN7qI3Q1DXFckiSKI=;
        b=HRVCxUerC0usgJ0b7MIqsBvrlBvAY/Wm47dbojWAKCM3zpKAtRyWA6He/KIvm84dXJ
         3Z8qXXHrrZ30TAHMNsaiFBtuZjRKqDOd6s8kMGLiFyEgH8INECZXT2f4fPtmy34wIK7o
         NRnMS787Vffm9aATkFkPzZLIl2BNI69YCgjmoPBkUyVf6p7WA7DN3dyjGs2vysj2WOZy
         qLHb/e1/mYQZPDzHsBuu2mb9OTNY2d/fNtTx4GwPd2B7oqbnxWkWlmqPvKEVXAiVwmMZ
         EF9l5s1yoeQYs/r6ZYCadrPft8AgkcGvuBH6f7McxZ27aZ3hQ3QM6AIlXjFc/sCca50o
         C34A==
X-Forwarded-Encrypted: i=1; AJvYcCWIthtr3m3vAvINMq75ZiktJIFl02wuqs7g9We+FX9kj7juRsvfPetYFlq3DfmzIHkthSSXu1vFFU9PXHwxgnRdkI1rB+Py3SFN2QGEIfv42RJoWQCXSruRz0xz
X-Gm-Message-State: AOJu0YxUoYiLePa6oMeq6MKIGUwAkFR62iYjuiVLuAKpVKzIQlhik0gw
	SlCTPia0PRrX3h3csjDkYIZQzPAKr+qqaDncuWFepwufdvWWB9kZVZkKtpGnlV8F9bRTKQbANYu
	HoYuMTDYeWWVIbscV112HTducmNBGztLH
X-Google-Smtp-Source: AGHT+IE2Ia9kd3h/+YP98aVtbC0ASanJ/IRAE0JGV0FtrB6wgTiytRTKGrq3AQ1B7uV2yxg1HLC/qCKX8x5uvrWUZOY=
X-Received: by 2002:a2e:9f57:0:b0:2d2:3b6a:4c3f with SMTP id
 v23-20020a2e9f57000000b002d23b6a4c3fmr3441940ljk.13.1708431051198; Tue, 20
 Feb 2024 04:10:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de> <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de> <87le7ndo4z.fsf@toke.dk>
 <20240214163607.RjjT5bO_@linutronix.de> <87jzn5cw90.fsf@toke.dk>
 <20240216165737.oIFG5g-U@linutronix.de> <87ttm4b7mh.fsf@toke.dk>
 <04d72b93-a423-4574-a98e-f8915a949415@kernel.org> <20240220101741.PZwhANsA@linutronix.de>
 <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>
In-Reply-To: <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>
From: Dave Taht <dave.taht@gmail.com>
Date: Tue, 20 Feb 2024 07:10:39 -0500
Message-ID: <CAA93jw6YRA71dBBmnLc0or28nnvr=NCy2kBCuzt+XuL_Pd5H_w@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am actually rather interested in what granularity ethernet flow
control takes place at these days at these speeds. Anyone know?

