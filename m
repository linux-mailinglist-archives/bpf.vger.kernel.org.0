Return-Path: <bpf+bounces-26675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402EB8A37BC
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6337A1C21096
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B33C14F112;
	Fri, 12 Apr 2024 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1eszPsr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BD14A89;
	Fri, 12 Apr 2024 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956576; cv=none; b=LOEYa7LYQHhGDmMFHFmswYsMjgsytio+14sITHo38QiKbMTB45mWnf6TUhjy6txeSjO0zk7j6+6Dcdz+eMFjc40U2Ew/o7gg0sM8qKLKBUjGBvMtRozuvtiOWnajG29SWbjSfXswTHoqeE2xUR0EUYnu9i6vQox84ToQWhhdM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956576; c=relaxed/simple;
	bh=yaRjQzEABL8hzuUckBbpGPbH5cBdTm25T5g2Axc+dyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbsR4FpL/BXSO9GQSbLBRhjQV0ivWk4IDte6OVKdW/7XB/rdkZpHy2ngpwQVm28fO/vsGcqFlMsqvjOFC+tlL0vaUti8wAAmq7hrxGdNFpBv/Yta6d3u5CtKVnSKXa2MK9l5Se49IkrGSxlik4M7fe6Hib1FBFeogViXighK8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1eszPsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C9AC113CD;
	Fri, 12 Apr 2024 21:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956576;
	bh=yaRjQzEABL8hzuUckBbpGPbH5cBdTm25T5g2Axc+dyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1eszPsrXGfUe0rQFYcdxXixDZ6/c0NrJoVXabWdBupJftCt0avS/NuJNOwN5Y9cy
	 pvfRk9AbNUujzCftpLNKMosKUGvlhdkKBse0aeV+E/DD7N516odGWRTvtRqow5Jx3S
	 zryXemfp0e/vlnkha9b3qimfb8ig8jGMs9fgjTx28cUDQEDSVAzNw7whxAFp4/YCv9
	 oHG3kcn51VfmvaaCy/Blgwc0gcy3LYMOMULtsH5s72K+k4SpMTRTsQBdS2N3OaX375
	 HKmh7/eqhF/DzXl+lXqfOr7Cp6YNwqqze4wObeYCPZxXncwpEYnCOFFUYua9qOgYBO
	 rvzIxCRuRNrcw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 02/12] pahole: Disable BTF multithreaded encoded when doing reproducible builds
Date: Fri, 12 Apr 2024 18:15:54 -0300
Message-ID: <20240412211604.789632-3-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412211604.789632-1-acme@kernel.org>
References: <20240412211604.789632-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reproducible builds need to produce BTF that have the same ids, which is
not possible at the moment to do in parallel with libbpf, so serialize
the encoding.

The next patches will also make sure that DWARF while being read in
parallel into internal representation for later BTF encoding has its CU
(Compile Units) fed to the BTF encoder in the same order as it is in the
DWARF file, this way we'll produce the same BTF output no matter how
many threads are used to read BTF.

Then we'll make sure we have tests in place that compare the output of
parallel BTF encoding (well, just the DWARF loading part, maybe the BTF
in the future), i.e. when using 'pahole -j' with the one obtained when
doing single threaded encoding.

Testing it on a:

  # grep -m1 "model name" /proc/cpuinfo
  model name	: 13th Gen Intel(R) Core(TM) i7-1365U
  ~#

I.e. 2 performance cores (4 threads) + 8 efficiency cores.

From:

  $ perf stat -r5 pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux

   Performance counter stats for 'pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux' (5 runs):

         17,187.27 msec task-clock:u       #    6.153 CPUs utilized   ( +-  0.34% )
  <SNIP>
            2.7931 +- 0.0336 seconds time elapsed  ( +-  1.20% )

  $

To:

  $ perf stat -r5 pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux

   Performance counter stats for 'pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux' (5 runs):

         14,654.06 msec task-clock:u       #    3.507 CPUs utilized   ( +-  0.45% )
  <SNIP>
            4.1787 +- 0.0344 seconds time elapsed  ( +-  0.82% )

  $

Which is still a nice improvement over doing it completely serially:

  $ perf stat -r5 pahole --btf_encode_detached=vmlinux.btf.serial vmlinux

   Performance counter stats for 'pahole --btf_encode_detached=vmlinux.btf.serial vmlinux' (5 runs):

          7,506.93 msec task-clock:u       #    1.000 CPUs utilized   ( +-  0.13% )
  <SNIP>
            7.5106 +- 0.0115 seconds time elapsed  ( +-  0.15% )

  $

  $ pahole vmlinux.btf.parallel > /tmp/parallel
  $ pahole vmlinux.btf.parallel.reproducible_build > /tmp/parallel.reproducible_build
  $ diff -u /tmp/parallel /tmp/parallel.reproducible_build | wc -l
  269920
  $ pahole --sort vmlinux.btf.parallel > /tmp/parallel.sorted
  $ pahole --sort vmlinux.btf.parallel.reproducible_build > /tmp/parallel.reproducible_build.sorted
  $ diff -u /tmp/parallel.sorted /tmp/parallel.reproducible_build.sorted | wc -l
  0
  $

The BTF ids continue to be undeterministic, as we need to process the
CUs (compile unites) in the same order that they are on vmlinux:

  $ bpftool btf dump file vmlinux.btf.serial > btfdump.serial
  $ bpftool btf dump file vmlinux.btf.parallel.reproducible_build > btfdump.parallel.reproducible_build
  $ bpftool btf dump file vmlinux.btf.parallel > btfdump.parallel
  $ diff -u btfdump.serial btfdump.parallel | wc -l
  624144
  $ diff -u btfdump.serial btfdump.parallel.reproducible_build | wc -l
  594622
  $ diff -u btfdump.parallel.reproducible_build btfdump.parallel | wc -l
  623355
  $

The BTF ids don't match, we'll get them to match at the end of this
patch series:

  $ tail -5 btfdump.serial
  	type_id=127124 offset=219200 size=40 (VAR 'rt6_uncached_list')
  	type_id=11760 offset=221184 size=64 (VAR 'vmw_steal_time')
  	type_id=13533 offset=221248 size=8 (VAR 'kvm_apic_eoi')
  	type_id=13532 offset=221312 size=64 (VAR 'steal_time')
  	type_id=13531 offset=221376 size=68 (VAR 'apf_reason')
  $ tail -5 btfdump.parallel.reproducible_build
  	type_id=113812 offset=219200 size=40 (VAR 'rt6_uncached_list')
  	type_id=87979 offset=221184 size=64 (VAR 'vmw_steal_time')
  	type_id=127391 offset=221248 size=8 (VAR 'kvm_apic_eoi')
  	type_id=127390 offset=221312 size=64 (VAR 'steal_time')
  	type_id=127389 offset=221376 size=68 (VAR 'apf_reason')
  $

Now to make it process the CUs in order, that should get everything
straight without hopefully not degrading it further too much.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/pahole.c b/pahole.c
index 96e153432fa212a5..fcb4360f11debeb9 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3173,6 +3173,14 @@ struct thread_data {
 	struct btf_encoder *encoder;
 };
 
+static int pahole_threads_prepare_reproducible_build(struct conf_load *conf, int nr_threads, void **thr_data)
+{
+	for (int i = 0; i < nr_threads; i++)
+		thr_data[i] = NULL;
+
+	return 0;
+}
+
 static int pahole_threads_prepare(struct conf_load *conf, int nr_threads, void **thr_data)
 {
 	int i;
@@ -3283,7 +3291,10 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 				thread->btf = btf_encoder__btf(btf_encoder);
 			}
 		}
-		pthread_mutex_unlock(&btf_lock);
+
+		// Reproducible builds don't have multiple btf_encoders, so we need to keep the lock until we encode BTF for this CU.
+		if (thr_data)
+			pthread_mutex_unlock(&btf_lock);
 
 		if (!btf_encoder) {
 			ret = LSK__STOP_LOADING;
@@ -3319,6 +3330,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			exit(1);
 		}
 out_btf:
+		if (!thr_data) // See comment about reproducibe_build above
+			pthread_mutex_unlock(&btf_lock);
 		return ret;
 	}
 #if 0
@@ -3689,8 +3702,14 @@ int main(int argc, char *argv[])
 
 	conf_load.steal = pahole_stealer;
 	conf_load.thread_exit = pahole_thread_exit;
-	conf_load.threads_prepare = pahole_threads_prepare;
-	conf_load.threads_collect = pahole_threads_collect;
+
+	if (conf_load.reproducible_build) {
+		conf_load.threads_prepare = pahole_threads_prepare_reproducible_build;
+		conf_load.threads_collect = NULL;
+	} else {
+		conf_load.threads_prepare = pahole_threads_prepare;
+		conf_load.threads_collect = pahole_threads_collect;
+	}
 
 	// Make 'pahole --header type < file' a shorter form of 'pahole -C type --count 1 < file'
 	if (conf.header_type && !class_name && prettify_input) {
-- 
2.44.0


