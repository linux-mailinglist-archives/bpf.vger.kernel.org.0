Return-Path: <bpf+bounces-7138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A1771B14
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 09:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A0D280EDC
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 07:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A413D99;
	Mon,  7 Aug 2023 07:05:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343A2106
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 07:05:07 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD951BCF;
	Mon,  7 Aug 2023 00:04:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C98401F460;
	Mon,  7 Aug 2023 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1691391874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTuF2TgB1pBwN8OkG1rHpu4xeWoKn3NkiBu7ZL/kjNo=;
	b=b+BEiZrOazh2iKNnKC3SDf37eCGPzo5Aktuj/Bb87LGLBIIPO0oKrfVZECh/ZUHZQ99A3c
	I3vc76WsiiUEN9tTFrpjkAy6FTYDwpr9s0sxVhGg2tqAN3zAA3EYGD9Tyz5KJbN4X4u7Lp
	b/oocpwiNVjz3VbAlTQNFBjjSQyLl8g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAB8013910;
	Mon,  7 Aug 2023 07:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id k5euJoKX0GSvWAAAMHmgww
	(envelope-from <mhocko@suse.com>); Mon, 07 Aug 2023 07:04:34 +0000
Date: Mon, 7 Aug 2023 09:04:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com, robin.lu@bytedance.com
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz>
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon 07-08-23 10:21:09, Chuyi Zhou wrote:
> 
> 
> 在 2023/8/4 21:34, Michal Hocko 写道:
> > On Fri 04-08-23 21:15:57, Chuyi Zhou wrote:
> > [...]
> > > > +	switch (bpf_oom_evaluate_task(task, oc, &points)) {
> > > > +		case -EOPNOTSUPP: break; /* No BPF policy */
> > > > +		case -EBUSY: goto abort; /* abort search process */
> > > > +		case 0: goto next; /* ignore process */
> > > > +		default: goto select; /* note the task */
> > > > +	}
> > > 
> > > Why we need to change the *points* value if we do not care about oom_badness
> > > ? Is it used to record some state? If so, we could record it through bpf
> > > map.
> > 
> > Strictly speaking we do not need to. That would require BPF to keep the
> > state internally. Many will do I suppose but we have to keep track of
> > the victim so that the oom killer knows what to kill so I thought that
> > it doesn't hurt to keep track of an abstract concept of points as well.
> > If you think this is not needed then oc->points could be always 0 for
> > bpf selected victims. The value is not used anyway in the proposed
> > scheme.
> > 
> > Btw. we will need another hook or metadata for the reporting side of
> > things. Generally dump_header() to know what has been the selection
> > policy.
> > 
> OK. Maybe a integer like policy_type is enough to distinguish different
> policies and the default method is zero. Or we can let BPF return a string
> like policy_name.
> 
> Which one should I start implementing in next version? Do you have a better
> idea?

String seems to be more descriptive.
-- 
Michal Hocko
SUSE Labs

