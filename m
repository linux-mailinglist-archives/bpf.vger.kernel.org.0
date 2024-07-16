Return-Path: <bpf+bounces-34905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625F3932286
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 11:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5DA282ECC
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F53195B35;
	Tue, 16 Jul 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HXdX6s9f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB441A8E
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121279; cv=none; b=VYDTltdb3surQ8RHJC32mSs41e7IjdMYdhgJYedMSzRpJ1AgEggmdOqj9EI6nrRMuFUfPIeqSnR+QL3vyxMSFbns5ZO7QxLJCfWEaqgNsmQlbpH5E4h9O5Fexcq+02BZ/kTDx1jp3l7XYc3awUAR15k3t9y71qpqGc2rSUl37cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121279; c=relaxed/simple;
	bh=cQRUOXRT3nbk5SXR4E5M2ElDKp0uLvZd3NstRhk7yDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLvRzxR8c6kic7r1nAOg9K9iappAEfT/EDZ1lSVBoiMC2/F8QvXWdSEKs7+rkLA+QbOxYcrK/Vv5uLt9Gy6du7LmIFPcjdJf4IAjNL5r5Z8iCjXrwgmFP20LxXVBaBBVXKpTUoDOcUjnvYZi57f3pHdisQX6z97iAESdOvTqs8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HXdX6s9f; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so1788406a12.0
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721121276; x=1721726076; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1F/ZpSl0ICqlO5c3jFxjhRdSZxvasTrherRTPCYwpKc=;
        b=HXdX6s9f2VR5DsPz5NgM9jZr+Ov6Ue0XCivIFDc9UO2NT+683O7w37nfqkiCeG3Uqa
         DS7PnMvtm0QSQTp06yr7EDMprCmTVSONnUul8Qnat6jHDN2F6qkhNhLx7IhytwuVbM0c
         KH2ebRyf0ea9VaIE1W1n/xVJMIdTqoaqTWueAAD8RpI/QnYaMrb5C5GrsJNPeYyjt35U
         On7pmIMcdohHYilKbfs1PY5cqlZpHmpQHB7WjsMbC6PYYPNBhJo0364KR6DaKzSde0h7
         D7fRew13IX7i6Jj8gT58hzh+af/NrlSp4qr9mpGVaxsmJ8HUc6DpcMobDJQ/EeGIcmjl
         2DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721121276; x=1721726076;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F/ZpSl0ICqlO5c3jFxjhRdSZxvasTrherRTPCYwpKc=;
        b=DJV6zwUEMDoh+N4S1OEiuyTV4nIqlZskwEXagk8/UwIhSgYflM9Ip5lz/3Nealisxb
         sFeQ5ErFedsEuUTb8PP8zbz2qHwK+TxkcC1m6v2g+5DxkDFQ8V9f6UHCLDLFLFpOGDQf
         LoarVaRKauXfz1zUcUwhrb4n4kOpZS1LOlxbnuIhvuCpGQqwHX7UkXppJ3jbs1+RqdA7
         STaMECt5iNyvlfEe/qbsOuyyqMNsy/IeA8xOBnSjSIEQY6ud4aEF6j7ZbXQV7GRfTFhp
         z26iKKUbLJUuBemudC2Un6a8u9v5KGyQFTuWwCoOlnZ7hjcR2lPo0aNkZM/sz8Zj7OiC
         5JEA==
X-Forwarded-Encrypted: i=1; AJvYcCWyflaFR6F/oZmmmmUmiaaAj0krc1dyrqubZ5jIbZq8D6/Jyd8fij+Vk5vUGHrzrBSBZsXJdRXdamugFMq0FngGORvf
X-Gm-Message-State: AOJu0YzyvhcW6w8mb2YQKeM0jDxYSKiqZ2gIv5Ey8l/AsKTonV12VVxb
	reCQrC9rwYRPK2+Q3kCs9ZppEflDW+WpoDcyq/Dld6xjC8iihMKs+lN3l4bhR6Q=
X-Google-Smtp-Source: AGHT+IGp1X9SF267zobXjwAU0nsjmxrbtCIMCWMxl8pWqlpiJzN4UPBYNOy39/tdXp8BHOAfTHjsDg==
X-Received: by 2002:a50:8d15:0:b0:57d:1595:f6fd with SMTP id 4fb4d7f45d1cf-59f0c91e614mr1052995a12.18.1721121276122;
        Tue, 16 Jul 2024 02:14:36 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24f56fb9sm4433282a12.24.2024.07.16.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:14:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
In-Reply-To: <a4edd3d6-4cad-4312-bd20-2fb8d3738ad6@rbox.co> (Michal Luczaj's
	message of "Sat, 13 Jul 2024 22:16:11 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-3-mhal@rbox.co>
	<87zfqqnbex.fsf@cloudflare.com>
	<fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
	<87ikx962wm.fsf@cloudflare.com>
	<a4edd3d6-4cad-4312-bd20-2fb8d3738ad6@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 16 Jul 2024 11:14:34 +0200
Message-ID: <8734o98zr9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 13, 2024 at 10:16 PM +02, Michal Luczaj wrote:
> On 7/13/24 11:45, Jakub Sitnicki wrote:
>> On Thu, Jul 11, 2024 at 10:33 PM +02, Michal Luczaj wrote:
>>> And looking at that commit[1], inet_unix_redir_to_connected() has its
>>> @type ignored, too.  Same treatment?
>> 
>> That one will not be a trivial fix like this case. inet_socketpair()
>> won't work for TCP as is. It will fail trying to connect() a listening
>> socket (p0). I recall now that we are in this state due to some
>> abandoned work that began in 75e0e27db6cf ("selftest/bpf: Change udp to
>> inet in some function names").
>
> I've assumed @type applies to AF_UNIX. So I've meant to keep
> inet_socketpair() with SOCK_DGRAM hardcoded (like it is in
> unix_inet_redir_to_connected()), but let the socketpair(AF_UNIX, ...)
> accept @type (like this patch does).

Ah, that is what you had in mind.
Sure, a partial fix gets us closer to a fully working test.

