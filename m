Return-Path: <bpf+bounces-45384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5F49D4FF9
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC60AB22AC2
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7344515990E;
	Thu, 21 Nov 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwuXH+Qt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625AB2AD00;
	Thu, 21 Nov 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203796; cv=none; b=Wm/fgrKTwdet2T8HmWVaAl5XTahMgvqlS2N6Zi0dGmcmaf52rAHyVQUaRt3tDh4H9pqP2u/1qP55doF3b7iHQZtOQ157lETW3N5TomfrZDKwrQbHHquCCy4q30ZNbhqZxVPi+Ob7bbT2Im2Zz2svzuywo8bYkcZzaMmaXruFP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203796; c=relaxed/simple;
	bh=O6oHHuEIbcIb6IByxG1z9a7cqD2dBudeztiOVftgRJ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TaMg1p8lntYLzGb9DWu6tcPohAtDNC/pft5qXDtvEWnKm27a4KmJeGYdeH5Jsscz4FO/FRG5W7Y2CH5Rn1x/+F2U6LuhniCzm9rqb56GzJUv+KqWRiv9MVigekgX4/BPi/MHE1Ewl6OQQUE2HKqQu4wp0NMn0Q3S1cpWRiBbS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwuXH+Qt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b152a23e9aso60976685a.0;
        Thu, 21 Nov 2024 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203793; x=1732808593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXs5fvPbgQTUo5pXWl788SZLxX0Pftkx5hC6S+lzBco=;
        b=FwuXH+QtR63OFcwd1+YiKGYGrc4j+6bkEYunn0sWyj48cly14WLwWxX9SsG/WP4uAV
         G39vwlVJy5KlFYpKE7C2qlyE7ufH8648PCnqL1Y2YR3urHVVdcU6gUwjHkJ5iXMtDzNm
         Xl/vgvfVETYvHyfifiy+UN+CRDw97s9Z2sKeDq4RH14GcA2I/zdOf05MlKO78ICKOGKQ
         0LM3qh9mUHNLPlSLxjHkVsPWuih70Quv73E5qx/it6Hbt9hVGZKf7gh2gPJU+a1UPUui
         hr2rvo+nYbhP6tYG3SxtlVD/3dNEWtOtPYDb+lRgoaJvnCMwm5HwuvafzaFv4nI8qEdd
         gf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203793; x=1732808593;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXs5fvPbgQTUo5pXWl788SZLxX0Pftkx5hC6S+lzBco=;
        b=N5P3LFD8mdvY2JMv6jAiA6ZTHbOClUeQ85n5lzEmHvXz35lEJ2GgL0NmZI+M8YSyaa
         3cA0+2hnc87qHatGwgyjFFeXpo1NCX4oRJJBYpf1DvsMFIKn8gdx+39vXzSYEgtLKz8x
         6I1I8nJm7W8rV8Z7OP2qHhMXbIJpZ9EngDo2vmyoA5yxkonvwCeRd1pD2XG6tO/FRPtW
         Rv6wRkM4386WazzXCe6lAFm/V18eLUflkeH299uEmNz3NkJ6jqKMPuV3q9s8GC66oxcL
         2UFjYbXxOD2Px8WNkpJAIrD8r/Vw4fXExv7Eek3wyC7G2/66k60MER5xRLDWHO5/d4sK
         Vo/w==
X-Forwarded-Encrypted: i=1; AJvYcCVlDKIRdNBawTLdhzqEtf1maQ13ToaTuGPKtWudyAKuDdW9IdrPEZPjc9XrGLiPWN0eABjGgYjo/d/0Z7G4@vger.kernel.org, AJvYcCVqjfehp7YRAdQdcs+p4f6ysASzwmdEo9ZZ+2p8bl1fWk+CPwg6PIIU427D0sVkNjRPdhM=@vger.kernel.org, AJvYcCWlQ9U9eXyUqcTQsSIfNh1Tfl6cU1HAwdzy0NfDZSUZHbQdARFPhEVLBGh7q9phd7EmIPYrJYEl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzd0wfWjf3u9QEuNd+Fr+ZlKHprk6g2d+OClh6HRv5WGwPkNn9
	rlAibIdb1P08XcmIXr2QiS4xhHPMZDsoHjFebSOjhiR0VTrXWPS7
X-Gm-Gg: ASbGncsjJQeYV0EPsVYyVJTOF8IGX1OqWrNSZpxJPMiBKW7hJKBPn6wRqSxpHb5vaVu
	P1c79jJO0gmcTbh/0pRCCp1FB/nh02n4o0vL+7uN6kfu5Oewpj3NVyUMTHvqYPDkMVg4Cw1mkhE
	LUxjMz4a2Sp1ajcYbt1nEhpN3uJ3WLeeNW2YfEOWxrvTUWhoWXgykcvEFzVYxwFTBvFSgvjM62j
	NikSPzc8z2ZVPChkhl1MiTAKIXt4kG2Hfi/IL8mPNMemUPqUtf7yi5zczNL8WyM14BnD8d1Ef1d
	HLWIOXAs5BluBNv1M6WaBQ==
X-Google-Smtp-Source: AGHT+IEoLKAzw+CSypvu/7v9DDR+mVYQ1Ps93lRD3TmJQ1SN2pV7s1zmjvjvkvTT1ZKElntCcmpEPw==
X-Received: by 2002:a05:6214:19ca:b0:6d4:19a0:1fa with SMTP id 6a1803df08f44-6d43781ce87mr106062356d6.29.1732203793172;
        Thu, 21 Nov 2024 07:43:13 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380d7cc2sm24916746d6.40.2024.11.21.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:43:12 -0800 (PST)
Date: Thu, 21 Nov 2024 10:43:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <673f55109d49_bb6d229431@willemb.c.googlers.com.notmuch>
In-Reply-To: <6af7f16f-2ce4-4584-a7dc-47116158d47a@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
 <6738babc4165e_747ce29446@willemb.c.googlers.com.notmuch>
 <52650a34-f9f9-4769-8d16-01f549954ddf@intel.com>
 <673cab54db1c1_2a097e2948c@willemb.c.googlers.com.notmuch>
 <6af7f16f-2ce4-4584-a7dc-47116158d47a@intel.com>
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Tue, 19 Nov 2024 10:14:28 -0500
> 
> > Alexander Lobakin wrote:
> >> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> >> Date: Sat, 16 Nov 2024 10:31:08 -0500
> 
> [...]
> 
> >> libeth_xdp depends on every patch from the series. I don't know why you
> >> believe this might anyhow move faster. Almost the whole series got
> >> reviewed relatively quickly, except drivers/intel folder which people
> >> often tend to avoid.
> > 
> > Smaller focused series might have been merged already.
> 
> Half of this series merged wouldn't change that the whole set wouldn't
> fit into one window (which is what you want). Half of this series merged
> wouldn't allow sending idpf XDP parts.

I meant that smaller series are easier to facilitate feedback and
iterate on quickly. So multiple focused series can make the same
window.
 
> >  
> >> I remind you that the initial libeth + iavf series (11 patches) was
> >> baking on LKML for one year. Here 2 Chapters went into the kernel within
> >> 2 windows and only this one (clearly much bigger than the previous ones
> >> and containing only generic changes in contrary to the previous which
> >> had only /intel code) didn't follow this rule, which doesn't
> >> unnecessarily mean it will stuck for too long.
> >>
> >> (+ I clearly mentioned several times that Chapter III will take longer
> >>  than the rest and each time you had no issues with that)
> > 
> > This is a misunderstanding. I need a working feature, on a predictable
> > timeline, in distro kernels.
> 
> Predictable timeline is not about upstream. At least when it comes to
> series which introduce a lot of generic changes / additions.
> A good example is PFCP offload in ice, the initial support was done and
> sent spring 2022, then it took almost 2 years until it landed into the
> kernel. The first series was of good quality, but there'll always be
> discussions, different opinions etc.
> 
> I've no idea what misunderstanding are you talking about, I quoted what
> Oregon told me quoting you. The email I sent with per-patch breakdown
> why none of them can be tossed off to upstream XDP for idpf, you seemed
> to ignore, at least I haven't seen any reply. I've no idea what they
> promise you each kernel release, but I haven't promised anything except
> sending first working RFC by the end of 2023, which was done back then;
> because promising that feature X will definitely land into upstream
> release Y would mean lying. There's always risk even a small series can
> easily miss 1-3 kernel releases.
> Take a look at Amit's comment. It involves additional work which I
> didn't expect. I'm planning to do it while the window is closed as the
> suggestion is perfectly valid and I don't have any arguments against.
> Feel free to go there and argue that the comment is not valid because
> you want the series merged ASAP, if you think that this "argument" works
> upstream.
> 
> > 
> >>>
> >>> The first 3 patches are not essential to IDFP XDP + AF_XDP either.
> >>
> >> You don't seem to read the code. libeth_xdp won't even build without them.
> > 
> > Not as written, no, obviously.
> 
> If you want to compare with the OOT implementation for the 10th time,
> let me remind you that it differs from the upstream version of idpf a
> ton. OOT driver still doesn't use Page Pool (without which idpf wouldn't
> have been accepted upstream at all), for example, which automatically
> drops the dependency from several big patches from this series. OOT
> implementation performs X times worse than the upstream ice. It still
> forces header split to be turned off when XDP prog is installed. It
> still uses hardcoded Rx buffer sizes. I can continue enumerating things
> from OOT unacceptable here in upstream forever.

I was not referring to the OOT series. See below.

> > 
> >> I don't believe the model taken by some developers (not spelling names
> >> loud) "let's submit minimal changes and almost draft code, I promise
> >> I'll create a todo list and will be polishing it within next x years"
> >> works at all, not speaking that it may work better than sending polished
> >> mature code (I hope it is).
> >>
> >>> The IDPF feature does not have to not depend on them.
> >>>
> >>> Does not matter for upstream, but for the purpose of backporting this
> >>> to distro kernels, it helps if the driver feature minimizes dependency
> >>> on core kernel API changes. If patch 19 can be made to work without
> >>
> >> OOT style of thinking.
> >> Minimizing core changes == artificial self-limiting optimization and
> >> functionality potential.
> >> New kernels > LTSes and especially custom kernels which receive
> >> non-upstream (== not officially supported by the community) feature
> >> backports. Upstream shouldn't sacrifice anything in favor of those, this
> >> way we end up one day sacrificing stuff for out-of-tree drivers (which I
> >> know some people already try to do).
> > 
> > Opinionated positions. Nice if you have unlimited time.
> 
> I clearly remember Kuba's position that he wants good quality of
> networking core and driver code. I'm pretty sure every netdev maintainer
> has the same position. Again, feel free to argue with them, saying they
> must take whatever trash is sent to LKML because customer X wants it
> backported to his custom kernel Y ASAP.

Not asking for massive changes, just suggesting a different patch
order. That does not affect code quality.

The core feature set does not depend on loop unrolling, constification,
removal of xdp_frame::mem.id, etcetera. These can probably be reviewed
and merged more quickly independent from this driver change, even.

Within IDPF, same for for per queue(set) link up/down and chunked
virtchannel messages. A deeper analysis can probably carve out
other changes not critical to landing XDP/XSK (sw marker removal).

> > 
> >>> some of the changes in 1..18, that makes it more robust from that PoV.
> >>
> >> No it can't, I thought people first read the code and only then comment,
> >> otherwise it's just wasting time.
> 
> Thanks,
> Olek



