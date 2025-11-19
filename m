Return-Path: <bpf+bounces-75088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E9BC7003C
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F0AA5008C8
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7C92E7F17;
	Wed, 19 Nov 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="LjTgYk2J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE42D59F7
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568251; cv=none; b=ircBQuiGtWGHomfQKIRX6Kk86xMERnGTIUVzW8SphgjPqAGFDXnlXVnh09bcZRjG9vdv0kEbqRMNXgBDtkAHRtrK8MgXO/+XiG4HVQKYqnGzRdSsb8h66UuWlpDowOU/90OGN5JZpwoCjGDqEzxyIxZT/ntj9elBBfbvgjVhHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568251; c=relaxed/simple;
	bh=D1dvfyFZn4fTD9P3L+aKcIof/xv5wKDsxEsuv77eNVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUT2BI0+Ds5rmBfj0bDh+OFY+S/7k408CbqQpT5qjdHvfeZg04Uis9aLEErM6IaFNzcG5HkXKvUIB5TPV7SNanBLgc3oNRaU8W5UiSy8gFOkHslB8y2my9JBjJWgJstgdVTk70cH8PX8aqOgf3uz3iVUqtuXhI0YePK7cqrnQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=LjTgYk2J; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 6E49811F74C
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 17:03:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 6E49811F74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1763568238; bh=aXRl5LbIe4SIxI+2jkbPFXSrdC9cHgsePOTDOOLMIW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjTgYk2JNptea4uz75Vz6WF/3FFuNtMjOcMupXj1Vz5g0rRhvurKmPOdx/tXIfzZK
	 SsRjpk+0qN25IyIpc0IeS1EuyAdSk7OHTgv+GsM8G1jzT+gvXX6qdqrBSpq50SUaqc
	 HCOE8KOho2kVIUfH6rNfzxSklhDqV/On9ZDuqoQk=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 603DF120043;
	Wed, 19 Nov 2025 17:03:58 +0100 (CET)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [194.95.239.47])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 51F7A40044;
	Wed, 19 Nov 2025 17:03:58 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [IPv6:2001:638:700:1038::1:52])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 9721D100033;
	Wed, 19 Nov 2025 17:03:57 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 7738780046;
	Wed, 19 Nov 2025 17:03:57 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id 70061201AE; Wed, 19 Nov 2025 17:03:57 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v6 bpf-next 0/4] bpf: properly verify tail call behavior
Date: Wed, 19 Nov 2025 17:03:51 +0100
Message-ID: <20251119160355.1160932-1-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <622f4e7645e426ae180e4511877eb90ceb1b1063.camel@gmail.com>
References: <622f4e7645e426ae180e4511877eb90ceb1b1063.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eduard, Hi Alexei, Hi List,

thanks for the good feedback.

Some details:

Eduard wrote:

> > +			env->insn_idx--;
>
> This insn_idx adjustment is a bit unfortunate, but refactoring getting
> rid of it is probably out of scope for this series.

Indeed. I tried hard to avoid it but couldn't find a way that would not have
let this patch explode. Similarly, check_helper_call by now ends with a lot
of if's checking func_id. This should at some point probably be replaced by
a switch statement.

Eduard also wrote:

> > +__msg("mark_precise: frame0: parent state regs=r0 stack=:  R0=Pscalar() R6=map_value(map=.data.vals,ks=4,vs=16) R10=fp0")
>
> Nit: I'd add a couple more lines to this __msg sequence to check that
>      backtrack_insn correctly moved one frame down.

I added some more __msg lines where it enters the subprogram, that's where the
patch changes behavior.

Cheers

Martin

Eduard Zingerman (2):
  bpf: correct stack liveness for tail calls
  bpf: test the correct stack liveness of tail calls

Martin Teichmann (2):
  bpf: properly verify tail call behavior
  bpf: test the proper verification of tail calls

 include/linux/bpf_verifier.h                  |  5 +-
 kernel/bpf/liveness.c                         |  7 ++-
 kernel/bpf/verifier.c                         | 60 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_live_stack.c | 50 ++++++++++++++++
 .../selftests/bpf/progs/verifier_sock.c       | 39 +++++++++++-
 .../bpf/progs/verifier_subprog_precision.c    | 53 ++++++++++++++++
 6 files changed, 202 insertions(+), 12 deletions(-)

-- 
2.43.0


