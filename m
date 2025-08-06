Return-Path: <bpf+bounces-65148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE6B1CC0C
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E02E17E046
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0D29CB48;
	Wed,  6 Aug 2025 18:39:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61E29A9C3;
	Wed,  6 Aug 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505554; cv=none; b=DVFFWgkAB2y/QUnFzkG+PgQ54OERKoZNbVH2evv3zlpi0YYKIhugwgwrjF5zNp8VqvHpEauNVDPz2XZ90TqoM4SghPpu59NaTzGT2vmXEmfOtKh69KKezrVZ78oE73mOSo6bj26EjWPMWG7h1umNYoxui72+OXqKksD0sS4+ptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505554; c=relaxed/simple;
	bh=YMlQV3K+pJen1PR4TEtvm9pYP0XGyd6K7N7luLSCKSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8PyhQ6NL+mAkiBOq1vDQ8pwu6motHu4A0C5Eq6mzDnpOXD7j869OphAudQgH1xFOIIWAoR3lQxTEuKqk2fPQE3WX5diZ8FQtOafuvk+OPTvzTwMhC+0f54zjr743y6oIg7XAyDzUbRbHWB4d8JyJHa369zoq8I+5RPtPdfuQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
Date: Wed, 6 Aug 2025 20:38:54 +0200
From: Florian Lehner <dev@der-flo.net>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add LINK_DETACH for iter and perf links
Message-ID: <aJOhPoTLdYnZmHYA@der-flo.net>
References: <20250801121053.7495-1-dev@der-flo.net>
 <f871d538-31b8-437a-b838-900836e13eb8@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f871d538-31b8-437a-b838-900836e13eb8@linux.dev>

On Tue, Aug 05, 2025 at 02:07:20PM -0700, Yonghong Song wrote:
> 
> 
> On 8/1/25 5:10 AM, Florian Lehner wrote:
> > 73b11c2a introduced LINK_DETACH and implemented it for some link types,
> > like xdp, netns and others.
> > 
> > This patch implements LINK_DETACH for perf and iter links, re-using
> > existing link release handling code.
[..]
> >   static void bpf_iter_link_dealloc(struct bpf_link *link)
> >   {
> >   	struct bpf_iter_link *iter_link =
> > @@ -490,6 +496,7 @@ static int bpf_iter_link_fill_link_info(const struct bpf_link *link,
> >   static const struct bpf_link_ops bpf_iter_link_lops = {
> >   	.release = bpf_iter_link_release,
> > +	.detach = bpf_iter_link_detach,
> 
> Not sure how useful for this one. For bpf_iter programs,
> the loaded prog will expect certain bpt_iter (e.g., bpf_map_elem, bpf_map, ...).
> So even if you have detach, you won't be able to attach to a different
> bpf_iter flavor.
> 
> Do you have a use case for this one?
> 

A key reason for adding this was to enable the temporary disabling and re-enabling of
an attached BPF program while keeping the same bpf_iter flavor. If you don't think
this is a strong enough use case, I'm open to removing this from the patch.

> >   static void bpf_perf_link_dealloc(struct bpf_link *link)
> >   {
> >   	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> > @@ -4027,6 +4033,7 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
> >   static const struct bpf_link_ops bpf_perf_link_lops = {
> >   	.release = bpf_perf_link_release,
> > +	.detach = bpf_perf_link_detach,
> 
> This one may be possible. You might be able to e.g., try a different bpf_cookie, or
> different perf event.
>

The primary use case for this feature is to allow for the temporary disabling of
uprobes that are attached using bpf_perf_links.


