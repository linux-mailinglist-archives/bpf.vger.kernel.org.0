Return-Path: <bpf+bounces-1293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53769712207
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 10:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5C51C20FA5
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 08:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBDEC2DB;
	Fri, 26 May 2023 08:19:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0970A93B
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 08:19:36 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BBDF3
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 01:19:31 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 6FDF7E8022C;
	Fri, 26 May 2023 10:19:27 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id A3EDC16006B; Fri, 26 May 2023 10:19:26 +0200 (CEST)
Date: Fri, 26 May 2023 10:19:26 +0200
From: Lennart Poettering <lennart@poettering.net>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org
Subject: Re: [PATCH bpf-next 1/2] libbpf: ensure libbpf always opens files
 with O_CLOEXEC
Message-ID: <ZHBrjg4xCNl0Z6KY@gardel-login>
References: <20230525221311.2136408-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525221311.2136408-1-andrii@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Do, 25.05.23 15:13, Andrii Nakryiko (andrii@kernel.org) wrote:

> Make sure that libbpf code always gets FD with O_CLOEXEC flag set,
> regardless if file is open through open() or fopen(). For the latter
> this means to add "e" to mode string, which is supported since pretty
> ancient glibc v2.7.
>
> I also dropped outdated TODO comment in usdt.c, which was already completed.
>
> Suggested-by: Lennart Poettering <lennart@poettering.net>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf.c           | 2 +-
>  tools/lib/bpf/libbpf.c        | 6 +++---
>  tools/lib/bpf/libbpf_probes.c | 2 +-
>  tools/lib/bpf/usdt.c          | 5 ++---
>  4 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 0a2c079244b6..8484b563b53d 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1064,7 +1064,7 @@ static struct btf *btf_parse_raw(const char *path, struct btf *base_btf)
>  	int err = 0;
>  	long sz;
>
> -	f = fopen(path, "rb");
> +	f = fopen(path, "rbe");

You might as well drop the "b". That's a thing only on non-POSIX
systems. So unless you want to support windows with this, you can drop
it with zero effect.

Thanks for doing this, much appreciated!

Lennart

--
Lennart Poettering, Berlin

