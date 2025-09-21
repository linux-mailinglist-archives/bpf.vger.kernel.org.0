Return-Path: <bpf+bounces-69160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D408CB8DDFC
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 18:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7592016E2F1
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FAA1E5B7A;
	Sun, 21 Sep 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="LTPyEKun"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814AB34BA28
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758470621; cv=none; b=F/LBA+FXqGc1FaiKBUV1KXbS28aLhPQZT0tr+ZdsRwNoQF5gvI/rJOHnmL41mMnUvai7XprcrbACIJ+yvMYurfQPb/Cms8XdYYCElR/PzPrGSYOExEP1bh7IQIE0V0PPfsXSdN35vGDaYmG0QBeiiJFlPr7PsdzhakuOEiyQx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758470621; c=relaxed/simple;
	bh=Nyv3nu9ra+VnkLcWi4fYDcC/tqIyFF5rY8/59rRkprI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu+oSDqL5QQk+gb153anMnWB0iK3ZYH5cp2UzoL1fyTJjhcbI+Tn5rZq2Eemfv9KEDK1talH5pYONPv+kj/LMrko+KpJ3oCsvkg/QKFPu8/11qL18vKZkHR/HJ3WCtxIp8BqedZa2T2TcbKJkMP+2yd9cVMnSrcKc9VTvjNk8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=LTPyEKun; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b520539e95bso191100a12.3
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1758470619; x=1759075419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m8vv2Le2VJrRxnfPklYATsMJpEaKnulCkTyhGkgWhWU=;
        b=LTPyEKunRJqMGjbdXUgzNLIalrK30rf3VEL3LynfI9XTB2cEmjQf30UY94NFyWnNvl
         0Y0ef+iVnf+l1ml08mVHXVL9N8lz+R8UqyE59xWs6my/uMYLmoQyhFxy8dQHKHvhne2V
         D0GLg9VX2J8MzPm4DFW2fO6Ltb/bkYvqy5jjbGYRPSeKkWH1jWxHrp1RFo6r3ZoL5jkq
         KKvsbSNcmUM5TokDct86vRi/Mqf0vvmwBc+Ucn05fTZ8Jhb7fuv4+pJDKoMn6K/qDwfS
         lJzfLRyZqAilwnCXn3pAwHIudKOw6jkZXHdyUg6/pT0YzsjHTDvg3RbM+OMxRAkYW/uA
         9c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758470619; x=1759075419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8vv2Le2VJrRxnfPklYATsMJpEaKnulCkTyhGkgWhWU=;
        b=nUEwmm0oTVT9w9S99bqRGkcSZx6ZwNznZvpCZjVW9Fi5ExQij5jAejqu22Ppi2nEer
         e/bcskegGvLhK30u+xjbR/E+S6YT6lIOQbfExfUyJZAy5Uzq95Wxto9W+5RhYG27IWJ9
         PGkRX9OCnMPdbjAKaBTyFxXKwCaNDNfws5ox8U72GQUl+p3SO3+sqPG7zT49ZkRi08m2
         qk2/gIODxyX+xVdX9loHoMnbpPUhYDaXgNZ/p0UV1fBRbtJVZKiC65VAReml/QsmKRVD
         mDURyw4OL/H9Y1xvRxh69G7WSlbGpWRGB/qMsVP+qXy2vmFhiwS0E1c4Gtt61QzsDSj+
         rwgA==
X-Forwarded-Encrypted: i=1; AJvYcCWEYD/pv0PmJqm8JjGGwJgOfKmzjcSJ97PajJmMXeZ2DCl72birgyCm8dcf/8Fsnge07SA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mfWWFiHMjRPxJEt4HBQ1iO3IKFVuwEXS/37eX6CN0zi+inzV
	6RWJDL0w3MrAhlt3Y9s0uddVdN2eRlWBYuAq49KZVIfoVfLORdNCfXPzCE8HB/q9ik4=
X-Gm-Gg: ASbGnctUAdV+WM1PBPdWC/rJikfNDNrS+6+Q5hxgMFJD9xUJhKEyv4yinhbgz/BRiCd
	fdXNNJxsYcGZXE+qTWasxrmHVWVqxTF+Mmx3pOL/jKf3IRMY/fiPgi3Eo+CHURqUIEzlLw+VGWI
	tUNegeUTc4YwkIlPVEoFYk9+VI/nczPO6pBion0sZa/hfzhdHsV1kA/j4y3Qmt1yClg2Qfeb3h4
	LgUBXTLn0JnntfajYRkPVuDzib1JHq+rO5R52XKKMpkP2gUDN+6ShhFQFKRqlC1Z6tg46vlRGWN
	SSZC/TIHEXedsdCvR30VvfvujSxViHWewWMM2vVcUmA8ePNFaG+N/lc1sa/gBDjSdXao0omhfnc
	UfKdmgwVZ
X-Google-Smtp-Source: AGHT+IGO1cuQkOPmn4UyOI5kFKI36eTSHeG8iJchXXEH6ggKPqiEmnDaBeCZE+RPDXwV2gVC+zSVyA==
X-Received: by 2002:a05:6a00:c96:b0:776:6e9e:3ccd with SMTP id d2e1a72fcca58-77e4f48e9a9mr6592843b3a.7.1758470618633;
        Sun, 21 Sep 2025 09:03:38 -0700 (PDT)
Received: from t14 ([2001:5a8:4519:2200:4345:519b:ccab:7b30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c05sm10322652b3a.4.2025.09.21.09.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 09:03:38 -0700 (PDT)
Date: Sun, 21 Sep 2025 09:03:35 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 00/14] bpf: Efficient socket destruction
Message-ID: <ilrnfpmoawkbsz2qnyne7haznfjxek4oqeyl7x5cmtds5sdvxe@dy6fs3ej4rbr>
References: <20250909170011.239356-1-jordan@jrife.io>
 <80b309fe-6ba0-4ca5-a0b7-b04485964f5d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b309fe-6ba0-4ca5-a0b7-b04485964f5d@linux.dev>

Hi Martin,

Thanks for taking a look.

> How many sockets were destroyed?

Between 1 and 5 per trial IIRC during this test. Generally, there would
be a small set of sockets to destroy for a given backend relative to the
total number UDP/TCP sockets on a system.

> For TCP, is it possible to abort the connection in BPF_SOCK_OPS_RTO_CB to
> stop the retry? RTO is not a per packet event.

To clarify, are you suggesting bpf_sock_destroy() from that context or
something else? If the former, bpf_sock_destroy() only works from socket
iterator contexts today, so that's one adjustment that would have to be
made. It seems like this could work, but I'd have to think more about
how to mark certain sockets for destruction (possibly using socket
storage or some auxiliary map).

> Does it have a lot of UDP connected sockets left to iterate in production?

It's hard to say for certain (my perspective is as a cloud provider,
but I've seen customers do strange things). It seems unlikely anyone is
creating, e.g., 1M UDP sockets on the same host. In practice, TCP would
be more of a concern. Still, it would be nice to have a more efficient
means to destroy a small set of sockets vs doing full UDP/TCP hash
traversals.

> I assume the sockets that need to be destroyed could be in different child
> hashtables (i.e. in different netns) even child_[e]hash is used?

Correct. You would have to do a hash traversal in all namespaces that
contain at least one connection to a given backend. This might hurt or
help depending on the use case and depending on how sparse the hashes
are, but might cut down on visiting / filtering out sockets from other
namespaces.

> Before diving into the discussion whether it is a good idea to add another
> key to a bpf hashmap, it seems that a hashmap does not actually fit your use
> case. A different data structure (or at least a different way of grouping
> sk) is needed. Have you considered using the

If I were to design my ideal data structure for grouping sockets
(ignoring current BPF limitations), it would look quite similar to the
modified SOCK_HASH in this series. Really what would be ideal is
something more like a multihash where a single key maps to a set of
sockets, but that felt much too specific to this use case and doesn't
fit well within the BPF map paradigm. The modification to SOCK_HASH with
the key prefix stuff kind of achieves and felt like a good starting
point.

> bpf_list_head/bpf_rb_root/bpf_arena? Potentially, the sk could be stored as
> a __kptr but I don't think it is supported yet, aside from considerations
> when sk is closed, etc. However, it can store the numeric ip/port and then
> use the bpf_sk_lookup helper, which can take netns_id. Iteration could
> potentially be done in a sleepable SEC("syscall") program in test_prog_run,
> where lock_sock is allowed. TCP sockops has a state change callback (i.e.

You could create a data structure tailored for efficient iteration over
a group of ip/port pairs, although I'm not sure how you would acquire
the socket lock unless, e.g., bpf_sock_destroy or a sleepable variant
thereof acquires the lock itself in that context after the sk lookup?
E.g. (pseudocode):

...
for each (ip,port,ns) in my custom data structure:
    sk = bpf_sk_lookup_tcp(ip, port, ns)
    if (sk)
    	bpf_sock_destroy_sleepable(sk) // acquires socket lock?
...

Or maybe just mark the socket for destruction in the test_prog_run
program (sock storage?) and later call bpf_sock_destroy in a sockops
context next time the socket is used.

Either way, I think the constraints around which contexts
bpf_sock_destroy supports might need to be relaxed.

> for tracking TCP_CLOSE) but connected udp does not have it now.

Overall, the SOCK_HASH changes felt like a natural starting point, but
I'm happy to discuss some alternatives. I like the idea of being able to
combine bpf_rb_root/bpf_arena + bpf_sk_lookup + bpf_sock_destroy, and it
seems like an interesting direction to explore.

Thanks again, I really appreciate the input.

Jordan

