Return-Path: <bpf+bounces-12705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3137CFE67
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DCB1C20EE2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321FD315A5;
	Thu, 19 Oct 2023 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0FxvLccp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3673F3158B
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 15:41:51 +0000 (UTC)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F7FD4B
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 08:41:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a66bf80fa3so33304139f.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697730102; x=1698334902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xxv/44z+YoCHFzTUvV/HWGf+cSx/epc2a2ex7I2Rd4=;
        b=0FxvLccpnKQ4ZTnNW+3aF+4ZJhZvUSKTlgj1ozd9/icZi7jnXx9l7EKY6IHTaBKb1E
         0d377NlbXqfYz3zIR7c/YZEbZucVBLRwsCFUxKWDRzHfWSUArN1hlFOJZt8aKzF/Lg5A
         KzxcKTf6WQsrw0s9VAs1AQXgYY1HU5N5GReR6CwgB9s7Q8RxEIUg8D+x+4M3KKS0JbzW
         veL1mJO0rJ/Mr+p+d1rtWYq7aFf6baNJuUZYCUNugBH6vlQLdWMZZzUiTd0wi3hqQRar
         CNum2+4o3OD3wN1Iw73TZC+OXAFg687lXTCfy5vHqnqgzCFEoWMjkySQ11HCnNp3xJTK
         PiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730102; x=1698334902;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xxv/44z+YoCHFzTUvV/HWGf+cSx/epc2a2ex7I2Rd4=;
        b=hIfoCbHMfAULlWFpiJPLo0lyBUffmuDQRBXhBzBf3iEiyOGqDLRmq3PR6ORPH1sThr
         NQJjRm0SBMJP9sXQmhOCns2Zf088rC3XYuSBWfGj1/g3Xjd5+22IVwghpQOSKHV+qFIx
         Iq/SNVFo5dh7oUnrB6l7SuyfMmiiZXJ8jnwvUpmYcc4p1s/BXZjqRoADiZw9fxYHyM+b
         DqexIRl2XqGBPtBMMET80DY9RcS55Lawko0OeODbrksSJ8M8vHVi4F1NXdBIQBxePIy3
         G2p5b+JkYqmOwxxJxwkfrp0l5P8etUj+rUSaqd/TJ15Wdq4xMvAEXBQ9MGnXfTMK3FMH
         JA3Q==
X-Gm-Message-State: AOJu0YxvUt33ElKGrmuZQWGHc+6TTO4QgO0vqtSLG/8a1c+xmyiGCD4l
	iOprwVRWMhVb/EDNIbFTinuRRg==
X-Google-Smtp-Source: AGHT+IFA9Ko8BzzmJvF9/Ll+x8hNvuQTu1RIUoMhlZt65y7Pvfo1T3P3HE1EZUqk9PGPQtsvTZn2lA==
X-Received: by 2002:a5e:db45:0:b0:79f:922b:3809 with SMTP id r5-20020a5edb45000000b0079f922b3809mr2532203iop.1.1697730102564;
        Thu, 19 Oct 2023 08:41:42 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id da19-20020a0566384a5300b0039deb26853csm1992382jab.10.2023.10.19.08.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:41:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: sdf@google.com, asml.silence@gmail.com, willemdebruijn.kernel@gmail.com, 
 kuba@kernel.org, pabeni@redhat.com, martin.lau@linux.dev, krisman@suse.de, 
 Breno Leitao <leitao@debian.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, io-uring@vger.kernel.org
In-Reply-To: <20231016134750.1381153-1-leitao@debian.org>
References: <20231016134750.1381153-1-leitao@debian.org>
Subject: Re: [PATCH v7 00/11] io_uring: Initial support for {s,g}etsockopt
 commands
Message-Id: <169773010167.2728246.364592257409613748.b4-ty@kernel.dk>
Date: Thu, 19 Oct 2023 09:41:41 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Mon, 16 Oct 2023 06:47:38 -0700, Breno Leitao wrote:
> This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
> and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
> SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
> and optnames. SOCKET_URING_OP_GETSOCKOPT is limited, for now, to
> SOL_SOCKET level, which seems to be the most common level parameter for
> get/setsockopt(2).
> 
> [...]

Applied, thanks!

[01/11] bpf: Add sockptr support for getsockopt
        commit: 7cb15cc7e081730df3392f136a8789f3d2c3fd66
[02/11] bpf: Add sockptr support for setsockopt
        commit: c028f6e54aa180747e384796760eee3bd78e0891
[03/11] net/socket: Break down __sys_setsockopt
        commit: e70464dcdcddb5128fe7956bf809683824c64de5
[04/11] net/socket: Break down __sys_getsockopt
        commit: 25f82732c8352bd0bec33c5a9989fd46cac5789f
[05/11] io_uring/cmd: Pass compat mode in issue_flags
        commit: 66c87d5639f2f80421b3a01f12dcb7718f996093
[06/11] tools headers: Grab copy of io_uring.h
        commit: c36507ed1a2c2cb05c4a2aad9acb39ca5d7c12fe
[07/11] selftests/net: Extract uring helpers to be reusable
        commit: 11336afdd4141bbbd144b118a8a559b1993dc5d2
[08/11] io_uring/cmd: return -EOPNOTSUPP if net is disabled
        commit: d807234143872e460cdf851f1b2bbda2b427f95d
[09/11] io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
        commit: c3199f61b896cdef3664dc12729a2beadf322783
[10/11] io_uring/cmd: Introduce SOCKET_URING_OP_SETSOCKOPT
        commit: 43ad652250d24e9496f4cd6a0d670417807ac9a0
[11/11] selftests/bpf/sockopt: Add io_uring support
        commit: d9710f1d12a99738ff168e252ab8e9ffdeb90ed5

Best regards,
-- 
Jens Axboe




