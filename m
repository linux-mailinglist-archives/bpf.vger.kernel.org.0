Return-Path: <bpf+bounces-28302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21A8B82D7
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 01:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188061C22E32
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE131BF6F2;
	Tue, 30 Apr 2024 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hX1qX7ai";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyMENwyv"
X-Original-To: bpf@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1D17B4FA
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518054; cv=none; b=orlhJVZ8/KZ0qMKG/jMFOSpw2DFonSeH3SGVMZlhiUaWwn5VubQ53Pr+ULwlalItALjRGYWnvrrt6jBi00VUOGeUIr1t7W75TJa1HlgHSFFNgCHUpnJVJ9dQT2tlulhNiiELkLOgL2kXBjryOZfUuu/PjEhROW7Fb0+UWQ69GKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518054; c=relaxed/simple;
	bh=aELafpbYvo/cFxDBfNrZ7m8L8Vy/aL+jyZUuUzB1wZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLhFSAR7b/hQGJwZ4lr9fJ/4Ctl7OEhRpXfNeBLJen5ztp2LomjBw8Nyy3kZB1KWNMS62756NENaj4SCDx+nwfNWiqsxW0lh4Z16qSPg/es5poWDHWLsM25Ssp7Gz+vYF1JSYw0faOTO7V2oJx0lh8iZtIpsBTFtXXxguwCl/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hX1qX7ai; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyMENwyv; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id F32751C00149;
	Tue, 30 Apr 2024 19:00:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Apr 2024 19:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714518050; x=1714604450; bh=geVDjfASgd
	GSB4HZBVN5ET7ikX2oNVxiA8NL3nV8zr8=; b=hX1qX7aiwHnei7YtBVtZGOVOaw
	pQDPAKpRWK6SrPyJykHPFfEc+PAJYa+ltnvFM0y1k1yismFmomIMkKyrnOgd2DYX
	yhhPR1q4CDDgLkQQdzUhQh4o25JJhU4/sye0HgjDU+ejJ6MODVAMVGG+85Byu+NF
	iV5DPvEAK436DMFNaSF/9ykOzpVT+lEQig1PRWfAl/Qv1JjdfvJtvz9t+ovtg8H7
	T961f629AkMBt/w5NYHGYEFczTJ3HNA97dZfA0IAYETkKEj22adLgu+Z+FvJL5be
	xHYk/GI8pj5y++mIiQHGL+GrggnpHicrYVavH/dc4pwdLWwfnlrm3yzsgBXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714518050; x=1714604450; bh=geVDjfASgdGSB4HZBVN5ET7ikX2o
	NVxiA8NL3nV8zr8=; b=SyMENwyvv5Z/PKNG84rVessxHUCWhb+uDcAOUrM8PPOe
	L1RCSPaXoAssJlSZKWAva+UR8azCyuz/HwJWndfUdi4xICo6o25kJDiixNSSDKhG
	DNDN17I2fhPc1PpMM9ipha8BqGzIYJ72n9eG1cgV+yHkzQUfg6zmSDHUov1ID9+P
	VZmPrwmSg0kz+KeEMl7m/Dnt9CQMMzii/HeCn5Uf/FeDd5uvAoCOIPL2XC4bs1eJ
	3wweH5AJZCESMYrhpnh6APoonr41m3HdtJsjJcCbR2yhiBP6jMStnvDfwzAlF4v6
	Py9Zbysq2MQfAo46j2z81Gm6LexoY+0M49pngrqOBQ==
X-ME-Sender: <xms:IXgxZnq6jzHkiPPl8nMkK1WYwk7PcjN58AkSwfyebTmBMRN2zVoR2Q>
    <xme:IXgxZhoeKjhTq2gzJDbj4yxM7f4oGAw1VSig59OA-5sQD41_jRjZPbiFLpZF30USQ
    Mx_JBC17uD5PWt4bw>
X-ME-Received: <xmr:IXgxZkOFUgSiYNZHdJulg8m9Di90-TMgUVQDwUnALPHIoPdlldTXioWqxxb7MPFr5VXmsAh11z-IrHDtjIfbo4TVmaojSuyZ-YBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeige
    dtheefffekuedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:IngxZq5bhDPvdwA6rJIMaSK_qlgQWTGU8bNtyAUVoKIpONZ1wlbeeA>
    <xmx:IngxZm4hZX7XU4iNsyNraJ4WPBqW5mPjTMy3MkGFbZORJLK_6-qbyA>
    <xmx:IngxZiisZmMZhMH5yknmkGrEDpYWFOljCKygj3SIy1GbixkrfLPGtg>
    <xmx:IngxZo7O4Ggcd8y3bVfcpnEngH-3oYqpp3pMgHd5Mr6dTWlTHqJJnA>
    <xmx:IngxZvHDPwVV9fF4BKYStUWxLjAjv_Vx-b2wa86Oo66Rf8lea1Rb902s>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 19:00:49 -0400 (EDT)
Date: Tue, 30 Apr 2024 17:00:47 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com, 
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v9 2/3] pahole: Add --btf_feature=decl_tag_kfuncs
 feature
Message-ID: <2jjkwylnz7rjqkjpjb5li3n7g32uhrhx2uzwwthtgfqdf6bwzl@yjmuy24buoyl>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
 <6d69d6dce917475ffe9c1bd7bc53358904f60915.1714430735.git.dxu@dxuuu.xyz>
 <ZjE85q0SJ1sve25u@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjE85q0SJ1sve25u@x1>

Hi Arnaldo,

On Tue, Apr 30, 2024 at 03:48:06PM GMT, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 29, 2024 at 04:45:59PM -0600, Daniel Xu wrote:
> > Add a feature flag to guard tagging of kfuncs. The next commit will
> > implement the actual tagging.
> > 
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> Also 'decl_tag_kfuncs' is not enabled when using --btf_features=default,
> right? as:
> 
>         BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
> 
> And that false is .default_enabled=false.

I think that `false` is for `initial_value`, isn't it? The macro sets
the `default_enabled` field.

Building with this seems to tag the kfuncs for me:

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf                                                                                                                                                                 
index 82377e470aed..7128dc25ba29 100644                                                                                                                                                                                  
--- a/scripts/Makefile.btf                                                                                                                                                                                               
+++ b/scripts/Makefile.btf                                                                                                                                                                                               
@@ -16,4 +16,6 @@ pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)                += --lang_exclude=rust                                                                                                                   
                                                                                                                                                                                                                         
 pahole-flags-$(call test-ge, $(pahole-ver), 125)       += --skip_encoding_btf_inconsistent_proto --btf_gen_optimized                                                                                                    
                                                                                                                                                                                                                         
+pahole-flags-$(call test-ge, $(pahole-ver), 126)       = -j --lang_exclude=rust --btf_features=default                                                                                                                  
+                                                                                                                                                                                                                        
 export PAHOLE_FLAGS := $(pahole-flags-y)

Thanks,
Daniel

