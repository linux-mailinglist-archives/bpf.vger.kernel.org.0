Return-Path: <bpf+bounces-54350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C52A680B8
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 00:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3957A93E4
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 23:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7432066EE;
	Tue, 18 Mar 2025 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U0HlWR7L"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FE1EF372
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340794; cv=none; b=kOQKFuZRoakYQSucBSqFqDDJCxvvW4/cNr4MALeszxlhf/R6BASO2p5RCnJ17HpKXGZfY4WOjN2uuDtdBKj2iSOcgZM/u/QXT3oHYFRkYTzP6/T4F3DzVRQ68UT5DJoexB0D6AGz5+5ZTo8QYCRBKW2CFUJs/tIVCFmGlTwjbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340794; c=relaxed/simple;
	bh=xXXCQ3Cgl7/w5wAwWQBHtL2Y4AqdyS1REBPw7uefWJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSBZDTqI0lAsD1ehEHmoolYhj/Z2iFfbtcGca0ydxSF2cuaGhdwHGzqkm09851u3NwLi+Cl6GKoB4NjqHMx6qGYMAO96/mrz0bbtNP11N6b1XwsUZtGuY8tHJgac4K1qyWleZ1cFT2Z8oipei1oiYoisRTaJH0MNZ+iSFL9jt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U0HlWR7L; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08387a7e-55b0-4499-a225-07207453c8d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742340780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3g0VDVZvjKKbD7htmR0YK/Eqvc6pnALzgbyLDThChY=;
	b=U0HlWR7LL+NQhm02pd5/mJ7DD5OevAErpcCeOucUBXWo6nkX8rlWcEyCJFbRvQEETSWOWR
	EIhb+xRpw+gmNaegMy0sj3Ng2brfo6BhlUF93RLnt6jk604onUHDfr0FhsEvT+Xs8yMxoA
	M6cXU9EkHs4VEqER31SKdLN4NuY07tU=
Date: Tue, 18 Mar 2025 16:32:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket
 iterators
To: Jordan Rife <jrife@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>,
 Aditi Ghag <aditi.ghag@isovalent.com>
References: <20250313233615.2329869-1-jrife@google.com>
 <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
 <CADKFtnQyiz_r_vfyYfTvzi3MvNpRt62mDrNyEvp9tm82UcSFjQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADKFtnQyiz_r_vfyYfTvzi3MvNpRt62mDrNyEvp9tm82UcSFjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/18/25 4:09 PM, Jordan Rife wrote:
> To add to this, I actually encountered some strange behavior today
> where using bpf_sock_destroy actually /causes/ sockets to repeat
> during iteration. In my environment, I just have one socket in a
> network namespace with a socket iterator that destroys it. The
> iterator visits the same socket twice and calls bpf_sock_destroy twice
> as a result. In the UDP case (and maybe TCP, I haven't checked)
> bpf_sock_destroy() can call udp_abort (sk->sk_prot->diag_destroy()) ->
> __udp_disconnect() -> udp_v4_rehash() (sk->sk_prot->rehash(sk)) which
> rehashes the socket and moves it to a new bucket. Depending on where a
> socket lands, you may encounter it again as you progress through the
> buckets. Doing some inspection with bpftrace seems to confirm this. As
> opposed to the edge cases I described before, this is more likely. I
> noticed this when I tried to use bpf_seq_write to write something for
> every socket that got deleted for an accurate count at the end in
> userspace which seems like a fairly valid use case.

imo, this is not a problem for bpf. The bpf prog has access to many fields of a 
udp_sock (ip addresses, ports, state...etc) to make the right decision. The bpf 
prog can decide if that rehashed socket needs to be bpf_sock_destroy(), e.g. the 
saddr in this case because of inet_reset_saddr(sk) before the rehash. From the 
bpf prog's pov, the rehashed udp_sock is not much different from a new udp_sock 
getting added from the userspace into the later bucket.

