Return-Path: <bpf+bounces-71824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B6BBFD7DF
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 19:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BCF4054B0
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA70359FB8;
	Wed, 22 Oct 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbnN3bDQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44B35971F
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150517; cv=none; b=mOyd3fJijt+DJ5Ki/6KWvA++wRV/kpoSxLknBXX/8flQuVPyjygO6wyoVGWiPRONfUqF9DEiY29vZk+p9IVnUcIkXNN2S12z1ZBuGodxwdidnE2RHCMjqNFyOz1/9pBqCAxetWfdQ3xfl8aLlrhwrDG70HjCjF22aByi6S2iOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150517; c=relaxed/simple;
	bh=jz2HdK0Ih54fb0mhqTghzLrg/4rLGwrJQTQBb9v8lPk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na+dC5KC2oWEoqj5N0ZlUdxl1HZxkIluLhpDBLP5PqhlJTRPncEFeDPVtaFw9pVHzvraJ66YFOgX8FAgxWE9Ni21TRL5MzDeM182kdP7IUGFaorw8N/RZamk1AjxDkueeXINPI8aO3y2g9/mni/z3Mw/iTwnTlcyJsnQkOiOKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbnN3bDQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so6177687a91.3
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761150515; x=1761755315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vWDPEez/Pn/tuHveZVqlQ/l+YWt3ZfTtD2FdR44qSs=;
        b=IbnN3bDQCMng84tfaYf8jItC/PSyvEkFfZzNf4NhnVPBVjsciOVlugbdWSfHhQvB5a
         fTbNMTgHqZwxMw08jciI0/skm5YpTev61XQRrTU/YoRr+gB0xVQ/cUWgT2dwI5CUSGB+
         rR4MQZ6H1tQxycU72LMiTK3lGXZQolevZcgfiWXS5my2T+fN0vn8PAArqUXdhM11MwE1
         Sb/lPodwPILzmjfsym29OikRmfsLGkqirnpsLjAOaz4/FpLMFulIWrpGJk2goF4aS/Pb
         4dbv/txJrn59jJe8pa27aRd5AhSnaW37TUxJLW01QKbda2LPAsiCOBfy8c49IXic//Hp
         8OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150515; x=1761755315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vWDPEez/Pn/tuHveZVqlQ/l+YWt3ZfTtD2FdR44qSs=;
        b=O6GqsEDIbXCkWplf7VnlUNMmNehij6B6q6t3Mksw+EBztsEhaLFEo5z5WCS6Obfbac
         vc+gvHPlecDnv8ZxP70wUf8T7zZ22Fymr+UTV7BIzXkp0H3vYhV5eBB8Iq28jVStnUcs
         Kph3DyEBVf5SLyirYqLavl7MMMpwh+9bJtVOMxVEz847zo1alXgyd6SCeeJhhwZ69q0o
         ZrKBgrD4shnFIG5pdvhLIxYonAWaF+W1EXu+tp7wNS2StwqOw6DVsDMyjWXWtczSyP/c
         kZFR54QbFPVfx6Lq/DaWymovRltejebUOGdUSMAPH093VMIozIRhZ1oLtF22wOG9fNZM
         w33A==
X-Forwarded-Encrypted: i=1; AJvYcCWxt94r72QPOLDv0soNMeC73qpgBgd0dGDsdC+wpQoHtd2bbK8/ZAhv0kjj88NNPBD0IyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKu8EgjgPpcUetedJ4pHV09FGLs3K42hIhetLUx/c+NEYAFzA
	xbbBdkRO0a5Bk+SAgtnaLjrjXE2ONvlyrsTJaQq4RESg5fltPRdPnfB9
X-Gm-Gg: ASbGnctQNMqpbIvVNOftyIAFa0BGkwOy8doM5pfHMTdQF4qNP3tMmjzjf+nPjvZqFyI
	6MADX857LK8zybyNP6JJIL7xJHdUDCmuTCgfGqfAXFPLsel01M7bU2s+GXt3qs02ANqYhYI9cmb
	ARbBo/Wx/QKMAeuOBmk9PPvMgoLM/i+pW8nif8b4lnAQgVTNs4zXoVf0MKe99/huNU0JvgC0yiv
	1b78PTR/Wch40699stTzYUpmLnplgk0x1j5617Z0hSzy/inP1kLkvcdePxbvOCz7aU7pDBIBp14
	nWsenGvw2pJ9U53TFir2wmBMe3t3L3UFd84DADzcpZoVNXWLQJMXCi2sIGALa1zFFJ/gN48PxhW
	GMEvGEKuos6DZcXFCRVhH08blaYs1cSb9XJM7+uKik7RLHsd7M9o0sQq496ipjMNdugh5gGRUfH
	qQyXo=
X-Google-Smtp-Source: AGHT+IHusUArV++0TfBaUizLya7hy6xUc0z7VcX1xC32O50I38HzPymcYuHT2IKLOX0EfF4dDywsEQ==
X-Received: by 2002:a17:90b:4c92:b0:32e:32f8:bf9f with SMTP id 98e67ed59e1d1-33bcf8f9960mr25809884a91.30.1761150515038;
        Wed, 22 Oct 2025 09:28:35 -0700 (PDT)
Received: from lima-default ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm3041328a91.3.2025.10.22.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:28:34 -0700 (PDT)
From: Your Name <alessandro.d@gmail.com>
X-Google-Original-From: Your Name <you@gmail.com>
Date: Thu, 23 Oct 2025 03:28:26 +1100
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Alessandro Decina <alessandro.d@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aPkGKqZjauLHYfka@lima-default>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
 <CAL+tcoCwGQyNSv9BZ_jfsia6YFoyT790iknqxG7bB7wVi3C_vQ@mail.gmail.com>
 <SA1SPRMB0026CD60501E3684B5EC67F290F3A@SA1SPRMB0026.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1SPRMB0026CD60501E3684B5EC67F290F3A@SA1SPRMB0026.namprd11.prod.outlook.com>

On Wed, Oct 22, 2025 at 05:41:06AM +0000, Sarkar, Tirthendu wrote:
> > From: Jason Xing <kerneljasonxing@gmail.com>
> 
> I believe the issue is not that status_descriptor is getting into
> multi-buffer packet but not updating next_to_clean results in
> I40E_DESC_UNUSED() to return incorrect values.

I don't think this is true? next_to_clean can be < next_to_process by
design, see

	if (next_to_process != next_to_clean)
		first = *i40e_rx_bi(rx_ring, next_to_clean);

at the start of i40e_clean_rx_irq_zc. This condition is normal and means
when we exited the function - for example because we ran out of budget - 
we were in the middle of a multi-buffer packet and now we must continue.

If I understand the code, I think that in that case we just set
entries_to_alloc to a lower number and return fewer buffers to the
hardware. 


> A similar issue was
> reported and fixed on the non-ZC path:
> https://lore.kernel.org/netdev/20231004083454.20143-1-tirthendu.sarkar@intel.com/

This is indeed exactly the same issue, but I'm not yet sold on the
diagnosis :D 

Ciao,
Alessandro

