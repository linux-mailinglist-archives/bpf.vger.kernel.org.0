Return-Path: <bpf+bounces-16757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54175805CEF
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D441C20FC2
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14A675B2;
	Tue,  5 Dec 2023 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTQllM/9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241B3FB3D;
	Tue,  5 Dec 2023 18:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E784C433C8;
	Tue,  5 Dec 2023 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701799803;
	bh=LU1lm5euECpqcvRwZ7jyN4+iInnCJKP6smuWa4x8dak=;
	h=Date:From:To:Cc:Subject:From;
	b=aTQllM/9zBjVF6JB6gnBDZtrpFBcTDUDKx96BRAHx0Eyt/NGJZWyLXCkAgTWZ9Kw8
	 QBeZIcfOP2r6iXUoDGbQ5PKGXAKYBiIc2PAaDlvpYZ4tLGYuY3A6rVwPKb7Ny6kHu4
	 kui4NGYkf4LwppIc1tJLQyfhZA6LkAkFHeMxn0UzQ7zZH0Bv1lYtyTGtBwfgNIwzoe
	 QXBIiDTmxjQWHDXSz9d/UJ+9S6TKWGGLrc3DnldOtGwq8I78xmKKK/ElhhJXiZgxOQ
	 rhWlmt2A52hFcQ37mBnwXAHR0usnhimh0XqtzlAO5ntow5CnCbNqSrL/B/9CGL0SaR
	 ymI3Afbec+8eg==
Date: Tue, 5 Dec 2023 10:10:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, fw@strlen.de, pablo@netfilter.org,
 torvalds@linux-foundation.org, bpf@vger.kernel.org
Subject: [ANN] Winter break shutdown plan
Message-ID: <20231205101002.1c09e027@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

tl;dr net-next will be closed Dec 23rd - Jan 1st (incl.)

Last year the winter holidays fell right after the v6.3 merge window.
We used this as an opportunity to extend the net-next shutdown over
the winter and new year's celebrations. The concept of shutting down
-next development seems to have overwhelming support, the real question
is whether to shut down for one or two weeks, rather than whether to
shut down at all.

The timing of the merge window is not as lucky this time. We will have
to do a "mid-cycle shutdown". net-next will "close" for feature
development, refactoring, etc. Because some code will exist in net-next
only, however, net-next will remain open for fixes. A bit confusing, but
hopefully we all understand what a fix is ;) Maybe a better way 
to phrase the shutdown this time would be "fixes only" rather than
"net-next is closed".

Regarding timing - we did a small poll among developers and/or
attendees of the bi-weekly call and the conclusion seems to be
that we should shut down on Dec 23rd (Saturday) and reopen on Jan 2nd.
Two-week shutdown had some support but it's hard to know whether to
fit the extra week before Christmas or after New Year or to split it...

Depending on the urgency and volume of fixes we hope to also skip
the PR to Linus on Dec 28th.

Hopefully the merge window for v6.8 will open on Jan 7th or 14th,
giving us at least a week to settle any -next code which is ready
after the break.

As always during net-next closures RFC posting of net-next code are
not be discouraged.

