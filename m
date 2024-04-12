Return-Path: <bpf+bounces-26684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD28A37C5
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA141C22196
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C5152165;
	Fri, 12 Apr 2024 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHyVQGdT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F014F122;
	Fri, 12 Apr 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956600; cv=none; b=S99027MER9nXUJPD238TnEF0e0woiq1PzqD0dZCP9qUo+QLWeaN1/iXvp520v0SU13K6uo1IRB9RwGTQ8V22ya32segEkASITENxl01vT0FNDYxrDwpsnCHCOhtZJedZDDLTUhoirkuKtwAg770JLkfKoL4470eRTGH04uho0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956600; c=relaxed/simple;
	bh=kKKif1xaBzPgA2Szp0+V+qy95KK7R3ordtjd7Jihqzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4FzO6a6s7unntp1w4ALPpXorqRtgSQ6gQnmrsqFnQdKHoKhiuXCm5L1pOw47aDNh5Oi5LrcERQo5j31lRhcASSMTgZwU65qOqmPsI+UOO0l/YuKP4kqBB8R7+J3huuViRrG74rthH6PTFVLLqf7AqFi+ysUxo7OxGx5XtcsmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHyVQGdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618A2C2BD11;
	Fri, 12 Apr 2024 21:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956599;
	bh=kKKif1xaBzPgA2Szp0+V+qy95KK7R3ordtjd7Jihqzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHyVQGdTTzMySPj0/QfcdVjtg2F5kOg/Neey5A98NKb0OTdXZvlpxOEnS74sN6iZO
	 XcrM8E2tI2zSVWAMDOTvx3Ud2S+58FuD+75eoO4WpDZ808ZA69ZZjnOSB4h9eDGA95
	 wa6YhJIHvhZoKaSlRu0nE38+sKdim9LB/IBBRTcCp/mk+bM+0Y2wo1ZWNFEpHEQt6u
	 hFTW/UKu4wseuSMTSgTc6LFta+2Cfsf73IVo5dlDcrULwG4gBTVQp2n9RSc2hOjsHA
	 OUA3r10tqUbsuDl7PIDHYR3QIy3TN/iy3RSs3gE1k80ZKkjjW0CEp7ZgfrTbMxf29W
	 eae8DJvp/8n7Q==
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
Subject: [PATCH 11/12] pahole: Encode BTF serially in a reproducible build
Date: Fri, 12 Apr 2024 18:16:03 -0300
Message-ID: <20240412211604.789632-12-acme@kernel.org>
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

Now we will ask the cus instance for the next processable CU, i.e. one
that is loaded and is in the same CU order as in the original DWARF
file, under the BTF lock.

With this we can go on loading the DWARF file in parallel and only
serialize the BTF encoding, keeping that order, with this the BTF ids
end up the same both for a serial encoding:

And here are some numbers with a Release build:

  $ cat buildcmd.sh
  mkdir build
  cd build
  cmake -DCMAKE_BUILD_TYPE=Release ..
  cd ..
  make -j $(getconf _NPROCESSORS_ONLN) -C build
  $ rm -rf build
  $ ./buildcmd.sh

Its an Intel Hybrid system, and migrates to/from efficiency/perfomance
cores:

  $ getconf _NPROCESSORS_ONLN
  28
  $ grep -m1 'model name' /proc/cpuinfo
  model name	: Intel(R) Core(TM) i7-14700K
  $

8 performance cores (16 threads), 12 efficiency cores.

Serial encoding:

  $ time perf stat -e cycles -r5 pahole --btf_encode_detached=vmlinux.btf.serial vmlinux

   Performance counter stats for 'pahole --btf_encode_detached=vmlinux.btf.serial vmlinux' (5 runs):

      13,313,169,305      cpu_atom/cycles:u/     ( +- 30.61% )  (0.00%)
      27,985,776,096      cpu_core/cycles:u/     ( +-  0.17% )  (100.00%)

             5.18276 +- 0.00952 seconds time elapsed  ( +-  0.18% )

  real	0m25.937s
  user	0m25.337s
  sys	0m0.533s
  $

Parallel, but non-reproducible:

  $ time perf stat -e cycles -r5 pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux

   Performance counter stats for 'pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux' (5 runs):

      73,112,892,822      cpu_atom/cycles:u/     ( +-  0.60% )  (43.16%)
      99,124,802,605      cpu_core/cycles:u/     ( +-  0.72% )  (59.01%)

              1.9501 +- 0.0111 seconds time elapsed  ( +-  0.57% )

  real	0m9.778s
  user	1m30.700s
  sys	0m13.114s
  $

Now what we want, a reproducible build done using parallel DWARF loading
+ CUs-ordered-as-in-vmlinux serial BTF encoding:

  $ time perf stat -e cycles -r5 pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible vmlinux

   Performance counter stats for 'pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible vmlinux' (5 runs):

      21,263,444,208      cpu_atom/cycles:u/     ( +-  1.95% )  (29.18%)
      35,881,074,547      cpu_core/cycles:u/     ( +-  0.64% )  (75.60%)

              2.5354 +- 0.0221 seconds time elapsed  ( +-  0.87% )

  real	0m12.709s
  user	0m35.001s
  sys	0m9.017s
  $

Fastest is off course the unreproducible, fully parallel DWARF loading/
BTF encoding at 1.9501 +- 0.0111 seconds, but doing a reproducible build
in 2.5354 +- 0.0221 seconds is better than completely disabling -j/full
serial at 5.18276 +- 0.00952 seconds.

Comparing the BTF generated:

  $ bpftool btf dump file vmlinux.btf.serial > output.vmlinux.btf.serial
  $ bpftool btf dump file vmlinux.btf.parallel > output.vmlinux.btf.parallel
  $ bpftool btf dump file vmlinux.btf.parallel.reproducible > output.vmlinux.btf.parallel.reproducible

  $ wc -l output.vmlinux.btf.serial output.vmlinux.btf.parallel output.vmlinux.btf.parallel.reproducible
    313404 output.vmlinux.btf.serial
    314345 output.vmlinux.btf.parallel
    313404 output.vmlinux.btf.parallel.reproducible
    941153 total
  $

Non reproducible parallel BTF encoding:

  $ diff -u output.vmlinux.btf.serial output.vmlinux.btf.parallel | head
  --- output.vmlinux.btf.serial	2024-04-02 11:11:56.665027947 -0300
  +++ output.vmlinux.btf.parallel	2024-04-02 11:12:38.490895460 -0300
  @@ -1,1708 +1,2553 @@
   [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
  -[2] CONST '(anon)' type_id=1
  -[3] VOLATILE '(anon)' type_id=2
  -[4] ARRAY '(anon)' type_id=1 index_type_id=21 nr_elems=2
  -[5] PTR '(anon)' type_id=8
  -[6] CONST '(anon)' type_id=5
  -[7] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
  $

Reproducible:

  $ diff -u output.vmlinux.btf.serial output.vmlinux.btf.parallel.reproducible
  $

And using a test script that I'll add to a nascent repository of
regression tests:

  $ time tests/reproducible_build.sh vmlinux
  Parallel reproducible DWARF Loading/Serial BTF encoding: Ok

  real	1m13.844s
  user	3m3.601s
  sys	0m9.049s
  $

If the number of threads started by pahole is different than what was
requests via its -j command line option, it will fail as well as if the
output of 'bpftool btf dump' differs from the BTF encoded totally
serially to one of the detached BTF encoded using reproducible DWARF
loading/BTF encoding.

In verbose mode:

  $ time VERBOSE=1 tests/reproducible_build.sh vmlinux
  Parallel reproducible DWARF Loading/Serial BTF encoding:
  serial encoding...
  1 threads encoding
  1 threads started
  diff from serial encoding:
  -----------------------------
  2 threads encoding
  2 threads started
  diff from serial encoding:
  -----------------------------
  3 threads encoding
  3 threads started
  diff from serial encoding:
  -----------------------------
  4 threads encoding
  4 threads started
  diff from serial encoding:
  -----------------------------
  5 threads encoding
  5 threads started
  diff from serial encoding:
  -----------------------------
  6 threads encoding
  6 threads started
   diff from serial encoding:
  -----------------------------
  7 threads encoding
  7 threads started
  diff from serial encoding:
  -----------------------------
  8 threads encoding
  8 threads started
  diff from serial encoding:
  -----------------------------
  9 threads encoding
  9 threads started
  diff from serial encoding:
  -----------------------------
  10 threads encoding
  10 threads started
  diff from serial encoding:
  -----------------------------
  11 threads encoding
  11 threads started
  diff from serial encoding:
  -----------------------------
  12 threads encoding
  12 threads started
  diff from serial encoding:
  -----------------------------
  13 threads encoding
  13 threads started
  diff from serial encoding:
  -----------------------------
  14 threads encoding
  14 threads started
  diff from serial encoding:
  -----------------------------
  15 threads encoding
  15 threads started
  diff from serial encoding:
  -----------------------------
  16 threads encoding
  16 threads started
  diff from serial encoding:
  -----------------------------
  17 threads encoding
  17 threads started
  diff from serial encoding:
  -----------------------------
  18 threads encoding
  18 threads started
  diff from serial encoding:
  -----------------------------
  19 threads encoding
  19 threads started
  diff from serial encoding:
  -----------------------------
  20 threads encoding
  20 threads started
  diff from serial encoding:
  -----------------------------
  21 threads encoding
  21 threads started
  diff from serial encoding:
  -----------------------------
  22 threads encoding
  22 threads started
  diff from serial encoding:
  -----------------------------
  23 threads encoding
  23 threads started
  diff from serial encoding:
  -----------------------------
  24 threads encoding
  24 threads started
  diff from serial encoding:
  -----------------------------
  25 threads encoding
  25 threads started
  diff from serial encoding:
  -----------------------------
  26 threads encoding
  26 threads started
  diff from serial encoding:
  -----------------------------
  27 threads encoding
  27 threads started
  diff from serial encoding:
  -----------------------------
  28 threads encoding
  28 threads started
  diff from serial encoding:
  -----------------------------
  Ok

  real	1m14.800s
  user	3m4.315s
  sys	0m8.977s
  $

Tested-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/all/ZhQBpAGIDU_koQnp@x1/T/#u
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c |  8 ++++++--
 pahole.c  | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index fbc8d8aa0060b7d0..1ec259f50dbd3778 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -489,8 +489,12 @@ struct cu *cus__get_next_processable_cu(struct cus *cus)
 			cu->state = CU__PROCESSING;
 			goto found;
 		case CU__PROCESSING:
-			// This will only happen when we get to parallel
-			// reproducible BTF encoding, libbpf dedup work needed here.
+			// This will happen when we get to parallel
+			// reproducible BTF encoding, libbpf dedup work needed
+			// here. The other possibility is when we're flushing
+			// the DWARF processed CUs when the parallel DWARF
+			// loading stoped and we still have CUs to encode to
+			// BTF because of ordering requirements.
 			continue;
 		case CU__UNPROCESSED:
 			// The first entry isn't loaded, signal the
diff --git a/pahole.c b/pahole.c
index fcb4360f11debeb9..77772bb42bb443ce 100644
--- a/pahole.c
+++ b/pahole.c
@@ -31,6 +31,7 @@
 
 static struct btf_encoder *btf_encoder;
 static char *detached_btf_filename;
+struct cus *cus;
 static bool btf_encode;
 static bool ctf_encode;
 static bool sort_output;
@@ -3324,11 +3325,32 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			encoder = btf_encoder;
 		}
 
+		// Since we don't have yet a way to parallelize the BTF encoding, we
+		// need to ask the loader for the next CU that we can process, one
+		// that is loaded and is in order, if the next one isn't yet loaded,
+		// then return to let the DWARF loader thread to load the next one,
+		// eventually all will get processed, even if when all DWARF loading
+		// threads finish.
+		if (conf_load->reproducible_build) {
+			ret = LSK__KEEPIT; // we're not processing the cu passed to this
+					  // function, so keep it.
+			cu = cus__get_next_processable_cu(cus);
+			if (cu == NULL)
+				goto out_btf;
+		}
+
 		ret = btf_encoder__encode_cu(encoder, cu, conf_load);
 		if (ret < 0) {
 			fprintf(stderr, "Encountered error while encoding BTF.\n");
 			exit(1);
 		}
+
+		if (conf_load->reproducible_build) {
+			ret = LSK__KEEPIT; // we're not processing the cu passed to this function, so keep it.
+			// Kinda equivalent to LSK__DELETE since we processed this, but we can't delete it
+			// as we stash references to entries in CUs for 'struct function' in btf_encoder__add_saved_funcs()
+			// and btf_encoder__save_func(), so we can't delete them here. - Alan Maguire
+		}
 out_btf:
 		if (!thr_data) // See comment about reproducibe_build above
 			pthread_mutex_unlock(&btf_lock);
@@ -3632,6 +3654,24 @@ out_free:
 	return ret;
 }
 
+static int cus__flush_reproducible_build(struct cus *cus, struct btf_encoder *encoder, struct conf_load *conf_load)
+{
+	int err = 0;
+
+	while (true) {
+		struct cu *cu = cus__get_next_processable_cu(cus);
+
+		if (cu == NULL)
+			break;
+
+		err = btf_encoder__encode_cu(encoder, cu, conf_load);
+		if (err < 0)
+			break;
+	}
+
+	return err;
+}
+
 int main(int argc, char *argv[])
 {
 	int err, remaining, rc = EXIT_FAILURE;
@@ -3692,7 +3732,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	struct cus *cus = cus__new();
+	cus = cus__new();
 	if (cus == NULL) {
 		fputs("pahole: insufficient memory\n", stderr);
 		goto out_dwarves_exit;
@@ -3797,6 +3837,12 @@ try_sole_arg_as_class_names:
 	header = NULL;
 
 	if (btf_encode && btf_encoder) { // maybe all CUs were filtered out and thus we don't have an encoder?
+		if (conf_load.reproducible_build &&
+		    cus__flush_reproducible_build(cus, btf_encoder, &conf_load) < 0) {
+			fprintf(stderr, "Encountered error while encoding BTF.\n");
+			exit(1);
+		}
+
 		err = btf_encoder__encode(btf_encoder);
 		if (err) {
 			fputs("Failed to encode BTF\n", stderr);
-- 
2.44.0


