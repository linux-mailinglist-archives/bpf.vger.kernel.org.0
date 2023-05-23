Return-Path: <bpf+bounces-1082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CC170D90A
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 11:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752E01C20D26
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76D1E515;
	Tue, 23 May 2023 09:31:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6C1E511
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:31:24 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25D102
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 02:31:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f0678de80so1322844566b.3
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684834265; x=1687426265;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=HsFExq0BgHT/JNdxJg5FjjZF8dObKKp1AJUbRVpK86Y=;
        b=lWy0aBFhBaWvgEVn7EumK73nd9MeyCsRxZVx/WHcLm0lBVAsJ9FeSk75nguCFe3y8L
         byIRtHKJqMF2mUsBxxOfF172Ba/93W4Nd9DuKhNIt3amm3xdXH20EbPmrup+8G7oSkO4
         1dUenxrUzhzjIsBv7WtI6CO0d7vO3M/AKeZxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834265; x=1687426265;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsFExq0BgHT/JNdxJg5FjjZF8dObKKp1AJUbRVpK86Y=;
        b=humdSW6A0lByQlvNJIoPKEIrhpmEyD3g/U0pWIVJ6dvU3z+Fp4nF5r/t+r3eSa5bvl
         dqlS1K30arSCZP2kb/c7uAKTQZeeA5xAzZs/XNT9Rm8u7tWHY2xY+upmRAdAo8hYaff+
         o7d08xJhcPZ3xPiKAcMRxHYI3bRlH0Pfz/JceFlES2kNs0//MKUXfTgGsFcnmM6qAVUF
         kl+kFmYUCUjneWQAE7xQArVhdzGEoe0eJP4K5CMXW+0S/7xcpS8O9jNZpFxjSBHoh1v1
         7kCInH4T5FcsFdzrdFVFsXHvf49fcq2W1BLpnPjQMyciBJ4eweLU1oJGHUQuk7B30Uf4
         3YBw==
X-Gm-Message-State: AC+VfDz0tH1BLTlcD6281yEE5FduU1jDWrYowl2KYRZtFtUAaYu9olea
	gs/X2yMEpKL+UWkuWalwm3vltQ==
X-Google-Smtp-Source: ACHHUZ5LxFsZvDXXkE+z+XXpcrTNb9bDUm5NqAl38t2/BRMCDB/YI61Nl/m4W+3lUWqyu6iBgEUacQ==
X-Received: by 2002:a17:907:2da8:b0:94a:82ca:12e5 with SMTP id gt40-20020a1709072da800b0094a82ca12e5mr16858600ejc.45.1684834265470;
        Tue, 23 May 2023 02:31:05 -0700 (PDT)
Received: from cloudflare.com (79.184.126.163.ipv4.supernova.orange.pl. [79.184.126.163])
        by smtp.gmail.com with ESMTPSA id g16-20020aa7d1d0000000b005068fe6f3d8sm3855440edp.87.2023.05.23.02.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:31:05 -0700 (PDT)
References: <20230523025618.113937-1-john.fastabend@gmail.com>
 <20230523025618.113937-11-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v10 10/14] bpf: sockmap, build helper to create
 connected socket pair
Date: Tue, 23 May 2023 11:23:12 +0200
In-reply-to: <20230523025618.113937-11-john.fastabend@gmail.com>
Message-ID: <875y8j75t4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 22, 2023 at 07:56 PM -07, John Fastabend wrote:
> A common operation for testing is to spin up a pair of sockets that are
> connected. Then we can use these to run specific tests that need to
> send data, check BPF programs and so on.
>
> The sockmap_listen programs already have this logic lets move it into
> the new sockmap_helpers header file for general use.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

