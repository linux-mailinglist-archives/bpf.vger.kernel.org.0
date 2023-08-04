Return-Path: <bpf+bounces-7010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D53507701C2
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 15:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124EB1C218A3
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958E0C135;
	Fri,  4 Aug 2023 13:34:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AFE746B
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 13:34:46 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B3B1BF9;
	Fri,  4 Aug 2023 06:34:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 685E71F8AB;
	Fri,  4 Aug 2023 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1691156073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dC3229kXtesd2LonV8QJ5tIaAJZvEIlDNMMMi0MzLuA=;
	b=DeFJbWAcdSuvcmAC25+a1fPES2q6mL+ZCOh3sOtNUFjYruRe9nDNniNxYt2Y6MnapORnGt
	I9U3Y4YA2Y0jOxVVoTmoNpv2W10oZV6sWz09qzfMJDeAVKCgQChfAEf/31jdqVmIzFEYAm
	bqi5ZfDvRLZO8Q2mxKXql+Pid58SuXc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A499133B5;
	Fri,  4 Aug 2023 13:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RKgXD2n+zGQYGgAAMHmgww
	(envelope-from <mhocko@suse.com>); Fri, 04 Aug 2023 13:34:33 +0000
Date: Fri, 4 Aug 2023 15:34:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com, robin.lu@bytedance.com
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri 04-08-23 21:15:57, Chuyi Zhou wrote:
[...]
> > +	switch (bpf_oom_evaluate_task(task, oc, &points)) {
> > +		case -EOPNOTSUPP: break; /* No BPF policy */
> > +		case -EBUSY: goto abort; /* abort search process */
> > +		case 0: goto next; /* ignore process */
> > +		default: goto select; /* note the task */
> > +	}
> 
> Why we need to change the *points* value if we do not care about oom_badness
> ? Is it used to record some state? If so, we could record it through bpf
> map.

Strictly speaking we do not need to. That would require BPF to keep the
state internally. Many will do I suppose but we have to keep track of
the victim so that the oom killer knows what to kill so I thought that
it doesn't hurt to keep track of an abstract concept of points as well.
If you think this is not needed then oc->points could be always 0 for
bpf selected victims. The value is not used anyway in the proposed
scheme.

Btw. we will need another hook or metadata for the reporting side of
things. Generally dump_header() to know what has been the selection
policy.

-- 
Michal Hocko
SUSE Labs

