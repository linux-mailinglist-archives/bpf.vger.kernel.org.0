Return-Path: <bpf+bounces-5756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A55760087
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785841C20C78
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0BD101E8;
	Mon, 24 Jul 2023 20:31:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B2DDC9
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 20:31:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F571728;
	Mon, 24 Jul 2023 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AYmPB6eKX/pK+eH7NmvpIyaBhO0aePPARgfiAYIigdk=; b=wFoyhuxXtvPIqJZ6PEFFXJ9fjV
	mJohraR43/WrtV99f3DQJwBTVIQBSOMjsE8vCVdJJVSw1jzPDQ1IKaDjzFbp41x69Z+TTlDlJiYn7
	IBLp4HqTpzfnIH7z8fbaI9jB/iQI55djcyNegdh2D6tGQ3XSrTu/0hx4C8ZuZqWMQYS3whJr0c6OR
	4dbHevzw5168GzLw2TWpHAWltiXahXdFP+TbkxcCCWQs71kncRwLvv165YxrTiQ5fM3vxR7APQViS
	yeMRGOtCA6Up4tdHnRjYJeWsLuuqVAigN/8CyIlT8MuJWswCiTs5HzO6xYlYrEJoxAazxg6lS5ror
	tTLK+A3w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qO2D8-005NqM-0A;
	Mon, 24 Jul 2023 20:31:18 +0000
Date: Mon, 24 Jul 2023 13:31:18 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
Cc: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, llvm@lists.linux.dev,
	nathan@kernel.org, ndesaulniers@google.com,
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in
 init_module_from_file
Message-ID: <ZL7fllo9Td1gJmHo@bombadil.infradead.org>
References: <0000000000000e4cc105ff68937b@google.com>
 <ZL7Una9vhJpX+dkb@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL7Una9vhJpX+dkb@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6

