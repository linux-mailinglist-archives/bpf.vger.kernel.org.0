Return-Path: <bpf+bounces-5810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353C760F56
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 11:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B431C20D47
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65E815AC2;
	Tue, 25 Jul 2023 09:33:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3014A90;
	Tue, 25 Jul 2023 09:33:09 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE08944AE;
	Tue, 25 Jul 2023 02:32:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99342a599e9so917908766b.3;
        Tue, 25 Jul 2023 02:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690277248; x=1690882048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlOFKCeP+4hVLbD69I004lHDv56Nbmt05BTtQgudZs4=;
        b=eSLDJIzinf8TLMkeDXBYeOsHYt8l/voNitBMIIYNaSx6NAbQ7JuxkkZq9jCnQLVWcv
         KOLaNVkKuR3jrNeGCfyUqMYh7vBBbUUUXoktIqOvlbFVguoqJWsVQANMuqi32m+PNBEU
         ztpJtbF0wBcSTrRvEmbCs7sfMuL9VtgWEpeKSynMg8oMN4ZvZ3cqnUV+izBSZvMjyc8H
         x5hhUv9C9l5TJqhQny1XPg8VDcrFdFUvspCGH1Jwu4W5tuGm1WCp4kDEST781KpO9N81
         xwDnBihP1oUp/QLH1oUF3AF6WOqZ1lO6k27t4k3eHLYVo/Z/5Vnf4n9Gyp+TfMmPYvlO
         mymQ==
X-Gm-Message-State: ABy/qLb2/zQbqg7wgZzadMo4XXTwDhSTAWGVD4GpSLaweZUHnz2/APBM
	dtN77Rc/C9hrFwMz2LPPnh/ezMpulHk=
X-Google-Smtp-Source: APBJJlHT3V/1QY83Hn6Q8+8JyqL3OEJLhTClEq/l18a51Yfc9VPCcKK34BhhyZJYKET9soqC4Ur5yw==
X-Received: by 2002:a17:906:7a0f:b0:987:4e89:577f with SMTP id d15-20020a1709067a0f00b009874e89577fmr11829450ejo.24.1690277248142;
        Tue, 25 Jul 2023 02:27:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-014.fbsv.net. [2a03:2880:31ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id jx16-20020a170906ca5000b00993664a9987sm7955470ejb.103.2023.07.25.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 02:27:27 -0700 (PDT)
Date: Tue, 25 Jul 2023 02:27:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, leit@meta.com, bpf@vger.kernel.org
Subject: Re: [PATCH 2/4] io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
Message-ID: <ZL+VfRiJQqrrLe/9@gmail.com>
References: <20230724142237.358769-1-leitao@debian.org>
 <20230724142237.358769-3-leitao@debian.org>
 <ZL61cIrQuo92Xzbu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL61cIrQuo92Xzbu@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 10:31:28AM -0700, Stanislav Fomichev wrote:
> On 07/24, Breno Leitao wrote:
> > Add support for getsockopt command (SOCKET_URING_OP_GETSOCKOPT), where
> > level is SOL_SOCKET. This is leveraging the sockptr_t infrastructure,
> > where a sockptr_t is either userspace or kernel space, and handled as
> > such.
> > 
> > Function io_uring_cmd_getsockopt() is inspired by __sys_getsockopt().
> 
> We probably need to also have bpf bits in the new
> io_uring_cmd_getsockopt?

It might be interesting to have the BPF hook for this function as
well, but I would like to do it in a following patch, so, I can
experiment with it better, if that is OK.

