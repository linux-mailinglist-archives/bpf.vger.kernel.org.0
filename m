Return-Path: <bpf+bounces-5745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138F275FFED
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440431C20BD9
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69C101FC;
	Mon, 24 Jul 2023 19:46:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3A10782
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 19:46:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8698B170E;
	Mon, 24 Jul 2023 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ijMl1Cv9y9enj5ovf4v4qSeTqopWOU/OBedk6+5VrX0=; b=o/MKFZwzv0jFes6m40Ybq+6Z0l
	OWIXSREb5FqwPLK9im6nfojshNNzR9gGww1EgQvj76Ej9giQjz3yyzFzjd7Rj3nJetHlcUkV9fjIe
	cNSMlm/f+nZl+Fxhi9N5p3eiqBsOnPOeIw1dXWBX8uA8DcJqXJom7btsb/G+h8HlnamwkaC/mjjtP
	SRw7Q4CT8pAJQQr4a/m2eLHsCGCh+H7hneUdZpjKETk+toWv44Q2f1yUxdj+Xo2KqkFl9rtT3fFg2
	CCezJyFkdXV4rOpe1TAP3jleOtN3PXyl6k+LcnwXQtHFnFIzrp5x+H6CEXXi/bgoPpgV8zDPR+LFq
	akNUH4qg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1VN-005K1E-1M;
	Mon, 24 Jul 2023 19:46:05 +0000
Date: Mon, 24 Jul 2023 12:46:05 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
Cc: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, llvm@lists.linux.dev,
	nathan@kernel.org, ndesaulniers@google.com,
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
Message-ID: <ZL7U/V3SFaJndkhW@bombadil.infradead.org>
References: <00000000000094ac8b05ffae2bf2@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000094ac8b05ffae2bf2@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6

