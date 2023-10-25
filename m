Return-Path: <bpf+bounces-13263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043D7D7345
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE58C281276
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD12AB5C;
	Wed, 25 Oct 2023 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0YbhcG6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D6848B
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 18:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DDCC433C8;
	Wed, 25 Oct 2023 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698258607;
	bh=Pf2TZM42jJsqSJj/dZFzMHf2pcaHavWaUTRXsZQunBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0YbhcG6K8lEeDz5PB5AS5ehwWTgNyQKKzDx2vj62nbXn8IH0Fpxrk2H2QEcAe3OL
	 e522dVDJdqGAeTMnJBlSAS6QLr8zEJO2viKLApok08xTiAH7hmaIatOpLBHAtvBIVD
	 4A4NL8+TiWDuX0pRjsUmE4Y4uzMTR1jno9Xl8KRD7sH9ilJm7okuGhTEd2h43KIsLJ
	 9ETJrnO8/tP2YeBHC/bTigNYZ+eldNQ44tVt/PRHvRdoE+2/AyAnjQ1tv0rpoy5bhO
	 wWS554Nbp4JrpTfFiosgkPRQ70Cv2JTCu5Fzpvk0D8OdGLJKG4NwnGGISgaIISBYZd
	 NlTb3/nuB/RGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B08C04035D; Wed, 25 Oct 2023 15:30:04 -0300 (-03)
Date: Wed, 25 Oct 2023 15:30:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
Message-ID: <ZTlerFwlAn3AP+o4@kernel.org>
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
 <ZTlTpYYVoYL0fls7@kernel.org>
 <ZTlVAtFw7oKaFrvl@kernel.org>
 <ZTlaoGDkALO2h95p@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTlaoGDkALO2h95p@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Oct 25, 2023 at 03:12:49PM -0300, Arnaldo Carvalho de Melo escreveu:
> But I guess the acks/reviews + my tests are enough to merge this as-is,
> thanks for your work on this!

Ok, its in the 'next' branch so that it can go thru:

https://github.com/libbpf/libbpf/actions/workflows/pahole.yml

But the previous days are all failures, probably something else is
preventing this test from succeeding? Andrii?

- Arnaldo

