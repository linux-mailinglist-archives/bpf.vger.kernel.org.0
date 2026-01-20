Return-Path: <bpf+bounces-79542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD16D3BD6C
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 03:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51A77303D6A4
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCDA258CD0;
	Tue, 20 Jan 2026 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNIyPl4R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01109244665
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874992; cv=pass; b=aWPWWiXulEJ1M3MLqndRCwUInfHoxVMbkkBXnhUCjLhknsn9mf+CAsxVw0lFasJg1Aizy1YLzRWDm9JDt7qmEg7AtB16sh8AoZJyqA3URRoR3RWRoehF/L/NQ3i0/4QzZKWi+GY9AKnL1jMPzN4bka+9TZnJ+Cd8Y6LIAT9tjdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874992; c=relaxed/simple;
	bh=Sx+TNnDKejFoNyVz/tHZhvmoIlr6m6g7EeKy3PMViwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnLTLHCfs4YN533e3wQS+q9tMNHiudUejdxDYHpfGLjqfLRD9wdt4vR/gDj0iKMv6fmZldJFeDrMZxUj/2wyiyDa5l0gTEJHiL073sa7czBJANMO/FNy2xDGJWb8XMJ5LJ8g1xCVqxQ323tnxG0WggDCu2w9UNzm1/cWJlSdknE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNIyPl4R; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so45507335e9.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 18:09:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768874989; cv=none;
        d=google.com; s=arc-20240605;
        b=GHJKImfIEy3I0Ie4HIVRzBKFqC2bCBb2JLALR1d0aLYGehfKVkwh5C3J8UPaqBu1hV
         hWkyOp7wqFZvzYL+vtP1Vhq4MsxpMNSTiooq+Iq826esalBYWSgq1saSJQIGjIlMPQDv
         Ji3chV8GfUlL1pUjEyT8+EMFpAbjmJq9VCOVieu9sPTuHJWjqdpzIgnkC4pE7aj48KKv
         8Vy6fhZ9xO13CJk8kM7+vfeCfAKMqslOVy2FqtVPD3DFVzmWYY68xv3fhve7m+H+h6kl
         XUXIS44OTkjIsePLwAcLk/jbvzUSznWPKnA31s+0KE1PEKNkS10nfDyWwvOPSZpV1Xde
         GwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AgDdtQ/zCcydIiPDBaQVxX6r4MYupVBp9oagp8PAfZ0=;
        fh=NRzxctIsfcnIn7lRXmK/EiaawZyo9lt/dz5Vvh41KkA=;
        b=bSC39R6zBNijOKiMefnLgggAqH/xgNuLrQz0SA+Orb5DrQ+4XIdsQO2n6KGHmkA8Fc
         r/X9Me1qTjxPYqMSLd/UIY6YwmtrEO5h+cHT2XjIMPpGONc/sJDD7Fu7QjXX5RHzyj4U
         VxMvDU0DNIjfARnbgTL47HnNMXus1Brd/RvQmFBmDtRAeBV818wEk8Y3MoO8dbBIEFFb
         2TD3ZM+UqbdbCGCIHsETwv9kAPdfLL+2JuDY1ue4/I2bZW9G1YHPHO63IB4ySvGO8KAQ
         0UrbLqlmp1z2HUNckQiYUw7zHvupy05PuAoCeqeisM8Q9Q7Lrxs5b8fgAx+3tuvYuNcF
         3i5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874989; x=1769479789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgDdtQ/zCcydIiPDBaQVxX6r4MYupVBp9oagp8PAfZ0=;
        b=DNIyPl4RW+97Mx3IWaLENCQG+KcG9YEgQ5OSN2CGwJoBrZJ0vwq4+7CqdK3zu/rDEi
         iaWRBqLR3kHZMGM0pwVuBR9l9A4Ia5StaCwBAWGHbzqI4qCvlgAISPeVS41kM4l+RZ1e
         Zv3NxNWQm8Q7reNITv/7NanSIsfxht8uUU0vHNMBcwQ55DCHkDy3rsmeQDWPuCrWdolF
         fc/AII93rBNcAbH7OIAzs2kv8a83/mkzZQovQdHvKE5TVgAHxGXdtTahRVGTvYy4K2Vy
         FpN0DVudQ/JggeSs4xKhCxdf3+sjppduwakyYKemP83X5u7nW/0eXfLdOd0fPMyWAP+E
         8EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874989; x=1769479789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AgDdtQ/zCcydIiPDBaQVxX6r4MYupVBp9oagp8PAfZ0=;
        b=ein0d0ylL/Vk5nt3h01y3VcfW6MJ6qv6yos8Ca9fm9UyCs56HST9j8arkzQxGgv4M8
         gFYxRNMfQmoK6pXap6P3yFKnbdDLjgPuG7qiqNdfOgcT4H976g+WRKa21uFvuehXvAjt
         tg82Qlpz9DNFrWIYHYyQz7KxSdXphyFPkTA592RFxY5r9OOXFQDRI17RCyfC/ShCMmvd
         GufRYT39fTD9j6yPARCoEjxWwoDSEo3Qdyor7WJXvvVdxNYqxKyaHB3L3pE6q+c0waxY
         X9slxb68sZ2vjSc86pQf/WYME8dlyjoix6bEeDqqtsdikDHFGiHjM+OH/pPD7AUTf467
         yahg==
X-Forwarded-Encrypted: i=1; AJvYcCWcUV2t0q3e74XrlgRV+GjFZpRoEoXNihViHJVDX1FWriNCAjHKqdP8LBVI5rsqQ1LEVrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYQFs6UdkF3wyYqZg4ac04fYzAdbrNjn0G9qc8ZrhcueYvSSv
	fx29aHU+azj7kPFAHANZUU1heX5xozPxe/p171gJqtzeKPkOz+cNiOgGP1wRWshJkuqv9d7xtTa
	1QVq/1fpm5BrmqVvc8CE1S/CH2xGTsOA=
X-Gm-Gg: AY/fxX6OgQ6UKsXjjKamO3Zwiy+PMtAhJp5M4PI89sA+9+H4F24VVUkQO+SNLXj4pXj
	YKQJ414QwqH6zpykJXFhlZAHWScpYJOjfPd7OVxAliwCG/qFArF93dQ+CuuIjJm+WOt7+IhThGQ
	r7ohceoTsl8jwjty7w4bNBeQARpwHN1N/qTcDVVdnhixjHw85YtJVRM8faxSag1vFI6w7gNSuaW
	sSRMWkZHMc7vGJJIpHZeXP3LzfTMeRqMtqZTzdwvNtnDNg+SreAqiBLocdpOwzbjuGHffgxfCeK
	wTjDliPOKJchniPOlMU44AX+2LciM9Aj8wJ5SVUbPOrb7J6E13G4qfvUtH8Ih6xfL0zOGoI5FIl
	FmqqMTUibYV2AeQ==
X-Received: by 2002:a05:600c:4e15:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-4803e8020fdmr2556245e9.36.1768874989264; Mon, 19 Jan 2026
 18:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f43e25d4f86cf567e06141f0408b0c4c169bd7ed.camel@gmail.com> <20260120015616.69224-1-realwujing@gmail.com>
In-Reply-To: <20260120015616.69224-1-realwujing@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 19 Jan 2026 18:09:37 -0800
X-Gm-Features: AZwV_Qjl3FiwPlByr5vRijLEICLGgKkMMNxOVRLj-ZyITJ1CbWt8eYZqQdK4BVQ
Message-ID: <CAADnVQKkDCNB5xk-gnUWXJ44LqG0gRaHfE5WjbAwZL-vnV+6oA@mail.gmail.com>
Subject: Re: [PATCH v3] bpf/verifier: optimize ID mapping reset in states_equal
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, yuanql9@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com>=
 wrote:
>
> The verifier uses an ID mapping table (struct bpf_idmap) during state
> equivalence checks. Currently, reset_idmap_scratch performs a full memset
> on the entire map (~4.7KB) in every call to states_equal.
>
> This ensures that reset overhead is minimal and the search loop is
> bounded by the number of IDs actually encountered in the current
> equivalence check.
>
> Benchmark results (system-wide 'perf stat' during high-concurrency 'veris=
tat'
> stress test, 60s):
>
> The following results, captured using perf while running veristat in para=
llel
> across all CPU cores, show a significant reduction in instruction overhea=
d
> (~9.3%) and branch executions (~11%), confirming that the O(1) reset logi=
c
> significantly reduces the verifier's workload during state equivalence
> checks.

You were already told by multiple people to stop doing this pointless
stress runs across all cpus.

> Metric          | Baseline      | Patched       | Delta
> ----------------|---------------|---------------|----------
> Iterations      | 5710          | 5731          | +0.37%
> Instructions    | 1.714 T       | 1.555 T       | -9.28%
> Inst/Iter       | 300.2 M       | 271.3 M       | -9.63%
> Cycles          | 1.436 T       | 1.335 T       | -7.03%
> Branches        | 350.4 B       | 311.9 B       | -10.99%
> Migrations      | 25,977        | 23,524        | -9.44%
>
> Test Command:
>   seq 1 2000000 | sudo perf stat -a -- \
>     timeout 60s xargs -P $(nproc) -I {} ./veristat access_map_in_map.bpf.=
o

and you were told to stop using tiny programs that don't exercise the
path you're changing in the patch.

> Detailed Performance Stats:
>
> Baseline:
>  Performance counter stats for 'system wide':
>
>          6,735,538      context-switches                 #   3505.5 cs/se=
c  cs_per_second
>       1,921,431.27 msec cpu-clock                        #     32.0 CPUs =
 CPUs_utilized
>             25,977      cpu-migrations                   #     13.5 migra=
tions/sec  migrations_per_second
>          7,268,841      page-faults                      #   3783.0 fault=
s/sec  page_fault_per_second
>     18,662,357,052      branch-misses                    #      3.9 %  br=
anch_miss_rate         (50.14%)
>    350,411,558,023      branches                         #    182.4 M/sec=
  branch_frequency     (66.85%)
>  1,435,774,261,319      cpu-cycles                       #      0.7 GHz  =
cycles_frequency       (66.95%)
>  1,714,154,229,503      instructions                     #      1.2 instr=
uctions  insn_per_cycle  (66.86%)
>    429,445,480,497      stalled-cycles-frontend          #     0.30 front=
end_cycles_idle        (66.36%)
>
>       60.035899231 seconds time elapsed
>
> Patched:
>  Performance counter stats for 'system wide':
>
>          6,662,371      context-switches                 #   3467.3 cs/se=
c  cs_per_second
>       1,921,497.78 msec cpu-clock                        #     32.0 CPUs =
 CPUs_utilized
>             23,524      cpu-migrations                   #     12.2 migra=
tions/sec  migrations_per_second
>          7,783,064      page-faults                      #   4050.5 fault=
s/sec  page_faults_per_second
>     18,181,655,163      branch-misses                    #      4.3 %  br=
anch_miss_rate         (50.15%)
>    311,865,239,743      branches                         #    162.3 M/sec=
  branch_frequency     (66.86%)
>  1,334,859,779,821      cpu-cycles                       #      0.7 GHz  =
cycles_frequency       (66.96%)
>  1,555,086,465,845      instructions                     #      1.2 instr=
uctions  insn_per_cycle  (66.87%)
>    407,666,712,045      stalled-cycles-frontend          #     0.31 front=
end_cycles_idle        (66.35%)
>
>       60.034702643 seconds time elapsed
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
> v3:
>  - Remove Suggested-by tags per Eduard's feedback.
>  - Add Eduard's Acked-by.
>  - Credit Andrii Nakryiko for the further optimization suggestion.
>  - Mention the limitation of system-wide profiling in commit message.

Do not add "educational" information to the commit log.
The commit should describe why and what is being done and the result.
If you cannot observe the difference before/after, then don't say anything.

"significantly reduces the verifier's workload" is not true.
You were not able to measure it. Don't invent gains.

pw-bot: cr

