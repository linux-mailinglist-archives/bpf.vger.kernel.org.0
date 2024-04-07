Return-Path: <bpf+bounces-26108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92A89AEA8
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 07:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EA71C219AE
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 05:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574B617FF;
	Sun,  7 Apr 2024 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="CgZKnpIg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298931C0DF3
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712467300; cv=none; b=N6mWQgH+HMvLnBDg9WD++ichwIwR8OGw7sPjN8EkPDtytEzRHe5SmjjWPqbNJaIqQWz7HbeeHd8gpK+RIjRrWXJbc/nKNDC/SaGMtNk6mXfmh1JR2QexHygq7rK9Hifyl+cl6t28MBHAQfUUO5KHI+6No2YKN7VNxA0bzTi6YT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712467300; c=relaxed/simple;
	bh=vbgKju6o9adXn9zCVISigse1XQaX/qMJuajNGAcxCns=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tsD1C5PvYLMJYZrdxxFYpGXRsv03w1rfha3/IgXtu5mW3UvY3Wnp51iQOi6/6kw2ll3HFrrNsKc+CX305IbQwDO7IIkAbAfz33hEibRLMai166fY6SNNq+mx9Kc331Bxznvvm8ERFWijU5DJm8wSEske+V5PEX+ud3roCkYe7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=CgZKnpIg; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d34a1ad704so149283639f.0
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 22:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1712467297; x=1713072097; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbgKju6o9adXn9zCVISigse1XQaX/qMJuajNGAcxCns=;
        b=CgZKnpIgZv2dUehQcMQteQWUk9L2IUZbEyWVY31S8O70/9wZwQ86yZSZ7N4GgZcReJ
         Sk9Il7czm9juk5Q6D+1/8uwUqPhvxI2RWZjRDhFBlTsee+/9UUKKF6K8PQKGStwAVWF+
         Yk5s9FrRYJ3DXOU8RrVRsVPuCa8tdVKHjF07o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712467297; x=1713072097;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbgKju6o9adXn9zCVISigse1XQaX/qMJuajNGAcxCns=;
        b=W4+fHgD+adfECe8gdmK+t4+SpW/d/AWRqdgc/Ui7zl9QAJN57UCOyf/nY6OVaSEWka
         VXObLVMnZVc9wLfqyFICsUt7L95ginJVa/h/PBfA5rjokecefazHs0mncSbBbxW2mKXc
         nNYwaiTvvM4yCeLpGtK4ezQsMRSaC4y4zFD+TGnCQ9ZbhiH6ZlQPuh7ExQY6WVl4XWWS
         pi5G2wMmNEcyleE3erprsH3tqtuWSM0LDWBTvJ5fHIfzy6BkxHvSRRjqevBLjKo9IGi1
         powu5gAfwDHxN+1PIw/xwyP7PyZYNGHKieV4x621ik5WtysGLy0Tz5S6JifzEWgJDGW3
         /BlA==
X-Gm-Message-State: AOJu0YzrvM0IyHX/Li38kPvzNBAGZOQZPXwqQ0d0y1NhpljQIyAJhXmv
	OLr2zoU/U9ypgaE/zKSE8/OlP1gQBgOKqmgF+snIMaVlNKOxJysSzV66Kv5PmAWiWvD/Kolxw6+
	p
X-Google-Smtp-Source: AGHT+IG6RQ3XjbJyd0Bxgk2EQnq5kj/z8wwCISk/za8fRv7br6YBvok9DA9pB0/DXrcl4wnOdOpH1Q==
X-Received: by 2002:a05:6602:1648:b0:7d3:5194:8097 with SMTP id y8-20020a056602164800b007d351948097mr6846693iow.16.1712467297615;
        Sat, 06 Apr 2024 22:21:37 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:76e8:2b8:1a80:7948])
        by smtp.gmail.com with UTF8SMTPSA id y34-20020a029525000000b0047be100ddb0sm1656829jah.98.2024.04.06.22.21.36
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 22:21:36 -0700 (PDT)
Date: Sat, 6 Apr 2024 23:21:35 -0600
From: Jose Fernandez <josef@netflix.com>
To: bpf@vger.kernel.org
Subject: Missing bpf stats for BPF_PROG_TYPE_EXT
Message-ID: <20240407052135.n3vwjrhw22kjehrh@ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

I'm the author of bpftop, a top-like monitor for bpf programs. A user reported
that for the libxdp framework, only the xdp dispatcher is getting bfp stats:
https://github.com/Netflix/bpftop/issues/15

The dispatcher created by libxdp declares a few global dummy functions to act as
the targets where BPF_PROG_TYPE_EXT programs can be hooked via the freplace
mechanism.

The missing BPF_PROG_TYPE_EXT stats result from how bpf-to-bpf freplace works.
The reference to the extension program is only kept in
trampoline->extension_prog, making the bpf_prog in bpf_prog_run() unaware that
its bpf_func was swapped. Consequently, stats are incremented only for the
target program, and not the extension program.

I believe users expect that stats for both target and extension programs to be
incremented. In the case of libxdp, the dispatcher's stats should represent an
aggregate of all programs, with each program also maintaining its independent
stats. First of all, is there any objection to this proposed behavior?

I thought of a few ways to accomplish this via a patch and I wanted to get some
guidance on which is the correct/preferred approach:

1. Add a new `extension_prog` pointer in the bpf_prog or bpf_prog_aux structs.
Then, set and clear the pointer in the same place where we set/clear
trampoline->extension_prog during bpf-to-bpf attach. Finally, when we increment
stats for the target prog, we check for the presence of the extension prog and
increment its stats.

2. Similar to 1, but we store a pointer to the extension prog's `bpf_prog_stats`
in bpf_prog.

3. Wrap the extension program's bpf_func within another function dedicated to
updating stats, and utilize the address of this wrapper function in
bpf_arch_text_poke. This approach is the least clear to me, and I'm uncertain
about its feasibility.

4. A bigger refactor that would enable this new behavior.

Thanks!
- Jose

