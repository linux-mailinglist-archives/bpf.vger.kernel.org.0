Return-Path: <bpf+bounces-52722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E176EA4774E
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 09:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA2175540
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38871225792;
	Thu, 27 Feb 2025 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMRM7xEG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B24224B08
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643498; cv=none; b=grz1j9sGWk+Ayu3CINrjBUnOUczHZk0I7xFAtEKQVtggGlg3Lpuato/SMMDVZVdyc6ASAAxDQ+G87C0eutRQjHLgS599CFJEk6SaJ9/O0nt3nYCfn/cT4KBUKm1SfZAFY5PTjoWo5m59Air24IP5XSUGX+spX9igxbZ5aBAU8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643498; c=relaxed/simple;
	bh=rlwCIU6wq0zg7H7hLkk46jst9cMoB+LfjLnMLeFXeeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfx3YGgzbygM22WSxVp2GRonlYiM3tQVygWoEcMBHsi5OxcQ/25n78kwt/4/vnQUlGvddAFuWTlJsKlCaL1iqL+ldNCAaX3TGciLK4RBqLsWLfn9REkpFasfN+9Mv5ReLbqqUXmHLLJb1k+DDB1brAAmIjnxT35WA0k0neio/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMRM7xEG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221ac1f849fso84435ad.1
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 00:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740643496; x=1741248296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVfI19/EVZuMF44ISw3H+kHayQljK7ILxbA5Nh59FJs=;
        b=EMRM7xEG+yTbhmYBsJWNgcQhIcBhOeElh/VoeymdLZtlxbjx38GbygixcY4IKZyAgf
         MNs237i32n8nHjYBpjSSMOXyjudeO+4xtfrTrQbHRQLTPabbENaC85196l+ajX1wRfAv
         k6Axcs/QB/sKhbXYOjtzq8aRLZoUn5B/2VrEROLbg1Vzo9MCrVUnXnLpsWnlhLxgIOcC
         12gQnBm/Ad4ZRrtgaOKnle2Ol/nVxFvSzQZ7OfXkgSIaPEIyDyhd1MLi3twBf0jRB35x
         uEHfW6dMfQ1r1uI4I6FYbUW0jocvYEJq4Pbqwth3YSxxp/0X9YbizziZzjWtumcpD8kE
         LnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740643496; x=1741248296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVfI19/EVZuMF44ISw3H+kHayQljK7ILxbA5Nh59FJs=;
        b=tjMzIKA6bMb8sJ5tR9vfFVAadxp4llZFVGzl3BzDSN04JgrUzFM6L46E46BDJJUrGN
         8Qgs74qOXwr2DduyI8Jwc32MQYytBCcFT4keFMy7QHdomw86Uz1C27puKa5Dp3Hqm2KX
         LK5rL5ViD0ENnZVq538L+xk5M7JYFmGnU+sQ9JmUJKuFi55FWsZZ1eM9TG+bcEAy7rAq
         DtELzXtOIRkG+ROi3TH6ngLepz2annR8yoEbzeaIIaIzXAJ2VC1+XhwQd2pXXYScmpTS
         6MVvywk5fGRnh96o6A305qOlws9hj09kp1GtrDzxhOe7UXYxOSvau7WAuf/oiIvAEzzk
         PgkQ==
X-Gm-Message-State: AOJu0YwDHLte0iJDXNvePKgVoYqmsR81WiKIbDKXPykb57dl/gKRoeI0
	PxGPaWt/XoJID0o4Lg8smUx5mOx/07wYdAzdxS5quRy3MCIlY8P7qHBDU+DiOg==
X-Gm-Gg: ASbGncvLVj3aT9XIMZ99f3x8k+Mnp05wrJOj2VU6p1das/ylkuEZak87KTfnqkTUZoy
	AgXLnklMrNSUnLYvXFf9QHpDteCSlwzoHqJLlRf7MNl3Mw8R8WSvP0x8yA3XGEb4nvu74Y6FTjg
	OH7bSvMnpZJnS/XSg7975kGrcZLLLdz5ETL06AXTPF3G843hxLjyrmNkszqcgzGcWZL7VeBtTfH
	t3lFy1UvoQXY6TCYT0oh2qC1O6oLIE3SkV3CW67TsE1hVXijF2o/UBXXR2FPUcAsIwqPpC0t2nZ
	0EKgwObj0/T/pEa0waE8OF/2sUbQcKpEGymvVK+ebOTRNTU/JIKJ9aiA1xfF1xkh
X-Google-Smtp-Source: AGHT+IH0kXAKW/WxeUSAkDJ6hpUz3G9Z8tiiq25Pho3rUzHzfEO4KswpeTVilRNrTdkuX5sOdpqUXQ==
X-Received: by 2002:a17:903:17ce:b0:215:9327:5aed with SMTP id d9443c01a7336-2234d84ead1mr1995945ad.20.1740643496268;
        Thu, 27 Feb 2025 00:04:56 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe4cd94sm910482b3a.38.2025.02.27.00.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:04:55 -0800 (PST)
Date: Thu, 27 Feb 2025 08:04:50 +0000
From: Peilin Ye <yepeilin@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yingchi Long <longyingchi24s@ict.ac.cn>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Introduce load-acquire and
 store-release instructions
Message-ID: <Z8AcosbkJ_n8wEbZ@google.com>
References: <cover.1740009184.git.yepeilin@google.com>
 <e2d7bfc155a26305a3024aaa102a3acfa693e565.1740009184.git.yepeilin@google.com>
 <CAADnVQKEcof-WBBj_W=GpsP0Tjm8hyxeWc06243ZBR7_Ua0Gfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKEcof-WBBj_W=GpsP0Tjm8hyxeWc06243ZBR7_Ua0Gfg@mail.gmail.com>

On Wed, Feb 26, 2025 at 06:18:47PM -0800, Alexei Starovoitov wrote:
> It's border line ok-ish to delay arena ld_acq/st_rel on x86 for a follow up,
> but non-arena on x86 should be done in this patch.
> It's trivial to add support on x86-64 and
> limiting the selftest to:
> .. defined(__TARGET_ARCH_arm64)
> is just not right.
> 
> Even arena ld_acq/st_rel can be done in this patch too.
> It is such a minor addition compared to the rest, so I don't see
> a reason not to do it right away.

Sure!  I'll add x86-64 support (including arena) in v4.

Thanks,
Peilin Ye


