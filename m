Return-Path: <bpf+bounces-50423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6BBA277E2
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A46165CBA
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD1A215F5F;
	Tue,  4 Feb 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuI8osmD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56C215F4A;
	Tue,  4 Feb 2025 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688788; cv=none; b=BozMWOuW1u2YJtnvFVTH7nmT+ELBI06qYeEGTKz/0nu2lwsMFh9uebI7Ro3llPfE47bBEgstbOa7T7hF8AxanF8N6wUbRFUgE3OUZTrdEIJQMbV0ALrXNYqV7S9IOBuurllsGLi8UeGAYfXA2LL7zy8aABb+RCs3cBl/qiwzKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688788; c=relaxed/simple;
	bh=WDK8lnctxaTiLWbUYtoRCHoX+u18i83cVZibWk6TBGk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Bf0m3LfpoJzvopSkq5wIawM64kH8wfisFMPBKWvxKrIspabaCYUm3bc82Sn3N3YfrV4ti0EqGbpYl+o19CZARHqg3zJ78C0Qa0BiNnS73FaXoJo0dAw3G3Dcay/7OTrcJCGeXiUCVwJxb20ihgeUID8byT7vzmN3wxae2abX8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuI8osmD; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467918c35easo86653611cf.2;
        Tue, 04 Feb 2025 09:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738688785; x=1739293585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcHlrhVoZdvwnoHCyGjHi+G6dJq+nu0Bln5b/gbIIRU=;
        b=KuI8osmDRtX0+l6POm9jwunOPRdldr1YQyaBVv52AWH5JxZ8DWyxPp8m/lxomaecae
         g/WPAt1EPc1BTKwrxDg/TST5KbF1Ru1dktaQ4tn6geS6tUxsDbDNrdEQIVsQdyZM/Oms
         sV+Y/YWkEwdo6YF0dyd7esCJrd5gZKeGRD2tTK3Y6w7Ka2cx4f55h11rSC0Uag+HcUMh
         etQdnZ3ylf/kD4/i3AsYy4zFhEnkIzizpOaLFrk1paIP8x9jQv6lgDbVdT+nfEe1ld4W
         8IfervENMqLbcddGacwZeH73E8cOLSs4S7nLIQKes+YNeG7sufDnlcatbiiBawA8kh2q
         Lpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688785; x=1739293585;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcHlrhVoZdvwnoHCyGjHi+G6dJq+nu0Bln5b/gbIIRU=;
        b=dE1EHokCceAE55WDu/EJgOZd/B5YtuxWBFVhIat6Xdho/enQg07qKophd6iLXBz9xQ
         q4JeEylSadzM4sPUAfPk6O/S6eYjNZQEVRBHTPf5mk3ncrp893Ub/J96SDa9bBKgnyWV
         bxOlu+oitVBcrMrm5ezHC7pqA1fT5fDkD8F6cgYSlZkM6jfoLwwNwJcYU56tIIEeR393
         GseHK0JD8R3CM+MVTvrKyca65/wRnmDgvtXURiQ6qBToivMGfKnhz6QotU/fid2V3+C3
         3P4MJTlTz0Uc2qAnHP7etYPMgPrQVf0uTitRl69Gjj+3PHwKPoKAS3utZdGhph4YDWz1
         8A9g==
X-Forwarded-Encrypted: i=1; AJvYcCUIxuUyBT3+OcvHduykx3iFh7S8fUyJ1q1RQ0bLRWkBg3Fh080OaeSWo59bJJUBgRhXSjAq02wC@vger.kernel.org, AJvYcCV30a03Zuh1mGy1G4cwfZBbRbMLkequ3AoLpMtNHQ9yCjzzSdE4sDXEYhakqEp66jsOUWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhceaUaVuYIR28m0Ahzz1wLouOQ88iKV+StpbgUOSibgb7GSC
	xxV3qGT7SriM/ofApQK10E5yBKoZVEXx90nPDgtGgUDYYC+FTmip
X-Gm-Gg: ASbGncssXJXI56bOdUC1Aad0ucd9fiBuHZw/LcbUAg5zqviixG3mVaDeZsjoM0IWrGZ
	yuEayp1Vuy4kp3P6pDllaiz+RTzk0vAi/zlp+mdMtx6Qz6gnzBa4u1JndAMAxV3byz/UCbtPWEG
	y3euy2NjAdLHe5VE4QGL93PMeOY/aKPALJP3+av22x8bPpmTNAkSx6ZBJNhWGEFP42rgp/s4k4i
	OAGutWVOg9jqUfL6z+vDXDi5kp19bs9cZfjwwF6MxW1Soe/kioRzqUtO7jSNYC0KFhkzJCHVI3C
	7kivTHjxvvXP7Fbsx2OPHeQnn6JBdOCFlIBoMpNhULGEoC68sKwoMwxRBGizdTk=
X-Google-Smtp-Source: AGHT+IEl552cRcs13jB1RubNcoQM+r9x0ANH7FdbAlVsDm9ShWr+Z58OUfXZ4LfL+IWqs9AMukJEeg==
X-Received: by 2002:a05:622a:12:b0:46c:7197:7001 with SMTP id d75a77b69052e-46fd0b6ce4cmr406737171cf.34.1738688785535;
        Tue, 04 Feb 2025 09:06:25 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf18a67dsm60939451cf.72.2025.02.04.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:06:25 -0800 (PST)
Date: Tue, 04 Feb 2025 12:06:24 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67a2491090b3c_bb56629464@willemb.c.googlers.com.notmuch>
In-Reply-To: <2706706c-3d85-4f43-ad91-d04bbb4f2b92@linux.dev>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <2706706c-3d85-4f43-ad91-d04bbb4f2b92@linux.dev>
Subject: Re: [PATCH bpf-next v7 00/13] net-timestamp: bpf extension to equip
 applications transparently
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 1/28/25 12:46 AM, Jason Xing wrote:
> > "Timestamping is key to debugging network stack latency. With
> > SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> > network issues can be attributed to the kernel." This is extracted
> > from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> > addressed by Willem de Bruijn at netdevconf 0x17).
> > 
> > There are a few areas that need optimization with the consideration of
> > easier use and less performance impact, which I highlighted and mainly
> > discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> > uAPI compatibility, extra system call overhead, and the need for
> > application modification. I initially managed to solve these issues
> > by writing a kernel module that hooks various key functions. However,
> > this approach is not suitable for the next kernel release. Therefore,
> > a BPF extension was proposed. During recent period, Martin KaFai Lau
> > provides invaluable suggestions about BPF along the way. Many thanks
> > here!
> > 
> > In this series, I only support foundamental codes and tx for TCP.
> 
> *fundamental*.
> 
> May be just "only tx time stamping for TCP is supported..."
> 
> > This approach mostly relies on existing SO_TIMESTAMPING feature, users
> > only needs to pass certain flags through bpf_setsocktopt() to a separate
> > tsflags. Please see the last selftest patch in this series.
> > 
> > After this series, we could step by step implement more advanced
> > functions/flags already in SO_TIMESTAMPING feature for bpf extension.
> 
> Patch 1-4 and 6-11 can use an extra "bpf:" tag in the subject line. Patch 13 
> should be "selftests/bpf:" instead of "bpf:" in the subject.
> 
> Please revisit the commit messages of this patch set to check for outdated 
> comments from the earlier revisions. I may have missed some of them.
> 
> Overall, it looks close. I will review at your replies later.
> 
> Willem, could you also take a look? Thanks.

Will do. Traveling, but took a first quick skim. 



