Return-Path: <bpf+bounces-78979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277DD224A5
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 04:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB1930693EC
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 03:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D19286416;
	Thu, 15 Jan 2026 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="sTvJCCm6"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770233993;
	Thu, 15 Jan 2026 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768447420; cv=none; b=P0nDO8h/EidFxhm5Xy6C9fbQBkE7ZAPFyyY47utkh+SOuP421rPTj4su5cw84kSQz2CySkg5zAF27inNt+omHHqSV0KigPJy8zig71jjkT9SvKx2bM1blg1ZzNX5x1V3S3ozESgMkFbuuGjAFslzE1AALAvGhEnvUKWvFvEdmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768447420; c=relaxed/simple;
	bh=bsOGvDo5/5azE5onitQOpiZZcCYnijJVqSM8hCw9ycE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lDdY70jWlsvjNahzNBjx0b/HwZxoRLONYds+RE6hBcGQx7NtmuBlPHOaltNQ9Gv4cmiYDdEKcFVmr825u4gQ2ucFbdgywrKbz2ygOfkteDie2XkBq0DHqTu+kGEmnVV/BLdIXYm/X/L8LKK4h3xNFtq7DI3vW9plpta+8b4TexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=sTvJCCm6; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768447404; bh=a21DOhvJKt/2YLRJJ7o5P0sIiqtpp/UNSt6rpDSiJtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sTvJCCm6Q5IjbbNDaBGOrFWV5DRW16RNoMCbsiDqAvLU+5JohJRSfTOs4JjwWGrCZ
	 RiGQS207eU3qbjOFiSYvwdBPK1fHvjNvNc2/Idn6BYvKu7f1/fsZropb8flnLGuq1P
	 OLWucC2Fl1P+KSNMiCjhdDzHbAcWitu9N0Vor6kU=
Received: from localhost.localdomain ([61.144.110.213])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 4FA3BC56; Thu, 15 Jan 2026 11:19:58 +0800
X-QQ-mid: xmsmtpt1768447198tewlcucmb
Message-ID: <tencent_9C541313B9B3C381AB950BC531F6C627ED05@qq.com>
X-QQ-XMAILINFO: Nr4sKL92GIu+jwNRc29xx2vpAgNWwpwtR05DgQ1Kpk7VB0Iasgyrgb9pC/DRfl
	 LznNDbRa8TcQ5x9SjCXk/jFI6OOJrp7fShm4asbdXVAHrfiOS/t4+L3Ku+SWeXoh+6uheELWTEIq
	 InK0jYPTU8quw+We2gBh96I97OYRqITNHD16WZlrpgYFsvIW6jzmCaKMB8BahDrb1RM4mUlHSyQA
	 jA19nAmM1pIWZIo1XAAatfLY3Kuq0lfE5OUijzZ42XBPZezloQ90bTRkXedCqCZGNL5ggBfaTFdL
	 JI0Twa9KPCu4jP4jOM8JttSoE7Asl60pznRrH2znsYFi2NMtIRgQrTjZ+Hx8BbaR1dRC3dvBprWN
	 JURBuQzmM3OR0Uep1uDPa/K4rg1aeKaPxNfYGUjJoZ8pC+Rii49oE2oB1HVb1XRdmbRjXjtc930c
	 dfJwVLMgKex3E+J6u8e250PQhDPCPeYStc3Lp8iO5KMYfnRKdk/f3zQxVcjVSs4tcxlp8fuKeYsU
	 ClK13dn+GDv5GlqyaO4oKs4+ryDFrQ4fl1zLYLGa/ZYsysJnhpF91n1EPskQQBqnRSmpCV0lTJBg
	 8rWphkr0AX+H17QSMQ3Y3e98NoR5O3WbYt+3HYLPwHyA/Upya9VcP6yjCw9vCV2R5uPKt4aTpSNj
	 6S9186z9x8byS+P1xAoS5WDG5R5du+3tU8qKSf8lHskkFqLvP9BP1HJBH8C5HGHnxx8jphSVYE7w
	 GEiy7ltbQvQFHoJYSHeQZ5iWt0DdJqnXmbA325Yqou9kEg34rTF6yqYVvutDc1DEluz3fjXtaiAe
	 My26tDvVdPj2lAsqEIQyWXereLgo14ye+yK+HEoJ0fG/wU0eUK8sbiGtexEbYxx/WQUso9d09h0K
	 o1VdQZp0AWL9eSxALRbq4/BwPRHsdVyB5w9mmg1PHyjvYnW0B4aNT5Fo5oOWv4cpVBR4e0WqZsAh
	 xvUBiBv3rP/JASB8OSQM4Xob6Grpi0orJamuXkYFnd3U7LUeQuN5O9bQCXJ8Hc69j4yfbZGlrHYp
	 c9iVGma2K0vPtDuxvsXFTVB1E9KtY=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: wujing <realwujing@qq.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: wujing <realwujing@qq.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH bpf-next] bpf/verifier: implement slab cache for verifier state list
Date: Thu, 15 Jan 2026 11:19:56 +0800
X-OQ-MSGID: <20260115031956.305725-1-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAADnVQJqnvr6Rs=0=gaQHWuXF1YE38afM3V6j04Jcetfv1+sEw@mail.gmail.com>
References: <CAADnVQJqnvr6Rs=0=gaQHWuXF1YE38afM3V6j04Jcetfv1+sEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alexei,

On Wed, Jan 14, 2026 at 07:59:44AM -0800, Alexei Starovoitov wrote:
> > ### Interpretation of Results
> > The comparison results clearly demonstrate the performance advantages of the optimization:
>
> This is not your analysis. This is AI generated garbage that you didn't even bother to filter.
> pw-bot: cr

I refute these claims.

1. "This is not your analysis":
The summary was written by me. I manually extracted the key performance gains (e.g., arena_strsearch -47%) from the raw logs to assist the review process.

2. "AI generated garbage":
The data is real. I spent half a day yesterday compiling the kernel and running `veristat` locally. The numbers are authentic measurements from my environment (Debian 6.19.0-rc5+ x86_64).

3. "didn't even bother to filter":
I distinctly filtered the full output to focus on the significant changes. To prove this, I have attached the full raw logs and the complete comparison table below.

Please check the data. It is real.


The numbers are real measurements from my dev environment.

Environment:
Kernel: Debian 6.19.0-rc5+ x86_64
Tools: tools/testing/selftests/bpf/veristat

I ran the following commands manually:

1. Baseline collection:
$ ./veristat -e file,prog,verdict,duration,insns,states,peak_states,mem_peak -o csv arena_strsearch.bpf.o bpf_flow.bpf.o bpf_gotox.bpf.o bpf_loop.bpf.o > baseline_stats.csv

2. Patched kernel collection:
$ ./veristat -e file,prog,verdict,duration,insns,states,peak_states,mem_peak -o csv arena_strsearch.bpf.o bpf_flow.bpf.o bpf_gotox.bpf.o bpf_loop.bpf.o > patched_stats.csv

3. Comparison:
$ ./veristat -C baseline_stats.csv patched_stats.csv

I have appended three sections below to fully document my work:
1. My manual summary of the significant performance improvements (which formed the basis of my previous analysis).
2. The full auto-generated comparison output from veristat.
3. The raw data logs from both runs.

---
1. Manually Summarized Key Improvements
(These are the specific cases where the slab cache optimization showed the most impact)

Program                         Duration (Baseline)  Duration (Patched)  Improvement
------------------------------  -------------------  ------------------  -----------
arena_strsearch                 121 us               64 us               -47.11%
bpf_loop:stack_check            747 us               469 us              -37.22%
bpf_loop:test_prog              519 us               386 us              -25.63%
bpf_loop:prog_null_ctx          202 us               162 us              -19.80%

---
2. Full Comparison Output (veristat -C baseline_stats.csv patched_stats.csv)
File                   Program                         Verdict (A)  Verdict (B)  Verdict (DIFF)  Duration (A) (us)  Duration (B) (us)  Duration (DIFF)      Insns (A)  Insns (B)  Insns (DIFF)  States (A)  States (B)  States (DIFF)  Peak states (A)  Peak states (B)  Peak states (DIFF)
---------------------  ------------------------------  -----------  -----------  --------------  -----------------  -----------------  -------------------  ---------  ---------  ------------  ----------  ----------  -------------  ---------------  ---------------  ------------------
arena_strsearch.bpf.o  arena_strsearch                 failure      failure      MATCH                         121                 64         -57 (-47.11%)         20         20   +0 (+0.00%)           2           2   +0 (+0.00%)                 2                 2          +0 (+0.00%)
bpf_flow.bpf.o         _dissect                        success      success      MATCH                         479                446          -33 (-6.89%)        211        211   +0 (+0.00%)          13          13    +0 (+0.00%)                13                13          +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_0                success      success      MATCH                        2433               2393          -40 (-1.64%)       1461       1461   +0 (+0.00%)          68          68    +0 (+0.00%)                68                68          +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_1                success      success      MATCH                        2727               2717          -10 (-0.37%)       1567       1567   +0 (+0.00%)          59          59    +0 (+0.00%)                59                59          +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_2                success      success      MATCH                        2057               2061           +4 (+0.19%)       1244       1244   +0 (+0.00%)          56          56    +0 (+0.00%)                56                56          +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_3                success      success      MATCH                        2290               2282           -8 (-0.35%)       1498       1498   +0 (+0.00%)          57          57    +0 (+0.00%)                57                57          +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_4                success      success      MATCH                         341                320          -21 (-6.16%)        259        259   +0 (+0.00%)           4           4    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_5                success      success      MATCH                         656                651           -5 (-0.76%)        416        416   +0 (+0.00%)          21          21    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        big_jump_table                  success      success      MATCH                          32                 30           -2 (-6.25%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        one_jump_two_maps               success      success      MATCH                          32                 30           -2 (-6.25%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        one_map_two_jumps               success      success      MATCH                          31                 30           -1 (-3.23%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        one_switch                      success      success      MATCH                          40                 39           -1 (-2.50%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        one_switch_non_zero_sec_off     success      success      MATCH                          32                 33           +1 (+3.12%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        simple_test_other_sec           success      success      MATCH                          32                 34           +2 (+6.25%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        two_switches                    success      success      MATCH                          32                 30           -2 (-6.25%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        use_nonstatic_global1           success      success      MATCH                          30                 34          +4 (+13.33%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        use_nonstatic_global2           success      success      MATCH                          33                 51         +18 (+54.55%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        use_nonstatic_global_other_sec  success      success      MATCH                          31                 32           +1 (+3.23%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        use_static_global1              success      success      MATCH                          31                 30           -1 (-3.23%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        use_static_global2              success      success      MATCH                          32                 31           -1 (-3.12%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_gotox.bpf.o        use_static_global_other_sec     success      success      MATCH                          31                 31           +0 (+0.00%)          2          2   +0 (+0.00%)           0           0    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_loop.bpf.o         prog_invalid_flags              success      success      MATCH                         230                208          -22 (-9.57%)         50         50   +0 (+0.00%)           5           5    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_loop.bpf.o         prog_nested_calls               success      success      MATCH                         546                530          -16 (-2.93%)        145        145   +0 (+0.00%)          19          19    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_loop.bpf.o         prog_non_constant_callback      success      success      MATCH                         203                200           -3 (-1.48%)         41         41   +0 (+0.00%)           5           5    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_loop.bpf.o         prog_null_ctx                   success      success      MATCH                         202                162         -40 (-19.80%)         22         22   +0 (+0.00%)           3           3    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_loop.bpf.o         stack_check                     success      success      MATCH                         747                469        -278 (-37.22%)        325        325   +0 (+0.00%)          25          25    +0 (+0.00%)                 0                 0          +0 (+0.00%)
bpf_loop.bpf.o         test_prog                       success      success      MATCH                         519                386        -133 (-25.63%)         64         64   +0 (+0.00%)           7           7    +0 (+0.00%)                 0                 0          +0 (+0.00%)

---
3. Raw Data: baseline_stats.csv (Unpatched)
file_name,prog_name,verdict,duration,total_insns,total_states,peak_states,mem_peak
arena_strsearch.bpf.o,arena_strsearch,failure,121,20,2,2,0
bpf_flow.bpf.o,_dissect,success,479,211,13,13,0
bpf_flow.bpf.o,flow_dissector_0,success,2433,1461,68,68,0
bpf_flow.bpf.o,flow_dissector_1,success,2727,1567,59,59,0
bpf_flow.bpf.o,flow_dissector_2,success,2057,1244,56,56,0
bpf_flow.bpf.o,flow_dissector_3,success,2290,1498,57,57,0
bpf_flow.bpf.o,flow_dissector_4,success,341,259,4,4,0
bpf_flow.bpf.o,flow_dissector_5,success,656,416,21,21,0
bpf_gotox.bpf.o,big_jump_table,success,32,2,0,0,0
bpf_gotox.bpf.o,one_jump_two_maps,success,32,2,0,0,0
bpf_gotox.bpf.o,one_map_two_jumps,success,31,2,0,0,0
bpf_gotox.bpf.o,one_switch,success,40,2,0,0,0
bpf_gotox.bpf.o,one_switch_non_zero_sec_off,success,32,2,0,0,0
bpf_gotox.bpf.o,simple_test_other_sec,success,32,2,0,0,0
bpf_gotox.bpf.o,two_switches,success,32,2,0,0,0
bpf_gotox.bpf.o,use_nonstatic_global1,success,30,2,0,0,0
bpf_gotox.bpf.o,use_nonstatic_global2,success,33,2,0,0,0
bpf_gotox.bpf.o,use_nonstatic_global_other_sec,success,31,2,0,0,0
bpf_gotox.bpf.o,use_static_global1,success,31,2,0,0,0
bpf_gotox.bpf.o,use_static_global2,success,32,2,0,0,0
bpf_gotox.bpf.o,use_static_global_other_sec,success,31,2,0,0,0
bpf_loop.bpf.o,prog_invalid_flags,success,230,50,5,5,0
bpf_loop.bpf.o,prog_nested_calls,success,546,145,19,19,0
bpf_loop.bpf.o,prog_non_constant_callback,success,203,41,5,5,0
bpf_loop.bpf.o,prog_null_ctx,success,202,22,3,3,0
bpf_loop.bpf.o,stack_check,success,747,325,25,25,0
bpf_loop.bpf.o,test_prog,success,519,64,7,7,0

Raw Data: patched_stats.csv (Patched)
file_name,prog_name,verdict,duration,total_insns,total_states,peak_states,mem_peak
arena_strsearch.bpf.o,arena_strsearch,failure,64,20,2,2,0
bpf_flow.bpf.o,_dissect,success,446,211,13,13,0
bpf_flow.bpf.o,flow_dissector_0,success,2393,1461,68,68,0
bpf_flow.bpf.o,flow_dissector_1,success,2717,1567,59,59,0
bpf_flow.bpf.o,flow_dissector_2,success,2061,1244,56,56,0
bpf_flow.bpf.o,flow_dissector_3,success,2282,1498,57,57,0
bpf_flow.bpf.o,flow_dissector_4,success,320,259,4,4,0
bpf_flow.bpf.o,flow_dissector_5,success,651,416,21,21,0
bpf_gotox.bpf.o,big_jump_table,success,30,2,0,0,0
bpf_gotox.bpf.o,one_jump_two_maps,success,30,2,0,0,0
bpf_gotox.bpf.o,one_map_two_jumps,success,30,2,0,0,0
bpf_gotox.bpf.o,one_switch,success,39,2,0,0,0
bpf_gotox.bpf.o,one_switch_non_zero_sec_off,success,33,2,0,0,0
bpf_gotox.bpf.o,simple_test_other_sec,success,34,2,0,0,0
bpf_gotox.bpf.o,two_switches,success,30,2,0,0,0
bpf_gotox.bpf.o,use_nonstatic_global1,success,34,2,0,0,0
bpf_gotox.bpf.o,use_nonstatic_global2,success,51,2,0,0,0
bpf_gotox.bpf.o,use_nonstatic_global_other_sec,success,32,2,0,0,0
bpf_gotox.bpf.o,use_static_global1,success,30,2,0,0,0
bpf_gotox.bpf.o,use_static_global2,success,31,2,0,0,0
bpf_gotox.bpf.o,use_static_global_other_sec,success,31,2,0,0,0
bpf_loop.bpf.o,prog_invalid_flags,success,208,50,5,5,0
bpf_loop.bpf.o,prog_nested_calls,success,530,145,19,19,0
bpf_loop.bpf.o,prog_non_constant_callback,success,200,41,5,5,0
bpf_loop.bpf.o,prog_null_ctx,success,162,22,3,3,0
bpf_loop.bpf.o,stack_check,success,469,325,25,25,0
bpf_loop.bpf.o,test_prog,success,386,64,7,7,0

Best regards,
wujing


