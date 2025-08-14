Return-Path: <bpf+bounces-65644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED78B26840
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 15:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3BC16DD95
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BBE3002CA;
	Thu, 14 Aug 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Dk+rUK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4BA14A4CC;
	Thu, 14 Aug 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179603; cv=none; b=KW2S5gU8oosjqZM/2hmQq+vZNr2nuNvXbOlsbuZsjMbRT+fjf/hSj0hqPSwME/KUPveDIeMlZJqMERqTQF2Uis/t2dBAsVPsP5OXSfCD+bbHulq0DCsOhgng/K0AOtjYPDO+n8+O/RTByYGvT/HrTCsShymvhaDkLg3IZVRSWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179603; c=relaxed/simple;
	bh=vUtIako2lXAos8oDQ19QEa4Aume7NqAZWeaOnGZhlLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxecr1y6LuvJt70kXjatzb7I4fcN8RCZUYckyGWmI4ItiStxE3J5wt4rNJfv9EHjRI8qo/xlGyjHLIYgEjYuYLrN4XOmAjlttpcgOpxto3Rc+f2AfP2xOSrjoA6vcUZZnWiOy0XKC3AvlZYUTYdo8GDZ+Z/64Ij84renEEdOibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4Dk+rUK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9e7437908so854335f8f.3;
        Thu, 14 Aug 2025 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755179598; x=1755784398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv+sLoDtH6k5d0xwtTC9Rj1x1RyT3QarUan+sdn0Qyg=;
        b=K4Dk+rUKrpqsRjUCFyer5UfKVSXDmMCHkKJyn+Fkp/rWM1wwn3N5hh4ttgNiRzVuEF
         CrDMr8PMm5x9gmlCGX8H9v51ju7Li0XqmaAyd+aagNqghp0uiXOtLHd6XYl8lTbiDdsB
         YazWlKXaVWtgvESK689hF7Qch0ulvhJ2IEBr89wipBzF1j1Q6L4/WxajD6eKNDFNv40/
         E1TGeAwUI+7ddPVMZTZvcVNTj6l/WqcE0/e2ln5tcKz6/wJNfsERthrwhRf2gCYEdJmt
         yZF0iec492UMQ9t+AEibMNuBwLSKXY5BB94pdYOp+Pq86YMcW8cjoQ8fwCJI3+If5Qvu
         Xd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179598; x=1755784398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv+sLoDtH6k5d0xwtTC9Rj1x1RyT3QarUan+sdn0Qyg=;
        b=CV6zCuJJ4xCmkb4cYwWqaGGpXnaLXI9Lk0SydI1fSnoQpxyEzG9dDMj9FX6wFcSSuA
         BiihZbMDVMYGzhj6A1WY2gzIsh02XQsUvwR6dRm8ckyaA/ui3TllCQM3LA+i8lDtJBjO
         jKN4EWYcA461u37krlSnevEgojvSVNyRGmWCUkUABBj//FrCsBDLxeVUzx71POtl2Rks
         0pYeX3WIUpIGNQddGeUyn3XbvIgiIW79ub8FIsE7xhB7b2DsUC6T776qGnrhGwr5O8N4
         bGnoYkl4ax7fG0VDcYRykYL+Tbee7yiRVRb0zysn+5xFLYET0LQNvO5q/P7eIKLPATLG
         s32A==
X-Forwarded-Encrypted: i=1; AJvYcCXAVvvSJ7qGE19FQCnftWNFbFm/XLXSWc05jvz+IPMp0oyXhFYGeeeLX1QKUO1vMsT/1PCucK6LKNJwQEL1Wh7udQ==@vger.kernel.org, AJvYcCXEVggKiv9VvNloLxgvEt+JpibQwE6fC/ZH86SLGlNT7qiH7RsM+yfbtt1YhH6rJla9QLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsUyvj25VqfqDX40NbxyifmSgglyLHH051x30pSXaS6IJsenA
	h7MSkhwG5ubC8g8xaGogwhXhT3HKTXKgjVW13wdtO+oltFYaBsR48h9H
X-Gm-Gg: ASbGncu/4YhKniAf42yB7OJMEHBhbh+91zm66F9UfmsBJtIAoYL9Id3GYHt3NjrMpQf
	mPnazORUSG2FVRP71mhv+NnoHuUoE6KkCNO/gICw4rnwhA1CPyr1z5TgAF33j8/naqHzXPdSJyW
	3sy5ZysbLAQNBBzDsnFc5NylYnGhI32vWW3vF+vizFJX50m7EmAj1shdQ1O9LsGTO4fe7FE2EDK
	DOqvJS+HBSFWb0lCazsgRJ00P8C32gfz+V7e0GqgjbV3hUh2r29s3ylH0D8RDxcTPjdfEUmgXMy
	+QmxX4WmKEaTa5Inm91eB10hqGSG/fcISoUi35cawtlMJHux7BhHfgI5EtpM/8HtGXHDowq9fzJ
	3KnIQ02nZPYUxc/lMgvSdofw4elQAJj3BDIS695b5dLjvOAAAEquN0MDwl8a1pCoNn+yx+EQCt6
	KErxDSpEnZolQWThBbSEHB
X-Google-Smtp-Source: AGHT+IE275IwRN09XY85Q/WqhExG3V3NA3w/fypwwKWJIKuT3JXXoYjYQo0+NAi6Mk1oJxgrC3skzg==
X-Received: by 2002:a05:6000:18a3:b0:3b8:d082:41e with SMTP id ffacd0b85a97d-3b9fc2ff7efmr2352684f8f.57.1755179597470;
        Thu, 14 Aug 2025 06:53:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0044511fc0c1f74efd.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4451:1fc0:c1f7:4efd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4d02sm49471754f8f.33.2025.08.14.06.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:53:16 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:53:14 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf] bpf: Check the helper function is valid in
 get_helper_proto
Message-ID: <aJ3qSru3r1is9lxy@mail.gmail.com>
References: <20250813133832.755428-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813133832.755428-1-jolsa@kernel.org>

On Wed, Aug 13, 2025 at 03:38:32PM +0200, Jiri Olsa wrote:
> From: Jiri Olsa <olsajiri@gmail.com>
> 
> syzbot reported an verifier bug [1] where the helper func pointer
> could be NULL due to disabled config option.
> 
> As Alexei suggested we could check on that in get_helper_proto
> directly. Excluding tail_call helper from the check, because it
> is NULL by design and valid in all configs.
> 
> [1] https://lore.kernel.org/bpf/68904050.050a0220.7f033.0001.GAE@google.com/
> Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com

The same bug was reported before by the kernel test robot at
https://lore.kernel.org/oe-lkp/202507160818.68358831-lkp@intel.com, so
I guess we'll need:

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507160818.68358831-lkp@intel.com

With that,

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

[...]


