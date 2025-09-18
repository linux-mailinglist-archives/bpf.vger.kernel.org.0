Return-Path: <bpf+bounces-68744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4CCB836E8
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC5B1C23AE2
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE782ED85D;
	Thu, 18 Sep 2025 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS/LbBwJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612A221265
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182711; cv=none; b=hYQQ5oc0GX5GmESLcYY0Ip12S7MzB+7dHudaA5Nzfz0aK4wUwZleJevxRlFk1vrXEugGqkG9HhqyHgj4MRbOBJam4up2EPCfXdJYcNjpaORklf+ajAuXyA2oT8QvPJxCR5xUWRaPYTPUHz4S8OjrFL85PzAVzlPg0Plz7pkFZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182711; c=relaxed/simple;
	bh=oQ9nZjgfmvsLpZcd6hpcdVA2Dax83oIwaefm8i+Prpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR+DsYs/JfcsbxcEyf9PQ+C5DDGKHkoC7sjfnMjQogz12mWv08x4a3zCQ1Vw+iHTaNBb+UWWTrNkfm2iLS8TvGTmFh5Xzg1sovMGXHBGTufXO411guCMlaLH3jxnXeBPtm5VLeGWRJNWgW4EiWWsXqc2Qre1FoXJ/rtFn83QYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS/LbBwJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3dae49b117bso419245f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758182708; x=1758787508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIaSqEb5EXQIggAwfQ6VKOWwq5DPVRIV17TJq0tIu7o=;
        b=NS/LbBwJpBaqvx8Y+7EaXpEeaWokMiyhW19l5xuy+ELMyzqp6PGVFJQ2CDBXY6qA/E
         Lj6sNzCMXUWv61H94AiVUUPYIjZsMVPT7pDXxId3Mh5Cp+bA6iMqzm/yxkeymAfuE28v
         W82n3MixzErXByiONY/+WJ0QGBrPr4fX/qWP+NMh5IYJ21wX2HeQ8UytVuWurstP2zYO
         csAq84JBEc5Xyp0Iyj3NrMJj8m5sRjH4WB0A2KMlpbKxwqptja67CGb6hlO9bwcAOpLJ
         g90Xp+IzyKryxp37CLvTszZE9rtlE4XpLA4LkVKapxLCetGQMU9LJCrHLE2H+jZ0wk5U
         GNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758182708; x=1758787508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIaSqEb5EXQIggAwfQ6VKOWwq5DPVRIV17TJq0tIu7o=;
        b=pd7JjbTQ1Q6g5fK4b+1t2NI/QUGLFE8/bhoqFUIa9tjj88adFbcjQ8JPwIkgcX8fB8
         frfL6+ii0DI1vKHHL4EHdNPIE6iJP2R95KESjIyUqNmr2+XSwgsbQbZM4hQvu6+lspYC
         wFfnWfS0TZSx917hbLeWEWbBdC+V4AJ6MoZnYFcZiYLR5yU35NVWJlZrRo/DeBl1Z3sp
         1T6Gim4DCGXpuKMj6uWUfBvePVuouK96zAVM7ld80CMxXhf9cfq3L5i3cOrQyj7ll1Uf
         WU9/TP6xcMM/B/XPIFenvkovBZjoQ+k2174mMz9GW51/f+Fcl0+JiDciuEp/Ra6yG/68
         ay/g==
X-Gm-Message-State: AOJu0YxhueNAT/ILgJcK0Dc1xmcam3dGLlaopNOaUNqyidb5rm9/3Ed6
	bTmfQElKrwVhYmYhZl2m0S0qjG/9gNyTJNsTErkElVq3qmKTqL8s7e3Z
X-Gm-Gg: ASbGncsmuy9OuZvTmQZ4X4X+bSwknAOJz4arOOcuqyHaZPHK4DjbOJKPgf5pgMOQkYN
	AU38kEvkvdssjWf00oQLEiQ20G20SGMWFU6U1vZd8FYaahi/vCqWqkHKU0y0E5zcyGU4+t9Nd0Y
	MR5ituHlVD1d7Rbp9sAtlkKYiSjvzFCi359YfNo2wH3aconkOrQIkO196vxebJ4XANZKWQci41e
	WDU3X9Qzn6JjaJhrczTq/uh8PkSEvDeYzAz/WisUuOFHokR54FST33jh2wYY/WOntYuJSEqFuP7
	aYJWoqCpDywRVp+CTqsUL8RB2G/J6vzze5vp9fHEw9FCJH/cD6/JAWRK14ksP8NP08V0F3IphR4
	yg3tsiUTo08CzctAwfQqUR/fywgEd42NSAJEu/7HRqW/neZuM98s=
X-Google-Smtp-Source: AGHT+IHh9rlNTHbjR2Z3MQjq1Gd0277qnp/w2/v9u42yGgYbNUhhJuL5gzXBxv7T+t8KHHdnXhxU9g==
X-Received: by 2002:a05:6000:438a:b0:3ec:42ad:58f with SMTP id ffacd0b85a97d-3ecdfa4c665mr3986655f8f.59.1758182707971;
        Thu, 18 Sep 2025 01:05:07 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1385adebsm745831f8f.42.2025.09.18.01.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:05:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:11:22 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 12/13] bpftool: Recognize insn_array map type
Message-ID: <aMu+qqortm0Vv4UA@mail.gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
 <20250913193922.1910480-13-a.s.protopopov@gmail.com>
 <0ef006c7-fb6d-4a97-b42d-f70c91a8cf72@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef006c7-fb6d-4a97-b42d-f70c91a8cf72@kernel.org>

On 25/09/16 09:33PM, Quentin Monnet wrote:
> 2025-09-13 19:39 UTC+0000 ~ Anton Protopopov <a.s.protopopov@gmail.com>
> > Teach bpftool to recognize instruction array map type.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >  tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
> >  tools/bpf/bpftool/map.c                         | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > index 252e4c538edb..3377d4a01c62 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > @@ -55,7 +55,7 @@ MAP COMMANDS
> >  |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
> >  |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
> >  |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
> > -|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
> > +|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** | **insn_array** }
> 
> 
> Thanks Anton!
> That's a long line. As you'll likely respin your series, could you wrap
> and start a new line, please?

Thanks, fixed! (I will resend the series as v3 now due to kbuild-bot issue.)

> 
> >  
> >  DESCRIPTION
> >  ===========
> > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > index c9de44a45778..79b90f274bef 100644
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -1477,7 +1477,7 @@ static int do_help(int argc, char **argv)
> >  		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
> >  		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
> >  		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
> > -		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
> > +		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena | insn_array }\n"
> 
> 
> Same here. Other than these:
> 
> Acked-by: Quentin Monnet <qmo@kernel.org>

