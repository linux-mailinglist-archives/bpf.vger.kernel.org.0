Return-Path: <bpf+bounces-212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CCD6FAC08
	for <lists+bpf@lfdr.de>; Mon,  8 May 2023 13:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD51280E3D
	for <lists+bpf@lfdr.de>; Mon,  8 May 2023 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61A171A3;
	Mon,  8 May 2023 11:19:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF7168CB
	for <bpf@vger.kernel.org>; Mon,  8 May 2023 11:19:50 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D803387E7
	for <bpf@vger.kernel.org>; Mon,  8 May 2023 04:19:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so47754628a12.0
        for <bpf@vger.kernel.org>; Mon, 08 May 2023 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1683544787; x=1686136787;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=m10/D0H/SLA8VCEoVNm97f3TkXpR8ECBbUoL0FwCvhs=;
        b=VcnVOmmrq+In3u11hbcdOxZ9eN2axTCwc21rN2dA4UD514zAcTbUEtwXucUNbJkYIT
         W2oJb77neFgmYVGn8cm1ZOSHp00O5whDsQPay+RqirV7MUenhT8OxF5HQKEAAUpX/nMA
         6e/u3IT5Q/Xa4FqJ53wZhfIyCwhXaQOqgqkMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683544787; x=1686136787;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m10/D0H/SLA8VCEoVNm97f3TkXpR8ECBbUoL0FwCvhs=;
        b=CHCR99PuDrLPLK5O4pA+7t7cPsvYpoQvM6SoJYwZetz6UCjJ0Kw+H+HLzYmcuNVl8n
         UghtQ4U+JmBCPPcSDxx/0o1W7YuA22YJN1ir5EqRDVj3woEsP8w+a24gdYNeFKGwHQ/c
         6+6h5IYSVn9JcDnhlbB1/2hZxegc1B1jHQnXZK7awNw//UVSniQziKacqp5yMImTrTsE
         rcBmByxspzyxekGN8k08czCwhHCJV5RQfPbdrcDJ8aMHJetrfYeqrKz6joj8wbq0A4XZ
         mNTJBqnmiOS1I8fZnT4MtDl3Sin5z02ae5HMLIvdyY3A6BQ7uqWow4EMlBEafeO2nNZE
         Xvvw==
X-Gm-Message-State: AC+VfDxmtTEL27SLsf9FWSUbOuw8w2Hbfbcr7KmcytO03m1suQ/R4KkW
	2M9Fr4h6UZBjZJgIY2b16jAY7w==
X-Google-Smtp-Source: ACHHUZ4IX1goJxSbrLiBqcWdMf3XdyMY1OdQgjRRMvJU5uZB5qTiOKvqgmPwLLqF7qHdL9mu1hZ8Wg==
X-Received: by 2002:a17:907:7f1a:b0:965:b0a7:5f47 with SMTP id qf26-20020a1709077f1a00b00965b0a75f47mr8474633ejc.29.1683544786777;
        Mon, 08 May 2023 04:19:46 -0700 (PDT)
Received: from cloudflare.com (79.184.132.119.ipv4.supernova.orange.pl. [79.184.132.119])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b00953381ea1b7sm4845643ejd.90.2023.05.08.04.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:19:46 -0700 (PDT)
References: <20230502155159.305437-1-john.fastabend@gmail.com>
 <20230502155159.305437-13-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, lmb@isovalent.com, edumazet@google.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v7 12/13] bpf: sockmap, test FIONREAD returns
 correct bytes in rx buffer
Date: Mon, 08 May 2023 13:19:32 +0200
In-reply-to: <20230502155159.305437-13-john.fastabend@gmail.com>
Message-ID: <87fs873wa7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 02, 2023 at 08:51 AM -07, John Fastabend wrote:
> A bug was reported where ioctl(FIONREAD) returned zero even though the
> socket with a SK_SKB verdict program attached had bytes in the msg
> queue. The result is programs may hang or more likely try to recover,
> but use suboptimal buffer sizes.
>
> Add a test to check that ioctl(FIONREAD) returns the correct number of
> bytes.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

