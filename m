Return-Path: <bpf+bounces-15073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F5E7EB6BE
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 20:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB3B1C20AA6
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B401FD3;
	Tue, 14 Nov 2023 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLYptecS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9151FA0
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 19:07:35 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE0FC;
	Tue, 14 Nov 2023 11:07:34 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2809a824bbbso4748127a91.3;
        Tue, 14 Nov 2023 11:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699988854; x=1700593654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTdxwqjsCHAfUHLS9E9O/GYEc/cGPlpr/fwvTx4EeE4=;
        b=BLYptecSPpNTtRzRt2nmFIAUgy0Wa4Di/cPdfXapr9X3A0tRMUHqYvtZR4XXNXPOHX
         Gy4099Z/YHg/P0p/ic+tuAui0IqCAXEJ/roPhchglylKrl9//Ad6B1hOTW8Cwe0n4geN
         igKYF7uGdXNOZ8xSEo2ysZinlflfVnbl18khnPmJ1g/VCqJ3iIh2drOQ6I78GOmJJ+zH
         7P26gXyQqeI7RsEbL0PCqhe7h6+AUzXa70OXliCC+fBqa4NsR7wRuRpyTiXSDtcH/jTd
         4ziwT5NR+I6gtYBKhAoDetewnuxHJ2j8+b90fcYBQr+sBpRX668AvT0QoMqNzr7aMRQJ
         3VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699988854; x=1700593654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTdxwqjsCHAfUHLS9E9O/GYEc/cGPlpr/fwvTx4EeE4=;
        b=tR1RSa6Z+F6W3BSDadGSwjDBHt+kJci8p/CjPf+mhizv1ncy9iZnUiZOftYJ+TQtwO
         qrW4l94Cy8CyxLwOXNP9ZUPBleDGdCvNmVx9FnBvJNvt3B0UEu2/yAW2GF6eYU/Eyea6
         7gzsdgEBrRCF5UIb6dqJhswoQD6OT0iH6T1QOZGWjc1KaSlyto50kxq6l3M/AYA2eohp
         FHzy1ASXuKXWVsGWDDIGygQTpEh34t4OOnlrvUaw/wYZIX2XcPdnTd1wg2LhUT0tVuQ7
         II4XuMbdsFWeLcxndmt/wI8fsEbWPB1BruIU4jsbBRMX1ZMFxuowPQLXsXezcpR23Ur+
         UDxQ==
X-Gm-Message-State: AOJu0Yz25+QsqAGq0H+e40oG1AUL9ftRIxXLG1+4lCQIQEFYwgqj0XdI
	ydtYECDSQ+Bi7uexRapMZno=
X-Google-Smtp-Source: AGHT+IFaLpasVhp8zQGEXaSudejE6IuzaZWdVvddFYiCVKRvwmxTXkuG+a1PWyBjlc0LXrcPrSXP9Q==
X-Received: by 2002:a17:90b:1e03:b0:27d:8d42:6def with SMTP id pg3-20020a17090b1e0300b0027d8d426defmr8808064pjb.34.1699988853635;
        Tue, 14 Nov 2023 11:07:33 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090ad30c00b002790ded9c6dsm5568472pju.31.2023.11.14.11.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:07:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 14 Nov 2023 09:07:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZVPFdKqUxmtW1jaJ@slm.duckdns.org>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
 <ZVKBSIPqJnAvrE3g@gpd>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVKBSIPqJnAvrE3g@gpd>

On Mon, Nov 13, 2023 at 03:04:24PM -0500, Andrea Righi wrote:
> > +#ifdef CONFIG_SCHED_DEBUG
> > +static const char *scx_ops_enable_state_str[] = {
> > +	[SCX_OPS_PREPPING]	= "prepping",
> > +	[SCX_OPS_ENABLING]	= "enabling",
> > +	[SCX_OPS_ENABLED]	= "enabled",
> > +	[SCX_OPS_DISABLING]	= "disabling",
> > +	[SCX_OPS_DISABLED]	= "disabled",
> > +};
> 
> We may want to move scx_ops_enable_state_str[] outside of
> CONFIG_SCHED_DEBUG, because we're using it later in print_scx_info()
> ("sched_ext: Print sched_ext info when dumping stack"), or we make
> print_scx_info() dependent of CONFIG_SCHED_DEBUG.

Yeah, Changwoo noticed the same problem. Will fix and post an updated patch.

Thanks.

-- 
tejun

