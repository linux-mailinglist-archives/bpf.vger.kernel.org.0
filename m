Return-Path: <bpf+bounces-47036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B765E9F3051
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 13:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62639166085
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A22B2046A6;
	Mon, 16 Dec 2024 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OC2hXuGG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB2204563
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351549; cv=none; b=k0ijwqhMlPfQxzA/dWDTiAwQmvhq4nQSgNLB2s1FjFdj7nFQX1CpXOKFmWhLb3g8NswH4Z9mDsPUhEI8dz6cs9iEj4nGfMFlmXSi2gPVM35XPOu4S6u7v6v9LMusu7RRchMWrmLDeVgPgU2ieC2ONrZhwEUMULdcm9gGzL2zc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351549; c=relaxed/simple;
	bh=loEJ2cAvHS1PBNFJKhLPyvT/66xxJTxwCR6IIL/pFQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aThq6sWVrDnn1UbZA8S/qKOBXJychfnnPz4freHEF4dJvyQKv4eJP7Yf2quzYR0W0Ljps/yCWjQA/xDbZxxlNnD4jRGK4qO/YeI1lcPWionTya/zdsK8ff/rtOizEema13dP+a6kadlFZPdUD4olw/+6B+JEp0QEPEoFnXScg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OC2hXuGG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6a3c42400so702365166b.0
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734351546; x=1734956346; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+eh9vCuyZ4u0G7ukXk1jSGQjFjMxa/J+DbFIZMl3no=;
        b=OC2hXuGGhwEc3PZ1AMIBQhL0aTDgy4KFIlA7yFJy/ZacxciLTerAkG9l0dmZ8Jlc8v
         d4KLWOGRvwEI7aHe5ZGz8ax7y7tpYqYZFlV3YVSICZvXPhfiaSuwnR0u/+z4yaESoOLR
         MYn9MJOe0HCcZ6PY91/mwWMWSg/vP5BZlz1hJd3wJnBubMUvo0jHFfL+Fe7fOHgKqq07
         SztxiImu0OnrFvakRJ1QM8HYL801OmNbQ94/uoDiP0WeC49ciz1oa/F9aP8Gl10EjP/T
         9iUri/9gP59rf1B2xAHohbrSsTzC+KcJPVB8nFOd+oWvLoZP34/sUH5FXKKXPd1oYFKh
         zsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351546; x=1734956346;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+eh9vCuyZ4u0G7ukXk1jSGQjFjMxa/J+DbFIZMl3no=;
        b=wRLCgu0bJ9k+lLQ3EAxB+0Gu25EvyIQvYG1m1/dJ2V1DlNlKQoM0ryHlQxtBtY6f5T
         tx10pVg+Xl6ndWf05b/G/ESF/WBeI4z9vSMtxE+z1j1p+cPQO3xjNMT7ux+KvCj9gDre
         UV402hM7JjY5qxztfattMU4t/h3V14bCrDJr84JySOnIKiXvMES6fMZek65aA2AeD/D8
         FG97AxiKxlYAPpBxj6JL91/KUGRdBnUJsYjSsGgqSuAMMLKqlTq86nvriQE8iI/r1BqO
         KskOIWkPpEUqRRrCkBNGWXW6WGjKfBT4pm3/GinuvY0jjCm7sc/0lDvMo8+7NOWYmG3V
         4b+w==
X-Gm-Message-State: AOJu0YyIrLZfPcSO40SL6jIJixHY5uTaj84xOL3e313o0/pxAG5E+qwd
	cT0kMxNAaUqPn4BPFTneXzggTWeTR1GsaWeUgCRgDGMY6Q0EfV50WQthe1zQkcA=
X-Gm-Gg: ASbGnctHevsqfj4qxtOqTBp6eFkj0OAboWpBN+3lFIZAjlXFEOpj2ESvrTtj2dhrlgy
	vFI/01PDpZpkMG0uXkJv0mK3WRlWeGvl/IxWFp31LCKBcw9fG4ulH3nsaj/QdToGRdOuZ0X4HT1
	VmB81BJgqQtuGx2syahW4l2YITmHMNqviyN1P1H1tKmhshEi2iPf3chtFEOTpau+LAM34Jvo8Wm
	BfCWg2DoUZ2gJNZC6uaEFlGxPMErG+Mcwqkt3ChMlkU8Wiqxw==
X-Google-Smtp-Source: AGHT+IHBhREBUd2xQnDq0nSySoUVJB7Nq18/B9DYXi9FyrteIejdfYbN2XxQQDiw2T2/psBgqBmIMA==
X-Received: by 2002:a17:907:6d16:b0:aa6:9229:352a with SMTP id a640c23a62f3a-aa6c4275d77mr1522582166b.26.1734351546033;
        Mon, 16 Dec 2024 04:19:06 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2387::38a:31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96359c8dsm324407366b.130.2024.12.16.04.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:19:05 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  martin.lau@linux.dev,  ast@kernel.org,
  edumazet@google.com,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  linux-kernel@vger.kernel.org,
  song@kernel.org,  john.fastabend@gmail.com,  andrii@kernel.org,
  mhal@rbox.co,  yonghong.song@linux.dev,  daniel@iogearbox.net,
  horms@kernel.org
Subject: Re: [PATCH bpf v2 0/2] bpf: fix wrong copied_seq calculation and
 add tests
In-Reply-To: <Z14udC8bTilHb3Xs@pop-os.localdomain> (Cong Wang's message of
	"Sat, 14 Dec 2024 17:18:44 -0800")
References: <20241209152740.281125-1-mrpre@163.com>
	<87ttb6w136.fsf@cloudflare.com> <Z14udC8bTilHb3Xs@pop-os.localdomain>
Date: Mon, 16 Dec 2024 13:19:03 +0100
Message-ID: <87o71bx1l4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Dec 14, 2024 at 05:18 PM -08, Cong Wang wrote:
> On Sat, Dec 14, 2024 at 07:50:37PM +0100, Jakub Sitnicki wrote:
>> On Mon, Dec 09, 2024 at 11:27 PM +08, Jiayuan Chen wrote:
>> 
>> [...]
>> 
>> > We added test cases for bpf + strparser and separated them from
>> > sockmap_basic. This is because we need to add more test cases for
>> > strparser in the future.
>> >
>> > Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
>> >
>> > ---
>> 
>> I have a question unrelated to the fix itself -
>> 
>> Are you an active strparser+verdict sockmap user?
>> 
>> I was wondering if we can deprecate strparser if/when KCM time comes
>
> I am afraid not.
>
> strparser is very different from skb verdict, upper layer (e.g. HTTP)
> protocol messages may be splitted accross sendmsg() call's, strparser
> is the only place where we can assemble the messages and parse them as a
> whole.
>
> And I don't think we have to use KCM together with strparser. Therefore,
> even _if_ KCM can be deprecated, strparse still can't.

Thanks for the context. Good to know we have strparser users.

I also wanna ask - did you guys consider migrating
strp_data_ready->strp_read_sock->...->strp_recv to read_skb /
tcp_read_skb to prevent the duplicate copied_seq update?

tcp_bpf_read_sock looks awfully lot like tcp_read_skb.

I realize it is easier said than done because there is an interface
mismatch - desc.count used to stop reading, and desc.error to signal OOM
/ need to requeue is missing. And then there is the SW kTLS read_sock
callback that would need adapting as well.

Definitely more work, but maybe less code duplication in the long run?

