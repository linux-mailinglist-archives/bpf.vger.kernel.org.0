Return-Path: <bpf+bounces-53521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF12A55C41
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 01:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DD3188EF5D
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 00:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32E13C8EA;
	Fri,  7 Mar 2025 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lMDKqoV3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F893596D
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308706; cv=none; b=gQgwrWikjr3xNjtq+h91W5xCbLquuIYQ0Y/Etb/+NuuoIjitKAGwcaFXlSpI/8H4xZwZS5Mc6/7L+nKU0AMrze7dIrjWxQqMY3uWCGeWorAUKypTjNTrU1X2XvtdyVo3xRPlmocEDRduJu/h4UT0yMedReeVL1IcO/SLEHIDnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308706; c=relaxed/simple;
	bh=kXCduX4hE36U/CoaPyXGNbVZJMBuWofHOZzlZuTpgTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iam/Ci3pPRzs+0XztS8ZojwN2JGD5+76+YMFfuEzn5LQEDwJX32j+nHVSJkHOfXMRvWaz5tN8cgZKmPamxQeS7bmktgWio41XnZ6mtYEo06IzvqeewYp0gdqeQ+RDKjvJEP5eYAAsAgeAfycz5DE0M+Wi2crBbonYVUNMWcFwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lMDKqoV3; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d191bfeafbso5423605ab.0
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 16:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741308703; x=1741913503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qVyADKTsqTkTvG/3k9p/YQJZnQ6SccIWFfvUDbm2Rs=;
        b=lMDKqoV3Ho6NylRs+ZSwzivh46jge6AxuYpjjTt9Z6pZAwxYsRCYjQMUuiESBeXiV5
         g/zSYHeyPy/d6LBAlLbEjxNw/hucEUC4yd+VX+8PsT/5EGAVZNOpFw5mnGyAatLfANb+
         x2RVfxaooWafhVnxILuL5wdueUzqap0XEnFAei/0CTPhuqKm2oqA0M1h7iAiG9e3KS1k
         cZsfKi0rjgaPWZ22UVZlf0PpwYXMOU5tVIZ5jbvgyPWULw9VA6jXSEd9TXWieqHhNPqP
         4AKqBYEcMHv4GupJc1ADBwcBPUqGg5vFQ+cZFImymtS/UBLPEeSgWYa4pPVaEvo+WQdQ
         SANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741308703; x=1741913503;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qVyADKTsqTkTvG/3k9p/YQJZnQ6SccIWFfvUDbm2Rs=;
        b=qTKH+BL3uN4ejURMXycICG5y1Z0LLv6pFVxlUxke5oCOQESkLUZKQBKVlosTi2GtWN
         M7PIw3YMEWtTZSXW4440BiMYmeyIJ8HabhpgHARssDMfzl4lkhEbo3rdCcX8P4Bsd953
         eHC4l2xze9M5iDlKmWxbHtAIDYM7ywhOEZBL828ijNucueWroKl+WGV3oyWVNB2BvKNl
         96Lh0zoYn2YtVgR+J7jf6q6M67GTPMefkcQrZi3KPty2Fw1MuxN7Q7WREczedNdhqI9g
         8bqbx9OuHgABC6xPNgx/7mQuM4X7KD4ZMCVak+cgcJEB5K5YZNiKcV2knHPCEOTF+PSf
         MJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEIyvixyF+UPHfl7EykUZ+1t688ynBGlLhfmfzeRNHY9tOdrs48Vul4BO6if7ujhwWrsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSGS8z+bM6HG1FWNERi5W4ceweDofuF+wTs6ldfit5QTBx1JM
	l0ZyMFp3Maj/Y2T8OxJbhrMkvWax3ml/MtYZTQur7i54Tqw1ZP5DF0XeBADeDM8h9NoNLJquPGz
	R
X-Gm-Gg: ASbGncsK5urbgLiINAQmgZikVzFZLDRVMhRjTa+4Qu/bBuj4LR7xtjsy55hH4pETT1z
	Bb15Cvrd27uZQhOsbOgayqfN7dBU5BDdUJF/5EQ5geqo5dhwDPulRpX9nZEJ9ZXRNUZClQRKNga
	z2WRtu/FI8/Q7Mbzyu9EiehdHkkLVhOKuyEqOTwggogmPl5acPo+Lr2q9WZny8C5/c+JHyN2bRr
	rvvP5YzZChtfR65Nbgu11qiFWZrn+KfE+hSL6fSSgTSHRnOS70P105A4SDjdjMBzZ9pqbVsJ1NV
	Y7d4oeKnaUTF/OC6zK1VzcIGjACz+8Ge+1Es
X-Google-Smtp-Source: AGHT+IFvMFyVJzq0CGa/q6ARLt4ujQOSTJjZd+XWOlBRoiADhUQftyPtRq86dsu188a1/xZu5uDMzA==
X-Received: by 2002:a05:6e02:1d03:b0:3d0:4e57:bbda with SMTP id e9e14a558f8ab-3d441933046mr21325595ab.1.1741308702832;
        Thu, 06 Mar 2025 16:51:42 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b599842sm5459815ab.64.2025.03.06.16.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 16:51:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, kernel-team@meta.com, 
 Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250306-rqf_flags-v1-1-bbd64918b406@debian.org>
References: <20250306-rqf_flags-v1-1-bbd64918b406@debian.org>
Subject: Re: [PATCH] block: Name the RQF flags enum
Message-Id: <174130870132.334915.1531694322372614000.b4-ty@kernel.dk>
Date: Thu, 06 Mar 2025 17:51:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 06 Mar 2025 08:27:51 -0800, Breno Leitao wrote:
> Commit 5f89154e8e9e3445f9b59 ("block: Use enum to define RQF_x bit
> indexes") converted the RQF flags to an anonymous enum, which was
> a beneficial change. This patch goes one step further by naming the enum
> as "rqf_flags".
> 
> This naming enables exporting these flags to BPF clients, eliminating
> the need to duplicate these flags in BPF code. Instead, BPF clients can
> now access the same kernel-side values through CO:RE (Compile Once, Run
> Everywhere), as shown in this example:
> 
> [...]

Applied, thanks!

[1/1] block: Name the RQF flags enum
      commit: e7112524e5e885181cc5ae4d258f33b9dbe0b907

Best regards,
-- 
Jens Axboe




