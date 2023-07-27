Return-Path: <bpf+bounces-6093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9F17659D7
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 19:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9E9282394
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01927149;
	Thu, 27 Jul 2023 17:17:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC527124
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:17:48 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CE997;
	Thu, 27 Jul 2023 10:17:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCF5621A8F;
	Thu, 27 Jul 2023 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1690478265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niENjOE1icbcpi7kZRifQxcvaZR6brVmI8ZmmVizlZU=;
	b=QV4PKhlv07RzPWFz4H11F+xa1G/rYCNmHsZTYzVwzbPVhlPTIGea2Akt5jl/3I0+tMCvQU
	rwg6AFeUJWdFauIz4nAA/sY9Js5OsX/Ezb5NefJxxH2f3Nk7uT5RrV5/1+AeyHQn1BgILs
	D7C+SDb4nHyr9AAKr4bTFDPyxIKvRtg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5B2F13902;
	Thu, 27 Jul 2023 17:17:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nDPOJbmmwmS5YwAAMHmgww
	(envelope-from <mhocko@suse.com>); Thu, 27 Jul 2023 17:17:45 +0000
Date: Thu, 27 Jul 2023 19:17:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, wuyun.abel@bytedance.com,
	robin.lu@bytedance.com
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Message-ID: <ZMKmuLqyjePWESux@dhcp22.suse.cz>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <7dbaabf9-c7c6-478b-0d07-b4ce0d7c116c@oracle.com>
 <CAADnVQLdu_6aJH+0wwpKB146HvxkhvL-uRGAqSPZ8jDMAMqX=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLdu_6aJH+0wwpKB146HvxkhvL-uRGAqSPZ8jDMAMqX=A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu 27-07-23 08:57:03, Alexei Starovoitov wrote:
> On Thu, Jul 27, 2023 at 4:45 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 27/07/2023 08:36, Chuyi Zhou wrote:
> > > This patchset tries to add a new bpf prog type and use it to select
> > > a victim memcg when global OOM is invoked. The mainly motivation is
> > > the need to customizable OOM victim selection functionality so that
> > > we can protect more important app from OOM killer.
> > >
> >
> > It's a nice use case, but at a high level, the approach pursued here
> > is, as I understand it, discouraged for new BPF program development.
> > Specifically, adding a new BPF program type with semantics like this
> > is not preferred. Instead, can you look at using something like
> >
> > - using "fmod_ret" instead of a new program type
> > - use BPF kfuncs instead of helpers.
> > - add selftests in tools/testing/selftests/bpf not samples.
> 
> +1 to what Alan said above and below.
> 
> Also as Michal said there needs to be a design doc with pros and cons.
> We see far too often that people attempt to use BPF in places where it
> shouldn't be.
> If programmability is not strictly necessary then BPF is not a good fit.

To be completely honest I am not sure whether BPF is the right fit
myself. It is definitely a path to be explored but maybe we will learn
not the proper one in the end. The primary reason for considering it
though is that there is endless (+1) different policies how to select a
victim to kill on OOM. So having an interface to hook into and make that
decision sounds very promissing. This might be something very static
like EXPORT_SYMBOL that a kernel module can hook into or a more broader
BPF callback that could be more generic and therefore allow for easier
to define policy AFAIU.
-- 
Michal Hocko
SUSE Labs

