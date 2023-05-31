Return-Path: <bpf+bounces-1489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15971767C
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 08:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371FE28131B
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 06:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2967563B7;
	Wed, 31 May 2023 06:01:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B264C67
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 06:01:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A60122;
	Tue, 30 May 2023 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=no3TEKUkmUVHzCsaYmjTpfXV5aF4dx90uX+omBYUYF0=; b=2DDNQ3l79qF9AhCeffpq9LM+wL
	fdS0aLm8eJ9zcYqtUEHnxAcURykn/5yZqBrSWnCBBalC91f1jgU8W3+RjRpsHfRbP6AfZqnbvvUQl
	GZcuibr56JdORnHZ7ysNbtaSDLkJeqxxACu1HvGMCGjc6LiSUG5TJ6jD8W+4umfRQw+StNSrWbY7w
	RZ0gSWg/kbuQDgoJE5msEk3bQoZHhwjGy0wYJkMvw/LznVRg/CngjjnnFzv0Zxfnrd7HEVH7CeHf1
	PTomZycSMUMtO0dSvFg7c4rddEIZak8fvfKbzxEmEzNkmXUwMrZX0dpsWXnLJQUjTsfZCYBIvUDEo
	kt5uhIUw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q4Etd-00GEid-2F;
	Wed, 31 May 2023 06:01:21 +0000
Date: Tue, 30 May 2023 23:01:21 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, thunder.leizhen@huawei.com, boqun.feng@gmail.com,
	vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com,
	brauner@kernel.org, michael.christie@oracle.com,
	samitolvanen@google.com, glider@google.com, peterz@infradead.org,
	keescook@chromium.org, stephen.s.brennan@oracle.com,
	alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH 1/1] kallsyms: add kallsyms_show_value defination in all
 cases
Message-ID: <ZHbisZ6eGOM0S0oj@bombadil.infradead.org>
References: <CGME20230531042611epcas5p1f46c41ccec93ce04eef4fe861242ac19@epcas5p1.samsung.com>
 <20230531042600.819453-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531042600.819453-1-maninder1.s@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 09:56:00AM +0530, Maninder Singh wrote:
> so bpf_dump_raw_ok check is not changed.

Since you're adding a new file and making no changes to tons of code but
also making somew new changes I can't tell easily what is new or not.
Although I can see we're now adding a false case for bpf_dump_raw_ok()
it would be best if just split this int wo separate patches. One
non-functional, and a second wwone which extends the code.

  Luis

