Return-Path: <bpf+bounces-64604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC31B14BB2
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0D4167973
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C9288537;
	Tue, 29 Jul 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQA/PbY2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A252877DA;
	Tue, 29 Jul 2025 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782798; cv=none; b=UeNhvCl22Url+CaltKDJX55im+jTuqVcr2nmFxtUsGPk4YyBf7hOYvo/8sGAWaxy2J8teXFVL0C/7+cnTm+o9f73sXV9I9k0+ZjgwWZ3/RBxf4LNI3jLPZSDI191+r+XCAxQRGAAP1jyfJX9ydH+RAmTwTjnh8L4RIJQoJPu0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782798; c=relaxed/simple;
	bh=rlndRviMl0UcHdaxHRoggsqdCQNzmSzMZrAcRGb5hqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIftiBEKeCOebATaGrDz4g9CXzEyqphXQPf7uK4mQ8Qlm0bDz4q7qACQ3m8bHBA5KulZ49fvqnxpbo+Mlj8t82cmoHnnovXEEkU3SXfM9g+N/G0CLZR3LjChIUgKv26/ZspMPYqLt6dKz/ySt+qfvqeBSis+Au37id014w8QzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQA/PbY2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4563a57f947so3062325e9.1;
        Tue, 29 Jul 2025 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753782795; x=1754387595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EE9S7KbhSao+VXArHjxBh/cgveFNCFgRdGsc9h/clf8=;
        b=XQA/PbY2VY8gIcV2WDayvPks9ywOuz1T8MAcHHw1R8f9Za8LBmx2UhivrZljvar1Eq
         v/nPbDAHkQeRILzF8Hj5anWqkOcF2hhiweYaR1f6bJT9TQhgzOTCCkdZAZJg4liGgTTb
         6oQ2KEJzxNo5D4eE8NlqFGbsZ7aL/btKk+SNE+62ZGoBD/XKqWVr8ZC6dIxotT6VdNDd
         71PwmdvIdI0tYxq0Zwek8G7wgW2nKVNgfpBTRLLrdWJgYZbLKhvwJNmIqHe9rOF4M1SI
         oUliZFh/mU1Dq5smhHRAa9qBtlUMiq+Ug2VWPXCM3ODITZ4SGPWlgphF/pgyzU1vGOXD
         /0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782795; x=1754387595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE9S7KbhSao+VXArHjxBh/cgveFNCFgRdGsc9h/clf8=;
        b=c5s9tRoRwWpOu/ZmtfASq0CzzdH3YTm1uS1PQQ6Dn5an5sXvIbcZOBlKxgf5YCUj9t
         Me55NvAbeT69IJoxhMvW06mK5mkwTN7gt1ff9ulbnHP/uKVksV1e0Um/OVDzkWBnxq6x
         gIS+Zc1nh4HMA4oO/N50+Ml2Di0/0NnsssTbN+0wxgMIRuCPGCFhS92x+2uj1Fn41PGR
         iyOa0z8fLZAOGT+FIECK48wFz0V12VaKb10CPZNQds4HcAwVjUXPFxkI2q7gcmupaamx
         EyQTojyGX16V+S9KVeGqDQ1d7F1pXp83oRTrmW7Lkv4kz7OgoLlNCWd1PZcmqlnWt9mI
         FLzA==
X-Forwarded-Encrypted: i=1; AJvYcCWBQH48nyJA9Xuy646/USy/OwOmNGkfWD26+QUBYxJF1wAg+FcyRKpaJTEoOMzsDlJWBOo=@vger.kernel.org, AJvYcCWvk62lNGvR7bMvlHK+z9X/ZLzGPhXDR8PXGF73KM6xcLpfIN2abTjFrSq/pJiqc+WklE1Ke7L2@vger.kernel.org, AJvYcCX5eLWccUqZZq6noRlyAGK/mgP8+V1ETi9ttbQ94yZuI7OEFGyhtt0rVgGvajv7q5oMpPp6ZcnT4mAzX9CpmUTC@vger.kernel.org
X-Gm-Message-State: AOJu0YzqaGr1FsgFG0lhOTdTaE2FeozOrJSlzUle95UWQWwvNa+VmqfX
	txp3rGMB6cB2rKe4vZJs+YAvx4G8iwyXewI756CcPJrD2q/o4ADB5qLe
X-Gm-Gg: ASbGncuuR2tdZOZgzG1U2zEnY8idCpWagXfPXUm5EdklrQg1mM1lBT+XFgOUQUrWkJv
	wLYjyfhYFtcqFd9k5TnNZBVs1+NbJw9QKOyOtU9yhDWax0e051bXdtseV1yjRzKyE9qBbICprLS
	0ji6jWJW4zv3obg8US/xUWQkKjjAUxwCljhLyD2+C8nkXMZKToDIPDGXwrl89K9JYi8YZdq0Ta3
	dL/0XtmjoGZe9hiMwyl80dCJXrkiGLnFyOxO7mH+wB8TCo1Z9BS3kRRDtU5Vof10RDmrwmvNB2w
	Cap3+rQyacOEFvAAMzCJn3wT3Wkgey/fBZ1vDxZPeT03G8+qYnuMESc/Uqr+Pk2Yi66bo8v3gKc
	mr3MZp6QFi6IYm6LuniSKW8Lt0flX6YnrY48aAys+hDBJBSz426LV914=
X-Google-Smtp-Source: AGHT+IGZrlB2YEoAZYXWNimrkcTKG3bFP6Bf59CEiAeLziQfIZ6sdzcDPoKMp80H8l0VyK0C7TQmsQ==
X-Received: by 2002:a05:6000:240b:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3b78e3d5ac2mr2135420f8f.5.1753782795107;
        Tue, 29 Jul 2025 02:53:15 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcb96sm196872745e9.21.2025.07.29.02.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:53:14 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:53:11 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
	fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, lkp@intel.com
Subject: Re: [PATCH bpf-next v3 0/4] bpf: add icmp_send_unreach kfunc
Message-ID: <aIiaB2QUxKmhvPlx@gmail.com>
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <b36532a2-506b-4ba5-b6a3-a089386a190e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36532a2-506b-4ba5-b6a3-a089386a190e@linux.dev>

On Mon, Jul 28, 2025 at 06:21:50PM -0700, Martin KaFai Lau wrote:
> On 7/28/25 2:43 AM, Mahe Tardy wrote:
> > Hello,
> > 
> > This is v3 of adding the icmp_send_unreach kfunc, as suggested during
> > LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
> > actively reject east-west traffic, similarly to what is possible to do
> > with netfilter reject target.
> > 
> > The first step to implement this is using ICMP control messages, with
> > the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
> > ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
> > than a TCP RST reply and will already hint the client TCP stack to abort
> > the connection and not retry extensively.
> > 
> > Note that this is different than the sock_destroy kfunc, that along
> > calls tcp_abort and thus sends a reset, destroying the underlying
> > socket.
> > 
> > Caveats of this kfunc design are that a cgroup_skb program can call this
> > function N times, thus send N ICMP unreach control messages and that the
> > program can return from the BPF filter with SK_PASS leading to a
> > potential confusing situation where the TCP connection was established
> > while the client received ICMP_DEST_UNREACH messages.
> > 
> > Another more sophisticated design idea would be for the kfunc to set the
> > kernel to send an ICMP_HOST_UNREACH control message with the appropriate
> > code when the cgroup_skb program terminates with SK_DROP. Creating a new
> > 'SK_REJECT' return code for cgroup_skb program was generally rejected
> > and would be too limited for other program types support.
> > 
> > We should bear in mind that we want to add a TCP reset kfunc next and
> > also could extend this kfunc to other program types if wanted.
> 
> Some high level questions.
> 
> Which other program types do you need this kfunc to send icmp and the future
> tcp rst?

I don't really know, I mostly need this in cgroup_skb for my use case
but I could see other programs type using this either for simplification
(for progs that can already rewrite the packet, like tc) or other
programs types like cgroup_skb, because they can't touch the packet
themselves.

> 
> This cover letter mentioned sending icmp unreach is easier than sending tcp
> rst. What problems do you see in sending tcp rst?
> 

Yes, I based these patches on what net/ipv4/netfilter/ipt_REJECT.c's
'reject_tg' function does. In the case of sending ICMP unreach
'nf_send_unreach', the routing step is quite straighforward as they are
only inverting the daddr and the saddr (that's what my renamed/moved
ip_route_reply_fetch_dst helper does).

In the case of sending RST 'nf_send_reset', there are extra steps, first
the same routing mechanism is done by just inverting the daddr and the
saddr but later 'ip_route_me_harder' is called which is doing a lot
more. I'm currently not sure which parts of this must be ported to work
in our BPF use case so I wanted to start with unreach.

