Return-Path: <bpf+bounces-45638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B39D9DBC
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27731166CAE
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5D01DDA0E;
	Tue, 26 Nov 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uit2/Qf4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162516F0E8;
	Tue, 26 Nov 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647750; cv=none; b=SZXUQqsTsP0zZucRNe5GJFfKbo998XnUfXTvXcaRA54Rf5lOzO1BynIoKjMJl/uzQa2MEzJLc8rEhpmrZkOEpnk1UOJfsA0r7jao+dyliVNmvkEkGHJJi4zo75f5meZNLgdmH3B6CsYuptlMuCGqFa/egUdd4wj/muoFOiuhiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647750; c=relaxed/simple;
	bh=VfqMEQxGpW86DlSP9kPieFBfvkn6Zy27+re4cIUUpYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2H7gv7UfOpwF1cgzJz9G5DfDwrfImCW4Sg7uVzdK9vNiarWToa4Vp9xwpbtHYcY7P6/Dgq17Zy48Fi1BEBntaZXXQH+ZzNpw+FnMGmidRbtmfL/FkOyh4wPCxqHQ0qVR8GHRrOOBLA4AXwaL8F6bmmW+Wrqx8B99mCXfFefEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uit2/Qf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3B3C4CECF;
	Tue, 26 Nov 2024 19:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732647749;
	bh=VfqMEQxGpW86DlSP9kPieFBfvkn6Zy27+re4cIUUpYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uit2/Qf4uwy8p050i/d0GKt1CeA7lQ/Zg/Y27pk6891JDiPgUnP35fVhjJHry28h0
	 gr0XjtN07SMdQxt3XnfeYrtuxz7C/UIL9JOQ8PJqf7f79JTpxtS8xpojE0XeJhOUyg
	 NxeKhjsGug6FT8xyStHfg9epqMhSWM/Y2HaH6mLCqI+Bw54b99Gv2IXt9tR8E3J5og
	 nWzwVZKfQt8Mfj/cv0+LPK+HpUpC0UGrt26c3XADgpjOsRSYL0oXNtyBC6q6Iw/7ke
	 LNajVecoHryYeDuGgV/U73M3lIvLMM8macMOzgYiwJiVoTOi7kTbfQtoo4aTGpkk0E
	 Ons9Amp5p4hQw==
Date: Tue, 26 Nov 2024 16:02:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, Alan Maguire <alan.maguire@oracle.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH dwarves v2 1/1] btf_encoder: handle .BTF_ids section
 endianness
Message-ID: <Z0YbQr_QTNrfNqAE@x1>
References: <20241122214431.292196-1-eddyz87@gmail.com>
 <20241122214431.292196-2-eddyz87@gmail.com>
 <Z0HXqLswziDAjNrk@krava>
 <Z0X2YnMyzNlZyQtP@x1>
 <b2e5cb3b1478d6900f126d4de223500d6be4c97d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e5cb3b1478d6900f126d4de223500d6be4c97d.camel@gmail.com>

On Tue, Nov 26, 2024 at 09:32:28AM -0800, Eduard Zingerman wrote:
> On Tue, 2024-11-26 at 13:25 -0300, Arnaldo Carvalho de Melo wrote:
 
> [...]
 
> Hi Arnaldo,
 
> > I think I saw instructions in one of the messages in this thread to get
> > hold of a vmlinux for s390 and test it. Right?
 
> Yes, in cover letter. Full vmlinux is not needed, a vmlinux binary for
> s390 would be sufficient for testing. Repeating the recipe for convenience:
 
>   To reproduce the bug:
>   - follow the instructions in [0] to build an s390 vmlinux;
>   - generate BTF requesting declaration tags for kfuncs:
>     $ pahole --btf_features_strict=decl_tag_kfuncs,decl_tag \
>              --btf_encode_detached=test.btf vmlinux
>   - observe that no kfuncs are generated:
>     $ bpftool btf dump file test.btf format c | grep __ksym
 
> [0] https://docs.kernel.org/bpf/s390.html

Thanks.
 
> > One extra question: this solves the BTF encoder case, the loader already
> > supported loading BTF from a different endianness, right? Lemme
> > check.
 
> > cus__load_btf()
> >   cu->little_endian = btf__endianness(btf) == BTF_LITTLE_ENDIAN;

> > enum btf_endianness btf__endianness(const struct btf *btf)
> > {
> >         if (is_host_big_endian())
> >                 return btf->swapped_endian ? BTF_LITTLE_ENDIAN : BTF_BIG_ENDIAN;
> >         else
> >                 return btf->swapped_endian ? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
> > }
 
> I can switch to is_host_big_endian() instead of `BYTE_ORDER` macro
> if you think that's better.

No need for that, I think, is_host_big_endian() is a static function
inlib/bpf/src/btf.c.

I was just looking at how endianness was being handled and noticed
libbpf does it, but, as you say below...
 
> > So we have parts of BTF byte swapping happening in libbpf and with this
> > patch, parts of it done in pahole, have you tought about doing this in
> > libbpf instead?
 
> BTF id lists handling is currently not a part of libbpf.

So we should do it in pahole, as you did, so all is clarified now, I'm
now testing it with the provided instructions.

Thanks,

- Arnaldo

