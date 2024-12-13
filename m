Return-Path: <bpf+bounces-46886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD0D9F1553
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C503284028
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 18:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D171E6311;
	Fri, 13 Dec 2024 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z62beqGq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6A186E26
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116287; cv=none; b=QIIcRwCwCQ1jbfgP8aFE68csZjMg0CXjvAt9qOSHtOX0vPVXl2W5WGhJk1UmFpbsOLoIRE7WZL4LwUSKkIJtmGAPnzbhcyP4BLzkCBvj5sviCIBYKBFw3PJaKUP2h4GuwqNFcOCMtIBKmW2LTkSP+Ygn/Pm+/O5ymOPtZpDuwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116287; c=relaxed/simple;
	bh=rGG0P+frzbjAQP+9fh6PE2z6G/h0XvM3/3hQKrvynpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8GNnt9rPWqiRdGVsfldi8/0bJ1SnZDhTTOLJZGiz0Yd+EXXtcg0SBgfR/UV+BjUC3Mym31+6iYZAVifC0TDbMrh+I95kq1P/Rug8XqWOSw6XKAOOBItfUJyLjAY6wMcfKUVY77Z8IZwXICntYjdxJIsq72inzR21sanYgZtql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z62beqGq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1400638f8f.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734116284; x=1734721084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGG0P+frzbjAQP+9fh6PE2z6G/h0XvM3/3hQKrvynpg=;
        b=Z62beqGq5uxOdVhWP6fN/8oB35HTft97+vGV8+14gs/8ZUMgJvHOfXQW4hWvLytoBZ
         c3ylWWW5OxG/eyRrOBNekTUiBywYQj1k2mluQdCMFwWOqb0NxAUBNWeWJShSx+cGEhd1
         JLPJajGwf9xvOug9IU0vwZtUqDAaaF/0CppAdFlAZ8FgCfrpjzfYsiqW0aimxi2VC54W
         2QyCdoOqGvzEN9XRIrdIqK66giKUiAe+NAdKl/Qgzq7AYOGN5lc9DYTPzzgnk8W0OhcT
         ARnszrfBMzDNi/hJOm3RynXOxd13vAICL1gmm0rhvOlvtsK5/EROtak4LHbX7bWAdKij
         F2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734116284; x=1734721084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGG0P+frzbjAQP+9fh6PE2z6G/h0XvM3/3hQKrvynpg=;
        b=JT0rI0Kgg9dHKjg3T1WH+/eWezw8u8tTbD2cXfMlzVw+O/k0CG6axu871eTw+3HSvc
         AH0Qkrz8Va8g+Z07N2mxJKH755LN5JZvERNybqkdl860kmYeMp1LUseA3+oOZvt4r+Wn
         qbMGfLK11M0kdxUJpDPOGrNA5Pl1VhSK81pgbN8VRJaEVBDGM7fw0CCdnhpwcCHulVuW
         i+muRgr1ynlMObWuRnyxNVufffr+YsOglQfIzJj49V7M0c55CaqIhjzfI7ryOjSe4V2y
         2RCrbg02chAWjjol9WU96bSnRtHNCdLSvrnHjZ6wYEgOZzPCTk8XdOQ46plJi1ronSDa
         ZA9w==
X-Forwarded-Encrypted: i=1; AJvYcCWNjPM6hQLs/xXeK5PM2BcPEUlm2lDK+sJL3B52p6W5e4sA+kfd0EEItcjfpdF1iZrJxmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9cvXaQRfFgnVoBf5XO0+pYLDueuVxanRxttzh6kVMsPiQ9Wr
	lNpjW6eFRUN4ItDYRIhMAy07BTXkR38JC4cpVzRnSjeTc1EYPb9AP1qTjxY79ZxuCdWutEWlx3/
	Wx8FEX352OHR/ll0AMCY8iXXF5FBJrQ==
X-Gm-Gg: ASbGncvld/8FFITXYEzv0VIqa304R9d4gr+r6fZSfB7BaRHet5uZTlnx0MIN9KNKX6F
	NI8s1Zo/g51E9NYRMr7xutL1HgVTi6GhIrRnx6oHFELaybAfbntKJB39hRFO6zaOgLSOd+w==
X-Google-Smtp-Source: AGHT+IGs+Y+BUs0MQtiMUaIeawQKnEBmP6PDBF8YV7tbwjALbtoMERVaMJxi2wQMR7vT9cd2Nsa8lQh3BBnLRvetE1k=
X-Received: by 2002:a05:6000:785:b0:386:3327:4f21 with SMTP id
 ffacd0b85a97d-388c3a8f4a9mr2956297f8f.27.1734116283629; Fri, 13 Dec 2024
 10:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com> <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka> <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
 <20241212150744.dVyycFUJ@linutronix.de> <Z1r_eKGkJYMz-uwH@tiehlicka>
 <20241212153506.dT1MvukO@linutronix.de> <20241212104809.1c6cb0a1@batman.local.home>
 <20241212160009.O3lGzN95@linutronix.de> <20241213124411.105d0f33@gandalf.local.home>
 <CAADnVQ+R3ABHX2sdiTqjgZDgn0==cA3gryx9h_uDktU6P2s2aw@mail.gmail.com>
In-Reply-To: <CAADnVQ+R3ABHX2sdiTqjgZDgn0==cA3gryx9h_uDktU6P2s2aw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Dec 2024 10:57:52 -0800
Message-ID: <CAADnVQJAM+cGs2vMX4H-EGftbgiu9ZGjXgidCkgQrc6h1YWx3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 10:44=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> If hard-irq acquired rt_mutex B (spin_lock or spin_trylock doesn't
> change the above analysis),

attempting to spin_lock from irq is obviously not safe. scratch that part.

