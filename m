Return-Path: <bpf+bounces-47229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09F9F64E8
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 12:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273BF16C766
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1719CC22;
	Wed, 18 Dec 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c5yLoWYQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C26158853
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521560; cv=none; b=BQfewsuCh29VnhZioPitKU7rJxeYGoEwcG0k4L1IafwcieRylVwj/AbiwepC0Md1+1GWWtqj6qpP4cwrCMnCklF2sLIHvEQCX/ZRfknBxKrK9+22dsGxW658uVuQ8h6ZxBiZaSX5/Pb8Vkl9H4imtquQ7TXuXemdwpTTMUWtYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521560; c=relaxed/simple;
	bh=gHeVwuHthyDGUKGQU3DgZz9PavO9tj7rNesXOtON8/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mInG4fE2G7eUj5F1tGR7A4ky4tPHFA+KjFcr1lXo5QCGo4KrdY54rEv9GDmx/UsHCkYU84GnwwIQy6Lafhcbce4KY50AbTB6IcYGL9xVNnkj6Nac7OSjh955WmaL2E1PkMm3ejU4mgUVAKD8WrCbHkFpt6+vM2c8dLv5Rq5ehuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c5yLoWYQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1099800366b.1
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734521557; x=1735126357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NirsifboHgji5j59MMySErrYcHpikjdtVLjaFZnGTyI=;
        b=c5yLoWYQYhs4YDgJi5VKAGGFmTvAeD76srPa2v8/ZaId7aNf+ChMsdqiS44rt1VodE
         VaJzVNefp4RkP3dsoYRTAISAutZdMehQDBiw5D1ZcdzEH11arz7Z+xplFlc7olpozg+o
         hmea0MLL8bzn8fpoVglV6tSwqzb2UlKEPFPSUjkN38f+zjzmsMRaEg8RdvDxEwcOYoOZ
         62JuePPiYBA0uWUgykcW10JlUkX//DxxqiBD/aoUwV9x+5n4JZ1zARvLSxsM/tpm021l
         /wHzpPnIpN9AJ7QbA6/dOYZzPOtHiAUei2D5a/smsU45BQehIF54wucgjGUHlPeVobrk
         u4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734521557; x=1735126357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NirsifboHgji5j59MMySErrYcHpikjdtVLjaFZnGTyI=;
        b=t4YL76OcZ1hymiNCtOi7Jdyg60WgBcmv9NQiHgFTZlFpaXDW42yD3VgJcnmmt7uvqt
         7dWgubQ4EaFjsbW/a0ASxOfrrEbMiDkMOSNAVS7NZv7bswUyVaXpmpVKqPRlzGDLeEII
         JYlQKTtLLDob7kunOKUyzumFMV557XMBCx9E5Ltr5A4KuB2JbkR8nC53Ist0wJCcOH9h
         zESOcCsXLR5HxnC/2nfw8HcOyoti3zh/TDzbdrxP51BwzlYzvr2RdT3H8/TDN0xv+WRp
         D/j8qIv32gTYhgj09fseePbu+UdDlwN2TCgh0tgRoVdmfw1NsTASwYY4HjuaiwyUEMY4
         rrKA==
X-Gm-Message-State: AOJu0YyaVBwDgedBt1JavOZpDUh33YJowhc2jQSfdNr7zeQIa4zMtmtt
	Znsv8SIcQ5UggXP02nuuyZ6n0vDPiM0vZcbxjRM6dCgRC71oANC8499Hml7Qn0c=
X-Gm-Gg: ASbGncs0iOkFRRMrD6XbJ9ece/aDCDKOBw0zNTFVIreJg2jnFt9hoCOExY7Tb4rAVaU
	/GeBDP0iKPhyc8c9i4Haw+6QlJz8g2p6cr4UPWf5c8kVqo9xNfgzsPzgj/8XCiPMdmwiprEgplE
	O+PYfkBmi27TG7le7c2YfxJ/OkR8cfiOHyrzWISBK1euBlRGmMZYoZFGODW8RzUCkrjGnzxAYM6
	kLBNWsZo9eft6o5PA0s5KFVjzU2yVvNiQDakWyaDcON7TjiTInGARXJ+jaPh48LxLQ=
X-Google-Smtp-Source: AGHT+IEq2q6tPMM/R6sk0hNdfzyfoNTw6B76xP4krVqvm/KRKwDS0gBQi3mRlSWgdtRvJ08llqW3UA==
X-Received: by 2002:a17:907:774d:b0:aab:d8de:217e with SMTP id a640c23a62f3a-aabf4789710mr170917766b.26.1734521556750;
        Wed, 18 Dec 2024 03:32:36 -0800 (PST)
Received: from localhost (109-81-89-64.rct.o2.cz. [109.81.89.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9606893esm547480166b.71.2024.12.18.03.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:32:36 -0800 (PST)
Date: Wed, 18 Dec 2024 12:32:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, willy@infradead.org,
	tglx@linutronix.de, jannh@google.com, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
Message-ID: <Z2Ky06Bwy9tO5E1r@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218030720.1602449-3-alexei.starovoitov@gmail.com>

On Tue 17-12-24 19:07:15, alexei.starovoitov@gmail.com wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce free_pages_nolock() that can free pages without taking locks.
> It relies on trylock and can be called from any context.
> Since spin_trylock() cannot be used in RT from hard IRQ or NMI
> it uses lockless link list to stash the pages which will be freed
> by subsequent free_pages() from good context.

Yes, this makes sense. Have you tried a simpler implementation that
would just queue on the lockless link list unconditionally? That would
certainly reduce the complexity. Essentially something similar that we
do in vfree_atomic (well, except the queue_work which is likely too
heavy for the usecase and potentialy not reentrant).

-- 
Michal Hocko
SUSE Labs

