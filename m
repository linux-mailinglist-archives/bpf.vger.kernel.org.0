Return-Path: <bpf+bounces-64806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37794B17161
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BAD1899AFE
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D590239E9F;
	Thu, 31 Jul 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXoftS7d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39322A7EF;
	Thu, 31 Jul 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965460; cv=none; b=gjINg2WgXxzMYK6t7Z4Ty+5mIoDrz2sC5JiGVqwct+cpNvYSaL9fDyYS0LE4FuwfqcJXOeNZ2gndr0qtPR1L5QQ3BJQUTDRNmoWh1op7xslY6TIboZ4e8bhPxGYwW/3J92aNiUiRHJFabTvbT3cg4GdDfEZeSOzQwai792dBzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965460; c=relaxed/simple;
	bh=F4N7j7/R3qLxjx+q87bCvU+pu2qGV4lJnYfHs/FMkUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuGmyncbkkYcxJpKD1JnaXPDlGf7q0dxROZaT4XBFWGVu98VeIP+qX1yXSmqQM2K5quQSEifDT6sl20pe5BrNfTN0TmfPt9fy6vgaitfqJCguDLkQzTHF3Kg/F1v7LgSI5Jn49/01OQfUkpMsZxkv5FZzDStZ9jGQr6W6wx+tPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXoftS7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F192C4CEEF;
	Thu, 31 Jul 2025 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753965459;
	bh=F4N7j7/R3qLxjx+q87bCvU+pu2qGV4lJnYfHs/FMkUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXoftS7d09eZDDde0RkubC0VZ4i2xxqIuOF6q5qj6gKuaj4qQULek3H0nC+TRCw7h
	 mpmzhVdFQbqqNryB8UMw19P4ZXimeqkuL/x+WWKXSsDQYnaNAFA0xcG+SxQ9SQeDL6
	 jt9KNxFBXbNn0zJE94zFraiz2qqztJSCsY8XVMHsBqGn+VPrEZXLcW/zCWM2DEwHeD
	 w/sT+a2v54oKoLYPDDOEsQ4qOhudihIDk/hFVjum3UrRfL/YmbskI7NoPxzgFvHfNN
	 sSJ4GV1poAd4kYFa7O/NMpLlHkXxr9yrQ73sNlAvnIpi30ge4kQOJrj5ne6yWmG+nj
	 WuDhERQm2e0JA==
Date: Thu, 31 Jul 2025 13:37:34 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	nxne.cnse.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 16/18] idpf: add support for XDP on Rx
Message-ID: <20250731123734.GA8494@horms.kernel.org>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
 <20250730160717.28976-17-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730160717.28976-17-aleksander.lobakin@intel.com>

+ Kees, linux-hardening

On Wed, Jul 30, 2025 at 06:07:15PM +0200, Alexander Lobakin wrote:
> Use libeth XDP infra to support running XDP program on Rx polling.
> This includes all of the possible verdicts/actions.
> XDP Tx queues are cleaned only in "lazy" mode when there are less than
> 1/4 free descriptors left on the ring. libeth helper macros to define
> driver-specific XDP functions make sure the compiler could uninline
> them when needed.
> Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
> applicable. It really gives some good boosts and code size reduction
> on x86_64.
> 
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Hi Alexander, all,

Sorry for providing review of __LIBETH_WORD_ACCESS[1] after the fact.
I had missed it earlier.

While I appreciate the desire for improved performance and nicer code
generation. I think the idea of writing 64 bits of data to the
address of a 32 bit member of a structure goes against the direction
of hardening work by Kees and others.

Indeed, it seems to me this is the kind of thing that struct_group()
aims to avoid.

In this case struct group() doesn't seem like the best option,
because it would provide a 64-bit buffer that we can memcpy into.
But it seems altogether better to simply assign u64 value to a u64 member.

So I'm wondering if an approach along the following lines is appropriate
(Very lightly compile tested only!).

And yes, there is room for improvement of the wording of the comment
I included below.

diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index f4880b50e804..a7d3d8e44aa6 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -1283,11 +1283,7 @@ static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
 	const struct page *page = __netmem_to_page(fqe->netmem);
 
 #ifdef __LIBETH_WORD_ACCESS
-	static_assert(offsetofend(typeof(xdp->base), flags) -
-		      offsetof(typeof(xdp->base), frame_sz) ==
-		      sizeof(u64));
-
-	*(u64 *)&xdp->base.frame_sz = fqe->truesize;
+	xdp->base.frame_sz_le_qword = fqe->truesize;
 #else
 	xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
 #endif
diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb11..b5eedeb82c9b 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -85,8 +85,19 @@ struct xdp_buff {
 	void *data_hard_start;
 	struct xdp_rxq_info *rxq;
 	struct xdp_txq_info *txq;
-	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
-	u32 flags; /* supported values defined in xdp_buff_flags */
+	union {
+		/* Allow setting frame_sz and flags as a single u64 on
+		 * little endian systems. This may may give optimal
+		 * performance. */
+		u64 frame_sz_le_qword;
+		struct {
+			/* Frame size to deduce data_hard_end/reserved
+			 * tailroom. */
+			u32 frame_sz;
+			/* Supported values defined in xdp_buff_flags. */
+			u32 flags;
+		};
+	};
 };
 
 static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)

[1] https://git.kernel.org/torvalds/c/80bae9df2108


...

