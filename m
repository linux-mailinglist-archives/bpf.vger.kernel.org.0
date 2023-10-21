Return-Path: <bpf+bounces-12891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27397D1A79
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 04:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7E61C21047
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 02:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C31815;
	Sat, 21 Oct 2023 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnkHw9qz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DDEA3
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 02:03:15 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BAFD71
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 19:03:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b497c8575aso1394204b3a.1
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 19:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697853793; x=1698458593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4BfpSktvbeUKArir1bRj5PHVyuN50VNESHk8dlYnFI=;
        b=BnkHw9qzr42VNIaGiFLxMwLL/sN+mw9q0P2L3mEmAdji+fENwpfG24qbMgkvSfwFp9
         VFThw009FLbe7bgXXxq7rSY7IQ/8YTytXCp8x/pGqrD95H5ZWSHMOTua/d7ZGVyz046e
         lF7l7GG5lOEQqxI/K3sVHuoR99MxkdN4BXVa7BR8NJQyvLjWJkipoj/Ia/dF7G7j3YrE
         NNI81Zv2R4YdAefjGLhcpzbqPFEIAxiJV17LWKzNzNJRQ3QbhadW/843f8z/RZuCpB1u
         E88F3QFSDdrUwzZiwuzYeWkhlSSQa6Y6B1Nz+R5Y4+WH5V00TSlOLdKR043ZmG2e9xpx
         8w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697853793; x=1698458593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4BfpSktvbeUKArir1bRj5PHVyuN50VNESHk8dlYnFI=;
        b=agR8nk33+BPb1Kz2dw5v8PMnw6/GQCDT7ND188iz8GS1zlNxpcWl9pICksRPAFKmfR
         ISiSODERZ5taW2ZrVX7KfDGjKRMU5bzMlDZE/XPPJiliD/EhEvToQxeho4xMaVyj6683
         xG/icGn698/2621uHTAPOFi+Dxf14W1XSuU6DRenFSVE/t+TQuT7tsQHqDTkjaYewrEC
         Y1U49HitIbv6ZmcjfClaYG4++rQcGTVMLNaEO1gh2eXa6pMqTEECQIvHOJo6oRU6BzEH
         g9bYvp5Wdhg2Iyo7VVoA7qYPhalE0REvvvlfpY7TEm1tOEvpI2cTH57XPkKd6WWhLIrk
         iMcw==
X-Gm-Message-State: AOJu0YyBQHNBLKJ3XPPTB6+umiC6Iaj5tMtRl0WpPfDwzye2MmiQEiam
	ZuscEsaowqjfhky5nAFDuqM=
X-Google-Smtp-Source: AGHT+IErUW+BgARy7CTYpTCHlLimvLL8d+UwcpVOFMaZGL8SWqCavOGXY9zgrCCFvRMxPu/yeMrR5Q==
X-Received: by 2002:a05:6a00:10c4:b0:6b5:608d:64f6 with SMTP id d4-20020a056a0010c400b006b5608d64f6mr3817371pfu.20.1697853792518;
        Fri, 20 Oct 2023 19:03:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:a906])
        by smtp.gmail.com with ESMTPSA id h29-20020aa79f5d000000b006be7d407a11sm2242657pfr.178.2023.10.20.19.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 19:03:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 20 Oct 2023 16:03:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Dennis Zhou <dennis@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hou Tao <houtao1@huawei.com>, Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 2/7] mm/percpu.c: introduce pcpu_alloc_size()
Message-ID: <ZTMxXjlJg89nH7Pe@slm.duckdns.org>
References: <20231020133202.4043247-1-houtao@huaweicloud.com>
 <20231020133202.4043247-3-houtao@huaweicloud.com>
 <ZTK9a4H2iuJrJG+x@snowbird>
 <CAADnVQKREaN65cNMJ0qajjA9=46JWHyK9jdGFKcQ=RwjAMuQKQ@mail.gmail.com>
 <ZTLA87JYVRLHn/zk@snowbird>
 <CAADnVQJiDfTgE_pEirDf2z0cc93pyWQnNCWnmOp=uks=6FViAg@mail.gmail.com>
 <12196815-c2ed-b5cb-4bda-bee794d8d082@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12196815-c2ed-b5cb-4bda-bee794d8d082@huaweicloud.com>

On Sat, Oct 21, 2023 at 09:20:29AM +0800, Hou Tao wrote:
> >> Eh, if it's trouble I can fix it in the future. I know single space is
> >> more common, but percpu was written with double so I'm trying my best to
> >> keep the file consistent.
> > Ok. Fair enough.
> > Force pushed with double space.
> 
> Thanks for the fixes. When I copied the sentence from the email, there
> was indeed double spaces in it, but I simply ignored and "fixed" it, and
> I also didn't double check the used style in mm/percpu.c. Will be more
> carefully next time.

FWIW, they are double spaced because emacs used to default to double spacing
and would never break single space when flowing paragraphs. e.g. If you
write "asdf fdsa. blah", it would never break the line between fdsa and
blah, sometimes leading to weird flowing. I just accepted that as a fact of
life and got used to double spacing. I did change the config quite a while
ago and now am using single space like a normal person.

So, it's upto Dennis but at least I don't mind gradually losing the double
spaces. No need to go through the files and convert them all at once, but if
the comment is gonna change anyway...

Thanks.

-- 
tejun

