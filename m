Return-Path: <bpf+bounces-35684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E61C93CAF4
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 00:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BF61C2187A
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45D143894;
	Thu, 25 Jul 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAa723Nb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D413A40F
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947593; cv=none; b=coqsPxJOy6I7nfXj5QqUxMo9U3/DyhSd62mIvRIb5npHRj28aBI4rH/UmBNif2gRo+tJGjkXC9Z6VTiucNybEYDDyyKt26DcM/BH8qta2I8K/twoOXtjoVByT9IYceeaAFmOj188yiKKezq9dzS3ZPadDUSf2pL7M/VCr9Hd0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947593; c=relaxed/simple;
	bh=whlrPpJ/X00z7ndHglD6vPWX0hJEVO8LEEwDUpISOys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkUmtEWDuk3+Lnd0wFNK4iS4E09dKh++OEvtcizjbV6JaFfr62F02OJdY5YoU6o513HIUlJ3zNjqRPkwWomBlgg1oInrrqkYqypUYNz7ZyfYIoMaiyEHxQvI/Lg2As2n56Ts4+Jywy1qJe9qMczkQ+6QX1CZPnlJzYYzRvNjfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAa723Nb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721947592; x=1753483592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=whlrPpJ/X00z7ndHglD6vPWX0hJEVO8LEEwDUpISOys=;
  b=FAa723Nb88qrV+ykfOb+j5o7F6iFNQEDvgEA7VxMAsrOjyF4r2ihjqV5
   gXWOSa3w27XBSImf89hcEo7oCBF6627vn834h7/iPe5viFM+cioFG9HvE
   1ZrYItLKoMMxQlVrOGI/YqK2MimVy5aeDnmSB0+p2F44ktbfG19qkARB8
   gsWIAjao7s2IzIs1DjDYFdYArezOb5qd0kfnBwEeYtKtdvaFq8T9QAgAR
   VgIFRITz/SlzLqBYdm96vUgOgjupN32K96J3psDB2bgVZMujBiJT2LMit
   gmww+x+L5030q8WZaZklD6ZsXdhS3UjZscA0imhG4jvmaoyt5TCVWEO7s
   A==;
X-CSE-ConnectionGUID: UCcu3msvTFyZSbjf2XqViw==
X-CSE-MsgGUID: 8CrB8KsAQWao9Ky/oJOjpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="30340430"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="30340430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:46:31 -0700
X-CSE-ConnectionGUID: 1tnOmP6QQZWQ0dVHDujVew==
X-CSE-MsgGUID: StDzRJVZTkCh9s59lbDVgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="90551411"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:46:31 -0700
Date: Thu, 25 Jul 2024 15:46:30 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	osandov@osandov.com, song@kernel.org,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2 bpf-next 05/10] lib/buildid: implement sleepable
 build_id_parse() API
Message-ID: <ZqLVxh2Ij6AovoJD@tassilo>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724225210.545423-6-andrii@kernel.org>

On Wed, Jul 24, 2024 at 03:52:05PM -0700, Andrii Nakryiko wrote:
> Extend freader with a flag specifying whether it's OK to cause page
> fault to fetch file data that is not already physically present in
> memory. With this, it's now easy to wait for data if the caller is
> running in sleepable (faultable) context.

How does that interact with kmap_local disabling preemption on highmem?


