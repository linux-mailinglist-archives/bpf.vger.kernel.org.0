Return-Path: <bpf+bounces-9518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAF6798A8F
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294AD1C20AFB
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0530A134CD;
	Fri,  8 Sep 2023 16:15:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113C4C93;
	Fri,  8 Sep 2023 16:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E2DC433C7;
	Fri,  8 Sep 2023 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694189729;
	bh=2w5Z4GfoET6f+1/N/jA7cwHt2hyj4wSuPoLNS7aECD0=;
	h=Date:From:To:Cc:Subject:From;
	b=jYrrFR9Dgd5k7JRcgUBVAjm4nwG7TSoXGy3O4sKlnmaeSJhMdQAyXRux6tk8aTDoP
	 wmTEqjnC6QNnMpn4oAca6EoNHOXHWQm4SCiH8jtqHWTuDAFRK57E/2Sofd+MMtRN95
	 F8SfBPHtWOlK6lZknvERf+yZa+Fy1dq6+MqywcLrSdrHnp4iCanYBMg5vjO4GOaXnj
	 WBYmT4A7BBVu1e0VmR2yP+lKiO+UxBZOjR8wZKIUbJJJrTewDnFRk/WRnTbUCEqDpQ
	 dn3S+noN5lImROnIRUixlEoocIIh+SobC8k91UlJj40kKCYFQ/ytwBMtAuXhqD6BAz
	 z4NQJej5DoKUQ==
Date: Fri, 8 Sep 2023 09:15:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Apply 13e07691a16f and co. to linux-6.1.y
Message-ID: <20230908161526.GA3344687@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please consider applying the following commits to 6.1 (they all picked
cleanly for me):

630ae80ea1dd ("tools lib subcmd: Add install target")
77dce6890a2a ("tools lib subcmd: Make install_headers clearer")
5d890591db6b ("tools lib subcmd: Add dependency test to install_headers")
0e43662e61f2 ("tools/resolve_btfids: Use pkg-config to locate libelf")
af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
e0975ab92f24 ("tools/resolve_btfids: Tidy HOST_OVERRIDES")
2531ba0e4ae6 ("tools/resolve_btfids: Pass HOSTCFLAGS as EXTRA_CFLAGS to prepare targets")
edd75c802855 ("tools/resolve_btfids: Fix setting HOSTCFLAGS")

The most critical change is 13e07691a16f, which resolves a missing
EXTRA_CFLAGS to the libsubcmd build. Without that EXTRA_CFLAGS, the
Android hermetic toolchain kernel build fails on host distributions
using glibc 2.38 and newer. The majority of those commits are strictly
needed due to dependency/fixes requirements, the few that are not still
seem to be worth bringing in for ease of backporting the rest and do not
appear to cause any problems.

I proposed another solution downstream, which may be more palatable if
people have concerns about this list of changes and the risk of
regressions, but Ian seemed to have some concerns on that thread around
that path and suggested this series of backports instead:

https://android-review.googlesource.com/c/kernel/common/+/2745896

While the number of patches seems large, the final changes are pretty
well self-contained.

Cheers,
Nathan

