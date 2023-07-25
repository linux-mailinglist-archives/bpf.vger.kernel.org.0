Return-Path: <bpf+bounces-5843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8512761FB7
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B0A2816DF
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5991525174;
	Tue, 25 Jul 2023 17:02:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511A3C23
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:02:44 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E926BE9
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 10:02:42 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c04f5827eso2951064a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690304562; x=1690909362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEq9wvoOmb79sxPImc43/8dWbsrHxgBnwc9vx2sbv8Q=;
        b=VWIQdXO6C9fKgtTrf5l5sGCGnOSCXxT0RK4teBxBlWjA45NvBd2W2NUCMBvJqd1LuQ
         +Ddme/UZOrkRccSEBHud08r7Hp2GlWNzroFWlyPl9a0XN1yaKOt47BItrQIH7itgaZ8L
         7CtNgDjtQGmkhgbXcJKsSXADLMCaG9OXG3B/pCyg44pBrE8DUcsdx625AOB1ywFHFJWk
         EVZCqM+29RfY09tnPa6AzfJ6TqZ3OX1xIi7nA+XQvQYYGtNtozEioR+Cj1IXxlTSyzX8
         ydYByI9q5vC/t0bcAbs5zfmRgTZcIcMmZSWRvoBzoDE3/5ywsADDG9JPeOFXHIcXarLI
         u7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690304562; x=1690909362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEq9wvoOmb79sxPImc43/8dWbsrHxgBnwc9vx2sbv8Q=;
        b=QYYJS0IZ+DxrRRa5GFGhOJ/z2aqlS0zuAmhIoM/QD1c2fXHMAIdXtM+yT3xX1IcEpQ
         tvpWzDucg4so0de9SKVjMZwsPjxq1lHEm3fPG/YDCS6qw7m2lK0fzg9+5vEu0pAHEz/y
         j+Jh1nYsRYSnJqJr3iDVnjNKIe14Sc0I01lkxmUmW1lLhN7n2+0YpbWDTBqaVAShKan9
         IwHeKvHyGmHs85cshQu2GVh1AaK1skJi7dA3sN5g5DE+TffP4jhCBOscOgVrapzgKLc0
         fK2q0RvI36QhqWCJKQsD7wrzB1x169N/BXF5BdGPEt592RkBW1pW2lUFlHCzY9aJ7SX3
         4chg==
X-Gm-Message-State: ABy/qLbWnPUPGQhObgPiG5Pki1/fYnaNSPZqGAh+hK8iiH6ANO/8dbws
	duSiHya/oUDgpP8IRC4P4IehjQA=
X-Google-Smtp-Source: APBJJlG+EQC6OFCeDlua8rQI6GRdjTdr0NTozio16Zq//4slIvlC7h02qvfKRrly0F7zWE7386X2IpM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7d12:0:b0:55a:12cf:3660 with SMTP id
 y18-20020a637d12000000b0055a12cf3660mr52472pgc.1.1690304562245; Tue, 25 Jul
 2023 10:02:42 -0700 (PDT)
Date: Tue, 25 Jul 2023 10:02:40 -0700
In-Reply-To: <ZL+VfRiJQqrrLe/9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724142237.358769-1-leitao@debian.org> <20230724142237.358769-3-leitao@debian.org>
 <ZL61cIrQuo92Xzbu@google.com> <ZL+VfRiJQqrrLe/9@gmail.com>
Message-ID: <ZMAAMKTaKSIKi1RW@google.com>
Subject: Re: [PATCH 2/4] io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
From: Stanislav Fomichev <sdf@google.com>
To: Breno Leitao <leitao@debian.org>
Cc: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	leit@meta.com, bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/25, Breno Leitao wrote:
> On Mon, Jul 24, 2023 at 10:31:28AM -0700, Stanislav Fomichev wrote:
> > On 07/24, Breno Leitao wrote:
> > > Add support for getsockopt command (SOCKET_URING_OP_GETSOCKOPT), where
> > > level is SOL_SOCKET. This is leveraging the sockptr_t infrastructure,
> > > where a sockptr_t is either userspace or kernel space, and handled as
> > > such.
> > > 
> > > Function io_uring_cmd_getsockopt() is inspired by __sys_getsockopt().
> > 
> > We probably need to also have bpf bits in the new
> > io_uring_cmd_getsockopt?
> 
> It might be interesting to have the BPF hook for this function as
> well, but I would like to do it in a following patch, so, I can
> experiment with it better, if that is OK.

We are not using io_uring, so fine with me. However, having a way to bypass
get/setsockopt bpf might be problematic for some other heavy io_uring
users.

Lemme CC a bunch of Meta folks explicitly. I'm not sure what that state
of bpf support in io_uring.

