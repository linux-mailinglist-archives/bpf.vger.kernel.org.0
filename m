Return-Path: <bpf+bounces-64537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5D1B13F58
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55729189AF24
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA8273D7C;
	Mon, 28 Jul 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4gRajOp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6426FA54;
	Mon, 28 Jul 2025 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718396; cv=none; b=q0CVSV12QdGUuexc2cZiiABB5LojgEeTcuiLK5WmGIZ2VQ1sw5NAmSF0+xAH85+38S13zlOwZdxxmfwIu5IMvFchcdmGTKC6NSNt2DE5T0zp7FEEBiUBUhbHD3BD4UR9HzK7eAsnn5gbgtQL/CWU8fq5ubXw+kB6uFjG2oupYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718396; c=relaxed/simple;
	bh=dNfaG4D18D9CjOcgvaBVkHp+jyn6+cieep0hDJfD19Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrJESwKPEa0rXCvKmBm4WOHylWkpKo/d0agB82Oy89HnZi6m0y1EpUhYa/gIMWg/h95rhIe4i8AV62bov3oIYUiiOzCESlOxw/+nQIHZmX3yBZinh7rIf5rds2MJ+KZDdgCGOtnO/dh3OdqmaFuJ930vimR8/eJ7fFHyvUniEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4gRajOp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b77b8750acso40948f8f.0;
        Mon, 28 Jul 2025 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753718393; x=1754323193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjx13zWedBGyIKTA7New5uvsNC41+GLmdqfifANAW9s=;
        b=M4gRajOp4eeMeIzpjNSQTJeWyACt8shsG7rWBYSkLTtc7FRTlJqZzuAt9dqQYjfEv7
         0sNy3tONzt+WkZlDodMI5iVgwdSIh0JDxiTmUfsmOPyRQhfPWir1mlw8Ba8M/k/v08VF
         29C3KtKr40MSYSKcBVscL8jygzP9X3wa6I8SLWBBFjnw9mHbOT883nsWr3miFT68hRxq
         Moc0se+Vn1axtPzAYfpvZqff5HvakzJMFR8o5xTqx8XeU6EAFHc8X8RvRAJB/s3Xu0mz
         q723Zkj6AtdRVhYdRvCG+ckTflW3Iywi/iyRpKJlLxDbPze3ut1LxKAR5FDetu78VE3v
         WveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718393; x=1754323193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjx13zWedBGyIKTA7New5uvsNC41+GLmdqfifANAW9s=;
        b=b6U20+3rloIGgCMsonNkJieQM32mohG3/AH6nGhZoHvaukQPlIAmBc1IciB+GyUV/e
         SDndWmrLI4O754MZZlStZ2eyScHBSTcGM/CiqmTZTse0fF21Ru6UU8KOeto872sC+YHr
         0d0h9VdKD+vXYWg3fgL9JAkhddEs5wGSa7XZAAQH0OVphP1DmLgB5U+ri/iBFfXJRbU4
         L8D31sQCmQiE340XCDUv2YDS2lBW+22D77qMisWhZzfcsF8Sqq1TSWgAU+y1GWO7BtYH
         34F4+cVSTFlTQpKFLgSSOL+CsdHQ7jHX6KtsBS997TvxQx/r0I9RtFyrOQ24yNmns80l
         s2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6UkOjkVnZYA85YH2mqtqSJMIKma8V42gDl62Vzervele6hx/+feIDM9iRPUhelO5miJ0=@vger.kernel.org, AJvYcCWBWkVt89awKuBLE6ESIZJkdffQhuk0RFJb1iUtyj9JwZKzzG3O1AhRN26XgKuYyize7sVyORwj@vger.kernel.org, AJvYcCXIdTlachE6OTjyeM+jk1E+tZUJrrRpZNLOxcT/dj0qCJ3FUFe8WFR5Yq7TMHK3ElvKsfeaM+RBw2tjonMvdRwV@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqxEo/lcs9NXf8WCCXUJjWVRKen+lW3mhActb/qlk/JoI4A3a
	F2/BvRJO+IlbE025VqGF2LzdiC0sJ96vw/wasFJ4/JUpAy6ffUDbKnPG
X-Gm-Gg: ASbGncvm2FU2CJSIeD9BD7NbSSXyh1wU5NCUIPS8bhUWWjtZMT+VUaxg8PQ+E+25Prd
	bqx7W7Erg/Wy5ES02NpOGyzwdcVF+eG7yHJoE3Ug4iHI8L977k5gZ5suEHJtsQgRtG8oOROjIlZ
	lBGZh3pgmhu/UpJRRfwq/27WgzG5h6J2UlKdbAyWthpvVAF+SWesOTVKq7bpQuSFysw4vmBuiHm
	70/bS+VRDgC/Rf0WgxTNhE/IVW7U7O6rv4eWLbJnzGtv/Xqu/lZoYZ+JK/RsaNTBjQFvPuNio4l
	qkY+8VCtMi6CodxVLhCQ/Ev34COQF6Z5YiDQx2fyjUMFDHWzpqqHnAXrekayXYJqlBmiBWaviDM
	wGE+I+W+TtrzrZ31KGj/pWvTIrY1DHpCFuTnTrsqDBrZXr9KWwlf2NNlVMzkHYhGGGA==
X-Google-Smtp-Source: AGHT+IHt942cS6W+rTZ71qArgtk78wyYddcCFyLJ6WkmhpsfPuo0O6TXSbk1FwgDtS4bjvFjnrZW7w==
X-Received: by 2002:a05:6000:459a:b0:3b7:76ac:8b9f with SMTP id ffacd0b85a97d-3b78e60fa69mr61150f8f.25.1753718393105;
        Mon, 28 Jul 2025 08:59:53 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f04009sm9336711f8f.38.2025.07.28.08.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:59:52 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:59:50 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: lkp@intel.com, alexei.starovoitov@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, coreteam@netfilter.org,
	daniel@iogearbox.net, fw@strlen.de, john.fastabend@gmail.com,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: add icmp_send_unreach
 kfunc tests
Message-ID: <aIeedqGvdfO641Ht@gmail.com>
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <20250728094345.46132-5-mahe.tardy@gmail.com>
 <356fe0b5-b66e-475b-b914-919339bb441a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356fe0b5-b66e-475b-b914-919339bb441a@linux.dev>

On Mon, Jul 28, 2025 at 08:40:49AM -0700, Yonghong Song wrote:
> 
> 
> On 7/28/25 2:43 AM, Mahe Tardy wrote:

[...]

> > +
> > +void test_icmp_send_unreach_kfunc(void)
> > +{
> > +	struct icmp_send_unreach *skel;
> > +	int cgroup_fd = -1, client_fd = 1, srv_fd = -1;
> 
> Should set client_fd = -1? See below ...

Well spotted yes, it's a typo, thank you.

> > +	int *code;
> > +
> > +	skel = icmp_send_unreach__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +		goto cleanup;
> > +
> > +	cgroup_fd = test__join_cgroup("/icmp_send_unreach_cgroup");
> > +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> > +		goto cleanup;
> > +
> > +	skel->links.egress =
> > +		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
> > +	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
> > +		goto cleanup;
> > +
> > +	code = &skel->bss->unreach_code;
> > +
> > +	for (*code = 0; *code <= NR_ICMP_UNREACH; (*code)++) {
> > +		// The TCP stack reacts differently when asking for
> > +		// fragmentation, let's ignore it for now
> > +		if (*code == ICMP_FRAG_NEEDED)
> > +			continue;
> > +
> > +		skel->bss->kfunc_ret = -1;
> > +
> > +		srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1",
> > +				      SRV_PORT, TIMEOUT_MS);
> > +		if (!ASSERT_GE(srv_fd, 0, "start_server"))
> > +			goto for_cleanup;
> 
> Otherwise if client_fd = 1, goto for_cleanup will close(1).
> 
> > +
> > +		client_fd = socket(AF_INET, SOCK_STREAM, 0);
> > +		ASSERT_GE(client_fd, 0, "client_socket");
> 
> The above two lines are not necessary since client_fd is
> actually set in the below.

Yep, must have been a leftover from when I was discovering the
network_helpers, oops!

> > +
> > +		client_fd = connect_to_fd(srv_fd, 0);
> > +		if (!ASSERT_GE(client_fd, 0, "client_connect"))
> > +			goto for_cleanup;
> > +
> > +		read_icmp_errqueue(client_fd, *code);
> > +
> > +		ASSERT_EQ(skel->bss->kfunc_ret, SK_DROP, "kfunc_ret");
> > +for_cleanup:
> > +		close(client_fd);
> > +		close(srv_fd);
> > +	}
> > +
> > +cleanup:
> > +	icmp_send_unreach__destroy(skel);
> > +	close(cgroup_fd);
> > +}
> [...]

I'm sending a v4 with those fixed + fixing the builds error when IPv6 is
built as a module from the kfunc patch. Thanks for the review.

