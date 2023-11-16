Return-Path: <bpf+bounces-15201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852DF7EE55B
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 17:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00CAB20D99
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD73C49F;
	Thu, 16 Nov 2023 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nwExwMZW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1467418D
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 08:42:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40839807e82so6540425e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 08:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700152931; x=1700757731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ey6FPqM3ezE5TkOnnp/QUGAqqxTUcssiF8OATJaVuv4=;
        b=nwExwMZWCVsthw8COGUwgE3raeK6Gs7loTDKm2Z2T8p/b8bszcMro1Euz9Sloiz3BR
         15Hb+ts4k4u9YMvrO001t07P4Oc9zGYiu7LSdfTpj658BZRB0g159LlynGjWA5YfPOXV
         7RfNyBlTz2z+sgg04Hmk7LGSTveDoWTD6+o6B+BCOP0mvpTpYQ4ET4cw+BEE1WGlO7Z8
         UeY2c1PVmNW/XdoHbtrHbloga+3x9/GlIXaYh/1w54C0wmzysRB2uRsWt/dB43HIJtnR
         gabPQUlbitjMC6W37EOshT5FCU2oBEzDAkVLnRoavYMOezPB83+MGHu1Uin7kvqAUSj3
         vUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700152931; x=1700757731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey6FPqM3ezE5TkOnnp/QUGAqqxTUcssiF8OATJaVuv4=;
        b=qMcUJVzbR6PwQrC7tDZvIzRDIOonkOvzyWhL5Iyco7620edCu0mqBPhNPfts0Dkmln
         lADidc+WSym1uq5mOm9dRK1hmeLzIylmslelGgm3eNIjzpAS3UPVMmAmeA8B5RiR1Kgj
         YfXpvmtgLrfjOYv4OoSUEI7zSYzXfZgQyWuvGuEAR+jnODYnwEpnQV89puv/4pbFfVXj
         Qq7xN7r8MQjaWcKRPbd9YrwIU4yip23LgL7wLczq+1nznMDXmhrvFOVebtxtqzc2eODu
         9zkxWDbGGqxepDBuW+qQTCKAO059nA+/eGiRvg5mvqWarqCaMkXtRktOxpYK9ZasWV0t
         VsXw==
X-Gm-Message-State: AOJu0Ywlo64tvXibNhj6oISnJX/vmqGuGRjIsTXeQufD9xJeA8KQUMaB
	p9IziSNKv6YlFLYDjOXQvdO7GA==
X-Google-Smtp-Source: AGHT+IGQ203pwjBxxfw2G6h6b9/XqW9U9jtEKCxq4ItGKaFpBXaLbN0FEFVC2YwJ41X/7QvwGzLsXg==
X-Received: by 2002:a05:600c:1c9e:b0:407:4126:f71c with SMTP id k30-20020a05600c1c9e00b004074126f71cmr2200349wms.6.1700152931379;
        Thu, 16 Nov 2023 08:42:11 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b0040839fcb217sm4346255wms.8.2023.11.16.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:42:10 -0800 (PST)
Date: Thu, 16 Nov 2023 17:42:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com
Subject: Re: [PATCH net-next v8 15/15] p4tc: Add P4 extern interface
Message-ID: <ZVZGYQDk/LyC7+8z@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-16-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116145948.203001-16-jhs@mojatatu.com>

Thu, Nov 16, 2023 at 03:59:48PM CET, jhs@mojatatu.com wrote:

[...]

> include/net/p4tc.h                |  161 +++
> include/net/p4tc_ext_api.h        |  199 +++
> include/uapi/linux/p4tc.h         |   61 +
> include/uapi/linux/p4tc_ext.h     |   36 +
> net/sched/p4tc/Makefile           |    2 +-
> net/sched/p4tc/p4tc_bpf.c         |   79 +-
> net/sched/p4tc/p4tc_ext.c         | 2204 ++++++++++++++++++++++++++++
> net/sched/p4tc/p4tc_pipeline.c    |   34 +-
> net/sched/p4tc/p4tc_runtime_api.c |   10 +-
> net/sched/p4tc/p4tc_table.c       |   57 +-
> net/sched/p4tc/p4tc_tbl_entry.c   |   25 +-
> net/sched/p4tc/p4tc_tmpl_api.c    |    4 +
> net/sched/p4tc/p4tc_tmpl_ext.c    | 2221 +++++++++++++++++++++++++++++
> 13 files changed, 5083 insertions(+), 10 deletions(-)

This is for this patch. Now for the whole patchset you have:
 30 files changed, 16676 insertions(+), 39 deletions(-)

I understand that you want to fit into 15 patches with all the work.
But sorry, patches like this are unreviewable. My suggestion is to split
the patchset into multiple ones including smaller patches and allow
people to digest this. I don't believe that anyone can seriously stand
to review a patch with more than 200 lines changes.

[...]

