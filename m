Return-Path: <bpf+bounces-23023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA32F86C346
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 09:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811E8284AD1
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2334B5DA;
	Thu, 29 Feb 2024 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H3uKgkjg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1945BE0
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194568; cv=none; b=KGxWCme8TtX5zqJzMgN6HnquZcYWKeMCNLFeOmQUw5IKMIr/PyKhlnnr0wY+p9M+EYXrwSaQm4vj4eD/xSB85tkfP2x/EPr+nPk2ScHqL4bCAqRswgkg8WZq3LXSlCaNwO++IUeqCgcXcV9xtdNY7apFjcGIkmMB64SXNHxSYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194568; c=relaxed/simple;
	bh=ru+ftwQ/yvR76JmpH6IIqxVxLN2/dN7BW2J5iiXgS1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kBJzZwxRiTX9lvSzGDxOQZbvtWGp+3kCXZUSw0sKDe3s6YLI2RQKCifPcF77XsmPnrGXQvq1Py9pOZ/rDXDuh6Kn5w6lnQmymp5DKZpWCeGbewLuyqw4kr0FZj9gg6OwCLgsPE/rX9/QuI6L/SvFWoHcmMpIW63G8E0y5eyPNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H3uKgkjg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5131c0691feso675800e87.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709194563; x=1709799363; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ru+ftwQ/yvR76JmpH6IIqxVxLN2/dN7BW2J5iiXgS1s=;
        b=H3uKgkjgL/jLnF6NiOKUKVAikyNP5PNKP0bpbrRs65vaEwQqaomgpZnQy/sPbr/gUZ
         e2OLDmRCY60tdgt23n1rLyHNiiv40IkegtR+hPXNyo6Gawz2n7ZLiMMRgB929L9PMFWJ
         sw9T27tTjf1ApC4V6gVAR5GESfsjzDsafQkEJlvbdIQclgaDsoR/66EXrkNhHML3Q2KW
         N8IeHYDDGxYTz2tpp5azRF6f0ORlic/xqmfocBub0FBGHB0B63mIV19ud1FL8zJ7cHQB
         88ZRJ5qzE4xnxZlDtwEwoz4V/JPtzAd45GZ55WAiCqGlMNekucDGLcrdQIPeD4g9k+07
         SS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194563; x=1709799363;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ru+ftwQ/yvR76JmpH6IIqxVxLN2/dN7BW2J5iiXgS1s=;
        b=SbzTh008qIRNnfUXjuDHpKSdEnxtA1OWOOxRe7kEJtiMawCNAt3LyV7xO99FMsoLYV
         HFUd+250oOmZRYTf6ZWwcvyIF43/uFfu3cLmwR7FNZblvc4wEGha2mEjuVPEgmNRtK27
         2r3ZjRdprx9WVjDXZkKrg6yYNLKfjLAvRuv7Ni6WZDHwIMNJjgEW+J57iYJ3PhRJPHFk
         Uh8zveeLb0Hku0rRCM2oy5ySJRhv4KcTZ2SurQkkKFgRHjN/eRytWV8Lw4BDykQfOtSa
         jyuBvDAxH8Whka6Rp3Vyz1sVPeuHOVTGjf7/hKJCodd/z21Aj84pmKArhwWD4aXL6Vcp
         tMAw==
X-Gm-Message-State: AOJu0YwKYtekOTrMziBiHnpGzB1uNZB0Z8NPInLoPKZS8n8ECsfET9ep
	jfD/QJPZvyU2Ga9x9FnHrKDNeC1+6PAo/d3I3I1BA+AGqWVaW2/cdczRtGaT9FY=
X-Google-Smtp-Source: AGHT+IH5tZ5J31RHIBI6NN61xC10cXMU2usFrYF+qTCcRQWJj33tXf3gDXwe/P5G9mL+7sz0FOd/qA==
X-Received: by 2002:ac2:446b:0:b0:513:1cde:a1a1 with SMTP id y11-20020ac2446b000000b005131cdea1a1mr771357lfl.38.1709194562774;
        Thu, 29 Feb 2024 00:16:02 -0800 (PST)
Received: from u94a (27-53-115-189.adsl.fetnet.net. [27.53.115.189])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001dbbe6f1dc5sm817012pln.40.2024.02.29.00.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:16:02 -0800 (PST)
Date: Thu, 29 Feb 2024 16:15:34 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, Paul Chaignon <paul@isovalent.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [LSF/MM/BPF TOPIC] Value Tracking in Verifier
Message-ID: <ZeA9Jqug3NqPwjtQ@u94a>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I'd like propose a discussion about BPF verifier itself. To avoid being too
vague, this proposition limits to value tracking (i.e. var_off and
*{min,max}_value in bpf_reg_state); taking a very brief look at the
challenges of current implementation, and maybe alternative implementation
like PREVAIL[1]. Before heading on to the actual discussion:
- Unify signed and unsigned min/max tracking[2]
- Refactor value tracking routines (as set-operations)
- Tracking relation between values

Admittedly the current topic is a rather narrowly scoped. The discussion
could be further expanded to be about the verifier in general as needed,
some (less concrete) ideas to discuss:
- Further reducing loop/branch states
- Lazier precision tracking
- Simplification/refactoring of codebase
- Documentation improvement


Thanks,
Shung-Hsi Yu

1: https://vbpf.github.io/
2: https://lore.kernel.org/bpf/20231108054611.19531-1-shung-hsi.yu@suse.com/

