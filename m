Return-Path: <bpf+bounces-3856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C67454C6
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 07:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903A5280C58
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 05:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637B77FD;
	Mon,  3 Jul 2023 05:23:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289307E3
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 05:23:23 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630F1A7;
	Sun,  2 Jul 2023 22:23:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZ874DWqz4wxS;
	Mon,  3 Jul 2023 15:23:19 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, Hari Bathini <hbathini@linux.ibm.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, stable@vger.kernel.org
In-Reply-To: <20230425065829.18189-1-hbathini@linux.ibm.com>
References: <20230425065829.18189-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/bpf: populate extable entries only during the last pass
Message-Id: <168836167606.46386.1266997701169825170.b4-ty@ellerman.id.au>
Date: Mon, 03 Jul 2023 15:21:16 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 25 Apr 2023 12:28:29 +0530, Hari Bathini wrote:
> Since commit 85e031154c7c ("powerpc/bpf: Perform complete extra passes
> to update addresses"), two additional passes are performed to avoid
> space and CPU time wastage on powerpc. But these extra passes led to
> WARN_ON_ONCE() hits in bpf_add_extable_entry() as extable entries are
> populated again, during the extra pass, without resetting the index.
> Fix it by resetting entry index before repopulating extable entries,
> if and when there is an additional pass.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/bpf: populate extable entries only during the last pass
      https://git.kernel.org/powerpc/c/35a4b8ce4ac00e940b46b1034916ccb22ce9bdef

cheers

