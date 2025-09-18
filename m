Return-Path: <bpf+bounces-68765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58BCB83E4C
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800A9463A61
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8919A2C027E;
	Thu, 18 Sep 2025 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AfgjUFDP"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3D235345;
	Thu, 18 Sep 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188866; cv=none; b=ipkgZZUz3GgFeJKi1T0YfYaWlYOvjRUO9S1xSyOGmnCG5oDeqQdU/kK8IYoJsefML2mgf07/7gQUUL37qZ3R+cE+7bvVjnovyl4q3AeSrUkXyfBzrYU6LsnvY7s65M7//Phh4u5YDCuCeb7lIcEXb97q6Z9kHls3DrlThvRDdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188866; c=relaxed/simple;
	bh=m8W6DbTd2l52905A+1ioun4Jqq0gXUE0aCdKZx07XPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbWnXKVWDhm9wuZZo5XiYVvgKF/xT9hH4mqTvZXD2+bjvHkVYZmcIQ/CykjQ6w84KdVPGJrqIxrIZoaW8B0DOLbrgCCl0jP2YO46yAEdi246wfIBI/XEC/0knvRtccbWbOP7K43vaEOTx2tlcKHSy57zpTWUXf9O4KsUBrN7lhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AfgjUFDP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m8W6DbTd2l52905A+1ioun4Jqq0gXUE0aCdKZx07XPk=; b=AfgjUFDP63VuKK45Xl/fdCwbLR
	h2FlRgg60b3TzZFdozKQBy6sb2Yn79iXXi8xyCemoIkPQ5hEx94VCpJCDiX3iaJs0r848ryDmahFf
	a01XIYr4rcJwPPMxbGpE4JPiXolObzCk24cgs5bnXEhQozMKPEzE4P2IBoCPlxtS1EbxqWO43siHo
	mHXHo+r0rURQQgZbwukB1905EEkTqtkBMK2C+V6kAjKXZU4MaoukdTvp/9wjzjhQngLqeWge0jiI7
	626EAn2OA2hhXsm/oAs2G1rWSVlnevehIPTK7FM+WEPY4IMK+THTHewIuAOB+on+OWbU5qjCFmxNm
	pgYEKbFA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBEd-0000000HLRJ-07Q5;
	Thu, 18 Sep 2025 09:47:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D341E300328; Thu, 18 Sep 2025 11:47:25 +0200 (CEST)
Date: Thu, 18 Sep 2025 11:47:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, mingo@redhat.com, paulmck@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, tzimmermann@suse.de, simona.vetter@ffwll.ch,
	jani.nikula@intel.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v5 2/4] rcu: replace preempt.h with sched.h in
 include/linux/rcupdate.h
Message-ID: <20250918094725.GX3419281@noisy.programming.kicks-ass.net>
References: <20250917060916.462278-1-dongml2@chinatelecom.cn>
 <20250917060916.462278-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917060916.462278-3-dongml2@chinatelecom.cn>

On Wed, Sep 17, 2025 at 02:09:14PM +0800, Menglong Dong wrote:

> 1b93c03fb319 ("rcu: add rcu_read_lock_dont_migrate()") in bpf-next tree.

FWIW that commit has migrate and rcu not nicely scoped. It doesn't
really matter, but it caused my brain to raise an exception when looking
at it.

Anyway, let me go queue these patches, see what happens :-)

