Return-Path: <bpf+bounces-79477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC95D3B603
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D18BB305F814
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F0D38E135;
	Mon, 19 Jan 2026 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFudIzvv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA938BDB3
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848222; cv=none; b=G2yVUOBaOSYIFt4tIx5HN1AawznWFnyDULCHAvNN2WAKFBA5ZoIPWieCisYuZJwAVJmN7sK/T9LNSEYyRuP4wwqyxUp9pnsDZ/n/ITuAjdMe8924rwYuiUaYAhp1celi2/eGoT/I3eFwzlwjBkEirueGfwS0+22zlFtXkRLDjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848222; c=relaxed/simple;
	bh=rrMvrWdYKAI+m6MARZvV3c0GragGaZJHWz5pqVajfjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CJa/MWIvgkzk8I7+V6UTizwcgRr2/VLmvMfABqPdW6xZCQvBrQyXy30q5ydjVKqqaTwxTMy/06RAROmD6CMkROGemMFYG67+tzfsQjJDvjkJO/jftvIsRSF3X7Lxr6amBlRJuxkEu5XczEbUk3zC2Ibelihpch/TGAuGX/HYMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFudIzvv; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so8064279eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768848220; x=1769453020; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3OHeSX7usNST+oUmdkhhpslnqDWteRbjvdPSeCpUyOc=;
        b=KFudIzvvl/m+g0iGfwyhAd+cZq82E/FeaTiG+uKYOe7QJ1RsRLIU39b1tT085F24ey
         tpSxSTzNaMk/Xa0CIo++niVk4LrOzB/M9ViIY6cFfoNTXTwrdAIG85GtpfShGkwwjuTj
         iyVRD086j2p2q41O81J4PcRReIxMXYWHIWZfNnvbgk184NnNRM8OIcSISLU7bG/ctVWJ
         pKxwCOHWCwcqQgftolSeSaTR+7BQa96WgoRZYYztvtMwmZJh6Kd1WYIOlJtGqK+BmuvY
         USfJMXHWbWoAvdeLWKeDbBaKjLV+YmRj/hNQ52Ny29DGW8Q23PfxCiaz9b571Q8E8EQV
         lL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768848220; x=1769453020;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OHeSX7usNST+oUmdkhhpslnqDWteRbjvdPSeCpUyOc=;
        b=CKuibIayGgmJ+mjDNmja9pmnUK/2ozHHbERZeTqlwhH0Mum7TbhyhNuOHSLXLIArm3
         dMyl8ooSkzoE9wdgnbeVHCfregifWz7Hl+mjsU7yz83GN4Q4j2saih7YC+zs4Qa5aGHh
         G6exWmrC8P7OO9nQzEg34NtPC+18pFszFvcTcrT5MLb0vVFsVKr61DN1cjkWnZImXahL
         zfmoxULtuBOcbSKEiPiQkMCuHp8HkSa2OriVZBVflkS/egippyPQddbbzqh2ea0KBk8d
         HEF1DqrES+DlnmrhSjcsawRaL5ZLR/owreXOW95LZQAKN9+7OaNo+mzOY7SupRnwk9p3
         1Djw==
X-Forwarded-Encrypted: i=1; AJvYcCXDs7UAZ4BA9pg9w1XLIYJsshCqIWiTk/RL+2xAtkKnM4D9+BTQMcTtt0199kwrpVUJBN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpknlrQ1jnyfP6OxP9QCernFT8CIUwVEOt8kufURWXNkKWTL8r
	l6gI9tqbzt1hjKnTEnL9tfeXO11ouJSKwiuvQ2bsxLpjShUHALvMnFzk
X-Gm-Gg: AZuq6aLw96afmIoDHNromNSrAJXtdCPhlBIsLNEUJNzEaQYEgz/tAgFO1xOW7QPesE0
	66VBP3HvCVb3iHM9PMyI6nJZV6GiRjGQpi22jhyyG7l9/STZy8oORtFsa/LtihkzlA2z5kBneSh
	LnjusZ9MKPB7USurypDStN3TZ0eCO6vqF1Q5IXsOlgd1h3HGnCSVJvteLn9WWUdDnVU5UvijGuS
	mmN0j+LNt4KnTNLkcA1VK3pb8NpcNIMO6jDAylEtzHKx/jfQnQ69rUJctk+5DH0nldatHy5WRXV
	1ogiD7/02Y2joigFy8Edsrdd6jc6o1gr2LeWxbpwVBj65HcUcmeaS/VW50Od6PmSvWjvnYiFCqO
	9T3xP6pepLMQi1tAqwEUkEWHclXIloQ8JgxPLSnyIQ/DtDt7CRZcfAt3yCrExeQ+bpWkAV8sAVm
	6ybHpR4wvPZ7bqQfMq/IDL5B4h/pdDDmvcnd8dYVaFc0Jma0ttvvgd0KPrQ6D3gbL5yg==
X-Received: by 2002:a05:7301:6508:b0:2b6:aeb8:3d8c with SMTP id 5a478bee46e88-2b6b503bcb5mr9877469eec.32.1768848220046;
        Mon, 19 Jan 2026 10:43:40 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm13727628eec.8.2026.01.19.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:43:39 -0800 (PST)
Message-ID: <a714ee96d0ad96bbc9d51037616e5c4e2790a8ec.camel@gmail.com>
Subject: Re: [PATCH v3] bpf/verifier: optimize precision backtracking by
 skipping precise bits
From: Eduard Zingerman <eddyz87@gmail.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, jolsa@kernel.org,
 kpsingh@kernel.org, 	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, 	song@kernel.org, yonghong.song@linux.dev,
 yuanql9@chinatelecom.cn
Date: Mon, 19 Jan 2026 10:43:37 -0800
In-Reply-To: <20260117100922.38459-1-realwujing@gmail.com>
References: <aa4cc54a3a0796b16d2d5e13142d104fa5a483e1.camel@gmail.com>
	 <20260117100922.38459-1-realwujing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-01-17 at 18:09 +0800, Qiliang Yuan wrote:

Hi Qiliang,

> 2. System-wide saturation profiling (32 cores):
>    # Start perf in background
>    sudo perf stat -a -- sleep 60 &
>    # Start 32 parallel loops of veristat
>    for i in {1..32}; do (while true; do ./veristat backtrack_stress.bpf.o=
 > /dev/null; done &); done

I'm not sure system-wide testing is helpful in this context.
I'd suggest collecting stats for a single process, e.g. as follows:

  perf stat -B --all-kernel -r10 -- ./veristat -q pyperf180.bpf.o

(Note: pyperf180 is a reasonably complex test for many purposes).
And then collecting profiling data:

  perf record -o <somewhere-where-mmap-is-possible> \
              --all-kernel --call-graph=3Ddwarf --vmlinux=3D<path-to-vmlinu=
x> \
	      -- ./veristat -q pyperf180.bpf.o

And then inspecting the profiling data using `perf report`.
What I see in stats corroborates with Yonghong's findings:

  W/o the patch:
            ...
          22293282      branch-misses                    #      2.8 %  bran=
ch_miss_rate         ( +-  1.25% )  (50.10%)
         594485451      branches                         #   1012.5 M/sec  =
branch_frequency     ( +-  1.68% )  (66.67%)
        1544503960      cpu-cycles                       #      2.6 GHz  cy=
cles_frequency       ( +-  0.18% )  (67.02%)
        3305212994      instructions                     #      2.1 instruc=
tions  insn_per_cycle  ( +-  2.04% )  (67.11%)
         587496908      stalled-cycles-frontend          #     0.38 fronten=
d_cycles_idle        ( +-  1.21% )  (66.39%)

           0.60033 +- 0.00173 seconds time elapsed  ( +-  0.29% )

  With the patch
            ...
          22397789      branch-misses                    #      2.8 %  bran=
ch_miss_rate         ( +-  1.27% )  (50.37%)
         596289399      branches                         #   1004.8 M/sec  =
branch_frequency     ( +-  1.59% )  (66.95%)
        1546060617      cpu-cycles                       #      2.6 GHz  cy=
cles_frequency       ( +-  0.16% )  (66.67%)
        3325745352      instructions                     #      2.2 instruc=
tions  insn_per_cycle  ( +-  1.76% )  (66.61%)
         588040713      stalled-cycles-frontend          #     0.38 fronten=
d_cycles_idle        ( +-  1.23% )  (66.48%)

           0.60697 +- 0.00201 seconds time elapsed  ( +-  0.33% )

So, I'd suggest shelving this change for now.

If you take a look at the profiling data, you'd notice that low
hanging fruit is actually improving bpf_patch_insn_data(),
It takes ~40% of time, at-least for this program.
This was actually discussed a very long time ago [1].
If you are interested in speeding up verifier,
maybe consider taking a look?

Best regards,
Eduard Zingerman.

[1] https://lore.kernel.org/bpf/CAEf4BzY_E8MSL4mD0UPuuiDcbJhh9e2xQo2=3D5w+p=
pRWWiYSGvQ@mail.gmail.com/

