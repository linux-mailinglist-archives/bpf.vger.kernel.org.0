Return-Path: <bpf+bounces-948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFBC708EF0
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 06:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4441C211D6
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 04:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211264B;
	Fri, 19 May 2023 04:44:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE47C
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 04:44:40 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA1E69;
	Thu, 18 May 2023 21:44:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d341bdedcso120651b3a.3;
        Thu, 18 May 2023 21:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684471477; x=1687063477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3qU23hzpwkx3Wy1H2sGt+EroI1bNHtby3EvKdFirqI=;
        b=VmMd8cSlX9dWYR+rXdoTeEhaQK0sYUw4+tBtIrJYdbpjuHE3dfAkpFH6BdZGzJ70H7
         9wx6JfVUUhjZGv6zbGe9UABdpKCZs0GJ3saRwdx0EhYIBnqQ4j+/klR0PoslYddmGq+h
         T9Bph2Of6x/Mzrdb7w6+9NE6MphikUp6zgIJR91wlij20THBa+SUh0+EtjNNwbZ1p7tj
         7q0Pqe4ABFswx4MU3HofjXRbtBl98Sc3Nn9lD/olCMMxc9dfD8uSuxGedSTsusiy3SSf
         V1GltMKaVFr66IijQ/duGFvDzetJ37fbT57wZIfQFJeG1eeBms3YO+1gHCQAGDVeQz5C
         6wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684471477; x=1687063477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3qU23hzpwkx3Wy1H2sGt+EroI1bNHtby3EvKdFirqI=;
        b=CB/Rh1Q0RWX/xIFPoNKUdjCuUA8IZ+OwkdJ74wUiICFU3c1u7SALaiFdESsahXcAv8
         X9o+BC+q6SGh/r9hTg3ZtrhVLsKnmG4In84KRdgLhRTTCJGYubPnos5ecG8tjKwz9Uq8
         mkPe+rQtV3lctJpWYriQYOHAGXYOSJKLtDJzwFJm1gdmjxRZK6Xlp4jIzv+j1pVL40Od
         y01q9KfNoTkumpZbqDj+scsMEi0onHKEZ37kWXQb/1BnJ3KQojKrYTsRaPsjkalMVNPZ
         UwZklwPnNZDv2ijgLhKlFYeYFQRWOUusDneKBuLtfiZfiYhnqIjZsHp1Cl6WH1edcMaM
         P61w==
X-Gm-Message-State: AC+VfDwS7Bk049a0gwMsqqkRdxOoystmoIm+N4osE/m0zessrKnCWkmY
	0psOuZxKRj95NIH+BDmbwiY=
X-Google-Smtp-Source: ACHHUZ4NhN0fY48dzO0knrhf6etMjha24Qg6jN7+tZOGgo3aBSsLt0vof/aLK7mhN7nW7TnBPhVQNQ==
X-Received: by 2002:a05:6a00:2d26:b0:64c:b45f:fc86 with SMTP id fa38-20020a056a002d2600b0064cb45ffc86mr1595837pfb.17.1684471477124;
        Thu, 18 May 2023 21:44:37 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:e212])
        by smtp.gmail.com with ESMTPSA id h11-20020a62b40b000000b0063d29df1589sm2091338pfn.136.2023.05.18.21.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:44:36 -0700 (PDT)
Date: Thu, 18 May 2023 21:44:33 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
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
Message-ID: <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
References: <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
 <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner>
 <20230518182635.na7vgyysd7fk7eu4@MacBook-Pro-8.local>
 <CAHk-=whg-ygwrxm3GZ_aNXO=srH9sZ3NmFqu0KkyWw+wgEsi6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whg-ygwrxm3GZ_aNXO=srH9sZ3NmFqu0KkyWw+wgEsi6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 11:57:14AM -0700, Linus Torvalds wrote:
> That is nobody's fault but your own, and you should just admit it rather
> than trying to double down on being wrong.

You're correct. I was indeed doubling down on that.
Thanks for putting it straight like that.

> The 0/1/2 file descriptors are not at all special. They are a shell
> pipeline default, nothing more. They are not the argument your think they
> are, and you should stop trying to make them an argument.

I'm well aware that any file type is allowed to be in FDs 0,1,2 and
some user space is using it that way, like old inetd:
https://github.com/guillemj/inetutils/blob/master/src/inetd.c#L428
That puts the same socket into 0,1,2 before exec-ing new process.

My point that the kernel has to assist user space instead of
stubbornly sticking to POSIX and saying all FDs are equal.

Most user space developers know that care should be taken with FDs 0,1,2,
but it's still easy to make a mistake.

To explain the motivation a bit of background:
"folly" is a core C++ library for fb apps. Like libstdc++ and a lot more.
Until this commit in 2021:
https://github.com/facebook/folly/commit/cc9032a0e41a0cba9aa93240c483cfceb0ff44ea
the user could launch a new process with flag "folly::Subprocess::CLOSE".
It's useful for the cases when child doesn't want to inherit stdin/out/err.
There is also GLOG. google's logging library that can be configured to log to stderr.
Both libraries are well written with the high code quality.
In a big app multiple people use different pieces and may not be aware
how all pieces are put together. You can guess the rest...
Important service used a library that used another library that started a
process with folly::Subprocess::CLOSE. That process opened network connections
and used glog. It was "working" for some time, because sys_write() to a socket
is a valid command, but when TCP buffers got full synchronous innocuous logging
prevented parent from making progress.

That footgun was removed from folly in 2021, but we still see this issue from time to time.
My point that the kernel can help here.
Since folks don't like sysctl to control FD assignment how about something like this:

diff --git a/fs/file.c b/fs/file.c
index 7893ea161d77..896e79433f61 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -554,9 +554,15 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
        return error;
 }

+__weak noinline u32 get_start_fd(void)
+{
+       return 0;
+}
+/* mark it as BPF_MODIFY_RETURN to let bpf progs adjust return value */
+
 int __get_unused_fd_flags(unsigned flags, unsigned long nofile)
 {
-       return alloc_fd(0, nofile, flags);
+       return alloc_fd(get_start_fd(), nofile, flags);
 }

Then we can enforce fd >= 3 for a certain container or for a particular app.

