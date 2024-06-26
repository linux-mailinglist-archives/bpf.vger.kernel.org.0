Return-Path: <bpf+bounces-33130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54291791D
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8711F22C29
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 06:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E672E14F9E1;
	Wed, 26 Jun 2024 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L6SYCSY6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2C171AD
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384284; cv=none; b=YjB7YREn4cElpLVmwqLwwhrg5pS4x2BjbJgd3bhBfUIq6mVkrVQ3yfi2RZ5FomWlNmGVmgsjD+QmnI10v0xDFkwelyqJ8g4djp+t45Y2SMVEoHofDn9u+Jcn7NohbbABn51rGbEtyQNDVYzrzlK2xN9Ir5qQ4dQEnV9ze1R9HdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384284; c=relaxed/simple;
	bh=sQtjV/DsknBaEV9QRJ2DhYybsbw/HxK5/e0h7fXanDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7/R3J3yrdv2rgGi3cJp/RBCTe3toGhqJOoKl3g3bTHKrKX5io6bL91dIM7JN3snfXvncvTUo8pqe0wyyGhfvFLyqr6WkmIVBjKilLQ3TwZMSFhBp/pLXZUTtPBjumecuqIfofcq6rI7WUzYUqPhFtCZmkC/8pjvOmurTmotBzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L6SYCSY6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso65733941fa.3
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719384280; x=1719989080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upm213LCndXRtkYBP/k1fZtAF3Nih3cvlnubABHsAAU=;
        b=L6SYCSY6kLFpWh4T72JDTaf4TpC8Bh0pR2OGXwcHYg3+hEvHZsQctYFX4qIR2fW50c
         R1aFnYhsTJYTsLs54r2tqYoLyDSPbtSMeUwjv47xrF4PA1Yaab6GLN6IW5nQOqwsew0y
         LNx1SKDUnRdkHlkpMBQCCMAGBw7K0tdL3s5yCyLyx81TxaXhP/plqf4BTeVubg9FWIC3
         KmaxQXqldb+JOrHv1vgFngZ6G1KVhEzTAbucntdoYotJjqXj5U4WuNSnEcpH6ByaPhoL
         x+9jAW29zu/B9SVCnLRQSGqpkTZ4yVIWMwQXFvVWlJ51+yGUUCSWx6iCju4jFu0ipj81
         HMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384280; x=1719989080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upm213LCndXRtkYBP/k1fZtAF3Nih3cvlnubABHsAAU=;
        b=R+tFneLuiZfCXbR0VlGZBQ/T3jg2LOYyNrmdMRkKp1VB9dqUxuPwYSwbpf50Ac0HsV
         irlTSuwF9UFsOvedVd81O+Y8BEYyaMNG7Xc80dsaP/AlAcZg4B3VRgFTKDG/UPM+Eb27
         mqTlHAFb7jPCNqnbjP+rrBo0zUDN9YeT8gO/9zYsdvf58xI7L/5z7le5unPwNIUejM2I
         iWNrMQvkF4ne24b5ODJlEB7SjJcjobFHhQu3W9GGn9L1Q475+sBNzD3V0wUKh88sJIhg
         OSq4D+ZWJ3GM1hcyl1S1bQ0DnJbc/xmtG7wmyi67Ef2Y9HZEXhWAda4kZHoik/mP+6kj
         trKw==
X-Forwarded-Encrypted: i=1; AJvYcCUHIIlEbwsDTEq0DMB1AqBmI4Gu1sntOje750LyOlqk9FCiLF4ILoEfsqEDtY2wbI85XSHYONjZHdbFrW8ik47Bfx+M
X-Gm-Message-State: AOJu0YyEx1dUtAAF+d/3wQP7BUvb6OVpsKMyCBLa/V3u+pjhBMSczuxd
	onq15Smwvy4Ve4gc6e7nVO+grVw2pTvQpaFLzni2oPxiipxVnsFMWJsjZORaW4g=
X-Google-Smtp-Source: AGHT+IFvp94Jq8r/nW0sLoomFwIYcAmOhp9Np+bFI/GlYSL6wmdtpfyAAqMD+4qFqLR0lqPPsouG9w==
X-Received: by 2002:a2e:3203:0:b0:2ec:5430:7f6b with SMTP id 38308e7fff4ca-2ec59587bdfmr55241741fa.49.1719384280499;
        Tue, 25 Jun 2024 23:44:40 -0700 (PDT)
Received: from u94a ([2401:e180:8840:49da:ed05:227a:7b40:7717])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb22dffesm8178043a12.83.2024.06.25.23.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:44:39 -0700 (PDT)
Date: Wed, 26 Jun 2024 14:44:31 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Stanislav Fomichev <sdf@google.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: CVE-2024-38564: bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
 enforcement in BPF_LINK_CREATE
Message-ID: <sgnl2ithdfmum4jlgbqcbhenm2roioypqk2ndmyq4xd2h4svwp@s3dmiiaxh3jf>
References: <2024061955-CVE-2024-38564-b069@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061955-CVE-2024-38564-b069@gregkh>

On Wed, Jun 19, 2024 at 03:36:13PM GMT, Greg Kroah-Hartman wrote:
> In the Linux kernel, the following vulnerability has been resolved:
> 
> bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE
> 
> bpf_prog_attach uses attach_type_to_prog_type to enforce proper
> attach type for BPF_PROG_TYPE_CGROUP_SKB. link_create uses
> bpf_prog_get and relies on bpf_prog_attach_check_attach_type
> to properly verify prog_type <> attach_type association.
> 
> Add missing attach_type enforcement for the link_create case.
> Otherwise, it's currently possible to attach cgroup_skb prog
> types to other cgroup hooks.
> 
> The Linux kernel CVE team has assigned CVE-2024-38564 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 5.7 with commit af6eea57437a and fixed in 6.6.33 with commit 6675c541f540
> 	Issue introduced in 5.7 with commit af6eea57437a and fixed in 6.8.12 with commit 67929e973f5a
> 	Issue introduced in 5.7 with commit af6eea57437a and fixed in 6.9.3 with commit b34bbc766510
> 	Issue introduced in 5.7 with commit af6eea57437a and fixed in 6.10-rc1 with commit 543576ec15b1

I'd like to dispute the affected commit for this CVE.

The commit that introduced the issue should instead be commit
4a1e7c0c63e02 ("bpf: Support attaching freplace programs to multiple
attach points") in 5.10.

When link_create() was added in commit af6eea57437a, it uses
bpf_prog_get_type(attr->link_create.prog_fd, ptype) to resolve struct
bpf_prog, which effectively does the requried

	prog->type == attach_type_to_prog_type(attach_type)

check through bpf_prog_get_ok(), and thus would not allow
BPF_PROG_TYPE_CGROUP_SKB to be attached to other cgroup hooks.

It is in commit 4a1e7c0c63e02 ("bpf: Support attaching freplace programs
to multiple attach points") that had bpf_prog_get_type() replaced with
bpf_prog_get() and lead to the removal of such check, making it possible
to attach BPF_PROG_TYPE_CGROUP_SKB to other cgroup hooks.

[...]

