Return-Path: <bpf+bounces-79358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16447D38BF3
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 04:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC853027E35
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894E322C73;
	Sat, 17 Jan 2026 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhqnX1kg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D81850A4
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768620406; cv=none; b=NMsjvpZ22A9GndVw75omsCSJfAUrRrK53j1ZSgqUMkSOHepEcgNEO23RbVmWnsWYAJ+SGPtUWpAvZ/LuiLBGjqJZTGzy41Ofmwe1fJE6ESfczFFnHQokRtUABwJVHQ/3EoOS3Yf6bWSdYrZTemi/GxefuIVcTlJJjqhMXBUqPb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768620406; c=relaxed/simple;
	bh=xDF65S/TKQ4cBuli8TtF52ak89loaaOOzkjnMCgIMFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7mArjrHUWcJiJ0mssKrS+ougLqcM+h9DQoBxdPE3SSlYpgw3wZYb4h59BZ7jSgu7ItYQOXvApeU8SDAX/hgqNa+R9guJOqL/k+pNdTMOc4wADtSG8dxqzic7XP+eLs+SaaTl/UN1eD+t7/BTF8n0uWzUYCi8j9B+2yfoRDoUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhqnX1kg; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233c155a42so3569576c88.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 19:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768620404; x=1769225204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n87JQRcCtgP7Sq4RUgv8xqJK8FC4ujcX9QlIpDyOsKM=;
        b=mhqnX1kgoR3aWQouO7NPA5Crjzxf5zn7a/uwMMfPvu6OIzjbDHKxmEV7EzZU5yjQ9C
         t0+2fVZgID0g7qcxF8MtElkqbEP4mI1/+kZ1MZEE0LjMCq14kIRhGI32AaW2ZTS2+UPq
         XwZ84qbRIeUp2qNoouYNZW0Zws7q1rm9K8aUDMyeNHR04P7As+N8vLisDhCRTnCe9rmi
         J8Ep9YG+6WPJisORQCBbDNM8xqF3/bl4OdNlOucuV4XfzE9lefBaZ+p1K3VsLovD+nSy
         WQh9D/9i/G2xAu3NB8Q2ePugC/IzM1s5VyQqEArsR5iej5H6k3W/dN1blD/0zq8meiWb
         CJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768620404; x=1769225204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n87JQRcCtgP7Sq4RUgv8xqJK8FC4ujcX9QlIpDyOsKM=;
        b=WNOCSc8591wknmJYTmXIcReVIxSe+guW8z2/fbaDmsPvLd3f6M6ZxDFEdEjUWK7d6l
         Ixv2nJrjSYvEZkdkcax9YOX36nlxlZxMKu1fUfpELpAQ37SmVmk2OasiEd9fEmvvPGPh
         KHhjW2Ac45wv80MkoHrH2T4Y9UlzYW4tDPO11Tk0MnFeIC36yvQYdrSxnhvoCfFRfut2
         ywAzPdJnBDUYodapHR5kikp1qxSOWHyueWvd5u4kpWumNpcl36teeOrFBBIxJcpQWdDG
         srGFtx6uuqA5uIdKKn5T7fCdpMDEjRtZqVDV/rCTkmp2AW6zNOjofH6ffg7Mt1DxM6rX
         0o3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOEmE2OgZ8RykNw8x974XpTp1noJq69zX6484bezvrKj8TvjmmawfCFg6srrJ3jBFPNqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYWbinKcgzlRTO/fYqnyHo30i+WERGbdaZAxpWCoJkli7s23q
	jstFOPklAEKnuQA0RE5ObY006+9OU5Ma9a7MhBaKjxmr/G6eVBBd2PXM
X-Gm-Gg: AY/fxX6T8xkTrcLcRsopv5hlP/AAtqwJE6xL/j+DuGIpUO67HhaqMSn7UnhRo0aPPXn
	cSWbyBEV4Yo1u30IeVF6sF0c+h8pKEq73uP8L/ykY35m6HGPAglWZ2h91/7r6q1OiRlSAs+C35t
	gVdGBTEOYEOGViuTA+iA3SLFSz+0B/BEicnjFZ6t1bX/NgIAykOYFOVOLTygwc73CTOHB+m6fzp
	RS6bNYiPQlA++8+1U25p09HEjvuMcyw0lC9pAl8I2LGDThM2KIXOTIgqWoDuRRvbnHsZ+359lmz
	WkO5F6yNCmE5CdUdYAX8oBzJq/+UiDMcm0wMmOYKuXye2PDpJZu0k+y/7Wi1spXWc3yIhnZj76Q
	SYT0NnwjiATWi6VJ0Mgn4fKzIH1Y7CsYJ6K85UWwvlkJhkhmcRB9spBVGGaCt7oeXqbLU/JeP3y
	SOnOz0WRCgNtbzK9f0v/lsDCUJeO0=
X-Received: by 2002:a05:7022:4396:b0:11b:ceee:a46d with SMTP id a92af1059eb24-1244a6e1306mr4069764c88.15.1768620404134;
        Fri, 16 Jan 2026 19:26:44 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm5382813c88.7.2026.01.16.19.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 19:26:43 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
X-Google-Original-From: Qiliang Yuan <yuanql9@chinatelecom.cn>
To: menglong.dong@linux.dev
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	realwujing@gmail.com,
	realwujing@qq.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v2] bpf/verifier: implement slab cache for verifier state list
Date: Sat, 17 Jan 2026 11:26:12 +0800
Message-ID: <20260117032612.10008-1-yuanql9@chinatelecom.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <14011562.uLZWGnKmhe@7950hx>
References: <14011562.uLZWGnKmhe@7950hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Jan 2026 22:50:36 +0800, Menglong Dong <menglong.dong@linux.dev> wrote:
> On 2026/1/16 21:29, Qiliang Yuan wrote:
> > The BPF verifier's state exploration logic in is_state_visited() frequently
> > allocates and deallocates 'struct bpf_verifier_state_list' nodes. Currently,
> > these allocations use generic kzalloc(), which leads to significant memory
> > management overhead and page faults during high-complexity verification,
> > especially in multi-core parallel scenarios.
> > 
> > This patch introduces a dedicated 'bpf_verifier_state_list' slab cache to
> > optimize these allocations, providing better speed, reduced fragmentation,
> > and improved cache locality. All allocation and deallocation paths are
> > migrated to use kmem_cache_zalloc() and kmem_cache_free().
> > 
> > Performance evaluation using a stress test (1000 conditional branches)
> > executed in parallel on 32 CPU cores for 60 seconds shows significant
> > improvements:
> 
> This patch is a little mess. First, don't send a new version by replying to
> your previous version.

Hi Menglong,

Congratulations on obtaining your @linux.dev email! It is great to see your
contribution to the community being recognized.

The core logic remains unchanged. Following suggestions from several
reviewers, I've added the perf benchmark data and sent this as a reply to the
previous thread to keep the context and review history easier to track.

> > Metric              | Baseline      | Patched       | Delta (%)
> > --------------------|---------------|---------------|----------
> > Page Faults         | 12,377,064    | 8,534,044     | -31.05%
> > IPC                 | 1.17          | 1.22          | +4.27%
> > CPU Cycles          | 1,795.37B     | 1,700.33B     | -5.29%
> > Instructions        | 2,102.99B     | 2,074.27B     | -1.37%
> 
> And the test case is odd too. What performance improvement do we
> get from this testing result? You run the veristat infinitely and record the
> performance with perf for 60s, so what can we get? Shouldn't you
> run the veristat for certain times and see the performance, such as
> the duration or the CPU cycles?

Following suggestions from several reviewers, I aimed to provide perf
benchmark data for comparison. However, existing veristat tests do not
frequently trigger the specific state list allocation paths I modified. This
is why I constructed a dedicated stress test and included the code in the
commit message to clearly demonstrate the performance gains.

> You optimize the verifier to reduce the verifying duration in your case,
> which seems to be a complex BPF program and consume much time
> in verifier. So what performance increasing do you get in your case?

The performance gains are primarily seen in the 31.05% reduction in Page Faults
and the 4.27% increase in IPC. These metrics indicate that moving to a
dedicated slab cache significantly reduces memory management overhead and
improves instruction throughput. Specifically, the reduction in CPU cycles
(-5.29%) confirms that the verifier spends less time on internal allocation
logic, which is crucial for complex BPF programs that involve deep state
exploration.

> > Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> You don't need to add all the reviewers here, unless big changes is
> made.

That makes sense, thanks for the advice. I'll refine this in the next version.

> > Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> > ---
> > On Mon, 2026-01-12 at 19:15 +0100, Kumar Kartikeya Dwivedi wrote:
> > > Did you run any numbers on whether this improves verification performance?
> > > Without any compelling evidence, I would leave things as-is.
> 
> This is not how we write change logs, please see how other people
> do.

Actually, the content following the 'Signed-off-by' line and the '---' marker 
is specifically designed to be ignored by 'git am' when the patch is applied. 
Only the text above the triple-dash is preserved as the permanent commit 
message. I intentionally placed the responses to previous reviewer comments 
in that section so that you could see the context and history during review 
without those discussions being permanently recorded in the git log. You can 
verify this behavior by testing 'git am' on a similar patch.

It's for this very reason that I decided to include the reply to reviewers 
directly within the v2 patch.

