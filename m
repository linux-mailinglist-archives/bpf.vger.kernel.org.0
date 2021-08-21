Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B353F379B
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 02:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhHUAVm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 20:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbhHUAV1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 20:21:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A4C061575;
        Fri, 20 Aug 2021 17:20:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q2so10788041pgt.6;
        Fri, 20 Aug 2021 17:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9kNRxalE+9qBUPi6/bQbtaGARFkuA2XMgWtQLAuiWs=;
        b=OVpvjRNNUIvAdVHmbf0GrGcb+2KgA97q9jCFDh2aCUJ0IKHrzJpRUAQZiHQgoYt9AL
         FsmXVZ6suLcHMAoSxeyhtja1MrzuA00w5EmWqXXgWvUKb7VYfuqVNBd625B1HTvzpQsu
         Kq0LJLne+g/qQQlV4Fs/J1tCK5NZFCKzT75SAHUuOapmlmcznmCUiA5r31otoX2YSV5e
         Hrf91RwhWTonyYC13bmpF7J6MW4dfCh9KBtysUkPO7LCzliK2o+5uh/Z1sPbM6djzK4u
         7ZVD0cny8EvHJBf51noL5YIKk0yMw7iT3s7W+tDL4rJLNSCdDa2rkL/FEFkAPA2wF9K2
         eFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9kNRxalE+9qBUPi6/bQbtaGARFkuA2XMgWtQLAuiWs=;
        b=cUMCIlS4ogDagFv1FdhNvXgwqEU9HNz+KAaz41k5ajpQnmbkAaZSQi+RRtA7WJaWx2
         D0TmH1Ela5MNnDmmir5du0Etmt/V47+SKLqhbALDgKJM4T3WeGfiEdhZaatLXEC5d43b
         wAk0fS0/T/N8VMNfJ14fi8q7IJUOQFy882aJVqRwbyLv1IEmy7jyKRTZckjJi2j/JAZH
         kRzAtNcqfOztIiMnbhVGE9hxnX/t2l1tlTxJqjetrFoAzKUv3SSr/MVXuwSYbibrEf/9
         2nMTspjky323YiXYOIJ8eGtEOZ0YHh/QyGLkPReoEiGBTpBB6zU+2wG8unKDNkbOl3FX
         LQvQ==
X-Gm-Message-State: AOAM533Dk0M+JL9lsjiNK0L0qy/jIn+9k4n9dflOzfbzZVwgoyoAWM1K
        Nx9fHy0M8UwrkEJPI6r6yg6AB9qOBko=
X-Google-Smtp-Source: ABdhPJxcCVXPDwoVtVFiMx1aCAXyLgVgFZOyGmI+8C+NEOc9gKYugoZr8ctjEjRCIh++DPFBQNlKaw==
X-Received: by 2002:a63:744c:: with SMTP id e12mr11506342pgn.177.1629505247148;
        Fri, 20 Aug 2021 17:20:47 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id b23sm318025pji.49.2021.08.20.17.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 17:20:46 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 11/22] samples: bpf: Add devmap_xmit tracepoint statistics support
Date:   Sat, 21 Aug 2021 05:49:59 +0530
Message-Id: <20210821002010.845777-12-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210821002010.845777-1-memxor@gmail.com>
References: <20210821002010.845777-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds support for retrieval and printing for devmap_xmit total and
mutli mode tracepoint. For multi mode, we keep a hash map entry for each
redirection stream, such that we can dynamically add and remove entries
on output.

The from_match and to_match will be set by individual samples when
setting up the XDP program on these devices.

The multi mode tracepoint is also handy for xdp_redirect_map_multi,
where up to 32 devices can be specified.

Also add samples_init_pre_load macro to finally set up the resized maps
and mmap them in place for low overhead stats retrieval.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 samples/bpf/xdp_sample_user.c | 317 +++++++++++++++++++++++++++++++++-
 samples/bpf/xdp_sample_user.h |  17 ++
 2 files changed, 331 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/xdp_sample_user.c b/samples/bpf/xdp_sample_user.c
index e2692dee1dbb..eb484c15492d 100644
--- a/samples/bpf/xdp_sample_user.c
+++ b/samples/bpf/xdp_sample_user.c
@@ -77,6 +77,8 @@ enum map_type {
 	MAP_CPUMAP_ENQUEUE,
 	MAP_CPUMAP_KTHREAD,
 	MAP_EXCEPTION,
+	MAP_DEVMAP_XMIT,
+	MAP_DEVMAP_XMIT_MULTI,
 	NUM_MAP,
 };
 
@@ -103,6 +105,8 @@ struct stats_record {
 	struct record redir_err[XDP_REDIRECT_ERR_MAX];
 	struct record kthread;
 	struct record exception[XDP_ACTION_MAX];
+	struct record devmap_xmit;
+	DECLARE_HASHTABLE(xmit_map, 5);
 	struct record enq[];
 };
 
@@ -111,7 +115,9 @@ struct sample_output {
 		__u64 rx;
 		__u64 redir;
 		__u64 drop;
+		__u64 drop_xmit;
 		__u64 err;
+		__u64 xmit;
 	} totals;
 	struct {
 		__u64 pps;
@@ -125,6 +131,12 @@ struct sample_output {
 	struct {
 		__u64 hits;
 	} except_cnt;
+	struct {
+		__u64 pps;
+		__u64 drop;
+		__u64 err;
+		double bavg;
+	} xmit_cnt;
 };
 
 struct xdp_desc {
@@ -265,6 +277,16 @@ static void sample_print_help(int mask)
 		       "  \t\t\t\thit/s     - Number of times the tracepoint was hit per second\n\n");
 	}
 
+	if (mask & SAMPLE_DEVMAP_XMIT_CNT) {
+		printf("  devmap_xmit\t\tDisplays devmap_xmit tracepoint events\n"
+		       "  \t\t\tThis tracepoint is invoked for successful transmissions on output\n"
+		       "  \t\t\tdevice but these statistics are not available for generic XDP mode,\n"
+		       "  \t\t\thence they will be omitted from the output when using SKB mode\n"
+		       "  \t\t\t\txmit/s    - Number of packets that were transmitted per second\n"
+		       "  \t\t\t\tdrop/s    - Number of packets that failed transmissions per second\n"
+		       "  \t\t\t\tdrv_err/s - Number of internal driver errors per second\n"
+		       "  \t\t\t\tbulk-avg  - Average number of packets processed for each event\n\n");
+	}
 }
 
 void sample_usage(char *argv[], const struct option *long_options,
@@ -353,6 +375,74 @@ static void map_collect_percpu(struct datarec *values, struct record *rec)
 	rec->total.xdp_redirect = sum_xdp_redirect;
 }
 
+static int map_collect_percpu_devmap(int map_fd, struct stats_record *rec)
+{
+	unsigned int nr_cpus = bpf_num_possible_cpus();
+	__u32 batch, count = 32;
+	struct datarec *values;
+	bool init = false;
+	__u64 *keys;
+	int i, ret;
+
+	keys = calloc(count, sizeof(__u64));
+	if (!keys)
+		return -ENOMEM;
+	values = calloc(count * nr_cpus, sizeof(struct datarec));
+	if (!values) {
+		free(keys);
+		return -ENOMEM;
+	}
+
+	for (;;) {
+		bool exit = false;
+
+		ret = bpf_map_lookup_batch(map_fd, init ? &batch : NULL, &batch,
+					   keys, values, &count, NULL);
+		if (ret < 0 && errno != ENOENT)
+			break;
+		if (errno == ENOENT)
+			exit = true;
+
+		init = true;
+		for (i = 0; i < count; i++) {
+			struct map_entry *e, *x = NULL;
+			__u64 pair = keys[i];
+			struct datarec *arr;
+
+			arr = &values[i * nr_cpus];
+			hash_for_each_possible(rec->xmit_map, e, node, pair) {
+				if (e->pair == pair) {
+					x = e;
+					break;
+				}
+			}
+			if (!x) {
+				x = calloc(1, sizeof(*x));
+				if (!x)
+					goto cleanup;
+				if (map_entry_init(x, pair) < 0) {
+					free(x);
+					goto cleanup;
+				}
+				hash_add(rec->xmit_map, &x->node, pair);
+			}
+			map_collect_percpu(arr, &x->val);
+		}
+
+		if (exit)
+			break;
+		count = 32;
+	}
+
+	free(values);
+	free(keys);
+	return 0;
+cleanup:
+	free(values);
+	free(keys);
+	return -ENOMEM;
+}
+
 static struct stats_record *alloc_stats_record(void)
 {
 	struct stats_record *rec;
@@ -408,6 +498,16 @@ static struct stats_record *alloc_stats_record(void)
 			}
 		}
 	}
+	if (sample_mask & SAMPLE_DEVMAP_XMIT_CNT) {
+		rec->devmap_xmit.cpu = alloc_record_per_cpu();
+		if (!rec->devmap_xmit.cpu) {
+			fprintf(stderr,
+				"Failed to allocate devmap_xmit per-CPU array\n");
+			goto end_exception;
+		}
+	}
+	if (sample_mask & SAMPLE_DEVMAP_XMIT_CNT_MULTI)
+		hash_init(rec->xmit_map);
 	if (sample_mask & SAMPLE_CPUMAP_ENQUEUE_CNT) {
 		for (i = 0; i < sample_n_cpus; i++) {
 			rec->enq[i].cpu = alloc_record_per_cpu();
@@ -418,13 +518,15 @@ static struct stats_record *alloc_stats_record(void)
 					i);
 				while (i--)
 					free(rec->enq[i].cpu);
-				goto end_exception;
+				goto end_devmap_xmit;
 			}
 		}
 	}
 
 	return rec;
 
+end_devmap_xmit:
+	free(rec->devmap_xmit.cpu);
 end_exception:
 	for (i = 0; i < XDP_ACTION_MAX; i++)
 		free(rec->exception[i].cpu);
@@ -448,6 +550,12 @@ static void free_stats_record(struct stats_record *r)
 
 	for (i = 0; i < sample_n_cpus; i++)
 		free(r->enq[i].cpu);
+	hash_for_each_safe(r->xmit_map, i, tmp, e, node) {
+		hash_del(&e->node);
+		free(e->val.cpu);
+		free(e);
+	}
+	free(r->devmap_xmit.cpu);
 	for (i = 0; i < XDP_ACTION_MAX; i++)
 		free(r->exception[i].cpu);
 	free(r->kthread.cpu);
@@ -835,6 +943,160 @@ static void stats_get_exception_cnt(struct stats_record *stats_rec,
 	}
 }
 
+static void stats_get_devmap_xmit(struct stats_record *stats_rec,
+				  struct stats_record *stats_prev,
+				  unsigned int nr_cpus,
+				  struct sample_output *out)
+{
+	double pps, drop, info, err;
+	struct record *rec, *prev;
+	double t;
+	int i;
+
+	rec = &stats_rec->devmap_xmit;
+	prev = &stats_prev->devmap_xmit;
+	t = calc_period(rec, prev);
+	for (i = 0; i < nr_cpus; i++) {
+		struct datarec *r = &rec->cpu[i];
+		struct datarec *p = &prev->cpu[i];
+		char str[64];
+
+		pps = calc_pps(r, p, t);
+		drop = calc_drop_pps(r, p, t);
+		err = calc_errs_pps(r, p, t);
+
+		if (!pps && !drop && !err)
+			continue;
+
+		snprintf(str, sizeof(str), "cpu:%d", i);
+		info = calc_info_pps(r, p, t);
+		if (info > 0)
+			info = (pps + drop) / info; /* calc avg bulk */
+		print_default("     %-18s" FMT_COLUMNf FMT_COLUMNf FMT_COLUMNf
+				      __COLUMN(".2f") "\n",
+			      str, XMIT(pps), DROP(drop), err, "drv_err/s",
+			      info, "bulk-avg");
+	}
+	if (out) {
+		pps = calc_pps(&rec->total, &prev->total, t);
+		drop = calc_drop_pps(&rec->total, &prev->total, t);
+		info = calc_info_pps(&rec->total, &prev->total, t);
+		if (info > 0)
+			info = (pps + drop) / info; /* calc avg bulk */
+		err = calc_errs_pps(&rec->total, &prev->total, t);
+
+		out->xmit_cnt.pps = pps;
+		out->xmit_cnt.drop = drop;
+		out->xmit_cnt.bavg = info;
+		out->xmit_cnt.err = err;
+		out->totals.xmit += pps;
+		out->totals.drop_xmit += drop;
+		out->totals.err += err;
+	}
+}
+
+static void stats_get_devmap_xmit_multi(struct stats_record *stats_rec,
+					struct stats_record *stats_prev,
+					unsigned int nr_cpus,
+					struct sample_output *out,
+					bool xmit_total)
+{
+	double pps, drop, info, err;
+	struct map_entry *entry;
+	struct record *r, *p;
+	double t;
+	int bkt;
+
+	hash_for_each(stats_rec->xmit_map, bkt, entry, node) {
+		struct map_entry *e, *x = NULL;
+		char ifname_from[IFNAMSIZ];
+		char ifname_to[IFNAMSIZ];
+		const char *fstr, *tstr;
+		unsigned long prev_time;
+		struct record beg = {};
+		__u32 from_idx, to_idx;
+		char str[128];
+		__u64 pair;
+		int i;
+
+		prev_time = sample_interval * NANOSEC_PER_SEC;
+
+		pair = entry->pair;
+		from_idx = pair >> 32;
+		to_idx = pair & 0xFFFFFFFF;
+
+		r = &entry->val;
+		beg.timestamp = r->timestamp - prev_time;
+
+		/* Find matching entry from stats_prev map */
+		hash_for_each_possible(stats_prev->xmit_map, e, node, pair) {
+			if (e->pair == pair) {
+				x = e;
+				break;
+			}
+		}
+		if (x)
+			p = &x->val;
+		else
+			p = &beg;
+		t = calc_period(r, p);
+		pps = calc_pps(&r->total, &p->total, t);
+		drop = calc_drop_pps(&r->total, &p->total, t);
+		info = calc_info_pps(&r->total, &p->total, t);
+		if (info > 0)
+			info = (pps + drop) / info; /* calc avg bulk */
+		err = calc_errs_pps(&r->total, &p->total, t);
+
+		if (out) {
+			/* We are responsible for filling out totals */
+			out->totals.xmit += pps;
+			out->totals.drop_xmit += drop;
+			out->totals.err += err;
+			continue;
+		}
+
+		fstr = tstr = NULL;
+		if (if_indextoname(from_idx, ifname_from))
+			fstr = ifname_from;
+		if (if_indextoname(to_idx, ifname_to))
+			tstr = ifname_to;
+
+		snprintf(str, sizeof(str), "xmit %s->%s", fstr ?: "?",
+			 tstr ?: "?");
+		/* Skip idle streams of redirection */
+		if (pps || drop || err) {
+			print_err(drop,
+				  "  %-20s " FMT_COLUMNf FMT_COLUMNf FMT_COLUMNf
+				  __COLUMN(".2f") "\n", str, XMIT(pps), DROP(drop),
+				  err, "drv_err/s", info, "bulk-avg");
+		}
+
+		for (i = 0; i < nr_cpus; i++) {
+			struct datarec *rc = &r->cpu[i];
+			struct datarec *pc, p_beg = {};
+			char str[64];
+
+			pc = p == &beg ? &p_beg : &p->cpu[i];
+
+			pps = calc_pps(rc, pc, t);
+			drop = calc_drop_pps(rc, pc, t);
+			err = calc_errs_pps(rc, pc, t);
+
+			if (!pps && !drop && !err)
+				continue;
+
+			snprintf(str, sizeof(str), "cpu:%d", i);
+			info = calc_info_pps(rc, pc, t);
+			if (info > 0)
+				info = (pps + drop) / info; /* calc avg bulk */
+
+			print_default("     %-18s" FMT_COLUMNf FMT_COLUMNf FMT_COLUMNf
+				      __COLUMN(".2f") "\n", str, XMIT(pps),
+				      DROP(drop), err, "drv_err/s", info, "bulk-avg");
+		}
+	}
+}
+
 static void stats_print(const char *prefix, int mask, struct stats_record *r,
 			struct stats_record *p, struct sample_output *out)
 {
@@ -849,6 +1111,9 @@ static void stats_print(const char *prefix, int mask, struct stats_record *r,
 	printf(FMT_COLUMNl,
 	       out->totals.err + out->totals.drop + out->totals.drop_xmit,
 	       "err,drop/s");
+	if (mask & SAMPLE_DEVMAP_XMIT_CNT ||
+	    mask & SAMPLE_DEVMAP_XMIT_CNT_MULTI)
+		printf(FMT_COLUMNl, XMIT(out->totals.xmit));
 	printf("\n");
 
 	if (mask & SAMPLE_RX_CNT) {
@@ -899,6 +1164,25 @@ static void stats_print(const char *prefix, int mask, struct stats_record *r,
 		stats_get_exception_cnt(r, p, nr_cpus, NULL);
 	}
 
+	if (mask & SAMPLE_DEVMAP_XMIT_CNT) {
+		str = (sample_log_level & LL_DEFAULT) && out->xmit_cnt.pps ?
+				    "devmap_xmit total" :
+				    "devmap_xmit";
+
+		print_err(out->xmit_cnt.err || out->xmit_cnt.drop,
+			  "  %-20s " FMT_COLUMNl FMT_COLUMNl FMT_COLUMNl
+				  __COLUMN(".2f") "\n",
+			  str, XMIT(out->xmit_cnt.pps),
+			  DROP(out->xmit_cnt.drop), out->xmit_cnt.err,
+			  "drv_err/s", out->xmit_cnt.bavg, "bulk-avg");
+
+		stats_get_devmap_xmit(r, p, nr_cpus, NULL);
+	}
+
+	if (mask & SAMPLE_DEVMAP_XMIT_CNT_MULTI)
+		stats_get_devmap_xmit_multi(r, p, nr_cpus, NULL,
+					    mask & SAMPLE_DEVMAP_XMIT_CNT);
+
 	if (sample_log_level & LL_DEFAULT ||
 	    ((sample_log_level & LL_SIMPLE) && sample_err_exp)) {
 		sample_err_exp = false;
@@ -910,12 +1194,13 @@ int sample_setup_maps(struct bpf_map **maps)
 {
 	sample_n_cpus = libbpf_num_possible_cpus();
 
-	for (int i = 0; i < NUM_MAP; i++) {
+	for (int i = 0; i < MAP_DEVMAP_XMIT_MULTI; i++) {
 		sample_map[i] = maps[i];
 
 		switch (i) {
 		case MAP_RX:
 		case MAP_CPUMAP_KTHREAD:
+		case MAP_DEVMAP_XMIT:
 			sample_map_count[i] = sample_n_cpus;
 			break;
 		case MAP_REDIRECT_ERR:
@@ -933,12 +1218,13 @@ int sample_setup_maps(struct bpf_map **maps)
 		if (bpf_map__resize(sample_map[i], sample_map_count[i]) < 0)
 			return -errno;
 	}
+	sample_map[MAP_DEVMAP_XMIT_MULTI] = maps[MAP_DEVMAP_XMIT_MULTI];
 	return 0;
 }
 
 static int sample_setup_maps_mappings(void)
 {
-	for (int i = 0; i < NUM_MAP; i++) {
+	for (int i = 0; i < MAP_DEVMAP_XMIT_MULTI; i++) {
 		size_t size = sample_map_count[i] * sizeof(struct datarec);
 
 		sample_mmap[i] = mmap(NULL, size, PROT_READ | PROT_WRITE,
@@ -1057,9 +1343,20 @@ static void sample_summary_print(void)
 	if (sample_out.totals.drop)
 		print_always("  Rx dropped          : %'-10llu\n",
 			     sample_out.totals.drop);
+	if (sample_out.totals.drop_xmit)
+		print_always("  Tx dropped          : %'-10llu\n",
+			     sample_out.totals.drop_xmit);
 	if (sample_out.totals.err)
 		print_always("  Errors recorded     : %'-10llu\n",
 			     sample_out.totals.err);
+	if (sample_out.totals.xmit) {
+		double pkts = sample_out.totals.xmit;
+
+		print_always("  Packets transmitted : %'-10llu\n",
+			     sample_out.totals.xmit);
+		print_always("  Average transmit/s  : %'-10.0f\n",
+			     sample_round(pkts / period));
+	}
 }
 
 void sample_exit(int status)
@@ -1115,6 +1412,13 @@ static int sample_stats_collect(struct stats_record *rec)
 			map_collect_percpu(&sample_mmap[MAP_EXCEPTION][i * sample_n_cpus],
 					   &rec->exception[i]);
 
+	if (sample_mask & SAMPLE_DEVMAP_XMIT_CNT)
+		map_collect_percpu(sample_mmap[MAP_DEVMAP_XMIT], &rec->devmap_xmit);
+
+	if (sample_mask & SAMPLE_DEVMAP_XMIT_CNT_MULTI) {
+		if (map_collect_percpu_devmap(bpf_map__fd(sample_map[MAP_DEVMAP_XMIT_MULTI]), rec) < 0)
+			return -EINVAL;
+	}
 	return 0;
 }
 
@@ -1123,7 +1427,9 @@ static void sample_summary_update(struct sample_output *out, int interval)
 	sample_out.totals.rx += out->totals.rx;
 	sample_out.totals.redir += out->totals.redir;
 	sample_out.totals.drop += out->totals.drop;
+	sample_out.totals.drop_xmit += out->totals.drop_xmit;
 	sample_out.totals.err += out->totals.err;
+	sample_out.totals.xmit += out->totals.xmit;
 	sample_out.rx_cnt.pps += interval;
 }
 
@@ -1141,6 +1447,11 @@ static void sample_stats_print(int mask, struct stats_record *cur,
 		stats_get_redirect_err_cnt(cur, prev, 0, &out);
 	if (mask & SAMPLE_EXCEPTION_CNT)
 		stats_get_exception_cnt(cur, prev, 0, &out);
+	if (mask & SAMPLE_DEVMAP_XMIT_CNT)
+		stats_get_devmap_xmit(cur, prev, 0, &out);
+	else if (mask & SAMPLE_DEVMAP_XMIT_CNT_MULTI)
+		stats_get_devmap_xmit_multi(cur, prev, 0, &out,
+					    mask & SAMPLE_DEVMAP_XMIT_CNT);
 	sample_summary_update(&out, interval);
 
 	stats_print(prog_name, mask, cur, prev, &out);
diff --git a/samples/bpf/xdp_sample_user.h b/samples/bpf/xdp_sample_user.h
index 203732615fee..3a678986cce2 100644
--- a/samples/bpf/xdp_sample_user.h
+++ b/samples/bpf/xdp_sample_user.h
@@ -14,9 +14,11 @@ enum stats_mask {
 	SAMPLE_CPUMAP_ENQUEUE_CNT   = 1U << 3,
 	SAMPLE_CPUMAP_KTHREAD_CNT   = 1U << 4,
 	SAMPLE_EXCEPTION_CNT        = 1U << 5,
+	SAMPLE_DEVMAP_XMIT_CNT      = 1U << 6,
 	SAMPLE_REDIRECT_CNT         = 1U << 7,
 	SAMPLE_REDIRECT_MAP_CNT     = SAMPLE_REDIRECT_CNT | _SAMPLE_REDIRECT_MAP,
 	SAMPLE_REDIRECT_ERR_MAP_CNT = SAMPLE_REDIRECT_ERR_CNT | _SAMPLE_REDIRECT_MAP,
+	SAMPLE_DEVMAP_XMIT_CNT_MULTI = 1U << 8,
 };
 
 /* Exit return codes */
@@ -63,6 +65,17 @@ static inline char *safe_strncpy(char *dst, const char *src, size_t size)
 			return -errno;                                         \
 	})
 
+#define sample_init_pre_load(skel)                                             \
+	({                                                                     \
+		skel->rodata->nr_cpus = libbpf_num_possible_cpus();            \
+		sample_setup_maps((struct bpf_map *[]){                        \
+			skel->maps.rx_cnt, skel->maps.redir_err_cnt,           \
+			skel->maps.cpumap_enqueue_cnt,                         \
+			skel->maps.cpumap_kthread_cnt,                         \
+			skel->maps.exception_cnt, skel->maps.devmap_xmit_cnt,  \
+			skel->maps.devmap_xmit_cnt_multi });                   \
+	})
+
 #define DEFINE_SAMPLE_INIT(name)                                               \
 	static int sample_init(struct name *skel, int mask)                    \
 	{                                                                      \
@@ -84,6 +97,10 @@ static inline char *safe_strncpy(char *dst, const char *src, size_t size)
 			__attach_tp(tp_xdp_cpumap_kthread);                    \
 		if (mask & SAMPLE_EXCEPTION_CNT)                               \
 			__attach_tp(tp_xdp_exception);                         \
+		if (mask & SAMPLE_DEVMAP_XMIT_CNT)                             \
+			__attach_tp(tp_xdp_devmap_xmit);                       \
+		if (mask & SAMPLE_DEVMAP_XMIT_CNT_MULTI)                       \
+			__attach_tp(tp_xdp_devmap_xmit_multi);                 \
 		return 0;                                                      \
 	}
 
-- 
2.33.0

