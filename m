Return-Path: <bpf+bounces-14014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF417DFB19
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 20:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB42B212C9
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E402219E7;
	Thu,  2 Nov 2023 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKuHOZC5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC22137B
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 19:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E512AC433C7;
	Thu,  2 Nov 2023 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698954592;
	bh=um+C0ZoZy5QHLz2KcvGqtlIqOQWsfcu8o7GHGw1IChc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PKuHOZC5rPO6nnl+jAg/hi2TQ2Iymk4ghWslhABaTBidhJk7O1ClsLYk9rIMKkxAh
	 14R9HgACqvpwYgYzDIoN3hYV0+YdGbldhV8RGJm5KSYG314wD6oao7/I/dxV1pmXds
	 YjnwkB1lh+3wPlVqu2kYUdCEeLxcpnIwyzDdG5FfnnhL/PHLeEqMXZB2mPVE1Qi7OC
	 Y6YAIGDIqXYaPlCwNSW/e3CThp/YZVF5EKx+m2kWjtyMdK3cc+2gMWLBqKb8HpX/5+
	 Wr5wGv1uceyicu5LweS0rn2NbxkwYkQlm0PURVObW8Tnakva47/61Jjn+f4oFsan7a
	 SIcxGYz7lVxVg==
Date: Thu, 02 Nov 2023 12:49:50 -0700
From: Kees Cook <kees@kernel.org>
To: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
CC: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
 hengqi.chen@gmail.com
Subject: Re: [PATCH bpf-next 1/6] bpf: Introduce BPF_PROG_TYPE_SECCOMP
User-Agent: K-9 Mail for Android
In-Reply-To: <20231031012407.51371-2-hengqi.chen@gmail.com>
References: <20231031012407.51371-1-hengqi.chen@gmail.com> <20231031012407.51371-2-hengqi.chen@gmail.com>
Message-ID: <6F41D669-AE0C-4CAE-9328-B03BFF7F5643@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 30, 2023 6:24:02 PM PDT, Hengqi Chen <hengqi=2Echen@gmail=2Ecom=
> wrote:
>This adds minimal support for seccomp eBPF programs
>which can be hooked into the existing seccomp framework=2E
>This allows users to write seccomp filter in eBPF language
>and enables seccomp filter reuse through bpf prog fd and
>bpffs=2E Currently, no helper calls are allowed just like
>its cBPF version=2E

I think this is bypassing the seccomp bitmap generation pass, so this will=
 break (at least) performance=2E

I continue to prefer sticking to only cBPF for seccomp, so let's just use =
the seccomp syscall to generate the fds=2E

-Kees

--=20
Kees Cook

