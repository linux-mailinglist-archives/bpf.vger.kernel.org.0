Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D3713CAE0
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 18:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAORYU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 12:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgAORYU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 12:24:20 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77CB207FF;
        Wed, 15 Jan 2020 17:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579109059;
        bh=b+aRmNZSG+rZiH8nNM8CW6uxu+f2JgSIa4gTfT3WMDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wicVpOCcLbMKoUychULSEd3NuKHeuWqbnKMMcxDVCvgzlbz3fTIH1nrV+7Kp+RJo8
         qvIhW61lPlz6rFGByKDshXIpidYU7Uv5kfAMIlu2vy6e4r8gkAODwJd7HF1/a/4m/U
         Aadtgd4vG0UgbcRavBsgdulm/ESRdgJ0qA4fMCb8=
Date:   Wed, 15 Jan 2020 18:24:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 06/10] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200115172417.GC4127163@kroah.com>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-7-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115171333.28811-7-kpsingh@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 15, 2020 at 06:13:29PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> JITed BPF programs are used by the BPF LSM as dynamically allocated
> security hooks. arch_bpf_prepare_trampoline handles the
> arch_bpf_prepare_trampoline generates code to handle conversion of the
> signature of the hook to the BPF context and allows the BPF program to
> be called directly as a C function.
> 
> The following permissions are required to attach a program to a hook:
> 
> - CAP_SYS_ADMIN to load the program
> - CAP_MAC_ADMIN to attach it (i.e. to update the security policy)

You forgot to list "GPL-compatible license" here :)

Anyway, looks good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
