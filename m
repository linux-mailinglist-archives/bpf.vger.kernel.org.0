Return-Path: <bpf+bounces-69633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08909B9C5C3
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6786E4C09BE
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F40E28D850;
	Wed, 24 Sep 2025 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRfjKh/O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D922DFA4
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753096; cv=none; b=EXXt1Wh10gCOQ18qY8LrYtoDnLpu5QGSS9F/e8gVTdiAkg0J+hFIJM2M41KNkcaw1ZSfe6BPYpconFYS9a9DorTKphICCwxXttbjPwSh5OeTEsjogn98u6z80CDcIr3iFXsDfZ2cIRwL5cjXbgLcUZa8NIhZmzwDpqn1GPz4M+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753096; c=relaxed/simple;
	bh=E3mp818XeEDGifzwzdOnw8G4qn3w2nYXo2kiXHXmH1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJbHLHFK01kOpGnAcUZXo+phONCB03/ezmxmh2dNvJsmEEy0W1OiiPTEMMoJT2HZxq7BT7aJe7ujdgQ9wFwplEpU0nvA3qDAP1UtblLKNZTpvT7Wf8GG5avoVvea5YAJ7Oc8vL8AUVAvRRPt7FLu8SFHjWp6Fl2mclupwalZ69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRfjKh/O; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2697899a202so11915425ad.0
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758753094; x=1759357894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWJ481WqwYt03Qs8yEQYxXt74IruS1KgxQpyoMD3fOU=;
        b=SRfjKh/Oa3qxnxurXBHLFYIKs7j1n9CLuhpwWHyYUxayMNFcNQVXm4ZASByYSs9Lbk
         UT1NcZXphV3AcX1QZwHuB+i0IQxjOHFIGekrxQeZ/k9qIlf4pvJSlt2Frf+XtH3CpO7M
         8kbiBObSyIDfnpr/7/A3T9TztmBRgfKYvoFRtGkm877SIQWugPpJBRRZtqVwXw6dKEK/
         pPfLTqVhpueuVrrB21n8NBKHfE6Lyvz4T10wCpJit5xP5jWQxjZIatn6DLt1pjcqAVis
         KMGYztjABG5OSGd+81koCGFMBFGIIDqCI2YGpjTPXXfh8jO890vihlBAdjDIFjTC4ywg
         KL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758753094; x=1759357894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWJ481WqwYt03Qs8yEQYxXt74IruS1KgxQpyoMD3fOU=;
        b=eLmRPVFFdE19L9OaXZqY7m2hrOBZw9sF6DB0SZs19KKkF0R+0QArxEZy5kap5Nwk77
         gQp80SpfeuHI1AgbHYYyGfZbCCIzv6TihG5r3joymZPST6LkHkDc9Uc9aBwHefMY+s1X
         0nuQyhfSnxp/gHiOuObVtqPJJ9D+i3lnaFHzVwLjVgx9EZF/WN/L9gXHDTcvNDAXKyln
         12IDCftKakktowwLmkMMvtsqN/ehhjyokyRU5AvorHRB4iXqGMGrxgWmBuxp80JClgD8
         cLo06xT8cqCjxFvfCFBGwnn8xXkbl+viKAhi60g5RigLJL3ryqljTRJon1xLrCoA4oVh
         VLSw==
X-Forwarded-Encrypted: i=1; AJvYcCXYTToeM+TJwQmiZPt+h4qiYgu6vmAsZmp35GxPX8DxrXvs6E2F+4eXkC8vDYXl6BBD8nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03GQ1Uc8IAPobV1DaXfhz80MLV/0VfTBzXqeYyHjfzcIXkgvi
	SkLUKNQ6ivOZhqKRPk9BdjiXQ1A0JMKVvuSM5OnOZsOB6SYGNlaX+/E=
X-Gm-Gg: ASbGncuwxdwEVAar/MqD7LS/+gpa/7gp1QYVCvr1fLiuWTp3FYTJ30NplvJLQrS7e2Q
	dgx5orQ+J2EKqC2tZdEwc3mZRny6mgIOXuPf+KlFJVRcF4/oj8QRTmGbyoi7Uy8fI1mbo63nV4u
	rJsN/FCqb6Pb8RgofdGNrs35+II7TCU/WUBqeVjxxj3e/XiPT27wV4SbOZuIpRUkGXCTN3wkkAg
	Llr1BULXwqsrkoa9ujEC3wDZmrhdSr12ryzKUKx2GNAw5MW/UjJnf65RRYBR+XvyRfj7ER7vKHY
	EC8F9nQTo71NFbTGbhYJfQZfDtnUfh9E2E/H71EFWLDvRtCQIfhqFP0zUjxO41cKv0wE7+a2psF
	Uk35exIGEuyOsM1RKBQbPJwc2/Rc/7W0PO++49lfQVp9q0sbJX/Pz6mIzPW1OiFaKu9eIDz0S7Y
	hzyGNIXzOgTXOF2Zq7Q4DKxOqUjCv9mIemCjVBMOsmYYMtBJs9lZEUBFySasm4dL5MBJaly3SVn
	yhv
X-Google-Smtp-Source: AGHT+IGqXSUCi05Q6A/shBANKJJ+7L6thhmdeK778FmwuGU+D6HEICoXlQ65iZTp1I/QU4cKU7BZPQ==
X-Received: by 2002:a17:902:8210:b0:267:44e6:11d6 with SMTP id d9443c01a7336-27ed6aca024mr3396525ad.6.1758753094437;
        Wed, 24 Sep 2025 15:31:34 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27ed6886f4esm3083585ad.80.2025.09.24.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:31:34 -0700 (PDT)
Date: Wed, 24 Sep 2025 15:31:33 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com, andrew+netdev@lunn.ch,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, matttbe@kernel.org,
	chuck.lever@oracle.com, jdamato@fastly.com, skhawaja@google.com,
	dw@davidwei.uk, mkarsten@uwaterloo.ca, yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	horms@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
Message-ID: <aNRxRRSfjOzSPNks@mini-arch>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
 <aNMG2X2GLDLBIjzB@mini-arch>
 <f103da72-0973-4a45-af81-ec1537422433@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f103da72-0973-4a45-af81-ec1537422433@gmail.com>

On 09/24, Mehdi Ben Hadj Khelifa wrote:
> On 9/23/25 9:45 PM, Stanislav Fomichev wrote:
> > On 09/23, Mehdi Ben Hadj Khelifa wrote:
> > > ---
> > > Mehdi Ben Hadj Khelifa (4):
> > >    netlink: specs: Add XDP RX queue index to XDP metadata
> > >    net: xdp: Add xmo_rx_queue_index callback
> > >    uapi: netdev: Add XDP RX queue index metadata flags
> > >    net: veth: Implement RX queue index XDP hint
> > > 
> > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > >   drivers/net/veth.c                      | 12 ++++++++++++
> > >   include/net/xdp.h                       |  5 +++++
> > >   include/uapi/linux/netdev.h             |  3 +++
> > >   net/core/xdp.c                          | 15 +++++++++++++++
> > >   tools/include/uapi/linux/netdev.h       |  3 +++
> > >   6 files changed, 43 insertions(+)
> > >   ---
> > >   base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
> > >   this is the commit of tag: v6.17-rc7 on the mainline.
> > >   This patch series is intended to make a base for setting
> > >   queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
> > >   the right index. Although that part I still didn't figure
> > >   out yet,I m searching for my guidance to do that as well
> > >   as for the correctness of the patches in this series.
> 
> > But why do you need a kfunc getter? You can already get rxq index
> > via xdp_md rx_queue_index.
> 
> Hi Stanislav, When i was looking at the available information or recent
> similar patches to populate the queue_index in xdp_rxq_info inside of
> the cpu map of an ebpf program to run xdp. i stumbled upon this:
> https://lkml.rescloud.iu.edu/2506.1/02808.html
> 
> which suggests that in order to that, a struct called "xdp_rx_meta" should
> be the route to do that. In my navigation of code i only found
> the closest thing to that is xdp_rx_metadata which is an enum. I tried to
> follow was done for other metadata there like timestamp in order to see if
> that gets me closer to do that. which was stupid with the information that i
> have now but for my lack of experience (this is my first patch) i tried to
> reason with the code.So yeah, since xdp_md is the structure for transfering
> metadata to ebpf programs that use xdp. it's useless to have a kfunc to
> expose queue_index since it's already present there. But how would one try
> to populate the queue_index in xdp_rxq_info in cpu_map_bpf_prog_run_xdp()?
> Any sort of hints or guides would be much appreciated.
> Thank you for your time.

I don't really understand what queue_index means for the cpu map. It is
a kernel thread doing work, there is no queue. Maybe whoever added
the todo can clarify?

