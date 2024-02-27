Return-Path: <bpf+bounces-22764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0598868963
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 07:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050C7B238EE
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517953818;
	Tue, 27 Feb 2024 06:55:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575C535B8;
	Tue, 27 Feb 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016927; cv=none; b=MqKCgz5e//c6YPm4cQLpzaqLENDZMo1qA2SwQI08Ovv3BLk+QDKgYrDgHRaTaAyEgcXiYy+Xfbos+Yl0MHnzT/BSRGXGlqoGGSY4vOZwodboBw8Wo/FCxUUTYJ9qefPyRZCTG+/jgaA9W2/4+97B9KmuuRECf2RWTHaZ8EvNQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016927; c=relaxed/simple;
	bh=gG5CMlrl+GPx0nv6WJg9sxLLdFwObEWxvNr02omKWMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5DIgEowaxs4adIsfbMHWCr8AfUjoA/EA5Uio5Zq7DBFnExTETHIUDeCuqb+SpMS6oC1CIsATurRUbuNmtiAWVMexXGxRDPeO4NTpQyn1pnqliOZKLoaxJ7l7OxgfkQD8yDcm0TD3eZ28d3Jm5QNjF6PFqVYZyml5IpneENS+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so3152679a12.0;
        Mon, 26 Feb 2024 22:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016925; x=1709621725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfYPVo8PlMx484tYtZ4NtC24FP1qjCc+CfFFfGRz5dA=;
        b=sJyHj4pduRQlovNl15Ut8pBZ6CD6IwLFXQ51sLG+Z0rwgl4c3nV99L9tJGPGnX9xxR
         6s+fJ98ZI8OFRrUHcf1639V2WJh03Sr5IyvfPRSgiqFxsUFpiNYdhzI0mdUxcW9tM+X2
         4BL/FM4D+yOfp2Zc3LS7XjWY/cxMlnw7ssYBE3u/4mMkmmzBbWadaoFom/slK0cSwnqA
         HTs2wCMHU0QX1pANmI/pBLd3YrQslJp/OcSYIJWu2torFbMDe9ummBK8n24oAAI5Pu9e
         WS9uHtJZl8V29wPqkS8D+QNrWn3opD9HmbmTEwOxly4YXzNjICJ+svBJzNYn+Olj6mfL
         cuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBrOl+RDIUzFOImjmzGwy5jUz2vTJg6kHCl49PtcFkdxKaGqY86WSfJNBR4Y5TdKa7mNLlRMIUar+CLH3xN0VXnSDFc8dkmL20LrZFqMiI6UWb30AccStIst1l62PK8cSQPDOhRAp+IYK5xsLrRNsrtdIV6LWAt8+0PpAyAFOoRcJEAw==
X-Gm-Message-State: AOJu0YxE0lceurDCPOpyfg19nhY1ldL1kyiH+Ca7GtRgENyDR3jXS+4n
	juXb2f6laS+YMZoIIcxInRiaSvQ8lRoJQanGIMtxPp7G8SNA1gFeKU/MoyhuOLCZQFturhyv2TN
	G5c4XAN/HXI4ZiQ97t4oLOp6Zh5w=
X-Google-Smtp-Source: AGHT+IE1/w/Ox4YK0hHwTMKs7yZKvHP3jxpt9iUkaVJEYi+86QMxyUzPWlTgWS6MSN6CSMs56va8/J/sZSfBwQ0nWQ8=
X-Received: by 2002:a17:90b:2243:b0:29a:d8ff:1b98 with SMTP id
 hk3-20020a17090b224300b0029ad8ff1b98mr2584869pjb.48.1709016925178; Mon, 26
 Feb 2024 22:55:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-3-irogers@google.com>
In-Reply-To: <20240214063708.972376-3-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 26 Feb 2024 22:55:13 -0800
Message-ID: <CAM9d7ch3xpuOwZkr5eiOCZj3b_az2=nErOahbsMajZtkQmK9tw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] perf trace: Ignore thread hashing in summary
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Commit 91e467bc568f ("perf machine: Use hashtable for machine
> threads") made the iteration of thread tids unordered. The perf trace
> --summary output sorts and prints each hash bucket, rather than all
> threads globally. Change this behavior by turn all threads into a
> list, sort the list by number of trace events then by tids, finally
> print the list. This also allows the rbtree in threads to be not
> accessed outside of machine.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c  | 41 +++++++++++++++++++++----------------
>  tools/perf/util/rb_resort.h |  5 -----
>  2 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 109b8e64fe69..90eaff8c0f6e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -74,6 +74,7 @@
>  #include <linux/err.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
> +#include <linux/list_sort.h>
>  #include <linux/random.h>
>  #include <linux/stringify.h>
>  #include <linux/time64.h>
> @@ -4312,34 +4313,38 @@ static unsigned long thread__nr_events(struct thr=
ead_trace *ttrace)
>         return ttrace ? ttrace->nr_events : 0;
>  }
>
> -DEFINE_RESORT_RB(threads,
> -               (thread__nr_events(thread__priv(a->thread)) <
> -                thread__nr_events(thread__priv(b->thread))),
> -       struct thread *thread;
> -)
> +static int trace_nr_events_cmp(void *priv __maybe_unused,
> +                              const struct list_head *la,
> +                              const struct list_head *lb)
>  {
> -       entry->thread =3D rb_entry(nd, struct thread_rb_node, rb_node)->t=
hread;
> +       struct thread_list *a =3D list_entry(la, struct thread_list, list=
);
> +       struct thread_list *b =3D list_entry(lb, struct thread_list, list=
);
> +       unsigned long a_nr_events =3D thread__nr_events(thread__priv(a->t=
hread));
> +       unsigned long b_nr_events =3D thread__nr_events(thread__priv(b->t=
hread));
> +
> +       if (a_nr_events !=3D b_nr_events)
> +               return a_nr_events < b_nr_events ? -1 : 1;
> +
> +       /* Identical number of threads, place smaller tids first. */
> +       return thread__tid(a->thread) < thread__tid(b->thread)
> +               ? -1
> +               : (thread__tid(a->thread) > thread__tid(b->thread) ? 1 : =
0);

I'm not sure if it can have a case where two different threads in the
hash table can have the same tid.  If not, it can simplify the last case.


>  }
>
>  static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *f=
p)
>  {
>         size_t printed =3D trace__fprintf_threads_header(fp);
> -       struct rb_node *nd;
> -       int i;
> -
> -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> -               DECLARE_RESORT_RB_MACHINE_THREADS(threads, trace->host, i=
);
> +       LIST_HEAD(threads);
>
> -               if (threads =3D=3D NULL) {
> -                       fprintf(fp, "%s", "Error sorting output by nr_eve=
nts!\n");
> -                       return 0;
> -               }
> +       if (machine__thread_list(trace->host, &threads) =3D=3D 0) {
> +               struct thread_list *pos;
>
> -               resort_rb__for_each_entry(nd, threads)
> -                       printed +=3D trace__fprintf_thread(fp, threads_en=
try->thread, trace);
> +               list_sort(NULL, &threads, trace_nr_events_cmp);

Same concern, it'd be nice if we can use an array instead.

Thanks,
Namhyung


>
> -               resort_rb__delete(threads);
> +               list_for_each_entry(pos, &threads, list)
> +                       printed +=3D trace__fprintf_thread(fp, pos->threa=
d, trace);
>         }
> +       thread_list__delete(&threads);
>         return printed;
>  }
>
> diff --git a/tools/perf/util/rb_resort.h b/tools/perf/util/rb_resort.h
> index 376e86cb4c3c..d927a0d25052 100644
> --- a/tools/perf/util/rb_resort.h
> +++ b/tools/perf/util/rb_resort.h
> @@ -143,9 +143,4 @@ struct __name##_sorted *__name =3D __name##_sorted__n=
ew
>         DECLARE_RESORT_RB(__name)(&__ilist->rblist.entries.rb_root,      =
       \
>                                   __ilist->rblist.nr_entries)
>
> -/* For 'struct machine->threads' */
> -#define DECLARE_RESORT_RB_MACHINE_THREADS(__name, __machine, hash_bucket=
)    \
> - DECLARE_RESORT_RB(__name)(&__machine->threads[hash_bucket].entries.rb_r=
oot, \
> -                          __machine->threads[hash_bucket].nr)
> -
>  #endif /* _PERF_RESORT_RB_H_ */
> --
> 2.43.0.687.g38aa6559b0-goog
>

