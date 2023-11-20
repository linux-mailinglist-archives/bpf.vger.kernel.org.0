Return-Path: <bpf+bounces-15380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C837F189C
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 17:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C439281DD5
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3461E529;
	Mon, 20 Nov 2023 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tm/2HmJo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE694
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 08:27:24 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ffef4b2741so102472766b.3
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700497642; x=1701102442; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T6AaTUQtZWohHFSgKuUYe4qHzdmFrqWinc4S2AkKZwU=;
        b=tm/2HmJoVvAfJ8KxoJFvPRKPm1UEGYBrF0NXqxqSulsAjKN5yHgD7RoFbWv5PJIdC4
         jHvpOxk/xguS0cMaAIqBgB6Cd1pyg1Z/4USeEWO1DTpf7BebQQBCJJeUwds26le1cmcy
         dbI1RwC+KOFhpeOkcecdSlGoEgn739pvN9LK4Ec0tmrFy+eXXdXVEmau8kwNKRx/Zgvo
         KX861P0AvWzPUp7249eaFGJT0hFV04WaIaoTRIqWN5h+sKLVCbZ9srKYo0zIGTVn04SO
         5OHOjPLl+2HaLs0kSW5oErOqBAzE/vpd9eovCZUUe0prASndii+TNBzyDT5pekxnChqH
         /1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700497642; x=1701102442;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6AaTUQtZWohHFSgKuUYe4qHzdmFrqWinc4S2AkKZwU=;
        b=eOGBVN/gJPO2K+PjR3jGsoxOaNQcbF2/u3X70U6+bBisB9GlSM5sEkxCnCHTNePGwE
         Z9l3B2Ysj5d0dtpLRxMxPR8ikxePuM9kXWBo8t9F9lDj8LBucygSztjWpMJqL2zVJphA
         X0PZAE/Obeb+Y0RMhdWwJnJuUUKfnqUixET+WDyqdblyo58DlMuiqV91qer+IoW7qZxO
         NnvhAhp4pc3NLcCcAHYWWdCVBvEFXnZaUh9Lx9NXUV5mq4rLcesa955HS49wojGUflSv
         BHXiDq6PGfpT460uHWURUsnp9v5TEWgsJjbwCiZizAWgTkvU5U6rx+WC7dpJ39xY79aA
         ARHA==
X-Gm-Message-State: AOJu0Yy6u1tuXcOr8cgilry683NuESX1zQw/VoJO+xkn9gG4hthP5Nxd
	qEDovV7it2fIky+r6J85TsB25Q==
X-Google-Smtp-Source: AGHT+IEtlwHJJRIvws+kP+8AZlakH5WPNPcmn+jjYQgLzdF87K5GDzZwiiZxE/XgElEmPPfw936Ytw==
X-Received: by 2002:a17:906:d7:b0:9fb:c70f:9917 with SMTP id 23-20020a17090600d700b009fbc70f9917mr4637599eji.56.1700497642369;
        Mon, 20 Nov 2023 08:27:22 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l21-20020a1709061c5500b009fda665860csm1547099ejg.22.2023.11.20.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:27:21 -0800 (PST)
Date: Mon, 20 Nov 2023 17:27:20 +0100
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
Message-ID: <ZVuI6AA1zM++S9Fu@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-16-jhs@mojatatu.com>
 <ZVZGYQDk/LyC7+8z@nanopsycho>
 <CAM0EoMkW1-a8yuxjEsqSnrmUx+ozn3CxvXTTwvEEPUrpk5UPRA@mail.gmail.com>
 <ZVsXKkD6ts+XcfE6@nanopsycho>
 <CAM0EoMnD0yWUyd3f42NaXsWmJZ5iuPZcySroFfRFSkk=p2e06g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnD0yWUyd3f42NaXsWmJZ5iuPZcySroFfRFSkk=p2e06g@mail.gmail.com>

Mon, Nov 20, 2023 at 03:02:49PM CET, jhs@mojatatu.com wrote:
>On Mon, Nov 20, 2023 at 3:22 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Nov 17, 2023 at 01:14:43PM CET, jhs@mojatatu.com wrote:
>> >On Thu, Nov 16, 2023 at 11:42 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Thu, Nov 16, 2023 at 03:59:48PM CET, jhs@mojatatu.com wrote:
>> >>
>> >> [...]
>> >>
>> >> > include/net/p4tc.h                |  161 +++
>> >> > include/net/p4tc_ext_api.h        |  199 +++
>> >> > include/uapi/linux/p4tc.h         |   61 +
>> >> > include/uapi/linux/p4tc_ext.h     |   36 +
>> >> > net/sched/p4tc/Makefile           |    2 +-
>> >> > net/sched/p4tc/p4tc_bpf.c         |   79 +-
>> >> > net/sched/p4tc/p4tc_ext.c         | 2204 ++++++++++++++++++++++++++++
>> >> > net/sched/p4tc/p4tc_pipeline.c    |   34 +-
>> >> > net/sched/p4tc/p4tc_runtime_api.c |   10 +-
>> >> > net/sched/p4tc/p4tc_table.c       |   57 +-
>> >> > net/sched/p4tc/p4tc_tbl_entry.c   |   25 +-
>> >> > net/sched/p4tc/p4tc_tmpl_api.c    |    4 +
>> >> > net/sched/p4tc/p4tc_tmpl_ext.c    | 2221 +++++++++++++++++++++++++++++
>> >> > 13 files changed, 5083 insertions(+), 10 deletions(-)
>> >>
>> >> This is for this patch. Now for the whole patchset you have:
>> >>  30 files changed, 16676 insertions(+), 39 deletions(-)
>> >>
>> >> I understand that you want to fit into 15 patches with all the work.
>> >> But sorry, patches like this are unreviewable. My suggestion is to split
>> >> the patchset into multiple ones including smaller patches and allow
>> >> people to digest this. I don't believe that anyone can seriously stand
>> >> to review a patch with more than 200 lines changes.
>> >
>> >This specific patch is not difficult to split into two. I can do that
>> >and send out minus the first 8 trivial patches - but not familiar with
>> >how to do "here's part 1 of the patches" and "here's patchset two".
>>
>> Split into multiple patchsets and send one by one. No need to have all
>> in at once.
>>
>>
>> >There's dependency between them so not clear how patchwork and
>>
>> What dependency. It should compile. Introduce some basic functionality
>> first and extend it incrementally with other patchsets. The usual way.
>>
>
>Sorry, still not following:
>Lets say i split the current patchset 1 with patch 1-8 (which are
>trivial and have been reviewed) then make the rest into patchset 2
>with a new set 1-8. I dont see how patchset 2 compiles unless it has
>access to code from patchset 1. Unless patchset 1 is merged i dont see
>how this works with patchwork or reviewers. Am i missing something?

Why it would not work. Describe your motivation and plans and submit
part of the work, the rest later on. No problem.


>
>cheers,
>jamal
>
>>
>> >reviewers would deal with it. Thoughts?
>> >
>> >Note: The code machinery is really repeatable; for example if you look
>> >at the tables control you will see very similar patterns to actions
>> >etc. i.e spending time to review one will make it easy for the rest.
>> >
>> >cheers,
>> >jamal
>> >
>> >> [...]

