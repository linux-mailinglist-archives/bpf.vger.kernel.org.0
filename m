Return-Path: <bpf+bounces-47308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CEA9F757E
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595FB1897C05
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E7C217649;
	Thu, 19 Dec 2024 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SWx839Io"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE87082A
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593230; cv=none; b=IWVzUVbKwKNQQbtd63IptGeUx9JzhKBqSFFJCV5Vf8LvuIEQwocOTNLuI5wpqv3F4SVjltIe2ke6YHzJNCBaEPBd7Mjcbi3awMn/wVsFo2qsKlqKumefeuB6LlEmRM52u/hhkj0qsBroUyD/oPUfXEu/VHxQCjF+GBce2/b+zws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593230; c=relaxed/simple;
	bh=Od18z0ts5rbdzAMXA8q7vzb70Zt2A4EjCQMXzlAm/LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp3OEgJO54XzgQskcw7gu+tJbSzu7E0gn8RqdrqwGl+dCHGQ56039SH14DwnhMuwLEkkcjwyLBOk7AbUlxXAz0Q+LQHYQx42uLOHiMTNS2MBsbjm7bOSWCpWSvCvFzjqOYfjF8mw02HRcTaJzbIizdGqs32fyqTXUB/z/1bFw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SWx839Io; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso65766466b.1
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 23:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734593226; x=1735198026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97dtlVcyBw25M5fzaFmvtmyL554Hmq/m5IYqP4Pg62U=;
        b=SWx839IoV8/Z+0EGBR+MaZmuLuylHpbmsYz5WSXqyNOvCwU77Ao0fz74KaJnAm5s6O
         ZbkFb7FcrGVkLRyYDicT9qP+Xl9jwqRtdYRSCEcJh1Swv5Sy+E86pnVzNP1XoCrWgPuW
         3Q8qS53Zr/YzFN+lTBuPlYp+adFHxcpJ7cNjl25QJ59/TE2mGUUX5zaAoERVtMmZyQC0
         iyRSaK2RpO+rl/5GpkhPFViqYWvTXbPDNPcVgfpty5E81MLvwLwjkfK5oLfZdRd3evOL
         7shk58GUODjBt9Xv4gEFmFnf2MZo8L5mHUG3FCPIpRvOPr6yLOHB6Lv8A0bOmR6imXaX
         O/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734593226; x=1735198026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97dtlVcyBw25M5fzaFmvtmyL554Hmq/m5IYqP4Pg62U=;
        b=EpoP0LeAFu46csW3hrD2ZTzPXCn+5IRsLT7R7Jf9+wEgYGfvpVzRLxr9UQD3ogyehI
         gdj23/U5WJhedEFVtwncJqFTt7hgkjWPu84L2tYwCOXJ50JZ9h3+VVLd2MY2Rb11Pf/X
         PHPMzms1mlLdUkWjPEKVWOSk2np+Rcjoijh+q4RaSjC2/gmOMGjO7BoiKUogxhOviXar
         eGpzdQid/RLyEYRKYGewpzfBIicDKoBkzhBpcfq0Urc7MXvQ29Mgq2hqzWMM0CyqVTlx
         NylbScaOcpoN5foC27HmrcIf86tfESJVzGKA4mFbtyIDP24llQNTtKY2jDYH7KRvfmk8
         Ei+Q==
X-Gm-Message-State: AOJu0Yz3DQLt/HkwYfCehO5jux9dw/XjL581U2EHiWMm5PXpd6lPpDNy
	kYZYuwecIkihE3KcU9D9r25BE8TdGnvkc8r/j1Jiq4x7HBraOJMhc+7bssNO3Ag=
X-Gm-Gg: ASbGncu7TnKikqvFXlevwfU0VOlG86mdFSBbNK5GD6T47atCT9pAkCKDJQLbeS5Lfnj
	OW9ExXZ6mcz00hGC4LBtX/ImdqTfhD2bKar9Lvi6/yaoAkDzlvFVQTlc5WfUmflXV5O6H7X0aOu
	bkiEGK/TL1gJ7FlAqi++XdT7zFlYOH8hjGXQLoOusEqcqF6oCSSXUkZqF6yLsaCyi/Dk0WrH7DL
	nUJ4okuYjY2bTon+Y3kOvHz8ivASHt9m1lzMV+/mw7x9UrXVffQmXlrIRaI2uEN
X-Google-Smtp-Source: AGHT+IEn6oeRbRI4AbH6fhvhNNVfLJ+Ai5mr0MHcTIXEZVTgpNmYy1QyMV2EdVWreRq6xsw1gNbabw==
X-Received: by 2002:a17:906:7ad5:b0:aab:73c5:836 with SMTP id a640c23a62f3a-aabf47baa3amr478289066b.32.1734593226110;
        Wed, 18 Dec 2024 23:27:06 -0800 (PST)
Received: from localhost (109-81-88-1.rct.o2.cz. [109.81.88.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f15dsm35600466b.23.2024.12.18.23.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 23:27:05 -0800 (PST)
Date: Thu, 19 Dec 2024 08:27:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 4/6] memcg: Use trylock to access memcg
 stock_lock.
Message-ID: <Z2PKyU3hJY5e0DUE@tiehlicka>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-5-alexei.starovoitov@gmail.com>
 <Z2Ky2idzyPn08JE-@tiehlicka>
 <CAADnVQKv_J-8CdSZsJh3uMz2XFh_g+fHZVGCmq6KTaAkupqi5w@mail.gmail.com>
 <Z2PGetahl-7EcoIi@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2PGetahl-7EcoIi@tiehlicka>

On Thu 19-12-24 08:08:44, Michal Hocko wrote:
> All that being said, the message I wanted to get through is that atomic
> (NOWAIT) charges could be trully reentrant if the stock local lock uses
> trylock. We do not need a dedicated gfp flag for that now.

And I want to add. Not only we can achieve that, I also think this is
desirable because for !RT this will be no functional change and for RT
it makes more sense to simply do deterministic (albeit more costly
page_counter update) than spin over a lock to use the batch (or learn
the batch cannot be used).
-- 
Michal Hocko
SUSE Labs

