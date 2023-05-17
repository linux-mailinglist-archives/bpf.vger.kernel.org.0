Return-Path: <bpf+bounces-768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CDB706784
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869C41C20B6D
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D972C752;
	Wed, 17 May 2023 12:05:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CC211C
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 12:05:42 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64837658C;
	Wed, 17 May 2023 05:05:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 09DC268BEB; Wed, 17 May 2023 14:05:29 +0200 (CEST)
Date: Wed, 17 May 2023 14:05:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	cyphar@cyphar.com, lennart@poettering.net,
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <20230517120528.GA17087@lst.de>
References: <20230516001348.286414-1-andrii@kernel.org> <20230516001348.286414-2-andrii@kernel.org> <20230516-briefe-blutzellen-0432957bdd15@brauner> <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com> <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 11:11:24AM +0200, Christian Brauner wrote:
> Adding fsdevel so we're aware of this quirk.
> 
> So I'm not sure whether this was ever discussed on fsdevel when you took
> the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
> invalid value.

I've never heard of this before, and I think it is compltely
unacceptable. 0 ist just a normal FD, although one that happens to
have specific meaning in userspace as stdin.

> 
> If it was discussed then great but if not then I would like to make it
> very clear that if in the future you decide to introduce custom
> semantics for vfs provided infrastructure - especially when exposed to
> userspace - that you please Cc us.

I don't think it's just the future.  We really need to undo this ASAP.


