Return-Path: <bpf+bounces-55228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD454A7A508
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AAC188C222
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5455124EF80;
	Thu,  3 Apr 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MquJu/Ee"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5924E016;
	Thu,  3 Apr 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689936; cv=none; b=dsXkvABblQxtUjCV0Eo0xtsoHtPr4rsobHMS8XZidPkeoR0kDuuwKo+ffcc1Z4W9kMnRru/v/DgNsYJ1dQjYuaP+SSJXYhO1/oGj+S2ywdKyDiSN0hmfvHF7r9UniZ/9qXsMa7cHlqXy7qVY71WYc4+HEXUtqTrnh/4y2jt1ieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689936; c=relaxed/simple;
	bh=rhDO3/j9rs7SP5hPmwLSeLrIfHx3DiYfvqQUF6lN7hk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZgHgewpMKZnFe/z/48WuGWVS9ZXKPim1o5A4stKYbYFwpRndSLQ89N+tBNvezudTpVq230Sia8dFPCITs9SENbLuDkLc3cH9fk9vTSjlsi3rMDQaWCs4vsx/v1Ch4Hkzqc8u/RaOs8YgXuuWUZlPfBqgz4xNYgq14F3CmZAjytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MquJu/Ee; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4766cb762b6so9576541cf.0;
        Thu, 03 Apr 2025 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689934; x=1744294734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7vNveOfyW+Z7WwHGJ7iFcVrk+rXWv/3dwWwsIsCE9U=;
        b=MquJu/EeTym5eOtHuh0XXTwB8E2Q/Dy/tWTfjAfSeecusjR1GOk/dSpoAKHkpv4kS2
         wW4Z41JBlK5nSjDO5snuIwpbu1x0aeuP0jcp9PsdYnUVSBEkhJ97IGi6mDL6X5bjN3SX
         L6/dN29phkdp3SDoc3pwlcCOLbtEFTQv3iWVRrMfxmAeg6y6Kf/ipW2zzWn11mDYMpuJ
         Ob327wrfyml7abOL5d1GeZT4k5g3V+ULRCwaj0ltcLXU+m4nkjVT2sKkKgW9RzDFq633
         YDx2CywAd2FKdPfPdFmhVHvZuN3UNZssQOiM5V/VVarr99jyVxe6SnqvqvdXmZWX33OM
         W1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689934; x=1744294734;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7vNveOfyW+Z7WwHGJ7iFcVrk+rXWv/3dwWwsIsCE9U=;
        b=Ik15SqKMQsAAm5mRVfmkI6gR9ahb8lW+ljR9ME5Ip/BBgmQa9CEYrn51eyZXe4vqRQ
         antOQCaoiM/BSruKf14EXV2S6XuBZEy50zR+HQon8DwpBtNZXNz5dUqK6lpY4bg7vUEP
         ANjAuviWKHis3Qx3ZA2TtRpbz3f8z684Zhj8DMtpDIliUjeQ0uD5HmPGkZ8CD5jbyHpu
         P9dhlBOnlLUwDskTq0qKm0kXMWFZGyl1HckNQMRzPrrYMzfF/5Hph8oB4OUMfJ2H5tQj
         EK8Fup9g65ECodgbOLhfA6Q7OpHH4zsUSmFdu0wsaN3/gsR0rwUlIJivY/a9YG/147f6
         lB8Q==
X-Gm-Message-State: AOJu0Yxc2PMt9qtPc4dr2z+F/VqxmlWiaoH2yvCwyq2agSEuy5tnRRi6
	JDECphb0nGHvjs2rny2KKcHTXq/FCl8ZX5QhCVDVCUsR9VWsvQZrh+LASA==
X-Gm-Gg: ASbGncswMjQ9fd2HuI1BMqjV4lQLjaDzwRFIDNx89XAnqkFkHE1nQMH2Go5l9zwb2nv
	7IS7uZBp9kK7fiKYF/dp2rhCCI/Vs0cvEgamTX3vk5KTfDQqB4c1oS7GbcuBSTGHvL+Ai8RX6iB
	qgbd1igyCHaFa8UhBXE4sOpNMnu6ZLM1+b+HNVjZ3L9v658SxzBUu3Qxe/cQ/FP544qUbqlLEWV
	1lLX01OcTRAd9mvDt7g2YezvCg62WXJMGS8P5LRCmgonJKKs1iRW+NHyybhyb13PU9mvZ/gcji6
	wunMftO1h4U0eqrRnoITTrLaliG1b6aMIUbWdsIRYYIl4Cg3jWKDvnUpr9pGOSaLa1AmcpvME5o
	Kel9q01vpEBRBswNPFDrTyw==
X-Google-Smtp-Source: AGHT+IEEPG6zQrG5Fn8xiXprRkSMvK0L1JGYHHUhhPLWZEaWGm8GRfv4Vu88fdqarHxRJn4DrS+X4w==
X-Received: by 2002:ac8:5ac8:0:b0:474:e033:3efb with SMTP id d75a77b69052e-47916258772mr58941381cf.24.1743689934185;
        Thu, 03 Apr 2025 07:18:54 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b057825sm8148331cf.5.2025.04.03.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:18:53 -0700 (PDT)
Date: Thu, 03 Apr 2025 10:18:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org, 
 daniel@iogearbox.net
Cc: netdev@vger.kernel.org, 
 ast@kernel.org, 
 john.fastabend@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 Matt Moeller <moeller.matt@gmail.com>, 
 =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>
Message-ID: <67ee98cd6c179_136b7c294e1@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250403140846.1268564-2-willemdebruijn.kernel@gmail.com>
References: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
 <20250403140846.1268564-2-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb
 frags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Classic BPF socket filters with SKB_NET_OFF and SKB_LL_OFF fail to
> read when these offsets extend into frags.
> 
> This has been observed with iwlwifi and reproduced with tun with
> IFF_NAPI_FRAGS. The below straightforward socket filter on UDP port,
> applied to a RAW socket, will silently miss matching packets.
> 
>     const int offset_proto = offsetof(struct ip6_hdr, ip6_nxt);
>     const int offset_dport = sizeof(struct ip6_hdr) + offsetof(struct udphdr, dest);
>     struct sock_filter filter_code[] = {
>             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
>             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
>             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offset_proto),
>             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
>             BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offset_dport),
> 
> This is unexpected behavior. Socket filter programs should be
> consistent regardless of environment. Silent misses are
> particularly concerning as hard to detect.
> 
> Use skb_copy_bits for offsets outside linear, same as done for
> non-SKF_(LL|NET) offsets.
> 
> Offset is always positive after subtracting the reference threshold
> SKB_(LL|NET)_OFF, so is always >= skb_(mac|network)_offset. The sum of
> the two is an offset against skb->data, and may be negative, but it
> cannot point before skb->head, as skb_(mac|network)_offset would too.
> 
> This appears to go back to when frag support was introduced to
> sk_run_filter in linux-2.4.4, before the introduction of git.
> 
> The amount of code change and 8/16/32 bit duplication are unfortunate.
> But any attempt I made to be smarter saved very few LoC while
> complicating the code.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/20250122200402.3461154-1-maze@google.com/

Let me respond here to the earlier comments in that thread, rather than reopen that.
https://lore.kernel.org/netdev/4a6be957-f932-426a-99bf-7209620f8fa9@iogearbox.net/

As Daniel suggests, a developer can work around the issue in a variety
of ways. And that is what this customer does in the short term. Avoid
SKF_NET_OFF.

But I think this does need to be addressed. SKF_NET_OFF doing what you
expect in many cases, but silently missing matches in some, is just
dangerous. It's not hard to fix: just use skb_copy_bits, like we also
do for regular positive offsets.

The specific instance is due to attaching a filter in the L3 layer,
while inspecting a transport header that will only get pulled by the
L4 layer. Pulling these headers in device drivers is a non-starter.

