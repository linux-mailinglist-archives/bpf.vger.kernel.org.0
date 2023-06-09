Return-Path: <bpf+bounces-2249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3A72A254
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 20:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89C61C2118E
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC832DBD6;
	Fri,  9 Jun 2023 18:32:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA973D38D
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 18:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BD3C4339B;
	Fri,  9 Jun 2023 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686335558;
	bh=STU3Tv/r0O1GGB8jYK3ZFllhddnik3Om6vxPQUm4bLA=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=hKdJTBA5wzWbKUuXr3OU99zHGJItn9ohuD/HnEMljD/26ZuNhFbPRzNmPW3603wuU
	 IAIkwI2kYJOx8qXP290PX4jE1B68fstBFKDF0PCZGlb0UmZ0miskGe83psow8K6+az
	 VySR0XAo703UeIg8bLaDHMY5OgWCjE6X7Mme9m2jScr+fQSmyh/HZ4AdPBrYVnUtpH
	 qCepXc4cDg7R5gmIZGtMolit+No0mzHseh7uWiOlq7J2e7/IRgVYIv3e1d2bOAl07m
	 N6sHSiYDfS9tspYodga0L1muxuVOXmk9Jt6pjxKnqmGm3rBfYGbDhVdNPdNT7HK3DT
	 cTSjFidFap5Lw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id D6AC827C0054;
	Fri,  9 Jun 2023 14:32:36 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Fri, 09 Jun 2023 14:32:36 -0400
X-ME-Sender: <xms:RHCDZF4HJYIdEHTCxb4ujXc5cgTmrJHcXnv6OTqEja-lDXHOo2kY8Q>
    <xme:RHCDZC6zAEVKrcZCTk46kPHdbjjupwL2tDVhLQiEeGLpE6OOzeo6SczvtlJtBPizf
    KajXNcu9L3Ea9ejVtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:RHCDZMf2DwwnP3eFfkfrAzcRwrunEEnJHUQY_z_0EX1RQ1QbaByNAg>
    <xmx:RHCDZOJI2tBdvkjCBAxGWR1soxZD2rijQE9CCLwb6QFb6J-XRFXdAA>
    <xmx:RHCDZJLYB3PIsj0mXFr5RtEyXgPjFVJvpz39iRa1WHtkXfYaH5410w>
    <xmx:RHCDZHgEB7AxNh0jPTXoEYRMutaEMUFnCZ1sUpcWaZTDqwBU52fqqQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7937A31A0063; Fri,  9 Jun 2023 14:32:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
Date: Fri, 09 Jun 2023 11:32:16 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
 "Kees Cook" <keescook@chromium.org>,
 "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain

On Wed, Jun 7, 2023, at 4:53 PM, Andrii Nakryiko wrote:
> This patch set introduces new BPF object, BPF token, which allows to delegate
> a subset of BPF functionality from privileged system-wide daemon (e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about allowing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application that
> would create a BPF token.
>

I skimmed the description and the LSFMM slides.

Years ago, I sent out a patch set to start down the path of making the bpf() API make sense when used in less-privileged contexts (regarding access control of BPF objects and such).  It went nowhere.

Where does BPF token fit in?  Does a kernel with these patches applied actually behave sensibly if you pass a BPF token into a container?  Giving a way to enable BPF in a container is only a small part of the overall task -- making BPF behave sensibly in that container seems like it should also be necessary.

