Return-Path: <bpf+bounces-4081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C6F748A04
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 19:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F288F1C20BA2
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1D134C1;
	Wed,  5 Jul 2023 17:17:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CD11CAE;
	Wed,  5 Jul 2023 17:17:23 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCD59F;
	Wed,  5 Jul 2023 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=2jFTDKijwef0tyLNmSDBdpMeN+9aOsVKRMVaf/HuEpk=; b=AUpCBF11Reuum3lUqr25W2qqmF
	pAvvMv074SjJx9pA/AUXPYu/PGjyTDIhmWHP2uegOE5ca7agQZmyeZ/zZYLd3zUYhxFudEHUlaRbb
	prnE4cFru5+31oYBX8DMEzOv03DoQ6NEmE9sdo6XxKYxOQwIFP+B36PUhg9dQOYKf+La1rQAqJ9AA
	USpOeQpcRWemV/z9P8kjHYlAIkUEY+rpM9RtGZY/9vo0er1SHNAZwRSSk3Cq5a4l0iqwV0gaqrRir
	zTqg2LKbGBU1/FhYGmYcwxjAtn7kNVs1+UQ7e+3UnE4/nf2xuqre71oQqOmLV6eU71faXHfqvgh2a
	rfrd2VBA==;
Received: from 31.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.31] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH67w-000OKD-TN; Wed, 05 Jul 2023 19:17:17 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2023-07-05
Date: Wed,  5 Jul 2023 19:17:16 +0200
Message-Id: <20230705171716.6494-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 2 non-merge commits during the last 1 day(s) which contain
a total of 3 files changed, 16 insertions(+), 4 deletions(-).

The main changes are:

1) Fix BTF to warn but not returning an error for a NULL BTF to still be
   able to load modules under CONFIG_DEBUG_INFO_BTF, from SeongJae Park.

2) Fix xsk sockets to honor SO_BINDTODEVICE in bind(), from Ilya Maximets.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alexander Egorenkov, Jason Wang, Jiri Olsa, John Fastabend, Magnus 
Karlsson

----------------------------------------------------------------

The following changes since commit acd9755894c96c27078b52e0bfd894e48b0b1508:

  Documentation: ABI: sysfs-class-net-qmi: pass_through contact update (2023-07-03 09:25:50 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to f7306acec9aae9893d15e745c8791124d42ab10a:

  xsk: Honor SO_BINDTODEVICE on bind (2023-07-04 10:19:48 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Ilya Maximets (1):
      xsk: Honor SO_BINDTODEVICE on bind

SeongJae Park (1):
      bpf, btf: Warn but return no error for NULL btf from __register_btf_kfunc_id_set()

 Documentation/networking/af_xdp.rst | 9 +++++++++
 kernel/bpf/btf.c                    | 6 ++----
 net/xdp/xsk.c                       | 5 +++++
 3 files changed, 16 insertions(+), 4 deletions(-)

