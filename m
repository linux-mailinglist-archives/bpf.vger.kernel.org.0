Return-Path: <bpf+bounces-875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36133708615
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 18:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2505B1C2118A
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207646FB8;
	Thu, 18 May 2023 16:33:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40723C70
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 16:33:42 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A5B3;
	Thu, 18 May 2023 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AjBRHlzs3yP+2PNf7RWBG7EmYvs/IiuEpC95BtDWbmk=; b=uo5j89Hd3X3wXlmAHXVL561iod
	HH/rVtTk0en1K3gILNXr3BxhxABls4mxfNr26bjf43KAwgCeNCz7tnAcw+uQs6fvxRg7dcNZXKX/N
	IzIoJOsUID2vo5ZJqOFUV2V04PwzxlAj6cR1ZlbZ0hq7mlZZJPZ2T2zMJwG0g+iH3ysulfZBsOvM4
	1qMNEZaKhVW1okZ21T4jaPw8RGNYC7X1CKv4nchownqKCFXlgywHCPPfeUGwd4ePPFzhMbgoLRwls
	/8yduNyTwuf6XvAWZfYpokB1S00pdYjmmeFVVCMvOyH0bFms+rQvUaNW6dshoddM83FU9WCumIRQU
	MW3AF1Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pzgZJ-005tWZ-0k; Thu, 18 May 2023 16:33:33 +0000
Date: Thu, 18 May 2023 17:33:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Lennart Poettering <lennart@poettering.net>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <ZGZTXAdS7roSg3WE@casper.infradead.org>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
 <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 09:25:08AM -0700, Alexei Starovoitov wrote:
> We're still talking past each other.
> 0 is an invalid bpf object. Not file.
> There is a difference.
> The kernel is breaking user space by returning non-file FDs in 0,1,2.
> Especially as fd = 1 and 2.
> ensure_good_fd() in libbpf is a library workaround to make sure bpf objects
> are not the reason for user app brekage.
> I firmly believe that making kernel return socket FDs and other special FDs with fd >=3
> (under new sysctl, for example) will prevent user space breakage.

Wait, why are socket FDs special?  I shouldn't be able to have anything
but chardev fds, pipes and regular files as fd 0,1,2?  I agree that having
directory fds and blockdev fds as fd 0,1,2 are confusing and pointless,
but I see the value in having a TCP socket as stdin/stdout/stderr.

If a fd shouldn't be used for stdio, having an ioctl to enable it
and read/write return errors until/unless it's enabled makes sense.
But now we have to label each fd as safe/not-safe for stdio, which we
can as easily do by setting up our fops appropriately.  So I'm not sure
what you're trying to accomplish here.

