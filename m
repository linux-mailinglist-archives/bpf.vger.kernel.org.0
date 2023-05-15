Return-Path: <bpf+bounces-500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE0702678
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 09:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B02810E7
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F282848C;
	Mon, 15 May 2023 07:55:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EA1FB1
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 07:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4D3C433D2;
	Mon, 15 May 2023 07:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684137305;
	bh=GGdXABU/W294z2dz02XJk9M2U2KkDKc5eHvI9rMuB34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IicAj9RdI3pzCJbc+9esIPILMu3vFaLdLbJ3i4KInRUfgshHs1466v4vgWYlmxQ1e
	 DZu2ksv86KSQAOtGc7wUsjeZUd7ktER7/alCxD49YRLFIyNA2UWoxFru+KrgZQuayG
	 MZGqQFUC9ku81RPTauWqA2iZpvwd5DvvuTEEvDCsyxfBBFVq7TlWDJ2Hkdc7qw3tJG
	 W/yd6nbF9CLO9Df9i5lw1plJuRqQynvNJI7K3+yZ67vDo0O4NX22MXbAQGbR7hQOo4
	 lF0DYoVPDuGH+R6e2SVtr91laXvyZKBYUs5fGdaM4xln7vy5bUZLwnMOrrOC+pSlhr
	 lAaDMBNuD02mw==
Date: Mon, 15 May 2023 09:54:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrei Vagin <avagin@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 7/9] kernel: use new capable_any functionality
Message-ID: <20230515-anhalten-begleichen-b85fa6b38195@brauner>
References: <20230511142535.732324-1-cgzones@googlemail.com>
 <20230511142535.732324-7-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511142535.732324-7-cgzones@googlemail.com>

On Thu, May 11, 2023 at 04:25:30PM +0200, Christian Göttsche wrote:
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

