Return-Path: <bpf+bounces-67557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC554B458B4
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDD417F9BE
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DAF342CB6;
	Fri,  5 Sep 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRwIqgCD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730030CD93
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078647; cv=none; b=iqwPj1Bnj3IDhRBIHRk4vwp1SgFaS2TsVvPlUwghd3TI35ByS9os/gwUq/3fyJoZrer0cDSChn00YuGPXOtpGlKTxvtemw7PqzuLwMJ+ce6ST4pudWnyZ1kCWD0KdTZjV9b5KutQoK5PZ/aPA6RIon7oYyP0Dyf+W286IJc8hzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078647; c=relaxed/simple;
	bh=8jrzx+11QB3Zqtbw+4n9/V620tuDcwEuyUW97xlC7KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf58sUy5MG2cSHNawgQE/PnclSVQ0xR4JLiF6+HuRQI74HMuzzrwHiaBGhov5Ga1GVYtDBwwzFvR8GDzsYzGF85+U0EJ7OdunqbnbC72SkpMWNvS97meNMT3BW6E0OUKr9nIF+Y1RLaJCZBduqoXhROljGhznYiQpy+hbQbUdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRwIqgCD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so9207505e9.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757078643; x=1757683443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FWivTSnmBouy+Xdzqn86NyY5H//Sq4Sqtc9qZ31IsO0=;
        b=CRwIqgCDGMApdwuqm/U/NEfoLyXKA8AT1TfNazO2n7HSmKdYOVa8v+gGn6Z+mRYld8
         xXxWu6G1gOnrbwBsA9z4n0SFNIUMfiGiRKYW8fB2OkfvAl1v06oU1F+b8pwXC46sq7O3
         OFAQ2uOo93XP8o3VS2NTqDTDUmmgoTzwnA/A1I8I4rnkbnLoKZnO/5ZoBGhhksH1DyHG
         nFfP1zMBSM3Szjg82l7K21I3Cmyylv9ixx1gXrGSIRirHqTyvQBSyHV0vWWe0IFJ9OLy
         oGvkHo8s0ObaMe1imYoWFgLqJEsybj204joHh08EStNekdu2yb5CJ/eRYdEzFS0/SFn/
         Xhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078643; x=1757683443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWivTSnmBouy+Xdzqn86NyY5H//Sq4Sqtc9qZ31IsO0=;
        b=vHGll4aO0BRsyKXN1a1KlhZEGHSZQPFRFgD6lTqdhK4v9gH90Xn4wPY9m0cB3oS8/E
         Jdeu/53Wxnxya94qxkJjy7xyr4OefK7+UAuuGVTmcyG1OOlYyWfeKU4eDiGgP4Cykw/E
         iWjPZzopo9S5v388SjIgO5fiCGl7yo3Z87BuF/0MF8Cb9lygCsFoCUXjXVrCw64p0X03
         nQ6fVEVsXMnp3i1a8fkvNkfxWKoRgweBpgoAOPB8kl/akeMD3SI30YWBJVDpffp/90MD
         POotqnuNJ2M7IHA77NaGUqPH8g+Az2+cKmLRMWpI2mtMCoTVf+0Kbk8MWOhty5PFCWGQ
         jEzA==
X-Forwarded-Encrypted: i=1; AJvYcCUYJRebP95BrFqYhbvQcIyUFUmIzKjDb79oRrSVdm9VMxPTtmH/xKzixEmMUJ8e3vdhQEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQU+uWA5jt5MO1DGxFPrdGgssPXqSM0J3F5WFNRmuKjrB1a9z
	F+H0OoLvaH65p0T6LeGROHHZa4lRWg2sT0jpIpX17eu5oNbtoK7C4YLA
X-Gm-Gg: ASbGnctpFVGCjeNInNPw6/jXnDml7lGlQXFdEuRUG3METpPQC5i40V6KUqi0vK7MY/X
	dwlz+InhGd451shz51jKGeB0oXdPRqTiqHhde1zJKoAzlM3GRWy9T3DHUD/Kwlt9sijdE3Ga7A8
	XkEqcVpH31sMx1R+t83R1eAQR+yq6KH3gKDSt1Wrif3GkrcopiDT3G0hUPSYo/enmUCL/RFWuRe
	ns/cOk9xLGAVYA29zp0h1PO8KjroHKYqBZXCsdsrlDXhbYyLSZjSSFzu0t0ZvGoVcD9tRQVRgts
	1yAQ/vd0ZaXDLJUzh+Gl2ULSAH8FnJfy6xTvnS9KQvaWOREBDEAQ5nWKIBsewghdltOaNaG/NCG
	84OXIacP88UEEqmXSApLKEPe+BvTJ3/+nyRL0sJ9q4WpfrkRtpccN+WhRI9TyhTyxT8q06rM7+4
	c51m/C5vygFw839KHVLj88yuwrJheNe3U=
X-Google-Smtp-Source: AGHT+IGvte2nZzHjHDB27zN98+qe2PGwDpPLHXr2vBL/TiZGf6HVx2cKaGy3ddNGoToClWByUaYGLg==
X-Received: by 2002:a05:600c:8b41:b0:45b:7be1:be1f with SMTP id 5b1f17b1804b1-45b8557d72amr182849915e9.32.1757078642453;
        Fri, 05 Sep 2025 06:24:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d0182e7ce2f9547e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d018:2e7c:e2f9:547e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b93fae643sm175875405e9.3.2025.09.05.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:24:01 -0700 (PDT)
Date: Fri, 5 Sep 2025 15:23:59 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <aLrkb-6ZFMLfMd-o@mail.gmail.com>
References: <cover.1756983951.git.paul.chaignon@gmail.com>
 <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
 <CAADnVQ+EGdXHBfzrm_FC2mxtZ-Y-VU5Py5GOt9KriC8hVfRB8A@mail.gmail.com>
 <a9751ae4-adf1-4829-a5c9-2153e79d1ba9@iogearbox.net>
 <a3a927f6-7cad-46c7-9b20-89c9978acad7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3a927f6-7cad-46c7-9b20-89c9978acad7@gmail.com>

On Thu, Sep 04, 2025 at 09:27:58AM -0700, Amery Hung wrote:
> 
> 
> On 9/4/25 9:02 AM, Daniel Borkmann wrote:
> > On 9/4/25 5:56 PM, Alexei Starovoitov wrote:
> > > On Thu, Sep 4, 2025 at 5:11 AM Paul Chaignon
> > > <paul.chaignon@gmail.com> wrote:
> > > > 
> > > > This patch adds support for crafting non-linear skbs in BPF test runs
> > > > for tc programs, via a new flag BPF_F_TEST_SKB_NON_LINEAR. When this
> > > > flag is set, only the L2 header is pulled in the linear area.
> > > 
> > > ...
> > > 
> > > > +               /* eth_type_trans expects the Ethernet header in
> > > > the linear area. */
> > > > +               __pskb_pull_tail(skb, ETH_HLEN);
> > > 
> > > Looks useful, but only L2 ? Is it realistic ?
> > > I don't recall any driver that would do L2 only.
> > > Is L2 only enough to cover all corner cases in your progs ?
> > > Should the linear size be a configurable parameter for prog_run() ?

I think it's enough for Cilium. It's a bit of a worst case for us AFAIU.
In any case, I'm definitely not against making it configurable.

> > 
> > Yeah perhaps we could make this configurable. The ETH_HLEN is a common
> > case
> > we've seen and also what virtual drivers pull in at min, but with NICs
> > doing
> > header/data split its probably better to let the user define this as part
> > of the testing. Then we're more flexible.
> > 
> 
> How about letting users specify the linear size through ctx->data_end? I am
> working on a set that introduces a kfunc, bpf_xdp_pull_data(). A part of is
> to support non-linear xdp_buff in test_run_xdp, and I am doing it through
> ctx->data_end. Is it something reasonable for test_run_skb?

Oh, nice! That was next on my list :)

Why use data_end though? I guess it'd work for skb, but can't we just
add a new field to the anonymous struct for BPF_PROG_TEST_RUN?

> 
> > Cheers,
> > Daniel
> 

