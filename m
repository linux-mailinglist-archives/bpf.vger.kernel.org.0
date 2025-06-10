Return-Path: <bpf+bounces-60126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91969AD2B0D
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 02:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81AA67A84A0
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421317ADF8;
	Tue, 10 Jun 2025 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjGbiwDG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803751779B8;
	Tue, 10 Jun 2025 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749516587; cv=none; b=SyAyOr7LYB9CH1Fz55HynKIXSPrfo7dy+H5q9l2LRHLYkpevSukuzFitsFD+hWUDn8qqIIAu0NJHgwDNppuHLHBF1v6BUHLOHGPXmEMscalBDMCcvql8uLrwhxuDViWbQbOb9UL/Ul4V6yrQloROXAsHBrWpfPD2luxkQc/0CF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749516587; c=relaxed/simple;
	bh=eUli2SqlTIb3UGlk8K0rC/rAcihDxdAKUxBy6iGjm5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTM2+6jVy/HFMbhih/xrNwgWBSqRjuLYUB6HeNNM7OedYhaP4HfxEUfCpa8/Cga1M64LeUTpb3vEsnj2hJ+y81vPk20vNyYBRRGiRuxUp2sCc3D5gHb3HcQPtPmhIgCOmcRQOZj4jE1LCCZsDyNVdVNmhi7Eh238Xc0xac3Is9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjGbiwDG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7cadd46ea9aso721598485a.1;
        Mon, 09 Jun 2025 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749516584; x=1750121384; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RF+PSMIKcuWfr1fY4InaD+yJzxbAHclMlrTdn5/1QWU=;
        b=SjGbiwDGa9js4rQXFDNyAWfkqrRliNkul1tmpy5EyFAoct+xdqsGNtasYaJWhgj+8B
         u8maMI+FnstVyWrhQuXVbNe7YYtjsChVuUqLba5o4a0Dp/oPOkWq45z8RxneqIe0AXUO
         elUJ9KEqb74BCiyxl9CHNik/BOntt380unqOsaEk7Ie6zrfCw5sZypHbutYYaqOA5W2b
         7PI7U47FGUPuHDPLQsp8a8B/Ygmp3rJjCMRnSOxelRHM7AlAUQh7qvy7ALzArnLE2IEv
         7WAFD3Sa0xW62DC48oZrBEolwQcmO2NgHJV8MGM9twrd20ei7kF5sbrvDZ6EoAB9ktEx
         Vn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749516584; x=1750121384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RF+PSMIKcuWfr1fY4InaD+yJzxbAHclMlrTdn5/1QWU=;
        b=qrST7l+hcyOFZH/S8e7yf+FQpXGVPqSYyqlldWlr1RJfn++9wIAQ3wEq++LyKN4QL6
         B9MvGJ/cx6zaK7vy53HJ1WwA5K5OK5B8GZzYhGOAGCFnKKf4txgj0sPXcdi+Yf+UbNFz
         LW9KZWdfQMPw18E4fIF3FDdNeKx9B0mMuFvCYydpxZbluKARtECW4Zm/JQleoneYSsv8
         cVTzhUrJElL8vdggcgXH83wWr9lKNNdonvK5ANCGHZoIOn9fzBeTlESan3VP+otcL+HE
         roMUigtiYQl424YBvDEBxCiUM8m8ovvsTU0kwb3RLOTTqPwjc7QbAOQ+lJQPyJvDYL7Q
         C6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8n+eQ8/pesOzWzNLX3cZCvPJ5ztRMmMJuM5RCbn0W4zsXascnWR70H55cn7vOjtIHahZB@vger.kernel.org, AJvYcCUWLlC4BbkVCceGJSmlZyhVXGOZ+HgaljKPBxRY69wNIM1QJ/rKx9pxDw/MbqD5rPLUITlUu/MzvT2xufRw@vger.kernel.org, AJvYcCV53p5rRqx7Ku+DhiUwD4Foy/sQICkatMyZtsv/DygVHrbM8o5hjmDCsUMJhrz8sJ0bGcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKcXZxQiLLfPRAQeTAD7UFkKXxwaLeWlRKz5E6gbNZpKsU6Dd9
	kFTjLENl124z8n0DByCJJodnSCMr5P7iUMlf21Qbj/bajcci0D6tri0z
X-Gm-Gg: ASbGncv3IYANxtMZV2Qgd5Kpa6NBcy1rdeb9iodvqw6hzAfXB0jDAy/kjRCrVb1tS/J
	1SB0w6PNbS6judpObW8SxyX06qy0NzrVdpuVeqUIws4qc6ABXTYnLfGdoDYCFBD8Fm31x+uSs6R
	6iCD6iVSiWyB53/zwWRpew8466rbPFZcdI39jF8sUilm25h64f5ccdVsHNoErjaJC3SIeBcAAU4
	9uS5Nx8SidSM0BTpVpHeGmY9gcGSKKJwOCGnoZ0j6bsRa10bDwxIuBtIwAEvg6o5sI/wdBr0tq4
	BJL/W4zmJrOX+kQXbdc6cMBpmLicXlc4uJ6rq0b12GPIysz3qOzDgfHARHd2wEFTXvpConPQijQ
	S/S7GXqmHD6TVAnmbKcEhDEJMaNFAI71vUOyVFbX67zFX3lWvHPbL
X-Google-Smtp-Source: AGHT+IGEy0YlhStd50i4t94VN7z4+D2puRlAeJ1apZkU2GngLeTxp86Im33dOmLnRIbI268qE/9c3Q==
X-Received: by 2002:a05:620a:bd4:b0:7d3:8dda:3eb4 with SMTP id af79cd13be357-7d38dda3eb7mr1442685485a.45.1749516584246;
        Mon, 09 Jun 2025 17:49:44 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a60ae88sm613800485a.72.2025.06.09.17.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:49:43 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18C751200066;
	Mon,  9 Jun 2025 20:49:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Jun 2025 20:49:43 -0400
X-ME-Sender: <xms:JoFHaP5lvBmkPt6DvqY5nkGD-YBQA5yC0dyEW5DoGezDHR2BUktMqQ>
    <xme:JoFHaE6998oTYx8rAsR455mp3gx89BDdAWgNQk-_-FWLLkNJz7Wzt4ckfOCQiE-cf
    XAO_IYAJBjTBfFjWA>
X-ME-Received: <xmr:JoFHaGcG2B4FOXiAx3n-ClmTw0VvmC6jnF07g9SJdovAHoZccZ5Jl-L1DPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleek
    ieeifeegveetjedvgeevueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggv
    rhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlh
    esjhhovghlfhgvrhhnrghnuggvshdrohhrghdprhgtphhtthhopehjohhshhesjhhoshhh
    thhrihhplhgvthhtrdhorhhgpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrgh
X-ME-Proxy: <xmx:J4FHaAKwkrXg86lToDmCwLmGsoAvbwoaZarBoEHvbHStado4o8EfiQ>
    <xmx:J4FHaDKBslPoikKT-fj9OFpybBAXHmCDpLhkEBbodSNox5WTR7i_KA>
    <xmx:J4FHaJyKEvrZN_yB_N7zGZLEra7vJc57O73dclXJVC6AVvzx2Whkow>
    <xmx:J4FHaPK92qSR6XDqPVVGR367T3Wju5Tt5mzcYrif9USDUC9leyh3Yg>
    <xmx:J4FHaOYYk7fTpeC143KEwshwCR9y-b9sUy6iKTH8Wswc3x_iKr70jRp3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 20:49:42 -0400 (EDT)
Date: Mon, 9 Jun 2025 17:49:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu: Fix lockup when RCU reader used while IRQ
 exiting
Message-ID: <aEeBJQ8go5wH1XCp@tardis.local>
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
 <20250609180125.2988129-2-joelagnelf@nvidia.com>
 <aEc6sroqylvlfx_M@tardis.local>
 <aEdttj_vcdIEsKxG@pavilion.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEdttj_vcdIEsKxG@pavilion.home>

On Tue, Jun 10, 2025 at 01:26:46AM +0200, Frederic Weisbecker wrote:
> Le Mon, Jun 09, 2025 at 12:49:06PM -0700, Boqun Feng a écrit :
> > Hi Joel,
> > 
> > On Mon, Jun 09, 2025 at 02:01:24PM -0400, Joel Fernandes wrote:
> > > During rcu_read_unlock_special(), if this happens during irq_exit(), we
> > > can lockup if an IPI is issued. This is because the IPI itself triggers
> > > the irq_exit() path causing a recursive lock up.
> > > 
> > > This is precisely what Xiongfeng found when invoking a BPF program on
> > > the trace_tick_stop() tracepoint As shown in the trace below. Fix by
> > > using context-tracking to tell us if we're still in an IRQ.
> > > context-tracking keeps track of the IRQ until after the tracepoint, so
> > > it cures the issues.
> > > 
> > 
> > This does fix the issue, but do we know when the CPU will eventually
> > report a QS after this fix? I believe we still want to report a QS as
> > early as possible in this case?
> 
> If !ct_in_irq(), we issue a self-IPI, then preempt_schedule_irq() will
> call into schedule() and report a QS (if preempt/bh is not disabled, otherwise
> this is delayed to preempt_enable() or local_bh_enable() issuing preempt_schedule())
> 
> If ct_in_irq(), we are already in an IRQ, then it's the same as above
> eventually.
> 

I see, I was missing this, thanks for pointing out ;-)

Regards,
Boqun

> Thanks.
> 
> -- 
> Frederic Weisbecker
> SUSE Labs
> 

