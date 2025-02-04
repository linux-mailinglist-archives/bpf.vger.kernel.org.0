Return-Path: <bpf+bounces-50386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E4A26DF2
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 10:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79E27A41D3
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1CA207A0C;
	Tue,  4 Feb 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="v04ZZrjn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iL6UT1eR"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C020371A;
	Tue,  4 Feb 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660191; cv=none; b=cqDh90sLKcFBbzq5MJFT0Uh8bNZiwoWexrAFQyLHWmIKaJu3lvovhDk/vxp13bu8mCsCiWJzXxiOiPLKs97anDq9MK0vHl7DpHO/D9EHJdP5xBo/Kom/3RcDTFJB9kr004fiQe6K7Taamn7gc3i8VxwRDVx/Pmm9V4zExZxEYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660191; c=relaxed/simple;
	bh=ldm5rA90FbHZ9erUip5pRsh/zyKUrvNrnX2gFJ3ZMkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3lHMGBlb144YgqCnoRRDGtpoKx/GYQnbj9kB3aGeWFGVTnxv5/Iyun+h6UOoRsfj9m3vcf7IqOHLhq+DFQ1bPAxvYE+1GWQMyN61edZkaV42zBNyblNYBj4Meb4vfRTM2r8NdMEeNMSKuXqWb4vvwLkL9t9Y8rxFkQRGBTbrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=v04ZZrjn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iL6UT1eR; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DBF925401CB;
	Tue,  4 Feb 2025 04:09:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 04 Feb 2025 04:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738660187; x=1738746587; bh=XZj/3L15Zh
	JDphoA3SD15pg6OoRb/NWpiUa3moUl3Kk=; b=v04ZZrjn6Rsnl3ivfR0PYx5B+C
	gpbvoThDhWkSv7mWI4Qe3TUN8ssc28EyYdL+ifX4MZSD5Gs0peKpK3yQdKuGROEb
	0Bi5Ig6rNGdSQlnlgcYntc5QiI8ytm/6r93T0CN5E217Jl48lFhJVyp6LcghNo3b
	giSZAqPHCKLc7fkGUntA2oUtVs2FHS2B6QdOyVFKEozlktzB6tDGHnjjdok92JCv
	AxOnKivyXShDdxSrq+kw/p/PCd+XqJEgob/THNe3I5NCZT4HwsqWMKsKWwkIW9rH
	z9UhoVwIDI4R0PHwuinY4+PTbZ/XQNXjSR0rmeBtEptgouryQ+FFV/BNs9QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738660187; x=1738746587; bh=XZj/3L15ZhJDphoA3SD15pg6OoRb/NWpiUa
	3moUl3Kk=; b=iL6UT1eRtA6auWC4tjEYI8noQCnKTjjLY0uPUS7cR6tHo2pjz6M
	PkqdDFgUJZoA3lihEfCHK3O9XTjva8gYwNN9ZjiPniCDEsgZY173aGVz/nCrGoBM
	2cWgS7yseOnFVkga09WWVe5S3FEBqnaKGdrUIxxZJ85bdEs/osTd7wugk/fjA48k
	1ek6RTH3O8+EMyJJvSQ7oQP+GgnZkP7sJ0AYMK36MSt0/qF1UWj9it9OtM6emljc
	sR7CmPRmC+oPic+6SKVu6cO6i5QneAcH65j/jjT6pzLktaZLGL0pzNAT751NiNyl
	AKwxxnaikGB3ZK68y6KJuV/VN5DMLhwakcw==
X-ME-Sender: <xms:WtmhZ9R5MyIwoZwvApJeK57TfqWIu3LtAsA_hV7Y_QREWpDMtkKdGQ>
    <xme:WtmhZ2xzxT5mltaU-rQJyejNwBP3Q7XaDfg4MwPN4PLuFb9JZw5AKcEQpGfgD6kPa
    ss4zjZ9eFS9pqtiSg>
X-ME-Received: <xmr:WtmhZy2FtSa1mIhqIzvNxOuzM8Z8n6Tgf-vYwZb7mIyRf7xpVq3PbEA3H3LXuCxnzHJ-K8e_rSKnb5v4cW72en-pd8pyOzosJh5FuFZsD_vLsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfegiedttefgvdfhvden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihuse
    gugihuuhhurdighiiipdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegurg
    hnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhig
    rdguvghvpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WtmhZ1COT6EQKOwe7Qx_EhE8EiVX6Bnl1_1a3U4esBQKyqeZYbnfQQ>
    <xmx:WtmhZ2g8v_ZwQjCM0sgrBoXIuWYSxG88aL0oL5j67kj9Zu4uFoGVxQ>
    <xmx:WtmhZ5rEeEDMai9nuyyD8O6hpdDwiYkr0lD3ep1Zi3AmZDSFQCvqLA>
    <xmx:WtmhZxijozAM17brIJdC8fsZ9aNN5kLa2gCnK5G93iEe8EnpzWOXdw>
    <xmx:W9mhZ9QGjDdp-h2YE4RS0Nl2rHfHd6LEfKADF_ar-EbyhjjQryXYgSEK>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 04:09:45 -0500 (EST)
Date: Tue, 4 Feb 2025 02:09:43 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, mhartmay@linux.ibm.com, 
	iii@linux.ibm.com
Subject: Re: [PATCH bpf-next 1/3] bpf: verifier: Do not extract constant map
 keys for irrelevant maps
Message-ID: <3kzwzsfyghdogwv2jghmkamzierq64l6zgozo3urja5fenzcqg@7yplvj3x3oqp>
References: <cover.1738439839.git.dxu@dxuuu.xyz>
 <ebbf8edf871a6543425b75bb659400221bd28275.1738439839.git.dxu@dxuuu.xyz>
 <084abedc8ec36ffe77f97531c0bcebc291547415.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <084abedc8ec36ffe77f97531c0bcebc291547415.camel@gmail.com>

On Mon, Feb 03, 2025 at 10:45:35AM -0800, Eduard Zingerman wrote:
> On Sat, 2025-02-01 at 12:58 -0700, Daniel Xu wrote:
> > Previously, we were trying to extract constant map keys for all
> > bpf_map_lookup_elem(), regardless of map type. This is an issue if the
> > map has a u64 key and the value is very high, as it can be interpreted
> > as a negative signed value. This in turn is treated as an error value by
> > check_func_arg() which causes a valid program to be incorrectly
> > rejected.
> > 
> > Fix by only extracting constant map keys for relevant maps. See next
> > commit for an example via selftest.
> > 
> > Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> Nit:
>   would be good if commit message said something along the lines:
>   ... the fix works because nullness elision is only allowed for
>       {PERCPU_}ARRAY maps, and keys for these are within u32 range ...

Ack. I can respin if necessary. Otherwise, here's the edited commit msg:

    bpf: verifier: Do not extract constant map keys for irrelevant maps

    Previously, we were trying to extract constant map keys for all
    bpf_map_lookup_elem(), regardless of map type. This is an issue if the
    map has a u64 key and the value is very high, as it can be interpreted
    as a negative signed value. This in turn is treated as an error value by
    check_func_arg() which causes a valid program to be incorrectly
    rejected.

    Fix by only extracting constant map keys for relevant maps. This fix
    works because nullness elision is only allowed for {PERCPU_}ARRAY maps,
    and keys for these are within u32 range. See next commit for an example
    via selftest.

    Acked-by: Eduard Zingerman <eddyz87@gmail.com>
    Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
    Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
    Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

