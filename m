Return-Path: <bpf+bounces-27046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52958A833C
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51A11C2156F
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B6513C3E0;
	Wed, 17 Apr 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWBAQPIc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A744C6B;
	Wed, 17 Apr 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357463; cv=none; b=ekVB7JaLrU4XAIkNej9f/VxylbrVwaa07JP10zBiRrHCq/Ne3CpTFcoewZecqIgBDBbzU7VC0mircIMJZwipLrhAXyvdsUAL/jn7xGyMxcvGSe5PALhYS24RdM2h0CLOzcDO2JMOXtZa9JoC67h4jrK1G+owmRTlp5ZNSmlxDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357463; c=relaxed/simple;
	bh=8NObq/H4Dilb0Mnzuz0GRC8TDvT8oEl+kBLbpirx3zw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N/Id05rMwByN+frNwPD1PctAqiINKyDVprqiPNKArBKwYK9a88+Ig/l/2l38zkVM23itCoEHVbHTjsW0RZrAEZla9jbeT+PYdvfQhyG623xy54gJI8V4rtBUPpftJHaNUf91IPXxcCFCPkqwIavi1NqQhAvER4JadNUY81rXyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWBAQPIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4080CC072AA;
	Wed, 17 Apr 2024 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713357463;
	bh=8NObq/H4Dilb0Mnzuz0GRC8TDvT8oEl+kBLbpirx3zw=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=VWBAQPIcG5eH+UcK0zoGVNOJ1fwoN8Y23l/oCXcVl/1rHZzXxd0gg2RBCVGV+HeSE
	 8vSNK8noQlpR1r8qacFDJt7mRkJcgG2Ri0Pczr9MlrBQi8XchBgATSr5VvmmktQjdl
	 SaMCm9YaexbHT+73XbAM3+lGzftRqoGZgykJmZl4Xuq7iQGQcBo3ZXUya3vL9WxQWz
	 F49sHhxLZ4thb99SLkaAawgdYTjFFy1hW+FF+SGTReLpEYDIo8mIcNhJaEkRm8KBgs
	 IFnSwIDCMK0XmMWYIhaKHePdXmWbwL7RpymdxbkTA7CR4PQQZXzEBpDOffEQYzYsdc
	 ph0tmdLM/5VPA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4211D123389F; Tue, 16 Apr 2024 22:55:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eadavis@qq.com,
 eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
In-Reply-To: <0000000000003a924406159cf8ee@google.com>
References: <0000000000003a924406159cf8ee@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 16 Apr 2024 22:55:00 +0200
Message-ID: <87il0huixn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> general protection fault in dev_map_enqueue

Alright, trying a different thing (not a correct patch, just testing a theory):

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git 443574b03387

diff --git a/net/core/filter.c b/net/core/filter.c
index 786d792ac816..c2fd4f67766f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4301,8 +4301,9 @@ void bpf_clear_redirect_map(struct bpf_map *map)
                 * cmpxchg() to make sure it hasn't been changed in
                 * the meantime by remote CPU.
                 */
-               if (unlikely(READ_ONCE(ri->map) == map))
-                       cmpxchg(&ri->map, map, NULL);
+               if (unlikely(READ_ONCE(ri->map) == map) &&
+                   cmpxchg(&ri->map, map, NULL) == map)
+                       WRITE_ONCE(ri->map_type, BPF_MAP_TYPE_UNSPEC);
        }
 }

