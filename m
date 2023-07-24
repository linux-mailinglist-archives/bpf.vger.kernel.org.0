Return-Path: <bpf+bounces-5757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B414B76008A
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4B12814BF
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A190101F7;
	Mon, 24 Jul 2023 20:31:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0A100BB
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 20:31:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8931737;
	Mon, 24 Jul 2023 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cZPnreDr2P2h/GQ+L4OSlct8mt5KXo29iB8a2WGbwWE=; b=PFnas0yJuvH3kkkb0BYx8Li24b
	whAPm5P0txbFhDaRjAdDMs15anEl9uzkqz2eB4RlEb/LyDYyIhraZpwtmxLuZBO3DgXQ3yy8hO7U7
	B03Lrb7fpHDkoyO4JFHkazqP/CLpK7mYE4+qBHNKgM0E3OEKryK0h0j7X8Ne7msvMmSdn/HskwE3P
	KsiCaGf0gyYyLcDhoDrxtrEmfIOpYQBV8dflfN84EYiuCiwnnt/hECZ4ag91kz/xQ0Ahg3TI/8qWL
	JfxXaEXy85I+Ni5hF+rLLanw4XKC+E0pEZWk4nRsyCNCvp8b9p3h7DpzTo7LkM4LDzMDfrdBT4F8+
	1+lU+9IA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qO2DK-005NsG-0t;
	Mon, 24 Jul 2023 20:31:30 +0000
Date: Mon, 24 Jul 2023 13:31:30 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
Cc: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, llvm@lists.linux.dev,
	nathan@kernel.org, ndesaulniers@google.com,
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
Message-ID: <ZL7fogwmV+JJcrVN@bombadil.infradead.org>
References: <00000000000094ac8b05ffae2bf2@google.com>
 <ZL7U/V3SFaJndkhW@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL7U/V3SFaJndkhW@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6

