Return-Path: <bpf+bounces-79053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB10D24A81
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 14:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C70130158EE
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69439E166;
	Thu, 15 Jan 2026 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b="f3mOQ1Q0";
	dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b="0P4f6tev"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.mpi-sp.org (smtp.mpi-sp.org [141.5.46.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B633A9D1
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.5.46.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482310; cv=none; b=UeZ3zHpM4TjwbfPfeCOGOaeNEgMYx7Ds3MFlYWZwVf/lUHNd5QStb7Y5xzsbwAUJPGztlGFUq2rD0GvBu9ideDulKLwY3tatleJUbl3b0dzXRKNUcZWDc+4DZRxZmiTifcp4K1xSLYWvP9qra3M0gIvG7ZUWxQddnlRQr90GlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482310; c=relaxed/simple;
	bh=syDsAmWtFpOnw0totyvwj9l2H1D3Mm4Syxk6/yuEH7M=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=luXLhTPXIeLHLp8jQrW0b5KM4Mk/p9F9eNsG29CY/vRtt+AZlm1GBLc9ja91UfcqaM3C0Ww1Q6RD3ZjY0nFqKYxwjZO+FAZ26NwOmv7crZhC5DFxuV9NXEU6BWuBgfuMxNiGUOhcEWWZ/CazdpMTQLMg9RslUa1QG3U8SfTMJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mpi-sp.org; spf=pass smtp.mailfrom=mpi-sp.org; dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b=f3mOQ1Q0; dkim=pass (4096-bit key) header.d=mpi-sp.org header.i=@mpi-sp.org header.b=0P4f6tev; arc=none smtp.client-ip=141.5.46.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mpi-sp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpi-sp.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mpi-sp.org; s=202211;
	t=1768481851; bh=syDsAmWtFpOnw0totyvwj9l2H1D3Mm4Syxk6/yuEH7M=;
	h=Date:From:To:Cc:Subject:From;
	b=f3mOQ1Q0HaeAoD/mbWNGTHArBcxbJo4+bWWvTmF/flsVd1MjUuE+lM5hoCXTkcivz
	 BYYj/Bqr+1vT8OQyULIoehPwtVcxrMSzK6L/0EQY6gjeHzpU4vuByrIZe2pRfdpKD8
	 HG66I0I5Jq9ARwCCAm8kJVSxWP5VTfegf6JbSaDqwztQJKTxOn9RQvfRRYepJ4rGVN
	 vuUbn+8ZwIAYYoWnxqoJDUwVxZCWDbDVpUamR82Nx/3fIC+J04WFYYiFJno1HTIlEf
	 UC9G3HCpBEVo1viDA8loH5YHtPqEzFWj6WymGfYKntw8MTNSji5t8leNxKRnTcdUZt
	 I8JJSI9quf6VKk7QVWh/kYzlpR+0jeEey4OUov72s5OIvzqHOmgYAt642IZP5EslnE
	 S04AcW9vIziLs72DAjgpLjv1n5EE3sMVZoQL4BEr3ifRGifiaBkSCa8BTn60HAy978
	 dAVZvnf33UfpWG8HZU3paKsQJerJwKfCskHZ87VxgoHNSd7DWumq5SEBr80CS0YRq6
	 mWimhqC3YAfuVfCqif860s/0Xircj0UDVKnGL0G1humkyiHSL3WfXLhsbvfklQrOow
	 KcXVPyvDJ0+/Z1LC0OeJgfUk3/ckZMHvy6UElOCsef02Po34pxl54aG2/W+qWcMdCC
	 oaPS2zZ+AQV4JUDNJNnQVuSM=
Received: from smtp.mpi-sp.org (localhost [127.0.0.1])
	by smtp.mpi-sp.org (Postfix) with ESMTP id E588F8804A7;
	Thu, 15 Jan 2026 13:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mpi-sp.org; s=202211;
	t=1768481850; bh=syDsAmWtFpOnw0totyvwj9l2H1D3Mm4Syxk6/yuEH7M=;
	h=Date:From:To:Cc:Subject:From;
	b=0P4f6teva0rKVeWVAw4n6uU92sMspHuFVxhzDetrYTrUmw5U7Tg35YH09bMsX1uhl
	 up2bPig7YRDu8OU9Xw48L1aLBdSwd2AufgoVZAkntYR5Hm2klhdBEd6E95Gnt40a7E
	 T4FxSnLWR87H3W/sAwLNIq7jsjVC95clb0PP/CSIpqwk5LSgHS/pk93omsiGgislhK
	 gq4ssVnBK/6NK9rsalldVrRCfoF9g85J81s/mM/29hJ/pVTe+xna0l24v8zn0dbtnB
	 K0RPDPE4xtctoljUsvfLFniVPv0C8CXuTIGCxPoUUtdmCNSthhRCZZ32nm9PQPvQec
	 ZLwbXQCA6mKKkStyYp2QwDZXOINO6loTt9+MBwwKEKTP/vrz/Su0cftZyJExzY1q0g
	 le4Fd8CMEdp0Vkm1Yym00wFitYWLBlZ0E+1Wnp6meOM1K15tIZr/Yfa8f5G/TnvlFJ
	 bGj7BcY+SFPZrUoUXLUO14ecIMg90NpdwmRQ7ogHtKB9Oyhj374F3rxfkF5t1DyB4z
	 oM54qqyWAYWgtkvxc6Czf1xxw7bCCekG2i8CqQQvTRANtemgi9W120fIVeL4v2rqpX
	 BbfcD9s8LRNSVQFwu4nh2z9lWM2BOAzjse8YdZgq9uxB5MVuu2+gsajmiN9cs6hJSR
	 OXPYP9j5grkauuhUuWcC90Bo=
Received: from imap.mpi-sp.org (imap.mpi-sp.org [10.100.1.36])
	by smtp.mpi-sp.org (Postfix) with ESMTPSA id 9FFFF880445;
	Thu, 15 Jan 2026 13:57:30 +0100 (CET)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 13:57:30 +0100
From: "syeda-mahnur.asif" <syeda-mahnur.asif@mpi-sp.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net
Subject: Verifier misses infinite loop
Message-ID: <e9e34c47d9668990e0b11fa17a1ab758@mpi-sp.org>
X-Sender: syeda-mahnur.asif@mpi-sp.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi,

In kernel 6.12.63, the eBPF verifier allows an infinite loop, comprised 
of timer callbacks.
This can in return stall the kernel if the bpf program is attached to 
something like irq_exit_rcu.

Example program:

-----


static int timer_callback(void);
static int timer_callback2(void);

struct elem {
     struct bpf_timer t;
};

struct {
     __uint(type, BPF_MAP_TYPE_ARRAY);
     __uint(max_entries, 100);
     __type(key, int);
     __type(value, struct elem);
} what SEC(".maps");

static int timer_callback() {

     u32 key = 1;
     struct elem *ele = bpf_map_lookup_elem(&what, &key);
     if (ele==NULL)
         return 0;

     struct bpf_timer *timer = &ele->t;
     bpf_timer_set_callback(timer, timer_callback2);
     bpf_timer_start(timer, 0, 0);
     return 0;

}

static int timer_callback2() {

     u32 key = 1;
     struct elem *ele = bpf_map_lookup_elem(&what, &key);
     if (ele==NULL)
         return 0;

     struct bpf_timer *timer = &ele->t;
     bpf_timer_set_callback(timer, timer_callback);
     bpf_timer_start(timer, 0, 0);

     return 0;
}


SEC("fentry/irq_exit_rcu")
int bpf_prog(void *ctx){

     u32 key = 1;
     struct elem *init;

     bpf_map_update_elem(&what, &key, &init, BPF_ANY);

     struct elem *ele = bpf_map_lookup_elem(&what, &key);
     if (ele==NULL)
         return 0;

     struct bpf_timer *timer = &ele->t;
     bpf_timer_init(timer, &what, 0);
     bpf_timer_set_callback(&ele->t, timer_callback);
     bpf_timer_start(timer, 0, 0);

     return 0;
}

char _license[] SEC("license") = "GPL";


----

