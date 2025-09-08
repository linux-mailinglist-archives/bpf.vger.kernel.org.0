Return-Path: <bpf+bounces-67763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF573B4976D
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DDC203C6D
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B630DD0C;
	Mon,  8 Sep 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUhqFkq1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9971F7569
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353315; cv=none; b=nrbp4Lkw4Q7lLwZqXmjlRlYXp5GPHe1St0GMdHnTNHx//q1kEQz8Wt20VAfIcuWaTau3rhun7OXHmK5QlsPKM1KQF2aQH5SkNOW7RUmHvtKMvzCEcc2xhPODFU5n9GhsQ8lihOFiTgjjIaedERrX/w7HxaK+ws3ScX0Mq1t6MBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353315; c=relaxed/simple;
	bh=zHM1rVps4zTpnKeQHJEkJtIwWStr9Q0kzHUdWHMSi6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoKp1ZoTCVcqp5u6znTUsaVubRvmfTZNkZ+JI3WpujS7eW2f3zjXtAA6NyBV6K1F9IThIiWvMgSCGV0+Hvwvw01p1hc7wdaYzLCsgqJ5IWTvf9YhePyF2B/yu2qs80ivtFok5BACvpcpRBXMID01etHKuuZYLwaa6606PvJ+vQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUhqFkq1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e4aeaa57b9so2231586f8f.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757353312; x=1757958112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUHvSMxY4LDfvlZDBq22Lh12fisKERtTUBvL8p6/HkQ=;
        b=BUhqFkq1C377xo2PAY0uwrGBT9qYjmNIMmbqP4X1aEcnPf6W7r6DrK0HXxu+KZw4kh
         IqTb81lFO5TNfXDB2gcUv1yef2C9LLzgXQSHLOZdRbs2nQgrbRc6BhqRb367xAzlFfns
         GgUyGzt1R2B4sliiP96rh1gI2NoAMaFqaCLZVaF0mO4JuetO0U52wqp6Cgwk8c7/Tf2R
         0e4ympct0j25CErrXPTrH6nBH4tLeNDplF8hmv8O+NL69WWpHAveAW7KCR1nJqYr2pQk
         /+DP1PJ+RxdTyZiLTdcQYeA9hbgyT0kk1ninG6xiGLsJ4q+MzAc62JRs0B5WdiAzQhs2
         sw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353312; x=1757958112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUHvSMxY4LDfvlZDBq22Lh12fisKERtTUBvL8p6/HkQ=;
        b=TuXVWWDxsoxF/CV4rTn8Gxz78wP/3uSnxj+OYHBxqQSHOfj6AeGpCiFucHsozfYTF7
         N1wcvFschUSBADh4fvOcJR9+2HdVId7KdljV5Usr6cWXA9vEQi9Lx+PjQ/PJsP0/1TdO
         zf565M79lZXUwZm2Jra991klmFBsAmHtjvxr3PSfQ7RxfpnIBF6he1R4Ud3bBrgS9Djp
         McwrijfNh+m4CuR206YFPlKti4d2LY27ibERnU5hj2X7PkeaYwousIyWOrkxDZr+cs+J
         D1x4y1sY2HKjILUlVaoYpGtldcT0WYd2CujnjwbK7Q597G4FRwQ63HshGkSwRdnPl5Gq
         w/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKWKefXYgWsnf49OVTYHqHn3slnN2Td7Ih4aRTfXMZ7QYYyEZVSrCmj7Nap/3xcxGSOZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMIviJTtkLFFdSGAZZY2yMGH8G4wl/z2+3O7kTMYSisC9fjsd
	c6wDSpMVQWWFp/vfI1IXDaHa7FFaAiGEZgCjKGm9grr+N3WzrtpFWxHP
X-Gm-Gg: ASbGncu275F4iega1lBJ5lZbXPUM7fmnsBLiWXQsIUqiR+G7I+r2ayDlWzDY1TyCq8n
	DjCAv3Np1mg1Z5BscOCiWGwsJlFaGgfQ/pKLlNFIdviLdzw+wfSMRqlK15gcpgectn5FAuvpCGx
	yjKeXitxoHhpIWGHf2NEJobIQIcscpSIu50nshWfNR2CNtN05HuZ7fJdR73zmASBFekxu8fYWgG
	3n+DddcYhISbay2ju393SiHsZ+SlXq5CsC8WM8CSvDtmeHnxFTHV1Opui6OjtX+y2FV2MpkrByT
	kpTFQP+VN5sq19qmIPcwwCxNgTy5KDvfEtusCC8hmlhze8IgCjqsG9V2theY20nebsAZp2DjKqk
	lBkWqAvUguzy513fJmSCTpJjQtJo3jA==
X-Google-Smtp-Source: AGHT+IEhIN7kP7AAu4AaZJ+Bt9rl7HyQ0dxeT+NrwJdFqKpGJ8D+9ObNDHJZPLWI7U5lS/Xpj/QIDQ==
X-Received: by 2002:a05:6000:1acd:b0:3d1:e1b1:9640 with SMTP id ffacd0b85a97d-3e643ff6d7emr7373979f8f.30.1757353312066;
        Mon, 08 Sep 2025 10:41:52 -0700 (PDT)
Received: from Tunnel ([194.65.32.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d9f3c36a78sm26879015f8f.48.2025.09.08.10.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:41:50 -0700 (PDT)
Date: Mon, 8 Sep 2025 19:41:48 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <aL8VXGQASeRo92xz@Tunnel>
References: <cover.1756983951.git.paul.chaignon@gmail.com>
 <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
 <CAADnVQ+EGdXHBfzrm_FC2mxtZ-Y-VU5Py5GOt9KriC8hVfRB8A@mail.gmail.com>
 <a9751ae4-adf1-4829-a5c9-2153e79d1ba9@iogearbox.net>
 <a3a927f6-7cad-46c7-9b20-89c9978acad7@gmail.com>
 <aLrkb-6ZFMLfMd-o@mail.gmail.com>
 <CAMB2axML8WkmA2Bv3gtvTnyq75cDO8ctqnPetB0jsYLQZVmNyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axML8WkmA2Bv3gtvTnyq75cDO8ctqnPetB0jsYLQZVmNyg@mail.gmail.com>

On Fri, Sep 05, 2025 at 09:34:54AM -0700, Amery Hung wrote:
> On Fri, Sep 5, 2025 at 6:24 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> >
> > On Thu, Sep 04, 2025 at 09:27:58AM -0700, Amery Hung wrote:

[...]

> > > How about letting users specify the linear size through ctx->data_end? I am
> > > working on a set that introduces a kfunc, bpf_xdp_pull_data(). A part of is
> > > to support non-linear xdp_buff in test_run_xdp, and I am doing it through
> > > ctx->data_end. Is it something reasonable for test_run_skb?
> >
> > Oh, nice! That was next on my list :)
> >
> > Why use data_end though? I guess it'd work for skb, but can't we just
> > add a new field to the anonymous struct for BPF_PROG_TEST_RUN?
> >
> 
> I choose to use ctx_in because it doesn't change the interface and
> feels natural. kattr->test.ctx_in is already copied from users and
> shows users' expectation about the input ctx. I think we should honor
> that (as long as the value makes sense). WDYT?

Ok, I think I see your point of view. To me, test.ctx_in *is* the
context and not metadata about it. I'm worried it would be weird to
users if we overload that field. I'm not against using that though if
it's the consensus.

> 
> Thanks for working on this. It would be great if there is some
> consistency between test_run_skb and test_run_xdp.

Definitely agree! Do you have a prototype anywhere I could check? If
not, you can always flag any inconsistency when I send the v2.

[...]


