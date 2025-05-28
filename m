Return-Path: <bpf+bounces-59173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B0AC6B02
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 15:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFCF4E557E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6782882A6;
	Wed, 28 May 2025 13:50:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C914E2F2;
	Wed, 28 May 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440252; cv=none; b=fJAxWqBRTRzMVcZX1Ns0HgG6M+2B6muEwBJruOGS4xAon8spqaBtWIlgkibOkdTqtN0ywqwD607yMia8qU3QgatXfigTeepPagGPhWA/4zyAYYHuNeDN9Lb7jH30EUS54Ow3g2l/6THRAqmDqHc6w+d/t5E05zm24qK+e7DT+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440252; c=relaxed/simple;
	bh=PJgWTfGidrPmfVhado8gvfzsvWoybwmRfTPeu3u2Oys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWbpAX6c8Q6nTAKRhtfkgZQTsaeI/mJWzB0gGtLTEXT51KhmHM870wuPOeDLyUSfHZc/IouuBDqoHweFumFM57R772OE1KRcR1xrAfCy374M5mz4iRT7hImY3C+YNEFmq3/bicymhj01oeXDuSTI2LjKGWdywbgy9j8rozspDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3441C4CEE7;
	Wed, 28 May 2025 13:50:50 +0000 (UTC)
Date: Wed, 28 May 2025 09:51:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, jolsa@kernel.org, bpf@vger.kernel.org,
 Menglong Dong <dongml2@chinatelecom.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/25] bpf: tracing multi-link support
Message-ID: <20250528095150.02e28aec@gandalf.local.home>
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 11:46:47 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> After four months, I finally finish the coding and testing of this series.
> This is my first time to write such a complex series, and it's so hard :/
> Anyway, I finished it.
> (I'm scared :/)
> 

Note, sending out a complex series like this at the start of the merge
window is not good timing.

Most kernel maintainers will not be able to even look at this until the
merge window is closed (in two weeks).

That includes myself.

-- Steve

