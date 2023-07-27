Return-Path: <bpf+bounces-6058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7773764CAD
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 10:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7310C2820F8
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4DD50F;
	Thu, 27 Jul 2023 08:25:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862CD2F0
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 08:25:02 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E32C9AD;
	Thu, 27 Jul 2023 01:24:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7A1E1F86A;
	Thu, 27 Jul 2023 08:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1690445716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gY74IzTCesS0wb70fi0IwI5ytjeH3ogluPp5I4+w60Q=;
	b=gTGvQ7d1fdL8EgiK/BHVi3m/TYh7xgr12LDZ1sG9jUAP60Pm9p5h+HYwKoTWTAB3Bi0d6z
	vNxtR8/PqsL6NyWzguauQv5uH9tj/RycaO+d2zM+UpsHi453Z7SinHnPu5G46CP/FMKmzV
	oYQbbi+v8LrG0sCY0gkMtmmzafaNStM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB04613902;
	Thu, 27 Jul 2023 08:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HiiPKpQnwmQsSQAAMHmgww
	(envelope-from <mhocko@suse.com>); Thu, 27 Jul 2023 08:15:16 +0000
Date: Thu, 27 Jul 2023 10:15:16 +0200
From: Michal Hocko <mhocko@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	robin.lu@bytedance.com
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Message-ID: <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727073632.44983-1-zhouchuyi@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu 27-07-23 15:36:27, Chuyi Zhou wrote:
> This patchset tries to add a new bpf prog type and use it to select
> a victim memcg when global OOM is invoked. The mainly motivation is
> the need to customizable OOM victim selection functionality so that
> we can protect more important app from OOM killer.

This is rather modest to give an idea how the whole thing is supposed to
work. I have looked through patches very quickly but there is no overall
design described anywhere either.

Please could you give us a high level design description and reasoning
why certain decisions have been made? e.g. why is this limited to the
global oom sitation, why is the BPF program forced to operate on memcgs
as entities etc...
Also it would be very helpful to call out limitations of the BPF
program, if there are any.

Thanks!
-- 
Michal Hocko
SUSE Labs

