Return-Path: <bpf+bounces-1084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED30F70D9CC
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 12:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CA61C20CE7
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC00B1EA60;
	Tue, 23 May 2023 10:03:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFDD1E501
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57D9C4339C;
	Tue, 23 May 2023 10:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684836199;
	bh=4KaikA8SZdt7zWz7GfmPF1T0Vq2qKT+hszZ8VMULmvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlVKcW7t2pJ4KIwK9kBxMfnsH6PTo920EjHFKeHjnO/tkD6iDabgwRCLrjxCzqqY+
	 3EJFfQb6nS1GfBiFVhMiEAs2e4EyopMIiOACxVN7vuuMpPXqy1qJmhE+X1iEanTZmY
	 PbvOF2n3kqvSIsNzD+zNN1L/+zGUUCzF0scsTl/O5HipMQenikRJQgb6ZJRUEX6IiX
	 6zjXxQDTXCQHVnkKhgTM3VywIoH1bA7nxcOZ2m7tLJ34BLwd1n4LgS0ZiL6cJda+/a
	 DxACTpEzfWleyIWyMvbOPGGNXwHwPiuEy+5Tt63AhzsYL3UU5+AVflK+WqrQqM0FoN
	 pfB1XyXdHptng==
Date: Tue, 23 May 2023 12:03:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, cyphar@cyphar.com, lennart@poettering.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: validate BPF object in BPF_OBJ_PIN
 before calling LSM
Message-ID: <20230523-gemein-kiesgrube-3343b4dc2eb4@brauner>
References: <20230522232917.2454595-1-andrii@kernel.org>
 <20230522232917.2454595-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522232917.2454595-2-andrii@kernel.org>

On Mon, May 22, 2023 at 04:29:14PM -0700, Andrii Nakryiko wrote:
> Do a sanity check whether provided file-to-be-pinned is actually a BPF
> object (prog, map, btf) before calling security_path_mknod LSM hook. If
> it's not, LSM hook doesn't have to be triggered, as the operation has no
> chance of succeeding anyways.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

