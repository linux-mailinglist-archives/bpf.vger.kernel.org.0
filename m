Return-Path: <bpf+bounces-46995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CBB9F21AC
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 02:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F331886ECD
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 01:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D17C8FE;
	Sun, 15 Dec 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfeplAwJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AEBE46;
	Sun, 15 Dec 2024 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734225529; cv=none; b=sVJrMTFTjfq4R9tCYC0Y9DrOImsdPnbdLRgB16wHao9q4EdlmZbat8y/xa41cTKDZhGNX4Ci5nPcfBp1Gd9rZ4QBgxb2nw04BRnSlZMbgWAjLUWTe1PkXwN6R05mtv+juD2PvFc+WGWt507bP4ZD8YmoyYgZRIp0TW72GeuVS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734225529; c=relaxed/simple;
	bh=pbrZo6z4Lt1Om0IlfJhQDHRrcKlcBwImRBNTgsFrcJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFjVZ2uu7DUa2BSBCYVMSFwgpm7d0VcZiRIay8XXN4ZPmNYJOYO4eYsJFbQgTc+uY/o48+hklNaFVxcrIXQ4qV3NE521MnEhnsVzRNk/7zoFfpnnjzvrVoPxNSo+FPAyAH9Tkn7f1CQ8g4umF3wHukVA2MC15GMchCranE5ALNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfeplAwJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2156e078563so22798045ad.2;
        Sat, 14 Dec 2024 17:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734225527; x=1734830327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HqHJjrOMJG8NCE9szTTIyjs4WVPLMPChAxuyj8fdq0=;
        b=dfeplAwJyi2CcCLLTkoPc38wh7NpzHcxFA2+r4s9pcJjb3LlSH+cMB13KVMRpIAfrA
         Jjv6m6RKIoioa2vL1xM2Mzxn00ZSwosDneBlY94E7eyVyugT5wDPizrq3n0BXla0vaDR
         g6nyJJiJpOho6mVCWcSwQ9P6Ymjl6Fn2+x+BsLX0h7c3xIZ8oA3qEgDeMt9XViX+jY3L
         La+dOR2Vo6vE1OP3fLcGDHZNTcx7Akk9ApstcDsqEx8I171ewnhx/p6XAdWlvkyfLqxh
         n1D+kwPkdhuTXBDytdfm0rrec850TCHRCXRJKB6Ty0c3Hj/RzTnw7EPq5ot3Is4DraOm
         fH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734225527; x=1734830327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HqHJjrOMJG8NCE9szTTIyjs4WVPLMPChAxuyj8fdq0=;
        b=MMKkuSaUJ+n5CxiWCXOmHN6YfvJ9PvG9iqIWSpmbdqMtw+NRsFVovJYUjVzUtUdtUa
         xkjZN4XXe5z3kgJu3WjXhwn+kPJ+oru7dmy8FInPtPgn037Q3isIRPinCmVZ0bbYcO1E
         NGP/IVqotBge+slFeQz+ktqYY1T8mGOMCYrirdWeCsx0+5XvYM/V2fplyc1pE2BBENiB
         mVd3/BG0TMt+RUlti352UeRfbBGp62QOWa5e/Ud499qWzGNZqDqPpCF7Imb87CeusJvg
         4bbh9kEKbKyOkGGd3DsZ5wRX0IisN56nnrKn31PPHvI5nAuRP2OZWzwLuEQuC90sDcd/
         y57A==
X-Forwarded-Encrypted: i=1; AJvYcCWvk/378a5IKRG60LNh2ae1478YoE6mHMpKkfaqZMQAani9L/ArUkqgH/eYTCCSNgUN0FU=@vger.kernel.org, AJvYcCXvhOhiyrYrxwQORghhav7v4PyEWFRYSh7R7kxPjoX0NPB+oynj1blMGGC0RM6tFtncWDZ01IZNvAHgwqjq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+dEKcwU4fHBPvwzC3GuZpKmGsVgCKw6ZPhsAx237ei+hmNTw
	KXetXUQp5JWxUR4sDy+cT1Lf6uZ+lsp1DY+9gVd5ISrsNUHNJy5H
X-Gm-Gg: ASbGnct8mtX8khhf1pKhHdaOMN130BB1kWsQf/5zaUjrQTle0JZj//OxwDsOp4gHBXF
	Y6dnnHoW4dIKGlOKw+CxORE3hy/OyI00L+fr0AUavFklNu29egy7lB2EfclDmuOS2Qu9fDe86XW
	fwZfhjLW1yjMCLlPPVNiStnplfP2oymlxwvECWfRY4gJINOLpqKkAgT1M8ZtGYvnYjKuw9SJrbf
	BZ8yAA0E4l7SGCdcWnBkEwYZ7oMs5jL5qFMVNkxqBvZp4NafieEOSuzfFVTPiI=
X-Google-Smtp-Source: AGHT+IHblGom5gbVWU/fYZm/PrZhhcE3suROouvE/DD1kE6T0q6ZmZM4NdVzjN6gmEryEKoBRMMdNw==
X-Received: by 2002:a17:902:cec3:b0:215:711d:d59 with SMTP id d9443c01a7336-21892980bb0mr117645535ad.2.1734225527312;
        Sat, 14 Dec 2024 17:18:47 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:3beb:b864:8de8:7334])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142dc1dfesm5434651a91.21.2024.12.14.17.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 17:18:46 -0800 (PST)
Date: Sat, 14 Dec 2024 17:18:44 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jiayuan Chen <mrpre@163.com>, bpf@vger.kernel.org, martin.lau@linux.dev,
	ast@kernel.org, edumazet@google.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, song@kernel.org,
	john.fastabend@gmail.com, andrii@kernel.org, mhal@rbox.co,
	yonghong.song@linux.dev, daniel@iogearbox.net, horms@kernel.org
Subject: Re: [PATCH bpf v2 0/2] bpf: fix wrong copied_seq calculation and add
 tests
Message-ID: <Z14udC8bTilHb3Xs@pop-os.localdomain>
References: <20241209152740.281125-1-mrpre@163.com>
 <87ttb6w136.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttb6w136.fsf@cloudflare.com>

On Sat, Dec 14, 2024 at 07:50:37PM +0100, Jakub Sitnicki wrote:
> On Mon, Dec 09, 2024 at 11:27 PM +08, Jiayuan Chen wrote:
> 
> [...]
> 
> > We added test cases for bpf + strparser and separated them from
> > sockmap_basic. This is because we need to add more test cases for
> > strparser in the future.
> >
> > Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> >
> > ---
> 
> I have a question unrelated to the fix itself -
> 
> Are you an active strparser+verdict sockmap user?
> 
> I was wondering if we can deprecate strparser if/when KCM time comes

I am afraid not.

strparser is very different from skb verdict, upper layer (e.g. HTTP)
protocol messages may be splitted accross sendmsg() call's, strparser
is the only place where we can assemble the messages and parse them as a
whole.

And I don't think we have to use KCM together with strparser. Therefore,
even _if_ KCM can be deprecated, strparse still can't.

Regards.

