Return-Path: <bpf+bounces-5755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C7760084
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF90281579
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF61100CD;
	Mon, 24 Jul 2023 20:31:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDFE1118D
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 20:31:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E05D12C;
	Mon, 24 Jul 2023 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cZPnreDr2P2h/GQ+L4OSlct8mt5KXo29iB8a2WGbwWE=; b=CjzVZCIlU59OFrBK/e/dd44SOw
	qc6fPT4GhgcfShzxKWBT7CHg8DhcuZpMMvpW1SXy1TzX2aRsAA8IU/VZd1poXejOMaqVxrumHAanw
	pJnlvohBmkJd0J+qwvPgmBI8K1qEWkf9V1wROkNs1vOi86PjQ+qr11hqS2T8ydNpJndf5UN+81AFU
	Ex3hiGvTuyY3IHMeDas+hoe6Z5k/s7HynY5DICc6oa3jrYSprX70EYWEV8s1KGfBsP9qDXDQlU/rg
	dibx6N/kyn2xBsZgqwbu+bvzqmNhK9iFvzwxk79ILdqqZEnDJG9tNbyDhrc+FBduTjo08rmQTLQuv
	HVdS47Rw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qO2Cs-005Nna-2r;
	Mon, 24 Jul 2023 20:31:02 +0000
Date: Mon, 24 Jul 2023 13:31:02 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
Cc: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, llvm@lists.linux.dev,
	nathan@kernel.org, ndesaulniers@google.com,
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] WARNING in init_module_from_file
Message-ID: <ZL7fhuAHmlcEHj73@bombadil.infradead.org>
References: <00000000000076961f05ff92d4e0@google.com>
 <ZL7UedKQUDAUThHM@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL7UedKQUDAUThHM@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6 

