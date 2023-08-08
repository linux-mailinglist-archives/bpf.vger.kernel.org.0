Return-Path: <bpf+bounces-7260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6057774384
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 20:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71E91C20E9E
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045B1BB4E;
	Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4B168DE
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467AC7EE1
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 10:35:11 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56477c00ef8so6007847a12.3
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691516111; x=1692120911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbNixERlHqS43p9WnetIfE1bwp3ZFaI202y6cxjDISk=;
        b=BtYnibgAq7g0L/okVpcz1sm6OulXBZOLXW68YAi0kE94x5HCN7bWDWiYRWfi91svGo
         Xc79qQ233j8gXgGltAV/J8/uXgNtnFjybeQZD1f/61BdCanNXGvF03sIBuo0PLfw2n8V
         M74JpyhSFxtW15aRUBl8P3VcNB0wjFg/9n39VGQsWXzGFLdytSDGhhjl7u1Z6CtvJuZN
         /eAqJk8ulH9QCYWJViD5t8z1c0a8y4LlJj9wtw/p4CWVORUdKTqp/wxHXBJvv2h+a/vL
         8rWrgpPqCe+14Q5CE8cj3cirPO2rMueXgtfqCD0+VzHSYfmiNnwNXQhCV4TlIpQyV+Ie
         Hl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516111; x=1692120911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbNixERlHqS43p9WnetIfE1bwp3ZFaI202y6cxjDISk=;
        b=lMZD19vTMOnSpDtWCbd/+bQMjuZequrqM5k9MdIP9Y4lBxhQMxGROYg01yq1HXmkPq
         TdPcJ6dxaO0osdPpi5BAgE+y3ZPDpJ4VImNQgy3m8FeuT98m3oGbIO9PAuD0Yyt1nSu9
         RlTmLAC23AOWZ8kO/JvzOuJagyH/xzS4+7MjS4q7yTF9v8KANSrgDcvjZtv2OjNdBf9F
         j2FnfdHBBVWxSK12Yh+rka+QgHgBebhSt0txeSa2lXVWBgKMnm4gbnMpie+UinVUwFK8
         47j5ZflG63F0TXLd0N6DWM//zl8dZwQAg048wUXLT8vh1NjkEVgHH1RJke8Tu4R3vEVx
         T15w==
X-Gm-Message-State: AOJu0Yw7GPS/CommBlQ5yu5RlVsnuh6zlCYaNi9wHQNwlFUEQzKwwd6f
	o/Tm8DA6iSo2AUJtOffpa9tbqmk=
X-Google-Smtp-Source: AGHT+IHneZnuNzdmec4p8IMznIadt3gvRYK8ETNwHwQuhWBeUw0E2l7zTwuivbDYUrt8/txQeEEsw9g=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3443:0:b0:564:41a2:8d5a with SMTP id
 b64-20020a633443000000b0056441a28d5amr732pga.11.1691516110738; Tue, 08 Aug
 2023 10:35:10 -0700 (PDT)
Date: Tue, 8 Aug 2023 10:35:08 -0700
In-Reply-To: <20230808134049.1407498-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230808134049.1407498-1-leitao@debian.org>
Message-ID: <ZNJ8zGcYClv/VCwG@google.com>
Subject: Re: [PATCH v2 0/8] io_uring: Initial support for {s,g}etsockopt commands
From: Stanislav Fomichev <sdf@google.com>
To: Breno Leitao <leitao@debian.org>
Cc: axboe@kernel.dk, asml.silence@gmail.com, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	io-uring@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/08, Breno Leitao wrote:
> This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
> and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
> SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
> nad optnames. On the other hand, SOCKET_URING_OP_GETSOCKOPT just
> implements level SOL_SOCKET case, which seems to be the
> most common level parameter for get/setsockopt(2).
> 
> struct proto_ops->setsockopt() uses sockptr instead of userspace
> pointers, which makes it easy to bind to io_uring. Unfortunately
> proto_ops->getsockopt() callback uses userspace pointers, except for
> SOL_SOCKET, which is handled by sk_getsockopt(). Thus, this patchset
> leverages sk_getsockopt() to imlpement the SOCKET_URING_OP_GETSOCKOPT
> case.
> 
> In order to support BPF hooks, I modified the hooks to use  sockptr, so,
> it is flexible enough to accept user or kernel pointers for
> optval/optlen.
> 
> PS1: For getsockopt command, the optlen field is not a userspace
> pointers, but an absolute value, so this is slightly different from
> getsockopt(2) behaviour. The new optlen value is returned in cqe->res.
> 
> PS2: The userspace pointers need to be alive until the operation is
> completed.
> 
> These changes were tested with a new test[1] in liburing. On the BPF
> side, I tested that no regression was introduced by running "test_progs"
> self test using "sockopt" test case.
> 
> [1] Link: https://github.com/leitao/liburing/blob/getsock/test/socket-getsetsock-cmd.c
> 
> RFC -> V1:
> 	* Copy user memory at io_uring subsystem, and call proto_ops
> 	  callbacks using kernel memory
> 	* Implement all the cases for SOCKET_URING_OP_SETSOCKOPT

I did a quick pass, will take a close look later today. So far everything makes
sense to me.

Should we properly test it as well?
We have tools/testing/selftests/bpf/prog_tests/sockopt.c which does
most of the sanity checks, but it uses regular socket/{g,s}etsockopt
syscalls. Seems like it should be pretty easy to extend this with
io_uring path? tools/testing/selftests/net/io_uring_zerocopy_tx.c
already implements minimal wrappers which we can most likely borrow.

