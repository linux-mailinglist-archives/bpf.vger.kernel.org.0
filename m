Return-Path: <bpf+bounces-5743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0075FFE5
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151C62813D8
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 19:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED041101F8;
	Mon, 24 Jul 2023 19:43:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4B101EC
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 19:43:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A3170E;
	Mon, 24 Jul 2023 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jt72MNl3swMARzj53k4BB65l+UHgCy67wPWcGfx/NOk=; b=HikHJobVOYJmiv1G3z0sNjBRUC
	E32VxxdtnfRht167qmJJO18u//Qb1jaDqmUdIGtdOHNkxZKeoBiN2poJrR6f1pEtNJJ0IiBKNr4YF
	PILWV69/8e/P+rkfrv9wIQY9bblY4CuXo5YdyGUlS4DPpWaOBKBftEVaz/oAE1aizladxWrf7Ygmg
	cTzQ2nLGBVeKvAz1xjk3sQAe/M/KM0xA866IkiWhizPVbu4bV+Fwo2hGoEEE3TbIfy+suMjjz26gw
	nVf2XrmgqM3aTaiURwGAUcnIYQ1eANLBPv7FMYgeTIxDs/XLLQzbg9lrTXh9tmmrKjqr+Dq5euc2F
	f6ng6+qw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1TF-005Jop-1P;
	Mon, 24 Jul 2023 19:43:53 +0000
Date: Mon, 24 Jul 2023 12:43:53 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
Cc: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, llvm@lists.linux.dev,
	nathan@kernel.org, ndesaulniers@google.com,
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] WARNING in init_module_from_file
Message-ID: <ZL7UedKQUDAUThHM@bombadil.infradead.org>
References: <00000000000076961f05ff92d4e0@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000076961f05ff92d4e0@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6 

