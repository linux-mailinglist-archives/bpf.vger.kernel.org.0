Return-Path: <bpf+bounces-76117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E704CA83B1
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283A933D249E
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83A6329E6E;
	Fri,  5 Dec 2025 15:32:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F63F32D42D;
	Fri,  5 Dec 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948766; cv=none; b=KbG5v4lJIEk+Nvl1UTe1H24rTsFvkV3GCS6kY5UQNGSEYpASplt8qNlugE/pXewriKC9jIRML606a+TYBNm+ZaLwpyik64UkA0Lw08meSZSjahKOOF+l6vU5X0qWUPqSYHU7xa2pbAqcsyweD65EZKRCbn5bhhYHBLO6EnZfG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948766; c=relaxed/simple;
	bh=QqxCFfJ9TlSkDqUBov5vN0BMfcjU3jjfnHPRswY0DqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvaVMbvOtMPlXqRx+PAhEuLVXyP6mCC1tiY9uFBiYCu62TVMCfOUy1REM5bcoATNx/3Zb80QmqZGjsZXZV3MxjwHMH+js3y9YpVQBP8hWGq7mmjzp5YsIwroICVw2iEZe8mqVV6ekTKjMjEnqbLCSq77QTHXXn7xntV7TsgWCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 217531758;
	Fri,  5 Dec 2025 07:32:21 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BF253F7A6;
	Fri,  5 Dec 2025 07:32:27 -0800 (PST)
Date: Fri, 5 Dec 2025 15:32:25 +0000
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH] bpftool: Fix build with OpenSSL versions older than 3.0
Message-ID: <20251205153225.GQ724103@e132581.arm.com>
References: <20251205145506.1270248-1-leo.yan@arm.com>
 <704bea33-84f7-4e20-9298-092eb35fa1ce@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <704bea33-84f7-4e20-9298-092eb35fa1ce@kernel.org>

On Fri, Dec 05, 2025 at 03:06:33PM +0000, Quentin Monnet wrote:
> On 05/12/2025 14:55, Leo Yan wrote:
> > ERR_get_error_all() exists only in OpenSSL 3.0 and later. Older versions
> > lack this API, causing build failure:
> > 
> >   sign.c: In function 'display_openssl_errors':
> >   sign.c:40:21: warning: implicit declaration of function 'ERR_get_error_all'; did you mean 'ERR_get_error_line'? [-Wimplicit-function-declaration]
> >      40 |         while ((e = ERR_get_error_all(&file, &line, NULL, &data, &flags))) {
> >         |                     ^~~~~~~~~~~~~~~~~
> >         |                     ERR_get_error_line
> >   LINK    /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/bpftool
> >   /usr/lib/gcc/x86_64-alpine-linux-musl/11.2.1/../../../../x86_64-alpine-linux-musl/bin/ld: /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/sign.o: in function `display_openssl_errors.constprop.0':
> >   sign.c:(.text+0x59): undefined reference to `ERR_get_error_all'
> >   collect2: error: ld returned 1 exit status
> > 
> > Use the deprecated ERR_get_error_line_data() for OpenSSL < 3.0, and keep
> > using ERR_get_error_all() when available.
> > 
> > Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/bpf/bpftool/sign.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> > index b34f74d210e9..c98edd6d1dde 100644
> > --- a/tools/bpf/bpftool/sign.c
> > +++ b/tools/bpf/bpftool/sign.c
> > @@ -37,7 +37,11 @@ static void display_openssl_errors(int l)
> >  	int flags;
> >  	int line;
> >  
> > +#if OPENSSL_VERSION_MAJOR >= 3
> >  	while ((e = ERR_get_error_all(&file, &line, NULL, &data, &flags))) {
> > +#else
> > +	while ((e = ERR_get_error_line_data(&file, &line, &data, &flags))) {
> > +#endif
> >  		ERR_error_string_n(e, buf, sizeof(buf));
> >  		if (data && (flags & ERR_TXT_STRING)) {
> >  			p_err("OpenSSL %s: %s:%d: %s", buf, file, line, data);
> 
> 
> Thanks, but this should be addressed in bpf-next already, see commit
> 90ae54b4c7ec ("bpftool: Allow bpftool to build with openssl < 3")

Thanks for the info.  I suspect someone has fixed it so I did not find
it on the perf mailing list (I should search bpf ML).  Please ignore
this one.

Leo

