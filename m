Return-Path: <bpf+bounces-27400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DA38ACC2C
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED31B247A9
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE936147C81;
	Mon, 22 Apr 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgEvNY8/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500C146A67;
	Mon, 22 Apr 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785979; cv=none; b=rS0nsBz0X1MHccL53It/MOsRekoCFVC+KTsHoAgQzRFZWahAFOFLTCjygagUhrmDOvcU2vCGmeBIyI8fowWzps39LxDgJNLmDtlUcCmkldyCd9JLd+vH/20grSSPcH0nY/j6+/H/G92ASpUTIed4/nepwQQTv/8LiLdlI3oH8NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785979; c=relaxed/simple;
	bh=ulsfSAEl7LBwePnfRAal8I6cQlsR0G+iMdbsnGnkwM8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/ajusAnHHX1NXqQyJ57Sf1MuYb0oSyrWJ1eSeOLus9fMC47iLF8W9RtuwJ2yQYLfsKLRSpYV5Rr+iP5ZOZ/pJpObCRtpYKcZCE9TmrCKDXHzsrZBGdNRpNMtAhFLyjvJTzrRZD+naySNvgVvLPR9zZKeJNXniS4YwPkQtt8AI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgEvNY8/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34b1e35155aso702983f8f.3;
        Mon, 22 Apr 2024 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713785976; x=1714390776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aJ9yQshLsZ6lvoWpjUZb+c8ATqrhPEYy3PtHw/SC4co=;
        b=CgEvNY8//ZyAveamdUFJ90Nus3p2L+j2AdeFGfHuCtDvbsgT4pKOUGFqadYmTL3TXQ
         jEXb/mUu2NSVU48k9SUd/CEvGlZ+UJtRfedFICsqsY9ZgJsmq65A47qreebe6u16PFJa
         dMPOtCiw48ZfubIzupe3ulr+wWazryE+Q9zw2ZxRUe4kgOpEm5wBvQEersC3SQjZ90bo
         KidDt9uRKOujqSL+gvVJXhnUKirrljqgUgqQ5rvu3zeLCkg8jFJyDHbjS1mhTwwrntnE
         koz7yO0CoIo7GmJM7C7JXy2r+gQfU8dY2s9sfk20tbihmse4JdN6PQcc7DZSMTRsAcB9
         qSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713785976; x=1714390776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ9yQshLsZ6lvoWpjUZb+c8ATqrhPEYy3PtHw/SC4co=;
        b=DjQVPYfPKiBlxDkKWQTkfyhv3V1r/+cm2r5IrQSKihd+UQ/gQDYBS38+Q/lMC0Lg/M
         kJmvbWhpnLIqzKFDrk+sfb7tUxM1EuWOCbccU8bJcaTXpFBS4iQXLlMZgtbSNewIrcPh
         yP74qyr/Fu1N06ajR132k0unI50Wb2t4YJPerz+6rHdUdLhEtn7xZKCOVa/a5OQ02UiL
         UuUcnjfIWcSQjpsoYQP8hfPUPt3gBhl1+QYhpyVtXafF9rYDrxmCWkisxdqB/VG5zFqa
         94SOI5PnPzKrhG7rHZgf0KTjhJiU3IFWdEsLBhcncJoQq35gQJPGfortE6NsV7WIJUdm
         oKlg==
X-Forwarded-Encrypted: i=1; AJvYcCXK2vscBsDTI24S58gA3Tu9UsPB1RZqZwSGNx3vTkJZDElPuYg+tnD+sRtRtlXVV1D5eSStmzlq+RrJto7Iy10Ac2F0ECHJm6E3Beuepi5gqPeR5MCIYPAxJ6vS58k2Ao0Jv7Fr5F/w5iVwaVKZNZyXVOo1sOfjC58UHaSTHE0xU4fw1Q==
X-Gm-Message-State: AOJu0Yw1cUqyHpJLzLRufe+GZQR0c0E/KkHyGVfhAwuTSXeb+uH6yii0
	h51U0M/hv2JpIDzPT4ZOTodvk1/3QOplOLKtfqaWVINihSbEub7B
X-Google-Smtp-Source: AGHT+IETX/3Lo779iTOd02lH4mu0GSF9AVTJKi6GM6wHxnVUA3usTw72yxk2ggywg7ebJStbnepGCg==
X-Received: by 2002:a5d:4ec1:0:b0:34a:e798:29fc with SMTP id s1-20020a5d4ec1000000b0034ae79829fcmr3474651wrv.52.1713785975586;
        Mon, 22 Apr 2024 04:39:35 -0700 (PDT)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d5481000000b003437a76565asm11759544wrv.25.2024.04.22.04.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 04:39:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Apr 2024 13:39:32 +0200
To: Jonathan Haslam <jonathan.haslam@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uprobes: reduce contention on uprobes_tree access
Message-ID: <ZiZMdLIK55q3EvMP@krava>
References: <20240422102306.6026-1-jonathan.haslam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422102306.6026-1-jonathan.haslam@gmail.com>

On Mon, Apr 22, 2024 at 03:23:05AM -0700, Jonathan Haslam wrote:
> Active uprobes are stored in an RB tree and accesses to this tree are
> dominated by read operations. Currently these accesses are serialized by
> a spinlock but this leads to enormous contention when large numbers of
> threads are executing active probes.
> 
> This patch converts the spinlock used to serialize access to the
> uprobes_tree RB tree into a reader-writer spinlock. This lock type
> aligns naturally with the overwhelmingly read-only nature of the tree
> usage here. Although the addition of reader-writer spinlocks are
> discouraged [0], this fix is proposed as an interim solution while an
> RCU based approach is implemented (that work is in a nascent form). This
> fix also has the benefit of being trivial, self contained and therefore
> simple to backport.
> 
> We have used a uprobe benchmark from the BPF selftests [1] to estimate
> the improvements. Each block of results below show 1 line per execution
> of the benchmark ("the "Summary" line) and each line is a run with one
> more thread added - a thread is a "producer". The lines are edited to
> remove extraneous output.
> 
> The tests were executed with this driver script:
> 
> for num_threads in {1..20}
> do
>   sudo ./bench -a -p $num_threads trig-uprobe-nop | grep Summary
> done
> 
> SPINLOCK (BEFORE)
> ==================
> Summary: hits    1.396 ± 0.007M/s (  1.396M/prod)
> Summary: hits    1.656 ± 0.016M/s (  0.828M/prod)
> Summary: hits    2.246 ± 0.008M/s (  0.749M/prod)
> Summary: hits    2.114 ± 0.010M/s (  0.529M/prod)
> Summary: hits    2.013 ± 0.009M/s (  0.403M/prod)
> Summary: hits    1.753 ± 0.008M/s (  0.292M/prod)
> Summary: hits    1.847 ± 0.001M/s (  0.264M/prod)
> Summary: hits    1.889 ± 0.001M/s (  0.236M/prod)
> Summary: hits    1.833 ± 0.006M/s (  0.204M/prod)
> Summary: hits    1.900 ± 0.003M/s (  0.190M/prod)
> Summary: hits    1.918 ± 0.006M/s (  0.174M/prod)
> Summary: hits    1.925 ± 0.002M/s (  0.160M/prod)
> Summary: hits    1.837 ± 0.001M/s (  0.141M/prod)
> Summary: hits    1.898 ± 0.001M/s (  0.136M/prod)
> Summary: hits    1.799 ± 0.016M/s (  0.120M/prod)
> Summary: hits    1.850 ± 0.005M/s (  0.109M/prod)
> Summary: hits    1.816 ± 0.002M/s (  0.101M/prod)
> Summary: hits    1.787 ± 0.001M/s (  0.094M/prod)
> Summary: hits    1.764 ± 0.002M/s (  0.088M/prod)
> 
> RW SPINLOCK (AFTER)
> ===================
> Summary: hits    1.444 ± 0.020M/s (  1.444M/prod)
> Summary: hits    2.279 ± 0.011M/s (  1.139M/prod)
> Summary: hits    3.422 ± 0.014M/s (  1.141M/prod)
> Summary: hits    3.565 ± 0.017M/s (  0.891M/prod)
> Summary: hits    2.671 ± 0.013M/s (  0.534M/prod)
> Summary: hits    2.409 ± 0.005M/s (  0.401M/prod)
> Summary: hits    2.485 ± 0.008M/s (  0.355M/prod)
> Summary: hits    2.496 ± 0.003M/s (  0.312M/prod)
> Summary: hits    2.585 ± 0.002M/s (  0.287M/prod)
> Summary: hits    2.908 ± 0.011M/s (  0.291M/prod)
> Summary: hits    2.346 ± 0.016M/s (  0.213M/prod)
> Summary: hits    2.804 ± 0.004M/s (  0.234M/prod)
> Summary: hits    2.556 ± 0.001M/s (  0.197M/prod)
> Summary: hits    2.754 ± 0.004M/s (  0.197M/prod)
> Summary: hits    2.482 ± 0.002M/s (  0.165M/prod)
> Summary: hits    2.412 ± 0.005M/s (  0.151M/prod)
> Summary: hits    2.710 ± 0.003M/s (  0.159M/prod)
> Summary: hits    2.826 ± 0.005M/s (  0.157M/prod)
> Summary: hits    2.718 ± 0.001M/s (  0.143M/prod)
> Summary: hits    2.844 ± 0.006M/s (  0.142M/prod)

nice, I'm assuming Masami will take this one.. in any case:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> The numbers in parenthesis give averaged throughput per thread which is
> of greatest interest here as a measure of scalability. Improvements are
> in the order of 22 - 68% with this particular benchmark (mean = 43%).
> 
> V2:
>  - Updated commit message to include benchmark results.
> 
> [0] https://docs.kernel.org/locking/spinlocks.html
> [1] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/benchs/bench_trigger.c
> 
> Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> ---
>  kernel/events/uprobes.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index e4834d23e1d1..8ae0eefc3a34 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
>   */
>  #define no_uprobe_events()	RB_EMPTY_ROOT(&uprobes_tree)
>  
> -static DEFINE_SPINLOCK(uprobes_treelock);	/* serialize rbtree access */
> +static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
>  
>  #define UPROBES_HASH_SZ	13
>  /* serialize uprobe->pending_list */
> @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
>  {
>  	struct uprobe *uprobe;
>  
> -	spin_lock(&uprobes_treelock);
> +	read_lock(&uprobes_treelock);
>  	uprobe = __find_uprobe(inode, offset);
> -	spin_unlock(&uprobes_treelock);
> +	read_unlock(&uprobes_treelock);
>  
>  	return uprobe;
>  }
> @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>  {
>  	struct uprobe *u;
>  
> -	spin_lock(&uprobes_treelock);
> +	write_lock(&uprobes_treelock);
>  	u = __insert_uprobe(uprobe);
> -	spin_unlock(&uprobes_treelock);
> +	write_unlock(&uprobes_treelock);
>  
>  	return u;
>  }
> @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
>  	if (WARN_ON(!uprobe_is_active(uprobe)))
>  		return;
>  
> -	spin_lock(&uprobes_treelock);
> +	write_lock(&uprobes_treelock);
>  	rb_erase(&uprobe->rb_node, &uprobes_tree);
> -	spin_unlock(&uprobes_treelock);
> +	write_unlock(&uprobes_treelock);
>  	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
>  	put_uprobe(uprobe);
>  }
> @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
>  	min = vaddr_to_offset(vma, start);
>  	max = min + (end - start) - 1;
>  
> -	spin_lock(&uprobes_treelock);
> +	read_lock(&uprobes_treelock);
>  	n = find_node_in_range(inode, min, max);
>  	if (n) {
>  		for (t = n; t; t = rb_prev(t)) {
> @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
>  			get_uprobe(u);
>  		}
>  	}
> -	spin_unlock(&uprobes_treelock);
> +	read_unlock(&uprobes_treelock);
>  }
>  
>  /* @vma contains reference counter, not the probed instruction. */
> @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
>  	min = vaddr_to_offset(vma, start);
>  	max = min + (end - start) - 1;
>  
> -	spin_lock(&uprobes_treelock);
> +	read_lock(&uprobes_treelock);
>  	n = find_node_in_range(inode, min, max);
> -	spin_unlock(&uprobes_treelock);
> +	read_unlock(&uprobes_treelock);
>  
>  	return !!n;
>  }
> -- 
> 2.43.0
> 

