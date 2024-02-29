Return-Path: <bpf+bounces-23049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F65186CBC5
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 15:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FA5B23E9D
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 14:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136D13775B;
	Thu, 29 Feb 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWyzPnVq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F336137757
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217571; cv=none; b=NAPNMBpj5ZOOL7xbX+dg1mBEmEMet9vSgm0kVcoO7wE3XCPFY5EkkM0f437dYzNbLn0GMajiWC/rMuDR5Z0Iwgr3xtXmlmCrg4IDC0U1U2Lu4eN/iZf6bIBoieS9c0TlGEGHaAgvc2Wp26IxWyXla0Rr5nzosLkbrnTIr4opTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217571; c=relaxed/simple;
	bh=U3QtwdSYVJ8B3X+I7hGxMFhZDBbQjj3ya7O/mHzfpH8=;
	h=From:Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IoYbHXg9v/kzfETsHGtbZe45w20pBYgPIRpkWlaOXd2G94kBTPrwcBagDZqIkoapG4dOf02ZBR+K6bTtoxW3OX1hj7Squ1mJ9oPzo9j1Zks4SJtJtLSA1Wg7o8KEAukgaURDyvF6m5GvZ+d7xjoeN1wGnLVTjbcMk+XPfreICSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWyzPnVq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b700c8ebso1050584e87.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709217567; x=1709822367; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDK6ftNu/COIulraGfnqFeADle+bT3+2glCggIKBvnY=;
        b=LWyzPnVqi2uxfKttxGiPvedhESVoTEvPnluhyXB6c/ugG2s9t/3ezYH8JegHaROvgP
         bk1ZglyO0WA3Esg/sInrjgDS15lxqqSDky6C5loll0NvVWrloWwi039fAPr446xfeUAQ
         FxHLqGdMg0wJR0oHZTts605bgaeTvEDWdV4My6A8lrPgoGJgWg7qe2TT1N6wPJCY7TWj
         TtBsf/OwCI5kVi5dwg9zGfQOjOiCKu0imlaIXlS132yxOiBGRIMOjyh3NaEbQDWRdNrj
         Ezc4QUCCsT06RSW+aqMcblDTJI1it1qO4HkE6lhS0bsqiAW1hhjBxnyW1723eDicbX7R
         OAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709217567; x=1709822367;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDK6ftNu/COIulraGfnqFeADle+bT3+2glCggIKBvnY=;
        b=GglIFAbV4NXO1vIjW2fGhAcGfcVNJBPrVrO9iKXoAwYzOI5pUd3paNv8PHqGq3Z46K
         HECOvJtnhNWhwLVLEMTz2/+KiMhG3E5vCYCLpyWdv+nhlL/ITj4Cx4VE4/Oe0O1I3RbC
         i8AH6h9sDfJ6aLRSBuxJe3fnbZTYor1i0f3NjvHTN6vTDR5Wp9/iXd5UMtjs7MXbY7m4
         FRRUOsLwjFd+LgY15pFcBUmu2JpD0XzWpucJJKb6sXpdvJNOosRKN0n4sR84d0yH5z3j
         /2NWg4UrxlkfrUe5jiOELiXPJZe8sN7qmCs45CfVjqDYx+0BjCfd4+zvgVqOOCiItwRB
         MG1w==
X-Gm-Message-State: AOJu0YxnWBWVRF+aL1Zr52BjIUUVYGbWv4MDhUoDtMzubc9DR3idgkrK
	SkGIghyoxPjrU3vCBSnl6z1Hod9VJVwe/WvU9NcgTimPQCtArzH7x48tWW1k
X-Google-Smtp-Source: AGHT+IHcXdLrRELmiNGVCxwG01DFzC4cdXA8RZ3KHFlcBU6gykI7JyAucRC+3Ql0aM4EI9vRp1eMgQ==
X-Received: by 2002:a19:8c5c:0:b0:513:28b4:84f4 with SMTP id i28-20020a198c5c000000b0051328b484f4mr1082188lfj.22.1709217567279;
        Thu, 29 Feb 2024 06:39:27 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f17-20020adfb611000000b0033d9f0dcb35sm1910582wre.87.2024.02.29.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:39:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Feb 2024 15:39:24 +0100
To: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <ZeCXHKJ--iYYbmLj@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

One of uprobe pain points is having slow execution that involves
two traps in worst case scenario or single trap if the original
instruction can be emulated. For return uprobes there's one extra
trap on top of that.

My current idea on how to make this faster is to follow the optimized
kprobes and replace the normal uprobe trap instruction with jump to
user space trampoline that:

  - executes syscall to call uprobe consumers callbacks
  - executes original instructions
  - jumps back to continue with the original code

There are of course corner cases where above will have trouble or
won't work completely, like:

  - executing original instructions in the trampoline is tricky wrt
    rip relative addressing

  - some instructions we can't move to trampoline at all

  - the uprobe address is on page boundary so the jump instruction to
    trampoline would span across 2 pages, hence the page replace won't
    be atomic, which might cause issues

  - ... ? many others I'm sure

Still with all the limitations I think we could be able to speed up
some amount of the uprobes, which seems worth doing.

I'd like to have the discussion on the topic and get some agreement
or directions on how this should be done.

