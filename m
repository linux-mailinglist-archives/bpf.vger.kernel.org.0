Return-Path: <bpf+bounces-31340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5488FB6DD
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3C21C23156
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CF143C67;
	Tue,  4 Jun 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJlxiajA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BEB13C827;
	Tue,  4 Jun 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514540; cv=none; b=vAeWOlsHJkK3UO4fwEym50vH2GtOsre8MNiZtrpOvQwTyqroSYCynX88IH2N8gfSj3mP9opK+0xrm37V/9Xj4mbt+ETvOhPDI2RomQVIkxtaHXKKudrf10NRuiN9izhCoGRl4HUbXvdpQajvk2CE1QIVbuiiQdINdTUSNt0RCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514540; c=relaxed/simple;
	bh=u1/FeGL5RUhF4S3WPJnEak69CnnlrvFnOyFPYCVCepg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIOHmknq1c08ZJbT3ofXSW+kfZldWmzx6Zl+tz9h2UqIj8QHF6yNXa4kxwPxYFwYczjRyuij6j1WWhkQCbve3vA8koCFwz596jpWHXbSdSE3g/K30e2Ml/agPPHEdQAHs9J/2hAL5VVlT8K14YMYN95PDdSmqdnVU2fkt2iKKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJlxiajA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7025b84c0daso2406957b3a.2;
        Tue, 04 Jun 2024 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717514538; x=1718119338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cvfNvU3cmQuJR5bvLUaGg5N8eIRCTz+/7OhxXi/qe8=;
        b=JJlxiajAk3oVBFJ/D9bw7wj36sMu70yU6Zq1v/rwc184YbO5UfQjyirP1Ij7UGdTbX
         5h8XHIylXNMqAfnvx16Th0iM3AhHuwdMlgDZa2oohiZXlCF5wuGUpmhsgxoojUgHpT41
         3LgZoGwX3d1zpu7Wph98Yo5hqH/FYNPp6kipMhDpI4EdzFyhFEAepus+1eh+CHCagtMT
         y+uMRd518RU+zBl+uK/95tQbBW1MRDww+5GKgyPW5JltdxQn3if8uBXcJRLcDTSxvhBR
         73YU8GyXtSCsm7cNYUATMNcgP9OL1jmllE05mzGL6f7NfRcFEf1hhEgNa7HEn2F0lGre
         0dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717514538; x=1718119338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cvfNvU3cmQuJR5bvLUaGg5N8eIRCTz+/7OhxXi/qe8=;
        b=TPtaY5yvvH2RGXE416b6UV/oqN6P9G0XfRFGuGqUl0ZZbvolHZS4Y/ZpRn7c5348rw
         NU42heWMY/1Ms23y5NU7VZYczLy+R1VFKtvRrhoBYGa6V2bn5YT0P4uUbVBB2w+Kc+7K
         acUITsT2mXU9scATVCfqpHnD1pky2o5ynxOfK8PSIYIEoTFZuueIeZ8yXqXcm9MBJ+fx
         be4c28pRrRi40/Z3r/juk33ebteB4NfyQ/8/3QYAamIFiWtAvIcTqys5uKqNmxYzsp+v
         +YUBhUJsya+dfz/shkG2Qw/feTlSJiIKGCGnXfPBX9p9Snu1uST12p6jBxLIFLxLmOop
         43sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNig5z1K/19RCv07AG+yrYU7lGz5eWnXx2dqY/7aYKuRcAkQorR/hgLopwgblOfImdYW+4r4hNPwlvR4FOZXTZDYye0i2t0N3IBhJ3xxHq9HzHv5TqjDyJo3v+
X-Gm-Message-State: AOJu0Yz2gqkrNU8y6QKhTHPiMQ2ct2Imq6sIr3Wh5g6hEhc6riRN6R9v
	FlaGhEPk710WCXLSZsR7zIxlSkGDOzbnJ1z8vDBmFSpbblfFWxYw
X-Google-Smtp-Source: AGHT+IEapJwJwkx/dDCBpoYj76UaLAqJGJ4q7hVU9Vy2myODCWE86PUk4ACS1E078cORjm+vVrq6qQ==
X-Received: by 2002:a05:6a00:1a91:b0:702:2749:6097 with SMTP id d2e1a72fcca58-702477bc078mr12359255b3a.1.1717514537940;
        Tue, 04 Jun 2024 08:22:17 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:274a:7c25:e246:a4c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423da888sm7194597b3a.60.2024.06.04.08.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:22:17 -0700 (PDT)
Date: Tue, 4 Jun 2024 08:22:16 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <olsajiri@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
	syzbot+1989ee16d94720836244@syzkaller.appspotmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [Patch bpf] bpf: fix a potential use-after-free in
 bpf_link_free()
Message-ID: <Zl8xKFi+Nvd3VM7H@pop-os.localdomain>
References: <20240602182703.207276-1-xiyou.wangcong@gmail.com>
 <ZlzI0bhlMP1sAHEI@krava>
 <ba683305-7e58-b3f0-0bfb-3dec25e05134@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba683305-7e58-b3f0-0bfb-3dec25e05134@iogearbox.net>

On Mon, Jun 03, 2024 at 06:15:55PM +0200, Daniel Borkmann wrote:
> On 6/2/24 9:32 PM, Jiri Olsa wrote:
> > On Sun, Jun 02, 2024 at 11:27:03AM -0700, Cong Wang wrote:
> > > From: Cong Wang <cong.wang@bytedance.com>
> > > 
> > > After commit 1a80dbcb2dba, bpf_link can be freed by
> > > link->ops->dealloc_deferred, but the code still tests and uses
> > > link->ops->dealloc afterward, which leads to a use-after-free as
> > > reported by syzbot. Actually, one of them should be sufficient, so
> > > just call one of them instead of both. Also add a WARN_ON() in case
> > > of any problematic implementation.
> > > 
> > > Reported-by: syzbot+1989ee16d94720836244@syzkaller.appspotmail.com
> > > Fixes: 1a80dbcb2dba ("bpf: support deferring bpf_link dealloc to after RCU grace period")
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > > ---
> > >   kernel/bpf/syscall.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 2222c3ff88e7..d8f244069495 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -2998,6 +2998,7 @@ static int bpf_obj_get(const union bpf_attr *attr)
> > >   void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
> > >   		   const struct bpf_link_ops *ops, struct bpf_prog *prog)
> > >   {
> > > +	WARN_ON(ops->dealloc && ops->dealloc_deferred);
> > >   	atomic64_set(&link->refcnt, 1);
> > >   	link->type = type;
> > >   	link->id = 0;
> > > @@ -3074,8 +3075,7 @@ static void bpf_link_free(struct bpf_link *link)
> > >   			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> > >   		else
> > >   			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
> > > -	}
> > > -	if (link->ops->dealloc)
> > > +	} else if (link->ops->dealloc)
> > >   		link->ops->dealloc(link);
> > 
> > nice catch
> 
> +1, thanks Cong !
> 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> I think it would also be slightly nicer to just fetch the ops once, which
> wouldn't have caused the issue if it was done back then in the first place.
> Do you mind if I squash this in and then apply it to bpf tree? Looks as
> follows :
> 

Sounds good to me.

Thanks.

