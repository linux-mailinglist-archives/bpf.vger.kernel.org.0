Return-Path: <bpf+bounces-7395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A587765D4
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A69F1C20D88
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44AC1CA1A;
	Wed,  9 Aug 2023 16:55:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9200A1BB4A
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:55:16 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07CD2106
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:55:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so9215613a12.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1691600113; x=1692204913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEEzkpRk4R5ngJk0sdsY4jksrqnBMmsAjfH4cPZ0Ceo=;
        b=LXifjXMjDkY+9vzyXyHF446KTFEVUBCGm6SxFbnjl7ZrDNlY8xnmabEJVxUW+ush49
         KKTZgh4/nppv9HRYHadUjsFyw9RkxQOq/WYrOfj40CU1EJmV4qLnVT7Fpbp1G3xyg2fg
         zVqg5l9IodUOMREAVjo0vXijlwzjHBQA0wc0IWOklIJ8xy95jxtpJkoZvFOJB1AhDlEE
         8yQb/0zN3SLbB54vF7iBeSO7+HaQszGc6LK35twMKAIV0gwa+L4NPOQr+nfUGIkvZbpE
         lTIBmsDwhaoOWEVeDVVn9FsSV6LTT5lELwKU13KV5VSCwyHi9BXIY5r0CWNQscVo3R7D
         VHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600113; x=1692204913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEEzkpRk4R5ngJk0sdsY4jksrqnBMmsAjfH4cPZ0Ceo=;
        b=Mu3gldDV9RDEwG8lKxmHV6vYoduoFHttagWifUnKuj3nJEdTH1JxYiHzDUsKCFQOX9
         uX+SIqKGSTqAU0dGjoOnvvSGmFn+Znt8+fL31MEiRkTAl3XFmRiIl6kb9WCRBRObXOe3
         YU0t1iRvRz+TLdaDHQbzgvfVVz0RY0t1Qkuy92+37eIbIP/JQXllaYrb2UGVus6aTS8K
         13WJ4eDbQYJrMIDTYdnaebjWWSO5gYb1h+6h0ImE++BWN0r3I1uod6QbtLLbQhhcxYv7
         qhN582bddiTXa1rxTYm3prqu609xxIRVGOnAx5MSUhq4Z/p8UboDq7AcRY69hVp9jM9x
         L28g==
X-Gm-Message-State: AOJu0Yx3kLiOFamUor1Ru+rQdNYG/2GjGXHNYxVjRlD/sXMpuyiFlt8s
	saazb8KNY+h1PzfU6U+5MEE4GI3e2T6/xxYBBYj5vQ==
X-Google-Smtp-Source: AGHT+IF7dM2eXGn6dRXYNXBc36kPTeydH1cLQHZ69WdeM57HrUxewNW65BPbYowzY8vRF7JfnkGpiq0tLQV/ExDslXY=
X-Received: by 2002:a17:907:78d9:b0:974:183a:54b6 with SMTP id
 kv25-20020a17090778d900b00974183a54b6mr2328010ejc.33.1691600113512; Wed, 09
 Aug 2023 09:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8hMpL3+vNOrBBRw01tD6OxQ-Yy8OWpq9nRtiyjm0GgE4g@mail.gmail.com>
 <20230809155538.67000-1-kuniyu@amazon.com>
In-Reply-To: <20230809155538.67000-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 9 Aug 2023 17:55:02 +0100
Message-ID: <CAN+4W8h44UdLRT+QLdh2rNeiKg0AkPAuGtYuXOgtFzvT2kHsWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in inet[6]_steal_sock
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 4:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> > Things we could do if necessary:
> > 1. Reset the flag in inet_csk_clone_lock like we do for SOCK_RCU_FREE
>
> I think we can't do this as sk_reuseport is inherited to twsk and used
> in inet_bind_conflict().

Ok, so what kind of state does reuseport carry in the various states then?

TCP_LISTEN: sk_reuseport && sk_reuseport_cb
TCP_ESTABLISHED: sk_reuseport && !sk_reuseport_cb
TCP_TIME_WAIT: sk_reuseport && !sk_reuseport_cb

Where is sk_reuseport_cb cleared? On clone? Or not at all?

> > 2. Duplicate the cb check into inet[6]_steal_sock
>
> or 3. Add sk_fullsock() test ?

I guess this would be in addition to the convoluted series of checks
I've removed in this patch?

