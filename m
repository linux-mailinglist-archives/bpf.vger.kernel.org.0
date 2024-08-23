Return-Path: <bpf+bounces-37917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7AC95C329
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 04:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B0B284704
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228061C694;
	Fri, 23 Aug 2024 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PMLzNK/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904821CD00
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724379600; cv=none; b=YmUCoNM6uh/jqhlcaekIADir7gEnTWe6qoHU2jnmE+B4Zu3fcAEXIvcZT8IcpjR1+pXj/q5kD/yFm/DdKAJlKyU8Ng9vkW/P4ruZq9HiTnZCJix3DIWACp0/E9UFPH+k89OoOddWjZ39iZL27bbYB7AkM7AfOhO+6tcQVkr/+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724379600; c=relaxed/simple;
	bh=kqKGVXaBuMbvE0nOrMIZkXFmNuTFw1QPsV5sRh+9eJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cWUwrzGw8/4rIGzUU3P3O//j+XrDDWfv9E1nT1Jb/l31ot4s3rUNUE1IQgGvwbRq1/vxaTpjW5CpXxFnU2ziwEMnkt29YojtGQYHCq+hPRXlkoc2jD7xvErMQyqdNfIP7ATItFAKKMgQfrcpW+fpXJhSyyAMFM8fUsGaEnScA7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PMLzNK/E; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371ba7e46easo682504f8f.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 19:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724379597; x=1724984397; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpITzH/ChCJ6L3eyHjuDVZ8jKyXR90GFT16jJ4SePRU=;
        b=PMLzNK/EGXedNK6V53Ugsp3lsQxL1Q8bcSLlxmWm8SWH119RelqxPXlLRp9G0lJGir
         rp5e/40qZ3y1WdNBThFu0jNg/sOEj60iP0BDzmYqdcg+BxnZ9vAkPLrVfeUriUkCRRsP
         ixHbGEc8/SK0CuWwot89onpV8Ms+YH/RcgrQ2MB3BVxo2t1pimXnCy09sNRpQ2/seLZQ
         0bWbq3L0NlJFb8d+5NrsLkV86wrJCdslFy6Zo5sc24v7OFtgsNNwlNyruPvz+7X8wN+k
         jZQ1Nmiy72NVSUG1oJeqQm1LC2qx2NSiTu6RbAgLX3MGevaT5fkIkW8B/7MRUuNkVH/S
         W7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724379597; x=1724984397;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpITzH/ChCJ6L3eyHjuDVZ8jKyXR90GFT16jJ4SePRU=;
        b=dkHR7qIyM5tsK9AlXkxBZrBKuYf9eDW0dSEix7j/d4ZAxkBOilbI3BBGIW8T8wVurv
         cv6l/kio0363SLnzBeE+uPWIiC3gHNS/B9eanBBt9gKSKRaQ3DT9QStKjuJ3ex7qPQDT
         4OpxBP8WfXyugI/MxpWf3hhBjCo/tyOBrhlDIhMAnW003hMeN4pUaKp0rqFciLitwEw0
         zw3+xw3tz80s6ZzmlzmU5DucNf9cnnBAROx/VrQILVP/tp0fdpkQw791sJQYhm12vOZ6
         GPIVxNsOTo9KFRRPAcdXs+0ZQgDWTnaDo49KdgQCnGO8WTfQaWh/Gn7VLaP/ymBDS6KI
         ceYw==
X-Gm-Message-State: AOJu0Yxo1aoXS0p2a1MupBmsCVtJ0qvtsddbb/h3yuNv0vh/GSrAfEor
	mnLHMrf1Ci6YAuOb+3zGSIKDbV+BBYtGIKWnqMd4na3cud+i9mVfDbtGZIFxTAw=
X-Google-Smtp-Source: AGHT+IEDoPzw03NhboOgRdg27IgdOACMeXwXANCZ8My/LVaHEufViIzTWeOOmFxTsV+/Wt73zw0sZw==
X-Received: by 2002:a05:6000:1374:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-373118c7bf7mr336842f8f.46.1724379596678;
        Thu, 22 Aug 2024 19:19:56 -0700 (PDT)
Received: from u94a (27-51-129-77.adsl.fetnet.net. [27.51.129.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba263f0sm4976429a91.33.2024.08.22.19.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 19:19:56 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:19:49 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: kernel-ci@meta.com
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, Alexei Starovoitov <ast@kernel.org>, 
	Manu Bretelle <chantra@meta.com>
Subject: BPF CI and stable backports (was Re: [PATCH stable 6.6 2/2]
 selftests/bpf: Add a test to verify previous stacksafe() fix)
Message-ID: <pybgmvfeil5euvdz7vs7ioacncrgiz4lnvy5sj3o4prypgsdd4@tzc2ecsmyt6g>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Aug 23, 2024 at 01:53:48AM GMT, bot+bpf-ci@kernel.org wrote:
[...]
> CI has tested the following submission:
> Status:     CONFLICT
> Name:       [stable,6.6,2/2] selftests/bpf: Add a test to verify previous stacksafe() fix
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=882411&state=*
> PR:         https://github.com/kernel-patches/bpf/pull/7584
> 
> Please rebase your submission onto the most recent upstream change and resubmit
> the patch to get it tested again.

It seems the BPF CI picks up stable patches and tries to apply it on top
of bpf-next, which fails to due conflict. Could a filter be added to CI
so these are ignored instead? (Or have BPF CI apply and test against
stable/linux-*, but that seems too much to ask)

OTOH if maintainers and reviewers prefers stable backport not to be sent
to the BPF mailing list, I will drop the CC to BPF mailing list in the
future.

Thanks,
Shung-Hsi

[...]

