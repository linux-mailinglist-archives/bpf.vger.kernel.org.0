Return-Path: <bpf+bounces-20596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EA3840832
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B4328719A
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD165BB5;
	Mon, 29 Jan 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqOAtHYW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201E657C3
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538257; cv=none; b=qJVKcl0zQRWTuS1kz2a9S1vjFNNCpX1lGVcIDC9RRBTUuBUfL+K2o1P/V1rzlY4ZyV0/CCoSvtwn7Jj0eEM4Hh2CxSEAsdVHV9cie7njpYm9HbrOzrpG9NZgX3V/zDxnO1Q6pG0rlY5/GHxXb+7ZtQZ+X02XmkWaPnweTLEf7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538257; c=relaxed/simple;
	bh=8RHekHuYUuO6oSvsiR5g60IAgj/SY3aZhugXuLwr3ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0NIVZ0CScIdaXX4+bbChr/IXcZiIG+xaR+Cydc0X36T1SvrPEnuyI+BfkRA00apbaEUwzEJV+A9pycjU3wNYftdOdoI5U+iY3M6xDFKAqN8tA6O1B0h8PTMRHhuj4kyZCezQdqAv4oVzXuHf1UHRosVgmdE8PJ+Yj/055IhNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqOAtHYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FA6C433F1;
	Mon, 29 Jan 2024 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706538256;
	bh=8RHekHuYUuO6oSvsiR5g60IAgj/SY3aZhugXuLwr3ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqOAtHYWAXXzI4v+EOxLkIk9xf8byh/aZ/WDrIJXh9wsnTXUP2DNmM/kAhK2msxWi
	 0FAXhWnpa1RW8jzB77t76UZgzinHjE/8FlSbc47LXG9BO+M12a3nQ2tHIaIC5WLN4R
	 kNuhSfN3uO3HpoZcthXBqiXJLFGTQlTplhTiNxg1O3K76RZ0DJNenJCJyi3GHV38qF
	 wMMLIbMFEQ1RMEjIgHRFhm9QNTdpaTaqB8HBJMFrj+cdxD2rl5N7ax4xrJc92RzQXa
	 vwkaJ4F0XOJZ4GDGQaQXO8nHWva9efC2R81hxN7uoEADrNHCuA+DB63xLE0o/hNr8D
	 mmV+ri76f4HiA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B8EC440441; Mon, 29 Jan 2024 11:24:13 -0300 (-03)
Date: Mon, 29 Jan 2024 11:24:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, jolsa@kernel.org, quentin@isovalent.com,
	andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3] pahole: Inject kfunc decl tags into BTF
Message-ID: <Zbe1DfHjhZHwIKha@kernel.org>
References: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>
 <49da8aff-1ec7-b908-2167-ee499e7a857a@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49da8aff-1ec7-b908-2167-ee499e7a857a@oracle.com>
X-Url: http://acmel.wordpress.com

Em Mon, Jan 29, 2024 at 01:05:05PM +0000, Alan Maguire escreveu:
> This should probably be a BTF feature supported by --btf_features; that
> way we'd have a mechanism to switch it off if needed. Can you look at
> adding a "tag_kfunc" or whatever name suits into the btf_features[]
> array in pahole.c?  Something like:
 
> 	BTF_FEATURE(tag_kfunc, btf_tag_kfunc, false),
 
> You'll also then need to add a btf_tag_kfunc boolean field to
> struct conf_load, and generation of kfunc tags should then be guarded by
 
> if (conf_load->btf_tag_kfunc)
 
> ...so that the tags are added conditionally depending on whether
> the user wants them.
 
> Then if a user specifies --btf_features=all or some subset of BTF
> features including "tag_kfunc" they will get kfunc tags.

Agreed.
 
> We probably should also move to using --btf_features instead of the
> current combination of "--" parameters when pahole is bumped to v1.26.

Alan, talking about that, I guess we better tag v1.26 before merging
this new kfunc work, wdyt?

- Arnaldo

