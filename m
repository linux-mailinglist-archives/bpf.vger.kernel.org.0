Return-Path: <bpf+bounces-23192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138986EA53
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E564DB293AC
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB43D0B6;
	Fri,  1 Mar 2024 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSqtTSRz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFF13CF75
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324901; cv=none; b=ksxDTW4lYTmA6xBbyGGDVkBFoLw8xQzwTxDPFID+week0avbwOdPdx0BKkpydvhhgW2ZXMjLQtYfVKwccn73UlX9sCLMoPoBsRsH+h1iKDl6bXH0/FZoCoxGxBG1OMXuNmKI9k50IaO5QrjOtuSF4qv3T4cKm1FdS8mBJGweHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324901; c=relaxed/simple;
	bh=wHQofL8oWcGOs9nOEbfXWWsoml5sk6uiT6DI39ueUz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnzBSyFGlYB1Bv7cF0wUGcj3o+SRVXJQczQmqPh55+ngjiWhDoPFPAwd48yoZWz9/pjIbq3sd03qYjl727Tn7D4DqSMj4sOrFUlax5e2Fp5m+FcjRLv2Hetex77aj68K9DG03n4AW8Ra8CBCOFLxyhC4KG7/57YxhI9A5vJV7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSqtTSRz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc96f64c10so25481255ad.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 12:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709324899; x=1709929699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d85mSHhOXIYr8Zb7pmgfSHs4D52LKsIa711XqIK68Xk=;
        b=HSqtTSRzxWkx/Us6aLLDnl3t2geSyAFKBSEsPc/qf+zo70qVDeXLjVDNCPc2T1s4ML
         OeeakyevFjQnXxOR1E1dJtF90Fld3CEEaegRkmtWts5wBRDWFYHWv2xaomO/31IzeHsT
         znJS0/aMnWxTtKbO179n96U9JhkfLP4ZXZrRrRzizLK3jACtOSFMAVIpBRUT4Ism9HDH
         1g4mWdtnIF9WKfFr1vZIgrYw2mAwYjovBoVZtgYK1nOIxGDEXvbWjdEV/z0yO/2qOmw2
         oVEFjJGKW2rzFC1a2VvPEK5TefjM74wzlVbpvPhWqc3MKKb6ew0msRFfXtqD/qHLkwOt
         SsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324899; x=1709929699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d85mSHhOXIYr8Zb7pmgfSHs4D52LKsIa711XqIK68Xk=;
        b=f9hRH04IokUxni9ZDmvgLk1GkSlmt643lRjq/Toyw5ucQnDKAvBN2yBoUlWOwPfAo/
         8fIC+vlLajiltK/c1QjeVH+ZvXA9k3kgLmNfod8RVUCoaf47aHYp5TvRNHjG3GCF1b5W
         tU3upu8Wgd1GUY+cU3CU6ylOMCgs6+ji2hL8IgoYQgpW7c7WN/Hp5lKNjAz6+ocMJnd+
         hkfkd/+1FWggz99nR+XeoOyq1mRiM1v/NxC6Fy5SzPeNkxV3+aaVvMOYKscqXZ/ztCvh
         KfO34VB6vYrMRbNWeUa31sJWo+0Q8kTb53Qqm+gAdNukdvJvoSFu+GzNsAErSCaMJNSJ
         e6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVMMjsOXbY5YaY2A/35ZggqtG0Zsdtj+unqlDmw2pUWz2Ab2f7AaDA3Qs10INf3bLOxjK0maf4sPNgZKEyHxc0wNCM/
X-Gm-Message-State: AOJu0Yzy+vu4WBxosg13PtWn2OiZNbkLFNls03UM9LyRYmfkM6GTKBCT
	mHT0ZmhLBN+nf5AA7dst+6qFjI4XWuvJqOkhZBsw8RvcJDGAUzoT
X-Google-Smtp-Source: AGHT+IEN08O8UW9JewvSymMXj9YIhiV/w9z1UoIhyZ0FF2yjrTrFVctAaTNhvAHkgQT7esP82jRI+w==
X-Received: by 2002:a17:903:22c1:b0:1dc:5dc0:9ba with SMTP id y1-20020a17090322c100b001dc5dc009bamr3679978plg.26.1709324899518;
        Fri, 01 Mar 2024 12:28:19 -0800 (PST)
Received: from valdaarhun.localnet ([223.233.80.13])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001d8be6d1ec4sm3879306plg.39.2024.03.01.12.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:28:19 -0800 (PST)
From: Sahil <icegambit91@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Quentin Monnet <quentin@isovalent.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next] bpftool: Mount bpffs on provided dir instead of parent
 dir
Date: Sat, 02 Mar 2024 01:58:07 +0530
Message-ID: <3290360.44csPzL39Z@valdaarhun>
In-Reply-To: <d61e8537-e291-434c-b401-2b020b2b610d@isovalent.com>
References:
 <20240229130543.17491-1-icegambit91@gmail.com>
 <d61e8537-e291-434c-b401-2b020b2b610d@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Thursday, February 29, 2024 8:29:07 PM IST Quentin Monnet wrote:
> [...]
> Perhaps it would be clearer to split the logics of mount_bpffs_for_pin()
> into two subfunctions, one for directories, one for file paths. This way
> we would avoid to call malloc() and dirname() when "name" is already a
> directory, and it would be easier to follow the different cases.
> 

I was working on these changes here, and I have got a question. In the
description of the github issue [1], one scenario is when the given directory
does not exist but its parent directory is bpffs. In this scenario no mounting
should be done.

But to check whether the parent dir is bpffs, the malloc and dirname will still
have to be done.

In the file subfunction too, the malloc and dirname will have to be done if the
given file does not already exist.

If my understanding above is right, should the mount_bpffs_for_pin() function
still be split?

Assuming that the function is split into two subfunctions, there's another
question that I have got.

>                if (is_dir && is_bpffs(name))
>                                return err;

The above condition was added in commit 2a36c26fe3b8 (patch submission [2]).
If the function is to be split into two subfunctions for dirs and files, is it ok to
remove the above function entirely in the file subfunction?

If "is_bpffs(name)" returns false, then that could imply that the file exists and its
parent dir is not bpffs, or that the file does not exist and no comment can be
made on the parent dir. In either case the malloc and dirname will have to be
done.

On the other hand if the file exists and is part of the bpffs then this condition
will allow the function to exit immediately without doing a malloc and dirname.
But this can be determined without the condition as well, since the file being
part of the bpffs implies that the dir will be bpffs.

Thanks,
Sahil

[1] https://github.com/libbpf/bpftool/issues/100
[2] https://lore.kernel.org/bpf/1683197138-1894-1-git-send-email-yangpc@wangsu.com/




